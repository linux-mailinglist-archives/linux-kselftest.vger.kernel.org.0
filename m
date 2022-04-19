Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136C506324
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 06:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbiDSEIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 00:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiDSEIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 00:08:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243714039
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 21:05:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h82-20020a25d055000000b00641d2fd5f3fso13379820ybg.11
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Apr 2022 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2kvo4cKjgLSkZi0ORkIKm30VEiLgu1BUEUNx8foAAG8=;
        b=eEembY2GsRtYsEYySYFlinuBVUlW5yxKUGielw9ewu8TxjrkRmZ2CQLu9Pc0BYrccx
         6hhIyK8vlTzr3br6uMeijPkKCHPDKM7b/k0ho/M3aBxaj6OfzC+ZyU/FsGwssN+czllA
         ctIslHRU87mKRu6oNVxEjtf9uWituD/2nKYCBqXjQf0PQIMvl5ofxDr90mQBsR4xEl67
         bnA78s4LcoplzlYfK4p7kqBd/TUkE3imotT7I18vhEhWg/0mFQ1Gvq4wwzyPKgttQMBX
         mcswzT5FdXz1/uvs9DCmsuUFUGC1R2OFVQKPfAGXPLgUNKT9mFvY4HCUpmbEOKq7nW/k
         /gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2kvo4cKjgLSkZi0ORkIKm30VEiLgu1BUEUNx8foAAG8=;
        b=DBM9vndahry+LqVerhqHMppou3nBS8IWEfkYTIDB62BR7aaZkGQyAsuc0mynsD5m+4
         bgszIcbpubchUZTofW8ey0OWRPCH9OejebCrSR34mu7p0ntyeIPGZa2SZyLoe7fDRVTh
         ShzzbMcXW2qpdyHi1hTT2dEl24H+2gFqtEIfJwyJrQQatOImgZbKT3SKP6gnn2CLhXgm
         PCxFNtaNKJNgIm6A9kwmnBWcBD6MsTaRgngMP0RgF7FKeVJyo6x2qQYtFKvOEaq0Q2tu
         dGGSeZsN2Fs25kJONHETUnb6CRvB5pYWlOFPuBW6jx770qn0mhNLdXATPB5zATjVRjfF
         zITQ==
X-Gm-Message-State: AOAM531PaE0NYD8RQ7dhL2kgXLOmnhvqzvEa1GhcuciTpxgPdWrZkldL
        uJTljB3OjqbFWdFka0cv102kBXDK/BlVy6/gptnSHQ==
X-Google-Smtp-Source: ABdhPJzlNyTz4ZcPX1ZcP0aN3Q/D3Va+r3K/NAXGD0co8t3sQljhVn3IORJ4o7KD0DIZbhTrRzDt9Nr2UXHcdxhSZPH9+Q==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:d2c9:6361:2665:49a6])
 (user=brendanhiggins job=sendgmr) by 2002:a25:c554:0:b0:645:42e2:fa59 with
 SMTP id v81-20020a25c554000000b0064542e2fa59mr210554ybe.571.1650341119990;
 Mon, 18 Apr 2022 21:05:19 -0700 (PDT)
Date:   Mon, 18 Apr 2022 21:05:15 -0700
Message-Id: <20220419040515.43693-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2] kunit: add support for kunit_suites that reference init code
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jk@codeconstruct.com.au,
        Brendan Higgins <brendanhiggins@google.com>
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

Add support for a new kind of kunit_suite registration macro called
kunit_test_init_section_suite(); this new registration macro allows the
registration of kunit_suites that reference functions marked __init and
data marked __initdata.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Martin Fernandez <martin.fernandez@eclypsium.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---
Changes since last version:

Renamed the new kunit_suite registration macro for init functions to a
more readable name.
---
 include/kunit/test.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 00b9ff7783ab..5a870f2d81f4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -380,6 +380,34 @@ static inline int kunit_run_all_tests(void)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
+/**
+ * kunit_test_init_section_suites() - used to register one or more &struct
+ *				      kunit_suite containing init functions or
+ *				      init data.
+ *
+ * @__suites: a statically allocated list of &struct kunit_suite.
+ *
+ * This functions identically as &kunit_test_suites() except that it suppresses
+ * modpost warnings for referencing functions marked __init or data marked
+ * __initdata; this is OK because currently KUnit only runs tests upon boot
+ * during the init phase or upon loading a module during the init phase.
+ *
+ * NOTE TO KUNIT DEVS: If we ever allow KUnit tests to be run after boot, these
+ * tests must be excluded.
+ *
+ * The only thing this macro does that's different from kunit_test_suites is
+ * that it suffixes the array and suite declarations it makes with _probe;
+ * modpost suppresses warnings about referencing init data for symbols named in
+ * this manner.
+ */
+#define kunit_test_init_section_suites(__suites...)			\
+	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
+			    ##__suites)
+
+#define kunit_test_init_section_suite(suite)	\
+	kunit_test_init_section_suites(&suite)
+
 #define kunit_suite_for_each_test_case(suite, test_case)		\
 	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.36.0.rc0.470.gd361397f0d-goog

