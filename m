Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63A4CE373
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Mar 2022 08:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiCEHlT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Mar 2022 02:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCEHlT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Mar 2022 02:41:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6813685B
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Mar 2022 23:40:29 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lj1-20020a17090b344100b001bf2d53a2feso1901149pjb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Mar 2022 23:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0z4cW7xQIjrEk6UGLRBISAZmjF+6UzoRq23fiadGk7M=;
        b=KKvIgifkJCkbEu+hUZevxwXiTQUQhzYNgS8hQSlzxwKb+tIXBeCF0sSjyLwroIpM2g
         GqTwFGZlchnx8650ZBsuFX9rOmLfN/UPuebKFtjnC2bp1uNi1wiNqDaUTfDgMr05lQiR
         /YT72Z3fxmBOj9CiucF3ccUq3jUrfeW/TmSW8ZTqor7MKFS1lV5+VFADzSZU3gcbHf48
         AfyNarj70Vr531sBsFuGKED4bS9mC5UsR9kPEX2l5KCvauAkQB9ACnq+w34xFUkG3sR3
         cvm7yMEkrn9Yv7LXMDEuk11DMyjRK58GTS5FeK2VvwgXC07N5ZyhKLFEIMGKEV2Hm4dR
         7m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0z4cW7xQIjrEk6UGLRBISAZmjF+6UzoRq23fiadGk7M=;
        b=Xff7oPWqAqYJubNuxJaEjjxUTkDsIVt2DaTZhy7V/yxmmv+qXWFeDM0WUzItNzL8xh
         eDfV1vp4f8OsetPcqoBkXzXdqfUfXMZhxf4XHaxn8IHdkF+6byTGhh7IKEmeFSsJ/WLX
         32Gl2kE/lvwV+p551NIEExYSEnBeUE/Pn1tPVSb08AT3/ruKYzDIyPQfJZ6XDwXxk9ZW
         8kcYDghs35vwbXdhwVzQ8sceZtKP4HT4ivRhkZhQC9ElZS4A4yJAXQlo9YAzjkX1mV1O
         wxMm4cOh7yBwFywbzQ/fVtmFrEs/VZX7ixbt6GybKKLQ0sh8vvxyeNWJv5HyeRba6huf
         y89g==
X-Gm-Message-State: AOAM533OkLR97dWvbvntvVZek+jU7XqjzWXMY9HcG6MaC8DlIt+QSiaU
        5LDXvO5Ju3sOoTMSlGJXfl2Egor4WzHXLQ==
X-Google-Smtp-Source: ABdhPJyj0RRhMNhQYVGwLC7Bq2b+jp5t9Fr/iu2aB3MdHs47HYoUvQlbqwvptW3Z+UMl1ybrSy2Kew0c0pv40Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:b307:b0:1bd:37f3:f0fc with SMTP
 id d7-20020a17090ab30700b001bd37f3f0fcmr14615177pjr.132.1646466028769; Fri,
 04 Mar 2022 23:40:28 -0800 (PST)
Date:   Sat,  5 Mar 2022 15:40:20 +0800
Message-Id: <20220305074020.751309-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH] list: test: Test the hlist structure
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add KUnit tests to the hlist linked-list structure which is used by
hashtables. This should give coverage of every function and macro in
list.h, as well as (combined with the KUnit tests for the hash
functions) get very close to having tests for the hashtable structure.

The tests here mirror the existing list tests, and are found in a new
suite titled 'hlist'.

Signed-off-by: David Gow <davidgow@google.com>
---

Note that this patch has five checkpatch failures, all of which are
false positives due to the test functions being confused with uses of
the hlist_for_each* macros they're testing.

For example:
ERROR: that open brace { should be on the previous line
#274: FILE: lib/list-test.c:1046:
+static void hlist_test_for_each_safe(struct kunit *test)
+{

The same thing occurred with the list_ variants, and since this is a
one-off issue, it doesn't seem worth fixing in checkpatch.

 lib/list-test.c | 397 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 396 insertions(+), 1 deletion(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index 035ef6597640..d374cf5d1a57 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -804,6 +804,401 @@ static struct kunit_suite list_test_module = {
 	.test_cases = list_test_cases,
 };
 
-kunit_test_suites(&list_test_module);
+struct hlist_test_struct {
+	int data;
+	struct hlist_node list;
+};
+
+static void hlist_test_init(struct kunit *test)
+{
+	/* Test the different ways of initialising a list. */
+	struct hlist_head list1 = HLIST_HEAD_INIT;
+	struct hlist_head list2;
+	HLIST_HEAD(list3);
+	struct hlist_head *list4;
+	struct hlist_head *list5;
+
+	INIT_HLIST_HEAD(&list2);
+
+	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	INIT_HLIST_HEAD(list4);
+
+	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	memset(list5, 0xFF, sizeof(*list5));
+	INIT_HLIST_HEAD(list5);
+
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list2));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list3));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(list4));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(list5));
+
+	kfree(list4);
+	kfree(list5);
+}
+
+static void hlist_test_unhashed(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+
+	/* is unhashed by default */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed(&a));
+
+	hlist_add_head(&a, &list);
+
+	/* is hashed once added to list */
+	KUNIT_EXPECT_FALSE(test, hlist_unhashed(&a));
+
+	hlist_del_init(&a);
+
+	/* is again unhashed after del_init */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed(&a));
+}
+
+/* Doesn't test concurrency guarantees */
+static void hlist_test_unhashed_lockless(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+
+	/* is unhashed by default */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed_lockless(&a));
+
+	hlist_add_head(&a, &list);
+
+	/* is hashed once added to list */
+	KUNIT_EXPECT_FALSE(test, hlist_unhashed_lockless(&a));
+
+	hlist_del_init(&a);
+
+	/* is again unhashed after del_init */
+	KUNIT_EXPECT_TRUE(test, hlist_unhashed_lockless(&a));
+}
+
+static void hlist_test_del(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_behind(&b, &a);
+
+	/* before: [list] -> a -> b */
+	hlist_del(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.pprev, &list.first);
+}
+
+static void hlist_test_del_init(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_behind(&b, &a);
+
+	/* before: [list] -> a -> b */
+	hlist_del_init(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.pprev, &list.first);
+
+	/* a is now initialised */
+	KUNIT_EXPECT_PTR_EQ(test, a.next, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, a.pprev, NULL);
+}
+
+/* Tests all three hlist_add_* functions */
+static void hlist_test_add(struct kunit *test)
+{
+	struct hlist_node a, b, c, d;
+	HLIST_HEAD(list);
+
+	hlist_add_head(&a, &list);
+	hlist_add_head(&b, &list);
+	hlist_add_before(&c, &a);
+	hlist_add_behind(&d, &a);
+
+	/* should be [list] -> b -> c -> a -> d */
+	KUNIT_EXPECT_PTR_EQ(test, list.first, &b);
+
+	KUNIT_EXPECT_PTR_EQ(test, c.pprev, &(b.next));
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &c);
+
+	KUNIT_EXPECT_PTR_EQ(test, a.pprev, &(c.next));
+	KUNIT_EXPECT_PTR_EQ(test, c.next, &a);
+
+	KUNIT_EXPECT_PTR_EQ(test, d.pprev, &(a.next));
+	KUNIT_EXPECT_PTR_EQ(test, a.next, &d);
+}
+
+/* Tests both hlist_fake() and hlist_add_fake() */
+static void hlist_test_fake(struct kunit *test)
+{
+	struct hlist_node a;
+
+	INIT_HLIST_NODE(&a);
+
+	/* not fake after init */
+	KUNIT_EXPECT_FALSE(test, hlist_fake(&a));
+
+	hlist_add_fake(&a);
+
+	/* is now fake */
+	KUNIT_EXPECT_TRUE(test, hlist_fake(&a));
+}
+
+static void hlist_test_is_singular_node(struct kunit *test)
+{
+	struct hlist_node a, b;
+	HLIST_HEAD(list);
+
+	INIT_HLIST_NODE(&a);
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&a, &list));
+
+	hlist_add_head(&a, &list);
+	KUNIT_EXPECT_TRUE(test, hlist_is_singular_node(&a, &list));
+
+	hlist_add_head(&b, &list);
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&a, &list));
+	KUNIT_EXPECT_FALSE(test, hlist_is_singular_node(&b, &list));
+}
+
+static void hlist_test_empty(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list);
+
+	/* list starts off empty */
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+
+	hlist_add_head(&a, &list);
+
+	/* list is no longer empty */
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list));
+}
+
+static void hlist_test_move_list(struct kunit *test)
+{
+	struct hlist_node a;
+	HLIST_HEAD(list1);
+	HLIST_HEAD(list2);
+
+	hlist_add_head(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list2));
+	hlist_move_list(&list1, &list2);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list1));
+	KUNIT_EXPECT_FALSE(test, hlist_empty(&list2));
+
+}
+
+static void hlist_test_entry(struct kunit *test)
+{
+	struct hlist_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct,
+			    hlist_entry(&(test_struct.list),
+				struct hlist_test_struct, list));
+}
+
+static void hlist_test_entry_safe(struct kunit *test)
+{
+	struct hlist_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct,
+			    hlist_entry_safe(&(test_struct.list),
+				struct hlist_test_struct, list));
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL,
+			    hlist_entry_safe((struct hlist_node *)NULL,
+				struct hlist_test_struct, list));
+}
+
+static void hlist_test_for_each(struct kunit *test)
+{
+	struct hlist_node entries[3], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	hlist_add_head(&entries[0], &list);
+	hlist_add_behind(&entries[1], &entries[0]);
+	hlist_add_behind(&entries[2], &entries[1]);
+
+	hlist_for_each(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+}
+
+
+static void hlist_test_for_each_safe(struct kunit *test)
+{
+	struct hlist_node entries[3], *cur, *n;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	hlist_add_head(&entries[0], &list);
+	hlist_add_behind(&entries[1], &entries[0]);
+	hlist_add_behind(&entries[2], &entries[1]);
+
+	hlist_for_each_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		hlist_del(&entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+}
+
+static void hlist_test_for_each_entry(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	hlist_for_each_entry(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void hlist_test_for_each_entry_continue(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	/* We skip the first (zero-th) entry. */
+	i = 1;
+
+	cur = &entries[0];
+	hlist_for_each_entry_continue(cur, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		/* Stamp over the entry. */
+		cur->data = 42;
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	/* The first entry was not visited. */
+	KUNIT_EXPECT_EQ(test, entries[0].data, 0);
+	/* The second (and presumably others), were. */
+	KUNIT_EXPECT_EQ(test, entries[1].data, 42);
+}
+
+static void hlist_test_for_each_entry_from(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	cur = &entries[0];
+	hlist_for_each_entry_from(cur, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		/* Stamp over the entry. */
+		cur->data = 42;
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	/* The first entry was visited. */
+	KUNIT_EXPECT_EQ(test, entries[0].data, 42);
+}
+
+static void hlist_test_for_each_entry_safe(struct kunit *test)
+{
+	struct hlist_test_struct entries[5], *cur;
+	struct hlist_node *tmp_node;
+	HLIST_HEAD(list);
+	int i = 0;
+
+	entries[0].data = 0;
+	hlist_add_head(&entries[0].list, &list);
+	for (i = 1; i < 5; ++i) {
+		entries[i].data = i;
+		hlist_add_behind(&entries[i].list, &entries[i-1].list);
+	}
+
+	i = 0;
+
+	hlist_for_each_entry_safe(cur, tmp_node, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		hlist_del(&cur->list);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+	KUNIT_EXPECT_TRUE(test, hlist_empty(&list));
+}
+
+
+static struct kunit_case hlist_test_cases[] = {
+	KUNIT_CASE(hlist_test_init),
+	KUNIT_CASE(hlist_test_unhashed),
+	KUNIT_CASE(hlist_test_unhashed_lockless),
+	KUNIT_CASE(hlist_test_del),
+	KUNIT_CASE(hlist_test_del_init),
+	KUNIT_CASE(hlist_test_add),
+	KUNIT_CASE(hlist_test_fake),
+	KUNIT_CASE(hlist_test_is_singular_node),
+	KUNIT_CASE(hlist_test_empty),
+	KUNIT_CASE(hlist_test_move_list),
+	KUNIT_CASE(hlist_test_entry),
+	KUNIT_CASE(hlist_test_entry_safe),
+	KUNIT_CASE(hlist_test_for_each),
+	KUNIT_CASE(hlist_test_for_each_safe),
+	KUNIT_CASE(hlist_test_for_each_entry),
+	KUNIT_CASE(hlist_test_for_each_entry_continue),
+	KUNIT_CASE(hlist_test_for_each_entry_from),
+	KUNIT_CASE(hlist_test_for_each_entry_safe),
+	{},
+};
+
+static struct kunit_suite hlist_test_module = {
+	.name = "hlist",
+	.test_cases = hlist_test_cases,
+};
+
+kunit_test_suites(&list_test_module, &hlist_test_module);
 
 MODULE_LICENSE("GPL v2");
-- 
2.35.1.616.g0bdcbb4464-goog

