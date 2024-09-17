Return-Path: <linux-kselftest+bounces-18059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582AC97AA0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 02:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5981F27918
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67A611E;
	Tue, 17 Sep 2024 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzJvTO5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E6168DA;
	Tue, 17 Sep 2024 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726534289; cv=none; b=Xj8emTzKubLBFbpCipHGlpJVLlCAlnHUPX9WroNuRh3aHaXzhEh0b/Xr5e1flIhCr8V1yUgVL/WFynCghL4SCj0y9pEZDHk/hfVEw+JMSaF03wmiGewJWrCxiaJyc7VcLo4Ow2ZmFtf16z0q0XUEMC4nn0fVvU5rdXHli2NcQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726534289; c=relaxed/simple;
	bh=Psypxuwd1H4rkSHfUpEbmruI5bc8W4XFS+SN9ouGJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bstxwe1YaxuzhqqRBSSf390TFtcYSy6BL/tEgnA03sZR+vHBZgiIdngO8X+L9xNynZGUUPlJn/rQVXc81/x1Rg6atFiJkT86YVjRVKTawpQaHNN1j8MpoZHiJ9kKNZtdRORYJuqAsK7VhjYY1UBqH+FetFs8qBC1PK+/CVK0tHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzJvTO5Q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068acc8b98so45229635ad.3;
        Mon, 16 Sep 2024 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726534287; x=1727139087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2XQmOxpcr/79eGurR6EvXFCrh0sbO+Q/xNEOLJbiHM=;
        b=QzJvTO5QKXxMEa14R2iW3R9chF+vyjxIFxU4UV44DQSS54Z1PSiAHD9dOT/3K9M96M
         pidNxDyCDgONLSZbX9K6I+rMBgY4hp05dRgfkUMzUh3QzezG096TBvaulWtFfAr4h5wM
         NKbCqQCdK8jFtX39YLtOANL+AcEcQuyHOPoabXg/YYF75j9FcM9DqYP+wcAP17uXKFqx
         G9XYkuSk3UeSdEPYxB1wD2zl7Oq370anecmOBrGXK+7qyXdFjyIF0k9/VcbpsIEfVjZx
         jxLnZ3eUvniJho032lTsuZEEYcM3Dk3Km1SGGXTsEBBGTeIjpZyZ8DeuPn+W2cZTJybN
         fUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726534287; x=1727139087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2XQmOxpcr/79eGurR6EvXFCrh0sbO+Q/xNEOLJbiHM=;
        b=dwwtIERbRBW66iQmwJp31Bo674LSTLgDh1fYQglzzD6GoFrDKAi3l3NgT2Pj49YUsT
         l+Hr+45ff85Oce5E1B5INlh+tL6rhLbqnbCgkThL4VAgiPlIcyrNMPrDYPrRZgWxmkDU
         As5cuv+9tdntFhIlhaGj0aGgd0np5rcz40cIbR0UDeOkcejlLbWBDoEkoIt0USwxllXp
         j1IkBndrEE6e6OAe/0ofMbLG5xzp2mHBi8b4o50T2tCGJNkW1JwqZQiuHOtO4wRZ5jFR
         fyTiqHWaAedn5APMH5Px08QiIe+IBOFzClU3PUei1HGDL/nTrr2ffa/LvWBA/uq9zZld
         oSjA==
X-Forwarded-Encrypted: i=1; AJvYcCVHeqrN3QvO3DCYcmvyjxKX6IWSoDC3QhKFOQZBzL/nwwJp19lgD6Ar+QuBhHGh1MH+sNOkQPee4Wa+L4wzWa3N@vger.kernel.org, AJvYcCWQzVZbaNi5CflwmfCEGdep6jeZNfJwGjzUpAkIO4AtpGVyGKms4jK6EnHI/faqLXDuNkQwZ3Lsfdco0NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3P0LIVPONWlS9Ue4bfrcBIQHOuOe6s/i1R1t17MK+2ppGuFKf
	ElHRqiUa/QwahILi+zs41aTgmMZLISfv0RaHmTdKJ4ka5e+ogLFQ
X-Google-Smtp-Source: AGHT+IGh8UHeJoobB7RVdy2rU2F7HxNi0bnWw3jhO7IS2pydHAPdoFrtJuq+dwogOW1YMH86eVFTsA==
X-Received: by 2002:a17:903:2306:b0:206:cfb3:92e0 with SMTP id d9443c01a7336-2076e355576mr228202885ad.17.1726534287468;
        Mon, 16 Sep 2024 17:51:27 -0700 (PDT)
Received: from arch.. ([143.106.58.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fddsm41714925ad.82.2024.09.16.17.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:51:27 -0700 (PDT)
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
	diego.daniel.professional@gmail.com
Subject: [PATCH v3 1/1] lib/llist_kunit.c: add KUnit tests for llist
Date: Mon, 16 Sep 2024 21:51:16 -0300
Message-ID: <20240917005116.304090-2-arturacb@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917005116.304090-1-arturacb@gmail.com>
References: <20240917005116.304090-1-arturacb@gmail.com>
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
linked in lib/list-test.c. Each test case (llist_test_x) tests
the behaviour of the llist function/macro 'x'.

Signed-off-by: Artur Alves <arturacb@gmail.com>
---
 lib/Kconfig.debug       |  11 ++
 lib/tests/Makefile      |   1 +
 lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 lib/tests/llist_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b5696659f027..f6bd98f8ce2b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2813,6 +2813,17 @@ config USERCOPY_KUNIT_TEST
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
+config LLIST_KUNIT_TEST
+	tristate "KUnit tests for lib/llist" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds the llist (lock-less list) KUnit test suite.
+	  It tests the API and basic functionality of the macros and
+	  functions defined in <linux/llist.h>.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index c6a14cc8663e..8d7c40a73110 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -34,4 +34,5 @@ CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
+obj-$(CONFIG_LLIST_KUNIT_TEST) += llist_kunit.o
 
diff --git a/lib/tests/llist_kunit.c b/lib/tests/llist_kunit.c
new file mode 100644
index 000000000000..817bb2948697
--- /dev/null
+++ b/lib/tests/llist_kunit.c
@@ -0,0 +1,358 @@
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
+	int i = 0, j = 0;
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
+	/* traversing deleted nodes */
+	deleted_nodes = llist_del_all(&llist);
+
+	llist_for_each(pos, deleted_nodes) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[j++]);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, j);
+}
+
+static void llist_test_safe_for_each(struct kunit *test)
+{
+	struct llist_node entries[ENTRIES_SIZE];
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
+static void llist_test_entry_for_each(struct kunit *test)
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
+static void llist_test_entry_safe_for_each(struct kunit *test)
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
+	struct llist_node entries[ENTRIES_SIZE], *pos, *reversed_llist;
+	LLIST_HEAD(llist);
+	int i = 0;
+
+	for (int i = 0; i < ENTRIES_SIZE; i++)
+		llist_add(&entries[i], &llist);
+
+	/* before [List] -> entries[2] -> entries[1] -> entries[0] */
+	reversed_llist = llist_reverse_order(llist_del_first(&llist));
+
+	/* should be [List] -> entries[0] -> entries[1] -> entries[2] */
+	llist_for_each(pos, reversed_llist) {
+		KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
+	}
+
+	KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
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
+	KUNIT_CASE(llist_test_safe_for_each),
+	KUNIT_CASE(llist_test_entry_for_each),
+	KUNIT_CASE(llist_test_entry_safe_for_each),
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for the llist data structure.");
-- 
2.46.0


