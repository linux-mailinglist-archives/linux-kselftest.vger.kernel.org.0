Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C875ACD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGTLRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGTLQr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E79726B7;
        Thu, 20 Jul 2023 04:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A36461A40;
        Thu, 20 Jul 2023 11:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EFBC433C8;
        Thu, 20 Jul 2023 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851778;
        bh=JWFUwbalD9zxa7dO/ypOz2ghZPZM+ydDXz32zJavDmo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rEatctXrj2El/Oqy1p1LuoVHjODRVKHwABdheYr7D+onnRgjPQTdG04aSVp5k6iJ6
         ONrLpEmbwfdS3BxkhZGwQFFpldyp9azcoIZ0aYplDhEuXeccqzPcp4hwLrWLIzASZ3
         bcdaCziIgQLc2VnyxscUOXxsJk2eHVlI8CJtgqdyVgmJfTtMPEVWHIiPphmCmhtSRJ
         oOCHKeXaJjrI7rAjpFzveNdCKwaHz6Pr0378if2GvSQSyLqD9niZrOPiM191dy5Mu8
         NODcJukr9fAyDiyPODWUv0u/TR9oywflLWAy+fdXNRtXxkLEXcW+WotSumAN8hu762
         WiAT/WaGzWHWg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:53 +0200
Subject: [PATCH v2 08/11] drm/vc4: tests: mock: Use a kunit action to
 unregister DRM device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-8-175017bd56ab@kernel.org>
References: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
In-Reply-To: <20230720-kms-kunit-actions-rework-v2-0-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JWFUwbalD9zxa7dO/ypOz2ghZPZM+ydDXz32zJavDmo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTNeBN0RPz+jjEX21DPrzuOxy6YveKE35Yznh8v9j
 vta1heqdZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi/2UZ/kdYbWP8pSvxfSfn
 VO67jkdayo8wb39xZJZT3HvDt0/uMmYw/OGde3vF5/su7RukFuiu4dP83rgt/5r1rLKGi1M/L33
 2qpgJAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The *_mock_device functions allocate a DRM device that needs to be
released using drm_dev_unregister.

Now that we have a kunit release action API, we can switch to it and
don't require any kind of garbage collection from the caller.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_mock.c           | 5 +++++
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index a4bed26af32f..00825ddc52f0 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -186,6 +186,11 @@ static struct vc4_dev *__mock_device(struct kunit *test, bool is_vc5)
 	ret = drm_dev_register(drm, 0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	ret = kunit_add_action_or_reset(test,
+					(kunit_action_t *)drm_dev_unregister,
+					drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	return vc4;
 }
 
diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 6c982e72cae8..776a7b01608f 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -754,14 +754,11 @@ static int vc4_pv_muxing_test_init(struct kunit *test)
 static void vc4_pv_muxing_test_exit(struct kunit *test)
 {
 	struct pv_muxing_priv *priv = test->priv;
-	struct vc4_dev *vc4 = priv->vc4;
-	struct drm_device *drm = &vc4->base;
 	struct drm_atomic_state *state = priv->state;
 
 	drm_atomic_state_put(state);
 	drm_modeset_drop_locks(&priv->ctx);
 	drm_modeset_acquire_fini(&priv->ctx);
-	drm_dev_unregister(drm);
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
@@ -871,7 +868,6 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	drm_atomic_state_put(state);
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-	drm_dev_unregister(drm);
 }
 
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
@@ -960,7 +956,6 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	drm_atomic_state_put(state);
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-	drm_dev_unregister(drm);
 }
 
 static void
@@ -1013,7 +1008,6 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	drm_atomic_state_put(state);
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
-	drm_dev_unregister(drm);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {

-- 
2.41.0

