Return-Path: <linux-kselftest+bounces-13980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB779386B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 01:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154841F21151
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135D12E5D;
	Sun, 21 Jul 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTsB5dMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E4179AA;
	Sun, 21 Jul 2024 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605434; cv=none; b=XWNstT28wgKHtAYsvND+UjIJ94C92QdnMUK5EOhuSYRAeTGGNce67gZgazJeut5ukb2IQ7QZvV+ugj4CPY5wk3Fz31r34uLGCoIwWZmw9OXfyrjATJDDtRvZQVq+bmLCBRZ8y9GCmO2bg2cc8qLsDPdfoo+xXsVPDUHwzmklHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605434; c=relaxed/simple;
	bh=1wWDJqNEmIPFfAO9OaTgiM2MeGchMUsMd6nOehX/BMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWb6Lu7p4sW14rXw3ymdQZU49F6acf17naYsWeAdskNX+TUYSMrjdomrW7XlK1q25iMv50uXkrqYMMwNOCNLHu8Z/up33xn3ITFopK+fgCxg3RZHUUWg02a/Mpk4Jydc4MajuUHmnyLh0natl2e4Hr3pypR3OwrHgrFI94EUuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTsB5dMz; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7035b2947a4so1900000a34.3;
        Sun, 21 Jul 2024 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721605432; x=1722210232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1SdKUGS6FFvEfc8L/toMZif4CrI9algobiFkfFXzfI=;
        b=bTsB5dMz5IbGQev9XcCo3zwl5WO2HStEwLW/X1JzxAziwafR3rroT3CS/dOZ6V1eIM
         xWmdEEBsWnYzSCsNkJEuSby0bRgDuFTxAkv5PBQOY4wtcgSsFo4wSdNrnTMrEr+dUgie
         q3IIG6at+cLxJVUpQsRyN4Kio6zCmOxwyjptoAmxYYsHaFXBXD4r5LWr5QQKf05trmom
         fXCcfHtRv9H0Q2fVy4lfct/FPDyt7hXr/eDFkNbsShxViDEYBZE34UNV5Ikm6vHHwDCG
         EkOgTk6eNOgOad5fTlUWi3B8yLGQPVIw0JFIjqbWXTAEvnVFND0E9e7GRwSYRdEXF8ma
         ZZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721605432; x=1722210232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1SdKUGS6FFvEfc8L/toMZif4CrI9algobiFkfFXzfI=;
        b=a2XPYYXy52hQy8d53zljxSPM0iCQLe3znF/iRyPoTu+ZWoaEf5Fp66pvsn+sv9xiHr
         XFLxOn3UjGId7xg5CDic+VhGkNkDnqg2jRV9kIEFVyGyST2yDSDb6fHJunza5zo5IY3T
         8MaXx0aTi9YRLiLK5eRnzHudC1k8vUZUGxTFl/bPtl2DPwyr4XJYZ0B7bIjfw1qgYWA9
         zKyy00I4twzuB2zzzGA6I3Te6jOM1JYhEyyMNFjwYVLe46dgOfVp75+59RcDvGDFWgCu
         6EKJeZ8OpPMu/Kj3tSTJ7MZaW0Vk5w+Y1XaY/GD2KS3HtIFeYbD9pJG3Coauv10bqZy5
         Ckdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQxhr/bdsBLwpCz5xMdtyriXIdTH8UniFkRIPowPxo5N5nxBqRor4+bAD6Ci7jVivn85YKTZZvK6J0w1xTdgUxI2SduBVyOGlzwL0jiM0XexMF5nFGOsKG6qrlEtJmgquyfOQEDphubf3mOLGc
X-Gm-Message-State: AOJu0YzRPv0cm/oBJgXKP44WecHHRuwcPL1X8Qb62D9iyPotRsaNngvw
	KosSYZhiCr9KKsvFohkbpPMM6e9+N3y7JuMBy6I/C6yV6R1ecRo6
X-Google-Smtp-Source: AGHT+IHa+ntfP5lEgstzlbXclUqknnHiyNXSma+1WRyWXzROMvjE4b787fFidjKoBm5sOt8dNUfqcQ==
X-Received: by 2002:a05:6830:6483:b0:703:6578:8e2b with SMTP id 46e09a7af769-70900923ffcmr6016745a34.23.1721605431915;
        Sun, 21 Jul 2024 16:43:51 -0700 (PDT)
Received: from arch.. (201-13-54-228.dsl.telesp.net.br. [201.13.54.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d19c52a62sm1733025b3a.124.2024.07.21.16.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 16:43:51 -0700 (PDT)
From: Artur Alves <arturacb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: n@nfraprado.net,
	andrealmeid@riseup.net,
	vinicius@nukelet.com,
	diego.daniel.professional@gmail.com,
	Artur Alves <arturacb@gmail.com>
Subject: [PATCH 1/1] lib/llist_kunit.c: add KUnit tests for llist
Date: Sun, 21 Jul 2024 20:43:17 -0300
Message-ID: <20240721234317.7935-2-arturacb@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721234317.7935-1-arturacb@gmail.com>
References: <20240721234317.7935-1-arturacb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit tests for the llist data structure. They test the vast
majority of methods and macros defined in include/linux/llist.h.

These are inspired by the existing tests for the 'list' doubly
linked in lib/list-test.c [1]. Each test case (llist_test_x)
tests the behaviour of the llist function/macro 'x'.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c

Signed-off-by: Artur Alves <arturacb@gmail.com>
---
 lib/Kconfig.debug |  11 ++
 lib/Makefile      |   1 +
 lib/llist_kunit.c | 360 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+)
 create mode 100644 lib/llist_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 561e346f5cb0..f58649c6cce2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2811,6 +2811,17 @@ config USERCOPY_KUNIT_TEST
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
+config LLIST_KUNIT_TEST
+	tristate "KUnit tests for lib/llist" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds the "llist_kunit" test module that
+	  helps to verify the correctness of the functions and
+	  macros defined in (<linux/llist.h>).
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..da5ebe56c33c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -370,6 +370,7 @@ CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_LLIST_KUNIT_TEST) += llist_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
diff --git a/lib/llist_kunit.c b/lib/llist_kunit.c
new file mode 100644
index 000000000000..7ffe2e2428a3
--- /dev/null
+++ b/lib/llist_kunit.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the Kernel lock-less linked-list structure.
+ *
+ * Author: Artur Alves <arturacb@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/llist.h>
+
+#define ENTRIES_SIZE 3
+
+struct llist_test_struct {
+	int data;
+	struct llist_node node;
+};
+
+static void llist_test_init_llist(struct kunit *test)
+{
+	/* test if the llist is correctly initialized */
+	struct llist_head llist1 = LLIST_HEAD_INIT(llist1);
+	LLIST_HEAD(llist2);
+	struct llist_head llist3, *llist4, *llist5;
+
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist1));
+
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist2));
+
+	init_llist_head(&llist3);
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist3));
+
+	llist4 = kzalloc(sizeof(*llist4), GFP_KERNEL | __GFP_NOFAIL);
+	init_llist_head(llist4);
+	KUNIT_EXPECT_TRUE(test, llist_empty(llist4));
+	kfree(llist4);
+
+	llist5 = kmalloc(sizeof(*llist5), GFP_KERNEL | __GFP_NOFAIL);
+	memset(llist5, 0xFF, sizeof(*llist5));
+	init_llist_head(llist5);
+	KUNIT_EXPECT_TRUE(test, llist_empty(llist5));
+	kfree(llist5);
+}
+
+static void llist_test_init_llist_node(struct kunit *test)
+{
+	struct llist_node a;
+
+	init_llist_node(&a);
+
+	KUNIT_EXPECT_PTR_EQ(test, a.next, &a);
+}
+
+static void llist_test_llist_entry(struct kunit *test)
+{
+	struct llist_test_struct test_struct, *aux;
+	struct llist_node *llist = &test_struct.node;
+
+	aux = llist_entry(llist, struct llist_test_struct, node);
+	KUNIT_EXPECT_PTR_EQ(test, &test_struct, aux);
+}
+
+static void llist_test_add(struct kunit *test)
+{
+	struct llist_node a, b;
+	LLIST_HEAD(llist);
+
+	init_llist_node(&a);
+	init_llist_node(&b);
+
+	/* The first assertion must be true, given that llist is empty */
+	KUNIT_EXPECT_TRUE(test, llist_add(&a, &llist));
+	KUNIT_EXPECT_FALSE(test, llist_add(&b, &llist));
+
+	/* Should be [List] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, llist.first, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void llist_test_add_batch(struct kunit *test)
+{
+	struct llist_node a, b, c;
+	LLIST_HEAD(llist);
+	LLIST_HEAD(llist2);
+
+	init_llist_node(&a);
+	init_llist_node(&b);
+	init_llist_node(&c);
+
+	llist_add(&a, &llist2);
+	llist_add(&b, &llist2);
+	llist_add(&c, &llist2);
+
+	/* This assertion must be true, given that llist is empty */
+	KUNIT_EXPECT_TRUE(test, llist_add_batch(&c, &a, &llist));
+
+	/* should be [List] -> c -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, llist.first, &c);
+	KUNIT_EXPECT_PTR_EQ(test, c.next, &b);
+	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
+}
+
+static void llist_test_llist_next(struct kunit *test)
+{
+	struct llist_node a, b;
+	LLIST_HEAD(llist);
+
+	init_llist_node(&a);
+	init_llist_node(&b);
+
+	llist_add(&a, &llist);
+	llist_add(&b, &llist);
+
+	/* should be [List] -> b -> a */
+	KUNIT_EXPECT_PTR_EQ(test, llist_next(&b), &a);
+	KUNIT_EXPECT_NULL(test, llist_next(&a));
+}
+
+static void llist_test_empty_llist(struct kunit *test)
+{
+	struct llist_head llist = LLIST_HEAD_INIT(llist);
+	struct llist_node a;
+
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
+
+	llist_add(&a, &llist);
+
+	KUNIT_EXPECT_FALSE(test, llist_empty(&llist));
+}
+
+static void llist_test_llist_on_list(struct kunit *test)
+{
+	struct llist_node a, b;
+	LLIST_HEAD(llist);
+
+	init_llist_node(&a);
+	init_llist_node(&b);
+
+	llist_add(&a, &llist);
+
+	/* should be [List] -> a */
+	KUNIT_EXPECT_TRUE(test, llist_on_list(&a));
+	KUNIT_EXPECT_FALSE(test, llist_on_list(&b));
+}
+
+static void llist_test_del_first(struct kunit *test)
+{
+	struct llist_node a, b, *c;
+	LLIST_HEAD(llist);
+
+	llist_add(&a, &llist);
+	llist_add(&b, &llist);
+
+	/* before: [List] -> b -> a */
+	c = llist_del_first(&llist);
+
+	/* should be [List] -> a */
+	KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
+
+	/* del must return a pointer to llist_node b
+	 * the returned pointer must be marked on list
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, c, &b);
+	KUNIT_EXPECT_TRUE(test, llist_on_list(c));
+}
+
+static void llist_test_del_first_init(struct kunit *test)
+{
+	struct llist_node a, *b;
+	LLIST_HEAD(llist);
+
+	llist_add(&a, &llist);
+
+	b = llist_del_first_init(&llist);
+
+	/* should be [List] */
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
+
+	/* the returned pointer must be marked out of the list */
+	KUNIT_EXPECT_FALSE(test, llist_on_list(b));
+}
+
+static void llist_test_del_first_this(struct kunit *test)
+{
+	struct llist_node a, b;
+	LLIST_HEAD(llist);
+
+	llist_add(&a, &llist);
+	llist_add(&b, &llist);
+
+	llist_del_first_this(&llist, &a);
+
+	/* before: [List] -> b -> a */
+
+	// should remove only if is the first node in the llist
+	KUNIT_EXPECT_FALSE(test, llist_del_first_this(&llist, &a));
+
+	KUNIT_EXPECT_TRUE(test, llist_del_first_this(&llist, &b));
+
+	/* should be [List] -> a */
+	KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
+}
+
+static void llist_test_del_all(struct kunit *test)
+{
+	struct llist_node a, b;
+	LLIST_HEAD(llist);
+	LLIST_HEAD(empty_llist);
+
+	llist_add(&a, &llist);
+	llist_add(&b, &llist);
+
+	/* deleting from a empty llist should return NULL */
+	KUNIT_EXPECT_NULL(test, llist_del_all(&empty_llist));
+
+	llist_del_all(&llist);
+
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
+}
+
+static void llist_test_for_each(struct kunit *test)
+{
+	struct llist_node entries[ENTRIES_SIZE] = { 0 };
+	struct llist_node *pos, *deleted_nodes;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
+		llist_add(&entries[i], &llist);
+
+	/* before [List] -> entries[0] -> ... -> entries[ENTRIES_SIZE - 1] */
+	llist_for_each(pos, llist.first) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
+
+	i = 0;
+
+	/* traversing deleted nodes */
+	deleted_nodes = llist_del_all(&llist);
+
+	llist_for_each(pos, deleted_nodes) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
+}
+
+static void llist_test_for_each_safe(struct kunit *test)
+{
+	struct llist_node entries[ENTRIES_SIZE] = { 0 };
+	struct llist_node *pos, *n;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
+		llist_add(&entries[i], &llist);
+
+	llist_for_each_safe(pos, n, llist.first) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
+		llist_del_first(&llist);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
+}
+
+static void llist_test_for_each_entry(struct kunit *test)
+{
+	struct llist_test_struct entries[ENTRIES_SIZE], *pos;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
+		entries[i].data = i;
+		llist_add(&entries[i].node, &llist);
+	}
+
+	i = 0;
+
+	llist_for_each_entry(pos, llist.first, node) {
+		KUNIT_EXPECT_EQ(test, pos->data, i);
+		i++;
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
+}
+
+static void llist_test_for_each_entry_safe(struct kunit *test)
+{
+	struct llist_test_struct entries[ENTRIES_SIZE], *pos, *n;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
+		entries[i].data = i;
+		llist_add(&entries[i].node, &llist);
+	}
+
+	i = 0;
+
+	llist_for_each_entry_safe(pos, n, llist.first, node) {
+		KUNIT_EXPECT_EQ(test, pos->data, i++);
+		llist_del_first(&llist);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
+	KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
+}
+
+static void llist_test_reverse_order(struct kunit *test)
+{
+	struct llist_node entries[3], *pos, *reversed_llist;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	llist_add(&entries[0], &llist);
+	llist_add(&entries[1], &llist);
+	llist_add(&entries[2], &llist);
+
+	/* before [List] -> entries[2] -> entries[1] -> entries[0] */
+	reversed_llist = llist_reverse_order(llist_del_first(&llist));
+
+	/* should be [List] -> entries[0] -> entries[1] -> entrires[2] */
+	llist_for_each(pos, reversed_llist) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
+	}
+
+	KUNIT_EXPECT_EQ(test, 3, i);
+}
+
+static struct kunit_case llist_test_cases[] = {
+	KUNIT_CASE(llist_test_init_llist),
+	KUNIT_CASE(llist_test_init_llist_node),
+	KUNIT_CASE(llist_test_llist_entry),
+	KUNIT_CASE(llist_test_add),
+	KUNIT_CASE(llist_test_add_batch),
+	KUNIT_CASE(llist_test_llist_next),
+	KUNIT_CASE(llist_test_empty_llist),
+	KUNIT_CASE(llist_test_llist_on_list),
+	KUNIT_CASE(llist_test_del_first),
+	KUNIT_CASE(llist_test_del_first_init),
+	KUNIT_CASE(llist_test_del_first_this),
+	KUNIT_CASE(llist_test_del_all),
+	KUNIT_CASE(llist_test_for_each),
+	KUNIT_CASE(llist_test_for_each_safe),
+	KUNIT_CASE(llist_test_for_each_entry),
+	KUNIT_CASE(llist_test_for_each_entry_safe),
+	KUNIT_CASE(llist_test_reverse_order),
+	{}
+};
+
+static struct kunit_suite llist_test_suite = {
+	.name = "llist",
+	.test_cases = llist_test_cases,
+};
+
+kunit_test_suite(llist_test_suite);
+
+MODULE_LICENSE("GPL v2");
-- 
2.45.2


