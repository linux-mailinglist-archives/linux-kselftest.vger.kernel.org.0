Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A241E52DA7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiESQpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiESQpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 12:45:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A719D02B1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 09:45:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso49714937b3.17
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=woTIQNp3VVCAmMSfZpcCzbgUuIqGGWkLmwVGiHGfpu4=;
        b=DMqucyj//pys3IaXeuqDaKt0zor8BFsoecsnxDiO3rb1z13H1ftt26oguqp12CVRu9
         giGMSkkmwXRQZss+YF+HeyzgfzxHJ5+G4O9pVKYJ/HDv2jkSdwdz5WTDB15zCSszAKZj
         Ba8UThJQyGUYlrkoc/DT5yU7gXe0a6a4GWPmWyX5jel+XmwnGqLbiDyzbAVBy/Ild3gf
         GKTYLNzsP1a43pyxEd3lzp7uZ4oFC6L9/LLfVizqP8tTpZ1Uf8WmG1v9yYTgbPba6MIl
         GHbWOpNCHPrqC5iTAXRkuKZsqsTzmhIvte+52M2kMTmqpuCCc/lmIUQ8r9c52L/9tYn4
         M8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=woTIQNp3VVCAmMSfZpcCzbgUuIqGGWkLmwVGiHGfpu4=;
        b=XCTbhaF8qRC0PSu2h1LHAAXBONrvhf7TAwuImKZRs551jiLUCjPqw07MViMudX+MjP
         TG3dT3cSWUqVwjM+wYgC5cQoh2gwGJfxj3JyZWJEmyyAlelGfnKaw8P5vkZkkh2ZVsJb
         wEb+X3BkuId+20kUchgram1W1bskOWcQJZ4N/K+84b84UBhN9AbcLShKggaAmMRZ8ci3
         jAJ3q88SZXkOa1FpSg+JpYjW5F1a5mHzqRzHaVex1tSAcnOgS4/Zit568py6aJw1XIVz
         To8aR+fjFR0PcAE4ydTAD7TX8TvT90C2fL+ActNAhuVqZz986Fl++dkhe/HyKXlgIPiD
         qSfg==
X-Gm-Message-State: AOAM531bBY8SHQO62M/h3XuvJmLC98F9d+vMKVVjNwxclfOAl1sdx5MT
        hrpM25BD4htt38nyni45Bx25p5G/LqY0Gg==
X-Google-Smtp-Source: ABdhPJwaTwWh9gjjFOcqiGhCrZWqfTGy605+TgFBZja7dXsi1cgZWfAKtMNHrfByb4+mjZiclTX1WJxbgNmabw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:80bd:389b:ae48:fbf7])
 (user=dlatypov job=sendgmr) by 2002:a25:7804:0:b0:64b:332e:cd7b with SMTP id
 t4-20020a257804000000b0064b332ecd7bmr5623040ybc.323.1652978717280; Thu, 19
 May 2022 09:45:17 -0700 (PDT)
Date:   Thu, 19 May 2022 09:45:12 -0700
Message-Id: <20220519164512.3180360-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] kunit: tool: refactor internal kconfig handling, allow overriding
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

Currently, you cannot ovewrwrite what's in your kunitconfig via
--kconfig_add.
Nor can you override something in a qemu_config via either means.

This patch makes it so we have this level of priority
* --kconfig_add
* kunitconfig file (the default or the one from --kunitconfig)
* qemu_config

The rationale for this order is that the more "dynamic" sources of
kconfig options should take priority.

--kconfig_add is obviously the most dynamic.
And for kunitconfig, users probably tweak the file manually or specify
--kunitconfig more often than they delve into qemu_config python files.

And internally, we convert the kconfigs from a python list into a set or
dict fairly often. We should just use a dict internally.
We exposed the set transform in the past since we didn't define __eq__,
so also take the chance to shore up the kunit_kconfig.Kconfig interface.

Example
=======

Let's consider the unrealistic example where someone would want to
disable CONFIG_KUNIT.
I.e. they run
$ ./tools/testing/kunit/kunit.py config --kconfig_add=CONFIG_KUNIT=n

Before
------
We'd write the following
> # CONFIG_KUNIT is not set
> CONFIG_KUNIT_ALL_TESTS=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=y

And we'd error out with
> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: # CONFIG_KUNIT is not set

After
-----
We'd write the following
> # CONFIG_KUNIT is not set
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_ALL_TESTS=y
> CONFIG_KUNIT_EXAMPLE_TEST=y

And we'd error out with
> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: CONFIG_KUNIT_EXAMPLE_TEST=y, CONFIG_KUNIT_TEST=y, CONFIG_KUNIT_ALL_TESTS=y

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_config.py    | 49 +++++++++++++++-----------
 tools/testing/kunit/kunit_kernel.py    | 21 ++++++-----
 tools/testing/kunit/kunit_tool_test.py | 45 ++++++++++-------------
 3 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 75a8dc1683d4..89443400b17e 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import List, Set
+from typing import Dict, Iterable, Set
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -32,35 +32,46 @@ class Kconfig:
 	"""Represents defconfig or .config specified using the Kconfig language."""
 
 	def __init__(self) -> None:
-		self._entries = []  # type: List[KconfigEntry]
+		self._entries = {}  # type: Dict[str, str]
 
-	def entries(self) -> Set[KconfigEntry]:
-		return set(self._entries)
+	def __eq__(self, other) -> bool:
+		if not isinstance(other, self.__class__):
+			return False
+		return self._entries == other._entries
 
-	def add_entry(self, entry: KconfigEntry) -> None:
-		self._entries.append(entry)
+	def __repr__(self) -> str:
+		return ','.join(str(e) for e in self._as_entries())
+
+
+	def _as_entries(self) -> Iterable[KconfigEntry]:
+		for name, value in self._entries.items():
+			yield KconfigEntry(name, value)
+
+	def add_entry(self, name: str, value: str) -> None:
+		self._entries[name] = value
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
-		other_dict = {e.name: e.value for e in other.entries()}
-		for a in self.entries():
-			b = other_dict.get(a.name)
+		for name, value in self._entries.items():
+			b = other._entries.get(name)
 			if b is None:
-				if a.value == 'n':
+				if value == 'n':
 					continue
 				return False
-			if a.value != b:
+			if value != b:
 				return False
 		return True
 
+	def set_diff(self, other: 'Kconfig') -> Set[KconfigEntry]:
+		return set(self._as_entries()) - set(other._as_entries())
+
 	def merge_in_entries(self, other: 'Kconfig') -> None:
-		if other.is_subset_of(self):
-			return
-		self._entries = list(self.entries().union(other.entries()))
+		for name, value in other._entries.items():
+			self._entries[name] = value
 
 	def write_to_file(self, path: str) -> None:
 		with open(path, 'a+') as f:
-			for entry in self.entries():
-				f.write(str(entry) + '\n')
+			for e in self._as_entries():
+				f.write(str(e) + '\n')
 
 def parse_file(path: str) -> Kconfig:
 	with open(path, 'r') as f:
@@ -78,14 +89,12 @@ def parse_from_string(blob: str) -> Kconfig:
 
 		match = config_matcher.match(line)
 		if match:
-			entry = KconfigEntry(match.group(1), match.group(2))
-			kconfig.add_entry(entry)
+			kconfig.add_entry(match.group(1), match.group(2))
 			continue
 
 		empty_match = is_not_set_matcher.match(line)
 		if empty_match:
-			entry = KconfigEntry(empty_match.group(1), 'n')
-			kconfig.add_entry(entry)
+			kconfig.add_entry(empty_match.group(1), 'n')
 			continue
 
 		if line[0] == '#':
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3539efaf99ba..ebd2d91af710 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -53,8 +53,8 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
-		pass
+	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+		return base_kunitconfig
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		raise ConfigError('Only the "um" arch is supported for alltests')
@@ -109,9 +109,10 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
+	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		kconfig = kunit_config.parse_from_string(self._kconfig)
-		base_kunitconfig.merge_in_entries(kconfig)
+		kconfig.merge_in_entries(base_kunitconfig)
+		return kconfig
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		kernel_path = os.path.join(build_dir, self._kernel_path)
@@ -265,9 +266,10 @@ class LinuxSourceTree:
 	def validate_config(self, build_dir: str) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
-		if self._kconfig.is_subset_of(validated_kconfig):
+		invalid = self._kconfig.set_diff(validated_kconfig)
+		if not invalid:
 			return True
-		invalid = self._kconfig.entries() - validated_kconfig.entries()
+
 		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
 			  'This is probably due to unsatisfied dependencies.\n' \
 			  'Missing: ' + ', '.join([str(e) for e in invalid])
@@ -282,7 +284,7 @@ class LinuxSourceTree:
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		try:
-			self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -303,7 +305,7 @@ class LinuxSourceTree:
 			return True
 
 		old_kconfig = kunit_config.parse_file(old_path)
-		return old_kconfig.entries() != self._kconfig.entries()
+		return old_kconfig != self._kconfig
 
 	def build_reconfig(self, build_dir: str, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
@@ -313,7 +315,8 @@ class LinuxSourceTree:
 			return self.build_config(build_dir, make_options)
 
 		existing_kconfig = kunit_config.parse_file(kconfig_path)
-		self._ops.make_arch_qemuconfig(self._kconfig)
+		self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
+
 		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
 			return True
 		print('Regenerating .config ...')
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 25a2eb3bf114..3a8f638ff092 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -45,7 +45,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertTrue(kconfig0.is_subset_of(kconfig0))
 
 		kconfig1 = kunit_config.Kconfig()
-		kconfig1.add_entry(kunit_config.KconfigEntry('TEST', 'y'))
+		kconfig1.add_entry('TEST', 'y')
 		self.assertTrue(kconfig1.is_subset_of(kconfig1))
 		self.assertTrue(kconfig0.is_subset_of(kconfig1))
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
@@ -56,40 +56,28 @@ class KconfigTest(unittest.TestCase):
 		kconfig = kunit_config.parse_file(kconfig_path)
 
 		expected_kconfig = kunit_config.Kconfig()
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('UML', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MMU', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MK8', 'n'))
-
-		self.assertEqual(kconfig.entries(), expected_kconfig.entries())
+		expected_kconfig.add_entry('UML', 'y')
+		expected_kconfig.add_entry('MMU', 'y')
+		expected_kconfig.add_entry('TEST', 'y')
+		expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
+		expected_kconfig.add_entry('MK8', 'n')
+
+		self.assertEqual(kconfig, expected_kconfig)
 
 	def test_write_to_file(self):
 		kconfig_path = os.path.join(test_tmpdir, '.config')
 
 		expected_kconfig = kunit_config.Kconfig()
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('UML', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MMU', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('EXAMPLE_TEST', 'y'))
-		expected_kconfig.add_entry(
-			kunit_config.KconfigEntry('MK8', 'n'))
+		expected_kconfig.add_entry('UML', 'y')
+		expected_kconfig.add_entry('MMU', 'y')
+		expected_kconfig.add_entry('TEST', 'y')
+		expected_kconfig.add_entry('EXAMPLE_TEST', 'y')
+		expected_kconfig.add_entry('MK8', 'n')
 
 		expected_kconfig.write_to_file(kconfig_path)
 
 		actual_kconfig = kunit_config.parse_file(kconfig_path)
-
-		self.assertEqual(actual_kconfig.entries(),
-				 expected_kconfig.entries())
+		self.assertEqual(actual_kconfig, expected_kconfig)
 
 class KUnitParserTest(unittest.TestCase):
 
@@ -381,8 +369,11 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
 	def test_kconfig_add(self):
+		want_kconfig = kunit_config.Kconfig()
+		want_kconfig.add_entry('NOT_REAL', 'y')
+
 		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
-		self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
+		self.assertFalse(want_kconfig.set_diff(tree._kconfig))
 
 	def test_invalid_arch(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):

base-commit: 1b11063d32d7e11366e48be64215ff517ce32217
-- 
2.36.1.124.g0e6072fb45-goog

