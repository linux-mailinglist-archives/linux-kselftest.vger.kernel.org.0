Return-Path: <linux-kselftest+bounces-13560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3B92E601
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B13287391
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919915DBB3;
	Thu, 11 Jul 2024 11:14:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D415CD60;
	Thu, 11 Jul 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696442; cv=none; b=CoxrBPdtlHZ1fs1K8TdigvkdVAJ3y/aqjAPdSYP5lLKJlQPWC2QlQCmCTJlW+7pblTqDst+9ksHDBsoX074sQRQeaig8tSai3ri+T2IYaCjjM2cOzhWY3NXUp2esBziyG4j4J38rMIbDCGhM6GxE6y/dkeBKXKDmzGqIbn4w+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696442; c=relaxed/simple;
	bh=4bixJwGuTWgSqOvL6zwccNF+B7ZssgQCR776AYlaV+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qsi8POpOA004fBnWVw3B93FheoRkkXHq9njUEyjYtTq1fhcCsJT5B5g9t8pAlVAc9jhjUtskP/cYcmifBAGkC7AGtE16hiYycKnqgPuhvwTtYVTP0/L+P/GVxd7iHFTe4CY4VQSZiHPYCF82urM8qkXFbTZfrZTZ4zYyHmWRjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKXCx55ZQz4f3kK5;
	Thu, 11 Jul 2024 19:13:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59B001A0170;
	Thu, 11 Jul 2024 19:13:57 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S7;
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
Subject: [PATCH bpf-next v4 05/20] lsm: Refactor return value of LSM hook inode_copy_up_xattr
Date: Thu, 11 Jul 2024 19:18:53 +0800
Message-Id: <20240711111908.3817636-6-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kXF4DJFWkXFWrJF1fJFb_yoWruw4fpa
	1Dtan2qr1rJFy7ZFykJF47ua1F93yfGFWUCa9xuw12yFZ3Xrn3Wryayr12gr45Wry8JF4k
	tanFvrs8C3WYy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook inode_copy_up_xattr to 0 or a negative error code.

Before:
- Hook inode_copy_up_xattr returns 0 when accepting xattr, 1 when
  discarding xattr, -EOPNOTSUPP if it does not know xattr, or any
  other negative error code otherwise.

After:
- Hook inode_copy_up_xattr returns 0 when accepting xattr, *-ECANCELED*
  when discarding xattr, -EOPNOTSUPP if it does not know xattr, or
  any other negative error code otherwise.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 fs/overlayfs/copy_up.c            |  6 +++---
 security/integrity/evm/evm_main.c |  2 +-
 security/security.c               | 12 ++++++------
 security/selinux/hooks.c          |  4 ++--
 security/smack/smack_lsm.c        |  6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a5ef2005a2cc..337a5be99ac9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -115,12 +115,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			continue;
 
 		error = security_inode_copy_up_xattr(old, name);
-		if (error < 0 && error != -EOPNOTSUPP)
-			break;
-		if (error == 1) {
+		if (error == -ECANCELED) {
 			error = 0;
 			continue; /* Discard */
 		}
+		if (error < 0 && error != -EOPNOTSUPP)
+			break;
 
 		if (is_posix_acl_xattr(name)) {
 			error = ovl_copy_acl(OVL_FS(sb), oldpath, new, name);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..6924ed508ebd 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1000,7 +1000,7 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
 	case EVM_XATTR_HMAC:
 	case EVM_IMA_XATTR_DIGSIG:
 	default:
-		rc = 1; /* discard */
+		rc = -ECANCELED; /* discard */
 	}
 
 	kfree(xattr_data);
diff --git a/security/security.c b/security/security.c
index 26eea8f4cd74..12215ca286af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2675,18 +2675,18 @@ EXPORT_SYMBOL(security_inode_copy_up);
  * lower layer to the union/overlay layer.   The caller is responsible for
  * reading and writing the xattrs, this hook is merely a filter.
  *
- * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
- *         if the security module does not know about attribute, or a negative
- *         error code to abort the copy up.
+ * Return: Returns 0 to accept the xattr, -ECANCELED to discard the xattr,
+ *         -EOPNOTSUPP if the security module does not know about attribute,
+ *         or a negative error code to abort the copy up.
  */
 int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	int rc;
 
 	/*
-	 * The implementation can return 0 (accept the xattr), 1 (discard the
-	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
-	 * any other error code in case of an error.
+	 * The implementation can return 0 (accept the xattr), -ECANCELED
+	 * (discard the xattr), -EOPNOTSUPP if it does not know anything
+	 *  about the xattr or any other error code in case of an error.
 	 */
 	rc = call_int_hook(inode_copy_up_xattr, src, name);
 	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5dedd3917d57..f9a6637dfd78 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3528,8 +3528,8 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 	 * xattrs up.  Instead, filter out SELinux-related xattrs following
 	 * policy load.
 	 */
-	if (selinux_initialized() && strcmp(name, XATTR_NAME_SELINUX) == 0)
-		return 1; /* Discard */
+	if (selinux_initialized() && !strcmp(name, XATTR_NAME_SELINUX))
+		return -ECANCELED; /* Discard */
 	/*
 	 * Any other attribute apart from SELINUX is not claimed, supported
 	 * by selinux.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6f73906bf7ea..ae8f1c2d0ca6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4893,10 +4893,10 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	/*
-	 * Return 1 if this is the smack access Smack attribute.
+	 * Return -ECANCELED if this is the smack access Smack attribute.
 	 */
-	if (strcmp(name, XATTR_NAME_SMACK) == 0)
-		return 1;
+	if (!strcmp(name, XATTR_NAME_SMACK))
+		return -ECANCELED;
 
 	return -EOPNOTSUPP;
 }
-- 
2.30.2


