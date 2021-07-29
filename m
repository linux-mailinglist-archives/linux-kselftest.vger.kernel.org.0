Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DA3DB00D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jul 2021 01:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhG2Xzh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 19:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhG2Xzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 19:55:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3DC061765
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 16:55:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so8526491yba.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jul 2021 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wU8t3u3Ep427BQvF2B3kOC3LIMZsmVWLr8RoWT7d7Kk=;
        b=sDFqRQnWH/i8O9+ByY9OVYGJWM3dm7ZPRFboRWFpcOoSadE1ScvEJZmRt4U7PuZ2iM
         5f3CYGv0Iu7ONdPrySMMYICPiNiwiDtJ34GpnPVZDQ+Ng2rVOgjw6P4LVXtii1w9aGLB
         BpByYCpBFRHK5R5uhxq2oGI5ohB2vNYG1OhoYcYpMl5YySwuPIHL6zlvFAnek4ZbGNrD
         73e3H71uuBjAZCYodBj/MJbGZk4Y0mrcyZngv+WYwCy5Q6LUYGChPwJ01JEgDtycUlXi
         P0YU/ImF4Nw21RtrcwJrRQlzgfY7zxIDkvxbrc2jHx5y9+KOdpJ1MKIr3UC47JjwOXim
         GMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wU8t3u3Ep427BQvF2B3kOC3LIMZsmVWLr8RoWT7d7Kk=;
        b=mV8QbyvzBxT/fQIS5yJ5X5b/jUWROE+a3LKSaOw3Dqq7cEv6agMVrVeKC6LTmiaBr2
         iKRaRbgfWDbp6OH2pwqf8HfR0fM4RPCwQ/taBa6W2wW59d9vRlbbcUxJftrWQsQkoeqw
         6ve1+dhjMrn1ojWj7e709g8pHN+kbb/H+SfWTjE8phQ60d0HZio3xd8kocGtiAYXimOQ
         Gsgg5mw7Ya3J7kxQ/HqFpRashHZly/E+5N+pX3GxFHiDHm9URls950deQJV6SG1NxmcX
         iYc/YxW4nB0QhTwUGORutLlZ7KVuOi8ahvANMOu8IO07nyJ8lMieu+Xm5A1Jqt0EXKMX
         gcTw==
X-Gm-Message-State: AOAM530gjx1ZFGgpdNyFdKdKlMGahEU5zI4Bn55Tc2sSlPTR99dpU0kV
        vv6vJ5h6H279IbZOvMdT6nFXLWbIxfuc2A==
X-Google-Smtp-Source: ABdhPJzj/prE60Bc3Ja98gOtqcVmAKt/KlputdPcplzLMdnXARBf9+It5zK738Vi+XMqpWYDViML4sdxtvSZiQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:675d:5947:e389:b947])
 (user=dlatypov job=sendgmr) by 2002:a5b:9c9:: with SMTP id
 y9mr10018616ybq.460.1627602932546; Thu, 29 Jul 2021 16:55:32 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:55:20 -0700
Message-Id: <20210729235521.1127484-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 1/2] kunit: tool: make --raw_output support only showing kunit output
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
after KUnit tests ahve started.

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
2.32.0.554.ge1b32706d8-goog

