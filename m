Return-Path: <linux-kselftest+bounces-22260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABF9D241B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F3DB24F85
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB991C4622;
	Tue, 19 Nov 2024 10:54:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43D53363;
	Tue, 19 Nov 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013685; cv=none; b=KtgNfimn4pGn99/bQ/txKxgzUwZCYo/EcNg+i/YXdtSoEt+sr+njEdN7ZfdPJgroiKmqcEJVSt7Vpwsr6l8q4RUe1fWpIV8cq7wA661+f9alYSz+b42MfxCXPPV2Ii7RcXCW4MUr3ch7RbsVuhsKZ2CNf0pl0DHYbNI/eJ6OPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013685; c=relaxed/simple;
	bh=CaHmjj/FuJZ+1+zKR86YqAOLydCWLwia8MEyKW2O6Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHkbXQe/dLuepXSMqLhZ4KWRajWWAfznCB6zWUXEBj/NXrXaNMLobNqqcfJPPS425TOA4u81y3ZhUbdw/QjzNXI6xYe40NIqtMLg7OkpYhXOr4lMQy2oUjN0+kZdgBeHGzIL+dZOO663GpjWoifjoZJ73KUwT6xdue/A1bewm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt17J6k5Yz9v7NV;
	Tue, 19 Nov 2024 18:33:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AB837140AC0;
	Tue, 19 Nov 2024 18:54:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHsyNDbjxnj1znAQ--.1193S3;
	Tue, 19 Nov 2024 11:54:29 +0100 (CET)
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
Subject: [PATCH v6 11/15] digest_cache: Add support for directories
Date: Tue, 19 Nov 2024 11:49:18 +0100
Message-ID: <20241119104922.2772571-12-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHsyNDbjxnj1znAQ--.1193S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uFyDuFyfJw43GFWrJF1UZFb_yoW8WFy8Jo
	ZayF4DAw18WFyUZr4DCF17A3WUW3yFq34xAr4kXFWDX3WxZFWUJasrCF1UJFy5Xr18JFZ7
	Awn7Jw4DJFy8tr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r
	4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0t5r7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEggAAsQ

From: Roberto Sassu <roberto.sassu@huawei.com>

In the environments where xattrs are not available (e.g. in the initial ram
disk), the Integrity Digest Cache cannot precisely determine which digest
list in a directory contains the desired reference digest. However,
although slower, it would be desirable to search the digest in all digest
lists of that directory.

This done in three steps. First, a directory digest cache is created like
the other digest caches. The only differences are that this digest cache
has the IS_DIR bit set, to distinguish it from those created from regular
files and, consequently, that it stores a list of directory entries file
names instead of hash tables for digests.

Second, the directory digest cache is populated with current directory
entries, by calling digest_cache_dir_add_entries().

Finally, digest_cache_dir_lookup_digest() is called with the directory
digest cache passed as argument, to iteratively search on each digest cache
for each directory entry.

The function first calls digest_cache_dir_create() to create/obtain the
current directory digest cache for the directory. If the latter returns
a different one than the one passed, digest_cache_dir_lookup_digest()
returns ERR_PTR(-EAGAIN) to let the caller of digest_cache_lookup() know
that the directory digest cache changed, and make the caller perform
another digest_cache_get() to get a fresh directory digest cache.

If the passed and the current directory digest caches match,
digest_cache_dir_lookup_digest() starts the lookup and iteratively searches
the passed digest in each directory entry. If there is no digest cache
associated to the current directory entry, digest_cache_dir_lookup_digest()
creates/obtains one by calling digest_cache_create(). It also keeps a
digest cache reference, so that it is available for next searches. The
iteration stops when the digest is found.

Finally, digest_cache_dir_free() releases the digest cache references
stored in the list of directory entries, and frees the list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/dir.c      | 263 +++++++++++++++++++++
 security/integrity/digest_cache/htable.c   |   7 +-
 security/integrity/digest_cache/internal.h |  44 ++++
 security/integrity/digest_cache/main.c     |  13 +
 5 files changed, 327 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/digest_cache/dir.c

diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 2a0f2500e227..d07ac2483504 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -6,6 +6,6 @@ obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 obj-$(CONFIG_DIGEST_CACHE_TLV_PARSER) += parsers/tlv.o
 
 digest_cache-y := main.o secfs.o htable.o parsers.o populate.o modsig.o \
-		  verif.o
+		  verif.o dir.o
 
 CFLAGS_parsers.o += -DPARSERS_DIR=\"$(MODLIB)/kernel/security/integrity/digest_cache/parsers\"
diff --git a/security/integrity/digest_cache/dir.c b/security/integrity/digest_cache/dir.c
new file mode 100644
index 000000000000..8f9e550c365f
--- /dev/null
+++ b/security/integrity/digest_cache/dir.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Manage digest caches from directories.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/init_task.h>
+#include <linux/namei.h>
+
+#include "internal.h"
+
+/**
+ * digest_cache_dir_iter - Digest cache directory iterator
+ * @__ctx: iterate_dir() context
+ * @name: Name of file in the accessed directory
+ * @namelen: String length of @name
+ * @offset: Current position in the directory stream (see man readdir)
+ * @ino: Inode number
+ * @d_type: File type
+ *
+ * This function stores the names of the files in the containing directory in
+ * a linked list. If they are in the format
+ * <seq num>-<digest list format>-<digest list name>, this function orders them
+ * by seq num, so that digest lists are processed in the desired order.
+ * Otherwise, if <seq num>- is not included, it adds the name at the end of
+ * the list.
+ *
+ * Return: True to continue processing, false to stop.
+ */
+static bool digest_cache_dir_iter(struct dir_context *__ctx, const char *name,
+				  int namelen, loff_t offset, u64 ino,
+				  unsigned int d_type)
+{
+	struct readdir_callback *ctx = container_of(__ctx, typeof(*ctx), ctx);
+	struct dir_entry *new_entry, *p;
+	unsigned int seq_num;
+	char *separator;
+	int ret;
+
+	if (!strcmp(name, ".") || !strcmp(name, ".."))
+		return true;
+
+	if (d_type != DT_REG)
+		return true;
+
+	new_entry = kmalloc(sizeof(*new_entry) + namelen + 1, GFP_KERNEL);
+	if (!new_entry)
+		return false;
+
+	memcpy(new_entry->name, name, namelen);
+	new_entry->name[namelen] = '\0';
+	new_entry->seq_num = UINT_MAX;
+	new_entry->digest_cache = NULL;
+	mutex_init(&new_entry->digest_cache_mutex);
+
+	if (new_entry->name[0] < '0' || new_entry->name[0] > '9')
+		goto out;
+
+	separator = strchr(new_entry->name, '-');
+	if (!separator)
+		goto out;
+
+	*separator = '\0';
+	ret = kstrtouint(new_entry->name, 10, &seq_num);
+	*separator = '-';
+	if (ret < 0)
+		goto out;
+
+	new_entry->seq_num = seq_num;
+
+	list_for_each_entry(p, ctx->head, list) {
+		if (seq_num <= p->seq_num) {
+			list_add(&new_entry->list, p->list.prev);
+			pr_debug("Added %s before %s in dir list\n",
+				 new_entry->name, p->name);
+			return true;
+		}
+	}
+out:
+	list_add_tail(&new_entry->list, ctx->head);
+	pr_debug("Added %s to tail of dir list\n", new_entry->name);
+	return true;
+}
+
+/**
+ * digest_cache_dir_add_entries - Add dir entries to a dir digest cache
+ * @digest_cache: Dir digest cache
+ * @digest_list_path: Path structure of the digest list directory
+ *
+ * This function iterates over the entries of a directory, and creates a linked
+ * list of file names from that directory.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_dir_add_entries(struct digest_cache *digest_cache,
+				 struct path *digest_list_path)
+{
+	struct file *dir_file;
+	struct readdir_callback buf = {
+		.ctx.actor = digest_cache_dir_iter,
+		.ctx.pos = 0,
+		.head = &digest_cache->dir_entries,
+	};
+	int ret;
+
+	dir_file = kernel_file_open(digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(dir_file)) {
+		pr_debug("Cannot access %s, ret: %ld\n", digest_cache->path_str,
+			 PTR_ERR(dir_file));
+		return PTR_ERR(dir_file);
+	}
+
+	ret = iterate_dir(dir_file, &buf.ctx);
+	if (ret < 0)
+		pr_debug("Failed to iterate directory %s\n",
+			 digest_cache->path_str);
+
+	fput(dir_file);
+	return ret;
+}
+
+/**
+ * digest_cache_dir_create - Create and initialize a directory digest cache
+ * @dentry: Dentry of the file whose digest is looked up
+ * @dir_path: Path structure of the digest list directory (updated)
+ * @path_str: Path string of the digest list directory
+ *
+ * This function creates and initializes (or obtains if it already exists) a
+ * directory digest cache. It updates the path that digest cache was
+ * created/obtained from, so that the caller can use it to perform lookup
+ * operations.
+ *
+ * Return: A directory digest cache on success, NULL otherwise.
+ */
+static struct digest_cache *digest_cache_dir_create(struct dentry *dentry,
+						    struct path *dir_path,
+						    char *path_str)
+{
+	struct digest_cache *digest_cache;
+	struct path _dir_path;
+	int ret;
+
+	ret = kern_path(path_str, 0, &_dir_path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", path_str);
+		return NULL;
+	}
+
+	digest_cache = digest_cache_create(dentry, &_dir_path, dir_path,
+					   path_str, "");
+	if (digest_cache)
+		digest_cache = digest_cache_init(dentry, dir_path,
+						 digest_cache);
+
+	path_put(&_dir_path);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_dir_lookup_digest - Lookup a digest
+ * @dentry: Dentry of the file whose digest is looked up
+ * @digest_cache: Dir digest cache
+ * @digest: Digest to search
+ * @algo: Algorithm of the digest to search
+ *
+ * This function iterates over the linked list created by
+ * digest_cache_dir_add_entries() and looks up the digest in the digest cache
+ * of each entry.
+ *
+ * Return: A digest cache reference if the digest is found, NULL if not, an
+ *         error pointer if dir digest cache changed since last get.
+ */
+struct digest_cache *
+digest_cache_dir_lookup_digest(struct dentry *dentry,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo)
+{
+	struct dir_entry *dir_entry;
+	struct digest_cache *dir_cache, *cache, *found = NULL;
+	struct path dir_path = { .dentry = NULL, .mnt = NULL };
+	struct path digest_list_path;
+	int ret;
+
+	/* Try to reacquire the dir digest cache, and check if changed. */
+	dir_cache = digest_cache_dir_create(dentry, &dir_path,
+					    digest_cache->path_str);
+	if (dir_cache != digest_cache) {
+		if (dir_cache)
+			found = ERR_PTR(-EAGAIN);
+
+		goto out;
+	}
+
+	list_for_each_entry(dir_entry, &dir_cache->dir_entries, list) {
+		mutex_lock(&dir_entry->digest_cache_mutex);
+		if (!dir_entry->digest_cache) {
+			digest_list_path.dentry = NULL;
+			digest_list_path.mnt = NULL;
+
+			cache = digest_cache_create(dentry, &dir_path,
+						    &digest_list_path,
+						    dir_cache->path_str,
+						    dir_entry->name);
+			if (cache)
+				cache = digest_cache_init(dentry,
+							  &digest_list_path,
+							  cache);
+
+			if (digest_list_path.dentry)
+				path_put(&digest_list_path);
+
+			/* Ignore digest caches that cannot be instantiated. */
+			if (!cache) {
+				mutex_unlock(&dir_entry->digest_cache_mutex);
+				continue;
+			}
+
+			/* Consume extra ref. from digest_cache_create(). */
+			dir_entry->digest_cache = cache;
+		}
+		mutex_unlock(&dir_entry->digest_cache_mutex);
+
+		ret = digest_cache_htable_lookup(dentry,
+						 dir_entry->digest_cache,
+						 digest, algo);
+		if (!ret) {
+			found = digest_cache_ref(dir_entry->digest_cache);
+			break;
+		}
+	}
+out:
+	if (dir_cache)
+		digest_cache_put(dir_cache);
+	if (dir_path.dentry)
+		path_put(&dir_path);
+
+	return found;
+}
+
+/**
+ * digest_cache_dir_free - Free the stored file list and put digest caches
+ * @digest_cache: Dir digest cache
+ *
+ * This function frees the file list created by digest_cache_dir_add_entries(),
+ * and puts the digest cache of each directory entry, if a reference exists.
+ */
+void digest_cache_dir_free(struct digest_cache *digest_cache)
+{
+	struct dir_entry *p, *q;
+
+	list_for_each_entry_safe(p, q, &digest_cache->dir_entries, list) {
+		if (p->digest_cache)
+			digest_cache_put(p->digest_cache);
+
+		list_del(&p->list);
+		mutex_destroy(&p->digest_cache_mutex);
+		kfree(p);
+	}
+}
diff --git a/security/integrity/digest_cache/htable.c b/security/integrity/digest_cache/htable.c
index 8aa6d50a0cb5..a01e24d7f198 100644
--- a/security/integrity/digest_cache/htable.c
+++ b/security/integrity/digest_cache/htable.c
@@ -202,7 +202,8 @@ EXPORT_SYMBOL_GPL(digest_cache_htable_lookup);
  * This function calls digest_cache_htable_lookup() to search a digest in the
  * passed digest cache, obtained with digest_cache_get().
  *
- * Return: A digest cache reference the digest is found, NULL if not.
+ * Return: A digest cache reference if the digest is found, NULL if not, an
+ *         error pointer if dir digest cache changed since last get.
  */
 struct digest_cache *digest_cache_lookup(struct dentry *dentry,
 					 struct digest_cache *digest_cache,
@@ -210,6 +211,10 @@ struct digest_cache *digest_cache_lookup(struct dentry *dentry,
 {
 	int ret;
 
+	if (test_bit(IS_DIR, &digest_cache->flags))
+		return digest_cache_dir_lookup_digest(dentry, digest_cache,
+						      digest, algo);
+
 	ret = digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
 	if (ret < 0)
 		return NULL;
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index c64e91b75a47..f849afe5e47b 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -17,6 +17,39 @@
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
 #define INIT_STARTED		1	/* Digest cache init started. */
 #define INVALID			2	/* Digest cache marked as invalid. */
+#define IS_DIR			3	/* Digest cache created from dir. */
+
+/**
+ * struct readdir_callback - Structure to store information for dir iteration
+ * @ctx: Context structure
+ * @head: Head of linked list of directory entries
+ *
+ * This structure stores information to be passed from the iterate_dir() caller
+ * to the directory iterator.
+ */
+struct readdir_callback {
+	struct dir_context ctx;
+	struct list_head *head;
+};
+
+/**
+ * struct dir_entry - Directory entry
+ * @list: Linked list of directory entries
+ * @digest_cache: Digest cache associated to the directory entry
+ * @digest_cache_mutex: Protects @digest_cache
+ * @seq_num: Sequence number of the directory entry from file name
+ * @name: File name of the directory entry
+ *
+ * This structure represents a directory entry with a digest cache created
+ * from that entry.
+ */
+struct dir_entry {
+	struct list_head list;
+	struct digest_cache *digest_cache;
+	struct mutex digest_cache_mutex;
+	unsigned int seq_num;
+	char name[];
+};
 
 /**
  * struct digest_cache_verif
@@ -84,6 +117,7 @@ struct htable {
 /**
  * struct digest_cache - Digest cache
  * @htables: Hash tables (one per algorithm)
+ * @dir_entries: List of files in a directory and the digest cache
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
@@ -94,6 +128,7 @@ struct htable {
  */
 struct digest_cache {
 	struct list_head htables;
+	struct list_head dir_entries;
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
@@ -213,4 +248,13 @@ size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 /* verif.c */
 void digest_cache_verif_free(struct digest_cache *digest_cache);
 
+/* dir.c */
+int digest_cache_dir_add_entries(struct digest_cache *digest_cache,
+				 struct path *digest_cache_path);
+struct digest_cache *
+digest_cache_dir_lookup_digest(struct dentry *dentry,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo);
+void digest_cache_dir_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 11a0445592f0..9df819c323c7 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -54,6 +54,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	INIT_LIST_HEAD(&digest_cache->htables);
 	INIT_LIST_HEAD(&digest_cache->verif_data);
 	spin_lock_init(&digest_cache->verif_data_lock);
+	INIT_LIST_HEAD(&digest_cache->dir_entries);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
 		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
@@ -71,6 +72,7 @@ static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
 	digest_cache_verif_free(digest_cache);
+	digest_cache_dir_free(digest_cache);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
 	kfree(digest_cache->path_str);
@@ -292,6 +294,17 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 			/* Prevent usage of partially-populated digest cache. */
 			set_bit(INVALID, &digest_cache->flags);
 		}
+	} else if (S_ISDIR(inode->i_mode)) {
+		set_bit(IS_DIR, &digest_cache->flags);
+
+		ret = digest_cache_dir_add_entries(digest_cache,
+						   digest_list_path);
+		if (ret < 0) {
+			pr_debug("Failed to add dir entries to dir digest cache, ret: %d (keep digest cache)\n",
+				 ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &digest_cache->flags);
+		}
 	}
 
 	/* Notify initialization complete. */
-- 
2.47.0.118.gfd3785337b


