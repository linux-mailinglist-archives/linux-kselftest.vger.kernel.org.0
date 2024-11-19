Return-Path: <linux-kselftest+bounces-22261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A69D242A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D61F22E75
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17D1C57AD;
	Tue, 19 Nov 2024 10:54:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9161C4A3F;
	Tue, 19 Nov 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013692; cv=none; b=DQ30Z73LXAL/kW/eLChM+pQYDchpJRWQizcINVkBP4hYs58aDhz5F0t1yzzwaJLLTIaoWHOuAyb4CnItHQCWqlnuT9LyinPrT2IUoNZY+9zvKksl9fwslcka28bEKT5iZv9GcDGgZjdi62BueWjH7N8y5lj+YqF1iihSrcwNJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013692; c=relaxed/simple;
	bh=4S1UJBXtM5KHQLq/OrbrojZKuVYHJkbNsUkoSxHvM8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT3c+mdkZrJEpLZgyhMaMx/5DFEVUp4OvsytU45CZ/CWFKsAFiWheMjLb6HfiDhMrO4pplx0f1AAzJ5tmK3mCGcghBxDvMFGuoPOAKevZrOCjXNRnmkTMw2M9R7wgyNjc+tDLo6Udb6G9jcfyBAvYeJLBh7gENt5T51q1qzAE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt1076wSZz9v7Nc;
	Tue, 19 Nov 2024 18:27:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 12100140418;
	Tue, 19 Nov 2024 18:54:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHsyNDbjxnj1znAQ--.1193S4;
	Tue, 19 Nov 2024 11:54:46 +0100 (CET)
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
Subject: [PATCH v6 12/15] digest cache: Prefetch digest lists if requested
Date: Tue, 19 Nov 2024 11:49:19 +0100
Message-ID: <20241119104922.2772571-13-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHsyNDbjxnj1znAQ--.1193S4
X-Coremail-Antispam: 1UD129KBjvAXoWftr4rGw1UuF45Ww4rWFyfJFb_yoW8urWrZo
	ZakF47Aw48WFyUurs8CF17Aa1DW34Fq34xAr1kGFZ8Z3Z7AFWUGasrC3WDJFy5Jr18JFZ7
	Zwn7Xw4UJFWxtr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	Xa7IU0KiiDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IElAACsB

From: Roberto Sassu <roberto.sassu@huawei.com>

A desirable goal when doing integrity measurements is that they are done
always in the same order across boots, so that the resulting PCR value
becomes predictable and suitable for sealing policies. However, due to
parallel execution of system services at boot, a deterministic order of
measurements is difficult to achieve.

The Integrity Digest Cache is not exempted from this issue. If callers
of digest_cache_get() pass file descriptors of inodes in an unpredictable
order, this very likely will result in reading digest lists in an
unpredictable order too.

Overcome this issue by introducing digest_cache_dir_prefetch() and
digest_cache_dir_lookup_filename(), to sequentially search the digest list
the digest cache will be populated from in the parent directory, instead
of directly accessing it from the full path.

If during the file name search there is no match, read the digest list to
trigger its measurement (if an appropriate policy exists). If there is a
match, attempt to create and initialize the digest cache from the found
file name.

This ensures that measurements are always done in the same order as the
file names stored in the digest cache of the parent directory, regardless
of which digest list was requested. However, the PCR still changes every
time a not yet read digest list is requested. In any case, the possible PCR
values are more manageable than in the unpredictable file access case, at
most the number of digest lists. Of course, PCR values further change when
digest lists are added/removed to/from the parent directory, or if the
parent directory itself is modified through securityfs.

The prefetching mechanism has been designed to be more like a aid to get
predictable measurements, and does not defend against path change attacks.
It assumes that the path does not change between retrieving the digest
cache associated to an inode and prefetching (i.e. the prefetching
mechanism gets the same digest cache). If the path changed, and the
prefetching mechanism retrieved a different digest cache,
digest_cache_get() still continues to use the one it retrieved, and will
ignore the prefetched one.

Prefetching is enabled by setting the newly introduced
'security.dig_prefetch' xattr to '1'. digest_cache_new() and
digest_cache_dir_create() call digest_cache_prefetch_requested() to check
it. They pass the check result to digest_cache_create(), which in turn sets
the DIR_PREFETCH and FILE_PREFETCH bit respectively in the parent directory
and regular file digest cache.

On subsequent calls to digest_cache_prefetch_requested(), the latter can
just test for DIR_PREFETCH bit (faster).

digest_cache_get(), after digest cache creation, checks if the digest cache
has the FILE_PREFETCH bit set and, if yes, calls
digest_cache_dir_prefetch() to do prefetching. For just reading digest
lists, digest_cache_dir_prefetch() asks digest_cache_create() to create
special digest caches with the FILE_READ bit set, so that
digest_cache_populate() does not attempt to extract digests. The special
digest caches also are not attached to the corresponding inode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/xattr.h                 |   3 +
 security/integrity/digest_cache/dir.c      | 135 ++++++++++++++++++++-
 security/integrity/digest_cache/internal.h |  12 +-
 security/integrity/digest_cache/main.c     |  96 ++++++++++++++-
 security/integrity/digest_cache/populate.c |   9 +-
 security/integrity/digest_cache/verif.c    |   4 +
 6 files changed, 251 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 8a58cf4bce65..8af33d38d9e8 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -57,6 +57,9 @@
 #define XATTR_DIGEST_LIST_SUFFIX "digest_list"
 #define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_SUFFIX
 
+#define XATTR_DIG_PREFETCH_SUFFIX "dig_prefetch"
+#define XATTR_NAME_DIG_PREFETCH XATTR_SECURITY_PREFIX XATTR_DIG_PREFETCH_SUFFIX
+
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
diff --git a/security/integrity/digest_cache/dir.c b/security/integrity/digest_cache/dir.c
index 8f9e550c365f..a292a9c25119 100644
--- a/security/integrity/digest_cache/dir.c
+++ b/security/integrity/digest_cache/dir.c
@@ -56,6 +56,7 @@ static bool digest_cache_dir_iter(struct dir_context *__ctx, const char *name,
 	new_entry->seq_num = UINT_MAX;
 	new_entry->digest_cache = NULL;
 	mutex_init(&new_entry->digest_cache_mutex);
+	new_entry->prefetched = false;
 
 	if (new_entry->name[0] < '0' || new_entry->name[0] > '9')
 		goto out;
@@ -134,6 +135,11 @@ int digest_cache_dir_add_entries(struct digest_cache *digest_cache,
  * created/obtained from, so that the caller can use it to perform lookup
  * operations.
  *
+ * Before creating the digest cache, this function first calls
+ * digest_cache_prefetch_requested() to check if prefetching has been requested
+ * on the directory, and passes the result to digest_cache_create(), so that the
+ * latter sets the DIR_PREFETCH bit in the directory digest cache.
+ *
  * Return: A directory digest cache on success, NULL otherwise.
  */
 static struct digest_cache *digest_cache_dir_create(struct dentry *dentry,
@@ -142,6 +148,7 @@ static struct digest_cache *digest_cache_dir_create(struct dentry *dentry,
 {
 	struct digest_cache *digest_cache;
 	struct path _dir_path;
+	bool prefetch_req;
 	int ret;
 
 	ret = kern_path(path_str, 0, &_dir_path);
@@ -150,8 +157,10 @@ static struct digest_cache *digest_cache_dir_create(struct dentry *dentry,
 		return NULL;
 	}
 
+	prefetch_req = digest_cache_prefetch_requested(&_dir_path, path_str);
+
 	digest_cache = digest_cache_create(dentry, &_dir_path, dir_path,
-					   path_str, "");
+					   path_str, "", prefetch_req, false);
 	if (digest_cache)
 		digest_cache = digest_cache_init(dentry, dir_path,
 						 digest_cache);
@@ -204,7 +213,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 			cache = digest_cache_create(dentry, &dir_path,
 						    &digest_list_path,
 						    dir_cache->path_str,
-						    dir_entry->name);
+						    dir_entry->name, false,
+						    false);
 			if (cache)
 				cache = digest_cache_init(dentry,
 							  &digest_list_path,
@@ -221,6 +231,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 
 			/* Consume extra ref. from digest_cache_create(). */
 			dir_entry->digest_cache = cache;
+			/* Digest list was read, mark entry as prefetched. */
+			dir_entry->prefetched = true;
 		}
 		mutex_unlock(&dir_entry->digest_cache_mutex);
 
@@ -241,6 +253,125 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 	return found;
 }
 
+/**
+ * digest_cache_dir_lookup_filename - Lookup a digest list
+ * @dentry: Dentry of the file whose digest list is looked up
+ * @dir_path: Path structure of the digest list directory
+ * @digest_cache: Dir digest cache
+ * @filename: File name of the digest list to search
+ *
+ * This function iterates over the linked list created by
+ * digest_cache_dir_add_entries() and looks up a digest list with a matching
+ * file name among the entries. If there is no match, it prefetches (reads) the
+ * current digest list. Otherwise, it creates and initializes a new digest
+ * cache.
+ *
+ * The new digest cache is not returned, since it might have been created from
+ * a different inode than the one originally found during digest_cache_create().
+ *
+ * If it is the right one, digest_cache_init() called from digest_cache_get()
+ * will go ahead and simply use the initialized digest cache. If for any reason
+ * the inode was different, digest_cache_init() will use the one previously
+ * returned by digest_cache_create().
+ */
+static void digest_cache_dir_lookup_filename(struct dentry *dentry,
+					     struct path *dir_path,
+					     struct digest_cache *digest_cache,
+					     char *filename)
+{
+	struct digest_cache *cache;
+	struct dir_entry *dir_entry;
+	struct path digest_list_path;
+	bool filename_found;
+
+	list_for_each_entry(dir_entry, &digest_cache->dir_entries, list) {
+		mutex_lock(&dir_entry->digest_cache_mutex);
+		filename_found = !strcmp(dir_entry->name, filename);
+		if (!filename_found && dir_entry->prefetched) {
+			mutex_unlock(&dir_entry->digest_cache_mutex);
+			continue;
+		}
+
+		digest_list_path.dentry = NULL;
+		digest_list_path.mnt = NULL;
+
+		cache = digest_cache_create(dentry, dir_path, &digest_list_path,
+					    digest_cache->path_str,
+					    dir_entry->name, false,
+					    filename_found ? false : true);
+		if (cache)
+			cache = digest_cache_init(dentry, &digest_list_path,
+						  cache);
+
+		if (digest_list_path.dentry)
+			path_put(&digest_list_path);
+
+		if (!filename_found)
+			pr_debug("Digest list %s/%s %s prefetched\n",
+				 digest_cache->path_str, dir_entry->name,
+				 cache ? "has been" : "cannot be");
+
+		if (cache)
+			digest_cache_put(cache);
+
+		dir_entry->prefetched = true;
+		mutex_unlock(&dir_entry->digest_cache_mutex);
+
+		if (filename_found)
+			break;
+	}
+
+	/* Prefetching done, no need to repeat. */
+	clear_bit(FILE_PREFETCH, &digest_cache->flags);
+}
+
+/**
+ * digest_cache_dir_prefetch - Prefetch digest lists in parent directory
+ * @dentry: Dentry of the file whose digest list is looked up
+ * @digest_cache: Digest cache
+ *
+ * This function prefetches the digest lists in the parent directory of the
+ * passed digest cache.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_dir_prefetch(struct dentry *dentry,
+			      struct digest_cache *digest_cache)
+{
+	struct digest_cache *dir_cache;
+	char *path_str, *last;
+	struct path dir_path = { .dentry = NULL, .mnt = NULL };
+	int ret = 0;
+
+	last = strrchr(digest_cache->path_str, '/');
+	if (!last)
+		return -EINVAL;
+
+	path_str = kstrndup(digest_cache->path_str,
+			    last - digest_cache->path_str, GFP_KERNEL);
+	if (!path_str)
+		return -ENOMEM;
+
+	dir_cache = digest_cache_dir_create(dentry, &dir_path, path_str);
+
+	kfree(path_str);
+
+	if (!dir_cache) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	digest_cache_dir_lookup_filename(dentry, &dir_path, dir_cache,
+					 last + 1);
+
+	digest_cache_put(dir_cache);
+out:
+	if (dir_path.dentry)
+		path_put(&dir_path);
+
+	return ret;
+}
+
 /**
  * digest_cache_dir_free - Free the stored file list and put digest caches
  * @digest_cache: Dir digest cache
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index f849afe5e47b..5af7f6e7bdf6 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -18,6 +18,9 @@
 #define INIT_STARTED		1	/* Digest cache init started. */
 #define INVALID			2	/* Digest cache marked as invalid. */
 #define IS_DIR			3	/* Digest cache created from dir. */
+#define DIR_PREFETCH		4	/* Prefetch enabled for dir. */
+#define FILE_PREFETCH		5	/* Prefetch enabled for dir entry. */
+#define FILE_READ		6	/* Digest cache for reading file. */
 
 /**
  * struct readdir_callback - Structure to store information for dir iteration
@@ -38,6 +41,7 @@ struct readdir_callback {
  * @digest_cache: Digest cache associated to the directory entry
  * @digest_cache_mutex: Protects @digest_cache
  * @seq_num: Sequence number of the directory entry from file name
+ * @prefetched: Whether the digest list has been already prefetched
  * @name: File name of the directory entry
  *
  * This structure represents a directory entry with a digest cache created
@@ -48,6 +52,7 @@ struct dir_entry {
 	struct digest_cache *digest_cache;
 	struct mutex digest_cache_mutex;
 	unsigned int seq_num;
+	bool prefetched;
 	char name[];
 };
 
@@ -219,7 +224,10 @@ digest_cache_from_file_sec(const struct file *file)
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *default_path,
 					 struct path *digest_list_path,
-					 char *path_str, char *filename);
+					 char *path_str, char *filename,
+					 bool prefetch_req, bool prefetch);
+bool digest_cache_prefetch_requested(struct path *digest_list_path,
+				     char *path_str);
 struct digest_cache *digest_cache_init(struct dentry *dentry,
 				       struct path *digest_list_path,
 				       struct digest_cache *digest_cache);
@@ -255,6 +263,8 @@ struct digest_cache *
 digest_cache_dir_lookup_digest(struct dentry *dentry,
 			       struct digest_cache *digest_cache, u8 *digest,
 			       enum hash_algo algo);
+int digest_cache_dir_prefetch(struct dentry *dentry,
+			      struct digest_cache *digest_cache);
 void digest_cache_dir_free(struct digest_cache *digest_cache);
 
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 9df819c323c7..ca1f0bc8ec94 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -86,6 +86,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
  * @digest_list_path: Path structure of the digest list
  * @path_str: Path string of the digest list
  * @filename: Digest list file name (can be an empty string)
+ * @prefetch_req: Whether prefetching has been requested
+ * @prefetch: Whether prefetching of a digest list is being done
  *
  * This function first locates, from the passed path and filename, the digest
  * list inode from which the digest cache will be created or retrieved (if it
@@ -107,7 +109,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *default_path,
 					 struct path *digest_list_path,
-					 char *path_str, char *filename)
+					 char *path_str, char *filename,
+					 bool prefetch_req, bool prefetch)
 {
 	struct digest_cache *digest_cache = NULL;
 	struct digest_cache_security *dig_sec;
@@ -160,6 +163,16 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 		goto out;
 	}
 
+	if (prefetch) {
+		digest_cache = digest_cache_alloc_init(path_str, filename);
+		if (digest_cache) {
+			set_bit(FILE_READ, &digest_cache->flags);
+			goto out_set;
+		}
+
+		goto out;
+	}
+
 	/* Ref. count is already 1 for this reference. */
 	dig_sec->dig_owner = digest_cache_alloc_init(path_str, filename);
 	if (!dig_sec->dig_owner)
@@ -167,14 +180,68 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 
 	/* Increment ref. count for reference returned to the caller. */
 	digest_cache = digest_cache_ref(dig_sec->dig_owner);
-
+out_set:
 	/* Make other digest cache requestors wait until creation complete. */
 	set_bit(INIT_IN_PROGRESS, &digest_cache->flags);
+
+	/* Set bit if prefetching was requested. */
+	if (prefetch_req) {
+		if (S_ISREG(inode->i_mode))
+			set_bit(FILE_PREFETCH, &digest_cache->flags);
+		else
+			set_bit(DIR_PREFETCH, &digest_cache->flags);
+	}
 out:
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 	return digest_cache;
 }
 
+/**
+ * digest_cache_prefetch_requested - Verify if prefetching is requested
+ * @digest_list_path: Path structure of the digest list directory
+ * @path_str: Path string of the digest list directory
+ *
+ * This function verifies whether or not digest list prefetching is requested.
+ * If dig_owner exists in the inode security blob, it checks the DIR_PREFETCH
+ * bit (faster). Otherwise, it reads the security.dig_prefetch xattr.
+ *
+ * Return: True if prefetching is requested, false otherwise.
+ */
+bool digest_cache_prefetch_requested(struct path *digest_list_path,
+				     char *path_str)
+{
+	struct digest_cache_security *dig_sec;
+	bool prefetch_req = false;
+	char prefetch_value;
+	struct inode *inode;
+	int ret;
+
+	inode = d_backing_inode(digest_list_path->dentry);
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return false;
+
+	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner) {
+		/* Reliable test: DIR_PREFETCH set with dig_owner_mutex held. */
+		prefetch_req = test_bit(DIR_PREFETCH,
+					&dig_sec->dig_owner->flags);
+		mutex_unlock(&dig_sec->dig_owner_mutex);
+		return prefetch_req;
+	}
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+
+	ret = vfs_getxattr(&nop_mnt_idmap, digest_list_path->dentry,
+			   XATTR_NAME_DIG_PREFETCH, &prefetch_value, 1);
+	if (ret == 1 && prefetch_value == '1') {
+		pr_debug("Prefetching has been enabled for directory %s\n",
+			 path_str);
+		prefetch_req = true;
+	}
+
+	return prefetch_req;
+}
+
 /**
  * digest_cache_new - Retrieve digest list file name and request digest cache
  * @dentry: Dentry of the inode for which the digest cache will be used
@@ -186,6 +253,12 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
  * with that file name. If security.digest_list is empty or not found, this
  * function requests the creation of a digest cache on the parent directory.
  *
+ * In either case, this function first calls digest_cache_prefetch_requested()
+ * to check if prefetching has been requested on the parent directory, and
+ * passes the result to digest_cache_create(), so that the latter sets the
+ * FILE_PREFETCH and DIR_PREFETCH bit respectively in the file or directory
+ * digest caches.
+ *
  * This function passes to the caller the path of the digest list from which
  * the digest cache was created (file or parent directory), so that
  * digest_cache_init() can reuse the same path, and to prevent the inode from
@@ -199,6 +272,7 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry,
 	char filename[NAME_MAX + 1] = { 0 };
 	struct digest_cache *digest_cache = NULL;
 	struct path default_path;
+	bool prefetch_req = false;
 	int ret;
 
 	ret = kern_path(default_path_str, 0, &default_path);
@@ -244,9 +318,12 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry,
 		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
 		 filename);
 create:
+	prefetch_req = digest_cache_prefetch_requested(&default_path,
+						       default_path_str);
+
 	digest_cache = digest_cache_create(dentry, &default_path,
 					   digest_list_path, default_path_str,
-					   filename);
+					   filename, prefetch_req, false);
 out:
 	path_put(&default_path);
 	return digest_cache;
@@ -372,9 +449,20 @@ struct digest_cache *digest_cache_get(struct file *file)
 
 	mutex_unlock(&dig_sec->dig_user_mutex);
 
-	if (digest_cache)
+	if (digest_cache) {
+		/*
+		 * Prefetching should also initialize our digest cache, if the
+		 * path didn't change meanwhile (otherwise the prefetching
+		 * mechanism will create and initialize the digest cache of a
+		 * different inode).
+		 */
+		if (test_bit(FILE_PREFETCH, &digest_cache->flags))
+			digest_cache_dir_prefetch(dentry, digest_cache);
+
+		/* Make sure we initialize our digest cache. */
 		digest_cache = digest_cache_init(dentry, &digest_list_path,
 						 digest_cache);
+	}
 
 	if (digest_list_path.dentry)
 		path_put(&digest_list_path);
diff --git a/security/integrity/digest_cache/populate.c b/security/integrity/digest_cache/populate.c
index 54f7f95f5794..b1646da07f36 100644
--- a/security/integrity/digest_cache/populate.c
+++ b/security/integrity/digest_cache/populate.c
@@ -11,6 +11,7 @@
 #include <linux/init_task.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_read_file.h>
+#include <linux/namei.h>
 
 #include "internal.h"
 
@@ -82,6 +83,12 @@ int digest_cache_populate(struct dentry *dentry,
 		return ret;
 	}
 
+	/* The caller wants just to read digest lists. */
+	if (test_bit(FILE_READ, &digest_cache->flags)) {
+		ret = 0;
+		goto out_vfree;
+	}
+
 	data_len = digest_cache_strip_modsig(data, ret);
 
 	/* Digest list parsers initialize the hash table and add the digests. */
@@ -91,7 +98,7 @@ int digest_cache_populate(struct dentry *dentry,
 	if (ret < 0)
 		pr_debug("Error parsing digest list %s, ret: %d\n",
 			 digest_cache->path_str, ret);
-
+out_vfree:
 	vfree(data);
 	return ret;
 }
diff --git a/security/integrity/digest_cache/verif.c b/security/integrity/digest_cache/verif.c
index 03ebf0de764b..2854bdab3e07 100644
--- a/security/integrity/digest_cache/verif.c
+++ b/security/integrity/digest_cache/verif.c
@@ -44,6 +44,10 @@ int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
 	gfp_t flags = !strncmp(verif_id, "kprobe", 6) ? GFP_ATOMIC : GFP_KERNEL;
 	int ret = 0;
 
+	/* Allows us to detect that we are prefetching in the tests. */
+	if (test_bit(FILE_READ, &digest_cache->flags))
+		return -ENOENT;
+
 	/*
 	 * Zero the data, so that we can always call free_verif() to free a
 	 * partially filled structure (if a pointer is NULL, will not be freed).
-- 
2.47.0.118.gfd3785337b


