Return-Path: <linux-kselftest+bounces-4444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3884F6E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1471C1C23CD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EC69D25;
	Fri,  9 Feb 2024 14:13:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF469D23;
	Fri,  9 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488013; cv=none; b=RW8SbizIK24ek8dkJtDTakJ/7F8qOptM8UEuQQKMUsD2+uV7hMI9NpOw1AKcoQOaVvOBzjNe0zUkLpnPwbEl4swbFMlN61rY81yxH3hcrYeMSobEJos8l+URSfzmyIqVB4Jo8rUBR7K9DHbgVhsvacm/XKkc1A5f6bEmS3uNGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488013; c=relaxed/simple;
	bh=sxG1qj6ZRW9AqSqo0SFNqKoBtRwSYTjvRUbjZeoJmlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIfYBhN86usqIxzCm/FvHquTXNtYwyxqs7P6efmjyHOS0GgyQeD/tcsD9lA9PBSuRqMkTSQzGhVZWW6JLKb5b8AOe4lMUhusprHNI6rhRnbLtorXkEwmdHhkQ5FRvyHUPf3OVoqylgoEJBvoYBMsjECZukuOZvpcY5duHoA5AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TWb6M6FHHz9yB7b;
	Fri,  9 Feb 2024 21:58:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5E2F11406BF;
	Fri,  9 Feb 2024 22:13:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCThMsZloMgpAg--.31110S3;
	Fri, 09 Feb 2024 15:13:17 +0100 (CET)
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
Subject: [PATCH v3 11/13] digest_cache: Reset digest cache on file/directory change
Date: Fri,  9 Feb 2024 15:09:15 +0100
Message-Id: <20240209140917.846878-12-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoCThMsZloMgpAg--.31110S3
X-Coremail-Antispam: 1UD129KBjvAXoW3ur1rZFyfXr1UWryxXF4UCFg_yoW8JFWfCo
	ZYvFsrXw18WFy5ZFs5CF17Aa9ru3yFgw1xArykGFW5ZF10vryUG3ZrC3WDJFy5Jr18Gr97
	A34kX3y8JFWUtr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOx7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnI
	WIevJa73UjIFyTuYvjfUUYL9UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y4hgAAsX

From: Roberto Sassu <roberto.sassu@huawei.com>

Register five new LSM hooks, file_open, path_truncate, file_release,
inode_unlink and inode_rename, to monitor digest lists/directory
modifications.

If an action affects a digest list or the parent directory, the new LSM
hook implementations call digest_cache_reset() to set the RESET bit on the
digest cache. This will cause next calls to digest_cache_get() and
digest_cache_create() to respectively put and clear dig_user and dig_owner,
and request a new digest cache.

That does not affect other users of the old digest cache, since that one
remains valid as long as the reference count is greater than zero. However,
they can explicitly call the new function digest_cache_was_reset(), to
check if the RESET bit was set on the digest cache reference they hold.

Recreating a file digest cache means reading the digest list again and
extracting the digests. Recreating a directory digest cache, instead, does
not mean recreating the digest cache for directory entries, since those
digest caches are likely already stored in the inode security blob. It
would happen however for new files.

File digest cache reset is done on file_open, when a digest list is opened
for write, path_truncate, when a digest list is truncated (there is no
inode_truncate, file_truncate does not catch operations through the
truncate() system call), inode_unlink, when a digest list is removed, and
inode_rename when a digest list is renamed.

Directory digest cache reset is done on file_release, when a digest list is
written in the digest list directory, on inode_unlink, when a digest list
is deleted from that directory, and finally on inode_rename, when a digest
list is moved to/from that directory.

With the exception of file_release, which will always be executed (cannot
be denied), the other LSM hooks are not optimal, since the digest_cache LSM
does not know whether or not the operation will be allowed also by other
LSMs. If the operation is denied, the digest_cache LSM would do an
unnecessary reset.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h     |   6 ++
 security/digest_cache/Kconfig    |   1 +
 security/digest_cache/Makefile   |   3 +-
 security/digest_cache/internal.h |   9 ++
 security/digest_cache/main.c     |  15 +++
 security/digest_cache/reset.c    | 168 +++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 security/digest_cache/reset.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 9db8128513ca..db3052c71b7a 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -48,6 +48,7 @@ int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
 			   size_t size);
 void *digest_cache_verif_get(struct digest_cache *digest_cache,
 			     const char *verif_id);
+bool digest_cache_was_reset(struct digest_cache *digest_cache);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -79,5 +80,10 @@ static inline void *digest_cache_verif_get(struct digest_cache *digest_cache,
 	return NULL;
 }
 
+static inline bool digest_cache_was_reset(struct digest_cache *digest_cache)
+{
+	return false;
+}
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
index dc9ed8f0f883..cd397eb64140 100644
--- a/security/digest_cache/Kconfig
+++ b/security/digest_cache/Kconfig
@@ -2,6 +2,7 @@
 config SECURITY_DIGEST_CACHE
 	bool "Digest_cache LSM"
 	select TLV_PARSER
+	select SECURITY_PATH
 	default n
 	help
 	   This option enables an LSM maintaining a cache of digests
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index e417da0383ab..3d5e600a2c45 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,7 +4,8 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o dir.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o dir.o \
+		  reset.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index bbef5ab83107..0517e648fbb7 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -18,6 +18,7 @@
 #define INVALID			1	/* Digest cache marked as invalid. */
 #define IS_DIR			2	/* Digest cache created from dir. */
 #define DIR_PREFETCH		3	/* Prefetching requested for dir. */
+#define RESET			4	/* Digest cache to be recreated. */
 
 /**
  * struct readdir_callback - Structure to store information for dir iteration
@@ -247,4 +248,12 @@ digest_cache_dir_lookup_filename(struct dentry *dentry,
 				 char *filename);
 void digest_cache_dir_free(struct digest_cache *digest_cache);
 
+/* reset.c */
+int digest_cache_file_open(struct file *file);
+int digest_cache_path_truncate(const struct path *path);
+void digest_cache_file_release(struct file *file);
+int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry);
+int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
+			      struct inode *new_dir, struct dentry *new_dentry);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index e6598f81074a..b192628e30db 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -162,6 +162,11 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 
 	/* Serialize check and assignment of dig_owner. */
 	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner && test_bit(RESET, &dig_sec->dig_owner->flags)) {
+		digest_cache_put(dig_sec->dig_owner);
+		dig_sec->dig_owner = NULL;
+	}
+
 	if (dig_sec->dig_owner) {
 		/* Increment ref. count for reference returned to the caller. */
 		digest_cache = digest_cache_ref(dig_sec->dig_owner);
@@ -394,6 +399,11 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 
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
@@ -482,6 +492,11 @@ static void digest_cache_inode_free_security(struct inode *inode)
 static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
+	LSM_HOOK_INIT(file_open, digest_cache_file_open),
+	LSM_HOOK_INIT(path_truncate, digest_cache_path_truncate),
+	LSM_HOOK_INIT(file_release, digest_cache_file_release),
+	LSM_HOOK_INIT(inode_unlink, digest_cache_inode_unlink),
+	LSM_HOOK_INIT(inode_rename, digest_cache_inode_rename),
 };
 
 /**
diff --git a/security/digest_cache/reset.c b/security/digest_cache/reset.c
new file mode 100644
index 000000000000..b4968ac993f0
--- /dev/null
+++ b/security/digest_cache/reset.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Reset digest cache on digest lists/directory modifications.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include "internal.h"
+
+/**
+ * digest_cache_was_reset - Report whether or not the digest cache was reset
+ * @digest_cache: Digest cache
+ *
+ * This function reports whether or not the RESET bit was set in the digest
+ * cache.
+ *
+ * It is meant to be used by digest_cache LSM users holding a reference of a
+ * digest cache, which might need to take additional actions depending on
+ * whether or not that digest cache was reset.
+ *
+ * Return: True if the digest cache was reset, false otherwise.
+ */
+bool digest_cache_was_reset(struct digest_cache *digest_cache)
+{
+	return test_bit(RESET, &digest_cache->flags);
+}
+EXPORT_SYMBOL_GPL(digest_cache_was_reset);
+
+/**
+ * digest_cache_reset - Reset the digest cache
+ * @inode: Inode of the digest list/directory containing the digest list
+ * @reason: Reason for reset
+ *
+ * This function sets the RESET bit in the digest cache, so that
+ * digest_cache_get() and digest_cache_create() respectively release and clear
+ * dig_user and dig_owner in the inode security blob. This causes new callers
+ * of digest_cache_get() to get a new digest cache.
+ */
+static void digest_cache_reset(struct inode *inode, const char *reason)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		return;
+
+	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner) {
+		pr_debug("Resetting %s, reason: %s\n",
+			 dig_sec->dig_owner->path_str, reason);
+		set_bit(RESET, &dig_sec->dig_owner->flags);
+	}
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+}
+
+/**
+ * digest_cache_file_open - A file is being opened
+ * @file: File descriptor
+ *
+ * This function is called when a file is opened. If the inode is a digest list
+ * and is opened for write, it resets the inode dig_owner, to force rebuilding
+ * the digest cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_file_open(struct file *file)
+{
+	if (!S_ISREG(file_inode(file)->i_mode) || !(file->f_mode & FMODE_WRITE))
+		return 0;
+
+	digest_cache_reset(file_inode(file), "file_open_write");
+	return 0;
+}
+
+/**
+ * digest_cache_path_truncate - A file is being truncated
+ * @path: File path
+ *
+ * This function is called when a file is being truncated. If the inode is a
+ * digest list, it resets the inode dig_owner, to force rebuilding the digest
+ * cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_path_truncate(const struct path *path)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	digest_cache_reset(inode, "file_truncate");
+	return 0;
+}
+
+/**
+ * digest_cache_file_release - Last reference of a file desc is being released
+ * @file: File descriptor
+ *
+ * This function is called when the last reference of a file descriptor is
+ * being released. If the parent inode is the digest list directory, the inode
+ * is a regular file and was opened for write, it resets the inode dig_owner,
+ * to force rebuilding the digest cache.
+ */
+void digest_cache_file_release(struct file *file)
+{
+	struct inode *dir = d_backing_inode(file_dentry(file)->d_parent);
+
+	if (!S_ISREG(file_inode(file)->i_mode) || !(file->f_mode & FMODE_WRITE))
+		return;
+
+	digest_cache_reset(dir, "dir_file_release");
+}
+
+/**
+ * digest_cache_inode_unlink - An inode is being removed
+ * @dir: Inode of the affected directory
+ * @dentry: Dentry of the inode being removed
+ *
+ * This function is called when an existing inode is being removed. If the
+ * inode is a digest list, or the parent inode is the digest list directory and
+ * the inode is a regular file, it resets the affected inode dig_owner, to force
+ * rebuilding the digest cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	digest_cache_reset(inode, "file_unlink");
+	digest_cache_reset(dir, "dir_unlink");
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
+ * directory to another (rename). If the inode is a digest list, or that inode
+ * is moved from/to the digest list directory, it resets the affected inode
+ * dig_owner, to force rebuilding the digest cache.
+ *
+ * Return: Zero.
+ */
+int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
+			      struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *old_inode = d_backing_inode(old_dentry);
+
+	if (!S_ISREG(old_inode->i_mode))
+		return 0;
+
+	digest_cache_reset(old_inode, "file_rename");
+	digest_cache_reset(old_dir, "dir_rename_from");
+	digest_cache_reset(new_dir, "dir_rename_to");
+	return 0;
+}
-- 
2.34.1


