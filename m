Return-Path: <linux-kselftest+bounces-13559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8B92E5FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDA1C20CD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BE15D5C7;
	Thu, 11 Jul 2024 11:14:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA415CD61;
	Thu, 11 Jul 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696442; cv=none; b=G88jRs4+rb9jeqcGiYBB9mo8hRzeAutvXE0HFDXfp1Wi/VBOTnycuT55eOQs+sAvXxagjRw+g3ajDBLAj8ffrTEZ+RuDfMPSLR5FxrT47plL5aO2ApoYb/p+iBKaUM8Z0dSaUo+A4w2xTrLXiRzcqvwNv718ELBhMDimyEI6/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696442; c=relaxed/simple;
	bh=Hg9ese+3RioISfNTgvRm6HlDHVGrAICdXCleHqiZp3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOJCi2z6Za/FQgW/GlftM/LQjonui5CnOdYy1muaDE7uNY0XkCUrERhDU8DQ+CkVq5LZizjZNHVgksvCGyZktMkD2k/8C34OuBoQnkXlWx//5UriXmyfQty2PtAQyY+J69jfFCqbJbXScJZUXWnM8cok0H6N9a1yJnimpeN9JbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKXCq6g8rz4f3m6w;
	Thu, 11 Jul 2024 19:13:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA1321A0572;
	Thu, 11 Jul 2024 19:13:56 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S4;
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
Subject: [PATCH bpf-next v4 02/20] lsm: Refactor return value of LSM hook inode_need_killpriv
Date: Thu, 11 Jul 2024 19:18:50 +0800
Message-Id: <20240711111908.3817636-3-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWfGw4xWFW5Ary7Gr4xXrb_yoW3XFy7pF
	4UKF13Gws5XFy7Wrn7tFsru34SvFWfWrW7JFZ09w12yFnrJr1xKr4ak3yUCryrCr1j9rnI
	v3ZFkw4rCr15JrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook inode_need_killpriv to 0 or a negative error code.

Before:
- Both hook inode_need_killpriv and func security_inode_need_killpriv
  return > 0 if security_inode_killpriv is required, 0 if not, and < 0
  to abort the operation.

After:
- Both hook inode_need_killpriv and func security_inode_need_killpriv
  return 0 on success and a negative error code on failure.
  On success, hook inode_need_killpriv sets output param @need to true
  if security_inode_killpriv is required, and false if not. When @need
  is true, func security_inode_need_killpriv sets ATTR_KILL_PRIV flag
  in @attr; when false, it clears the flag.
  On failure, @need and @attr remains unchanged.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 fs/attr.c                     |  5 ++---
 fs/inode.c                    |  4 +---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      | 20 ++++++++++++++++----
 security/commoncap.c          | 12 ++++++++----
 security/security.c           | 29 ++++++++++++++++++++++++-----
 6 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 960a310581eb..aaadc721c982 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -427,11 +427,10 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
 
 	if (ia_valid & ATTR_KILL_PRIV) {
-		error = security_inode_need_killpriv(dentry);
+		error = security_inode_need_killpriv(dentry, &ia_valid);
 		if (error < 0)
 			return error;
-		if (error == 0)
-			ia_valid = attr->ia_valid &= ~ATTR_KILL_PRIV;
+		attr->ia_valid = ia_valid;
 	}
 
 	/*
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..cd335dc3a3bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2012,11 +2012,9 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
 		return 0;
 
 	mask = setattr_should_drop_suidgid(idmap, inode);
-	ret = security_inode_need_killpriv(dentry);
+	ret = security_inode_need_killpriv(dentry, &mask);
 	if (ret < 0)
 		return ret;
-	if (ret)
-		mask |= ATTR_KILL_PRIV;
 	return mask;
 }
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e6e6f8473955..964849de424b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -165,7 +165,7 @@ LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
-LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
+LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry, bool *need)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 454f96307cb9..1614ef5b2dd2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -161,7 +161,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags);
 int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name);
-int cap_inode_need_killpriv(struct dentry *dentry);
+int cap_inode_need_killpriv(struct dentry *dentry, bool *need);
 int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int cap_inode_getsecurity(struct mnt_idmap *idmap,
 			  struct inode *inode, const char *name, void **buffer,
@@ -389,7 +389,7 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
-int security_inode_need_killpriv(struct dentry *dentry);
+int security_inode_need_killpriv(struct dentry *dentry, int *attr);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
@@ -971,9 +971,21 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
-static inline int security_inode_need_killpriv(struct dentry *dentry)
+static inline int security_inode_need_killpriv(struct dentry *dentry, int *attr)
 {
-	return cap_inode_need_killpriv(dentry);
+	int rc;
+	bool need = false;
+
+	rc = cap_inode_need_killpriv(dentry, &need);
+	if (rc < 0)
+		return rc;
+
+	if (need)
+		*attr |= ATTR_KILL_PRIV;
+	else
+		*attr &= ~ATTR_KILL_PRIV;
+
+	return 0;
 }
 
 static inline int security_inode_killpriv(struct mnt_idmap *idmap,
diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..17d6188d22cf 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -286,21 +286,25 @@ int cap_capset(struct cred *new,
 /**
  * cap_inode_need_killpriv - Determine if inode change affects privileges
  * @dentry: The inode/dentry in being changed with change marked ATTR_KILL_PRIV
+ * @need: If inode_killpriv() is needed
  *
  * Determine if an inode having a change applied that's marked ATTR_KILL_PRIV
  * affects the security markings on that inode, and if it is, should
  * inode_killpriv() be invoked or the change rejected.
  *
- * Return: 1 if security.capability has a value, meaning inode_killpriv()
- * is required, 0 otherwise, meaning inode_killpriv() is not required.
+ * Return: Always returns 0. If security.capability has a value, meaning
+ * inode_killpriv() is required, @need is set to true.
  */
-int cap_inode_need_killpriv(struct dentry *dentry)
+int cap_inode_need_killpriv(struct dentry *dentry, bool *need)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	int error;
 
 	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
-	return error > 0;
+	if (error > 0)
+		*need = true;
+
+	return 0;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 3475f0cab3da..a4abcd86eb36 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2490,17 +2490,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry
+ * @attr: attribute flags
  *
  * Called when an inode has been changed to determine if
  * security_inode_killpriv() should be called.
  *
- * Return: Return <0 on error to abort the inode change operation, return 0 if
- *         security_inode_killpriv() does not need to be called, return >0 if
- *         security_inode_killpriv() does need to be called.
+ * Return: Return 0 on success, negative error code on failure.
+ *         On success, set ATTR_KILL_PRIV flag in @attr when @need is true,
+ *         clears it when false.
  */
-int security_inode_need_killpriv(struct dentry *dentry)
+int security_inode_need_killpriv(struct dentry *dentry, int *attr)
 {
-	return call_int_hook(inode_need_killpriv, dentry);
+	int rc;
+	bool need = false;
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_need_killpriv,
+			     list) {
+		rc = hp->hook.inode_need_killpriv(dentry, &need);
+		if (rc < 0)
+			return rc;
+		if (need)
+			break;
+	}
+
+	if (need)
+		*attr |= ATTR_KILL_PRIV;
+	else
+		*attr &= ~ATTR_KILL_PRIV;
+
+	return 0;
 }
 
 /**
-- 
2.30.2


