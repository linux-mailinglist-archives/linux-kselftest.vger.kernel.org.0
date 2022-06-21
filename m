Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9ED553B43
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353739AbiFUULk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354267AbiFUULh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 16:11:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3612E9E7
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:11:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s124so18544112oia.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMkvNw5YR3UNKYLqbjJMK6eaGt061mR96hNUfApP1D0=;
        b=O6WpMAH1urdk/F3jF0Y798cz5tkN1chqgXmjszSgmk4IYEjz7cR+6XP0BwBigXa5jf
         uF5WC2BCMcHEbS7GYXPuSFZo/QVORgsvf/6WswaPlxuZXNlR5NXdZOSdP3hPq+Kpk9tK
         cxHX7jkwdJ2/drJl9TYMHDz6FADUyg58EX/bJJIzjysUTH9gjYe3z3gx879aPmumctBC
         by3BtRUiOwpw05Ee2tGVKnSxj1TqT0uEkh9n6grQTWfnOweYCQDrMM7/7YghGhe1SvW4
         hhR7K1MamS4ZWKsBkR3aAF84RuddMvN2W4UABCGAfzR6BizKrXaylqu2XK1C0Q/6JZOl
         YfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMkvNw5YR3UNKYLqbjJMK6eaGt061mR96hNUfApP1D0=;
        b=pFIdVXZsAp6q2SxntAhJpd/I5NCcmng5swbUGaalu1Ok/aatH34LxMXMZOjinolCNs
         iHRSNzNn4a06aoNX68skiv2w5HDYuSSds9aGflRX8wc7BLhkvWYkO1NdoVyWIll5FhIq
         OxoPYp1UbsxrSQ/wvDQe0ZQ3F2itW9UDIiwMTlvGbi+1a+S/u95Muwhy7iSO5BPNh2Od
         LN9REAfsR8wTXuvRvDis/s8hjYI02ALjBn6C37rnbSUUmIFotL6SU69Ns2tLkQFmJEV2
         26NDGyfbWMUClb/rCpG4yjMdmvQYo2OWGcflHxH+2tETfQaRTEUD/jgZjfUFpmElfCq7
         LRVQ==
X-Gm-Message-State: AJIora/81nBaI++JAcl6bB+PLNEDNiu9//muygIcQ9Z4JWYTgfepF696
        Rtm2rAac5Z6v8kwLAOAjsI1JYw==
X-Google-Smtp-Source: AGRyM1sv/Rv7f1S4CGqk6pnkgGwmqQcIcSY2NLDz8hIqkdqOxZ2lwwtCtmevKNlGI1+MeClUz0K7HA==
X-Received: by 2002:a05:6808:b09:b0:32f:3b9b:e29 with SMTP id s9-20020a0568080b0900b0032f3b9b0e29mr14867343oij.206.1655842292478;
        Tue, 21 Jun 2022 13:11:32 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o206-20020acad7d7000000b0032b7a0c5da1sm9759771oig.27.2022.06.21.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:11:31 -0700 (PDT)
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
        Arthur Grillo <arthur.grillo@usp.br>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH v2 9/9] drm: selftest: convert drm_mm selftest to KUnit
Date:   Tue, 21 Jun 2022 17:09:26 -0300
Message-Id: <20220621200926.257002-10-maira.canal@usp.br>
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

From: Arthur Grillo <arthur.grillo@usp.br>

Considering the current adoption of the KUnit framework, convert the
DRM mm selftest to the KUnit API.

Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 Documentation/gpu/todo.rst                    |   11 -
 drivers/gpu/drm/Kconfig                       |   20 -
 drivers/gpu/drm/Makefile                      |    1 -
 drivers/gpu/drm/selftests/Makefile            |    2 -
 drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
 drivers/gpu/drm/selftests/drm_selftest.c      |  109 --
 drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
 drivers/gpu/drm/tests/Makefile                |    3 +-
 .../test-drm_mm.c => tests/drm_mm_test.c}     | 1135 +++++++----------
 9 files changed, 452 insertions(+), 898 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/Makefile
 delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
 delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
 rename drivers/gpu/drm/{selftests/test-drm_mm.c => tests/drm_mm_test.c} (58%)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 513b20ccef1e..10bfb50908d1 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -617,17 +617,6 @@ Contact: Javier Martinez Canillas <javierm@redhat.com>
 
 Level: Intermediate
 
-Convert Kernel Selftests (kselftest) to KUnit tests when appropriate
---------------------------------------------------------------------
-
-Many of the `Kselftest <https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html>`_
-tests in DRM could be converted to Kunit tests instead, since that framework
-is more suitable for unit testing.
-
-Contact: Javier Martinez Canillas <javierm@redhat.com>
-
-Level: Starter
-
 Enable trinity for DRM
 ----------------------
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f49639bcdbff..a0c7cb5f0c3f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -50,26 +50,6 @@ config DRM_DEBUG_MM
 
 	  If in doubt, say "N".
 
-config DRM_DEBUG_SELFTEST
-	tristate "kselftests for DRM"
-	depends on DRM
-	depends on DEBUG_KERNEL
-	select PRIME_NUMBERS
-	select DRM_DISPLAY_DP_HELPER
-	select DRM_DISPLAY_HELPER
-	select DRM_LIB_RANDOM
-	select DRM_KMS_HELPER
-	select DRM_BUDDY
-	select DRM_EXPORT_FOR_TESTS if m
-	default n
-	help
-	  This option provides kernel modules that can be used to run
-	  various selftests on parts of the DRM api. This option is not
-	  useful for distributions or general kernels, but only for kernel
-	  developers working on DRM and associated drivers.
-
-	  If in doubt, say "N".
-
 config DRM_KUNIT_TEST
 	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
 	depends on DRM && KUNIT
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index ebc82c5fa65f..36dcbf4cf6db 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -75,7 +75,6 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 # Drivers and the rest
 #
 
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
 obj-$(CONFIG_DRM_KUNIT_TEST) += tests/
 
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
deleted file mode 100644
index a4ebecb8146b..000000000000
--- a/drivers/gpu/drm/selftests/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o
diff --git a/drivers/gpu/drm/selftests/drm_mm_selftests.h b/drivers/gpu/drm/selftests/drm_mm_selftests.h
deleted file mode 100644
index 8c87c964176b..000000000000
--- a/drivers/gpu/drm/selftests/drm_mm_selftests.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(name, function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_mm
- */
-selftest(sanitycheck, igt_sanitycheck) /* keep first (selfcheck for igt) */
-selftest(init, igt_init)
-selftest(debug, igt_debug)
-selftest(reserve, igt_reserve)
-selftest(insert, igt_insert)
-selftest(replace, igt_replace)
-selftest(insert_range, igt_insert_range)
-selftest(align, igt_align)
-selftest(frag, igt_frag)
-selftest(align32, igt_align32)
-selftest(align64, igt_align64)
-selftest(evict, igt_evict)
-selftest(evict_range, igt_evict_range)
-selftest(bottomup, igt_bottomup)
-selftest(lowest, igt_lowest)
-selftest(topdown, igt_topdown)
-selftest(highest, igt_highest)
-selftest(color, igt_color)
-selftest(color_evict, igt_color_evict)
-selftest(color_evict_range, igt_color_evict_range)
diff --git a/drivers/gpu/drm/selftests/drm_selftest.c b/drivers/gpu/drm/selftests/drm_selftest.c
deleted file mode 100644
index e29ed9faef5b..000000000000
--- a/drivers/gpu/drm/selftests/drm_selftest.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Copyright © 2016 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
- */
-
-#include <linux/compiler.h>
-
-#define selftest(name, func) __idx_##name,
-enum {
-#include TESTS
-};
-#undef selftest
-
-#define selftest(n, f) [__idx_##n] = { .name = #n, .func = f },
-static struct drm_selftest {
-	bool enabled;
-	const char *name;
-	int (*func)(void *);
-} selftests[] = {
-#include TESTS
-};
-#undef selftest
-
-/* Embed the line number into the parameter name so that we can order tests */
-#define param(n) __PASTE(igt__, __PASTE(__PASTE(__LINE__, __), n))
-#define selftest_0(n, func, id) \
-module_param_named(id, selftests[__idx_##n].enabled, bool, 0400);
-#define selftest(n, func) selftest_0(n, func, param(n))
-#include TESTS
-#undef selftest
-
-static void set_default_test_all(struct drm_selftest *st, unsigned long count)
-{
-	unsigned long i;
-
-	for (i = 0; i < count; i++)
-		if (st[i].enabled)
-			return;
-
-	for (i = 0; i < count; i++)
-		st[i].enabled = true;
-}
-
-static int run_selftests(struct drm_selftest *st,
-			 unsigned long count,
-			 void *data)
-{
-	int err = 0;
-
-	set_default_test_all(st, count);
-
-	/* Tests are listed in natural order in drm_*_selftests.h */
-	for (; count--; st++) {
-		if (!st->enabled)
-			continue;
-
-		pr_debug("drm: Running %s\n", st->name);
-		err = st->func(data);
-		if (err)
-			break;
-	}
-
-	if (WARN(err > 0 || err == -ENOTTY,
-		 "%s returned %d, conflicting with selftest's magic values!\n",
-		 st->name, err))
-		err = -1;
-
-	rcu_barrier();
-	return err;
-}
-
-static int __maybe_unused
-__drm_subtests(const char *caller,
-	       const struct drm_subtest *st,
-	       int count,
-	       void *data)
-{
-	int err;
-
-	for (; count--; st++) {
-		pr_debug("Running %s/%s\n", caller, st->name);
-		err = st->func(data);
-		if (err) {
-			pr_err("%s: %s failed with error %d\n",
-			       caller, st->name, err);
-			return err;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/selftests/drm_selftest.h b/drivers/gpu/drm/selftests/drm_selftest.h
deleted file mode 100644
index c784ec02ff53..000000000000
--- a/drivers/gpu/drm/selftests/drm_selftest.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright © 2016 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
- */
-
-#ifndef __DRM_SELFTEST_H__
-#define __DRM_SELFTEST_H__
-
-struct drm_subtest {
-	int (*func)(void *data);
-	const char *name;
-};
-
-static int __drm_subtests(const char *caller,
-			  const struct drm_subtest *st,
-			  int count,
-			  void *data);
-#define drm_subtests(T, data) \
-	__drm_subtests(__func__, T, ARRAY_SIZE(T), data)
-
-#define SUBTEST(x) { x, #x }
-
-#endif /* __DRM_SELFTEST_H__ */
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 15a3efb2cf8e..9f7306bc3ae5 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_damage_helper_test.o drm_cmdline_parser_test.o \
 	drm_rect_test.o drm_format_test.o drm_plane_helper_test.o \
-	drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o
+	drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o \
+	drm_mm_test.o
diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/tests/drm_mm_test.c
similarity index 58%
rename from drivers/gpu/drm/selftests/test-drm_mm.c
rename to drivers/gpu/drm/tests/drm_mm_test.c
index b768b53c4aee..89a088a063af 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -3,9 +3,7 @@
  * Test cases for the drm_mm range manager
  */
 
-#define pr_fmt(fmt) "drm_mm: " fmt
-
-#include <linux/module.h>
+#include <kunit/test.h>
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 #include <linux/random.h>
@@ -16,9 +14,6 @@
 
 #include "../lib/drm_random.h"
 
-#define TESTS "drm_mm_selftests.h"
-#include "drm_selftest.h"
-
 static unsigned int random_seed;
 static unsigned int max_iterations = 8192;
 static unsigned int max_prime = 128;
@@ -45,13 +40,7 @@ static const struct insert_mode {
 	{}
 };
 
-static int igt_sanitycheck(void *ignored)
-{
-	pr_info("%s - ok!\n", __func__);
-	return 0;
-}
-
-static bool assert_no_holes(const struct drm_mm *mm)
+static bool assert_no_holes(struct kunit *test, const struct drm_mm *mm)
 {
 	struct drm_mm_node *hole;
 	u64 hole_start, __always_unused hole_end;
@@ -61,13 +50,14 @@ static bool assert_no_holes(const struct drm_mm *mm)
 	drm_mm_for_each_hole(hole, mm, hole_start, hole_end)
 		count++;
 	if (count) {
-		pr_err("Expected to find no holes (after reserve), found %lu instead\n", count);
+		KUNIT_FAIL(test,
+			   "Expected to find no holes (after reserve), found %lu instead\n", count);
 		return false;
 	}
 
 	drm_mm_for_each_node(hole, mm) {
 		if (drm_mm_hole_follows(hole)) {
-			pr_err("Hole follows node, expected none!\n");
+			KUNIT_FAIL(test, "Hole follows node, expected none!\n");
 			return false;
 		}
 	}
@@ -75,7 +65,7 @@ static bool assert_no_holes(const struct drm_mm *mm)
 	return true;
 }
 
-static bool assert_one_hole(const struct drm_mm *mm, u64 start, u64 end)
+static bool assert_one_hole(struct kunit *test, const struct drm_mm *mm, u64 start, u64 end)
 {
 	struct drm_mm_node *hole;
 	u64 hole_start, hole_end;
@@ -89,62 +79,62 @@ static bool assert_one_hole(const struct drm_mm *mm, u64 start, u64 end)
 	drm_mm_for_each_hole(hole, mm, hole_start, hole_end) {
 		if (start != hole_start || end != hole_end) {
 			if (ok)
-				pr_err("empty mm has incorrect hole, found (%llx, %llx), expect (%llx, %llx)\n",
-				       hole_start, hole_end,
-				       start, end);
+				KUNIT_FAIL(test,
+					   "empty mm has incorrect hole, found (%llx, %llx), expect (%llx, %llx)\n",
+					   hole_start, hole_end, start, end);
 			ok = false;
 		}
 		count++;
 	}
 	if (count != 1) {
-		pr_err("Expected to find one hole, found %lu instead\n", count);
+		KUNIT_FAIL(test, "Expected to find one hole, found %lu instead\n", count);
 		ok = false;
 	}
 
 	return ok;
 }
 
-static bool assert_continuous(const struct drm_mm *mm, u64 size)
+static bool assert_continuous(struct kunit *test, const struct drm_mm *mm, u64 size)
 {
 	struct drm_mm_node *node, *check, *found;
 	unsigned long n;
 	u64 addr;
 
-	if (!assert_no_holes(mm))
+	if (!assert_no_holes(test, mm))
 		return false;
 
 	n = 0;
 	addr = 0;
 	drm_mm_for_each_node(node, mm) {
 		if (node->start != addr) {
-			pr_err("node[%ld] list out of order, expected %llx found %llx\n",
+			KUNIT_FAIL(test, "node[%ld] list out of order, expected %llx found %llx\n",
 			       n, addr, node->start);
 			return false;
 		}
 
 		if (node->size != size) {
-			pr_err("node[%ld].size incorrect, expected %llx, found %llx\n",
+			KUNIT_FAIL(test, "node[%ld].size incorrect, expected %llx, found %llx\n",
 			       n, size, node->size);
 			return false;
 		}
 
 		if (drm_mm_hole_follows(node)) {
-			pr_err("node[%ld] is followed by a hole!\n", n);
+			KUNIT_FAIL(test, "node[%ld] is followed by a hole!\n", n);
 			return false;
 		}
 
 		found = NULL;
 		drm_mm_for_each_node_in_range(check, mm, addr, addr + size) {
 			if (node != check) {
-				pr_err("lookup return wrong node, expected start %llx, found %llx\n",
-				       node->start, check->start);
+				KUNIT_FAIL(test,
+					   "lookup return wrong node, expected start %llx, found %llx\n",
+					   node->start, check->start);
 				return false;
 			}
 			found = check;
 		}
 		if (!found) {
-			pr_err("lookup failed for node %llx + %llx\n",
-			       addr, size);
+			KUNIT_FAIL(test, "lookup failed for node %llx + %llx\n", addr, size);
 			return false;
 		}
 
@@ -166,30 +156,31 @@ static u64 misalignment(struct drm_mm_node *node, u64 alignment)
 	return rem;
 }
 
-static bool assert_node(struct drm_mm_node *node, struct drm_mm *mm,
+static bool assert_node(struct kunit *test, struct drm_mm_node *node, struct drm_mm *mm,
 			u64 size, u64 alignment, unsigned long color)
 {
 	bool ok = true;
 
 	if (!drm_mm_node_allocated(node) || node->mm != mm) {
-		pr_err("node not allocated\n");
+		KUNIT_FAIL(test, "node not allocated\n");
 		ok = false;
 	}
 
 	if (node->size != size) {
-		pr_err("node has wrong size, found %llu, expected %llu\n",
+		KUNIT_FAIL(test, "node has wrong size, found %llu, expected %llu\n",
 		       node->size, size);
 		ok = false;
 	}
 
 	if (misalignment(node, alignment)) {
-		pr_err("node is misaligned, start %llx rem %llu, expected alignment %llu\n",
-		       node->start, misalignment(node, alignment), alignment);
+		KUNIT_FAIL(test,
+			   "node is misaligned, start %llx rem %llu, expected alignment %llu\n",
+			   node->start, misalignment(node, alignment), alignment);
 		ok = false;
 	}
 
 	if (node->color != color) {
-		pr_err("node has wrong color, found %lu, expected %lu\n",
+		KUNIT_FAIL(test, "node has wrong color, found %lu, expected %lu\n",
 		       node->color, color);
 		ok = false;
 	}
@@ -197,76 +188,64 @@ static bool assert_node(struct drm_mm_node *node, struct drm_mm *mm,
 	return ok;
 }
 
-#define show_mm(mm) do { \
-	struct drm_printer __p = drm_debug_printer(__func__); \
-	drm_mm_print((mm), &__p); } while (0)
-
-static int igt_init(void *ignored)
+static void igt_mm_init(struct kunit *test)
 {
 	const unsigned int size = 4096;
 	struct drm_mm mm;
 	struct drm_mm_node tmp;
-	int ret = -EINVAL;
 
 	/* Start with some simple checks on initialising the struct drm_mm */
 	memset(&mm, 0, sizeof(mm));
-	if (drm_mm_initialized(&mm)) {
-		pr_err("zeroed mm claims to be initialized\n");
-		return ret;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, drm_mm_initialized(&mm),
+			       "zeroed mm claims to be initialized\n");
 
 	memset(&mm, 0xff, sizeof(mm));
 	drm_mm_init(&mm, 0, size);
 	if (!drm_mm_initialized(&mm)) {
-		pr_err("mm claims not to be initialized\n");
+		KUNIT_FAIL(test, "mm claims not to be initialized\n");
 		goto out;
 	}
 
 	if (!drm_mm_clean(&mm)) {
-		pr_err("mm not empty on creation\n");
+		KUNIT_FAIL(test, "mm not empty on creation\n");
 		goto out;
 	}
 
 	/* After creation, it should all be one massive hole */
-	if (!assert_one_hole(&mm, 0, size)) {
-		ret = -EINVAL;
+	if (!assert_one_hole(test, &mm, 0, size)) {
+		KUNIT_FAIL(test, "");
 		goto out;
 	}
 
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.start = 0;
 	tmp.size = size;
-	ret = drm_mm_reserve_node(&mm, &tmp);
-	if (ret) {
-		pr_err("failed to reserve whole drm_mm\n");
+	if (drm_mm_reserve_node(&mm, &tmp)) {
+		KUNIT_FAIL(test, "failed to reserve whole drm_mm\n");
 		goto out;
 	}
 
 	/* After filling the range entirely, there should be no holes */
-	if (!assert_no_holes(&mm)) {
-		ret = -EINVAL;
+	if (!assert_no_holes(test, &mm)) {
+		KUNIT_FAIL(test, "");
 		goto out;
 	}
 
 	/* And then after emptying it again, the massive hole should be back */
 	drm_mm_remove_node(&tmp);
-	if (!assert_one_hole(&mm, 0, size)) {
-		ret = -EINVAL;
+	if (!assert_one_hole(test, &mm, 0, size)) {
+		KUNIT_FAIL(test, "");
 		goto out;
 	}
 
 out:
-	if (ret)
-		show_mm(&mm);
 	drm_mm_takedown(&mm);
-	return ret;
 }
 
-static int igt_debug(void *ignored)
+static void igt_mm_debug(struct kunit *test)
 {
 	struct drm_mm mm;
 	struct drm_mm_node nodes[2];
-	int ret;
 
 	/* Create a small drm_mm with a couple of nodes and a few holes, and
 	 * check that the debug iterator doesn't explode over a trivial drm_mm.
@@ -277,24 +256,16 @@ static int igt_debug(void *ignored)
 	memset(nodes, 0, sizeof(nodes));
 	nodes[0].start = 512;
 	nodes[0].size = 1024;
-	ret = drm_mm_reserve_node(&mm, &nodes[0]);
-	if (ret) {
-		pr_err("failed to reserve node[0] {start=%lld, size=%lld)\n",
-		       nodes[0].start, nodes[0].size);
-		return ret;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, drm_mm_reserve_node(&mm, &nodes[0]),
+			       "failed to reserve node[0] {start=%lld, size=%lld)\n",
+			       nodes[0].start, nodes[0].size);
 
 	nodes[1].size = 1024;
 	nodes[1].start = 4096 - 512 - nodes[1].size;
-	ret = drm_mm_reserve_node(&mm, &nodes[1]);
-	if (ret) {
-		pr_err("failed to reserve node[1] {start=%lld, size=%lld)\n",
-		       nodes[1].start, nodes[1].size);
-		return ret;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, drm_mm_reserve_node(&mm, &nodes[1]),
+			       "failed to reserve node[0] {start=%lld, size=%lld)\n",
+			       nodes[0].start, nodes[0].size);
 
-	show_mm(&mm);
-	return 0;
 }
 
 static struct drm_mm_node *set_node(struct drm_mm_node *node,
@@ -305,7 +276,7 @@ static struct drm_mm_node *set_node(struct drm_mm_node *node,
 	return node;
 }
 
-static bool expect_reserve_fail(struct drm_mm *mm, struct drm_mm_node *node)
+static bool expect_reserve_fail(struct kunit *test, struct drm_mm *mm, struct drm_mm_node *node)
 {
 	int err;
 
@@ -314,17 +285,18 @@ static bool expect_reserve_fail(struct drm_mm *mm, struct drm_mm_node *node)
 		return true;
 
 	if (!err) {
-		pr_err("impossible reserve succeeded, node %llu + %llu\n",
-		       node->start, node->size);
+		KUNIT_FAIL(test, "impossible reserve succeeded, node %llu + %llu\n",
+			   node->start, node->size);
 		drm_mm_remove_node(node);
 	} else {
-		pr_err("impossible reserve failed with wrong error %d [expected %d], node %llu + %llu\n",
+		KUNIT_FAIL(test,
+			   "impossible reserve failed with wrong error %d [expected %d], node %llu + %llu\n",
 		       err, -ENOSPC, node->start, node->size);
 	}
 	return false;
 }
 
-static bool check_reserve_boundaries(struct drm_mm *mm,
+static bool check_reserve_boundaries(struct kunit *test, struct drm_mm *mm,
 				     unsigned int count,
 				     u64 size)
 {
@@ -356,11 +328,9 @@ static bool check_reserve_boundaries(struct drm_mm *mm,
 	int n;
 
 	for (n = 0; n < ARRAY_SIZE(boundaries); n++) {
-		if (!expect_reserve_fail(mm,
-					 set_node(&tmp,
-						  boundaries[n].start,
+		if (!expect_reserve_fail(test, mm, set_node(&tmp, boundaries[n].start,
 						  boundaries[n].size))) {
-			pr_err("boundary[%d:%s] failed, count=%u, size=%lld\n",
+			KUNIT_FAIL(test, "boundary[%d:%s] failed, count=%u, size=%lld\n",
 			       n, boundaries[n].name, count, size);
 			return false;
 		}
@@ -369,7 +339,7 @@ static bool check_reserve_boundaries(struct drm_mm *mm,
 	return true;
 }
 
-static int __igt_reserve(unsigned int count, u64 size)
+static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 {
 	DRM_RND_STATE(prng, random_seed);
 	struct drm_mm mm;
@@ -377,7 +347,7 @@ static int __igt_reserve(unsigned int count, u64 size)
 	unsigned int *order, n, m, o = 0;
 	int ret, err;
 
-	/* For exercising drm_mm_reserve_node(), we want to check that
+	/* For exercising drm_mm_reserve_node(struct kunit *test, ), we want to check that
 	 * reservations outside of the drm_mm range are rejected, and to
 	 * overlapping and otherwise already occupied ranges. Afterwards,
 	 * the tree and nodes should be intact.
@@ -392,13 +362,12 @@ static int __igt_reserve(unsigned int count, u64 size)
 		goto err;
 
 	nodes = vzalloc(array_size(count, sizeof(*nodes)));
-	if (!nodes)
-		goto err_order;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	ret = -EINVAL;
 	drm_mm_init(&mm, 0, count * size);
 
-	if (!check_reserve_boundaries(&mm, count, size))
+	if (!check_reserve_boundaries(test, &mm, count, size))
 		goto out;
 
 	for (n = 0; n < count; n++) {
@@ -407,57 +376,53 @@ static int __igt_reserve(unsigned int count, u64 size)
 
 		err = drm_mm_reserve_node(&mm, &nodes[n]);
 		if (err) {
-			pr_err("reserve failed, step %d, start %llu\n",
+			KUNIT_FAIL(test, "reserve failed, step %d, start %llu\n",
 			       n, nodes[n].start);
 			ret = err;
 			goto out;
 		}
 
 		if (!drm_mm_node_allocated(&nodes[n])) {
-			pr_err("reserved node not allocated! step %d, start %llu\n",
+			KUNIT_FAIL(test, "reserved node not allocated! step %d, start %llu\n",
 			       n, nodes[n].start);
 			goto out;
 		}
 
-		if (!expect_reserve_fail(&mm, &nodes[n]))
+		if (!expect_reserve_fail(test, &mm, &nodes[n]))
 			goto out;
 	}
 
 	/* After random insertion the nodes should be in order */
-	if (!assert_continuous(&mm, size))
+	if (!assert_continuous(test, &mm, size))
 		goto out;
 
 	/* Repeated use should then fail */
 	drm_random_reorder(order, count, &prng);
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(&mm,
-					 set_node(&tmp, order[n] * size, 1)))
+		if (!expect_reserve_fail(test, &mm, set_node(&tmp, order[n] * size, 1)))
 			goto out;
 
 		/* Remove and reinsert should work */
 		drm_mm_remove_node(&nodes[order[n]]);
 		err = drm_mm_reserve_node(&mm, &nodes[order[n]]);
 		if (err) {
-			pr_err("reserve failed, step %d, start %llu\n",
+			KUNIT_FAIL(test, "reserve failed, step %d, start %llu\n",
 			       n, nodes[n].start);
 			ret = err;
 			goto out;
 		}
 	}
 
-	if (!assert_continuous(&mm, size))
+	if (!assert_continuous(test, &mm, size))
 		goto out;
 
 	/* Overlapping use should then fail */
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(&mm, set_node(&tmp, 0, size*count)))
+		if (!expect_reserve_fail(test, &mm, set_node(&tmp, 0, size*count)))
 			goto out;
 	}
 	for (n = 0; n < count; n++) {
-		if (!expect_reserve_fail(&mm,
-					 set_node(&tmp,
-						  size * n,
-						  size * (count - n))))
+		if (!expect_reserve_fail(test, &mm, set_node(&tmp, size * n, size * (count - n))))
 			goto out;
 	}
 
@@ -472,7 +437,7 @@ static int __igt_reserve(unsigned int count, u64 size)
 			node = &nodes[order[(o + m) % count]];
 			err = drm_mm_reserve_node(&mm, node);
 			if (err) {
-				pr_err("reserve failed, step %d/%d, start %llu\n",
+				KUNIT_FAIL(test, "reserve failed, step %d/%d, start %llu\n",
 				       m, n, node->start);
 				ret = err;
 				goto out;
@@ -481,7 +446,7 @@ static int __igt_reserve(unsigned int count, u64 size)
 
 		o += n;
 
-		if (!assert_continuous(&mm, size))
+		if (!assert_continuous(test, &mm, size))
 			goto out;
 	}
 
@@ -491,41 +456,29 @@ static int __igt_reserve(unsigned int count, u64 size)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	vfree(nodes);
-err_order:
 	kfree(order);
 err:
 	return ret;
 }
 
-static int igt_reserve(void *ignored)
+static void igt_mm_reserve(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
-	int n, ret;
+	int n;
 
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		ret = __igt_reserve(count, size - 1);
-		if (ret)
-			return ret;
-
-		ret = __igt_reserve(count, size);
-		if (ret)
-			return ret;
-
-		ret = __igt_reserve(count, size + 1);
-		if (ret)
-			return ret;
+		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size - 1));
+		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size));
+		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size + 1));
 
 		cond_resched();
 	}
-
-	return 0;
 }
 
-static bool expect_insert(struct drm_mm *mm, struct drm_mm_node *node,
-			  u64 size, u64 alignment, unsigned long color,
-			  const struct insert_mode *mode)
+static bool expect_insert(struct kunit *test, struct drm_mm *mm, struct drm_mm_node *node,
+			  u64 size, u64 alignment, unsigned long color, const struct insert_mode *mode)
 {
 	int err;
 
@@ -533,12 +486,13 @@ static bool expect_insert(struct drm_mm *mm, struct drm_mm_node *node,
 					 size, alignment, color,
 					 mode->mode);
 	if (err) {
-		pr_err("insert (size=%llu, alignment=%llu, color=%lu, mode=%s) failed with err=%d\n",
-		       size, alignment, color, mode->name, err);
+		KUNIT_FAIL(test,
+			   "insert (size=%llu, alignment=%llu, color=%lu, mode=%s) failed with err=%d\n",
+			   size, alignment, color, mode->name, err);
 		return false;
 	}
 
-	if (!assert_node(node, mm, size, alignment, color)) {
+	if (!assert_node(test, node, mm, size, alignment, color)) {
 		drm_mm_remove_node(node);
 		return false;
 	}
@@ -546,7 +500,7 @@ static bool expect_insert(struct drm_mm *mm, struct drm_mm_node *node,
 	return true;
 }
 
-static bool expect_insert_fail(struct drm_mm *mm, u64 size)
+static bool expect_insert_fail(struct kunit *test, struct drm_mm *mm, u64 size)
 {
 	struct drm_mm_node tmp = {};
 	int err;
@@ -556,17 +510,18 @@ static bool expect_insert_fail(struct drm_mm *mm, u64 size)
 		return true;
 
 	if (!err) {
-		pr_err("impossible insert succeeded, node %llu + %llu\n",
+		KUNIT_FAIL(test, "impossible insert succeeded, node %llu + %llu\n",
 		       tmp.start, tmp.size);
 		drm_mm_remove_node(&tmp);
 	} else {
-		pr_err("impossible insert failed with wrong error %d [expected %d], size %llu\n",
-		       err, -ENOSPC, size);
+		KUNIT_FAIL(test,
+			   "impossible insert failed with wrong error %d [expected %d], size %llu\n",
+			   err, -ENOSPC, size);
 	}
 	return false;
 }
 
-static int __igt_insert(unsigned int count, u64 size, bool replace)
+static int __igt_insert(struct kunit *test, unsigned int count, u64 size, bool replace)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const struct insert_mode *mode;
@@ -582,8 +537,7 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 
 	ret = -ENOMEM;
 	nodes = vmalloc(array_size(count, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	order = drm_random_order(count, &prng);
 	if (!order)
@@ -598,8 +552,8 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 
 			node = replace ? &tmp : &nodes[n];
 			memset(node, 0, sizeof(*node));
-			if (!expect_insert(&mm, node, size, 0, n, mode)) {
-				pr_err("%s insert failed, size %llu step %d\n",
+			if (!expect_insert(test, &mm, node, size, 0, n, mode)) {
+				KUNIT_FAIL(test, "%s insert failed, size %llu step %d\n",
 				       mode->name, size, n);
 				goto out;
 			}
@@ -607,32 +561,34 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 			if (replace) {
 				drm_mm_replace_node(&tmp, &nodes[n]);
 				if (drm_mm_node_allocated(&tmp)) {
-					pr_err("replaced old-node still allocated! step %d\n",
-					       n);
+					KUNIT_FAIL(test,
+						   "replaced old-node still allocated! step %d\n",
+						   n);
 					goto out;
 				}
 
-				if (!assert_node(&nodes[n], &mm, size, 0, n)) {
-					pr_err("replaced node did not inherit parameters, size %llu step %d\n",
-					       size, n);
+				if (!assert_node(test, &nodes[n], &mm, size, 0, n)) {
+					KUNIT_FAIL(test,
+						   "replaced node did not inherit parameters, size %llu step %d\n",
+						   size, n);
 					goto out;
 				}
 
 				if (tmp.start != nodes[n].start) {
-					pr_err("replaced node mismatch location expected [%llx + %llx], found [%llx + %llx]\n",
-					       tmp.start, size,
-					       nodes[n].start, nodes[n].size);
+					KUNIT_FAIL(test,
+						   "replaced node mismatch location expected [%llx + %llx], found [%llx + %llx]\n",
+						   tmp.start, size, nodes[n].start, nodes[n].size);
 					goto out;
 				}
 			}
 		}
 
 		/* After random insertion the nodes should be in order */
-		if (!assert_continuous(&mm, size))
+		if (!assert_continuous(test, &mm, size))
 			goto out;
 
 		/* Repeated use should then fail */
-		if (!expect_insert_fail(&mm, size))
+		if (!expect_insert_fail(test, &mm, size))
 			goto out;
 
 		/* Remove one and reinsert, as the only hole it should refill itself */
@@ -640,19 +596,20 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 			u64 addr = nodes[n].start;
 
 			drm_mm_remove_node(&nodes[n]);
-			if (!expect_insert(&mm, &nodes[n], size, 0, n, mode)) {
-				pr_err("%s reinsert failed, size %llu step %d\n",
+			if (!expect_insert(test, &mm, &nodes[n], size, 0, n, mode)) {
+				KUNIT_FAIL(test, "%s reinsert failed, size %llu step %d\n",
 				       mode->name, size, n);
 				goto out;
 			}
 
 			if (nodes[n].start != addr) {
-				pr_err("%s reinsert node moved, step %d, expected %llx, found %llx\n",
-				       mode->name, n, addr, nodes[n].start);
+				KUNIT_FAIL(test,
+					   "%s reinsert node moved, step %d, expected %llx, found %llx\n",
+					   mode->name, n, addr, nodes[n].start);
 				goto out;
 			}
 
-			if (!assert_continuous(&mm, size))
+			if (!assert_continuous(test, &mm, size))
 				goto out;
 		}
 
@@ -665,19 +622,20 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 
 			for (m = 0; m < n; m++) {
 				node = &nodes[order[(o + m) % count]];
-				if (!expect_insert(&mm, node, size, 0, n, mode)) {
-					pr_err("%s multiple reinsert failed, size %llu step %d\n",
-					       mode->name, size, n);
+				if (!expect_insert(test, &mm, node, size, 0, n, mode)) {
+					KUNIT_FAIL(test,
+							   "%s multiple reinsert failed, size %llu step %d\n",
+							   mode->name, size, n);
 					goto out;
 				}
 			}
 
 			o += n;
 
-			if (!assert_continuous(&mm, size))
+			if (!assert_continuous(test, &mm, size))
 				goto out;
 
-			if (!expect_insert_fail(&mm, size))
+			if (!expect_insert_fail(test, &mm, size))
 				goto out;
 		}
 
@@ -696,42 +654,30 @@ static int __igt_insert(unsigned int count, u64 size, bool replace)
 	kfree(order);
 err_nodes:
 	vfree(nodes);
-err:
 	return ret;
 }
 
-static int igt_insert(void *ignored)
+static void igt_mm_insert(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
 	unsigned int n;
-	int ret;
 
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		ret = __igt_insert(count, size - 1, false);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert(count, size, false);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert(count, size + 1, false);
-		if (ret)
-			return ret;
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size - 1, false));
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size, false));
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size + 1, false));
 
 		cond_resched();
 	}
 
-	return 0;
 }
 
-static int igt_replace(void *ignored)
+static void igt_mm_replace(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
 	unsigned int n;
-	int ret;
 
 	/* Reuse igt_insert to exercise replacement by inserting a dummy node,
 	 * then replacing it with the intended node. We want to check that
@@ -742,28 +688,17 @@ static int igt_replace(void *ignored)
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		ret = __igt_insert(count, size - 1, true);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert(count, size, true);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert(count, size + 1, true);
-		if (ret)
-			return ret;
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size - 1, true));
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size, true));
+		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size + 1, true));
 
 		cond_resched();
 	}
-
-	return 0;
 }
 
-static bool expect_insert_in_range(struct drm_mm *mm, struct drm_mm_node *node,
+static bool expect_insert_in_range(struct kunit *test, struct drm_mm *mm, struct drm_mm_node *node,
 				   u64 size, u64 alignment, unsigned long color,
-				   u64 range_start, u64 range_end,
-				   const struct insert_mode *mode)
+				   u64 range_start, u64 range_end, const struct insert_mode *mode)
 {
 	int err;
 
@@ -772,13 +707,14 @@ static bool expect_insert_in_range(struct drm_mm *mm, struct drm_mm_node *node,
 					  range_start, range_end,
 					  mode->mode);
 	if (err) {
-		pr_err("insert (size=%llu, alignment=%llu, color=%lu, mode=%s) nto range [%llx, %llx] failed with err=%d\n",
-		       size, alignment, color, mode->name,
-		       range_start, range_end, err);
+		KUNIT_FAIL(test,
+				   "insert (size=%llu, alignment=%llu, color=%lu, mode=%s) nto range [%llx, %llx] failed with err=%d\n",
+				   size, alignment, color, mode->name,
+				   range_start, range_end, err);
 		return false;
 	}
 
-	if (!assert_node(node, mm, size, alignment, color)) {
+	if (!assert_node(test, node, mm, size, alignment, color)) {
 		drm_mm_remove_node(node);
 		return false;
 	}
@@ -786,67 +722,63 @@ static bool expect_insert_in_range(struct drm_mm *mm, struct drm_mm_node *node,
 	return true;
 }
 
-static bool expect_insert_in_range_fail(struct drm_mm *mm,
-					u64 size,
-					u64 range_start,
-					u64 range_end)
+static bool expect_insert_in_range_fail(struct kunit *test, struct drm_mm *mm,
+					u64 size, u64 range_start, u64 range_end)
 {
 	struct drm_mm_node tmp = {};
 	int err;
 
-	err = drm_mm_insert_node_in_range(mm, &tmp,
-					  size, 0, 0,
-					  range_start, range_end,
+	err = drm_mm_insert_node_in_range(mm, &tmp, size, 0, 0, range_start, range_end,
 					  0);
 	if (likely(err == -ENOSPC))
 		return true;
 
 	if (!err) {
-		pr_err("impossible insert succeeded, node %llx + %llu, range [%llx, %llx]\n",
-		       tmp.start, tmp.size, range_start, range_end);
+		KUNIT_FAIL(test,
+				   "impossible insert succeeded, node %llx + %llu, range [%llx, %llx]\n",
+				   tmp.start, tmp.size, range_start, range_end);
 		drm_mm_remove_node(&tmp);
 	} else {
-		pr_err("impossible insert failed with wrong error %d [expected %d], size %llu, range [%llx, %llx]\n",
-		       err, -ENOSPC, size, range_start, range_end);
+		KUNIT_FAIL(test,
+				   "impossible insert failed with wrong error %d [expected %d], size %llu, range [%llx, %llx]\n",
+				   err, -ENOSPC, size, range_start, range_end);
 	}
 
 	return false;
 }
 
-static bool assert_contiguous_in_range(struct drm_mm *mm,
-				       u64 size,
-				       u64 start,
-				       u64 end)
+static bool assert_contiguous_in_range(struct kunit *test, struct drm_mm *mm,
+				       u64 size, u64 start, u64 end)
 {
 	struct drm_mm_node *node;
 	unsigned int n;
 
-	if (!expect_insert_in_range_fail(mm, size, start, end))
+	if (!expect_insert_in_range_fail(test, mm, size, start, end))
 		return false;
 
 	n = div64_u64(start + size - 1, size);
 	drm_mm_for_each_node(node, mm) {
 		if (node->start < start || node->start + node->size > end) {
-			pr_err("node %d out of range, address [%llx + %llu], range [%llx, %llx]\n",
-			       n, node->start, node->start + node->size, start, end);
+			KUNIT_FAIL(test,
+					   "node %d out of range, address [%llx + %llu], range [%llx, %llx]\n",
+					   n, node->start, node->start + node->size, start, end);
 			return false;
 		}
 
 		if (node->start != n * size) {
-			pr_err("node %d out of order, expected start %llx, found %llx\n",
+			KUNIT_FAIL(test, "node %d out of order, expected start %llx, found %llx\n",
 			       n, n * size, node->start);
 			return false;
 		}
 
 		if (node->size != size) {
-			pr_err("node %d has wrong size, expected size %llx, found %llx\n",
+			KUNIT_FAIL(test, "node %d has wrong size, expected size %llx, found %llx\n",
 			       n, size, node->size);
 			return false;
 		}
 
-		if (drm_mm_hole_follows(node) &&
-		    drm_mm_hole_node_end(node) < end) {
-			pr_err("node %d is followed by a hole!\n", n);
+		if (drm_mm_hole_follows(node) && drm_mm_hole_node_end(node) < end) {
+			KUNIT_FAIL(test, "node %d is followed by a hole!\n", n);
 			return false;
 		}
 
@@ -856,7 +788,7 @@ static bool assert_contiguous_in_range(struct drm_mm *mm,
 	if (start > 0) {
 		node = __drm_mm_interval_first(mm, 0, start - 1);
 		if (drm_mm_node_allocated(node)) {
-			pr_err("node before start: node=%llx+%llu, start=%llx\n",
+			KUNIT_FAIL(test, "node before start: node=%llx+%llu, start=%llx\n",
 			       node->start, node->size, start);
 			return false;
 		}
@@ -865,7 +797,7 @@ static bool assert_contiguous_in_range(struct drm_mm *mm,
 	if (end < U64_MAX) {
 		node = __drm_mm_interval_first(mm, end, U64_MAX);
 		if (drm_mm_node_allocated(node)) {
-			pr_err("node after end: node=%llx+%llu, end=%llx\n",
+			KUNIT_FAIL(test, "node after end: node=%llx+%llu, end=%llx\n",
 			       node->start, node->size, end);
 			return false;
 		}
@@ -874,7 +806,7 @@ static bool assert_contiguous_in_range(struct drm_mm *mm,
 	return true;
 }
 
-static int __igt_insert_range(unsigned int count, u64 size, u64 start, u64 end)
+static int __igt_insert_range(struct kunit *test, unsigned int count, u64 size, u64 start, u64 end)
 {
 	const struct insert_mode *mode;
 	struct drm_mm mm;
@@ -886,14 +818,13 @@ static int __igt_insert_range(unsigned int count, u64 size, u64 start, u64 end)
 	DRM_MM_BUG_ON(!size);
 	DRM_MM_BUG_ON(end <= start);
 
-	/* Very similar to __igt_insert(), but now instead of populating the
+	/* Very similar to __igt_insert(struct kunit *test, ), but now instead of populating the
 	 * full range of the drm_mm, we try to fill a small portion of it.
 	 */
 
 	ret = -ENOMEM;
 	nodes = vzalloc(array_size(count, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	ret = -EINVAL;
 	drm_mm_init(&mm, 0, count * size);
@@ -903,20 +834,19 @@ static int __igt_insert_range(unsigned int count, u64 size, u64 start, u64 end)
 
 	for (mode = insert_modes; mode->name; mode++) {
 		for (n = start_n; n <= end_n; n++) {
-			if (!expect_insert_in_range(&mm, &nodes[n],
-						    size, size, n,
-						    start, end, mode)) {
-				pr_err("%s insert failed, size %llu, step %d [%d, %d], range [%llx, %llx]\n",
-				       mode->name, size, n,
-				       start_n, end_n,
-				       start, end);
+			if (!expect_insert_in_range(test, &mm, &nodes[n], size, size, n,
+						start, end, mode)) {
+				KUNIT_FAIL(test,
+						   "%s insert failed, size %llu, step %d [%d, %d], range [%llx, %llx]\n",
+						   mode->name, size, n, start_n, end_n, start, end);
 				goto out;
 			}
 		}
 
-		if (!assert_contiguous_in_range(&mm, size, start, end)) {
-			pr_err("%s: range [%llx, %llx] not full after initialisation, size=%llu\n",
-			       mode->name, start, end, size);
+		if (!assert_contiguous_in_range(test, &mm, size, start, end)) {
+			KUNIT_FAIL(test,
+				   "%s: range [%llx, %llx] not full after initialisation, size=%llu\n",
+				   mode->name, start, end, size);
 			goto out;
 		}
 
@@ -925,23 +855,24 @@ static int __igt_insert_range(unsigned int count, u64 size, u64 start, u64 end)
 			u64 addr = nodes[n].start;
 
 			drm_mm_remove_node(&nodes[n]);
-			if (!expect_insert_in_range(&mm, &nodes[n],
-						    size, size, n,
+			if (!expect_insert_in_range(test, &mm, &nodes[n], size, size, n,
 						    start, end, mode)) {
-				pr_err("%s reinsert failed, step %d\n", mode->name, n);
+				KUNIT_FAIL(test, "%s reinsert failed, step %d\n", mode->name, n);
 				goto out;
 			}
 
 			if (nodes[n].start != addr) {
-				pr_err("%s reinsert node moved, step %d, expected %llx, found %llx\n",
-				       mode->name, n, addr, nodes[n].start);
+				KUNIT_FAIL(test,
+					   "%s reinsert node moved, step %d, expected %llx, found %llx\n",
+					   mode->name, n, addr, nodes[n].start);
 				goto out;
 			}
 		}
 
-		if (!assert_contiguous_in_range(&mm, size, start, end)) {
-			pr_err("%s: range [%llx, %llx] not full after reinsertion, size=%llu\n",
-			       mode->name, start, end, size);
+		if (!assert_contiguous_in_range(test, &mm, size, start, end)) {
+			KUNIT_FAIL(test,
+				   "%s: range [%llx, %llx] not full after reinsertion, size=%llu\n",
+				   mode->name, start, end, size);
 			goto out;
 		}
 
@@ -958,11 +889,10 @@ static int __igt_insert_range(unsigned int count, u64 size, u64 start, u64 end)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	vfree(nodes);
-err:
 	return ret;
 }
 
-static int insert_outside_range(void)
+static int insert_outside_range(struct kunit *test)
 {
 	struct drm_mm mm;
 	const unsigned int start = 1024;
@@ -971,81 +901,57 @@ static int insert_outside_range(void)
 
 	drm_mm_init(&mm, start, size);
 
-	if (!expect_insert_in_range_fail(&mm, 1, 0, start))
+	if (!expect_insert_in_range_fail(test, &mm, 1, 0, start))
 		return -EINVAL;
 
-	if (!expect_insert_in_range_fail(&mm, size,
+	if (!expect_insert_in_range_fail(test, &mm, size,
 					 start - size/2, start + (size+1)/2))
 		return -EINVAL;
 
-	if (!expect_insert_in_range_fail(&mm, size,
+	if (!expect_insert_in_range_fail(test, &mm, size,
 					 end - (size+1)/2, end + size/2))
 		return -EINVAL;
 
-	if (!expect_insert_in_range_fail(&mm, 1, end, end + size))
+	if (!expect_insert_in_range_fail(test, &mm, 1, end, end + size))
 		return -EINVAL;
 
 	drm_mm_takedown(&mm);
 	return 0;
 }
 
-static int igt_insert_range(void *ignored)
+static void igt_mm_insert_range(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(13), max_iterations);
 	unsigned int n;
-	int ret;
 
 	/* Check that requests outside the bounds of drm_mm are rejected. */
-	ret = insert_outside_range();
-	if (ret)
-		return ret;
+	KUNIT_ASSERT_FALSE(test, insert_outside_range(test));
 
 	for_each_prime_number_from(n, 1, 50) {
 		const u64 size = BIT_ULL(n);
 		const u64 max = count * size;
 
-		ret = __igt_insert_range(count, size, 0, max);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert_range(count, size, 1, max);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert_range(count, size, 0, max - 1);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert_range(count, size, 0, max/2);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert_range(count, size, max/2, max);
-		if (ret)
-			return ret;
-
-		ret = __igt_insert_range(count, size, max/4+1, 3*max/4-1);
-		if (ret)
-			return ret;
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max));
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 1, max));
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max - 1));
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max/2));
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, max/2, max/2));
+		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, max/4+1, 3*max/4-1));
 
 		cond_resched();
 	}
-
-	return 0;
 }
 
-static int prepare_igt_frag(struct drm_mm *mm,
-			    struct drm_mm_node *nodes,
-			    unsigned int num_insert,
+static int prepare_igt_frag(struct kunit *test, struct drm_mm *mm,
+			    struct drm_mm_node *nodes, unsigned int num_insert,
 			    const struct insert_mode *mode)
 {
 	unsigned int size = 4096;
 	unsigned int i;
 
 	for (i = 0; i < num_insert; i++) {
-		if (!expect_insert(mm, &nodes[i], size, 0, i,
-				   mode) != 0) {
-			pr_err("%s insert failed\n", mode->name);
+		if (!expect_insert(test, mm, &nodes[i], size, 0, i, mode) != 0) {
+			KUNIT_FAIL(test, "%s insert failed\n", mode->name);
 			return -EINVAL;
 		}
 	}
@@ -1060,9 +966,8 @@ static int prepare_igt_frag(struct drm_mm *mm,
 
 }
 
-static u64 get_insert_time(struct drm_mm *mm,
-			   unsigned int num_insert,
-			   struct drm_mm_node *nodes,
+static u64 get_insert_time(struct kunit *test, struct drm_mm *mm,
+			   unsigned int num_insert, struct drm_mm_node *nodes,
 			   const struct insert_mode *mode)
 {
 	unsigned int size = 8192;
@@ -1071,8 +976,8 @@ static u64 get_insert_time(struct drm_mm *mm,
 
 	start = ktime_get();
 	for (i = 0; i < num_insert; i++) {
-		if (!expect_insert(mm, &nodes[i], size, 0, i, mode) != 0) {
-			pr_err("%s insert failed\n", mode->name);
+		if (!expect_insert(test, mm, &nodes[i], size, 0, i, mode) != 0) {
+			KUNIT_FAIL(test, "%s insert failed\n", mode->name);
 			return 0;
 		}
 	}
@@ -1080,27 +985,25 @@ static u64 get_insert_time(struct drm_mm *mm,
 	return ktime_to_ns(ktime_sub(ktime_get(), start));
 }
 
-static int igt_frag(void *ignored)
+static void igt_mm_frag(struct kunit *test)
 {
 	struct drm_mm mm;
 	const struct insert_mode *mode;
 	struct drm_mm_node *nodes, *node, *next;
 	unsigned int insert_size = 10000;
 	unsigned int scale_factor = 4;
-	int ret = -EINVAL;
 
 	/* We need 4 * insert_size nodes to hold intermediate allocated
 	 * drm_mm nodes.
-	 * 1 times for prepare_igt_frag()
-	 * 1 times for get_insert_time()
-	 * 2 times for get_insert_time()
+	 * 1 times for prepare_igt_frag(struct kunit *test, )
+	 * 1 times for get_insert_time(struct kunit *test, )
+	 * 2 times for get_insert_time(struct kunit *test, )
 	 */
 	nodes = vzalloc(array_size(insert_size * 4, sizeof(*nodes)));
-	if (!nodes)
-		return -ENOMEM;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	/* For BOTTOMUP and TOPDOWN, we first fragment the
-	 * address space using prepare_igt_frag() and then try to verify
+	 * address space using prepare_igt_frag(struct kunit *test, ) and then try to verify
 	 * that that insertions scale quadratically from 10k to 20k insertions
 	 */
 	drm_mm_init(&mm, 1, U64_MAX - 2);
@@ -1111,28 +1014,25 @@ static int igt_frag(void *ignored)
 		    mode->mode != DRM_MM_INSERT_HIGH)
 			continue;
 
-		ret = prepare_igt_frag(&mm, nodes, insert_size, mode);
-		if (ret)
+		if (prepare_igt_frag(test, &mm, nodes, insert_size, mode))
 			goto err;
 
-		insert_time1 = get_insert_time(&mm, insert_size,
+		insert_time1 = get_insert_time(test, &mm, insert_size,
 					       nodes + insert_size, mode);
 		if (insert_time1 == 0)
 			goto err;
 
-		insert_time2 = get_insert_time(&mm, (insert_size * 2),
+		insert_time2 = get_insert_time(test, &mm, (insert_size * 2),
 					       nodes + insert_size * 2, mode);
 		if (insert_time2 == 0)
 			goto err;
 
-		pr_info("%s fragmented insert of %u and %u insertions took %llu and %llu nsecs\n",
-			mode->name, insert_size, insert_size * 2,
-			insert_time1, insert_time2);
+		kunit_info(test, "%s fragmented insert of %u and %u insertions took %llu and %llu nsecs\n",
+			mode->name, insert_size, insert_size * 2, insert_time1, insert_time2);
 
 		if (insert_time2 > (scale_factor * insert_time1)) {
-			pr_err("%s fragmented insert took %llu nsecs more\n",
-			       mode->name,
-			       insert_time2 - (scale_factor * insert_time1));
+			KUNIT_FAIL(test, "%s fragmented insert took %llu nsecs more\n",
+			       mode->name, insert_time2 - (scale_factor * insert_time1));
 			goto err;
 		}
 
@@ -1140,24 +1040,20 @@ static int igt_frag(void *ignored)
 			drm_mm_remove_node(node);
 	}
 
-	ret = 0;
 err:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	vfree(nodes);
-
-	return ret;
 }
 
-static int igt_align(void *ignored)
+static void igt_mm_align(struct kunit *test)
 {
 	const struct insert_mode *mode;
 	const unsigned int max_count = min(8192u, max_prime);
 	struct drm_mm mm;
 	struct drm_mm_node *nodes, *node, *next;
 	unsigned int prime;
-	int ret = -EINVAL;
 
 	/* For each of the possible insertion modes, we pick a few
 	 * arbitrary alignments and check that the inserted node
@@ -1165,8 +1061,7 @@ static int igt_align(void *ignored)
 	 */
 
 	nodes = vzalloc(array_size(max_count, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	drm_mm_init(&mm, 1, U64_MAX - 2);
 
@@ -1176,10 +1071,8 @@ static int igt_align(void *ignored)
 		for_each_prime_number_from(prime, 1, max_count) {
 			u64 size = next_prime_number(prime);
 
-			if (!expect_insert(&mm, &nodes[i],
-					   size, prime, i,
-					   mode)) {
-				pr_err("%s insert failed with alignment=%d",
+			if (!expect_insert(test, &mm, &nodes[i], size, prime, i, mode)) {
+				KUNIT_FAIL(test, "%s insert failed with alignment=%d",
 				       mode->name, prime);
 				goto out;
 			}
@@ -1194,22 +1087,18 @@ static int igt_align(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	vfree(nodes);
-err:
-	return ret;
 }
 
-static int igt_align_pot(int max)
+static void igt_align_pot(struct kunit *test, int max)
 {
 	struct drm_mm mm;
 	struct drm_mm_node *node, *next;
 	int bit;
-	int ret = -EINVAL;
 
 	/* Check that we can align to the full u64 address space */
 
@@ -1220,51 +1109,45 @@ static int igt_align_pot(int max)
 
 		node = kzalloc(sizeof(*node), GFP_KERNEL);
 		if (!node) {
-			ret = -ENOMEM;
+			KUNIT_FAIL(test, "failed to allocate node");
 			goto out;
 		}
 
 		align = BIT_ULL(bit);
 		size = BIT_ULL(bit-1) + 1;
-		if (!expect_insert(&mm, node,
-				   size, align, bit,
-				   &insert_modes[0])) {
-			pr_err("insert failed with alignment=%llx [%d]",
-			       align, bit);
+		if (!expect_insert(test, &mm, node, size, align, bit, &insert_modes[0])) {
+			KUNIT_FAIL(test, "insert failed with alignment=%llx [%d]", align, bit);
 			goto out;
 		}
 
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm) {
 		drm_mm_remove_node(node);
 		kfree(node);
 	}
 	drm_mm_takedown(&mm);
-	return ret;
 }
 
-static int igt_align32(void *ignored)
+static void igt_mm_align32(struct kunit *test)
 {
-	return igt_align_pot(32);
+	igt_align_pot(test, 32);
 }
 
-static int igt_align64(void *ignored)
+static void igt_mm_align64(struct kunit *test)
 {
-	return igt_align_pot(64);
+	igt_align_pot(test, 64);
 }
 
-static void show_scan(const struct drm_mm_scan *scan)
+static void show_scan(struct kunit *test, const struct drm_mm_scan *scan)
 {
-	pr_info("scan: hit [%llx, %llx], size=%lld, align=%lld, color=%ld\n",
-		scan->hit_start, scan->hit_end,
-		scan->size, scan->alignment, scan->color);
+	kunit_info(test, "scan: hit [%llx, %llx], size=%lld, align=%lld, color=%ld\n",
+		scan->hit_start, scan->hit_end, scan->size, scan->alignment, scan->color);
 }
 
-static void show_holes(const struct drm_mm *mm, int count)
+static void show_holes(struct kunit *test, const struct drm_mm *mm, int count)
 {
 	u64 hole_start, hole_end;
 	struct drm_mm_node *hole;
@@ -1274,19 +1157,15 @@ static void show_holes(const struct drm_mm *mm, int count)
 		const char *node1 = NULL, *node2 = NULL;
 
 		if (drm_mm_node_allocated(hole))
-			node1 = kasprintf(GFP_KERNEL,
-					  "[%llx + %lld, color=%ld], ",
+			node1 = kasprintf(GFP_KERNEL, "[%llx + %lld, color=%ld], ",
 					  hole->start, hole->size, hole->color);
 
 		if (drm_mm_node_allocated(next))
-			node2 = kasprintf(GFP_KERNEL,
-					  ", [%llx + %lld, color=%ld]",
+			node2 = kasprintf(GFP_KERNEL, ", [%llx + %lld, color=%ld]",
 					  next->start, next->size, next->color);
 
-		pr_info("%sHole [%llx - %llx, size %lld]%s\n",
-			node1,
-			hole_start, hole_end, hole_end - hole_start,
-			node2);
+		kunit_info(test, "%sHole [%llx - %llx, size %lld]%s\n", node1,
+			hole_start, hole_end, hole_end - hole_start, node2);
 
 		kfree(node2);
 		kfree(node1);
@@ -1301,12 +1180,9 @@ struct evict_node {
 	struct list_head link;
 };
 
-static bool evict_nodes(struct drm_mm_scan *scan,
-			struct evict_node *nodes,
-			unsigned int *order,
-			unsigned int count,
-			bool use_color,
-			struct list_head *evict_list)
+static bool evict_nodes(struct kunit *test, struct drm_mm_scan *scan,
+			struct evict_node *nodes, unsigned int *order, unsigned int count,
+			bool use_color, struct list_head *evict_list)
 {
 	struct evict_node *e, *en;
 	unsigned int i;
@@ -1322,8 +1198,9 @@ static bool evict_nodes(struct drm_mm_scan *scan,
 			list_del(&e->link);
 	}
 	if (list_empty(evict_list)) {
-		pr_err("Failed to find eviction: size=%lld [avail=%d], align=%lld (color=%lu)\n",
-		       scan->size, count, scan->alignment, scan->color);
+		KUNIT_FAIL(test,
+			   "Failed to find eviction: size=%lld [avail=%d], align=%lld (color=%lu)\n",
+			   scan->size, count, scan->alignment, scan->color);
 		return false;
 	}
 
@@ -1340,7 +1217,8 @@ static bool evict_nodes(struct drm_mm_scan *scan,
 		}
 	} else {
 		if (drm_mm_scan_color_evict(scan)) {
-			pr_err("drm_mm_scan_color_evict unexpectedly reported overlapping nodes!\n");
+			KUNIT_FAIL(test,
+				   "drm_mm_scan_color_evict unexpectedly reported overlapping nodes!\n");
 			return false;
 		}
 	}
@@ -1348,9 +1226,8 @@ static bool evict_nodes(struct drm_mm_scan *scan,
 	return true;
 }
 
-static bool evict_nothing(struct drm_mm *mm,
-			  unsigned int total_size,
-			  struct evict_node *nodes)
+static bool evict_nothing(struct kunit *test, struct drm_mm *mm,
+			  unsigned int total_size, struct evict_node *nodes)
 {
 	struct drm_mm_scan scan;
 	LIST_HEAD(evict_list);
@@ -1371,7 +1248,7 @@ static bool evict_nothing(struct drm_mm *mm,
 		e = &nodes[n];
 
 		if (!drm_mm_node_allocated(&e->node)) {
-			pr_err("node[%d] no longer allocated!\n", n);
+			KUNIT_FAIL(test, "node[%d] no longer allocated!\n", n);
 			return false;
 		}
 
@@ -1387,17 +1264,16 @@ static bool evict_nothing(struct drm_mm *mm,
 		e = &nodes[n];
 
 		if (!e->link.next) {
-			pr_err("node[%d] no longer connected!\n", n);
+			KUNIT_FAIL(test, "node[%d] no longer connected!\n", n);
 			return false;
 		}
 	}
 
-	return assert_continuous(mm, nodes[0].node.size);
+	return assert_continuous(test, mm, nodes[0].node.size);
 }
 
-static bool evict_everything(struct drm_mm *mm,
-			     unsigned int total_size,
-			     struct evict_node *nodes)
+static bool evict_everything(struct kunit *test, struct drm_mm *mm,
+			     unsigned int total_size, struct evict_node *nodes)
 {
 	struct drm_mm_scan scan;
 	LIST_HEAD(evict_list);
@@ -1417,7 +1293,7 @@ static bool evict_everything(struct drm_mm *mm,
 	list_for_each_entry(e, &evict_list, link) {
 		if (!drm_mm_scan_remove_block(&scan, &e->node)) {
 			if (!err) {
-				pr_err("Node %lld not marked for eviction!\n",
+				KUNIT_FAIL(test, "Node %lld not marked for eviction!\n",
 				       e->node.start);
 				err = -EINVAL;
 			}
@@ -1429,29 +1305,25 @@ static bool evict_everything(struct drm_mm *mm,
 	list_for_each_entry(e, &evict_list, link)
 		drm_mm_remove_node(&e->node);
 
-	if (!assert_one_hole(mm, 0, total_size))
+	if (!assert_one_hole(test, mm, 0, total_size))
 		return false;
 
 	list_for_each_entry(e, &evict_list, link) {
 		err = drm_mm_reserve_node(mm, &e->node);
 		if (err) {
-			pr_err("Failed to reinsert node after eviction: start=%llx\n",
+			KUNIT_FAIL(test, "Failed to reinsert node after eviction: start=%llx\n",
 			       e->node.start);
 			return false;
 		}
 	}
 
-	return assert_continuous(mm, nodes[0].node.size);
+	return assert_continuous(test, mm, nodes[0].node.size);
 }
 
-static int evict_something(struct drm_mm *mm,
-			   u64 range_start, u64 range_end,
-			   struct evict_node *nodes,
-			   unsigned int *order,
-			   unsigned int count,
-			   unsigned int size,
-			   unsigned int alignment,
-			   const struct insert_mode *mode)
+static int evict_something(struct kunit *test, struct drm_mm *mm,
+			   u64 range_start, u64 range_end, struct evict_node *nodes,
+			   unsigned int *order, unsigned int count, unsigned int size,
+			   unsigned int alignment, const struct insert_mode *mode)
 {
 	struct drm_mm_scan scan;
 	LIST_HEAD(evict_list);
@@ -1459,38 +1331,35 @@ static int evict_something(struct drm_mm *mm,
 	struct drm_mm_node tmp;
 	int err;
 
-	drm_mm_scan_init_with_range(&scan, mm,
-				    size, alignment, 0,
-				    range_start, range_end,
-				    mode->mode);
-	if (!evict_nodes(&scan,
-			 nodes, order, count, false,
-			 &evict_list))
+	drm_mm_scan_init_with_range(&scan, mm, size, alignment, 0, range_start,
+			range_end, mode->mode);
+	if (!evict_nodes(test, &scan, nodes, order, count, false, &evict_list))
 		return -EINVAL;
 
 	memset(&tmp, 0, sizeof(tmp));
 	err = drm_mm_insert_node_generic(mm, &tmp, size, alignment, 0,
 					 DRM_MM_INSERT_EVICT);
 	if (err) {
-		pr_err("Failed to insert into eviction hole: size=%d, align=%d\n",
+		KUNIT_FAIL(test, "Failed to insert into eviction hole: size=%d, align=%d\n",
 		       size, alignment);
-		show_scan(&scan);
-		show_holes(mm, 3);
+		show_scan(test, &scan);
+		show_holes(test, mm, 3);
 		return err;
 	}
 
 	if (tmp.start < range_start || tmp.start + tmp.size > range_end) {
-		pr_err("Inserted [address=%llu + %llu] did not fit into the request range [%llu, %llu]\n",
-		       tmp.start, tmp.size, range_start, range_end);
+		KUNIT_FAIL(test,
+			   "Inserted [address=%llu + %llu] did not fit into the request range [%llu, %llu]\n",
+			   tmp.start, tmp.size, range_start, range_end);
 		err = -EINVAL;
 	}
 
-	if (!assert_node(&tmp, mm, size, alignment, 0) ||
+	if (!assert_node(test, &tmp, mm, size, alignment, 0) ||
 	    drm_mm_hole_follows(&tmp)) {
-		pr_err("Inserted did not fill the eviction hole: size=%lld [%d], align=%d [rem=%lld], start=%llx, hole-follows?=%d\n",
-		       tmp.size, size,
-		       alignment, misalignment(&tmp, alignment),
-		       tmp.start, drm_mm_hole_follows(&tmp));
+		KUNIT_FAIL(test,
+			   "Inserted did not fill the eviction hole: size=%lld [%d], align=%d [rem=%lld], start=%llx, hole-follows?=%d\n",
+			   tmp.size, size, alignment, misalignment(&tmp, alignment),
+			   tmp.start, drm_mm_hole_follows(&tmp));
 		err = -EINVAL;
 	}
 
@@ -1501,21 +1370,21 @@ static int evict_something(struct drm_mm *mm,
 	list_for_each_entry(e, &evict_list, link) {
 		err = drm_mm_reserve_node(mm, &e->node);
 		if (err) {
-			pr_err("Failed to reinsert node after eviction: start=%llx\n",
+			KUNIT_FAIL(test, "Failed to reinsert node after eviction: start=%llx\n",
 			       e->node.start);
 			return err;
 		}
 	}
 
-	if (!assert_continuous(mm, nodes[0].node.size)) {
-		pr_err("range is no longer continuous\n");
+	if (!assert_continuous(test, mm, nodes[0].node.size)) {
+		KUNIT_FAIL(test, "range is no longer continuous\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int igt_evict(void *ignored)
+static void igt_mm_evict(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int size = 8192;
@@ -1524,7 +1393,6 @@ static int igt_evict(void *ignored)
 	struct evict_node *nodes;
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
-	int ret, err;
 
 	/* Here we populate a full drm_mm and then try and insert a new node
 	 * by evicting other nodes in a random order. The drm_mm_scan should
@@ -1533,61 +1401,48 @@ static int igt_evict(void *ignored)
 	 * sizes to try and stress the hole finder.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(size, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	order = drm_random_order(size, &prng);
 	if (!order)
 		goto err_nodes;
 
-	ret = -EINVAL;
 	drm_mm_init(&mm, 0, size);
 	for (n = 0; n < size; n++) {
-		err = drm_mm_insert_node(&mm, &nodes[n].node, 1);
-		if (err) {
-			pr_err("insert failed, step %d\n", n);
-			ret = err;
+		if (drm_mm_insert_node(&mm, &nodes[n].node, 1)) {
+			KUNIT_FAIL(test, "insert failed, step %d\n", n);
 			goto out;
 		}
 	}
 
 	/* First check that using the scanner doesn't break the mm */
-	if (!evict_nothing(&mm, size, nodes)) {
-		pr_err("evict_nothing() failed\n");
+	if (!evict_nothing(test, &mm, size, nodes)) {
+		KUNIT_FAIL(test, "evict_nothing() failed\n");
 		goto out;
 	}
-	if (!evict_everything(&mm, size, nodes)) {
-		pr_err("evict_everything() failed\n");
+	if (!evict_everything(test, &mm, size, nodes)) {
+		KUNIT_FAIL(test, "evict_everything() failed\n");
 		goto out;
 	}
 
 	for (mode = evict_modes; mode->name; mode++) {
 		for (n = 1; n <= size; n <<= 1) {
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, 0, U64_MAX,
-					      nodes, order, size,
-					      n, 1,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u) failed\n",
+			if (evict_something(test, &mm, 0, U64_MAX, nodes, order, size, n, 1, mode)) {
+				KUNIT_FAIL(test, "%s evict_something(size=%u) failed\n",
 				       mode->name, n);
-				ret = err;
 				goto out;
 			}
 		}
 
 		for (n = 1; n < size; n <<= 1) {
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, 0, U64_MAX,
-					      nodes, order, size,
-					      size/2, n,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u, alignment=%u) failed\n",
-				       mode->name, size/2, n);
-				ret = err;
+			if (evict_something(test, &mm, 0, U64_MAX, nodes, order, size,
+					      size/2, n, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_something(size=%u, alignment=%u) failed\n",
+					   mode->name, size/2, n);
 				goto out;
 			}
 		}
@@ -1598,14 +1453,10 @@ static int igt_evict(void *ignored)
 			DRM_MM_BUG_ON(!nsize);
 
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, 0, U64_MAX,
-					      nodes, order, size,
-					      nsize, n,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u, alignment=%u) failed\n",
-				       mode->name, nsize, n);
-				ret = err;
+			if (evict_something(test, &mm, 0, U64_MAX, nodes, order, size,
+					      nsize, n, mode)) {
+				KUNIT_FAIL(test, "%s evict_something(size=%u, alignment=%u) failed\n",
+					   mode->name, nsize, n);
 				goto out;
 			}
 		}
@@ -1613,7 +1464,6 @@ static int igt_evict(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
@@ -1621,11 +1471,9 @@ static int igt_evict(void *ignored)
 	kfree(order);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
-static int igt_evict_range(void *ignored)
+static void igt_mm_evict_range(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int size = 8192;
@@ -1637,28 +1485,22 @@ static int igt_evict_range(void *ignored)
 	struct evict_node *nodes;
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
-	int ret, err;
 
 	/* Like igt_evict() but now we are limiting the search to a
 	 * small portion of the full drm_mm.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(size, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	order = drm_random_order(size, &prng);
 	if (!order)
 		goto err_nodes;
 
-	ret = -EINVAL;
 	drm_mm_init(&mm, 0, size);
 	for (n = 0; n < size; n++) {
-		err = drm_mm_insert_node(&mm, &nodes[n].node, 1);
-		if (err) {
-			pr_err("insert failed, step %d\n", n);
-			ret = err;
+		if (drm_mm_insert_node(&mm, &nodes[n].node, 1)) {
+			KUNIT_FAIL(test, "insert failed, step %d\n", n);
 			goto out;
 		}
 	}
@@ -1666,26 +1508,22 @@ static int igt_evict_range(void *ignored)
 	for (mode = evict_modes; mode->name; mode++) {
 		for (n = 1; n <= range_size; n <<= 1) {
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, range_start, range_end,
-					      nodes, order, size,
-					      n, 1,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u) failed with range [%u, %u]\n",
-				       mode->name, n, range_start, range_end);
+			if (evict_something(test, &mm, range_start, range_end, nodes,
+					order, size, n, 1, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_something(size=%u) failed with range [%u, %u]\n",
+					   mode->name, n, range_start, range_end);
 				goto out;
 			}
 		}
 
 		for (n = 1; n <= range_size; n <<= 1) {
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, range_start, range_end,
-					      nodes, order, size,
-					      range_size/2, n,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u, alignment=%u) failed with range [%u, %u]\n",
-				       mode->name, range_size/2, n, range_start, range_end);
+			if (evict_something(test, &mm, range_start, range_end, nodes,
+					order, size, range_size/2, n, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_something(size=%u, alignment=%u) failed with range [%u, %u]\n",
+					   mode->name, range_size/2, n, range_start, range_end);
 				goto out;
 			}
 		}
@@ -1696,13 +1534,11 @@ static int igt_evict_range(void *ignored)
 			DRM_MM_BUG_ON(!nsize);
 
 			drm_random_reorder(order, size, &prng);
-			err = evict_something(&mm, range_start, range_end,
-					      nodes, order, size,
-					      nsize, n,
-					      mode);
-			if (err) {
-				pr_err("%s evict_something(size=%u, alignment=%u) failed with range [%u, %u]\n",
-				       mode->name, nsize, n, range_start, range_end);
+			if (evict_something(test, &mm, range_start, range_end, nodes,
+					order, size, nsize, n, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_something(size=%u, alignment=%u) failed with range [%u, %u]\n",
+					   mode->name, nsize, n, range_start, range_end);
 				goto out;
 			}
 		}
@@ -1710,7 +1546,6 @@ static int igt_evict_range(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
@@ -1718,8 +1553,6 @@ static int igt_evict_range(void *ignored)
 	kfree(order);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
 static unsigned int node_index(const struct drm_mm_node *node)
@@ -1727,7 +1560,7 @@ static unsigned int node_index(const struct drm_mm_node *node)
 	return div64_u64(node->start, node->size);
 }
 
-static int igt_topdown(void *ignored)
+static void igt_mm_topdown(struct kunit *test)
 {
 	const struct insert_mode *topdown = &insert_modes[TOPDOWN];
 	DRM_RND_STATE(prng, random_seed);
@@ -1737,17 +1570,14 @@ static int igt_topdown(void *ignored)
 	struct drm_mm mm;
 	struct drm_mm_node *nodes, *node, *next;
 	unsigned int *order, n, m, o = 0;
-	int ret;
 
 	/* When allocating top-down, we expect to be returned a node
 	 * from a suitable hole at the top of the drm_mm. We check that
 	 * the returned node does match the highest available slot.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(count, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	bitmap = bitmap_zalloc(count, GFP_KERNEL);
 	if (!bitmap)
@@ -1757,28 +1587,26 @@ static int igt_topdown(void *ignored)
 	if (!order)
 		goto err_bitmap;
 
-	ret = -EINVAL;
 	for (size = 1; size <= 64; size <<= 1) {
 		drm_mm_init(&mm, 0, size*count);
 		for (n = 0; n < count; n++) {
-			if (!expect_insert(&mm, &nodes[n],
-					   size, 0, n,
-					   topdown)) {
-				pr_err("insert failed, size %u step %d\n", size, n);
+			if (!expect_insert(test, &mm, &nodes[n], size, 0, n, topdown)) {
+				KUNIT_FAIL(test, "insert failed, size %u step %d\n", size, n);
 				goto out;
 			}
 
 			if (drm_mm_hole_follows(&nodes[n])) {
-				pr_err("hole after topdown insert %d, start=%llx\n, size=%u",
-				       n, nodes[n].start, size);
+				KUNIT_FAIL(test,
+					   "hole after topdown insert %d, start=%llx\n, size=%u",
+					   n, nodes[n].start, size);
 				goto out;
 			}
 
-			if (!assert_one_hole(&mm, 0, size*(count - n - 1)))
+			if (!assert_one_hole(test, &mm, 0, size*(count - n - 1)))
 				goto out;
 		}
 
-		if (!assert_continuous(&mm, size))
+		if (!assert_continuous(test, &mm, size))
 			goto out;
 
 		drm_random_reorder(order, count, &prng);
@@ -1793,23 +1621,23 @@ static int igt_topdown(void *ignored)
 				unsigned int last;
 
 				node = &nodes[order[(o + m) % count]];
-				if (!expect_insert(&mm, node,
-						   size, 0, 0,
-						   topdown)) {
-					pr_err("insert failed, step %d/%d\n", m, n);
+				if (!expect_insert(test, &mm, node, size, 0, 0, topdown)) {
+					KUNIT_FAIL(test, "insert failed, step %d/%d\n", m, n);
 					goto out;
 				}
 
 				if (drm_mm_hole_follows(node)) {
-					pr_err("hole after topdown insert %d/%d, start=%llx\n",
-					       m, n, node->start);
+					KUNIT_FAIL(test,
+						   "hole after topdown insert %d/%d, start=%llx\n",
+						   m, n, node->start);
 					goto out;
 				}
 
 				last = find_last_bit(bitmap, count);
 				if (node_index(node) != last) {
-					pr_err("node %d/%d, size %d, not inserted into upmost hole, expected %d, found %d\n",
-					       m, n, size, last, node_index(node));
+					KUNIT_FAIL(test,
+						   "node %d/%d, size %d, not inserted into upmost hole, expected %d, found %d\n",
+						   m, n, size, last, node_index(node));
 					goto out;
 				}
 
@@ -1827,7 +1655,6 @@ static int igt_topdown(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
@@ -1837,11 +1664,9 @@ static int igt_topdown(void *ignored)
 	bitmap_free(bitmap);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
-static int igt_bottomup(void *ignored)
+static void igt_mm_bottomup(struct kunit *test)
 {
 	const struct insert_mode *bottomup = &insert_modes[BOTTOMUP];
 	DRM_RND_STATE(prng, random_seed);
@@ -1851,16 +1676,13 @@ static int igt_bottomup(void *ignored)
 	struct drm_mm mm;
 	struct drm_mm_node *nodes, *node, *next;
 	unsigned int *order, n, m, o = 0;
-	int ret;
 
 	/* Like igt_topdown, but instead of searching for the last hole,
 	 * we search for the first.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(count, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	bitmap = bitmap_zalloc(count, GFP_KERNEL);
 	if (!bitmap)
@@ -1870,22 +1692,20 @@ static int igt_bottomup(void *ignored)
 	if (!order)
 		goto err_bitmap;
 
-	ret = -EINVAL;
 	for (size = 1; size <= 64; size <<= 1) {
 		drm_mm_init(&mm, 0, size*count);
 		for (n = 0; n < count; n++) {
-			if (!expect_insert(&mm, &nodes[n],
-					   size, 0, n,
-					   bottomup)) {
-				pr_err("bottomup insert failed, size %u step %d\n", size, n);
+			if (!expect_insert(test, &mm, &nodes[n], size, 0, n, bottomup)) {
+				KUNIT_FAIL(test,
+					   "bottomup insert failed, size %u step %d\n", size, n);
 				goto out;
 			}
 
-			if (!assert_one_hole(&mm, size*(n + 1), size*count))
+			if (!assert_one_hole(test, &mm, size*(n + 1), size*count))
 				goto out;
 		}
 
-		if (!assert_continuous(&mm, size))
+		if (!assert_continuous(test, &mm, size))
 			goto out;
 
 		drm_random_reorder(order, count, &prng);
@@ -1900,17 +1720,16 @@ static int igt_bottomup(void *ignored)
 				unsigned int first;
 
 				node = &nodes[order[(o + m) % count]];
-				if (!expect_insert(&mm, node,
-						   size, 0, 0,
-						   bottomup)) {
-					pr_err("insert failed, step %d/%d\n", m, n);
+				if (!expect_insert(test, &mm, node, size, 0, 0, bottomup)) {
+					KUNIT_FAIL(test, "insert failed, step %d/%d\n", m, n);
 					goto out;
 				}
 
 				first = find_first_bit(bitmap, count);
 				if (node_index(node) != first) {
-					pr_err("node %d/%d not inserted into bottom hole, expected %d, found %d\n",
-					       m, n, first, node_index(node));
+					KUNIT_FAIL(test,
+						   "node %d/%d not inserted into bottom hole, expected %d, found %d\n",
+						   m, n, first, node_index(node));
 					goto out;
 				}
 				__clear_bit(first, bitmap);
@@ -1927,7 +1746,6 @@ static int igt_bottomup(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
@@ -1937,47 +1755,39 @@ static int igt_bottomup(void *ignored)
 	bitmap_free(bitmap);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
-static int __igt_once(unsigned int mode)
+static void __igt_once(struct kunit *test, unsigned int mode)
 {
 	struct drm_mm mm;
 	struct drm_mm_node rsvd_lo, rsvd_hi, node;
-	int err;
 
 	drm_mm_init(&mm, 0, 7);
 
 	memset(&rsvd_lo, 0, sizeof(rsvd_lo));
 	rsvd_lo.start = 1;
 	rsvd_lo.size = 1;
-	err = drm_mm_reserve_node(&mm, &rsvd_lo);
-	if (err) {
-		pr_err("Could not reserve low node\n");
+	if (drm_mm_reserve_node(&mm, &rsvd_lo)) {
+		KUNIT_FAIL(test, "Could not reserve low node\n");
 		goto err;
 	}
 
 	memset(&rsvd_hi, 0, sizeof(rsvd_hi));
 	rsvd_hi.start = 5;
 	rsvd_hi.size = 1;
-	err = drm_mm_reserve_node(&mm, &rsvd_hi);
-	if (err) {
-		pr_err("Could not reserve low node\n");
+	if (drm_mm_reserve_node(&mm, &rsvd_hi)) {
+		KUNIT_FAIL(test, "Could not reserve low node\n");
 		goto err_lo;
 	}
 
 	if (!drm_mm_hole_follows(&rsvd_lo) || !drm_mm_hole_follows(&rsvd_hi)) {
-		pr_err("Expected a hole after lo and high nodes!\n");
-		err = -EINVAL;
+		KUNIT_FAIL(test, "Expected a hole after lo and high nodes!\n");
 		goto err_hi;
 	}
 
 	memset(&node, 0, sizeof(node));
-	err = drm_mm_insert_node_generic(&mm, &node, 2, 0, 0, mode);
-	if (err) {
-		pr_err("Could not insert the node into the available hole!\n");
-		err = -EINVAL;
+	if (drm_mm_insert_node_generic(&mm, &node, 2, 0, 0, mode)) {
+		KUNIT_FAIL(test, "Could not insert the node into the available hole!\n");
 		goto err_hi;
 	}
 
@@ -1988,23 +1798,20 @@ static int __igt_once(unsigned int mode)
 	drm_mm_remove_node(&rsvd_lo);
 err:
 	drm_mm_takedown(&mm);
-	return err;
 }
 
-static int igt_lowest(void *ignored)
+static void igt_mm_lowest(struct kunit *test)
 {
-	return __igt_once(DRM_MM_INSERT_LOW);
+	__igt_once(test, DRM_MM_INSERT_LOW);
 }
 
-static int igt_highest(void *ignored)
+static void igt_mm_highest(struct kunit *test)
 {
-	return __igt_once(DRM_MM_INSERT_HIGH);
+	__igt_once(test, DRM_MM_INSERT_HIGH);
 }
 
 static void separate_adjacent_colors(const struct drm_mm_node *node,
-				     unsigned long color,
-				     u64 *start,
-				     u64 *end)
+				     unsigned long color, u64 *start, u64 *end)
 {
 	if (drm_mm_node_allocated(node) && node->color != color)
 		++*start;
@@ -2014,11 +1821,11 @@ static void separate_adjacent_colors(const struct drm_mm_node *node,
 		--*end;
 }
 
-static bool colors_abutt(const struct drm_mm_node *node)
+static bool colors_abutt(struct kunit *test, const struct drm_mm_node *node)
 {
 	if (!drm_mm_hole_follows(node) &&
 	    drm_mm_node_allocated(list_next_entry(node, node_list))) {
-		pr_err("colors abutt; %ld [%llx + %llx] is next to %ld [%llx + %llx]!\n",
+		KUNIT_FAIL(test, "colors abutt; %ld [%llx + %llx] is next to %ld [%llx + %llx]!\n",
 		       node->color, node->start, node->size,
 		       list_next_entry(node, node_list)->color,
 		       list_next_entry(node, node_list)->start,
@@ -2029,14 +1836,13 @@ static bool colors_abutt(const struct drm_mm_node *node)
 	return false;
 }
 
-static int igt_color(void *ignored)
+static void igt_mm_color(struct kunit *test)
 {
 	const unsigned int count = min(4096u, max_iterations);
 	const struct insert_mode *mode;
 	struct drm_mm mm;
 	struct drm_mm_node *node, *nn;
 	unsigned int n;
-	int ret = -EINVAL, err;
 
 	/* Color adjustment complicates everything. First we just check
 	 * that when we insert a node we apply any color_adjustment callback.
@@ -2050,14 +1856,11 @@ static int igt_color(void *ignored)
 	for (n = 1; n <= count; n++) {
 		node = kzalloc(sizeof(*node), GFP_KERNEL);
 		if (!node) {
-			ret = -ENOMEM;
 			goto out;
 		}
 
-		if (!expect_insert(&mm, node,
-				   n, 0, n,
-				   &insert_modes[0])) {
-			pr_err("insert failed, step %d\n", n);
+		if (!expect_insert(test, &mm, node, n, 0, n, &insert_modes[0])) {
+			KUNIT_FAIL(test, "insert failed, step %d\n", n);
 			kfree(node);
 			goto out;
 		}
@@ -2065,7 +1868,7 @@ static int igt_color(void *ignored)
 
 	drm_mm_for_each_node_safe(node, nn, &mm) {
 		if (node->color != node->size) {
-			pr_err("invalid color stored: expected %lld, found %ld\n",
+			KUNIT_FAIL(test, "invalid color stored: expected %lld, found %ld\n",
 			       node->size, node->color);
 
 			goto out;
@@ -2082,17 +1885,14 @@ static int igt_color(void *ignored)
 
 		node = kzalloc(sizeof(*node), GFP_KERNEL);
 		if (!node) {
-			ret = -ENOMEM;
 			goto out;
 		}
 
 		node->size = 1 + 2*count;
 		node->color = node->size;
 
-		err = drm_mm_reserve_node(&mm, node);
-		if (err) {
-			pr_err("initial reserve failed!\n");
-			ret = err;
+		if (drm_mm_reserve_node(&mm, node)) {
+			KUNIT_FAIL(test, "initial reserve failed!\n");
 			goto out;
 		}
 
@@ -2103,7 +1903,6 @@ static int igt_color(void *ignored)
 
 			node = kzalloc(sizeof(*node), GFP_KERNEL);
 			if (!node) {
-				ret = -ENOMEM;
 				goto out;
 			}
 
@@ -2111,10 +1910,8 @@ static int igt_color(void *ignored)
 			node->size = n + count;
 			node->color = node->size;
 
-			err = drm_mm_reserve_node(&mm, node);
-			if (err != -ENOSPC) {
-				pr_err("reserve %d did not report color overlap! err=%d\n",
-				       n, err);
+			if (drm_mm_reserve_node(&mm, node) != -ENOSPC) {
+				KUNIT_FAIL(test, "reserve %d did not report color overlap!", n);
 				goto out;
 			}
 
@@ -2122,10 +1919,8 @@ static int igt_color(void *ignored)
 			rem = misalignment(node, n + count);
 			node->start += n + count - rem;
 
-			err = drm_mm_reserve_node(&mm, node);
-			if (err) {
-				pr_err("reserve %d failed, err=%d\n", n, err);
-				ret = err;
+			if (drm_mm_reserve_node(&mm, node)) {
+				KUNIT_FAIL(test, "reserve %d failed", n);
 				goto out;
 			}
 
@@ -2135,15 +1930,11 @@ static int igt_color(void *ignored)
 		for (n = 1; n <= count; n++) {
 			node = kzalloc(sizeof(*node), GFP_KERNEL);
 			if (!node) {
-				ret = -ENOMEM;
 				goto out;
 			}
 
-			if (!expect_insert(&mm, node,
-					   n, n, n,
-					   mode)) {
-				pr_err("%s insert failed, step %d\n",
-				       mode->name, n);
+			if (!expect_insert(test, &mm, node, n, n, n, mode)) {
+				KUNIT_FAIL(test, "%s insert failed, step %d\n", mode->name, n);
 				kfree(node);
 				goto out;
 			}
@@ -2153,19 +1944,21 @@ static int igt_color(void *ignored)
 			u64 rem;
 
 			if (node->color != node->size) {
-				pr_err("%s invalid color stored: expected %lld, found %ld\n",
-				       mode->name, node->size, node->color);
+				KUNIT_FAIL(test,
+					   "%s invalid color stored: expected %lld, found %ld\n",
+					   mode->name, node->size, node->color);
 
 				goto out;
 			}
 
-			if (colors_abutt(node))
+			if (colors_abutt(test, node))
 				goto out;
 
 			div64_u64_rem(node->start, node->size, &rem);
 			if (rem) {
-				pr_err("%s colored node misaligned, start=%llx expected alignment=%lld [rem=%lld]\n",
-				       mode->name, node->start, node->size, rem);
+				KUNIT_FAIL(test,
+					   "%s colored node misaligned, start=%llx expected alignment=%lld [rem=%lld]\n",
+					   mode->name, node->start, node->size, rem);
 				goto out;
 			}
 
@@ -2176,25 +1969,18 @@ static int igt_color(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
 	drm_mm_for_each_node_safe(node, nn, &mm) {
 		drm_mm_remove_node(node);
 		kfree(node);
 	}
 	drm_mm_takedown(&mm);
-	return ret;
 }
 
-static int evict_color(struct drm_mm *mm,
-		       u64 range_start, u64 range_end,
-		       struct evict_node *nodes,
-		       unsigned int *order,
-		       unsigned int count,
-		       unsigned int size,
-		       unsigned int alignment,
-		       unsigned long color,
-		       const struct insert_mode *mode)
+static int evict_color(struct kunit *test, struct drm_mm *mm, u64 range_start,
+		u64 range_end, struct evict_node *nodes, unsigned int *order,
+		unsigned int count, unsigned int size, unsigned int alignment,
+		unsigned long color, const struct insert_mode *mode)
 {
 	struct drm_mm_scan scan;
 	LIST_HEAD(evict_list);
@@ -2202,39 +1988,37 @@ static int evict_color(struct drm_mm *mm,
 	struct drm_mm_node tmp;
 	int err;
 
-	drm_mm_scan_init_with_range(&scan, mm,
-				    size, alignment, color,
-				    range_start, range_end,
-				    mode->mode);
-	if (!evict_nodes(&scan,
-			 nodes, order, count, true,
-			 &evict_list))
+	drm_mm_scan_init_with_range(&scan, mm, size, alignment, color, range_start,
+			range_end, mode->mode);
+	if (!evict_nodes(test, &scan, nodes, order, count, true, &evict_list))
 		return -EINVAL;
 
 	memset(&tmp, 0, sizeof(tmp));
 	err = drm_mm_insert_node_generic(mm, &tmp, size, alignment, color,
 					 DRM_MM_INSERT_EVICT);
 	if (err) {
-		pr_err("Failed to insert into eviction hole: size=%d, align=%d, color=%lu, err=%d\n",
-		       size, alignment, color, err);
-		show_scan(&scan);
-		show_holes(mm, 3);
+		KUNIT_FAIL(test,
+			   "Failed to insert into eviction hole: size=%d, align=%d, color=%lu, err=%d\n",
+			   size, alignment, color, err);
+		show_scan(test, &scan);
+		show_holes(test, mm, 3);
 		return err;
 	}
 
 	if (tmp.start < range_start || tmp.start + tmp.size > range_end) {
-		pr_err("Inserted [address=%llu + %llu] did not fit into the request range [%llu, %llu]\n",
-		       tmp.start, tmp.size, range_start, range_end);
+		KUNIT_FAIL(test,
+			   "Inserted [address=%llu + %llu] did not fit into the request range [%llu, %llu]\n",
+			   tmp.start, tmp.size, range_start, range_end);
 		err = -EINVAL;
 	}
 
-	if (colors_abutt(&tmp))
+	if (colors_abutt(test, &tmp))
 		err = -EINVAL;
 
-	if (!assert_node(&tmp, mm, size, alignment, color)) {
-		pr_err("Inserted did not fit the eviction hole: size=%lld [%d], align=%d [rem=%lld], start=%llx\n",
-		       tmp.size, size,
-		       alignment, misalignment(&tmp, alignment), tmp.start);
+	if (!assert_node(test, &tmp, mm, size, alignment, color)) {
+		KUNIT_FAIL(test,
+			   "Inserted did not fit the eviction hole: size=%lld [%d], align=%d [rem=%lld], start=%llx\n",
+			   tmp.size, size, alignment, misalignment(&tmp, alignment), tmp.start);
 		err = -EINVAL;
 	}
 
@@ -2245,7 +2029,7 @@ static int evict_color(struct drm_mm *mm,
 	list_for_each_entry(e, &evict_list, link) {
 		err = drm_mm_reserve_node(mm, &e->node);
 		if (err) {
-			pr_err("Failed to reinsert node after eviction: start=%llx\n",
+			KUNIT_FAIL(test, "Failed to reinsert node after eviction: start=%llx\n",
 			       e->node.start);
 			return err;
 		}
@@ -2255,7 +2039,7 @@ static int evict_color(struct drm_mm *mm,
 	return 0;
 }
 
-static int igt_color_evict(void *ignored)
+static void igt_mm_color_evict(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int total_size = min(8192u, max_iterations);
@@ -2265,7 +2049,6 @@ static int igt_color_evict(void *ignored)
 	struct evict_node *nodes;
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
-	int ret, err;
 
 	/* Check that the drm_mm_scan also honours color adjustment when
 	 * choosing its victims to create a hole. Our color_adjust does not
@@ -2273,23 +2056,20 @@ static int igt_color_evict(void *ignored)
 	 * enlarging the set of victims that must be evicted.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(total_size, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	order = drm_random_order(total_size, &prng);
 	if (!order)
 		goto err_nodes;
 
-	ret = -EINVAL;
 	drm_mm_init(&mm, 0, 2*total_size - 1);
 	mm.color_adjust = separate_adjacent_colors;
 	for (n = 0; n < total_size; n++) {
-		if (!expect_insert(&mm, &nodes[n].node,
+		if (!expect_insert(test, &mm, &nodes[n].node,
 				   1, 0, color++,
 				   &insert_modes[0])) {
-			pr_err("insert failed, step %d\n", n);
+			KUNIT_FAIL(test, "insert failed, step %d\n", n);
 			goto out;
 		}
 	}
@@ -2297,25 +2077,18 @@ static int igt_color_evict(void *ignored)
 	for (mode = evict_modes; mode->name; mode++) {
 		for (n = 1; n <= total_size; n <<= 1) {
 			drm_random_reorder(order, total_size, &prng);
-			err = evict_color(&mm, 0, U64_MAX,
-					  nodes, order, total_size,
-					  n, 1, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u) failed\n",
-				       mode->name, n);
+			if (evict_color(test, &mm, 0, U64_MAX, nodes, order, total_size,
+					  n, 1, color++, mode)) {
+				KUNIT_FAIL(test, "%s evict_color(size=%u) failed\n", mode->name, n);
 				goto out;
 			}
 		}
 
 		for (n = 1; n < total_size; n <<= 1) {
 			drm_random_reorder(order, total_size, &prng);
-			err = evict_color(&mm, 0, U64_MAX,
-					  nodes, order, total_size,
-					  total_size/2, n, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u, alignment=%u) failed\n",
+			if (evict_color(test, &mm, 0, U64_MAX, nodes, order, total_size,
+					  total_size/2, n, color++, mode)) {
+				KUNIT_FAIL(test, "%s evict_color(size=%u, alignment=%u) failed\n",
 				       mode->name, total_size/2, n);
 				goto out;
 			}
@@ -2327,12 +2100,9 @@ static int igt_color_evict(void *ignored)
 			DRM_MM_BUG_ON(!nsize);
 
 			drm_random_reorder(order, total_size, &prng);
-			err = evict_color(&mm, 0, U64_MAX,
-					  nodes, order, total_size,
-					  nsize, n, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u, alignment=%u) failed\n",
+			if (evict_color(test, &mm, 0, U64_MAX, nodes, order, total_size,
+					  nsize, n, color++, mode)) {
+				KUNIT_FAIL(test, "%s evict_color(size=%u, alignment=%u) failed\n",
 				       mode->name, nsize, n);
 				goto out;
 			}
@@ -2341,21 +2111,16 @@ static int igt_color_evict(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
-	if (ret)
-		show_mm(&mm);
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	kfree(order);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
-static int igt_color_evict_range(void *ignored)
+static void igt_mm_color_evict_range(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int total_size = 8192;
@@ -2368,29 +2133,25 @@ static int igt_color_evict_range(void *ignored)
 	struct evict_node *nodes;
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
-	int ret, err;
 
 	/* Like igt_color_evict(), but limited to small portion of the full
 	 * drm_mm range.
 	 */
 
-	ret = -ENOMEM;
 	nodes = vzalloc(array_size(total_size, sizeof(*nodes)));
-	if (!nodes)
-		goto err;
+	KUNIT_ASSERT_TRUE(test, nodes);
 
 	order = drm_random_order(total_size, &prng);
 	if (!order)
 		goto err_nodes;
 
-	ret = -EINVAL;
 	drm_mm_init(&mm, 0, 2*total_size - 1);
 	mm.color_adjust = separate_adjacent_colors;
 	for (n = 0; n < total_size; n++) {
-		if (!expect_insert(&mm, &nodes[n].node,
+		if (!expect_insert(test, &mm, &nodes[n].node,
 				   1, 0, color++,
 				   &insert_modes[0])) {
-			pr_err("insert failed, step %d\n", n);
+			KUNIT_FAIL(test, "insert failed, step %d\n", n);
 			goto out;
 		}
 	}
@@ -2398,26 +2159,21 @@ static int igt_color_evict_range(void *ignored)
 	for (mode = evict_modes; mode->name; mode++) {
 		for (n = 1; n <= range_size; n <<= 1) {
 			drm_random_reorder(order, range_size, &prng);
-			err = evict_color(&mm, range_start, range_end,
-					  nodes, order, total_size,
-					  n, 1, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u) failed for range [%x, %x]\n",
-				       mode->name, n, range_start, range_end);
+			if (evict_color(test, &mm, range_start, range_end, nodes, order,
+					total_size, n, 1, color++, mode)) {
+				KUNIT_FAIL(test, "%s evict_color(size=%u) failed for range [%x, %x]\n",
+					   mode->name, n, range_start, range_end);
 				goto out;
 			}
 		}
 
 		for (n = 1; n < range_size; n <<= 1) {
 			drm_random_reorder(order, total_size, &prng);
-			err = evict_color(&mm, range_start, range_end,
-					  nodes, order, total_size,
-					  range_size/2, n, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u, alignment=%u) failed for range [%x, %x]\n",
-				       mode->name, total_size/2, n, range_start, range_end);
+			if (evict_color(test, &mm, range_start, range_end, nodes, order,
+					total_size, range_size/2, n, color++, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_color(size=%u, alignment=%u) failed for range [%x, %x]\n",
+					   mode->name, total_size/2, n, range_start, range_end);
 				goto out;
 			}
 		}
@@ -2428,13 +2184,11 @@ static int igt_color_evict_range(void *ignored)
 			DRM_MM_BUG_ON(!nsize);
 
 			drm_random_reorder(order, total_size, &prng);
-			err = evict_color(&mm, range_start, range_end,
-					  nodes, order, total_size,
-					  nsize, n, color++,
-					  mode);
-			if (err) {
-				pr_err("%s evict_color(size=%u, alignment=%u) failed for range [%x, %x]\n",
-				       mode->name, nsize, n, range_start, range_end);
+			if (evict_color(test, &mm, range_start, range_end, nodes, order,
+					total_size, nsize, n, color++, mode)) {
+				KUNIT_FAIL(test,
+					   "%s evict_color(size=%u, alignment=%u) failed for range [%x, %x]\n",
+					   mode->name, nsize, n, range_start, range_end);
 				goto out;
 			}
 		}
@@ -2442,46 +2196,57 @@ static int igt_color_evict_range(void *ignored)
 		cond_resched();
 	}
 
-	ret = 0;
 out:
-	if (ret)
-		show_mm(&mm);
 	drm_mm_for_each_node_safe(node, next, &mm)
 		drm_mm_remove_node(node);
 	drm_mm_takedown(&mm);
 	kfree(order);
 err_nodes:
 	vfree(nodes);
-err:
-	return ret;
 }
 
-#include "drm_selftest.c"
-
-static int __init test_drm_mm_init(void)
+static int drm_mm_init_test(struct kunit *test)
 {
-	int err;
-
 	while (!random_seed)
 		random_seed = get_random_int();
 
-	pr_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
-		random_seed, max_iterations, max_prime);
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
-
-	return err > 0 ? 0 : err;
-}
-
-static void __exit test_drm_mm_exit(void)
-{
+	return 0;
 }
 
-module_init(test_drm_mm_init);
-module_exit(test_drm_mm_exit);
-
 module_param(random_seed, uint, 0400);
 module_param(max_iterations, uint, 0400);
 module_param(max_prime, uint, 0400);
 
+static struct kunit_case drm_mm_tests[] = {
+	KUNIT_CASE(igt_mm_init),
+	KUNIT_CASE(igt_mm_debug),
+	KUNIT_CASE(igt_mm_reserve),
+	KUNIT_CASE(igt_mm_insert),
+	KUNIT_CASE(igt_mm_replace),
+	KUNIT_CASE(igt_mm_insert_range),
+	KUNIT_CASE(igt_mm_frag),
+	KUNIT_CASE(igt_mm_align),
+	KUNIT_CASE(igt_mm_align32),
+	KUNIT_CASE(igt_mm_align64),
+	KUNIT_CASE(igt_mm_evict),
+	KUNIT_CASE(igt_mm_evict_range),
+	KUNIT_CASE(igt_mm_topdown),
+	KUNIT_CASE(igt_mm_bottomup),
+	KUNIT_CASE(igt_mm_lowest),
+	KUNIT_CASE(igt_mm_highest),
+	KUNIT_CASE(igt_mm_color),
+	KUNIT_CASE(igt_mm_color_evict),
+	KUNIT_CASE(igt_mm_color_evict_range),
+	{}
+};
+
+static struct kunit_suite drm_mm_test_suite = {
+	.name = "drm_mm",
+	.init = drm_mm_init_test,
+	.test_cases = drm_mm_tests,
+};
+
+kunit_test_suite(drm_mm_test_suite);
+
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
-- 
2.36.1

