Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1973B47C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFYRAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:00:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3314 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhFYRAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:00:20 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNBc3mcYz6L4vj;
        Sat, 26 Jun 2021 00:44:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:57:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 07/12] digest_lists: Interfaces - digest_list_add, digest_list_del
Date:   Fri, 25 Jun 2021 18:56:09 +0200
Message-ID: <20210625165614.2284243-8-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625165614.2284243-1-roberto.sassu@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces <securityfs>/integrity/digest_lists/digest_list_add,
which can be used to upload a digest list and add the digests to the hash
table; passed data are interpreted as file path if the first byte is / or
as the digest list itself otherwise. ima_measure_critical_data() is called
to calculate the digest of the digest list and eventually, if an
appropriate rule is set in the IMA policy, to measure it.

It also introduces <securityfs>/integrity/digest_lists/digest_list_del,
which can be used to upload a digest list and delete the digests from the
hash table; data are interpreted in the same way as described for
digest_list_add.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/digest_lists.rst       |  28 +++
 MAINTAINERS                                   |   1 +
 include/linux/kernel_read_file.h              |   1 +
 security/integrity/digest_lists/Makefile      |   2 +-
 .../integrity/digest_lists/digest_lists.h     |   3 +-
 security/integrity/digest_lists/fs.c          | 210 ++++++++++++++++++
 security/integrity/integrity.h                |   4 +
 7 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/digest_lists/fs.c

diff --git a/Documentation/security/digest_lists.rst b/Documentation/security/digest_lists.rst
index 04ea4b3790e0..85a34a5ad7ce 100644
--- a/Documentation/security/digest_lists.rst
+++ b/Documentation/security/digest_lists.rst
@@ -644,3 +644,31 @@ to roll back when one of the steps fails.
 
 #. ``digest_list_parse()`` deletes the ``digest_list_item`` on unsuccessful
    add or successful delete.
+
+
+Interfaces
+----------
+
+This section introduces the interfaces in
+``<securityfs>/integrity/digest_lists`` necessary to interact with Huawei
+Digest Lists.
+
+
+``digest_list_add``
+~~~~~~~~~~~~~~~~~~~
+
+``digest_list_add`` can be used to upload a digest list and add the digests
+to the hash table; passed data are interpreted as file path if the first
+byte is ``/`` or as the digest list itself otherwise.
+
+``ima_measure_critical_data()`` is called to calculate the digest of the
+digest list and eventually, if an appropriate rule is set in the IMA
+policy, to measure it.
+
+
+``digest_list_del``
+~~~~~~~~~~~~~~~~~~~
+
+``digest_list_del`` can be used to upload a digest list and delete the
+digests from the hash table; data are interpreted in the same way as
+described for ``digest_list_add``.
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d280acf5fb..c86b410f2c2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8389,6 +8389,7 @@ T:	git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	Documentation/security/digest_lists.rst
 F:	include/linux/digest_list.h
 F:	security/integrity/digest_lists/digest_list.h
+F:	security/integrity/digest_lists/fs.c
 F:	security/integrity/digest_lists/methods.c
 F:	security/integrity/digest_lists/parser.c
 F:	uapi/linux/digest_lists.h
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 575ffa1031d3..636ecdfdc616 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(DIGEST_LIST, digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/digest_lists/Makefile b/security/integrity/digest_lists/Makefile
index 86cca5bb7824..00ca06d4bdfd 100644
--- a/security/integrity/digest_lists/Makefile
+++ b/security/integrity/digest_lists/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_DIGEST_LISTS) += digest_lists.o
 
-digest_lists-y := methods.o parser.o
+digest_lists-y := methods.o parser.o fs.o
diff --git a/security/integrity/digest_lists/digest_lists.h b/security/integrity/digest_lists/digest_lists.h
index 442ab116a6a5..4b74995848dc 100644
--- a/security/integrity/digest_lists/digest_lists.h
+++ b/security/integrity/digest_lists/digest_lists.h
@@ -28,7 +28,8 @@
 #include <linux/hash_info.h>
 #include <uapi/linux/digest_lists.h>
 
-#define MAX_DIGEST_SIZE	64
+#include "../integrity.h"
+
 #define HASH_BITS 10
 #define MEASURE_HTABLE_SIZE (1 << HASH_BITS)
 
diff --git a/security/integrity/digest_lists/fs.c b/security/integrity/digest_lists/fs.c
new file mode 100644
index 000000000000..b407c5f7b659
--- /dev/null
+++ b/security/integrity/digest_lists/fs.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: fs.c
+ *      Functions for the interfaces exposed in securityfs.
+ */
+
+
+#include <linux/fcntl.h>
+#include <linux/kernel_read_file.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/parser.h>
+#include <linux/vmalloc.h>
+#include <linux/namei.h>
+#include <linux/ima.h>
+
+#include "digest_lists.h"
+
+static struct dentry *digest_lists_dir;
+static struct dentry *digest_list_add_dentry;
+static struct dentry *digest_list_del_dentry;
+
+static ssize_t digest_list_read(char *path, enum ops op)
+{
+	void *data = NULL;
+	char *datap;
+	size_t size;
+	u8 actions = 0;
+	bool measured = false;
+	struct file *file;
+	u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
+	enum hash_algo algo = HASH_ALGO__LAST;
+	int rc, pathlen = strlen(path);
+
+	/* remove \n */
+	datap = path;
+	strsep(&datap, "\n");
+
+	file = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
+		return PTR_ERR(file);
+	}
+
+	rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
+			      READING_DIGEST_LIST);
+	if (rc < 0) {
+		pr_err("unable to read file: %s (%d)", path, rc);
+		goto out;
+	}
+
+	size = rc;
+
+	ima_measure_critical_data("digest_lists", "file_upload", data, size,
+				  false, digest, &algo, &measured);
+	if (algo == HASH_ALGO__LAST) {
+		rc = -EINVAL;
+		goto out_vfree;
+	}
+
+	if (measured)
+		actions |= COMPACT_ACTION_IMA_MEASURED;
+
+	rc = digest_list_parse(size, data, op, actions, digest, algo, "");
+	if (rc < 0)
+		pr_err("unable to upload digest list %s (%d)\n", path, rc);
+out_vfree:
+	vfree(data);
+out:
+	fput(file);
+
+	if (rc < 0)
+		return rc;
+
+	return pathlen;
+}
+
+static ssize_t digest_list_write(struct file *file, const char __user *buf,
+				 size_t datalen, loff_t *ppos)
+{
+	char *data;
+	ssize_t result;
+	enum ops op = DIGEST_LIST_ADD;
+	struct dentry *dentry = file_dentry(file);
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+	enum hash_algo algo = HASH_ALGO__LAST;
+	u8 actions = 0;
+	bool measured = false;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	result = -EFBIG;
+	if (datalen > 64 * 1024 * 1024 - 1)
+		goto out;
+
+	data = memdup_user_nul(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	if (dentry == digest_list_del_dentry)
+		op = DIGEST_LIST_DEL;
+
+	result = -EPERM;
+
+	if (data[0] == '/') {
+		result = digest_list_read(data, op);
+	} else {
+		ima_measure_critical_data("digest_lists", "buffer_upload", data,
+					  datalen, false, digest, &algo,
+					  &measured);
+		if (algo == HASH_ALGO__LAST) {
+			pr_err("failed to calculate buffer digest\n");
+			result = -EINVAL;
+			goto out_kfree;
+		}
+
+		if (measured)
+			actions |= COMPACT_ACTION_IMA_MEASURED;
+
+		result = digest_list_parse(datalen, data, op, actions, digest,
+					   algo, "");
+		if (result != datalen) {
+			pr_err("unable to upload generated digest list\n");
+			result = -EINVAL;
+		}
+	}
+out_kfree:
+	kfree(data);
+out:
+	return result;
+}
+
+static unsigned long flags;
+
+/*
+ * digest_list_open: sequentialize access to the add/del files
+ */
+static int digest_list_open(struct inode *inode, struct file *filp)
+{
+	if ((filp->f_flags & O_ACCMODE) != O_WRONLY)
+		return -EACCES;
+
+	if (test_and_set_bit(0, &flags))
+		return -EBUSY;
+
+	return 0;
+}
+
+/*
+ * digest_list_release - release the add/del files
+ */
+static int digest_list_release(struct inode *inode, struct file *file)
+{
+	clear_bit(0, &flags);
+	return 0;
+}
+
+static const struct file_operations digest_list_upload_ops = {
+	.open = digest_list_open,
+	.write = digest_list_write,
+	.read = seq_read,
+	.release = digest_list_release,
+	.llseek = generic_file_llseek,
+};
+
+int __init digest_lists_fs_init(void)
+{
+	digest_lists_dir = securityfs_create_dir("digest_lists", integrity_dir);
+	if (IS_ERR(digest_lists_dir))
+		return -1;
+
+	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
+						digest_lists_dir, NULL,
+						&digest_list_upload_ops);
+	if (IS_ERR(digest_list_add_dentry))
+		goto out;
+
+	digest_list_del_dentry = securityfs_create_file("digest_list_del", 0200,
+						digest_lists_dir, NULL,
+						&digest_list_upload_ops);
+	if (IS_ERR(digest_list_del_dentry))
+		goto out;
+
+	return 0;
+out:
+	securityfs_remove(digest_list_del_dentry);
+	securityfs_remove(digest_list_add_dentry);
+	securityfs_remove(digest_lists_dir);
+	return -1;
+}
+
+late_initcall(digest_lists_fs_init);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..ac45e1599c2d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -6,6 +6,9 @@
  * Mimi Zohar <zohar@us.ibm.com>
  */
 
+#ifndef __INTEGRITY_H
+#define __INTEGRITY_H
+
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
@@ -283,3 +286,4 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+#endif /*__INTEGRITY_H*/
-- 
2.25.1

