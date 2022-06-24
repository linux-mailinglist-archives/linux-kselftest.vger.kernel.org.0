Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9CF558C26
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 02:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiFXAM5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jun 2022 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFXAM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jun 2022 20:12:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3479F108C
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 17:12:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v191-20020a25c5c8000000b00663d6d41f5aso851176ybe.12
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jun 2022 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6uunD2g0M7oC9HubsVKWl+mdiBooUbJaE8apiZgZWPQ=;
        b=nEkZFBfENPUBjZ3+w3lYjd8PwUIDkVxqeyY9LGtHTBjunXVU45OS8nKtxZny3MeBXh
         dn/Ejwf1HUZWy7HBRy6GOOC6DdzGPdINd+wT1JIdXgLO0qNqX4HnRF03bj7U/+dqms+T
         x1Jych095YlixkssUlE+MBGd4ljzlXUpeaTTzWyq7lumTS5FRf9CHv5ySiaKnsv9+9ZK
         DpllriOjnWc4BsZGlBW64vlxPcg4epVL42pLqoYeIou9qz76QKavgC1IrqF5/jHuOP7R
         5hxdLtW/hmxGiOzylhr2qVwkBlceVEvimllVOLzAXy2U1lXdJgk4LInrJZ/LjEijlHSY
         V8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6uunD2g0M7oC9HubsVKWl+mdiBooUbJaE8apiZgZWPQ=;
        b=v2mp6p7nxg5K9oyIQEH3awyGmk1K7M/XkmoLyF4pRbThX7SFJaKDE0KuckRocyqqHD
         z4KDtqK/LtM9GPBtvYkym4f9JwguEUi6bQGRg/XhOWPTEiQcXLHbaUFu1CQRJQRzaLyu
         ENkt/I3MFvsr6snf6d4ciEkhqzNpgp73EGoXIzFfFumvMX6mzwswTrqW+fmOVuY42Vg+
         a0L81eAcoYFw/o9Sf/NUNBDh4hQAt9K0B07TalDBxsZZ65wcqxKoy6Z+wZJ97ol5g/1o
         NaK9GLOpkXJO1FAwyF4kRJTSGjVqkqO8yesjLm5KLO71+weJOnsBuH6mtXS++03WCT8G
         y9Rg==
X-Gm-Message-State: AJIora+5UesOJHeFuwfhDUdUmsiMClahs78uwaJBMZfl66QBQxICjGxf
        l+P/wq//AgBGJml+GpjD09JsnwXjyqnbJA==
X-Google-Smtp-Source: AGRyM1uU3cGKBTXZb9dnbPpsVFuAWUbuTsmaXNmJM//yDiCl764HV0a+S18RmH9DErmCj/ZzrkaGMgB1ZnqoWw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a0d:c103:0:b0:314:1aa7:8efb with SMTP id
 c3-20020a0dc103000000b003141aa78efbmr13618259ywd.87.1656029573377; Thu, 23
 Jun 2022 17:12:53 -0700 (PDT)
Date:   Fri, 24 Jun 2022 00:12:46 +0000
Message-Id: <20220624001247.3255978-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH 1/2] kunit: tool: make --kunitconfig repeatable, blindly concat
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's come up a few times that it would be useful to have --kunitconfig
be repeatable [1][2].

This could be done before with a bit of shell-fu, e.g.
  $ find fs/ -name '.kunitconfig' -exec cat {} + | \
    ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin
or equivalently:
  $ cat fs/ext4/.kunitconfig fs/fat/.kunitconfig | \
    ./tools/testing/kunit/kunit.py run --kunitconfig=/dev/stdin

But this can be fairly clunky to use in practice.

And having explicit support in kunit.py opens the door to having more
config fragments of interest, e.g. options for PCI on UML [1], UML
coverage [2], variants of tests [3].
There's another argument to be made that users can just use multiple
--kconfig_add's, but this gets very clunky very fast (e.g. [2]).

Note: there's a big caveat here that some kconfig options might be
incompatible. We try to give a clearish error message in the simple case
where the same option appears multiple times with conflicting values,
but more subtle ones (e.g. mutually exclusive options) will be
potentially very confusing for the user. I don't know we can do better.

Note 2: if you want to combine a --kunitconfig with the default, you
either have to do to specify the current build_dir
> --kunitconfig=.kunit --kunitconfig=additional.config
or
> --kunitconfig=tools/testing/kunit/configs/default.config --kunitconifg=additional.config
each of which have their downsides (former depends on --build_dir,
doesn't work if you don't have a .kunitconfig yet), etc.

Example with conflicting values:
> $ ./tools/testing/kunit/kunit.py config --kunitconfig=lib/kunit --kunitconfig=/dev/stdin <<EOF
> CONFIG_KUNIT_TEST=n
> CONFIG_KUNIT=m
> EOF
> ...
> kunit_kernel.ConfigError: Multiple values specified for 2 options in kunitconfig:
> CONFIG_KUNIT=y
>   vs from /dev/stdin
> CONFIG_KUNIT=m
>
> CONFIG_KUNIT_TEST=y
>   vs from /dev/stdin
> # CONFIG_KUNIT_TEST is not set

[1] https://lists.freedesktop.org/archives/dri-devel/2022-June/357616.html
[2] https://lore.kernel.org/linux-kselftest/CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com/
[3] https://lore.kernel.org/linux-kselftest/CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

NOTE: this series is based on https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
That patch redoes kunitconfig parsing, so we'd have merge conflicts
either way we order these.

---
 tools/testing/kunit/kunit.py           | 13 ++++---
 tools/testing/kunit/kunit_config.py    | 11 +++++-
 tools/testing/kunit/kunit_kernel.py    | 38 ++++++++++++------
 tools/testing/kunit/kunit_tool_test.py | 54 +++++++++++++++++++++++---
 4 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 13bd72e47da8..163f6b8ac464 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -291,8 +291,9 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--kunitconfig',
 			     help='Path to Kconfig fragment that enables KUnit tests.'
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
-			     'will get  automatically appended.',
-			     metavar='PATH')
+			     'will get  automatically appended. If repeated, the files '
+			     'blindly concatenated, which might not work in all cases.',
+			     action='append', metavar='PATHS')
 	parser.add_argument('--kconfig_add',
 			     help='Additional Kconfig options to append to the '
 			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
@@ -414,7 +415,7 @@ def main(argv, linux=None):
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
+					kunitconfig_paths=cli_args.kunitconfig,
 					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
@@ -440,7 +441,7 @@ def main(argv, linux=None):
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
+					kunitconfig_paths=cli_args.kunitconfig,
 					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
@@ -457,7 +458,7 @@ def main(argv, linux=None):
 	elif cli_args.subcommand == 'build':
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
+					kunitconfig_paths=cli_args.kunitconfig,
 					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
@@ -476,7 +477,7 @@ def main(argv, linux=None):
 	elif cli_args.subcommand == 'exec':
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
+					kunitconfig_paths=cli_args.kunitconfig,
 					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 89443400b17e..05b129030c6e 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import Dict, Iterable, Set
+from typing import Dict, Iterable, List, Set, Tuple
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -64,6 +64,15 @@ class Kconfig:
 	def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
 		return set(self._as_entries()) - set(other._as_entries())
 
+	def differing_options(self, other: 'Kconfig') -> List[Tuple[KconfigEntry, KconfigEntry]]:
+		diff = []  # type: List[Tuple[KconfigEntry, KconfigEntry]]
+		for name, value in self._entries.items():
+			b = other._entries.get(name)
+			if b and value != b:
+				pair = (KconfigEntry(name, value), KconfigEntry(name, b))
+				diff.append(pair)
+		return diff
+
 	def merge_in_entries(self, other: 'Kconfig') -> None:
 		for name, value in other._entries.items():
 			self._entries[name] = value
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 6d994bb24999..fc415ff7530e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -176,6 +176,30 @@ def get_kunitconfig_path(build_dir: str) -> str:
 def get_old_kunitconfig_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OLD_KUNITCONFIG_PATH)
 
+def get_parsed_kunitconfig(build_dir: str,
+			   kunitconfig_paths: Optional[List[str]]=None) -> kunit_config.Kconfig:
+	if not kunitconfig_paths:
+		path = get_kunitconfig_path(build_dir)
+		if not os.path.exists(path):
+			shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, path)
+		return kunit_config.parse_file(path)
+
+	merged = kunit_config.Kconfig()
+
+	for path in kunitconfig_paths:
+		if os.path.isdir(path):
+			path = os.path.join(path, KUNITCONFIG_PATH)
+		if not os.path.exists(path):
+			raise ConfigError(f'Specified kunitconfig ({path}) does not exist')
+
+		partial = kunit_config.parse_file(path)
+		diff = merged.differing_options(partial)
+		if diff:
+			diff_str = '\n\n'.join(f'{a}\n  vs from {path}\n{b}' for a, b in diff)
+			raise ConfigError(f'Multiple values specified for {len(diff)} options in kunitconfig:\n{diff_str}')
+		merged.merge_in_entries(partial)
+	return merged
+
 def get_outfile_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OUTFILE_PATH)
 
@@ -221,7 +245,7 @@ class LinuxSourceTree:
 	      self,
 	      build_dir: str,
 	      load_config=True,
-	      kunitconfig_path='',
+	      kunitconfig_paths: Optional[List[str]]=None,
 	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
@@ -237,17 +261,7 @@ class LinuxSourceTree:
 		if not load_config:
 			return
 
-		if kunitconfig_path:
-			if os.path.isdir(kunitconfig_path):
-				kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
-			if not os.path.exists(kunitconfig_path):
-				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
-		else:
-			kunitconfig_path = get_kunitconfig_path(build_dir)
-			if not os.path.exists(kunitconfig_path):
-				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
-
-		self._kconfig = kunit_config.parse_file(kunitconfig_path)
+		self._kconfig = get_parsed_kunitconfig(build_dir, kunitconfig_paths)
 		if kconfig_add:
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 3a8f638ff092..e21ae1331350 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -356,17 +356,46 @@ class LinuxSourceTreeTest(unittest.TestCase):
 
 	def test_invalid_kunitconfig(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=['/nonexistent_file'])
 
 	def test_valid_kunitconfig(self):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[kunitconfig.name])
 
 	def test_dir_kunitconfig(self):
 		with tempfile.TemporaryDirectory('') as dir:
 			with open(os.path.join(dir, '.kunitconfig'), 'w'):
 				pass
-			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir])
+
+	def test_multiple_kunitconfig(self):
+		want_kconfig = kunit_config.Kconfig()
+		want_kconfig.add_entry('KUNIT', 'y')
+		want_kconfig.add_entry('KUNIT_TEST', 'm')
+
+		with tempfile.TemporaryDirectory('') as dir:
+			other = os.path.join(dir, 'otherkunitconfig')
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(other, 'w') as f:
+				f.write('CONFIG_KUNIT_TEST=m')
+				pass
+
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
+			self.assertFalse(want_kconfig.set_diff(tree._kconfig))
+
+
+	def test_multiple_kunitconfig_invalid(self):
+		with tempfile.TemporaryDirectory('') as dir:
+			other = os.path.join(dir, 'otherkunitconfig')
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(other, 'w') as f:
+				f.write('CONFIG_KUNIT=m')
+
+			with self.assertRaisesRegex(kunit_kernel.ConfigError, '(?s)Multiple values.*CONFIG_KUNIT'):
+				kunit_kernel.LinuxSourceTree('', kunitconfig_paths=[dir, other])
+
 
 	def test_kconfig_add(self):
 		want_kconfig = kunit_config.Kconfig()
@@ -637,7 +666,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
+							kunitconfig_paths=['mykunitconfig'],
 							kconfig_add=None,
 							arch='um',
 							cross_compile=None,
@@ -649,19 +678,32 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['config', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
+							kunitconfig_paths=['mykunitconfig'],
 							kconfig_add=None,
 							arch='um',
 							cross_compile=None,
 							qemu_config_path=None)
 
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_multiple_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', '--kunitconfig=mykunitconfig', '--kunitconfig=other'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit',
+							kunitconfig_paths=['mykunitconfig', 'other'],
+							kconfig_add=None,
+							arch='um',
+							cross_compile=None,
+							qemu_config_path=None)
+
+
 	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
 	def test_run_kconfig_add(self, mock_linux_init):
 		mock_linux_init.return_value = self.linux_source_mock
 		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path=None,
+							kunitconfig_paths=None,
 							kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
 							arch='um',
 							cross_compile=None,
-- 
2.37.0.rc0.104.g0611611a94-goog

