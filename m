Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5E56B01D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 03:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiGHBgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jul 2022 21:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiGHBgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jul 2022 21:36:38 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EAA72EF7
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jul 2022 18:36:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bd7-20020a656e07000000b00412a946da8eso3943165pgb.20
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jul 2022 18:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ODgBEmEsl6rJt2EylFcnojNKRR8OgMdKvcL6VaOiX+w=;
        b=kGzY4rmoueVx8pzGnUgsiXuHksm/6KkwxWV5DiERjqjh2dFXzFTo4K4jyDmrholloJ
         m88uOd2FZADYSZkTuohMXEJMpsqy5zzrnBm3UaNSenDmIUkEbVFmU6Jz1kJuvZDY4FoR
         w5IGi+7S2LX6+X+omaOu9nF+0EGNI1jW+61HqV33z4/UT2t6gEH0uzVFOgUmsJR2R3vU
         L5tsUQYO3B6FU+eqyc7RI6qGwEAvT6Nkebfa/UwJqcpSA3Mu5iEaapURnTrptcQrcM4A
         ltwR69dsbS2zO6AkXUuXRfEG/IfNKNQubDapGh6o12ByrEakXfR/T+TSWa4u/+ex3txz
         5ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ODgBEmEsl6rJt2EylFcnojNKRR8OgMdKvcL6VaOiX+w=;
        b=PlkfQFU0l8R8chk7W6dd9LlGsteLgPastkcen2TEqXXYoGjlRMcF7QclK0h76FLbDY
         InzSDFSQ3lemoqpW+U7vaEzQ8+PXPaFt+tSiUDM8z9kMJvmB2KV7oxw2cJafh1EuweeG
         UpJih96dBjR1Liw3nCYjeknflBSXitBflALdqJ8vBpuiAVbtq+uTYzBXYZLoTotzHMgc
         ebuTkEXnSd2AXOzQrr1BOLm0fKtvuk3s/B5wy7WsDnRrTBC9KtIDi7HdEEkD5CPIKRaM
         tEuxZo4d0+Y+o/zbjIkRrhLu8e6QYZK2waSxjdkyfiOOY/CIr3OqOPjhOJ67THqFIq+p
         SC/Q==
X-Gm-Message-State: AJIora+7k9rIAVjj0K1ETtUsZkPTmTgW6nmatMKWPDeDWPHeqAVMtXZk
        YjaKuEjxVSrsiE5y+Vpod5sOY43k2DjQXA==
X-Google-Smtp-Source: AGRyM1v2XdtgG64jw4csnYN8EGLp7K3RGY75Unj6RkvSQ3kjwGXowENaMzWzV2203FmSBiVCja3yg3DcJRiYcA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:f8d1:b0:1ef:8795:c7e with SMTP id
 l17-20020a17090af8d100b001ef87950c7emr1006572pjd.74.1657244195596; Thu, 07
 Jul 2022 18:36:35 -0700 (PDT)
Date:   Fri,  8 Jul 2022 01:36:32 +0000
Message-Id: <20220708013632.1210466-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4] kunit: tool: make --kunitconfig repeatable, blindly concat
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v3: merge with kunitconfig refactor patch, rename
differing_options() to conflicting_options()

v3 -> v4: add Brendan's RB tag, rebase onto the -kselftest kunit branch.
The 1/3 and 3/3 of the initial series applied cleanly, but this one
didn't, so I'm sending just this one out by itself now.
Specifically, there were significant merge conflicts with the
--qemu_args patch.
---
 tools/testing/kunit/kunit.py           |  7 ++--
 tools/testing/kunit/kunit_config.py    | 11 ++++-
 tools/testing/kunit/kunit_kernel.py    | 38 +++++++++++------
 tools/testing/kunit/kunit_tool_test.py | 56 ++++++++++++++++++++++----
 4 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index b686126afb40..e132b0654029 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -293,8 +293,9 @@ def add_common_opts(parser) -> None:
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
@@ -381,7 +382,7 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
 			qemu_args.extend(shlex.split(arg))
 
 	return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-			kunitconfig_path=cli_args.kunitconfig,
+			kunitconfig_paths=cli_args.kunitconfig,
 			kconfig_add=cli_args.kconfig_add,
 			arch=cli_args.arch,
 			cross_compile=cli_args.cross_compile,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 898b2a35eb29..48b5f34b2e5d 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import Dict, Iterable, Set
+from typing import Dict, Iterable, List, Set, Tuple
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -60,6 +60,15 @@ class Kconfig:
 				return False
 		return True
 
+	def conflicting_options(self, other: 'Kconfig') -> List[Tuple[KconfigEntry, KconfigEntry]]:
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
index 94ec9f65ef19..56492090e28e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -177,6 +177,30 @@ def get_kunitconfig_path(build_dir: str) -> str:
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
+		diff = merged.conflicting_options(partial)
+		if diff:
+			diff_str = '\n\n'.join(f'{a}\n  vs from {path}\n{b}' for a, b in diff)
+			raise ConfigError(f'Multiple values specified for {len(diff)} options in kunitconfig:\n{diff_str}')
+		merged.merge_in_entries(partial)
+	return merged
+
 def get_outfile_path(build_dir: str) -> str:
 	return os.path.join(build_dir, OUTFILE_PATH)
 
@@ -221,7 +245,7 @@ class LinuxSourceTree:
 	def __init__(
 	      self,
 	      build_dir: str,
-	      kunitconfig_path='',
+	      kunitconfig_paths: Optional[List[str]]=None,
 	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
@@ -238,17 +262,7 @@ class LinuxSourceTree:
 				qemu_config_path = _default_qemu_config_path(self._arch)
 				_, self._ops = _get_qemu_ops(qemu_config_path, extra_qemu_args, cross_compile)
 
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
index e56544d58147..ad63d0d34f3f 100755
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
+			self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
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
@@ -636,7 +665,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
 		self.mock_linux_init.assert_called_once_with('.kunit',
-						kunitconfig_path='mykunitconfig',
+						kunitconfig_paths=['mykunitconfig'],
 						kconfig_add=None,
 						arch='um',
 						cross_compile=None,
@@ -647,18 +676,31 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['config', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
 		self.mock_linux_init.assert_called_once_with('.kunit',
-						kunitconfig_path='mykunitconfig',
+						kunitconfig_paths=['mykunitconfig'],
 						kconfig_add=None,
 						arch='um',
 						cross_compile=None,
 						qemu_config_path=None,
 						extra_qemu_args=[])
 
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
+							qemu_config_path=None,
+							extra_qemu_args=[])
+
 	def test_run_kconfig_add(self):
 		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
 		# Just verify that we parsed and initialized it correctly here.
 		self.mock_linux_init.assert_called_once_with('.kunit',
-						kunitconfig_path=None,
+						kunitconfig_paths=None,
 						kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
 						arch='um',
 						cross_compile=None,
@@ -669,7 +711,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--arch=x86_64', '--qemu_args', '-m 2048'])
 		# Just verify that we parsed and initialized it correctly here.
 		self.mock_linux_init.assert_called_once_with('.kunit',
-						kunitconfig_path=None,
+						kunitconfig_paths=None,
 						kconfig_add=None,
 						arch='x86_64',
 						cross_compile=None,

base-commit: 1d202d1496a0be94100d8cbc2b658dcd980a3edf
-- 
2.37.0.rc0.161.g10f37bed90-goog

