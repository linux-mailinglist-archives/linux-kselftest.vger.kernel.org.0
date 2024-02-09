Return-Path: <linux-kselftest+bounces-4435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9D84F6A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9576E281220
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB967E86;
	Fri,  9 Feb 2024 14:10:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1545664A2;
	Fri,  9 Feb 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487839; cv=none; b=PN3dSt5ImNM3PCeti2kNkQSqysGjfru50Y6iPv8Ufn3L7/Bc6sgA+KFG7R4o6fVwsw5qlqQQk0sCQI2QYqEIFyLX12iaMs4lLVVxOZKj5P1ugGhzZh0LNZ8O6f/T2MT0/IWEcjZ23Cqs3bBkFfdzeAu34Abq8+eXXlicFnQxS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487839; c=relaxed/simple;
	bh=IFWDwU8ikkRBvK1oE1qM6gJFhgzGoyM1GZH2FBTntR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/vLe8uYPI0xKOFlIF/7mKNAaCPOCPo76SeZaJmnaeQCXtlcTLf5m5GYD1B1st/2t5uMI51cUXiflu9NjzVPVaTRCJ7rvMNfymVAqL6FNUhxWPenGi7zmvnLQvubZufSzTwFwRoyYXvY7kMUwCWKa5KELRIVfsN2WMq6WkMjsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TWb326rCJz9yBkR;
	Fri,  9 Feb 2024 21:55:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 78ED21405F9;
	Fri,  9 Feb 2024 22:10:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S5;
	Fri, 09 Feb 2024 15:10:25 +0100 (CET)
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
Subject: [PATCH v3 03/13] digest_cache: Add securityfs interface
Date: Fri,  9 Feb 2024 15:09:07 +0100
Message-Id: <20240209140917.846878-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Zw18Xw15Kr1DWryrtFb_yoWxWF4fp3
	9Ik3WUKr4xZF13Awn3A3W7CF1rK398tF47Cr4DW343AFW3Wwn0va4Iyr1UZryUXr4UZa4I
	yw4jkr15Xr4qqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5o4DAAAsS

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the digest_cache_path file in securityfs, to let root change/read the
default path (file or directory) from where digest lists are looked up.

An RW semaphore prevents the default path from changing while
digest_list_new() and read_default_path() are executed, so that those read
a stable value. Multiple digest_list_new() and read_default_path() calls,
instead, can be done in parallel, since they are the readers.

Changing the default path does not affect digest caches created with the
old path.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/digest_cache/Kconfig    |  4 ++
 security/digest_cache/Makefile   |  2 +-
 security/digest_cache/internal.h |  1 +
 security/digest_cache/main.c     | 10 +++-
 security/digest_cache/secfs.c    | 87 ++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 security/digest_cache/secfs.c

diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
index 0c47d5151f07..2f361c7844df 100644
--- a/security/digest_cache/Kconfig
+++ b/security/digest_cache/Kconfig
@@ -15,3 +15,7 @@ config DIGEST_LIST_DEFAULT_PATH
 	help
 	   Default directory where digest_cache LSM expects to find digest
 	   lists.
+
+	   It can be changed at run-time, by writing the new path to the
+	   securityfs interface. Digest caches created with the old path are
+	   not affected by the change.
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index 48848c41253e..1330655e33b1 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o
+digest_cache-y := main.o secfs.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index 5f04844af3a5..bbf5eefe5c82 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -49,6 +49,7 @@ struct digest_cache_security {
 
 extern struct lsm_blob_sizes digest_cache_blob_sizes;
 extern char *default_path_str;
+extern struct rw_semaphore default_path_sem;
 
 static inline struct digest_cache_security *
 digest_cache_get_security(const struct inode *inode)
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index 166798e6247e..8bae2e91ac4c 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -18,6 +18,9 @@ static struct kmem_cache *digest_cache_cache __read_mostly;
 
 char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
 
+/* Protects default_path_str. */
+struct rw_semaphore default_path_sem;
+
 /**
  * digest_cache_alloc_init - Allocate and initialize a new digest cache
  * @path_str: Path string of the digest list
@@ -267,9 +270,12 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 
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
@@ -379,6 +385,8 @@ static const struct lsm_id digest_cache_lsmid = {
  */
 static int __init digest_cache_init(void)
 {
+	init_rwsem(&default_path_sem);
+
 	digest_cache_cache = kmem_cache_create("digest_cache_cache",
 					       sizeof(struct digest_cache),
 					       0, SLAB_PANIC,
diff --git a/security/digest_cache/secfs.c b/security/digest_cache/secfs.c
new file mode 100644
index 000000000000..d3a37bf3588e
--- /dev/null
+++ b/security/digest_cache/secfs.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the securityfs interface of the digest_cache LSM.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include <linux/security.h>
+
+#include "internal.h"
+
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
+static int __init digest_cache_path_init(void)
+{
+	default_path_dentry = securityfs_create_file("digest_cache_path", 0660,
+						     NULL, NULL,
+						     &default_path_ops);
+	if (IS_ERR(default_path_dentry))
+		return -EFAULT;
+
+	return 0;
+}
+
+late_initcall(digest_cache_path_init);
-- 
2.34.1


