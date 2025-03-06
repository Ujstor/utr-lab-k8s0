all: update-repos k8s0

k8s0: build_system_k8s0 build_apps_k8s0

update-repos:
	@echo "Updating Helm repositories..."
	@helm repo update

# Paths
CHART_DIR_SYSTEM_K8S0 := gitops/helm/system
CHART_DIR_APPS_K8S0 := gitops/helm/apps

# k8s0-ops cluster packages
CHART_SYSTEM_K8S0 := cert-manager cilium ingress-nginx argocd cluster-issuer external-secrets metallb-operator metallb-config kyverno
CHART_APPS_K8S0 := harbor

# Define pattern rules for k8s0
build_system_k8s0: $(addprefix k8s0-system-,$(CHART_SYSTEM_k8s0))
build_apps_k8s0: $(addprefix k8s0-apps-,$(CHART_APPS_k8s0))

k8s0-system-%:
	@echo "Packaging $* chart for k8s0 system..."
	@helm dependency build --skip-refresh $(CHART_DIR_SYSTEM_K8S0)/$* || helm dependency update --skip-refresh $(CHART_DIR_SYSTEM_K8S0)/$*

k8s0-apps-%:
	@echo "Packaging $* chart for k8s0 apps..."
	@helm dependency build --skip-refresh $(CHART_DIR_APPS_K8S0)/$* || helm dependency update --skip-refresh $(CHART_DIR_APPS_K8S0)/$*


.PHONY: all k8s0 build_system_k8s0 build_apps_k8s0
