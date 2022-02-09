Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6244AE962
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 06:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiBIFiK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 00:38:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbiBIF2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 00:28:17 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E31C08E888
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 21:28:21 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so1037467plp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 21:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rZmcqq9wo8YnIT5ye21K0NZ6qO5uZQZ73lL6JC7iEz8=;
        b=V7pZi17UGh4z8xKEPrH1tHrUFmHaRAzvYAScVj9FqCzqJOPH1qxNvmVXTqmdmhDDja
         fSevxqTLIKSXGes2Bc2yGMwmn7vJl0vbrogVI02WbymmV4+O5pyInoUXAt1zZDRNXNhD
         z6epdNN7gu63acsXSIVLG/J0gBfUtBORK47KpxZN4ke2d9mQz/PmlvDccsPtR38X39Oq
         6y1+YimogJQnshvrmsxFNBfNa0FWZbz4Fd+udxylcO1TK9rUtlqZbPfVTmUqk2FT8fE7
         cC6zbqItrZi9fJeEySh/9QX8B+0DK8T/atnxM8CIqEO0AOqaa7lheUgGtPCgA2g42FVt
         AYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rZmcqq9wo8YnIT5ye21K0NZ6qO5uZQZ73lL6JC7iEz8=;
        b=TXf+cHr2OLSWysZsukz1JLIDielddkuEvW4wyMc7k3VT4RyClJmiCenl++iGyns9Nn
         A7CM+2vUtoWwIqiD07xCu2YERhIJtkv+9asEHP6uD7RKKHEdzBg254yupO20PDXm77QO
         7HfAW5XBJ5dq1YnyuvpFZPFA/9shwRLQHGIVIgO7ZpvPSzoc5AdAhNUc95W+E0Q/ZZX5
         k9oNlxJdQb9mxBxx+2YVXOQfGfrHGI/VflRELavil1RKhBZ2RN6jPyBa4Kis/C8TW7TN
         Q6H+Mye/f2eYt+09ex2xRvo+8vKqoKgLPs80UoEz2SGWSEMh8fKX/bvkKBfrlPADLmxy
         dD4g==
X-Gm-Message-State: AOAM532XuZ0P9Az4kW/Oi8sxKnG9sYM+00vQVtHd+pUP/1j1rpwAURIt
        heVoFy43QzTfbgixew+QqC+pdBMibXpjvQ==
X-Google-Smtp-Source: ABdhPJwyIfZyzDHRcKT+rTPIrUjaIig807SEciA4VZqtAc+0hggnYq8ijl+rHM47O4N+sK6xME3dZVt5hj3+aA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:24d:: with SMTP id
 j13mr545456plh.54.1644384500567; Tue, 08 Feb 2022 21:28:20 -0800 (PST)
Date:   Wed,  9 Feb 2022 13:28:11 +0800
Message-Id: <20220209052813.854014-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3 1/3] list: test: Add test for list_del_init_careful()
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
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

The list_del_init_careful() function was added[1] after the list KUnit
test. Add a very basic test to cover it.

Note that this test only covers the single-threaded behaviour (which
matches list_del_init()), as is already the case with the test for
list_empty_careful().

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6fe44d96fc1536af5b11cd859686453d1b7bfd1

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-1-davidgow@google.com/
- Fix the test calling list_del_init() instead of
  list_del_init_careful()
- Improve the comment noting we only test single-threaded behaviour.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
- Patch 1/3 unchanged
---
 lib/list-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..f82a3c7788b8 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,25 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* NOTE: This test only checks the behaviour of this function in
+	 * isolation. It does not verify memory model guarantees. */
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init_careful(&a);
+	/* after: [list] -> b, a initialised */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
+}
+
 static void list_test_list_move(struct kunit *test)
 {
 	struct list_head a, b;
@@ -707,6 +726,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
-- 
2.35.0.263.gb82422642f-goog

