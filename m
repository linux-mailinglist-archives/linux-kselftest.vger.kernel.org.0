Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB864492E30
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 20:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348679AbiARTJn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 14:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348646AbiARTJl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 14:09:41 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607AEC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:40 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id 81-20020a370454000000b00478f3a61beeso39384qke.18
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lD6lqWX8EnRHxX0zLj6k1wGPtoB3tiWy/CWZlAPTJDU=;
        b=an/AD+StigzlDSBcUsrKyiMtniDABtx3FjPV3LX+S/5cfZuxEjADmiINc5hsUJqS1j
         vFTjb4Ul52P09yJ6XxYKzttKNQ/Ib5uuHg4qFDgBDYNo86P9mOJoDPOczuLV4qWlS/cN
         8AwBpDQpXYBuR9DHbP0IUyr71FTya6jMiTjSlMTpVq0YP8uyPpVphvD53fCM4EJNPWvr
         applchaagucZGm05aYWFSks7whPkdUYXEkxL9gvpAPI1Iz4Jc52x6C3LMNniWqH/nOih
         PE9dXI5P/Lgx5sqNYkPQbUOobP11U+lBaR4ev71T4cEN0g2Cj5VyyBe21F2b/nbEO4CM
         Ombw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lD6lqWX8EnRHxX0zLj6k1wGPtoB3tiWy/CWZlAPTJDU=;
        b=b96aYQOyytB9OQrACk0bl17Zxw45iCtaEeOW3yAhik0ItKScYujdIOV7wLV9Qhx75I
         vIbT58PkiBg0fa//TOblTTiOToyxs/FHnR6w/kaR/n/PRshS+7arSfMFxb6xHpJfQdar
         +ZQTQSURLBfRvmTOrT3NVED7JCsVOUqxvw0KwtTnn8l1AIjX9Ydyp0ux4z/z+z82Vw5V
         83Y2IYP2CeuQbhjq+9MetRvaHBtpMCnvJURhU7U07/vl/0DTIkVIc2X186NIwHsTG/Bi
         NCZzZsgfx8cS+PzcOV0QLymJhKM6vvP5qq85/9bzYdtYX/QlKvcJt/U/sOyb8a/Q+s5S
         5G4A==
X-Gm-Message-State: AOAM530eIh2/YKRKFOcMG1cowAAt0GD/8ajXH6r0kOhv6coxoOm+79NS
        enh43byym7qfr1fWIlaWK/NEHSPGV6SECA==
X-Google-Smtp-Source: ABdhPJyIvRFzYjNHUfdXdKwTrT/HLKTC2twyg8uViC+rjfEei3/hOjHQj+ZJiX9u9n5Ps/sLbCQj8EpQA+WuJQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:ac8:5e4e:: with SMTP id
 i14mr21505830qtx.221.1642532979560; Tue, 18 Jan 2022 11:09:39 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:09:22 -0800
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
Message-Id: <20220118190922.1557074-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 5/5] kunit: tool: simplify code since build_dir can't be None
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--build_dir is set to a default of '.kunit' since commit ddbd60c779b4
("kunit: use --build_dir=.kunit as default"), but even before then it
was explicitly set to ''.

So outside of one unit test, there was no way for the build_dir to be
ever be None, and we can simplify code by fixing the unit test and
enforcing that via updated type annotations.

E.g. this lets us drop `get_file_path()` since it's now exactly
equivalent to os.path.join().

Note: there's some `if build_dir` checks that also fail if build_dir is
explicitly set to '' that just guard against passing "O=" to make.
But running `make O=` works just fine, so drop these checks.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_json.py      |  8 ++--
 tools/testing/kunit/kunit_kernel.py    | 51 ++++++++++----------------
 tools/testing/kunit/kunit_tool_test.py |  2 +-
 3 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 61091878f51e..24d103049bca 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -12,12 +12,11 @@ import os
 import kunit_parser
 
 from kunit_parser import Test, TestStatus
-from typing import Any, Dict, Optional
+from typing import Any, Dict
 
 JsonObj = Dict[str, Any]
 
-def _get_group_json(test: Test, def_config: str,
-		build_dir: Optional[str]) -> JsonObj:
+def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
@@ -50,8 +49,7 @@ def _get_group_json(test: Test, def_config: str,
 	}
 	return test_group
 
-def get_json_result(test: Test, def_config: str,
-		build_dir: Optional[str]) -> str:
+def get_json_result(test: Test, def_config: str, build_dir: str) -> str:
 	test_group = _get_group_json(test, def_config, build_dir)
 	test_group["name"] = "KUnit Test Group"
 	return json.dumps(test_group, indent=4)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 44bbe54f25f1..fe159e7ff697 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -28,11 +28,6 @@ OUTFILE_PATH = 'test.log'
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
 
-def get_file_path(build_dir, default):
-	if build_dir:
-		default = os.path.join(build_dir, default)
-	return default
-
 class ConfigError(Exception):
 	"""Represents an error trying to configure the Linux kernel."""
 
@@ -59,17 +54,15 @@ class LinuxSourceTreeOperations(object):
 	def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
 		pass
 
-	def make_allyesconfig(self, build_dir, make_options) -> None:
+	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		raise ConfigError('Only the "um" arch is supported for alltests')
 
-	def make_olddefconfig(self, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, 'olddefconfig']
+	def make_olddefconfig(self, build_dir: str, make_options) -> None:
+		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, 'olddefconfig']
 		if self._cross_compile:
 			command += ['CROSS_COMPILE=' + self._cross_compile]
 		if make_options:
 			command.extend(make_options)
-		if build_dir:
-			command += ['O=' + build_dir]
 		print('Populating config with:\n$', ' '.join(command))
 		try:
 			subprocess.check_output(command, stderr=subprocess.STDOUT)
@@ -78,14 +71,12 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make(self, jobs, build_dir, make_options) -> None:
-		command = ['make', 'ARCH=' + self._linux_arch, '--jobs=' + str(jobs)]
+	def make(self, jobs, build_dir: str, make_options) -> None:
+		command = ['make', 'ARCH=' + self._linux_arch, 'O=' + build_dir, '--jobs=' + str(jobs)]
 		if make_options:
 			command.extend(make_options)
 		if self._cross_compile:
 			command += ['CROSS_COMPILE=' + self._cross_compile]
-		if build_dir:
-			command += ['O=' + build_dir]
 		print('Building with:\n$', ' '.join(command))
 		try:
 			proc = subprocess.Popen(command,
@@ -143,14 +134,12 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def __init__(self, cross_compile=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
-	def make_allyesconfig(self, build_dir, make_options) -> None:
+	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
-		command = ['make', 'ARCH=um', 'allyesconfig']
+		command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
 		if make_options:
 			command.extend(make_options)
-		if build_dir:
-			command += ['O=' + build_dir]
 		process = subprocess.Popen(
 			command,
 			stdout=subprocess.DEVNULL,
@@ -167,24 +156,24 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
 		"""Runs the Linux UML binary. Must be named 'linux'."""
-		linux_bin = get_file_path(build_dir, 'linux')
+		linux_bin = os.path.join(build_dir, 'linux')
 		return subprocess.Popen([linux_bin] + params,
 					   stdin=subprocess.PIPE,
 					   stdout=subprocess.PIPE,
 					   stderr=subprocess.STDOUT,
 					   text=True, errors='backslashreplace')
 
-def get_kconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, KCONFIG_PATH)
+def get_kconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, KCONFIG_PATH)
 
-def get_kunitconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, KUNITCONFIG_PATH)
+def get_kunitconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, KUNITCONFIG_PATH)
 
-def get_old_kunitconfig_path(build_dir) -> str:
-	return get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+def get_old_kunitconfig_path(build_dir: str) -> str:
+	return os.path.join(build_dir, OLD_KUNITCONFIG_PATH)
 
-def get_outfile_path(build_dir) -> str:
-	return get_file_path(build_dir, OUTFILE_PATH)
+def get_outfile_path(build_dir: str) -> str:
+	return os.path.join(build_dir, OUTFILE_PATH)
 
 def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceTreeOperations:
 	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
@@ -268,7 +257,7 @@ class LinuxSourceTree(object):
 			return False
 		return True
 
-	def validate_config(self, build_dir) -> bool:
+	def validate_config(self, build_dir: str) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
 		if self._kconfig.is_subset_of(validated_kconfig):
@@ -283,7 +272,7 @@ class LinuxSourceTree(object):
 		logging.error(message)
 		return False
 
-	def build_config(self, build_dir, make_options) -> bool:
+	def build_config(self, build_dir: str, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
@@ -311,7 +300,7 @@ class LinuxSourceTree(object):
 		old_kconfig = kunit_config.parse_file(old_path)
 		return old_kconfig.entries() != self._kconfig.entries()
 
-	def build_reconfig(self, build_dir, make_options) -> bool:
+	def build_reconfig(self, build_dir: str, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
 		if not os.path.exists(kconfig_path):
@@ -326,7 +315,7 @@ class LinuxSourceTree(object):
 		os.remove(kconfig_path)
 		return self.build_config(build_dir, make_options)
 
-	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
+	def build_kernel(self, alltests, jobs, build_dir: str, make_options) -> bool:
 		try:
 			if alltests:
 				self._ops.make_allyesconfig(build_dir, make_options)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index f7cbc248a405..a3c036a620b2 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -469,7 +469,7 @@ class KUnitJsonTest(unittest.TestCase):
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
 				def_config='kunit_defconfig',
-				build_dir=None)
+				build_dir='.kunit')
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
-- 
2.34.1.703.g22d0c6ccf7-goog

