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
  sh("kubectl config set-cluster ${clusterName} --insecure-skip-tls-verify=true")
  sh("kubectl config set-context ${clusterName} --cluster=${clusterName}")
  sh("kubectl config use-context ${clusterName}")
  sh("kubectl config view")
  sh("kubectl rolling-update frontend --image=${imageTag} --cluster=${clusterName} --context=${clusterName}")
  //sh("sed -i.bak 's#us.gcr.io/sela-india-project/gcpdemo-app:1.0.0#${imageTag}#' ./k8s/*.yaml")
  //sh("kubectl apply -f k8s/ --cluster=${clusterName} --context=${clusterName}")

}