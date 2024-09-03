Return-Path: <linux-kselftest+bounces-17072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1AE96AA73
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462272821D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767201D223D;
	Tue,  3 Sep 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN2lNTdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDE1D5891;
	Tue,  3 Sep 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399641; cv=none; b=q+jy6dSlwZXXFFawCaHpUPWEJO7Swo2goAVUAbNTjeTKtphVGm0txq8xKYXl7dU/ADX0FN7aSH0aocyINT96rJr4OnpA+Rss8eP+diIkrsCGX6MKwKHU+WoQABC0th9mGEcMblsEssJx3eBGqIajjAkdrVpJNZL1ydRB562GGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399641; c=relaxed/simple;
	bh=qnomJCLvVtF8f+qx3fNZZxi0tIn96cMXjmUErjLpmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgGm5yvkFYD3Vg8i5W/LmF+uO9J1HscndwkgYnzUrbYekpAk9rXmXsFt280iHvW7Pn9kgUzxIidlBvkKuBf7yljzhHFDCabMHh5i4zE5fL7Sma8hW5Kuvb0x6frXjz9tf7OMgQ3smCKoT7VRj8kyFtLwnoXdsXZrWgGBxpYOOFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN2lNTdT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d86f713557so3164696a91.2;
        Tue, 03 Sep 2024 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725399639; x=1726004439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+fJap+X8qN/9fnhn2J+/mVQg1Exd8on5U1Vz/Ah3lc=;
        b=cN2lNTdTIGolAEe6m2vumKJchk+nykEsR1k6QbtaYUIUOZj23t9dT6NRFPot7S8opu
         qatDuhU4CLp9NTGgFLC6YD4JVBs/3G2ZGdudZXO48wQ4yPKIyTAU7r8/MXfLIPwtgMex
         uFeUO1cDexbbmb1K6AidT4mSrHMLD8Q11JtMUAbeMKW1NzdxA+DjsfHt44f5xT1cwf1i
         5xYZaokw9BQxxT2m5rtRk8YgCraVc/IDBQ0XMARudxV3jlvAHx53MDpeODaRGybb4FhI
         jcthe/8aAhMf0BiOgRttWwYwsZly48tflcokIeJ3i4m4A7yrqKlEt8vtT6Bwr91MEbO3
         Hnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399639; x=1726004439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+fJap+X8qN/9fnhn2J+/mVQg1Exd8on5U1Vz/Ah3lc=;
        b=boMA7OvPsnfWM87O6e2BF2SaGDqeAJwMFhEDdVzpMvqlkYGVCC/f+iHbTikiuAgCw1
         aZesFcJxuW6eilJDRtUvrtYiDsJTmX9a8JdGNjk5d3GRfWu/M10AERG9CSsdT2sABltK
         md0/kqP1xSOASyvNYmG7y93PPXaeam0PPz3PAiaC5Vz+AqkQUE2YXu8EpX3sMvEX6VLs
         hzxT6nwSD/ZqOhRCi0ldjDqiHv9GZfzUdpE+pgaRgz/T+j6hgDQGIIfrLBEHOt2PM42e
         cVjmZLS0itDnctohvBOwHScCvQtXbe85ZgGj5UrsabdwUy09I/DJWxhzoqazQQTaHFzD
         swCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT2Gp5Wb2Tmn0/BgZE3MjVrBAlWbB6UNplnkTbHKmt7iJeseuYPW3kIPM54e1ifYWFsNdHMHUUV+K+IXOrn9vX@vger.kernel.org, AJvYcCUYp01rBeyyriwoqZYJvD1qo7TVw9F4BkX7jaOygoLZNXgoG7qr0h8NcsaFRoLCcY2ABEX0lLsu2qbFhhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAgrKgqMSLlbuxnNz88mFKoFmOqbEsAeX9N2KgEMOm1cy2DfR
	AK0HDSGAMttjHiy45e8ovXm+zT9IAcdSvIFUzPTPOodF71U3xti9
X-Google-Smtp-Source: AGHT+IGS8y412iA96GRVbq8ZXvtVWoHoZHkJl09OSyvOsc9/h98BXxJ/3btCWcAKrB50rTWnt0JOEw==
X-Received: by 2002:a17:90b:3006:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2d8904c6ea8mr10540124a91.1.1725399638803;
        Tue, 03 Sep 2024 14:40:38 -0700 (PDT)
Received: from arch.. ([2804:1b3:a700:a499:26ee:9aff:fe39:f350])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3864csm2699525ad.141.2024.09.03.14.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:40:38 -0700 (PDT)
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
Subject: [PATCH v2 1/1] lib/llist_kunit.c: add KUnit tests for llist
Date: Tue,  3 Sep 2024 18:40:27 -0300
Message-ID: <20240903214027.77533-2-arturacb@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903214027.77533-1-arturacb@gmail.com>
References: <20240903214027.77533-1-arturacb@gmail.com>
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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/list-test.c?h=v6.11-rc6

Signed-off-by: Artur Alves <arturacb@gmail.com>
---
 lib/Kconfig.debug       |  11 ++
 lib/tests/Makefile      |   1 +
 lib/tests/llist_kunit.c | 361 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 lib/tests/llist_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..b2725daccc52 100644
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
+	  This option builds the "llist_kunit" test module that
+	  helps to verify the correctness of the functions and
+	  macros defined in (<linux/llist.h>).
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
index 000000000000..f273c0d175c7
--- /dev/null
+++ b/lib/tests/llist_kunit.c
@@ -0,0 +1,361 @@
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for the llist data structure.");
-- 
2.46.0


