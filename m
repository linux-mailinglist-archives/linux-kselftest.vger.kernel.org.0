Return-Path: <linux-kselftest+bounces-4437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F784F6B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF3B1F21AB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5A69DFD;
	Fri,  9 Feb 2024 14:11:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0D69D00;
	Fri,  9 Feb 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487864; cv=none; b=D19XI/MYd4tDUBpdWgJUgcvI5uzrYC6D0rDtIfdym1g5tE+ztiWCbkKMmXKw754NH9W/MsBHRtsbFi/v1AkaA859efUM0xzo4Ujb2dZDQqRpw8Gh7VA7t4e55ZIvcEK7E/OsuF/GQQoAA0gbF/XJoNMLwJqZ6l4OBxZcfg3DFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487864; c=relaxed/simple;
	bh=KOLFzJzmRMSCR4xZEtIXEdjmTTqNH0W9nLaTMonLbDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QT+vwIJrVbwhRqQkfQWcIw9Xwonh5Oetxi6UqBewBv7vkm3HvVr+NbrDgZligQ69qekiXMpXglvbsnlNx7YpYMgJIm3Vq39vwnSbe2x6tTmTm8v13paPj7jMLXObdiH3wytp7PfzfuaW3nqub6DnOdiT+pf4Zyv1fLQH9V3iws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TWb3S4bBNz9y4TD;
	Fri,  9 Feb 2024 21:55:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D539014059D;
	Fri,  9 Feb 2024 22:10:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S7;
	Fri, 09 Feb 2024 15:10:52 +0100 (CET)
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
Subject: [PATCH v3 05/13] digest_cache: Populate the digest cache from a digest list
Date: Fri,  9 Feb 2024 15:09:09 +0100
Message-Id: <20240209140917.846878-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S7
X-Coremail-Antispam: 1UD129KBjvJXoWfGr45Zr4DWryxJr15tw15CFg_yoWktrykpa
	sxCF15trWrJF1fCw4xAF12kryfKrWvqF42qws5ur1ayr47Xr1Yy3WIk3Wjvry5Gr4UWa17
	Ar4UKFyUKr4DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
	GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y4egAEsv

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_populate() to populate the digest cache from a
digest list.

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
not be returned by digest_cache_create(). Dig_owner however is kept, to
avoid an excessive number of retries, which would probably not succeed
either.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/kernel_read_file.h |   1 +
 security/digest_cache/Makefile   |   2 +-
 security/digest_cache/internal.h |  26 ++++++
 security/digest_cache/main.c     |  18 ++++
 security/digest_cache/modsig.c   |  66 ++++++++++++++
 security/digest_cache/populate.c | 149 +++++++++++++++++++++++++++++++
 6 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 security/digest_cache/modsig.c
 create mode 100644 security/digest_cache/populate.c

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
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index 7e00c53d8f55..c1452437d02f 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o
+digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index ee6487acce1d..0d9c01dd9bc8 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -15,6 +15,24 @@
 
 /* Digest cache bits in flags. */
 #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
+#define INVALID			1	/* Digest cache marked as invalid. */
+
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
 
 /**
  * struct digest_cache_entry - Entry of a digest cache hash table
@@ -127,4 +145,12 @@ int digest_cache_htable_lookup(struct dentry *dentry,
 			       enum hash_algo algo);
 void digest_cache_htable_free(struct digest_cache *digest_cache);
 
+/* populate.c */
+int digest_cache_populate(struct digest_cache *digest_cache,
+			  struct path *digest_list_path, char *path_str,
+			  char *filename);
+
+/* modsig.c */
+size_t digest_cache_strip_modsig(__u8 *data, size_t data_len);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index fa435b6566fa..8e9ab99081c3 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -166,6 +166,17 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 
+	if (S_ISREG(inode->i_mode)) {
+		ret = digest_cache_populate(digest_cache, digest_list_path,
+					    path_str, filename);
+		if (ret < 0) {
+			pr_debug("Failed to populate digest cache %s ret: %d (keep digest cache)\n",
+				 digest_cache->path_str, ret);
+			/* Prevent usage of partially-populated digest cache. */
+			set_bit(INVALID, &digest_cache->flags);
+		}
+	}
+
 	/* Creation complete, notify the other lock contenders. */
 	clear_and_wake_up_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
 exists:
@@ -173,6 +184,13 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 		/* Wait until creation complete. */
 		wait_on_bit(&dig_sec->dig_owner->flags, INIT_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
+
+	if (test_bit(INVALID, &digest_cache->flags)) {
+		pr_debug("Digest cache %s is invalid, don't return it\n",
+			 digest_cache->path_str);
+		digest_cache_put(digest_cache);
+		digest_cache = NULL;
+	}
 out:
 	if (digest_list_path == &file_path)
 		path_put(&file_path);
diff --git a/security/digest_cache/modsig.c b/security/digest_cache/modsig.c
new file mode 100644
index 000000000000..3bdda00d8bb2
--- /dev/null
+++ b/security/digest_cache/modsig.c
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
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
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
diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
new file mode 100644
index 000000000000..415e638f587b
--- /dev/null
+++ b/security/digest_cache/populate.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the code to populate a digest cache.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include <linux/init_task.h>
+#include <linux/kernel_read_file.h>
+
+#include "internal.h"
+
+/**
+ * digest_cache_parse_digest_list - Parse a digest list
+ * @digest_cache: Digest cache
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function selects a parser for a digest list depending on its file name,
+ * and calls the appropriate parsing function. It expects the file name to be
+ * in the format: [<seq num>-]<format>-<digest list name>. <seq num> is
+ * optional.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
+					  char *path_str, char *filename,
+					  void *data, size_t data_len)
+{
+	char *format, *next_sep;
+	int ret = -EINVAL;
+
+	if (!filename[0]) {
+		filename = strrchr(path_str, '/');
+		if (!filename)
+			return ret;
+
+		filename++;
+	}
+
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
+	pr_debug("Parsing %s%s%s, format: %.*s, size: %ld\n", path_str,
+		 filename[0] ? "/" : "", filename, (int)(next_sep - format),
+		 format, data_len);
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
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
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
+			  struct path *digest_list_path, char *path_str,
+			  char *filename)
+{
+	struct file *file;
+	void *data;
+	size_t data_len;
+	struct read_work w;
+	int ret;
+
+	file = dentry_open(digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Unable to open digest list %s%s%s, ret: %ld\n",
+			 path_str, filename[0] ? "/" : "", filename,
+			 PTR_ERR(file));
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
+		pr_debug("Unable to read digest list %s%s%s, ret: %d\n",
+			 path_str, filename[0] ? "/" : "", filename, ret);
+		return ret;
+	}
+
+	data_len = digest_cache_strip_modsig(data, ret);
+
+	/* Digest list parsers initialize the hash table and add the digests. */
+	ret = digest_cache_parse_digest_list(digest_cache, path_str, filename,
+					     data, data_len);
+	if (ret < 0)
+		pr_debug("Error parsing digest list %s%s%s, ret: %d\n",
+			 path_str, filename[0] ? "/" : "", filename, ret);
+
+	vfree(data);
+	return ret;
+}
-- 
2.34.1


