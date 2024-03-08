Return-Path: <linux-kselftest+bounces-6083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C5875CA0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 04:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C81628261C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC0529403;
	Fri,  8 Mar 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bh6o2bGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFD2C1A4;
	Fri,  8 Mar 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867855; cv=none; b=uCR6YE9W2KQdsri/Q8oehvfq3G2BiVkTBTLq+eRQRTGsjpILIY+NJHbKJDzm+JJvQsG+wspFT4gSuxq+YsJ6wgaM6Uhlaj2+Ap9guyyqOMbwcSCa8lGBuio90MVgfQ788b2IVdmURZJk9XPfxn+d/VuFSyM+w1vt8f0mmA9lYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867855; c=relaxed/simple;
	bh=6/pqmKcTfJ7ZjlboslE8k27C7M3/b7WwzJYIfVZWS/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=so6RFHG2xDoE2oJGAaYCdDD9IrQ5QJTz+jh8SGlh7bsYKMvaeJCtgL7ihTfnVT4rS8NUWxBK1kTcH8ZaXSqVeIBnwfGCDe2KPFNbqdqF8Oi9n+RmX/eHFWkfYI8xMS4ucvKXlLkx17sFpDlosHA25npyNd9Q4ha3nY8qF4jJ+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bh6o2bGM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709867848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cPdBhsvbS8W8tho97vnnqzeb+LNT+QyvYIcFFv0J5F8=;
	b=bh6o2bGMtkrXsEykPtnExJ5ohPTOChr+7UGDacBAwIge2xs/k3U0N/DN0EodpaFvwh6/ZEnBQrLp7b0Y7ns/KDmA8SaNGgUvA+zGN7QrCkxnov0tfZFui0d1ntIg5HfNhB2g6tKgtP/EMoNyOJFIIzRRtWTUv+L1RLDv8r3UvZE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21N1LN_1709867842;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W21N1LN_1709867842)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 11:17:27 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	yixingrui@linux.alibaba.com,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/4] pstore: add multi-backend support
Date: Fri,  8 Mar 2024 11:16:53 +0800
Message-Id: <20240308031656.9672-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
References: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pstore supports only one backend open at a time.
Specifically, due to the global variable "psinfo", pstore only accepts
the first registered backend. If a new backend wants to register later,
pstore will simply reject it and return an error. This design forced us
to close existing backend in order to use the new ones.

To enable pstore to support multiple backends, "psinfo" is replaced by
"psinfo_list", a list that holds multiple "psinfo". If multiple backends
are registered with the same frontend, the frontend is reused.

User can specify multiple backends that are allowed to be registered by
module parameter "pstore.backend=" separated by commas or "all" to
enable all available backends. If no pstore.backend was specified,
pstore would accept the first registered backend which is the same as
before.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
---
 fs/pstore/ftrace.c     |  27 +++-
 fs/pstore/inode.c      |  19 ++-
 fs/pstore/internal.h   |   4 +-
 fs/pstore/platform.c   | 279 +++++++++++++++++++++++++++--------------
 fs/pstore/pmsg.c       |  27 +++-
 include/linux/pstore.h |  23 ++++
 6 files changed, 271 insertions(+), 108 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..a4fd0aa0efb5 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -23,10 +23,11 @@
 /* This doesn't need to be atomic: speed is chosen over correctness here. */
 static u64 pstore_ftrace_stamp;
 
-static void notrace pstore_ftrace_call(unsigned long ip,
+static void notrace pstore_do_ftrace(unsigned long ip,
 				       unsigned long parent_ip,
 				       struct ftrace_ops *op,
-				       struct ftrace_regs *fregs)
+				       struct ftrace_regs *fregs,
+				       struct pstore_info *psinfo)
 {
 	int bit;
 	unsigned long flags;
@@ -57,6 +58,20 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
+static void notrace pstore_ftrace_call(unsigned long ip,
+				       unsigned long parent_ip,
+				       struct ftrace_ops *op,
+				       struct ftrace_regs *fregs)
+{
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
+			pstore_do_ftrace(ip, parent_ip, op, fregs, entry->psi);
+	mutex_unlock(&psback_lock);
+}
+
 static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
 	.func	= pstore_ftrace_call,
 };
@@ -131,8 +146,12 @@ MODULE_PARM_DESC(record_ftrace,
 
 void pstore_register_ftrace(void)
 {
-	if (!psinfo->write)
-		return;
+	struct pstore_info_list *entry;
+
+	list_for_each_entry(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
+			if (!entry->psi->write)
+				return;
 
 	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
 
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d0d9bfdad30c..bee71c7da995 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -285,7 +285,7 @@ static const struct super_operations pstore_ops = {
 	.show_options	= pstore_show_options,
 };
 
-static struct dentry *psinfo_lock_root(void)
+static struct dentry *psinfo_lock_root(struct pstore_info *psinfo)
 {
 	struct dentry *root;
 
@@ -309,7 +309,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	struct dentry *root;
 	int rc = 0;
 
-	root = psinfo_lock_root();
+	root = psinfo_lock_root(psi);
 	if (!root)
 		return 0;
 
@@ -398,21 +398,22 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
  * when we are re-scanning the backing store looking to add new
  * error records.
  */
-void pstore_get_records(int quiet)
+void pstore_get_records(struct pstore_info *psi, int quiet)
 {
 	struct dentry *root;
 
-	root = psinfo_lock_root();
+	root = psinfo_lock_root(psi);
 	if (!root)
 		return;
 
-	pstore_get_backend_records(psinfo, root, quiet);
+	pstore_get_backend_records(psi, root, quiet);
 	inode_unlock(d_inode(root));
 }
 
 static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
+	struct pstore_info_list *entry;
 
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_blocksize		= PAGE_SIZE;
@@ -437,7 +438,13 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	scoped_guard(mutex, &pstore_sb_lock)
 		pstore_sb = sb;
 
-	pstore_get_records(0);
+	if (!psback)
+		return 0;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		pstore_get_records(entry->psi, 0);
+	mutex_unlock(&psback_lock);
 
 	return 0;
 }
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 801d6c0b170c..4b1c7ba27052 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -33,10 +33,10 @@ static inline void pstore_register_pmsg(void) {}
 static inline void pstore_unregister_pmsg(void) {}
 #endif
 
-extern struct pstore_info *psinfo;
+extern struct pstore_backends *psback;
 
 extern void	pstore_set_kmsg_bytes(int);
-extern void	pstore_get_records(int);
+extern void	pstore_get_records(struct pstore_info *psi, int quiet);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
 					   struct dentry *root, int quiet);
 extern int	pstore_put_backend_records(struct pstore_info *psi);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03425928d2fb..a1742b39fb88 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -62,12 +62,12 @@ static void pstore_dowork(struct work_struct *);
 static DECLARE_WORK(pstore_work, pstore_dowork);
 
 /*
- * psinfo_lock protects "psinfo" during calls to
+ * psback_lock protects "psback" during calls to
  * pstore_register(), pstore_unregister(), and
  * the filesystem mount/unmount routines.
  */
-static DEFINE_MUTEX(psinfo_lock);
-struct pstore_info *psinfo;
+DEFINE_MUTEX(psback_lock);
+struct pstore_backends *psback;
 
 static char *backend;
 module_param(backend, charp, 0444);
@@ -104,9 +104,6 @@ static void *compress_workspace;
  */
 #define DMESG_COMP_PERCENT	60
 
-static char *big_oops_buf;
-static size_t max_compressed_size;
-
 void pstore_set_kmsg_bytes(int bytes)
 {
 	kmsg_bytes = bytes;
@@ -201,7 +198,7 @@ static int pstore_compress(const void *in, void *out,
 	return zstream.total_out;
 }
 
-static void allocate_buf_for_compression(void)
+static void allocate_buf_for_compression(struct pstore_info_list *entry)
 {
 	size_t compressed_size;
 	char *buf;
@@ -224,11 +221,11 @@ static void allocate_buf_for_compression(void)
 	 * uncompressed record size, since any record that would be expanded by
 	 * compression is just stored uncompressed.
 	 */
-	compressed_size = (psinfo->bufsize * 100) / DMESG_COMP_PERCENT;
+	compressed_size = (entry->psi->bufsize * 100) / DMESG_COMP_PERCENT;
 	buf = kvzalloc(compressed_size, GFP_KERNEL);
 	if (!buf) {
 		pr_err("Failed %zu byte compression buffer allocation for: %s\n",
-		       psinfo->bufsize, compress);
+		       entry->psi->bufsize, compress);
 		return;
 	}
 
@@ -241,22 +238,22 @@ static void allocate_buf_for_compression(void)
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
-	big_oops_buf = buf;
-	max_compressed_size = compressed_size;
+	entry->big_oops_buf = buf;
+	entry->max_compressed_size = compressed_size;
 
 	pr_info("Using crash dump compression: %s\n", compress);
 }
 
-static void free_buf_for_compression(void)
+static void free_buf_for_compression(struct pstore_info_list *entry)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress_workspace) {
 		vfree(compress_workspace);
 		compress_workspace = NULL;
 	}
 
-	kvfree(big_oops_buf);
-	big_oops_buf = NULL;
-	max_compressed_size = 0;
+	kvfree(entry->big_oops_buf);
+	entry->big_oops_buf = NULL;
+	entry->max_compressed_size = 0;
 }
 
 void pstore_record_init(struct pstore_record *record,
@@ -278,6 +275,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 			enum kmsg_dump_reason reason)
 {
 	struct kmsg_dump_iter iter;
+	struct pstore_info_list *entry;
 	unsigned long	total = 0;
 	const char	*why;
 	unsigned int	part = 1;
@@ -285,16 +283,18 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	int		saved_ret = 0;
 	int		ret;
 
+	entry = container_of(dumper, struct pstore_info_list, pstore_dumper);
+
 	why = kmsg_dump_reason_str(reason);
 
 	if (pstore_cannot_block_path(reason)) {
-		if (!spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
+		if (!spin_trylock_irqsave(&entry->psi->buf_lock, flags)) {
 			pr_err("dump skipped in %s path because of concurrent dump\n",
 					in_nmi() ? "NMI" : why);
 			return;
 		}
 	} else {
-		spin_lock_irqsave(&psinfo->buf_lock, flags);
+		spin_lock_irqsave(&entry->psi->buf_lock, flags);
 	}
 
 	kmsg_dump_rewind(&iter);
@@ -308,15 +308,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		size_t dump_size;
 		struct pstore_record record;
 
-		pstore_record_init(&record, psinfo);
+		pstore_record_init(&record, entry->psi);
 		record.type = PSTORE_TYPE_DMESG;
 		record.count = oopscount;
 		record.reason = reason;
 		record.part = part;
-		record.buf = psinfo->buf;
+		record.buf = entry->psi->buf;
 
-		dst = big_oops_buf ?: psinfo->buf;
-		dst_size = max_compressed_size ?: psinfo->bufsize;
+		dst = entry->big_oops_buf ?: entry->psi->buf;
+		dst_size = entry->max_compressed_size ?: entry->psi->bufsize;
 
 		/* Write dump header. */
 		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
@@ -328,10 +328,10 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 					  dst_size, &dump_size))
 			break;
 
-		if (big_oops_buf) {
-			zipped_len = pstore_compress(dst, psinfo->buf,
+		if (entry->big_oops_buf) {
+			zipped_len = pstore_compress(dst, entry->psi->buf,
 						header_size + dump_size,
-						psinfo->bufsize);
+						entry->psi->bufsize);
 
 			if (zipped_len > 0) {
 				record.compressed = true;
@@ -344,14 +344,14 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 				 * of the uncompressed data as possible into
 				 * the pstore record, and discard the rest.
 				 */
-				record.size = psinfo->bufsize;
-				memcpy(psinfo->buf, dst, psinfo->bufsize);
+				record.size = entry->psi->bufsize;
+				memcpy(entry->psi->buf, dst, entry->psi->bufsize);
 			}
 		} else {
 			record.size = header_size + dump_size;
 		}
 
-		ret = psinfo->write(&record);
+		ret = entry->psi->write(&record);
 		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
 			pstore_new_entry = 1;
 			pstore_timer_kick();
@@ -364,39 +364,33 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		total += record.size;
 		part++;
 	}
-	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
+	spin_unlock_irqrestore(&entry->psi->buf_lock, flags);
 
 	if (saved_ret) {
-		pr_err_once("backend (%s) writing error (%d)\n", psinfo->name,
+		pr_err_once("backend (%s) writing error (%d)\n", entry->psi->name,
 			    saved_ret);
 	}
 }
 
-static struct kmsg_dumper pstore_dumper = {
-	.dump = pstore_dump,
-};
-
 /*
  * Register with kmsg_dump to save last part of console log on panic.
  */
-static void pstore_register_kmsg(void)
+static void pstore_register_kmsg(struct kmsg_dumper *pstore_dumper)
 {
-	kmsg_dump_register(&pstore_dumper);
+	kmsg_dump_register(pstore_dumper);
 }
 
-static void pstore_unregister_kmsg(void)
+static void pstore_unregister_kmsg(struct kmsg_dumper *pstore_dumper)
 {
-	kmsg_dump_unregister(&pstore_dumper);
+	kmsg_dump_unregister(pstore_dumper);
 }
 
 #ifdef CONFIG_PSTORE_CONSOLE
-static void pstore_console_write(struct console *con, const char *s, unsigned c)
+static void pstore_console_do_write(struct console *con, const char *s,
+				    unsigned c, struct pstore_info *psinfo)
 {
 	struct pstore_record record;
 
-	if (!c)
-		return;
-
 	pstore_record_init(&record, psinfo);
 	record.type = PSTORE_TYPE_CONSOLE;
 
@@ -405,6 +399,21 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 	psinfo->write(&record);
 }
 
+static void pstore_console_write(struct console *con, const char *s,
+				 unsigned int c)
+{
+	struct pstore_info_list *entry;
+
+	if (!c)
+		return;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_CONSOLE)
+			pstore_console_do_write(con, s, c, entry->psi);
+	mutex_unlock(&psback_lock);
+}
+
 static struct console pstore_console = {
 	.write	= pstore_console_write,
 	.index	= -1,
@@ -413,7 +422,7 @@ static struct console pstore_console = {
 static void pstore_register_console(void)
 {
 	/* Show which backend is going to get console writes. */
-	strscpy(pstore_console.name, psinfo->name,
+	strscpy(pstore_console.name, "pstore console",
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
@@ -455,6 +464,33 @@ static int pstore_write_user_compat(struct pstore_record *record,
 	return unlikely(ret < 0) ? ret : record->size;
 }
 
+static bool is_backend_enabled(char *backend, const char *name)
+{
+	char *sep, *backend_name;
+
+	if (!backend || strcmp(backend, "all") == 0)
+		return true;
+	else {
+		sep = kstrdup(backend, GFP_KERNEL);
+		while ((backend_name = strsep(&sep, ",")) != NULL) {
+			if (strcmp(name, backend_name) == 0)
+				return true;
+		}
+	}
+	return false;
+}
+
+static bool is_backend_loaded(const char *name)
+{
+	struct pstore_info_list *entry;
+
+	list_for_each_entry(entry, &psback->list_entry, list)
+		if (strcmp(entry->psi->name, name) == 0)
+			return true;
+
+	return false;
+}
+
 /*
  * platform specific persistent storage driver registers with
  * us here. If pstore is already mounted, call the platform
@@ -464,12 +500,14 @@ static int pstore_write_user_compat(struct pstore_record *record,
  */
 int pstore_register(struct pstore_info *psi)
 {
+	struct pstore_info_list *newpsi;
 	char *new_backend;
 
-	if (backend && strcmp(backend, psi->name)) {
-		pr_warn("backend '%s' already in use: ignoring '%s'\n",
-			backend, psi->name);
-		return -EBUSY;
+	/* backend has to be in pstore.backend for going on registering */
+	if (!is_backend_enabled(backend, psi->name)) {
+		pr_warn("backend '%s' ignored: not present in "
+			"pstore.backend=...\n", psi->name);
+		return -EINVAL;
 	}
 
 	/* Sanity check flags. */
@@ -486,80 +524,125 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
-	new_backend = kstrdup(psi->name, GFP_KERNEL);
-	if (!new_backend)
-		return -ENOMEM;
-
-	mutex_lock(&psinfo_lock);
-	if (psinfo) {
-		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
-			psinfo->name, psi->name);
-		mutex_unlock(&psinfo_lock);
-		kfree(new_backend);
-		return -EBUSY;
+	mutex_lock(&psback_lock);
+
+	/*
+	 * If no backend specified, first come first served to
+	 * maintain backward compatibility
+	 */
+	if (!backend) {
+		new_backend = kstrdup(psi->name, GFP_KERNEL);
+		if (!new_backend) {
+			mutex_unlock(&psback_lock);
+			return -ENOMEM;
+		}
+		pr_warn("pstore.backend=... not specified, "
+			"registering first available: '%s'\n",
+			psi->name);
+	}
+
+	if (psback) {
+		if (is_backend_loaded(psi->name)) {
+			pr_warn("backend '%s' already loaded; "
+				"not loading it again\n", psi->name);
+			mutex_unlock(&psback_lock);
+			return -EPERM;
+		}
+	} else {
+		psback = kzalloc(sizeof(*psback), GFP_KERNEL);
+		if (!psback) {
+			mutex_unlock(&psback_lock);
+			return -ENOMEM;
+		}
+		INIT_LIST_HEAD(&psback->list_entry);
 	}
 
 	if (!psi->write_user)
 		psi->write_user = pstore_write_user_compat;
-	psinfo = psi;
-	mutex_init(&psinfo->read_mutex);
-	spin_lock_init(&psinfo->buf_lock);
+
+	newpsi = kzalloc(sizeof(*newpsi), GFP_KERNEL);
+	if (!newpsi) {
+		mutex_unlock(&psback_lock);
+		return -EPERM;
+	}
+	newpsi->psi = psi;
+
+	mutex_init(&psi->read_mutex);
+	spin_lock_init(&psi->buf_lock);
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
-		allocate_buf_for_compression();
+		allocate_buf_for_compression(newpsi);
 
-	pstore_get_records(0);
+	pstore_get_records(psi, 0);
+
+	list_add(&newpsi->list, &psback->list_entry);
 
 	if (psi->flags & PSTORE_FLAGS_DMESG) {
-		pstore_dumper.max_reason = psinfo->max_reason;
-		pstore_register_kmsg();
+		newpsi->pstore_dumper.dump = pstore_dump;
+		newpsi->pstore_dumper.max_reason = psi->max_reason;
+		pstore_register_kmsg(&newpsi->pstore_dumper);
 	}
-	if (psi->flags & PSTORE_FLAGS_CONSOLE)
+	if (psi->flags & PSTORE_FLAGS_CONSOLE
+	    && !psback->front_cnt[PSTORE_TYPE_CONSOLE]++)
 		pstore_register_console();
-	if (psi->flags & PSTORE_FLAGS_FTRACE)
+	if (psi->flags & PSTORE_FLAGS_FTRACE &&
+	    !psback->front_cnt[PSTORE_TYPE_FTRACE]++)
 		pstore_register_ftrace();
-	if (psi->flags & PSTORE_FLAGS_PMSG)
+	if (psi->flags & PSTORE_FLAGS_PMSG &&
+	    !psback->front_cnt[PSTORE_TYPE_PMSG]++)
 		pstore_register_pmsg();
 
 	/* Start watching for new records, if desired. */
 	pstore_timer_kick();
 
 	/*
-	 * Update the module parameter backend, so it is visible
+	 * When module parameter backend is not specified,
+	 * update the module parameter backend, so it is visible
 	 * through /sys/module/pstore/parameters/backend
 	 */
-	backend = new_backend;
+	if (!backend)
+		backend = new_backend;
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
-	mutex_unlock(&psinfo_lock);
+	mutex_unlock(&psback_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pstore_register);
 
 void pstore_unregister(struct pstore_info *psi)
 {
+	struct pstore_info_list *entry, *tmp;
+
+	pr_info("Unregistering %s as persistent store backend\n", psi->name);
+
 	/* It's okay to unregister nothing. */
 	if (!psi)
 		return;
 
-	mutex_lock(&psinfo_lock);
+	mutex_lock(&psback_lock);
 
-	/* Only one backend can be registered at a time. */
-	if (WARN_ON(psi != psinfo)) {
-		mutex_unlock(&psinfo_lock);
+	/* Can not unregister an unloaded backend*/
+	if (WARN_ON(!is_backend_loaded(psi->name))) {
+		mutex_unlock(&psback_lock);
 		return;
 	}
 
 	/* Unregister all callbacks. */
-	if (psi->flags & PSTORE_FLAGS_PMSG)
+	if (psi->flags & PSTORE_FLAGS_PMSG &&
+	    !--psback->front_cnt[PSTORE_TYPE_PMSG])
 		pstore_unregister_pmsg();
-	if (psi->flags & PSTORE_FLAGS_FTRACE)
+	if (psi->flags & PSTORE_FLAGS_FTRACE &&
+	    !--psback->front_cnt[PSTORE_TYPE_FTRACE])
 		pstore_unregister_ftrace();
-	if (psi->flags & PSTORE_FLAGS_CONSOLE)
+	if (psi->flags & PSTORE_FLAGS_CONSOLE &&
+	    !--psback->front_cnt[PSTORE_TYPE_CONSOLE])
 		pstore_unregister_console();
-	if (psi->flags & PSTORE_FLAGS_DMESG)
-		pstore_unregister_kmsg();
+	list_for_each_entry(entry, &psback->list_entry, list) {
+		if (entry->psi == psi)
+			if (psi->flags & PSTORE_FLAGS_DMESG)
+				pstore_unregister_kmsg(&entry->pstore_dumper);
+	}
 
 	/* Stop timer and make sure all work has finished. */
 	del_timer_sync(&pstore_timer);
@@ -568,19 +651,28 @@ void pstore_unregister(struct pstore_info *psi)
 	/* Remove all backend records from filesystem tree. */
 	pstore_put_backend_records(psi);
 
-	free_buf_for_compression();
+	list_for_each_entry_safe(entry, tmp, &psback->list_entry, list) {
+		if (entry->psi == psi) {
+			list_del(&entry->list);
+			free_buf_for_compression(entry);
+			kfree(entry);
+			break;
+		}
+	}
 
-	psinfo = NULL;
-	kfree(backend);
-	backend = NULL;
+	if (list_empty(&psback->list_entry)) {
+		kfree(psback);
+		psback = NULL;
+	}
 
 	pr_info("Unregistered %s as persistent store backend\n", psi->name);
-	mutex_unlock(&psinfo_lock);
+	mutex_unlock(&psback_lock);
 }
 EXPORT_SYMBOL_GPL(pstore_unregister);
 
 static void decompress_record(struct pstore_record *record,
-			      struct z_stream_s *zstream)
+			      struct z_stream_s *zstream,
+			      struct pstore_info *psinfo)
 {
 	int ret;
 	int unzipped_len;
@@ -697,7 +789,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 			break;
 		}
 
-		decompress_record(record, &zstream);
+		decompress_record(record, &zstream, psi);
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
@@ -729,7 +821,12 @@ void pstore_get_backend_records(struct pstore_info *psi,
 
 static void pstore_dowork(struct work_struct *work)
 {
-	pstore_get_records(1);
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		pstore_get_records(entry->psi, 1);
+	mutex_unlock(&psback_lock);
 }
 
 static void pstore_timefunc(struct timer_list *unused)
@@ -744,13 +841,7 @@ static void pstore_timefunc(struct timer_list *unused)
 
 static int __init pstore_init(void)
 {
-	int ret;
-
-	ret = pstore_init_fs();
-	if (ret)
-		free_buf_for_compression();
-
-	return ret;
+	return pstore_init_fs();
 }
 late_initcall(pstore_init);
 
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 55f139afa327..facde6a15fc4 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -11,8 +11,9 @@
 
 static DEFINE_MUTEX(pmsg_lock);
 
-static ssize_t write_pmsg(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t do_write_pmsg(struct file *file, const char __user *buf,
+			     size_t count, loff_t *ppos,
+			     struct pstore_info *psinfo)
 {
 	struct pstore_record record;
 	int ret;
@@ -34,6 +35,28 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	return ret ? ret : count;
 }
 
+static ssize_t write_pmsg(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	int ret, written = 0, err = 0;
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list) {
+		if (entry->psi->flags & PSTORE_FLAGS_PMSG) {
+			ret = do_write_pmsg(file, buf, count,
+					     ppos, entry->psi);
+			/* Return the first negative value or max_seen ret */
+			if (!err && ret < 0)
+				err = ret;
+			written = ret > written ? ret : written;
+		}
+	}
+	mutex_unlock(&psback_lock);
+
+	return err ? err :  written;
+}
+
 static const struct file_operations pmsg_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= noop_llseek,
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..f57ce9f50b2b 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -201,6 +201,29 @@ struct pstore_info {
 	int		(*erase)(struct pstore_record *record);
 };
 
+/* Supported multibackends */
+extern struct mutex psback_lock;
+
+struct pstore_info_list {
+	struct pstore_info *psi;
+	char *big_oops_buf;
+	size_t max_compressed_size;
+	struct kmsg_dumper pstore_dumper;
+	struct list_head list;
+};
+
+/**
+ * struct pstore_backends - management of pstore backends
+ * @front_cnt:	count of each enabled frontend
+ * @list_entry:	entry of pstore backend driver information list
+ *
+ */
+
+struct pstore_backends {
+	int front_cnt[PSTORE_TYPE_MAX];
+	struct list_head list_entry;
+};
+
 /* Supported frontends */
 #define PSTORE_FLAGS_DMESG	BIT(0)
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
-- 
2.39.3


