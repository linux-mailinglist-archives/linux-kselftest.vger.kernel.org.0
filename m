Return-Path: <linux-kselftest+bounces-7977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E38A539C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4881C219B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442A82481;
	Mon, 15 Apr 2024 14:27:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927257C085;
	Mon, 15 Apr 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191263; cv=none; b=OIfueERh1fvEG8Ck3kZpIEAVCRCdwVEs/0KXk/dvr9qdj2uUH39DVAsL/Nn9z7lDRvlESWjWEHneUFRY8MXIkotIkVKBq3lTwkaWpNqKporMMJS2EVfcNgqeSmUa8QXKgF/7jhCREejLlxrnkMV4i26WeCjfo+opIS0KsOr47dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191263; c=relaxed/simple;
	bh=dtfkfV8AsY0ZbzcHITpN2TpqLuxJlpIKgBeW/JL7kJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogGbIAOf4K++E3JQhAI5O4P0EYx5noC4Bu7P5sb5p/sJTAesL02F/u+GdTskA0NTrwB0S9Bb2EuoHONGiEGPoUQ3vt/+Wl/2lvyftnOLnYE6H0/zXnecpsov7BjJj/yzcWJjI70C699OnlZKByn/ho8YJlqVs4dkB4k14L+BK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJ8Gg5Lf5z9xGYd;
	Mon, 15 Apr 2024 22:11:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2A81B14064D;
	Mon, 15 Apr 2024 22:27:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S11;
	Mon, 15 Apr 2024 15:27:28 +0100 (CET)
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
Subject: [PATCH v4 09/14] digest_cache: Add support for directories
Date: Mon, 15 Apr 2024 16:24:31 +0200
Message-Id: <20240415142436.2545003-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S11
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr4kZw4Dtr1fWr4xtrykuFg_yoW8XrWUKo
	ZavF4UAw18WFyUur4DCF17Aa1UW34Fqw1xAr4ktFWDZ3W8XrWUJ3ZrCF1DJFy5Xr18JFZ7
	Awn7Jws8JrW8tr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOO7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
	v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZF
	pf9x07jxWrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h0uQAAss

From: Roberto Sassu <roberto.sassu@huawei.com>

In the environments where xattrs are not available (e.g. in the initial ram
disk), the digest_cache LSM cannot precisely determine which digest list in
a directory contains the desired reference digest. However, although
slower, it would be desirable to search the digest in all digest lists of
that directory.

This done in two steps. When a digest cache is being created,
digest_cache_create() invokes digest_cache_dir_create(), to generate the
list of current directory entries. Entries are placed in the list in
ascending order by the <seq num> if prepended to the file name, or at the
end of the list if not.

The resulting digest cache has the IS_DIR bit set, to distinguish it from
the digest caches created from regular files.

Second, when a digest is searched in a directory digest cache,
digest_cache_lookup() invokes digest_cache_dir_lookup_digest() to
iteratively search that digest in each directory entry generated by
digest_cache_dir_create().

That list is stable, even if new files are added or deleted from that
directory. A subsequent patch will invalidate the digest cache, forcing
next callers of digest_cache_get() to get a new directory digest cache with
the updated list of directory entries.

If the current directory entry does not have a digest cache reference,
digest_cache_dir_lookup_digest() invokes digest_cache_create() to create a
new digest cache for that entry. In either case,
digest_cache_dir_lookup_digest() calls then digest_cache_htable_lookup()
with the new/existing digest cache to search the digest. Check and
assignment of the digest cache in a directory entry is protected by the
per entry digest_cache_mutex.

The iteration stops when the digest is found. In that case,
digest_cache_dir_lookup_digest() returns the digest cache reference of the
current directory entry as the digest_cache_found_t type, so that callers
of digest_cache_lookup() don't mistakenly try to call digest_cache_put()
with that reference.

This new reference type will be used to retrieve information about the
digest cache containing the digest, which is not known in advance until the
digest search is performed.

The order of the list of directory entries influences the speed of the
digest search. A search terminates faster if less digest caches have to be
created. One way to optimize it could be to order the list of digest lists
in the same way of when they are requested at boot.

Finally, digest_cache_dir_free() releases the digest cache references
stored in the list of directory entries, and frees the list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/digest_cache/Makefile   |   2 +-
 security/digest_cache/dir.c      | 193 +++++++++++++++++++++++++++++++
 security/digest_cache/htable.c   |  22 +++-
 security/digest_cache/internal.h |  45 +++++++
 security/digest_cache/main.c     |  12 ++
 5 files changed, 271 insertions(+), 3 deletions(-)
 create mode 100644 security/digest_cache/dir.c

diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index 37a473c7bc28..e417da0383ab 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o dir.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/digest_cache/dir.c b/security/digest_cache/dir.c
new file mode 100644
index 000000000000..7bfcdd5f7ef1
--- /dev/null
+++ b/security/digest_cache/dir.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Manage digest caches from directories.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include <linux/init_task.h>
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
+ * digest_cache_dir_create - Create a directory digest cache
+ * @digest_cache: Digest cache
+ * @digest_list_path: Path structure of the digest list directory
+ *
+ * This function iterates over the entries of a directory, and creates a linked
+ * list of file names from that directory.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_dir_create(struct digest_cache *digest_cache,
+			    struct path *digest_list_path)
+{
+	struct file *dir_file;
+	struct readdir_callback buf = {
+		.ctx.actor = digest_cache_dir_iter,
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
+	buf.head = &digest_cache->dir_entries;
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
+ * digest_cache_dir_lookup_digest - Lookup a digest
+ * @dentry: Dentry of the file whose digest is looked up
+ * @digest_list_path: Path structure of the digest list directory
+ * @digest_cache: Digest cache
+ * @digest: Digest to search
+ * @algo: Algorithm of the digest to search
+ *
+ * This function iterates over the linked list created by
+ * digest_cache_dir_create() and looks up the digest in the digest cache of
+ * each entry.
+ *
+ * Return: A digest_cache_found_t value if the digest if found, zero otherwise.
+ */
+digest_cache_found_t
+digest_cache_dir_lookup_digest(struct dentry *dentry,
+			       struct path *digest_list_path,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo)
+{
+	struct digest_cache *cache;
+	struct dir_entry *dir_entry;
+	int ret;
+
+	list_for_each_entry(dir_entry, &digest_cache->dir_entries, list) {
+		mutex_lock(&dir_entry->digest_cache_mutex);
+		if (!dir_entry->digest_cache) {
+			cache = digest_cache_create(dentry, digest_list_path,
+						    digest_cache->path_str,
+						    dir_entry->name);
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
+		if (!ret)
+			return (digest_cache_found_t)dir_entry->digest_cache;
+	}
+
+	return 0UL;
+}
+
+/**
+ * digest_cache_dir_free - Free the stored file list and put digest caches
+ * @digest_cache: Digest cache
+ *
+ * This function frees the file list created by digest_cache_create(), and puts
+ * the digest cache if a reference exists.
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
diff --git a/security/digest_cache/htable.c b/security/digest_cache/htable.c
index d2d5d8f5e5b1..8cf7400dfcf4 100644
--- a/security/digest_cache/htable.c
+++ b/security/digest_cache/htable.c
@@ -8,6 +8,8 @@
  */
 
 #define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include <linux/namei.h>
+
 #include "internal.h"
 
 /**
@@ -210,10 +212,26 @@ digest_cache_found_t digest_cache_lookup(struct dentry *dentry,
 					 struct digest_cache *digest_cache,
 					 u8 *digest, enum hash_algo algo)
 {
+	struct path digest_list_path;
+	digest_cache_found_t found;
 	int ret;
 
-	ret = digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
-	return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;
+	if (!test_bit(IS_DIR, &digest_cache->flags)) {
+		ret = digest_cache_htable_lookup(dentry, digest_cache, digest,
+						 algo);
+		return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;
+	}
+
+	ret = kern_path(digest_cache->path_str, 0, &digest_list_path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", digest_cache->path_str);
+		return 0UL;
+	}
+
+	found = digest_cache_dir_lookup_digest(dentry, &digest_list_path,
+					       digest_cache, digest, algo);
+	path_put(&digest_list_path);
+	return found;
 }
 EXPORT_SYMBOL_GPL(digest_cache_lookup);
 
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index 4929d25e7972..b7afca8e04da 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -16,6 +16,39 @@
 /* Digest cache bits in flags. */
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
 #define INVALID			1	/* Digest cache marked as invalid. */
+#define IS_DIR			2	/* Digest cache created from dir. */
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
+} __packed;
 
 /**
  * struct digest_cache_verif
@@ -83,6 +116,7 @@ struct htable {
 /**
  * struct digest_cache - Digest cache
  * @htables: Hash tables (one per algorithm)
+ * @dir_entries: List of files in a directory and the digest cache
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
@@ -93,6 +127,7 @@ struct htable {
  */
 struct digest_cache {
 	struct list_head htables;
+	struct list_head dir_entries;
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
@@ -193,4 +228,14 @@ size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
 /* verif.c */
 void digest_cache_verif_free(struct digest_cache *digest_cache);
 
+/* dir.c */
+int digest_cache_dir_create(struct digest_cache *digest_cache,
+			    struct path *digest_list_path);
+digest_cache_found_t
+digest_cache_dir_lookup_digest(struct dentry *dentry,
+			       struct path *digest_list_path,
+			       struct digest_cache *digest_cache, u8 *digest,
+			       enum hash_algo algo);
+void digest_cache_dir_free(struct digest_cache *digest_cache);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index f3475b36e566..15f1486610a3 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -50,6 +50,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	digest_cache->flags = 0UL;
 	INIT_LIST_HEAD(&digest_cache->htables);
 	INIT_LIST_HEAD(&digest_cache->verif_data);
+	INIT_LIST_HEAD(&digest_cache->dir_entries);
 	mutex_init(&digest_cache->mutex);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
@@ -68,6 +69,7 @@ static void digest_cache_free(struct digest_cache *digest_cache)
 {
 	digest_cache_htable_free(digest_cache);
 	digest_cache_verif_free(digest_cache);
+	digest_cache_dir_free(digest_cache);
 	mutex_destroy(&digest_cache->mutex);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
@@ -185,6 +187,16 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 			/* Prevent usage of partially-populated digest cache. */
 			set_bit(INVALID, &digest_cache->flags);
 		}
+	} else if (S_ISDIR(inode->i_mode)) {
+		set_bit(IS_DIR, &dig_sec->dig_owner->flags);
+
+		ret = digest_cache_dir_create(digest_cache, digest_list_path);
+		if (ret < 0) {
+			pr_debug("Failed to create dir digest cache, ret: %d (keep digest cache)\n",
+				 ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &dig_sec->dig_owner->flags);
+		}
 	}
 
 	/* Creation complete, notify the other lock contenders. */
-- 
2.34.1


