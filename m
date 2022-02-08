Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A04AD002
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 05:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiBHEBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 23:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiBHEBw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 23:01:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56FC0401E5
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 20:01:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a251302000000b006118f867dadso32938314ybt.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 20:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+XmkWwkxZcBFnXp1LdOSslc7SXE79cZcwWCdKQ9aqB4=;
        b=gSLrSscicf63WBa+QXt1YmMRgTK6zeN7sj8vXSXPqm8QQDHA5o4Pn5sppkBMWCH2eQ
         Ruj5q8AhdYfY4Pzjm0atw94gM0suZOdIi57BejTDhRusGZjpOV7qYBDLQDUb3xlG5OaD
         0v0/+OOHd+0x2CiJjghNA05UypTxJQEdkyGgn/QEogTVLfuUMOoBaJEwwlvuwkdNGyXK
         AsAiIYZK35QUJJZJcYJhVu9qUmuAHvtoJp1CEqk7yBo9VemL9+27adqz0fFzWQNCD90e
         aN0glTYOxjsZB05tCF8QJxs4HYoDJBogN3K1bNhOLoPmeo6Y4VR9K74ittvA6qjtyRZm
         whkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+XmkWwkxZcBFnXp1LdOSslc7SXE79cZcwWCdKQ9aqB4=;
        b=UM1KK0YbHq1KfmV5twP5a0672Ryx9PNbHRKfcWx26CcgLf3YE3SJ2583g37HONBdkA
         XHBwzj5nRCoZBhAbk1HnFspOyf0Bg7d4TN2B2NDOG5mq7Y29EWxBDTdxDKVUU54WxkQP
         9eVHd6/vWG+09qDB4Fwh1hOtbUMj3rUKklbN1Pl03AjZoBRTBuQ0ToM3gvQHvcFEGZdW
         bx27X05+EHu+dB9LEBomdfmJ7+TZoNyHw2b/9p0rNkmiImcw921aJHVOYVC5OEDfqeDE
         txQ2Qszlci+24HLfArYmrxPeJaVLwcD0uraHhzMIgK4W9/CvpYqP7nzHONL8Czgiikej
         acYA==
X-Gm-Message-State: AOAM530uJ0dKi9hjleQNWhCR3lCoQSwXw/ZuM2DCGfRYF3RlENmDRPKe
        aM238Mln4Dr99AAza9pglz5aT/QqGL7DUQ==
X-Google-Smtp-Source: ABdhPJyMSA7NqD/FfD+yoNwPC4NdA4qhKUSPsVLL0GuhwkM7srn7XZfjhx0wpkMMlUdEj7GZsheX7uc3sfImCA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:34d0:: with SMTP id
 b199mr3143034ywa.385.1644292911231; Mon, 07 Feb 2022 20:01:51 -0800 (PST)
Date:   Tue,  8 Feb 2022 12:01:21 +0800
Message-Id: <20220208040122.695258-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2 1/3] list: test: Add test for list_del_init_careful()
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

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
- Patch 1/3 unchanged

---
 lib/list-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index ee09505df16f..976e9ae1f3c5 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -161,6 +161,24 @@ static void list_test_list_del_init(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
 }
 
+static void list_test_list_del_init_careful(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del_init(&a);
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
@@ -707,6 +725,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_replace_init),
 	KUNIT_CASE(list_test_list_swap),
 	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_del_init_careful),
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
-- 
2.35.0.263.gb82422642f-goog

