Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB3866B2EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAORVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjAORVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:21:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DF876BB;
        Sun, 15 Jan 2023 09:21:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C9C160DB6;
        Sun, 15 Jan 2023 17:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A01C433EF;
        Sun, 15 Jan 2023 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803300;
        bh=xLxVGWdwSbYolStnuWIQa4D7zd8awG8REU3pYzPYYzU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J3G1qntCiju0eNR3mlq+3jCPVC75mA6TteV1EfRelugoxAyyYXulCDp85Z53ZkJAX
         QnpxAPTfH6TuECi9VyGAzwzHb2wsx2Yf6ayZ4Xaq+IbBr24d2S9CRMiqoj6xJgskqr
         JkniAAVpT/09HvEuwZ5PymH3dDFi3Vz/ks+LjYCvhc3SXlFr5J7/grVbP6MnFjydwk
         UgGvwDgeDmD3EQIsQSo2DaknrJNcSKG9Wn7XbahiQbd4O7LVlx7ip7BnCzyS6ixbAE
         8LcvFxYKK0MoLKUoNoKCseiUA6pz3ChdO1/tBLxYj0tf9+8hKc9p133C4qJIWVLf2L
         EStLxy0wPVe7A==
Subject: [PATCH v2 13/41] NFSD: Replace /proc/fs/nfsd/supported_krb5_enctypes
 with a symlink
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:21:39 -0500
Message-ID: <167380329945.10651.15538457743821507363.stgit@bazille.1015granger.net>
In-Reply-To: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Now that I've added a file under /proc/net/rpc that is managed by
the SunRPC's Kerberos mechanism, replace NFSD's
supported_krb5_enctypes file with a symlink to the new SunRPC proc
file, which contains exactly the same content.

Remarkably, commit b0b0c0a26e84 ("nfsd: add proc file listing
kernel's gss_krb5 enctypes") added the nfsd_supported_krb5_enctypes
file in 2011, but this file has never been documented in nfsd(7).

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |   74 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f2a0d6ac88df..04474b8ccf0a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -14,7 +14,6 @@
 #include <linux/lockd/lockd.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/gss_api.h>
-#include <linux/sunrpc/gss_krb5_enctypes.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
@@ -47,7 +46,6 @@ enum {
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
 	NFSD_Filecache,
-	NFSD_SupportedEnctypes,
 	/*
 	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
 	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
@@ -187,16 +185,6 @@ static int export_features_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(export_features);
 
-#if defined(CONFIG_SUNRPC_GSS) || defined(CONFIG_SUNRPC_GSS_MODULE)
-static int supported_enctypes_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, KRB5_SUPPORTED_ENCTYPES);
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(supported_enctypes);
-#endif /* CONFIG_SUNRPC_GSS or CONFIG_SUNRPC_GSS_MODULE */
-
 static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
 	.read		= seq_read,
@@ -1150,6 +1138,9 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_op = &simple_dir_inode_operations;
 		inc_nlink(inode);
 		break;
+	case S_IFLNK:
+		inode->i_op = &simple_symlink_inode_operations;
+		break;
 	default:
 		break;
 	}
@@ -1195,6 +1186,59 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 	goto out;
 }
 
+#if IS_ENABLED(CONFIG_SUNRPC_GSS)
+static int __nfsd_symlink(struct inode *dir, struct dentry *dentry,
+			  umode_t mode, const char *content)
+{
+	struct inode *inode;
+
+	inode = nfsd_get_inode(dir->i_sb, mode);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_link = (char *)content;
+	inode->i_size = strlen(content);
+
+	d_add(dentry, inode);
+	inc_nlink(dir);
+	fsnotify_create(dir, dentry);
+	return 0;
+}
+
+/*
+ * @content is assumed to be a NUL-terminated string that lives
+ * longer than the symlink itself.
+ */
+static void nfsd_symlink(struct dentry *parent, const char *name,
+			 const char *content)
+{
+	struct inode *dir = parent->d_inode;
+	struct dentry *dentry;
+	int ret = -ENOMEM;
+
+	inode_lock(dir);
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		goto out_err;
+	ret = __nfsd_symlink(d_inode(parent), dentry, S_IFLNK | 0777, content);
+	if (ret)
+		goto out_err;
+out:
+	inode_unlock(dir);
+	return;
+out_err:
+	dput(dentry);
+	dentry = ERR_PTR(ret);
+	goto out;
+}
+#else
+static inline void nfsd_symlink(struct dentry *parent, const char *name,
+				const char *content)
+{
+}
+
+#endif
+
 static void clear_ncl(struct inode *inode)
 {
 	struct nfsdfs_client *ncl = inode->i_private;
@@ -1355,10 +1399,6 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
-#if defined(CONFIG_SUNRPC_GSS) || defined(CONFIG_SUNRPC_GSS_MODULE)
-		[NFSD_SupportedEnctypes] = {"supported_krb5_enctypes",
-					&supported_enctypes_fops, S_IRUGO},
-#endif /* CONFIG_SUNRPC_GSS or CONFIG_SUNRPC_GSS_MODULE */
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
@@ -1371,6 +1411,8 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 	ret = simple_fill_super(sb, 0x6e667364, nfsd_files);
 	if (ret)
 		return ret;
+	nfsd_symlink(sb->s_root, "supported_krb5_enctypes",
+		     "/proc/net/rpc/gss_krb5_enctypes");
 	dentry = nfsd_mkdir(sb->s_root, NULL, "clients");
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);


