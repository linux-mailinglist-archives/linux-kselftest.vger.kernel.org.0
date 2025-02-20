Return-Path: <linux-kselftest+bounces-27068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5DA3DB40
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 14:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40B33B759F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459E1F8BA4;
	Thu, 20 Feb 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVYtkDYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95D1F8AE5
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057941; cv=none; b=Fvn07/YiDXtNm0Ifcpswzvg6mBvnWrH/C15eU7Gr8IfZxZjaxppF0iMo4wD0+rDv3+gRfri7do08ANCMc6CLbYAwXZ9+TiQJV3BEXPVmiJ2+o6RNMn11QQuMXplh1HJHfxmEvQVbD3dyPkFIfD8mShbJTyTjpk+UZQ7MSW8Bq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057941; c=relaxed/simple;
	bh=BZAhdlTCRPUzqFspXw+ULhHxYXJuUMwGcDqpvl4gjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkXa1Jgqaes+maQCKQNu5+F/nHTpdOvnZ2Y99gg7OBPZ1a9xSwiuSBvb5IpxRXnSnL0R2Rng/1RXmqY+dVSCsRBfjI7lRiy7X0oPb/XeqzBvmyt/4loSCZ3EnjydHkvpUd+orgS0wyarpn6IJl7VQoslIS0MrTAaNUW81jpSMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVYtkDYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC8C4CED1;
	Thu, 20 Feb 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057941;
	bh=BZAhdlTCRPUzqFspXw+ULhHxYXJuUMwGcDqpvl4gjCo=;
	h=From:To:Cc:Subject:Date:From;
	b=VVYtkDYdEinpYRpHnMGh8V0qZPhh0kGm3UYiIrLTYUk0eV28HEEOf+blwWGJhQTT5
	 2w+rjscUps9oUtWprdzN89/t9Vc7KMtA2GRIlQUH4jkTveAO5uRjko78rgO0AbhnjK
	 Fk+rf4fVWG4Ca0soevAx6kEHwXcfuK/JchmcDu4CBncy3l+UR00nvzbfu9zhWMvh1r
	 jX7aDKgsql2MQnaD+bcHPmToMdtm/zJVtaV/idNPuFLLau7y7JDHn606NuxGCM2VHs
	 nXQZ6kH1wHKaDSeiNllZeGSIy8dixWUqYa3Pbtcy9DkT2GHmQxCF3lcGagmeMfNNCT
	 tPyD8GEb8+0Tw==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()
Date: Thu, 20 Feb 2025 14:25:37 +0100
Message-ID: <20250220132537.2834168-1-mripard@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lockdep complains when a lock is released in a separate thread the
lock is taken in, and it turns out that kunit does run its actions in a
separate thread than the test ran in.

This means that drm_kunit_helper_acquire_ctx_alloc() just cannot work as
it's supposed to, so let's just get rid of it.

Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Changes from v1:
 - Reworded the commit log (Sima)
---
 drivers/gpu/drm/tests/drm_atomic_state_test.c |  24 +-
 .../drm/tests/drm_hdmi_state_helper_test.c    | 254 +++++++++++-------
 drivers/gpu/drm/tests/drm_kunit_helpers.c     |  41 ---
 .../gpu/drm/vc4/tests/vc4_test_pv_muxing.c    |  46 ++--
 include/drm/drm_kunit_helpers.h               |   2 -
 5 files changed, 191 insertions(+), 176 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
index 5945c3298901..2f6ac7a09f44 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
@@ -187,11 +187,11 @@ static int set_up_atomic_state(struct kunit *test,
  * connectors are changed but the CRTC mode is not.
  */
 static void drm_test_check_connector_changed_modeset(struct kunit *test)
 {
 	struct drm_atomic_test_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector *old_conn, *new_conn;
 	struct drm_atomic_state *state;
 	struct drm_device *drm;
 	struct drm_connector_state *new_conn_state, *old_conn_state;
 	int ret, initial_modeset_count;
@@ -201,18 +201,17 @@ static void drm_test_check_connector_changed_modeset(struct kunit *test)
 
 	drm = &priv->drm;
 	old_conn = &priv->connectors[0];
 	new_conn = &priv->connectors[1];
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	// first modeset to enable
-	ret = set_up_atomic_state(test, priv, old_conn, ctx);
+	ret = set_up_atomic_state(test, priv, old_conn, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	new_conn_state = drm_atomic_get_connector_state(state, new_conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
@@ -229,10 +228,13 @@ static void drm_test_check_connector_changed_modeset(struct kunit *test)
 
 	// modeset_disables is called as part of the atomic commit tail
 	ret = drm_atomic_commit(state);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_EQ(test, modeset_counter, initial_modeset_count + 1);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that the drm_crtc_in_clone_mode() helper can detect if a given CRTC
  * state is in clone mode
@@ -261,27 +263,26 @@ static void drm_test_check_in_clone_mode(struct kunit *test)
 static void drm_test_check_valid_clones(struct kunit *test)
 {
 	int ret;
 	const struct drm_clone_mode_test *param = test->param_value;
 	struct drm_atomic_test_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_device *drm;
 	struct drm_atomic_state *state;
 	struct drm_crtc_state *crtc_state;
 
 	priv = drm_atomic_test_init_drm_components(test, false);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = set_up_atomic_state(test, priv, NULL, ctx);
+	ret = set_up_atomic_state(test, priv, NULL, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
@@ -290,10 +291,13 @@ static void drm_test_check_valid_clones(struct kunit *test)
 	// force modeset
 	crtc_state->mode_changed = true;
 
 	ret = drm_atomic_helper_check_modeset(drm, state);
 	KUNIT_ASSERT_EQ(test, ret, param->expected_result);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static void drm_check_in_clone_mode_desc(const struct drm_clone_mode_test *t,
 				      char *desc)
 {
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 23ecc00accb2..e97efd3af9ed 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -271,11 +271,11 @@ drm_kunit_helper_connector_hdmi_init(struct kunit *test,
  * in turn disable/enable the connector.
  */
 static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
@@ -294,17 +294,16 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	conn = &priv->connector;
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	new_conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
@@ -325,21 +324,24 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, new_conn_state->hdmi.broadcast_rgb, DRM_HDMI_BROADCAST_RGB_FULL);
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 	KUNIT_EXPECT_TRUE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we set the RGB quantization property to the same value,
  * we don't trigger a mode change on the connector's CRTC and leave the
  * connector unaffected.
  */
 static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
@@ -358,17 +360,16 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	conn = &priv->connector;
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	new_conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
@@ -391,21 +392,24 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 			new_conn_state->hdmi.broadcast_rgb);
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 	KUNIT_EXPECT_FALSE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to auto with a mode that isn't the
  * VIC-1 mode, we will get a limited RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -424,17 +428,16 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -447,21 +450,24 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
 	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to auto with a VIC-1 mode, we will get
  * a full RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *mode;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -475,21 +481,20 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 
 	drm = &priv->drm;
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -502,21 +507,24 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
 	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to full with a mode that isn't the
  * VIC-1 mode, we will get a full RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -535,17 +543,16 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -560,21 +567,24 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	KUNIT_ASSERT_EQ(test,
 			conn_state->hdmi.broadcast_rgb,
 			DRM_HDMI_BROADCAST_RGB_FULL);
 
 	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to full with a VIC-1 mode, we will get
  * a full RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *mode;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -588,21 +598,20 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 
 	drm = &priv->drm;
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -617,21 +626,24 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	KUNIT_ASSERT_EQ(test,
 			conn_state->hdmi.broadcast_rgb,
 			DRM_HDMI_BROADCAST_RGB_FULL);
 
 	KUNIT_EXPECT_FALSE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to limited with a mode that isn't the
  * VIC-1 mode, we will get a limited RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -650,17 +662,16 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_NE(test, drm_match_cea_mode(preferred), 1);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -675,21 +686,24 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	KUNIT_ASSERT_EQ(test,
 			conn_state->hdmi.broadcast_rgb,
 			DRM_HDMI_BROADCAST_RGB_LIMITED);
 
 	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that for an HDMI connector, with an HDMI monitor, if the
  * Broadcast RGB property is set to limited with a VIC-1 mode, we will
  * get a limited RGB Quantization Range.
  */
 static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *mode;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -703,21 +717,20 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 
 	drm = &priv->drm;
 	conn = &priv->connector;
 	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	mode = drm_kunit_display_mode_from_cea_vic(test, drm, 1);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
 
@@ -732,21 +745,24 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	KUNIT_ASSERT_EQ(test,
 			conn_state->hdmi.broadcast_rgb,
 			DRM_HDMI_BROADCAST_RGB_LIMITED);
 
 	KUNIT_EXPECT_TRUE(test, conn_state->hdmi.is_limited_range);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we change the maximum bpc property to a different value,
  * we trigger a mode change on the connector's CRTC, which will in turn
  * disable/enable the connector.
  */
 static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
@@ -769,17 +785,16 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	KUNIT_ASSERT_GT(test, ret, 0);
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	new_conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
@@ -806,21 +821,24 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 			new_conn_state->hdmi.output_bpc);
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 	KUNIT_EXPECT_TRUE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we set the output bpc property to the same value, we
  * don't trigger a mode change on the connector's CRTC and leave the
  * connector unaffected.
  */
 static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *old_conn_state;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
@@ -843,17 +861,16 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	KUNIT_ASSERT_GT(test, ret, 0);
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	new_conn_state = drm_atomic_get_connector_state(state, conn);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
 
@@ -878,20 +895,23 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 			new_conn_state->hdmi.output_bpc);
 
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 	KUNIT_EXPECT_FALSE(test, crtc_state->mode_changed);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we have an HDMI connector but a !HDMI display, we always
  * output RGB with 8 bpc.
  */
 static void drm_test_check_output_bpc_dvi(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -917,31 +937,33 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	KUNIT_ASSERT_FALSE(test, info->is_hdmi);
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that when doing a commit which would use RGB 8bpc, the TMDS
  * clock rate stored in the connector state is equal to the mode clock
  */
 static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
 	struct drm_crtc *crtc;
@@ -962,33 +984,35 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1000);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that when doing a commit which would use RGB 10bpc, the TMDS
  * clock rate stored in the connector state is equal to 1.25 times the
  * mode pixel clock
  */
 static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
 	struct drm_crtc *crtc;
@@ -1009,33 +1033,35 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_bpc, 10);
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1250);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that when doing a commit which would use RGB 12bpc, the TMDS
  * clock rate stored in the connector state is equal to 1.5 times the
  * mode pixel clock
  */
 static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
 	struct drm_device *drm;
 	struct drm_crtc *crtc;
@@ -1056,22 +1082,24 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 	KUNIT_ASSERT_FALSE(test, preferred->flags & DRM_MODE_FLAG_DBLCLK);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_bpc, 12);
 	KUNIT_ASSERT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1500);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we filter a rate through our hook, it's indeed rejected
  * by the whole atomic_check logic.
@@ -1081,11 +1109,11 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
  * again to see if it fails as it should.
  */
 static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *conn;
 	struct drm_device *drm;
@@ -1102,29 +1130,31 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	conn = &priv->connector;
 
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	/* You shouldn't be doing that at home. */
 	conn->hdmi.funcs = &reject_connector_hdmi_funcs;
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
 	crtc_state->connectors_changed = true;
 
 	ret = drm_atomic_check_only(state);
 	KUNIT_EXPECT_LT(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if:
  * - We have an HDMI connector supporting RGB only
@@ -1137,11 +1167,11 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
  * will be equal to 1.25 times the mode pixel clock.
  */
 static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1174,22 +1204,24 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	KUNIT_ASSERT_GT(test, rate, info->max_tmds_clock * 1000);
 
 	rate = drm_hdmi_compute_mode_clock(preferred, 10, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 10);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate, preferred->clock * 1250);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if:
  * - We have an HDMI connector supporting both RGB and YUV422 and up to
@@ -1204,11 +1236,11 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
  * picking YUV422.
  */
 static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1246,32 +1278,34 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	KUNIT_ASSERT_GT(test, rate, info->max_tmds_clock * 1000);
 
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 10);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if a driver and screen supports RGB and YUV formats, and we
  * try to set the VIC 1 mode, we end up with 8bpc RGB even if we could
  * have had a higher bpc.
  */
 static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *mode;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1308,32 +1342,34 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	 * Thus, we have to calculate the rate by hand.
 	 */
 	rate = mode->clock * 1500;
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, mode, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, mode, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if a driver supports only RGB but the screen also supports
  * YUV formats, we only end up with an RGB format.
  */
 static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1374,31 +1410,33 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	KUNIT_ASSERT_GT(test, rate, info->max_tmds_clock * 1000);
 
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_LT(test, conn_state->hdmi.output_bpc, 12);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if a screen supports only RGB but the driver also supports
  * YUV formats, we only end up with an RGB format.
  */
 static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1441,32 +1479,34 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	KUNIT_ASSERT_GT(test, rate, info->max_tmds_clock * 1000);
 
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_YUV422);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_LT(test, conn_state->hdmi.output_bpc, 12);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if a display supports higher bpc but the driver only
  * supports 8 bpc, we only end up with 8 bpc even if we could have had a
  * higher bpc.
  */
 static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1499,32 +1539,34 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	 * clock to actually use 12bpc.
 	 */
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if a driver supports higher bpc but the display only
  * supports 8 bpc, we only end up with 8 bpc even if we could have had a
  * higher bpc.
  */
 static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_display_info *info;
 	struct drm_display_mode *preferred;
 	unsigned long long rate;
 	struct drm_connector *conn;
@@ -1559,28 +1601,30 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	 * clock to actually use 12bpc.
 	 */
 	rate = drm_hdmi_compute_mode_clock(preferred, 12, HDMI_COLORSPACE_RGB);
 	KUNIT_ASSERT_LT(test, rate, info->max_tmds_clock * 1000);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	conn_state = conn->state;
 	KUNIT_ASSERT_NOT_NULL(test, conn_state);
 
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_bpc, 8);
 	KUNIT_EXPECT_EQ(test, conn_state->hdmi.output_format, HDMI_COLORSPACE_RGB);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /* Test that atomic check succeeds when disabling a connector. */
 static void drm_test_check_disable_connector(struct kunit *test)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_atomic_state *state;
 	struct drm_display_mode *preferred;
 	struct drm_connector *conn;
@@ -1591,23 +1635,22 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	priv = drm_kunit_helper_connector_hdmi_init(test,
 						    BIT(HDMI_COLORSPACE_RGB),
 						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	conn = &priv->connector;
 	preferred = find_preferred_mode(conn);
 	KUNIT_ASSERT_NOT_NULL(test, preferred);
 
 	drm = &priv->drm;
 	crtc = priv->crtc;
-	ret = light_up_connector(test, drm, crtc, conn, preferred, ctx);
+	ret = light_up_connector(test, drm, crtc, conn, preferred, &ctx);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
@@ -1621,10 +1664,13 @@ static void drm_test_check_disable_connector(struct kunit *test)
 	ret = drm_atomic_set_crtc_for_connector(conn_state, NULL);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	ret = drm_atomic_check_only(state);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static struct kunit_case drm_atomic_helper_connector_hdmi_check_tests[] = {
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode),
 	KUNIT_CASE(drm_test_check_broadcast_rgb_auto_cea_mode_vic_1),
diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 3c0b7824c0be..a4eb68f0decc 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -78,51 +78,10 @@ __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
 
 	return drm;
 }
 EXPORT_SYMBOL_GPL(__drm_kunit_helper_alloc_drm_device_with_driver);
 
-static void action_drm_release_context(void *ptr)
-{
-	struct drm_modeset_acquire_ctx *ctx = ptr;
-
-	drm_modeset_drop_locks(ctx);
-	drm_modeset_acquire_fini(ctx);
-}
-
-/**
- * drm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
- * @test: The test context object
- *
- * Allocates and initializes a modeset acquire context.
- *
- * The context is tied to the kunit test context, so we must not call
- * drm_modeset_acquire_fini() on it, it will be done so automatically.
- *
- * Returns:
- * An ERR_PTR on error, a pointer to the newly allocated context otherwise
- */
-struct drm_modeset_acquire_ctx *
-drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
-{
-	struct drm_modeset_acquire_ctx *ctx;
-	int ret;
-
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx);
-
-	drm_modeset_acquire_init(ctx, 0);
-
-	ret = kunit_add_action_or_reset(test,
-					action_drm_release_context,
-					ctx);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return ctx;
-}
-EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
-
 static void kunit_action_drm_atomic_state_put(void *ptr)
 {
 	struct drm_atomic_state *state = ptr;
 
 	drm_atomic_state_put(state);
diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 40a05869a50e..992e8f5c5c6e 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -722,11 +722,11 @@ static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
 }
 
 static int vc4_pv_muxing_test_init(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct pv_muxing_priv *priv;
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
 
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
@@ -735,17 +735,19 @@ static int vc4_pv_muxing_test_init(struct kunit *test)
 
 	vc4 = params->mock_fn(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 	priv->vc4 = vc4;
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
-	priv->state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	priv->state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->state);
 
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
 	return 0;
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
 	KUNIT_CASE_PARAM(drm_vc4_test_pv_muxing,
@@ -780,11 +782,11 @@ static struct kunit_suite vc5_pv_muxing_test_suite = {
  * and
  * https://lore.kernel.org/dri-devel/20200917121623.42023-1-maxime@cerno.tech/
  */
 static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct vc4_hvs_state *new_hvs_state;
 	unsigned int hdmi0_channel;
 	unsigned int hdmi1_channel;
@@ -793,15 +795,14 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	int ret;
 
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -820,11 +821,11 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[hdmi0_channel].in_use);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -841,10 +842,13 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	hdmi1_channel = new_vc4_crtc_state->assigned_channel;
 	KUNIT_ASSERT_NE(test, hdmi1_channel, VC4_HVS_CHANNEL_DISABLED);
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[hdmi1_channel].in_use);
 
 	KUNIT_EXPECT_NE(test, hdmi0_channel, hdmi1_channel);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * This test makes sure that we never change the FIFO of an active HVS
  * channel if we disable a FIFO with a lower index.
@@ -852,11 +856,11 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
  * Doing so would result in a FIFO stall and would disrupt an output
  * supposed to be unaffected by the commit.
  */
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct vc4_hvs_state *new_hvs_state;
 	unsigned int old_hdmi0_channel;
 	unsigned int old_hdmi1_channel;
@@ -865,15 +869,14 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	int ret;
 
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -903,11 +906,11 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[old_hdmi1_channel].in_use);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_del_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -927,10 +930,13 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 		KUNIT_ASSERT_NE(test, hdmi1_channel, VC4_HVS_CHANNEL_DISABLED);
 		KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[hdmi1_channel].in_use);
 
 		KUNIT_EXPECT_EQ(test, old_hdmi1_channel, hdmi1_channel);
 	}
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 /*
  * Test that if we affect a single output, only the CRTC state of that
  * output will be pulled in the global atomic state.
@@ -947,25 +953,24 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
  *     inactive CRTC that never completes.
  */
 static void
 drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx *ctx;
+	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
 	int ret;
 
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	drm_modeset_acquire_init(&ctx, 0);
 
 	drm = &vc4->base;
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -973,11 +978,11 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -985,10 +990,13 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	new_vc4_crtc_state = get_vc4_crtc_state_for_encoder(test, state,
 							    VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_EXPECT_NULL(test, new_vc4_crtc_state);
+
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {
 	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable),
 	KUNIT_CASE(drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state),
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index afdd46ef04f7..11d59ce0bac0 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -93,12 +93,10 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 #define drm_kunit_helper_alloc_drm_device(_test, _dev, _type, _member, _feat)	\
 	((_type *)__drm_kunit_helper_alloc_drm_device(_test, _dev,		\
 						      sizeof(_type),		\
 						      offsetof(_type, _member),	\
 						      _feat))
-struct drm_modeset_acquire_ctx *
-drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
 
 struct drm_atomic_state *
 drm_kunit_helper_atomic_state_alloc(struct kunit *test,
 				    struct drm_device *drm,
 				    struct drm_modeset_acquire_ctx *ctx);
-- 
2.48.1


