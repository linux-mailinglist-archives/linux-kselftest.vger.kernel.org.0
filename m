Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC90552D7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348515AbiFUIyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348586AbiFUIyI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 04:54:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316301902A
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:54:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 15-20020a63040f000000b0040c9f7f2978so3547493pge.12
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0uhV+vE5GR6r1TPh+N0PxUsqIXfuH6Gv3M64Soo3ZV0=;
        b=qDlBtT5aPcoXioaoOss1BwK808pjMkcG19mg6/PuczAfv2vCZr9SU9StPq1Ib3iP1P
         Pc3uF13Nep2goxYIBlNpTgpJzHGqwCI2E1mZrO3ZDCdTl0889+8xBdLmdtKot6GezFwg
         L81x9/6DyG17cQ0xlJ4QBeWIIOMUiVVblaWjjIf31lgz727Y9geOPu3Ie+WuWPYMyJCC
         hDKtzbRVRHwFjxyfIP+UnCs+RrWcbG6J2fTSVhApVOx/re91uagd3biwcjVMc+2U12w0
         pWlmQwVkunoC9OkJa2lNBoMHYbV9Hu6lAra8ihcyckgVuqmRpJe/17MM6daMaPE8I/Yl
         gAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0uhV+vE5GR6r1TPh+N0PxUsqIXfuH6Gv3M64Soo3ZV0=;
        b=iYrzA3QxZyBddQk4EPDBxgtQH/nbq9yRIju8ubXTEIn3hUWaHpa+yiR+v4cUavVgGy
         OJCOmgyGSULpzlo5duCN58lCTb4p0hzytOLTHrE7fFzrFoHy45BOBpeJhmDzD7bMNZsk
         SZcIMrCeMLExYvL5kn5rWohcWE9G/Qv9z9GUsXwPks/QqtUUjV61iRba8s+MCafkHX2K
         z3oHnai7JtSn4gIeig6NB/uTja3wqyiey6ycjU2WmepIK7HsXw1JJaB9Tn1eV+lApzbG
         MCP+6a01kpIj//hWAL5hdLLw5yQPQ7Z0MHHskqFVR5iSO4nSS/zIR5FG2axNVedZ6yuP
         mxVg==
X-Gm-Message-State: AJIora+SeUUrK2YH5Zki6gIO4FP2dwlwKaHjKAB0ZtRi0/uoRmPZswME
        BETT7sozNFjk92Af3sSqaJzKQZWh7D5Jxg==
X-Google-Smtp-Source: AGRyM1v0iEb5qqc6gumUemGChdbOr/X+EucelQpwk6J+2yXUNXxUTowX5rfO4DWXmf+LwoHgdjVsy8xDH/guyg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:4a97:b0:1ea:fa24:467c with SMTP
 id f23-20020a17090a4a9700b001eafa24467cmr694998pjh.1.1655801646030; Tue, 21
 Jun 2022 01:54:06 -0700 (PDT)
Date:   Tue, 21 Jun 2022 16:53:43 +0800
In-Reply-To: <20220621085345.603820-1-davidgow@google.com>
Message-Id: <20220621085345.603820-4-davidgow@google.com>
Mime-Version: 1.0
References: <20220621085345.603820-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v2 3/5] thunderbolt: test: Use kunit_test_suite() macro
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
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220618090310.1174932-4-davidgow@google.com/
- Actually include the Kconfig changes, which were mistakenly added to
  the next patch in the series in v1.
- Add Acked-by tag from Mika Westerberg

---
 drivers/thunderbolt/Kconfig  |  5 +++--
 drivers/thunderbolt/domain.c |  3 ---
 drivers/thunderbolt/tb.h     |  8 --------
 drivers/thunderbolt/test.c   | 12 +-----------
 4 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
index 4bfec8a28064..2a063d344b94 100644
--- a/drivers/thunderbolt/Kconfig
+++ b/drivers/thunderbolt/Kconfig
@@ -28,8 +28,9 @@ config USB4_DEBUGFS_WRITE
 	  this for production systems or distro kernels.
 
 config USB4_KUNIT_TEST
-	bool "KUnit tests"
-	depends on KUNIT=y
+	bool "KUnit tests" if !KUNIT_ALL_TESTS
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
2.37.0.rc0.104.g0611611a94-goog

