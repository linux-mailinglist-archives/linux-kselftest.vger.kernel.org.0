Return-Path: <linux-kselftest+bounces-1903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65164812ABB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 09:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190001F211DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA824218;
	Thu, 14 Dec 2023 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTn6W0H2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30A116
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbcc50d7dd3so2360498276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543798; x=1703148598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OlTPqlli2uCG1E/b+wjlxbRhYFvKODMjutJLmsxab0=;
        b=bTn6W0H2un/UrpbYru9M2NKox2ChTjwRO0EtM78EaaKaJm6EIOM1H/kueNK2ApH0Dn
         ET8BHm4hdPyim67TZ08fFqna4qZOA67ILFetdp1Qnp605MnLLg0Dz0fuTHhzOkoEFddy
         ktGbX53nlxc5RFUcmS2NtRsyJpa4eZXTuvDXdbU+xapYrwIXjpq1dgksborzldLqojyX
         /1viJoOJ2boCzdi/+B0Cdrgha/YFj8aGtmjH+5t3VrLbcnb06kYjp2J39hMKDtSYjgtK
         ATGfEOn1IrHjopKjhPcojcBc8NUxIWan2xkqxZKEoJBaZaG12iyScJLNDL5J6oY2K+8h
         cRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543798; x=1703148598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OlTPqlli2uCG1E/b+wjlxbRhYFvKODMjutJLmsxab0=;
        b=KJkA9kV5Yg/k8J/nwyn2pg+wp1PuxWLhx4yQhHbFUsp8uwKeOWuORQuu4796UE1+Aw
         +EXZmgCAXYypz6/kSa/ZOmufzGrt7blmxTHHn6u4rEsb7cBCd9VDk1kW+y53cMf/0OQm
         6mt8CXYwoLqB+ByFx2W+0QsW6xR3GZfNtwL37otZ9r2AhWo3lPQrH6anVbR2rPwB87yP
         Arih/maVaumoVsPpn4rBs3lbC/muoAphXdgt97rWj+r5jz8BA11HDi6OxTSGmhF7NpiW
         gkMKW83/GGUGhaVQLgsuTvswsUmlE9KSgtpO72xi9hxmqxQed6hkmdB8Ekkw3p7huMYA
         xJlA==
X-Gm-Message-State: AOJu0Yz2zGpOzo7E39R8Xljrgj1Jf5LdGr9Uguv/Z/WgrEFsyXlV2eJt
	ts7qTw+6zj+v/17lhwPbjM+X+mPeLy2K8Q==
X-Google-Smtp-Source: AGHT+IGYd0L9Vo9z0N0bobAOarR+ihwNX6w+y9dOu6AojB77ZT83Z/Ze6xJ9GB5zhfbg6h+PwG9Dnayik/tziw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:3103:0:b0:dbc:cf6d:9a50 with SMTP id
 x3-20020a253103000000b00dbccf6d9a50mr41005ybx.10.1702543798003; Thu, 14 Dec
 2023 00:49:58 -0800 (PST)
Date: Thu, 14 Dec 2023 16:49:19 +0800
In-Reply-To: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-5-7e9a287d3048@google.com>
Subject: [PATCH v3 5/5] drm/tests: Switch to kunit devices
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Maxime Ripard <mripard@kernel.org>

Kunit recently gained helpers to create test managed devices. This means
that we no longer have to roll our own helpers in KMS and we can reuse
them.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 66 ++-----------------------------
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
2.43.0.472.g3155946c3a-goog


