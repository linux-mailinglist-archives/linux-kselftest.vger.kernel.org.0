Return-Path: <linux-kselftest+bounces-7971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0AA8A5358
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024AF1F23022
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD06763EC;
	Mon, 15 Apr 2024 14:26:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7E7602A;
	Mon, 15 Apr 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191182; cv=none; b=JrC14pGTSByW7XoXefkV1A7wScWb9LgJLvAAJimrl90EmPvhZ49PzJKzBqkK2d0Ijiif7cAgI2b19/7Gv+9BqxRmfTnTd5MvR8Md4ffHKzm7j1Km1/3gU6RP28Ixcy3AoYk70t1bS1qdqAVYbe/IyXY8NTn7rSJcSaDovRqCuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191182; c=relaxed/simple;
	bh=IVATW++nz28c3kZOnMIL86wBCVh/IETb0S5N+Sy2G4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXTcaUpl1WTnBK4U0Vjw7aPuvj1oelBh57gaq5AkO4cqad13PxYwdK7WSMAn4amyjJmFAMYiEyj5jqJPSX3/9JKJmCxjbGtddI0DOOlyiD05qoVRzqvZpWPIQcRogj2VI8yWdpV6Hl7khKOGUeW0k0IFbTK8iysv/0R5WfNV9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJ8F96TfDz9v7HR;
	Mon, 15 Apr 2024 22:09:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C0B9C1404F5;
	Mon, 15 Apr 2024 22:26:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S6;
	Mon, 15 Apr 2024 15:26:06 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 04/14] digest_cache: Add hash tables and operations
Date: Mon, 15 Apr 2024 16:24:26 +0200
Message-Id: <20240415142436.2545003-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S6
X-Coremail-Antispam: 1UD129KBjvAXoW3tF4kCrWrGFW7KrWDKryUKFg_yoW8Xw48Co
	ZIkF4UJw18WFy3ur4DCF17Aa1UW34rt34xAr1kJrWDZ3WktryUJ3ZrCFn8JFy3Xry8GrZ7
	Aw1kJ3y7Jr48tr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOr7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	WY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU04rW7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x10QABsD

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a linked list of hash tables to the digest cache, one per algorithm,
containing the digests extracted from digest lists.

The number of hash table slots is determined by dividing the number of
digests to add to the average depth of the collision list defined with
CONFIG_DIGEST_CACHE_HTABLE_DEPTH (currently set to 30). It can be changed
in the kernel configuration.

Add digest_cache_htable_init() and digest_cache_htable_add(), to be called
by digest list parsers, in order to allocate the hash tables and to add
extracted digests.

Add digest_cache_htable_free(), to let the digest_cache LSM free the hash
tables at the time a digest cache is freed.

Add digest_cache_htable_lookup() to search a digest in the hash table of a
digest cache for a given algorithm.

Add digest_cache_lookup() to the public API, to let users of the
digest_cache LSM search a digest in a digest cache and, in a subsequent
patch, to search it in the digest caches for each directory entry.

Return the digest cache containing the digest, as a different type,
digest_cache_found_t to avoid it being accidentally put. Also, introduce
digest_cache_from_found_t() to explicitly convert it back to a digest cache
for further use (e.g. retrieving verification data, introduced later).

Finally, add digest_cache_hash_key() to compute the hash table key from the
first two bytes of the digest (modulo the number of slots).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h     |  34 +++++
 security/digest_cache/Kconfig    |  11 ++
 security/digest_cache/Makefile   |   2 +-
 security/digest_cache/htable.c   | 250 +++++++++++++++++++++++++++++++
 security/digest_cache/internal.h |  43 ++++++
 security/digest_cache/main.c     |   3 +
 6 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 security/digest_cache/htable.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index e79f94a60b0f..4872700ac205 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -11,12 +11,39 @@
 #define _LINUX_DIGEST_CACHE_H
 
 #include <linux/fs.h>
+#include <crypto/hash_info.h>
 
 struct digest_cache;
 
+/**
+ * typedef digest_cache_found_t - Digest cache reference as numeric value
+ *
+ * This new type represents a digest cache reference that should not be put.
+ */
+typedef unsigned long digest_cache_found_t;
+
+/**
+ * digest_cache_from_found_t - Convert digest_cache_found_t to digest cache ptr
+ * @found: digest_cache_found_t value
+ *
+ * Convert the digest_cache_found_t returned by digest_cache_lookup() to a
+ * digest cache pointer, so that it can be passed to the other functions of the
+ * API.
+ *
+ * Return: Digest cache pointer.
+ */
+static inline struct digest_cache *
+digest_cache_from_found_t(digest_cache_found_t found)
+{
+	return (struct digest_cache *)found;
+}
+
 #ifdef CONFIG_SECURITY_DIGEST_CACHE
 struct digest_cache *digest_cache_get(struct dentry *dentry);
 void digest_cache_put(struct digest_cache *digest_cache);
+digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
+					 struct digest_cache *digest_cache,
+					 u8 *digest, enum hash_algo algo);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -28,5 +55,12 @@ static inline void digest_cache_put(struct digest_cache *digest_cache)
 {
 }
 
+static inline digest_cache_found_t
+digest_cache_lookup(struct dentry *dentry, struct digest_cache *digest_cache,
+		    u8 *digest, enum hash_algo algo)
+{
+	return 0UL;
+}
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
index dfabe5d6e3ca..71017954e5c5 100644
--- a/security/digest_cache/Kconfig
+++ b/security/digest_cache/Kconfig
@@ -18,3 +18,14 @@ config DIGEST_LIST_DEFAULT_PATH
 	  It can be changed at run-time, by writing the new path to the
 	  securityfs interface. Digest caches created with the old path are
 	  not affected by the change.
+
+config DIGEST_CACHE_HTABLE_DEPTH
+	int
+	default 30
+	help
+	  Desired average depth of the collision list in the digest cache
+	  hash tables.
+
+	  A smaller number will increase the amount of hash table slots, and
+	  make the search faster. A bigger number will decrease the number of
+	  hash table slots, but make the search slower.
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index 1330655e33b1..7e00c53d8f55 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o
+digest_cache-y := main.o secfs.o htable.o
diff --git a/security/digest_cache/htable.c b/security/digest_cache/htable.c
new file mode 100644
index 000000000000..d2d5d8f5e5b1
--- /dev/null
+++ b/security/digest_cache/htable.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement hash table operations for the digest cache.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include "internal.h"
+
+/**
+ * digest_cache_hash_key - Compute hash key
+ * @digest: Digest cache
+ * @num_slots: Number of slots in the hash table
+ *
+ * This function computes a hash key based on the first two bytes of the
+ * digest and the number of slots of the hash table.
+ *
+ * Return: Hash key.
+ */
+static inline unsigned int digest_cache_hash_key(u8 *digest,
+						 unsigned int num_slots)
+{
+	/* Same as ima_hash_key() but parametrized. */
+	return (digest[0] | digest[1] << 8) % num_slots;
+}
+
+/**
+ * lookup_htable - Lookup a hash table
+ * @digest_cache: Digest cache
+ * @algo: Algorithm of the desired hash table
+ *
+ * This function searches the hash table for a given algorithm in the digest
+ * cache.
+ *
+ * Return: A hash table if found, NULL otherwise.
+ */
+static struct htable *lookup_htable(struct digest_cache *digest_cache,
+				    enum hash_algo algo)
+{
+	struct htable *h;
+
+	list_for_each_entry(h, &digest_cache->htables, next)
+		if (h->algo == algo)
+			return h;
+
+	return NULL;
+}
+
+/**
+ * digest_cache_htable_init - Allocate and initialize the hash table
+ * @digest_cache: Digest cache
+ * @num_digests: Number of digests to add to the digest cache
+ * @algo: Algorithm of the digests
+ *
+ * This function allocates and initializes the hash table for a given algorithm.
+ * The number of slots depends on the number of digests to add to the digest
+ * cache, and the constant CONFIG_DIGEST_CACHE_HTABLE_DEPTH stating the desired
+ * average depth of the collision list.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_digests,
+			     enum hash_algo algo)
+{
+	struct htable *h;
+	int i;
+
+	h = lookup_htable(digest_cache, algo);
+	if (h)
+		return 0;
+
+	h = kmalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	h->num_slots = DIV_ROUND_UP(num_digests,
+				    CONFIG_DIGEST_CACHE_HTABLE_DEPTH);
+	h->slots = kmalloc_array(h->num_slots, sizeof(*h->slots), GFP_KERNEL);
+	if (!h->slots) {
+		kfree(h);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < h->num_slots; i++)
+		INIT_HLIST_HEAD(&h->slots[i]);
+
+	h->num_digests = 0;
+	h->algo = algo;
+
+	list_add_tail(&h->next, &digest_cache->htables);
+
+	pr_debug("Initialized hash table for digest list %s, digests: %llu, slots: %u, algo: %s\n",
+		 digest_cache->path_str, num_digests, h->num_slots,
+		 hash_algo_name[algo]);
+	return 0;
+}
+
+/**
+ * digest_cache_htable_add - Add a new digest to the digest cache
+ * @digest_cache: Digest cache
+ * @digest: Digest to add
+ * @algo: Algorithm of digest
+ *
+ * This function, invoked by a digest list parser, adds a digest extracted
+ * from a digest list to the digest cache.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_htable_add(struct digest_cache *digest_cache, u8 *digest,
+			    enum hash_algo algo)
+{
+	struct htable *h;
+	struct digest_cache_entry *entry;
+	unsigned int key;
+	int digest_len;
+
+	h = lookup_htable(digest_cache, algo);
+	if (!h) {
+		pr_debug("No hash table for algorithm %s was found in digest cache %s, initialize one\n",
+			 hash_algo_name[algo], digest_cache->path_str);
+		return -ENOENT;
+	}
+
+	digest_len = hash_digest_size[algo];
+
+	entry = kmalloc(sizeof(*entry) + digest_len, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->digest, digest, digest_len);
+
+	key = digest_cache_hash_key(digest, h->num_slots);
+	hlist_add_head(&entry->hnext, &h->slots[key]);
+	h->num_digests++;
+	pr_debug("Added digest %s:%*phN to digest cache %s, num of %s digests: %llu\n",
+		 hash_algo_name[algo], digest_len, digest,
+		 digest_cache->path_str, hash_algo_name[algo], h->num_digests);
+	return 0;
+}
+
+/**
+ * digest_cache_htable_lookup - Search a digest in the digest cache
+ * @dentry: Dentry of the file whose digest is looked up
+ * @digest_cache: Digest cache
+ * @digest: Digest to search
+ * @algo: Algorithm of the digest to search
+ *
+ * This function searches the passed digest and algorithm in the passed digest
+ * cache.
+ *
+ * Return: Zero if the digest is found, -ENOENT if not.
+ */
+int digest_cache_htable_lookup(struct dentry *dentry,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo)
+{
+	struct digest_cache_entry *entry;
+	struct htable *h;
+	unsigned int key;
+	int digest_len;
+	int search_depth = 0;
+
+	h = lookup_htable(digest_cache, algo);
+	if (!h)
+		return -ENOENT;
+
+	digest_len = hash_digest_size[algo];
+	key = digest_cache_hash_key(digest, h->num_slots);
+
+	hlist_for_each_entry(entry, &h->slots[key], hnext) {
+		if (!memcmp(entry->digest, digest, digest_len)) {
+			pr_debug("Cache hit at depth %d for file %s, digest %s:%*phN in digest cache %s\n",
+				 search_depth, dentry->d_name.name,
+				 hash_algo_name[algo], digest_len, digest,
+				 digest_cache->path_str);
+
+			return 0;
+		}
+
+		search_depth++;
+	}
+
+	pr_debug("Cache miss for file %s, digest %s:%*phN in digest cache %s\n",
+		 dentry->d_name.name, hash_algo_name[algo], digest_len, digest,
+		 digest_cache->path_str);
+	return -ENOENT;
+}
+
+/**
+ * digest_cache_lookup - Search a digest in the digest cache
+ * @dentry: Dentry of the file whose digest is looked up
+ * @digest_cache: Digest cache
+ * @digest: Digest to search
+ * @algo: Algorithm of the digest to search
+ *
+ * This function calls digest_cache_htable_lookup() to search a digest in the
+ * passed digest cache, obtained with digest_cache_get().
+ *
+ * It returns the digest cache reference as the digest_cache_found_t type, to
+ * avoid that the digest cache is accidentally put. The digest_cache_found_t
+ * type can be converted back to a digest cache pointer, by
+ * calling digest_cache_from_found_t().
+ *
+ * Return: A positive digest_cache_found_t if the digest is found, zero if not.
+ */
+digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
+					 struct digest_cache *digest_cache,
+					 u8 *digest, enum hash_algo algo)
+{
+	int ret;
+
+	ret = digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
+	return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;
+}
+EXPORT_SYMBOL_GPL(digest_cache_lookup);
+
+/**
+ * digest_cache_htable_free - Free the hash tables
+ * @digest_cache: Digest cache
+ *
+ * This function removes all digests from all hash tables in the digest cache,
+ * and frees the memory.
+ */
+void digest_cache_htable_free(struct digest_cache *digest_cache)
+{
+	struct htable *h, *h_tmp;
+	struct digest_cache_entry *p;
+	struct hlist_node *q;
+	int i;
+
+	list_for_each_entry_safe(h, h_tmp, &digest_cache->htables, next) {
+		for (i = 0; i < h->num_slots; i++) {
+			hlist_for_each_entry_safe(p, q, &h->slots[i], hnext) {
+				hlist_del(&p->hnext);
+				pr_debug("Removed digest %s:%*phN from digest cache %s\n",
+					 hash_algo_name[h->algo],
+					 hash_digest_size[h->algo], p->digest,
+					 digest_cache->path_str);
+				kfree(p);
+			}
+		}
+
+		list_del(&h->next);
+		kfree(h->slots);
+		kfree(h);
+	}
+}
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index bbf5eefe5c82..f6ffeaa25288 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -16,8 +16,40 @@
 /* Digest cache bits in flags. */
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
 
+/**
+ * struct digest_cache_entry - Entry of a digest cache hash table
+ * @hnext: Pointer to the next element in the collision list
+ * @digest: Stored digest
+ *
+ * This structure represents an entry of a digest cache hash table, storing a
+ * digest.
+ */
+struct digest_cache_entry {
+	struct hlist_node hnext;
+	u8 digest[];
+} __packed;
+
+/**
+ * struct htable - Hash table
+ * @next: Next hash table in the linked list
+ * @slots: Hash table slots
+ * @num_slots: Number of slots
+ * @num_digests: Number of digests stored in the hash table
+ * @algo: Algorithm of the digests
+ *
+ * This structure is a hash table storing digests of file data or metadata.
+ */
+struct htable {
+	struct list_head next;
+	struct hlist_head *slots;
+	unsigned int num_slots;
+	u64 num_digests;
+	enum hash_algo algo;
+};
+
 /**
  * struct digest_cache - Digest cache
+ * @htables: Hash tables (one per algorithm)
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
@@ -25,6 +57,7 @@
  * This structure represents a cache of digests extracted from a digest list.
  */
 struct digest_cache {
+	struct list_head htables;
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
@@ -84,4 +117,14 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
 					 char *path_str, char *filename);
 
+/* htable.c */
+int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_digests,
+			     enum hash_algo algo);
+int digest_cache_htable_add(struct digest_cache *digest_cache, u8 *digest,
+			    enum hash_algo algo);
+int digest_cache_htable_lookup(struct dentry *dentry,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo);
+void digest_cache_htable_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index 661c8d106791..0b201af6432c 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -48,6 +48,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
+	INIT_LIST_HEAD(&digest_cache->htables);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -63,6 +64,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
  */
 static void digest_cache_free(struct digest_cache *digest_cache)
 {
+	digest_cache_htable_free(digest_cache);
+
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
 	kmem_cache_free(digest_cache_cache, digest_cache);
-- 
2.34.1


