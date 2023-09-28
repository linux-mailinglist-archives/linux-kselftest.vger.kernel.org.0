Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C47B10E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI1Cnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjI1Cnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:53 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82110A;
        Wed, 27 Sep 2023 19:43:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vt.rlHz_1695869026;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlHz_1695869026)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:47 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 2/5] pstore: add multi-backends support
Date:   Thu, 28 Sep 2023 10:42:41 +0800
Message-Id: <20230928024244.257687-3-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, pstore supports only one backend open at a time.
Specifically, due to the global variable "psinfo", pstore only accepts
the first registered backend. If a new backend wants to register later,
pstore will simply reject it and return an error. This design forced us
to close existing backend in order to use the new ones.

To enable pstore to support multiple backends, "psinfo" is replaced by
"psinfo_list", a list that holds multiple "psinfo". If multiple backends
are registered with the same frontend, the frontend is reused.

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 fs/pstore/ftrace.c     |  22 +++-
 fs/pstore/inode.c      |  16 +--
 fs/pstore/internal.h   |   7 +-
 fs/pstore/platform.c   | 224 ++++++++++++++++++++++++++---------------
 fs/pstore/pmsg.c       |  23 ++++-
 fs/pstore/tty.c        |   8 +-
 include/linux/pstore.h |  29 ++++++
 7 files changed, 232 insertions(+), 97 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 776cae20af4e..d3176fb94c95 100644
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
@@ -131,9 +146,6 @@ MODULE_PARM_DESC(record_ftrace,
 
 void pstore_register_ftrace(void)
 {
-	if (!psinfo->write)
-		return;
-
 	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
 
 	pstore_set_ftrace_enabled(record_ftrace);
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index ffbadb8b3032..312e7d55b95f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -288,7 +288,7 @@ static const struct super_operations pstore_ops = {
 	.show_options	= pstore_show_options,
 };
 
-static struct dentry *psinfo_lock_root(void)
+static struct dentry *psinfo_lock_root(struct pstore_info *psinfo)
 {
 	struct dentry *root;
 
@@ -315,7 +315,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	struct dentry *root;
 	int rc = 0;
 
-	root = psinfo_lock_root();
+	root = psinfo_lock_root(psi);
 	if (!root)
 		return 0;
 
@@ -414,21 +414,22 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
  * when we are re-scanning the backing store looking to add new
  * error records.
  */
-void pstore_get_records(int quiet)
+void pstore_get_records(struct pstore_info *psi, int pos, int quiet)
 {
 	struct dentry *root;
 
-	root = psinfo_lock_root();
+	root = psinfo_lock_root(psi);
 	if (!root)
 		return;
 
-	pstore_get_backend_records(psinfo, root, quiet);
+	pstore_get_backend_records(psi, root, quiet, pos);
 	inode_unlock(d_inode(root));
 }
 
 static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
+	struct pstore_info_list *entry;
 
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_blocksize		= PAGE_SIZE;
@@ -454,7 +455,10 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	pstore_sb = sb;
 	mutex_unlock(&pstore_sb_lock);
 
-	pstore_get_records(0);
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		pstore_get_records(entry->psi, entry->index, 0);
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 1205366f0523..7465b5baf002 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -41,12 +41,13 @@ static inline void pstore_register_tty(void) {}
 static inline void pstore_unregister_tty(void) {}
 #endif
 
-extern struct pstore_info *psinfo;
+extern struct pstore_backends *psback;
 
 extern void	pstore_set_kmsg_bytes(int);
-extern void	pstore_get_records(int);
+extern void	pstore_get_records(struct pstore_info *psi, int pos,
+						int quiet);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
-					   struct dentry *root, int quiet);
+					   struct dentry *root, int quiet, int pos);
 extern int	pstore_put_backend_records(struct pstore_info *psi);
 extern int	pstore_mkfile(struct dentry *root,
 			      struct pstore_record *record);
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index a6a1df06cfe1..34fb21e6ff4f 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -70,12 +70,12 @@ static void pstore_dowork(struct work_struct *);
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
@@ -103,8 +103,8 @@ struct pstore_zbackend {
 	const char *name;
 };
 
-static char *big_oops_buf;
-static size_t big_oops_buf_sz;
+static char *big_oops_buf[PSTORE_BACKEND_NUM];
+static size_t big_oops_buf_sz[PSTORE_BACKEND_NUM];
 
 void pstore_set_kmsg_bytes(int bytes)
 {
@@ -285,7 +285,7 @@ static int pstore_compress(const void *in, void *out,
 	return outlen;
 }
 
-static void allocate_buf_for_compression(void)
+static void allocate_buf_for_compression(struct pstore_info *psinfo, int pos)
 {
 	struct crypto_comp *ctx;
 	int size;
@@ -295,8 +295,8 @@ static void allocate_buf_for_compression(void)
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
 		return;
 
-	/* Skip if no pstore backend yet or compression init already done. */
-	if (!psinfo || tfm)
+	/* Skip if no pstore backend yet. */
+	if (!psinfo)
 		return;
 
 	if (!crypto_has_comp(zbackend->name, 0, 0)) {
@@ -328,21 +328,21 @@ static void allocate_buf_for_compression(void)
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
 	tfm = ctx;
-	big_oops_buf_sz = size;
-	big_oops_buf = buf;
+	big_oops_buf_sz[pos] = size;
+	big_oops_buf[pos] = buf;
 
 	pr_info("Using crash dump compression: %s\n", zbackend->name);
 }
 
-static void free_buf_for_compression(void)
+static void free_buf_for_compression(int pos)
 {
 	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
 		crypto_free_comp(tfm);
 		tfm = NULL;
 	}
-	kfree(big_oops_buf);
-	big_oops_buf = NULL;
-	big_oops_buf_sz = 0;
+	kfree(big_oops_buf[pos]);
+	big_oops_buf[pos] = NULL;
+	big_oops_buf_sz[pos] = 0;
 }
 
 /*
@@ -352,7 +352,8 @@ static void free_buf_for_compression(void)
  * printk buffer which results in fetching old contents.
  * Copy the recent messages from big_oops_buf to psinfo->buf
  */
-static size_t copy_kmsg_to_buffer(int hsize, size_t len)
+static size_t copy_kmsg_to_buffer(int hsize, size_t len,
+			   struct pstore_info *psinfo, int pos)
 {
 	size_t total_len;
 	size_t diff;
@@ -361,12 +362,12 @@ static size_t copy_kmsg_to_buffer(int hsize, size_t len)
 
 	if (total_len > psinfo->bufsize) {
 		diff = total_len - psinfo->bufsize + hsize;
-		memcpy(psinfo->buf, big_oops_buf, hsize);
-		memcpy(psinfo->buf + hsize, big_oops_buf + diff,
+		memcpy(psinfo->buf, big_oops_buf[pos], hsize);
+		memcpy(psinfo->buf + hsize, big_oops_buf[pos] + diff,
 					psinfo->bufsize - hsize);
 		total_len = psinfo->bufsize;
 	} else
-		memcpy(psinfo->buf, big_oops_buf, total_len);
+		memcpy(psinfo->buf, big_oops_buf[pos], total_len);
 
 	return total_len;
 }
@@ -386,8 +387,8 @@ void pstore_record_init(struct pstore_record *record,
  * callback from kmsg_dump. Save as much as we can (up to kmsg_bytes) from the
  * end of the buffer.
  */
-static void pstore_dump(struct kmsg_dumper *dumper,
-			enum kmsg_dump_reason reason)
+static void pstore_do_dump(struct kmsg_dumper *dumper,
+			enum kmsg_dump_reason reason, struct pstore_info *psinfo, int pos)
 {
 	struct kmsg_dump_iter iter;
 	unsigned long	total = 0;
@@ -427,9 +428,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.part = part;
 		record.buf = psinfo->buf;
 
-		if (big_oops_buf) {
-			dst = big_oops_buf;
-			dst_size = big_oops_buf_sz;
+		if (big_oops_buf[pos]) {
+			dst = big_oops_buf[pos];
+			dst_size = big_oops_buf_sz[pos];
 		} else {
 			dst = psinfo->buf;
 			dst_size = psinfo->bufsize;
@@ -445,7 +446,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 					  dst_size, &dump_size))
 			break;
 
-		if (big_oops_buf) {
+		if (big_oops_buf[pos]) {
 			zipped_len = pstore_compress(dst, psinfo->buf,
 						header_size + dump_size,
 						psinfo->bufsize);
@@ -455,7 +456,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 				record.size = zipped_len;
 			} else {
 				record.size = copy_kmsg_to_buffer(header_size,
-								  dump_size);
+								  dump_size, psinfo, pos);
 			}
 		} else {
 			record.size = header_size + dump_size;
@@ -482,6 +483,18 @@ static void pstore_dump(struct kmsg_dumper *dumper,
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
+			pstore_do_dump(dumper, reason, entry->psi, entry->index);
+	rcu_read_unlock();
+}
+
 static struct kmsg_dumper pstore_dumper = {
 	.dump = pstore_dump,
 };
@@ -500,13 +513,11 @@ static void pstore_unregister_kmsg(void)
 }
 
 #ifdef CONFIG_PSTORE_CONSOLE
-static void pstore_console_write(struct console *con, const char *s, unsigned c)
+static void pstore_console_do_write(struct console *con, const char *s,
+				unsigned int c, struct pstore_info *psinfo)
 {
 	struct pstore_record record;
 
-	if (!c)
-		return;
-
 	pstore_record_init(&record, psinfo);
 	record.type = PSTORE_TYPE_CONSOLE;
 
@@ -515,6 +526,20 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 	psinfo->write(&record);
 }
 
+static void pstore_console_write(struct console *con, const char *s, unsigned int c)
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
@@ -523,7 +548,7 @@ static struct console pstore_console = {
 static void pstore_register_console(void)
 {
 	/* Show which backend is going to get console writes. */
-	strscpy(pstore_console.name, psinfo->name,
+	strscpy(pstore_console.name, "pstore console",
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
@@ -574,11 +599,8 @@ static int pstore_write_user_compat(struct pstore_record *record,
  */
 int pstore_register(struct pstore_info *psi)
 {
-	if (backend && strcmp(backend, psi->name)) {
-		pr_warn("backend '%s' already in use: ignoring '%s'\n",
-			backend, psi->name);
-		return -EBUSY;
-	}
+	struct pstore_info_list *entry;
+	struct pstore_info_list *newpsi;
 
 	/* Sanity check flags. */
 	if (!psi->flags) {
@@ -594,36 +616,57 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
-	mutex_lock(&psinfo_lock);
-	if (psinfo) {
-		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
-			psinfo->name, psi->name);
-		mutex_unlock(&psinfo_lock);
-		return -EBUSY;
+	mutex_lock(&psback_lock);
+
+	if (psback) {
+		if (psback->flag == PSTORE_LIST_FULL) {
+			pr_warn("registration space is used up: ignoring '%s'\n", psi->name);
+			mutex_unlock(&psback_lock);
+			return -EBUSY;
+		}
+		list_for_each_entry(entry, &psback->list_entry, list) {
+			if (strcmp(entry->psi->name, psi->name) == 0) {
+				pr_warn("backend '%s' already loaded\n", psi->name);
+				mutex_unlock(&psback_lock);
+				return -EPERM;
+			}
+		}
+	}
+
+	if (!psback) {
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
+	INIT_LIST_HEAD(&newpsi->list);
+	psback->flag |= (1 << newpsi->index);
+
+	mutex_init(&psi->read_mutex);
+	spin_lock_init(&psi->buf_lock);
+
+	if (psi->flags & PSTORE_FLAGS_DMESG && !psback->front_cnt[PSTORE_TYPE_DMESG])
+		allocate_buf_for_compression(psi, newpsi->index);
 
-	if (psi->flags & PSTORE_FLAGS_DMESG)
-		allocate_buf_for_compression();
+	pstore_get_records(psi, newpsi->index, 0);
 
-	pstore_get_records(0);
+	list_add_rcu(&newpsi->list, &psback->list_entry);
 
-	if (psi->flags & PSTORE_FLAGS_DMESG) {
-		pstore_dumper.max_reason = psinfo->max_reason;
+	if (psi->flags & PSTORE_FLAGS_DMESG && !psback->front_cnt[PSTORE_TYPE_DMESG]++) {
+		pstore_dumper.max_reason = psi->max_reason;
 		pstore_register_kmsg();
 	}
-	if (psi->flags & PSTORE_FLAGS_CONSOLE)
+	if (psi->flags & PSTORE_FLAGS_CONSOLE && !psback->front_cnt[PSTORE_TYPE_CONSOLE]++)
 		pstore_register_console();
-	if (psi->flags & PSTORE_FLAGS_FTRACE)
+	if (psi->flags & PSTORE_FLAGS_FTRACE && !psback->front_cnt[PSTORE_TYPE_FTRACE]++)
 		pstore_register_ftrace();
-	if (psi->flags & PSTORE_FLAGS_PMSG)
+	if (psi->flags & PSTORE_FLAGS_PMSG && !psback->front_cnt[PSTORE_TYPE_PMSG]++)
 		pstore_register_pmsg();
-	if (psi->flags & PSTORE_FLAGS_TTY)
+	if (psi->flags & PSTORE_FLAGS_TTY && !psback->front_cnt[PSTORE_TYPE_TTY]++)
 		pstore_register_tty();
 
 	/* Start watching for new records, if desired. */
@@ -637,35 +680,30 @@ int pstore_register(struct pstore_info *psi)
 
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
-		return;
-	}
+	mutex_lock(&psback_lock);
 
 	/* Unregister all callbacks. */
-	if (psi->flags & PSTORE_FLAGS_PMSG)
+	if (psi->flags & PSTORE_FLAGS_PMSG && !--psback->front_cnt[PSTORE_TYPE_PMSG])
 		pstore_unregister_pmsg();
-	if (psi->flags & PSTORE_FLAGS_FTRACE)
+	if (psi->flags & PSTORE_FLAGS_FTRACE && !--psback->front_cnt[PSTORE_TYPE_FTRACE])
 		pstore_unregister_ftrace();
-	if (psi->flags & PSTORE_FLAGS_CONSOLE)
+	if (psi->flags & PSTORE_FLAGS_CONSOLE && !--psback->front_cnt[PSTORE_TYPE_CONSOLE])
 		pstore_unregister_console();
-	if (psi->flags & PSTORE_FLAGS_DMESG)
+	if (psi->flags & PSTORE_FLAGS_DMESG && !--psback->front_cnt[PSTORE_TYPE_DMESG])
 		pstore_unregister_kmsg();
-	if (psi->flags & PSTORE_FLAGS_TTY)
+	if (psi->flags & PSTORE_FLAGS_TTY && !--psback->front_cnt[PSTORE_TYPE_TTY])
 		pstore_unregister_tty();
 
 	/* Stop timer and make sure all work has finished. */
@@ -675,18 +713,28 @@ void pstore_unregister(struct pstore_info *psi)
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
 
-static void decompress_record(struct pstore_record *record)
+static void decompress_record(struct pstore_record *record, int pos)
 {
 	int ret;
 	int unzipped_len;
@@ -702,13 +750,13 @@ static void decompress_record(struct pstore_record *record)
 	}
 
 	/* Missing compression buffer means compression was not initialized. */
-	if (!big_oops_buf) {
+	if (!big_oops_buf[pos]) {
 		pr_warn("no decompression method initialized!\n");
 		return;
 	}
 
 	/* Allocate enough space to hold max decompression and ECC. */
-	unzipped_len = big_oops_buf_sz;
+	unzipped_len = big_oops_buf_sz[pos];
 	workspace = kmalloc(unzipped_len + record->ecc_notice_size,
 			    GFP_KERNEL);
 	if (!workspace)
@@ -748,7 +796,7 @@ static void decompress_record(struct pstore_record *record)
  * error records.
  */
 void pstore_get_backend_records(struct pstore_info *psi,
-				struct dentry *root, int quiet)
+				struct dentry *root, int quiet, int pos)
 {
 	int failed = 0;
 	unsigned int stop_loop = 65536;
@@ -784,7 +832,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 			break;
 		}
 
-		decompress_record(record);
+		decompress_record(record, pos);
 		rc = pstore_mkfile(root, record);
 		if (rc) {
 			/* pstore_mkfile() did not take record, so free it. */
@@ -810,7 +858,12 @@ void pstore_get_backend_records(struct pstore_info *psi,
 
 static void pstore_dowork(struct work_struct *work)
 {
-	pstore_get_records(1);
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		pstore_get_records(entry->psi, entry->index, 1);
+	mutex_unlock(&psback_lock);
 }
 
 static void pstore_timefunc(struct timer_list *unused)
@@ -841,6 +894,10 @@ static void __init pstore_choose_compression(void)
 static int __init pstore_init(void)
 {
 	int ret;
+	struct pstore_info_list *entry;
+
+	if (!psback)
+		return 0;
 
 	pstore_choose_compression();
 
@@ -849,11 +906,18 @@ static int __init pstore_init(void)
 	 * initialize compression because crypto was not ready. If so,
 	 * initialize compression now.
 	 */
-	allocate_buf_for_compression();
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		allocate_buf_for_compression(entry->psi, entry->index);
+	mutex_unlock(&psback_lock);
 
 	ret = pstore_init_fs();
-	if (ret)
-		free_buf_for_compression();
+	if (ret) {
+		mutex_lock(&psback_lock);
+		list_for_each_entry(entry, &psback->list_entry, list)
+			free_buf_for_compression(entry->index);
+		mutex_unlock(&psback_lock);
+	}
 
 	return ret;
 }
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 55f139afa327..c35ce09861cf 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -11,8 +11,8 @@
 
 static DEFINE_MUTEX(pmsg_lock);
 
-static ssize_t write_pmsg(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t do_write_pmsg(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos, struct pstore_info *psinfo)
 {
 	struct pstore_record record;
 	int ret;
@@ -34,6 +34,25 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	return ret ? ret : count;
 }
 
+static ssize_t write_pmsg(struct file *file, const char __user *buf,
+			  size_t count, loff_t *ppos)
+{
+	int ret;
+	struct pstore_info_list *entry;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list) {
+		if (entry->psi->flags & PSTORE_FLAGS_PMSG) {
+			int _ret = do_write_pmsg(file, buf, count, ppos, entry->psi);
+
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
diff --git a/fs/pstore/tty.c b/fs/pstore/tty.c
index 432ed7194188..0cbe553bcdf2 100644
--- a/fs/pstore/tty.c
+++ b/fs/pstore/tty.c
@@ -41,7 +41,13 @@ void pstore_register_tty(void)
 
 void pstore_start_tty(const unsigned char *buf, int count)
 {
-	do_write_ttymsg(buf, count);
+	struct pstore_info_list *entry;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+		if (entry->psi->flags & PSTORE_FLAGS_TTY)
+			do_write_ttymsg(buf, count, entry->psi);
+	rcu_read_unlock();
 }
 
 void pstore_unregister_tty(void)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 791c86552921..ede60617d778 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -202,6 +202,33 @@ struct pstore_info {
 	int		(*erase)(struct pstore_record *record);
 };
 
+/* Supported multibackends */
+#define PSTORE_MAX_BACKEND_LENGTH 100
+#define PSTORE_BACKEND_NUM 16
+
+#define PSTORE_LIST_FULL (BIT(PSTORE_BACKEND_NUM) - 1)
+#define PSOTRE_LIST_EMPTY 0
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
@@ -211,6 +238,8 @@ struct pstore_info {
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
+extern struct mutex psback_lock;
+
 
 struct pstore_ftrace_record {
 	unsigned long ip;
-- 
2.39.3

