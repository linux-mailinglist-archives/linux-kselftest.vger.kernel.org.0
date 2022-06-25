Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0755A736
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiFYFK4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 01:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiFYFKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 01:10:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF548E63
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s194-20020a252ccb000000b00669b5702413so3806863ybs.22
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 22:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z60giZ+cYGB0OQy1BSvN+3PmyrskrpMeDRFaX7tGacA=;
        b=Xr6xY+FOlAbmemr77B6BFiulFx55OzX/vQpFKaIlk9QBDoik0ukb3dZ8IRi+t/r3yK
         mLcyxlJsTEswdu4eWy7rTKP/m4JJmbyLQO2LG8uyvKR2yM1nAShA75wLeFUgdBa9Q7YW
         7p9wXg/QerP9KrNr6ygCn7N/LrKMQo4DEXYZjfb2sPFc90cXeJNYd1OOvEA7ihreJy4N
         M5sNG43pc2LONxIowrrgOTCSOQajUdvIswqE54chs6DMIQ4POdLyZzKNuijWoR41gCzT
         60+G76fFBb5KQSMMx4dGipFjiVamXJRrMeL6QUh1uslUg8JYyF9V3smU1euwmCP9m39h
         CSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z60giZ+cYGB0OQy1BSvN+3PmyrskrpMeDRFaX7tGacA=;
        b=pA0KhuEZQTDlPlQBhn3cFw7b056zm/E0/hPni6FOjhuXK4c8RAuFVsiV7Z0na9IfSF
         uyx8165fYsa7sI3SeaUYyKyy97Hq/IahAPnQfQInlrZaEe0YND7gODg1RjYpfE1KXv5b
         TG1B+Y1m3Zv0QyHXHwUaKPHetwD5/uVczuL7M6BxnmVWb4dQGx9V6hvNkWkbAF4mj8UV
         xzedK+BoZOl4aqjUyjw8ws6t60grBNYZsZ1k5GFodZNqEJcxcKvOkJhPDH2y2Skvk9x7
         fxvjuFDPveYFLeI7b4SUMVUxGYEGwiRctnmsCJk+0BjxW2kGv8DgQVXKh2CCkA95BgDW
         u28Q==
X-Gm-Message-State: AJIora+lci/cv2Y7E6XdM1gAb1KWrpv/71He1IHL60xr8TRAeScziKiD
        EBdewjD1FEio+J7foxD8B0xPrJzaa3F9AQ==
X-Google-Smtp-Source: AGRyM1vIbyjxZtT2NR+c5O96ieBxDIF580E55AnqzRfCBf4HwOqyp+FN1T0Sy8LsrBnEAOglWCfJTe/lb94Eyw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:d91:0:b0:317:9176:56fe with SMTP id
 139-20020a810d91000000b00317917656femr2781543ywn.381.1656133852887; Fri, 24
 Jun 2022 22:10:52 -0700 (PDT)
Date:   Sat, 25 Jun 2022 13:08:37 +0800
In-Reply-To: <20220625050838.1618469-1-davidgow@google.com>
Message-Id: <20220625050838.1618469-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 3/5] thunderbolt: test: Use kunit_test_suite() macro
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new implementation of kunit_test_suite() for modules no longer
conflicts with module_init, so can now be used by the thunderbolt tests.

Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
enabled.

This means that kunit_tool can now successfully run and parse the test
results with, for example:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
	'thunderbolt'

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220621085345.603820-4-davidgow@google.com/
- Don't permit USB4_KUNIT_TESTS to be enabled when USB4=y and KUNIT=m
  i.e., add a dependency on (USB4=m || KUNIT=y)
  This would result in undefined kunit symbols being used, otherwise.
- Add Daniel's Acked-by

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-4-davidgow@google.com/
- Actually include the Kconfig changes, which were mistakenly added to
  the next patch in the series in v1.
- Add Acked-by tag from Mika Westerberg

---
 drivers/thunderbolt/Kconfig  |  6 ++++--
 drivers/thunderbolt/domain.c |  3 ---
 drivers/thunderbolt/tb.h     |  8 --------
 drivers/thunderbolt/test.c   | 12 +-----------
 4 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index 4bfec8a28064..e76a6c173637 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -28,8 +28,10 @@ config USB4_DEBUGFS_WRITE
 	  this for production systems or distro kernels.
 
 config USB4_KUNIT_TEST
-	bool "KUnit tests"
-	depends on KUNIT=y
+	bool "KUnit tests" if !KUNIT_ALL_TESTS
+	depends on (USB4=m || KUNIT=y)
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config USB4_DMA_TEST
 	tristate "DMA traffic test driver"
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 2889a214dadc..99211f35a5cd 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -872,7 +872,6 @@ int tb_domain_init(void)
 {
 	int ret;
 
-	tb_test_init();
 	tb_debugfs_init();
 	tb_acpi_init();
 
@@ -890,7 +889,6 @@ int tb_domain_init(void)
 err_acpi:
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 
 	return ret;
 }
@@ -903,5 +901,4 @@ void tb_domain_exit(void)
 	tb_xdomain_exit();
 	tb_acpi_exit();
 	tb_debugfs_exit();
-	tb_test_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 4602c69913fa..a831faa50f65 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1271,12 +1271,4 @@ static inline void tb_service_debugfs_init(struct tb_service *svc) { }
 static inline void tb_service_debugfs_remove(struct tb_service *svc) { }
 #endif
 
-#ifdef CONFIG_USB4_KUNIT_TEST
-int tb_test_init(void);
-void tb_test_exit(void);
-#else
-static inline int tb_test_init(void) { return 0; }
-static inline void tb_test_exit(void) { }
-#endif
-
 #endif
diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
index ee37f8b58f50..24c06e7354cd 100644
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@ -2817,14 +2817,4 @@ static struct kunit_suite tb_test_suite = {
 	.test_cases = tb_test_cases,
 };
 
-static struct kunit_suite *tb_test_suites[] = { &tb_test_suite, NULL };
-
-int tb_test_init(void)
-{
-	return __kunit_test_suites_init(tb_test_suites);
-}
-
-void tb_test_exit(void)
-{
-	return __kunit_test_suites_exit(tb_test_suites);
-}
+kunit_test_suite(tb_test_suite);
-- 
2.37.0.rc0.161.g10f37bed90-goog

