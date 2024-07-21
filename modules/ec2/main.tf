resource "aws_security_group" "allow_ssh_http" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  security_groups = [aws_security_group.allow_ssh_http.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo docker run -d -p 80:80 --name nginx nginx
              echo "<!DOCTYPE html>
              <html lang='en'>
              <head>
                  <meta charset='UTF-8'>
                  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                  <title>Magic Card Trick</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          text-align: center;
                          background-color: #f8f9fa;
                          color: #343a40;
                      }
                      h1 {
                          margin-top: 50px;
                      }
                      .card-container {
                          display: flex;
                          justify-content: center;
                          flex-wrap: wrap;
                          margin: 20px;
                      }
                      .card {
                          width: 100px;
                          height: 150px;
                          margin: 10px;
                          border: 2px solid #343a40;
                          border-radius: 10px;
                          display: flex;
                          justify-content: center;
                          align-items: center;
                          cursor: pointer;
                          transition: transform 0.2s;
                      }
                      .card:hover {
                          transform: scale(1.1);
                      }
                      .hidden-card {
                          display: none;
                      }
                  </style>
              </head>
              <body>
                  <h1>Pick a Card</h1>
                  <p>Click on a card to reveal the magic card!</p>
                  <div class='card-container'>
                      <div class='card' onclick='revealCard(this)'>A♠</div>
                      <div class='card' onclick='revealCard(this)'>K♣</div>
                      <div class='card' onclick='revealCard(this)'>Q♦</div>
                      <div class='card' onclick='revealCard(this)'>J♥</div>
                      <div class='card hidden-card' id='magic-card'>J♥</div>
                  </div>

                  <script>
                      function revealCard(selectedCard) {
                          const cards = document.querySelectorAll('.card');
                          cards.forEach(card => card.style.display = 'none');
                          const magicCard = document.getElementById('magic-card');
                          magicCard.style.display = 'flex';
                      }
                  </script>
              </body>
              </html>" > /home/ec2-user/index.html
              EOF
}
