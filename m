Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26256C37A
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiGHUbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiGHUbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 16:31:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FD9CE36
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 13:31:44 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10c0119dd16so57913fac.6
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTaWLiICbVytGNbdL4/jJ2tdjKgRvLW/Lx3Y/K1eO2Y=;
        b=JoIyJdRLCpd6+ynNar8tPnGUd1Yf1GIANxQb5oLH/Y8RHTOIGOePZ9qv7mEamVfoew
         YV8VAvMJAYfGG1yDeBzVRWQuHuJ9gMjHUFHC/bnVoH34RTvGkIFtzg6ttq9jb8Q6cSLf
         ql9Qyntw/oSMxyffSZbtrTp+bAVh6RMGAp6sj1/hXNK/x8DxhuqS/9hu5SZfxzHs7xPj
         JGlHN32oiU64AqrhaMn/uOrpO3rdAQFv9YGuxMlM1Sx2UWnTBG+f5fDyEIEiUBpA6MxQ
         FuOxkm16theBMrOqnu7I6sZy2G74pZSPjMpWQpERLdkDbHAk6pGlUJf1p9wHHpxxvazf
         MQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTaWLiICbVytGNbdL4/jJ2tdjKgRvLW/Lx3Y/K1eO2Y=;
        b=KPH6Y2k02byde4CxKPRTpsh4rTrXhG4IrULhrMuEfzPYnSvqSQ/Gu5gFMvaiWb5Oxu
         la4R6Y3JvoQQn2IaV1C3XksjYUnbJbqG2Yr8K+wOi4o+/t6aPq+bibc2hH4YiNcl2AsB
         rrXtjesdpi5RMSYgozgeSzm7Kip7w7MEGbGATtLg4vJ0KpmkSTWzq5tFfpOYzv8KAxTD
         DJ3voIVfFg4MTJhU5DedKTlLKy2Ty/sB8PDnx0wIKN+tRmclH6i0UVcga8a8Hl7D9tBJ
         iFOLotQD5+baF1p4T13DhJVFKaQZRHJN+91ywYwvYtQzcdCvFYhFKrqnHi1v5baBfvdn
         d4tQ==
X-Gm-Message-State: AJIora8eKjYui1IkbQkDKI03Ne5iRw6gdVdhgPmQ6+2QdRxb1DgOK7xj
        g3TyB7OI95dULp3jT0ojJsoqZw==
X-Google-Smtp-Source: AGRyM1uGfXiUjMoBtP4xviVn+pviz0EpozLlh2oiIAUSFrPCHIlD5d60wUKEHjtEN/7l62JRIp6bsg==
X-Received: by 2002:a05:6870:e997:b0:10c:66f1:8bbb with SMTP id r23-20020a056870e99700b0010c66f18bbbmr982399oao.243.1657312303687;
        Fri, 08 Jul 2022 13:31:43 -0700 (PDT)
Received: from fedora.. ([143.107.182.242])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b0061c309b1dc2sm742225otb.39.2022.07.08.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:31:43 -0700 (PDT)
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
Subject: [PATCH v5 3/9] drm: selftest: convert drm_rect selftest to KUnit
Date:   Fri,  8 Jul 2022 17:30:46 -0300
Message-Id: <20220708203052.236290-4-maira.canal@usp.br>
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
 drivers/gpu/drm/selftests/test-drm_rect.c     | 223 ------------------
 drivers/gpu/drm/tests/Makefile                |   2 +-
 drivers/gpu/drm/tests/drm_rect_test.c         | 214 +++++++++++++++++
 6 files changed, 216 insertions(+), 233 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
 create mode 100644 drivers/gpu/drm/tests/drm_rect_test.c

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
diff --git a/drivers/gpu/drm/selftests/test-drm_rect.c b/drivers/gpu/drm/selftests/test-drm_rect.c
deleted file mode 100644
index 3a5ff38321f4..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_rect.c
+++ /dev/null
@@ -1,223 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Test cases for the drm_rect functions
- */
-
-#define pr_fmt(fmt) "drm_rect: " fmt
-
-#include <linux/limits.h>
-
-#include <drm/drm_rect.h>
-
-#include "test-drm_modeset_common.h"
-
-int igt_drm_rect_clip_scaled_div_by_zero(void *ignored)
-{
-	struct drm_rect src, dst, clip;
-	bool visible;
-
-	/*
-	 * Make sure we don't divide by zero when dst
-	 * width/height is zero and dst and clip do not intersect.
-	 */
-	drm_rect_init(&src, 0, 0, 0, 0);
-	drm_rect_init(&dst, 0, 0, 0, 0);
-	drm_rect_init(&clip, 1, 1, 1, 1);
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
-
-	drm_rect_init(&src, 0, 0, 0, 0);
-	drm_rect_init(&dst, 3, 3, 0, 0);
-	drm_rect_init(&clip, 1, 1, 1, 1);
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-	FAIL(visible, "Destination not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
-
-	return 0;
-}
-
-int igt_drm_rect_clip_scaled_not_clipped(void *ignored)
-{
-	struct drm_rect src, dst, clip;
-	bool visible;
-
-	/* 1:1 scaling */
-	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
-	drm_rect_init(&dst, 0, 0, 1, 1);
-	drm_rect_init(&clip, 0, 0, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 2:1 scaling */
-	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
-	drm_rect_init(&dst, 0, 0, 1, 1);
-	drm_rect_init(&clip, 0, 0, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
-	     src.y1 != 0 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 1:2 scaling */
-	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 0, 0, 2, 2);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
-	     dst.y1 != 0 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
-}
-
-int igt_drm_rect_clip_scaled_clipped(void *ignored)
-{
-	struct drm_rect src, dst, clip;
-	bool visible;
-
-	/* 1:1 scaling top/left clip */
-	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 0, 0, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 1:1 scaling bottom/right clip */
-	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 1, 1, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
-	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
-	     dst.y1 != 1 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 2:1 scaling top/left clip */
-	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 0, 0, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 2 << 16 ||
-	     src.y1 != 0 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 1 ||
-	     dst.y1 != 0 || dst.y2 != 1,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 2:1 scaling bottom/right clip */
-	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 1, 1, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 2 << 16 || src.x2 != 4 << 16 ||
-	     src.y1 != 2 << 16 || src.y2 != 4 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 1 || dst.x2 != 2 ||
-	     dst.y1 != 1 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 1:2 scaling top/left clip */
-	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
-	drm_rect_init(&dst, 0, 0, 4, 4);
-	drm_rect_init(&clip, 0, 0, 2, 2);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 0 || src.x2 != 1 << 16 ||
-	     src.y1 != 0 || src.y2 != 1 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 0 || dst.x2 != 2 ||
-	     dst.y1 != 0 || dst.y2 != 2,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	/* 1:2 scaling bottom/right clip */
-	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
-	drm_rect_init(&dst, 0, 0, 4, 4);
-	drm_rect_init(&clip, 2, 2, 2, 2);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
-	     src.y1 != 1 << 16 || src.y2 != 2 << 16,
-	     "Source badly clipped\n");
-	FAIL(dst.x1 != 2 || dst.x2 != 4 ||
-	     dst.y1 != 2 || dst.y2 != 4,
-	     "Destination badly clipped\n");
-	FAIL(!visible, "Destination should be visible\n");
-	FAIL(!drm_rect_visible(&src), "Source should be visible\n");
-
-	return 0;
-}
-
-int igt_drm_rect_clip_scaled_signed_vs_unsigned(void *ignored)
-{
-	struct drm_rect src, dst, clip;
-	bool visible;
-
-	/*
-	 * 'clip.x2 - dst.x1 >= dst width' could result a negative
-	 * src rectangle width which is no longer expected by the
-	 * code as it's using unsigned types. This could lead to
-	 * the clipped source rectangle appering visible when it
-	 * should have been fully clipped. Make sure both rectangles
-	 * end up invisible.
-	 */
-	drm_rect_init(&src, 0, 0, INT_MAX, INT_MAX);
-	drm_rect_init(&dst, 0, 0, 2, 2);
-	drm_rect_init(&clip, 3, 3, 1, 1);
-
-	visible = drm_rect_clip_scaled(&src, &dst, &clip);
-
-	FAIL(visible, "Destination should not be visible\n");
-	FAIL(drm_rect_visible(&src), "Source should not be visible\n");
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index b3e73d674c67..f2eced30a955 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
-	drm_cmdline_parser_test.o
+	drm_cmdline_parser_test.o drm_rect_test.o
diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
new file mode 100644
index 000000000000..c1dbefd49a4c
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for the drm_rect functions
+ *
+ * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
+ */
+
+#include <kunit/test.h>
+
+#include <drm/drm_rect.h>
+
+static void igt_drm_rect_clip_scaled_div_by_zero(struct kunit *test)
+{
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/*
+	 * Make sure we don't divide by zero when dst
+	 * width/height is zero and dst and clip do not intersect.
+	 */
+	drm_rect_init(&src, 0, 0, 0, 0);
+	drm_rect_init(&dst, 0, 0, 0, 0);
+	drm_rect_init(&clip, 1, 1, 1, 1);
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+
+	drm_rect_init(&src, 0, 0, 0, 0);
+	drm_rect_init(&dst, 3, 3, 0, 0);
+	drm_rect_init(&clip, 1, 1, 1, 1);
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+}
+
+static void igt_drm_rect_clip_scaled_not_clipped(struct kunit *test)
+{
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/* 1:1 scaling */
+	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
+	drm_rect_init(&dst, 0, 0, 1, 1);
+	drm_rect_init(&clip, 0, 0, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
+			       src.y1 != 0 || src.y2 != 1 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
+			       dst.y1 != 0 || dst.y2 != 1, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 2:1 scaling */
+	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
+	drm_rect_init(&dst, 0, 0, 1, 1);
+	drm_rect_init(&clip, 0, 0, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 2 << 16 ||
+			       src.y1 != 0 || src.y2 != 2 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
+			       dst.y1 != 0 || dst.y2 != 1, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 1:2 scaling */
+	drm_rect_init(&src, 0, 0, 1 << 16, 1 << 16);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 0, 0, 2, 2);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
+			       src.y1 != 0 || src.y2 != 1 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 2 ||
+			       dst.y1 != 0 || dst.y2 != 2, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+}
+
+static void igt_drm_rect_clip_scaled_clipped(struct kunit *test)
+{
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/* 1:1 scaling top/left clip */
+	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 0, 0, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
+			       src.y1 != 0 || src.y2 != 1 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 ||
+			       dst.y1 != 0 || dst.y2 != 1, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 1:1 scaling bottom/right clip */
+	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 1, 1, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
+			       src.y1 != 1 << 16 || src.y2 != 2 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 1 || dst.x2 != 2 || dst.y1 != 1 ||
+			       dst.y2 != 2, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 2:1 scaling top/left clip */
+	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 0, 0, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 2 << 16 ||
+			       src.y1 != 0 || src.y2 != 2 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 1 || dst.y1 != 0 ||
+			       dst.y2 != 1, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 2:1 scaling bottom/right clip */
+	drm_rect_init(&src, 0, 0, 4 << 16, 4 << 16);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 1, 1, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 2 << 16 || src.x2 != 4 << 16 ||
+			       src.y1 != 2 << 16 || src.y2 != 4 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 1 || dst.x2 != 2 || dst.y1 != 1 ||
+			       dst.y2 != 2, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 1:2 scaling top/left clip */
+	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
+	drm_rect_init(&dst, 0, 0, 4, 4);
+	drm_rect_init(&clip, 0, 0, 2, 2);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 0 || src.x2 != 1 << 16 ||
+			       src.y1 != 0 || src.y2 != 1 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 0 || dst.x2 != 2 || dst.y1 != 0 ||
+			       dst.y2 != 2, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+
+	/* 1:2 scaling bottom/right clip */
+	drm_rect_init(&src, 0, 0, 2 << 16, 2 << 16);
+	drm_rect_init(&dst, 0, 0, 4, 4);
+	drm_rect_init(&clip, 2, 2, 2, 2);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, src.x1 != 1 << 16 || src.x2 != 2 << 16 ||
+			       src.y1 != 1 << 16 || src.y2 != 2 << 16, "Source badly clipped\n");
+	KUNIT_EXPECT_FALSE_MSG(test, dst.x1 != 2 || dst.x2 != 4 || dst.y1 != 2 ||
+			       dst.y2 != 4, "Destination badly clipped\n");
+	KUNIT_EXPECT_TRUE_MSG(test, visible, "Destination should be visible\n");
+	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
+}
+
+static void igt_drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
+{
+	struct drm_rect src, dst, clip;
+	bool visible;
+
+	/*
+	 * 'clip.x2 - dst.x1 >= dst width' could result a negative
+	 * src rectangle width which is no longer expected by the
+	 * code as it's using unsigned types. This could lead to
+	 * the clipped source rectangle appering visible when it
+	 * should have been fully clipped. Make sure both rectangles
+	 * end up invisible.
+	 */
+	drm_rect_init(&src, 0, 0, INT_MAX, INT_MAX);
+	drm_rect_init(&dst, 0, 0, 2, 2);
+	drm_rect_init(&clip, 3, 3, 1, 1);
+
+	visible = drm_rect_clip_scaled(&src, &dst, &clip);
+
+	KUNIT_EXPECT_FALSE_MSG(test, visible, "Destination should not be visible\n");
+	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
+}
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
2.35.3

