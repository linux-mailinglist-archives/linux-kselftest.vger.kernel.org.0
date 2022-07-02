Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5960564049
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiGBNNK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGBNNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 09:13:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCBDF3C
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Jul 2022 06:12:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w83so7142449oiw.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Jul 2022 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgLoT6rngsvCpzaKpYqf015P/SZSWs9fRK9VXT/kWlE=;
        b=BCeHf3xV6WJw8KS8Nf32xqEQ4+eGmjo1507bFH8DtV2xW16lJO+j/FA0HrrvR3wZRE
         c/sexUyaq0DovCDZ0pEdkaAuFqEoXvMwgqXd5k44SdLen7J6njqNSS06mrtQqsI/IwCH
         2cCLcYLsdtGCofmtI+mxqCCXK++oIj/LK5UDFoEEdM7ZlJtSo+HIv/5L0afHmYzgc1Ze
         r4oskCwOqXm47LKbWMRjgL5LInefCFhUqq457dr1nA50l+G7lHnQvjFEgMhIel0sPQO/
         ahPLOXNpRYdsx9dH6KgsJYsNtZkSsJJYKkdOMVKnHV81XljMghKKj0f3Zde0EUWVFPrt
         mxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgLoT6rngsvCpzaKpYqf015P/SZSWs9fRK9VXT/kWlE=;
        b=okd+1XWrC0wIOuuV1KkzGBYjVL0jM5Lgt873A4+n5JT1uiFEzseZQbiJWzVJwKqe/I
         LIRHywsZI7eVWnLdT+vsWdrHNEMT7O5hVTUdyYCk2qXwhlYQUMOdMQGBz+xgc9k9dI79
         GGJ89noiWTWTQ1p6HvtIsgoiajuoEijVCImu5qt7o5/DngVcx64mhyYYHxoTIitcw53R
         joV54QsiU61YHRFMHWBAY0tFvOJBGH0eHYwMmCn/m7ShFrKzWkeM223JDi4I2RK+LZgu
         +f6Uuu5uE/B2mJ0fnMMUb8/qr4ULChOzf6J3woVtDysOgmtPKUHOJbqJD0edBaZ3aopo
         vmcw==
X-Gm-Message-State: AJIora/G0rDTua8o7hDr4s9oHbfgJdMeFq5nqQnXisOs6lXthWxN9Wvd
        4MbBBMdzJ1IwQQBhEz1EyuYsDg==
X-Google-Smtp-Source: AGRyM1tTlq5QneesEc2tKit83dvAM5uUItlEcwusy4/zdrLigw1xFxikC7/zzkH9eYcQhYBBCzANJw==
X-Received: by 2002:a05:6808:1a0e:b0:335:c4db:f336 with SMTP id bk14-20020a0568081a0e00b00335c4dbf336mr8121024oib.58.1656767571728;
        Sat, 02 Jul 2022 06:12:51 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o13-20020a9d718d000000b00616afb1f1e2sm12643206otj.19.2022.07.02.06.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 06:12:51 -0700 (PDT)
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
Subject: [PATCH v4 7/9] drm: selftest: convert drm_framebuffer selftest to KUnit
Date:   Sat,  2 Jul 2022 10:11:14 -0300
Message-Id: <20220702131116.457444-8-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220702131116.457444-1-maira.canal@usp.br>
References: <20220702131116.457444-1-maira.canal@usp.br>
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
 drivers/gpu/drm/selftests/Makefile            |  5 +--
 .../gpu/drm/selftests/drm_modeset_selftests.h |  9 ------
 .../drm/selftests/test-drm_modeset_common.c   | 32 -------------------
 .../drm/selftests/test-drm_modeset_common.h   | 21 ------------
 drivers/gpu/drm/tests/Makefile                |  2 +-
 .../drm_framebuffer_test.c}                   | 26 +++++++++++----
 6 files changed, 21 insertions(+), 74 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
 rename drivers/gpu/drm/{selftests/test-drm_framebuffer.c => tests/drm_framebuffer_test.c} (96%)

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
similarity index 96%
rename from drivers/gpu/drm/selftests/test-drm_framebuffer.c
rename to drivers/gpu/drm/tests/drm_framebuffer_test.c
index f6d66285c5fc..94d071742f08 100644
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
@@ -336,15 +336,27 @@ static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
 	return buffer_created;
 }
 
-int igt_check_drm_framebuffer_create(void *ignored)
+static void igt_check_drm_framebuffer_create(struct kunit *test)
 {
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(createbuffer_tests); i++) {
-		FAIL(createbuffer_tests[i].buffer_created !=
+		KUNIT_EXPECT_EQ_MSG(test, createbuffer_tests[i].buffer_created,
 				execute_drm_mode_fb_cmd2(&createbuffer_tests[i].cmd),
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
2.36.1

