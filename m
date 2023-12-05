Return-Path: <linux-kselftest+bounces-1130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517EB804D1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE841F213E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B673D962;
	Tue,  5 Dec 2023 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0j+5ISS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844471401A
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 09:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727EFC433C8;
	Tue,  5 Dec 2023 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701767049;
	bh=iHNG95pabcCaKRGYTm2mMzTLBn46Au1mavLF0mz5hUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0j+5ISSZCCoWUik6DUCXFcK4Q6nsDLDsU9MIlEtmDnxBKtMvT8W1pd9Y380GY5BX
	 J9ojF/hTj1VarBxgUXB6Rq6qEuaLi6bWktQ5qrxu35zw5rlx8jxshWXsshZPswzxlA
	 sK+4wO0XVWBhjd9+HL/0zCukTi3x1vA5TG43qbRT5tsn5cvrrSrf49EuoZLiSNna+p
	 UcNMxeUtfr9RpZ7gW+1SKcTNL4M66+9bvJCfEGfgkEh3HIHXTMqReh5bPVVFTpgN0f
	 OyEt1tKLwEJBQmTdq7NotJVCXHyEKr3r+uYcyONL9y9h2v+waJz7/hDqmrpYXQ/9cH
	 fkFKWw+cZ8erQ==
From: Maxime Ripard <mripard@kernel.org>
To: davidgow@google.com,
	Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	David Airlie <airlied@linux.ie>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] drm/tests: Switch to kunit devices
Date: Tue,  5 Dec 2023 10:04:05 +0100
Message-ID: <20231205090405.153140-1-mripard@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kunit recently gained helpers to create test managed devices. This means
that we no longer have to roll our own helpers in KMS and we can reuse
them.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

David, feel free to integrate that patch into your series and merge it
whenever and wherever you see fit.
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 66 ++---------------------
 1 file changed, 3 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index c251e6b34de0..ca4f8e4c5d5d 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -5,6 +5,7 @@
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
 
+#include <kunit/device.h>
 #include <kunit/resource.h>
 
 #include <linux/device.h>
@@ -15,28 +16,6 @@
 static const struct drm_mode_config_funcs drm_mode_config_funcs = {
 };
 
-static int fake_probe(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static struct platform_driver fake_platform_driver = {
-	.probe	= fake_probe,
-	.driver = {
-		.name	= KUNIT_DEVICE_NAME,
-	},
-};
-
-KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_driver_unregister,
-			    platform_driver_unregister,
-			    struct platform_driver *);
-KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_put,
-			    platform_device_put,
-			    struct platform_device *);
-KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_del,
-			    platform_device_del,
-			    struct platform_device *);
-
 /**
  * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
  * @test: The test context object
@@ -54,34 +33,7 @@ KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_del,
  */
 struct device *drm_kunit_helper_alloc_device(struct kunit *test)
 {
-	struct platform_device *pdev;
-	int ret;
-
-	ret = platform_driver_register(&fake_platform_driver);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	ret = kunit_add_action_or_reset(test,
-					kunit_action_platform_driver_unregister,
-					&fake_platform_driver);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
-
-	ret = kunit_add_action_or_reset(test,
-					kunit_action_platform_device_put,
-					pdev);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	ret = platform_device_add(pdev);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	ret = kunit_add_action_or_reset(test,
-					kunit_action_platform_device_del,
-					pdev);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	return &pdev->dev;
+	return kunit_device_register(test, KUNIT_DEVICE_NAME);
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
 
@@ -94,19 +46,7 @@ EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
  */
 void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-
-	kunit_release_action(test,
-			     kunit_action_platform_device_del,
-			     pdev);
-
-	kunit_release_action(test,
-			     kunit_action_platform_device_put,
-			     pdev);
-
-	kunit_release_action(test,
-			     kunit_action_platform_driver_unregister,
-			     &fake_platform_driver);
+	kunit_device_unregister(test, dev);
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
 
-- 
2.43.0


