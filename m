Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E263E617FFF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKCOvs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKCOvr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 10:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521E186FE;
        Thu,  3 Nov 2022 07:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FA361F0D;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B47C43144;
        Thu,  3 Nov 2022 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487103;
        bh=EgUfYi6omv+JphmdlMh1yMRQPC+NdgzKbGKf8IoKtB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPxuEoxlI5Qt+ee5xfr6mCmkZr3CA39FxBhKj0s86ZClDnS48ngdeW3WwzCaBJ/jt
         cDP4p9meb+b4Lo7nOaPtPYv05r8aIEi170TYkCKeu7ZLSFg7zcIFzJSOTKTNMiQEIa
         oO65nxc3qHmRXJHkoU8HpiO2w3vcOWG3RSnVelWtzAd5VZwdVTX4TMEt/w5ex2LmT7
         NLl9y49LnA1X0ZbWMHc3rPz5YiympCgVnPlMb1/G03M8gB/F9NhUgy/VQizmZ1xoRA
         BXhoyEEHnjNgRfvXeYHA6B/2PEUPKdn5Yu7HxfM7L7jJuQsugA2wCQDIFCzCPSKkNv
         vRPUGttR0RxeA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1oqbZE-0076b1-0G;
        Thu, 03 Nov 2022 14:51:40 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Isabella Basso" <isabbasso@riseup.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH RFC v2 4/8] drm/i915: add support to run KUnit tests on bare metal
Date:   Thu,  3 Nov 2022 14:51:34 +0000
Message-Id: <df4fd92968cb7442dd2778f1c6f3e69935c5796b.1667486144.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667486144.git.mchehab@kernel.org>
References: <cover.1667486144.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a logic to seek for PCI devices and to run tests on
them, if the tests are willing to run on physical hardware,
instead of using Qemu.

Later patches will add the KUnit tests. So, for now, mark
such functions with __maybe_unused, to avoid build issues
with WERROR.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RFC v2 0/8] at: https://lore.kernel.org/all/cover.1667486144.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/selftests/i915_kunit.c | 100 ++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/i915/selftests/i915_kunit.c b/drivers/gpu/drm/i915/selftests/i915_kunit.c
index 731b84a1fdc3..430610864f6e 100644
--- a/drivers/gpu/drm/i915/selftests/i915_kunit.c
+++ b/drivers/gpu/drm/i915/selftests/i915_kunit.c
@@ -8,9 +8,109 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/pci.h>
 #include <kunit/test.h>
+#include "i915_drv.h"
 #include "i915_selftest.h"
 
+#define MAX_PCI_BOARDS	8
+
+/*
+ * PCI selftest support
+ *
+ * It is possible to run tests that demands hardware in bare metal.
+ *
+ * Add a logic to detect and get PCI devices using i915 driver, up to
+ * MAX_PCI_BOARDS devices.
+ */
+
+static int n_boards;
+static struct pci_dev *dev_i915[MAX_PCI_BOARDS];
+static int __maybe_unused i915_pci_init_suite(struct kunit_suite *suite)
+{
+	struct pci_dev *pdev = NULL;
+	int i;
+
+	/* Check for PCI devices with i915 driver */
+	do {
+		/*
+		 * Let's search all devices at the PCI ID. We could, instead,
+		 * use include/drm/i915_pciids.h, but that would mean a much
+		 * more complex code, and won't still warrant that the device
+		 * was bound to i915 driver. So, let's check the driver's
+		 * name instead.
+		 */
+		pdev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pdev);
+		if (pdev) {
+			if (pdev->driver && !strcmp(pdev->driver->name, "i915")) {
+				pr_info("%s: it is a i915 device.\n",
+					pci_name(pdev));
+
+				for (i = 0; i < n_boards; i++) {
+					if (pdev == dev_i915[i]) {
+						pci_dev_put(pdev);
+						continue;
+					}
+				}
+				dev_i915[n_boards++] = pdev;
+				if (n_boards >= MAX_PCI_BOARDS)
+					break;
+			} else {
+				pci_dev_put(pdev);
+			}
+		}
+	} while (pdev);
+
+	return 0;
+}
+
+static void __maybe_unused i915_pci_exit_suite(struct kunit_suite *suite)
+{
+	int i;
+
+	for (i = 0; i < n_boards; i++)
+		pci_dev_put(dev_i915[i]);
+
+	n_boards = 0;
+}
+
+static void __maybe_unused run_pci_test(struct kunit *test,
+					int (*f)(struct drm_i915_private *i915))
+{
+	struct drm_i915_private *i915;
+	int i, ret, disable_display;
+
+	if (!n_boards)
+		kunit_skip(test, "runs only on i915 hardware\n");
+
+	for (i = 0; i < n_boards; i++) {
+		i915 = pdev_to_i915(dev_i915[i]);
+
+		cond_resched();
+		if (signal_pending(current))
+			return;
+
+		pr_info("Running %s on %s\n",
+			test->name, pci_name(dev_i915[i]));
+
+		/* FIXME: is it ok to disable_display here? */
+		disable_display = i915->params.disable_display;
+		i915->params.disable_display = 1;
+		ret = f(i915);
+		i915->params.disable_display = disable_display;
+
+		if (ret == -EINTR && !signal_pending(current))
+			ret = 0;
+
+		if (WARN(ret > 0 || ret == -ENOTTY,
+			"%s returned %d, conflicting with selftest's magic values!\n",
+			test->name, ret))
+			ret = -EINVAL;
+
+		KUNIT_EXPECT_EQ(test, ret, 0);
+	}
+}
+
 /*
  * Test run logic, similar to what i915 selftest does
  */
-- 
2.38.1

