Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA685503D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiFRJD4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiFRJDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 05:03:45 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323A2FE4E
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 02:03:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d15-20020aa7868f000000b0051c24cfebc0so2874330pfo.13
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l/ttLvz0OHvUwNpHYrnOtuxKB7kHcTFDOJ9+1t28w8k=;
        b=jYR2WCgcWlBbR92OxuHz4xPPf3H5cRhEsyQjcbj9V1I5XXaNNs0Fhei3lLFii/xO+2
         icLjO5uDyyPQYEWFkJlCN/2vsjYiE3P4Fu+it/i7IxMElAFmvlNfTwAh4LH2U6T/CfW0
         gzaewJRDivkUjDGDRBrDy1+sc38rLFWpXaBNRl7GylXCcfVJyBcTa0PiNgJIgBAj9AN3
         lyA9wwT+K9oDn3Iv4dCdbE3bKbgqIygUvNbLkQNNvSKrcnTRkdjnqO6LcRsHnVxQ+Ogn
         VlBkB+UtjdSJBVCFdrKI+qk376LralvkGo1wYmlJvuNbTDQIY/eMhrfJvGSVxav7rch/
         e2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l/ttLvz0OHvUwNpHYrnOtuxKB7kHcTFDOJ9+1t28w8k=;
        b=2ixNsIoqrteiuGDEe7iOe47nlxtuwM7rDs8XTClaU2XYSVjyGsU+TokTP4fvtrRhlR
         YoexracrVMwJmiNNL6kehxnYZgspiOqEyMrpAZMHQ8PO00IcrdKvUaKljEgQicKx9uxZ
         tveOold8pu4DGjtpH3KDilHueE1TObHa9zg+pRzZPb1NnimdyH86Uo1ldO67EfZyoX8A
         gHvP6UH+QTcVXtF6sI5R5fv4auAIV5Zo+zCZfVq5ufkZOp1mSgrRifI1Ib1Gbsck4sDo
         TlTypCTGULNrnD0kQm3B+DQc0B7O7AEk0p22+0ZDj0hjFXPgVYZDfv+sJbLVEXwzjeql
         kIgg==
X-Gm-Message-State: AJIora+whPVY3ZhRDi2EWseiLBQsuHkQkEQWVvBiw2CP/P2YWCWq5wAP
        +J4GnZRXBYPZJB/IXjiL/WdcwDkA5Q9++g==
X-Google-Smtp-Source: AGRyM1tqU8NQ1EwMjJIqa8XBUDMxnxZOkI3Tj286IoY6j4ByRRBGB8CD1fTsDOMYy71AgVNF1WNNkNKjzpGplA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:7806:b0:168:d336:dda9 with SMTP
 id p6-20020a170902780600b00168d336dda9mr13505513pll.83.1655543024232; Sat, 18
 Jun 2022 02:03:44 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:03:08 +0800
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
Message-Id: <20220618090310.1174932-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220618090310.1174932-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 3/5] thunderbolt: test: Use kunit_test_suite() macro
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

The new implementation of kunit_test_suite() for modules no longer
conflicts with module_init, so can now be used by the thunderbolt tests.

Also update the Kconfig entry to enable the test when KUNIT_ALL_TESTS is
enabled.

This means that kunit_tool can now successfully run and parse the test
results with, for example:
	./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_USB4=y \
	'thunderbolt'

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/thunderbolt/domain.c |  3 ---
 drivers/thunderbolt/tb.h     |  8 --------
 drivers/thunderbolt/test.c   | 12 +-----------
 3 files changed, 1 insertion(+), 22 deletions(-)

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
2.36.1.476.g0c4daa206d-goog

