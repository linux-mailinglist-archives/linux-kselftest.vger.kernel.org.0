Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB345400304
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Sep 2021 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349937AbhICQPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Sep 2021 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349936AbhICQPL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Sep 2021 12:15:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BABC061575
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Sep 2021 09:14:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso6323820qkb.6
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Sep 2021 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M6ta55C5YrTiWpJmRXkscLbV8qDYp7HoT3jJ6wg8fKI=;
        b=JMhBqnd8AJEbyTVh+/OD0W9I+YhqfjmIJiyFfl6RyNSqhBCGkFjYt2FvjsgRkwCdQF
         D+H+YMexFArgRpval3MhGlLM11t50kFSok9v8VRevgc988OF/fM9C0yss5onTZDJGFn9
         vWNgxVEF6qBMIYr5qamQcDSVsNRBZfVUrf6Hfe+8/Q007XoAjBoquGHFuQ0K287IuoRP
         LtKf/HMh3+KN73qlCprG9FvVFca/yoDftSdfgV0upNRCSaPr7I8ya6q+EosR6D1XZ/4w
         IpAOHtvAWPJ0Sl6U639yuArOSzzvdYZ86y7qfqo/h0TbjxfALNTtM6YzrSNUoIXvjRKz
         VWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M6ta55C5YrTiWpJmRXkscLbV8qDYp7HoT3jJ6wg8fKI=;
        b=SSRRHOWbJWqPPOxeZkiqdjxVKnkRb9466UcncgAxsujxuWUBjkDGdvzlivf9HWe+FR
         T2mKLvmMrlxK61+HjI+Jdb8IZougSBlKQ8d+ppK2quHgraBbDtNUlWPlAcexi0Fr7TLR
         MMWghlp/60koJOx+2nl+bpLQEoLyRs1PFKhhfkY03aNSPCSi6X59ZVJVU3zWxCNeJjUC
         CFqSLq/obPNXU5U9cBTk+Gy4eNC8COCVElpchHm6lAhc9l2gUA2+b0pRyTEkpVDYAeGQ
         eZDOEsp/GgZOoVUZkR0W7CSFjXog1VPk6wg3xwDWAGleoPTJAyBMfUXXTo7KSWenBXhq
         z9TQ==
X-Gm-Message-State: AOAM531f5vSsJhbkYhuVpk+s+dSl2nWmSHxfuFwi+cIHt97i73BYBmo7
        ixaZLe5toCButpII65ixJ3HcUuWluMzqkA==
X-Google-Smtp-Source: ABdhPJyhy9kIgP9BQY4I4hoOAicE1VyjpnSlpawr29BJjQNMqgNZx01vITsQM5Xj+ykD8wQvDu+jmDzNSaklOw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:4791:26fa:5a8a:1c2a])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:268e:: with SMTP id
 gm14mr4477617qvb.51.1630685650225; Fri, 03 Sep 2021 09:14:10 -0700 (PDT)
Date:   Fri,  3 Sep 2021 09:14:05 -0700
Message-Id: <20210903161405.1861312-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH] kunit: tool: better handling of quasi-bool args (--json, --raw_output)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Problem:

What does this do?
$ kunit.py run --json
Well, it runs all the tests and prints test results out as JSON.

And next is
$ kunit.py run my-test-suite --json
This runs just `my-test-suite` and prints results out as JSON.

But what about?
$ kunit.py run --json my-test-suite
This runs all the tests and stores the json results in a "my-test-suite"
file.

Why:
--json, and now --raw_output are actually string flags. They just have a
default value. --json in particular takes the name of an output file.

It was intended that you'd do
$ kunit.py run --json=my_output_file my-test-suite
if you ever wanted to specify the value.

Workaround:
It doesn't seem like there's a way to make
https://docs.python.org/3/library/argparse.html only accept arg values
after a '='.

I believe that `--json` should "just work" regardless of where it is.
So this patch automatically rewrites a bare `--json` to `--json=stdout`.

That makes the examples above work the same way.
Add a regression test that can catch this for --raw_output.

Fixes: 6a499c9c42d0 ("kunit: tool: make --raw_output support only showing kunit output")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 24 ++++++++++++++++++++++--
 tools/testing/kunit/kunit_tool_test.py |  8 ++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5a931456e718..95d62020e4f2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
-from typing import Iterable
+from typing import Iterable, Sequence
 
 import kunit_config
 import kunit_json
@@ -186,6 +186,26 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				exec_result.elapsed_time))
 	return parse_result
 
+# Problem:
+# $ kunit.py run --json
+# works as one would expect and prints the parsed test results as JSON.
+# $ kunit.py run --json suite_name
+# would *not* pass suite_name as the filter_glob and print as json.
+# argparse will consider it to be another way of writing
+# $ kunit.py run --json=suite_name
+# i.e. it would run all tests, and dump the json to a `suite_name` file.
+# So we hackily automatically rewrite --json => --json=stdout
+pseudo_bool_flag_defaults = {
+		'--json': 'stdout',
+		'--raw_output': 'kunit',
+}
+def massage_argv(argv: Sequence[str]) -> Sequence[str]:
+	def massage_arg(arg: str) -> str:
+		if arg not in pseudo_bool_flag_defaults:
+			return arg
+		return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
+	return map(massage_arg, argv)
+
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -303,7 +323,7 @@ def main(argv, linux=None):
 				  help='Specifies the file to read results from.',
 				  type=str, nargs='?', metavar='input_file')
 
-	cli_args = parser.parse_args(argv)
+	cli_args = parser.parse_args(massage_argv(argv))
 
 	if get_kernel_root_path():
 		os.chdir(get_kernel_root_path())
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..1edcc8373b4e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -408,6 +408,14 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_does_not_take_positional_args(self):
+		# --raw_output is a string flag, but we don't want it to consume
+		# any positional arguments, only ones after an '='
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
+
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)

base-commit: a9c9a6f741cdaa2fa9ba24a790db8d07295761e3
-- 
2.33.0.153.gba50c8fa24-goog

