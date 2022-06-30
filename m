Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBA560E49
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 02:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiF3AtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiF3AtK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 20:49:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215C403D2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:48:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u9so23903118oiv.12
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jun 2022 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aipbfvDB0a79PLvDDZC8xgVDYKM9R90jOk7ng/pPclQ=;
        b=hXiKstyDWRziepAtL3AWwqaJxPJSEJfsdtomsd+mgUUqcTRhwdEwWwnXJM/b/YKH+w
         YtaXUcwnXOsoB1r8SU3DxtPa/8U0MLM450asSoJZK7uaYAtIMGWyOJ8kwLRthB35GwJ1
         P31s/TB9621FPADlUQQo6wRnkczRdcq0qdZxqsxhOpo/Odkvwlh8Dx47JimwV4BZccwS
         IfPm0pY0qw7u6ktE18D0QOp+2K15DXuH4Ev56dOOtKCbQPsgCOHgVtAqEImfDiEDrpfO
         Sz9LiXUpuonDsCXbyACjndCWb3PjP9skUHwq/AtP9UxqgqxsWRWvFk6zyUxgNfU3YZUN
         nHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aipbfvDB0a79PLvDDZC8xgVDYKM9R90jOk7ng/pPclQ=;
        b=WrTowtNmkPhQmZKe/hJGH/sCuf7SBxIWTrSH4kqEI6E74KA1CtANlrdvg0e3W9nXXE
         Xp6GAKHEJZ535eEij6Q+pupcWGdzCfTzGpkqrk5BJWtU/R5QzbnzAjm0K2nurs20QaaM
         xAEN4f+VYU8IR9M02jcUTW9tWyn7v1m4lXiMZ+vV4NNZ3ERkG62uHOv0YjcbY6NsY6z0
         iA6Xk4ck2Re/9egz2DelAlmQz2kvcv8dSHs2GC2DuHRNdMpG4aK9A6DNtkZfPaQOAD/p
         Z2ybVdGaWK0LbMy8fjAQINOUCm+APGyQeZ2WPTTL5S9D24nLjSIfiCCqooJkHeR2VbOb
         lKUA==
X-Gm-Message-State: AJIora/zaCQS/+UiI5MH9pqg//500JfNufHRn0HKbX0s9vgvnbYeZ4in
        5iEGGObK7a0BFgIesK2bU6WFxQ==
X-Google-Smtp-Source: AGRyM1uOdsJX3NOQ1ut3lQA0UkynaPM1fr3LkeLtCuXXt15n6vN0RBCjziacrD5XiK684Pg5LQz7Yg==
X-Received: by 2002:a05:6808:1794:b0:335:a89f:55b8 with SMTP id bg20-20020a056808179400b00335a89f55b8mr3757773oib.261.1656550138370;
        Wed, 29 Jun 2022 17:48:58 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id r10-20020a056808210a00b00325cda1ff8esm9432250oiw.13.2022.06.29.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:48:57 -0700 (PDT)
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
Subject: [PATCH v3 4/9] drm: selftest: convert drm_format selftest to KUnit
Date:   Wed, 29 Jun 2022 21:46:06 -0300
Message-Id: <20220630004611.114441-5-maira.canal@usp.br>
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
DRM format selftest to the KUnit API.

Acked-by: Daniel Latypov <dlatypov@google.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   3 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |   3 -
 drivers/gpu/drm/selftests/test-drm_format.c   | 280 -----------------
 .../drm/selftests/test-drm_modeset_common.h   |   3 -
 drivers/gpu/drm/tests/Makefile                |   2 +-
 drivers/gpu/drm/tests/drm_format_test.c       | 284 ++++++++++++++++++
 6 files changed, 286 insertions(+), 289 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
 create mode 100644 drivers/gpu/drm/tests/drm_format_test.c

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 8a794914e328..b7f252d886d0 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
-                      test-drm_format.o test-drm_framebuffer.o \
-		      test-drm_dp_mst_helper.o
+                      test-drm_framebuffer.o test-drm_dp_mst_helper.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o \
 				    test-drm_buddy.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index a3ca90307364..63061ef55eff 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -7,9 +7,6 @@
  * Tests are executed in order by igt/drm_selftests_helper
  */
 selftest(check_plane_state, igt_check_plane_state)
-selftest(check_drm_format_block_width, igt_check_drm_format_block_width)
-selftest(check_drm_format_block_height, igt_check_drm_format_block_height)
-selftest(check_drm_format_min_pitch, igt_check_drm_format_min_pitch)
 selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
 selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
 selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_format.c b/drivers/gpu/drm/selftests/test-drm_format.c
deleted file mode 100644
index c5e212afa27a..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_format.c
+++ /dev/null
@@ -1,280 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Test cases for the drm_format functions
- */
-
-#define pr_fmt(fmt) "drm_format: " fmt
-
-#include <linux/errno.h>
-#include <linux/kernel.h>
-
-#include <drm/drm_fourcc.h>
-
-#include "test-drm_modeset_common.h"
-
-int igt_check_drm_format_block_width(void *ignored)
-{
-	const struct drm_format_info *info = NULL;
-
-	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_block_width(info, 0) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-
-	/* Test 1 plane format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 2) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test 3 planes format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 2) != 1);
-	FAIL_ON(drm_format_info_block_width(info, 3) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	/* Test a tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L0);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_width(info, 0) != 2);
-	FAIL_ON(drm_format_info_block_width(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_width(info, -1) != 0);
-
-	return 0;
-}
-
-int igt_check_drm_format_block_height(void *ignored)
-{
-	const struct drm_format_info *info = NULL;
-
-	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_block_height(info, 0) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-
-	/* Test 1 plane format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 2) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test 3 planes format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 2) != 1);
-	FAIL_ON(drm_format_info_block_height(info, 3) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	/* Test a tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L0);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_block_height(info, 0) != 2);
-	FAIL_ON(drm_format_info_block_height(info, 1) != 0);
-	FAIL_ON(drm_format_info_block_height(info, -1) != 0);
-
-	return 0;
-}
-
-int igt_check_drm_format_min_pitch(void *ignored)
-{
-	const struct drm_format_info *info = NULL;
-
-	/* Test invalid arguments */
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	/* Test 1 plane 8 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_RGB332);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
-			(uint64_t)(UINT_MAX - 1));
-
-	/* Test 1 plane 16 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_XRGB4444);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1280);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 3840);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 8192);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 1342);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX * 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
-			(uint64_t)(UINT_MAX - 1) * 2);
-
-	/* Test 1 plane 24 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_RGB888);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 3);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 6);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 3072);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 5760);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 12288);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 2013);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX * 3);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
-			(uint64_t)(UINT_MAX - 1) * 3);
-
-	/* Test 1 plane 32 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_ABGR8888);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 8);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 2560);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 7680);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 16384);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 2684);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX * 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
-			(uint64_t)(UINT_MAX - 1) * 4);
-
-	/* Test 2 planes format */
-	info = drm_format_info(DRM_FORMAT_NV12);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 320) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 512) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 960) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2048) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 336) != 672);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
-			(uint64_t)UINT_MAX + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=
-			(uint64_t)(UINT_MAX - 1));
-	FAIL_ON(drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2) !=
-			(uint64_t)(UINT_MAX - 1));
-
-	/* Test 3 planes 8 bits per pixel format */
-	info = drm_format_info(DRM_FORMAT_YUV422);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 3, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 1) != 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 2) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 640);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 320) != 320);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 320) != 320);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 1024);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 512) != 512);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 512) != 512);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 1920);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 960) != 960);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 960) != 960);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 4096);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 2048) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 2048) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 671);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 336) != 336);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, 336) != 336);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=
-			(uint64_t)UINT_MAX / 2 + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1) !=
-			(uint64_t)UINT_MAX / 2 + 1);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2) !=
-			(uint64_t)(UINT_MAX - 1) / 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2) !=
-			(uint64_t)(UINT_MAX - 1) / 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2) !=
-			(uint64_t)(UINT_MAX - 1) / 2);
-
-	/* Test tiled format */
-	info = drm_format_info(DRM_FORMAT_X0L2);
-	FAIL_ON(!info);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, -1, 0) != 0);
-	FAIL_ON(drm_format_info_min_pitch(info, 1, 0) != 0);
-
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1) != 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 2) != 4);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 640) != 1280);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1024) != 2048);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 1920) != 3840);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 4096) != 8192);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, 671) != 1342);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX) !=
-			(uint64_t)UINT_MAX * 2);
-	FAIL_ON(drm_format_info_min_pitch(info, 0, UINT_MAX - 1) !=
-			(uint64_t)(UINT_MAX - 1) * 2);
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index 42a10d7da51c..5709d967a5c4 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -17,9 +17,6 @@
 #define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
 
 int igt_check_plane_state(void *ignored);
-int igt_check_drm_format_block_width(void *ignored);
-int igt_check_drm_format_block_height(void *ignored);
-int igt_check_drm_format_min_pitch(void *ignored);
 int igt_check_drm_framebuffer_create(void *ignored);
 int igt_dp_mst_calc_pbn_mode(void *ignored);
 int igt_dp_mst_sideband_msg_req_decode(void *ignored);
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index f2eced30a955..1aa1627cb5e6 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
-	drm_cmdline_parser_test.o drm_rect_test.o
+	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o
diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
new file mode 100644
index 000000000000..e94b2bc6de54
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_format_test.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for the drm_format functions
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_fourcc.h>
+
+static void igt_check_drm_format_block_width(struct kunit *test)
+{
+	const struct drm_format_info *info = NULL;
+
+	/* Test invalid arguments */
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 1));
+
+	/* Test 1 plane format */
+	info = drm_format_info(DRM_FORMAT_XRGB4444);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
+
+	/* Test 2 planes format */
+	info = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 0));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 2));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
+
+	/* Test 3 planes format */
+	info = drm_format_info(DRM_FORMAT_YUV422);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 0));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 1));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_width(info, 2));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 3));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
+
+	/* Test a tiled format */
+	info = drm_format_info(DRM_FORMAT_X0L0);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_width(info, 0), 2);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, 1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
+}
+
+static void igt_check_drm_format_block_height(struct kunit *test)
+{
+	const struct drm_format_info *info = NULL;
+
+	/* Test invalid arguments */
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 1));
+
+	/* Test 1 plane format */
+	info = drm_format_info(DRM_FORMAT_XRGB4444);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 1));
+
+	/* Test 2 planes format */
+	info = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 0));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 2));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
+
+	/* Test 3 planes format */
+	info = drm_format_info(DRM_FORMAT_YUV422);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 0));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 1));
+	KUNIT_EXPECT_TRUE(test, drm_format_info_block_height(info, 2));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 3));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
+
+	/* Test a tiled format */
+	info = drm_format_info(DRM_FORMAT_X0L0);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_EQ(test, drm_format_info_block_height(info, 0), 2);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, 1));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
+}
+
+static void igt_check_drm_format_min_pitch(struct kunit *test)
+{
+	const struct drm_format_info *info = NULL;
+
+	/* Test invalid arguments */
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	/* Test 1 plane 8 bits per pixel format */
+	info = drm_format_info(DRM_FORMAT_RGB332);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
+			(uint64_t)(UINT_MAX - 1));
+
+	/* Test 1 plane 16 bits per pixel format */
+	info = drm_format_info(DRM_FORMAT_XRGB4444);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1280);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 3840);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 8192);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 1342);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX * 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
+			(uint64_t)(UINT_MAX - 1) * 2);
+
+	/* Test 1 plane 24 bits per pixel format */
+	info = drm_format_info(DRM_FORMAT_RGB888);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 3);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 6);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 3072);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 5760);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 12288);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 2013);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX * 3);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
+			(uint64_t)(UINT_MAX - 1) * 3);
+
+	/* Test 1 plane 32 bits per pixel format */
+	info = drm_format_info(DRM_FORMAT_ABGR8888);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 8);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 2560);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 7680);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 16384);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 2684);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX * 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
+			(uint64_t)(UINT_MAX - 1) * 4);
+
+	/* Test 2 planes format */
+	info = drm_format_info(DRM_FORMAT_NV12);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 2, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 320), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 512), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 960), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2048), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 336), 672);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1),
+			(uint64_t)UINT_MAX + 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1)),
+			(uint64_t)(UINT_MAX - 1));
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2),
+			(uint64_t)(UINT_MAX - 1));
+
+	/* Test 3 planes 8 bits per pixel format */
+	info = drm_format_info(DRM_FORMAT_YUV422);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 2, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 3, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 1), 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 2), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 640);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 320), 320);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 320), 320);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 1024);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 512), 512);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 512), 512);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 1920);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 960), 960);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 960), 960);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 4096);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 2048), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 2048), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 671);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, 336), 336);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, 336), 336);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1),
+			(uint64_t)UINT_MAX / 2 + 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1),
+			(uint64_t)UINT_MAX / 2 + 1);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2),
+			(uint64_t)(UINT_MAX - 1) / 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2),
+			(uint64_t)(UINT_MAX - 1) / 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2),
+			(uint64_t)(UINT_MAX - 1) / 2);
+
+	/* Test tiled format */
+	info = drm_format_info(DRM_FORMAT_X0L2);
+	KUNIT_EXPECT_TRUE(test, info);
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 0, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, -1, 0));
+	KUNIT_EXPECT_FALSE(test, drm_format_info_min_pitch(info, 1, 0));
+
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1), 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 2), 4);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 640), 1280);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1024), 2048);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 1920), 3840);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 4096), 8192);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, 671), 1342);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX),
+			(uint64_t)UINT_MAX * 2);
+	KUNIT_EXPECT_EQ(test, drm_format_info_min_pitch(info, 0, UINT_MAX - 1),
+			(uint64_t)(UINT_MAX - 1) * 2);
+}
+
+static struct kunit_case drm_format_tests[] = {
+	KUNIT_CASE(igt_check_drm_format_block_width),
+	KUNIT_CASE(igt_check_drm_format_block_height),
+	KUNIT_CASE(igt_check_drm_format_min_pitch),
+	{ }
+};
+
+static struct kunit_suite drm_format_test_suite = {
+	.name = "drm_format",
+	.test_cases = drm_format_tests,
+};
+
+kunit_test_suite(drm_format_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.1

