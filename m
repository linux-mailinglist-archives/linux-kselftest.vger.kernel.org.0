Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64B56C425
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiGHUcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 16:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbiGHUcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 16:32:15 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768AA024D
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 13:32:07 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10c0052da61so19030fac.12
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syBCLXlDdIqeFLcMBQWKgKCXogFqzHw8Q9N6jKrm+iA=;
        b=lNvdzWzb90yUeC9wREvMML1OoZRVaYYeMvgXvOHIU5OhMZoQkewuhbys50shjeWlzY
         0b7GKgm7l21L93u0ZZ5wZDFK/b7GkdiZFu6a3HnYNOrTX/cjt8X1dav4/THIHPt/vDL+
         MxnF05vV0BOxeoeyRMjPNznkdcI6JB9Exrrmm0wU+dG5F64IwF8wt63lCAzzSGiLkuM7
         J8WfndXwRRe8J9HXi1njXIuwpwiNE9SivJT6BTb7l9uzZ4qTHk2Dwget5OgVSWUzEpdH
         bN7EoG9R7QGoXg8D1kxT6759Bv/VDZ3Av6vmcFVUYKnU3Z2Mp/LFd33OZpXtbgoqJYVJ
         AFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syBCLXlDdIqeFLcMBQWKgKCXogFqzHw8Q9N6jKrm+iA=;
        b=zrdaLTVRkaq7p2aEJp1m6vQuzf5Ayi4wxqtV3v7njyHCo1u3EuTj2sZzc1+TLyKGfr
         VZaZTO63yKpRdcXNfo3o/RkdIC23Kw5lM+igvYKI+xX8I8NO61NmOYKWEhNdwN9Hhuxo
         E7CBgrcaophTO2g9p/Hx/wo85EAOvBSTWhslXcWC7wqtUbD5PDAAm0nANlMMfLjTQEwA
         F3VNvcCcidc2OQvp7fc4z5FThDqvVPXHUgvpZ+nZhdYX2iDQ+/6QLRtS7mKgaMhROSJN
         uIlNpo5I6hhi7LDLaX4c1hSF3tUHCyXqCY02VtfMB/5ZPGHA5qzb3EzbdfWgMoumrUQV
         Gq4A==
X-Gm-Message-State: AJIora8+QfWvOz9pQi2UhZESzGAzGwJ8f4MDu64vfmIwiqeLTWrW18la
        Nl8k0rTW5Aa5lKK2l1jArkmn8A==
X-Google-Smtp-Source: AGRyM1sAyU98WICYi+ndYTyKTj92KFmHlLuJnJyAbFU2Z600JFLcG82fkwmdLpv1ZQMoCaNzkQWiwA==
X-Received: by 2002:a05:6870:418d:b0:10c:1a0b:75ea with SMTP id y13-20020a056870418d00b0010c1a0b75eamr992162oac.287.1657312326277;
        Fri, 08 Jul 2022 13:32:06 -0700 (PDT)
Received: from fedora.. ([143.107.182.242])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b0061c309b1dc2sm742225otb.39.2022.07.08.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:32:05 -0700 (PDT)
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
Subject: [PATCH v5 5/9] drm: selftest: convert drm_plane_helper selftest to KUnit
Date:   Fri,  8 Jul 2022 17:30:48 -0300
Message-Id: <20220708203052.236290-6-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708203052.236290-1-maira.canal@usp.br>
References: <20220708203052.236290-1-maira.canal@usp.br>
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
Tested-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   4 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   1 -
 .../drm/selftests/test-drm_modeset_common.h   |   1 -
 drivers/gpu/drm/tests/Makefile                |   2 +-
 .../drm_plane_helper_test.c}                  | 122 ++++++++++--------
 5 files changed, 71 insertions(+), 59 deletions(-)
 rename drivers/gpu/drm/{selftests/test-drm_plane_helper.c => tests/drm_plane_helper_test.c} (57%)

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
similarity index 57%
rename from drivers/gpu/drm/selftests/test-drm_plane_helper.c
rename to drivers/gpu/drm/tests/drm_plane_helper_test.c
index 64e8938ab194..e298766cd41f 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/tests/drm_plane_helper_test.c
@@ -1,20 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Test cases for the drm_plane_helper functions
+ *
+ * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
  */
 
-#define pr_fmt(fmt) "drm_plane_helper: " fmt
+#include <kunit/test.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_modes.h>
 
-#include "test-drm_modeset_common.h"
-
 static void set_src(struct drm_plane_state *plane_state,
-		    unsigned src_x, unsigned src_y,
-		    unsigned src_w, unsigned src_h)
+		    unsigned int src_x, unsigned int src_y,
+		    unsigned int src_w, unsigned int src_h)
 {
 	plane_state->src_x = src_x;
 	plane_state->src_y = src_y;
@@ -23,8 +23,8 @@ static void set_src(struct drm_plane_state *plane_state,
 }
 
 static bool check_src_eq(struct drm_plane_state *plane_state,
-			 unsigned src_x, unsigned src_y,
-			 unsigned src_w, unsigned src_h)
+			 unsigned int src_x, unsigned int src_y,
+			 unsigned int src_w, unsigned int src_h)
 {
 	if (plane_state->src.x1 < 0) {
 		pr_err("src x coordinate %x should never be below 0.\n", plane_state->src.x1);
@@ -50,7 +50,7 @@ static bool check_src_eq(struct drm_plane_state *plane_state,
 
 static void set_crtc(struct drm_plane_state *plane_state,
 		     int crtc_x, int crtc_y,
-		     unsigned crtc_w, unsigned crtc_h)
+		     unsigned int crtc_w, unsigned int crtc_h)
 {
 	plane_state->crtc_x = crtc_x;
 	plane_state->crtc_y = crtc_y;
@@ -60,7 +60,7 @@ static void set_crtc(struct drm_plane_state *plane_state,
 
 static bool check_crtc_eq(struct drm_plane_state *plane_state,
 			  int crtc_x, int crtc_y,
-			  unsigned crtc_w, unsigned crtc_h)
+			  unsigned int crtc_w, unsigned int crtc_h)
 {
 	if (plane_state->dst.x1 != crtc_x ||
 	    plane_state->dst.y1 != crtc_y ||
@@ -74,7 +74,7 @@ static bool check_crtc_eq(struct drm_plane_state *plane_state,
 	return true;
 }
 
-int igt_check_plane_state(void *ignored)
+static void igt_check_plane_state(struct kunit *test)
 {
 	int ret;
 
@@ -83,9 +83,8 @@ int igt_check_plane_state(void *ignored)
 		.enable = true,
 		.active = true,
 		.mode = {
-			DRM_MODE("1024x768", 0, 65000, 1024, 1048,
-				1184, 1344, 0, 768, 771, 777, 806, 0,
-				DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
+			DRM_MODE("1024x768", 0, 65000, 1024, 1048, 1184, 1344, 0, 768, 771,
+				 777, 806, 0, DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
 		},
 	};
 	static struct drm_plane plane = {
@@ -109,10 +108,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -120,10 +119,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -133,16 +132,17 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  false, false);
-	FAIL(!ret, "Should not be able to position on the crtc with can_position=false\n");
+	KUNIT_EXPECT_TRUE_MSG(test, ret,
+			      "Should not be able to position on the crtc with can_position=false\n");
 
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
@@ -151,28 +151,28 @@ int igt_check_plane_state(void *ignored)
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
@@ -181,10 +181,10 @@ int igt_check_plane_state(void *ignored)
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
@@ -192,10 +192,11 @@ int igt_check_plane_state(void *ignored)
 						  DRM_PLANE_HELPER_NO_SCALING,
 						  0x10001,
 						  false, false);
-	FAIL(ret < 0, "Should succeed by clipping to exact multiple");
-	FAIL_ON(!plane_state.visible);
-	FAIL_ON(!check_src_eq(&plane_state, 0x40002, 0x40002, 1024 << 16, 768 << 16));
-	FAIL_ON(!check_crtc_eq(&plane_state, 0, 0, 1024, 768));
+	KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
+	KUNIT_EXPECT_TRUE(test, plane_state.visible);
+	KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0x40002, 0x40002,
+					     1024 << 16, 768 << 16));
+	KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
 
 	set_src(&plane_state, 0, 0, 0x3ffff, 0x3ffff);
 	set_crtc(&plane_state, 1022, 766, 4, 4);
@@ -203,11 +204,11 @@ int igt_check_plane_state(void *ignored)
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
@@ -215,10 +216,23 @@ int igt_check_plane_state(void *ignored)
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
+					     1024 << 16, 768 << 16));
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
2.35.3

