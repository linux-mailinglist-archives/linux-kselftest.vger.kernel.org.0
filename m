Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F030118E
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Jan 2021 01:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAWASx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jan 2021 19:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAWASk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jan 2021 19:18:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D36C061786
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jan 2021 16:17:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127so7186916ybn.5
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jan 2021 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=j2yVLSeKVflthIG8vtivuEcuH5FNLO2jKklVbyIHSEo=;
        b=RQKykWkfNrzebKlEf7vc0c2jTc87fR03Qa7ac2jOOXolc7+hOLWIc2n0BYqjXSvns8
         Bcik0sPBVZO8G7Pgy6WelJSbnUhx5+/MITfj10+rvFRTJgRJY8gwi7m1a8T1c4tJdWQS
         Ihe+BXo3bpr4vpXKvy5vOrE+wKBfhcZK4JDxTrwaFsrAyYQq/sM+WPLGDfCLP6kZiytv
         oACsgVJySnR7sRfz+oGjhHLBNTO3HXSz0SwBxUUEkixTLNey89HgFQqiIr/pBd+BcLO5
         XWKX78CpIkb9qbzYmwKt9sKMNXUKKh60Hk5U8wGdyk+Gl8KR2si2NlAS+agdJUovw9NC
         QpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=j2yVLSeKVflthIG8vtivuEcuH5FNLO2jKklVbyIHSEo=;
        b=nNSBbtfx+IHzQOfoXO92RHyeD8h+SiVNL2bX/w5NKeNwaXFKh3BUy2dZpMAUzQoeuX
         WyFFbtoE1ASwdHttvV7OOqj8PtA2ZecVmVmqPdx9CgwGWTf+656gEn0vyya55Hr0yMhv
         yPRDFqfRBtwIYERHgscGHRdrnMvJzJIz1qMSTpD1DdL3U4zQKTRt/FZdRSMZXtMZSQqr
         PSXkQ3qOQ1ufe+UR8Hw1k9mSwFFPMQPiHfYspZkdDjTzM4OsiTPB6Jgw9zOekkHk1g1W
         88uIl38JgzjT0sYDHJVKUCQPY0tOms583ydE9GscVhJueBvXGNA12f8SvbJD3lsRz9sE
         dD7w==
X-Gm-Message-State: AOAM531LiTZKpoLGr98Nn7/Hdr4VA4clnbQhYgpyS61bP4bfTi4260pG
        yaC3fwGFRjED0OMEQb/nHfAxNftp3K6lZg==
X-Google-Smtp-Source: ABdhPJzg8rUAIWjiNNGyMxTdBOYfHprxuYZqATRBJRECUUTYZhJwKn9jqJwNrj0ocvjRaM/+vQZ3sRS2o2rehg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:2941:: with SMTP id
 p62mr5891729ybp.26.1611361076091; Fri, 22 Jan 2021 16:17:56 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:17:43 -0800
Message-Id: <20210123001743.1379894-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] kunit: make kunit_tool accept optional path to .kunitconfig fragment
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently running tests via KUnit tool means tweaking a .kunitconfig
file, which you'd keep around locally and never commit.
This changes makes it so users can pass in a path to a kunitconfig.

One of the imagined use cases is having kunitconfig fragments in-tree
to formalize interesting sets of tests for features/subsystems, e.g.
  $ ./tools/testing/kunit/kunit.py run fs/ext4/kunitconfig

For now, this hypothetical fs/ext4/kunitconfig would contain
  CONFIG_KUNIT=y
  CONFIG_EXT4_FS=y
  CONFIG_EXT4_KUNIT_TESTS=y

At the moment, it's not hard to manually whip up this file, but as more
and more tests get added, this will get tedious.

It also opens the door to documenting how to run all the tests relevant
to a specific subsystem or feature as a simple one-liner.

This can be seen as an analogue to tools/testing/selftests/*/config
But in the case of KUnit, the tests live in the same directory as the
code-under-test, so it feels more natural to allow the kunitconfig
fragments to live anywhere. (Though, people could create a separate
directory if wanted; this patch imposes no restrictions on the path).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           |  9 ++++++---
 tools/testing/kunit/kunit_kernel.py    | 12 ++++++++----
 tools/testing/kunit/kunit_tool_test.py | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e808a47c839b..3204a23bd16e 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -188,6 +188,9 @@ def add_build_opts(parser) -> None:
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
 			    type=int, default=8, metavar='jobs')
+	parser.add_argument('kunitconfig',
+			     help='Path to Kconfig fragment that enables KUnit tests',
+			     type=str, nargs='?', metavar='kunitconfig')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
@@ -256,7 +259,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
@@ -274,7 +277,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -286,7 +289,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2076a5a2d060..0b461663e7d9 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -123,7 +123,7 @@ def get_outfile_path(build_dir) -> str:
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
+	def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
 		self._ops = LinuxSourceTreeOperations()
@@ -131,9 +131,13 @@ class LinuxSourceTree(object):
 		if not load_config:
 			return
 
-		kunitconfig_path = get_kunitconfig_path(build_dir)
-		if not os.path.exists(kunitconfig_path):
-			shutil.copyfile(defconfig, kunitconfig_path)
+		if kunitconfig_path:
+			if not os.path.exists(kunitconfig_path):
+				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
+		else:
+			kunitconfig_path = get_kunitconfig_path(build_dir)
+			if not os.path.exists(kunitconfig_path):
+				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
 
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b593f4448e83..533fe41b5123 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -12,6 +12,7 @@ from unittest import mock
 import tempfile, shutil # Handling test_tmpdir
 
 import json
+import signal
 import os
 
 import kunit_config
@@ -250,6 +251,23 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
+class LinuxSourceTreeTest(unittest.TestCase):
+
+	def setUp(self):
+		mock.patch.object(signal, 'signal').start()
+		self.addCleanup(mock.patch.stopall)
+
+	def test_invalid_kunitconfig(self):
+		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
+
+	def test_valid_kunitconfig(self):
+		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+
+	# TODO: add more test cases.
+
+
 class KUnitJsonTest(unittest.TestCase):
 
 	def _json_for(self, log_file):
@@ -399,5 +417,12 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', 'mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+
 if __name__ == '__main__':
 	unittest.main()

base-commit: 2b8fdbbf1c616300312f71fe5b21fe8f03129950
-- 
2.30.0.280.ga3ce27912f-goog

