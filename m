Return-Path: <linux-kselftest+bounces-17266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A796DD8B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66CC1C238B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127019EEC8;
	Thu,  5 Sep 2024 15:10:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BD1BF54;
	Thu,  5 Sep 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549007; cv=none; b=NeVBMYrGJoPPx+8cBJPs4R0BFP4mXv3joLfFulvfMrTstMK/dondhl4yKP8BivWNuT2u7wCBeqCsKtHM3osto7m8ALErdAmeW+FTSBLqVBToDWgEnZgrK7B9PLwka3dEXEqQrb/ujWGTkRG4vpcT6uF0GUoMh5bSaZGGSC8Jr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549007; c=relaxed/simple;
	bh=I5uyUPPo6SLqmGokRmFn/umS5mBDW4TOGjWbrTxI9zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiK7SMPeIDjerVYHiuM0XeIyGvXnW2jgQwIAsOqB5OrNM1JF4TpRYPdeQa2S72AZLtTR1AoUGg7sG4BYKU25kAbf8JEW9eR/hfxrlb1xmp8iQWGmhZVP/3xrn0mLiPc9GTgIdsEBDdpxAabRhkDughMZJoWgQx+n/ntWDZUVSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02NL1mv5z9v7NJ;
	Thu,  5 Sep 2024 22:50:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C058D140B3C;
	Thu,  5 Sep 2024 23:09:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHmTCzydlmEFVUAA--.29644S2;
	Thu, 05 Sep 2024 16:09:54 +0100 (CET)
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
Subject: [PATCH v5 10/14] digest_cache: Add support for directories
Date: Thu,  5 Sep 2024 17:05:39 +0200
Message-Id: <20240905150543.3766895-11-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHmTCzydlmEFVUAA--.29644S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uFyDXFW5Wr4xKF1UCF18AFb_yoW8ArW8Ko
	ZayF47Aw18WFyUuF4DCF17A3WUW3yFqw1xAr1kXFWDZ3WxXFWUJasrCF1DJFy5Xr18JFZ7
	Awn7Jw4DJFy8tr97n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyT
	uYvjxUV6pBDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK4gAAsj

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
current directory digest cache for the directory. If this function returns
a different one than the one passed, it means that the directory was
modified between the get and lookup operations, and it uses the new one.

Then, digest_cache_dir_lookup_digest() starts the lookup and iteratively
searches the passed digest in each directory entry. If there is no digest
cache associated to the current directory entry,
digest_cache_dir_lookup_digest() creates/obtains one by calling
digest_cache_create(). It also keeps a digest cache reference, so that it
is available for next searches.

The iteration stops when the digest is found. Since the digest cache
containing the digest has been found, digest_cache_dir_update_dig_user()
is called to replace dig_user, set by digest_cache_get() to the directory
digest cache, with the found one. It can also happen that dig_user is
updated with a directory digest cache, if the digest is not found and there
was a directory modification between get and lookup.

digest_cache_dir_lookup_digest() returns the digest cache reference of the
current directory entry as the uintptr_t type, so that callers
of digest_cache_lookup() don't mistakenly try to call digest_cache_put()
with that reference.

The returned digest cache reference can be converted back to
(struct digest_cache *) and used to retrieve information about the
digest cache containing the digest, which is not known in advance in the
case of directories until the digest search is performed.

Finally, digest_cache_dir_free() releases the digest cache references
stored in the list of directory entries, and frees the list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/dir.c      | 273 +++++++++++++++++++++
 security/integrity/digest_cache/htable.c   |   4 +
 security/integrity/digest_cache/internal.h |  43 ++++
 security/integrity/digest_cache/main.c     |  13 +
 5 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache/dir.c

diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 77dd98a1a07d..aef7f97d1407 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o dir.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/integrity/digest_cache/dir.c b/security/integrity/digest_cache/dir.c
new file mode 100644
index 000000000000..f0a2cb9618ba
--- /dev/null
+++ b/security/integrity/digest_cache/dir.c
@@ -0,0 +1,273 @@
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
+ * a linked list. If they are in the format <seq num>-<format>-<name>, this
+ * function orders them by seq num, so that digest lists are processed in the
+ * desired order. Otherwise, if <seq num>- is not included, it adds the name at
+ * the end of the list.
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
+	dir_file = dentry_open(digest_list_path, O_RDONLY, &init_cred);
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
+ * @digest_list_path: Path structure of the digest list directory (updated)
+ * @path_str: Path string of the digest list directory
+ *
+ * This function creates and initializes (or obtains if it already exists) a
+ * directory digest cache. It updates the path that digest cache was
+ * created/obtained from, so that the caller can use it to perform lookup
+ * operations.
+ *
+ * Return: A directory digest cache on success, NULL otherwise.
+ */
+static struct digest_cache *
+digest_cache_dir_create(struct dentry *dentry, struct path *digest_list_path,
+			char *path_str)
+{
+	struct digest_cache *digest_cache;
+	int ret;
+
+	ret = kern_path(path_str, 0, digest_list_path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", path_str);
+		return NULL;
+	}
+
+	digest_cache = digest_cache_create(dentry, digest_list_path, path_str,
+					   "");
+	if (digest_cache)
+		digest_cache = digest_cache_init(dentry, digest_cache);
+
+	return digest_cache;
+}
+
+/**
+ * digest_cache_dir_update_dig_user - Update dig_user with passed digest cache
+ * @dentry: Dentry of the file whose digest is looked up
+ * @digest_cache: Dir digest cache
+ *
+ * This function updates dig_user of the inode being verified, with the passed
+ * digest cache. The digest cache can differ if the directory inode was evicted
+ * or modified, or if the digest searched was found in a directory entry. In the
+ * latter case, dig_user is replaced with the digest cache of that directory
+ * entry.
+ */
+static void digest_cache_dir_update_dig_user(struct dentry *dentry,
+					     struct digest_cache *digest_cache)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return;
+
+	/* Serialize accesses to inode for which the digest cache is used. */
+	mutex_lock(&dig_sec->dig_user_mutex);
+	if (dig_sec->dig_user != digest_cache) {
+		digest_cache_put(dig_sec->dig_user);
+		dig_sec->dig_user = digest_cache_ref(digest_cache);
+	}
+	mutex_unlock(&dig_sec->dig_user_mutex);
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
+ * Return: A positive uintptr_t value if the digest if found, zero otherwise.
+ */
+uintptr_t digest_cache_dir_lookup_digest(struct dentry *dentry,
+					 struct digest_cache *digest_cache,
+					 u8 *digest, enum hash_algo algo)
+{
+	struct dir_entry *dir_entry;
+	struct digest_cache *dir_cache, *cache, *found = NULL;
+	struct path digest_list_path;
+	int ret;
+
+	/* Try to reacquire the dir digest cache, and use the new if changed. */
+	dir_cache = digest_cache_dir_create(dentry, &digest_list_path,
+					    digest_cache->path_str);
+	if (!dir_cache)
+		return 0UL;
+
+	/* Continue to use the new one. */
+	list_for_each_entry(dir_entry, &dir_cache->dir_entries, list) {
+		mutex_lock(&dir_entry->digest_cache_mutex);
+		if (!dir_entry->digest_cache) {
+			cache = digest_cache_create(dentry, &digest_list_path,
+						    dir_cache->path_str,
+						    dir_entry->name);
+			if (cache)
+				cache = digest_cache_init(dentry, cache);
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
+			found = dir_entry->digest_cache;
+			break;
+		}
+	}
+
+	digest_cache_dir_update_dig_user(dentry, found ?: dir_cache);
+
+	digest_cache_put(dir_cache);
+	path_put(&digest_list_path);
+	return (uintptr_t)found;
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
index 385f81047b0c..1aa884ef18f0 100644
--- a/security/integrity/digest_cache/htable.c
+++ b/security/integrity/digest_cache/htable.c
@@ -209,6 +209,10 @@ uintptr_t digest_cache_lookup(struct dentry *dentry,
 {
 	int ret;
 
+	if (test_bit(IS_DIR, &digest_cache->flags))
+		return digest_cache_dir_lookup_digest(dentry, digest_cache,
+						      digest, algo);
+
 	ret = digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
 	if (ret < 0)
 		return 0UL;
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index 9083a87374a5..34a26576a5aa 100644
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
@@ -95,6 +129,7 @@ struct htable {
  */
 struct digest_cache {
 	struct list_head htables;
+	struct list_head dir_entries;
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
@@ -208,4 +243,12 @@ size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 /* verif.c */
 void digest_cache_verif_free(struct digest_cache *digest_cache);
 
+/* dir.c */
+int digest_cache_dir_add_entries(struct digest_cache *digest_cache,
+				 struct path *digest_cache_path);
+uintptr_t digest_cache_dir_lookup_digest(struct dentry *dentry,
+					 struct digest_cache *digest_cache,
+					 u8 *digest, enum hash_algo algo);
+void digest_cache_dir_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index fda6ac599a2d..d050ebad3cbb 100644
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
@@ -283,6 +285,17 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 			/* Prevent usage of partially-populated digest cache. */
 			set_bit(INVALID, &digest_cache->flags);
 		}
+	} else if (S_ISDIR(inode->i_mode)) {
+		set_bit(IS_DIR, &digest_cache->flags);
+
+		ret = digest_cache_dir_add_entries(digest_cache,
+					&digest_cache->digest_list_path);
+		if (ret < 0) {
+			pr_debug("Failed to add dir entries to dir digest cache, ret: %d (keep digest cache)\n",
+				 ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &digest_cache->flags);
+		}
 	}
 
 	path_put(&digest_cache->digest_list_path);
-- 
2.34.1


