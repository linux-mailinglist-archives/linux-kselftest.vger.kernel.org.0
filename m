Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1475ACC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGTLQr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGTLQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E607270A;
        Thu, 20 Jul 2023 04:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9756061A30;
        Thu, 20 Jul 2023 11:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122EC433C8;
        Thu, 20 Jul 2023 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851772;
        bh=RTSEK9AuzInb7QEn851gyVYlX2dE99c4ygJyZxMvK4w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LGJjo1RlmLqvxcMtAHqsnDWNrG5LnXneK5Yg0asEY0wUnpmxf5EQlxVYZJ8fb68ZI
         lBh084z2BgcXsxbtV/T1m272twTAM1vFVk9Hg34KEldAaPxAIzxtphK6ntKVgLHfPr
         jhY2pI01EwRFI1TwI5Hh/0k0aayQyCEZXjPsTpN/LGzff2+gzAzhMK+2qyY979qd+2
         nSim8I6Nq+K3ofrZt7GZEO+gFtJxsSoQ0FM9pnNr40woS40ERxBQD0RGKNX3T0ACu/
         Gk4wux8xPAAqc0P/hcRTC/pzVhFAyOwzGT8N9jwiEsrzqLfV4RsD9Ai4fceVMrhQW3
         t+JJX09qz25hg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:51 +0200
Subject: [PATCH v2 06/11] drm/tests: helpers: Create a helper to allocate
 an atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-6-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=mripard@kernel.org;
 h=from:subject:message-id; bh=RTSEK9AuzInb7QEn851gyVYlX2dE99c4ygJyZxMvK4w=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTN2dsp7mT+PKRU0fMZ0W2y+0tkJTOdv7lYX9XqXw
 7Pw487tHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiI9D+Gf5o9nI4NK7yXLVTa
 fmQLo2K/59RURseeN08+bVy5oEfvxhuG/5E2IpVf37O1V4YvvvtnpfA1uXMiYR25zy4KJCZJ7+q
 oYwcA
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

As we gain more tests, boilerplate to allocate an atomic state and free
it starts to be there more and more as well.

In order to reduce the allocation boilerplate, we can create a helper
to create that atomic state, and call an action when the test is done.
This will also clean up the exit path.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 39 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  5 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 5130d4553262..d3b2c6b48163 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -161,5 +162,43 @@ drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
 
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
+					(kunit_action_t *)drm_atomic_state_put,
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

