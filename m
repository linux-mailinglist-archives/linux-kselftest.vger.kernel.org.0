Return-Path: <linux-kselftest+bounces-17271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A58496DDFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04457284732
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC319B595;
	Thu,  5 Sep 2024 15:23:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143421DFF5;
	Thu,  5 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549792; cv=none; b=drymP6lZ3yj0A2+3rF/JsLhyA4wdaJ29oBgQMA+h/ZWADdF5GDI9t69ZB17QBqHMtXH0kZBQdNjUDnaUOiq49TL2wof6UaMxisCEVtLyzsG2ablRSL6pGI01K+BhNE4vC9Wy7X0H/CotWfaCmj2YaSO45z6be+PyRZcz/n3nAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549792; c=relaxed/simple;
	bh=3NYqRiZLPEHMvQmEnE8rSTpccuapjMI+iHNa77P0DAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWDs0dGYD2/XGG5RynTqc7yWZgjDTJ4Bo27sHPdoPUUU8F2KR/IGK2ct7LVwOvprPzyVb7x/KgwKhc28SQqXWOrMDf+aaACQ18q9SMMZ4tPQhXUHEqe0euA44GRPpHrGSSVJuUwhf+Y7ldcqn9I9G0nrF/iUd1V23vLfLwfbrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02K25TzGz9v7NT;
	Thu,  5 Sep 2024 22:47:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 237931408F9;
	Thu,  5 Sep 2024 23:07:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S4;
	Thu, 05 Sep 2024 16:07:00 +0100 (CET)
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
Subject: [PATCH v5 02/14] integrity: Introduce the Integrity Digest Cache
Date: Thu,  5 Sep 2024 17:05:31 +0200
Message-Id: <20240905150543.3766895-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S4
X-Coremail-Antispam: 1UD129KBjvAXoWfuw4kXF4xXw15Ww13uFykKrg_yoW5Jr18Go
	Zaya17Jw18WFy3uFs5CF17Aay7WwsYq3yxAr4kXrWUZ3WIvFyUJasrG3WDJFy5Jr18Jr93
	A34kX3yUJFWUtr93n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUVBMNUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK1wACsU

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the Integrity Digest Cache, to collect digests from various
sources (called digest lists), and to store them in kernel memory, in a set
of hash tables forming a digest cache. Extracted digests can be used as
reference values for integrity verification of file data or metadata.

The Integrity Digest Cache aims to be used by IMA and (later) by EVM to
verify accessed files. It is not an LSM on its own, and requires IMA (when
the feature is enabled) to reserve additional space in the inode security
blob and to call digest_cache_do_init() for registering additional LSM
hooks.

The additional space in the inode security blob is used for storing the
digest_cache_security structure, which contains two digest cache pointers:
dig_owner, set if the digest cache was created from that inode; dig_user,
set if the digest cache was used for verifying that inode. An inode
security blob has both pointers set if digests are extracted from that
inode, and the inode itself is verified with another inode. Check and
assignment of those pointers are protected respectively with
dig_owner_mutex and dig_user_mutex.

The only way for a user of the Integrity Digest Cache to obtain a digest
cache is to call digest_cache_get(). The latter first checks if dig_user in
the security blob of the passed inode is not NULL and, in that case,
immediately returns the pointer after incrementing the digest cache
reference count.

If dig_user is NULL, digest_cache_get() calls digest_cache_new(), which
determines from which path the digest cache should be retrieved. If the
default path (defined in the kernel config, or at run-time) is a file,
digest_cache_new() uses it as the final destination. If the default path is
a directory, the function attempts to read the security.digest_list xattr
and, if found, uses its value as last path component. Lastly, if the xattr
is not found or empty, it uses the directory as final destination. A
subsequent patch will allow the holders of the returned digest cache to
iteratively search a digest in each directory entry.

Finally, digest_cache_new() calls digest_cache_create(), which resolves the
inode from the path, and checks if the dig_owner pointer is set. If it is,
again, digest_cache_create() immediately returns after incrementing the
digest cache reference count. If not, it calls digest_cache_alloc_init() to
create a new digest cache. A subsequent patch will initialize it.

A holder of a digest cache can release its reference and consequently
decrement the digest cache reference count by calling digest_cache_put().
If the reference count becomes zero, digest_cache_put() also calls
digest_cache_free() to free the memory.

Inodes having either dig_owner and dig_user set are also holders of digest
caches. Their reference is released when they are evicted from memory, by
implementing the inode_free_security LSM hook. The inode_alloc_security LSM
hook, instead, initializes the digest_cache_security structure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h               |  30 ++
 include/uapi/linux/xattr.h                 |   3 +
 security/integrity/Kconfig                 |   1 +
 security/integrity/Makefile                |   1 +
 security/integrity/digest_cache/Kconfig    |  17 +
 security/integrity/digest_cache/Makefile   |   7 +
 security/integrity/digest_cache/internal.h |  90 +++++
 security/integrity/digest_cache/main.c     | 367 +++++++++++++++++++++
 security/integrity/ima/ima.h               |   1 +
 security/integrity/ima/ima_main.c          |   8 +-
 10 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/digest_cache.h
 create mode 100644 security/integrity/digest_cache/Kconfig
 create mode 100644 security/integrity/digest_cache/Makefile
 create mode 100644 security/integrity/digest_cache/internal.h
 create mode 100644 security/integrity/digest_cache/main.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
new file mode 100644
index 000000000000..86e6c5a0b896
--- /dev/null
+++ b/include/linux/digest_cache.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Public API of the Integrity Digest Cache.
+ */
+
+#ifndef _LINUX_DIGEST_CACHE_H
+#define _LINUX_DIGEST_CACHE_H
+
+#include <linux/fs.h>
+
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+struct digest_cache *digest_cache_get(struct dentry *dentry);
+void digest_cache_put(struct digest_cache *digest_cache);
+
+#else
+static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
+{
+	return NULL;
+}
+
+static inline void digest_cache_put(struct digest_cache *digest_cache)
+{
+}
+
+#endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
+#endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..8a58cf4bce65 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -54,6 +54,9 @@
 #define XATTR_IMA_SUFFIX "ima"
 #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
 
+#define XATTR_DIGEST_LIST_SUFFIX "digest_list"
+#define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_SUFFIX
+
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 3c45f4f3455f..55b1311a48fa 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -132,5 +132,6 @@ config INTEGRITY_AUDIT
 
 source "security/integrity/ima/Kconfig"
 source "security/integrity/evm/Kconfig"
+source "security/integrity/digest_cache/Kconfig"
 
 endif   # if INTEGRITY
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 92b63039c654..0fdabfc6c8ae 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -21,3 +21,4 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
 # The relative order of the 'ima' and 'evm' LSMs depends on the order below.
 obj-$(CONFIG_IMA)			+= ima/
 obj-$(CONFIG_EVM)			+= evm/
+obj-$(CONFIG_INTEGRITY_DIGEST_CACHE)	+= digest_cache/
diff --git a/security/integrity/digest_cache/Kconfig b/security/integrity/digest_cache/Kconfig
new file mode 100644
index 000000000000..5fbec491237b
--- /dev/null
+++ b/security/integrity/digest_cache/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+config INTEGRITY_DIGEST_CACHE
+	bool "Integrity Digest Cache"
+	default n
+	help
+	  This option enables a cache of reference digests (e.g. of file
+	  data or metadata) to be used by IMA and (later) by EVM, to verify
+	  accessed files.
+
+	  Digests can be extracted from RPM headers, or from other sources.
+
+config DIGEST_LIST_DEFAULT_PATH
+	string
+	default "/etc/digest_lists"
+	help
+	  Default path where the Integrity Digest Cache expects to find digest
+	  lists.
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
new file mode 100644
index 000000000000..6a3f7cc6e106
--- /dev/null
+++ b/security/integrity/digest_cache/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for building the Integrity Digest Cache.
+
+obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
+
+digest_cache-y := main.o
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
new file mode 100644
index 000000000000..e8a13afaf2fc
--- /dev/null
+++ b/security/integrity/digest_cache/internal.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Internal header of the Integrity Digest Cache.
+ */
+
+#ifndef _DIGEST_CACHE_INTERNAL_H
+#define _DIGEST_CACHE_INTERNAL_H
+
+#include <linux/lsm_hooks.h>
+#include <linux/digest_cache.h>
+
+/**
+ * struct digest_cache - Digest cache
+ * @ref_count: Number of references to the digest cache
+ * @path_str: Path of the digest list the digest cache was created from
+ * @flags: Control flags
+ *
+ * This structure represents a cache of digests extracted from a digest list.
+ */
+struct digest_cache {
+	atomic_t ref_count;
+	char *path_str;
+	unsigned long flags;
+};
+
+/**
+ * struct digest_cache_security - Digest cache pointers in inode security blob
+ * @dig_owner: Digest cache created from this inode
+ * @dig_owner_mutex: Protects @dig_owner
+ * @dig_user: Digest cache requested for this inode
+ * @dig_user_mutex: Protects @dig_user
+ *
+ * This structure contains references to digest caches, protected by their
+ * respective mutex.
+ */
+struct digest_cache_security {
+	struct digest_cache *dig_owner;
+	struct mutex dig_owner_mutex;
+	struct digest_cache *dig_user;
+	struct mutex dig_user_mutex;
+};
+
+extern loff_t inode_sec_offset;
+extern char *default_path_str;
+
+static inline struct digest_cache_security *
+digest_cache_get_security(const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return inode->i_security + inode_sec_offset;
+}
+
+static inline struct digest_cache *
+digest_cache_ref(struct digest_cache *digest_cache)
+{
+	int ref_count = atomic_inc_return(&digest_cache->ref_count);
+
+	pr_debug("Ref (+) digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str, ref_count);
+	return digest_cache;
+}
+
+static inline struct digest_cache *
+digest_cache_unref(struct digest_cache *digest_cache)
+{
+	bool ref_is_zero;
+
+	/* Unreliable ref. count, but cannot decrement before print (UAF). */
+	pr_debug("Ref (-) digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str,
+		 atomic_read(&digest_cache->ref_count) - 1);
+
+	ref_is_zero = atomic_dec_and_test(&digest_cache->ref_count);
+	return (ref_is_zero) ? digest_cache : NULL;
+}
+
+/* main.c */
+struct digest_cache *digest_cache_create(struct dentry *dentry,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename);
+int __init digest_cache_do_init(const struct lsm_id *lsm_id,
+				loff_t inode_offset);
+
+#endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
new file mode 100644
index 000000000000..60030df04a4d
--- /dev/null
+++ b/security/integrity/digest_cache/main.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the main code of the Integrity Digest Cache.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/namei.h>
+#include <linux/xattr.h>
+
+#include "internal.h"
+
+static int digest_cache_enabled __ro_after_init;
+static struct kmem_cache *digest_cache_cache __read_mostly;
+
+loff_t inode_sec_offset;
+
+char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
+
+/**
+ * digest_cache_alloc_init - Allocate and initialize a new digest cache
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ *
+ * This function allocates and initializes a new digest cache.
+ *
+ * Return: A new digest cache on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_alloc_init(char *path_str,
+						    char *filename)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = kmem_cache_zalloc(digest_cache_cache, GFP_KERNEL);
+	if (!digest_cache)
+		return digest_cache;
+
+	digest_cache->path_str = kasprintf(GFP_KERNEL, "%s%s%s", path_str,
+					   filename[0] ? "/" : "", filename);
+	if (!digest_cache->path_str) {
+		kmem_cache_free(digest_cache_cache, digest_cache);
+		return NULL;
+	}
+
+	atomic_set(&digest_cache->ref_count, 1);
+	digest_cache->flags = 0UL;
+
+	pr_debug("New digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
+
+	return digest_cache;
+}
+
+/**
+ * digest_cache_free - Free all memory occupied by the digest cache
+ * @digest_cache: Digest cache
+ *
+ * This function frees the memory occupied by the digest cache.
+ */
+static void digest_cache_free(struct digest_cache *digest_cache)
+{
+	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
+	kfree(digest_cache->path_str);
+	kmem_cache_free(digest_cache_cache, digest_cache);
+}
+
+/**
+ * digest_cache_create - Create a digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_list_path: Path structure of the digest list
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ *
+ * This function first locates, from the passed path, the digest list inode
+ * from which the digest cache will be created or retrieved (if it already
+ * exists).
+ *
+ * If dig_owner is NULL in the inode security blob, this function creates a
+ * new digest cache with reference count set to 1 (reference returned), sets
+ * it to dig_owner and consequently increments again the digest cache reference
+ * count.
+ *
+ * Otherwise, it simply increments the reference count of the existing
+ * dig_owner, since that reference is returned to the caller.
+ *
+ * This function locks dig_owner_mutex to protect against concurrent requests
+ * to obtain a digest cache from the same inode.
+ *
+ * Return: A digest cache on success, NULL on error.
+ */
+struct digest_cache *digest_cache_create(struct dentry *dentry,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename)
+{
+	struct path file_path;
+	struct digest_cache *digest_cache = NULL;
+	struct digest_cache_security *dig_sec;
+	struct inode *inode = d_backing_inode(digest_list_path->dentry);
+	int ret;
+
+	if (S_ISDIR(inode->i_mode) && filename[0]) {
+		ret = vfs_path_lookup(digest_list_path->dentry,
+				      digest_list_path->mnt, filename,
+				      LOOKUP_FOLLOW, &file_path);
+		if (ret < 0) {
+			pr_debug("Cannot find digest list %s/%s\n", path_str,
+				 filename);
+			return NULL;
+		}
+
+		digest_list_path = &file_path;
+		inode = d_backing_inode(file_path.dentry);
+
+		/* No support for nested directories. */
+		if (!S_ISREG(inode->i_mode)) {
+			pr_debug("%s is not a regular file (no support for nested directories)\n",
+				 file_path.dentry->d_name.name);
+			goto out;
+		}
+	}
+
+	/*
+	 * Cannot request a digest cache for the same inode the digest cache
+	 * is populated from.
+	 */
+	if (d_backing_inode(dentry) == inode) {
+		pr_debug("Cannot request a digest cache for %s and create the digest cache from it\n",
+			 dentry->d_name.name);
+		goto out;
+	}
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		goto out;
+
+	/* Serialize check and assignment of dig_owner. */
+	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner) {
+		/* Increment ref. count for reference returned to the caller. */
+		digest_cache = digest_cache_ref(dig_sec->dig_owner);
+		mutex_unlock(&dig_sec->dig_owner_mutex);
+		goto out;
+	}
+
+	/* Ref. count is already 1 for this reference. */
+	dig_sec->dig_owner = digest_cache_alloc_init(path_str, filename);
+	if (!dig_sec->dig_owner) {
+		mutex_unlock(&dig_sec->dig_owner_mutex);
+		goto out;
+	}
+
+	/* Increment ref. count for reference returned to the caller. */
+	digest_cache = digest_cache_ref(dig_sec->dig_owner);
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+out:
+	if (digest_list_path == &file_path)
+		path_put(&file_path);
+
+	return digest_cache;
+}
+
+/**
+ * digest_cache_new - Retrieve digest list file name and request digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ *
+ * This function locates the default path. If it is a file, it directly creates
+ * a digest cache from it. Otherwise, it reads the digest list file name from
+ * the security.digest_list xattr and requests the creation of a digest cache
+ * with that file name. If security.digest_list is empty or not found, this
+ * function requests the creation of a digest cache on the parent directory.
+ *
+ * Return: A digest cache on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_new(struct dentry *dentry)
+{
+	char filename[NAME_MAX + 1] = { 0 };
+	struct digest_cache *digest_cache = NULL;
+	struct path default_path;
+	int ret;
+
+	ret = kern_path(default_path_str, 0, &default_path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", default_path_str);
+		return NULL;
+	}
+
+	/* The default path is a file, no need to get xattr. */
+	if (S_ISREG(d_backing_inode(default_path.dentry)->i_mode)) {
+		pr_debug("Default path %s is a file, not reading %s xattr\n",
+			 default_path_str, XATTR_NAME_DIGEST_LIST);
+		goto create;
+	} else if (!S_ISDIR(d_backing_inode(default_path.dentry)->i_mode)) {
+		pr_debug("Default path %s must be either a file or a directory\n",
+			 default_path_str);
+		goto out;
+	}
+
+	ret = vfs_getxattr(&nop_mnt_idmap, dentry, XATTR_NAME_DIGEST_LIST,
+			   filename, sizeof(filename) - 1);
+	if (ret <= 0) {
+		pr_debug("Digest list file name not found for file %s, using %s\n",
+			 dentry->d_name.name, default_path_str);
+		if (ret && ret != -ENODATA)
+			goto out;
+
+		goto create;
+	}
+
+	if (strchr(filename, '/')) {
+		pr_debug("%s xattr should contain only a file name, got: %s\n",
+			 XATTR_NAME_DIGEST_LIST, filename);
+		goto out;
+	}
+
+	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
+		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
+		 filename);
+create:
+	digest_cache = digest_cache_create(dentry, &default_path,
+					   default_path_str, filename);
+out:
+	path_put(&default_path);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_get - Get a digest cache for a given inode
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ *
+ * This function tries to find a digest cache from the inode security blob of
+ * the passed dentry (dig_user field). If a digest cache was not found, it calls
+ * digest_cache_new() to create a new one. In both cases, it increments the
+ * digest cache reference count before returning the reference to the caller.
+ *
+ * The caller is responsible to call digest_cache_put() to release the digest
+ * cache reference returned.
+ *
+ * This function locks dig_user_mutex to protect against concurrent requests
+ * to obtain a digest cache for the same inode.
+ *
+ * Return: A digest cache on success, NULL otherwise.
+ */
+struct digest_cache *digest_cache_get(struct dentry *dentry)
+{
+	struct digest_cache_security *dig_sec;
+	struct digest_cache *digest_cache = NULL;
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (!digest_cache_enabled)
+		return NULL;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return NULL;
+
+	/* Serialize accesses to inode for which the digest cache is used. */
+	mutex_lock(&dig_sec->dig_user_mutex);
+	if (!dig_sec->dig_user)
+		/* Consume extra reference from digest_cache_create(). */
+		dig_sec->dig_user = digest_cache_new(dentry);
+
+	if (dig_sec->dig_user)
+		/* Increment ref. count for reference returned to the caller. */
+		digest_cache = digest_cache_ref(dig_sec->dig_user);
+
+	mutex_unlock(&dig_sec->dig_user_mutex);
+
+	return digest_cache;
+}
+EXPORT_SYMBOL_GPL(digest_cache_get);
+
+/**
+ * digest_cache_put - Release a digest cache reference
+ * @digest_cache: Digest cache
+ *
+ * This function decrements the reference count of the digest cache passed as
+ * argument. If the reference count reaches zero, it calls digest_cache_free()
+ * to free the digest cache.
+ */
+void digest_cache_put(struct digest_cache *digest_cache)
+{
+	struct digest_cache *to_free;
+
+	to_free = digest_cache_unref(digest_cache);
+	if (!to_free)
+		return;
+
+	digest_cache_free(to_free);
+}
+EXPORT_SYMBOL_GPL(digest_cache_put);
+
+/**
+ * digest_cache_inode_alloc_security - Initialize inode security blob
+ * @inode: Inode for which the security blob is initialized
+ *
+ * This function initializes the digest_cache_security structure, directly
+ * stored in the inode security blob.
+ *
+ * Return: Zero.
+ */
+static int digest_cache_inode_alloc_security(struct inode *inode)
+{
+	struct digest_cache_security *dig_sec;
+
+	/* The inode security blob is always allocated here. */
+	dig_sec = digest_cache_get_security(inode);
+	mutex_init(&dig_sec->dig_owner_mutex);
+	mutex_init(&dig_sec->dig_user_mutex);
+	return 0;
+}
+
+/**
+ * digest_cache_inode_free_security - Release the digest cache references
+ * @inode: Inode for which the digest cache references are released
+ *
+ * Since the inode is being evicted, this function releases the non-needed
+ * references to the digest caches stored in the digest_cache_security
+ * structure.
+ */
+static void digest_cache_inode_free_security(struct inode *inode)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (!dig_sec)
+		return;
+
+	mutex_destroy(&dig_sec->dig_owner_mutex);
+	mutex_destroy(&dig_sec->dig_user_mutex);
+	if (dig_sec->dig_owner)
+		digest_cache_put(dig_sec->dig_owner);
+	if (dig_sec->dig_user)
+		digest_cache_put(dig_sec->dig_user);
+}
+
+static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
+	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
+};
+
+/**
+ * digest_cache_do_init - Initialize the Integrity Digest Cache
+ * @lsm_id: ID of LSM registering the LSM hooks
+ * @inode_offset: Offset in the inode security blob
+ *
+ * Initialize the Integrity Digest Cache, by instantiating a cache for the
+ * digest_cache structure and by registering the LSM hooks as part of the
+ * calling LSM.
+ */
+int __init digest_cache_do_init(const struct lsm_id *lsm_id,
+				loff_t inode_offset)
+{
+	inode_sec_offset = inode_offset;
+
+	digest_cache_cache = kmem_cache_create("digest_cache_cache",
+					       sizeof(struct digest_cache),
+					       0, SLAB_PANIC, NULL);
+
+	security_add_hooks(digest_cache_hooks, ARRAY_SIZE(digest_cache_hooks),
+			   lsm_id);
+
+	digest_cache_enabled = 1;
+	return 0;
+}
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..ad5c95cf22ac 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -23,6 +23,7 @@
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
+#include "../digest_cache/internal.h"
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..7cbd78ca3be5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1206,11 +1206,17 @@ static int __init init_ima_lsm(void)
 	ima_iintcache_init();
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
 	init_ima_appraise_lsm(&ima_lsmid);
+	if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE))
+		digest_cache_do_init(&ima_lsmid, ima_blob_sizes.lbs_inode +
+				     sizeof(struct ima_iint_cache *));
 	return 0;
 }
 
 struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct ima_iint_cache *),
+	.lbs_inode = sizeof(struct ima_iint_cache *)
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	 + sizeof(struct digest_cache_security)
+#endif
 };
 
 DEFINE_LSM(ima) = {
-- 
2.34.1


