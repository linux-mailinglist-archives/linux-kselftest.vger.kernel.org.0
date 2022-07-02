Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3356403D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiGBNMS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGBNMR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 09:12:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C2A458
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 06:12:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s188so6878046oib.6
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QH1ysce7a4iPy25QjHmNOoS7mfHhmICJAkNX6mxrFQ0=;
        b=o5N7CMIk9f/8DrOzrncHZ/e3348kDZwNfpyJzUvaM7P1nh4+0IfSXvAlOgUK4+Nt+3
         MbpjFhfJn0qZSLWSOMbN17aqts3eAdmjRoGvToh64rojZa4+zBU3a6PjcTAvhoEYMfGL
         pRcH/9I4cMVXIrwELu6aLQh8R3o3Eb2ranltVbEJIMMvvKSvfqoTIcwQqkVYNu8Kabwm
         N8ph8NCAgEgKvx1kxsUMrNnJhHx0M8ofXHOBuOHRK8Uvc4u1zO+6q67CW1xfPN6HKYgy
         SvvMa+SQMu4g4/pCRBpuf4/RuNEZ50R5JiNQm+e1uSuGdI9+qD/DFNwfOcD3jg4+MH+I
         BAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QH1ysce7a4iPy25QjHmNOoS7mfHhmICJAkNX6mxrFQ0=;
        b=p5lr+sEKyb69eWnAKwkE31TLc8AyS5MZG7T6hDYNOfwCjHp9kDW0ZDkoyPG1g7z6OZ
         yXgILMqaUhm/okBbJinn8o7iFB5BrFpuhMRGgDqvjcMJDhC0+D/GZcGQz5q+iPB/PsFp
         jKiVDH4lUD8ExF2oWniB7E0fY+6FAKYR3SZcgo5bHHLxKwO7Q64e6f4/tUlJuq2KECC6
         Hv9P2SiRkkYWH53x9hSIYthN3TlSOo+9dtbboCw5xtWi760lUzy4HEdNVoaO+73IxeVY
         xZOhifJ5Cyv3M53UA+LM6CTtl+XNe5yTsM5ue5diT3c/7r7ZcYd6RUwLjxCML+kBWz8Q
         tqHw==
X-Gm-Message-State: AJIora9BlWuTamqTHJ3RntpEmAw3LALHaIlpi0aPgKGOhommwPpQsTVV
        Vk+0accWQUjN0V2owcdtucnQ/Q==
X-Google-Smtp-Source: AGRyM1tx2PjaWXjxTwkZVpy+OQ322PfKLU13J/oDE/RuC2R1VFHTd5BT4WWawEdiYxrf8XVKd7Oi/A==
X-Received: by 2002:a05:6808:f8b:b0:335:c440:ff3c with SMTP id o11-20020a0568080f8b00b00335c440ff3cmr7894861oiw.251.1656767533041;
        Sat, 02 Jul 2022 06:12:13 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d718d000000b00616afb1f1e2sm12643206otj.19.2022.07.02.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 06:12:12 -0700 (PDT)
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
Subject: [PATCH v4 3/9] drm: selftest: convert drm_rect selftest to KUnit
Date:   Sat,  2 Jul 2022 10:11:10 -0300
Message-Id: <20220702131116.457444-4-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220702131116.457444-1-maira.canal@usp.br>
References: <20220702131116.457444-1-maira.canal@usp.br>
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

Co-developed-by: Carlos Veras <carlos.craveiro@usp.br>
Signed-off-by: Carlos Veras <carlos.craveiro@usp.br>
Co-developed-by: Matheus Vieira <matheus.vieira.g@usp.br>
Signed-off-by: Matheus Vieira <matheus.vieira.g@usp.br>
Tested-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   2 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   4 -
 .../drm/selftests/test-drm_modeset_common.h   |   4 -
 drivers/gpu/drm/tests/Makefile                |   2 +-
 .../test-drm_rect.c => tests/drm_rect_test.c} | 125 ++++++++++--------
 5 files changed, 69 insertions(+), 68 deletions(-)
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
index 3a5ff38321f4..66f11b63e06b 100644
--- a/drivers/gpu/drm/selftests/test-drm_rect.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -1,17 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Test cases for the drm_rect functions
+ *
+ * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
  */
 
-#define pr_fmt(fmt) "drm_rect: " fmt
-
-#include <linux/limits.h>
+#include <kunit/test.h>
 
 #include <drm/drm_rect.h>
 
-#include "test-drm_modeset_common.h"
-
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
+static void igt_drm_rect_clip_scaled_div_by_zero(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -24,20 +22,20 @@ int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
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
@@ -49,14 +47,14 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
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
@@ -65,14 +63,14 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
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
@@ -81,19 +79,17 @@ int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
 
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
@@ -105,14 +101,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -121,14 +117,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -137,14 +133,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -153,14 +149,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -169,14 +165,14 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -185,19 +181,17 @@ int igt_drm_rect_clip_scaled_clipped(void *ignored)
 
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
@@ -216,8 +210,23 @@ int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
 
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

