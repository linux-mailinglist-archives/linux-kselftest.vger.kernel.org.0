Return-Path: <linux-kselftest+bounces-33375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D948ABD1DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5F81B679BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92965266B6A;
	Tue, 20 May 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnQDSbdo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62528266594;
	Tue, 20 May 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729527; cv=none; b=lWrLIKg3d11xgxkZFYEOCQyHJbBuaDix58tL127tX0YP1Q3PhySEMelO29Unn7caeUpDZfpAcveMQMZkN6ahUn32S+rw2us9aoTsfTsg9eG8Cvd0VcftaZFrTv3+79DAW6eCcZnhZh5AJvSkYKqmaFdB5JWcHqZYiCJdyK6c9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729527; c=relaxed/simple;
	bh=+6EIVL7ThX53vHz5L3JTUOBo0sIuRo6+hjEqxH0fBc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmHiWUN95zPn8NdDwszPQg4YI6ZNg7ulaTH5PtvvVWcK2WMxGwSszzJ0dqlf4olUn170PDchfyHKNpNsBgyHtob4Xwsx/sWxB/ozWsZ4dh+Ea51kwKgeN+y3RLtT3uaDwEWuA6jE3Nv38WwGWYeGWyZ17nWPdbF0gs8Gh7lZ2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnQDSbdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A898AC4CEF0;
	Tue, 20 May 2025 08:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729526;
	bh=+6EIVL7ThX53vHz5L3JTUOBo0sIuRo6+hjEqxH0fBc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnQDSbdozV4AvdMgXyfkOoq41Q5I5qRVREKTf4Q9I6Hwr4/RW5fKsDC4NoLquJXGx
	 qI+wgDxmLoe95stKSfr1OEgWVDRRILLjd/GanzdaFrqnfR7AsV6lAJ85dgjCsd6d/8
	 k/oa6mRol6vdGcA2CfFB6L/ihFqhIyJoRwFYJZQSnUJgcBzQA4+HI3SocOMUaetab0
	 +SuYejWOmillTMGk3OIgbbbNSxjETQe+pz4ckmqxaNECmz2ftKprczx/EA3wWj5XDU
	 7g9qqWZR5jRjfVokFDVUkB6XjOW7qaBti2tRirzkDRSR/eOHd9du/EKdjGIN0NNW3U
	 aDzj0tFVzLHtw==
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
Subject: [RFC PATCH 5/7] platform/chrome: kunit: cros_ec_spi: Call .probe() directly
Date: Tue, 20 May 2025 08:24:32 +0000
Message-ID: <20250520082435.2255639-6-tzungbi@kernel.org>
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

Get the spi_driver and call .probe() directly.

For running the tests:

$ ./tools/testing/kunit/kunit.py run \
	--arch=x86_64 \
	--kconfig_add CONFIG_FTRACE=y \
	--kconfig_add CONFIG_FUNCTION_TRACER=y \
	--kconfig_add CONFIG_MODULES=y \
	--kconfig_add CONFIG_DEBUG_KERNEL=y \
	--kconfig_add CONFIG_KALLSYMS_ALL=y \
	--kconfig_add CONFIG_LIVEPATCH=y \
	--kconfig_add CONFIG_KUNIT_FTRACE_STUBS=y \
	--kconfig_add CONFIG_CHROME_PLATFORMS=y \
	--kconfig_add CONFIG_CROS_EC=y \
	--kconfig_add CONFIG_SPI=y \
	--kconfig_add CONFIG_CROS_EC_SPI=y \
	--kconfig_add CONFIG_CROS_KUNIT_EC_SPI_TEST=y \
	cros_ec_spi*

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_ec_spi_test.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi_test.c b/drivers/platform/chrome/cros_ec_spi_test.c
index 2a021569a726..52dea75ecabf 100644
--- a/drivers/platform/chrome/cros_ec_spi_test.c
+++ b/drivers/platform/chrome/cros_ec_spi_test.c
@@ -27,6 +27,7 @@ struct cros_ec_spi_test_priv {
 	struct device dev;
 	struct spi_controller *fake_ctlr;
 	struct spi_device *fake_spi_device;
+	struct spi_driver *spi_drv;
 
 	int fake_cros_ec_register_called;
 	struct cros_ec_device *ec_dev;
@@ -117,16 +118,12 @@ static int find_target_driver(struct device_driver *drv, void *data)
 static int cros_ec_spi_test_init(struct kunit *test)
 {
 	struct cros_ec_spi_test_priv *priv;
-	struct spi_board_info board_info = {};
 	int ret;
 	struct device_driver *drv;
-	enum probe_type orig;
 
 	kunit_activate_ftrace_stub(test, cros_ec_register, fake_cros_ec_register);
 	kunit_activate_ftrace_stub(test, cros_ec_unregister, fake_cros_ec_unregister);
 
-	sized_strscpy(board_info.modalias, "cros-ec-spi", SPI_NAME_SIZE);
-
 	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 	test->priv = priv;
@@ -151,21 +148,17 @@ static int cros_ec_spi_test_init(struct kunit *test)
 	ret = spi_register_controller(priv->fake_ctlr);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	/*
-	 * Force to use synchronous probe so that the upcoming SPI device gets
-	 * probed correctly and synchronously.
-	 */
 	ret = bus_for_each_drv(&spi_bus_type, NULL, &drv, find_target_driver);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	KUNIT_ASSERT_NOT_NULL(test, drv);
-	orig = drv->probe_type;
-	drv->probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-	priv->fake_spi_device = spi_new_device(priv->fake_ctlr, &board_info);
-	/* Restore to original probe type. */
-	drv->probe_type = orig;
+	priv->fake_spi_device = spi_alloc_device(priv->fake_ctlr);
 	KUNIT_ASSERT_NOT_NULL(test, priv->fake_spi_device);
 
+	priv->spi_drv = container_of(drv, struct spi_driver, driver);
+	ret = priv->spi_drv->probe(priv->fake_spi_device);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_register_called, 1);
 	KUNIT_ASSERT_NOT_NULL(test, priv->ec_dev);
 	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 0);
@@ -180,9 +173,10 @@ static void cros_ec_spi_test_exit(struct kunit *test)
 {
 	struct cros_ec_spi_test_priv *priv = test->priv;
 
-	spi_unregister_device(priv->fake_spi_device);
+	priv->spi_drv->remove(priv->fake_spi_device);
 	KUNIT_EXPECT_EQ(test, priv->fake_cros_ec_unregister_called, 1);
 
+	spi_dev_put(priv->fake_spi_device);
 	spi_unregister_controller(priv->fake_ctlr);
 	device_del(&priv->dev);
 	class_destroy(priv->fake_class);
-- 
2.49.0.1101.gccaa498523-goog


