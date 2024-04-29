// jshint esversion: 6
/**
 * A function to wrap it all in.
 */
(function () {
    "use strict";

    const path = window.location.pathname;

    console.log(path);

    const navLink = document.querySelectorAll("header > nav > a");

    navLink.forEach((link) => console.log(link.href));

    navLink.forEach((link) => {
        if (link.href.includes(path)) {
            link.classList.add("current");
        }
    });

    console.log("All ready.");
})();
