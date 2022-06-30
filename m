Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD17560E48
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiF3AtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 20:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiF3AtS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 20:49:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1B40904
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:49:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i126so3496210oih.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsfSsSM2bRzysv5W5KRkAtTDSP/dkLhm/MHUqCMcvoA=;
        b=c8mvcfB7/Xo+kPFXfnrm/0vMUYvKjsWCoLNh8LtiAF4KTteoIbk3jbiMBE4ArQEWsi
         Fl0kW+X1pywsFFRDtTRF4voz3jEODSdzRuXa1dgaosvdwP/EUdpLGk5QVoJZvnvsT3o4
         /jO1GO5W+cVkVf3+7HhwLNLozQa6nlEkuwRFASNjugbsiMixSvFPjXiEC4yH1sNIDM+Z
         XDZvS8Enz9lCkEwuZa8Gef//aAJBAKdR9reUHlgWgMnyHi7Om3gXL7ZPg9VRzweUo9Vo
         X209Hmg2gQyJYs2d3LHWds6u9Ay1tA1g1yu1FIRQgf/qjneM/TKApwSJ+Qyu8J/gVrs/
         AqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsfSsSM2bRzysv5W5KRkAtTDSP/dkLhm/MHUqCMcvoA=;
        b=DbcuM1J/dVxVBohA1xZBMmxJhMd+KpvBt0ec3Bx7/i4IcjU6aBUFhSaK8WmWw4d5cq
         i2r8hP0gNTrLlNPQxcT899/bSI358KBauuwRSAqAjiyOmZ3JF8AlRd8d4fEsU8FZ3Dhv
         uj0k4Poc+0F2x8QSVrlUnG5269PD0tb2cZe5yQS7jja2KQOmrkcnZfuHaPJ+04eg15SB
         AbazXlnhXlj/i0A+pvt4GnT1A4vir/IDgNZs41i2JEqvGIexEpdxIDmpqvjge2/Dcw1J
         NDpXq5k92ihgeXHrgT8Z8ekoIthROm1NPtV7HrFX0ggDchIKRAdV4VED5N89YjLeJYpZ
         8IsQ==
X-Gm-Message-State: AJIora8EAjzY9i74ISTlKa0PHk66OrK0WlystdZC9Nrfrp3AA8huIU3E
        G7RAKHwslrG/zXoFYHuXIJgOEg==
X-Google-Smtp-Source: AGRyM1snJMopPP44WM4OVMvhim5bbTlEFROp50GWr8cOImPC9HvF3Ubu/0X5UWgmz7q3FNayNtVd9Q==
X-Received: by 2002:a05:6808:d4b:b0:32f:35bb:ba32 with SMTP id w11-20020a0568080d4b00b0032f35bbba32mr4925751oik.282.1656550147367;
        Wed, 29 Jun 2022 17:49:07 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id r10-20020a056808210a00b00325cda1ff8esm9432250oiw.13.2022.06.29.17.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:49:06 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
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
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        "Djakson C . G . Filho" <djakson.filho@gmail.com>,
        Anderson Fraga <aaafraga@gmail.com>
Subject: [PATCH v3 5/9] drm: selftest: convert drm_plane_helper selftest to KUnit
Date:   Wed, 29 Jun 2022 21:46:07 -0300
Message-Id: <20220630004611.114441-6-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630004611.114441-1-maira.canal@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
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

Acked-by: Daniel Latypov <dlatypov@google.com>
Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Djakson C. G. Filho <djakson.filho@gmail.com>
Signed-off-by: Djakson C. G. Filho <djakson.filho@gmail.com>
Co-developed-by: Anderson Fraga <aaafraga@gmail.com>
Signed-off-by: Anderson Fraga <aaafraga@gmail.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   4 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   1 -
 .../drm/selftests/test-drm_modeset_common.h   |   1 -
 drivers/gpu/drm/tests/Makefile                |   2 +-
 .../drm_plane_helper_test.c}                  | 103 ++++++++++--------
 5 files changed, 60 insertions(+), 51 deletions(-)
 rename drivers/gpu/drm/{selftests/test-drm_plane_helper.c => tests/drm_plane_helper_test.c} (62%)

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
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 1aa1627cb5e6..4d44006a4f23 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
-	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o
+	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/tests/drm_plane_helper_test.c
similarity index 62%
rename from drivers/gpu/drm/selftests/test-drm_plane_helper.c
rename to drivers/gpu/drm/tests/drm_plane_helper_test.c
index 64e8938ab194..7f27f1fce373 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/tests/drm_plane_helper_test.c
@@ -3,15 +3,12 @@
  * Test cases for the drm_plane_helper functions
  */
 
-#define pr_fmt(fmt) "drm_plane_helper: " fmt
-
+#include <kunit/test.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_modes.h>
 
-#include "test-drm_modeset_common.h"
-
 static void set_src(struct drm_plane_state *plane_state,
 		    unsigned src_x, unsigned src_y,
 		    unsigned src_w, unsigned src_h)
@@ -74,7 +71,7 @@ static bool check_crtc_eq(struct drm_plane_state *plane_state,
 	return true;
 }
 
-int igt_check_plane_state(void *ignored)
+static void igt_check_plane_state(struct kunit *test)
 {
 	int ret;
 
@@ -109,10 +106,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -120,10 +117,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -133,16 +130,17 @@ int igt_check_plane_state(void *ignored)
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
@@ -151,28 +149,28 @@ int igt_check_plane_state(void *ignored)
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
@@ -181,10 +179,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -192,10 +190,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -203,11 +201,11 @@ int igt_check_plane_state(void *ignored)
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
@@ -215,10 +213,23 @@ int igt_check_plane_state(void *ignored)
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
+	.name = "drm_plane_helper",
+	.test_cases = drm_plane_helper_test,
+};
+
+kunit_test_suite(drm_plane_helper_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.1

