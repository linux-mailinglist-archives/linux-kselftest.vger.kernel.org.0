Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB998D30F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJJS4g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 14:56:36 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45442 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJS4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 14:56:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id x31so5045234pgl.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=9+UVpgNk8CQF6QXtdJbLihVg7rPsY93dgpexzdrcZBM=;
        b=e5rwKwDyCHuxMh/rpdE9yzCyiQyoAb5ZJdJs2uW1ZvJe5q8RknWv9n+WoF1xQh7Wq/
         BxgnofU3/5A7cYQZGzaiIhRlXnWDXxbfHYYgqpMpuTVRXAANedK9PCTp+pbK2nmerOod
         klDLukc8qBeoe/ETX+rxVBblF63uAsNL5215ao0277drAXmnVOy1jw8O+UVgz6bWp/or
         UDf7LV+a5azay5zgSm+oxK2VyeFa79keyg79xQ3cC8fTPxxFyJqskzSeOoUo/qj18dUx
         mTinoRB6mZgQZ8+KNvW3s5IF08VmaKSpsexCcl/rIzDOr1HUhMNvRQy8+1oMj37FzTeD
         PtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=9+UVpgNk8CQF6QXtdJbLihVg7rPsY93dgpexzdrcZBM=;
        b=cIez8555ijvXo/3xrVeJbmWcg81foiDt8CvhE4HMBjyro5aWe3Bta3cspdtQl4pH2H
         z5SCam3EhgYnm1yXAWAfzjhv/7oKNVQpublx50DqeiAIJ3CExNc85B8MZ5gA7+wDWMJi
         cq4LzzaXxXbaQ0D7h4oNKpiTQ9RlH985QbuSQdZgm2QbwUZasNY54Foz2YeshfyRcAYt
         fNhkrjmF7FCjhtUXCSm0ihkSX5tDdtEUgdFD1ogCxuHYtkx48a6+Cu+4xNqxg2OO+Zle
         GnQ9CCYvuuV1S91f82fv6G4YwgU6a8nRMhZZMslEhdjWlzpJExdDBW/BITwSShdJbW7q
         Q4CA==
X-Gm-Message-State: APjAAAWpEF39EKpw7jsJCLzyXSG0ZcAFugwarL8Z0mTE8ua2HkqLDpga
        cdKXKlrbjbkGHIKDtG1cotwx6uHSSmvb2Q==
X-Google-Smtp-Source: APXvYqwm9yc/gW0K8N3S3+VgIiJgKpRAazFOfpIJC0PlC2fzNgvnu4G6viFzIssdRdA2EvP8Mm1jIS0pJq6MkA==
X-Received: by 2002:a63:d415:: with SMTP id a21mr12168545pgh.299.1570733794707;
 Thu, 10 Oct 2019 11:56:34 -0700 (PDT)
Reply-To: 20191007213633.92565-1-davidgow@google.com
Date:   Thu, 10 Oct 2019 11:56:31 -0700
Message-Id: <20191010185631.26541-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH linux-kselftest/test v2] lib/list-test: add a test for the
 'list' doubly linked list
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

Add a KUnit test for the kernel doubly linked list implementation in
include/linux/list.h

Each test case (list_test_x) is focused on testing the behaviour of the
list function/macro 'x'. None of the tests pass invalid lists to these
macros, and so should behave identically with DEBUG_LIST enabled and
disabled.

Note that, at present, it only tests the list_ types (not the
singly-linked hlist_), and does not yet test all of the
list_for_each_entry* macros (and some related things like
list_prepare_entry).

Signed-off-by: David Gow <davidgow@google.com>
---
Addressed the various comments on v1. The biggest change is the renaming
of all of the testcases from the form x_test to list_test_x. I'm not
super happy with how that looks (not the least because it ends up with
'list' twice), but it is more consistent with the proc/sysctl tests.


 MAINTAINERS       |   5 +
 lib/Kconfig.debug |  12 +
 lib/Makefile      |   3 +
 lib/list-test.c   | 738 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 758 insertions(+)
 create mode 100644 lib/list-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ef985e01457..9ccabdb25a26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9504,6 +9504,11 @@ F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
+LIST UNIT TEST
+M:	David Gow <davidgow@google.com>
+S:	Maintained
+F:	lib/list-test.c
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a3017a5dadcd..7b648141ff52 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1961,6 +1961,18 @@ config SYSCTL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config LIST_TEST
+	bool "KUnit Test for Kernel Linked-list structures"
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
index 000000000000..52522ba83a68
--- /dev/null
+++ b/lib/list-test.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the Kernel Linked-list structures.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+#include <kunit/test.h>
+
+#include <linux/list.h>
+
+struct list_test_struct {
+	int data;
+	struct list_head list;
+};
+
+static void list_test_list_init(struct kunit *test)
+{
+	/* Test the different ways of initialising a list. */
+	struct list_head list1 = LIST_HEAD_INIT(list1);
+	struct list_head list2;
+	LIST_HEAD(list3);
+	struct list_head *list4;
+	struct list_head *list5;
+
+	INIT_LIST_HEAD(&list2);
+
+	list4 = kzalloc(sizeof(*list4), 0);
+	INIT_LIST_HEAD(list4);
+
+	list5 = kmalloc(sizeof(*list5), 0);
+	memset(list5, 0xFF, sizeof(*list5));
+	INIT_LIST_HEAD(list5);
+
+	/* list_empty_careful() checks both next and prev. */
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list1));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list3));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(list4));
+	KUNIT_EXPECT_TRUE(test, list_empty_careful(list5));
+
+	kfree(list4);
+	kfree(list5);
+}
+
+static void list_test_list_add(struct kunit *test)
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
+static void list_test_list_add_tail(struct kunit *test)
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
+static void list_test_list_del(struct kunit *test)
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
+static void list_test_list_replace(struct kunit *test)
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
+static void list_test_list_replace_init(struct kunit *test)
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
+static void list_test_list_swap(struct kunit *test)
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
+static void list_test_list_del_init(struct kunit *test)
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
+static void list_test_list_move(struct kunit *test)
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
+static void list_test_list_move_tail(struct kunit *test)
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
+static void list_test_list_bulk_move_tail(struct kunit *test)
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
+static void list_test_list_is_first(struct kunit *test)
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
+static void list_test_list_is_last(struct kunit *test)
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
+static void list_test_list_empty(struct kunit *test)
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
+static void list_test_list_empty_careful(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
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
+static void list_test_list_rotate_left(struct kunit *test)
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
+static void list_test_list_rotate_to_front(struct kunit *test)
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
+static void list_test_list_is_singular(struct kunit *test)
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
+static void list_test_list_cut_position(struct kunit *test)
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
+static void list_test_list_cut_before(struct kunit *test)
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
+static void list_test_list_splice(struct kunit *test)
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
+static void list_test_list_splice_tail(struct kunit *test)
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
+static void list_test_list_splice_init(struct kunit *test)
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
+static void list_test_list_splice_tail_init(struct kunit *test)
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
+static void list_test_list_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct;
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));
+}
+
+static void list_test_list_first_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list, struct list_test_struct, list));
+}
+
+static void list_test_list_last_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list, struct list_test_struct, list));
+}
+
+static void list_test_list_first_entry_or_null(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list, struct list_test_struct, list));
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry_or_null(&list, struct list_test_struct, list));
+}
+
+static void list_test_list_next_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1, list));
+}
+
+static void list_test_list_prev_entry(struct kunit *test)
+{
+	struct list_test_struct test_struct1, test_struct2;
+	LIST_HEAD(list);
+
+	list_add_tail(&test_struct1.list, &list);
+	list_add_tail(&test_struct2.list, &list);
+
+
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2, list));
+}
+
+static void list_test_list_for_each(struct kunit *test)
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
+static void list_test_list_for_each_prev(struct kunit *test)
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
+static void list_test_list_for_each_safe(struct kunit *test)
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
+	KUNIT_EXPECT_TRUE(test, list_empty(&list));
+}
+
+static void list_test_list_for_each_prev_safe(struct kunit *test)
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
+	KUNIT_EXPECT_TRUE(test, list_empty(&list));
+}
+
+static void list_test_list_for_each_entry(struct kunit *test)
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
+	
+	KUNIT_EXPECT_EQ(test, i, 5);
+}
+
+static void list_test_list_for_each_entry_reverse(struct kunit *test)
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
+	
+	KUNIT_EXPECT_EQ(test, i, -1);
+}
+
+static struct kunit_case list_test_cases[] = {
+	KUNIT_CASE(list_test_list_init),
+	KUNIT_CASE(list_test_list_add),
+	KUNIT_CASE(list_test_list_add_tail),
+	KUNIT_CASE(list_test_list_del),
+	KUNIT_CASE(list_test_list_replace),
+	KUNIT_CASE(list_test_list_replace_init),
+	KUNIT_CASE(list_test_list_swap),
+	KUNIT_CASE(list_test_list_del_init),
+	KUNIT_CASE(list_test_list_move),
+	KUNIT_CASE(list_test_list_move_tail),
+	KUNIT_CASE(list_test_list_bulk_move_tail),
+	KUNIT_CASE(list_test_list_is_first),
+	KUNIT_CASE(list_test_list_is_last),
+	KUNIT_CASE(list_test_list_empty),
+	KUNIT_CASE(list_test_list_empty_careful),
+	KUNIT_CASE(list_test_list_rotate_left),
+	KUNIT_CASE(list_test_list_rotate_to_front),
+	KUNIT_CASE(list_test_list_is_singular),
+	KUNIT_CASE(list_test_list_cut_position),
+	KUNIT_CASE(list_test_list_cut_before),
+	KUNIT_CASE(list_test_list_splice),
+	KUNIT_CASE(list_test_list_splice_tail),
+	KUNIT_CASE(list_test_list_splice_init),
+	KUNIT_CASE(list_test_list_splice_tail_init),
+	KUNIT_CASE(list_test_list_entry),
+	KUNIT_CASE(list_test_list_first_entry),
+	KUNIT_CASE(list_test_list_last_entry),
+	KUNIT_CASE(list_test_list_first_entry_or_null),
+	KUNIT_CASE(list_test_list_next_entry),
+	KUNIT_CASE(list_test_list_prev_entry),
+	KUNIT_CASE(list_test_list_for_each),
+	KUNIT_CASE(list_test_list_for_each_prev),
+	KUNIT_CASE(list_test_list_for_each_safe),
+	KUNIT_CASE(list_test_list_for_each_prev_safe),
+	KUNIT_CASE(list_test_list_for_each_entry),
+	KUNIT_CASE(list_test_list_for_each_entry_reverse),
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
2.23.0.700.g56cf767bdb-goog

