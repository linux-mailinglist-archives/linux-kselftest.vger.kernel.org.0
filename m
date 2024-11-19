Return-Path: <linux-kselftest+bounces-22256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D219D23FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EC0B2454B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E71C4A05;
	Tue, 19 Nov 2024 10:52:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F721C4603;
	Tue, 19 Nov 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013538; cv=none; b=PfK8UHO2yyWqqcqbH2a8lUbdXCLcvjKlPMXIzuhxHb2IV4xyX56mcrYnEAz6SkPKsfH+ym3H2nAdaMopZN0BN1pmQAKJ7aXSOyvd4Ki/NxzEKMUeSbL7JfnFg0uuoc/oCGImHCgQZ26X2L7N9gq4hFpO75ONYUbmMubckAdmg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013538; c=relaxed/simple;
	bh=ZrX049mDSgS7H89v/ZFuQqp5qnhFIb1/04t5hFEmaH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQMuNng5tZrj5MGUVTf0an70kyO7bfzpoQcxjZV5ZTbFmPFelaQhSotfnaDcK4/0a9jIL0CMV46miLVy1NM1bFa2yDwvd9b+ZAcqyfEhIXqDxSqyesr8oi+S/8Ye321uzdCIip280yFUPKBw5lo9nDqfQCj4dbKVbPv8hj/lcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt0xB3qDhz9v7JM;
	Tue, 19 Nov 2024 18:25:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B0F441407FE;
	Tue, 19 Nov 2024 18:52:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S9;
	Tue, 19 Nov 2024 11:52:03 +0100 (CET)
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
Subject: [PATCH v6 07/15] digest_cache: Allow registration of digest list parsers
Date: Tue, 19 Nov 2024 11:49:14 +0100
Message-ID: <20241119104922.2772571-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S9
X-Coremail-Antispam: 1UD129KBjvAXoWfGr4xWryrCFy5JrW7GF1xXwb_yoW8JFW5Wo
	ZIvF4UGw18ua47uF4kCF1xAayxu39Yqw1rAr93WrW5Z3WIyry5J3ZrGa1UJFWUJr4rGrZr
	Aw18Xw4UJayrtr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOr7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	WY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU0l4iUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEiAADsc

From: Roberto Sassu <roberto.sassu@huawei.com>

Allow kernel modules to register/deregister new digest list parsers,
respectively through digest_cache_register_parser() and
digest_cache_unregister_parser().

Those functions pass the new parser structure holding the linked list
pointers and a parsing function with the new type parser_func.

Introduce digest_cache_parse_digest_list(), which determines the desired
parser from the file name, looks up the parser among the registered ones
with lookup_get_parser(), calls the parser-specific function along with the
digest list data read by the kernel, and finally releases the kernel module
reference with put_parser().

The expected digest list file name format is:

[<seq num>-]<digest list format>-<digest list name>

<seq-num>- is an optional prefix to impose in which order digest lists in
a directory should be parsed.

Introduce load_parser() to load a kernel module containing a
parser for the requested digest list format (compressed kernel modules are
supported). Kernel modules are searched in the
/lib/modules/<kernel ver>/security/integrity/digest_cache directory.

load_parser() calls ksys_finit_module() to load a kernel module directly
from the kernel. request_module() cannot be used at this point, since the
reference digests of modprobe and the linked libraries (required for IMA
appraisal) might not be yet available, resulting in modprobe execution
being denied.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h               |  38 +++
 security/integrity/digest_cache/Kconfig    |   1 +
 security/integrity/digest_cache/Makefile   |   4 +-
 security/integrity/digest_cache/internal.h |   5 +
 security/integrity/digest_cache/parsers.c  | 257 +++++++++++++++++++++
 5 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache/parsers.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 59a42c04cbb8..a9d731990b7c 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -13,6 +13,32 @@
 #include <linux/fs.h>
 #include <crypto/hash_info.h>
 
+struct digest_cache;
+
+/**
+ * typedef parser_func - Function to parse digest lists
+ *
+ * Define a function type to parse digest lists.
+ */
+typedef int (*parser_func)(struct digest_cache *digest_cache, const u8 *data,
+			   size_t data_len);
+
+/**
+ * struct parser - Structure to store a function pointer to parse digest list
+ * @list: Linked list
+ * @owner: Kernel module owning the parser
+ * @name: Parser name (must match the format in the digest list file name)
+ * @func: Function pointer for parsing
+ *
+ * This structure stores a function pointer to parse a digest list.
+ */
+struct parser {
+	struct list_head list;
+	struct module *owner;
+	const char name[NAME_MAX + 1];
+	parser_func func;
+};
+
 #ifdef CONFIG_INTEGRITY_DIGEST_CACHE
 /* Client API */
 struct digest_cache *digest_cache_get(struct file *file);
@@ -30,6 +56,8 @@ int digest_cache_htable_add(struct digest_cache *digest_cache, u8 *digest,
 int digest_cache_htable_lookup(struct dentry *dentry,
 			       struct digest_cache *digest_cache, u8 *digest,
 			       enum hash_algo algo);
+int digest_cache_register_parser(struct parser *parser);
+void digest_cache_unregister_parser(struct parser *parser);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct file *file)
@@ -72,5 +100,15 @@ static inline int digest_cache_htable_lookup(struct dentry *dentry,
 	return -EOPNOTSUPP;
 }
 
+static inline int digest_cache_register_parser(const char *name,
+					       parser_func func)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void digest_cache_unregister_parser(const char *name)
+{
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/integrity/digest_cache/Kconfig b/security/integrity/digest_cache/Kconfig
index 419011fb52c9..65c07110911b 100644
--- a/security/integrity/digest_cache/Kconfig
+++ b/security/integrity/digest_cache/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config INTEGRITY_DIGEST_CACHE
 	bool "Integrity Digest Cache"
+	select MODULE_DECOMPRESS if MODULE_COMPRESS
 	default n
 	help
 	  This option enables a cache of reference digests (e.g. of file
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 0092c913979d..d68cae690241 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -4,4 +4,6 @@
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 
-digest_cache-y := main.o secfs.o htable.o
+digest_cache-y := main.o secfs.o htable.o parsers.o
+
+CFLAGS_parsers.o += -DPARSERS_DIR=\"$(MODLIB)/kernel/security/integrity/digest_cache/parsers\"
diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index e14343e96caa..e178549f9ff9 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -161,4 +161,9 @@ int __init digest_cache_secfs_init(struct dentry *dir);
 /* htable.c */
 void digest_cache_htable_free(struct digest_cache *digest_cache);
 
+/* parsers.c */
+int digest_cache_parse_digest_list(struct dentry *dentry,
+				   struct digest_cache *digest_cache,
+				   char *path_str, void *data, size_t data_len);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/integrity/digest_cache/parsers.c b/security/integrity/digest_cache/parsers.c
new file mode 100644
index 000000000000..744c9742a44e
--- /dev/null
+++ b/security/integrity/digest_cache/parsers.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the code to register digest list parsers.
+ */
+
+#define pr_fmt(fmt) "digest_cache: "fmt
+#include <linux/init_task.h>
+#include <linux/namei.h>
+#include <uapi/linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/vmalloc.h>
+
+#include "internal.h"
+
+static DEFINE_MUTEX(parsers_mutex);
+static LIST_HEAD(parsers);
+
+/**
+ * load_parser - Load kernel module containing a parser
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_cache: Digest cache
+ * @name: Name of the parser to load
+ *
+ * This function opens a kernel module file in
+ * /lib/modules/<kernel ver>/security/integrity/digest_cache, and executes
+ * ksys_finit_module() to load the kernel module. After kernel module
+ * initialization, the parser should be found in the linked list of parsers.
+ *
+ * Return: Zero if kernel module is loaded, a POSIX error code otherwise.
+ */
+static int load_parser(struct dentry *dentry, struct digest_cache *digest_cache,
+		       const char *name)
+{
+	char *compress_suffix = "";
+	char *parser_path;
+	struct file *file;
+	struct path path;
+	int ret = 0, flags = 0;
+
+	/* Must be kept in sync with kernel/module/Kconfig. */
+	if (IS_ENABLED(CONFIG_MODULE_COMPRESS_GZIP))
+		compress_suffix = ".gz";
+	else if (IS_ENABLED(CONFIG_MODULE_COMPRESS_XZ))
+		compress_suffix = ".xz";
+	else if (IS_ENABLED(CONFIG_MODULE_COMPRESS_ZSTD))
+		compress_suffix = ".zst";
+
+	if (strlen(compress_suffix))
+		flags |= MODULE_INIT_COMPRESSED_FILE;
+
+	parser_path = kasprintf(GFP_KERNEL, "%s/%s.ko%s", PARSERS_DIR, name,
+				compress_suffix);
+	if (!parser_path)
+		return -ENOMEM;
+
+	ret = kern_path(parser_path, 0, &path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", parser_path);
+		goto out;
+	}
+
+	/* Cannot request a digest cache for the kernel module inode. */
+	if (d_backing_inode(dentry) == d_backing_inode(path.dentry)) {
+		pr_debug("Cannot request a digest cache for kernel module %s\n",
+			 dentry->d_name.name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	file = kernel_file_open(&path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Cannot open %s\n", parser_path);
+		ret = PTR_ERR(file);
+		goto out_path;
+	}
+
+	/* Mark the file descriptor as ours. */
+	digest_cache_to_file_sec(file, digest_cache);
+
+	ret = ksys_finit_module(file, "", flags);
+	if (ret < 0)
+		pr_debug("Cannot load module %s\n", parser_path);
+
+	fput(file);
+out_path:
+	path_put(&path);
+out:
+	kfree(parser_path);
+	return ret;
+}
+
+/**
+ * lookup_get_parser - Lookup and get parser among registered ones
+ * @name: Name of the parser to search
+ *
+ * This function searches a parser among the registered ones, and returns it
+ * to the caller, after incrementing the kernel module reference count.
+ *
+ * Must be called with parser_mutex held.
+ *
+ * Return: A parser structure if parser is found and available, NULL otherwise.
+ */
+static struct parser *lookup_get_parser(const char *name)
+{
+	struct parser *entry, *found = NULL;
+
+	list_for_each_entry(entry, &parsers, list) {
+		if (!strcmp(entry->name, name) &&
+		    try_module_get(entry->owner)) {
+			found = entry;
+			break;
+		}
+	}
+
+	return found;
+}
+
+/**
+ * put_parser - Put parser
+ * @parser: Parser to put
+ *
+ * This function decreases the kernel module reference count.
+ */
+static void put_parser(struct parser *parser)
+{
+	module_put(parser->owner);
+}
+
+/**
+ * digest_cache_parse_digest_list - Parse a digest list
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_cache: Digest cache
+ * @path_str: Path string of the digest list
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function selects a parser for a digest list depending on its file name,
+ * and calls the appropriate parsing function. It expects the file name to be
+ * in the format: [<seq num>-]<digest list format>-<digest list name>.
+ * <seq num>- is optional.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_cache_parse_digest_list(struct dentry *dentry,
+				   struct digest_cache *digest_cache,
+				   char *path_str, void *data, size_t data_len)
+{
+	char *filename, *format, *next_sep;
+	struct parser *parser;
+	char format_buf[sizeof(parser->name)];
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
+	if (!next_sep || next_sep - format >= sizeof(format_buf))
+		return ret;
+
+	snprintf(format_buf, sizeof(format_buf), "%.*s",
+		 (int)(next_sep - format), format);
+
+	pr_debug("Parsing %s, format: %s, size: %ld\n", path_str, format_buf,
+		 data_len);
+
+	mutex_lock(&parsers_mutex);
+	parser = lookup_get_parser(format_buf);
+	mutex_unlock(&parsers_mutex);
+
+	if (!parser) {
+		load_parser(dentry, digest_cache, format_buf);
+
+		mutex_lock(&parsers_mutex);
+		parser = lookup_get_parser(format_buf);
+		mutex_unlock(&parsers_mutex);
+
+		if (!parser) {
+			pr_debug("Digest list parser %s not found\n",
+				 format_buf);
+			return -ENOENT;
+		}
+	}
+
+	ret = parser->func(digest_cache, data, data_len);
+	put_parser(parser);
+
+	return ret;
+}
+
+/**
+ * digest_cache_register_parser - Register new parser
+ * @parser: Parser structure to register
+ *
+ * This function searches the parser name among the registered ones and, if not
+ * found, appends the parser to the linked list of parsers.
+ *
+ * Return: Zero on success, -EEXIST if a parser with the same name exists.
+ */
+int digest_cache_register_parser(struct parser *parser)
+{
+	struct parser *p;
+	int ret = 0;
+
+	mutex_lock(&parsers_mutex);
+	p = lookup_get_parser(parser->name);
+	if (p) {
+		put_parser(p);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	list_add_tail(&parser->list, &parsers);
+out:
+	pr_debug("Digest list parser \'%s\' %s registered\n", parser->name,
+		 (ret < 0) ? "cannot be" : "successfully");
+
+	mutex_unlock(&parsers_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(digest_cache_register_parser);
+
+/**
+ * digest_cache_unregister_parser - Unregister parser
+ * @parser: Parser structure to unregister
+ *
+ * This function removes the passed parser from the linked list of parsers.
+ */
+void digest_cache_unregister_parser(struct parser *parser)
+{
+	mutex_lock(&parsers_mutex);
+	list_del(&parser->list);
+	mutex_unlock(&parsers_mutex);
+
+	pr_debug("Digest list parser \'%s\' successfully unregistered\n",
+		 parser->name);
+}
+EXPORT_SYMBOL_GPL(digest_cache_unregister_parser);
-- 
2.47.0.118.gfd3785337b


