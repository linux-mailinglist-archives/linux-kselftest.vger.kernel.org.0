Return-Path: <linux-kselftest+bounces-17262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FD96DD6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33B128949E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DC516F839;
	Thu,  5 Sep 2024 15:08:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2396757FC;
	Thu,  5 Sep 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548892; cv=none; b=UOb8349wYNuJO8jg2jFEgR5/ysqXmJLnEE40dUdxm8UUyGLVfxuQri1mGH/P+U7lAXakjznwS/IZZ2m1bRoGUL1qTU4+5FDEtq6l+gUq8WvY6UrvowhiWxE46Hpo/1CYBb8/6rFV3eAvEPBSt7s2wWNPYHeYksBu56pnOvOl9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548892; c=relaxed/simple;
	bh=NXEEguL5UsO05tJyT66LvSNP7LHc/mQUR55z6TednnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER93Hw3CsnwuSmtA0UR1ZgUSpNUxo7PbFbOYbRim2R69m20oRjXmiB11b4EsrBMF7RzqgCJ4Y13e/tGcy/DVe6C892xcLoB+eCbpoK134K6Heck475QKJeMyB64sFcnLmrLGz3/XGdfqXHRmBE5B02Pt64mnJhnCce+lBm7+EF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X02L46fy8z9v7Hv;
	Thu,  5 Sep 2024 22:48:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 31C9D14101D;
	Thu,  5 Sep 2024 23:07:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S8;
	Thu, 05 Sep 2024 16:07:54 +0100 (CET)
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
Subject: [PATCH v5 06/14] digest_cache: Populate the digest cache from a digest list
Date: Thu,  5 Sep 2024 17:05:35 +0200
Message-Id: <20240905150543.3766895-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S8
X-Coremail-Antispam: 1UD129KBjvJXoWfGr45Zr4rKw4xKFWDXFyUAwb_yoWkuFy7pa
	sIk3W5trWrZF1fCw1xAF1akr1fKrWqqF42qws5ur1ayr4UXr1Yy3W0ya4UZry5Gr4Uu3W7
	tr4Ygryj9r4DXaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0M5lUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oKmwABsR

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_populate() to populate the digest cache from a
digest list. Call it from digest_cache_init() if the inode is a regular
file.

It opens the file and then schedules a work to read the content (with new
file type READING_DIGEST_LIST). Scheduling a work solves the problem of
kernel_read_file() returning -EINTR.

Once the work is done, this function calls digest_cache_strip_modsig() to
strip a module-style appended signature, if present, and finally calls
digest_cache_parse_digest_list() to parse the data.

The latter function, which at the moment does nothing, will be completed
with calls to parsing functions selected from the digest list file name.
It expects digest lists file names to be in the format:

[<seq num>-]<digest list format>-<digest list name>

<seq-num>- is an optional prefix to impose in which order digest lists in
a directory should be parsed.

Failing to populate a digest cache causes it to be marked as invalid and to
not be returned by digest_cache_init(). Dig_owner however is kept, to
avoid an excessive number of retries, which would probably not succeed
either.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/kernel_read_file.h           |   1 +
 security/integrity/digest_cache/Makefile   |   2 +-
 security/integrity/digest_cache/internal.h |  24 ++++
 security/integrity/digest_cache/main.c     |  16 +++
 security/integrity/digest_cache/modsig.c   |  66 ++++++++++
 security/integrity/digest_cache/populate.c | 142 +++++++++++++++++++++
 6 files changed, 250 insertions(+), 1 deletion(-)
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
index 0092c913979d..1b91f9fba51c 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index f4b146a1bbaf..f8ec51405bae 100644
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
@@ -143,4 +160,11 @@ int digest_cache_htable_lookup(struct dentry *dentry,
 			       enum hash_algo algo);
 void digest_cache_htable_free(struct digest_cache *digest_cache);
 
+/* populate.c */
+int digest_cache_populate(struct digest_cache *digest_cache,
+			  struct path *digest_list_path);
+
+/* modsig.c */
+size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index a74fc1183332..6878ebe5b779 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -258,6 +258,9 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry)
 struct digest_cache *digest_cache_init(struct dentry *dentry,
 				       struct digest_cache *digest_cache)
 {
+	struct inode *inode;
+	int ret;
+
 	/* Wait for digest cache initialization. */
 	if (test_and_set_bit(INIT_STARTED, &digest_cache->flags)) {
 		wait_on_bit(&digest_cache->flags, INIT_IN_PROGRESS,
@@ -265,6 +268,19 @@ struct digest_cache *digest_cache_init(struct dentry *dentry,
 		goto out;
 	}
 
+	inode = d_backing_inode(digest_cache->digest_list_path.dentry);
+
+	if (S_ISREG(inode->i_mode)) {
+		ret = digest_cache_populate(digest_cache,
+					    &digest_cache->digest_list_path);
+		if (ret < 0) {
+			pr_debug("Failed to populate digest cache %s ret: %d (keep digest cache)\n",
+				 digest_cache->path_str, ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &digest_cache->flags);
+		}
+	}
+
 	path_put(&digest_cache->digest_list_path);
 	/* Notify initialization complete. */
 	clear_and_wake_up_bit(INIT_IN_PROGRESS, &digest_cache->flags);
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
index 000000000000..c68c76971380
--- /dev/null
+++ b/security/integrity/digest_cache/populate.c
@@ -0,0 +1,142 @@
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
+ * digest_cache_parse_digest_list - Parse a digest list
+ * @digest_cache: Digest cache
+ * @path_str: Path string of the digest list
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function selects a parser for a digest list depending on its file name,
+ * and calls the appropriate parsing function. It expects the file name to be
+ * in the format: [<seq num>-]<format>-<digest list name>. <seq num>- is
+ * optional.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
+					  char *path_str, void *data,
+					  size_t data_len)
+{
+	char *filename, *format, *next_sep;
+	int ret = -EINVAL;
+
+	filename = strrchr(path_str, '/');
+	if (!filename)
+		return ret;
+
+	filename++;
+	format = filename;
+
+	/*
+	 * Since we expect that all files start with a digest list format, this
+	 * check is reliable to detect <seq num>.
+	 */
+	if (filename[0] >= '0' && filename[0] <= '9') {
+		format = strchr(filename, '-');
+		if (!format)
+			return ret;
+
+		format++;
+	}
+
+	next_sep = strchr(format, '-');
+	if (!next_sep)
+		return ret;
+
+	pr_debug("Parsing %s, format: %.*s, size: %ld\n", path_str,
+		 (int)(next_sep - format), format, data_len);
+
+	return ret;
+}
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
+int digest_cache_populate(struct digest_cache *digest_cache,
+			  struct path *digest_list_path)
+{
+	struct file *file;
+	void *data;
+	size_t data_len;
+	struct read_work w;
+	int ret;
+
+	file = dentry_open(digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Unable to open digest list %s, ret: %ld\n",
+			 digest_cache->path_str, PTR_ERR(file));
+		return PTR_ERR(file);
+	}
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
+	ret = digest_cache_parse_digest_list(digest_cache,
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
2.34.1


