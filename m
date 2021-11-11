Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66D44CE62
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Nov 2021 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhKKAiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 19:38:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKKAiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 19:38:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id AC80E1F457AF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636590934; bh=CVfsKtZShmrJxw/1imPozmYEdgbV8DDkEYUqR/BOkqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SW79s66PhsiV6UNlc/hPNAmrQUBVIXbOWPrgpdiOyFoGWVRqunuNdAWX/JZsECuoO
         j11tPg1rfdgA0hNKLwqzRr4Dqvgiaa3KS2TtrslRvMUsIIVr5NNHeYxv4dpFpwI1JH
         Dvu0EWMNHuzCnyJrRn3U92T0lvGWLVo1aKU6kfylS5jgMzSFjZ8WhONu/TV7T00oh3
         8u+cxaG7gYssq33K5+6g8scWQb/CUqcVYyv8HrzrSS6yuR+mCJuFxmGG5+qHm76t8E
         j+huDZ/aJbvXOdY9NqIq7Wn0jMiCrJcHgm1apyiWuU2yaf0EVeaS2dcpip4AMgMsGG
         NvpV3wuxEC/MA==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org, igt-dev@lists.freedesktop.org,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        ~lkcamp/discussion@lists.sr.ht, isabbasso@riseup.net,
        maira.canal@usp.br, arthur.grillo@usp.br,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 1/1] drm: selftest: convert drm_damage_helper selftest to KUnit
Date:   Wed, 10 Nov 2021 21:34:53 -0300
Message-Id: <20211111003453.209115-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211111003453.209115-1-andrealmeid@collabora.com>
References: <20211111003453.209115-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Maíra Canal <maira.canal@usp.br>

Considering the current adoption of the KUnit framework, convert the
DRM damage helper selftest to the KUnit API.

Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/gpu/drm/Kconfig                       |  13 ++
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/selftests/Makefile            |   5 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  21 --
 .../drm/selftests/test-drm_damage_helper.c    | 215 +++++++++---------
 5 files changed, 127 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index cea777ae7fb9..56f6ca74ebb6 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -79,6 +79,19 @@ config DRM_DEBUG_SELFTEST
 
 	  If in doubt, say "N".
 
+config DRM_DAMAGE_HELPER_KUNIT_TEST
+	tristate "KUnit tests for DRM damage helper"
+	depends on DRM && KUNIT
+	select DRM_KMS_HELPER
+	default KUNIT_ALL_TESTS
+	help
+	  This option provides a KUnit module that can be used to run
+	  an unit test on the DRM damage helper API. This option is not
+	  useful for distributions or general kernels, but only for kernel
+	  developers working on DRM and associated drivers.
+
+	  If in doubt, say "N".
+
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index ad1112154898..e632c43c9b7d 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -58,7 +58,7 @@ drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
 drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
 
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
+obj-y += selftests/
 
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 0856e4b12f70..311f6af2caf1 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
-		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
-		      test-drm_rect.o
+		      test-drm_dp_mst_helper.o test-drm_rect.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o
+
+obj-$(CONFIG_DRM_DAMAGE_HELPER_KUNIT_TEST) += test-drm_damage_helper.o
diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
index 782e285ca383..4787b3b70709 100644
--- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
+++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
@@ -15,26 +15,5 @@ selftest(check_drm_format_block_width, igt_check_drm_format_block_width)
 selftest(check_drm_format_block_height, igt_check_drm_format_block_height)
 selftest(check_drm_format_min_pitch, igt_check_drm_format_min_pitch)
 selftest(check_drm_framebuffer_create, igt_check_drm_framebuffer_create)
-selftest(damage_iter_no_damage, igt_damage_iter_no_damage)
-selftest(damage_iter_no_damage_fractional_src, igt_damage_iter_no_damage_fractional_src)
-selftest(damage_iter_no_damage_src_moved, igt_damage_iter_no_damage_src_moved)
-selftest(damage_iter_no_damage_fractional_src_moved, igt_damage_iter_no_damage_fractional_src_moved)
-selftest(damage_iter_no_damage_not_visible, igt_damage_iter_no_damage_not_visible)
-selftest(damage_iter_no_damage_no_crtc, igt_damage_iter_no_damage_no_crtc)
-selftest(damage_iter_no_damage_no_fb, igt_damage_iter_no_damage_no_fb)
-selftest(damage_iter_simple_damage, igt_damage_iter_simple_damage)
-selftest(damage_iter_single_damage, igt_damage_iter_single_damage)
-selftest(damage_iter_single_damage_intersect_src, igt_damage_iter_single_damage_intersect_src)
-selftest(damage_iter_single_damage_outside_src, igt_damage_iter_single_damage_outside_src)
-selftest(damage_iter_single_damage_fractional_src, igt_damage_iter_single_damage_fractional_src)
-selftest(damage_iter_single_damage_intersect_fractional_src, igt_damage_iter_single_damage_intersect_fractional_src)
-selftest(damage_iter_single_damage_outside_fractional_src, igt_damage_iter_single_damage_outside_fractional_src)
-selftest(damage_iter_single_damage_src_moved, igt_damage_iter_single_damage_src_moved)
-selftest(damage_iter_single_damage_fractional_src_moved, igt_damage_iter_single_damage_fractional_src_moved)
-selftest(damage_iter_damage, igt_damage_iter_damage)
-selftest(damage_iter_damage_one_intersect, igt_damage_iter_damage_one_intersect)
-selftest(damage_iter_damage_one_outside, igt_damage_iter_damage_one_outside)
-selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
-selftest(damage_iter_damage_not_visible, igt_damage_iter_damage_not_visible)
 selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
 selftest(dp_mst_sideband_msg_req_decode, igt_dp_mst_sideband_msg_req_decode)
diff --git a/drivers/gpu/drm/selftests/test-drm_damage_helper.c b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
index 1c19a5d3eefb..83905661d41e 100644
--- a/drivers/gpu/drm/selftests/test-drm_damage_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_damage_helper.c
@@ -3,14 +3,11 @@
  * Test case for drm_damage_helper functions
  */
 
-#define pr_fmt(fmt) "drm_damage_helper: " fmt
-
+#include <kunit/test.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_drv.h>
 
-#include "test-drm_modeset_common.h"
-
 struct drm_driver mock_driver;
 static struct drm_device mock_device;
 static struct drm_object_properties mock_obj_props;
@@ -114,7 +111,7 @@ const struct drm_framebuffer fb = {
 	mock_setup(&old_state); \
 	mock_setup(&state);
 
-int igt_damage_iter_no_damage(void *ignored)
+static void igt_damage_iter_no_damage(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -129,13 +126,12 @@ int igt_damage_iter_no_damage(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 2048, 2048));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 0, 0, 2048, 2048));
 }
 
-int igt_damage_iter_no_damage_fractional_src(void *ignored)
+static void igt_damage_iter_no_damage_fractional_src(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -152,13 +148,12 @@ int igt_damage_iter_no_damage_fractional_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 3, 3, 1028, 772));
 }
 
-int igt_damage_iter_no_damage_src_moved(void *ignored)
+static void igt_damage_iter_no_damage_src_moved(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -174,13 +169,12 @@ int igt_damage_iter_no_damage_src_moved(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 10, 10, 1034, 778));
 }
 
-int igt_damage_iter_no_damage_fractional_src_moved(void *ignored)
+static void igt_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -197,13 +191,11 @@ int igt_damage_iter_no_damage_fractional_src_moved(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 4, 4, 1029, 773));
 }
 
-int igt_damage_iter_no_damage_not_visible(void *ignored)
+static void igt_damage_iter_no_damage_not_visible(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -221,12 +213,10 @@ int igt_damage_iter_no_damage_not_visible(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_no_damage_no_crtc(void *ignored)
+static void igt_damage_iter_no_damage_no_crtc(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -242,12 +232,10 @@ int igt_damage_iter_no_damage_no_crtc(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_no_damage_no_fb(void *ignored)
+static void igt_damage_iter_no_damage_no_fb(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_plane_state old_state;
@@ -267,12 +255,10 @@ int igt_damage_iter_no_damage_no_fb(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_simple_damage(void *ignored)
+static void igt_damage_iter_simple_damage(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -292,13 +278,11 @@ int igt_damage_iter_simple_damage(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 1024, 768));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 0, 0, 1024, 768));
 }
 
-int igt_damage_iter_single_damage(void *ignored)
+static void igt_damage_iter_single_damage(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -317,13 +301,12 @@ int igt_damage_iter_single_damage(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 768, 576));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 256, 192, 768, 576));
 }
 
-int igt_damage_iter_single_damage_intersect_src(void *ignored)
+static void igt_damage_iter_single_damage_intersect_src(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -343,13 +326,12 @@ int igt_damage_iter_single_damage_intersect_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage clipped to src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 1024, 768));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 256, 192, 1024, 768));
 }
 
-int igt_damage_iter_single_damage_outside_src(void *ignored)
+static void igt_damage_iter_single_damage_outside_src(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -369,12 +351,10 @@ int igt_damage_iter_single_damage_outside_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_single_damage_fractional_src(void *ignored)
+static void igt_damage_iter_single_damage_fractional_src(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -396,13 +376,13 @@ int igt_damage_iter_single_damage_fractional_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 256, 330));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 10, 10, 256, 330));
 }
 
-int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored)
+static void igt_damage_iter_single_damage_intersect_fractional_src(
+		struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -425,13 +405,13 @@ int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage clipped to rounded off src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 4, 1029, 330));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 10, 4, 1029, 330));
 }
 
-int igt_damage_iter_single_damage_outside_fractional_src(void *ignored)
+static void igt_damage_iter_single_damage_outside_fractional_src(
+		struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -454,12 +434,10 @@ int igt_damage_iter_single_damage_outside_fractional_src(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
 
-int igt_damage_iter_single_damage_src_moved(void *ignored)
+static void igt_damage_iter_single_damage_src_moved(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -480,13 +458,13 @@ int igt_damage_iter_single_damage_src_moved(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 10, 10, 1034, 778));
 }
 
-int igt_damage_iter_single_damage_fractional_src_moved(void *ignored)
+static void igt_damage_iter_single_damage_fractional_src_moved(
+		struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -509,13 +487,11 @@ int igt_damage_iter_single_damage_fractional_src_moved(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 4, 4, 1029, 773));
 }
 
-int igt_damage_iter_damage(void *ignored)
+static void igt_damage_iter_damage(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -535,18 +511,18 @@ int igt_damage_iter_damage(void *ignored)
 	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
+			KUNIT_EXPECT_TRUE(test,
+					check_damage_clip(&state, &clip, 20, 30, 200, 180));
 		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
+			KUNIT_EXPECT_TRUE(test,
+					check_damage_clip(&state, &clip, 240, 200, 280, 250));
 		num_hits++;
 	}
 
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 2);
 }
 
-int igt_damage_iter_damage_one_intersect(void *ignored)
+static void igt_damage_iter_damage_one_intersect(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -568,18 +544,18 @@ int igt_damage_iter_damage_one_intersect(void *ignored)
 	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
+			KUNIT_EXPECT_TRUE(test,
+					check_damage_clip(&state, &clip, 20, 30, 200, 180));
 		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
+			KUNIT_EXPECT_TRUE(test,
+					check_damage_clip(&state, &clip, 4, 4, 1029, 773));
 		num_hits++;
 	}
 
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 2);
 }
 
-int igt_damage_iter_damage_one_outside(void *ignored)
+static void igt_damage_iter_damage_one_outside(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -600,13 +576,12 @@ int igt_damage_iter_damage_one_outside(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test,
+			check_damage_clip(&state, &clip, 240, 200, 280, 250));
 }
 
-int igt_damage_iter_damage_src_moved(void *ignored)
+static void igt_damage_iter_damage_src_moved(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -629,13 +604,11 @@ int igt_damage_iter_damage_src_moved(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 1, "Should return round off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 1);
+	KUNIT_EXPECT_TRUE(test, check_damage_clip(&state, &clip, 3, 3, 1028, 772));
 }
 
-int igt_damage_iter_damage_not_visible(void *ignored)
+static void igt_damage_iter_damage_not_visible(struct kunit *test)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_property_blob damage_blob;
@@ -660,7 +633,39 @@ int igt_damage_iter_damage_not_visible(void *ignored)
 	drm_atomic_for_each_plane_damage(&iter, &clip)
 		num_hits++;
 
-	FAIL(num_hits != 0, "Should not return any damage.");
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, num_hits, 0);
 }
+
+static struct kunit_case drm_damage_helper_tests[] = {
+	KUNIT_CASE(igt_damage_iter_no_damage),
+	KUNIT_CASE(igt_damage_iter_no_damage_fractional_src),
+	KUNIT_CASE(igt_damage_iter_no_damage_src_moved),
+	KUNIT_CASE(igt_damage_iter_no_damage_fractional_src_moved),
+	KUNIT_CASE(igt_damage_iter_no_damage_not_visible),
+	KUNIT_CASE(igt_damage_iter_no_damage_no_crtc),
+	KUNIT_CASE(igt_damage_iter_no_damage_no_fb),
+	KUNIT_CASE(igt_damage_iter_simple_damage),
+	KUNIT_CASE(igt_damage_iter_single_damage),
+	KUNIT_CASE(igt_damage_iter_single_damage_intersect_src),
+	KUNIT_CASE(igt_damage_iter_single_damage_outside_src),
+	KUNIT_CASE(igt_damage_iter_single_damage_fractional_src),
+	KUNIT_CASE(igt_damage_iter_single_damage_intersect_fractional_src),
+	KUNIT_CASE(igt_damage_iter_single_damage_outside_fractional_src),
+	KUNIT_CASE(igt_damage_iter_single_damage_src_moved),
+	KUNIT_CASE(igt_damage_iter_single_damage_fractional_src_moved),
+	KUNIT_CASE(igt_damage_iter_damage),
+	KUNIT_CASE(igt_damage_iter_damage_one_intersect),
+	KUNIT_CASE(igt_damage_iter_damage_one_outside),
+	KUNIT_CASE(igt_damage_iter_damage_src_moved),
+	KUNIT_CASE(igt_damage_iter_damage_not_visible),
+	{ }
+};
+
+static struct kunit_suite drm_damage_helper_test_suite = {
+	.name = "drm_damage_helper_tests",
+	.test_cases = drm_damage_helper_tests,
+};
+
+kunit_test_suite(drm_damage_helper_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.33.1

