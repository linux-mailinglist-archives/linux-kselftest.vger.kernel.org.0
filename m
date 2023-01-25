Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABB67C03B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 23:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjAYWze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 17:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjAYWzd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 17:55:33 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76112611E6
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 14:55:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4ff7c6679f2so530617b3.12
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5aTHflhvU5hl+JkwekB7RlOlr/hp8opqL15QvEvo54=;
        b=bzJkDFDODwQ4aHczZ5Q29/ItRyxdl5BzMlhkXInDNq7XoQP+rKcbY8Wv9t1t+PrziN
         8JWaVl5mT8IpHx6sqr1EPTFJ6XrLcuJ5bixw3ZyBldPnxVYau+fueN5JGSFpnOceecKW
         jPAomFh/8HDxILl5PnriMP5ukvKu1O0UwmYIOC8UmT9sdBYSQpRU4isozBpJIu5snXC4
         lvpNVIWVQKaFREvzzdISZtw8/DFZThhJr557P+IGkJCT5nBiDSr7X+zOZR20Wh7kDoax
         k7/TTaHn7yrb5nwTBU/ypUW/0Go7z2gsIYfEBoKNuAmyTKGt0BhlihmjOyL6OSryp9Pd
         YIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5aTHflhvU5hl+JkwekB7RlOlr/hp8opqL15QvEvo54=;
        b=lQ3Va9PPzMGiRVSK6fD75DWNhJBFewT8iWVVsmp9E6VEhVTi01PBcdvpI7lBzVCRcN
         VB5SSz2F/QHrXbmumHHyMhbMTg1txywUZlcm3Q/LKMCtJ2o7bDNeAdJP4nh5QaMCdMaB
         pOGTeY785kF9F10vofPg7hem63KDoBK+XGZce6NltYIb60B8hYC1LlCQLsmOzlTtEnmi
         vmuL4FZHl3hodlEAPDN6nU5OaynX/xf0KbZFn1rX76z5JWllAXgUh3lV58dUD2RBoRhl
         fbQvGEcnaaQKhMA9elnGPWzCLtsg911maTiZlWjH5psp0E9RES5ac7ZwlMqTF/k2vW7H
         d85g==
X-Gm-Message-State: AFqh2kqKwcuy4XzeFSMYuRVoxREEgND9yjbrSwe4QeMdCauoPrhDc5yb
        eYWlX/s3EhkWWj2kJ9h+S9zkHD3QHg==
X-Google-Smtp-Source: AMrXdXtI9b5ejz77UAIM3baiDxU99jcZXtO//dFoZkyOApxz9CPrvwKmllDiZa1jLWm274hcqNB+nVXRAA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:124c:0:b0:502:bcca:867c with SMTP id
 73-20020a81124c000000b00502bcca867cmr2657198yws.484.1674687307523; Wed, 25
 Jan 2023 14:55:07 -0800 (PST)
Date:   Wed, 25 Jan 2023 22:54:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125225449.351154-1-rmoar@google.com>
Subject: [PATCH v3] lib/hashtable_test.c: add test for the hashtable structure
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
Reviewed-by: David Gow <davidgow@google.com>
---

Changes since v2:
- Remove extraneous hash_init() calls when using DEFINE_HASHTABLE.
- Change up the size of the hashtables in different tests.
- Change formatting to group lines regarding the same hashtable_test_entry.
- Use KUNIT_ASSERT_LEQ() and KUNIT_ASSERT_GEQ() instead of a few if
  statements.

Changes since v1:
- Change Kconfig.debug message to be more succinct.
- Directly increment current element's visited field rather than looking up
  corresponding element.
- Use KUNIT_ASSERT_... statements to check the keys are within range rather
  than using if statements.
- Change hash_for_each_possible test to check buckets using a hash_for_each
  method instead of calculating the bucket number using hash_min.

Note: The check patch script is outputting open brace errors on lines
152, 185, 239 of lib/hashtable_test.c. However, I think these errors are
a mistake as the format of the braces on those lines is consistent
with the Linux Kernel style guide. As David Gow commented on the
last version, "This is a known issue with checkpatch and function
names with "for_each" in them. It was discussed here, and we
ultimately decided just to ignore the warnings:
https://lore.kernel.org/all/CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com/."

 lib/Kconfig.debug    |  13 ++
 lib/Makefile         |   1 +
 lib/hashtable_test.c | 317 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 lib/hashtable_test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..69b1452a3eeb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2496,6 +2496,19 @@ config LIST_KUNIT_TEST
 
 	  If unsure, say N.
 
+config HASHTABLE_KUNIT_TEST
+	tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the hashtable KUnit test suite.
+	  It tests the basic functionality of the API defined in
+	  include/linux/hashtable.h. For more information on KUnit and
+	  unit tests in general please refer to the KUnit documentation
+	  in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LINEAR_RANGES_TEST
 	tristate "KUnit test for linear_ranges"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 4d9461bfea42..5f8efbe8e97f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -369,6 +369,7 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 CFLAGS_bitfield_kunit.o := $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
new file mode 100644
index 000000000000..1d1b3288dee2
--- /dev/null
+++ b/lib/hashtable_test.c
@@ -0,0 +1,317 @@
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
+	DEFINE_HASHTABLE(hash1, 2);
+	DECLARE_HASHTABLE(hash2, 3);
+
+	/* When using DECLARE_HASHTABLE, must use hash_init to
+	 * initialize the hashtable.
+	 */
+	hash_init(hash2);
+
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash1));
+	KUNIT_EXPECT_TRUE(test, hash_empty(hash2));
+}
+
+static void hashtable_test_hash_empty(struct kunit *test)
+{
+	struct hashtable_test_entry a;
+	DEFINE_HASHTABLE(hash, 1);
+
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
+	DEFINE_HASHTABLE(hash, 4);
+
+	a.key = 1;
+	a.data = 13;
+	hash_add(hash, &a.node, a.key);
+	b.key = 1;
+	b.data = 2;
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
+	a.key = 1;
+	a.data = 13;
+	a.visited = 0;
+	hash_add(hash, &a.node, a.key);
+	b.key = 2;
+	b.data = 10;
+	b.visited = 0;
+	hash_add(hash, &b.node, b.key);
+
+	hash_for_each(hash, bkt, x, node) {
+		x->visited++;
+		if (x->key == a.key)
+			KUNIT_EXPECT_EQ(test, x->data, 13);
+		else if (x->key == b.key)
+			KUNIT_EXPECT_EQ(test, x->data, 10);
+		else
+			KUNIT_FAIL(test, "Unexpected key in hashtable.");
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
+	DEFINE_HASHTABLE(hash, 6);
+
+	a.key = 1;
+	a.data = 13;
+	hash_add(hash, &a.node, a.key);
+	b.key = 2;
+	b.data = 10;
+	b.visited = 0;
+	hash_add(hash, &b.node, b.key);
+
+	hash_del(&b.node);
+	hash_for_each_possible(hash, x, node, b.key) {
+		x->visited++;
+		KUNIT_EXPECT_NE(test, x->key, b.key);
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
+	/* Add three entries to the hashtable. */
+	for (i = 0; i < 3; i++) {
+		entries[i].key = i;
+		entries[i].data = i + 10;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count = 0;
+	hash_for_each(hash, bkt, x, node) {
+		x->visited += 1;
+		KUNIT_ASSERT_GE_MSG(test, x->key, 0, "Unexpected key in hashtable.");
+		KUNIT_ASSERT_LT_MSG(test, x->key, 3, "Unexpected key in hashtable.");
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
+	/* Add three entries to the hashtable. */
+	for (i = 0; i < 3; i++) {
+		entries[i].key = i;
+		entries[i].data = i + 10;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count = 0;
+	hash_for_each_safe(hash, bkt, tmp, x, node) {
+		x->visited += 1;
+		KUNIT_ASSERT_GE_MSG(test, x->key, 0, "Unexpected key in hashtable.");
+		KUNIT_ASSERT_LT_MSG(test, x->key, 3, "Unexpected key in hashtable.");
+		count++;
+
+		/* Delete entry during loop. */
+		hash_del(&x->node);
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
+	struct hashtable_test_entry *x, *y;
+	int buckets[2];
+	int bkt, i, j, count;
+	DEFINE_HASHTABLE(hash, 5);
+
+	/* Add three entries with key = 0 to the hashtable. */
+	for (i = 0; i < 3; i++) {
+		entries[i].key = 0;
+		entries[i].data = i;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key = 1. */
+	entries[3].key = 1;
+	entries[3].data = 3;
+	entries[3].visited = 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count = 0;
+	hash_for_each_possible(hash, x, node, 0) {
+		x->visited += 1;
+		KUNIT_ASSERT_GE_MSG(test, x->data, 0, "Unexpected data in hashtable.");
+		KUNIT_ASSERT_LT_MSG(test, x->data, 4, "Unexpected data in hashtable.");
+		count++;
+	}
+
+	/* Should have visited each entry with key = 0 exactly once. */
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* Save the buckets for the different keys. */
+	hash_for_each(hash, bkt, y, node) {
+		KUNIT_ASSERT_GE_MSG(test, y->key, 0, "Unexpected key in hashtable.");
+		KUNIT_ASSERT_LE_MSG(test, y->key, 1, "Unexpected key in hashtable.");
+		buckets[y->key] = bkt;
+	}
+
+	/* If entry with key = 1 is in the same bucket as the entries with
+	 * key = 0, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (buckets[0] == buckets[1]) {
+		KUNIT_EXPECT_EQ(test, count, 4);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
+	} else {
+		KUNIT_EXPECT_EQ(test, count, 3);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 0);
+	}
+}
+
+static void hashtable_test_hash_for_each_possible_safe(struct kunit *test)
+{
+	struct hashtable_test_entry entries[4];
+	struct hashtable_test_entry *x, *y;
+	struct hlist_node *tmp;
+	int buckets[2];
+	int bkt, i, j, count;
+	DEFINE_HASHTABLE(hash, 5);
+
+	/* Add three entries with key = 0 to the hashtable. */
+	for (i = 0; i < 3; i++) {
+		entries[i].key = 0;
+		entries[i].data = i;
+		entries[i].visited = 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key = 1. */
+	entries[3].key = 1;
+	entries[3].data = 3;
+	entries[3].visited = 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count = 0;
+	hash_for_each_possible_safe(hash, x, tmp, node, 0) {
+		x->visited += 1;
+		KUNIT_ASSERT_GE_MSG(test, x->data, 0, "Unexpected data in hashtable.");
+		KUNIT_ASSERT_LT_MSG(test, x->data, 4, "Unexpected data in hashtable.");
+		count++;
+
+		/* Delete entry during loop. */
+		hash_del(&x->node);
+	}
+
+	/* Should have visited each entry with key = 0 exactly once. */
+	for (j = 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* Save the buckets for the different keys. */
+	hash_for_each(hash, bkt, y, node) {
+		KUNIT_ASSERT_GE_MSG(test, y->key, 0, "Unexpected key in hashtable.");
+		KUNIT_ASSERT_LE_MSG(test, y->key, 1, "Unexpected key in hashtable.");
+		buckets[y->key] = bkt;
+	}
+
+	/* If entry with key = 1 is in the same bucket as the entries with
+	 * key = 0, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (buckets[0] == buckets[1]) {
+		KUNIT_EXPECT_EQ(test, count, 4);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
+	} else {
+		KUNIT_EXPECT_EQ(test, count, 3);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 0);
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

base-commit: 5835ffc27381c2d32c3f0d7b575cb3397555ab47
-- 
2.39.1.456.gfc5497dd1b-goog

