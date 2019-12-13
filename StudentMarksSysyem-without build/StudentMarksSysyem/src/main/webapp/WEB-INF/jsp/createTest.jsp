<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="css/common.css">
  <script type="text/javascript" src="jquery.js"></script>
</head>
<body>
<script type="text/javascript">
var sectionData={};
function shareData(){
	giveNames();
  var sectionDataAsString = JSON.stringify(sectionData);
  document.getElementById("sectionDataField").value=sectionDataAsString;
}
function ShowHideDevBtns(chkBtn) {
  var btnList = document.getElementsByClassName("toDisable");
  var btnPreviewDisable = document.getElementById("submitAnswersDisable");
  var checked = chkBtn.checked?"none":"block";
  var unchecked = chkBtn.checked?"block":"none";
  var uncheckedDisable = chkBtn.checked?true:false;
  for(var i=0;i<btnList.length;i++){
      btnList[i].style.display=checked;
  }
  btnPreviewDisable.style.display=unchecked;
  btnPreviewDisable.disabled=uncheckedDisable;

}

function reAssignValue(listElement){
  /*function to reassign values to the options when any option is deleted for a question*/
  var opt_list=listElement.children;
  for(var j=1;j<opt_list.length-2;j++){
    var sub_list=opt_list[j].children;/*because the options have severel elements*/
        sub_list[1].value=j;
  }
  
}

function removeOption(option){
  /*function toreassign value to options when a ption is deleted*/
  var question=option.parentElement;
  option.remove();
  reAssignValue(question);
}

function add_option(name, value) {
  /*creating a label to append radiobutton and textfield*/
  var label = document.createElement("label");
  /*creating a radio button and textfield for new option*/
  var radio =document.createElement("input");
  radio.type = "radio";
  radio.name = name;
  radio.value = value;
  var opt=document.createElement("textarea");
  opt.style="width:70%";
  opt.className="options";
  /*opt.setAttribute("style","width:auto;");*/
  /*creating delete option button  */
  var deleteOption = document.createElement("input");
  deleteOption.onclick=function(){removeOption(this.parentElement)};
  deleteOption.type="button";
  deleteOption.value="x";
  deleteOption.innerHTML="x";
  deleteOption.className="toDisable";
  deleteOption.setAttribute("style","float:right;");
  /*creating a br element for displaying diffrent options in diffrent lines*/
  var br = document.createElement("br");
  /*appending radio ,input and delete button to label*/
  label.appendChild(radio);
  label.appendChild(opt);
  label.appendChild(deleteOption);
  label.insertBefore(br,radio);
  /*returning label element*/
  return label;
}
function giveNames(){
	var question=document.getElementsByClassName("questions_ta");
	for (i = 0; i < question.length; i++) {
		question[i].name=question[i].nextSibling.firstElementChild.nextElementSibling.name.slice(0, 3) + 'u' + question[i].nextSibling.firstElementChild.nextElementSibling.name.slice(3,question[i].nextSibling.firstElementChild.nextElementSibling.name.length);
	}
	var options=document.getElementsByClassName("options");
	for (i = 0; i < options.length; i++) {
		options[i].name=options[i].parentElement.firstElementChild.nextElementSibling.name.slice(0, 3) + 'o' +options[i].parentElement.firstElementChild.nextElementSibling.name.slice(3,options[i].parentElement.firstElementChild.nextElementSibling.name.length)+options[i].parentElement.firstElementChild.nextElementSibling.value;
	}
}

function extra_option(question,groupName){
  /*calculate number of options that already exist,which is the new index*/
  var new_index=question.childNodes.length;
  new_index=new_index-2;/*-3+1*/
  /*create a option with the new index*/
  var opt=add_option(groupName,new_index);
  /*insert the created uption before the add option button*/
  question.insertBefore(opt,question.lastChild.previousSibling);
}

function set_active(tabName) {
  /*getting a list of all the tabs*/
  var tabContent = document.getElementsByClassName("tabcontent");
  /*setting display to none for all tabs, so its not visible*/
  for (var i = 0; i < tabContent.length; i++) {
    tabContent[i].style.display = "none";
  }
  /*setting display of active tab to block, so its visible*/
  document.getElementById(tabName).style.display = "block";
}

function changeSectionName(toChangeSectionName){
  /*getting section name as input(prompt) from user*/
  newSectionName=prompt("Enter new section name");
  if(newSectionName){

    var toChange=document.getElementsByName(toChangeSectionName)[0];
    
    /*changing tab name and value*/
    toChange.name=newSectionName;
    toChange.innerHTML=newSectionName;
    /*Changing content id for the changed tab name*/
    var divToChange=document.getElementById(toChangeSectionName);
    /*checking if the section has questions and reassigning radiobutton names*/
    if(divToChange!=undefined){
    var eleToChange=document.getElementById(toChangeSectionName).children[0].children[0];
    updateNames(newSectionName,eleToChange);
    }
    /*changing id of div of the section */
    divToChange.id=newSectionName;

    /*changing the section name in section data*/ 
    temp=sectionData[toChangeSectionName];
    delete sectionData[toChangeSectionName];
    sectionData[newSectionName]=temp;

  }
} 

function addTab(){
  /*console.log(document);*/
  /*Inputting section name from user*/
  sectionName=prompt("Enter section name");
  if(sectionName){
    /*creating a tab(button) with the given name*/
    var tab_btn = document.createElement("input");
    tab_btn.type="button";
    tab_btn.innerHTML = sectionName;
    tab_btn.value = sectionName;
    tab_btn.className="tablinks";
    tab_btn.name=sectionName;
    tab_btn.onclick=function(){set_active(this.name)};
    tab_btn.ondblclick = function(){changeSectionName(this.name)};
    /*adding the tab to the like navigation bar*/
    document.getElementById("topNavigation").appendChild(tab_btn);

    /*adding click event to tab,to switch tabs */
    tab_btn.addEventListener("click", function() {
    var current = document.getElementsByClassName("active");
    if (current.length > 0) { current[0].className = current[0].className.replace(" active", "");}
    this.className += " active";
    });
    /*Creating a section with the given name*/
    var div = document.createElement('div');
    var par = document.createElement('p');
    div.id=sectionName;
    par.innerHTML = document.getElementById("template").innerHTML;
    div.append(par);
    div.className="tabcontent";  
    document.getElementsByClassName("content")[0].appendChild(div);

    /*To set the added tab as active*/
    tab_btn.click();
    /*send no of tab to php */
    sectionData[sectionName]=0;
    
  }
}

function createQuestion(sectionId){

  var ques_list=document.getElementById(sectionId).firstElementChild.firstElementChild;
  
  /*to give index to the question*/
  if(!ques_list.firstElementChild){
    ques_count=1;
  }
  else{
    ques_count=ques_list.childNodes.length;
  }
  var radioGroupName=sectionId+"_q_"+ques_count;
  /*creating a li element for the list*/
  var listElement=document.createElement("li");
  /*creating a textarea for entering the question*/
  var ques=document.createElement("textarea");
  ques.className="questions_ta";
  ques.setAttribute("rows",4);
  ques.setAttribute("style","width:100%;border:none;");
  /*creating a delete Question button incase we need to*/
  var deleteButton=document.createElement("input");
  deleteButton.type="button";
  deleteButton.value="Delete";
  deleteButton.setAttribute("style","float: right;");
  deleteButton.onclick=function(){deleteQuestion(this.parentElement)};
  deleteButton.innerHTML="Delete";
  deleteButton.className="toDisable";
  /*creating a button to add more options for the questions */
  var addOption=document.createElement("input");
  addOption.onclick=function(){extra_option(this.parentElement.parentElement,this.parentElement.parentElement.children[2].children[1].name)};
  addOption.type="button";
  addOption.id="add_btn";
  addOption.innerHTML="Add Option";
  addOption.value="Add Option";
  addOption.className="toDisable";
  var btn_wth_space=document.createElement("label");
  var br = document.createElement("br");
  btn_wth_space.appendChild(br);
  btn_wth_space.appendChild(addOption);
  /*creating 4 options*/
  var rb1=add_option(radioGroupName, "1");
  var rb2=add_option(radioGroupName, "2");
  var rb3=add_option(radioGroupName, "3");
  var rb4=add_option(radioGroupName, "4");
  /*appending all the necessary elements of question to a li element*/
  listElement.appendChild(ques);
  listElement.appendChild(rb1);
  listElement.appendChild(rb2);
  listElement.appendChild(rb3);
  listElement.appendChild(rb4);
  listElement.appendChild(btn_wth_space);
  listElement.appendChild(deleteButton);
  /*appending the li element to the list of questions*/
  ques_list.appendChild(listElement);

  sectionData[sectionId]+=1;
}

function deleteQuestion(question){
  /*storing the id of li element and id of tabconent to pass to updateNames function */
  var currentName=question.parentElement.parentElement.parentElement.id;
  var parentName=question.parentElement;
  /*removing the question*/
  question.remove();
  /*calling the updateNames function to rearrange the questions so as to have correct index order*/
  updateNames(currentName,parentName);

  sectionData[currentName]-=1;
}

function updateNames(newName,list){
  if(list){
    var ques_list=list.children;
    for(var i=0;i<ques_list.length;i++){
      var opt_list=ques_list[i].children;
      console.log(opt_list);
      for(var j=2;j<opt_list.length-1;j++){
        var changedName=newName+"_q_"+(i+1).toString();
        var sub_list=opt_list[j].children;/*because the options have severel elements*/
        sub_list[1].setAttribute("name",changedName);
      }
    }
  }
}
</script>

<div style ="background-color: rgb(0, 0, 51);font-size:0px;">
  <div style="font-size: 30px;width: 100%;text-align: center;color:white"><b>Exam</b></div>
  <br>
  <div style="display:block;width:100%;background-color: rgb(0, 0, 51);visibility: visible;" >
    <div id="topNavigation" class="tab" style="width:100%; display: inline-block;background-color:rgba(204, 0, 102, 0.63);color:white">
    <!--div in which the tabs for sections are added-->
    <input type="button" class="toDisable" id="tabLinkAdd" style="float:right" onclick="addTab()" value="Add Section"/>
    <div width style="display:inline-block;font-size:18px;float:right;" id="timeRemaining"></div>    
    </div>
  </div>
</div>
<form action ="testSave" method = "POST">

	<div class="content" style="border:2px;border-block-color: black">
	  <!--div in which the questions or tabcontent are added-->
	  <div id="template" class="tabcontent" hidden>
	      <ol class="questions">  
	      </ol>
	      <input type="button" class="toDisable" onclick="createQuestion(this.parentElement.parentElement.id)"value="Add Question"></input>
	  </div>
	</div>
	<div class="todisable"><input type="checkbox" onclick="ShowHideDevBtns(this)" />Preview</div> 
	<div class="toDisable" id="testInfoInput">
	  <input type="text" id="sectionDataField" name="elements" style="display:none" />
	  <label for="testName">Test Name</label>
	  <input type="text" id="testName" name="testName" placeholder="Enter test name"/><br>
	  <label for="testSDate">Start Date </label>
	  <input type="date" id="testsdate" name="testSDate" /><br>
	  <label for="testEDate">End Date</label>
	  <input type="date" id="testedate" name="testEDate" /><br>
	  <label for="testDuration">Duration</label>
	  <input type="text" id="testDuration" name="testDuration" placeholder="duration in minutes"/><br>
	  <label for="testSem">Semester</label>
	  <input type="text" id="testSem" name="testSem" placeholder="semester"/><br>
	  <label for="testSec">Section</label>
	  <input type="text" id="testSec" name="testSec" placeholder="section"/>
	</div>
	  <input type="submit" class="toDisable" attr="subbtn" onclick="shareData()" value="CREATE" />
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
<a href='logout' class="linkbtn">Logout</a>
<a href='homepage' class="linkbtn">Homepage</a>
</body>
</html>