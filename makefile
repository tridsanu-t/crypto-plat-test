include parameter

create-action:
	kubectl create ns actions-runner-system
create-secret:
	kubectl create secret generic controller-manager -n actions-runner-system --from-literal=github_token=$(PAT)

################ Helm ################
add-helm-repo:
	helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
update-repo:
	helm repo update
install-arc:
	helm upgrade --install --namespace actions-runner-system \
  	--create-namespace --wait actions-runner-controller \
  	actions-runner-controller/actions-runner-controller \
  	--set syncPeriod=1m
uninstall-arc:
	helm uninstall actions-runner-controller -n actions-runner-system
################ Configuration ################
create-config:
	kubectl create -f ./config/runner.yaml
delete-config:
	kubectl delete -f ./config/runner.yaml
git-username:
	git config --global user.name "deftdev test"
git-email:
	git config --global user.email tridsanu.t@deftdev.tech