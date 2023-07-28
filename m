Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7676682C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjG1JGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjG1JG2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A943582;
        Fri, 28 Jul 2023 02:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E325862081;
        Fri, 28 Jul 2023 09:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0080BC433C8;
        Fri, 28 Jul 2023 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535184;
        bh=g19Qr7lTEX4DQpW0gKyuC8KKuGZXXC9l7fQhhK+dJSE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CEFjL9Sx7KXL8EOMQcOXjK4yr3X1qxzElzF8P4uksXp3+8MUkFd7QM63SW0KNshB/
         m7gnmqXLfNlJZFywCPGZpam1rw4l0RJuxim36RooRckxbCOEw9sagO8irzYnnlaAMp
         WZxp3PTYVG1l2IsOb1jgLdoEu+OFYB+B91c2mMAs5cEN8cYMV1A6lCgNfdO6T79GLC
         71j3bkf5xTdATo85I4CZhwPJbQFsa94KBFasLpfP7saMSomaUH9nZkKEN5Tq3e0eyv
         +FVr1az/HIC1vR57CQKMDWjdEpColFwVqhc9UdvYklCc1aso1xdBDsWR7/AiCuHVaO
         tOU73Z/hFWwAA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 28 Jul 2023 11:06:14 +0200
Subject: [PATCH v3 01/11] drm/tests: helpers: Switch to kunit actions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230728-kms-kunit-actions-rework-v3-1-952565ccccfe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=mripard@kernel.org;
 h=from:subject:message-id; bh=g19Qr7lTEX4DQpW0gKyuC8KKuGZXXC9l7fQhhK+dJSE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmHW7kcFk19LujtYX7eSdTX7/TqrR+97EXLLwSc2hr1S
 TRXj/NIRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACZSrs7IcHmx6o5blq+msj01
 ONnBYfAkyXbS2dgdaytVPfbu8ygzcWH4n1X35O6vUOGVjhvuhn6zk/qXqvn1R9CbnIk5K7KXWEy
 4xgcA
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

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 54 ++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 4df47071dc88..cdf35421e641 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -26,6 +26,28 @@ static struct platform_driver fake_platform_driver = {
 	},
 };
 
+static void kunit_action_platform_driver_unregister(void *ptr)
+{
+	struct platform_driver *drv = ptr;
+
+	platform_driver_unregister(drv);
+
+}
+
+static void kunit_action_platform_device_put(void *ptr)
+{
+	struct platform_device *pdev = ptr;
+
+	platform_device_put(pdev);
+}
+
+static void kunit_action_platform_device_del(void *ptr)
+{
+	struct platform_device *pdev = ptr;
+
+	platform_device_del(pdev);
+}
+
 /**
  * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
  * @test: The test context object
@@ -35,8 +57,8 @@ static struct platform_driver fake_platform_driver = {
  * able to leverage the usual infrastructure and most notably the
  * device-managed resources just like a "real" device.
  *
- * Callers need to make sure drm_kunit_helper_free_device() on the
- * device when done.
+ * Resources will be cleaned up automatically, but the removal can be
+ * forced using @drm_kunit_helper_free_device.
  *
  * Returns:
  * A pointer to the new device, or an ERR_PTR() otherwise.
@@ -49,12 +71,27 @@ struct device *drm_kunit_helper_alloc_device(struct kunit *test)
 	ret = platform_driver_register(&fake_platform_driver);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_platform_driver_unregister,
+					&fake_platform_driver);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
 
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_platform_device_put,
+					pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ret = platform_device_add(pdev);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
+	ret = kunit_add_action_or_reset(test,
+					kunit_action_platform_device_del,
+					pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	return &pdev->dev;
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
@@ -70,8 +107,17 @@ void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 
-	platform_device_unregister(pdev);
-	platform_driver_unregister(&fake_platform_driver);
+	kunit_release_action(test,
+			     kunit_action_platform_device_del,
+			     pdev);
+
+	kunit_release_action(test,
+			     kunit_action_platform_device_put,
+			     pdev);
+
+	kunit_release_action(test,
+			     kunit_action_platform_driver_unregister,
+			     pdev);
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
 

-- 
2.41.0

