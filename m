Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410EF40B4E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhINQhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 12:37:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3800 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhINQg5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 12:36:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H886W5Xzmz67Pmr;
        Wed, 15 Sep 2021 00:33:23 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 18:35:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 06/13] diglim: IMA info
Date:   Tue, 14 Sep 2021 18:33:54 +0200
Message-ID: <20210914163401.864635-7-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914163401.864635-1-roberto.sassu@huawei.com>
References: <20210914163401.864635-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce diglim_ima_get_info() to retrieve the digest and the actions
performed by IMA on the passed digest list file or buffer.

diglim_ima_get_info() requires the caller to write-lock the file to ensure
that the file content the integrity status is retrieved from didn't change
since the time the buffer passed as argument was filled.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                        |   1 +
 security/integrity/diglim/Makefile |   2 +-
 security/integrity/diglim/diglim.h |   6 ++
 security/integrity/diglim/ima.c    | 122 +++++++++++++++++++++++++++++
 security/integrity/integrity.h     |   4 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/diglim/ima.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5959936d490..f10690dda734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5514,6 +5514,7 @@ F:	Documentation/security/diglim/introduction.rst
 F:	include/linux/diglim.h
 F:	include/uapi/linux/diglim.h
 F:	security/integrity/diglim/diglim.h
+F:	security/integrity/diglim/ima.c
 F:	security/integrity/diglim/methods.c
 F:	security/integrity/diglim/parser.c
 
diff --git a/security/integrity/diglim/Makefile b/security/integrity/diglim/Makefile
index 34e4e154fff3..880dc5300792 100644
--- a/security/integrity/diglim/Makefile
+++ b/security/integrity/diglim/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_DIGLIM) += diglim.o
 
-diglim-y := methods.o parser.o
+diglim-y := methods.o parser.o ima.o
diff --git a/security/integrity/diglim/diglim.h b/security/integrity/diglim/diglim.h
index afdb0affdc5e..ebe8936520b5 100644
--- a/security/integrity/diglim/diglim.h
+++ b/security/integrity/diglim/diglim.h
@@ -22,6 +22,8 @@
 #include <linux/hash_info.h>
 #include <linux/diglim.h>
 
+#include "../integrity.h"
+
 #define MAX_DIGEST_SIZE 64
 #define HASH_BITS 10
 #define DIGLIM_HTABLE_SIZE (1 << HASH_BITS)
@@ -221,4 +223,8 @@ void digest_list_del(u8 *digest, enum hash_algo algo, u8 actions,
 
 int digest_list_parse(loff_t size, void *buf, enum ops op, u8 actions,
 		      u8 *digest, enum hash_algo algo, const char *label);
+
+int diglim_ima_get_info(struct file *file, u8 *buffer, size_t buffer_len,
+			char *event_name, u8 *digest, size_t digest_len,
+			enum hash_algo *algo, u8 *actions);
 #endif /*__DIGLIM_INTERNAL_H*/
diff --git a/security/integrity/diglim/ima.c b/security/integrity/diglim/ima.c
new file mode 100644
index 000000000000..2cc1ec1299f8
--- /dev/null
+++ b/security/integrity/diglim/ima.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Functions to retrieve the integrity status from IMA.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/ima.h>
+
+#include "diglim.h"
+
+static int diglim_ima_get_info_file(struct file *file, u8 *digest,
+				    size_t digest_len, enum hash_algo *algo,
+				    u8 *actions)
+{
+	struct integrity_iint_cache *iint;
+	struct inode *inode = file_inode(file);
+	int ret = -ENOENT;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return ret;
+
+	mutex_lock(&iint->mutex);
+	/* File digest has not been calculated. */
+	if (!(iint->flags & IMA_COLLECTED))
+		goto out;
+
+	ret = 0;
+
+	if (iint->flags & IMA_MEASURED)
+		*actions |= 1 << COMPACT_ACTION_IMA_MEASURED;
+
+	if (iint->flags & IMA_APPRAISED)
+		*actions |= 1 << COMPACT_ACTION_IMA_APPRAISED;
+
+	if (test_bit(IMA_DIGSIG, &iint->atomic_flags))
+		*actions |= 1 << COMPACT_ACTION_IMA_APPRAISED_DIGSIG;
+
+	if (algo)
+		*algo = iint->ima_hash->algo;
+	if (digest)
+		memcpy(digest, iint->ima_hash->digest, hash_digest_size[*algo]);
+out:
+	mutex_unlock(&iint->mutex);
+	return ret;
+}
+
+static int diglim_ima_get_info_buffer(u8 *buffer, size_t buffer_len,
+				      char *event_name, u8 *digest,
+				      size_t digest_len, enum hash_algo *algo,
+				      u8 *actions)
+{
+	int ret;
+
+	ret = ima_measure_critical_data("diglim", event_name, buffer,
+					buffer_len, false, digest, digest_len);
+	if (ret < 0 && ret != -EEXIST)
+		return -ENOENT;
+
+	*algo = ima_get_current_hash_algo();
+
+	if (!ret || ret == -EEXIST)
+		*actions |= 1 << COMPACT_ACTION_IMA_MEASURED;
+
+	return 0;
+}
+
+/**
+ * diglim_ima_get_info - retrieve the integrity status of digest list from IMA
+ * @file: file to retrieve the integrity status from
+ * @buffer: buffer to retrieve the integrity status from (alternative to file)
+ * @buffer_len: buffer length
+ * @event_name: name of the event to be generated by IMA for buffer measurement
+ * @digest: digest of the file or the buffer
+ * @digest_len: digest length
+ * @algo: digest algorithm
+ * @actions: actions performed on the file or the buffer
+ *
+ * This function attempts to retrieve some information from the passed digest
+ * list file or buffer: the digest, its algorithm, and the actions performed by
+ * IMA.
+ *
+ * This function first attempts to retrieve the information from the file, and
+ * if unsuccessful, attempts with the buffer.
+ *
+ * The caller must prevent writes to the file with deny_write_access() to ensure
+ * that the file content the integrity status is retrieved from didn't change
+ * since the time the buffer passed as argument was filled.
+ *
+ * Return: 0 if the information has been successfully retrieved, -ENOENT
+ *         otherwise.
+ */
+int diglim_ima_get_info(struct file *file, u8 *buffer, size_t buffer_len,
+			char *event_name, u8 *digest, size_t digest_len,
+			enum hash_algo *algo, u8 *actions)
+{
+	int ret = -ENOENT;
+
+	/* Ensure that the file is write-locked. */
+	if (file && atomic_read(&file_inode(file)->i_writecount) >= 0)
+		return -EINVAL;
+
+	if (file) {
+		ret = diglim_ima_get_info_file(file, digest, digest_len, algo,
+					       actions);
+		if (!ret && (*actions & (1 << COMPACT_ACTION_IMA_MEASURED)))
+			return ret;
+	}
+
+	if (buffer) {
+		ret = diglim_ima_get_info_buffer(buffer, buffer_len, event_name,
+						 digest, digest_len, algo,
+						 actions);
+	}
+
+	return ret;
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 74919b638f52..de5dde382f11 100644
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
@@ -285,3 +288,4 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+#endif /*__INTEGRITY_H*/
-- 
2.25.1

