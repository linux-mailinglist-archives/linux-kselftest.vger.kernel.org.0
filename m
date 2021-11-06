Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48347446BC9
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 02:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKFBeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhKFBeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 21:34:00 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3217DC061570
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 18:31:16 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z188-20020a6265c5000000b004946b8e3cedso3897360pfb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SfViBjJ9JYa7cYjYsOedNbA1OKNONbdViyuLjraKQhM=;
        b=MOoXWktKf6qNktRDrFSRjhGeYhJiddc63WTvVmfbUVphjkvAK++FkU0JbNkqRGR/Lf
         OGaN58TS8UB2QZsY7hlJdYiZPxnV3p3QRfd73DeUQdhboWdWjsme8r9q38r4AyvF5L5i
         lSEfK0rVMg1BuXy3kjBc/orZIcDs0LQNQCIYMXUyrTxg7f1Vf1ipuAxKtILpx9k5EDi6
         ozS4ZWSJPZvr3dzwh7I2d/NnT+NiJ2OPV5kycIYaiFCSP6omKzd4/vpfPwmFFiUqsqH1
         +hn8BoRJa/mIwc/pPWra4reMJXt0NDAvbYPCMnIp5j1rUXFkgMA4X9JBD3Ie+L8nJno+
         n7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SfViBjJ9JYa7cYjYsOedNbA1OKNONbdViyuLjraKQhM=;
        b=L5FRdLCqlkPN/ZTxtGsfQgTzYIPjERsd3eX/dLl5bdcaE/XXq5c5YwuUIB/NUkg5Vd
         R6K23Ac21bOZ26xGr07q3FBjQb9yCLWSrlY6Ab9LFJcnACMumv9UlauImGEctDIClvbG
         Pb4BlNin4LCC5AOVxonpuBua8bm63SDBJ2zUbG0pngiudI2tznvFuIjgAfNDbqxZGph7
         +og24EOPYOgC8u9u08St3PupzOXZat1WyGyNC4tJamrh+ApPmFItZvK1IgTnP0Mp07m8
         t/Wz5UqFpCd470diQsHVVA7UIJijNykUJ91GQY1wnKDEvkFLPVdouH2vQ8LyhtSObEaj
         X5Cg==
X-Gm-Message-State: AOAM53259+Zqyy4/OmJiwqBMwwQXsr/MI5bwVb2rcNGEEKDtnfdF55Y3
        S+X4nfoTghlVgZdYJJbmPKrWCZP8R6RWyQ==
X-Google-Smtp-Source: ABdhPJwdJFI2tMvJuyT4RS1rWrkh3idkQesRSVjtzHXDMV4OnHJoEHpkobbZXeDEtx8Yh7E3SESYYetfd9HqNw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:6353:c04e:9de:d603])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:c3:: with SMTP id
 v3mr275100pjd.0.1636162275887; Fri, 05 Nov 2021 18:31:15 -0700 (PDT)
Date:   Fri,  5 Nov 2021 18:30:57 -0700
Message-Id: <20211106013058.2621799-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 1/2] kunit: tool: move Kconfig read_from_file/parse_from_string
 to package-level
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

read_from_file() clears its `self` Kconfig object and parses a config
file.

It is a way to construct Kconfig objects more so than an operation on
Kconfig objects. This is reflected in the fact its only ever used as:
  kconfig = kunit_config.Kconfig()
  kconfig.read_from_file(path)

So clean this up and simplify callers by replacing it with
  kconfig = kunit_config.parse_file(path)

Do the same thing for the related parse_from_string() function as well.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_config.py    | 61 +++++++++++++-------------
 tools/testing/kunit/kunit_kernel.py    | 12 ++---
 tools/testing/kunit/kunit_tool_test.py |  6 +--
 3 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index c77c7d2ef622..677354546156 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -62,33 +62,34 @@ class Kconfig(object):
 			for entry in self.entries():
 				f.write(str(entry) + '\n')
 
-	def parse_from_string(self, blob: str) -> None:
-		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
-		self._entries = []
-		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
-		config_matcher = re.compile(CONFIG_PATTERN)
-		for line in blob.split('\n'):
-			line = line.strip()
-			if not line:
-				continue
-
-			match = config_matcher.match(line)
-			if match:
-				entry = KconfigEntry(match.group(1), match.group(2))
-				self.add_entry(entry)
-				continue
-
-			empty_match = is_not_set_matcher.match(line)
-			if empty_match:
-				entry = KconfigEntry(empty_match.group(1), 'n')
-				self.add_entry(entry)
-				continue
-
-			if line[0] == '#':
-				continue
-			else:
-				raise KconfigParseError('Failed to parse: ' + line)
-
-	def read_from_file(self, path: str) -> None:
-		with open(path, 'r') as f:
-			self.parse_from_string(f.read())
+def parse_file(path: str) -> Kconfig:
+	with open(path, 'r') as f:
+		return parse_from_string(f.read())
+
+def parse_from_string(blob: str) -> Kconfig:
+	"""Parses a string containing Kconfig entries."""
+	kconfig = Kconfig()
+	is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
+	config_matcher = re.compile(CONFIG_PATTERN)
+	for line in blob.split('\n'):
+		line = line.strip()
+		if not line:
+			continue
+
+		match = config_matcher.match(line)
+		if match:
+			entry = KconfigEntry(match.group(1), match.group(2))
+			kconfig.add_entry(entry)
+			continue
+
+		empty_match = is_not_set_matcher.match(line)
+		if empty_match:
+			entry = KconfigEntry(empty_match.group(1), 'n')
+			kconfig.add_entry(entry)
+			continue
+
+		if line[0] == '#':
+			continue
+		else:
+			raise KconfigParseError('Failed to parse: ' + line)
+	return kconfig
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 66095568bf32..51ee6e5dae91 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -116,8 +116,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
 	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
-		kconfig = kunit_config.Kconfig()
-		kconfig.parse_from_string(self._kconfig)
+		kconfig = kunit_config.parse_from_string(self._kconfig)
 		base_kunitconfig.merge_in_entries(kconfig)
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
@@ -249,8 +248,7 @@ class LinuxSourceTree(object):
 			if not os.path.exists(kunitconfig_path):
 				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
 
-		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
+		self._kconfig = kunit_config.parse_file(kunitconfig_path)
 
 	def clean(self) -> bool:
 		try:
@@ -262,8 +260,7 @@ class LinuxSourceTree(object):
 
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
+		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if not self._kconfig.is_subset_of(validated_kconfig):
 			invalid = self._kconfig.entries() - validated_kconfig.entries()
 			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
@@ -291,8 +288,7 @@ class LinuxSourceTree(object):
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if os.path.exists(kconfig_path):
-			existing_kconfig = kunit_config.Kconfig()
-			existing_kconfig.read_from_file(kconfig_path)
+			existing_kconfig = kunit_config.parse_file(kconfig_path)
 			self._ops.make_arch_qemuconfig(self._kconfig)
 			if not self._kconfig.is_subset_of(existing_kconfig):
 				print('Regenerating .config ...')
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9c4126731457..4ec70e41ec5a 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -50,10 +50,9 @@ class KconfigTest(unittest.TestCase):
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
 
 	def test_read_from_file(self):
-		kconfig = kunit_config.Kconfig()
 		kconfig_path = test_data_path('test_read_from_file.kconfig')
 
-		kconfig.read_from_file(kconfig_path)
+		kconfig = kunit_config.parse_file(kconfig_path)
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
@@ -86,8 +85,7 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig.write_to_file(kconfig_path)
 
-		actual_kconfig = kunit_config.Kconfig()
-		actual_kconfig.read_from_file(kconfig_path)
+		actual_kconfig = kunit_config.parse_file(kconfig_path)
 
 		self.assertEqual(actual_kconfig.entries(),
 				 expected_kconfig.entries())

base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
-- 
2.34.0.rc0.344.g81b53c2807-goog

