Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB910553B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354330AbiFUULD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbiFUULC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 16:11:02 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3492A264
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:56 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so19730541fac.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+JXFHG3jcYkJ4zBa6+egSCKXqbH+aGXx2km2H05uYQ=;
        b=FbCYgR+iqW7O3ZMKXewe1TUS1d7pWW8ce8uyh7B3Esn9vyCQnIN/ixWEOXmpq7tN8m
         Pgmb/CKvXTTRHiDLetCbAO5fSd+Qtk4V/GZhNToHrBU5u+35AssjPuc85YuDQFk2tFKD
         OXj94n7WnU8mLfb5SoRFXs2kQ1VMMTJLdr4nXqBgCzfQSBFBYePfOTFd/A/dONJEXzFy
         aveFizIKmL7DvIT9Tbe266Gux1Ce64n7+zZ67E51IyttW9vhuOYf9ZJqxhv0sa2u+w8p
         QbTEjVwis1N8yvvKLIyT4YgJzzxuY5dflOS9SmRyknt36lv1A5r3+D3yQVJqOqtBaxW2
         uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+JXFHG3jcYkJ4zBa6+egSCKXqbH+aGXx2km2H05uYQ=;
        b=Fg8aIVFGogh5rLok+bOwQ21Y4LVE6eSK4KGdew+FIHUOYRuRDZEZFc9GnTiET90LbQ
         n0Y3aTGp8p2iXeP4wJY37DGO0icxIrWEA7EUbyCY4v0I/SQrO257yZm7VNhtRy9AoV4u
         wGNirXFcqYdhkUlIm0jRgKwE5oQxy9YqzFCJB/JxaNUktZklSPmY1RUVRlG+uajnz3bh
         d8PqhX/oSZmeALdGjDONlSyKRfoXSUrwgFu4jtBBApu9OWTUEcYpxh8ofoTKJad+J8jw
         W72ebdUSuQ0IikN1JA86/MRjM8T31+cQuFQclYNaRNfep0dUqhKrTsHiPjL1rsZ7WPlz
         DSyA==
X-Gm-Message-State: AJIora8kP9VwLGcMGnJOKIsOWTIdiqJ7RY+cNUysA7mLKLCS4gn8tSpL
        IKKhul3JcDIHAQuW7gRU49AsKQ==
X-Google-Smtp-Source: AGRyM1sDsodObH5UQVWHkQxti2YwARV6TpiJCXO306fxkTS4dGJ48ylTGJWAvJewuYAdkwHvCXAnvg==
X-Received: by 2002:a05:6870:9710:b0:101:d3a2:94d1 with SMTP id n16-20020a056870971000b00101d3a294d1mr8233766oaq.180.1655842256003;
        Tue, 21 Jun 2022 13:10:56 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o206-20020acad7d7000000b0032b7a0c5da1sm9759771oig.27.2022.06.21.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:10:55 -0700 (PDT)
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
Subject: [PATCH v2 5/9] drm: selftest: convert drm_plane_helper selftest to KUnit
Date:   Tue, 21 Jun 2022 17:09:22 -0300
Message-Id: <20220621200926.257002-6-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621200926.257002-1-maira.canal@usp.br>
References: <20220621200926.257002-1-maira.canal@usp.br>
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
index 7a60289d2c6c..0dfc8b806f85 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o drm_cmdline_parser_test.o \
-	drm_rect_test.o drm_format_test.o
+	drm_rect_test.o drm_format_test.o drm_plane_helper_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_plane_helper.c b/drivers/gpu/drm/tests/drm_plane_helper_test.c
similarity index 62%
rename from drivers/gpu/drm/selftests/test-drm_plane_helper.c
rename to drivers/gpu/drm/tests/drm_plane_helper_test.c
index b61273e9c403..794e7ddf62f1 100644
--- a/drivers/gpu/drm/selftests/test-drm_plane_helper.c
+++ b/drivers/gpu/drm/tests/drm_plane_helper_test.c
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
@@ -214,10 +212,23 @@ int igt_check_plane_state(void *ignored)
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

