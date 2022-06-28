Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97955F220
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiF1X62 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jun 2022 19:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF1X61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jun 2022 19:58:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7C1C935
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jun 2022 16:58:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso7705362plb.19
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jun 2022 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=diawUkmMji2F3F26uiMOT2BgtEsZELg3CBpeDJnhLk0=;
        b=F78PTKQxQ/CVPEIgZMh9d4NwrVQi4vrk1e54rBAcjSb+9+1kDvrsFQgP3D0w3OuChm
         xXMoW8gYp2z7jS6SdRoi3SljDFaozEvR+MSCOpuOEHi/WtS7C4wQMeSMc7kzyvqWG+p/
         gvbCm2uT7vsOh5VMuoCbRr3Y4x4CaeolmT8Pz0Uyop8L3xIxeZDHjMM3BH6itTtXbANU
         Mu224c/ICOZ5iv8SjpYPx30FRadp9aEJUPSNZzjLDHKiDioIwnvS2O1v+W15n4p5ly3t
         KZPa0qE56FVm00WPEYbc4JLbGcuwIxSi09KUKIDIUqfoYaEC/90Xm1LhuCpYOfS5ihZ+
         Yegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=diawUkmMji2F3F26uiMOT2BgtEsZELg3CBpeDJnhLk0=;
        b=44tTqcPbvHW8ruUJdr1zi378SqqUZbWIKygO0abZzbuwbMssGVGYRA4SJooHTASC3O
         VE3aCWy6Vnnv2tsxZQHTyvT5hDqULf1vuRtuUGXEdde967ggoN6Z7DuPB7tBb8fT4F2Y
         bvbZfatYKlmdbeYR6+Z6hBZJYpzKA56Fgb2V0BBuzrprSMgwHYXSUDBJLhgRiBFn+7gm
         KFPTqXKTxdoU1/vrkN2V0KiIJ2uOJJ5qtEqzjObeMpE8TbKWKrEUP1zSmO2XSmXLLWV+
         tvhT7MiWSBBeE+e7Eqhl8elAztGfv5bGKskh12f0egjBDar6UouPlfwTe8JDmgfJai/9
         50DA==
X-Gm-Message-State: AJIora/MM8ma3PMt6RaPGNaMsjCtmbEujEjNqNCIVurBrlMvSto6lSSO
        oj+9Y6vnLVg971WXX2tPZe+4+blNc03H3Q==
X-Google-Smtp-Source: AGRyM1slGRn0McvNZPUlXnLeTHKjfP/WQ6P57uFR9A+5P912UMzJ6PiCBuJWlouRqzQI2ZaxdNzJUMtWQdREIA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:f606:b0:168:ecca:44e with SMTP id
 n6-20020a170902f60600b00168ecca044emr6183328plg.144.1656460705544; Tue, 28
 Jun 2022 16:58:25 -0700 (PDT)
Date:   Wed, 29 Jun 2022 07:58:12 +0800
Message-Id: <20220628235812.2356160-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] kunit: tool: Enable virtio/PCI by default on UML
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Tested-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

NOTE: This depends on the refactor kconfig handling & repeatable
--kunitconfig series here:
https://lore.kernel.org/linux-kselftest/20220627221446.82157-1-dlatypov@goo=
gle.com/T/
https://patchwork.kernel.org/project/linux-kselftest/list/?series=3D654332
Please apply those first.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220624084400.1454579-1-davidgow@g=
oogle.com/
- (Hopefully) fix a pytype warning re: architecture being None in the
  tests. (Thanks, Daniel)
- Rebase on top of the new combined v3 of the kconfig/kunitconfig
  patchset.
- Add Jos=C3=A9's Tested-by and Daniel's Reviewed-by.

Changes since RFC:
https://lore.kernel.org/linux-kselftest/20220622035326.759935-1-davidgow@go=
ogle.com/
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

diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/ku=
nit/configs/arch_uml.config
new file mode 100644
index 000000000000..e824ce43b05a
--- /dev/null
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -0,0 +1,5 @@
+# Config options which are added to UML builds by default
+
+# Enable virtio/pci, as a lot of tests require it.
+CONFIG_VIRTIO_UML=3Dy
+CONFIG_UML_PCI_OVER_VIRTIO=3Dy
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index f65c996127c3..2698d4c51e6e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -26,6 +26,7 @@ KUNITCONFIG_PATH =3D '.kunitconfig'
 OLD_KUNITCONFIG_PATH =3D 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH =3D 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH =3D 'tools/testing/kunit/configs/broken_on_uml.confi=
g'
+UML_KCONFIG_PATH =3D 'tools/testing/kunit/configs/arch_uml.config'
 OUTFILE_PATH =3D 'test.log'
 ABS_TOOL_PATH =3D os.path.abspath(os.path.dirname(__file__))
 QEMU_CONFIGS_DIR =3D os.path.join(ABS_TOOL_PATH, 'qemu_configs')
@@ -53,7 +54,7 @@ class LinuxSourceTreeOperations:
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
=20
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) ->=
 kunit_config.Kconfig:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kun=
it_config.Kconfig:
 		return base_kunitconfig
=20
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
@@ -109,7 +110,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOper=
ations):
 		self._kernel_command_line =3D qemu_arch_params.kernel_command_line + ' k=
unit_shutdown=3Dreboot'
 		self._extra_qemu_params =3D qemu_arch_params.extra_qemu_params
=20
-	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) ->=
 kunit_config.Kconfig:
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kun=
it_config.Kconfig:
 		kconfig =3D kunit_config.parse_from_string(self._kconfig)
 		kconfig.merge_in_entries(base_kunitconfig)
 		return kconfig
@@ -138,6 +139,11 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOper=
ations):
 	def __init__(self, cross_compile=3DNone):
 		super().__init__(linux_arch=3D'um', cross_compile=3Dcross_compile)
=20
+	def make_arch_config(self, base_kunitconfig: kunit_config.Kconfig) -> kun=
it_config.Kconfig:
+		kconfig =3D kunit_config.parse_file(UML_KCONFIG_PATH)
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
-			self._kconfig =3D self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig =3D self._ops.make_arch_config(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -328,7 +334,7 @@ class LinuxSourceTree:
 			return self.build_config(build_dir, make_options)
=20
 		existing_kconfig =3D kunit_config.parse_file(kconfig_path)
-		self._kconfig =3D self._ops.make_arch_qemuconfig(self._kconfig)
+		self._kconfig =3D self._ops.make_arch_config(self._kconfig)
=20
 		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfi=
g_changed(build_dir):
 			return True
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index 0c5ba3ed35e6..6b8887c79c50 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -430,6 +430,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=3Dy')
=20
 			tree =3D kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops =3D kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config =3D mock.patch.object(tree, 'build_config').start()
=20
 			# Should generate the .config
@@ -447,6 +451,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=3Dy\nCONFIG_KUNIT_TEST=3Dy')
=20
 			tree =3D kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops =3D kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config =3D mock.patch.object(tree, 'build_config').start()
=20
 			self.assertTrue(tree.build_reconfig(build_dir, make_options=3D[]))
@@ -463,6 +471,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				f.write('CONFIG_KUNIT=3Dy\nCONFIG_KUNIT_TEST=3Dy')
=20
 			tree =3D kunit_kernel.LinuxSourceTree(build_dir)
+			# Stub out the source tree operations, so we don't have
+			# the defaults for any given architecture get in the
+			# way.
+			tree._ops =3D kunit_kernel.LinuxSourceTreeOperations('none', None)
 			mock_build_config =3D mock.patch.object(tree, 'build_config').start()
=20
 			# ... so we should trigger a call to build_config()
--=20
2.37.0.rc0.161.g10f37bed90-goog

