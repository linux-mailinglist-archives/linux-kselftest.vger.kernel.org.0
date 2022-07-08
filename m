Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87A956BFAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiGHQ22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 12:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiGHQ1p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 12:27:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66C8736B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 09:27:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j3-20020a17090a694300b001ef87826a62so1245729pjm.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Q/iRyvoXPEz0OuK0jrrOflnyHMomDksx7PC4C85yLGg=;
        b=mfBiGkWGOPGNvfiac/hpFafX2LM9jWCc0WY9c6vJOJfpstMLiLkb32FtdShieTEyVQ
         68qP7JoiNdSOxOWe3Dwk8PARy+E82wHl1aCGKQm7TgZsrZKFOtz2r3SaCWAnqFVP6Rzy
         m228zMJFM4aa7ovr4UFKqW93g2alQFj/WhRyf/M/lKSfiaUAEhvePi2kdGNjhZENDS55
         d/SeC62Qs+uGbkFceHmBBGb0F2XRgmMgHYeu7oRdc8JT+Ciw71jNfFAkhbVOXxwCGEvd
         NqHlPCCdXzayANXA3TEDRSUB2Nk/Hg14+if46xh3RViixlh9AvPK+WXDQ1aH8HnmaoIc
         yZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Q/iRyvoXPEz0OuK0jrrOflnyHMomDksx7PC4C85yLGg=;
        b=ghYl6Pnuz/fkN2TSbrnDgvWHkYRgs/v/vYt20LbBU2W39zCWwNjhcw/TvfbrO8IKnw
         DPU+TUzsvA7/XudJFNcYGKj6o08vr5dMYezKky6jmnn4Vw5bSsX1DR9kaHJwQkNLP8kh
         h9u3qgSd4VW+Vgn+Bh7buRdB+rW/xOglCa5qAEE8Hy7dDQjuguPuITr3sdN0TNcER/lJ
         lq7u6ETKWHYomKZbqvgkE2G6Hv0bR/1xP5c5MjhttV8qqgVlY+jsAHXDAmA3I5NCF4+c
         y930RXfYn9X4NFtx5Nbj9rMeBlVmhX3XqR26fi7cNv+4Gbd0POoZ7UcoMGPDvE5nlNGo
         1CvQ==
X-Gm-Message-State: AJIora/J9GT/beF1Z417RihdrclCJTk/tTGa4UaikfB21TfffqpgzaJ2
        L8hlQ67ZFfe6evV+yXmU+I/Fi/wPY4kCrw==
X-Google-Smtp-Source: AGRyM1sLJlwxfjqcNm/Fsdm7a+OffuFDWD2oUjsDH2QuDyuxoNm/fNvoT9Z8F/FLo+/1aeoJHpSeHvP6HN+vag==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:ea47:b0:16b:997b:5fd6 with SMTP
 id r7-20020a170902ea4700b0016b997b5fd6mr4426982plg.16.1657297639986; Fri, 08
 Jul 2022 09:27:19 -0700 (PDT)
Date:   Fri,  8 Jul 2022 16:27:11 +0000
Message-Id: <20220708162711.1309633-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3] kunit: tool: Enable virtio/PCI by default on UML
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        "=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>
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

From: David Gow <davidgow@google.com>

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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

NOTE: This depends on v4 of the repeatable --kunitconfig patch here:
https://patchwork.kernel.org/project/linux-kselftest/patch/20220708013632.1=
210466-1-dlatypov@google.com/
Please apply it first first.

Changes since v2: (dlatypov@google.com)
- Rebase on top of the -kselftest kunit branch + v4 of the --kunitconfig
  patch. It rebased cleanly, but it evidently would not apply cleanly
  due to all the conflicts v4 --kunitconfig had with --qemu_args

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
index 56492090e28e..f5c26ea89714 100644
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
 		stdout.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
@@ -298,7 +304,7 @@ class LinuxSourceTree:
 		if build_dir and not os.path.exists(build_dir):
 			os.mkdir(build_dir)
 		try:
-			self._kconfig =3D self._ops.make_arch_qemuconfig(self._kconfig)
+			self._kconfig =3D self._ops.make_arch_config(self._kconfig)
 			self._kconfig.write_to_file(kconfig_path)
 			self._ops.make_olddefconfig(build_dir, make_options)
 		except ConfigError as e:
@@ -329,7 +335,7 @@ class LinuxSourceTree:
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
index ad63d0d34f3f..446ac432d9a4 100755
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

base-commit: cbb6bc7059151df198b45e883ed731d8f528b65b
--=20
2.37.0.rc0.161.g10f37bed90-goog

