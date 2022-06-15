Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53654CAA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiFOOAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352886AbiFOOAJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 10:00:09 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F1457BE
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-fe023ab520so16556641fac.10
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08N7YiGKX0jNilKmdhjsyfvhixOh2CcV1TwDxPITXG8=;
        b=akp8rGhKvMbS5UnNC5JI0a3vP3pjdLmy8+qAse8JqxQHms3yUBza7GKedmCpHcFvgG
         6ofwDn3TPrq8bsWt45JMeC1uHCqo8dm9vTCORpYsThT4BQ0r0SNQ+XoEXyQxSkFnMXII
         k9JWNjxE2AWmIGXOHCKO0rDWUPOelAX8o2sQ4z8Oo9xb2i8MMTAsgnsZOzrt5CAZKtDx
         Ht8lxkpQsUTQizR8tGxh2RcPgQ1aBg+DrnpYsvlukMQ52eeH4gXEMFs+JVchkBLHQzPd
         w+dTFqqIrLV95q9adYN1gCJtZfShcqR5Xdz0VuHzy/VHf5ykxfIjyFWNph+AFj/cjC1C
         /yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08N7YiGKX0jNilKmdhjsyfvhixOh2CcV1TwDxPITXG8=;
        b=Bz9AjIESClStlC+efxe3zBlm4dKzzf277lpnJM+im3v5/Qft8sUoOKE3LCFLfIGHK5
         Aycq3xPOUa9Cp2NoS140CnoWhdR8ln2kTB4vS0QbReNc78MP1YSF33/gL/Lqkt/frdYJ
         zdkRQpCzw5J7oCniZJXVX1J0SrwZRBnC9CbjcY4N3acKb/nfuBMGAxQpcQP5FJN1QqjL
         8yoCIa64atq1LOBcMbez8NgshuBQ2PMdZY+uCvnJ4KOSks/cagxEk7fg+w3XEimnPUDP
         uEmD6BGg0Aj8aP1vZyFlgJeSa6AeZljjJjw5C2Ol6tKqPlny1v6khn8VkL3i3JrEWJ0h
         sYMw==
X-Gm-Message-State: AJIora8g7u9JZZro8Em+cVYIghkSD2DEuZPBU2jjDzaqIOun+lv1CyVZ
        s4AZl1sHi4J0U7SjrPWQEcyfhA==
X-Google-Smtp-Source: AGRyM1vfnpZ29ACmpZQbV/GAMT2TO/QO2cAyQJQaYsEjoxGdyhNcxoWYIO4Klm/OFZo19UHdobw/dg==
X-Received: by 2002:a05:6871:14e:b0:f3:4d16:c42b with SMTP id z14-20020a056871014e00b000f34d16c42bmr5511174oab.232.1655301586317;
        Wed, 15 Jun 2022 06:59:46 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id u7-20020a056830248700b0060bfebb96e5sm6056928ots.35.2022.06.15.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:59:45 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        "Djakson C . G . Filho" <djakson.filho@gmail.com>,
        Anderson Fraga <aaafraga@gmail.com>
Subject: [PATCH 06/10] drm: selftest: convert drm_plane_helper selftest to KUnit
Date:   Wed, 15 Jun 2022 10:58:20 -0300
Message-Id: <20220615135824.15522-7-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615135824.15522-1-maira.canal@usp.br>
References: <20220615135824.15522-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Considering the current adoption of the KUnit framework, convert the
DRM plane helper selftest to the KUnit API.

Co-developed-by: Djakson C. G. Filho <djakson.filho@gmail.com>
Signed-off-by: Djakson C. G. Filho <djakson.filho@gmail.com>
Co-developed-by: Anderson Fraga <aaafraga@gmail.com>
Signed-off-by: Anderson Fraga <aaafraga@gmail.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   4 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   1 -
 .../drm/selftests/test-drm_modeset_common.h   |   1 -
 drivers/gpu/drm/tests/Kconfig                 |  12 +++
 drivers/gpu/drm/tests/Makefile                |   1 +
 .../test-drm_plane_helper.c                   | 101 ++++++++++--------
 6 files changed, 70 insertions(+), 50 deletions(-)
 rename drivers/gpu/drm/{selftests => tests}/test-drm_plane_helper.c (62%)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index b7f252d886d0..9e0ccb482841 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
-                      test-drm_framebuffer.o test-drm_dp_mst_helper.o
+test-drm_modeset-y := test-drm_modeset_common.o test-drm_framebuffer.o \
+					test-drm_dp_mst_helper.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
 				    test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 63061ef55eff..22e467f6465a 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -6,7 +6,6 @@
  *
  * Tests are executed in order by igt/drm_selftests_helper
  */
-selftest(check_plane_state, igt_check_plane_state)
 selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
 selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
 selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 5709d967a5c4..790f3cf31f0d 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -16,7 +16,6 @@
 
 #define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
 
-int igt_check_plane_state(void *ignored);
 int igt_check_drm_framebuffer_create(void *ignored);
 int igt_dp_mst_calc_pbn_mode(void *ignored);
 int igt_dp_mst_sideband_msg_req_decode(void *ignored);
diff --git a/drivers/gpu/drm/tests/Kconfig b/drivers/gpu/drm/tests/Kconfig
index 7c4f76560152..5aa8ac2dd28e 100644
--- a/drivers/gpu/drm/tests/Kconfig
+++ b/drivers/gpu/drm/tests/Kconfig
@@ -61,4 +61,16 @@ config DRM_FORMAT_KUNIT_TEST
 
 		If in doubt, say "N".
 
+config DRM_PLANE_HELPER_KUNIT_TEST
+	tristate "KUnit tests for DRM plane helper" if !DRM_KUNIT_TEST
+	select DRM_KMS_HELPER
+	default y if DRM_KUNIT_TEST
+	help
+		This option provides KUnit modules that can be used to run
+		various selftests on parts of the DRM plane helper API.  This
+		option is not useful for distributions or general kernels, but only
+		for kernel developers working on DRM and associated drivers.
+
+		If in doubt, say "N".
+
 endmenu
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 95d1f67f609d..6e3a10806cd8 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_DRM_DAMAGE_HELPER_KUNIT_TEST) += test-drm_damage_helper.o
 obj-$(CONFIG_DRM_CMDLINE_PARSER_KUNIT_TEST) += test-drm_cmdline_parser.o
 obj-$(CONFIG_DRM_RECT_KUNIT_TEST) += test-drm_rect.o
 obj-$(CONFIG_DRM_FORMAT_KUNIT_TEST) += test-drm_format.o
+obj-$(CONFIG_DRM_PLANE_HELPER_KUNIT_TEST) += test-drm_plane_helper.o
diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/tests/test-drm_plane_helper.c
similarity index 62%
rename from drivers/gpu/drm/selftests/test-drm_plane_helper.c
rename to drivers/gpu/drm/tests/test-drm_plane_helper.c
index b61273e9c403..354c2c8d9f1c 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/tests/test-drm_plane_helper.c
@@ -3,14 +3,11 @@
  * Test cases for the drm_plane_helper functions
  */
 
-#define pr_fmt(fmt) "drm_plane_helper: " fmt
-
+#include <kunit/test.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_modes.h>
 
-#include "test-drm_modeset_common.h"
-
 static void set_src(struct drm_plane_state *plane_state,
 		    unsigned src_x, unsigned src_y,
 		    unsigned src_w, unsigned src_h)
@@ -73,7 +70,7 @@ static bool check_crtc_eq(struct drm_plane_state *plane_state,
 	return true;
 }
 
-int igt_check_plane_state(void *ignored)
+static void igt_check_plane_state(struct kunit *test)
 {
 	int ret;
 
@@ -108,10 +105,10 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(ret < 0, "Simple clipping check should pass\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Simple clipping check should pass\n");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 1024 << 16, 768 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 
 	/* Rotated clipping + reflection, no scaling. */
 	plane_state.rotation = DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X;
@@ -119,10 +116,10 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(ret < 0, "Rotated clipping check should pass\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 768 << 16, 1024 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Rotated clipping check should pass\n");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 768 << 16, 1024 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 	plane_state.rotation = DRM_MODE_ROTATE_0;
 
 	/* Check whether positioning works correctly. */
@@ -132,16 +129,17 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(!ret, "Should not be able to position on the crtc with can_position=false\n");
+	KUNIT_EXPECT_TRUE_MSG(test, ret,
+			"Should not be able to position on the crtc with can_position=false\n");
 
 	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  true, false);
-	FAIL(ret < 0, "Simple positioning should work\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 1023 << 16, 767 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1023, 767));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Simple positioning should work\n");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 1023 << 16, 767 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1023, 767));
 
 	/* Simple scaling tests. */
 	set_src(&plane_state, 0, 0, 512 << 16, 384 << 16);
@@ -150,28 +148,28 @@ int igt_check_plane_state(void *ignored)
 						  0x8001,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(!ret, "Upscaling out of range should fail.\n");
+	KUNIT_EXPECT_TRUE_MSG(test, ret, "Upscaling out of range should fail.\n");
 	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
 						  0x8000,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(ret < 0, "Upscaling exactly 2x should work\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 512 << 16, 384 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Upscaling exactly 2x should work\n");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 512 << 16, 384 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 
 	set_src(&plane_state, 0, 0, 2048 << 16, 1536 << 16);
 	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  0x1ffff, false, false);
-	FAIL(!ret, "Downscaling out of range should fail.\n");
+	KUNIT_EXPECT_TRUE_MSG(test, ret, "Downscaling out of range should fail.\n");
 	ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  0x20000, false, false);
-	FAIL(ret < 0, "Should succeed with exact scaling limit\n");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2048 << 16, 1536 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed with exact scaling limit\n");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2048 << 16, 1536 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 
 	/* Testing rounding errors. */
 	set_src(&plane_state, 0, 0, 0x40001, 0x40001);
@@ -180,10 +178,10 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  0x10001,
 						  true, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 1022, 766, 2, 2));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 1022, 766, 2, 2));
 
 	set_src(&plane_state, 0x20001, 0x20001, 0x4040001, 0x3040001);
 	set_crtc(&plane_state, -2, -2, 1028, 772);
@@ -191,10 +189,10 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  0x10001,
 						  false, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0x40002, 0x40002, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0x40002, 0x40002, 1024 << 16, 768 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 
 	set_src(&plane_state, 0, 0, 0x3ffff, 0x3ffff);
 	set_crtc(&plane_state, 1022, 766, 4, 4);
@@ -202,11 +200,11 @@ int igt_check_plane_state(void *ignored)
 						  0xffff,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  true, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
 	/* Should not be rounded to 0x20001, which would be upscaling. */
-	FAIL_ON(!check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 1022, 766, 2, 2));
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 1022, 766, 2, 2));
 
 	set_src(&plane_state, 0x1ffff, 0x1ffff, 0x403ffff, 0x303ffff);
 	set_crtc(&plane_state, -2, -2, 1028, 772);
@@ -214,10 +212,21 @@ int igt_check_plane_state(void *ignored)
 						  0xffff,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0x3fffe, 0x3fffe, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
-
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0x3fffe, 0x3fffe,
+				1024 << 16, 768 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 }
+
+static struct kunit_case drm_plane_helper_test[] = {
+	KUNIT_CASE(igt_check_plane_state),
+	{}
+};
+
+static struct kunit_suite drm_plane_helper_test_suite = {
+	.name = "drm_plane_helper_test",
+	.test_cases = drm_plane_helper_test,
+};
+
+kunit_test_suite(drm_plane_helper_test_suite);
-- 
2.36.1

