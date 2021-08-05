Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B473E1F92
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 01:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbhHEXwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 19:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhHEXwH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 19:52:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FBC0613D5
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Aug 2021 16:51:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so7898484yba.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Aug 2021 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g4VlaZaJqsE6T03DiXthF+BbWIcuoMN/330Q3/YZIio=;
        b=KPZrnmtt/GX4apWQRm+0lWsBhov6eO/lA7Q1FFgtlVtXEtHmJW77OxmjJS2VbjPxaL
         +oebQ+lpb9cVOtK6TQhRDZfwdrHVlOj2Vl0V2JAtMJXIFFfptVmGZN2h/ux2Kia0uCCZ
         UGco7DkftL786h2DKl9BfYtap44yH3TQKZJ/V3mZTzERPkg6w8JrvQmE21PfO40AKOLM
         KAZGs5JR3fKydzV4swwpzaW1E58OCFlC0lv2F2C66bP3g/RKOWTz+aRos5XQHMAwBAFl
         3JCufPmY+MVK2UydOwiLW1ojRgvKHAyy4y7m0zcqz28sb+OaF4rSPGZdqo54YZVoWbJe
         k5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g4VlaZaJqsE6T03DiXthF+BbWIcuoMN/330Q3/YZIio=;
        b=dkrPLkFTdPb1o0MtBxlISIT/ggCAUVPvFbCWS5lezhACLyZq0gQPc9Ts+qZ0mY4SBb
         Gyoe/YWQG/AU9sapEO8kbv4LZIszeqxqSESjq9K50X0yNbQ3Gle7u1by3DpOAiragweE
         cd5lRvlNcHVqNjwS4/5dJUmQMJfqig+YtHrEw1wDETwfqNcfq4kRBwQ2yN5xGdCMB5DG
         43jhPggA6kEPXH0pAHSmNsx/DY49/543RNtxdWCTzDGx0cCqWPnz9rE16+wKJ/0q4aQL
         LNpnYlpK/olFdX3EMU7BloM35IoCqjrHS6DwGoiEZRqk8yOl4xm9snfyT7rBgl+B1aj+
         LILw==
X-Gm-Message-State: AOAM531aedUn0FZyYLXCmZVrfOfWojehGdhcKc815CnU6+jku3VSqnxN
        5bShR5RyXYCxq4blCG50j0Be9vU3iR3ptA==
X-Google-Smtp-Source: ABdhPJzsGmCDww09UKe4MBlzb8FwZh++khO8jLgyABH8pw2Fo0mG/OpYavE6lkB63cEvlNflqN6ccLeR27IGXg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:ba4b:612a:402a:3fbd])
 (user=dlatypov job=sendgmr) by 2002:a25:abcd:: with SMTP id
 v71mr8942440ybi.499.1628207511613; Thu, 05 Aug 2021 16:51:51 -0700 (PDT)
Date:   Thu,  5 Aug 2021 16:51:44 -0700
Message-Id: <20210805235145.2528054-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 1/2] kunit: tool: make --raw_output support only showing
 kunit output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--raw_output is nice, but it would be nicer if could show only output
after KUnit tests have started.

So change the flag to allow specifying a string ('kunit').
Make it so `--raw_output` alone will default to `--raw_output=all` and
have the same original behavior.

Drop the small kunit_parser.raw_output() function since it feels wrong
to put it in "kunit_parser.py" when the point of it is to not parse
anything.

E.g.

$ ./tools/testing/kunit/kunit.py run --raw_output=kunit
...
[15:24:07] Starting KUnit Kernel ...
TAP version 14
1..1
    # Subtest: example
    1..3
    # example_simple_test: initializing
    ok 1 - example_simple_test
    # example_skip_test: initializing
    # example_skip_test: You should not see a line below.
    ok 2 - example_skip_test # SKIP this test should be skipped
    # example_mark_skipped_test: initializing
    # example_mark_skipped_test: You should see a line below.
    # example_mark_skipped_test: You should see this line.
    ok 3 - example_mark_skipped_test # SKIP this test should be skipped
ok 1 - example
[15:24:10] Elapsed time: 6.487s total, 0.001s configuring, 3.510s building, 0.000s running

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/kunit-tool.rst |  9 ++++++---
 tools/testing/kunit/kunit.py                 | 20 +++++++++++++++-----
 tools/testing/kunit/kunit_parser.py          |  4 ----
 tools/testing/kunit/kunit_tool_test.py       |  9 +++++++++
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index c7ff9afe407a..ae52e0f489f9 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -114,9 +114,12 @@ results in TAP format, you can pass the ``--raw_output`` argument.
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
-.. note::
-	The raw output from test runs may contain other, non-KUnit kernel log
-	lines.
+The raw output from test runs may contain other, non-KUnit kernel log
+lines. You can see just KUnit output with ``--raw_output=kunit``:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --raw_output=kunit
 
 If you have KUnit results in their raw TAP format, you can parse them and print
 the human-readable summary with the ``parse`` command for kunit_tool. This
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7174377c2172..5a931456e718 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -16,6 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
+from typing import Iterable
 
 import kunit_config
 import kunit_json
@@ -114,7 +115,16 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 					      'Tests not Parsed.')
 
 	if request.raw_output:
-		kunit_parser.raw_output(request.input_data)
+		output: Iterable[str] = request.input_data
+		if request.raw_output == 'all':
+			pass
+		elif request.raw_output == 'kunit':
+			output = kunit_parser.extract_tap_lines(output)
+		else:
+			print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
+		for line in output:
+			print(line.rstrip())
+
 	else:
 		test_result = kunit_parser.parse_run_tests(request.input_data)
 	parse_end = time.time()
@@ -135,7 +145,6 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 	return KunitResult(KunitStatus.SUCCESS, test_result,
 				parse_end - parse_start)
 
-
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	run_start = time.time()
@@ -181,7 +190,7 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-                            type=str, default='.kunit', metavar='build_dir')
+			    type=str, default='.kunit', metavar='build_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -246,8 +255,9 @@ def add_exec_opts(parser) -> None:
 			     action='append')
 
 def add_parse_opts(parser) -> None:
-	parser.add_argument('--raw_output', help='don\'t format output from kernel',
-			    action='store_true')
+	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
+			    'If set to --raw_output=kunit, filters to just KUnit output.',
+			    type=str, nargs='?', const='all', default=None)
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Stores test results in a JSON, and either '
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index b88db3f51dc5..84938fefbac0 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -106,10 +106,6 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 				yield line_num, line[prefix_len:]
 	return LineStream(lines=isolate_kunit_output(kernel_output))
 
-def raw_output(kernel_output) -> None:
-	for line in kernel_output:
-		print(line.rstrip())
-
 DIVIDER = '=' * 60
 
 RESET = '\033[0;0m'
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 628ab00f74bc..619c4554cbff 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -399,6 +399,15 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_kunit(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)

base-commit: f684616e08e9cd9db3cd53fe2e068dfe02481657
-- 
2.32.0.605.g8dce9f2422-goog

