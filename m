Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28A55D56B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiF0WO7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 18:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiF0WO4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 18:14:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A236158
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 15:14:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h13-20020a63e14d000000b0040df75eaa2eso2060045pgk.21
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tpbMLj90Q5ZZyV7bAnYok0p0SPzRes9kgVh6ocDsDPE=;
        b=JPmf0L12/7N7ahfNXCXTrk9Gd//dHUi7MDMJs3NR337watOhxy52oo3OTxnoZVwBme
         nNMWxDszh0z5v2SNA47OWQgqLLGkW2qkpkfyeefC4aabx6t54aXOuOXkEf7XjUuzkeAc
         CY+Hyaserw/vigQCC7Rzkms8WbevU+ZEnorMZbpLYmRbFBMGOZZi2Fkr2REcTB257B9H
         /2M0SVqnbK8XdHzDzu8rjvNxrMZRGNu4yDXGiDx8Lu4UIjSeXmjA4JHRfAG8TjGvao8R
         pI/A1P0TZW3+THwG9Tj1lf1Sg71u6hy95Ba0Hz/YEK4v+ZAcag/ybSZI/sIr6kFB4zZ/
         11aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tpbMLj90Q5ZZyV7bAnYok0p0SPzRes9kgVh6ocDsDPE=;
        b=cpKMF6QP3aiIEwHmU69AFjounn4RsF7EbAXkTFR9iPUpyvwM2jwQ6qhRkhTYhBZT/P
         dsOnBtr9JJk8zQo15TrPIgOc/xUO69H/3x1BKH3yZpwql19wyb7lHTGghBMHmS5qzXw6
         LcW6lMfHmP3BOAiFzkvwTp6Kl9LZJg8lZDsB/OXIeLiBiSIOpZytOtcAFS3C/nIZ3Njl
         yUJuQh56eNGu+lTfm4uvl22lxrAKHG2OGlMPQxTxsA3rEwy5LXt10Le/3Qxpa9b+/uUw
         R4CpiivlMVv/UzX9wIBkQKB5CFzsOF4kHj/js6xLECrw8LXt8LKQOj1ut/bTdc42+IJU
         3A+A==
X-Gm-Message-State: AJIora8EWJeO7Bp0RjREuH81hmXnXYiVSk1hxgqz9R9sTGGX5ig/G2MJ
        t70ctukRH+9m2piOwJ1dz/jurrvVvXOVlg==
X-Google-Smtp-Source: AGRyM1tLwLtAKfruj8QWEVxGwQLaxFwbNY3dEcAT1EOmq5HkH668rKgSNZZUFSnEinO9PpnHCqqbgj7psExtvA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a62:aa10:0:b0:525:22bb:b028 with SMTP id
 e16-20020a62aa10000000b0052522bbb028mr186430pff.21.1656368094689; Mon, 27 Jun
 2022 15:14:54 -0700 (PDT)
Date:   Mon, 27 Jun 2022 22:14:44 +0000
Message-Id: <20220627221446.82157-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 1/3] kunit: tool: refactor internal kconfig handling, allow overriding
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: fix validate_config() func.
There was a bug found by David, see
https://lore.kernel.org/linux-kselftest/CAGS_qxpF338dvbB+6QW1n8_agddeS10+nkTQNmT+0UcvoE1gBw@mail.gmail.com/
v2 -> v3: remove `set_diff()` helper, merge into other kunitconfig
series
---
 tools/testing/kunit/kunit_config.py    | 45 ++++++++++++++------------
 tools/testing/kunit/kunit_kernel.py    | 20 ++++++------
 tools/testing/kunit/kunit_tool_test.py | 45 +++++++++++---------------
 3 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 75a8dc1683d4..898b2a35eb29 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -8,7 +8,7 @@
 
 from dataclasses import dataclass
 import re
-from typing import List, Set
+from typing import Dict, Iterable, Set
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
@@ -32,35 +32,42 @@ class Kconfig:
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
+		return ','.join(str(e) for e in self.as_entries())
+
+	def as_entries(self) -> Iterable[KconfigEntry]:
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
+			for e in self.as_entries():
+				f.write(str(e) + '\n')
 
 def parse_file(path: str) -> Kconfig:
 	with open(path, 'r') as f:
@@ -78,14 +85,12 @@ def parse_from_string(blob: str) -> Kconfig:
 
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
index 3539efaf99ba..4115781185e1 100644
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
@@ -267,10 +268,10 @@ class LinuxSourceTree:
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if self._kconfig.is_subset_of(validated_kconfig):
 			return True
-		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		missing = set(self._kconfig.as_entries()) - set(validated_kconfig.as_entries())
 		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
 			  'This is probably due to unsatisfied dependencies.\n' \
-			  'Missing: ' + ', '.join([str(e) for e in invalid])
+			  'Missing: ' + ', '.join(str(e) for e in missing)
 		if self._arch == 'um':
 			message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
 				   'on a different architecture with something like "--arch=x86_64".'
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
index 25a2eb3bf114..0fbca18b6e65 100755
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
+		self.assertTrue(want_kconfig.is_subset_of(tree._kconfig), msg=tree._kconfig)
 
 	def test_invalid_arch(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):

base-commit: 274295c6e53f8b8b8dfa8b24a3fcb8a9d670c22c
-- 
2.37.0.rc0.161.g10f37bed90-goog

