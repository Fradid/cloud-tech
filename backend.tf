terraform {
	backend "s3" {
		bucket = "tf-state-lab3-klochko-bohdan-04"
		key = "env/dev/var-04.tfstate"
		region = "eu-central-1"
		encrypt = true
		use_lockfile = true
	}
}