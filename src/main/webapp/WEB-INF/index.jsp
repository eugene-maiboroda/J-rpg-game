<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>RPG</title>
    <meta id="root" about="${pageContext.request.contextPath}">
    <link href="${pageContext.request.contextPath}/resources/bootstrap-4.3.1-dist/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/bootstrap-4.3.1-dist/js/jq.js" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-4.3.1-dist/js/jq.js">
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-4.3.1-dist/js/bootstrap.js">
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts.js">
    </script>

</head>
<body onload="loadContent('${pageContext.request.contextPath}','', 1);">
<div class="container">


            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Error!</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-danger" role="alert" id="error-text">
                                This is a danger alert—check it out!
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>



    <h1 style="text-align: center; margin-top: 50px; margin-bottom: 30px">Admin panel</h1>

        <label style="float: left ; margin-right: 10px" for="order">Order by: </label>
        <select style="float: left" onchange="processSearch('${pageContext.request.contextPath}', 1)" style="margin-left: 5px" id="order"
                class="form-control-sm">
            <option selected>Id</option>
            <option>Name</option>
            <option>Experience</option>
            <option>Birthday</option>
        </select>


        <select style="float: right" onchange="processSearch('${pageContext.request.contextPath}', 1)" style="margin-left: 5px" id="limit"
                class="form-control-sm">
            <option>1</option>
            <option selected>3</option>
            <option>5</option>
            <option>10</option>
            <option>20</option>
        </select>
     <label style="float: right; margin-right: 10px" for="limit">Players in a page: </label>

<br>

    <table style="margin-top: 10px" class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Title</th>
            <th scope="col">Race</th>
            <th scope="col">Profession</th>
            <th scope="col">Experience</th>
            <th scope="col">Level</th>
            <th scope="col">Until Next Level</th>
            <th scope="col">Birthday</th>
            <th scope="col">Banned</th>
            <th scope="col"></th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody id="mainTable">
        </tbody>
    </table>
    <h5 id="count" style="float: right; margin-right: 20px"></h5>
    <div>
        <ul id="pagging-bar" class="pagination pagination-sm justify-content-center">

        </ul>
    </div>


    <button style="margin-bottom: 15px" type="button" class="btn btn-info" onclick="clickCreate()">Create new player</button>
    <form style="background-color: #E9ECEF; padding: 20px; border-radius: 10px; display: none" id="createButton">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputNameNew">Name</label>
                <input type="text" class="form-control" id="inputNameNew" placeholder="Name">
            </div>
            <div class="form-group col-md-6">
                <label for="inputTitleNew">Title</label>
                <input type="text" class="form-control" id="inputTitleNew" placeholder="Title">
            </div>
        </div>
        <div class="form-row">

            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label>Birthday</label>
                <div class="form-row">
                        <input type="date" class="form-control" id="inputBirthdayNew">
                </div>
            </div>
            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label>Experience</label>
                <div class="form-row">
                        <input type="number" min="0" step="1000" class="form-control" id="inputExperienceNew">
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label for="inputRace">Race</label>
                <select id="inputRaceNew" class="form-control">
                    <option selected>Human</option>
                    <option>Dwarf</option>
                    <option>Elf</option>
                    <option>Giant</option>
                    <option>Orc</option>
                    <option>Troll</option>
                    <option>Hobbit</option>
                </select>
            </div>
            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label for="inputProfession">Profession</label>
                <select id="inputProfessionNew" class="form-control">
                    <option selected>Warrior</option>
                    <option>Rogue</option>
                    <option>Sorcerer</option>
                    <option>Cleric</option>
                    <option>Paladin</option>
                    <option>Nazgul</option>
                    <option>Warlock</option>
                    <option>Druid</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6" style="padding: 0px 10px">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioNew1"
                           value="false" checked="checked">
                    <label class="form-check-label" for="inlineRadio2">Active</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadioNew2"
                           value="true">
                    <label class="form-check-label" for="inlineRadio3">Banned</label>
                </div>
            </div>
        </div>
        <button type="button" onclick="processCreate('${pageContext.request.contextPath}')" class="btn btn-success">
            Create
        </button>
    </form>

    <h3 style="margin-top: 50px">Filter options:</h3>
    <form style="background-color: #E9ECEF; padding: 20px; border-radius: 10px">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inputName">Name</label>
                <input type="text" class="form-control" id="inputName" placeholder="Name">
            </div>
            <div class="form-group col-md-6">
                <label for="inputTitle">Title</label>
                <input type="text" class="form-control" id="inputTitle" placeholder="Title">
            </div>
        </div>
        <div class="form-row">

            <div class="form-group col-md-6" style="padding: 0px 10px">
                <label>Birthday between</label>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input type="date" class="form-control" id="inputBirthdayAfter">
                    </div>
                    <div class="form-group col-md-6">
                        <input type="date" class="form-control" id="inputBirthdayBefore">
                    </div>
                </div>
            </div>
            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label>Experience between</label>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input type="number" min="0" step="1000" class="form-control" id="inputExperienceMin">
                    </div>
                    <div class="form-group col-md-6">
                        <input type="number" min="0" step="1000" class="form-control" id="inputExperienceMax">
                    </div>
                </div>
            </div>
            <div class="form-group col-md-3" style="padding: 0px 10px">
                <label>Level between</label>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <input type="number" min="0" class="form-control" id="inputLevelMin">
                    </div>
                    <div class="form-group col-md-6">
                        <input type="number" min="0" class="form-control" id="inputLevelMax">
                    </div>
                </div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-3">
                <label for="inputRace">Race</label>
                <select id="inputRace" class="form-control">
                    <option selected>Any</option>
                    <option>Human</option>
                    <option>Dwarf</option>
                    <option>Elf</option>
                    <option>Giant</option>
                    <option>Orc</option>
                    <option>Troll</option>
                    <option>Hobbit</option>
                </select>
            </div>
            <div class="form-group col-md-3">
                <label for="inputProfession">Profession</label>
                <select id="inputProfession" class="form-control">
                    <option selected>Any</option>
                    <option>Warrior</option>
                    <option>Rogue</option>
                    <option>Sorcerer</option>
                    <option>Cleric</option>
                    <option>Paladin</option>
                    <option>Nazgul</option>
                    <option>Warlock</option>
                    <option>Druid</option>
                </select>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-6" style="padding: 0px 10px">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1"
                           value="null" checked="checked">
                    <label class="form-check-label" for="inlineRadio1">Any</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2"
                           value="false">
                    <label class="form-check-label" for="inlineRadio2">Active</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3"
                           value="true">
                    <label class="form-check-label" for="inlineRadio3">Banned</label>
                </div>
            </div>
        </div>
        <button type="button" onclick="processSearch('${pageContext.request.contextPath}',1)" class="btn btn-primary">
            Accept
        </button>
    </form>


</div>
</body>
</html>