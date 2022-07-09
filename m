Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4456C648
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGIDU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 23:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGIDUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 23:20:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6CB820DC
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 20:20:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so362803ybq.7
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lx/BiL2O9zbe0le6J+dFZQuPgX8f+rnEW9RXPsfjH4c=;
        b=Rt56sVzazgxUE4QrMIanz54Ve8L3LbCLYF38E3qyJV7pg0PipkP6/hyHSXjMdt8V/C
         KG7Lp6VXMHkHZ4JXXR5suNFExjbLppwBmpYv7ze8XIufUdxa34t7RN9HLUr88AB7055J
         jr3FJ39Llf9M1cc4Qg7XRtfvmKRG9s7EHlf6E/h3qUJ/8un4hheMEwtnRbVcAvx6I2/J
         RSP9of124wzIWrBXEcU7KoVpWWj3wMhPJhJooAIAi5EzKFcUKKg1y2iNx0dCBvRxKDZ0
         GCJi0noM4NRw205GVev6FR9YIprIkX1RyjIWpGRw3DUQIE8LVCUmfINHIAwHRBaO2YmQ
         8lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lx/BiL2O9zbe0le6J+dFZQuPgX8f+rnEW9RXPsfjH4c=;
        b=6ZhEkN9cAFtRwy3E55KDM6gHZ9vUkdjWoPs1RuVczh1HP00qHm10CJsbc+w3e9uhN8
         Wc55l/mkDjLYGsJLbF3zvDQLmVGwWIrLFmnWa6oH/MoGfxLu1aBg4ZFOruQSceHZjqgI
         ZleH6OvP2nEUwyg8gAtmWKmfV9KIuAswYehCIZi9tPRD3t6sRtv+7IQUy4X45zbtGc2v
         WiFKF16VtWp6KG8mxvjRP3NgspnKgTUoYCGO9ZW/tpH1ItCNuliWrDJOq+s1y5LdqM45
         QPx0oJogvfI7PVTknUPmJZu28yRp1PtJlER/JwdQ4Gw+GO46UFM5O0BBtiz/6mSeol+2
         2ELw==
X-Gm-Message-State: AJIora+cf6x2oM4z9a/+lS7SuuzvxitLHVmaJDSXw7gr4O4nwmTFHLSW
        sly+/duC8EoA67/1pOuQJODwKSKfjmSmfg==
X-Google-Smtp-Source: AGRyM1sb4RyLCMh9MpLdNin9MkXDwjf+mS9BNT7RWoG9P0GBF2yfUlddIR+CcqW0f5128Pg1eSLJcBHVFGP6YA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a0d:f544:0:b0:317:f98a:8702 with SMTP id
 e65-20020a0df544000000b00317f98a8702mr7586257ywf.229.1657336824450; Fri, 08
 Jul 2022 20:20:24 -0700 (PDT)
Date:   Sat,  9 Jul 2022 11:20:00 +0800
In-Reply-To: <20220709032001.819487-1-davidgow@google.com>
Message-Id: <20220709032001.819487-5-davidgow@google.com>
Mime-Version: 1.0
References: <20220709032001.819487-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 4/5] nitro_enclaves: test: Use kunit_test_suite() macro
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
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

The kunit_test_suite() macro previously conflicted with module_init,
making it unsuitable for use in the nitro_enclaves test. Now that it's
fixed, we can use it instead of a custom call into internal KUnit
functions to run the test.

As a side-effect, this means that the test results are properly included
with other suites when built-in. To celebrate, enable the test by
default when KUNIT_ALL_TESTS is set (and NITRO_ENCLAVES enabled).

The nitro_enclave tests can now be run via kunit_tool with:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_SMP=y \
	--kconfig_add CONFIG_HOTPLUG_CPU=y \
	--kconfig_add CONFIG_VIRT_DRIVERS=y \
	--kconfig_add CONFIG_NITRO_ENCLAVES=y \
	'ne_misc_dev_test'

(This is a pretty long command, so it may be worth adding a .kunitconfig
file at some point, instead.)

Reviewed-by: Andra Paraschiv <andraprs@amazon.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20220625050838.1618469-5-davidgow@google.com/
- Rebase on top of the TAINT_TEST patch series. This should now apply
  cleanly on top of the kunit branch:
  https://lore.kernel.org/linux-kselftest/20220708044847.531566-1-davidgow@google.com/T/#u
- Add Brendan's Acked-by tag.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220621085345.603820-5-davidgow@google.com/
- Add Andra's Reviewed-by tag.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-5-davidgow@google.com/
- Move the mistakenly-added thunderbolt Kconfig to the previous patch
  (Thanks Andra)
- Add Andra's Acked-by tag.

---
 drivers/virt/nitro_enclaves/Kconfig           |  5 ++--
 drivers/virt/nitro_enclaves/ne_misc_dev.c     | 27 -------------------
 .../virt/nitro_enclaves/ne_misc_dev_test.c    |  5 +---
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
index 2d3d98158121..ce91add81401 100644
--- a/drivers/virt/nitro_enclaves/Kconfig
+++ b/drivers/virt/nitro_enclaves/Kconfig
@@ -16,8 +16,9 @@ config NITRO_ENCLAVES
 	  The module will be called nitro_enclaves.
 
 config NITRO_ENCLAVES_MISC_DEV_TEST
-	bool "Tests for the misc device functionality of the Nitro Enclaves"
-	depends on NITRO_ENCLAVES && KUNIT=y
+	bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
+	depends on NITRO_ENCLAVES && KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the misc device functionality of the Nitro
 	  Enclaves. Select this option only if you will boot the kernel for
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 20c881b6a4b6..241b94f62e56 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1759,35 +1759,10 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #if defined(CONFIG_NITRO_ENCLAVES_MISC_DEV_TEST)
 #include "ne_misc_dev_test.c"
-
-static inline int ne_misc_dev_test_init(void)
-{
-	return __kunit_test_suites_init(ne_misc_dev_test_suites);
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-	__kunit_test_suites_exit(ne_misc_dev_test_suites);
-}
-#else
-static inline int ne_misc_dev_test_init(void)
-{
-	return 0;
-}
-
-static inline void ne_misc_dev_test_exit(void)
-{
-}
 #endif
 
 static int __init ne_init(void)
 {
-	int rc = 0;
-
-	rc = ne_misc_dev_test_init();
-	if (rc < 0)
-		return rc;
-
 	mutex_init(&ne_cpu_pool.mutex);
 
 	return pci_register_driver(&ne_pci_driver);
@@ -1798,8 +1773,6 @@ static void __exit ne_exit(void)
 	pci_unregister_driver(&ne_pci_driver);
 
 	ne_teardown_cpu_pool();
-
-	ne_misc_dev_test_exit();
 }
 
 module_init(ne_init);
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
index 265797bed0ea..74df43b925be 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev_test.c
@@ -151,7 +151,4 @@ static struct kunit_suite ne_misc_dev_test_suite = {
 	.test_cases = ne_misc_dev_test_cases,
 };
 
-static struct kunit_suite *ne_misc_dev_test_suites[] = {
-	&ne_misc_dev_test_suite,
-	NULL
-};
+kunit_test_suite(ne_misc_dev_test_suite);
-- 
2.37.0.rc0.161.g10f37bed90-goog

