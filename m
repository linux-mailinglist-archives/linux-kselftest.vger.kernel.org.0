Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8107155959B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiFXIoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFXIoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 04:44:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16044F1CF
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 01:44:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3177d1fe9f1so17024087b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=71G3cfA5PBAKD0oF5OXbLK3/0rhXG8br391sycZlj8g=;
        b=VFRYLEdS0b6+2/SNRmN7NEt+1cayRbIyH+/liE9mT0KhTuKIvuO5zzRzedzFqX5j1Z
         f/IkR/Xrjgmz2fgNVgOgEiCECILWOa6MbBF7JAq/bX5TW4KhKb9GhK/6GeTRqX+efRaP
         CKHr5yTZWXOQdkCnGKrizG3p3dibqYZzXHGhi170jA8/tAx/T/3ojzQ/YRg0gNKGAdTf
         9XOTd6Oihx8cF4yX/w+V30Q80ZxxbKxwfcLYfJVmFP7MSN3lA1qo55kcj4v0vWMvCARF
         YnC4J7kWn3nvCcC2K1a8kFG1SAgJLjsX0Qk5gmihONZsNwFJKPetrx4Cc5bM2BCcUyZh
         W84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=71G3cfA5PBAKD0oF5OXbLK3/0rhXG8br391sycZlj8g=;
        b=juurTnWkLgceMTc1sVSVQDVMC7JGaWR1whBb28LloHV1J2ZPk4HdStn+vvcLhcYpWB
         BHyZ+qjmGKqwj2McQoEr8Zmf4M4fgBky0vdg27RVD/JZ1gextyWwzLBxvDJka3b2XM9N
         WJEygNsGO8rVQ+wijex7J16v+dgzxevZdssMzqhv3nNmhl0zLZRAghD3HsJGreE8f32A
         YjbsL+/MAl+oBwtPA2xnv80KzH64MhP/HbRF5J7BJ3HnogVbiKMOmO2UyxFY23IsZF9/
         BxIayylXq30HOuNHG+FsmCXqXO0hjh95ZDZGcQRATam/Xkv4jONAG81W2Fi1wfEeI8u7
         dCig==
X-Gm-Message-State: AJIora+SuLcwo/t2StvUj1JwOfpIejDc7htikBL4I7WZwULneP/HbtrI
        a467aENYnN9CPTVw67aXjBUS36L/yQ9U0w==
X-Google-Smtp-Source: AGRyM1u0hpr2D+ojSUdme51mvHYIp0ZK6z9VFhV+t6AoKFFNdS0RNm3h9ylDkXZ9rYU/oycd8qB8GnFRBIEvDg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:442:0:b0:669:b500:9474 with SMTP id
 63-20020a250442000000b00669b5009474mr5619872ybe.376.1656060246169; Fri, 24
 Jun 2022 01:44:06 -0700 (PDT)
Date:   Fri, 24 Jun 2022 16:43:59 +0800
Message-Id: <20220624084400.1454579-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] kunit: tool: Enable virtio/PCI by default on UML
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

There are several tests which depend on PCI, and hence need a bunch of
extra options to run under UML. This makes it awkward to give
configuration instructions (whether in documentation, or as part of a
.kunitconfig file), as two separate, incompatible sets of config options
are required for UML and "most other architectures".

For non-UML architectures, it's possible to add default kconfig options
via the qemu_config python files, but there's no equivalent for UML. Add
a new tools/testing/kunit/configs/arch_uml.config file containing extra
kconfig options to use on UML.

Signed-off-by: David Gow <davidgow@google.com>
---

NOTE: This has dependencies on the 'make --kunitconfig repeatable'
series:
https://lore.kernel.org/linux-kselftest/20220624001247.3255978-1-dlatypov@google.com/
which, in turn, depends on:
https://lore.kernel.org/linux-kselftest/20220520224200.3764027-1-dlatypov@google.com/
Please apply those first.

Changes since RFC:
https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@google.com/
- Rebase on top of the previous kconfig patches.
- Fix a missing make_arch_qemuconfig->make_arch_config rename (Thanks
  Brendan)
- Fix the tests to use the base LinuxSourceTreeOperations class, which
  has no default kconfig options (and so won't conflict with those set
  in the tests). Only test_build_reconfig_existing_config actually
  failed, but I updated a few more in case the defaults changed.


---
 tools/testing/kunit/configs/arch_uml.config |  5 +++++
 tools/testing/kunit/kunit_kernel.py         | 14 ++++++++++----
 tools/testing/kunit/kunit_tool_test.py      | 12 ++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/kunit/configs/arch_uml.config

diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
new file mode 100644
index 000000000000..e824ce43b05a
--- /dev/null
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -0,0 +1,5 @@
+# Config options which are added to UML builds by default
+
+# Enable virtio/pci, as a lot of tests require it.
+CONFIG_VIRTIO_UML=y
+CONFIG_UML_PCI_OVER_VIRTIO=y
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index fc415ff7530e..127598fb994b 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -26,6 +26,7 @@ KUNITCONFIG_PATH = '.kunitconfig'
 OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
+UML_KCONFIG_PATH = 'tools/testing/kunit/configs/arch_uml.config'
 OUTFILE_PATH = 'test.log'
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR = os.path.join(ABS_TOOL_PATH, 'qemu_configs')
@@ -53,7 +54,7 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		return base_kunitconfig
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
@@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._kernel_command_line = qemu_arch_params.kernel_command_line + ' kunit_shutdown=reboot'
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
 		kconfig = kunit_config.parse_from_string(self._kconfig)
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
@@ -138,6 +139,11 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 	def __init__(self, cross_compile=None):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kunit_config.Kconfig:
+		kconfig = kunit_config.parse_file(UML_KCONFIG_PATH)
+		kconfig.merge_in_entries(base_kunitconfig)
+		return kconfig
+
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
@@ -297,7 +303,7 @@ class LinuxSourceTree:
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		try:
-			self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig = self._ops.make_arch_config(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -328,7 +334,7 @@ class LinuxSourceTree:
 			return self.build_config(build_dir, make_options)
 
 		existing_kconfig = kunit_config.parse_file(kconfig_path)
-		self._kconfig = self._ops.make_arch_qemuconfig(self._kconfig)
+		self._kconfig = self._ops.make_arch_config(self._kconfig)
 
 		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
 			return True
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index e21ae1331350..08cb2dc8ef7d 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -430,6 +430,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			# Should generate the .config
@@ -447,6 +451,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
@@ -463,6 +471,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
 
 			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
 			mock_build_config = mock.patch.object(tree, 'build_config').start()
 
 			# ... so we should trigger a call to build_config()
-- 
2.37.0.rc0.161.g10f37bed90-goog

