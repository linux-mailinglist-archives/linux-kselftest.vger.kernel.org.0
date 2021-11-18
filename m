Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC87456314
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 20:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhKRTGg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhKRTGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 14:06:35 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576BC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 11:03:35 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s22-20020a056a0008d600b00480fea2e96cso4195482pfu.7
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HbbnT4g8uYXIZ4nFA7Y+X8aSEdLIcDyoD9XMwtQbx1Y=;
        b=fiLii7/mlsjqDi+U5IhIH5ww75jnDR7U36Nl3na2PjrYgnrUU/u7BbXxbzFkWlv5UW
         CkVw7JSRYSr2XsT/3ektJIPSnsc1Bq8uoS+VDrrWWH/9Gz1ZdODjmMAeET5gOQBRL2mm
         Ao6KoZj/CYRoLRA29CldVMS4ySGHVr4uGIDyDXQqtJX//C2Insn3nooIRJ6CsMMxfx1w
         GhCDlHK7qqz2sxKQoa4ifFXCg4if/ZPJs+E/q79WIqx+zEAn/fQ6PrOcIwG9Q67SzszD
         Ki01XWPPeQimrjSp4J4vbK7t9XWqQ+hdOhac3ytkF0wVCq3GO7WxWloNQzyzrHFsnsqr
         E8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HbbnT4g8uYXIZ4nFA7Y+X8aSEdLIcDyoD9XMwtQbx1Y=;
        b=xB16a68rggIAC9vjhFvc/QWNgydHF0QTbU5PJxPkhrS80DRazGi08GVRgx6bS6iAhH
         j3I7kbjtQXn+qNggJWayHfrj5abKCwBDPhJLVxWPIQAfmAPX/fiK05ydVl8TBt8AiO48
         cZFejVtcT5QwzNW0vHjarnkSyupHSD+ONBRu+v5l8q99vo7p810CYec6K682fJIh6CcI
         Zgqak3pAIaBiDp54jRhFNBzc0f5wxOhJw+mdwdjVMua2XkxYKPy3JRLYb5T4JfcdBbx3
         evn9LUc2XF4NJmRWzkAdRbB8EivKFdcU3APFx5mpchprCedmKOh0ANPQgpOamuJCHThU
         JcVA==
X-Gm-Message-State: AOAM531iMN3wdOAxUFCVoykpSzx8N4s6/zoKhSo9WKB5AbWUyEFMqTMM
        z2lbMbI6uk+T3oSesofRKrj1sF1RPnctWA==
X-Google-Smtp-Source: ABdhPJzFkgFOA9pRhwhquQr18CIg/N87lwp4HnotuWd+w1xAo93fsID55xxbHcJjm9EGpCv9FXuq/HV+jp44VQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:b453:daa7:1a43:6c62])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:3a89:: with SMTP id
 om9mr13123321pjb.99.1637262214821; Thu, 18 Nov 2021 11:03:34 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:03:29 -0800
Message-Id: <20211118190329.1925388-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] kunit: tool: reconfigure when the used kunitconfig changes
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Problem: currently, if you remove something from your kunitconfig,
kunit.py will not regenerate the .config file.
The same thing happens if you did --kunitconfig_add=CONFIG_KASAN=y [1]
and then ran again without it. Your new run will still have KASAN.

The reason is that kunit.py won't regenerate the .config file if it's a
superset of the kunitconfig. This speeds it up a bit for iterating.

This patch adds an additional check that forces kunit.py to regenerate
the .config file if the current kunitconfig doesn't match the previous
one.

What this means:
* deleting entries from .kunitconfig works as one would expect
* dropping  a --kunitconfig_add also triggers a rebuild
* you can still edit .config directly to turn on new options

We implement this by creating a `last_used_kunitconfig` file in the
build directory (so .kunit, by default) after we generate the .config.
When comparing the kconfigs, we compare python sets, so duplicates and
permutations don't trip us up.

The majority of this patch is adding unit tests for the existing logic
and for the new case where `last_used_kunitconfig` differs.

[1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/start.rst |  8 ++---
 tools/testing/kunit/kunit_kernel.py     | 36 ++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py  | 43 +++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..0a5e65540974 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -50,10 +50,10 @@ It'll warn you if you haven't included the dependencies of the options you're
 using.
 
 .. note::
-   Note that removing something from the ``.kunitconfig`` will not trigger a
-   rebuild of the ``.config`` file: the configuration is only updated if the
-   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
-   other tools (such as make menuconfig) to adjust other config options.
+   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
+   ``.config`` file. But you can edit the ``.config`` file directly or with
+   tools like ``make menuconfig O=.kunit``. As long as its a superset of
+   ``.kunitconfig``, kunit.py won't overwrite your changes.
 
 
 Running the tests (KUnit Wrapper)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 350883672be0..8a6e0ee88f3d 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -21,6 +21,7 @@ import qemu_config
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
+OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
@@ -289,24 +290,37 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		return self.validate_config(build_dir)
+		if not self.validate_config(build_dir):
+			return False
+
+		old_path = get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+		os.remove(old_path)  # write_to_file appends to the file
+		self._kconfig.write_to_file(old_path)
+		return True
+
+	def _kconfig_changed(self, build_dir: str) -> bool:
+		old_path = get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+		if not os.path.exists(old_path):
+			return False
+
+		old_kconfig = kunit_config.parse_file(old_path)
+		return old_kconfig.entries() != self._kconfig.entries()
 
 	def build_reconfig(self, build_dir, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
-		if os.path.exists(kconfig_path):
-			existing_kconfig = kunit_config.parse_file(kconfig_path)
-			self._ops.make_arch_qemuconfig(self._kconfig)
-			if not self._kconfig.is_subset_of(existing_kconfig):
-				print('Regenerating .config ...')
-				os.remove(kconfig_path)
-				return self.build_config(build_dir, make_options)
-			else:
-				return True
-		else:
+		if not os.path.exists(kconfig_path):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
+		existing_kconfig = kunit_config.parse_file(kconfig_path)
+		self._ops.make_arch_qemuconfig(self._kconfig)
+		if self._kconfig.is_subset_of(existing_kconfig) and not self._kconfig_changed(build_dir):
+			return True
+		print('Regenerating .config ...')
+		os.remove(kconfig_path)
+		return self.build_config(build_dir, make_options)
+
 	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 7e42a7c27987..8cd8d53e3d24 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -358,6 +358,49 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			with open(kunit_kernel.get_outfile_path(build_dir), 'rt') as outfile:
 				self.assertEqual(outfile.read(), 'hi\nbye\n', msg='Missing some output')
 
+	def test_build_reconfig_no_config(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			# Should generate the .config
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			mock_build_config.assert_called_once_with(build_dir, [])
+
+	def test_build_reconfig_existing_config(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			# Existing .config is a superset, should not touch it
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(kunit_kernel.get_kconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			self.assertEqual(mock_build_config.call_count, 0)
+
+	def test_build_reconfig_remove_option(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			# We removed CONFIG_KUNIT_TEST=y from our .kunitconfig...
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(kunit_kernel.get_file_path(build_dir, kunit_kernel.OLD_KUNITCONFIG_PATH), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+			with open(kunit_kernel.get_kconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			# ... so we should trigger a call to build_config()
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			mock_build_config.assert_called_once_with(build_dir, [])
+
 	# TODO: add more test cases.
 
 

base-commit: 4770a2c00c390b88d33f24fb0b8b386535970ffc
-- 
2.34.0.rc2.393.gf8c9666880-goog

