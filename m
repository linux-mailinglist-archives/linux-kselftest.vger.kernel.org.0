Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38B54C3BF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiBYCyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 21:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiBYCyJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 21:54:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BAA278CB4
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 18:53:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a255607000000b00621afc793b8so1940159ybb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1JSYgi+oTGL4l294PnzZ502FNsmaxeRtZnvR904tj6U=;
        b=mxgk6tcHgsg2Pw4mDUim3HZH9kmRTfjI4cl0J6ChHJhFGp58/j755dpPkQ7Ig5hMT5
         RJWKLv74Lr2SS0UtgecaaAlvgp0uWV60nQa+5lI5vVhH7XjOa0zU0jqScTOoJMrRFLAo
         +NrHZ0FGQdnW2f7NKYEhlkqi01se19MNL5BUzrvp33IWcoT8lKkWZnlbKqKM0ex42P6/
         eAb4tsarKkhASieo18Si3OUx1JL7oUwDuRkGZWEvXcNRtxPET5r7Bdm5MRu5A+ZwEPEz
         t23FQFSJYBWoMHr9uimcgcdZc9Y1NDx6IKU89vbDTqb58ikkpcTh8m32LCEfgmcjaosG
         iQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1JSYgi+oTGL4l294PnzZ502FNsmaxeRtZnvR904tj6U=;
        b=LMYAfmt0R6s5yrcYOiRVI3voTcpR0d6yan0VKROMaineF1k7AApnqeuM551fW16M56
         HcYh6ugHXUpKm7qmsYJt4BKmbRoMNyl/yYJolYPt3x0kQ76C3DVyal6YfdymY22zbqJk
         o9Mt0DB5OpVSXUXTbh4TOUl+6KrdW3mBMqCvi1AIqOsZTOGJEQO2/qRrBasP2jRaomkn
         a6FpRDfo+nP+2k2e7HQwSgubGoCXLPfg7aMqDZ0SYJhZBy367GDRhZQhj+t4LotpqfEb
         QesK9U28WF+lj6M/7tcZ5y2GVLaLcW1EyuilTNaNLI/t5Y8goHBd4FShqTstOOKNglG2
         df9w==
X-Gm-Message-State: AOAM530ujrHiSfjDytW6tePtVAlq3SSJZqATCMIJRxAE2SHc6xJj9+Jc
        mrulgwW0C0MMhUs8j6NbWHLsWu5M3VPpmA==
X-Google-Smtp-Source: ABdhPJyXLhiVRmQq6TxnG5H67PgQrDXUmQO++OuwW0lLgq81reTtItb19csaR4kyWBDKHiV/rO2J9G/+LfKihQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a5b:9cc:0:b0:61d:f7ba:7fc with SMTP id
 y12-20020a5b09cc000000b0061df7ba07fcmr5113388ybq.434.1645757617802; Thu, 24
 Feb 2022 18:53:37 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:52:48 +0800
In-Reply-To: <20220225025247.1888244-1-davidgow@google.com>
Message-Id: <20220225025247.1888244-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220225025247.1888244-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 2/3] list: test: Add a test for list_is_head()
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

list_is_head() was added recently[1], and didn't have a KUnit test. The
implementation is trivial, so it's not a particularly exciting test, but
it'd be nice to get back to full coverage of the list functions.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes since v3:
https://lore.kernel.org/lkml/20220209052813.854014-2-davidgow@google.com/
- Add Reviewed-by tags.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220208040122.695258-2-davidgow@google.com/
- Use the _MSG variants of the assert macros, as suggested by Daniel
  Latypov.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-2-davidgow@google.com/
- Test both non-head elements of the same list and head elements of
  different lists.

---
 lib/list-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 302b7382bff4..3870ebfd84aa 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -254,6 +254,24 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
+static void list_test_list_is_head(struct kunit *test)
+{
+	struct list_head a, b, c;
+
+	/* Two lists: [a] -> b, [c] */
+	INIT_LIST_HEAD(&a);
+	INIT_LIST_HEAD(&c);
+	list_add_tail(&b, &a);
+
+	KUNIT_EXPECT_TRUE_MSG(test, list_is_head(&a, &a),
+		"Head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &b),
+		"Non-head element of same list");
+	KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &c),
+		"Head element of different list");
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -731,6 +749,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
-- 
2.35.1.574.g5d30c73bfb-goog

