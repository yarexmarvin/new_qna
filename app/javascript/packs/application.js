// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery")
require("@nathanvda/cocoon")
import Rails from "@rails/ujs";
import $ from 'jquery';
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import '../answers/edit'
import '../answers/create'
import '../questions/edit'
import '../votes/vote'
import createConsumer from "../channels/consumer";


const GistClient = require("gist-client")

const gistClient = new GistClient()

global.$ = jQuery;
Rails.start();
Turbolinks.start();
ActiveStorage.start();
window.gistClient = gistClient;

