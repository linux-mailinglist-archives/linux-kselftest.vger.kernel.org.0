Return-Path: <linux-kselftest+bounces-17261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FF96DD65
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7221C21015
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E91A070E;
	Thu,  5 Sep 2024 15:07:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C084A2F;
	Thu,  5 Sep 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548869; cv=none; b=NG4sXDtlDL5r/oJnHx7yI2U2dgIdeuqfPFbN0vJ6v4NSzJhX/k8glUC1xJPI1oA3Xl6um2g8GNb7uP1kxXYVMvEfql0m4PPw/M1dCxpJsT7EJFihuKDvNsRlu28YVkIqmxrzD0Lu6XMT3isn6T5JF20pY6FblqXozdJN1qPj0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548869; c=relaxed/simple;
	bh=6lpMHiZwFsdXCLmbmUpkhqTZ3pO3tetjpkHbtTN1dsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uexJh3KOGCUWX11W/XKB3Q0E33o+0GhZSpvvH4sH+Urn6P+PVBybGw3ebMoYGmi2JUx7qp3lBWmRYe4j4PdzOERPB92c+xZeM/Lc2RXltPmq797I/u6eBqIOnq/OccNmXpq7x6yO3yHlGpxonuIE4ZnigulHWSp3GXh5UUJAiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02C05qsMz9v7JT;
	Thu,  5 Sep 2024 22:42:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3916C140516;
	Thu,  5 Sep 2024 23:07:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S6;
	Thu, 05 Sep 2024 16:07:27 +0100 (CET)
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
Subject: [PATCH v5 04/14] digest_cache: Add securityfs interface
Date: Thu,  5 Sep 2024 17:05:33 +0200
Message-Id: <20240905150543.3766895-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S6
X-Coremail-Antispam: 1UD129KBjvJXoW3AryUXw4xXFyfuF4fWFWUtwb_yoW3tF1kpa
	9Ik3WUKr4xZFy3Cwn7A3W3CF1Fg390gF17Cws8Wry3Aay5uw1qva40yr1UZry5Xr4UZa4I
	yr4j9r1UZr4qqaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK2gAAsb

From: Roberto Sassu <roberto.sassu@huawei.com>

Create the digest_cache directory in <securityfs>/integrity, and add the
default_path file, to let root change/read the default path (file or
directory) from where digest lists are looked up.

An RW semaphore prevents the default path from changing while
digest_list_new() and read_default_path() are executed, so that those read
a stable value. Multiple digest_list_new() and read_default_path() calls,
instead, can be done in parallel, since they are the readers.

Changing the default path does not affect digest caches created with the
old path.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/Kconfig    |   4 +
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/internal.h |   4 +
 security/integrity/digest_cache/main.c     |  10 +-
 security/integrity/digest_cache/secfs.c    | 104 +++++++++++++++++++++
 security/integrity/ima/ima_fs.c            |   6 ++
 6 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/digest_cache/secfs.c

diff --git a/security/integrity/digest_cache/Kconfig b/security/integrity/digest_cache/Kconfig
index 5fbec491237b..6e61089acbe2 100644
--- a/security/integrity/digest_cache/Kconfig
+++ b/security/integrity/digest_cache/Kconfig
@@ -15,3 +15,7 @@ config DIGEST_LIST_DEFAULT_PATH
 	help
 	  Default path where the Integrity Digest Cache expects to find digest
 	  lists.
+
+	  It can be changed at run-time, by writing the new path to the
+	  securityfs interface. Digest caches created with the old path are
+	  not affected by the change.
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 6a3f7cc6e106..c351186d4e1e 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o
+digest_cache-y := main.o secfs.o
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index 54e118a2ef79..2fcfa9b4cf13 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -53,6 +53,7 @@ struct digest_cache_security {
 
 extern loff_t inode_sec_offset;
 extern char *default_path_str;
+extern struct rw_semaphore default_path_sem;
 
 static inline struct digest_cache_security *
 digest_cache_get_security(const struct inode *inode)
@@ -96,4 +97,7 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset);
 
+/* secfs.c */
+int __init digest_cache_secfs_init(struct dentry *dir);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 188f1dcc880e..0e25f573166a 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -20,6 +20,9 @@ loff_t inode_sec_offset;
 
 char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
 
+/* Protects default_path_str. */
+struct rw_semaphore default_path_sem;
+
 /**
  * digest_cache_alloc_init - Allocate and initialize a new digest cache
  * @path_str: Path string of the digest list
@@ -305,9 +308,12 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 
 	/* Serialize accesses to inode for which the digest cache is used. */
 	mutex_lock(&dig_sec->dig_user_mutex);
-	if (!dig_sec->dig_user)
+	if (!dig_sec->dig_user) {
+		down_read(&default_path_sem);
 		/* Consume extra reference from digest_cache_create(). */
 		dig_sec->dig_user = digest_cache_new(dentry);
+		up_read(&default_path_sem);
+	}
 
 	if (dig_sec->dig_user)
 		/* Increment ref. count for reference returned to the caller. */
@@ -404,6 +410,8 @@ static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset)
 {
+	init_rwsem(&default_path_sem);
+
 	inode_sec_offset = inode_offset;
 
 	digest_cache_cache = kmem_cache_create("digest_cache_cache",
diff --git a/security/integrity/digest_cache/secfs.c b/security/integrity/digest_cache/secfs.c
new file mode 100644
index 000000000000..3267b2a83430
--- /dev/null
+++ b/security/integrity/digest_cache/secfs.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the securityfs interface of the Integrity Digest Cache.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/security.h>
+
+#include "internal.h"
+
+static struct dentry *digest_cache_dir;
+static struct dentry *default_path_dentry;
+
+/**
+ * write_default_path - Write default path
+ * @file: File descriptor of the securityfs file
+ * @buf: User space buffer
+ * @datalen: Amount of data to write
+ * @ppos: Current position in the file
+ *
+ * This function sets the new default path where digest lists can be found.
+ * Can be either a regular file or a directory.
+ *
+ * Return: Length of path written on success, a POSIX error code otherwise.
+ */
+static ssize_t write_default_path(struct file *file, const char __user *buf,
+				  size_t datalen, loff_t *ppos)
+{
+	char *new_default_path_str;
+
+	new_default_path_str = memdup_user_nul(buf, datalen);
+	if (IS_ERR(new_default_path_str))
+		return PTR_ERR(new_default_path_str);
+
+	down_write(&default_path_sem);
+	kfree_const(default_path_str);
+	default_path_str = new_default_path_str;
+	up_write(&default_path_sem);
+	return datalen;
+}
+
+/**
+ * read_default_path - Read default path
+ * @file: File descriptor of the securityfs file
+ * @buf: User space buffer
+ * @datalen: Amount of data to read
+ * @ppos: Current position in the file
+ *
+ * This function returns the current default path where digest lists can be
+ * found. Can be either a regular file or a directory.
+ *
+ * Return: Length of path read on success, a POSIX error code otherwise.
+ */
+static ssize_t read_default_path(struct file *file, char __user *buf,
+				 size_t datalen, loff_t *ppos)
+{
+	int ret;
+
+	down_read(&default_path_sem);
+	ret = simple_read_from_buffer(buf, datalen, ppos, default_path_str,
+				      strlen(default_path_str) + 1);
+	up_read(&default_path_sem);
+	return ret;
+}
+
+static const struct file_operations default_path_ops = {
+	.open = generic_file_open,
+	.write = write_default_path,
+	.read = read_default_path,
+	.llseek = generic_file_llseek,
+};
+
+/**
+ * digest_cache_secfs_init - Initialize the securityfs interface
+ * @dir: Directory entry provided by the calling LSM
+ *
+ * This function initialize the securityfs interfaces, for configuration
+ * by user space.
+ *
+ * Initialize 'default_path', allowing user space to change the default
+ * directory where digest lists are searched.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int __init digest_cache_secfs_init(struct dentry *dir)
+{
+	digest_cache_dir = securityfs_create_dir("digest_cache", dir);
+	if (IS_ERR(digest_cache_dir))
+		return PTR_ERR(digest_cache_dir);
+
+	default_path_dentry = securityfs_create_file("default_path", 0660,
+						     digest_cache_dir, NULL,
+						     &default_path_ops);
+	if (IS_ERR(default_path_dentry)) {
+		securityfs_remove(digest_cache_dir);
+		return PTR_ERR(default_path_dentry);
+	}
+
+	return 0;
+}
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e4a79a9b2d58..be9e374e2cef 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -614,6 +614,12 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	if (IS_ENABLED(CONFIG_INTEGRITY_DIGEST_CACHE)) {
+		ret = digest_cache_secfs_init(integrity_dir);
+		if (ret < 0)
+			goto out;
+	}
+
 	return 0;
 out:
 	securityfs_remove(ima_policy);
-- 
2.34.1


