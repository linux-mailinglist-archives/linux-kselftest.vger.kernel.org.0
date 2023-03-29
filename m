Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D06CD830
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 13:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC2LIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC2LIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 07:08:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1D1710
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 04:07:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so150948267b3.11
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680088078;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qLE8CWrmaNXgXCg2eNFOgeW6xHNyRTGjnMFCzItSd5A=;
        b=Aob7ge9ZtEBOKmu461YXtMVZ/sAukHmCRbKP6dMeCycttYKk3qU6Jad/XnVJcxhkR9
         u95tIOinC9eOx8dGDdYDKRGl7xopgJSnwxASP2J09IiR8fhmo1ezd8pvi5ZlRfJncZsX
         7RaLGXYDz9+K8zMUrZ7YrhP89w+OXWG//7XUS5Zgw7/8Vxol9vXx34ek83kawzepgS38
         VrcLKQYXJKqliJsKaGOmHuZitygaZDCbRHzkC1hwsVlCNrgbkgczRkxfiyzZ7+i9ETIq
         CI7cqCgbOc2BoLiCRL6pVTcBRtkbQVGZbIVLjDWmkWX9TW6imq5Xfq1fm1SKjacpLZbA
         7gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLE8CWrmaNXgXCg2eNFOgeW6xHNyRTGjnMFCzItSd5A=;
        b=pIsjo2x53EskJ3LpjUwcDxUm8dW3rY93Q3KQHb2LfNePEU5CLcMxlcQhjRTFZT4HTS
         c/IGFybqLuqU5xSNMfhZ1BPKCVSrJPYePsOYWFLY6C0Wzl5vP9OiRFBwUlNRaUmmsSMM
         MUb4vVxSluuGttmyrXCAgpEZy4kckKttIppbFeo/kLXxOSrj17zsfYTlVumy2T3p2SDX
         wOKVFgMP+2p3lf0oZ6mXRfwjq98KxOglxzLCXc2FV7BT/xI4HGEKpjD9rN/vEvbbSTVF
         fi/DSjwcSW/WeuqK3mHOdoEhJsMgSXXtx2QAkFjyRWb+ahTB6It1IsZfiieT9K2vLLBv
         wElQ==
X-Gm-Message-State: AAQBX9dj8BbuOsxzZaCF6UgxXnR/9XFISXyMkpEeZOQpv4YciCmtXISQ
        ZfxexYpU+WTTf32iR6z/oJDtn3J8r2RnLLa+
X-Google-Smtp-Source: AKy350ZYgvwaYrYxW4St3GTPmqThmwm4W46Naie1JY6mHAA8lhucU4GKj49jr/vcyUgjmMzqOu/vNKKFu4reiR5R
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a25:d7ce:0:b0:b7d:e643:d3c3 with SMTP
 id o197-20020a25d7ce000000b00b7de643d3c3mr2897717ybg.8.1680088078456; Wed, 29
 Mar 2023 04:07:58 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:07:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329110723.3458843-1-sadiyakazi@google.com>
Subject: [PATCH v1] list: test: Test the klist structure
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add KUnit tests to the klist linked-list structure.
These perform testing for different variations of node add
and node delete in the klist data structure (<linux/klist.h>).

Limitation: Since we use a static global variable, and if
multiple instances of this test are run concurrently, the test may fail.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
 lib/list-test.c | 298 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 297 insertions(+), 1 deletion(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index d374cf5d1a57..af651cacb8f4 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 
 #include <linux/list.h>
+#include <linux/klist.h>
 
 struct list_test_struct {
 	int data;
@@ -1199,6 +1200,301 @@ static struct kunit_suite hlist_test_module = {
 	.test_cases = hlist_test_cases,
 };
 
-kunit_test_suites(&list_test_module, &hlist_test_module);
+
+struct klist_test_struct {
+	int data;
+	struct klist klist;
+	struct klist_node klist_node;
+};
+
+/* counts the number of nodes*/
+static int node_count;
+static struct klist_node *last_node_count;
+
+static void check_node(struct klist_node *node_ptr)
+{
+	node_count++;
+	last_node_count = node_ptr;
+}
+
+static void check_delete_node(struct klist_node *node_ptr)
+{
+	node_count--;
+	last_node_count = node_ptr;
+}
+
+static void klist_test_add_tail(struct kunit *test)
+{
+	struct klist_node a, b;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_tail(&a, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 1);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &a);
+
+	klist_add_tail(&b, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 2);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &b);
+
+	/* should be [list] -> a -> b */
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_head(struct kunit *test)
+{
+	struct klist_node a, b;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 1);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &a);
+
+	klist_add_head(&b, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 2);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &b);
+
+	/* should be [list] -> b -> a */
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_behind(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	klist_add_head(&b, &mylist);
+
+	klist_add_behind(&c, &a);
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
+
+	klist_add_behind(&d, &b);
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
+
+	klist_iter_init(&mylist, &i);
+
+	/* should be [list] -> b -> d -> a -> c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_before(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	klist_add_head(&b, &mylist);
+	klist_add_before(&c, &a);
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
+
+	klist_add_before(&d, &b);
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
+
+	klist_iter_init(&mylist, &i);
+
+	/* should be [list] -> b -> d -> a -> c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+/* Verify that klist_del() delays the deletion of a node until there
+ * are no other references to it
+ */
+static void klist_test_del_refcount_greater_than_zero(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	/* Advance the iterator to point to node c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+
+	/* Try to delete node c while there is a reference to it*/
+	klist_del(&c);
+
+	/*
+	 * Verify that node c is still attached to the list even after being
+	 * deleted. Since the iterator still points to c, the reference count is not
+	 * decreased to 0
+	 */
+	KUNIT_EXPECT_TRUE(test, klist_node_attached(&c));
+
+	/* Check that node c has not been removed yet*/
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
+
+	klist_iter_exit(&i);
+
+	/* Since the iterator is no longer pointing to node c, node c is removed
+	 * from the list
+	 */
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
+
+}
+
+/* Verify that klist_del() deletes a node immediately when there are no
+ * other references to it.
+ */
+static void klist_test_del_refcount_zero(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+	/* Delete node c*/
+	klist_del(&c);
+
+	/* Check that node c is deleted from the list*/
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
+
+	/* Should be [list] -> a -> b -> d*/
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_remove(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+	/* Delete node c*/
+	klist_remove(&c);
+
+	/* Check the nodes in the list*/
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
+
+	/* should be [list] -> a -> b -> d*/
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_node_attached(struct kunit *test)
+{
+	struct klist_node a = {};
+	struct klist mylist;
+
+	klist_init(&mylist, NULL, NULL);
+
+	KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
+	klist_add_head(&a, &mylist);
+	KUNIT_EXPECT_TRUE(test, klist_node_attached(&a));
+	klist_del(&a);
+	KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
+
+}
+
+static struct kunit_case klist_test_cases[] = {
+	KUNIT_CASE(klist_test_add_tail),
+	KUNIT_CASE(klist_test_add_head),
+	KUNIT_CASE(klist_test_add_behind),
+	KUNIT_CASE(klist_test_add_before),
+	KUNIT_CASE(klist_test_del_refcount_greater_than_zero),
+	KUNIT_CASE(klist_test_del_refcount_zero),
+	KUNIT_CASE(klist_test_remove),
+	KUNIT_CASE(klist_test_node_attached),
+	{},
+};
+
+static struct kunit_suite klist_test_module = {
+	.name = "klist",
+	.test_cases = klist_test_cases,
+};
+
+kunit_test_suites(&list_test_module, &hlist_test_module, &klist_test_module);
 
 MODULE_LICENSE("GPL v2");
-- 
2.40.0.348.gf938b09366-goog

