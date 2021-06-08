Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC5C39EEFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHGyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 02:54:19 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:37855 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGyS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 02:54:18 -0400
Received: by mail-yb1-f202.google.com with SMTP id g9-20020a25ae490000b029052f9e5b7d3fso25524336ybe.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jun 2021 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+mHueS6XQQ0bYEG0FWWm1sQjelvw0uwp+bumwTE9gIs=;
        b=KtTTr7yH4H5Yn0j6hAC+HMJslKwB+AsVe2tnb8mAgNv0IXH56AIZO9EHiley8kl+Tu
         tkrIv1yunuVjoY6tscrY2PzSraaYV31/69Yl4oyifHWfOEZolwCDbDHhmaIJtMs+p8T4
         6kjvV2/7R6HNdXhts3Bej6q1gLCuYUOuOCwXzL2rW3cyf38f2HPn5UnQj1T8+tyqIMVN
         glpF/NTfvYNdpXzB14yfLIfiSkQMxW7NA8F8yPtkmt+thHaDXbzNz6wvi9ATOZylNR53
         p8HRHQlC67MfiBYm3Ptu2vHAlcGuX7nLvlknaQK41OtWghJ4TK3maSUajQLkKHxSyYFI
         ycJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+mHueS6XQQ0bYEG0FWWm1sQjelvw0uwp+bumwTE9gIs=;
        b=tuPaTziJbbQZT6CFl/xlF0EqKpolAQ729ROjNVb8MXm3QTMvKOF6dgKOxim9Nq9qzI
         xo/IWFvsj9K5Hk6UJ9aFaJuvzEXTk/iaRb7g+cElV/4Okkr/+59DaFMX8MrqgZ549WSF
         vHSmx1QGBf7zhOkhoSTBm8NOZuoBhxS4nitrD1iMeoY3sFIr/QKKJAbxbVuOFxIwmWu3
         dZNTXBbQXAGmH1zI9Ih2wVsUPqih3cyz/ysXaSENQ6AKThaobgjML29EqyKFPHn53ifp
         88S5LaWaoqVfLrFKqHSwh8WkWq9JSyb1C7RLKW6/0fCo9X/8tJfRXTLaUb+0k71sJOp8
         BzOA==
X-Gm-Message-State: AOAM532EAlhZpWn01HvKT0j9pwaSGW0AUBQTQuJQsjTq7Q73XmNbF/jU
        h72ud0Oxdjxj/0TPS45pgrHaT4alLp+a5A==
X-Google-Smtp-Source: ABdhPJzRmlSprcaFk7V319oNoQf7/v+DbzaXNgalr0FDTksLpqxZT6bcFh3qn8dfZfsY5XYvz5U6I75NdlA+ug==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:868:b4e3:8c14:177d])
 (user=davidgow job=sendgmr) by 2002:a25:1455:: with SMTP id
 82mr29369098ybu.403.1623135075148; Mon, 07 Jun 2021 23:51:15 -0700 (PDT)
Date:   Mon,  7 Jun 2021 23:51:11 -0700
In-Reply-To: <20210608064852.609327-1-davidgow@google.com>
Message-Id: <20210608065111.610297-1-davidgow@google.com>
Mime-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 3/4] kunit: test: Add example tests which are always skipped
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
---
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
2.32.0.rc1.229.g3e70b5a671-goog

