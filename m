Return-Path: <linux-kselftest+bounces-33373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DDABD1D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E244A2CF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E904265CA6;
	Tue, 20 May 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK2kBCzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD326560B;
	Tue, 20 May 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729522; cv=none; b=cpSedkCAqXRXPAegFq55qaSyT9UjPRlL/Qyw/0I7K3bROZk1TTZD3u9r+eOckw29u7acTG38wAIu2M4Jd32pwXbnFLysHS+EvrHliu0XDQzFDkdKR15Y7OgVo2O6EH+Jjbw2zBLYg5M+ti/ZOb2uQNKLitweCGCMqomTCAbtIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729522; c=relaxed/simple;
	bh=Kdt2GQcqm/bi8fPVEBnTYb5UzxELQd2ak+jgUFrgci4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfVbl4lmYrXbTnsII+j2SPHvfx8KIZKo9ysKW/eP0HmA1cyfc5A5vj567g+WExlyH2T4XZ6mzpswSZYatCUJaGYpC5zg+NHpgSU6G5MWA9Tpjwz2y2gcWoIJC0ubDOpQ4i5tpVBqi5VLivs2R+7wwz5I96m+N0em6sAwFrBrtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK2kBCzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9589BC4CEE9;
	Tue, 20 May 2025 08:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729521;
	bh=Kdt2GQcqm/bi8fPVEBnTYb5UzxELQd2ak+jgUFrgci4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bK2kBCzqWtLk+BlQ1GzdSc4V/kPSbnmNN9WWBJkghfu/t+l6RQN5rSe2z7V1F78OX
	 IEdlWzGHEVa5tAxd/rX58cHI7em6IrWAixiysvFdRdg1uEWNCse7YRWSa+BwBcAIf9
	 ZTGZfyER8hK19Y8ve9IAQEhVCgs0drEQHLlOEXHGV7zI7pAJi+nv/Cibf4if3KOXdi
	 2c75BKeO+45CuxhlMkBKWwQzJJc4CXvmFOc1sXEBBENR97//Jke4YaU+6kF21U4Bin
	 q3WfXFh6/8/ZetL0lq/5bWKIr0Gszr5/g7dkS++eMySSmMz2RjxxlOi/3YpvhGqDyc
	 ftSIWDyVOk7RQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org,
	brendan.higgins@linux.dev,
	davidgow@google.com
Cc: tzungbi@kernel.org,
	rmoar@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] platform/chrome: kunit: cros_ec_i2c: Use static stub instead
Date: Tue, 20 May 2025 08:24:30 +0000
Message-ID: <20250520082435.2255639-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
References: <20250520082435.2255639-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For running the tests:

$ ./tools/testing/kunit/kunit.py run \
        --arch=x86_64 \
        --kconfig_add CONFIG_CHROME_PLATFORMS=y \
        --kconfig_add CONFIG_CROS_EC=y \
        --kconfig_add CONFIG_I2C=y \
        --kconfig_add CONFIG_CROS_EC_I2C=y \
        --kconfig_add CONFIG_CROS_KUNIT_EC_I2C_TEST=y \
        cros_ec_i2c*

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig            |  1 -
 drivers/platform/chrome/cros_ec.c          |  6 ++++++
 drivers/platform/chrome/cros_ec_i2c_test.c | 10 +++++-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 5e0b44fb7ca7..bf10c0625be8 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -331,7 +331,6 @@ config CROS_KUNIT_EC_I2C_TEST
 	tristate "Kunit tests for ChromeOS EC over I2C" if !KUNIT_ALL_TESTS
 	depends on KUNIT && CROS_EC
 	default KUNIT_ALL_TESTS
-	depends on KUNIT_FTRACE_STUBS
 	depends on CROS_EC_I2C
 	help
 	  Kunit tests for ChromeOS EC over I2C.
diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 110771a8645e..62327fa0ff34 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -18,6 +18,8 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
+#include <kunit/static_stub.h>
+
 #include "cros_ec.h"
 
 static struct cros_ec_platform ec_p = {
@@ -179,6 +181,8 @@ static int cros_ec_ready_event(struct notifier_block *nb,
  */
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
+	KUNIT_STATIC_STUB_REDIRECT(cros_ec_register, ec_dev);
+
 	struct device *dev = ec_dev->dev;
 	int err = 0;
 
@@ -318,6 +322,8 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	KUNIT_STATIC_STUB_REDIRECT(cros_ec_unregister, ec_dev);
+
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
diff --git a/drivers/platform/chrome/cros_ec_i2c_test.c b/drivers/platform/chrome/cros_ec_i2c_test.c
index 3a7f1a17d82d..5d41cdeec4b7 100644
--- a/drivers/platform/chrome/cros_ec_i2c_test.c
+++ b/drivers/platform/chrome/cros_ec_i2c_test.c
@@ -3,7 +3,7 @@
  * Kunit tests for ChromeOS Embedded Controller I2C interface.
  */
 #include <kunit/test.h>
-#include <kunit/ftrace_stub.h>
+#include <kunit/static_stub.h>
 
 #include <linux/i2c.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -106,8 +106,8 @@ static int cros_ec_i2c_test_init(struct kunit *test)
 		I2C_BOARD_INFO("cros-ec-i2c", I2C_ADDR),
 	};
 
-	kunit_activate_ftrace_stub(test, cros_ec_register, fake_cros_ec_register);
-	kunit_activate_ftrace_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
+	kunit_activate_static_stub(test, cros_ec_register, fake_cros_ec_register);
+	kunit_activate_static_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
 
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -142,8 +142,8 @@ static void cros_ec_i2c_test_exit(struct kunit *test)
 
 	i2c_del_adapter(priv->fake_adap);
 
-	kunit_deactivate_ftrace_stub(test, cros_ec_register);
-	kunit_deactivate_ftrace_stub(test, cros_ec_unregister);
+	kunit_deactivate_static_stub(test, cros_ec_register);
+	kunit_deactivate_static_stub(test, cros_ec_unregister);
 }
 
 static int cros_ec_i2c_test_cmd_xfer_init(struct kunit *test)
-- 
2.49.0.1101.gccaa498523-goog


