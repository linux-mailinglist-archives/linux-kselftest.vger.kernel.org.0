Return-Path: <linux-kselftest+bounces-4137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F2849A38
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BE3B232F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800E1BF3A;
	Mon,  5 Feb 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XDgZsiuR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1D1BC27;
	Mon,  5 Feb 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136176; cv=none; b=JGvVso7Tt71OEv/ufmm8TG20xlVjl/wWQ4tj4jVMBRjbAxayaL+Ku4Ezy07kUcJv2wJTxFmmtpqrnCs7IRTlxCEcipg2vf+TvglYpaA1YCNdwiNHYwyQlPTkD28NYka9HGInsxhotqbFPPURwJvRvxoRvwuJ5ZpRfQnoEoJUYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136176; c=relaxed/simple;
	bh=7LWJOgSsbE9Tz0u82XR81h/HxkNcMRMi4AFu6KAqzgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCfsX60Xv16m54VPDfIdkhINZwsH+nRxqCyqTK7B6Fdmjnp9lB114ITDXegJqv310qsRYECPDdePWs19Q6oE4K2RLFJrUaQJ8KTtxCzbz96/4j0ZP4u0UJDG5M9XNc5fYDvXPwZMl5UOEBS1FVyrGAZsPsJ2f4KGS8CKCpr/RS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XDgZsiuR; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707136168; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1+kABUfx6NozQnQFXevzdOANiuiVrg0avKW10iKIyDU=;
	b=XDgZsiuR5RyF4wq/KeBus7mzCvt+hEP0+3TU0MoOQTSeoS3GE31TDcLb7K5zzvYiFWcE3FMcX11LUrreKrhkuxz4eEL6zd16US31MyESzSi4jVN6Ub61or5MtH0yOVICJEfe4VS+bUsXzW4pqrKddIkuhUKzJFftHEtx6iGJUKg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W0AVhOl_1707136163;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0AVhOl_1707136163)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:29:28 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 1/3] pstore: add multi-backend support
Date: Mon,  5 Feb 2024 20:28:50 +0800
Message-Id: <20240205122852.7069-2-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205122852.7069-1-xiangzao@linux.alibaba.com>
References: <20240205122852.7069-1-xiangzao@linux.alibaba.com>
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

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 fs/pstore/ftrace.c     |  29 +++++-
 fs/pstore/inode.c      |  19 ++--
 fs/pstore/internal.h   |   4 +-
 fs/pstore/platform.c   | 225 ++++++++++++++++++++++++++++-------------
 fs/pstore/pmsg.c       |  24 ++++-
 include/linux/pstore.h |  29 ++++++
 6 files changed, 248 insertions(+), 82 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..2532a663aa2c 100644
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
+				       struct ftrace_info *psinfo)
 {
 	int bit;
 	unsigned long flags;
@@ -57,6 +58,20 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
+static void notrace pstore_ftrace_call(unsigned long ip,
+				       unsigned long parent_ip,
+				       struct ftrace_ops *op,
+				       struct pt_regs *regs)
+{
+	struct pstore_info_list *entry;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
+			pstore_do_ftrace(ip, parent_ip, op, regs, entry->psi);
+	rcu_read_unlock();
+}
+
 static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
 	.func	= pstore_ftrace_call,
 };
@@ -131,8 +146,14 @@ MODULE_PARM_DESC(record_ftrace,
 
 void pstore_register_ftrace(void)
 {
-	if (!psinfo->write)
-		return;
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
+			if (!entry->psi->write) {
+				rcu_read_unlock();
+				return;
+			}
+	rcu_read_unlock();
 
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
index 03425928d2fb..432a41852a07 100644
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
@@ -104,7 +104,7 @@ static void *compress_workspace;
  */
 #define DMESG_COMP_PERCENT	60
 
-static char *big_oops_buf;
+static char *big_oops_buf[PSTORE_BACKEND_NUM];
 static size_t max_compressed_size;
 
 void pstore_set_kmsg_bytes(int bytes)
@@ -201,7 +201,7 @@ static int pstore_compress(const void *in, void *out,
 	return zstream.total_out;
 }
 
-static void allocate_buf_for_compression(void)
+static void allocate_buf_for_compression(struct pstore_info *psinfo, int pos)
 {
 	size_t compressed_size;
 	char *buf;
@@ -241,21 +241,21 @@ static void allocate_buf_for_compression(void)
 	}
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
-	big_oops_buf = buf;
+	big_oops_buf[pos] = buf;
 	max_compressed_size = compressed_size;
 
 	pr_info("Using crash dump compression: %s\n", compress);
 }
 
-static void free_buf_for_compression(void)
+static void free_buf_for_compression(int pos)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress_workspace) {
 		vfree(compress_workspace);
 		compress_workspace = NULL;
 	}
 
-	kvfree(big_oops_buf);
-	big_oops_buf = NULL;
+	kvfree(big_oops_buf[pos]);
+	big_oops_buf[pos] = NULL;
 	max_compressed_size = 0;
 }
 
@@ -274,8 +274,9 @@ void pstore_record_init(struct pstore_record *record,
  * callback from kmsg_dump. Save as much as we can (up to kmsg_bytes) from the
  * end of the buffer.
  */
-static void pstore_dump(struct kmsg_dumper *dumper,
-			enum kmsg_dump_reason reason)
+static void pstore_do_dump(struct kmsg_dumper *dumper,
+			enum kmsg_dump_reason reason,
+			struct pstore_info *psinfo, int pos)
 {
 	struct kmsg_dump_iter iter;
 	unsigned long	total = 0;
@@ -315,7 +316,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.part = part;
 		record.buf = psinfo->buf;
 
-		dst = big_oops_buf ?: psinfo->buf;
+		dst = big_oops_buf[pos] ?: psinfo->buf;
 		dst_size = max_compressed_size ?: psinfo->bufsize;
 
 		/* Write dump header. */
@@ -328,7 +329,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 					  dst_size, &dump_size))
 			break;
 
-		if (big_oops_buf) {
+		if (big_oops_buf[pos]) {
 			zipped_len = pstore_compress(dst, psinfo->buf,
 						header_size + dump_size,
 						psinfo->bufsize);
@@ -372,6 +373,19 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	}
 }
 
+static void pstore_dump(struct kmsg_dumper *dumper,
+			enum kmsg_dump_reason reason)
+{
+	struct pstore_info_list *entry;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_DMESG)
+			pstore_do_dump(dumper, reason,
+				       entry->psi, entry->index);
+	rcu_read_unlock();
+}
+
 static struct kmsg_dumper pstore_dumper = {
 	.dump = pstore_dump,
 };
@@ -390,13 +404,11 @@ static void pstore_unregister_kmsg(void)
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
 
@@ -405,6 +417,21 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
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
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_CONSOLE)
+			pstore_console_do_write(con, s, c, entry->psi);
+	rcu_read_unlock();
+}
+
 static struct console pstore_console = {
 	.write	= pstore_console_write,
 	.index	= -1,
@@ -413,7 +440,7 @@ static struct console pstore_console = {
 static void pstore_register_console(void)
 {
 	/* Show which backend is going to get console writes. */
-	strscpy(pstore_console.name, psinfo->name,
+	strscpy(pstore_console.name, "pstore console",
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
@@ -464,12 +491,15 @@ static int pstore_write_user_compat(struct pstore_record *record,
  */
 int pstore_register(struct pstore_info *psi)
 {
+	struct pstore_info_list *entry;
+	struct pstore_info_list *newpsi;
 	char *new_backend;
 
-	if (backend && strcmp(backend, psi->name)) {
-		pr_warn("backend '%s' already in use: ignoring '%s'\n",
-			backend, psi->name);
-		return -EBUSY;
+	/* backend has to be enabled for going on registering */
+	if (backend && !strstr(backend, psi->name) &&
+	    strcmp(backend, "all")) {
+		pr_warn("backend '%s' not enabled\n", psi->name);
+		return -EINVAL;
 	}
 
 	/* Sanity check flags. */
@@ -486,79 +516,118 @@ int pstore_register(struct pstore_info *psi)
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
+		pr_warn("no backend enabled, registering backend '%s'\n",
+			psi->name);
+		new_backend = kstrdup(psi->name, GFP_KERNEL);
+		if (!new_backend) {
+			mutex_unlock(&psback_lock);
+			return -ENOMEM;
+		}
+	}
+
+	if (psback) {
+		if (psback->flag == PSTORE_LIST_FULL) {
+			pr_warn("backend registration space is used up: "
+				"ignoring '%s'\n", psi->name);
+			mutex_unlock(&psback_lock);
+			return -EBUSY;
+		}
+		list_for_each_entry(entry, &psback->list_entry, list) {
+			if (strcmp(entry->psi->name, psi->name) == 0) {
+				pr_warn("backend '%s' already loaded\n",
+					psi->name);
+				mutex_unlock(&psback_lock);
+				return -EPERM;
+			}
+		}
+	} else {
+		psback = kzalloc(sizeof(*psback), GFP_KERNEL);
+		INIT_LIST_HEAD(&psback->list_entry);
 	}
 
 	if (!psi->write_user)
 		psi->write_user = pstore_write_user_compat;
-	psinfo = psi;
-	mutex_init(&psinfo->read_mutex);
-	spin_lock_init(&psinfo->buf_lock);
+	newpsi = kzalloc(sizeof(*newpsi), GFP_KERNEL);
+	newpsi->psi = psi;
+	newpsi->index = ffz(psback->flag);
+	psback->flag |= (1 << newpsi->index);
+
+	mutex_init(&psi->read_mutex);
+	spin_lock_init(&psi->buf_lock);
+
+	if (psi->flags & PSTORE_FLAGS_DMESG &&
+	    !psback->front_cnt[PSTORE_TYPE_DMESG])
+		allocate_buf_for_compression(psi, newpsi->index);
 
-	if (psi->flags & PSTORE_FLAGS_DMESG)
-		allocate_buf_for_compression();
+	pstore_get_records(psi, 0);
 
-	pstore_get_records(0);
+	list_add_rcu(&newpsi->list, &psback->list_entry);
 
-	if (psi->flags & PSTORE_FLAGS_DMESG) {
-		pstore_dumper.max_reason = psinfo->max_reason;
+	if (psi->flags & PSTORE_FLAGS_DMESG &&
+	    !psback->front_cnt[PSTORE_TYPE_DMESG]++) {
+		pstore_dumper.max_reason = psi->max_reason;
 		pstore_register_kmsg();
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
+	struct pstore_info_list *entry;
 	/* It's okay to unregister nothing. */
 	if (!psi)
 		return;
 
-	mutex_lock(&psinfo_lock);
-
-	/* Only one backend can be registered at a time. */
-	if (WARN_ON(psi != psinfo)) {
-		mutex_unlock(&psinfo_lock);
+	/* Can not unregister an unenabled backend*/
+	if (WARN_ON(!strstr(backend, psi->name) && strcmp(backend, "all")))
 		return;
-	}
+
+	mutex_lock(&psback_lock);
 
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
+	if (psi->flags & PSTORE_FLAGS_DMESG &&
+	    !--psback->front_cnt[PSTORE_TYPE_DMESG])
 		pstore_unregister_kmsg();
 
 	/* Stop timer and make sure all work has finished. */
@@ -568,19 +637,30 @@ void pstore_unregister(struct pstore_info *psi)
 	/* Remove all backend records from filesystem tree. */
 	pstore_put_backend_records(psi);
 
-	free_buf_for_compression();
+	list_for_each_entry(entry, &psback->list_entry, list) {
+		if (entry->psi == psi) {
+			list_del_rcu(&entry->list);
+			psback->flag ^= 1 << entry->index;
+			synchronize_rcu();
+			free_buf_for_compression(entry->index);
+			kfree(entry);
+			break;
+		}
+	}
 
-	psinfo = NULL;
-	kfree(backend);
-	backend = NULL;
+	if (psback->flag == PSOTRE_LIST_EMPTY) {
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
@@ -697,7 +777,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 			break;
 		}
 
-		decompress_record(record, &zstream);
+		decompress_record(record, &zstream, psi);
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
@@ -729,7 +809,12 @@ void pstore_get_backend_records(struct pstore_info *psi,
 
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
@@ -745,11 +830,15 @@ static void pstore_timefunc(struct timer_list *unused)
 static int __init pstore_init(void)
 {
 	int ret;
+	struct pstore_info_list *entry;
 
 	ret = pstore_init_fs();
-	if (ret)
-		free_buf_for_compression();
-
+	if (ret) {
+		mutex_lock(&psback_lock);
+		list_for_each_entry(entry, &psback->list_entry, list)
+			free_buf_for_compression(entry->index);
+		mutex_unlock(&psback_lock);
+	}
 	return ret;
 }
 late_initcall(pstore_init);
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 55f139afa327..9d5b8602e273 100644
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
@@ -34,6 +35,25 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	return ret ? ret : count;
 }
 
+static ssize_t write_pmsg(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	int ret, _ret;
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list) {
+		if (entry->psi->flags & PSTORE_FLAGS_PMSG) {
+			_ret = do_write_pmsg(file, buf, count,
+					     ppos, entry->psi);
+			ret = ret > _ret ? ret : _ret;
+		}
+	}
+	mutex_unlock(&psback_lock);
+
+	return ret;
+}
+
 static const struct file_operations pmsg_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= noop_llseek,
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..0d2be20c8929 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -201,6 +201,35 @@ struct pstore_info {
 	int		(*erase)(struct pstore_record *record);
 };
 
+/* Supported multibackends */
+#define PSTORE_MAX_BACKEND_LENGTH 100
+#define PSTORE_BACKEND_NUM 16
+
+#define PSTORE_LIST_FULL (BIT(PSTORE_BACKEND_NUM) - 1)
+#define PSOTRE_LIST_EMPTY 0
+
+extern struct mutex psback_lock;
+
+struct pstore_info_list {
+	struct pstore_info *psi;
+	struct list_head list;
+	int index;
+};
+
+/**
+ * struct pstore_backends - management of pstore backends
+ * @list_entry:	entry of pstore backend driver information list
+ * @front_cnt:	count of each enabled frontend
+ * @flag:	bitmap of enabled pstore backend
+ *
+ */
+
+struct pstore_backends {
+	struct list_head list_entry;
+	int front_cnt[PSTORE_TYPE_MAX];
+	u16 flag;
+};
+
 /* Supported frontends */
 #define PSTORE_FLAGS_DMESG	BIT(0)
 #define PSTORE_FLAGS_CONSOLE	BIT(1)
-- 
2.39.3


