Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C454D5357
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiCJVDV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 16:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiCJVDU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 16:03:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F3187E2C
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 13:02:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc58f5a95bso52142047b3.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nhgi3BB4XpjaAi43HFqrROCjC8ClF99sWlB07YLUjuw=;
        b=KwvTEZJ0wY9VDs3piyux/dajAEwF5+D10/YCaGxRIrlvTdMFpqlR2ieLlINMV9Neol
         J+62V/6rDjgxezD+17hGyRlX2W1THPqWrfOejkp92Rcxaq0k1rEEM24p9D40YqZcvgGR
         T3wuhqeaOy3bmJNELByai+/MAza4z/z482ZLB3Mf5rRJWCuIbCfrgPK5mbrwgkczbpum
         Pme0yt4xy9GEXL351n5UIjCVUR6qLcrslOY2LCWtlnn++vXO+Ox6tabl5CeInxE25tLV
         qEvNFOWAIg5PCo4q4rXgWdHg5MLAsISjJWJahi75cxY3cKzyAZE/Cin9DT8Z8u4rn3Hg
         u4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nhgi3BB4XpjaAi43HFqrROCjC8ClF99sWlB07YLUjuw=;
        b=bxzCRg4xnFDSUesbbHdpvHXNfEAPYEVCRXiKmNypR09QOySOZCLqvsAgkf4yMAFZTj
         m7CznqT1hne2K8zcDDCAauZziDKqhNR+BmhYFwWTzcta6VvCTUp2JK3Rv0ZKCT3IcDwa
         eY2dpA0cuZAmPOdhzVsjnvGc0wDjuJgwT2+U/wfX79/4o/IV+NHtb1q1/Ip8KGiK5XIl
         hp5CSLR0wrjEEJPxyvCWdaVE5dT2vWzCHbGRrZB6C0ZnI9n28GwMr8ZU4NZyqro8zEyp
         E6seCZYuD2LhMBpRD8JZJoxMXCExuLBMGAmu7GP/Qrt8OA6R4gvdm+bDj3RgeWkksvzx
         52nw==
X-Gm-Message-State: AOAM532T4hDNNlAXYEhdC3iE8bA3f/OgIFHRezbVZdfIYcLri6kDgYTB
        LKnH2PygpOYZr7cYTK07GAcr8UgwEEFxGZQV2vhKIw==
X-Google-Smtp-Source: ABdhPJycuI1HKbQSXZF0j/e2TWioe6F+r4T2m2FRMWk0cWFfdUZPWhC23SJEpUIplksniR+bqEh7ZozdVSB6L+i71zl1gg==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:e3e5:56d9:89bd:baa])
 (user=brendanhiggins job=sendgmr) by 2002:a25:bd4c:0:b0:62c:bd12:6dc4 with
 SMTP id p12-20020a25bd4c000000b0062cbd126dc4mr4160719ybm.549.1646946138601;
 Thu, 10 Mar 2022 13:02:18 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:02:10 -0800
Message-Id: <20220310210210.2124637-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC v1] kunit: add support for kunit_suites that reference init code
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        martin.fernandez@eclypsium.com, daniel.gutson@eclypsium.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
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
kunit_test_init_suite(); this new registration macro allows the
registration of kunit_suites that reference functions marked __init and
data marked __initdata.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

This patch is in response to a KUnit user issue[1] in which the user was
attempting to test some init functions; although this is a functional
solution as long as KUnit tests only run during the init phase, we will
need to do more work if we ever allow tests to run after the init phase
is over; it is for this reason that this patch adds a new registration
macro rather than simply modifying the existing macros.

[1] https://groups.google.com/g/kunit-dev/c/XDjieRHEneg/m/D0rFCwVABgAJ

---
 include/kunit/test.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b26400731c02..1878e585f6d3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -379,6 +379,27 @@ static inline int kunit_run_all_tests(void)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
+/**
+ * kunit_test_init_suites() - used to register one or more &struct kunit_suite
+ *			      containing init functions or init data.
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
+ */
+#define kunit_test_init_suites(__suites...)				\
+	__kunit_test_suites(CONCATENATE(__UNIQUE_ID(array), _probe),	\
+			    CONCATENATE(__UNIQUE_ID(suites), _probe),	\
+			    ##__suites)
+
+#define kunit_test_init_suite(suite)	kunit_test_init_suites(&suite)
+
 #define kunit_suite_for_each_test_case(suite, test_case)		\
 	for (test_case = suite->test_cases; test_case->run_case; test_case++)
 

base-commit: 330f4c53d3c2d8b11d86ec03a964b86dc81452f5
-- 
2.35.1.723.g4982287a31-goog

