Return-Path: <linux-kselftest+bounces-22258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CAF9D240C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1892860B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F41C4A0C;
	Tue, 19 Nov 2024 10:52:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947619C553;
	Tue, 19 Nov 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013567; cv=none; b=lPg/pWYtkllImR0jmjw8Cz7YAf/n0MJNId2O6SsC74n4BdK6Y96nGZFsD3rvR5q0uixW/Zm7ovzuTmO1neFjv0vBzVP+/U6grfLVHW1Gzi3lDqwbyrlZqHTcv3evw6vl650tSSYOqLbDGS+AUpNiOjqBGuNlu3FY9GasUI/KdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013567; c=relaxed/simple;
	bh=ee9zthSyrG3efC8WOt0TySe+yv4qWr8mwsw0DjJLqnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrOVN9MfnFqTCOUw/rInuoA8oNIIjyCKsKVyyfWuVzWfssldGkPsrXB8UV9wYWdQxoHdd1fTzdS1s7SjFRkKva8AQqg2ajjvAmFxSesW5wlE3rzAtamqU/hembTHL3jDXVaXRaxLcu6k/Noy/wHRbJuslYB9GI36SVt8SrOLGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt1506Drrz9v7J6;
	Tue, 19 Nov 2024 18:31:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 367F5140E7B;
	Tue, 19 Nov 2024 18:52:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S11;
	Tue, 19 Nov 2024 11:52:36 +0100 (CET)
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
Subject: [PATCH v6 09/15] digest_cache: Populate the digest cache from a digest list
Date: Tue, 19 Nov 2024 11:49:16 +0100
Message-ID: <20241119104922.2772571-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S11
X-Coremail-Antispam: 1UD129KBjvJXoW3CryfJr1rGr1fKr1DAw1xGrg_yoWDurW5pa
	9Ik3W5trWrZFn3Cw1xAF1akr1rKrWvgF42qws5uw1ayF47Xr1Yv3WIya4UZry5Jr4Uu3W7
	Jr4jgr1j9r4DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEfAAAsu

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_populate() to populate the digest cache from a
digest list. Call it from digest_cache_init() if the inode is a regular
file.

It opens the file, marks it for internal use with
digest_cache_to_file_sec(), and then schedules a work to read the content
(with new file type READING_DIGEST_LIST). Scheduling a work solves the
problem of kernel_read_file() returning -EINTR.

Once the work is done, this function calls digest_cache_strip_modsig() to
strip a module-style appended signature, if present, and finally calls
digest_cache_parse_digest_list() to parse the data.

Failing to populate a digest cache causes it to be marked as invalid and to
not be returned by digest_cache_init(). Dig_owner however is kept, to
avoid an excessive number of retries, which would probably not succeed
either.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/kernel_read_file.h           |  1 +
 security/integrity/digest_cache/Makefile   |  2 +-
 security/integrity/digest_cache/internal.h | 25 ++++++
 security/integrity/digest_cache/main.c     | 16 ++++
 security/integrity/digest_cache/modsig.c   | 66 +++++++++++++++
 security/integrity/digest_cache/populate.c | 97 ++++++++++++++++++++++
 6 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache/modsig.c
 create mode 100644 security/integrity/digest_cache/populate.c

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..85f602e49e2f 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(DIGEST_LIST, digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 3b42b20d1bc0..3b81edea065b 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -5,6 +5,6 @@
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 obj-$(CONFIG_DIGEST_CACHE_TLV_PARSER) += parsers/tlv.o
 
-digest_cache-y := main.o secfs.o htable.o parsers.o
+digest_cache-y := main.o secfs.o htable.o parsers.o populate.o modsig.o
 
 CFLAGS_parsers.o += -DPARSERS_DIR=\"$(MODLIB)/kernel/security/integrity/digest_cache/parsers\"
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index e178549f9ff9..2171ea8423ff 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -18,6 +18,23 @@
 #define INIT_STARTED		1	/* Digest cache init started. */
 #define INVALID			2	/* Digest cache marked as invalid. */
 
+/**
+ * struct read_work - Structure to schedule reading a digest list
+ * @work: Work structure
+ * @file: File descriptor of the digest list to read
+ * @data: Digest list data (updated)
+ * @ret: Return value from kernel_read_file() (updated)
+ *
+ * This structure contains the necessary information to schedule reading a
+ * digest list.
+ */
+struct read_work {
+	struct work_struct work;
+	struct file *file;
+	void *data;
+	int ret;
+};
+
 /**
  * struct digest_cache_entry - Entry of a digest cache hash table
  * @hnext: Pointer to the next element in the collision list
@@ -166,4 +183,12 @@ int digest_cache_parse_digest_list(struct dentry *dentry,
 				   struct digest_cache *digest_cache,
 				   char *path_str, void *data, size_t data_len);
 
+/* populate.c */
+int digest_cache_populate(struct dentry *dentry,
+			  struct digest_cache *digest_cache,
+			  struct path *digest_list_path);
+
+/* modsig.c */
+size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index ebc5dc09a62b..ad0f34c7ef9b 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -267,6 +267,9 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 				       struct path *digest_list_path,
 				       struct digest_cache *digest_cache)
 {
+	struct inode *inode;
+	int ret;
+
 	/* Wait for digest cache initialization. */
 	if (!digest_list_path->dentry ||
 	    test_and_set_bit(INIT_STARTED, &digest_cache->flags)) {
@@ -275,6 +278,19 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 		goto out;
 	}
 
+	inode = d_backing_inode(digest_list_path->dentry);
+
+	if (S_ISREG(inode->i_mode)) {
+		ret = digest_cache_populate(dentry, digest_cache,
+					    digest_list_path);
+		if (ret < 0) {
+			pr_debug("Failed to populate digest cache %s ret: %d (keep digest cache)\n",
+				 digest_cache->path_str, ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &digest_cache->flags);
+		}
+	}
+
 	/* Notify initialization complete. */
 	clear_and_wake_up_bit(INIT_IN_PROGRESS, &digest_cache->flags);
 out:
diff --git a/security/integrity/digest_cache/modsig.c b/security/integrity/digest_cache/modsig.c
new file mode 100644
index 000000000000..fa512c43a556
--- /dev/null
+++ b/security/integrity/digest_cache/modsig.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2019  IBM Corporation
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Strip module-style appended signatures.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/module.h>
+#include <linux/module_signature.h>
+
+#include "internal.h"
+
+/**
+ * digest_cache_strip_modsig - Strip module-style appended sig from digest list
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function strips the module-style appended signature from a digest list,
+ * if present.
+ *
+ * Return: Size of stripped data on success, original size otherwise.
+ */
+size_t digest_cache_strip_modsig(__u8 *data, size_t data_len)
+{
+	const size_t marker_len = strlen(MODULE_SIG_STRING);
+	const struct module_signature *sig;
+	size_t parsed_data_len = data_len;
+	size_t sig_len;
+	const void *p;
+
+	/* From ima_modsig.c */
+	if (data_len <= marker_len + sizeof(*sig))
+		return data_len;
+
+	p = data + parsed_data_len - marker_len;
+	if (memcmp(p, MODULE_SIG_STRING, marker_len))
+		return data_len;
+
+	parsed_data_len -= marker_len;
+	sig = (const struct module_signature *)(p - sizeof(*sig));
+
+	/* From module_signature.c */
+	if (be32_to_cpu(sig->sig_len) >= parsed_data_len - sizeof(*sig))
+		return data_len;
+
+	/* Unlike for module signatures, accept all signature types. */
+	if (sig->algo != 0 ||
+	    sig->hash != 0 ||
+	    sig->signer_len != 0 ||
+	    sig->key_id_len != 0 ||
+	    sig->__pad[0] != 0 ||
+	    sig->__pad[1] != 0 ||
+	    sig->__pad[2] != 0) {
+		pr_debug("Signature info has unexpected non-zero params\n");
+		return data_len;
+	}
+
+	sig_len = be32_to_cpu(sig->sig_len);
+	parsed_data_len -= sig_len + sizeof(*sig);
+	return parsed_data_len;
+}
diff --git a/security/integrity/digest_cache/populate.c b/security/integrity/digest_cache/populate.c
new file mode 100644
index 000000000000..54f7f95f5794
--- /dev/null
+++ b/security/integrity/digest_cache/populate.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the code to populate a digest cache.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/init_task.h>
+#include <linux/vmalloc.h>
+#include <linux/kernel_read_file.h>
+
+#include "internal.h"
+
+/**
+ * digest_cache_read_digest_list - Read a digest list
+ * @work: Work structure
+ *
+ * This function is invoked by schedule_work() to read a digest list.
+ *
+ * It does not return a value, but stores the result in the passed structure.
+ */
+static void digest_cache_read_digest_list(struct work_struct *work)
+{
+	struct read_work *w = container_of(work, struct read_work, work);
+
+	w->ret = kernel_read_file(w->file, 0, &w->data, INT_MAX, NULL,
+				  READING_DIGEST_LIST);
+}
+
+/**
+ * digest_cache_populate - Populate a digest cache from a digest list
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_cache: Digest cache
+ * @digest_list_path: Path structure of the digest list
+ *
+ * This function opens the digest list for reading it. Then, it schedules a
+ * work to read the digest list and, once the work is done, it calls
+ * digest_cache_strip_modsig() to strip a module-style appended signature and
+ * digest_cache_parse_digest_list() for extracting and adding digests to the
+ * digest cache.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_populate(struct dentry *dentry,
+			  struct digest_cache *digest_cache,
+			  struct path *digest_list_path)
+{
+	struct file *file;
+	void *data;
+	size_t data_len;
+	struct read_work w;
+	int ret;
+
+	file = kernel_file_open(digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Unable to open digest list %s, ret: %ld\n",
+			 digest_cache->path_str, PTR_ERR(file));
+		return PTR_ERR(file);
+	}
+
+	/* Mark the file descriptor as ours. */
+	digest_cache_to_file_sec(file, digest_cache);
+
+	w.data = NULL;
+	w.file = file;
+	INIT_WORK_ONSTACK(&w.work, digest_cache_read_digest_list);
+
+	schedule_work(&w.work);
+	flush_work(&w.work);
+	destroy_work_on_stack(&w.work);
+	fput(file);
+
+	ret = w.ret;
+	data = w.data;
+
+	if (ret < 0) {
+		pr_debug("Unable to read digest list %s, ret: %d\n",
+			 digest_cache->path_str, ret);
+		return ret;
+	}
+
+	data_len = digest_cache_strip_modsig(data, ret);
+
+	/* Digest list parsers initialize the hash table and add the digests. */
+	ret = digest_cache_parse_digest_list(dentry, digest_cache,
+					     digest_cache->path_str, data,
+					     data_len);
+	if (ret < 0)
+		pr_debug("Error parsing digest list %s, ret: %d\n",
+			 digest_cache->path_str, ret);
+
+	vfree(data);
+	return ret;
+}
-- 
2.47.0.118.gfd3785337b


