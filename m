Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7114430B1C2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Feb 2021 21:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBAU4H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Feb 2021 15:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBAU4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Feb 2021 15:56:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35C2C06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Feb 2021 12:55:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e62so17337009yba.5
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Feb 2021 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mxhCYz3pmXJ0cyDtRYw4nEnyQnGosIqZqquj4Bg/3vE=;
        b=hZ6xJOOQ2MmrrgxbULGyECvWLErthF4ctryyH8aDZNne7gZGSpqOucYbQdZYhc3U46
         zbdcJkm67ikOodul/wB82w+LO/xNYIkeaSKLwOmw/T9fz+L4BahbfneBDfuYoZVk8HNa
         /0YYQJ3Xkf7aULPXdsorf4IfyE1t0bjTd3rJPg3tLe4HzqRCa75e/jjlHF9RdodGGAUk
         EuT/QrcwTKOvbGiaAm8d0qZ8e9dYzpFE5gdPYtP/BZyiM2zsG3u3/UYMPOn1dUWvNZhu
         iAfc3SzjLwlTQ0M1VL1sm5pyR4bZ1pRbRCb90//RcOF6kmBPPvK06aNMLBSClB4sForD
         aByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mxhCYz3pmXJ0cyDtRYw4nEnyQnGosIqZqquj4Bg/3vE=;
        b=Sn5Zvh3K5WGyuoTyZh++wJT5up7tpVsNC5XMqUbIp0MiXuhhOxAwrDzx7jNppQr5Gl
         uJ3pR3mMnTBZ3x9mv7mhXEU11Z/OqiMcjOW0fyrbaqmw0/anqdrEnCCtFLyyW7WdZuhC
         UG7vQhNgUOVL3J+dh2+I51pYQNiMOnbGVEwZwRpLbkgZtvbOhy1icL6ngJcdUODBr7os
         Hko24jRRkTQYphK6BMvUi3he5NtnCg14a05xCc8jRZrX57MLW/lx7tBtXXRv5b2wAc0o
         UAoHBR0uJVOoLmtzGxPsoScikrfVfFslMyWN+qqtRyD2jH3jdAZQ6ibSXncUzl05Qfep
         ePLg==
X-Gm-Message-State: AOAM5329g9HCzMN1lxIT5mOH8+Ntruy8CCRvsfphYLXLIaOWzWl0+3gn
        QhyxaHGf/NXNVT7evvaL6foU4GRhWjsAFg==
X-Google-Smtp-Source: ABdhPJzRT97jxN0qRXhxSydxV7x0QUiIGHkthpEOo92P6NJmrGZOsLkdq+kKG26c4Fbrky8dwukwN8jCIcN6GQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:af91:: with SMTP id
 g17mr6705005ybh.321.1612212923680; Mon, 01 Feb 2021 12:55:23 -0800 (PST)
Date:   Mon,  1 Feb 2021 12:55:14 -0800
Message-Id: <20210201205514.3943096-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2] kunit: make kunit_tool accept optional path to
 .kunitconfig fragment
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
  $ ./tools/testing/kunit/kunit.py run --kunticonfig=fs/ext4/kunitconfig

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

Changes since v1: change from a positional arg to a flag --kunitconfig.
Ensure that it gets added for `kunit.py config` and all other commands.

---
 tools/testing/kunit/kunit.py           |  9 +++++---
 tools/testing/kunit/kunit_kernel.py    | 12 ++++++----
 tools/testing/kunit/kunit_tool_test.py | 32 ++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e808a47c839b..02871a363f76 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -182,6 +182,9 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--alltests',
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
+	parser.add_argument('--kunitconfig',
+			     help='Path to Kconfig fragment that enables KUnit tests',
+			     metavar='kunitconfig')
 
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
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
index b593f4448e83..22f50b931138 100755
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
@@ -399,5 +417,19 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', '--kunitconfig=mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_config_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['config', '--kunitconfig=mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+
 if __name__ == '__main__':
 	unittest.main()

base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0.365.g02bc693789-goog

