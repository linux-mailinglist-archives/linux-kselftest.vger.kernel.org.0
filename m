Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24321552D8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347547AbiFUIyg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 04:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347062AbiFUIyU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 04:54:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53B26578
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:54:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3175eae9b09so113594277b3.23
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sMhw4RZ/mWWPPEUWkgHgKXiigOXLUScNjtTFmn2v0ww=;
        b=WYhhSDqtQLk2QwIQ9Mr+OfByWeTNLN8sNc4QhSP14iedILM5LNdrlTY82CM6VPKQCE
         By6Ua1qc4cn6zsrHKakHGav00eshow0V3SRetAmA0xPNxDAyQihPZF7xBJ0KTM/lOqVD
         yAhIvn2GX/NfazxHfKC654SnUE7VoOHGZr3pWPPebIBxIOX2UvpIL4VDNO0I6QH/j5Gz
         YqGIfw9M0roZ/xk2YYqZrsC8UH2LzF0G9fjmQredjggrZW8PNMWTCbL06TbFWUJ7e2/x
         7HjOI5S5pt2/z0kYY9bCfy6eQ49h/EoCWOj36bKQ3He5JQvrn3N7cPPpRMn1UzZH9WZI
         RVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sMhw4RZ/mWWPPEUWkgHgKXiigOXLUScNjtTFmn2v0ww=;
        b=4wWpxisyM8r7J+4U0sgNYj9GoalX/9j/dr3/s5eik07RdyNVPcvE5qW8R/VYIvMJhx
         SL9yqDY390oge9QtaIx6RFx14Jp2X5rg2PfrbAuryq7cbeunC7YVsgc2ZD4QLEI36TzF
         X2rQz+W4oBVSMZ6MzDg3mpZjEzRMYa1n4caLeh0ilnGFPVDRA1HIO7eF3OG2kIVcs/B8
         bvjByiW81FNsR0t+VSs0hbHSQbfCYKanQfOZhiB1Zm3Qzo4i6r/pqN/J4uYlGg+OYBw/
         JXwaPGRgNRF+qiilP21GYswcBej8OxmKKI9Fu4UBJETrQ8HMoxbMXO7TrXaELrF4V5ZV
         dCzg==
X-Gm-Message-State: AJIora9HQg7zx9wcWk3cvkeoXtSPRIc8pC5pe2XKjiqaXAJvV+pFeaVx
        jGaWfcBE5FLuM3d1nHeAzkZe1lHWV+bHmA==
X-Google-Smtp-Source: AGRyM1vieUr2pRKhrhNOp1dFpCWfaNn7lwjXBL4J8TaauocML9PYRPmYH8ZaoDHS6H8PaqQG31H3ZdL9MJQ6hg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:f045:0:b0:317:e6b2:2c64 with SMTP id
 z66-20020a0df045000000b00317e6b22c64mr7404945ywe.350.1655801655027; Tue, 21
 Jun 2022 01:54:15 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:53:45 +0800
In-Reply-To: <20220621085345.603820-1-davidgow@google.com>
Message-Id: <20220621085345.603820-6-davidgow@google.com>
Mime-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2 5/5] mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     Paraschiv@google.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit_test_suite() macro is no-longer incompatible with module_add,
so its use can be reinstated.

Since this fixes parsing with builtins and kunit_tool, also enable the
test by default when KUNIT_ALL_TESTS is enabled.

The test can now be run via kunit_tool with:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_OF=y --kconfig_add CONFIG_OF_ADDRESS=y \
	--kconfig_add CONFIG_MMC=y --kconfig_add CONFIG_MMC_SDHCI=y \
	--kconfig_add CONFIG_MMC_SDHCI_PLTFM=y \
	--kconfig_add CONFIG_MMC_SDHCI_OF_ASPEED=y \
	'sdhci-of-aspeed'

(It may be worth adding a .kunitconfig at some point, as there are
enough dependencies to make that command scarily long.)

Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-6-davidgow@google.com/

---
 drivers/mmc/host/Kconfig                |  5 +++--
 drivers/mmc/host/sdhci-of-aspeed-test.c |  8 +-------
 drivers/mmc/host/sdhci-of-aspeed.c      | 27 -------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d6144978e32d..10c563999d3d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -169,8 +169,9 @@ config MMC_SDHCI_OF_ASPEED
 	  If unsure, say N.
 
 config MMC_SDHCI_OF_ASPEED_TEST
-	bool "Tests for the ASPEED SDHCI driver"
-	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
+	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
+	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
 	  option only if you will boot the kernel for the purpose of running
diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
index 1ed4f86291f2..ecb502606c53 100644
--- a/drivers/mmc/host/sdhci-of-aspeed-test.c
+++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
@@ -96,10 +96,4 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
 	.test_cases = aspeed_sdhci_test_cases,
 };
 
-static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
-	&aspeed_sdhci_test_suite,
-	NULL,
-};
-
-static struct kunit_suite **aspeed_sdc_test_suites
-	__used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
+kunit_test_suite(aspeed_sdhci_test_suite);
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..c10367946bc7 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -606,25 +606,6 @@ static struct platform_driver aspeed_sdc_driver = {
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
 #include "sdhci-of-aspeed-test.c"
-
-static inline int aspeed_sdc_tests_init(void)
-{
-	return __kunit_test_suites_init(aspeed_sdc_test_suites);
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-	__kunit_test_suites_exit(aspeed_sdc_test_suites);
-}
-#else
-static inline int aspeed_sdc_tests_init(void)
-{
-	return 0;
-}
-
-static inline void aspeed_sdc_tests_exit(void)
-{
-}
 #endif
 
 static int __init aspeed_sdc_init(void)
@@ -639,12 +620,6 @@ static int __init aspeed_sdc_init(void)
 	if (rc < 0)
 		goto cleanup_sdhci;
 
-	rc = aspeed_sdc_tests_init();
-	if (rc < 0) {
-		platform_driver_unregister(&aspeed_sdc_driver);
-		goto cleanup_sdhci;
-	}
-
 	return 0;
 
 cleanup_sdhci:
@@ -656,8 +631,6 @@ module_init(aspeed_sdc_init);
 
 static void __exit aspeed_sdc_exit(void)
 {
-	aspeed_sdc_tests_exit();
-
 	platform_driver_unregister(&aspeed_sdc_driver);
 	platform_driver_unregister(&aspeed_sdhci_driver);
 }
-- 
2.37.0.rc0.104.g0611611a94-goog

