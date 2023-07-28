Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C076684C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjG1JIU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjG1JHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092DA4227;
        Fri, 28 Jul 2023 02:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA4F262089;
        Fri, 28 Jul 2023 09:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC632C433CA;
        Fri, 28 Jul 2023 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535211;
        bh=8/tEb5OWseFqbYf8/A/XKTgIA6zjZPi8ZpLNlpJKKpw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UVrz4KM23wFmjfRqT7qkW+QdFNE0JVLImJg98dre5NUS1nIy7PMJcxpCs4qwNwdYS
         xdk+KsRwBx13qbs//t3YXapXoSkGFmut+QpMqmrQ+HNFZuHsb17Q+f1CjwIvlRLGOz
         dL7JPjdW2zYc7H+4Tvs2ejRglvu5olWuSUw1GLhpS4fcTBuPZil+Ot4c/nODquBInx
         uTIGBDUcULWUlaUBqa8wdSZm1qRsc9pfu5lVj4OATNg+KTdqkfJW8HQ3VLLZjg3LBu
         PanYhABVusGJqYM71hVrGC4EWRwrkQCsmsEntpjbzHmYHLux+cxJjgHee/RmtA6ctF
         YTpVNpTs3txKg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:23 +0200
Subject: [PATCH v3 10/11] drm/vc4: tests: Switch to atomic state allocation
 helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-10-952565ccccfe@kernel.org>
References: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
In-Reply-To: <20230728-kms-kunit-actions-rework-v3-0-952565ccccfe@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6236; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8/tEb5OWseFqbYf8/A/XKTgIA6zjZPi8ZpLNlpJKKpw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7k8fsS/bAlfGreBXeAHk2kAY7N/qJupjFekk/n1V
 9vFxEw7SlkYxLgYZMUUWWKEzZfEnZr1upONbx7MHFYmkCEMXJwCMJGLWowMDX9LJBey6kZJ/vgd
 InRXi8thIdvu1x9Zo3Z1XXCZcn/6c4Z/OoJxYVPSzp+65FYbHT31dhHLh77pp94/FXB4dYY95lQ
 OGwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that we have a helper that takes care of an atomic state allocation
and cleanup, we can migrate to it to simplify our tests.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 55 ++++----------------------
 1 file changed, 8 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index ff1deaed0cab..5f9f5626329d 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -725,7 +725,6 @@ static int vc4_pv_muxing_test_init(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
 	struct drm_modeset_acquire_ctx *ctx;
-	struct drm_atomic_state *state;
 	struct pv_muxing_priv *priv;
 	struct drm_device *drm;
 	struct vc4_dev *vc4;
@@ -742,24 +741,12 @@ static int vc4_pv_muxing_test_init(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
-	state = drm_atomic_state_alloc(drm);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
-
-	state->acquire_ctx = ctx;
-
-	priv->state = state;
+	priv->state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->state);
 
 	return 0;
 }
 
-static void vc4_pv_muxing_test_exit(struct kunit *test)
-{
-	struct pv_muxing_priv *priv = test->priv;
-	struct drm_atomic_state *state = priv->state;
-
-	drm_atomic_state_put(state);
-}
-
 static struct kunit_case vc4_pv_muxing_tests[] = {
 	KUNIT_CASE_PARAM(drm_vc4_test_pv_muxing,
 			 vc4_test_pv_muxing_gen_params),
@@ -771,7 +758,6 @@ static struct kunit_case vc4_pv_muxing_tests[] = {
 static struct kunit_suite vc4_pv_muxing_test_suite = {
 	.name = "vc4-pv-muxing-combinations",
 	.init = vc4_pv_muxing_test_init,
-	.exit = vc4_pv_muxing_test_exit,
 	.test_cases = vc4_pv_muxing_tests,
 };
 
@@ -786,7 +772,6 @@ static struct kunit_case vc5_pv_muxing_tests[] = {
 static struct kunit_suite vc5_pv_muxing_test_suite = {
 	.name = "vc5-pv-muxing-combinations",
 	.init = vc4_pv_muxing_test_init,
-	.exit = vc4_pv_muxing_test_exit,
 	.test_cases = vc5_pv_muxing_tests,
 };
 
@@ -814,11 +799,9 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -839,13 +822,9 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	drm_atomic_state_put(state);
-
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -864,8 +843,6 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_ASSERT_TRUE(test, new_hvs_state->fifo_state[hdmi1_channel].in_use);
 
 	KUNIT_EXPECT_NE(test, hdmi0_channel, hdmi1_channel);
-
-	drm_atomic_state_put(state);
 }
 
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
@@ -887,11 +864,9 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -923,13 +898,9 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	drm_atomic_state_put(state);
-
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_del_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -951,8 +922,6 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, old_hdmi1_channel, hdmi1_channel);
 	}
-
-	drm_atomic_state_put(state);
 }
 
 static void
@@ -972,11 +941,9 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -986,13 +953,9 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	ret = drm_atomic_helper_swap_state(state, false);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	drm_atomic_state_put(state);
-
-	state = drm_atomic_state_alloc(drm);
+	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = ctx;
-
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -1002,8 +965,6 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	new_vc4_crtc_state = get_vc4_crtc_state_for_encoder(test, state,
 							    VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_EXPECT_NULL(test, new_vc4_crtc_state);
-
-	drm_atomic_state_put(state);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {

-- 
2.41.0

