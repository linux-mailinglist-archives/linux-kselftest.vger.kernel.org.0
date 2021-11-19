Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C1457984
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 00:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhKSX0X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 18:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhKSX0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 18:26:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A2C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:23:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v23-20020a170902bf9700b001421d86afc4so5319807pls.9
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dgIT26rqM0+t/RAfvkZ1o+37LktYOW23EMBKnQmSG58=;
        b=jWNQ/LjChxit5+0/a3FXFylmAJXpIprPxB34R7/DQVHkjfOky8KDVBl3h/vKfRKuaM
         dodqIs/jJL3xgQdQRbPWz1m0tE1Ao29J5FY9UipnALX0RQWE5eKCTgPs0u+UwLjxgfGK
         0tXpnYDTan6+1Mwm3yyaxDLlQf8mrzlBqqJdqKA2Q8T8yjivTB1O+oPsQSTHbp6ZFP1W
         MzdN9mdl2O0TN5hOBfJdFc1u+AWKqHlYp7q6YHLk6xXfhbFkbzJandIC5b50+IGvgnIE
         OAb8NMTTvPLch3acgBDgeYShs2oJMQuE8J4xEtX3u0E+/kquR7Y8SFhod4x8yU0Jk281
         ukHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dgIT26rqM0+t/RAfvkZ1o+37LktYOW23EMBKnQmSG58=;
        b=xDZ/yCMMfzYCSVdMu3cMeYHDDNEADFHP11pakR6q1QiTdvmY5KOdyTnXh1k9qyF4JO
         zlyFmNseaZIrnA+c8clA/thazMdn0r5F3WGvSLdXm+uMnq9FCZagEPJeRlvSrt3IO8xF
         Qna3kKgplenKnJ+NfSnM+ZG4HBsFxaeUlDrx+lvGgUZpIevcuzpUKcqWZY0+G1yGcVRe
         HZwPgfRYkyPvMbKhMYEMSaxNQkXFQrHNlKHKjbZlHBPe9xrIvl7axBFyJ+iq+fbh6pxE
         j4+WxmWXLTpSBmo3Z58BAqsW/LnirgOyHjyu9XwY2mW4eAOoUT5fS60qxHVfe/Jpmlxh
         P/vA==
X-Gm-Message-State: AOAM531RYuIy6GlxBKlfpkqL2OxT33tjQtd6/cWR4be7L3/8QnayJ7wP
        tU1fwEhqTAbLlZMkmizwvr99PoVjGa8Vpw==
X-Google-Smtp-Source: ABdhPJxlKT9aq5lUjmM1pCwGeDDQJvmo1AGZrUzDbY0xKz5LIrs2VNebL8OLV+e0xH+3irsKu+36/CDLMP6+6w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:255f:999b:cd4:cfdd])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:15c1:b0:49f:d21f:1d63 with SMTP
 id o1-20020a056a0015c100b0049fd21f1d63mr66585652pfu.18.1637364199660; Fri, 19
 Nov 2021 15:23:19 -0800 (PST)
Date:   Fri, 19 Nov 2021 15:23:16 -0800
Message-Id: <20211119232316.2246034-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] kunit: tool: reconfigure when the used kunitconfig changes
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
Note: this patch is based on
https://lore.kernel.org/linux-kselftest/20211106013058.2621799-1-dlatypov@google.com/
This patch will work without it, but there'll be a false merge conflict.

v1 -> v2:
* always regenerate if last_used_kunitconfig doesn't exist
* don't call os.remove() if last_used_kunitconfig doesn't exist
* add in get_old_kunitconfig_path() to match get_kunitconfig_path()
* s/_kconfig_changed/_kunitconfig_changed
---
 Documentation/dev-tools/kunit/start.rst |  8 ++---
 tools/testing/kunit/kunit_kernel.py     | 40 ++++++++++++++++------
 tools/testing/kunit/kunit_tool_test.py  | 45 +++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 15 deletions(-)

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
index 350883672be0..12085e04a80c 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -21,6 +21,7 @@ import qemu_config
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
+OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
@@ -179,6 +180,9 @@ def get_kconfig_path(build_dir) -> str:
 def get_kunitconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KUNITCONFIG_PATH)
 
+def get_old_kunitconfig_path(build_dir) -> str:
+	return get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+
 def get_outfile_path(build_dir) -> str:
 	return get_file_path(build_dir, OUTFILE_PATH)
 
@@ -289,24 +293,38 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		return self.validate_config(build_dir)
+		if not self.validate_config(build_dir):
+			return False
+
+		old_path = get_old_kunitconfig_path(build_dir)
+		if os.path.exists(old_path):
+			os.remove(old_path)  # write_to_file appends to the file
+		self._kconfig.write_to_file(old_path)
+		return True
+
+	def _kunitconfig_changed(self, build_dir: str) -> bool:
+		old_path = get_old_kunitconfig_path(build_dir)
+		if not os.path.exists(old_path):
+			return True
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
+		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
+			return True
+		print('Regenerating .config ...')
+		os.remove(kconfig_path)
+		return self.build_config(build_dir, make_options)
+
 	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 7e42a7c27987..572f133511aa 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -358,6 +358,51 @@ class LinuxSourceTreeTest(unittest.TestCase):
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
+			with open(kunit_kernel.get_old_kunitconfig_path(build_dir), 'w') as f:
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
+			with open(kunit_kernel.get_old_kunitconfig_path(build_dir), 'w') as f:
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
 
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

