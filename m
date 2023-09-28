Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF697B10E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 04:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjI1Cnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 22:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjI1Cnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 22:43:53 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40D114;
        Wed, 27 Sep 2023 19:43:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vt.rlII_1695869027;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0Vt.rlII_1695869027)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 10:43:48 +0800
From:   Yuanhe Shu <xiangzao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yuanhe Shu <xiangzao@linux.alibaba.com>,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 3/5] pstore: add subdirs for multi-backends
Date:   Thu, 28 Sep 2023 10:42:42 +0800
Message-Id: <20230928024244.257687-4-xiangzao@linux.alibaba.com>
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

With pstore supporting multiple backends, since different backends
may enable different kinds of frontends, records in the file system
are very confusing.

By simply modifying the file system, subdirs are added for each backend,
each dir has the same name as the corresponding backend.

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 fs/pstore/inode.c      | 80 ++++++++++++++++++++++++++++++++++++------
 fs/pstore/internal.h   |  1 +
 fs/pstore/platform.c   |  5 ++-
 include/linux/pstore.h |  2 ++
 4 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 312e7d55b95f..0f6d888a3b06 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -288,9 +288,14 @@ static const struct super_operations pstore_ops = {
 	.show_options	= pstore_show_options,
 };
 
-static struct dentry *psinfo_lock_root(struct pstore_info *psinfo)
+static struct dentry *psinfo_lock(struct pstore_info *psinfo)
 {
-	struct dentry *root;
+	struct dentry *dentry;
+	struct qstr qname;
+
+	qname.name = psinfo->name;
+	qname.len  = strlen(psinfo->name);
+	qname.hash = full_name_hash(pstore_sb->s_root, qname.name, qname.len);
 
 	mutex_lock(&pstore_sb_lock);
 	/*
@@ -302,11 +307,16 @@ static struct dentry *psinfo_lock_root(struct pstore_info *psinfo)
 		return NULL;
 	}
 
-	root = pstore_sb->s_root;
-	inode_lock(d_inode(root));
+	dentry = d_lookup(pstore_sb->s_root, &qname);
+	if (!dentry) {
+		mutex_unlock(&pstore_sb_lock);
+		return NULL;
+	}
+
+	inode_lock(d_inode(dentry));
 	mutex_unlock(&pstore_sb_lock);
 
-	return root;
+	return dentry;
 }
 
 int pstore_put_backend_records(struct pstore_info *psi)
@@ -315,7 +325,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	struct dentry *root;
 	int rc = 0;
 
-	root = psinfo_lock_root(psi);
+	root = psinfo_lock(psi);
 	if (!root)
 		return 0;
 
@@ -416,14 +426,60 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
  */
 void pstore_get_records(struct pstore_info *psi, int pos, int quiet)
 {
+	struct dentry *dentry;
+
+	dentry = psinfo_lock(psi);
+	if (!dentry)
+		return;
+
+	pstore_get_backend_records(psi, dentry, quiet, pos);
+	inode_unlock(d_inode(dentry));
+}
+
+void pstore_mksubdir(struct pstore_info *psi)
+{
+	struct dentry *dentry;
+	struct inode *inode;
 	struct dentry *root;
+	struct qstr qname;
 
-	root = psinfo_lock_root(psi);
-	if (!root)
+	if (!psi || !pstore_sb)
+		return;
+
+	root = pstore_sb->s_root;
+	qname.name = psi->name;
+	qname.len = strlen(psi->name);
+	qname.hash = full_name_hash(root, qname.name, qname.len);
+	dentry = d_lookup(root, &qname);
+
+	/* Skip if subdir is already present in the filesystem. */
+	if (dentry)
 		return;
 
-	pstore_get_backend_records(psi, root, quiet, pos);
+	inode_lock(d_inode(root));
+
+	dentry = d_alloc_name(root, psi->name);
+	if (!dentry)
+		goto fail;
+
+	inode = pstore_get_inode(pstore_sb);
+	if (!inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto fail;
+	}
+	inode->i_mode = S_IFDIR | 0750;
+	inode->i_op = &pstore_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+
+	inc_nlink(inode);
+	inc_nlink(d_inode(root));
+
+	d_add(dentry, inode);
+
+fail:
 	inode_unlock(d_inode(root));
+	return;
 }
 
 static int pstore_fill_super(struct super_block *sb, void *data, int silent)
@@ -456,10 +512,14 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_unlock(&pstore_sb_lock);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &psback->list_entry, list)
+	list_for_each_entry_rcu(entry, &psback->list_entry, list) {
+		pstore_mksubdir(entry->psi);
 		pstore_get_records(entry->psi, entry->index, 0);
+	}
 	rcu_read_unlock();
 
+	psback->fs_ready = true;
+
 	return 0;
 }
 
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 7465b5baf002..20449ca940bb 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -44,6 +44,7 @@ static inline void pstore_unregister_tty(void) {}
 extern struct pstore_backends *psback;
 
 extern void	pstore_set_kmsg_bytes(int);
+extern void	pstore_mksubdir(struct pstore_info *psi);
 extern void	pstore_get_records(struct pstore_info *psi, int pos,
 						int quiet);
 extern void	pstore_get_backend_records(struct pstore_info *psi,
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 34fb21e6ff4f..d576ee48527c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -652,7 +652,10 @@ int pstore_register(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_DMESG && !psback->front_cnt[PSTORE_TYPE_DMESG])
 		allocate_buf_for_compression(psi, newpsi->index);
 
-	pstore_get_records(psi, newpsi->index, 0);
+	if (psback->fs_ready) {
+		pstore_mksubdir(psi);
+		pstore_get_records(psi, newpsi->index, 0);
+	}
 
 	list_add_rcu(&newpsi->list, &psback->list_entry);
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ede60617d778..306597545f2d 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -220,6 +220,7 @@ struct pstore_info_list {
  * @list_entry:	entry of pstore backend driver information list
  * @front_cnt:	count of each enabled frontend
  * @flag:	bitmap of enabled pstore backend
+ * @fs_ready:	whether the pstore filesystem is ready
  *
  */
 
@@ -227,6 +228,7 @@ struct pstore_backends {
 	struct list_head list_entry;
 	int front_cnt[PSTORE_TYPE_MAX];
 	u16 flag;
+	bool fs_ready;
 };
 
 /* Supported frontends */
-- 
2.39.3

