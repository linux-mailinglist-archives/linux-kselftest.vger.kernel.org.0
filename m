Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE96EF591
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjDZNfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjDZNfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 09:35:54 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9163599
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 06:35:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:d7c1:43a8:a4fb:24a3])
        by laurent.telenet-ops.be with bizsmtp
        id pRbp2900z1Gxb9y01RbpM7; Wed, 26 Apr 2023 15:35:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1prfJD-000W3A-CF;
        Wed, 26 Apr 2023 15:35:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1prfJF-0003Z4-Eq;
        Wed, 26 Apr 2023 15:35:49 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mark Brown <broonie@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] regmap: REGMAP_KUNIT must not select REGMAP
Date:   Wed, 26 Apr 2023 15:35:45 +0200
Message-Id: <b0a5dbb17c1d5ea482e052e585ae83bb69c48806.1682516005.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enabling a (modular) test must not silently enable additional kernel
functionality, as that may increase the attack vector of a product.

Fix this by:
  1. making REGMAP visible if CONFIG_KUNIT_ALL_TESTS is enabled,
  2. making REGMAP_KUNIT depend on REGMAP instead of selecting it.

After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
modules for all appropriate tests for ones system, without pulling in
extra unwanted functionality, while still allowing a tester to manually
enable REGMAP and its test suite on a system where REGMAP is not enabled
by default.

Fixes: 2238959b6ad27040 ("regmap: Add some basic kunit tests")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Make REGMAP visible if CONFIG_KUNIT_ALL_TESTS is enabled.
---
 drivers/base/regmap/Kconfig | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 33a8366e22a584a5..0db2021f7477f2ab 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,16 +4,23 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
+	bool "Register Map support" if KUNIT_ALL_TESTS
 	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM || REGMAP_MDIO || REGMAP_FSI)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	select MDIO_BUS if REGMAP_MDIO
-	bool
+	help
+	  Enable support for the Register Map (regmap) access API.
+
+	  Usually, this option is automatically selected when needed.
+	  However, you may want to enable it manually for running the regmap
+	  KUnit tests.
+
+	  If unsure, say N.
 
 config REGMAP_KUNIT
 	tristate "KUnit tests for regmap"
-	depends on KUNIT
+	depends on KUNIT && REGMAP
 	default KUNIT_ALL_TESTS
-	select REGMAP
 	select REGMAP_RAM
 
 config REGMAP_AC97
-- 
2.34.1

