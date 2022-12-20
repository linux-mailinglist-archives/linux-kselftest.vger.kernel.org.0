Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CF651979
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 04:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiLTDQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 22:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTDQV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 22:16:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3213F15
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 19:16:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b0af5bcbd3so129551517b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 19:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O38uW0vTxSxK8tvIH6taDalP5oh7NUvMww4e0LxgzMs=;
        b=W6TYVAsdFdjy72l6R3z+9WaVEobO2ZdQYioXrCcpwEqRjSKSt1AN0ptWIKS4zt5UTM
         +8mcMy8SFmM5FmMwjATQiwm9RpEpPJ80th954wJk9iM7vqs7eoKgyI6qtONNh0l+q1Bl
         r2LMs3ZV2pNyKaXcVEPuIalAlGb9dviug5nP1bLklMamurRwyKlocGkgTyOUPgvrE7sD
         nCwKQN4V2hOTwzesir6wWD5TN15/RHq0FM3lMwV5/3ZX9cGW6wPbKdEM5YIsuZw0pW4E
         bs/VLssn/VJVLOT/lxDYaSBBd63tQn2tCXyoCWnzZRtDiAWSnmo8RzNAkVpuNUnz6lRr
         HYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O38uW0vTxSxK8tvIH6taDalP5oh7NUvMww4e0LxgzMs=;
        b=gGAoFvMDCjHqLb/p90D0sSNWv08s5OWjnwh86j0UGvI85H9DheszMyZmDFJFmJXtsZ
         hX9tkDDdMz3yvuKm5H8qgPYZ9WVMy+v66RRe8ywIkcNEL3siygNL3ISrezIqWMyiOXuR
         OXEAzskHUBno7Wzqkwol8ehzRZJ8jjMsOg1NNmc6Q0PlKOM1s3Yd1yThjTlZrYhzeR+7
         cKGHAN54zJzQDCElkYkJgUnPd9s5SlxoLGvLr1P9GNc7hN4z0+GQR6K30+71t+fzdGwb
         G0NPgwykU6p9ALyrF8mNjw70037Y4phnu/AYkALX+VfeprfEwjCvhehaZFd1lKjzUdSX
         oueg==
X-Gm-Message-State: ANoB5pnyVAez9ODgEgp7IPYq/kBDzRUURAXxH4IMo+UPQTUTvf7JB4N5
        A1BoTacGd7Z9v23xo8LeRvjt/v2GSw==
X-Google-Smtp-Source: AA0mqf7+SG9QQr4ChEZ4sKnDsdIMCafLEqYtXNPlq5Zd9ywRMyIS5oHpyA9F1UOhkEf7zH4WKHITKlccvw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:9ac7:0:b0:708:c3d2:a2bd with SMTP id
 t7-20020a259ac7000000b00708c3d2a2bdmr12152865ybo.138.1671506179087; Mon, 19
 Dec 2022 19:16:19 -0800 (PST)
Date:   Tue, 20 Dec 2022 03:10:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220031023.197178-1-rmoar@google.com>
Subject: [PATCH v1] lib/hashtable_test.c: add test for the hashtable structure
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a KUnit test for the kernel hashtable implementation in
include/linux/hashtable.h.

Note that this version does not yet test each of the rcu
alternative versions of functions.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Note: The check patch script is outputting open brace errors on lines
154, 186, 231 of lib/hashtable_test.c but I believe the format of the
braces on those lines is consistent with the Linux Kernel style guide.
Will continue to look at these errors.

 lib/Kconfig.debug    |  13 ++
 lib/Makefile         |   1 +
 lib/hashtable_test.c | 299 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 lib/hashtable_test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3fc7abffc7aa..3cf3b6f8cff4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2458,6 +2458,19 @@ config LIST_KUNIT_TEST
 
 	  If unsure, say N.
 
+config HASHTABLE_KUNIT_TEST
+	tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the hashtable KUnit test suite.
+	  It tests the API and basic functionality of the functions
+	  and associated macros defined in include/linux/hashtable.h.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LINEAR_RANGES_TEST
 	tristate "KUnit test for linear_ranges"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 161d6a724ff7..9036d3aeee0a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -370,6 +370,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
new file mode 100644
index 000000000000..7907df66a8e7
--- /dev/null
+++ b/lib/hashtable_test.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the Kernel Hashtable structures.
+ *
+ * Copyright (C) 2022, Google LLC.
+ * Author: Rae Moar <rmoar@google.com>
+ */
+#include <kunit/test.h>
+
+#include <linux/hashtable.h>
+
+struct hashtable_test_entry {
+	int key;
+	int data;
+	struct hlist_node node;
+	int visited;
+};
+
+static void hashtable_test_hash_init(struct kunit *test)
+{
+	/* Test the different ways of initialising a hashtable. */
+	DEFINE_HASHTABLE(hash1, 3);
+	DECLARE_HASHTABLE(hash2, 3);
+
+	hash_init(hash1);
+	hash_init(hash2);
+
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash1));
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash2));
+}
+
+static void hashtable_test_hash_empty(struct kunit *test)
+{
+	struct hashtable_test_entry a;
+	DEFINE_HASHTABLE(hash, 3);
+
+	hash_init(hash);
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash));
+
+	a.key = 1;
+	a.data = 13;
+	hash_add(hash, &a.node, a.key);
+
+	/* Hashtable should no longer be empty. */
+	KUNIT_EXPECT_FALSE(test, hash_empty(hash));
+}
+
+static void hashtable_test_hash_hashed(struct kunit *test)
+{
+	struct hashtable_test_entry a, b;
+	DEFINE_HASHTABLE(hash, 3);
+
+	hash_init(hash);
+	a.key = 1;
+	a.data = 13;
+	b.key = 1;
+	b.data = 2;
+
+	hash_add(hash, &a.node, a.key);
+	hash_add(hash, &b.node, b.key);
+
+	KUNIT_EXPECT_TRUE(test, hash_hashed(&a.node));
+	KUNIT_EXPECT_TRUE(test, hash_hashed(&b.node));
+}
+
+static void hashtable_test_hash_add(struct kunit *test)
+{
+	struct hashtable_test_entry a, b, *x;
+	int bkt;
+	DEFINE_HASHTABLE(hash, 3);
+
+	hash_init(hash);
+	a.key = 1;
+	a.data = 13;
+	a.visited = 0;
+	b.key = 2;
+	b.data = 10;
+	b.visited = 0;
+
+	hash_add(hash, &a.node, a.key);
+	hash_add(hash, &b.node, b.key);
+
+	hash_for_each(hash, bkt, x, node) {
+		if (x->key == a.key && x->data == a.data)
+			a.visited += 1;
+		if (x->key == b.key && x->data == b.data)
+			b.visited += 1;
+	}
+
+	/* Both entries should have been visited exactly once. */
+	KUNIT_EXPECT_EQ(test, a.visited, 1);
+	KUNIT_EXPECT_EQ(test, b.visited, 1);
+}
+
+static void hashtable_test_hash_del(struct kunit *test)
+{
+	struct hashtable_test_entry a, b, *x;
+	DEFINE_HASHTABLE(hash, 3);
+
+	hash_init(hash);
+	a.key = 1;
+	a.data = 13;
+	b.key = 2;
+	b.data = 10;
+	b.visited = 0;
+
+	hash_add(hash, &a.node, a.key);
+	hash_add(hash, &b.node, b.key);
+
+	hash_del(&b.node);
+	hash_for_each_possible(hash, x, node, b.key) {
+		if (x->key == b.key && x->data == b.data)
+			b.visited += 1;
+	}
+
+	/* The deleted entry should not have been visited. */
+	KUNIT_EXPECT_EQ(test, b.visited, 0);
+
+	hash_del(&a.node);
+
+	/* The hashtable should be empty. */
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash));
+}
+
+static void hashtable_test_hash_for_each(struct kunit *test)
+{
+	struct hashtable_test_entry entries[3];
+	struct hashtable_test_entry *x;
+	int bkt, i, j, count;
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries. */
+	hash_init(hash);
+	for (i = 0; i < 3; i++) {
+		entries[i].key = i;
+		entries[i].data = i + 10;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count = 0;
+	hash_for_each(hash, bkt, x, node) {
+		if (x->key >= 0 && x->key < 3)
+			entries[x->key].visited += 1;
+		count++;
+	}
+
+	/* Should have visited each entry exactly once. */
+	KUNIT_EXPECT_EQ(test, count, 3);
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+}
+
+static void hashtable_test_hash_for_each_safe(struct kunit *test)
+{
+	struct hashtable_test_entry entries[3];
+	struct hashtable_test_entry *x;
+	struct hlist_node *tmp;
+	int bkt, i, j, count;
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries. */
+	hash_init(hash);
+	for (i = 0; i < 3; i++) {
+		entries[i].key = i;
+		entries[i].data = i + 10;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count = 0;
+	hash_for_each_safe(hash, bkt, tmp, x, node) {
+		if (x->key >= 0 && x->key < 3) {
+			entries[x->key].visited += 1;
+			hash_del(&entries[x->key].node);
+		}
+		count++;
+	}
+
+	/* Should have visited each entry exactly once. */
+	KUNIT_EXPECT_EQ(test, count, 3);
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+}
+
+static void hashtable_test_hash_for_each_possible(struct kunit *test)
+{
+	struct hashtable_test_entry entries[4];
+	struct hashtable_test_entry *x;
+	int i, j, count;
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries with key = 1. */
+	hash_init(hash);
+	for (i = 0; i < 3; i++) {
+		entries[i].key = 1;
+		entries[i].data = i;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key = 2. */
+	entries[3].key = 2;
+	entries[3].data = 3;
+	entries[3].visited = 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count = 0;
+	hash_for_each_possible(hash, x, node, 1) {
+		if (x->data >= 0 && x->data < 4)
+			entries[x->data].visited += 1;
+		count++;
+	}
+
+	/* Should have visited each entry with key = 1 exactly once. */
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* If entry with key = 2 is in the same bucket as the entries with
+	 * key = 1, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (hash_min(1, HASH_BITS(hash)) == hash_min(2, HASH_BITS(hash))) {
+		KUNIT_EXPECT_EQ(test, count, 4);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
+	} else {
+		KUNIT_EXPECT_EQ(test, count, 3);
+	}
+}
+
+static void hashtable_test_hash_for_each_possible_safe(struct kunit *test)
+{
+	struct hashtable_test_entry entries[4];
+	struct hashtable_test_entry *x;
+	struct hlist_node *tmp;
+	int i, j, count;
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries with key = 1. */
+	hash_init(hash);
+	for (i = 0; i < 3; i++) {
+		entries[i].key = 1;
+		entries[i].data = i;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key = 2. */
+	entries[3].key = 2;
+	entries[3].data = 3;
+	entries[3].visited = 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count = 0;
+	hash_for_each_possible_safe(hash, x, tmp, node, 1) {
+		if (x->data >= 0 && x->data < 4) {
+			entries[x->data].visited += 1;
+			hash_del(&entries[x->data].node);
+		}
+		count++;
+	}
+
+	/* Should have visited each entry with key = 1 exactly once. */
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* If entry with key = 2 is in the same bucket as the entries with
+	 * key = 1, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (hash_min(1, HASH_BITS(hash)) == hash_min(2, HASH_BITS(hash))) {
+		KUNIT_EXPECT_EQ(test, count, 4);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
+	} else {
+		KUNIT_EXPECT_EQ(test, count, 3);
+	}
+}
+
+static struct kunit_case hashtable_test_cases[] = {
+	KUNIT_CASE(hashtable_test_hash_init),
+	KUNIT_CASE(hashtable_test_hash_empty),
+	KUNIT_CASE(hashtable_test_hash_hashed),
+	KUNIT_CASE(hashtable_test_hash_add),
+	KUNIT_CASE(hashtable_test_hash_del),
+	KUNIT_CASE(hashtable_test_hash_for_each),
+	KUNIT_CASE(hashtable_test_hash_for_each_safe),
+	KUNIT_CASE(hashtable_test_hash_for_each_possible),
+	KUNIT_CASE(hashtable_test_hash_for_each_possible_safe),
+	{},
+};
+
+static struct kunit_suite hashtable_test_module = {
+	.name = "hashtable",
+	.test_cases = hashtable_test_cases,
+};
+
+kunit_test_suites(&hashtable_test_module);
+
+MODULE_LICENSE("GPL");

base-commit: 054be257f28ca8eeb8e3620766501b81ceb4b293
-- 
2.39.0.314.g84b9a713c41-goog

