Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25D56C38F
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiGHUdF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 16:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbiGHUcn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 16:32:43 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC19FE14
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 13:32:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i126so69872oih.4
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpH4TWYBlIFZvBNSrmqit1anbb5AAWHiKs0HcYRZXQk=;
        b=TW2EMHmPmrMrBEyLy3k4gdiPUYyoHoQidmX3DHJewfZ3jbVWbh9vf8UgcviHwB4o8F
         itboAQ7WquF8uBw7/r0XRePLQ5qyBMuo9yrFXNkWY9IP6370oExqxV43pQUxm1gEdqm+
         3x66DNoHap2iaicdogd9MZ5X7lIoji6df+EIF0vCS4nI05m1ZfS0NK4M9h1Asaq2aQJG
         ebKtxIhWL9dwLG3DoaPrrG6fWISyIHDu8IXtlYMm/mrnWzOSh+41E7Bd6QlxHQ5p+Ual
         mIY1joqdEGe9lzixTfNfkKe43MAv4iVkkESMz6OJKKvx0lBHPt0vBNc4A0+5/zrzDL+j
         Ni0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpH4TWYBlIFZvBNSrmqit1anbb5AAWHiKs0HcYRZXQk=;
        b=oOGDIMlbe9/WFa3AOvMF6zgqngczRXTpBbAiMmdZChlztBiXo4od0fHSoUe8Fhm+lT
         gC1cgDerJt21vdcqFf4GgUHtuE2Okimjxk9LPLl1yJ8LD5ct2+YG6EUIDPpKFdvMJVXE
         QiY+IsRwDGXbliXn9zKsbynogbM/9tBXGI4m9RWhSWOC/Rs7nPfd5IdHONVICLzdvZHc
         K0u/xRaCzI3Qo4NyGlBgBe2wIYToaJaMpXtt8cYrszmso1Ppt742UZMVSFzJBe1sEiDS
         JglZH2UYQKihjM3CyhuEYBZr2gSZjySXfucshmaGRTBAht8lrWJ8UBDeDNFYcuCbz2YU
         jIfQ==
X-Gm-Message-State: AJIora9HcqVUVMV5CJBClM6/Bh0CoGWa7W6lRk4mkqLTHV3HX374rlCe
        PM5GUi8xnuxaoa4cncGYFKWxqA==
X-Google-Smtp-Source: AGRyM1uai9ygiORxQYescxpIL5sNtxikvFY62X4TqUOL1GeLpMUi5h15AWJ5eoen3icOpijsW3DZgw==
X-Received: by 2002:a05:6808:1509:b0:336:77e:d668 with SMTP id u9-20020a056808150900b00336077ed668mr950536oiw.71.1657312346279;
        Fri, 08 Jul 2022 13:32:26 -0700 (PDT)
Received: from fedora.. ([143.107.182.242])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b0061c309b1dc2sm742225otb.39.2022.07.08.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:32:25 -0700 (PDT)
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
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH v5 7/9] drm: selftest: convert drm_framebuffer selftest to KUnit
Date:   Fri,  8 Jul 2022 17:30:50 -0300
Message-Id: <20220708203052.236290-8-maira.canal@usp.br>
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
DRM framebuffer selftest to the KUnit API.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |  5 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  9 ---
 .../drm/selftests/test-drm_modeset_common.c   | 32 --------
 .../drm/selftests/test-drm_modeset_common.h   | 21 -----
 drivers/gpu/drm/tests/Makefile                |  2 +-
 .../drm_framebuffer_test.c}                   | 77 ++++++++++++-------
 6 files changed, 53 insertions(+), 93 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
 rename drivers/gpu/drm/{selftests/test-drm_framebuffer.c => tests/drm_framebuffer_test.c} (86%)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 1539f55db9a7..f7db628b60cb 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test-drm_modeset-y := test-drm_modeset_common.o test-drm_framebuffer.o
-
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
-				    test-drm_buddy.o
+obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
deleted file mode 100644
index 40a29b8cf386..000000000000
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(name, function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_selftests_helper
- */
-selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.c b/drivers/gpu/drm/selftests/test-drm_modeset_common.c
deleted file mode 100644
index 2a7f93774006..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Common file for modeset selftests.
- */
-
-#include <linux/module.h>
-
-#include "test-drm_modeset_common.h"
-
-#define TESTS "drm_modeset_selftests.h"
-#include "drm_selftest.h"
-
-#include "drm_selftest.c"
-
-static int __init test_drm_modeset_init(void)
-{
-	int err;
-
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
-
-	return err > 0 ? 0 : err;
-}
-
-static void __exit test_drm_modeset_exit(void)
-{
-}
-
-module_init(test_drm_modeset_init);
-module_exit(test_drm_modeset_exit);
-
-MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
deleted file mode 100644
index 3feb2fea1a6b..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __TEST_DRM_MODESET_COMMON_H__
-#define __TEST_DRM_MODESET_COMMON_H__
-
-#include <linux/errno.h>
-#include <linux/printk.h>
-
-#define FAIL(test, msg, ...) \
-	do { \
-		if (test) { \
-			pr_err("%s/%u: " msg, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
-			return -EINVAL; \
-		} \
-	} while (0)
-
-#define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
-
-int igt_check_drm_framebuffer_create(void *ignored);
-
-#endif
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 5ffacd3eacf3..4cbfd9098d56 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
 	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o \
-	drm_dp_mst_helper_test.o
+	drm_dp_mst_helper_test.o drm_framebuffer_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/tests/drm_framebuffer_test.c
similarity index 86%
rename from drivers/gpu/drm/selftests/test-drm_framebuffer.c
rename to drivers/gpu/drm/tests/drm_framebuffer_test.c
index f6d66285c5fc..ec7a08ba4056 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/tests/drm_framebuffer_test.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Test cases for the drm_framebuffer functions
+ *
+ * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
  */
 
-#include <linux/kernel.h>
+#include <kunit/test.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_mode.h>
@@ -12,8 +14,6 @@
 
 #include "../drm_crtc_internal.h"
 
-#include "test-drm_modeset_common.h"
-
 #define MIN_WIDTH 4
 #define MAX_WIDTH 4096
 #define MIN_HEIGHT 4
@@ -73,12 +73,14 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 },
 { .buffer_created = 0, .name = "ABGR8888 Out of bound height * pitch combination",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_ABGR8888,
-		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX - 1, 0, 0 }, .pitches = { 4 * MAX_WIDTH, 0, 0 },
+		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX - 1, 0, 0 },
+		 .pitches = { 4 * MAX_WIDTH, 0, 0 },
 	}
 },
 { .buffer_created = 1, .name = "ABGR8888 Large buffer offset",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_ABGR8888,
-		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX / 2, 0, 0 }, .pitches = { 4 * MAX_WIDTH, 0, 0 },
+		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX / 2, 0, 0 },
+		 .pitches = { 4 * MAX_WIDTH, 0, 0 },
 	}
 },
 { .buffer_created = 1, .name = "ABGR8888 Set DRM_MODE_FB_MODIFIERS without modifiers",
@@ -89,11 +91,13 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 },
 { .buffer_created = 1, .name = "ABGR8888 Valid buffer modifier",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_ABGR8888,
-		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX / 2, 0, 0 }, .pitches = { 4 * MAX_WIDTH, 0, 0 },
-		 .flags = DRM_MODE_FB_MODIFIERS, .modifier = { AFBC_FORMAT_MOD_YTR, 0, 0 },
+		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX / 2, 0, 0 },
+		 .pitches = { 4 * MAX_WIDTH, 0, 0 }, .flags = DRM_MODE_FB_MODIFIERS,
+		 .modifier = { AFBC_FORMAT_MOD_YTR, 0, 0 },
 	}
 },
-{ .buffer_created = 0, .name = "ABGR8888 Invalid buffer modifier(DRM_FORMAT_MOD_SAMSUNG_64_32_TILE)",
+{ .buffer_created = 0,
+	.name = "ABGR8888 Invalid buffer modifier(DRM_FORMAT_MOD_SAMSUNG_64_32_TILE)",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_ABGR8888,
 		 .handles = { 1, 0, 0 }, .offsets = { UINT_MAX / 2, 0, 0 },
 		 .pitches = { 4 * MAX_WIDTH, 0, 0 }, .flags = DRM_MODE_FB_MODIFIERS,
@@ -143,7 +147,8 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 { .buffer_created = 1, .name = "NV12 with DRM_FORMAT_MOD_SAMSUNG_64_32_TILE",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_NV12,
 		 .handles = { 1, 1, 0 }, .flags = DRM_MODE_FB_MODIFIERS,
-		 .modifier = { DRM_FORMAT_MOD_SAMSUNG_64_32_TILE, DRM_FORMAT_MOD_SAMSUNG_64_32_TILE, 0 },
+		 .modifier = { DRM_FORMAT_MOD_SAMSUNG_64_32_TILE,
+			 DRM_FORMAT_MOD_SAMSUNG_64_32_TILE, 0 },
 		 .pitches = { MAX_WIDTH, MAX_WIDTH, 0 },
 	}
 },
@@ -164,7 +169,8 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 },
 { .buffer_created = 0, .name = "NV12 Handle for inexistent plane",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_NV12,
-		 .handles = { 1, 1, 1 }, .flags = DRM_MODE_FB_MODIFIERS, .pitches = { MAX_WIDTH, MAX_WIDTH, 0 },
+		 .handles = { 1, 1, 1 }, .flags = DRM_MODE_FB_MODIFIERS,
+		 .pitches = { MAX_WIDTH, MAX_WIDTH, 0 },
 	}
 },
 { .buffer_created = 1, .name = "NV12 Handle for inexistent plane without DRM_MODE_FB_MODIFIERS",
@@ -203,24 +209,29 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 },
 { .buffer_created = 1, .name = "YVU420 Different buffer offsets/pitches",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
-		 .handles = { 1, 1, 1 }, .offsets = { MAX_WIDTH, MAX_WIDTH  + MAX_WIDTH * MAX_HEIGHT,
-						      MAX_WIDTH  + 2 * MAX_WIDTH * MAX_HEIGHT },
-		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2) + 1, DIV_ROUND_UP(MAX_WIDTH, 2) + 7 },
+		 .handles = { 1, 1, 1 }, .offsets = { MAX_WIDTH, MAX_WIDTH  +
+			 MAX_WIDTH * MAX_HEIGHT, MAX_WIDTH  + 2 * MAX_WIDTH * MAX_HEIGHT },
+		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2) + 1,
+			 DIV_ROUND_UP(MAX_WIDTH, 2) + 7 },
 	}
 },
-{ .buffer_created = 0, .name = "YVU420 Modifier set just for plane 0, without DRM_MODE_FB_MODIFIERS",
+{ .buffer_created = 0,
+	.name = "YVU420 Modifier set just for plane 0, without DRM_MODE_FB_MODIFIERS",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
 		 .handles = { 1, 1, 1 }, .modifier = { AFBC_FORMAT_MOD_SPARSE, 0, 0 },
 		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2), DIV_ROUND_UP(MAX_WIDTH, 2) },
 	}
 },
-{ .buffer_created = 0, .name = "YVU420 Modifier set just for planes 0, 1, without DRM_MODE_FB_MODIFIERS",
+{ .buffer_created = 0,
+	.name = "YVU420 Modifier set just for planes 0, 1, without DRM_MODE_FB_MODIFIERS",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
-		 .handles = { 1, 1, 1 }, .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE, 0 },
+		 .handles = { 1, 1, 1 },
+		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE, 0 },
 		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2), DIV_ROUND_UP(MAX_WIDTH, 2) },
 	}
 },
-{ .buffer_created = 0, .name = "YVU420 Modifier set just for plane 0, 1, with DRM_MODE_FB_MODIFIERS",
+{ .buffer_created = 0,
+	.name = "YVU420 Modifier set just for plane 0, 1, with DRM_MODE_FB_MODIFIERS",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
 		 .handles = { 1, 1, 1 }, .flags = DRM_MODE_FB_MODIFIERS,
 		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE, 0 },
@@ -230,7 +241,8 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 { .buffer_created = 1, .name = "YVU420 Valid modifier",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
 		 .handles = { 1, 1, 1 }, .flags = DRM_MODE_FB_MODIFIERS,
-		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE },
+		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE,
+			 AFBC_FORMAT_MOD_SPARSE },
 		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2), DIV_ROUND_UP(MAX_WIDTH, 2) },
 	}
 },
@@ -245,8 +257,8 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 { .buffer_created = 0, .name = "YVU420 Modifier for inexistent plane",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_YVU420,
 		 .handles = { 1, 1, 1 }, .flags = DRM_MODE_FB_MODIFIERS,
-		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE,
-			       AFBC_FORMAT_MOD_SPARSE },
+		 .modifier = { AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE,
+			 AFBC_FORMAT_MOD_SPARSE, AFBC_FORMAT_MOD_SPARSE },
 		 .pitches = { MAX_WIDTH, DIV_ROUND_UP(MAX_WIDTH, 2), DIV_ROUND_UP(MAX_WIDTH, 2) },
 	}
 },
@@ -276,7 +288,8 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
 		 .pitches = { 2 * MAX_WIDTH + 1, 0, 0 }
 	}
 },
-{ .buffer_created = 1, .name = "X0L2 Offset for inexistent plane, without DRM_MODE_FB_MODIFIERS set",
+{ .buffer_created = 1,
+	.name = "X0L2 Offset for inexistent plane, without DRM_MODE_FB_MODIFIERS set",
 	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_X0L2,
 		 .handles = { 1, 0, 0 }, .offsets = { 0, 0, 3 },
 		 .pitches = { 2 * MAX_WIDTH + 1, 0, 0 }
@@ -336,15 +349,27 @@ static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
 	return buffer_created;
 }
 
-int igt_check_drm_framebuffer_create(void *ignored)
+static void igt_check_drm_framebuffer_create(struct kunit *test)
 {
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(createbuffer_tests); i++) {
-		FAIL(createbuffer_tests[i].buffer_created !=
-				execute_drm_mode_fb_cmd2(&createbuffer_tests[i].cmd),
+		KUNIT_EXPECT_EQ_MSG(test, createbuffer_tests[i].buffer_created,
+				    execute_drm_mode_fb_cmd2(&createbuffer_tests[i].cmd),
 		     "Test %d: \"%s\" failed\n", i, createbuffer_tests[i].name);
 	}
-
-	return 0;
 }
+
+static struct kunit_case drm_framebuffer_tests[] = {
+	KUNIT_CASE(igt_check_drm_framebuffer_create),
+	{ }
+};
+
+static struct kunit_suite drm_framebuffer_test_suite = {
+	.name = "drm_framebuffer",
+	.test_cases = drm_framebuffer_tests,
+};
+
+kunit_test_suite(drm_framebuffer_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.35.3

