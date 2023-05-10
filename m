Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7886FD644
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 07:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjEJFi7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 01:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjEJFi5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 01:38:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A830F9
        for <linux-kselftest@vger.kernel.org>; Tue,  9 May 2023 22:38:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559e281c5dfso75247017b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 May 2023 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683697132; x=1686289132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfo42Q0Y+93PbUz1Yll6pAE36cAitDEFg/Zj034KFHY=;
        b=rmd4TKqnOZTd1yPShThAvmZvlcVmX5R+MgeqNKnU3hjsvhOeXoQWw53L4vlBu24w2O
         uJeQvXfNnt98wUYtlcyRgAKitZINh5JyjVOuwF2GxPSJXqIIV43P6XuSWOqjS5pmNHR6
         VWUzt2NU3BYqGgVPQoBsH9Fk3x8n7j9XYXs5WxGPAabxedPFurLRhNz++N8msmsf+MO5
         9isTNnVN+Qp9/1ik9kKp3mLdQlDkvGApwVj8S645AWqwdb2rgbtLQBp1C5Bv27LIO3IT
         zG2Dvkum7WvbQ5CKzfSr4xngncd/YTFZzlcD7oU6Cp1VOBzOSnXoEL7Olo8pNbumiaym
         Bv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697132; x=1686289132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfo42Q0Y+93PbUz1Yll6pAE36cAitDEFg/Zj034KFHY=;
        b=X7sHRcOkuEe/7N24FMALZor/psy7cY7mWyjcP+SEUxQJb6EkL+6IB7I4TirO4EZekp
         D6hRe877lLRSvoznT+wzdX7r61lJLKIwoMIA70DXNutiV71v6rXVkTGC8nFpmDIuJ02L
         FNsLaapnysD7kY0yNVSW8p150J4GkFQ5Jx+BMlh3PTS9IQ2TotW9Vpxdx6f9GhAaRNSf
         blUWpYmblC5jFwjCWsfR44wQMbZg7AqNL+yPcYxbbKMNQu0x0HQz2BKeSetIWr2xE7xw
         jrGIh+FBYePBbir2o3hgJ97ewsaO4xsRqtpk91swxbQ/LDL4HKb83bRsuNbrj3uLuv35
         boDQ==
X-Gm-Message-State: AC+VfDwa3U8I6NRVZwZFj58pZvhrYZi5tUr7QE2LdBmHsQ4i1DBtKpax
        X/Ej+6y4+CLnI3I4HZgR/Y22VumCNnViyA==
X-Google-Smtp-Source: ACHHUZ4e/K50fW2t0YQaNJVoN4iOC0HO0V4/JFVNf7CQLXQsKDEhj8MTD0BwKOn6kf9Vf6zoEUsUiv90+jKT8g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:c903:0:b0:556:cacc:1f1d with SMTP id
 o3-20020a81c903000000b00556cacc1f1dmr10154166ywi.8.1683697132036; Tue, 09 May
 2023 22:38:52 -0700 (PDT)
Date:   Wed, 10 May 2023 13:38:32 +0800
In-Reply-To: <20230510053832.438529-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230510053832.438529-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510053832.438529-4-davidgow@google.com>
Subject: [PATCH v4 4/4] kunit: example: Provide example exit functions
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
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

Add an example .exit and .suite_exit function to the KUnit example
suite. Given exit functions are a bit more subtle than init functions
(due to running in a different kthread, and running even after tests or
test init functions fail), providing an easy place to experiment with
them is useful.

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20230421040218.2156548-4-davidgow@google.com/
- Rebased on top of latest kselftest/kunit branch.
- Added Reviewed-by tag.

This patch was introduced in v3.

---
 lib/kunit/kunit-example-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index cd8b7e51d02b..24315c882b31 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -41,6 +41,16 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This is run once after each test case, see the comment on
+ * example_test_suite for more information.
+ */
+static void example_test_exit(struct kunit *test)
+{
+	kunit_info(test, "cleaning up\n");
+}
+
+
 /*
  * This is run once before all test cases in the suite.
  * See the comment on example_test_suite for more information.
@@ -52,6 +62,16 @@ static int example_test_init_suite(struct kunit_suite *suite)
 	return 0;
 }
 
+/*
+ * This is run once after all test cases in the suite.
+ * See the comment on example_test_suite for more information.
+ */
+static void example_test_exit_suite(struct kunit_suite *suite)
+{
+	kunit_info(suite, "exiting suite\n");
+}
+
+
 /*
  * This test should always be skipped.
  */
@@ -211,7 +231,9 @@ static struct kunit_case example_test_cases[] = {
 static struct kunit_suite example_test_suite = {
 	.name = "example",
 	.init = example_test_init,
+	.exit = example_test_exit,
 	.suite_init = example_test_init_suite,
+	.suite_exit = example_test_exit_suite,
 	.test_cases = example_test_cases,
 };
 
-- 
2.40.1.521.gf1e218fcd8-goog

