Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087C560E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiF3As6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF3As4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 20:48:56 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C25403D3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:48:50 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101d2e81bceso23826683fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m718tsZf56Uw3dYaEg+gFx3+cMC7NUNk9+sdBldHrpo=;
        b=lL2eNnBVSe3AsqfWlyujqj5y2j35tgpsd/fbjzGFzefTLco3KUMRIP7BAwVQsZQ5Wz
         CMoLxUPMekw2tJjY4/uvE7jeuntT80UGfqH3sEVdtQudaO1CJh/ZXuINGRumDpl2XGTl
         ipbGRHz0jX+c5VPrLyoG4tdV+/e4dI/DHfCStTdipzsAeMbGa7pj1cVEVoFDKi7MZqyz
         +zYKnl9CwQxy48BNzTtL7XtCtydp+43j7++0AEkF/aphvTnCgDlJK6GmynMUdJ3wYu8Q
         07m5wlt5ouimrfuZnWOa80ev7Ljuv5qMLoeCDVY+7E6/s9tgzaoPeSIeJ0BfA4Q6BoC6
         JqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m718tsZf56Uw3dYaEg+gFx3+cMC7NUNk9+sdBldHrpo=;
        b=UafU9pQNYqn9GEjI4SjW64DnqUBcb3JMGmMcyOZdgMUZXSR5aL6fh6PAUlPQjc5LQO
         b821bdDDz817OmBYcZzrmUeMomABuCHH1i0X94eUM0N8Hi2rx/o589WLyVWydJdDpnXA
         GYiSk/CWHkGXcRSuPvJJezuaMpeTlu6DtOcoTu0arQkhZFPS1zeaqtaKIdZZx70HIvkX
         mg+W08pmavMrtduqFohNAcOxaVPKc/dbuUSB6XzaD4HfNO9Zy4m2J0w+B0KhFRiHT04f
         N69iKgYvGvTU4OAKYRYdjf5YFrQrh7hpF6PXaxY5Eqnh4sgqrdZZK5Z4FnM1doJQaOol
         xg7w==
X-Gm-Message-State: AJIora9JBLOihztKq8KWsewpvBGvM1R+gnJTHAsGil7u6+1Gyx3WoFn4
        cOghK7HU6lJTM3jg/gqxSTEP4A==
X-Google-Smtp-Source: AGRyM1vR85JJTRol56GiSDArhmw5HNz18/X2R2KoEpQoXhTA7ptoG7krC1DoUX8gTK1btptd9ELpOA==
X-Received: by 2002:a05:6870:340b:b0:ee:37af:2722 with SMTP id g11-20020a056870340b00b000ee37af2722mr3734660oah.91.1656550129792;
        Wed, 29 Jun 2022 17:48:49 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id r10-20020a056808210a00b00325cda1ff8esm9432250oiw.13.2022.06.29.17.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:48:49 -0700 (PDT)
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
        Carlos Veras <carlos.craveiro@usp.br>,
        Matheus Vieira <matheus.vieira.g@usp.br>
Subject: [PATCH v3 3/9] drm: selftest: convert drm_rect selftest to KUnit
Date:   Wed, 29 Jun 2022 21:46:05 -0300
Message-Id: <20220630004611.114441-4-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630004611.114441-1-maira.canal@usp.br>
References: <20220630004611.114441-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Considering the current adoption of the KUnit framework, convert the
DRM rect selftest to the KUnit API.

Acked-by: Daniel Latypov <dlatypov@google.com>
Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Carlos Veras <carlos.craveiro@usp.br>
Signed-off-by: Carlos Veras <carlos.craveiro@usp.br>
Co-developed-by: Matheus Vieira <matheus.vieira.g@usp.br>
Signed-off-by: Matheus Vieira <matheus.vieira.g@usp.br>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   2 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   4 -
 .../drm/selftests/test-drm_modeset_common.h   |   4 -
 drivers/gpu/drm/tests/Makefile                |   2 +-
 .../test-drm_rect.c => tests/drm_rect_test.c} | 124 +++++++++---------
 5 files changed, 67 insertions(+), 69 deletions(-)
 rename drivers/gpu/drm/{selftests/test-drm_rect.c => tests/drm_rect_test.c} (53%)

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 8633bb9ea717..8a794914e328 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
-		      test-drm_dp_mst_helper.o test-drm_rect.o
+		      test-drm_dp_mst_helper.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
 				    test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 4787b3b70709..a3ca90307364 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -6,10 +6,6 @@
  *
  * Tests are executed in order by igt/drm_selftests_helper
  */
-selftest(drm_rect_clip_scaled_div_by_zero, igt_drm_rect_clip_scaled_div_by_zero)
-selftest(drm_rect_clip_scaled_not_clipped, igt_drm_rect_clip_scaled_not_clipped)
-selftest(drm_rect_clip_scaled_clipped, igt_drm_rect_clip_scaled_clipped)
-selftest(drm_rect_clip_scaled_signed_vs_unsigned, igt_drm_rect_clip_scaled_signed_vs_unsigned)
 selftest(check_plane_state, igt_check_plane_state)
 selftest(check_drm_format_block_width, igt_check_drm_format_block_width)
 selftest(check_drm_format_block_height, igt_check_drm_format_block_height)
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index c29354e59cec..42a10d7da51c 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -16,10 +16,6 @@
 
 #define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
 
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored);
-int igt_drm_rect_clip_scaled_not_clipped(void *ignored);
-int igt_drm_rect_clip_scaled_clipped(void *ignored);
-int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored);
 int igt_check_plane_state(void *ignored);
 int igt_check_drm_format_block_width(void *ignored);
 int igt_check_drm_format_block_height(void *ignored);
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index b3e73d674c67..f2eced30a955 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
-	drm_cmdline_parser_test.o
+	drm_cmdline_parser_test.o drm_rect_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_rect.c b/drivers/gpu/drm/tests/drm_rect_test.c
similarity index 53%
rename from drivers/gpu/drm/selftests/test-drm_rect.c
rename to drivers/gpu/drm/tests/drm_rect_test.c
index 3a5ff38321f4..314dab502e7e 100644
--- a/drivers/gpu/drm/selftests/test-drm_rect.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -3,15 +3,10 @@
  * Test cases for the drm_rect functions
  */
 
-#define pr_fmt(fmt) "drm_rect: " fmt
-
-#include <linux/limits.h>
-
+#include <kunit/test.h>
 #include <drm/drm_rect.h>
 
-#include "test-drm_modeset_common.h"
-
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
+static void igt_drm_rect_clip_scaled_div_by_zero(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -24,20 +19,20 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
 	drm_rect_init(&dst, 0, 0, 0, 0);
 	drm_rect_init(&clip, 1, 1, 1, 1);
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
+
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 
 	drm_rect_init(&src, 0, 0, 0, 0);
 	drm_rect_init(&dst, 3, 3, 0, 0);
 	drm_rect_init(&clip, 1, 1, 1, 1);
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
 
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
 
-int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
+static void igt_drm_rect_clip_scaled_not_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -49,14 +44,14 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
 	     src.y1 != 0 || src.y2 != 1 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
 	     dst.y1 != 0 || dst.y2 != 1,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 2:1 scaling */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -65,14 +60,14 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 2 << 16 ||
 	     src.y1 != 0 || src.y2 != 2 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
 	     dst.y1 != 0 || dst.y2 != 1,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 1:2 scaling */
 	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
@@ -81,19 +76,17 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
 	     src.y1 != 0 || src.y2 != 1 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 2 ||
 	     dst.y1 != 0 || dst.y2 != 2,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 }
 
-int igt_drm_rect_clip_scaled_clipped(void *ignored)
+static void igt_drm_rect_clip_scaled_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -105,14 +98,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
 	     src.y1 != 0 || src.y2 != 1 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
 	     dst.y1 != 0 || dst.y2 != 1,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 1:1 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -121,14 +114,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
 	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 1 || dst.x2 != 2 ||
 	     dst.y1 != 1 || dst.y2 != 2,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 2:1 scaling top/left clip */
 	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
@@ -137,14 +130,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 2 << 16 ||
 	     src.y1 != 0 || src.y2 != 2 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
 	     dst.y1 != 0 || dst.y2 != 1,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 2:1 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
@@ -153,14 +146,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 2 << 16 || src.x2 != 4 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 2 << 16 || src.x2 != 4 << 16 ||
 	     src.y1 != 2 << 16 || src.y2 != 4 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 1 || dst.x2 != 2 ||
 	     dst.y1 != 1 || dst.y2 != 2,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 1:2 scaling top/left clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -169,14 +162,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
 	     src.y1 != 0 || src.y2 != 1 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 2 ||
 	     dst.y1 != 0 || dst.y2 != 2,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 
 	/* 1:2 scaling bottom/right clip */
 	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
@@ -185,19 +178,17 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
 	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
 	     "Source badly clipped\n");
-	FAIL(dst.x1 != 2 || dst.x2 != 4 ||
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 2 || dst.x2 != 4 ||
 	     dst.y1 != 2 || dst.y2 != 4,
 	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 }
 
-int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
+static void igt_drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -216,8 +207,23 @@ int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
 
 	visible = drm_rect_clip_scaled(&src, &dst, &clip);
 
-	FAIL(visible, "Destination should not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
-
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
+
+static struct kunit_case drm_rect_tests[] = {
+	KUNIT_CASE(igt_drm_rect_clip_scaled_div_by_zero),
+	KUNIT_CASE(igt_drm_rect_clip_scaled_not_clipped),
+	KUNIT_CASE(igt_drm_rect_clip_scaled_clipped),
+	KUNIT_CASE(igt_drm_rect_clip_scaled_signed_vs_unsigned),
+	{ }
+};
+
+static struct kunit_suite drm_rect_test_suite = {
+	.name = "drm_rect",
+	.test_cases = drm_rect_tests,
+};
+
+kunit_test_suite(drm_rect_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.1

