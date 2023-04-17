terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  token     = "y0_AgAAAABpoqkNAATuwQAAAADguMAxUUlk2_smQ0WyMzSL-OCUj23SI0U"
  cloud_id  = "1g7irb2c3n8jf1q4u3s"
  folder_id = "b1glv4cjjk5obhte4pc3"
  zone = "ru-central1-a"
}