Return-Path: <linux-kselftest+bounces-4443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E10584F6DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C541F21390
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4586931D;
	Fri,  9 Feb 2024 14:13:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF067E72;
	Fri,  9 Feb 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487997; cv=none; b=oK3Ko0/O6jMx0OQSwvMgr9RGD64BG4MamZzVzW8bvbqhPFgy5Q0KMFEvmsQebXS3c1E5+6G4fSsQZ0SQ2x0/S/VxudDIrcO/Z9cE7wPsKhGcWzD380gnif9eHrmHloFGEbKsykgyutd2MWiHWlep8Qolf28Bq1QcwleJ+tpWtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487997; c=relaxed/simple;
	bh=FR8HVe+5+ZRIXHDV4G8XdB3pSlIH4F96oeUWxAu2zso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSa7szK2xYQ4XBHDw49CkQVJL6WDHhb+uzGo1b42uBzYeAnlEhAbQCA2dxmIzIn9oesmvGuXi7++GZIQb5dhqfJ7Eox5yTkIlqeMhamNzcDHw1VjUHBmhf17O12qBKFvSQkbkErd4DXidJrz8awl5BEamje+HAbL8hPE3hkt/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TWb632gRyz9yB7W;
	Fri,  9 Feb 2024 21:58:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0312F14068C;
	Fri,  9 Feb 2024 22:13:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCThMsZloMgpAg--.31110S2;
	Fri, 09 Feb 2024 15:13:04 +0100 (CET)
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
Subject: [PATCH v3 10/13] digest cache: Prefetch digest lists if requested
Date: Fri,  9 Feb 2024 15:09:14 +0100
Message-Id: <20240209140917.846878-11-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoCThMsZloMgpAg--.31110S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJFykCF1DWFW3urWDuF4fGrg_yoW8WryrJo
	Za9F4UAw18WFyUurs8uF17Aa1DW34Yg34xAr1kGFW5Z3WkAryUG3ZrC3WDJFy5Xr18JFZ7
	Zwn7Jw45JrWUtr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY97AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JV
	W5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0JUUl1kUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y4gwAGsU

From: Roberto Sassu <roberto.sassu@huawei.com>

A desirable goal when doing integrity measurements is that they are done
always in the same order across boots, so that the resulting PCR value
becomes predictable and suitable for sealing policies. However, due to
parallel execution of system services at boot, a deterministic order of
measurements is difficult to achieve.

The digest_cache LSM is not exempted from this issue. Under the assumption
that only the digest list is measured, and file measurements are omitted if
their digest is found in that digest list, a PCR can be predictable only if
all files belong to the same digest list. Otherwise, it will still be
unpredictable, since files accessed in a non-deterministic order will cause
digest lists to be measured in a non-deterministic order too.

Overcome this issue, if prefetching is enabled, by searching a digest list
file name in digest_list_dir_lookup_filename() among the entries of the
linked list built by digest_cache_dir_create(). If the file name does not
match, read the digest list to trigger its measurement. Otherwise, also
create a digest cache and return that to the caller. Release the extra
reference of the directory digest cache in digest_cache_new(), since it was
only used for the search and it is not going to be returned.

Prefetching needs to be explicitly enabled by setting the new
security.dig_prefetch xattr to 1 in the directory containing the digest
lists. The newly introduced function digest_cache_prefetch_requested()
checks first if the DIR_PREFETCH bit is set in dig_owner, otherwise it
reads the xattr. digest_cache_create() sets DIR_PREFETCH in dig_owner, if
prefetching is enabled, before declaring the digest cache as initialized.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/xattr.h       |  3 +
 security/digest_cache/dir.c      | 55 +++++++++++++++++-
 security/digest_cache/internal.h | 11 +++-
 security/digest_cache/main.c     | 98 ++++++++++++++++++++++++++++++--
 security/digest_cache/populate.c |  8 ++-
 security/digest_cache/verif.c    |  5 +-
 6 files changed, 171 insertions(+), 9 deletions(-)

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
 
diff --git a/security/digest_cache/dir.c b/security/digest_cache/dir.c
index 3d684af241a2..a5ae37822717 100644
--- a/security/digest_cache/dir.c
+++ b/security/digest_cache/dir.c
@@ -54,6 +54,7 @@ static bool digest_cache_dir_iter(struct dir_context *__ctx, const char *name,
 	new_entry->seq_num = UINT_MAX;
 	new_entry->digest_cache = NULL;
 	mutex_init(&new_entry->digest_cache_mutex);
+	new_entry->prefetched = false;
 
 	if (new_entry->name[0] < '0' || new_entry->name[0] > '9')
 		goto out;
@@ -127,6 +128,7 @@ int digest_cache_dir_create(struct digest_cache *digest_cache,
  * @digest_cache: Digest cache
  * @digest: Digest to search
  * @algo: Algorithm of the digest to search
+ * @filename: File name of the digest list to search
  *
  * This function iterates over the linked list created by
  * digest_cache_dir_create() and looks up the digest in the digest cache of
@@ -149,7 +151,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 		if (!dir_entry->digest_cache) {
 			cache = digest_cache_create(dentry, digest_list_path,
 						    digest_cache->path_str,
-						    dir_entry->name);
+						    dir_entry->name, false,
+						    false);
 			/* Ignore digest caches that cannot be instantiated. */
 			if (!cache) {
 				mutex_unlock(&dir_entry->digest_cache_mutex);
@@ -158,6 +161,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 
 			/* Consume extra ref. from digest_cache_create(). */
 			dir_entry->digest_cache = cache;
+			/* Digest list was read, mark entry as prefetched. */
+			dir_entry->prefetched = true;
 		}
 		mutex_unlock(&dir_entry->digest_cache_mutex);
 
@@ -171,6 +176,54 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 	return 0UL;
 }
 
+/**
+ * digest_cache_dir_lookup_filename - Lookup a digest list
+ * @dentry: Dentry of the file whose digest list is looked up
+ * @digest_list_path: Path structure of the digest list directory
+ * @digest_cache: Digest cache
+ * @filename: File name of the digest list to search
+ *
+ * This function iterates over the linked list created by
+ * digest_cache_dir_create() and looks up a digest list with a matching file
+ * name among the entries. If there is no match, it prefetches (reads) the
+ * current digest list. Otherwise, it returns the digest cache pointer from
+ * digest_cache_create() to the caller.
+ *
+ * Return: A digest cache pointer if the digest list if found, NULL otherwise.
+ */
+struct digest_cache *
+digest_cache_dir_lookup_filename(struct dentry *dentry,
+				 struct path *digest_list_path,
+				 struct digest_cache *digest_cache,
+				 char *filename)
+{
+	struct digest_cache *cache;
+	struct dir_entry *dir_entry;
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
+		cache = digest_cache_create(dentry, digest_list_path,
+					    digest_cache->path_str,
+					    dir_entry->name, false,
+					    filename_found ? false : true);
+
+		dir_entry->prefetched = true;
+		mutex_unlock(&dir_entry->digest_cache_mutex);
+
+		if (filename_found)
+			return cache;
+	}
+
+	return NULL;
+}
+
 /**
  * digest_cache_dir_free - Free the stored file list and put digest caches
  * @digest_cache: Digest cache
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index dee24d48abad..bbef5ab83107 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -17,6 +17,7 @@
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
 #define INVALID			1	/* Digest cache marked as invalid. */
 #define IS_DIR			2	/* Digest cache created from dir. */
+#define DIR_PREFETCH		3	/* Prefetching requested for dir. */
 
 /**
  * struct readdir_callback - Structure to store information for dir iteration
@@ -37,6 +38,7 @@ struct readdir_callback {
  * @digest_cache: Digest cache associated to the directory entry
  * @digest_cache_mutex: Protects @digest_cache
  * @seq_num: Sequence number of the directory entry from file name
+ * @prefetched: Whether the digest list has been already prefetched
  * @name: File name of the directory entry
  *
  * This structure represents a directory entry with a digest cache created
@@ -47,6 +49,7 @@ struct dir_entry {
 	struct digest_cache *digest_cache;
 	struct mutex digest_cache_mutex;
 	unsigned int seq_num;
+	bool prefetched;
 	char name[];
 } __packed;
 
@@ -205,7 +208,8 @@ digest_cache_from_file_sec(const struct file *file)
 /* main.c */
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
-					 char *path_str, char *filename);
+					 char *path_str, char *filename,
+					 bool prefetch_req, bool prefetch);
 
 /* htable.c */
 int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_digests,
@@ -236,6 +240,11 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 			       struct path *digest_list_path,
 			       struct digest_cache *digest_cache, u8 *digest,
 			       enum hash_algo algo);
+struct digest_cache *
+digest_cache_dir_lookup_filename(struct dentry *dentry,
+				 struct path *digest_list_path,
+				 struct digest_cache *digest_cache,
+				 char *filename);
 void digest_cache_dir_free(struct digest_cache *digest_cache);
 
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index a51c33dd07a8..e6598f81074a 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -82,6 +82,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
  * @digest_list_path: Path structure of the digest list
  * @path_str: Path string of the digest list
  * @filename: Digest list file name (can be an empty string)
+ * @prefetch_req: Whether prefetching has been requested
+ * @prefetch: Whether prefetching of a digest list is being done
  *
  * This function first locates, from the passed path, the digest list inode
  * from which the digest cache will be created or retrieved (if it already
@@ -108,7 +110,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
  */
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
-					 char *path_str, char *filename)
+					 char *path_str, char *filename,
+					 bool prefetch_req, bool prefetch)
 {
 	struct path file_path;
 	struct digest_cache *digest_cache = NULL;
@@ -136,11 +139,21 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 		 * digest cache is populated from.
 		 */
 		if (d_backing_inode(dentry) == inode)
-			return NULL;
+			goto out;
 
 		/* No support for nested directories. */
 		if (!S_ISREG(inode->i_mode))
-			return NULL;
+			goto out;
+
+		if (prefetch) {
+			/* Fine to fail, we are just prefetching. */
+			ret = digest_cache_populate(NULL, digest_list_path,
+						    path_str, filename);
+			pr_debug("Digest list %s/%s %s prefetched\n",
+				 path_str, filename,
+				 !ret ? "has been" : "cannot be");
+			goto out;
+		}
 	}
 
 	dig_sec = digest_cache_get_security(inode);
@@ -169,6 +182,11 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 
 	/* Make the other lock contenders wait until creation complete. */
 	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
+
+	/* Set DIR_PREFETCH if prefetching was requested. */
+	if (prefetch_req)
+		set_bit(DIR_PREFETCH, &digest_cache->flags);
+
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 
 	if (S_ISREG(inode->i_mode)) {
@@ -213,6 +231,52 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 	return digest_cache;
 }
 
+/**
+ * digest_cache_prefetch_requested - Verify if prefetching is requested
+ * @digest_list_path: Path structure of the digest list directory
+ * @path_str: Path string of the digest list directory
+ *
+ * This function verifies whether or not digest list prefetching is requested.
+ * If dig_owner exists in the inode security blob, it checks the DIR_PREFETCH
+ * bit (faster). Otherwise, it reads the new security.dig_prefetch xattr.
+ *
+ * Return: True if prefetching is requested, false otherwise.
+ */
+static bool digest_cache_prefetch_requested(struct path *digest_list_path,
+					    char *path_str)
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
@@ -223,13 +287,19 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
  * with that file name. If security.digest_list is not found, this function
  * requests the creation of a digest cache on the parent directory.
  *
+ * On prefetching, if the default path is a directory and if
+ * security.digest_list is found, this function first retrieves the directory
+ * digest cache, and then calls digest_cache_dir_lookup_filename() to retrieve
+ * the desired digest cache in that directory.
+ *
  * Return: A new digest cache on success, NULL on error.
  */
 static struct digest_cache *digest_cache_new(struct dentry *dentry)
 {
 	char filename[NAME_MAX + 1] = { 0 };
-	struct digest_cache *digest_cache = NULL;
+	struct digest_cache *digest_cache = NULL, *found;
 	struct path default_path;
+	bool prefetch_req = false;
 	int ret;
 
 	ret = kern_path(default_path_str, 0, &default_path);
@@ -266,9 +336,27 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry)
 	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
 		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
 		 filename);
+
+	/* On prefetching, retrieve the directory digest cache. */
+	if (filename[0])
+		prefetch_req = digest_cache_prefetch_requested(&default_path,
+							default_path_str);
 create:
 	digest_cache = digest_cache_create(dentry, &default_path,
-					   default_path_str, filename);
+					   default_path_str,
+					   !prefetch_req ? filename : "",
+					   prefetch_req, false);
+	if (!digest_cache)
+		goto out;
+
+	if (prefetch_req) {
+		/* Find the digest cache with a matching file name. */
+		found = digest_cache_dir_lookup_filename(dentry, &default_path,
+							 digest_cache,
+							 filename);
+		digest_cache_put(digest_cache);
+		digest_cache = found;
+	}
 out:
 	path_put(&default_path);
 	return digest_cache;
diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
index 9c2fc2295310..17e7b011c367 100644
--- a/security/digest_cache/populate.c
+++ b/security/digest_cache/populate.c
@@ -143,6 +143,12 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 		return ret;
 	}
 
+	/* The caller wants just to read digest lists. */
+	if (!digest_cache) {
+		ret = 0;
+		goto out_vfree;
+	}
+
 	data_len = digest_cache_strip_modsig(data, ret);
 
 	/* Digest list parsers initialize the hash table and add the digests. */
@@ -151,7 +157,7 @@ int digest_cache_populate(struct digest_cache *digest_cache,
 	if (ret < 0)
 		pr_debug("Error parsing digest list %s%s%s, ret: %d\n",
 			 path_str, filename[0] ? "/" : "", filename, ret);
-
+out_vfree:
 	vfree(data);
 	return ret;
 }
diff --git a/security/digest_cache/verif.c b/security/digest_cache/verif.c
index dd480bdc805a..9599d1832529 100644
--- a/security/digest_cache/verif.c
+++ b/security/digest_cache/verif.c
@@ -33,7 +33,7 @@ static void free_verif(struct digest_cache_verif *verif)
  * This function lets a verifier supply verification data about a digest list
  * being read to populate the digest cache.
  *
- * Return: Zero on success, -ENOMEM if out of memory.
+ * Return: Zero on success, -ENOMEM if out of memory, -ENOENT on prefetching.
  */
 int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
 			   size_t size)
@@ -41,6 +41,9 @@ int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
 	struct digest_cache *digest_cache = digest_cache_from_file_sec(file);
 	struct digest_cache_verif *new_verif;
 
+	if (!digest_cache)
+		return -ENOENT;
+
 	/*
 	 * All allocations must be atomic (non-sleepable) since kprobe does not
 	 * allow otherwise (kprobe is needed for testing).
-- 
2.34.1


