Return-Path: <linux-kselftest+bounces-17265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C696DD7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18818286472
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303419E804;
	Thu,  5 Sep 2024 15:08:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A919DFA4;
	Thu,  5 Sep 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548921; cv=none; b=MSL9yXxoKJ9fzeFw7lwqf284Zx9zBauwPihhYd73+IzH7VXdCBBDdil5sG0MoALmGSjxqUjDoRiHCCQF4pG248A9k474BBWhj9Q3ed7HkMjqBRYBWcspqLv+x+R7Mv1iDInT305yVmZoiVO8EHd3D35/zQZIQb99trG82G2HJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548921; c=relaxed/simple;
	bh=YzxpC1adSZX1DE1u2jed4h3rwZgAsj1hxxRm44BH92c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omdSB9uj9RlrdV5HZRzykXRQavfOdI73LecvE+BRp7KfBFAVWb//G1YL0V9+KkGYGESwkPrG6BFbGhCiccLk0SDk5tWoZSfIVsM7xIolIsUWt7y3dUWT0uQHVUCLKbE/PrPzjbGqYva/Lq5+gJaWscghmlc3d+AIiYjp9Ld/vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02D73cP7z9v7Jk;
	Thu,  5 Sep 2024 22:43:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B51EA14065B;
	Thu,  5 Sep 2024 23:08:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S11;
	Thu, 05 Sep 2024 16:08:36 +0100 (CET)
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
Subject: [PATCH v5 09/14] digest_cache: Add management of verification data
Date: Thu,  5 Sep 2024 17:05:38 +0200
Message-Id: <20240905150543.3766895-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S11
X-Coremail-Antispam: 1UD129KBjvAXoWfGr15Kr1rJrW8KFW3ur47XFb_yoW8Xr1xWo
	ZIka9rtw48WFyUZr4vyF17AayUWw4Fg3yxAr1kGFWUuFyIyryUJasrGFn8JFW5Xr1rGFZ7
	Aw18Aw4DJFW8tr93n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOe7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
	07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK3AAAsd

From: Roberto Sassu <roberto.sassu@huawei.com>

The Integrity Digest Cache can support other LSMs in their decisions of
granting access to file data and metadata.

However, the information alone about whether a digest was found in a digest
cache might not be sufficient, because for example those LSMs wouldn't know
about the integrity of the digest list digests were extracted from.

Introduce digest_cache_verif_set() to let the same LSMs (or a chosen
integrity provider) evaluate the digest list being read during the creation
of the digest cache, by implementing the kernel_post_read_file LSM hook,
and let them attach their verification data to that digest cache.

Reserve space in the file descriptor security blob for the digest cache
pointer (through IMA). Also introduce digest_cache_to_file_sec() to set
that pointer before reading the digest list, and
digest_cache_from_file_sec() to retrieve the pointer back from the file
descriptor passed by LSMs with digest_cache_verif_set().

Multiple providers are supported, in the event there are multiple
integrity LSMs active. Each provider should also provide a unique verifier
ID as an argument to digest_cache_verif_set(), so that verification data
can be distinguished. Concurrent set are protected by the verif_data_lock
spinlock.

A caller of digest_cache_get() can retrieve back the verification data by
calling digest_cache_verif_get() and passing a digest cache pointer and the
desired verifier ID.

Since directory digest caches are not populated themselves, LSMs have to do
a lookup first to get the digest cache containing the digest, and pass the
uintptr_t value cast to (struct digest_cache *) to
digest_cache_verif_get().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h               |  17 +++
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/internal.h |  43 ++++++-
 security/integrity/digest_cache/main.c     |   8 +-
 security/integrity/digest_cache/populate.c |   2 +
 security/integrity/digest_cache/verif.c    | 127 +++++++++++++++++++++
 security/integrity/ima/ima_main.c          |   5 +-
 7 files changed, 200 insertions(+), 4 deletions(-)
 create mode 100644 security/integrity/digest_cache/verif.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 53a7edc04310..92e17100e9c9 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -19,6 +19,10 @@ void digest_cache_put(struct digest_cache *digest_cache);
 uintptr_t digest_cache_lookup(struct dentry *dentry,
 			      struct digest_cache *digest_cache,
 			      u8 *digest, enum hash_algo algo);
+int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
+			   size_t size);
+void *digest_cache_verif_get(struct digest_cache *digest_cache,
+			     const char *verif_id);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -37,5 +41,18 @@ static inline uintptr_t digest_cache_lookup(struct dentry *dentry,
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
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 681276a4c756..77dd98a1a07d 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index f8ec51405bae..9083a87374a5 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -18,6 +18,21 @@
 #define INIT_STARTED		1	/* Digest cache init started. */
 #define INVALID			2	/* Digest cache marked as invalid. */
 
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
@@ -73,6 +88,8 @@ struct htable {
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
  * @digest_list_path: Path structure of the digest list
+ * @verif_data: Verification data regarding the digest list
+ * @verif_data_lock: Protects verification data modifications
  *
  * This structure represents a cache of digests extracted from a digest list.
  */
@@ -82,6 +99,8 @@ struct digest_cache {
 	char *path_str;
 	unsigned long flags;
 	struct path digest_list_path;
+	struct list_head verif_data;
+	spinlock_t verif_data_lock;
 };
 
 /**
@@ -102,6 +121,7 @@ struct digest_cache_security {
 };
 
 extern loff_t inode_sec_offset;
+extern loff_t file_sec_offset;
 extern char *default_path_str;
 extern struct rw_semaphore default_path_sem;
 
@@ -138,6 +158,24 @@ digest_cache_unref(struct digest_cache *digest_cache)
 	return (ref_is_zero) ? digest_cache : NULL;
 }
 
+static inline void digest_cache_to_file_sec(const struct file *file,
+					    struct digest_cache *digest_cache)
+{
+	struct digest_cache **digest_cache_sec;
+
+	digest_cache_sec = file->f_security + file_sec_offset;
+	*digest_cache_sec = digest_cache;
+}
+
+static inline struct digest_cache *
+digest_cache_from_file_sec(const struct file *file)
+{
+	struct digest_cache **digest_cache_sec;
+
+	digest_cache_sec = file->f_security + file_sec_offset;
+	return *digest_cache_sec;
+}
+
 /* main.c */
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
@@ -145,7 +183,7 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 struct digest_cache *digest_cache_init(struct dentry *dentry,
 				       struct digest_cache *digest_cache);
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
-				loff_t inode_offset);
+				loff_t inode_offset, loff_t file_offset);
 
 /* secfs.c */
 int __init digest_cache_secfs_init(struct dentry *dir);
@@ -167,4 +205,7 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 /* modsig.c */
 size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 
+/* verif.c */
+void digest_cache_verif_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 6878ebe5b779..fda6ac599a2d 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -17,6 +17,7 @@ static int digest_cache_enabled __ro_after_init;
 static struct kmem_cache *digest_cache_cache __read_mostly;
 
 loff_t inode_sec_offset;
+loff_t file_sec_offset;
 
 char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
 
@@ -51,6 +52,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
 	INIT_LIST_HEAD(&digest_cache->htables);
+	INIT_LIST_HEAD(&digest_cache->verif_data);
+	spin_lock_init(&digest_cache->verif_data_lock);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -67,6 +70,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
+	digest_cache_verif_free(digest_cache);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
@@ -421,17 +425,19 @@ static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
  * digest_cache_do_init - Initialize the Integrity Digest Cache
  * @lsm_id: ID of LSM registering the LSM hooks
  * @inode_offset: Offset in the inode security blob
+ * @file_offset: Offset in the file security blob
  *
  * Initialize the Integrity Digest Cache, by instantiating a cache for the
  * digest_cache structure and by registering the LSM hooks as part of the
  * calling LSM.
  */
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
-				loff_t inode_offset)
+				loff_t inode_offset, loff_t file_offset)
 {
 	init_rwsem(&default_path_sem);
 
 	inode_sec_offset = inode_offset;
+	file_sec_offset = file_offset;
 
 	digest_cache_cache = kmem_cache_create("digest_cache_cache",
 					       sizeof(struct digest_cache),
diff --git a/security/integrity/digest_cache/populate.c b/security/integrity/digest_cache/populate.c
index 1c68d957bf1d..1ebf3a11f50b 100644
--- a/security/integrity/digest_cache/populate.c
+++ b/security/integrity/digest_cache/populate.c
@@ -115,6 +115,8 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 		return PTR_ERR(file);
 	}
 
+	digest_cache_to_file_sec(file, digest_cache);
+
 	w.data = NULL;
 	w.file = file;
 	INIT_WORK_ONSTACK(&w.work, digest_cache_read_digest_list);
diff --git a/security/integrity/digest_cache/verif.c b/security/integrity/digest_cache/verif.c
new file mode 100644
index 000000000000..de47bd9dc388
--- /dev/null
+++ b/security/integrity/digest_cache/verif.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Manage verification data regarding digest lists.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
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
+ * being read to populate the digest cache. Verifier ID must be unique.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
+			   size_t size)
+{
+	struct digest_cache *digest_cache = digest_cache_from_file_sec(file);
+	struct digest_cache_verif *new_verif, *verif;
+	/* All allocations done by kprobe must be atomic (non-sleepable). */
+	gfp_t flags = !strncmp(verif_id, "kprobe", 6) ? GFP_ATOMIC : GFP_KERNEL;
+	int ret = 0;
+
+	new_verif = kzalloc(sizeof(*new_verif), flags);
+	if (!new_verif)
+		return -ENOMEM;
+
+	new_verif->verif_id = kstrdup(verif_id, flags);
+	if (!new_verif->verif_id) {
+		free_verif(new_verif);
+		return -ENOMEM;
+	}
+
+	new_verif->data = kmemdup(data, size, flags);
+	if (!new_verif->data) {
+		free_verif(new_verif);
+		return -ENOMEM;
+	}
+
+	spin_lock(&digest_cache->verif_data_lock);
+	list_for_each_entry(verif, &digest_cache->verif_data, list) {
+		if (!strcmp(verif->verif_id, verif_id)) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+	list_add_tail_rcu(&new_verif->list, &digest_cache->verif_data);
+out:
+	spin_unlock(&digest_cache->verif_data_lock);
+
+	if (ret < 0)
+		free_verif(new_verif);
+
+	return ret;
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7cbd78ca3be5..646d900828e0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1208,7 +1208,8 @@ static int __init init_ima_lsm(void)
 	init_ima_appraise_lsm(&ima_lsmid);
 	if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE))
 		digest_cache_do_init(&ima_lsmid, ima_blob_sizes.lbs_inode +
-				     sizeof(struct ima_iint_cache *));
+				     sizeof(struct ima_iint_cache *),
+				     ima_blob_sizes.lbs_file);
 	return 0;
 }
 
@@ -1217,6 +1218,8 @@ struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_DIGEST_CACHE
 	 + sizeof(struct digest_cache_security)
 #endif
+	,
+	.lbs_file = sizeof(struct digest_cache *),
 };
 
 DEFINE_LSM(ima) = {
-- 
2.34.1


