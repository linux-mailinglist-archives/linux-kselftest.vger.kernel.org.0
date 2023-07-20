Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF975AEB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 14:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGTMpt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGTMpf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 08:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B726A5;
        Thu, 20 Jul 2023 05:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A8061A3D;
        Thu, 20 Jul 2023 12:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BFC433C7;
        Thu, 20 Jul 2023 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689857124;
        bh=/t17Dw8Ji4dvYfH3v5c7ic+nA+UyzWEDYc0SP3u2a0E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ati3GUNIpz+rGEpQ502H4eeDTtqI8lLdRbIv4/5aYKCZRupFSRUez0RG6V7W9MJaG
         SILac4zUP+3cEN+9nqYlVrtMDg1xgRbYSfA5U6UvUnvTREfn9jawn1cC1m9lA4m30y
         pE6Z2Cg6i7JoN4v5pLFN3Qcc/38UbX4856fsNjmoSm4BWBTPVHloBpO+r7rEks5HaP
         cxrgwMi0gxIFc2is8wC0tVbMar3QEm0oP4M6+iBwg4LoR9jvCbVJOs6ZD8omTjYYIW
         hTeXlTg9pw4ktrcsdwG0kx2PLM4j2nRlESsELL5e6kp4mn5tv2TaO71bfJkV4+g4vw
         Flpdc3feFmcbA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 20 Jul 2023 14:45:09 +0200
Subject: [PATCH v3 3/3] drivers: base: Free devm resources when
 unregistering a device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-kunit-devm-inconsistencies-test-v3-3-6aa7e074f373@kernel.org>
References: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
In-Reply-To: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dK5NenGOGX4zkAO7TDHxkXUxqTtkK1TPL9bi3DSmzKI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7dSK10souHee+q/LaRWFGoYlAl3evuuubNG63G+yyl
 +4Yhyp0lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCIydxkZzky9WXDY9Oq8kFeH
 TDOuP65/bx3Oe6rEPVE9anmxxpLIjYwM557FzFxhKhxkzbP8Mf99YauS2ttWnRzFrr8rNmv7HHj
 MDgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
memory leaks concerns.

This patch effectively combines the two commits mentioned above to
release the resources both on device_del() and device_release() and get
the best of both worlds.

Fixes: a525a3ddeaca ("driver core: free devres in device_release")
Signed-off-by: David Gow <davidgow@google.com>
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
2.41.0

