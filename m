Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD2766842
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjG1JH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjG1JGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699730DE;
        Fri, 28 Jul 2023 02:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C689D62087;
        Fri, 28 Jul 2023 09:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D706AC433C8;
        Fri, 28 Jul 2023 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535199;
        bh=glqLVfxH2FzQa0kBwhFP6pFwhRUvrw5EmHCeG8i7sAE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TCYuV47WRfvlWfegR/SM0w+A+x4i6UcNBNxpgEIF7c64NvVpcey7vXwaRxaJmxEO3
         AUvQwahhv8RFEPCJctBmJMbRPc0kFrWkGRW+b1yGkC7s4jYx0+XE7xvS7nfsc9t84k
         zzSOV4YcQQQIXrvYEYN/i6HiSYkG05zhZsayVNj8BE6nmhBBxDQV0+ojAf9h5KOATk
         ibosE9qoO+GMlNO3dB8ADIYU/uA6GmJO8OndTgUFlMVT7tbAt4K6js3vS5GFxNCXav
         6aMiiYcqMpYw+baKHpyd/zIHJF+Sfqp/BCdpI3OJnZiuHZpVvOrNNiuX924QKCeaf+
         JWN8ApmyHURGw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:19 +0200
Subject: [PATCH v3 06/11] drm/tests: helpers: Create a helper to allocate
 an atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-6-952565ccccfe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075; i=mripard@kernel.org;
 h=from:subject:message-id; bh=glqLVfxH2FzQa0kBwhFP6pFwhRUvrw5EmHCeG8i7sAE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7mul79aduU7b2fpY/Ppz//fnFJ9/rDO/2eaLA4Mm
 3e3fp07u6OUhUGMi0FWTJElRth8SdypWa872fjmwcxhZQIZwsDFKQATkV3CyHDzg19N666QrMTT
 XOcVQn0uZS4+8UqvpMps51YzzawjD7gZGRa0PcnU+a3SsvfR8q55J+++8Fp8J7/S+UKo/RGB4DN
 H1nMBAA==
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

As we gain more tests, boilerplate to allocate an atomic state and free
it starts to be there more and more as well.

In order to reduce the allocation boilerplate, we can create a helper
to create that atomic state, and call an action when the test is done.
This will also clean up the exit path.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 46 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  5 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 35ea4a34909d..3d624ff2f651 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -187,5 +188,50 @@ drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
 
+static void kunit_action_drm_atomic_state_put(void *ptr)
+{
+	struct drm_atomic_state *state = ptr;
+
+	drm_atomic_state_put(state);
+}
+
+/**
+ * drm_kunit_helper_atomic_state_alloc - Allocates an atomic state
+ * @test: The test context object
+ * @drm: The device to alloc the state for
+ * @ctx: Locking context for that atomic update
+ *
+ * Allocates a empty atomic state.
+ *
+ * The state is tied to the kunit test context, so we must not call
+ * drm_atomic_state_put() on it, it will be done so automatically.
+ *
+ * Returns:
+ * An ERR_PTR on error, a pointer to the newly allocated state otherwise
+ */
+struct drm_atomic_state *
+drm_kunit_helper_atomic_state_alloc(struct kunit *test,
+				    struct drm_device *drm,
+				    struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_atomic_state *state;
+	int ret;
+
+	state = drm_atomic_state_alloc(drm);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_drm_atomic_state_put,
+					state);
+	if (ret)
+		return ERR_PTR(ret);
+
+	state->acquire_ctx = ctx;
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_atomic_state_alloc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index 4ba5e10653c6..514c8a7a32f0 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -90,4 +90,9 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 struct drm_modeset_acquire_ctx *
 drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
 
+struct drm_atomic_state *
+drm_kunit_helper_atomic_state_alloc(struct kunit *test,
+				    struct drm_device *drm,
+				    struct drm_modeset_acquire_ctx *ctx);
+
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.41.0

