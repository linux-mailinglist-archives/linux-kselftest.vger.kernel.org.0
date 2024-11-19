Return-Path: <linux-kselftest+bounces-22254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4637F9D23EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA2E1F22D70
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164071C4A29;
	Tue, 19 Nov 2024 10:51:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9A1B85D4;
	Tue, 19 Nov 2024 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013501; cv=none; b=rz5t1J4FFitWQZanHoq7NqeqBUun35MGe1PWwD/lGmNaNne0PJ0Axi8WPOOiq9zxXC0sUZa4LRCxZSvMEgMLHZN7nLRCLYc3BQ/7HkR3zsYb6OfiaRMAVc31oS7hH49n4hnPLMF0wIRqvWjczhzewMlm4vYjlodoYXE1nD0eaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013501; c=relaxed/simple;
	bh=02qP0PKT6+/1YNFR42mP6rJ6NfXseYre8sCd3S/thpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXER2dV9n8X9kCXZ3fxoYBR1X5mXVlnunzebNqWkru6ykxv8VhhBTLEcljlHEHqcB/U1ErUU0MuK0CO+v8QciCP40t2MqfLd6Mbn/k1nZJVXD3fwqevHZanXg6s7BKKPqdzSfL0jiVQO8d/mVY8R6E/nS+f2lXzHxhhyM5CNcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt0wT3dmRz9v7JN;
	Tue, 19 Nov 2024 18:24:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 84A9B140ABD;
	Tue, 19 Nov 2024 18:51:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S7;
	Tue, 19 Nov 2024 11:51:30 +0100 (CET)
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
Subject: [PATCH v6 05/15] digest_cache: Add securityfs interface
Date: Tue, 19 Nov 2024 11:49:12 +0100
Message-ID: <20241119104922.2772571-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S7
X-Coremail-Antispam: 1UD129KBjvJXoW3AryUWr1Utw13XFy8Jw48tFb_yoW3Kry8p3
	9xK3WUKr4fZFy3Cwn7A3W3CF1rK390gr1UCws8Wry3Aay5uwn0va40yr1UZry5Xr4UZFyx
	tw4jvr1UZr4qqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
	v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUsCztUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEhgAAsR

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
index 81f9d4ae749f..a4bfa8287b8d 100644
--- a/security/integrity/digest_cache/Kconfig
+++ b/security/integrity/digest_cache/Kconfig
@@ -17,3 +17,7 @@ config DIGEST_LIST_DEFAULT_PATH
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
index 29bf98a974f3..82d9c894c8fc 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -52,6 +52,7 @@ struct digest_cache_security {
 extern loff_t inode_sec_offset;
 extern loff_t file_sec_offset;
 extern char *default_path_str;
+extern struct rw_semaphore default_path_sem;
 
 static inline struct digest_cache_security *
 digest_cache_get_security_from_blob(void *inode_security)
@@ -121,4 +122,7 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset, loff_t file_offset);
 
+/* secfs.c */
+int __init digest_cache_secfs_init(struct dentry *dir);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 6e94cff2b0dc..6724471914da 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -21,6 +21,9 @@ loff_t file_sec_offset;
 
 char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
 
+/* Protects default_path_str. */
+struct rw_semaphore default_path_sem;
+
 /**
  * digest_cache_alloc_init - Allocate and initialize a new digest cache
  * @path_str: Path string of the digest list
@@ -321,9 +324,12 @@ struct digest_cache *digest_cache_get(struct file *file)
 
 	/* Serialize accesses to inode for which the digest cache is used. */
 	mutex_lock(&dig_sec->dig_user_mutex);
-	if (!dig_sec->dig_user)
+	if (!dig_sec->dig_user) {
+		down_read(&default_path_sem);
 		/* Consume extra reference from digest_cache_create(). */
 		dig_sec->dig_user = digest_cache_new(dentry, &digest_list_path);
+		up_read(&default_path_sem);
+	}
 
 	if (dig_sec->dig_user)
 		/* Increment ref. count for reference returned to the caller. */
@@ -439,6 +445,8 @@ static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset, loff_t file_offset)
 {
+	init_rwsem(&default_path_sem);
+
 	inode_sec_offset = inode_offset;
 	file_sec_offset = file_offset;
 
diff --git a/security/integrity/digest_cache/secfs.c b/security/integrity/digest_cache/secfs.c
new file mode 100644
index 000000000000..f158233f3492
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
+ * This function initializes the securityfs interfaces, for configuration
+ * by user space.
+ *
+ * It creates 'default_path', allowing user space to change the default
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
2.47.0.118.gfd3785337b


