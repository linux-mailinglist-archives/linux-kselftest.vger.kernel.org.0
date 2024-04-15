Return-Path: <linux-kselftest+bounces-7975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7650B8A538F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D093284F57
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581480C0C;
	Mon, 15 Apr 2024 14:27:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D180BFE;
	Mon, 15 Apr 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191244; cv=none; b=vAOndsF4bbm8zbz9ODylacTCinxt2bNjIk4SkZlQgUIYH5aF1TkOn19b9lfkxo2YJFRnDSdKIUihecf4DGtCD7Zibqou/cja7YIz9lQA7R+rz1tWC+/gYrWG1CSkZrkVkkTLfztcuc+1MC3XIPE7DZmTYQZHfLvGA+MiSdSpkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191244; c=relaxed/simple;
	bh=xMiwM8N6A0QvO6nnvH3L0ZOn6X5TyXl/kn0pTzA3sls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV7J4gr1wZf1NLvkZorlxYJuB4aBZLRJF3fS5UoLTFOu8GSTozGYgZ9Xu/23KJsIIEojv4nLIp1Tk7GOThZtwAbKNG89O8C4W1o23buvJxhskJoY4+z0NnZPYbJGrQvLekPbNEjZHKZoB+2MgfCluAiBGEG9nZjx4ez36D0BznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJ8GP2kNwz9xGnC;
	Mon, 15 Apr 2024 22:10:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 05E4F140801;
	Mon, 15 Apr 2024 22:27:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S10;
	Mon, 15 Apr 2024 15:27:12 +0100 (CET)
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
Subject: [PATCH v4 08/14] digest_cache: Add management of verification data
Date: Mon, 15 Apr 2024 16:24:30 +0200
Message-Id: <20240415142436.2545003-9-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S10
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWkJw1DAF4DGF4rCFy8Zrb_yoWkury5p3
	s29F1Dtr4rZr13Jw17AF129r1rtFZ5tF47Jw48ur13ZF47Xr1jy3W8A34UuryrJrW8ua17
	tr47Kw1Uur1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXV
	W8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZE
	Xa7IU04rW7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h0twAAsi

From: Roberto Sassu <roberto.sassu@huawei.com>

The digest_cache LSM can support other LSMs in their decisions of granting
access to file data and metadata.

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
 security/digest_cache/main.c     |   5 ++
 security/digest_cache/populate.c |   2 +
 security/digest_cache/verif.c    | 116 +++++++++++++++++++++++++++++++
 6 files changed, 181 insertions(+), 1 deletion(-)
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
index cc6752a8683e..4929d25e7972 100644
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
+ * @mutex: Protect digest cache modifications
  *
  * This structure represents a cache of digests extracted from a digest list.
  */
@@ -79,6 +96,8 @@ struct digest_cache {
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
+	struct list_head verif_data;
+	struct mutex mutex;
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
index 6e9ed1b5040a..f3475b36e566 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -49,6 +49,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	atomic_set(&digest_cache->ref_count, 1);
 	digest_cache->flags = 0UL;
 	INIT_LIST_HEAD(&digest_cache->htables);
+	INIT_LIST_HEAD(&digest_cache->verif_data);
+	mutex_init(&digest_cache->mutex);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -65,6 +67,8 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
+	digest_cache_verif_free(digest_cache);
+	mutex_destroy(&digest_cache->mutex);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
@@ -336,6 +340,7 @@ EXPORT_SYMBOL_GPL(digest_cache_put);
 
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
index 000000000000..04023240d3b4
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
+	mutex_lock(&digest_cache->mutex);
+	list_add_tail_rcu(&new_verif->list, &digest_cache->verif_data);
+	mutex_unlock(&digest_cache->mutex);
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


