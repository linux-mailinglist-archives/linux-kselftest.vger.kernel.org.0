Return-Path: <linux-kselftest+bounces-33377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D186ABD1E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9094A3811
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C96267712;
	Tue, 20 May 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbZuTXHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501C267702;
	Tue, 20 May 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729532; cv=none; b=Yr4rzQkST8BQ6a+CUQ3dm+WEpQ+oTE1QGajbU54U3r/DQ2e/2yuEs2Wb+w63jdDhZHT+QKJk/h1FYzp2c3HZCTYuNbH+rVXd0sZzP7kwaLeZv83Z8/x4PSS3mGkvGJsVRFwsSawI5r0cp53+eZChhakhLWypGBSrEfpScrw4otY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729532; c=relaxed/simple;
	bh=nBLwYdLCrdKN8wRv7ArzFbqRn5yd+GRLAnV4S2iIl/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjIjtGyYUPStqASVCYfN586idW8nywvrux9C2yrm9vwo2ypwFinLd7YhYnIRASWhFQLRYD5Px1m+M97UjBccEN4jBlSACns42/n7V+4j7A2VpmQnD820ryWBCIUk4clyqLtZUlYulmkPD4z6TcLWIPKmyLKu6UqcI8rExxr8jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbZuTXHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC02FC4CEF0;
	Tue, 20 May 2025 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729531;
	bh=nBLwYdLCrdKN8wRv7ArzFbqRn5yd+GRLAnV4S2iIl/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbZuTXHPjSMU8w6PSVIPcLhHf3wW8xc3x6FhbA9MDjKaVOBpg/qasfeExFkxPaz78
	 XxUo0xIt3rJd+gvg4sH91FqOqjMqlDalB0O/oL+bwmS0242Izjxe0zS5jkTVjBw12l
	 VlL5Ad4N4ujQhOCExsEpuXTAtep7YkVg1C5SeViXPaOvUV4DWo+j9/XpW8xK6+M1pD
	 elAD7VWTGl/xt5nGn+y9OoeFxLqDIuzpP29WFZbFjkolvbyNlvIE/MRMT9gUumcb1q
	 Y5/fkQqgRTl1kMoghMKY8A3z1sdL/LvMexP1wjKJxD9ys6k1or6wrnGPUSz61b0qID
	 9kjWbIDCuDuTQ==
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
Subject: [RFC PATCH 7/7] platform/chrome: kunit: cros_ec_spi: Use kprobes stub instead
Date: Tue, 20 May 2025 08:24:34 +0000
Message-ID: <20250520082435.2255639-8-tzungbi@kernel.org>
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
	--kconfig_add CONFIG_KPROBES=y \
	--kconfig_add CONFIG_KUNIT_KPROBES_STUBS=y \
	--kconfig_add CONFIG_CHROME_PLATFORMS=y \
	--kconfig_add CONFIG_CROS_EC=y \
	--kconfig_add CONFIG_SPI=y \
	--kconfig_add CONFIG_CROS_EC_SPI=y \
	--kconfig_add CONFIG_CROS_KUNIT_EC_SPI_TEST=y \
	cros_ec_spi*

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig            |  2 +-
 drivers/platform/chrome/cros_ec_spi_test.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index aa13e871a31f..aacce3323384 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -339,7 +339,7 @@ config CROS_KUNIT_EC_SPI_TEST
 	tristate "Kunit tests for ChromeOS EC over SPI" if !KUNIT_ALL_TESTS
 	depends on KUNIT && CROS_EC
 	default KUNIT_ALL_TESTS
-	depends on KUNIT_FTRACE_STUBS
+	depends on KUNIT_KPROBES_STUBS
 	depends on CROS_EC_SPI
 	help
 	  Kunit tests for ChromeOS EC over SPI.
diff --git a/drivers/platform/chrome/cros_ec_spi_test.c b/drivers/platform/chrome/cros_ec_spi_test.c
index 52dea75ecabf..74fcbd37b87b 100644
--- a/drivers/platform/chrome/cros_ec_spi_test.c
+++ b/drivers/platform/chrome/cros_ec_spi_test.c
@@ -3,7 +3,7 @@
  * Kunit tests for ChromeOS Embedded Controller SPI interface.
  */
 #include <kunit/test.h>
-#include <kunit/ftrace_stub.h>
+#include <kunit/kprobes_stub.h>
 
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -121,8 +121,8 @@ static int cros_ec_spi_test_init(struct kunit *test)
 	int ret;
 	struct device_driver *drv;
 
-	kunit_activate_ftrace_stub(test, cros_ec_register, fake_cros_ec_register);
-	kunit_activate_ftrace_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
+	kunit_activate_kprobes_stub(test, cros_ec_register, fake_cros_ec_register);
+	kunit_activate_kprobes_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
 
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -181,8 +181,8 @@ static void cros_ec_spi_test_exit(struct kunit *test)
 	device_del(&priv->dev);
 	class_destroy(priv->fake_class);
 
-	kunit_deactivate_ftrace_stub(test, cros_ec_register);
-	kunit_deactivate_ftrace_stub(test, cros_ec_unregister);
+	kunit_deactivate_kprobes_stub(test, cros_ec_register);
+	kunit_deactivate_kprobes_stub(test, cros_ec_unregister);
 }
 
 static int cros_ec_spi_test_cmd_xfer_init(struct kunit *test)
-- 
2.49.0.1101.gccaa498523-goog


