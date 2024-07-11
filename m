Return-Path: <linux-kselftest+bounces-13565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C492E625
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D03C1C23451
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BD16B739;
	Thu, 11 Jul 2024 11:14:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E116B38F;
	Thu, 11 Jul 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696447; cv=none; b=IG9LHpgeZ1ZhzCUiFp/i/kj6YZPXpy5dGc575JBOrNWqRIjg1BbanQKv4Q+PwDjiWGIHfssy3sH0/UKOtMaWY1wrP2Jm0UR3urh2PahmseY4wJn17srAe5Pe6QVXngTFj4bL0DhiooAhFGJmSGZu/AZpIxP3lOza9ZkS9qAhkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696447; c=relaxed/simple;
	bh=PM8AFPWlS6LkP5AL3p5RSlFkj5rPkUtAUSQ60pJZkWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrlSZE8nYwUo5q+C+Xla3cIFFdXmcLhAZHW/FB/zmJEspSJVa6d/701Tkd8x+SbRFDCEGujHSxD+zjeOy9w6IwQBy8ATBq3iS66L2uolTNi9JW9EVRC+oB3oQ4/SG0mYvdaIyIZtVOg2BRibLled4DUfdqZ9wC9DcJfz1iiI9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXCs2JkNz4f3jsL;
	Thu, 11 Jul 2024 19:13:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 011CB1A0170;
	Thu, 11 Jul 2024 19:13:56 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S5;
	Thu, 11 Jul 2024 19:13:56 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 03/20] lsm: Refactor return value of LSM hook inode_getsecurity
Date: Thu, 11 Jul 2024 19:18:51 +0800
Message-Id: <20240711111908.3817636-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtry5AryUJF1fKF1xXryrZwb_yoWfuF4kpF
	45KanxGr4fXFyUWrn2yF17u3WSvFWfGrWUCrWq9wnxAFnFvr10qF12kF17CF1rGrW8Cr12
	q3ZF9wsxCw4UJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook inode_getsecurity to 0 or a negative error code.

Before:
- Hook inode_getsecurity returns size of buffer on success or a
  negative error code on failure.

After:
- Hook inode_getsecurity returns 0 on success or a negative error
  code on failure. An output parameter @len is introduced to hold
  the buffer size on success.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 fs/xattr.c                    | 19 ++++++++++---------
 include/linux/lsm_hook_defs.h |  3 ++-
 include/linux/security.h      | 12 ++++++------
 security/commoncap.c          |  9 ++++++---
 security/security.c           | 11 ++++++-----
 security/selinux/hooks.c      | 16 ++++++----------
 security/smack/smack_lsm.c    | 14 +++++++-------
 7 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index f8b643f91a98..f4e3bedf7272 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -339,27 +339,28 @@ xattr_getsecurity(struct mnt_idmap *idmap, struct inode *inode,
 		  const char *name, void *value, size_t size)
 {
 	void *buffer = NULL;
-	ssize_t len;
+	int error;
+	u32 len;
 
 	if (!value || !size) {
-		len = security_inode_getsecurity(idmap, inode, name,
-						 &buffer, false);
+		error = security_inode_getsecurity(idmap, inode, name,
+						   false, &buffer, &len);
 		goto out_noalloc;
 	}
 
-	len = security_inode_getsecurity(idmap, inode, name, &buffer,
-					 true);
-	if (len < 0)
-		return len;
+	error = security_inode_getsecurity(idmap, inode, name, true,
+					   &buffer, &len);
+	if (error)
+		return error;
 	if (size < len) {
-		len = -ERANGE;
+		error = -ERANGE;
 		goto out;
 	}
 	memcpy(value, buffer, len);
 out:
 	kfree(buffer);
 out_noalloc:
-	return len;
+	return error < 0 ? error : len;
 }
 
 /*
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 964849de424b..4f056f2613af 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -169,7 +169,8 @@ LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry, bool *need)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
-	 struct inode *inode, const char *name, void **buffer, bool alloc)
+	 struct inode *inode, const char *name, bool alloc, void **buffer,
+	 u32 *len)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
diff --git a/include/linux/security.h b/include/linux/security.h
index 1614ef5b2dd2..b6d296d21438 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -164,8 +164,8 @@ int cap_inode_removexattr(struct mnt_idmap *idmap,
 int cap_inode_need_killpriv(struct dentry *dentry, bool *need);
 int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int cap_inode_getsecurity(struct mnt_idmap *idmap,
-			  struct inode *inode, const char *name, void **buffer,
-			  bool alloc);
+			  struct inode *inode, const char *name, bool alloc,
+			  void **buffer, u32 *len);
 extern int cap_mmap_addr(unsigned long addr);
 extern int cap_mmap_file(struct file *file, unsigned long reqprot,
 			 unsigned long prot, unsigned long flags);
@@ -393,7 +393,7 @@ int security_inode_need_killpriv(struct dentry *dentry, int *attr);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
-			       void **buffer, bool alloc);
+			       bool alloc, void **buffer, u32 *len);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
@@ -996,10 +996,10 @@ static inline int security_inode_killpriv(struct mnt_idmap *idmap,
 
 static inline int security_inode_getsecurity(struct mnt_idmap *idmap,
 					     struct inode *inode,
-					     const char *name, void **buffer,
-					     bool alloc)
+					     const char *name, bool alloc,
+					     void **buffer, u32 *len)
 {
-	return cap_inode_getsecurity(idmap, inode, name, buffer, alloc);
+	return cap_inode_getsecurity(idmap, inode, name, alloc, buffer, len);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
diff --git a/security/commoncap.c b/security/commoncap.c
index 17d6188d22cf..ff82e2ab6f8f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -383,8 +383,8 @@ static bool is_v3header(int size, const struct vfs_cap_data *cap)
  * so that's good.
  */
 int cap_inode_getsecurity(struct mnt_idmap *idmap,
-			  struct inode *inode, const char *name, void **buffer,
-			  bool alloc)
+			  struct inode *inode, const char *name,
+			  bool alloc, void **buffer, u32 *len)
 {
 	int size;
 	kuid_t kroot;
@@ -485,7 +485,10 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 	}
 out_free:
 	kfree(tmpbuf);
-	return size;
+	if (size < 0)
+		return size;
+	*len = size;
+	return 0;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index a4abcd86eb36..614f14cbfff7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2544,8 +2544,9 @@ int security_inode_killpriv(struct mnt_idmap *idmap,
  * @idmap: idmap of the mount
  * @inode: inode
  * @name: xattr name
- * @buffer: security label buffer
  * @alloc: allocation flag
+ * @buffer: security label buffer
+ * @len: security label length
  *
  * Retrieve a copy of the extended attribute representation of the security
  * label associated with @name for @inode via @buffer.  Note that @name is the
@@ -2553,17 +2554,17 @@ int security_inode_killpriv(struct mnt_idmap *idmap,
  * @alloc is used to specify if the call should return a value via the buffer
  * or just the value length.
  *
- * Return: Returns size of buffer on success.
+ * Return: Returns 0 on success or a negative error code on failure.
  */
 int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
-			       void **buffer, bool alloc)
+			       bool alloc, void **buffer, u32 *len)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return LSM_RET_DEFAULT(inode_getsecurity);
 
-	return call_int_hook(inode_getsecurity, idmap, inode, name, buffer,
-			     alloc);
+	return call_int_hook(inode_getsecurity, idmap, inode, name, alloc,
+			     buffer, len);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9cd5a8f1f6a3..70792bba24d9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3407,7 +3407,7 @@ static int selinux_path_notify(const struct path *path, u64 mask,
  */
 static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 				     struct inode *inode, const char *name,
-				     void **buffer, bool alloc)
+				     bool alloc, void **buffer, u32 *len)
 {
 	u32 size;
 	int error;
@@ -3440,14 +3440,14 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 						&context, &size);
 	if (error)
 		return error;
-	error = size;
+	*len = size;
 	if (alloc) {
 		*buffer = context;
 		goto out_nofree;
 	}
 	kfree(context);
 out_nofree:
-	return error;
+	return 0;
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
@@ -6644,13 +6644,9 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	int len = 0;
-	len = selinux_inode_getsecurity(&nop_mnt_idmap, inode,
-					XATTR_SELINUX_SUFFIX, ctx, true);
-	if (len < 0)
-		return len;
-	*ctxlen = len;
-	return 0;
+	return selinux_inode_getsecurity(&nop_mnt_idmap, inode,
+					 XATTR_SELINUX_SUFFIX,
+					 true, ctx, ctxlen);
 }
 #ifdef CONFIG_KEYS
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f5cbec1e6a92..e7a5f6fd9a2d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1543,14 +1543,15 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
  * @idmap: idmap of the mount
  * @inode: the object
  * @name: attribute name
- * @buffer: where to put the result
  * @alloc: duplicate memory
+ * @buffer: where to put the result
+ * @len: where to put the result length
  *
- * Returns the size of the attribute or an error code
+ * Returns 0 on success or a negative error code on failure
  */
 static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 				   struct inode *inode, const char *name,
-				   void **buffer, bool alloc)
+				   bool alloc, void **buffer, u32 *len)
 {
 	struct socket_smack *ssp;
 	struct socket *sock;
@@ -1558,7 +1559,6 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 	struct inode *ip = inode;
 	struct smack_known *isp;
 	struct inode_smack *ispp;
-	size_t label_len;
 	char *label = NULL;
 
 	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
@@ -1594,15 +1594,15 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 	if (!label)
 		label = isp->smk_known;
 
-	label_len = strlen(label);
-
 	if (alloc) {
 		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return label_len;
+	*len = strlen(label);
+
+	return 0;
 }
 
 
-- 
2.30.2


