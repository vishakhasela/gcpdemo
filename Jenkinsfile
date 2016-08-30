node {
  def project = 'sela-india-project'
  def appName = 'gcpdemo-app'
  def imageTag = "us.gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
  def clusterName="gke_${project}_us-central1-a_${appName}"

  checkout scm
  
  sh("apt-get update")
  sh("apt-get install -y software-properties-common")
  
  sh("apt-get --yes --force-yes install ant")
  stage 'Build gcpdemo app'
  sh("ant all")
  
  stage 'Build image'
  sh("docker build -t ${imageTag} .")

  stage 'Push image to registry'
  sh("gcloud docker push ${imageTag}")

  stage "Deploy Application"
  // Change deployed image in staging to the one we just built
  sh("gcloud container clusters get-credentials gcpdemo-app --zone us-central1-a")
  sh("kubectl rolling-update frontend --image=${imageTag} --cluster=${clusterName}")

}