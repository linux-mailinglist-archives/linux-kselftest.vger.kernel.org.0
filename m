Return-Path: <linux-kselftest+bounces-13564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA492E620
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C87B27B05
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5316A923;
	Thu, 11 Jul 2024 11:14:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19E16B38E;
	Thu, 11 Jul 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696447; cv=none; b=bLWfE9gTQJrYgf0bfx6qq8yQR4F5GwblPqhdzEvFMfqMTg2x3CS2idO8z7i/s5sB4mwDF77sdlk9tCxkeDRE7eeNwFmDQ+EuZ0XtV/s+qQl7/CABQKIaNaPG/G9FbDi5+yVnTC26Yu3lCHKLsPcexeCTQKYNolWFPs2oELz+ZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696447; c=relaxed/simple;
	bh=RYfGu/7aP6JIgSpGZxYMDl39rhFU2E3iLOaQK5oD8W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uW6zIk0CIBqYJdmMcBx6eu8D1hDcgDWGjlJhMy6lf9CU++z4vAgMfZFcK3Bub0Bqzm3AbPC/wN9ctIlJp9KzbtjSTH+hRB6DgZIt2E81vCNdrPufz0fYX7kvF37/LuqEXVz1YtEqXAPMTtL+qh2W12YzTVULC8q1CJqDeFwz//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXCs3mLgz4f3jHg;
	Thu, 11 Jul 2024 19:13:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E1A21A0568;
	Thu, 11 Jul 2024 19:13:57 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S6;
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
Subject: [PATCH bpf-next v4 04/20] lsm: Refactor return value of LSM hook inode_listsecurity
Date: Thu, 11 Jul 2024 19:18:52 +0800
Message-Id: <20240711111908.3817636-5-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWUuw4xury3ArykJr15XFb_yoW3Zw15pF
	45Ka15Jr1rJFyxWrn7t3Zxu3WS9FZ5GrWUG393Cw13AF1kJw1vqF1FkFyY9FyrJr18Gr10
	qanrursxGw4UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook inode_listsecurity to 0 or a negative error code.

Before:
- Hook inode_listsecurity returns number of bytes used/required on
  success or a negative error code on failure.

After:
- Hook inode_listsecurity returns 0 on success or a negative error
  code on failure. An output parameter @bytes is introduced to hold
  the number of bytes used/required on success.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 fs/nfs/nfs4proc.c             |  5 ++++-
 fs/xattr.c                    |  5 ++++-
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  7 ++++---
 net/socket.c                  |  9 +++++----
 security/security.c           | 29 +++++++++++++++++++++++++----
 security/selinux/hooks.c      |  8 +++++---
 security/smack/smack_lsm.c    |  6 ++++--
 8 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a691fa10b3e9..6d75758ba3d5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7848,10 +7848,13 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 static ssize_t
 nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 {
+	size_t bytes;
 	int len = 0;
 
 	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
-		len = security_inode_listsecurity(inode, list, list_len);
+		len = security_inode_listsecurity(inode, list, list_len, &bytes);
+		if (!len)
+			len = bytes;
 		if (len >= 0 && list_len && len > list_len)
 			return -ERANGE;
 	}
diff --git a/fs/xattr.c b/fs/xattr.c
index f4e3bedf7272..ab7d7123a016 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -485,6 +485,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
 	ssize_t error;
+	size_t bytes;
 
 	error = security_inode_listxattr(dentry);
 	if (error)
@@ -493,7 +494,9 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (inode->i_op->listxattr) {
 		error = inode->i_op->listxattr(dentry, list, size);
 	} else {
-		error = security_inode_listsecurity(inode, list, size);
+		error = security_inode_listsecurity(inode, list, size, &bytes);
+		if (!error)
+			error = bytes;
 		if (size && error > size)
 			error = -ERANGE;
 	}
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 4f056f2613af..1b7761ae2777 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -174,7 +174,7 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
-	 size_t buffer_size)
+	 size_t buffer_size, size_t *bytes)
 LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
diff --git a/include/linux/security.h b/include/linux/security.h
index b6d296d21438..0ed53e232c4d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -395,7 +395,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       bool alloc, void **buffer, u32 *len);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
+int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size, size_t *bytes);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
@@ -1007,9 +1007,10 @@ static inline int security_inode_setsecurity(struct inode *inode, const char *na
 	return -EOPNOTSUPP;
 }
 
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
+					      size_t buffer_size, size_t *bytes)
 {
-	return 0;
+	return *bytes = 0;
 }
 
 static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
diff --git a/net/socket.c b/net/socket.c
index e416920e9399..43f0e3c9a6e0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -571,12 +571,13 @@ static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
 static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
-	ssize_t len;
+	int err;
+	size_t len;
 	ssize_t used = 0;
 
-	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
-	if (len < 0)
-		return len;
+	err = security_inode_listsecurity(d_inode(dentry), buffer, size, &len);
+	if (err < 0)
+		return err;
 	used += len;
 	if (buffer) {
 		if (size < used)
diff --git a/security/security.c b/security/security.c
index 614f14cbfff7..26eea8f4cd74 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2597,20 +2597,41 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
  * @inode: inode
  * @buffer: buffer
  * @buffer_size: size of buffer
+ * @bytes: number of bytes used/required
  *
  * Copy the extended attribute names for the security labels associated with
  * @inode into @buffer.  The maximum size of @buffer is specified by
  * @buffer_size.  @buffer may be NULL to request the size of the buffer
  * required.
  *
- * Return: Returns number of bytes used/required on success.
+ * Return: Returns 0 on success or a negative error code on failure.
  */
 int security_inode_listsecurity(struct inode *inode,
-				char *buffer, size_t buffer_size)
+				char *buffer, size_t buffer_size,
+				size_t *bytes)
 {
+	int rc;
+	size_t used;
+	struct security_hook_list *hp;
+
 	if (unlikely(IS_PRIVATE(inode)))
-		return 0;
-	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
+		return *bytes = 0;
+
+	used = 0;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_listsecurity,
+			     list) {
+		rc = hp->hook.inode_listsecurity(inode, buffer, buffer_size,
+						 &used);
+		if (rc < 0)
+			return rc;
+		if (used != 0)
+			break;
+	}
+
+	*bytes = used;
+
+	return 0;
+
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 70792bba24d9..5dedd3917d57 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3481,16 +3481,18 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	return 0;
 }
 
-static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+static int selinux_inode_listsecurity(struct inode *inode, char *buffer,
+				      size_t buffer_size, size_t *bytes)
 {
 	const int len = sizeof(XATTR_NAME_SELINUX);
 
 	if (!selinux_initialized())
-		return 0;
+		return *bytes = 0;
 
 	if (buffer && len <= buffer_size)
 		memcpy(buffer, XATTR_NAME_SELINUX, len);
-	return len;
+	*bytes = len;
+	return 0;
 }
 
 static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e7a5f6fd9a2d..6f73906bf7ea 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1611,16 +1611,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
  * @inode: the object
  * @buffer: where they go
  * @buffer_size: size of buffer
+ * @bytes: number of data bytes in buffer
  */
 static int smack_inode_listsecurity(struct inode *inode, char *buffer,
-				    size_t buffer_size)
+				    size_t buffer_size, size_t *bytes)
 {
 	int len = sizeof(XATTR_NAME_SMACK);
 
 	if (buffer != NULL && len <= buffer_size)
 		memcpy(buffer, XATTR_NAME_SMACK, len);
 
-	return len;
+	*bytes = len;
+	return 0;
 }
 
 /**
-- 
2.30.2


