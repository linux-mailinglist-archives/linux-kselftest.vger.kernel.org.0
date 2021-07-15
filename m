Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153903CA1F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jul 2021 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhGOQL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jul 2021 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhGOQLX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jul 2021 12:11:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B8C0613AB
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 09:08:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so8310071ybp.17
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jul 2021 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1o37J9MoZZ+vDer31YkJSNAjMMNxblJv6XR93abMUWg=;
        b=L7/iBV0UZozFU2kASLrC9NFDydG9pNTC2UhDgqQtjPPtc/XXkLq0fKJd7t1lJLCxKB
         CHNO7pmG4c4OBzkTCSn+Fi3JUbYI+99Euc0MxRqt3g+VhWlme9lNWa4GeKPKJ90/BWHM
         K+GiLjnDHl8KLhyg5qJtzLTGdJaTWptqUYa2v1eCvvitLKhK7SfQGegO0GjRHjZBJvFY
         2vDi54+WzJ1ewxxysDHhjhgcuRmy7xdRKDC1xZea+CfvGfwzXwq/fnEuP0JsO6O7+FwW
         5WPaSv4q3z4LYZoE2FX0xgp4jUUlsiGldLsw4VCcgZ7Sn8mNij5lnRQEfWL1qtbhZEr2
         j6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1o37J9MoZZ+vDer31YkJSNAjMMNxblJv6XR93abMUWg=;
        b=LmXDtgC7AtV3x++W+otdm9XbnHXtUsI4KfB1K4pbY4IUTYqvWHz9/DlfkPGepZEt8Z
         dfWABrsfOfdOF+eEYwLC/wKw9g+9SWy+xrsNWgrY1wtxPEOqKH9amlhB+/fvjrOOy68I
         YyOHIT5OzMKMgXVP0NJorTAbYOX7h1yfMFx3XBbS0bCfqB6u/UsTZX6nDC3Ay/hA47PK
         EIJna3hUGmOlN/ksUbZNJzJq1cCckZmY2kbt3Che+8w1ajiY98sUk81gc1fkwfvkTeBq
         fQOh6RE2IykB4haJ6iq+9VNy5eBildBG2jtZ4imbHS/o+Spd5iTjujNfgItmNpIPzfFT
         qibw==
X-Gm-Message-State: AOAM533QApiaYAzcO1G8nRYtLokBDDNiIyjGO5I3tTw3bdF64octEa/k
        52ofhxbc5/rJS2NKSqt6qboec8kT9GJosQ==
X-Google-Smtp-Source: ABdhPJzjaGzZak4dOt1/5/b95sxTJ8nObU7fjaj4tH3oNcjkTlOE+5apMIuefvtYI30QQI/aDbxcgd4PFzPQng==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:24a2:4c13:4cc0:8818])
 (user=dlatypov job=sendgmr) by 2002:a25:b70d:: with SMTP id
 t13mr6440528ybj.204.1626365306296; Thu, 15 Jul 2021 09:08:26 -0700 (PDT)
Date:   Thu, 15 Jul 2021 09:08:19 -0700
Message-Id: <20210715160819.1107685-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3] kunit: tool: add --kernel_args to allow setting module params
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit.py currently does not make it possible for users to specify module
parameters (/kernel arguments more generally) unless one directly tweaks
the kunit.py code itself.

This hasn't mattered much so far, but this would make it easier to port
existing tests that expose module parameters over to KUnit and/or let
current KUnit tests take advantage of them.

Tested using an kunit internal parameter:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit \
    --kernel_args=kunit.filter_glob=kunit_status
...
Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2:
s/kernel_arg/kernel_args in documentation
v2 -> v3:
Fix up kunit_tool_test.py, add a test case.
---
 .../dev-tools/kunit/running_tips.rst          | 10 ++++++++++
 tools/testing/kunit/kunit.py                  | 16 +++++++++++----
 tools/testing/kunit/kunit_tool_test.py        | 20 +++++++++++++------
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7d99386cf94a..ebaaa2764207 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -80,6 +80,16 @@ file ``.kunitconfig``, you can just pass in the dir, e.g.
 	automagically, but tests could theoretically depend on incompatible
 	options, so handling that would be tricky.
 
+Setting kernel commandline parameters
+-------------------------------------
+
+You can use ``--kernel_args`` to pass arbitrary kernel arguments, e.g.
+
+.. code-block:: bash
+
+	$ ./tools/testing/kunit/kunit.py run --kernel_args=param=42 --kernel_args=param2=false
+
+
 Generating code coverage reports under UML
 ------------------------------------------
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index be8d8d4a4e08..03f3bc406955 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -28,12 +28,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
+                              ['timeout', 'build_dir', 'alltests',
+                               'filter_glob', 'kernel_args'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'json', 'make_options'])
+					   'kernel_args', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -92,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
 	result = linux.run_kernel(
+		args=request.kernel_args,
 		timeout=None if request.alltests else request.timeout,
                 filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
@@ -150,7 +152,8 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests, request.filter_glob)
+				 request.alltests, request.filter_glob,
+				 request.kernel_args)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -236,6 +239,9 @@ def add_exec_opts(parser) -> None:
 			    nargs='?',
 			    default='',
 			    metavar='filter_glob')
+	parser.add_argument('--kernel_args',
+			    help='Kernel command-line parameters. Maybe be repeated',
+			     action='append')
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
@@ -307,6 +313,7 @@ def main(argv, linux=None):
 				       cli_args.build_dir,
 				       cli_args.alltests,
 				       cli_args.filter_glob,
+				       cli_args.kernel_args,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -361,7 +368,8 @@ def main(argv, linux=None):
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
 						cli_args.alltests,
-						cli_args.filter_glob)
+						cli_args.filter_glob,
+						cli_args.kernel_args)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bdae0e5f6197..93fda23f446c 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -346,7 +346,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -354,7 +354,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -393,7 +393,7 @@ class KUnitMainTest(unittest.TestCase):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -401,7 +401,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
@@ -409,7 +409,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
@@ -426,7 +426,7 @@ class KUnitMainTest(unittest.TestCase):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
@@ -451,5 +451,13 @@ class KUnitMainTest(unittest.TestCase):
 							cross_compile=None,
 							qemu_config_path=None)
 
+	def test_run_kernel_args(self):
+		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
+
 if __name__ == '__main__':
 	unittest.main()

base-commit: 8096acd7442e613fad0354fc8dfdb2003cceea0b
-- 
2.32.0.93.g670b81a890-goog

