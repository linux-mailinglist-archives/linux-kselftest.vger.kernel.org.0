Return-Path: <linux-kselftest+bounces-22252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD409D23DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6958B2567F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E51C1F2F;
	Tue, 19 Nov 2024 10:51:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224B13AD03;
	Tue, 19 Nov 2024 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013471; cv=none; b=FV3fOzSuiFYALG+yr4C0+FocDzlAuwZHZmtrJzXQ+3aDNklgFTfaqe/LDcTBwwmN8+xBRsf1o2i4FZS2mU7/wS/EaVLhqnxenHluwPxE1u24XAtPkcu6ggc6MbHwqmRFMJITlF9pIEuXCfzr9+28AqfgDz9eZ5CVTXOg0Bp4Gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013471; c=relaxed/simple;
	bh=VnwQ4c0mgyqCWF4Y4IToWHfqT22TOeVAZq6ztG2gAeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7V/eXO05AbkxcdgcngEvMvfARv8SVW6b5slyW7FSVgaaii31Es8P6MVG+h+FSKchU41JThZfhXQayKYLigd8vWwkYlPiztSYI8S5rpMotzcXdBroh+Pjn85wKULCXjizmxzsnsXYQsrS/rEmz+GdXQEUh+T6CLX2u70Jq5avQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt0vt4tHLz9v7JM;
	Tue, 19 Nov 2024 18:23:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 136A0140B08;
	Tue, 19 Nov 2024 18:50:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S5;
	Tue, 19 Nov 2024 11:50:58 +0100 (CET)
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
Subject: [PATCH v6 03/15] integrity: Introduce the Integrity Digest Cache
Date: Tue, 19 Nov 2024 11:49:10 +0100
Message-ID: <20241119104922.2772571-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S5
X-Coremail-Antispam: 1UD129KBjvAXoWfuw4kXFy5CF4fuw4xuryfWFg_yoW5XF4xAo
	Zaya17Jw18WFy3Zr4kCF1xAay7WwsYq3yxAr4kXrWUZ3WIvFyUJasrG3WDJFy5Jr18Jr93
	A34kXw45JFWUtr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r
	4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0QeOJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEfwAFst

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the Integrity Digest Cache, to collect digests from various
sources (called digest lists), and to store them in kernel memory, in a set
of hash tables forming a digest cache. Extracted digests can be used as
reference values for integrity verification of file data or metadata.

The Integrity Digest Cache aims to be used by IMA and (later) by EVM to
verify accessed files. It is not an LSM on its own, and requires IMA (when
the feature is enabled) to reserve additional space in the inode and file
descriptor security blobs and to call digest_cache_do_init() for
registering additional LSM hooks.

The additional space in the inode security blob is used for storing the
digest_cache_security structure, which contains two digest cache pointers:
dig_owner, set if the digest cache was created from that inode; dig_user,
set if the digest cache was used for verifying that inode. An inode
security blob has both pointers set if digests are extracted from that
inode, and the inode itself is verified with another inode. Check and
assignment of those pointers are protected respectively with
dig_owner_mutex and dig_user_mutex.

The additional space in the file descriptor security blob is used to store
the digest cache pointer and to annotate the digest cache with the
integrity information the digest cache is created from. It also makes it
possible to identify from IMA hooks the file descriptors opened by the
Integrity Digest Cache and to properly nest the mutex, by calling the new
function digest_cache_opened_fd().

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
 include/linux/digest_cache.h               |  37 ++
 include/uapi/linux/xattr.h                 |   3 +
 security/integrity/Kconfig                 |   1 +
 security/integrity/Makefile                |   1 +
 security/integrity/digest_cache/Kconfig    |  19 +
 security/integrity/digest_cache/Makefile   |   7 +
 security/integrity/digest_cache/internal.h | 116 ++++++
 security/integrity/digest_cache/main.c     | 406 +++++++++++++++++++++
 security/integrity/ima/ima.h               |   1 +
 security/integrity/ima/ima_main.c          |  10 +-
 10 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/digest_cache.h
 create mode 100644 security/integrity/digest_cache/Kconfig
 create mode 100644 security/integrity/digest_cache/Makefile
 create mode 100644 security/integrity/digest_cache/internal.h
 create mode 100644 security/integrity/digest_cache/main.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
new file mode 100644
index 000000000000..1f88b61fb7cd
--- /dev/null
+++ b/include/linux/digest_cache.h
@@ -0,0 +1,37 @@
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
+/* Client API */
+struct digest_cache *digest_cache_get(struct file *file);
+void digest_cache_put(struct digest_cache *digest_cache);
+bool digest_cache_opened_fd(struct file *file);
+
+#else
+static inline struct digest_cache *digest_cache_get(struct file *file)
+{
+	return NULL;
+}
+
+static inline void digest_cache_put(struct digest_cache *digest_cache)
+{
+}
+
+static inline bool digest_cache_opened_fd(struct file *file)
+{
+	return false;
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
index 000000000000..81f9d4ae749f
--- /dev/null
+++ b/security/integrity/digest_cache/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+config INTEGRITY_DIGEST_CACHE
+	bool "Integrity Digest Cache"
+	default n
+	help
+	  This option enables a cache of reference digests (e.g. of file
+	  data or metadata) to be used by IMA and (later) by EVM, to verify
+	  accessed files.
+
+	  Digests can be extracted from supported data formats (e.g. a
+	  TLV-based format). Support for more formats can be added through
+	  third-party kernel modules.
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
index 000000000000..fa76ab2672ea
--- /dev/null
+++ b/security/integrity/digest_cache/internal.h
@@ -0,0 +1,116 @@
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
+extern loff_t file_sec_offset;
+extern char *default_path_str;
+
+static inline struct digest_cache_security *
+digest_cache_get_security_from_blob(void *inode_security)
+{
+	return inode_security + inode_sec_offset;
+}
+
+static inline struct digest_cache_security *
+digest_cache_get_security(const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return digest_cache_get_security_from_blob(inode->i_security);
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
+/* main.c */
+struct digest_cache *digest_cache_create(struct dentry *dentry,
+					 struct path *default_path,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename);
+int __init digest_cache_do_init(const struct lsm_id *lsm_id,
+				loff_t inode_offset, loff_t file_offset);
+
+#endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
new file mode 100644
index 000000000000..c644cdc2ebd7
--- /dev/null
+++ b/security/integrity/digest_cache/main.c
@@ -0,0 +1,406 @@
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
+loff_t file_sec_offset;
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
+ * @default_path: Path structure of the default path
+ * @digest_list_path: Path structure of the digest list
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ *
+ * This function first locates, from the passed path and filename, the digest
+ * list inode from which the digest cache will be created or retrieved (if it
+ * already exists).
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
+					 struct path *default_path,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename)
+{
+	struct digest_cache *digest_cache = NULL;
+	struct digest_cache_security *dig_sec;
+	struct inode *inode = d_backing_inode(default_path->dentry);
+	int ret;
+
+	if (S_ISDIR(inode->i_mode) && filename[0]) {
+		ret = vfs_path_lookup(default_path->dentry, default_path->mnt,
+				      filename, LOOKUP_FOLLOW,
+				      digest_list_path);
+		if (ret < 0) {
+			pr_debug("Cannot find digest list %s/%s\n", path_str,
+				 filename);
+			return NULL;
+		}
+
+		inode = d_backing_inode(digest_list_path->dentry);
+
+		/* No support for nested directories. */
+		if (!S_ISREG(inode->i_mode)) {
+			pr_debug("%s is not a regular file (no support for nested directories)\n",
+				 digest_list_path->dentry->d_name.name);
+			return NULL;
+		}
+	} else {
+		digest_list_path->dentry = default_path->dentry;
+		digest_list_path->mnt = default_path->mnt;
+		path_get(digest_list_path);
+	}
+
+	/*
+	 * Cannot request a digest cache for the same inode the digest cache
+	 * is populated from.
+	 */
+	if (d_backing_inode(dentry) == inode) {
+		pr_debug("Cannot request a digest cache for %s and create the digest cache from it\n",
+			 dentry->d_name.name);
+		return NULL;
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
+		goto out;
+	}
+
+	/* Ref. count is already 1 for this reference. */
+	dig_sec->dig_owner = digest_cache_alloc_init(path_str, filename);
+	if (!dig_sec->dig_owner)
+		goto out;
+
+	/* Increment ref. count for reference returned to the caller. */
+	digest_cache = digest_cache_ref(dig_sec->dig_owner);
+out:
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_new - Retrieve digest list file name and request digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_list_path: Path structure of the digest list (updated)
+ *
+ * This function locates the default path. If it is a file, it directly creates
+ * a digest cache from it. Otherwise, it reads the digest list file name from
+ * the security.digest_list xattr and requests the creation of a digest cache
+ * with that file name. If security.digest_list is empty or not found, this
+ * function requests the creation of a digest cache on the parent directory.
+ *
+ * This function passes to the caller the path of the digest list from which
+ * the digest cache was created (file or parent directory), so that
+ * digest_cache_init() can reuse the same path, and to prevent the inode from
+ * being evicted between creation and initialization.
+ *
+ * Return: A digest cache on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_new(struct dentry *dentry,
+					     struct path *digest_list_path)
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
+		if (ret && ret != -ENODATA && ret != -EOPNOTSUPP) {
+			pr_debug("Cannot get %s xattr from file %s, ret: %d\n",
+				 XATTR_NAME_DIGEST_LIST, dentry->d_name.name,
+				 ret);
+			goto out;
+		}
+
+		pr_debug("Digest list file name not found for file %s, using %s\n",
+			 dentry->d_name.name, default_path_str);
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
+					   digest_list_path, default_path_str,
+					   filename);
+out:
+	path_put(&default_path);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_get - Get a digest cache for a given inode
+ * @file: File descriptor of the inode for which the digest cache will be used
+ *
+ * This function tries to find a digest cache from the inode security blob from
+ * the passed file descriptor (dig_user field). If a digest cache was not found,
+ * it calls digest_cache_new() to create a new one. In both cases, it increments
+ * the digest cache reference count before returning the reference to the
+ * caller.
+ *
+ * The caller is responsible to call digest_cache_put() to release the digest
+ * cache reference returned.
+ *
+ * This function locks dig_user_mutex to protect against concurrent requests
+ * to obtain a digest cache for the same inode.
+ *
+ * Return: A digest cache on success, NULL otherwise.
+ */
+struct digest_cache *digest_cache_get(struct file *file)
+{
+	struct digest_cache_security *dig_sec;
+	struct digest_cache *digest_cache = NULL;
+	struct inode *inode = file_inode(file);
+	struct dentry *dentry = file_dentry(file);
+	struct path digest_list_path = { .dentry = NULL, .mnt = NULL };
+
+	if (!digest_cache_enabled)
+		return NULL;
+
+	/* Do not allow recursion for now. */
+	if (digest_cache_opened_fd(file))
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
+		dig_sec->dig_user = digest_cache_new(dentry, &digest_list_path);
+
+	if (dig_sec->dig_user)
+		/* Increment ref. count for reference returned to the caller. */
+		digest_cache = digest_cache_ref(dig_sec->dig_user);
+
+	mutex_unlock(&dig_sec->dig_user_mutex);
+
+	if (digest_list_path.dentry)
+		path_put(&digest_list_path);
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
+ * digest_cache_opened_fd - Determine if fd is opened by Digest Cache
+ * @file: File descriptor
+ *
+ * Determine whether or not the file descriptor was internally opened by the
+ * Integrity Digest Cache.
+ *
+ * Return: True if it is opened by us, false otherwise.
+ */
+bool digest_cache_opened_fd(struct file *file)
+{
+	struct digest_cache *digest_cache = digest_cache_from_file_sec(file);
+
+	return !!digest_cache;
+}
+EXPORT_SYMBOL_GPL(digest_cache_opened_fd);
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
+ * digest_cache_inode_free_security_rcu - Release the digest cache references
+ * @inode_security: Inode security blob
+ *
+ * Since the inode is being evicted, this function releases the non-needed
+ * references to the digest caches stored in the digest_cache_security
+ * structure.
+ */
+static void digest_cache_inode_free_security_rcu(void *inode_security)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security_from_blob(inode_security);
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
+	LSM_HOOK_INIT(inode_free_security_rcu,
+		      digest_cache_inode_free_security_rcu),
+};
+
+/**
+ * digest_cache_do_init - Initialize the Integrity Digest Cache
+ * @lsm_id: ID of LSM registering the LSM hooks
+ * @inode_offset: Offset in the inode security blob
+ * @file_offset: Offset in the file security blob
+ *
+ * Initialize the Integrity Digest Cache, by instantiating a cache for the
+ * digest_cache structure and by registering the LSM hooks as part of the
+ * calling LSM.
+ */
+int __init digest_cache_do_init(const struct lsm_id *lsm_id,
+				loff_t inode_offset, loff_t file_offset)
+{
+	inode_sec_offset = inode_offset;
+	file_sec_offset = file_offset;
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
index 3c323ca213d4..2eaa7f224da4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -23,6 +23,7 @@
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
+#include "../digest_cache/internal.h"
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..f6cc0c7a6244 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1206,11 +1206,19 @@ static int __init init_ima_lsm(void)
 	ima_iintcache_init();
 	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
 	init_ima_appraise_lsm(&ima_lsmid);
+	if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE))
+		digest_cache_do_init(&ima_lsmid, ima_blob_sizes.lbs_inode +
+				     sizeof(struct ima_iint_cache *),
+				     ima_blob_sizes.lbs_file);
 	return 0;
 }
 
 struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct ima_iint_cache *),
+	.lbs_inode = sizeof(struct ima_iint_cache *)
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	 + sizeof(struct digest_cache_security),
+	.lbs_file = sizeof(struct digest_cache *),
+#endif
 };
 
 DEFINE_LSM(ima) = {
-- 
2.47.0.118.gfd3785337b


