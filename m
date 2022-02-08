Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B74AD004
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 05:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbiBHECJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 23:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbiBHECI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 23:02:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399AC0401E9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 20:02:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so33047066ybi.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 20:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CxJP9WmKdhJPvihmm8sG8RGI+nXykzjS6eG2g1fovU8=;
        b=aTpA7d/2qmOZO32QUtSD6yTG0RdY1y10sUxuy8DAdgV6jsUvpRmy7giwqlY9hzgAAP
         MiAnm8NGbh8wBX3VGPsvZg07SVm4BZ2zN3qL5IV4Kkueqg7I4u725AahOYSvKlq8gG6w
         mdsNR53kxuZ8L/iRe/BVZuVKVcjCFvEatuVODOxrHcY8l5GT6VcmrgLM9Wjo0Z60DHBl
         Exn94S5UeSd37P1RDdYOmEGS7jHjq7Q/YXC3/VkPmP1HTp9zudjsyV3KJ390qNB+IQMN
         n1+UqVxzxhHsofrPK8ScBj9gNKPkFOWyw5d//CIFZqpje2C5WQOILtqsx5bdYTb8WLeK
         U0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CxJP9WmKdhJPvihmm8sG8RGI+nXykzjS6eG2g1fovU8=;
        b=cmJKbxsDLksEhyHSkm9wvMojsyQWKQdJk74ejSt8IWmHxHgviq3fxvfY0yFfIj2IUU
         zWqU8pgZBrVIEx/tFFJWqqOtBhM7oTZnRHNT3MDlJKMFM+SVPoJSdgjbp1PSjEmk2zGi
         COs3aHU5w0whsltgYztEsHRS30Fbe+GuFRNDWixCAHPep1rhp/foykCb540ojI6FrR7S
         e5OqnY+pQGwt6wQ8wOfK0TocfpMvccyBRRERDPtFyp5R1jf+vmk/+MvT6g5Khl5lZvCl
         ddJop6invsW/S441Kh0Oox31au7S5+cXFCTu7rH3RfW7t1zu/AdDkdP4S1TS+sa7CW5U
         M33w==
X-Gm-Message-State: AOAM533vnIBOoEUhm+EFchZJ8hDDyYsLsFu3LQqkfOZRStOYcZIqSQu5
        nEM1Y+tFzZCaGAU8d4bu33WVHxA3RVtYPQ==
X-Google-Smtp-Source: ABdhPJwfi9JlOMGPBk60WOI+gsv4Ug5ydFhcY73dbYBp19AibO1J+5xomc8gqDsUHdJyhCe/D9hiPBlo6ORobQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:100a:: with SMTP id
 w10mr3120727ybt.668.1644292926851; Mon, 07 Feb 2022 20:02:06 -0800 (PST)
Date:   Tue,  8 Feb 2022 12:01:23 +0800
In-Reply-To: <20220208040122.695258-1-davidgow@google.com>
Message-Id: <20220208040122.695258-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2 2/3] list: test: Add a test for list_is_head()
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

list_is_head() was added recently[1], and didn't have a KUnit test. The
implementation is trivial, so it's not a particularly exciting test, but
it'd be nice to get back to full coverage of the list functions.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220205061539.273330-2-davidgow@google.com/
- Test both non-head elements of the same list and head elements of
  different lists.

---
 lib/list-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 976e9ae1f3c5..1960615d1a9f 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -252,6 +252,23 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
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
+	KUNIT_EXPECT_TRUE(test, list_is_head(&a, &a));
+	/* Non-head element of same list */
+	KUNIT_EXPECT_FALSE(test, list_is_head(&a, &b));
+	/* Head element of different list */
+	KUNIT_EXPECT_FALSE(test, list_is_head(&a, &c));
+}
+
+
 static void list_test_list_is_first(struct kunit *test)
 {
 	struct list_head a, b;
@@ -729,6 +746,7 @@ static struct kunit_case list_test_cases[] = {
 	KUNIT_CASE(list_test_list_move),
 	KUNIT_CASE(list_test_list_move_tail),
 	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_head),
 	KUNIT_CASE(list_test_list_is_first),
 	KUNIT_CASE(list_test_list_is_last),
 	KUNIT_CASE(list_test_list_empty),
-- 
2.35.0.263.gb82422642f-goog

