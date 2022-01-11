Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE248B780
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiAKTmn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiAKTml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E9C06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso2593196ybt.12
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IK/pmS24q6VZVkmGI5V/Gm7usfxnRrjcLFdAJnMZ6jo=;
        b=kPS3NVMXisQ+S/QiUTo32EZgKyhJGfLV5qbJ/CUrzZeNer1H5zWimCjpTdxSG89Tjk
         9dRxuAb/q0Kff2CmnjGBbVOoMGKy7tQMH7gWghOqk8iI76NU34RIk+i+J5AiujsustPr
         x7DpfQO/TXPs4wNx/3fqlndDE2PdYkaXp4y8sMiZBZ2iMFauWQeFSPaGn7Z4vz8dWh60
         3GcqpW7YdE4mNEg+BoWHj84ROx4gpnFC/r3cej87lr/JRDYt47DNJ/2be4N4rqfAW56H
         nYovJo/oOvJfuKLzjk1ZR5WazDeSlvvcW4ARJAtVilMMhYM+uHhAtXEO1iNwLuim+XsZ
         WIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IK/pmS24q6VZVkmGI5V/Gm7usfxnRrjcLFdAJnMZ6jo=;
        b=3QnGdJW/z6PwdD91cmpiXOAKPsWl6WYKaWxy/BVJZpmCUP4Co0n8vDCuih1OGjWZ/E
         2AfjgQNt7UKibfXkE+p0j4N26j31B1z3UF54r0NN16GjaNQFAkaxQFR2tfsJzmbvJikb
         SVCV5MMy0uAQQJQmVE1vMzoc5NNH7HebW7vhE637Jj+cwcNrzp9K1eu5hD8w+PqmgwDa
         5VC6w0P/GS+YUTpjSzcHSiVusPwLtoB/VtE2mLhdvU2if0aVmYep06NajN2ZM71cOsaO
         denq8Xu7+JYfTQ0Fmxh6ycWuEuYEomSfnCOyY8faNWmZn6K8sy/xdPKp8DGjiMNGxdBM
         bi/A==
X-Gm-Message-State: AOAM530PLuHFy9ZZd552h6A+Hc7wzD4lH/l7snHmBustW5ZYktiHBlO9
        GTwXnkBwg22DWNS4i+zhudozLFP4uXx2ow==
X-Google-Smtp-Source: ABdhPJwX78HJ4lOcr1NG1sNwWGZipmSIxgpMjxDBLYD02itZJXKKzuQQmiZ+DWe0Ps8yNuW9G+qj3USG47dl3A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a25:360f:: with SMTP id
 d15mr6124569yba.31.1641930160484; Tue, 11 Jan 2022 11:42:40 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:26 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 1/6] kunit: add example test case showing off all the
 expect macros
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, these macros are only really documented near the bottom of
https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.

E.g. it's likely someone might just not realize that
KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
or similar.

This can also serve as a basic smoketest that the KUnit assert machinery
still works for all the macros.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/kunit-example-test.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 51099b0ca29c..4bbf37c04eba 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -69,6 +69,47 @@ static void example_mark_skipped_test(struct kunit *test)
 	/* This line should run */
 	kunit_info(test, "You should see this line.");
 }
+
+/*
+ * This test shows off all the types of KUNIT_EXPECT macros.
+ */
+static void example_all_expect_macros_test(struct kunit *test)
+{
+	/* Boolean assertions */
+	KUNIT_EXPECT_TRUE(test, true);
+	KUNIT_EXPECT_FALSE(test, false);
+
+	/* Integer assertions */
+	KUNIT_EXPECT_EQ(test, 1, 1); /* check == */
+	KUNIT_EXPECT_GE(test, 1, 1); /* check >= */
+	KUNIT_EXPECT_LE(test, 1, 1); /* check <= */
+	KUNIT_EXPECT_NE(test, 1, 0); /* check != */
+	KUNIT_EXPECT_GT(test, 1, 0); /* check >  */
+	KUNIT_EXPECT_LT(test, 0, 1); /* check <  */
+
+	/* Pointer assertions */
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
+	KUNIT_EXPECT_PTR_NE(test, test, NULL);
+
+	/* String assertions */
+	KUNIT_EXPECT_STREQ(test, "hi", "hi");
+	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
+
+	/*
+	 * There are also ASSERT variants of all of the above that abort test
+	 * execution if they fail. Useful for memory allocations, etc.
+	 */
+	KUNIT_ASSERT_GT(test, sizeof(char), 0);
+
+	/*
+	 * There are also _MSG variants of all of the above that let you include
+	 * additional text on failure.
+	 */
+	KUNIT_EXPECT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
+	KUNIT_ASSERT_GT_MSG(test, sizeof(int), 0, "Your ints are 0-bit?!");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -83,6 +124,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_simple_test),
 	KUNIT_CASE(example_skip_test),
 	KUNIT_CASE(example_mark_skipped_test),
+	KUNIT_CASE(example_all_expect_macros_test),
 	{}
 };
 
-- 
2.34.1.575.g55b058a8bb-goog

