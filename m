Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA9750B04
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGLO3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLO3G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 10:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA481BE3;
        Wed, 12 Jul 2023 07:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D050261821;
        Wed, 12 Jul 2023 14:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECC2C433C7;
        Wed, 12 Jul 2023 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689172141;
        bh=UIptaRiyaUbynGEQXD+WmGu3lG3e/9aGCDV4f+3TJh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxuqvTQlrhh+DPsoL4fbCLE1xjcDOhd8C67rK7WyAI00C4PXEp49XwMZ96a/YpJUL
         2k/nwytR0A0vw89zv58lahN2CbfL4JccngihS0m+TWH0hGB8QM8CQNxmUTczFfHnHB
         45tZS+ClSl/NBXdpKxsbdU8tbDQX4TTsXCcPQVFnnpoTxRZyrW3UX3ev0GibA9odHx
         m6vCxS15T8lHY6bEYvvkLRS5SN5yeckqENHOlpgZGAl2DO5o2SwP/dDgXzIsP0NOFd
         1/kQ66/SMLFFoqwhI64Q7SeYFDau2nPDsivvX7BDpB9VkB3b23ky0bycIQ2ipgQLNa
         YQ+gtTtIZY2OQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1qJapt-003ben-1d;
        Wed, 12 Jul 2023 16:28:57 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Brendan Higgins" <brendanhiggins@google.com>,
        "David Gow" <davidgow@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Nikolai Kondrashov" <spbnick@gmail.com>,
        "Rae Moar" <rmoar@google.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mauro.chehab@intel.com
Subject: [PATCH RFC 1/2] docs: add support for documenting kUnit and kSelftests
Date:   Wed, 12 Jul 2023 16:28:54 +0200
Message-Id: <db42a78399569634fc8bf26d61825e0e730c2f40.1689171160.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689171160.git.mchehab@kernel.org>
References: <cover.1689171160.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an extension at Sphinx to allow documenting tests. Such extension
uses a class developed for me to document GPU tests as part of the
IGT test suite: https://gitlab.freedesktop.org/drm/igt-gpu-tools

The idea is to keep the test_list.py in sync on both trees, while
adding any kernel-specific logic inside test_kdoc.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC 0/2] at: https://lore.kernel.org/all/cover.1689171160.git.mchehab@kernel.org/

 Documentation/conf.py             |    2 +-
 Documentation/sphinx/test_kdoc.py |  108 +++
 Documentation/sphinx/test_list.py | 1288 +++++++++++++++++++++++++++++
 3 files changed, 1397 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sphinx/test_kdoc.py
 create mode 100644 Documentation/sphinx/test_list.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d4fdf6a3875a..cec017a6cab5 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -55,7 +55,7 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat', 'test_kdoc']
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/sphinx/test_kdoc.py b/Documentation/sphinx/test_kdoc.py
new file mode 100644
index 000000000000..41357438c5fd
--- /dev/null
+++ b/Documentation/sphinx/test_kdoc.py
@@ -0,0 +1,108 @@
+# coding=utf-8
+# SPDX-License-Identifier: GPL-2.0
+#
+u"""
+    "include-test
+    ~~~~~~~~~~~~~
+
+    Implementation of the ``include-test`` reST-directive.
+
+    :copyright: Copyright (C) 2023  Intel Corporation
+    :author: Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab@kernel.org>
+    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
+
+    The ``include-test`` (:py:class:`ParseTests`) directive calls produces
+    a documentation from KUnit/Kselftests based on the fields described
+    at the config variable below:
+
+        - Feature:
+            Name of the feature to be tested
+
+        - Mega feature:
+            Group of features that are under test
+
+        - Scope:
+            Test scope. Usually, the name of the subsystem where the
+            driver belongs.
+
+        - Description:
+            Description of the feature
+
+    Overview of directive's argument and options.
+
+    .. code-block:: rst
+
+        .. include-test:: <C file>
+            :debug:
+
+    The argument ``<C file>`` is required and should contain the location of
+    a KUnit or Kselftest C file with test documentation.
+
+    ``debug``
+      Inserts a code-block with the *raw* reST. Sometimes it is helpful to see
+      what reST is generated.
+
+"""
+
+from docutils import nodes
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import Directive
+from sphinx.util.docutils import switch_source_input
+
+from test_list import TestList
+
+__version__  = '1.0'
+
+# Valid fields for KUnit/Kselftest documentation
+config = {
+    "fields": {
+        "Scope": {
+            "Mega feature": {
+                "Feature": { }
+            }
+        },
+        "Description" : { }
+    }
+}
+
+def setup(app):
+    u"""Setup ``include-test`` directive"""
+
+    app.add_directive("include-test", ParseTests)
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True,
+    )
+
+class ParseTests(Directive):
+
+    u"""TestList parsing for ``include-test`` directive"""
+
+    required_arguments = 1
+    optional_arguments = 0
+    has_content = False
+    final_argument_whitespace = True
+
+    def run(self):
+        env = self.state.document.settings.env
+        doc = self.state.document
+        if not doc.settings.file_insertion_enabled:
+            raise self.warning("docutils: file insertion disabled")
+
+        tests = TestList(config_dict = config, file_list = self.arguments,
+                         test_tag = "KTEST_SUITE", subtest_tag = "KTEST_TEST",
+                         main_name = "ktest")
+
+        lines = tests.print_nested_rest(return_string = True)
+
+        content = ViewList()
+        for line_no,line in enumerate(lines.split("\n")):
+            content.append(line, env.srcdir + "/" + env.docname, line_no)
+
+        node = nodes.section()
+        with switch_source_input(self.state, content):
+            self.state.nested_parse(content, 0, node, match_titles=1)
+
+        return node.children
diff --git a/Documentation/sphinx/test_list.py b/Documentation/sphinx/test_list.py
new file mode 100644
index 000000000000..402c69e93180
--- /dev/null
+++ b/Documentation/sphinx/test_list.py
@@ -0,0 +1,1288 @@
+#!/usr/bin/env python3
+# pylint: disable=C0301,R0902,R0914,R0912,R0913,R0915,R1702,C0302
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+## Copyright (C) 2023    Intel Corporation                 ##
+## Author: Mauro Carvalho Chehab <mchehab@kernel.org>      ##
+##                                                         ##
+## Allow keeping inlined test documentation and validate   ##
+## if the documentation is kept updated.                   ##
+
+"""Maintain test plan and test implementation documentation on IGT."""
+
+import glob
+import json
+import os
+import re
+import subprocess
+import sys
+
+MIN_PYTHON = (3, 6)
+if sys.version_info < MIN_PYTHON:
+    sys.exit("Python %s.%s or later is required.\n" % MIN_PYTHON) # pylint: disable=C0209
+
+#
+# ancillary functions to sort dictionary hierarchy
+#
+def _sort_per_level(item):
+    if "level" not in item[1]["_properties_"]:
+        return item[0]
+
+    return "%05d_%05d_%s" % (item[1]["_properties_"]["level"], item[1]["_properties_"]["sublevel"], item[0])   # pylint: disable=C0209
+
+def _sort_using_array(item, array):
+    ret_str = ''
+    for field in array:
+        if field in item[1]:
+            ret_str += '_' + field + '_' + item[1][field]
+
+    if ret_str == '':
+        ret_str="________"
+
+    return ret_str
+
+#
+# Ancillary logic to allow plurals on fields
+#
+# As suggested at https://stackoverflow.com/questions/18902608/generating-the-plural-form-of-a-noun/19018986
+#
+
+def _plural(field):
+
+    """
+    Poor man's conversion to plural.
+
+    It should cover usual English plural rules, although it is not meant
+    to cover exceptions (except for a few ones that could be useful on actual
+    fields).
+
+    """
+
+    match = re.match(r"(.*)\b(\S+)", field)
+    if match:
+        ret_str = match.group(1)
+        word = match.group(2)
+
+        if word.isupper():
+            ret_str += word
+        elif word in ["of", "off", "on", "description", "todo"]:
+            ret_str += word
+        elif word.endswith('ed'):
+            ret_str += word
+        elif word[-1:] in ['s', 'x', 'z']:
+            ret_str += word + 'es'
+        elif word[-2:] in ['sh', 'ch']:
+            ret_str += word + 'es'
+        elif word.endswith('fe'):
+            ret_str += word[:-2] + 'ves'
+        elif word.endswith('f'):
+            ret_str += word[:-1] + 'ves'
+        elif word.endswith('y'):
+            ret_str += word[:-1] + 'ies'
+        elif word.endswith('o'):
+            ret_str += word + 'es'
+        elif word.endswith('us'):
+            ret_str += word[:-2] + 'i'
+        elif word.endswith('on'):
+            ret_str += word[:-2] + 'a'
+        elif word.endswith('an'):
+            ret_str += word[:-2] + 'en'
+        else:
+            ret_str += word + 's'
+
+        return ret_str
+
+    return field
+
+#
+# TestList class definition
+#
+class TestList:
+
+    """
+    Parse and handle test lists with test/subtest documentation, in the
+    form of C comments, with two meta-tags (by default, TEST and SUBTEST),
+    and a set of `field: value` items:
+
+        /**
+         * TEST: Check if new IGT test documentation logic functionality is working
+         * Category: Software build block
+         * Sub-category: documentation
+         * Functionality: test documentation
+         * Issue: none
+         * Description: Complete description of this test
+         *
+         * SUBTEST: foo
+         * Description: do foo things
+         * 	description continuing on another line
+         *
+         * SUBTEST: bar
+         * Description: do bar things
+         * 	description continuing on another line
+         */
+
+        /**
+         * SUBTEST: test-%s-binds-%s-with-%ld-size
+         * Description: Test arg[2] arg[1] binds with arg[3] size
+         *
+         * SUBTEST: test-%s-%ld-size
+         * Description: Test arg[1] with %arg[2] size
+         *
+         * arg[1]:
+         *
+         * @large:	large
+         * 		something
+         * @mixed:	mixed
+         * 		something
+         * @small:	small
+         * 		something
+         *
+         * arg[2]:	buffer size
+         * 		of some type
+         *
+         * arg[3]:
+         *
+         * @binds:			foo
+         * @misaligned-binds:		misaligned
+         * @userptr-binds:		userptr
+         * @userptr-misaligned-binds:	userptr misaligned
+         */
+
+    It is also possible to define a list of values that will actually be
+    used by the test and no string replacement is needed.
+    This is done by using one or multiple arg[n].values lines:
+
+        /**
+         * SUBTEST: unbind-all-%d-vmas
+         * Description: unbind all with %arg[1] VMAs
+         *
+         * arg[1].values: 2, 8
+         * arg[1].values: 16, 32
+         */
+
+        /**
+         * SUBTEST: unbind-all-%d-vmas
+         * Description: unbind all with %arg[1] VMAs
+         *
+         * arg[1].values: 64, 128
+         */
+
+    Such feature is specially useful for numeric parameters
+
+    The valid `field` values are defined on a JSON configuration file.
+
+    The TEST documents the common fields present on all tests. Typically,
+    each IGT C test file should contain just one such field.
+
+    The SUBTEST contains the fields that are specific to each subtest.
+
+    Note: when igt_simple_main is used, there will be a single nameless
+    subtest. On such case, "SUBTEST:" is still needed, but without a
+    test name on it, e. g., it would be documented as:
+
+        /**
+         * TEST: some test that uses igt_simple_main
+         * Category: Software build block
+         * Sub-category: documentation
+         * Functionality: test documentation
+         * Issue: none
+         * Description: Complete description of this test
+         *
+         * SUBTEST:
+         * Description: do foo things
+         */
+
+    Some IGT tests may have strings or integer wildcards, like:
+        test-%s-%ld-size
+
+    Those are declared using igt_subtest_f() and similar macros.
+
+    The wildcard arguments there need to be expanded. This is done by
+    defining arg[1] to arg[n] at the same code comment that contains the
+    SUBTEST as those variables are locally processed on each comment line.
+
+    This script needs a configuration file, in JSON format, describing the
+    fields which will be parsed for TEST and/or SUBTEST tags.
+
+    An example of such file is:
+
+    {
+        "files": [ "tests/driver/*.c" ],
+        "exclude_files": [ "tests/driver/*-helper.c" ],
+        "fields": {
+            "Category": {
+                "Sub-category": {
+                    "Functionality": {
+                    }
+                }
+            },
+            "Issue": {
+                "_properties_": {
+                    "description": "If the test is used to solve an issue, point to the URL containing the issue."
+                }
+            },
+            "Description" : {
+                "_properties_": {
+                    "description": "Provides a description for the test/subtest."
+                }
+            }
+        }
+    }
+
+    So, the above JSON config file expects tags like those:
+
+    TEST: foo
+    Description: foo
+
+    SUBTEST: bar
+    Category: Hardware
+    Sub-category: EU
+    Description: test bar on EU
+
+    SUBTEST: foobar
+    Category: Software
+    Type: ioctl
+    Description: test ioctls
+    """
+
+    def __init__(self, config_fname = None,
+                 include_plan = False, file_list = None,
+                 built_testlist = None,
+                 config_dict = None, sources_path = None,
+                 test_tag = "TEST", subtest_tag = "SUBTESTS?",
+                 main_name = "igt", subtest_separator = "@"):
+        self.doc = {}
+        self.test_number = 0
+        self.config = None
+        self.filenames = file_list
+        self.plan_filenames = []
+        self.props = {}
+        self.built_testlist = built_testlist
+        self.level_count = 0
+        self.field_list = {}
+        self.title = None
+        self.filters = {}
+        self.subtest_separator = subtest_separator
+        self.main_name = main_name
+
+        # Exclusive or: either one is needed
+        if bool(config_fname) == bool(config_dict):
+            sys.exit("Error: either config filename or config dict shall be used")
+
+        if self.main_name:
+            self.main_name += subtest_separator
+
+        implemented_class = None
+
+        if config_fname:
+            with open(config_fname, 'r', encoding='utf8') as handle:
+                self.config = json.load(handle)
+
+            config_origin = config_fname
+            cfg_path = os.path.realpath(os.path.dirname(config_fname)) + "/"
+            driver_name = re.sub(r'(.*/)?([^\/]+)/.*', r'\2', config_fname).capitalize()
+
+        else:
+            self.config = config_dict
+            config_origin = "config dict"
+            cfg_path = "./"
+            driver_name = main_name
+
+        if sources_path:
+            cfg_path = os.path.realpath(sources_path) + "/"
+
+        if not self.config:
+            sys.exit("Error: configuration is empty!")
+
+        self.__add_field(None, 0, 0, self.config["fields"])
+
+        sublevel_count = [ 0 ] * self.level_count
+
+        for field, item in self.props.items():
+            if "sublevel" in item["_properties_"]:
+                level = item["_properties_"]["level"]
+                sublevel = item["_properties_"]["sublevel"]
+                if sublevel > sublevel_count[level - 1]:
+                    sublevel_count[level - 1] = sublevel
+
+            field_lc = field.lower()
+            self.field_list[field_lc] = field
+            field_plural = _plural(field_lc)
+            if field_lc != field_plural:
+                self.field_list[field_plural] = field
+
+        if include_plan:
+            self.props["Class"] = {}
+            self.props["Class"]["_properties_"] = {}
+            self.props["Class"]["_properties_"]["level"] = 1
+            self.props["Class"]["_properties_"]["sublevel"] = sublevel_count[0] + 1
+
+        # Remove non-multilevel items, as we're only interested on
+        # hierarchical item levels here
+        for field, item in self.props.items():
+            if "sublevel" in item["_properties_"]:
+                level = item["_properties_"]["level"]
+                if sublevel_count[level - 1] == 1:
+                    del item["_properties_"]["level"]
+                    del item["_properties_"]["sublevel"]
+        if "_properties_" in self.props:
+            del self.props["_properties_"]
+
+        has_implemented = False
+        if not self.filenames:
+            self.filenames = []
+            exclude_files = []
+            files = self.config["files"]
+            exclude_file_glob = self.config.get("exclude_files", [])
+            for cfg_file in exclude_file_glob:
+                cfg_file = cfg_path + cfg_file
+                for fname in glob.glob(cfg_file):
+                    exclude_files.append(fname)
+
+            for cfg_file in files:
+                cfg_file = cfg_path + cfg_file
+                for fname in glob.glob(cfg_file):
+                    if fname in exclude_files:
+                        continue
+                    self.filenames.append(fname)
+                    has_implemented = True
+        else:
+            for cfg_file in self.filenames:
+                if cfg_file:
+                    has_implemented = True
+
+        has_planned = False
+        if include_plan and "planning_files" in self.config:
+            implemented_class = "Implemented"
+            files = self.config["planning_files"]
+            for cfg_file in files:
+                cfg_file = cfg_path + cfg_file
+                for fname in glob.glob(cfg_file):
+                    self.plan_filenames.append(fname)
+                    has_planned = True
+
+        planned_class = None
+        if has_implemented:
+            if has_planned:
+                planned_class = "Planned"
+                self.title = "Planned and implemented "
+            else:
+                self.title = "Implemented "
+        else:
+            if has_planned:
+                self.title = "Planned "
+            else:
+                sys.exit("Need file names to be processed")
+
+        self.title += self.config.get("name", "tests for " + driver_name + " driver")
+
+        # Parse files, expanding wildcards
+        field_re = re.compile(r"(" + '|'.join(self.field_list.keys()) + r'):\s*(.*)', re.I)
+
+        for fname in self.filenames:
+            if fname == '':
+                continue
+
+            self.__add_file_documentation(fname, implemented_class, field_re,
+                                          test_tag, subtest_tag, config_origin)
+
+        if include_plan:
+            for fname in self.plan_filenames:
+                self.__add_file_documentation(fname, planned_class, field_re,
+                                              test_tag, subtest_tag, config_origin)
+
+    #
+    # ancillary methods
+    #
+
+    def __add_field(self, name, sublevel, hierarchy_level, field):
+
+        """ Flatten config fields into a non-hierarchical dictionary """
+
+        for key in field:
+            if key not in self.props:
+                self.props[key] = {}
+                self.props[key]["_properties_"] = {}
+
+            if name:
+                if key == "_properties_":
+                    if key not in self.props:
+                        self.props[key] = {}
+                    self.props[name][key].update(field[key])
+
+                    sublevel += 1
+                    hierarchy_level += 1
+                    if "sublevel" in self.props[name][key]:
+                        if self.props[name][key]["sublevel"] != sublevel:
+                            sys.exit(f"Error: config defined {name} as sublevel {self.props[key]['sublevel']}, but wants to redefine as sublevel {sublevel}")
+
+                    self.props[name][key]["level"] = self.level_count
+                    self.props[name][key]["sublevel"] = sublevel
+
+                    continue
+            else:
+                self.level_count += 1
+
+            self.__add_field(key, sublevel, hierarchy_level, field[key])
+
+    def __filter_subtest(self, test, subtest, field_not_found_value):
+
+        """ Apply filter criteria to subtests """
+
+        for filter_field, regex in self.filters.items():
+            if filter_field in subtest:
+                if not regex.match(subtest[filter_field]):
+                    return True
+            elif filter_field in test:
+                if not regex.match(test[filter_field]):
+                    return True
+            else:
+                return field_not_found_value
+
+        # None of the filtering rules were applied
+        return False
+
+    def expand_subtest(self, fname, test_name, test, allow_inherit, with_lines = False, with_subtest_nr = False):
+
+        """Expand subtest wildcards providing an array with subtests"""
+
+        subtest_array = []
+
+        for subtest in self.doc[test]["subtest"].keys():
+            summary = test_name
+            if self.doc[test]["subtest"][subtest]["_summary_"] != '':
+                summary += self.subtest_separator + self.doc[test]["subtest"][subtest]["_summary_"]
+            if not summary:
+                continue
+
+            num_vars = summary.count('%')
+            file_ln = self.doc[test]["subtest_line"][subtest]
+
+            # Handle trivial case: no wildcards
+            if num_vars == 0:
+                subtest_dict = {}
+
+                subtest_dict["_summary_"] = summary
+
+                for k in sorted(self.doc[test]["subtest"][subtest].keys()):
+                    if k in [ '_summary_', 'arg', 'subtest_line' ]:
+                        continue
+
+                    if not allow_inherit:
+                        if k in self.doc[test] and self.doc[test]["subtest"][subtest][k] == self.doc[test][k]:
+                            continue
+
+                    subtest_dict[k] = self.doc[test]["subtest"][subtest][k]
+
+                if with_lines:
+                    subtest_dict["line"] = file_ln
+
+                if with_subtest_nr:
+                    subtest_dict["subtest_nr"] = subtest
+
+                subtest_array.append(subtest_dict)
+
+                continue
+
+            # Handle summaries with wildcards
+
+            # Convert subtest arguments into an array
+            arg_array = {}
+            arg_ref = self.doc[test]["subtest"][subtest]["arg"]
+
+            for arg_k in self.doc[test]["arg"][arg_ref].keys():
+                arg_array[arg_k] = []
+                if int(arg_k) > num_vars:
+                    continue
+
+                for arg_el in sorted(self.doc[test]["arg"][arg_ref][arg_k].keys()):
+                    arg_array[arg_k].append(arg_el)
+
+            size = len(arg_array)
+
+            if size < num_vars:
+                sys.exit(f"{fname}:subtest {summary} needs {num_vars} arguments but only {size} are defined.")
+
+            for j in range(0, num_vars):
+                if arg_array[j] is None:
+                    sys.exit(f"{fname}:subtest{summary} needs arg[{j}], but this is not defined.")
+
+
+            # convert numeric wildcards to string ones
+            summary = re.sub(r'%(d|ld|lld|i|u|lu|llu)','%s', summary)
+
+            # Expand subtests
+            pos = [ 0 ] * num_vars
+            args = [ 0 ] * num_vars
+            arg_map = [ 0 ] * num_vars
+            while 1:
+                for j in range(0, num_vars):
+                    arg_val = arg_array[j][pos[j]]
+                    args[j] = arg_val
+
+                    if arg_val in self.doc[test]["arg"][arg_ref][j]:
+                        arg_map[j] = self.doc[test]["arg"][arg_ref][j][arg_val]
+                        if re.match(r"\<.*\>", self.doc[test]["arg"][arg_ref][j][arg_val]):
+                            args[j] = "<" + arg_val + ">"
+                    else:
+                        arg_map[j] = arg_val
+
+                arg_summary = summary % tuple(args)
+
+                # Store the element
+                subtest_dict = {}
+                subtest_dict["_summary_"] = arg_summary
+
+                for field in sorted(self.doc[test]["subtest"][subtest].keys()):
+                    if field in [ '_summary_', 'arg', 'subtest_line' ]:
+                        continue
+
+                    sub_field = self.doc[test]["subtest"][subtest][field]
+                    sub_field = re.sub(r"%?\barg\[(\d+)\]", lambda m: arg_map[int(m.group(1)) - 1], sub_field) # pylint: disable=W0640
+
+                    if not allow_inherit:
+                        if field in self.doc[test]:
+                            if sub_field in self.doc[test][field] and sub_field == self.doc[test][field]:
+                                continue
+
+                    subtest_dict[field] = sub_field
+
+                if with_lines:
+                    subtest_dict["line"] = file_ln
+
+                if with_subtest_nr:
+                    subtest_dict["subtest_nr"] = subtest
+
+                subtest_array.append(subtest_dict)
+
+                # Increment variable inside the array
+                arr_pos = 0
+                while pos[arr_pos] + 1 >= len(arg_array[arr_pos]):
+                    pos[arr_pos] = 0
+                    arr_pos += 1
+                    if arr_pos >= num_vars:
+                        break
+
+                if arr_pos >= num_vars:
+                    break
+
+                pos[arr_pos] += 1
+
+        return subtest_array
+
+    def expand_dictionary(self, subtest_only):
+
+        """ prepares a dictionary with subtest arguments expanded """
+
+        test_dict = {}
+
+        for test in self.doc:                   # pylint: disable=C0206
+            fname = self.doc[test]["File"]
+
+            name = re.sub(r'.*/', '', fname)
+            name = re.sub(r'\.[\w+]$', '', name)
+            name = self.main_name + name
+
+            if not subtest_only:
+                test_dict[name] = {}
+
+                for field in self.doc[test]:
+                    if field == "subtest":
+                        continue
+                    if field == "arg":
+                        continue
+
+                    test_dict[name][field] = self.doc[test][field]
+                dic = test_dict[name]
+            else:
+                dic = test_dict
+
+            subtest_array = self.expand_subtest(fname, name, test, subtest_only)
+            for subtest in subtest_array:
+                if self.__filter_subtest(self.doc[test], subtest, True):
+                    continue
+
+                summary = subtest["_summary_"]
+
+                dic[summary] = {}
+                for field in sorted(subtest.keys()):
+                    if field in [ '_summary_', 'arg', 'subtest_line' ]:
+                        continue
+                    dic[summary][field] = subtest[field]
+
+        return test_dict
+
+    #
+    # Output methods
+    #
+
+    def print_rest_flat(self, filename = None, return_string = False):
+
+        """Print tests and subtests ordered by tests"""
+
+        out = "=" * len(self.title) + "\n"
+        out += self.title + "\n"
+        out += "=" * len(self.title) + "\n\n"
+
+        for test in sorted(self.doc.keys()):
+            fname = self.doc[test]["File"]
+
+            name = re.sub(r'.*/', '', fname)
+            name = re.sub(r'\.[ch]', '', name)
+            name = self.main_name + name
+
+            tmp_subtest = self.expand_subtest(fname, name, test, False)
+
+            # Get subtests first, to avoid displaying tests with
+            # all filtered subtests
+            subtest_array = []
+            for subtest in tmp_subtest:
+                if self.__filter_subtest(self.doc[test], subtest, True):
+                    continue
+                subtest_array.append(subtest)
+
+            if not subtest_array:
+                continue
+
+            out += len(name) * '=' + "\n"
+            out += name + "\n"
+            out += len(name) * '=' + "\n\n"
+
+            for field in sorted(self.doc[test].keys()):
+                if field == "subtest":
+                    continue
+                if field == "arg":
+                    continue
+                if field == "_summary_":
+                    continue
+                if field == "subtest_line":
+                    continue
+
+                out += f":{field}: {self.doc[test][field]}\n"
+
+            for subtest in subtest_array:
+
+                out += "\n" + subtest["_summary_"] + "\n"
+                out += len(subtest["_summary_"]) * '=' + "\n\n"
+
+                for field in sorted(subtest.keys()):
+                    if field in [ '_summary_', 'arg', 'subtest_line' ]:
+                        continue
+
+                    out += f":{field}:" + subtest[field] + "\n"
+
+                out += "\n"
+
+            out += "\n\n"
+
+        if filename:
+            with open(filename, "w", encoding='utf8') as handle:
+                handle.write(out)
+        elif not return_string:
+            print(out)
+        else:
+            return out
+
+    def get_spreadsheet(self):
+
+        """
+        Return a bidimentional array with the test contents.
+
+        Its output is similar to a spreadsheet, so it can be used by a
+        separate python file that would create a workbook's sheet.
+        """
+
+        sheet = []
+        row = 0
+        sheet.append([])
+        sheet[row].append('Test name')
+
+        subtest_dict = self.expand_dictionary(True)
+
+                # Identify the sort order for the fields
+        fields_order = []
+        fields = sorted(self.props.items(), key = _sort_per_level)
+        for item in fields:
+            fields_order.append(item[0])
+            sheet[row].append(item[0])
+
+        # Receives a flat subtest dictionary, with wildcards expanded
+        subtest_dict = self.expand_dictionary(True)
+
+        subtests = sorted(subtest_dict.items(),
+                          key = lambda x: _sort_using_array(x, fields_order))
+
+        for subtest, fields in subtests:
+            row += 1
+            sheet.append([])
+
+            sheet[row].append(subtest)
+
+            for field in fields_order:
+                if field in fields:
+                    sheet[row].append(fields[field])
+                else:
+                    sheet[row].append('')
+        return sheet
+
+    def print_nested_rest(self, filename = None, return_string = False):
+
+        """Print tests and subtests ordered by tests"""
+
+        handler = None
+        if filename:
+            original_stdout = sys.stdout
+            handler = open(filename, "w", encoding='utf8') # pylint: disable=R1732
+            sys.stdout = handler
+
+        out = "=" * len(self.title) + "\n"
+        out += self.title + "\n"
+        out += "=" * len(self.title) + "\n\n"
+
+        # Identify the sort order for the fields
+        fields_order = []
+        fields = sorted(self.props.items(), key = _sort_per_level)
+        for item in fields:
+            fields_order.append(item[0])
+
+        # Receives a flat subtest dictionary, with wildcards expanded
+        subtest_dict = self.expand_dictionary(True)
+
+        subtests = sorted(subtest_dict.items(),
+                          key = lambda x: _sort_using_array(x, fields_order))
+
+        # Use the level markers below
+        level_markers='=-^_~:.`"*+#'
+
+        # Print the data
+        old_fields = [ '' ] * len(fields_order)
+
+        for subtest, fields in subtests:
+            # Check what level has different message
+            marker = 0
+            for cur_level in range(0, len(fields_order)):  # pylint: disable=C0200
+                field = fields_order[cur_level]
+                if "level" not in self.props[field]["_properties_"]:
+                    continue
+                if field in fields:
+                    if old_fields[cur_level] != fields[field]:
+                        break
+                    marker += 1
+
+            # print hierarchy
+            for i in range(cur_level, len(fields_order)):
+                if "level" not in self.props[fields_order[i]]["_properties_"]:
+                    continue
+                if fields_order[i] not in fields:
+                    continue
+
+                if marker >= len(level_markers):
+                    sys.exit(f"Too many levels: {marker}, maximum limit is {len(level_markers):}")
+
+                title_str = fields_order[i] + ": " + fields[fields_order[i]]
+
+                out += title_str + "\n"
+                out += level_markers[marker] * len(title_str) + "\n\n"
+                marker += 1
+
+            out += "\n``" + subtest + "``" + "\n\n"
+
+            # print non-hierarchy fields
+            for field in fields_order:
+                if "level" in self.props[field]["_properties_"]:
+                    continue
+
+                if field in fields:
+                    out += f":{field}: {fields[field]}" + "\n"
+
+            # Store current values
+            for i in range(cur_level, len(fields_order)):
+                field = fields_order[i]
+                if "level" not in self.props[field]["_properties_"]:
+                    continue
+                if field in fields:
+                    old_fields[i] = fields[field]
+                else:
+                    old_fields[i] = ''
+
+            out += "\n"
+
+        if filename:
+            with open(filename, "w", encoding='utf8') as handle:
+                handle.write(out)
+        elif not return_string:
+            print(out)
+        else:
+            return out
+
+    def print_json(self, out_fname):
+
+        """Adds the contents of test/subtest documentation form a file"""
+
+        # Receives a dictionary with tests->subtests with expanded subtests
+        test_dict = self.expand_dictionary(False)
+
+        with open(out_fname, "w", encoding='utf8') as write_file:
+            json.dump(test_dict, write_file, indent = 4)
+
+    #
+    # Add filters
+    #
+    def add_filter(self, filter_field_expr):
+
+        """ Add a filter criteria for output data """
+
+        match = re.match(r"(.*)=~\s*(.*)", filter_field_expr)
+        if not match:
+            sys.exit(f"Filter field {filter_field_expr} is not at <field> =~ <regex> syntax")
+        field = match.group(1).strip().lower()
+        if field not in self.field_list:
+            sys.exit(f"Field '{field}' is not defined")
+        filter_field = self.field_list[field]
+        regex = re.compile("{0}".format(match.group(2).strip()), re.I) # pylint: disable=C0209
+        self.filters[filter_field] = regex
+
+    #
+    # Subtest list methods
+    #
+
+    def get_subtests(self, sort_field = None, expand = None, with_order = False):
+
+        """Return an array with all subtests"""
+
+        subtests = {}
+        subtests[""] = []
+
+        order = None
+
+        if sort_field:
+            if sort_field.lower() not in self.field_list:
+                sys.exit(f"Field '{sort_field}' is not defined")
+            sort_field = self.field_list[sort_field.lower()]
+
+            if with_order:
+                if "_properties_" in self.props[sort_field]:
+                    if "order" in self.props[sort_field]["_properties_"]:
+                        order = self.props[sort_field]["_properties_"]["order"]
+
+        subtest_array = []
+        for test in sorted(self.doc.keys()):
+            fname = self.doc[test]["File"]
+
+            test_name = re.sub(r'.*/', '', fname)
+            test_name = re.sub(r'\.[ch]\s*', '', test_name)
+            test_name = self.main_name + test_name
+
+            subtest_array += self.expand_subtest(fname, test_name, test, True)
+
+        subtest_array.sort(key = lambda x : x.get('_summary_'))
+
+        for subtest in subtest_array:
+            if self.__filter_subtest(self.doc[test], subtest, True):
+                continue
+
+            if sort_field:
+                if sort_field in subtest:
+                    if expand:
+                        test_list = subtest[sort_field].split(expand)
+                        test_list = [s.strip() for s in test_list]
+
+                        for test_elem in test_list:
+                            if test_elem not in subtests:
+                                subtests[test_elem] = []
+                            if order:
+                                subtests[test_elem].append((subtest["_summary_"], test_list))
+                            else:
+                                subtests[test_elem].append(subtest["_summary_"])
+                    else:
+                        if subtest[sort_field] not in subtests:
+                            subtests[subtest[sort_field]] = []
+                            if order:
+                                subtests[test_elem].append((subtest["_summary_"], [subtest[sort_field]]))
+                            else:
+                                subtests[subtest[sort_field]].append(subtest["_summary_"])
+                else:
+                    if order:
+                        subtests[test_elem].append((subtest["_summary_"], [subtest[sort_field]]))
+                    else:
+                        subtests[""].append(subtest["_summary_"])
+
+            else:
+                if order:
+                    subtests[test_elem].append((subtest["_summary_"], [subtest[sort_field]]))
+                else:
+                    subtests[""].append(subtest["_summary_"])
+
+        if order:
+            for group, tests in subtests.items():
+                prefix_tests = []
+                suffix_tests = []
+                middle_tests = []
+                is_prefix = True
+                for k in order:
+                    if k == "__all__":
+                        is_prefix = False
+                        continue
+                    for test in tests:
+                        if k in test[1]:
+                            if is_prefix:
+                                prefix_tests.append(test[0])
+                            else:
+                                suffix_tests.append(test[0])
+                for test in tests:
+                    if test[0] not in prefix_tests and test[0] not in suffix_tests:
+                        middle_tests.append(test[0])
+                subtests[group] = prefix_tests + middle_tests + suffix_tests
+
+        return subtests
+
+    #
+    # Validation methods
+    #
+    def check_tests(self):
+
+        """Compare documented subtests with the test list"""
+
+        if not self.built_testlist:
+            sys.exit("Need the build path where the exec files are located")
+
+        if self.filters:
+            print("NOTE: test checks are affected by filters")
+
+        doc_subtests = set()
+
+        args_regex = re.compile(r'\<[^\>]+\>')
+
+        for subtest in self.get_subtests()[""]:
+            subtest = self.subtest_separator.join(subtest.split(self.subtest_separator)[:3])
+            subtest = re.sub(r'\<[^\>]+\>', r'\\d+', subtest)
+            doc_subtests.add(subtest)
+
+        doc_subtests = list(sorted(doc_subtests))
+
+        # Get a list of tests from
+        tests = set()
+        for name in self.filenames:
+            test = self.main_name + re.sub(r"\.c$", "", name.split('/')[-1])
+            tests.add(test)
+
+        run_subtests = []
+        with open(self.built_testlist, 'r', encoding='utf8') as handle:
+            for line in handle:
+                name = line.rstrip("\n")
+                if name in tests:
+                    run_subtests.append(name)
+                else:
+                    result = name.rsplit(self.subtest_separator, 1)[0]
+                    if name in tests:
+                        run_subtests.append(name)
+
+        # Compare arrays
+
+        run_missing = []
+        doc_uneeded = []
+
+        test_regex = r""
+        for doc_test in doc_subtests:
+            if test_regex != r"":
+                test_regex += r"|"
+            test_regex += doc_test
+
+        test_regex = re.compile(r'^(' + test_regex + r')$')
+
+        for doc_test in doc_subtests:
+            found = False
+            for run_test in run_subtests:
+                if test_regex.match(run_test):
+                    found = True
+                    break
+            if not found:
+                doc_uneeded.append(doc_test)
+
+        for run_test in run_subtests:
+            found = False
+            if test_regex.match(run_test):
+                found = True
+            if not found:
+                run_missing.append(run_test)
+
+        if doc_uneeded:
+            for test_name in doc_uneeded:
+                print(f"Warning: Documented {test_name} doesn't exist on source files")
+
+        if run_missing:
+            for test_name in run_missing:
+                print(f'Warning: Missing documentation for {test_name}')
+        if doc_uneeded or run_missing:
+            sys.exit(1)
+
+    #
+    # File handling methods
+    #
+
+    def __add_file_documentation(self, fname, implemented_class, field_re,
+                                 test_tag, subtest_tag, config_origin):
+
+        """Adds the contents of test/subtest documentation form a file"""
+
+        current_test = None
+        current_subtest = None
+
+        handle_section = ''
+        current_field = ''
+        arg_number = 1
+        cur_arg = -1
+        cur_arg_element = 0
+        has_test_or_subtest = 0
+
+        test_regex    = re.compile(test_tag    + r':\s*(.*)')
+        subtest_regex = re.compile('^' + subtest_tag + r':\s*(.*)')
+
+        with open(fname, 'r', encoding='utf8') as handle:
+            arg_ref = None
+            current_test = ''
+            subtest_number = 0
+
+            for file_ln, file_line in enumerate(handle):
+                file_line = file_line.rstrip()
+
+                if re.match(r'^\s*\*$', file_line):
+                    continue
+
+                if re.match(r'^\s*\*/$', file_line):
+                    handle_section = ''
+                    current_subtest = None
+                    arg_ref = None
+                    cur_arg = -1
+                    has_test_or_subtest = 0
+
+                    continue
+
+                if re.match(r'^\s*/\*\*$', file_line):
+                    handle_section = '1'
+                    continue
+
+                if not handle_section:
+                    continue
+
+                file_line = re.sub(r'^\s*\* ?', '', file_line)
+
+                # Handle only known sections
+                if handle_section == '1':
+                    current_field = ''
+
+                    # Check if it is a new TEST section
+                    match = test_regex.match(file_line)
+                    if match:
+                        has_test_or_subtest = 1
+                        current_test = self.test_number
+                        self.test_number += 1
+
+                        handle_section = 'test'
+
+                        self.doc[current_test] = {}
+                        self.doc[current_test]["arg"] = {}
+                        self.doc[current_test]["_summary_"] = match.group(1)
+                        self.doc[current_test]["File"] = fname
+                        self.doc[current_test]["subtest"] = {}
+                        self.doc[current_test]["subtest_line"] = {}
+
+                        if implemented_class:
+                            self.doc[current_test]["Class"] = implemented_class
+                        current_subtest = None
+
+                        continue
+
+                # Check if it is a new SUBTEST section
+                match = subtest_regex.match(file_line)
+                if match:
+                    has_test_or_subtest = 1
+                    current_subtest = subtest_number
+                    subtest_number += 1
+
+                    current_field = ''
+                    handle_section = 'subtest'
+
+                    # subtests inherit properties from the tests
+                    self.doc[current_test]["subtest"][current_subtest] = {}
+                    for field in self.doc[current_test].keys():
+                        if field == "arg":
+                            continue
+                        if field == "summary":
+                            continue
+                        if field == "File":
+                            continue
+                        if field == "subtest":
+                            continue
+                        if field == "_properties_":
+                            continue
+                        if field == "Description":
+                            continue
+                        self.doc[current_test]["subtest"][current_subtest][field] = self.doc[current_test][field]
+
+                    self.doc[current_test]["subtest"][current_subtest]["_summary_"] = match.group(1)
+                    self.doc[current_test]["subtest"][current_subtest]["Description"] = ''
+                    self.doc[current_test]["subtest_line"][current_subtest] = file_ln
+
+                    if not arg_ref:
+                        arg_ref = arg_number
+                        arg_number += 1
+                        self.doc[current_test]["arg"][arg_ref] = {}
+
+                    self.doc[current_test]["subtest"][current_subtest]["arg"] = arg_ref
+
+                    continue
+
+                # It is a known section. Parse its contents
+                match = field_re.match(file_line)
+                if match:
+                    current_field = self.field_list[match.group(1).lower()]
+                    match_val = match.group(2)
+
+                    if handle_section == 'test':
+                        self.doc[current_test][current_field] = match_val
+                    else:
+                        self.doc[current_test]["subtest"][current_subtest][current_field] = match_val
+
+                    cur_arg = -1
+
+                    continue
+
+                if not has_test_or_subtest:
+                    continue
+
+                # Use hashes for arguments to avoid duplication
+                match = re.match(r'arg\[(\d+)\]:\s*(.*)', file_line)
+                if match:
+                    current_field = ''
+                    if arg_ref is None:
+                        sys.exit(f"{fname}:{file_ln + 1}: arguments should be defined after one or more subtests, at the same comment")
+
+                    cur_arg = int(match.group(1)) - 1
+                    if cur_arg not in self.doc[current_test]["arg"][arg_ref]:
+                        self.doc[current_test]["arg"][arg_ref][cur_arg] = {}
+
+                    cur_arg_element = match.group(2)
+
+                    if match.group(2):
+                        # Should be used only for numeric values
+                        self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] = "<" + match.group(2) + ">"
+
+                    continue
+
+                match = re.match(r'\@(\S+):\s*(.*)', file_line)
+                if match:
+                    if cur_arg >= 0:
+                        current_field = ''
+                        if arg_ref is None:
+                            sys.exit(f"{fname}:{file_ln + 1}: arguments should be defined after one or more subtests, at the same comment")
+
+                        cur_arg_element = match.group(1)
+                        self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] = match.group(2)
+
+                    else:
+                        print(f"{fname}:{file_ln + 1}: Warning: invalid argument: @%s: %s" %
+                            (match.group(1), match.group(2)))
+
+                    continue
+
+                # We don't need a multi-lined version here
+                match = re.match(r'arg\[(\d+)\]\.values:\s*(.*)', file_line)
+                if match:
+                    cur_arg = int(match.group(1)) - 1
+
+                    if cur_arg not in self.doc[current_test]["arg"][arg_ref]:
+                        self.doc[current_test]["arg"][arg_ref][cur_arg] = {}
+
+                    values = match.group(2).replace(" ", "").split(",")
+                    for split_val in values:
+                        if split_val == "":
+                            continue
+                        self.doc[current_test]["arg"][arg_ref][cur_arg][split_val] = split_val
+
+                    continue
+
+                # Handle multi-line field contents
+                if current_field:
+                    match = re.match(r'\s+(.*)', file_line)
+                    if match:
+                        if handle_section == 'test':
+                            dic = self.doc[current_test]
+                        else:
+                            dic = self.doc[current_test]["subtest"][current_subtest]
+
+                        if dic[current_field] != '':
+                            dic[current_field] += " "
+                        dic[current_field] += match.group(1)
+                        continue
+
+                # Handle multi-line argument contents
+                if cur_arg >= 0 and arg_ref is not None:
+                    match = re.match(r'\s+\*?\s*(.*)', file_line)
+                    if match:
+                        match_val = match.group(1)
+
+                        match = re.match(r'^(\<.*)\>$',self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element])
+                        if match:
+                            self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] = match.group(1) + ' ' + match_val + ">"
+                        else:
+                            if self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] != '':
+                                self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] += ' '
+                            self.doc[current_test]["arg"][arg_ref][cur_arg][cur_arg_element] += match_val
+                    continue
+
+                file_line.rstrip(r"\n")
+                sys.exit(f"{fname}:{file_ln + 1}: Error: unrecognized line. Need to add field at %s?\n\t==> %s" %
+                         (config_origin, file_line))
+
+    def show_subtests(self, sort_field):
+
+        """Show subtests, allowing sort and filter a field """
+
+        if sort_field:
+            test_subtests = self.get_subtests(sort_field)
+            for val_key in sorted(test_subtests.keys()):
+                if not test_subtests[val_key]:
+                    continue
+                if val_key == "":
+                    print("not defined:")
+                else:
+                    print(f"{val_key}:")
+                    for sub in test_subtests[val_key]:
+                        print (f"  {sub}")
+        else:
+            for sub in self.get_subtests(sort_field)[""]:
+                print (sub)
+
+    def gen_testlist(self, directory, sort_field):
+
+        """Generate testlists from the test documentation"""
+
+        test_prefix = os.path.commonprefix(self.get_subtests()[""])
+        test_prefix = re.sub(r'^' + self.main_name, '', test_prefix)
+
+        # NOTE: currently, it uses a comma for multi-value delimitter
+        test_subtests = self.get_subtests(sort_field, ",", with_order = True)
+
+        if not os.path.exists(directory):
+            os.makedirs(directory)
+
+        for test in test_subtests.keys():  # pylint: disable=C0201,C0206
+            if not test_subtests[test]:
+                continue
+
+            testlist = test.lower()
+            if testlist == "":
+                fname = "other"
+            elif testlist == "bat":         # Basic Acceptance Test
+                fname = "fast-feedback"
+            else:
+                fname = testlist
+
+            fname = re.sub(r"[^\w\d]+", "-", fname)
+            fname = directory + "/" + test_prefix + fname + ".testlist"
+
+            with open(fname, 'w', encoding='utf8') as handler:
+                for sub in test_subtests[test]:
+                    handler.write (f"{sub}\n")
+                print(f"{fname} created.")
-- 
2.40.1

