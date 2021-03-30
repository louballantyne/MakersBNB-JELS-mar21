https://playground.diagram.codes/d/sequence

alias user="User"
alias browser="Browser"
alias controller="Controller"
alias view="View"
alias model="Model"

user->browser: "visit /"
browser->controller: "get /"
controller->model: "variables?"
model->controller: "return variables"
controller->view: "index.erb"
view->browser: "index.erb"
browser->browser: "renders html"
browser->user: "displays page"
