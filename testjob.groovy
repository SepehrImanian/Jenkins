job('seed_job') {
  scm {
    git {
      remote {
        url('https://github.com/SepehrImanian/Jenkins.git')
      }
      branch('main')
    }
  }
  steps {
    dsl {
      external('external_job.groovy')
    }
  }
}
