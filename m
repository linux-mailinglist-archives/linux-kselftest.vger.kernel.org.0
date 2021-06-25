Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899C63B3CE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYHAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 03:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFYHAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 03:00:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2D4C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 23:58:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a25f5040000b029054df41d5cceso2974705ybe.18
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oc9ussIVPpLKNQyBAih5iA2F2VxRRfpcgUOh/ls8NWQ=;
        b=Bok1hqFg+ciy5bGnz9jNah5nkTl+BmwEKBVWa3dSs5nK1pY9AyaE8s6JjPDQtXj/T7
         AUR8FawUkze6o4AQAW6TCjXJEhhdlRIfov+9tcUCjUEGp6Q2YYaU1Uu1b1owJW2LBe6x
         ez2BroXx8KuKvcte6kbASBNnXkVpt5kyBlCRzQqCu8hecHWwPpcUFeX79tNIcFU9hTzp
         hKgyrHFpYeIBlEdmvgjkA1QE74dLb1NjhKMg9CcoqghN4jebh6RP93ZeAnjw69G2CFln
         LOhMvM6Pv/H6qPQbJdMek4OtDyE1m2nK8W549H6FeX0mN8jh/wR38ZnYsl/+xLIG4boL
         YVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oc9ussIVPpLKNQyBAih5iA2F2VxRRfpcgUOh/ls8NWQ=;
        b=HR49KXfGcqtMGPL2zICCeg7h5FutAc61AJjQ2Ah9Efg9zXzWH+qyLkr8M/FCnmNZmY
         qW4/GMulyAouBx9/cLIqoRy8aY/sPxiwf089PfW3gDZ2QZSDW2h3VTWDQQu2Tuvl/fRn
         HMKYpZBHod3ARTJnDclcojqOhWF+vjFc6YEBBMbS9LNXxCUnNFnIlRUhXaQURENx15/3
         6qbG6ZXPkf8LGae7KYHXjLff19It2JNRVB308RATx3cYzOg6JI0MxnPndI5qRkvB+f9I
         bMkX2d82MrDtgr3oUab/SrnRFHwazdXXclI65pffUJlhJ+wQ6W/xf5inkvY1fexJqPU2
         dPEg==
X-Gm-Message-State: AOAM530biNItYe0kdF+eumOWAAR+MaR7tGVLRGNuneMaaFh2DMwTYZM8
        mUrUZdI6gj6UFUHcGJbmcglZsxPKvjsAkA==
X-Google-Smtp-Source: ABdhPJyhITi9ybwaOfl06YIxPyrUXd/r7sjegiUztAicF9gv9fy0dJjtabGaBQ3YX/heeHJd7PpJfLQ1PVW3jw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:bd17:f9ad:979a:a3a9])
 (user=davidgow job=sendgmr) by 2002:a25:a549:: with SMTP id
 h67mr10715684ybi.393.1624604304936; Thu, 24 Jun 2021 23:58:24 -0700 (PDT)
Date:   Thu, 24 Jun 2021 23:58:14 -0700
In-Reply-To: <20210625065815.322131-1-davidgow@google.com>
Message-Id: <20210625065815.322131-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210625065815.322131-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH kunit-fixes v5 3/4] kunit: test: Add example tests which are
 always skipped
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two new tests to the example test suite, both of which are always
skipped. This is used as an example for how to write tests which are
skipped, and to demonstrate the difference between kunit_skip() and
kunit_mark_skipped().

Note that these tests are enabled by default, so a default run of KUnit
will have two skipped tests.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

No changes since v4:
https://lore.kernel.org/linux-kselftest/20210611070802.1318911-3-davidgow@google.com/

No changes since v3:
https://lore.kernel.org/linux-kselftest/20210608065111.610297-1-davidgow@google.com/

No changes since v2:
https://lore.kernel.org/linux-kselftest/20210528075932.347154-3-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210526081112.3652290-3-davidgow@google.com/
- These tests are now part of the example test suite.
- Use kunit_info() instead of kunit_log(KERN_INFO, ...)
- Use KUNIT_FAIL() to assert the test is not executing for skip_test

 lib/kunit/kunit-example-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index be1164ecc476..51099b0ca29c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,35 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should not see a line below.");
+
+	/* Skip (and abort) the test */
+	kunit_skip(test, "this test should be skipped");
+
+	/* This line should not execute */
+	KUNIT_FAIL(test, "You should not see this line.");
+}
+
+/*
+ * This test should always be marked skipped.
+ */
+static void example_mark_skipped_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should see a line below.");
+
+	/* Skip (but do not abort) the test */
+	kunit_mark_skipped(test, "this test should be skipped");
+
+	/* This line should run */
+	kunit_info(test, "You should see this line.");
+}
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -52,6 +81,8 @@ static struct kunit_case example_test_cases[] = {
 	 * test suite.
 	 */
 	KUNIT_CASE(example_simple_test),
+	KUNIT_CASE(example_skip_test),
+	KUNIT_CASE(example_mark_skipped_test),
 	{}
 };
 
-- 
2.32.0.93.g670b81a890-goog

