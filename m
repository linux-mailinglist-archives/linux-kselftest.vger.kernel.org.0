Return-Path: <linux-kselftest+bounces-22262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE59D243D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F245328793D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851D1C8306;
	Tue, 19 Nov 2024 10:55:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E513AD03;
	Tue, 19 Nov 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013713; cv=none; b=QSnrwMnjnPlRJBKRZWKI+UGj1NNXe4tKeWCMuE3+z7E6Btf4GREIstOq7nxRAJk+TVUIBvjiNgF0G1DSUujgxVMdd7LcPm+rYazMKexB9VKVqaivyq9p+7eG968q9EUR7jvhyk5t4HDi53XjdoV/RnnzbYs9nTMRJGifkCEGwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013713; c=relaxed/simple;
	bh=S1hQRVhc5WMSpd3hwuS7vPiVTsvn9Zl1TZ6nrMGjBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWF+p6472rjaacg0441HLYjEs0cmzpiSC1x5rWDxGKpz7lZOn28GA431xtaPi658rZD5s5Gu1WWS52VEHXml5w80dCfij8KrPcFAdEp//KYXZFacLQeOSk0TaF7cACndyc2cIPFjEVOkAEwaUNeiu2tRQx4PWIEoVd7ONslMcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt17p4x6Rz9v7J6;
	Tue, 19 Nov 2024 18:34:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7B791140F4E;
	Tue, 19 Nov 2024 18:55:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHsyNDbjxnj1znAQ--.1193S5;
	Tue, 19 Nov 2024 11:55:02 +0100 (CET)
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
Subject: [PATCH v6 13/15] digest_cache: Reset digest cache on file/directory change
Date: Tue, 19 Nov 2024 11:49:20 +0100
Message-ID: <20241119104922.2772571-14-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHsyNDbjxnj1znAQ--.1193S5
X-Coremail-Antispam: 1UD129KBjvAXoW3tF17Ww43WF4xKF17Gr15Arb_yoW8WF47uo
	ZYvanrJw18WFy5ZFs8C3W7Aa4UuaySg34fArykWrZ8Z3WIvFyUJasrC3WDJFy5Xr18Wr97
	A3s7X3y8XFWUtr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO07kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxU
	V6pBDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEhAABsX

From: Roberto Sassu <roberto.sassu@huawei.com>

Register six new LSM hooks on behalf of the IMA LSM, path_truncate,
file_release, inode_unlink, inode_rename, inode_post_setxattr and
inode_post_removexattr, to monitor digest lists/parent directory
modifications.

If an action affects a digest list or the parent directory, the new LSM
hook implementations call digest_cache_reset_clear_owner() to set the RESET
bit on the digest cache referenced by dig_owner in the inode security blob,
and to put and clear dig_owner itself. This will also cause next calls to
digest_cache_get() and digest_cache_dir_lookup_digest() to replace
respectively dig_user and the directory entry digest cache.

If an action affects a file using a digest cache, the new LSM hook
implementations call digest_cache_clear_user() to clear dig_user in the
inode security blob. This will also cause next calls to digest_cache_get()
to obtain a new digest cache, based on the updated location.

Recreating a file digest cache means reading the digest list again and
extracting the digests. Recreating a directory digest cache, instead, does
not mean recreating the digest cache for existing directory entries, since
those digest caches are likely already stored in the inode security blob.
It would happen however for new directory entries.

Dig_owner reset and clear for file/directory digest caches is done on
path_truncate, when a digest list is truncated (there is no inode_truncate,
file_truncate does not catch operations through the truncate() system
call), file_release, when a digest list opened for write or created is
being closed, inode_unlink, when a digest list is removed, and inode_rename
when a digest list or the directory itself are renamed.

Directory digest caches are reset even if the current operation involves a
file, since that operation might affect the result of the lookup done
through them. For example, if one wants to know whether a digest is found
or not in a directory, adding a new digest list to that directory could
change the result.

Dig_user clear is always done on inode_post_setxattr and
inode_post_removexattr, when the security.digest_list xattr is respectively
set or removed from a file using a digest cache.

Callers of digest_cache_get() can still keep a digest cache after reset,
since the reference count remains greater than zero even if dig_owner and
dig_user are cleared. However, digest_cache_lookup() will notify the
callers that a reset happened through an error pointer. Callers need to
obtain a fresh digest cache with digest_cache_get() and repeat the lookup
again.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/dir.c      |   6 +
 security/integrity/digest_cache/htable.c   |   6 +-
 security/integrity/digest_cache/internal.h |  13 ++
 security/integrity/digest_cache/main.c     |  12 ++
 security/integrity/digest_cache/reset.c    | 227 +++++++++++++++++++++
 6 files changed, 264 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/digest_cache/reset.c

diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index d07ac2483504..f8afb85407a0 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -6,6 +6,6 @@ obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 obj-$(CONFIG_DIGEST_CACHE_TLV_PARSER) += parsers/tlv.o
 
 digest_cache-y := main.o secfs.o htable.o parsers.o populate.o modsig.o \
-		  verif.o dir.o
+		  verif.o dir.o reset.o
 
 CFLAGS_parsers.o += -DPARSERS_DIR=\"$(MODLIB)/kernel/security/integrity/digest_cache/parsers\"
diff --git a/security/integrity/digest_cache/dir.c b/security/integrity/digest_cache/dir.c
index a292a9c25119..d4fd5b5ef8fa 100644
--- a/security/integrity/digest_cache/dir.c
+++ b/security/integrity/digest_cache/dir.c
@@ -206,6 +206,12 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
 
 	list_for_each_entry(dir_entry, &dir_cache->dir_entries, list) {
 		mutex_lock(&dir_entry->digest_cache_mutex);
+		if (dir_entry->digest_cache &&
+		    test_bit(RESET, &dir_entry->digest_cache->flags)) {
+			digest_cache_put(dir_entry->digest_cache);
+			dir_entry->digest_cache = NULL;
+		}
+
 		if (!dir_entry->digest_cache) {
 			digest_list_path.dentry = NULL;
 			digest_list_path.mnt = NULL;
diff --git a/security/integrity/digest_cache/htable.c b/security/integrity/digest_cache/htable.c
index a01e24d7f198..349aebf91360 100644
--- a/security/integrity/digest_cache/htable.c
+++ b/security/integrity/digest_cache/htable.c
@@ -203,7 +203,8 @@ EXPORT_SYMBOL_GPL(digest_cache_htable_lookup);
  * passed digest cache, obtained with digest_cache_get().
  *
  * Return: A digest cache reference if the digest is found, NULL if not, an
- *         error pointer if dir digest cache changed since last get.
+ *         error pointer if dir digest cache changed since last get, or digest
+ *         cache was reset.
  */
 struct digest_cache *digest_cache_lookup(struct dentry *dentry,
 					 struct digest_cache *digest_cache,
@@ -211,6 +212,9 @@ struct digest_cache *digest_cache_lookup(struct dentry *dentry,
 {
 	int ret;
 
+	if (test_bit(RESET, &digest_cache->flags))
+		return ERR_PTR(-EAGAIN);
+
 	if (test_bit(IS_DIR, &digest_cache->flags))
 		return digest_cache_dir_lookup_digest(dentry, digest_cache,
 						      digest, algo);
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index 5af7f6e7bdf6..75f8b118c3db 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -21,6 +21,7 @@
 #define DIR_PREFETCH		4	/* Prefetch enabled for dir. */
 #define FILE_PREFETCH		5	/* Prefetch enabled for dir entry. */
 #define FILE_READ		6	/* Digest cache for reading file. */
+#define RESET			7	/* Digest cache to be recreated. */
 
 /**
  * struct readdir_callback - Structure to store information for dir iteration
@@ -267,4 +268,16 @@ int digest_cache_dir_prefetch(struct dentry *dentry,
 			      struct digest_cache *digest_cache);
 void digest_cache_dir_free(struct digest_cache *digest_cache);
 
+/* reset.c */
+int digest_cache_path_truncate(const struct path *path);
+void digest_cache_file_release(struct file *file);
+int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry);
+int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
+			      struct inode *new_dir, struct dentry *new_dentry);
+void digest_cache_inode_post_setxattr(struct dentry *dentry, const char *name,
+				      const void *value, size_t size,
+				      int flags);
+void digest_cache_inode_post_removexattr(struct dentry *dentry,
+					 const char *name);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index ca1f0bc8ec94..0a167c82e308 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -436,6 +436,11 @@ struct digest_cache *digest_cache_get(struct file *file)
 
 	/* Serialize accesses to inode for which the digest cache is used. */
 	mutex_lock(&dig_sec->dig_user_mutex);
+	if (dig_sec->dig_user && test_bit(RESET, &dig_sec->dig_user->flags)) {
+		digest_cache_put(dig_sec->dig_user);
+		dig_sec->dig_user = NULL;
+	}
+
 	if (!dig_sec->dig_user) {
 		down_read(&default_path_sem);
 		/* Consume extra reference from digest_cache_create(). */
@@ -553,6 +558,13 @@ static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security_rcu,
 		      digest_cache_inode_free_security_rcu),
+	LSM_HOOK_INIT(path_truncate, digest_cache_path_truncate),
+	LSM_HOOK_INIT(file_release, digest_cache_file_release),
+	LSM_HOOK_INIT(inode_unlink, digest_cache_inode_unlink),
+	LSM_HOOK_INIT(inode_rename, digest_cache_inode_rename),
+	LSM_HOOK_INIT(inode_post_setxattr, digest_cache_inode_post_setxattr),
+	LSM_HOOK_INIT(inode_post_removexattr,
+		      digest_cache_inode_post_removexattr),
 };
 
 /**
diff --git a/security/integrity/digest_cache/reset.c b/security/integrity/digest_cache/reset.c
new file mode 100644
index 000000000000..003c8ee96d72
--- /dev/null
+++ b/security/integrity/digest_cache/reset.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Reset digest cache on digest lists/directory modifications.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include "internal.h"
+
+/**
+ * digest_cache_reset_clear_owner - Reset and clear dig_owner
+ * @inode: Inode of the digest list/directory containing the digest list
+ * @reason: Reason for reset and clear
+ *
+ * This function sets the RESET bit of the digest cache referenced by dig_owner
+ * of the passed inode, and puts and clears dig_owner.
+ *
+ * The next time they are called, digest_cache_get() and
+ * digest_cache_dir_lookup_digest() replace respectively dig_user and the digest
+ * cache of the directory entry.
+ */
+static void digest_cache_reset_clear_owner(struct inode *inode,
+					   const char *reason)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return;
+
+	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner) {
+		pr_debug("Resetting and clearing %s (dig_owner), reason: %s\n",
+			 dig_sec->dig_owner->path_str, reason);
+		set_bit(RESET, &dig_sec->dig_owner->flags);
+		digest_cache_put(dig_sec->dig_owner);
+		dig_sec->dig_owner = NULL;
+	}
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+}
+
+/**
+ * digest_cache_clear_user - Clear dig_user
+ * @inode: Inode of the file using the digest cache
+ * @filename: File name of the affected inode
+ * @reason: Reason for clear
+ *
+ * This function clears dig_user in the inode security blob, so that
+ * digest_cache_get() requests a new digest cache based on the updated digest
+ * list location.
+ */
+static void digest_cache_clear_user(struct inode *inode, const char *filename,
+				    const char *reason)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return;
+
+	mutex_lock(&dig_sec->dig_user_mutex);
+	if (dig_sec->dig_user && !test_bit(RESET, &dig_sec->dig_user->flags)) {
+		pr_debug("Clearing %s (dig_user of %s), reason: %s\n",
+			 dig_sec->dig_user->path_str, filename, reason);
+		digest_cache_put(dig_sec->dig_user);
+		dig_sec->dig_user = NULL;
+	}
+	mutex_unlock(&dig_sec->dig_user_mutex);
+}
+
+/**
+ * digest_cache_path_truncate - A file is being truncated
+ * @path: File path
+ *
+ * This function is called when a file is being truncated. If the inode is a
+ * digest list and/or the parent is a directory containing digest lists, it
+ * resets the inode and/or directory dig_owner, to force rebuilding the digest
+ * cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_path_truncate(const struct path *path)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *dir = d_backing_inode(path->dentry->d_parent);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	digest_cache_reset_clear_owner(inode, "path_truncate(file)");
+	digest_cache_reset_clear_owner(dir, "path_truncate(dir)");
+	return 0;
+}
+
+/**
+ * digest_cache_file_release - Last reference of a file desc is being released
+ * @file: File descriptor
+ *
+ * This function is called when the last reference of a file descriptor is
+ * being released. If the inode is a regular file and was opened for write or
+ * was created, it resets the inode and the parent directory dig_owner, to
+ * force rebuilding the digest caches.
+ */
+void digest_cache_file_release(struct file *file)
+{
+	struct inode *dir = d_backing_inode(file_dentry(file)->d_parent);
+
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+	    ((!(file->f_mode & FMODE_WRITE)) &&
+	      !(file->f_mode & FMODE_CREATED)))
+		return;
+
+	digest_cache_reset_clear_owner(file_inode(file), "file_release(file)");
+	digest_cache_reset_clear_owner(dir, "file_release(dir)");
+}
+
+/**
+ * digest_cache_inode_unlink - An inode is being removed
+ * @dir: Inode of the affected directory
+ * @dentry: Dentry of the inode being removed
+ *
+ * This function is called when an existing inode is being removed. If the
+ * inode is a digest list/digest list directory, or the parent inode is the
+ * digest list directory and the inode is a regular file, it resets the
+ * affected inode dig_owner, to force rebuilding the digest cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return 0;
+
+	digest_cache_reset_clear_owner(inode, S_ISREG(inode->i_mode) ?
+				       "inode_unlink(file)" :
+				       "inode_unlink(dir)");
+
+	if (S_ISREG(inode->i_mode))
+		digest_cache_reset_clear_owner(dir, "inode_unlink(dir)");
+
+	return 0;
+}
+
+/**
+ * digest_cache_inode_rename - An inode is being renamed
+ * @old_dir: Inode of the directory containing the inode being renamed
+ * @old_dentry: Dentry of the inode being renamed
+ * @new_dir: Directory where the inode will be placed into
+ * @new_dentry: Dentry of the inode after being renamed
+ *
+ * This function is called when an existing inode is being moved from a
+ * directory to another (rename). If the inode is a digest list or the digest
+ * list directory, or that inode is a digest list moved from/to the digest list
+ * directory, it resets the affected inode dig_owner, to force rebuilding the
+ * digest cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
+			      struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *old_inode = d_backing_inode(old_dentry);
+
+	if (!S_ISREG(old_inode->i_mode) && !S_ISDIR(old_inode->i_mode))
+		return 0;
+
+	digest_cache_reset_clear_owner(old_inode, S_ISREG(old_inode->i_mode) ?
+				       "inode_rename(file)" :
+				       "inode_rename(dir)");
+
+	if (S_ISREG(old_inode->i_mode)) {
+		digest_cache_reset_clear_owner(old_dir,
+					       "inode_rename(from_dir)");
+		digest_cache_reset_clear_owner(new_dir,
+					       "inode_rename(to_dir)");
+	}
+
+	return 0;
+}
+
+/**
+ * digest_cache_inode_post_setxattr - An xattr was set
+ * @dentry: File
+ * @name: Xattr name
+ * @value: Xattr value
+ * @size: Size of xattr value
+ * @flags: Flags
+ *
+ * This function is called after an xattr was set on an existing inode. If the
+ * inode points to a digest cache and the xattr set is security.digest_list, it
+ * puts and clears dig_user in the inode security blob, to force retrieving a
+ * fresh digest cache.
+ */
+void digest_cache_inode_post_setxattr(struct dentry *dentry, const char *name,
+				      const void *value, size_t size, int flags)
+{
+	if (strcmp(name, XATTR_NAME_DIGEST_LIST))
+		return;
+
+	digest_cache_clear_user(d_backing_inode(dentry), dentry->d_name.name,
+				"inode_post_setxattr");
+}
+
+/**
+ * digest_cache_inode_post_removexattr - An xattr was removed
+ * @dentry: File
+ * @name: Xattr name
+ *
+ * This function is called after an xattr was removed from an existing inode.
+ * If the inode points to a digest cache and the xattr removed is
+ * security.digest_list, it puts and clears dig_user in the inode security
+ * blob, to force retrieving a fresh digest cache.
+ */
+void digest_cache_inode_post_removexattr(struct dentry *dentry,
+					 const char *name)
+{
+	if (strcmp(name, XATTR_NAME_DIGEST_LIST))
+		return;
+
+	digest_cache_clear_user(d_backing_inode(dentry), dentry->d_name.name,
+				"inode_post_removexattr");
+}
-- 
2.47.0.118.gfd3785337b


