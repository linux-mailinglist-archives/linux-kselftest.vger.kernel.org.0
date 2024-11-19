Return-Path: <linux-kselftest+bounces-22259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF19D2411
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC6A1F22D7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E01C4608;
	Tue, 19 Nov 2024 10:54:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9719C553;
	Tue, 19 Nov 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013669; cv=none; b=iKN8JqQPzzk8UYrdyFWeHpqrnMFo/cWp3mXEGIxTYf1DSwYVOJ9ZEg1WLM2zX1V7ccmiDnkLmnQT1+7oiKgI8PAc8byneLQFfwePAyrhNFMKqj9OravsueNHglk9TO6D++BWqh1W+ERIZ6piA2NALGLwE17j1QE+hJtWRp5LJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013669; c=relaxed/simple;
	bh=y6p5Z7O9gV4y2W4jbw8MsZjbIEern3boBWypsYiDbLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVhqMh9Nv7JrYxL0+9IYQkGZTNb03NhZrq3UwS29IHlnzN1aZxeHiL2VYNPH8QLZboOLN7MCd33GH+ZCR6U7NNqbBihqxesRKUT4nsCog3cjk7eif3KyiVyqUjUQDbH5+XDVJ8Mo7vufpIPGN1mkuUxU1w+qD3DASsH7bABfpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt16y2HnVz9v7NH;
	Tue, 19 Nov 2024 18:33:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 79ED114093B;
	Tue, 19 Nov 2024 18:54:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHsyNDbjxnj1znAQ--.1193S2;
	Tue, 19 Nov 2024 11:54:13 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
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
	linux-api@vger.kernel.org,
	linux-modules@vger.kernel.org,
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
Subject: [PATCH v6 10/15] digest_cache: Add management of verification data
Date: Tue, 19 Nov 2024 11:49:17 +0100
Message-ID: <20241119104922.2772571-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHsyNDbjxnj1znAQ--.1193S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr1rKrWDtF4UAFWfGryxGrg_yoWkJw47p3
	s29F1DKr4rZr1fCwnrAF129r1rKFZ5tF47Jw48ur15ZF45Xr1jv3W8A34UuryrJrW8Wa17
	tr42gw1Uur4DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU0uMKtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEkAAAsH

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

digest_cache_verif_set() receives as argument a file descriptor and calls
digest_cache_from_file_sec() to obtain back the digest cache being created
from that file descriptor. The digest cache being created was associated to
the file descriptor by digest_cache_populate(), before reading the digest
list from the kernel, by calling digest_cache_to_file_sec().

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
returned digest cache reference to digest_cache_verif_get().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h               |  17 +++
 security/integrity/digest_cache/Makefile   |   3 +-
 security/integrity/digest_cache/internal.h |  22 ++++
 security/integrity/digest_cache/main.c     |   3 +
 security/integrity/digest_cache/verif.c    | 131 +++++++++++++++++++++
 5 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache/verif.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index a9d731990b7c..d2483fe588be 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -47,6 +47,10 @@ bool digest_cache_opened_fd(struct file *file);
 struct digest_cache *digest_cache_lookup(struct dentry *dentry,
 					 struct digest_cache *digest_cache,
 					 u8 *digest, enum hash_algo algo);
+int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
+			   size_t size);
+void *digest_cache_verif_get(struct digest_cache *digest_cache,
+			     const char *verif_id);
 
 /* Parser API */
 int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_digests,
@@ -81,6 +85,19 @@ digest_cache_lookup(struct dentry *dentry, struct digest_cache *digest_cache,
 	return NULL;
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
 static inline int digest_cache_htable_init(struct digest_cache *digest_cache,
 					   u64 num_digests, enum hash_algo algo)
 {
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 3b81edea065b..2a0f2500e227 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 obj-$(CONFIG_DIGEST_CACHE_TLV_PARSER) += parsers/tlv.o
 
-digest_cache-y := main.o secfs.o htable.o parsers.o populate.o modsig.o
+digest_cache-y := main.o secfs.o htable.o parsers.o populate.o modsig.o \
+		  verif.o
 
 CFLAGS_parsers.o += -DPARSERS_DIR=\"$(MODLIB)/kernel/security/integrity/digest_cache/parsers\"
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index 2171ea8423ff..c64e91b75a47 100644
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
@@ -72,6 +87,8 @@ struct htable {
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
+ * @verif_data: Verification data regarding the digest list
+ * @verif_data_lock: Protects verification data modifications
  *
  * This structure represents a cache of digests extracted from a digest list.
  */
@@ -80,6 +97,8 @@ struct digest_cache {
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
+	struct list_head verif_data;
+	spinlock_t verif_data_lock;
 };
 
 /**
@@ -191,4 +210,7 @@ int digest_cache_populate(struct dentry *dentry,
 /* modsig.c */
 size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 
+/* verif.c */
+void digest_cache_verif_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index ad0f34c7ef9b..11a0445592f0 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -52,6 +52,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
 	INIT_LIST_HEAD(&digest_cache->htables);
+	INIT_LIST_HEAD(&digest_cache->verif_data);
+	spin_lock_init(&digest_cache->verif_data_lock);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -68,6 +70,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
+	digest_cache_verif_free(digest_cache);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
diff --git a/security/integrity/digest_cache/verif.c b/security/integrity/digest_cache/verif.c
new file mode 100644
index 000000000000..03ebf0de764b
--- /dev/null
+++ b/security/integrity/digest_cache/verif.c
@@ -0,0 +1,131 @@
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
+	/*
+	 * Zero the data, so that we can always call free_verif() to free a
+	 * partially filled structure (if a pointer is NULL, will not be freed).
+	 */
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
-- 
2.47.0.118.gfd3785337b


