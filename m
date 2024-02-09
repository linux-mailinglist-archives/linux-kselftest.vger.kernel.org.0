Return-Path: <linux-kselftest+bounces-4440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8884F6CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13991C21AD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5576692E1;
	Fri,  9 Feb 2024 14:11:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA916A320;
	Fri,  9 Feb 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487908; cv=none; b=WxVeKEXtiJzSbvPa8M7haDexMUCOg7+TYOLsrWmBfmU75I4cnwWuRl6VQ4s+b30KxidwMRlx/8RyaqBUU6OQV9U/BPotDVemisPbLIUZvAn4eKVjKhd23+Hcr3BlHfUNg1NNbZ+UH7G0+xpYCuHqzElVpcHkrVZu73PyYh4Zo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487908; c=relaxed/simple;
	bh=WLMZH5azDphMOQPmm/BFk1TN38+Xep2BvMxGYFPSTVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgaGC6GnCqCrAnC+vq1IDjVuUZ4HzdB9UNrjNRskP7hYLneveKiYHOhqXAVBscuHB2d73sf1kgwQ8wngGXYGF9BCkIUxdcyawMsZze3yqnPZRPHjrJxZ/vgi3Keg9/BJKC/mgtF3UDOTm+JMMLCSZ/tdqfyGsbYs1GtKv96Hez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TWZzx0zJZz9xFmM;
	Fri,  9 Feb 2024 21:52:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B15071405F9;
	Fri,  9 Feb 2024 22:11:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S10;
	Fri, 09 Feb 2024 15:11:33 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
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
	petrtesarik@huaweicloud.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 08/13] digest_cache: Add management of verification data
Date: Fri,  9 Feb 2024 15:09:12 +0100
Message-Id: <20240209140917.846878-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S10
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWkJw1DAF4DGF4rCFy8Zrb_yoWkuF4Up3
	s29F1Dtr4rZr13Jw17AF129r1rtFZ5tF47Jw48ur13ZF47Xr1jy3W8A34UZry5JrW8Wa17
	tr47Kw1Uur1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
	GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y4fwAEsq

From: Roberto Sassu <roberto.sassu@huawei.com>

The digest_cache LSM can support other LSMs in their decisions of granting
access to file content and metadata.

However, the information alone about whether a digest was found in a digest
cache might not be sufficient, because for example those LSMs wouldn't know
whether the digest cache itself was created from authentic data.

Introduce digest_cache_verif_set() to let the same LSMs (or a chosen
integrity provider) evaluate the digest list being read during the creation
of the digest cache, by implementing the kernel_post_read_file LSM hook,
and let them attach their verification data to that digest cache.

Reserve space in the file descriptor security blob for the digest cache
pointer. Also introduce digest_cache_to_file_sec() to set that pointer
before calling kernel_read_file() in digest_cache_populate(), and
digest_cache_from_file_sec() to retrieve the pointer back from the file
descriptor passed by LSMs with digest_cache_verif_set().

Multiple providers are supported, in the event there are multiple
integrity LSMs active. Each provider should also provide an unique verifier
ID as an argument to digest_cache_verif_set(), so that verification data
can be distinguished.

A caller of digest_cache_get() can retrieve back the verification data by
calling digest_cache_verif_get() and passing a digest cache pointer and the
desired verifier ID.

Since directory digest caches are not populated themselves, LSMs have to do
a lookup first to get the digest cache containing the digest, call
digest_cache_from_found_t() to convert the returned digest_cache_found_t
type to a digest cache pointer, and pass that to digest_cache_verif_get().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h     |  17 +++++
 security/digest_cache/Makefile   |   2 +-
 security/digest_cache/internal.h |  40 +++++++++++
 security/digest_cache/main.c     |   4 ++
 security/digest_cache/populate.c |   2 +
 security/digest_cache/verif.c    | 116 +++++++++++++++++++++++++++++++
 6 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 security/digest_cache/verif.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 4872700ac205..9db8128513ca 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -44,6 +44,10 @@ void digest_cache_put(struct digest_cache *digest_cache);
 digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
 					 struct digest_cache *digest_cache,
 					 u8 *digest, enum hash_algo algo);
+int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
+			   size_t size);
+void *digest_cache_verif_get(struct digest_cache *digest_cache,
+			     const char *verif_id);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -62,5 +66,18 @@ digest_cache_lookup(struct dentry *dentry, struct digest_cache *digest_cache,
 	return 0UL;
 }
 
+static inline int digest_cache_verif_set(struct file *file,
+					 const char *verif_id, void *data,
+					 size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void *digest_cache_verif_get(struct digest_cache *digest_cache,
+					   const char *verif_id)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index eca4076497e6..37a473c7bc28 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index 0d9c01dd9bc8..a266925a6cce 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -17,6 +17,21 @@
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
 #define INVALID			1	/* Digest cache marked as invalid. */
 
+/**
+ * struct digest_cache_verif
+ * @list: Linked list
+ * @verif_id: Identifier of who verified the digest list
+ * @data: Opaque data set by the digest list verifier
+ *
+ * This structure contains opaque data containing the result of verification
+ * of the digest list by a verifier.
+ */
+struct digest_cache_verif {
+	struct list_head list;
+	char *verif_id;
+	void *data;
+};
+
 /**
  * struct read_work - Structure to schedule reading a digest list
  * @work: Work structure
@@ -71,6 +86,8 @@ struct htable {
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
+ * @verif_data: Verification data regarding the digest list
+ * @verif_data_lock: Protect concurrent verification data additions
  *
  * This structure represents a cache of digests extracted from a digest list.
  */
@@ -79,6 +96,8 @@ struct digest_cache {
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
+	struct list_head verif_data;
+	spinlock_t verif_data_lock;
 };
 
 /**
@@ -130,6 +149,24 @@ digest_cache_unref(struct digest_cache *digest_cache)
 	return (ref_is_zero) ? digest_cache : NULL;
 }
 
+static inline void digest_cache_to_file_sec(const struct file *file,
+					    struct digest_cache *digest_cache)
+{
+	struct digest_cache **digest_cache_sec;
+
+	digest_cache_sec = file->f_security + digest_cache_blob_sizes.lbs_file;
+	*digest_cache_sec = digest_cache;
+}
+
+static inline struct digest_cache *
+digest_cache_from_file_sec(const struct file *file)
+{
+	struct digest_cache **digest_cache_sec;
+
+	digest_cache_sec = file->f_security + digest_cache_blob_sizes.lbs_file;
+	return *digest_cache_sec;
+}
+
 /* main.c */
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
@@ -153,4 +190,7 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 /* modsig.c */
 size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 
+/* verif.c */
+void digest_cache_verif_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index 8e9ab99081c3..d726832e5913 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -49,6 +49,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
 	INIT_LIST_HEAD(&digest_cache->htables);
+	INIT_LIST_HEAD(&digest_cache->verif_data);
+	spin_lock_init(&digest_cache->verif_data_lock);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -65,6 +67,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
+	digest_cache_verif_free(digest_cache);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
@@ -329,6 +332,7 @@ EXPORT_SYMBOL_GPL(digest_cache_put);
 
 struct lsm_blob_sizes digest_cache_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct digest_cache_security),
+	.lbs_file = sizeof(struct digest_cache *),
 };
 
 /**
diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
index 1770c8385017..9c2fc2295310 100644
--- a/security/digest_cache/populate.c
+++ b/security/digest_cache/populate.c
@@ -123,6 +123,8 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 		return PTR_ERR(file);
 	}
 
+	digest_cache_to_file_sec(file, digest_cache);
+
 	w.data = NULL;
 	w.file = file;
 	INIT_WORK_ONSTACK(&w.work, digest_cache_read_digest_list);
diff --git a/security/digest_cache/verif.c b/security/digest_cache/verif.c
new file mode 100644
index 000000000000..dd480bdc805a
--- /dev/null
+++ b/security/digest_cache/verif.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Manage verification data regarding digest lists.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include "internal.h"
+
+/**
+ * free_verif - Free a digest_cache_verif structure
+ * @verif: digest_cache_verif structure
+ *
+ * Free the space allocated for a digest_cache_verif structure.
+ */
+static void free_verif(struct digest_cache_verif *verif)
+{
+	kfree(verif->data);
+	kfree(verif->verif_id);
+	kfree(verif);
+}
+
+/**
+ * digest_cache_verif_set - Set digest cache verification data
+ * @file: File descriptor of the digest list being read to populate digest cache
+ * @verif_id: Verifier ID
+ * @data: Verification data (opaque)
+ * @size: Size of @data
+ *
+ * This function lets a verifier supply verification data about a digest list
+ * being read to populate the digest cache.
+ *
+ * Return: Zero on success, -ENOMEM if out of memory.
+ */
+int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
+			   size_t size)
+{
+	struct digest_cache *digest_cache = digest_cache_from_file_sec(file);
+	struct digest_cache_verif *new_verif;
+
+	/*
+	 * All allocations must be atomic (non-sleepable) since kprobe does not
+	 * allow otherwise (kprobe is needed for testing).
+	 */
+	new_verif = kzalloc(sizeof(*new_verif), GFP_ATOMIC);
+	if (!new_verif)
+		return -ENOMEM;
+
+	new_verif->verif_id = kstrdup(verif_id, GFP_ATOMIC);
+	if (!new_verif->verif_id) {
+		free_verif(new_verif);
+		return -ENOMEM;
+	}
+
+	new_verif->data = kmemdup(data, size, GFP_ATOMIC);
+	if (!new_verif->data) {
+		free_verif(new_verif);
+		return -ENOMEM;
+	}
+
+	spin_lock(&digest_cache->verif_data_lock);
+	list_add_tail_rcu(&new_verif->list, &digest_cache->verif_data);
+	spin_unlock(&digest_cache->verif_data_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(digest_cache_verif_set);
+
+/**
+ * digest_cache_verif_get - Get digest cache verification data
+ * @digest_cache: Digest cache
+ * @verif_id: Verifier ID
+ *
+ * This function returns the verification data previously set by a verifier
+ * with digest_cache_verif_set().
+ *
+ * Return: Verification data if found, NULL otherwise.
+ */
+void *digest_cache_verif_get(struct digest_cache *digest_cache,
+			     const char *verif_id)
+{
+	struct digest_cache_verif *verif;
+	void *verif_data = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(verif, &digest_cache->verif_data, list) {
+		if (!strcmp(verif->verif_id, verif_id)) {
+			verif_data = verif->data;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return verif_data;
+}
+EXPORT_SYMBOL_GPL(digest_cache_verif_get);
+
+/**
+ * digest_cache_verif_free - Free all digest_cache_verif structures
+ * @digest_cache: Digest cache
+ *
+ * This function frees the space allocated for all digest_cache_verif
+ * structures in the digest cache.
+ */
+void digest_cache_verif_free(struct digest_cache *digest_cache)
+{
+	struct digest_cache_verif *p, *q;
+
+	/* No need to lock, called when nobody else has a digest cache ref. */
+	list_for_each_entry_safe(p, q, &digest_cache->verif_data, list) {
+		list_del(&p->list);
+		free_verif(p);
+	}
+}
-- 
2.34.1


