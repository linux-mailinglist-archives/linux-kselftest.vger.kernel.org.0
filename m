Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A26EF3E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbjDZMBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbjDZMBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 08:01:11 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CC4C3F
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 05:01:10 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by michel.telenet-ops.be with bizsmtp
        id pQ18290091C8whw06Q18Q8; Wed, 26 Apr 2023 14:01:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1prdlL-000VzI-W4;
        Wed, 26 Apr 2023 13:56:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1prdlO-0001kr-2K;
        Wed, 26 Apr 2023 13:56:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mark Brown <broonie@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] regmap: REGMAP_KUNIT must not select REGMAP
Date:   Wed, 26 Apr 2023 13:56:44 +0200
Message-Id: <a89cb0eae953f534011d3a655fa70feb01fb2b73.1682510075.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enabling a (modular) test must not silently enable additional kernel
functionality, as that may increase the attack vector of a product.

Fix this by making REGMAP_KUNIT depend on REGMAP instead.

Fixes: 2238959b6ad27040 ("regmap: Add some basic kunit tests")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/base/regmap/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 33a8366e22a584a5..20327c15cbce5d8c 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -11,9 +11,8 @@ config REGMAP
 
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

