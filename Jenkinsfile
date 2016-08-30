node {
  def project = 'sela-india-project'
  def appName = 'gcpdemo-app'
  def imageTag = "us.gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

  checkout scm

  stage 'Build image'
  sh("docker build -t ${imageTag} .")

  stage 'Push image to registry'
  sh("gcloud docker push ${imageTag}")

  stage "Deploy Application"
  // Change deployed image in staging to the one we just built
  sh("sed -i.bak 's#us.gcr.io/sela-india-project/gcpdemo-app:1.0.0#${imageTag}#' ./k8s/*.yaml")
  sh("kubectl apply -f k8s/ --cluster="gke_${project}_us-central1-a_${appName}")
}