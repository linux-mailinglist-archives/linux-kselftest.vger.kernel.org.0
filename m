Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AB48DC55
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jan 2022 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiAMQ7v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jan 2022 11:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiAMQ7u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jan 2022 11:59:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73552C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 08:59:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v66-20020a256145000000b006115377709aso12514791ybb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jan 2022 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=56DWaENCHRMghpIV1icK93qpW14DeDvo1W7ZsO3A1B8=;
        b=I5pIXTSreNu/k26AmGVwEGt4v2BG9gVUdimQLEIzP2yDG+po2TLOs8+n4YOx7yafNx
         E8KY4MlzJmUK98afez6V5EOJ6cg9vnJZEpzFozgu3RpBLLKFL2ZAMyEQ5Ybv2FC6rx01
         gHNbsI8qIatOXJzxeophN43v6akkKvTXePv4lo166QpDR3qW5S77cfKrR5YrqIf+7ETL
         c5kcdJ7XDmEG4h43G8IEjhBQgcLU3mXJPRG1qZKsXCbpmGWRaMBNYfomH0oBzuU+LI2k
         c6fvCz6kcKq0rJfAKNKVa8NDqdeHuhFdPL24YobQJeVRfJbziWiEVjpf7SDlJ9+xxFbX
         KmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=56DWaENCHRMghpIV1icK93qpW14DeDvo1W7ZsO3A1B8=;
        b=q4S6/+/wBbzdNUUhY/zVumXTfmuirBM4xbZKG1dEJ6/tkiP7UDuPVQ2LzGC6Nzgina
         780Wep3WD15yWaZT/IRCcVahHlXvVIp1DbF14bIJ95JH7oEz465ndN708HfpYTKKnY6X
         zFN7aO2zPAc9XMkthSBodiCOw4VqYAFpvIRfNtfywBgjF873Ga4C+6XbCMKoD8WIf9VY
         9GXm9XegypEC4n5P3Uy/kVAg4/JyYUFWPW9nEH7VHCT08WTxqalgiGThJcceeVJmoQMS
         n3QR+av3uocnrZGKbkW0IUm1KVPqVe+nGF21wZjZQ85yNZLuAPe0ie+x1lizNIYkiokG
         Lpjg==
X-Gm-Message-State: AOAM532E2KkRN1Tg2TtsipU9WnS5DM2INGV5HrwqtTnlOtGjAwXDKZRM
        2LGX10jEzh98H8ldYHYW8WxO0g/h1eo1Vw==
X-Google-Smtp-Source: ABdhPJxDCZZzIiLvvsZPEjr3S2+pReXde9HWQEBJ9XM+CW88mx/JVvUESeOutwQOk0fo1RWu6+F2h/2Em9LB7Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a70:cede:4191:24bc])
 (user=dlatypov job=sendgmr) by 2002:a25:c8c3:: with SMTP id
 y186mr7255985ybf.20.1642093189705; Thu, 13 Jan 2022 08:59:49 -0800 (PST)
Date:   Thu, 13 Jan 2022 08:59:26 -0800
In-Reply-To: <20220113165931.451305-1-dlatypov@google.com>
Message-Id: <20220113165931.451305-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220113165931.451305-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 1/6] kunit: add example test case showing off all the
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
2.34.1.703.g22d0c6ccf7-goog

