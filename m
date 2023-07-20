Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F975ACC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGTLQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGTLQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D152706;
        Thu, 20 Jul 2023 04:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C43C61A33;
        Thu, 20 Jul 2023 11:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67340C433C8;
        Thu, 20 Jul 2023 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689851769;
        bh=CXPsdCVxz77cgfDGMI4BSalP4ePPYu8Tjf40VvpURr4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=peC6XHDlEo9ViqK8GjRcdygHlyFRs4WTMcmRssoW59KEKeh3xvg9kpYr+4c/3R7Wq
         d6VUIrqPvsBxv6MWCQ5huSN+Nm/oOFrtPjBeL8gJa5oeL8o4dpLIRv9w89rkWloDuu
         aWaEQJgNtCOvyv0ELmmuFoy3xKTS1uxGQyvCd6lTaFFIQoyFgu8mwaB4u0g6uJyHV5
         A4ET8iadCrvlGJ2doFhrrWS1SeVwHIEknYq1+VDbRysTskWEB12h1ho0qMIOZ6anUk
         7tGJfrB6SdjO3/PE+RR6eh17XxtlvOFBzLRNXtfKPPdOA5/gY7EW1TfVWjHUPfecgF
         kHeyl98s0yTnQ==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 13:15:50 +0200
Subject: [PATCH v2 05/11] drm/tests: helpers: Create a helper to allocate a
 locking ctx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kms-kunit-actions-rework-v2-5-175017bd56ab@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CXPsdCVxz77cgfDGMI4BSalP4ePPYu8Tjf40VvpURr4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7xTOKj0Vt+pHu+uzCVas+w/2m0qWbm/zXOqXZ+9/5s
 WffA9XVHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZgIz39Ghom3ShRDzrhZBcdO
 va37oeD4z0v8+153n3Xb6rP+bXcN90ZGhrcd5V85I9QfbDk3gYlrVqGr4CWpsC/SnrUuJ9q4Vx5
 7zQkA
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

As we get more and more tests, the locking context initialisation
creates more and more boilerplate, both at creation and destruction.

Let's create a helper that will allocate, initialise a context, and
register kunit actions to clean up once the test is done.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 41 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 5856beb7f7d7..5130d4553262 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -120,5 +120,46 @@ __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(__drm_kunit_helper_alloc_drm_device_with_driver);
 
+static void action_drm_release_context(void *ptr)
+{
+	struct drm_modeset_acquire_ctx *ctx = ptr;
+
+	drm_modeset_drop_locks(ctx);
+	drm_modeset_acquire_fini(ctx);
+}
+
+/**
+ * drm_kunit_helper_context_alloc - Allocates an acquire context
+ * @test: The test context object
+ *
+ * Allocates and initializes a modeset acquire context.
+ *
+ * The context is tied to the kunit test context, so we must not call
+ * drm_modeset_acquire_fini() on it, it will be done so automatically.
+ *
+ * Returns:
+ * An ERR_PTR on error, a pointer to the newly allocated context otherwise
+ */
+struct drm_modeset_acquire_ctx *
+drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	drm_modeset_acquire_init(ctx, 0);
+
+	ret = kunit_add_action_or_reset(test,
+					action_drm_release_context,
+					ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ed013fdcc1ff..4ba5e10653c6 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -87,5 +87,7 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 						      sizeof(_type),		\
 						      offsetof(_type, _member),	\
 						      _feat))
+struct drm_modeset_acquire_ctx *
+drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
 
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.41.0

