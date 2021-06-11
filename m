Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8723A3C9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFKHKL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 03:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKHKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 03:10:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA4C0613A3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 00:08:13 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ea18-20020ad458b20000b0290215c367b5d3so18328225qvb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AxYDSx1W326c/2AyjpxnRpJtEiakxWyplUUfpgkOn8E=;
        b=jq+1isH9k+dHyRsbX6VVekzvYSv1oG214o5mvppdopGqmbQEFm9xSHWmX6xFjAeRWa
         S8hBswHxE8iiIa9Hr+aeWRlxQMVbr1e1pqOobSD3LJq+gPxHsIFpAl7+xm0NqwBhZx2i
         da/2vcsuWLdODTeblJMro6PF0CKq+M8sg3bst0ZqkvDCyBfFWlVftFplNSdPRDVL5C51
         zGTL3xLJ60/tKTkgSz6U2QLhn9X74wa8saIBs6fTsNj3CVW2N4JdZvKbhg/wjEfLrmGy
         OkQ+h/TxAEu6gsb+CJvGJr8OvY5ULtYxg7asf/03veiT0/ENfAo/WNK6fURqfKc9ZW7p
         fo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AxYDSx1W326c/2AyjpxnRpJtEiakxWyplUUfpgkOn8E=;
        b=XhRvUO+Zb5zy8wp/3Feiom3JFhm/XNM8h0F+vv5rO/H8LpN8mDq5DmFJeSvhR5hMs/
         t9nX9OxL5UrrcHZ2Au3m88U61ExrmMpROijQ5Y4mNK8YBY82N4YxPlTc8cmCMS5vKCw9
         w/QpeJhokFDf0hpEzkl+aJ0/ZQODBsJJTApI6LKYepYzP0udkcSgaYVrJVGQHPMjXm3x
         V5+IJrmO3wgu1FA1mFQFxUnRKDTQp4SltMYqK4HL8JRs4mOWLnuJAaSfkJkhu3qTFxQz
         Y9NFI6Y77B8zX2PjaEIkaAkfs4fAUzWmrOp+T0Zyf05BaVA7s8vUjtDerkPx1udzYdPe
         1tSA==
X-Gm-Message-State: AOAM531VpLVMqI0wMYpeayLH0vyPD2s6kre1+Djlw6YvZa4h1U80vtiV
        NTbWZdlj7eky3s+il5OhDn2ksAPHaiB6Fg==
X-Google-Smtp-Source: ABdhPJw/U/Im0QhLI9R0/SWqjK2HH4JF7Z6KaoqKeCXXRviGcjR/D3ZQqejJJ99ejngy+3rdX3xd3lSkYtbo8g==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:b697:a576:a25f:5b1e])
 (user=davidgow job=sendgmr) by 2002:a05:6214:1481:: with SMTP id
 bn1mr3425657qvb.1.1623395291462; Fri, 11 Jun 2021 00:08:11 -0700 (PDT)
Date:   Fri, 11 Jun 2021 00:08:01 -0700
In-Reply-To: <20210611070802.1318911-1-davidgow@google.com>
Message-Id: <20210611070802.1318911-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210611070802.1318911-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v4 3/4] kunit: test: Add example tests which are always skipped
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
2.32.0.272.g935e593368-goog

