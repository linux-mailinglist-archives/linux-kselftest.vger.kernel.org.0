Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34904C3BFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 03:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiBYCxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 21:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiBYCxq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 21:53:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EE278CAF
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 18:53:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g19-20020aa796b3000000b004e136dcec34so2313939pfk.23
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 18:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2puWIl3IcpbmEtDoBGd8mpwWXz/flgK5gtzvJt22Ibg=;
        b=V7A8Rb2FXvpOWQfWfzts5uMpUAXDUD+M3X+h/q51ZiFHnsqw6bhHOmPnaoE/ZY5iOQ
         C8orkMrqUIiLMxOLijz28b1G+810z04aGpYpY4X0pI3wqm7P/t7sWYKk1aXduo9gdbhw
         1RyDvYEIhp+V2Sa8MxaG/5Ur286JFCurw2fjxoe8oAj4IeSjVCCKYjadlmyL25pI9aNo
         SApjixcEDESi3VEHQZ6r++HehdafCfN2K3xj1eXCQ1+cM6e3EgyVe5mecBCKCOaQi8ut
         d8F+eBLvh2qcv4lPsWt+D65gG3/e8tGPx77ArCe2k0ONFiJ65/xXlcROmNm4FaBDWBfy
         Qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2puWIl3IcpbmEtDoBGd8mpwWXz/flgK5gtzvJt22Ibg=;
        b=SvIYatDKP24erhVnlGoUzCnCFCDq9tyRBEF7b7aBd8n3u0iN4CBzsCsy9hKAShcKJi
         3zNv1H8OedhwBx4ZGYqvMLVgzCMR8ZIbBqwTmnxLYL9KLyBIMKxw1xMvBbkWpE8oVjN1
         GqKmVwSeH/t0+NXsX6GBeUzAAwl2LjnmUWOzsa3ghqICK0pKGYofsCOtbUZ/5yWhVuxv
         7XUnDH2PFTX8rbSt84A7Tp1LvJ0hYc0b9YeqkYdSgSN/WH9GJFsEpPvNOpDcZNnjkS7q
         px2lIuDO7cuWqlXg3gBOH71wGPbJ1/AVVVRo2aLIMrWIzzdZrjcGfmSYkcsNYKtLiIAl
         liSw==
X-Gm-Message-State: AOAM532c3NrHZSrBMB7rxNx58+jDzyesF8oQl9YKjR5x0UJcOlLDspIR
        rKFrDiwXV4UIyQIfv8nQV8vLxiTTnJknFg==
X-Google-Smtp-Source: ABdhPJyAVL+KVNuKKmj4OCwnf0mb2V2caveapLa1ZAGZW4xhwAdHDu2wqfAIMOl8UrftyjkEAcI9bMuubXYhJw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP
 id mi18-20020a17090b4b5200b001bcb208dc5cmr139771pjb.1.1645757594543; Thu, 24
 Feb 2022 18:53:14 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:52:46 +0800
Message-Id: <20220225025247.1888244-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 1/3] list: test: Add test for list_del_init_careful()
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes since v3:
https://lore.kernel.org/lkml/20220209052813.854014-1-davidgow@google.com/
- Fix a comment style issue.
- Add Reviewed-by tags.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-1-davidgow@google.com/
- Fix the test calling list_del_init() instead of
  list_del_init_careful()
- Improve the comment noting we only test single-threaded behaviour.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
- Patch 1/3 unchanged
---
 lib/list-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..302b7382bff4 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,26 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* NOTE: This test only checks the behaviour of this function in
+	 * isolation. It does not verify memory model guarantees.
+	 */
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
@@ -707,6 +727,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
-- 
2.35.1.574.g5d30c73bfb-goog

