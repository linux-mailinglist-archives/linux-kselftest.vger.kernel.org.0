Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9FCEE7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJGVg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 17:36:59 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35272 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGVg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 17:36:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id 10so16438114qka.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QgTMZr2OmUuabe3KIXb9kNyafQ3k3yHDnTZLSW+zfsk=;
        b=PQMklxXaaFN1hpmS0B4NAJed0s83JXAM9YRYx4QPO6yrbi3EyxadcvX5R6zW91q4BF
         lUrD+AL5nFH6XLzZUhG2CxVgdQhb/6xuve7HVi5HWmQZL7IrZKxAcuS3XqVzSvnVOXLw
         2uXv8BfTV+FuGxW3Vt+rWQpGgoxfAa1LZw0yGV34FT7l1/rYxNXWVx4d7eX2XQHWMrnJ
         vEd/FGhA0+MM4knqbjzkMhtDQN/K62FoBy+2nVddVOQd/PMWQyU+wTysxEDWYnmc9npj
         CnLOfU3HosSbdHKO227nSusWOhTlh0miDCFGFLi2AWl6dNE+gI8xU99+hLUy5YsJ4uB0
         GjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QgTMZr2OmUuabe3KIXb9kNyafQ3k3yHDnTZLSW+zfsk=;
        b=WuDE8lZF6fvitgA5pdb8oRAXdW9DY5MI8XqGpyfSg1gNQ2oR5WuJWBCYn/4ThzChDa
         B39CjZl3VsS6UizND4RdKATm7ACiKnyrFR3e4jySUr60fdAMfa0fT3WBtZO7pzb0e5q1
         +XQ612Daw5NVH7bK8XZMiRv7zzHFSTv31pYtYvs6wFOJwQdbukLtXSpUtcC/hdXfVza9
         SwWEA9U7CQLFgVrS3+6bN/UyV4TIF5ozZqb1kRusxg5UJSwrnhFnTMAWHYrNOGE4uFIB
         d7gH0GcAN/qh99jSCrHU5C95C/bBMEmPe3+5oCSLGyqfvqgg9CIkCT6rBqKQgiJAddbG
         v/zQ==
X-Gm-Message-State: APjAAAVK1VhMFB+/Z7Zv/IO/aJKxmwxyo9y9vUlMck1mqEUo2g6wsK4b
        0HRzYetOFT7DaGjYpaL3uNirIIzCxuddHQ==
X-Google-Smtp-Source: APXvYqxZZRNk5m/SHt8x4Y7FFyHLCzmJGABTXIi+WNbGw1K82bNMkIv8Qud43BeypC2n98+VmbtQMmT8tdk50g==
X-Received: by 2002:ac8:1e1a:: with SMTP id n26mr33274499qtl.357.1570484216336;
 Mon, 07 Oct 2019 14:36:56 -0700 (PDT)
Date:   Mon,  7 Oct 2019 14:36:33 -0700
Message-Id: <20191007213633.92565-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] lib/list-test: add a test for the 'list' doubly linked list
From:   David Gow <davidgow@google.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change adds a KUnit test for the kernel doubly linked list
implementation in include/linux/list.h

Note that, at present, it only tests the list_ types (not the
singly-linked hlist_), and does not yet test all of the
list_for_each_entry* macros (and some related things like
list_prepare_entry).

This change depends on KUnit, so should be merged via the 'test' branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Kconfig.debug |  12 +
 lib/Makefile      |   3 +
 lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 726 insertions(+)
 create mode 100644 lib/list-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a3017a5dadcd..60691c0aac3e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1961,6 +1961,18 @@ config SYSCTL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config LIST_TEST
+	bool "KUnit Test for Kernel Linked-list stuctures"
+	depends on KUNIT
+	help
+	  This builds the linked list unit test, which runs on boot.
+	  It tests that the API and basic functionality of the list_head type
+	  and associated macros.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index bba1fd5485f7..309e174ee35d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
 obj-$(CONFIG_OBJAGG) += objagg.o
+
+# KUnit tests
+obj-$(CONFIG_LIST_TEST) += list-test.o
diff --git a/lib/list-test.c b/lib/list-test.c
new file mode 100644
index 000000000000..f333e8b0d9fe
--- /dev/null
+++ b/lib/list-test.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include <linux/list.h>
+
+struct list_test_struct {
+	int data;
+	struct list_head list;
+};
+
+static void list_init_test(struct kunit *test)
+{
+	/* Test the different ways of initialising a list. */
+	struct list_head list1 = LIST_HEAD_INIT(list1);
+	struct list_head list2;
+	LIST_HEAD(list3);
+
+	INIT_LIST_HEAD(&list2);
+
+	/* list_empty_careful() checks both next and prev. */
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list3));
+}
+
+static void list_add_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add(&a, &list);
+	list_add(&b, &list);
+
+	/* should be [list] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void list_add_tail_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* should be [list] -> a -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a);
+	KUNIT_EXPECT_PTR_EQ(test, a.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, a.next, &b);
+}
+
+static void list_del_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_del(&a);
+
+	/* now: [list] -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+}
+
+static void list_replace_test(struct kunit *test)
+{
+	struct list_head a_old, a_new, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a_old, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a_old -> b */
+	list_replace(&a_old, &a_new);
+
+	/* now: [list] -> a_new -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+}
+
+static void list_replace_init_test(struct kunit *test)
+{
+	struct list_head a_old, a_new, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a_old, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a_old -> b */
+	list_replace_init(&a_old, &a_new);
+
+	/* now: [list] -> a_new -> b */
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
+
+	/* check a_old is empty (initialized) */
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a_old));
+}
+
+static void list_swap_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_swap(&a, &b);
+
+	/* after: [list] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, &b, list.next);
+	KUNIT_EXPECT_PTR_EQ(test, &a, list.prev);
+
+	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
+	KUNIT_EXPECT_PTR_EQ(test, &list, b.prev);
+
+	KUNIT_EXPECT_PTR_EQ(test, &list, a.next);
+	KUNIT_EXPECT_PTR_EQ(test, &b, a.prev);
+}
+
+static void list_del_init_test(struct kunit *test)
+{
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
+static void list_move_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+	list_add_tail(&b, &list2);
+
+	/* before: [list1] -> a, [list2] -> b */
+	list_move(&a, &list2);
+	/* after: [list1] empty, [list2] -> a -> b */
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
+
+	KUNIT_EXPECT_PTR_EQ(test, &a, list2.next);
+	KUNIT_EXPECT_PTR_EQ(test, &b, a.next);
+}
+
+static void list_move_tail_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+	list_add_tail(&b, &list2);
+
+	/* before: [list1] -> a, [list2] -> b */
+	list_move_tail(&a, &list2);
+	/* after: [list1] empty, [list2] -> b -> a */
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
+
+	KUNIT_EXPECT_PTR_EQ(test, &b, list2.next);
+	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
+}
+
+static void list_bulk_move_tail_test(struct kunit *test)
+{
+	struct list_head a, b, c, d, x, y;
+	struct list_head *list1_values[] = { &x, &b, &c, &y };
+	struct list_head *list2_values[] = { &a, &d };
+	struct list_head *ptr;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&x, &list1);
+	list_add_tail(&y, &list1);
+
+	list_add_tail(&a, &list2);
+	list_add_tail(&b, &list2);
+	list_add_tail(&c, &list2);
+	list_add_tail(&d, &list2);
+
+	/* before: [list1] -> x -> y, [list2] -> a -> b -> c -> d */
+	list_bulk_move_tail(&y, &b, &c);
+	/* after: [list1] -> x -> b -> c -> y, [list2] -> a -> d */
+
+	list_for_each(ptr, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list1_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 4);
+	i = 0;
+	list_for_each(ptr, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list2_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 2);
+}
+
+static void list_is_first_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	KUNIT_EXPECT_TRUE(test, list_is_first(&a, &list));
+	KUNIT_EXPECT_FALSE(test, list_is_first(&b, &list));
+}
+
+static void list_is_last_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	KUNIT_EXPECT_FALSE(test, list_is_last(&a, &list));
+	KUNIT_EXPECT_TRUE(test, list_is_last(&b, &list));
+}
+
+static void list_empty_test(struct kunit *test)
+{
+	struct list_head a;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, list_empty(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty(&list2));
+}
+
+static void list_empty_careful_test(struct kunit *test)
+{
+	struct list_head a;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+
+	list_add_tail(&a, &list1);
+
+	KUNIT_EXPECT_FALSE(test, list_empty_careful(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_rotate_left_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+
+	/* before: [list] -> a -> b */
+	list_rotate_left(&list);
+	/* after: [list] -> b -> a */
+
+	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void list_rotate_to_front_test(struct kunit *test)
+{
+	struct list_head a, b, c, d;
+	struct list_head *list_values[] = { &c, &d, &a, &b };
+	struct list_head *ptr;
+	LIST_HEAD(list);
+	int i = 0;
+
+	list_add_tail(&a, &list);
+	list_add_tail(&b, &list);
+	list_add_tail(&c, &list);
+	list_add_tail(&d, &list);
+
+	/* before: [list] -> a -> b -> c -> d */
+	list_rotate_to_front(&c, &list);
+	/* after: [list] -> c -> d -> a -> b */
+
+	list_for_each(ptr, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, ptr, list_values[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 4);
+}
+
+static void list_is_singular_test(struct kunit *test)
+{
+	struct list_head a, b;
+	LIST_HEAD(list);
+
+	/* [list] empty */
+	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
+
+	list_add_tail(&a, &list);
+
+	/* [list] -> a */
+	KUNIT_EXPECT_TRUE(test, list_is_singular(&list));
+
+	list_add_tail(&b, &list);
+
+	/* [list] -> a -> b */
+	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
+}
+
+static void list_cut_position_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut_position(&list2, &list1, &entries[1]);
+	/* after: [list2] -> entries[0] -> entries[1], [list1] -> entries[2] */
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 2);
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
+static void list_cut_before_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list1);
+
+	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
+	list_cut_before(&list2, &list1, &entries[1]);
+	/* after: [list2] -> entries[0], [list1] -> entries[1] -> entries[2] */
+
+	list_for_each(cur, &list2) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+}
+
+static void list_splice_test(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice(&list2, &entries[1]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_splice_tail_test(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_tail(&list2, &entries[4]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_splice_init_test(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_init(&list2, &entries[1]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_splice_tail_init_test(struct kunit *test)
+{
+	struct list_head entries[5], *cur;
+	LIST_HEAD(list1);
+	LIST_HEAD(list2);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list1);
+	list_add_tail(&entries[1], &list1);
+	list_add_tail(&entries[2], &list2);
+	list_add_tail(&entries[3], &list2);
+	list_add_tail(&entries[4], &list1);
+
+	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
+	list_splice_tail_init(&list2, &entries[4]);
+	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
+
+	list_for_each(cur, &list1) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 5);
+
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+}
+
+static void list_entry_test(struct kunit *test)
+{
+	struct list_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));
+}
+
+static void list_first_entry_test(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	static LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list, struct list_test_struct, list));
+}
+
+static void list_last_entry_test(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	static LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list, struct list_test_struct, list));
+}
+
+static void list_first_entry_or_null_test(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	static LIST_HEAD(list);
+
+	KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list, struct list_test_struct, list));
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry_or_null(&list, struct list_test_struct, list));
+}
+
+static void list_next_entry_test(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	static LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1, list));
+}
+
+static void list_prev_entry_test(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	static LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2, list));
+}
+
+static void list_for_each_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list);
+	int i = 0;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+}
+
+static void list_for_each_prev_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur;
+	LIST_HEAD(list);
+	int i = 2;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_prev(cur, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		i--;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, -1);
+}
+
+static void list_for_each_safe_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur, *n;
+	LIST_HEAD(list);
+	int i = 0;
+
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		list_del(&entries[i]);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
+}
+
+static void list_for_each_prev_safe_test(struct kunit *test)
+{
+	struct list_head entries[3], *cur, *n;
+	LIST_HEAD(list);
+	int i = 2;
+
+	list_add_tail(&entries[0], &list);
+	list_add_tail(&entries[1], &list);
+	list_add_tail(&entries[2], &list);
+
+	list_for_each_prev_safe(cur, n, &list) {
+		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
+		list_del(&entries[i]);
+		i--;
+	}
+
+	KUNIT_EXPECT_EQ(test, i, -1);
+}
+
+static void list_for_each_entry_test(struct kunit *test)
+{
+	struct list_test_struct entries[5], *cur;
+	static LIST_HEAD(list);
+	int i = 0;
+
+	for (i = 0; i < 5; ++i) {
+		entries[i].data = i;
+		list_add_tail(&entries[i].list, &list);
+	}
+
+	i = 0;
+
+	list_for_each_entry(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i++;
+	}
+}
+
+static void list_for_each_entry_reverse_test(struct kunit *test)
+{
+	struct list_test_struct entries[5], *cur;
+	static LIST_HEAD(list);
+	int i = 0;
+
+	for (i = 0; i < 5; ++i) {
+		entries[i].data = i;
+		list_add_tail(&entries[i].list, &list);
+	}
+
+	i = 4;
+
+	list_for_each_entry_reverse(cur, &list, list) {
+		KUNIT_EXPECT_EQ(test, cur->data, i);
+		i--;
+	}
+}
+
+static struct kunit_case list_test_cases[] = {
+	KUNIT_CASE(list_init_test),
+	KUNIT_CASE(list_add_test),
+	KUNIT_CASE(list_add_tail_test),
+	KUNIT_CASE(list_del_test),
+	KUNIT_CASE(list_replace_test),
+	KUNIT_CASE(list_replace_init_test),
+	KUNIT_CASE(list_swap_test),
+	KUNIT_CASE(list_del_init_test),
+	KUNIT_CASE(list_move_test),
+	KUNIT_CASE(list_move_tail_test),
+	KUNIT_CASE(list_bulk_move_tail_test),
+	KUNIT_CASE(list_is_first_test),
+	KUNIT_CASE(list_is_last_test),
+	KUNIT_CASE(list_empty_test),
+	KUNIT_CASE(list_empty_careful_test),
+	KUNIT_CASE(list_rotate_left_test),
+	KUNIT_CASE(list_rotate_to_front_test),
+	KUNIT_CASE(list_is_singular_test),
+	KUNIT_CASE(list_cut_position_test),
+	KUNIT_CASE(list_cut_before_test),
+	KUNIT_CASE(list_splice_test),
+	KUNIT_CASE(list_splice_tail_test),
+	KUNIT_CASE(list_splice_init_test),
+	KUNIT_CASE(list_splice_tail_init_test),
+	KUNIT_CASE(list_entry_test),
+	KUNIT_CASE(list_first_entry_test),
+	KUNIT_CASE(list_last_entry_test),
+	KUNIT_CASE(list_first_entry_or_null_test),
+	KUNIT_CASE(list_next_entry_test),
+	KUNIT_CASE(list_prev_entry_test),
+	KUNIT_CASE(list_for_each_test),
+	KUNIT_CASE(list_for_each_prev_test),
+	KUNIT_CASE(list_for_each_safe_test),
+	KUNIT_CASE(list_for_each_prev_safe_test),
+	KUNIT_CASE(list_for_each_entry_test),
+	KUNIT_CASE(list_for_each_entry_reverse_test),
+	{},
+};
+
+static struct kunit_suite list_test_module = {
+	.name = "list-test",
+	.test_cases = list_test_cases,
+};
+
+kunit_test_suite(list_test_module);
-- 
2.23.0.581.g78d2f28ef7-goog

