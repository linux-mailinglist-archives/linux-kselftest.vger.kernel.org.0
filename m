Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4957852F5C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 00:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbiETWmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiETWmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 18:42:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B21966AF
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:42:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o7-20020a256b47000000b0064ddc3bea70so8288189ybm.4
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=otM6CQL2bDJ5cO5Ez8z2N6+rNYCbBMcYNZ3dWKO8T5c=;
        b=bGQsMLurMXKU2h1vF6pjWf/lxg7fxX16V1oVyqfKi91/tVd/hukI9FhEJJE4aRrqIl
         eq8Ms0wik7siz99OHYju4sTr9BLZWCCwlcpN/A+kmGKwHfSWkxUnzSghAIwOtMuBojVr
         83H/jVTJ7+/CgGV9KhC7EdBt4Y/EFRRleAWNN0WHtk1rrDFNO9j1FZkiTVcNZnQ5SaMz
         DVKdcA+RhNYh8yPX08+G9iTwQc1VPrErqVe3ki3BuOxPKkPM0lozYobBOV+TaEYCzFqa
         HuVV4JFk636BE29zk6mZCyRZyYWKAn9yoCe9t4YNzwtHZ3PZc7ZccyRrbQ9G+gc0M7+V
         naSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=otM6CQL2bDJ5cO5Ez8z2N6+rNYCbBMcYNZ3dWKO8T5c=;
        b=pkH8vAXqcNYJF2ti+YiT0BiYH+3jsow9UlHEuxoOFRex5yDkoYTelgqimoz1jaK1W+
         VQCHhWFvTwpcJ6kV9KJdoZ5Ze8y9BcrFJ/Z1O9dJl3fCFp0ZDGHzx7CMp2wLPeKh7Hhg
         eoLb3pp+39LJCuBimg7SdlipnA2457fqBakuB7gm8uJ4PV7PprZHjCHNSP6iRYecj0aq
         GkXi5WHMBiuiFjksf8k4jXhKLec2EnXbTOOF/GSc7/xguyJaXBUUfVXweJkMwtsfbduZ
         Z5i0NHmIJnZoXKhmZsEVSe1GZn0TeMbYiti9q876MlEKH6FyPAZP21LV+bOdYr48Wyhj
         5JJA==
X-Gm-Message-State: AOAM530DiTyygfEAlNVikKRtbt3GeoGVI0BfZU53BsU5je57d1Q7u0Z3
        dKAMhidiS6cSxYJhoOmD06yhJ2GT8KaHBw==
X-Google-Smtp-Source: ABdhPJyKJz35S4mYnAIUgJaT5Sn0yTcbgymRLWIV+u6TJPUNAp9Rz+rtFMFL5xDxx99TN4TypmIZeuIAShuw3w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d2e4:a878:ad33:9e82])
 (user=dlatypov job=sendgmr) by 2002:a5b:a0d:0:b0:622:6203:ab21 with SMTP id
 k13-20020a5b0a0d000000b006226203ab21mr11216455ybq.502.1653086532044; Fri, 20
 May 2022 15:42:12 -0700 (PDT)
Date:   Fri, 20 May 2022 15:42:00 -0700
Message-Id: <20220520224200.3764027-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v2] kunit: tool: refactor internal kconfig handling, allow overriding
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
v1 -> v2: fix validate_config() func.
There was a bug found by David, see
https://lore.kernel.org/linux-kselftest/CAGS_qxpF338dvbB+6QW1n8_agddeS10+nkTQNmT+0UcvoE1gBw@mail.gmail.com/
---
 tools/testing/kunit/kunit_config.py    | 49 +++++++++++++++-----------
 tools/testing/kunit/kunit_kernel.py    | 18 +++++-----
 tools/testing/kunit/kunit_tool_test.py | 45 ++++++++++-------------
 3 files changed, 57 insertions(+), 55 deletions(-)

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
index 3539efaf99ba..6d994bb24999 100644
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
@@ -267,7 +268,7 @@ class LinuxSourceTree:
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if self._kconfig.is_subset_of(validated_kconfig):
 			return True
-		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		invalid = self._kconfig.set_diff(validated_kconfig)
 		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
 			  'This is probably due to unsatisfied dependencies.\n' \
 			  'Missing: ' + ', '.join([str(e) for e in invalid])
@@ -282,7 +283,7 @@ class LinuxSourceTree:
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		try:
-			self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -303,7 +304,7 @@ class LinuxSourceTree:
 			return True
 
 		old_kconfig = kunit_config.parse_file(old_path)
-		return old_kconfig.entries() != self._kconfig.entries()
+		return old_kconfig != self._kconfig
 
 	def build_reconfig(self, build_dir: str, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
@@ -313,7 +314,8 @@ class LinuxSourceTree:
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

