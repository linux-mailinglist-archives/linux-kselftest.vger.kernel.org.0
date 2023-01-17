Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D6670C0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAQWtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjAQWrQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:47:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29094F856
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:50:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z17-20020a256651000000b007907852ca4dso35382688ybm.16
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULZLef51O7gy3vfZoZVDDimXgPQXe9qknUeKNZ9s4pw=;
        b=A7+73cH9pLRt5aUzTfHuCReOyUryIJc8uZlQ+f09yKp2WRxxccaP+nZMY2ZQ3A8xXI
         1ZX5cg4STGhBE5+t+J5tUNYQ4HpLjKDzIVpj7wIveCAGLdQCIJ6wqDsDpYZlLrTNJLHS
         GAnbiZppqBEUBH4XBoxpNeSxwpIv+ItTNc5wFN4/RDwGl07Naf9b4Jt5D1W4R06M1Kbj
         B4LZ30HGL4qOzHy3Q8lDzSYt5KXAu7RCLu3U9IgX/uOE4CSBAi+gE3YvUwWS/sxeY5j+
         tzQyc4UQfn6wGtEn7AP2dY/GyAPx0RAXUmXdg5YMMVV7C6UNE9suohgUd0OKiFuEm+ew
         OCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULZLef51O7gy3vfZoZVDDimXgPQXe9qknUeKNZ9s4pw=;
        b=AEnmtB5aSHtaC1WmeirMuv0zqQIFEfWEQCYaR47v9NgJSSMSWdybRfkCGACeJmyp4a
         RK3Bo6OiAes6y5JC4GZAraGX94Bwyj5bimVRwYeTQiEvUAzQk45L1S3tK00XU0+mHfOY
         x01MTMwXOtv44L3y9TfHpB/rdOrPwjo08/371wP7uHJPF5GHtrVi3LYYQMGDVJfGpsUe
         dsDnnwHe4gELmZZaow1fgVmjsFsmYR0nN1+Eit9ssUxA0Haapn7ZE1eHdkYbVP+ZTn4E
         pwGPEVpn3fcHC/QGLa9oz7kb5v8BNKotl5roYZDRITE1wrur2OjPEetmwoQfdMm3CJUJ
         8gSw==
X-Gm-Message-State: AFqh2kqatsl3fnf4FjMss+KF53PEbfOHoWi5HgTrNkvGEbJmmZuS1bp5
        czAa7kzkR/4ZrXGYlAbt1WWIzAtw+Q==
X-Google-Smtp-Source: AMrXdXsG+hLuSRc4mtzKUc4GQ8BYViNEH4AKKNO7VQHLs9NKiNduGuhY+GUVycSatXGuVoFUcBar6siYOg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:40ca:0:b0:7ae:2b0:d5c6 with SMTP id
 n193-20020a2540ca000000b007ae02b0d5c6mr545169yba.627.1673992254928; Tue, 17
 Jan 2023 13:50:54 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:50:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117215046.3734066-1-rmoar@google.com>
Subject: [PATCH v2] lib/hashtable_test.c: add test for the hashtable structure
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
---

Changes since v1:
- Change Kconfig.debug message to be more succinct.
- Directly increment current element's visited field rather than looking
  up corresponding element.
- Use KUNIT_EXPECT_=E2=80=A6 statements to check keys are within range rath=
er
  than using if statements.
- Change hash_for_each_possible test to check buckets using a
  hash_for_each method instead of calculating the bucket number using
  hash_min.

Note: The check patch script is outputting open brace errors on lines
158, 192, 247 of lib/hashtable_test.c. However, I think these errors are
a mistake as the format of the braces on those lines seems consistent
with the Linux Kernel style guide.

 lib/Kconfig.debug    |  13 ++
 lib/Makefile         |   1 +
 lib/hashtable_test.c | 326 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 lib/hashtable_test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..69b1452a3eeb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2496,6 +2496,19 @@ config LIST_KUNIT_TEST
=20
 	  If unsure, say N.
=20
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
@@ -369,6 +369,7 @@ obj-$(CONFIG_PLDMFW) +=3D pldmfw/
 CFLAGS_bitfield_kunit.o :=3D $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_BITFIELD_KUNIT) +=3D bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) +=3D list-test.o
+obj-$(CONFIG_HASHTABLE_KUNIT_TEST) +=3D hashtable_test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) +=3D test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) +=3D test_bits.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) +=3D cmdline_kunit.o
diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
new file mode 100644
index 000000000000..ab09b747d83d
--- /dev/null
+++ b/lib/hashtable_test.c
@@ -0,0 +1,326 @@
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
+	a.key =3D 1;
+	a.data =3D 13;
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
+	a.key =3D 1;
+	a.data =3D 13;
+	b.key =3D 1;
+	b.data =3D 2;
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
+	a.key =3D 1;
+	a.data =3D 13;
+	a.visited =3D 0;
+	b.key =3D 2;
+	b.data =3D 10;
+	b.visited =3D 0;
+
+	hash_add(hash, &a.node, a.key);
+	hash_add(hash, &b.node, b.key);
+
+	hash_for_each(hash, bkt, x, node) {
+		x->visited++;
+		if (x->key =3D=3D a.key)
+			KUNIT_EXPECT_EQ(test, x->data, 13);
+		else if (x->key =3D=3D b.key)
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
+	DEFINE_HASHTABLE(hash, 3);
+
+	hash_init(hash);
+	a.key =3D 1;
+	a.data =3D 13;
+	b.key =3D 2;
+	b.data =3D 10;
+	b.visited =3D 0;
+
+	hash_add(hash, &a.node, a.key);
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
+	/* Initialize a hashtable with three entries. */
+	hash_init(hash);
+	for (i =3D 0; i < 3; i++) {
+		entries[i].key =3D i;
+		entries[i].data =3D i + 10;
+		entries[i].visited =3D 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count =3D 0;
+	hash_for_each(hash, bkt, x, node) {
+		x->visited +=3D 1;
+		KUNIT_ASSERT_GE(test, x->key, 0);
+		KUNIT_ASSERT_LT(test, x->key, 3);
+		count++;
+	}
+
+	/* Should have visited each entry exactly once. */
+	KUNIT_EXPECT_EQ(test, count, 3);
+	for (j =3D 0; j < 3; j++)
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
+	for (i =3D 0; i < 3; i++) {
+		entries[i].key =3D i;
+		entries[i].data =3D i + 10;
+		entries[i].visited =3D 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	count =3D 0;
+	hash_for_each_safe(hash, bkt, tmp, x, node) {
+		x->visited +=3D 1;
+		KUNIT_ASSERT_GE(test, x->key, 0);
+		KUNIT_ASSERT_LT(test, x->key, 3);
+		count++;
+
+		/* Delete entry during loop. */
+		hash_del(&x->node);
+	}
+
+	/* Should have visited each entry exactly once. */
+	KUNIT_EXPECT_EQ(test, count, 3);
+	for (j =3D 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+}
+
+static void hashtable_test_hash_for_each_possible(struct kunit *test)
+{
+	struct hashtable_test_entry entries[4];
+	struct hashtable_test_entry *x, *y;
+	int buckets[2];
+	int bkt, i, j, count;
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries with key =3D 0. */
+	hash_init(hash);
+	for (i =3D 0; i < 3; i++) {
+		entries[i].key =3D 0;
+		entries[i].data =3D i;
+		entries[i].visited =3D 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key =3D 1. */
+	entries[3].key =3D 1;
+	entries[3].data =3D 3;
+	entries[3].visited =3D 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count =3D 0;
+	hash_for_each_possible(hash, x, node, 0) {
+		x->visited +=3D 1;
+		KUNIT_ASSERT_GE(test, x->data, 0);
+		KUNIT_ASSERT_LT(test, x->data, 4);
+		count++;
+	}
+
+	/* Should have visited each entry with key =3D 0 exactly once. */
+	for (j =3D 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* Save the buckets for the different keys. */
+	hash_for_each(hash, bkt, y, node) {
+		if (y->key < 0 || y->key > 1)
+			KUNIT_ASSERT_FAILURE(test, "Unexpected key in hashtable.");
+		buckets[y->key] =3D bkt;
+	}
+
+	/* If entry with key =3D 1 is in the same bucket as the entries with
+	 * key =3D 0, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (buckets[0] =3D=3D buckets[1]) {
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
+	DEFINE_HASHTABLE(hash, 3);
+
+	/* Initialize a hashtable with three entries with key =3D 0. */
+	hash_init(hash);
+	for (i =3D 0; i < 3; i++) {
+		entries[i].key =3D 0;
+		entries[i].data =3D i;
+		entries[i].visited =3D 0;
+		hash_add(hash, &entries[i].node, entries[i].key);
+	}
+
+	/* Add an entry with key =3D 1. */
+	entries[3].key =3D 1;
+	entries[3].data =3D 3;
+	entries[3].visited =3D 0;
+	hash_add(hash, &entries[3].node, entries[3].key);
+
+	count =3D 0;
+	hash_for_each_possible_safe(hash, x, tmp, node, 0) {
+		x->visited +=3D 1;
+		KUNIT_ASSERT_GE(test, x->data, 0);
+		KUNIT_ASSERT_LT(test, x->data, 4);
+		count++;
+
+		/* Delete entry during loop. */
+		hash_del(&x->node);
+	}
+
+	/* Should have visited each entry with key =3D 0 exactly once. */
+	for (j =3D 0; j < 3; j++)
+		KUNIT_EXPECT_EQ(test, entries[j].visited, 1);
+
+	/* Save the buckets for the different keys. */
+	hash_for_each(hash, bkt, y, node) {
+		if (y->key < 0 || y->key > 1)
+			KUNIT_ASSERT_FAILURE(test, "Unexpected key in hashtable.");
+		buckets[y->key] =3D bkt;
+	}
+
+	/* If entry with key =3D 1 is in the same bucket as the entries with
+	 * key =3D 0, check it was visited. Otherwise ensure that only three
+	 * entries were visited.
+	 */
+	if (buckets[0] =3D=3D buckets[1]) {
+		KUNIT_EXPECT_EQ(test, count, 4);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 1);
+	} else {
+		KUNIT_EXPECT_EQ(test, count, 3);
+		KUNIT_EXPECT_EQ(test, entries[3].visited, 0);
+	}
+}
+
+static struct kunit_case hashtable_test_cases[] =3D {
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
+static struct kunit_suite hashtable_test_module =3D {
+	.name =3D "hashtable",
+	.test_cases =3D hashtable_test_cases,
+};
+
+kunit_test_suites(&hashtable_test_module);
+
+MODULE_LICENSE("GPL");

base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
--=20
2.39.0.314.g84b9a713c41-goog

