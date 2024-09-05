Return-Path: <linux-kselftest+bounces-17260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF796DD60
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E6E1F22232
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4E27D405;
	Thu,  5 Sep 2024 15:07:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054419EEB1;
	Thu,  5 Sep 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548867; cv=none; b=ee3mcYJhY9ms5fZf+GEnty9h5Vyu27VTyCK7fc8dcFxc6dU+Ylu7qUHO0t7eKIb1vsbOGi4Q6R/hUdj/bOrUAWrxG2bClJdIUihAJ7uGna1b9CoPl7bgPnX8QRfAWbGfSV8Qd1z9HXDzg8Y3Wz9swUNsnxbZ4bJbcdJ6/hy+ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548867; c=relaxed/simple;
	bh=sXNXSmtmklTHs1BLx/FLW9Rpe0FdOo8nfSVnM8NhxRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqxfxoH+or2I+EDAI+YKBJExBxu/+6unXTODwJrFOibTj4rfvaYTnmUOR6C/FT3azBpdz5Vvj0E2YOJgZIOVNWnA55OiMbbUe5TBl9wcdTBQkST6zdChe+fFKPkXQRxAQZM/uNGrD5DjaV7prjCaAzN1/v6BJ0zbHB6zQ+F4v+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02Kb3zJfz9v7Hq;
	Thu,  5 Sep 2024 22:48:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9A8B11401E9;
	Thu,  5 Sep 2024 23:07:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S7;
	Thu, 05 Sep 2024 16:07:40 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v5 05/14] digest_cache: Add hash tables and operations
Date: Thu,  5 Sep 2024 17:05:34 +0200
Message-Id: <20240905150543.3766895-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S7
X-Coremail-Antispam: 1UD129KBjvAXoW3tF4fJFW7uw1UCFW5JrWkZwb_yoW8XrWfto
	ZIkF4UJw18WFy3ua1DCF17Za1UW34rt34xAr4kXrWDX3WvqFyUJ3ZFkFn8JFy3Xry8GrZ7
	Aw1kJ3yUJa18tr93n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUVdgAUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oKmwAAsQ

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

Add digest_cache_htable_free(), to let the Integrity Digest Cache free the
hash tables at the time a digest cache is freed.

Add digest_cache_htable_lookup() to search a digest in the hash table of a
digest cache for a given algorithm.

Add digest_cache_lookup() to the public API, to let users of the Integrity
Digest Cache search a digest in a digest cache and, in a subsequent patch,
to search it in the digest caches for each directory entry.

Return the digest cache containing the digest as uintptr_t, to avoid it
being accidentally put. It should be cast back to (struct digest_cache *)
in the functions that require it.

Finally, add digest_cache_hash_key() to compute the hash table key from the
first two bytes of the digest (modulo the number of slots).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h               |  11 +
 security/integrity/digest_cache/Kconfig    |  11 +
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/htable.c   | 250 +++++++++++++++++++++
 security/integrity/digest_cache/internal.h |  43 ++++
 security/integrity/digest_cache/main.c     |   3 +
 6 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache/htable.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 86e6c5a0b896..53a7edc04310 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -11,10 +11,14 @@
 #define _LINUX_DIGEST_CACHE_H
 
 #include <linux/fs.h>
+#include <crypto/hash_info.h>
 
 #ifdef CONFIG_INTEGRITY_DIGEST_CACHE
 struct digest_cache *digest_cache_get(struct dentry *dentry);
 void digest_cache_put(struct digest_cache *digest_cache);
+uintptr_t digest_cache_lookup(struct dentry *dentry,
+			      struct digest_cache *digest_cache,
+			      u8 *digest, enum hash_algo algo);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -26,5 +30,12 @@ static inline void digest_cache_put(struct digest_cache *digest_cache)
 {
 }
 
+static inline uintptr_t digest_cache_lookup(struct dentry *dentry,
+					    struct digest_cache *digest_cache,
+					    u8 *digest, enum hash_algo algo)
+{
+	return 0UL;
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/integrity/digest_cache/Kconfig b/security/integrity/digest_cache/Kconfig
index 6e61089acbe2..11097464540a 100644
--- a/security/integrity/digest_cache/Kconfig
+++ b/security/integrity/digest_cache/Kconfig
@@ -19,3 +19,14 @@ config DIGEST_LIST_DEFAULT_PATH
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
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index c351186d4e1e..0092c913979d 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o
+digest_cache-y := main.o secfs.o htable.o
diff --git a/security/integrity/digest_cache/htable.c b/security/integrity/digest_cache/htable.c
new file mode 100644
index 000000000000..385f81047b0c
--- /dev/null
+++ b/security/integrity/digest_cache/htable.c
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
+#define pr_fmt(fmt) "digest_cache: "fmt
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
+ * @num_digests: Number of digests to add to the hash table
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
+	unsigned int i;
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
+ * This function searches the passed digest and algorithm in the digest cache.
+ *
+ * Return: Zero if the digest is found, a POSIX error code otherwise.
+ */
+int digest_cache_htable_lookup(struct dentry *dentry,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo)
+{
+	struct digest_cache_entry *entry;
+	struct htable *h;
+	unsigned int key;
+	int digest_len = hash_digest_size[algo];
+	int search_depth = 0, ret = -ENOENT;
+
+	h = lookup_htable(digest_cache, algo);
+	if (!h)
+		goto out;
+
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
+out:
+	pr_debug("Cache miss for file %s, digest %s:%*phN not in digest cache %s\n",
+		 dentry->d_name.name, hash_algo_name[algo], digest_len, digest,
+		 digest_cache->path_str);
+	return ret;
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
+ * It returns the digest cache reference as uintptr_t, to avoid that the digest
+ * cache is accidentally put. It should be cast to a digest_cache pointer where
+ * the function requires that.
+ *
+ * Return: A positive uintptr_t if the digest is found, zero if not.
+ */
+uintptr_t digest_cache_lookup(struct dentry *dentry,
+			      struct digest_cache *digest_cache,
+			      u8 *digest, enum hash_algo algo)
+{
+	int ret;
+
+	ret = digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
+	if (ret < 0)
+		return 0UL;
+
+	return (uintptr_t)digest_cache;
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
+	unsigned int i;
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
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index 2fcfa9b4cf13..f4b146a1bbaf 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -18,8 +18,40 @@
 #define INIT_STARTED		1	/* Digest cache init started. */
 #define INVALID			2	/* Digest cache marked as invalid. */
 
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
+};
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
@@ -28,6 +60,7 @@
  * This structure represents a cache of digests extracted from a digest list.
  */
 struct digest_cache {
+	struct list_head htables;
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
@@ -100,4 +133,14 @@ int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 /* secfs.c */
 int __init digest_cache_secfs_init(struct dentry *dir);
 
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
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 0e25f573166a..a74fc1183332 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -50,6 +50,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
+	INIT_LIST_HEAD(&digest_cache->htables);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -65,6 +66,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
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


