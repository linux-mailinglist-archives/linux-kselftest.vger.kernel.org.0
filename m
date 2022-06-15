Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D854CA9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353786AbiFON7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354514AbiFON7a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 09:59:30 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982473B55C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-fe32122311so16583805fac.7
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ke74yS+EUhUdYFIDDGGyv82yFVctd155+Aond1yGQCw=;
        b=N5LFMZFpO7uX11G1sXwNvE0J6DBksGSBP06VFoHZ599PmY+tOmRg671fbCjEqiZ7bk
         A1x0BfnVmhlOFm7YrkxQVpeZYs/Y29uetkd5OfTNJ6TT+8uwLpddUbHKhA/J3RDQv7QY
         NqmXsSLbmlddEYrreS2yghOibvN/YouuypKRRbVw0kGixOskGTTQdENMRA2HMb/zWDNa
         Nz3YKbkJJKmgCWElJD6t4LqmAFiV1qnc/vKKPPLgP43DLS/CRKlVvS4tIBPP5GKN0uF6
         Ia1EwAfwzflJSOhSPCGLo5Y07oA3zjuZHc45R74p+AgFdUiMaA3PKqA66tjydogi2TbZ
         M/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ke74yS+EUhUdYFIDDGGyv82yFVctd155+Aond1yGQCw=;
        b=t0e6y1RqcWUck8EpOY8dPWs5/7h5lBu+OrokJ4m/nU1irghn7YrQVQtKRHM8NWPcnq
         zzJA+yqR1MvJh6R0mH6klW3gE0JSLO6JrZ9ax/IkZSVOvlkcqifL7nd/VU4sJEkIIcap
         M/imCIA5yTmpvfaukAqW9WGhNVXbd2Ie1yaedSEPHokEvOSvob4YdLQ7Cw8Vhe60dMeZ
         A7WxN9XAMmJjgNdgQ41+wSKHwqoT7c2Yd69dWUU9iz2zKwg90ptuPmRoro3ZcRByZbel
         ewYZI3SbjNKUwB/k672HvZinM0gva01n47j/0lBPA/EFdeddmF72BDBXQRx5oZu/bg1W
         aPrA==
X-Gm-Message-State: AJIora81pp/lWBfqDQAvxUVc+eJE+1XzF5um8zMsDBROTok8a0HrRnLu
        zHRpT0uSlyov0oH6kNMx32O0/g==
X-Google-Smtp-Source: AGRyM1vTvZIP+h5CElfxgKVqwX8HAr9rVG8qq3gM9JeAfWjg6UEdfDLC6PczqteNYki17p8D4mDXhg==
X-Received: by 2002:a05:6870:c1c1:b0:ee:5c83:7be7 with SMTP id i1-20020a056870c1c100b000ee5c837be7mr5332734oad.53.1655301555138;
        Wed, 15 Jun 2022 06:59:15 -0700 (PDT)
Received: from fedora.. ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id u7-20020a056830248700b0060bfebb96e5sm6056928ots.35.2022.06.15.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:59:14 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
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
Cc:     dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Arthur Grillo <arthur.grillo@usp.br>
Subject: [PATCH 01/10] drm: selftest: convert drm_damage_helper selftest to KUnit
Date:   Wed, 15 Jun 2022 10:58:15 -0300
Message-Id: <20220615135824.15522-2-maira.canal@usp.br>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615135824.15522-1-maira.canal@usp.br>
References: <20220615135824.15522-1-maira.canal@usp.br>
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
DRM damage helper selftest to the KUnit API.

Co-developed-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/selftests/Makefile            |   3 +-
 .../gpu/drm/selftests/drm_modeset_selftests.h |  21 -
 .../drm/selftests/test-drm_damage_helper.c    | 667 ------------------
 .../drm/selftests/test-drm_modeset_common.h   |  21 -
 drivers/gpu/drm/tests/Kconfig                 |  28 +
 drivers/gpu/drm/tests/Makefile                |   2 +
 .../gpu/drm/tests/test-drm_damage_helper.c    | 633 +++++++++++++++++
 9 files changed, 667 insertions(+), 711 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
 create mode 100644 drivers/gpu/drm/tests/Kconfig
 create mode 100644 drivers/gpu/drm/tests/Makefile
 create mode 100644 drivers/gpu/drm/tests/test-drm_damage_helper.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e88c497fa010..bd1b5d82c9cf 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -70,6 +70,8 @@ config DRM_DEBUG_SELFTEST
 
 	  If in doubt, say "N".
 
+source "drivers/gpu/drm/tests/Kconfig"
+
 config DRM_KMS_HELPER
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 15fe3163f822..0f24aa542be0 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 #
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
+obj-y += tests/
 
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index 5ba5f9138c95..7a1a732e0a1b 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
                       test-drm_format.o test-drm_framebuffer.o \
-		      test-drm_damage_helper.o test-drm_dp_mst_helper.o \
-		      test-drm_rect.o
+		      test-drm_dp_mst_helper.o test-drm_rect.o
 
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o \
 				    test-drm_buddy.o
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
deleted file mode 100644
index 8d8d8e214c28..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_damage_helper.c
+++ /dev/null
@@ -1,667 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Test case for drm_damage_helper functions
- */
-
-#define pr_fmt(fmt) "drm_damage_helper: " fmt
-
-#include <drm/drm_damage_helper.h>
-#include <drm/drm_plane.h>
-#include <drm/drm_drv.h>
-
-#include "test-drm_modeset_common.h"
-
-struct drm_driver mock_driver;
-static struct drm_device mock_device;
-static struct drm_object_properties mock_obj_props;
-static struct drm_plane mock_plane;
-static struct drm_property mock_prop;
-
-static void mock_setup(struct drm_plane_state *state)
-{
-	static bool setup_done = false;
-
-	state->plane = &mock_plane;
-
-	if (setup_done)
-		return;
-
-	/* just enough so that drm_plane_enable_fb_damage_clips() works */
-	mock_device.driver = &mock_driver;
-	mock_device.mode_config.prop_fb_damage_clips = &mock_prop;
-	mock_plane.dev = &mock_device;
-	mock_obj_props.count = 0;
-	mock_plane.base.properties = &mock_obj_props;
-	mock_prop.base.id = 1; /* 0 is an invalid id */
-	mock_prop.dev = &mock_device;
-
-	drm_plane_enable_fb_damage_clips(&mock_plane);
-}
-
-static void set_plane_src(struct drm_plane_state *state, int x1, int y1, int x2,
-			  int y2)
-{
-	state->src.x1 = x1;
-	state->src.y1 = y1;
-	state->src.x2 = x2;
-	state->src.y2 = y2;
-}
-
-static void set_damage_clip(struct drm_mode_rect *r, int x1, int y1, int x2,
-			    int y2)
-{
-	r->x1 = x1;
-	r->y1 = y1;
-	r->x2 = x2;
-	r->y2 = y2;
-}
-
-static void set_damage_blob(struct drm_property_blob *damage_blob,
-			    struct drm_mode_rect *r, uint32_t size)
-{
-	damage_blob->length = size;
-	damage_blob->data = r;
-}
-
-static void set_plane_damage(struct drm_plane_state *state,
-			     struct drm_property_blob *damage_blob)
-{
-	state->fb_damage_clips = damage_blob;
-}
-
-static bool check_damage_clip(struct drm_plane_state *state, struct drm_rect *r,
-			      int x1, int y1, int x2, int y2)
-{
-	/*
-	 * Round down x1/y1 and round up x2/y2. This is because damage is not in
-	 * 16.16 fixed point so to catch all pixels.
-	 */
-	int src_x1 = state->src.x1 >> 16;
-	int src_y1 = state->src.y1 >> 16;
-	int src_x2 = (state->src.x2 >> 16) + !!(state->src.x2 & 0xFFFF);
-	int src_y2 = (state->src.y2 >> 16) + !!(state->src.y2 & 0xFFFF);
-
-	if (x1 >= x2 || y1 >= y2) {
-		pr_err("Cannot have damage clip with no dimension.\n");
-		return false;
-	}
-
-	if (x1 < src_x1 || y1 < src_y1 || x2 > src_x2 || y2 > src_y2) {
-		pr_err("Damage cannot be outside rounded plane src.\n");
-		return false;
-	}
-
-	if (r->x1 != x1 || r->y1 != y1 || r->x2 != x2 || r->y2 != y2) {
-		pr_err("Damage = %d %d %d %d\n", r->x1, r->y1, r->x2, r->y2);
-		return false;
-	}
-
-	return true;
-}
-
-const struct drm_framebuffer fb = {
-	.width = 2048,
-	.height = 2048
-};
-
-/* common mocked structs many tests need */
-#define MOCK_VARIABLES() \
-	struct drm_plane_state old_state; \
-	struct drm_plane_state state = { \
-		.crtc = ZERO_SIZE_PTR, \
-		.fb = (struct drm_framebuffer *) &fb, \
-		.visible = true, \
-	}; \
-	mock_setup(&old_state); \
-	mock_setup(&state);
-
-int igt_damage_iter_no_damage(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src same as fb size. */
-	set_plane_src(&old_state, 0, 0, fb.width << 16, fb.height << 16);
-	set_plane_src(&state, 0, 0, fb.width << 16, fb.height << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 2048, 2048));
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_fractional_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_src_moved(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src moved since old plane state. */
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 10 << 16, 10 << 16,
-		      (10 + 1024) << 16, (10 + 768) << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_fractional_src_moved(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src has fractional part and it moved since old plane state. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_not_visible(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	state.visible = false;
-
-	mock_setup(&old_state);
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_no_crtc(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	state.crtc = NULL;
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
-}
-
-int igt_damage_iter_no_damage_no_fb(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_plane_state old_state;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	struct drm_plane_state state = {
-		.crtc = ZERO_SIZE_PTR,
-		.fb = 0,
-	};
-
-	mock_setup(&old_state);
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
-}
-
-int igt_damage_iter_simple_damage(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	/* Damage set to plane src */
-	set_damage_clip(&damage, 0, 0, 1024, 768);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 0, 0, 1024, 768));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	set_damage_clip(&damage, 256, 192, 768, 576);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 768, 576));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_intersect_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	/* Damage intersect with plane src. */
-	set_damage_clip(&damage, 256, 192, 1360, 768);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage clipped to src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 256, 192, 1024, 768));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_outside_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	/* Damage clip outside plane src */
-	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_fractional_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_damage_clip(&damage, 10, 10, 256, 330);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 256, 330));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	/* Damage intersect with plane src. */
-	set_damage_clip(&damage, 10, 1, 1360, 330);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage clipped to rounded off src.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 4, 1029, 330));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_outside_fractional_src(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src has fractional part. */
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	/* Damage clip outside plane src */
-	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should have no damage.");
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_src_moved(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src moved since old plane state. */
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 10 << 16, 10 << 16,
-		      (10 + 1024) << 16, (10 + 768) << 16);
-	set_damage_clip(&damage, 20, 30, 256, 256);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 10, 10, 1034, 778));
-
-	return 0;
-}
-
-int igt_damage_iter_single_damage_fractional_src_moved(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage;
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	/* Plane src with fractional part moved since old plane state. */
-	set_plane_src(&old_state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	/* Damage intersect with plane src. */
-	set_damage_clip(&damage, 20, 30, 1360, 256);
-	set_damage_blob(&damage_blob, &damage, sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return rounded off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-
-	return 0;
-}
-
-int igt_damage_iter_damage(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	/* 2 damage clips. */
-	set_damage_clip(&damage[0], 20, 30, 200, 180);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip) {
-		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
-		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
-		num_hits++;
-	}
-
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
-}
-
-int igt_damage_iter_damage_one_intersect(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	/* 2 damage clips, one intersect plane src. */
-	set_damage_clip(&damage[0], 20, 30, 200, 180);
-	set_damage_clip(&damage[1], 2, 2, 1360, 1360);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip) {
-		if (num_hits == 0)
-			FAIL_ON(!check_damage_clip(&state, &clip, 20, 30, 200, 180));
-		if (num_hits == 1)
-			FAIL_ON(!check_damage_clip(&state, &clip, 4, 4, 1029, 773));
-		num_hits++;
-	}
-
-	FAIL(num_hits != 2, "Should return damage when set.");
-
-	return 0;
-}
-
-int igt_damage_iter_damage_one_outside(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0, 0, 1024 << 16, 768 << 16);
-	set_plane_src(&state, 0, 0, 1024 << 16, 768 << 16);
-	/* 2 damage clips, one outside plane src. */
-	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return damage when set.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 240, 200, 280, 250));
-
-	return 0;
-}
-
-int igt_damage_iter_damage_src_moved(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	/* 2 damage clips, one outside plane src. */
-	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 1, "Should return round off plane src as damage.");
-	FAIL_ON(!check_damage_clip(&state, &clip, 3, 3, 1028, 772));
-
-	return 0;
-}
-
-int igt_damage_iter_damage_not_visible(void *ignored)
-{
-	struct drm_atomic_helper_damage_iter iter;
-	struct drm_property_blob damage_blob;
-	struct drm_mode_rect damage[2];
-	struct drm_rect clip;
-	uint32_t num_hits = 0;
-
-	MOCK_VARIABLES();
-
-	state.visible = false;
-
-	set_plane_src(&old_state, 0x40002, 0x40002,
-		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
-	set_plane_src(&state, 0x3fffe, 0x3fffe,
-		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
-	/* 2 damage clips, one outside plane src. */
-	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
-	set_damage_clip(&damage[1], 240, 200, 280, 250);
-	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
-	set_plane_damage(&state, &damage_blob);
-	drm_atomic_helper_damage_iter_init(&iter, &old_state, &state);
-	drm_atomic_for_each_plane_damage(&iter, &clip)
-		num_hits++;
-
-	FAIL(num_hits != 0, "Should not return any damage.");
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index cfb51d8da2bc..c29354e59cec 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -25,27 +25,6 @@ int igt_check_drm_format_block_width(void *ignored);
 int igt_check_drm_format_block_height(void *ignored);
 int igt_check_drm_format_min_pitch(void *ignored);
 int igt_check_drm_framebuffer_create(void *ignored);
-int igt_damage_iter_no_damage(void *ignored);
-int igt_damage_iter_no_damage_fractional_src(void *ignored);
-int igt_damage_iter_no_damage_src_moved(void *ignored);
-int igt_damage_iter_no_damage_fractional_src_moved(void *ignored);
-int igt_damage_iter_no_damage_not_visible(void *ignored);
-int igt_damage_iter_no_damage_no_crtc(void *ignored);
-int igt_damage_iter_no_damage_no_fb(void *ignored);
-int igt_damage_iter_simple_damage(void *ignored);
-int igt_damage_iter_single_damage(void *ignored);
-int igt_damage_iter_single_damage_intersect_src(void *ignored);
-int igt_damage_iter_single_damage_outside_src(void *ignored);
-int igt_damage_iter_single_damage_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_intersect_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_outside_fractional_src(void *ignored);
-int igt_damage_iter_single_damage_src_moved(void *ignored);
-int igt_damage_iter_single_damage_fractional_src_moved(void *ignored);
-int igt_damage_iter_damage(void *ignored);
-int igt_damage_iter_damage_one_intersect(void *ignored);
-int igt_damage_iter_damage_one_outside(void *ignored);
-int igt_damage_iter_damage_src_moved(void *ignored);
-int igt_damage_iter_damage_not_visible(void *ignored);
 int igt_dp_mst_calc_pbn_mode(void *ignored);
 int igt_dp_mst_sideband_msg_req_decode(void *ignored);
 
diff --git a/drivers/gpu/drm/tests/Kconfig b/drivers/gpu/drm/tests/Kconfig
new file mode 100644
index 000000000000..686e134b88bf
--- /dev/null
+++ b/drivers/gpu/drm/tests/Kconfig
@@ -0,0 +1,28 @@
+menu "KUnit tests for DRM"
+	depends on DRM && KUNIT
+
+config DRM_KUNIT_TEST
+	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
+	select DRM_KMS_HELPER
+	default KUNIT_ALL_TESTS
+	help
+	  This option provides a KUnit module that can be used to run
+	  all unit tests on the DRM API. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on DRM and associated drivers.
+
+	  If in doubt, say "N".
+
+config DRM_DAMAGE_HELPER_KUNIT_TEST
+	tristate "KUnit tests for DRM damage helper" if !DRM_KUNIT_TEST
+	select DRM_KMS_HELPER
+	default y if DRM_KUNIT_TEST
+	help
+	  This option provides a KUnit module that can be used to run
+	  an unit test on the DRM damage helper API. This option is not
+	  useful for distributions or general kernels, but only for kernel
+	  developers working on DRM and associated drivers.
+
+	  If in doubt, say "N".
+
+endmenu
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
new file mode 100644
index 000000000000..3fef656dffb9
--- /dev/null
+++ b/drivers/gpu/drm/tests/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_DRM_DAMAGE_HELPER_KUNIT_TEST) += test-drm_damage_helper.o
diff --git a/drivers/gpu/drm/tests/test-drm_damage_helper.c b/drivers/gpu/drm/tests/test-drm_damage_helper.c
new file mode 100644
index 000000000000..5e170eb8753a
--- /dev/null
+++ b/drivers/gpu/drm/tests/test-drm_damage_helper.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test case for drm_damage_helper functions
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_damage_helper.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_drv.h>
+
+struct drm_damage_mock {
+	struct drm_driver driver;
+	struct drm_device device;
+	struct drm_object_properties obj_props;
+	struct drm_plane plane;
+	struct drm_property prop;
+	struct drm_framebuffer fb;
+	struct drm_plane_state state;
+	struct drm_plane_state old_state;
+};
+
+static int drm_damage_helper_init(struct kunit *test)
+{
+	struct drm_damage_mock *mock;
+
+	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
+
+	mock->fb.width = 2048;
+	mock->fb.height = 2048;
+
+	mock->state.crtc = ZERO_SIZE_PTR;
+	mock->state.fb = &mock->fb;
+	mock->state.visible = true;
+
+	mock->old_state.plane = &mock->plane;
+	mock->state.plane = &mock->plane;
+
+	/* just enough so that drm_plane_enable_fb_damage_clips() works */
+	mock->device.driver = &mock->driver;
+	mock->device.mode_config.prop_fb_damage_clips = &mock->prop;
+	mock->plane.dev = &mock->device;
+	mock->obj_props.count = 0;
+	mock->plane.base.properties = &mock->obj_props;
+	mock->prop.base.id = 1; /* 0 is an invalid id */
+	mock->prop.dev = &mock->device;
+
+	drm_plane_enable_fb_damage_clips(&mock->plane);
+
+	test->priv = mock;
+
+	return 0;
+}
+
+static void set_plane_src(struct drm_plane_state *state, int x1, int y1, int x2,
+			  int y2)
+{
+	state->src.x1 = x1;
+	state->src.y1 = y1;
+	state->src.x2 = x2;
+	state->src.y2 = y2;
+}
+
+static void set_damage_clip(struct drm_mode_rect *r, int x1, int y1, int x2,
+			    int y2)
+{
+	r->x1 = x1;
+	r->y1 = y1;
+	r->x2 = x2;
+	r->y2 = y2;
+}
+
+static void set_damage_blob(struct drm_property_blob *damage_blob,
+			    struct drm_mode_rect *r, uint32_t size)
+{
+	damage_blob->length = size;
+	damage_blob->data = r;
+}
+
+static void set_plane_damage(struct drm_plane_state *state,
+			     struct drm_property_blob *damage_blob)
+{
+	state->fb_damage_clips = damage_blob;
+}
+
+static void check_damage_clip(struct kunit *test, struct drm_rect *r,
+		int x1, int y1, int x2, int y2)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_plane_state state = mock->state;
+
+	/*
+	 * Round down x1/y1 and round up x2/y2. This is because damage is not in
+	 * 16.16 fixed point so to catch all pixels.
+	 */
+	int src_x1 = state.src.x1 >> 16;
+	int src_y1 = state.src.y1 >> 16;
+	int src_x2 = (state.src.x2 >> 16) + !!(state.src.x2 & 0xFFFF);
+	int src_y2 = (state.src.y2 >> 16) + !!(state.src.y2 & 0xFFFF);
+
+	if (x1 >= x2 || y1 >= y2)
+		KUNIT_FAIL(test, "Cannot have damage clip with no dimension.");
+	if (x1 < src_x1 || y1 < src_y1 || x2 > src_x2 || y2 > src_y2)
+		KUNIT_FAIL(test, "Damage cannot be outside rounded plane src.");
+	if (r->x1 != x1 || r->y1 != y1 || r->x2 != x2 || r->y2 != y2)
+		KUNIT_FAIL(test, "Damage = %d %d %d %d, want = %d %d %d %d",
+				r->x1, r->y1, r->x2, r->y2, x1, y1, x2, y2);
+}
+
+static void igt_damage_iter_no_damage(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src same as fb size. */
+	set_plane_src(&mock->old_state, 0, 0, mock->fb.width << 16, mock->fb.height << 16);
+	set_plane_src(&mock->state, 0, 0, mock->fb.width << 16, mock->fb.height << 16);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, &clip, 0, 0, 2048, 2048);
+}
+
+static void igt_damage_iter_no_damage_fractional_src(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src has fractional part. */
+	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
+			"Should return rounded off plane src as damage.");
+	check_damage_clip(test, &clip, 3, 3, 1028, 772);
+}
+
+static void igt_damage_iter_no_damage_src_moved(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src moved since old plane state. */
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 10 << 16, 10 << 16,
+		      (10 + 1024) << 16, (10 + 768) << 16);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, &clip, 10, 10, 1034, 778);
+}
+
+static void igt_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src has fractional part and it moved since old plane state. */
+	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return plane src as damage.");
+	check_damage_clip(test, &clip, 4, 4, 1029, 773);
+}
+
+static void igt_damage_iter_no_damage_not_visible(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	mock->state.visible = false;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
+}
+
+static void igt_damage_iter_no_damage_no_crtc(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	mock->state.crtc = NULL;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
+}
+
+static void igt_damage_iter_no_damage_no_fb(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	mock->state.fb = NULL;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
+}
+
+static void igt_damage_iter_simple_damage(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* Damage set to plane src */
+	set_damage_clip(&damage, 0, 0, 1024, 768);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, &clip, 0, 0, 1024, 768);
+}
+
+static void igt_damage_iter_single_damage(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	set_damage_clip(&damage, 256, 192, 768, 576);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, &clip, 256, 192, 768, 576);
+}
+
+static void igt_damage_iter_single_damage_intersect_src(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* Damage intersect with plane src. */
+	set_damage_clip(&damage, 256, 192, 1360, 768);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage clipped to src.");
+	check_damage_clip(test, &clip, 256, 192, 1024, 768);
+}
+
+static void igt_damage_iter_single_damage_outside_src(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* Damage clip outside plane src */
+	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
+}
+
+static void igt_damage_iter_single_damage_fractional_src(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src has fractional part. */
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_damage_clip(&damage, 10, 10, 256, 330);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, &clip, 10, 10, 256, 330);
+}
+
+static void igt_damage_iter_single_damage_intersect_fractional_src(
+		struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src has fractional part. */
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	/* Damage intersect with plane src. */
+	set_damage_clip(&damage, 10, 1, 1360, 330);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
+			"Should return damage clipped to rounded off src.");
+	check_damage_clip(test, &clip, 10, 4, 1029, 330);
+}
+
+static void igt_damage_iter_single_damage_outside_fractional_src(
+		struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src has fractional part. */
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	/* Damage clip outside plane src */
+	set_damage_clip(&damage, 1360, 1360, 1380, 1380);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
+}
+
+static void igt_damage_iter_single_damage_src_moved(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src moved since old plane state. */
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 10 << 16, 10 << 16,
+		      (10 + 1024) << 16, (10 + 768) << 16);
+	set_damage_clip(&damage, 20, 30, 256, 256);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
+			"Should return plane src as damage.");
+	check_damage_clip(test, &clip, 10, 10, 1034, 778);
+}
+
+static void igt_damage_iter_single_damage_fractional_src_moved(
+		struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage;
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	/* Plane src with fractional part moved since old plane state. */
+	set_plane_src(&mock->old_state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	/* Damage intersect with plane src. */
+	set_damage_clip(&damage, 20, 30, 1360, 256);
+	set_damage_blob(&damage_blob, &damage, sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
+			"Should return rounded off plane as damage.");
+	check_damage_clip(test, &clip, 4, 4, 1029, 773);
+}
+
+static void igt_damage_iter_damage(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* 2 damage clips. */
+	set_damage_clip(&damage[0], 20, 30, 200, 180);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip) {
+		if (num_hits == 0)
+			check_damage_clip(test, &clip, 20, 30, 200, 180);
+		if (num_hits == 1)
+			check_damage_clip(test, &clip, 240, 200, 280, 250);
+		num_hits++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 2, "Should return damage when set.");
+}
+
+static void igt_damage_iter_damage_one_intersect(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	/* 2 damage clips, one intersect plane src. */
+	set_damage_clip(&damage[0], 20, 30, 200, 180);
+	set_damage_clip(&damage[1], 2, 2, 1360, 1360);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip) {
+		if (num_hits == 0)
+			check_damage_clip(test, &clip, 20, 30, 200, 180);
+		if (num_hits == 1)
+			check_damage_clip(test, &clip, 4, 4, 1029, 773);
+		num_hits++;
+	}
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 2, "Should return damage when set.");
+}
+
+static void igt_damage_iter_damage_one_outside(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0, 0, 1024 << 16, 768 << 16);
+	set_plane_src(&mock->state, 0, 0, 1024 << 16, 768 << 16);
+	/* 2 damage clips, one outside plane src. */
+	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1, "Should return damage when set.");
+	check_damage_clip(test, &clip, 240, 200, 280, 250);
+}
+
+static void igt_damage_iter_damage_src_moved(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	/* 2 damage clips, one outside plane src. */
+	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 1,
+			"Should return round off plane src as damage.");
+	check_damage_clip(test, &clip, 3, 3, 1028, 772);
+}
+
+static void igt_damage_iter_damage_not_visible(struct kunit *test)
+{
+	struct drm_damage_mock *mock = test->priv;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_property_blob damage_blob;
+	struct drm_mode_rect damage[2];
+	struct drm_rect clip;
+	uint32_t num_hits = 0;
+
+	mock->state.visible = false;
+
+	set_plane_src(&mock->old_state, 0x40002, 0x40002,
+		      0x40002 + (1024 << 16), 0x40002 + (768 << 16));
+	set_plane_src(&mock->state, 0x3fffe, 0x3fffe,
+		      0x3fffe + (1024 << 16), 0x3fffe + (768 << 16));
+	/* 2 damage clips, one outside plane src. */
+	set_damage_clip(&damage[0], 1360, 1360, 1380, 1380);
+	set_damage_clip(&damage[1], 240, 200, 280, 250);
+	set_damage_blob(&damage_blob, &damage[0], sizeof(damage));
+	set_plane_damage(&mock->state, &damage_blob);
+	drm_atomic_helper_damage_iter_init(&iter, &mock->old_state, &mock->state);
+	drm_atomic_for_each_plane_damage(&iter, &clip)
+		num_hits++;
+
+	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should not return any damage.");
+}
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
+	.init = drm_damage_helper_init,
+	.test_cases = drm_damage_helper_tests,
+};
+
+kunit_test_suite(drm_damage_helper_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.36.1

