Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038A553B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 22:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353802AbiFUUKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiFUUKm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 16:10:42 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DB2AE29
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-101ec2d6087so9314647fac.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8SAijqHGfk8f8mEK1ByB2OvcaeZTEqCktzZxPU+MYmI=;
        b=Vg9h1dlETOucWWL30iwCKu9VaA4pRQ0e39shXIrdJlWmnjA75kl0WRymXyROJQt7VT
         CpDj8dAn22gJP+8nVm2ZuCePHdYZVGXaoFfbCMa2/uA4pZ1qcmhNPbaCc2Xn8e+du14O
         h8ufVDGhacMa6OgOAEJ/BtqLtlX2PA3l1FJMKzxoP15ectGNh/PdbjG9cATr9LxAJbU9
         GHPbcnLI1LtCi7EPnNG0SCLz+QpaFCV81nEJl59cuUAU0pqkOVU4QnD3PJlh9RownRIZ
         Rfzhb2WCa4ynL5w+o7XcBy3EzBPRVHwRHaBbbOVvzN53KWlu+TfxHkB25J8XzIhc5JU5
         vxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8SAijqHGfk8f8mEK1ByB2OvcaeZTEqCktzZxPU+MYmI=;
        b=4DQPUDmMgShrBRw/3TXIWnpLuiNjJSLQMH0SHmfKe6ok7Sv+yNHofBo22Y5DS/H1TN
         RlnQhAyskGpNXzZC6P1fW3ndfmAgfboMD6gtiZmcsCjdXXx3IXclKnTmHtaT/52j7xeL
         qo8silcBjIRSiib4iJgypV/HuGWSdUSwKO6buhChCat/AUhYS73nMXXdGSd7GClNSSBi
         FsmVH07PO53mwAPz3hlZpk6fmvdB0jUq9QvK1I3SWkeiN1MmNOqiY9K8MxyfsAv9eNmI
         sS11COVsL0qULlEvaLWmJM/HC9Su+0lbvAk1tcFKe1IbPY20yPJoAFhKZzeigbPYjMlC
         kzoA==
X-Gm-Message-State: AJIora9ga+vilcm9+QuACv1kdnn2kNY/uULeZjks0uVAyJAAxpIN/rfw
        zVY0I2bPkb1O1Y0REaQkgomklA==
X-Google-Smtp-Source: AGRyM1tjVbJsER/ygkOt3McKYU3LPB3g1Nbi2O5Kqwi7LNYbvprgel4SqnWcIt+mxR7mGjsywWHeDg==
X-Received: by 2002:a05:6870:632a:b0:101:22a:59cd with SMTP id s42-20020a056870632a00b00101022a59cdmr22525914oao.274.1655842237681;
        Tue, 21 Jun 2022 13:10:37 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o206-20020acad7d7000000b0032b7a0c5da1sm9759771oig.27.2022.06.21.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:10:37 -0700 (PDT)
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
Subject: [PATCH v2 3/9] drm: selftest: convert drm_rect selftest to KUnit
Date:   Tue, 21 Jun 2022 17:09:20 -0300
Message-Id: <20220621200926.257002-4-maira.canal@usp.br>
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
DRM rect selftest to the KUnit API.

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
 drivers/gpu/drm/tests/Makefile                |   3 +-
 .../test-drm_rect.c => tests/drm_rect_test.c} | 124 +++++++++---------
 5 files changed, 68 insertions(+), 69 deletions(-)
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
index f9929ac10765..d413fbe6d710 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o drm_cmdline_parser_test.o
+obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o drm_cmdline_parser_test.o \
+	drm_rect_test.o
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

