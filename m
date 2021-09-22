Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5018414E3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Sep 2021 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhIVQlA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Sep 2021 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhIVQlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Sep 2021 12:41:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF981C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 09:39:29 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so9258210qtx.16
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Sep 2021 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7/iG3SA02r1f60QR6SCCZYUVHBWkS+SuM1mbU3JpT68=;
        b=KoUB2StG9c+YM8RcINzTvM1NepgTmSE2dbP62dqS4qE7aGKsSfDmT+DA0/PkUW0jM0
         SCBnxfFMjUAJsV4Jg1O25r4jJ6bjlcmPbczCs4LQP5YySXbrxWGItZg9WvVvmubDwYfW
         gJJLgjIT00iIvwo0U573dXCqBkhQjz5ciuxDAyOzIm+i6x8cxfp40CddeatBv35CpQ/S
         In2mhmmmlRETvrsh6s3FSJcmmfByeiNdbzJCYwyaOfy8ISwLMsJTwM2bU7EmJr0Ro1z0
         cv+8+4ayeNXo52WsMgljNUwzWIt0dMxfYrq52G9yATg44vIPK9XcdTBWvc70ZLEapiwl
         3tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7/iG3SA02r1f60QR6SCCZYUVHBWkS+SuM1mbU3JpT68=;
        b=Iz/npieYp5JQW2V2YoFGzEmgCxJiQP8z2iehHizlBiG8TgHFKOy/zghJlROz36vXHv
         NPzGUOY79G6TPn1dM/MZkzNlBk44t5TQrmYHs678YIb2hk6Jb2fqddFTpdQar0cy7MuZ
         3bobFWAxY3n4CzUnlzFFFlqmiF3WNSTieJoeKYchdI58xAI8Q85JG8ZeeiJWBFLlys3S
         M2bEaIsLbErFxqKZQolx2/dMqBT2hqldl3sZoclzU365g4APiuieFT4O4WGU2tLg/e+A
         tPKsyIs+y5JIt3tLABhUeVJPUxWuLMEDj6jB5eTkC8D5SAv7SiA7w6YMP3CcPrrjredp
         p8SQ==
X-Gm-Message-State: AOAM530tM8X8mXHcLFws6K5i9PDXqWpKus4BKLwth3sWAneF1HBkWCsc
        PikB0ldtZuiqIrkganSgWRz1QErylywPeA==
X-Google-Smtp-Source: ABdhPJwC3PqjAmzkBqprnS2BY+WEZFwDOYJrLYk4n2FB9Y9p4Ifm2V20Ed/pxSa8v04MRO3XoZGSKQY4ILjdWQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5ad1:21fa:bca6:a843])
 (user=dlatypov job=sendgmr) by 2002:a25:1b08:: with SMTP id
 b8mr113845ybb.24.1632328768925; Wed, 22 Sep 2021 09:39:28 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:39:21 -0700
Message-Id: <20210922163921.2462565-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] kunit: tool: better handling of quasi-bool args (--json, --raw_output)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
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
Tested-by: David Gow <davidgow@google.com>
---
v1 -> v2: fix mypy error by converting mapped argv to a list.
---
 tools/testing/kunit/kunit.py           | 24 ++++++++++++++++++++++--
 tools/testing/kunit/kunit_tool_test.py |  8 ++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5a931456e718..ac35c61f65f5 100755
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
+	return list(map(massage_arg, argv))
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

base-commit: 4c17ca27923c16fd73bbb9ad033c7d749c3bcfcc
-- 
2.33.0.464.g1972c5931b-goog

