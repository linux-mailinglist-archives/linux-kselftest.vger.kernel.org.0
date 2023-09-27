Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A37B052F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjI0NUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjI0NUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 09:20:18 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99315126
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 06:20:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:cafc:ec85:941b:7b06])
        by andre.telenet-ops.be with bizsmtp
        id r1LC2A00256e2kz011LCBm; Wed, 27 Sep 2023 15:20:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlUSB-004j32-EN;
        Wed, 27 Sep 2023 15:20:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qlUSZ-0011s7-Te;
        Wed, 27 Sep 2023 15:20:11 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drivers: base: test: Make property entry API test modular
Date:   Wed, 27 Sep 2023 15:20:10 +0200
Message-Id: <98388154383df9d4ced73946efd18318aeea50e2.1695820382.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no reason why the KUnit Tests for the property entry API can
only be built-in.  Add support for building these tests as a loadable
module, like is supported by most other tests.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/test/Kconfig               | 4 ++--
 drivers/base/test/property-entry-test.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 9d42051f8f8e715e..5c7fac80611ce8bc 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -14,6 +14,6 @@ config DM_KUNIT_TEST
 	depends on KUNIT
 
 config DRIVER_PE_KUNIT_TEST
-	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
-	depends on KUNIT=y
+	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
+	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index dd2b606d76a3f546..a8657eb06f94e934 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -506,3 +506,7 @@ static struct kunit_suite property_entry_test_suite = {
 };
 
 kunit_test_suite(property_entry_test_suite);
+
+MODULE_DESCRIPTION("Test module for the property entry API");
+MODULE_AUTHOR("Dmitry Torokhov <dtor@chromium.org>");
+MODULE_LICENSE("GPL");
-- 
2.34.1

