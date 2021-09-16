Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1886F40ED70
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 00:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbhIPWka (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 18:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbhIPWka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 18:40:30 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C4C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 15:39:09 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h18-20020a0cffd2000000b0037e78fb2552so35066044qvv.12
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Sep 2021 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EdHLsFLcwc3yqlVGHs+Fv4V3AJJwg9rmZTGpHSJ/dcQ=;
        b=fKMDm4mfMdMQonLPVgx0CETjfgrQ2t/yvCNuS1UZSWK9cYO86A6JNCHa9B3+JhWLU9
         Puhi17TKciloF/mCw+fnhIdCnYikypcy4zUToQEbVhQJUTOi3MndUy/rp3vOYCXS0Gjt
         wqAQy/dVwvMneOWvFdfMF6U0+rvRRypQVTAMQEgcKKd3SdHm40VIqf0QcwfEZ6jUa+fl
         zfckZVRHFzda2MhZ/gwVCPwmMw61wsQWDTfmlTJ+fmsRg7zgIzo6LvSu+KtXsbw4HW8h
         Q266m3QV+H8Tqbjw0d8ibJUEalrRjcqH7K8tZMdu6BnFsixccFu9btCu/VwQ2y73Kfz9
         8Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EdHLsFLcwc3yqlVGHs+Fv4V3AJJwg9rmZTGpHSJ/dcQ=;
        b=Y+98GS8jN4nBvA/r13u3dMS9E/LQMQsSbqnI1sWWCLmEloUmEzFHhDXc4wpPCaoxUD
         nIMIk7xoupRk1hpEZ+alA8CVKGpWNcnDdonRq2lomKv2+AOiv3GN750WiuUBg3X2HGmI
         /DAEhKvtgNhDdY5Lm3aYzAvIvrPJfhtcLoRqz9mIy59fxxNnTaLe/J6cXoJYslzGsG2b
         bsyCeI7F00EMfDJhzECMwNlFIgdIMqyvIHkM037nnUqR8IfMBvgqzolj/OEEsze688ks
         TeSy6qgDb63zUwqXTJJoEgt2bblWuSz6I6nFHZuA0YQ/Y4UAXDlpeym8/LUEWV6PYkit
         iNMg==
X-Gm-Message-State: AOAM532tyX3suOj+f+ZxhfZWzvvNH/xDpjlmA7xhdvGj/S9s3U9F04j/
        6ff4nQUVnaRZKDdCe7GYhIP3QyzBv5vZ8g==
X-Google-Smtp-Source: ABdhPJwQUR5FF0JMgIrjHmd3U9D6zBGgXV0PSIguUKGVDxuXyMFE2eLv+YX8Cbxj2d+Wo2qtWTZ0jRXHhMNSHw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:84a4:4669:156a:f5fb])
 (user=dlatypov job=sendgmr) by 2002:a25:bfc8:: with SMTP id
 q8mr9612510ybm.473.1631831948194; Thu, 16 Sep 2021 15:39:08 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:39:03 -0700
Message-Id: <20210916223903.1592541-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] kunit: tool: make --raw_output only support showing kunit output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 6a499c9c42d0 ("kunit: tool: make --raw_output support only
showing kunit output") made --raw_output a string-typed argument.
Passing --raw_output=kunit would make it only show KUnit-related output
and not everything.

However, converting it to a string-typed argument had side effects.

These calls used to work:
$ kunit.py run --raw_output
$ kunit.py run --raw_output suite_filter
$ kunit.py run suite_filter --raw_output

But now the second is actually parsed as
$ kunit.py run --raw_output=suite_filter

So the order you add in --raw_output now matters and command lines that
used to work might not anymore.

Change --raw_output back to a boolean flag, but change its behavior to
match that of the former --raw_output=kunit.
The assumption is that this is what most people wanted to see anyways.

To get the old behavior, users can simply do:
$ kunit.py run >/dev/null; cat .kunit/test.log
They don't have any easy way of getting the --raw_output=kunit behavior.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

Meta: this is an alternative to
https://lore.kernel.org/linux-kselftest/20210903161405.1861312-1-dlatypov@google.com/

I'd slightly prefer that approach, but if we're fine with giving up the
old --raw_output semantics entirely, this would be cleaner.
I'd also assume that most people would prefer the new semantics, but I'm
not sure of that.

---
 Documentation/dev-tools/kunit/kunit-tool.rst |  7 -------
 tools/testing/kunit/kunit.py                 | 12 +++---------
 tools/testing/kunit/kunit_tool_test.py       | 13 ++++++-------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index ae52e0f489f9..03404746f1f6 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -114,13 +114,6 @@ results in TAP format, you can pass the ``--raw_output`` argument.
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
-The raw output from test runs may contain other, non-KUnit kernel log
-lines. You can see just KUnit output with ``--raw_output=kunit``:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --raw_output=kunit
-
 If you have KUnit results in their raw TAP format, you can parse them and print
 the human-readable summary with the ``parse`` command for kunit_tool. This
 accepts a filename for an argument, or will read from standard input.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5a931456e718..3626a56472b5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -115,13 +115,7 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 					      'Tests not Parsed.')
 
 	if request.raw_output:
-		output: Iterable[str] = request.input_data
-		if request.raw_output == 'all':
-			pass
-		elif request.raw_output == 'kunit':
-			output = kunit_parser.extract_tap_lines(output)
-		else:
-			print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
+		output = kunit_parser.extract_tap_lines(request.input_data)
 		for line in output:
 			print(line.rstrip())
 
@@ -256,8 +250,8 @@ def add_exec_opts(parser) -> None:
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
-			    'If set to --raw_output=kunit, filters to just KUnit output.',
-			    type=str, nargs='?', const='all', default=None)
+			    'It will only show output from KUnit.',
+			    action='store_true')
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Stores test results in a JSON, and either '
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..55ed3dac31ee 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -399,14 +399,13 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
-	def test_run_raw_output_kunit(self):
+	def test_run_raw_output_does_not_take_positional_args(self):
+		# --raw_output might eventually support an argument, but we don't want it
+		# to consume any positional arguments, only ones after an '='.
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
-		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
-		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		for call in self.print_mock.call_args_list:
-			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+		kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
 
 	def test_exec_timeout(self):
 		timeout = 3453

base-commit: 316346243be6df12799c0b64b788e06bad97c30b
-- 
2.33.0.464.g1972c5931b-goog

