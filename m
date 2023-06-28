Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D8740DE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjF1Jwx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:52:53 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:36890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjF1JuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:50:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0EE6126D;
        Wed, 28 Jun 2023 09:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF13C433C0;
        Wed, 28 Jun 2023 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687945800;
        bh=wHy/4Bdn8bLqInIOtsbVUy9HeffaJhdQru3m0BWjVgw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BWkUgE7gZGIMcrVg4STv/B5lPWx6Q8LyAoYbws0CSfCsql+bBDYdawWGK2XhmpBeC
         3NvH9Qv74cYPjC+asPQ3krfts5qn3C7LZYVRGVdHGFaGO7GdSQmH+hfhKB56A3qgD4
         rRd/g93Rxsf5ti8lgPiq9rjcuAtigVVAqhyrlKKEcf0T7e2F743EjQwGeo+bPkXkPY
         n2tEOow3lYJ/Tr3Tgu68XW+2U48h6bpvpjGQUwRX+yOVSS3c8yAM8jlgvUV2Czauhv
         C6o8lclOBYraXDRZR45mVnE2yiHbIPq7H1HzStHYeG5v/6wDIwbVa1imO/tNyHZj0v
         6GKfP/FzqBL8w==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 28 Jun 2023 11:49:23 +0200
Subject: [PATCH v2 3/3] drivers: base: Free devm resources when
 unregistering a device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-kunit-devm-inconsistencies-test-v2-3-19feb71e864b@kernel.org>
References: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kkD1/1T/bjGcKyT9fGwaBiGFMGIVAdeHxZ21NAuyjKQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClzmDQeKW9juC9gfatjn+zP1Tc23Pvrmamu8vlh4Z0Fz
 0MeOSxL6ShlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEHjUzMnQyzcqpElvTKrI5
 b+bcuqw+yyvfLRbvNI6x/MYZ685Xu4aR4b5PXZ3fitalx1w82WN83qfUTXv818QscdauFV7nTaf
 N5gQA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Gow <davidgow@google.com>

In the current code, devres_release_all() only gets called if the device
has a bus and has been probed.

This leads to issues when using bus-less or driver-less devices where
the device might never get freed if a managed resource holds a reference
to the device. This is happening in the DRM framework for example.

We should thus call devres_release_all() in the device_del() function to
make sure that the device-managed actions are properly executed when the
device is unregistered, even if it has neither a bus nor a driver.

This is effectively the same change than commit 2f8d16a996da ("devres:
release resources on device_del()") that got reverted by commit
a525a3ddeaca ("driver core: free devres in device_release") over
use-after-free concerns.

It's not clear whether those concerns are legitimate though, but I would
expect drivers not to register new resources in their device-managed
actions.

Fixes: a525a3ddeaca ("driver core: free devres in device_release")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/base/core.c                      | 11 +++++++++++
 drivers/base/test/platform-device-test.c |  2 --
 drivers/base/test/root-device-test.c     |  2 --
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..6ceaf50f5a67 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3817,6 +3817,17 @@ void device_del(struct device *dev)
 	device_platform_notify_remove(dev);
 	device_links_purge(dev);
 
+	/*
+	 * If a device does not have a driver attached, we need to clean
+	 * up any managed resources. We do this in device_release(), but
+	 * it's never called (and we leak the device) if a managed
+	 * resource holds a reference to the device. So release all
+	 * managed resources here, like we do in driver_detach(). We
+	 * still need to do so again in device_release() in case someone
+	 * adds a new resource after this point, though.
+	 */
+	devres_release_all(dev);
+
 	bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index b6ebf1dcdffb..1ae5ce8bd366 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -87,8 +87,6 @@ static void platform_device_devm_register_get_unregister_with_devm_test(struct k
 	struct test_priv *priv = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
 
diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
index 9a3e6cccae13..780d07455f57 100644
--- a/drivers/base/test/root-device-test.c
+++ b/drivers/base/test/root-device-test.c
@@ -78,8 +78,6 @@ static void root_device_devm_register_get_unregister_with_devm_test(struct kunit
 	struct test_priv *priv = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	priv->dev = root_device_register(DEVICE_NAME);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
 

-- 
2.40.0

