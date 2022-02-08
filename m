Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975524AD007
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 05:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbiBHECT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 23:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbiBHECT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 23:02:19 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C664C0401F2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 20:02:18 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 68-20020a621547000000b004c74bbd2819so8711432pfv.18
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bOOyAGeDCfZ5ARPFOfUdicpQjmM40zAiAN4IAXCAr1w=;
        b=Qe9jHwp67T/2rtU3YnWRGt23KuxYuhClrpZS/9iEuqVpfhFbv0LU/Whse5mKOonQtp
         5BJAgro1lSUXcuajv/2iCIGNDqNOU9ju+Jk1ocaWvN8uVcu9iUohh12uKaOBbQ8tAIvG
         I3F3ygIhBC3BTW55WTyV7ooZ46zy/Ia3wFUoJvlHejD+Sjluo/lxtN4Tk+B/u0j0vtbH
         BQ62gmReBl/flHQWLc9xgF65HjOX+4q4I8kelAVbZUj9xn84ow9gbC0se2fiWKNL+Tz0
         jvuqqc+99wXowg1SpuWj0lv/614wK7MxL1VjlFnVvqlT8iDEnw051rw0lptj7qvyRiUB
         LcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bOOyAGeDCfZ5ARPFOfUdicpQjmM40zAiAN4IAXCAr1w=;
        b=NbyPLKSdJ1mZP1w4dfFi9zlPYzvYFrT1En1jcM8awP3ScoD0qJgWk4KfgapJGA3OV6
         q/opB8wCwpP7rBVpOKwRw3zsXOfLaycpHNnsyWzc6b7MKZBNPpXde4KK/u48kyA1vWT9
         sSWFhaHjeoqsY/VEDYKfnCBZx2xb1SmsnAHN3V2Hb5xKGAQg9N5JDpcShWr75og33NfP
         ATtYcTk5ZSGZ0ehM3gqviXNW5pIeqvL0wyvlDeDs93JxlE/MRV3Ez9mOe8j+kUS6Etlo
         0X5ajtyxyMFFvIFjqjT+uL3p7NcASCPKApzUK7+WschJIFM1v9NORHNQZNCYICXLyzcG
         UxRA==
X-Gm-Message-State: AOAM5316MuMXb1xxW5j6EbX/kYQ+OC40h44MpwgE9/l1+5kS5uPIYbFI
        mXrSdcW6jT/lBfLr7UJeO84tdCKVlvkYwQ==
X-Google-Smtp-Source: ABdhPJwQX7dVSP0gMLBZgYP13J+vjOvNbh4RSr0wLnEiLAEFWdMT+ZtFLOBZcsSPlyL8pBBIsNgxs3AV+TH99w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:5503:: with SMTP id
 b3mr2328282pji.187.1644292937742; Mon, 07 Feb 2022 20:02:17 -0800 (PST)
Date:   Tue,  8 Feb 2022 12:01:24 +0800
In-Reply-To: <20220208040122.695258-1-davidgow@google.com>
Message-Id: <20220208040122.695258-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2 3/3] list: test: Add a test for list_entry_is_head()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The list_entry_is_head() macro was added[1] after the list KUnit tests,
so wasn't tested. Add a new KUnit test to complete the set.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e130816164e244b692921de49771eeb28205152d

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-3-davidgow@google.com/
- Rework the test entirely to better match the improved list_is_head()
  test.

---
 lib/list-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 1960615d1a9f..80dd14c4ca1f 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -546,6 +546,22 @@ static void list_test_list_entry(struct kunit *test)
 				struct list_test_struct, list));
 }
 
+static void list_test_list_entry_is_head(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2, test_struct3;
+
+	INIT_LIST_HEAD(&test_struct1.list);
+	INIT_LIST_HEAD(&test_struct3.list);
+
+	list_add_tail(&test_struct2.list, &test_struct1.list);
+
+	KUNIT_EXPECT_TRUE(test, list_entry_is_head((&test_struct1), &test_struct1.list, list));
+	/* Non-head element of same list */
+	KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct2), &test_struct1.list, list));
+	/* Head element of different list */
+	KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct3), &test_struct1.list, list));
+}
+
 static void list_test_list_first_entry(struct kunit *test)
 {
 	struct list_test_struct test_struct1, test_struct2;
@@ -761,6 +777,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_splice_init),
 	KUNIT_CASE(list_test_list_splice_tail_init),
 	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_entry_is_head),
 	KUNIT_CASE(list_test_list_first_entry),
 	KUNIT_CASE(list_test_list_last_entry),
 	KUNIT_CASE(list_test_list_first_entry_or_null),
-- 
2.35.0.263.gb82422642f-goog

