Return-Path: <linux-kselftest+bounces-13566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C292E62D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D90C2841EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89DE16C6A2;
	Thu, 11 Jul 2024 11:14:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22916B392;
	Thu, 11 Jul 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696447; cv=none; b=n7AtKVriJHJ8Z3c3Qf9YFQAfPVzLMuwUusYZBNVA53sj9UWPIpNXMxpRp7bBiAPgHzYos6OSRLq7JOUDlM/s9F3usKv3YozSYx1A6iCgJF5sJuJ3IpuC2f7K/3zd9hkm5wZ+CVChFC00TUaqVAJjLltQg2k0e9Pakr7OffKe+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696447; c=relaxed/simple;
	bh=F2DBOYAey1NBHWQhzeFhHSb9csczr8YPT8WbPlwEQb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9qXJ8nuAWzDi1gG86V1vEtBhUpiB1e2CaoIn/ywzpq5K+I3e4ofbX3ZCUUeDJlKFgPL2BLDUgU94IG8XxtUCi0h05pQ4IGgin8ReBLQCxPGHGVGlG2Fg/yoAza3RtSSD/sjEZXFPmsGG00R3XItd4znS7mDRmgFxDEm5UHxmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXCr713pz4f3jrw;
	Thu, 11 Jul 2024 19:13:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9C8D41A0187;
	Thu, 11 Jul 2024 19:13:56 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgCHjPVxvo9mulQgBw--.25300S3;
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
Subject: [PATCH bpf-next v4 01/20] lsm: Refactor return value of LSM hook vm_enough_memory
Date: Thu, 11 Jul 2024 19:18:49 +0800
Message-Id: <20240711111908.3817636-2-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHjPVxvo9mulQgBw--.25300S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur48GF1DAw17Kr47ur1rWFg_yoW7Gr4kpF
	s5Ka13KrWvkFyxZrs7GanxC3W3t34fWF4UGrWUu34Fk3ZFvr17KF4UAw1Y9r1UtrW8tasF
	qFW29rs3Ca1qq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAHUDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook vm_enough_memory to 0 or a negative error code.

Before:
- Hook vm_enough_memory returns 1 if permission is granted, 0 if not.
- LSM_RET_DEFAULT(vm_enough_memory_mm) is 1.

After:
- Hook vm_enough_memory reutrns 0 if permission is granted, negative
  error code if not.
- LSM_RET_DEFAULT(vm_enough_memory_mm) is 0.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  2 +-
 security/commoncap.c          | 11 +++--------
 security/security.c           | 11 +++++------
 security/selinux/hooks.c      | 15 ++++-----------
 5 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 44488b1ab9a9..e6e6f8473955 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
diff --git a/include/linux/security.h b/include/linux/security.h
index de3af33e6ff5..454f96307cb9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -634,7 +634,7 @@ static inline int security_settime64(const struct timespec64 *ts,
 
 static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
+	return __vm_enough_memory(mm, pages, !cap_vm_enough_memory(mm, pages));
 }
 
 static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..cefad323a0b1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1396,17 +1396,12 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
  * Determine whether the allocation of a new virtual mapping by the current
  * task is permitted.
  *
- * Return: 1 if permission is granted, 0 if not.
+ * Return: 0 if permission granted, negative error code if not.
  */
 int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 {
-	int cap_sys_admin = 0;
-
-	if (cap_capable(current_cred(), &init_user_ns,
-				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) == 0)
-		cap_sys_admin = 1;
-
-	return cap_sys_admin;
+	return cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
+			   CAP_OPT_NOAUDIT);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index e5ca08789f74..3475f0cab3da 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1115,15 +1115,14 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	int rc;
 
 	/*
-	 * The module will respond with a positive value if
-	 * it thinks the __vm_enough_memory() call should be
-	 * made with the cap_sys_admin set. If all of the modules
-	 * agree that it should be set it will. If any module
-	 * thinks it should not be set it won't.
+	 * The module will respond with 0 if it thinks the __vm_enough_memory()
+	 * call should be made with the cap_sys_admin set. If all of the modules
+	 * agree that it should be set it will. If any module thinks it should
+	 * not be set it won't.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
 		rc = hp->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0) {
+		if (rc < 0) {
 			cap_sys_admin = 0;
 			break;
 		}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7eed331e90f0..9cd5a8f1f6a3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2202,23 +2202,16 @@ static int selinux_syslog(int type)
 }
 
 /*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
+ * Check permission for allocating a new virtual mapping. Returns
+ * 0 if permission is granted, negative error code if not.
  *
  * Do not audit the selinux permission check, as this is applied to all
  * processes that allocate mappings.
  */
 static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 {
-	int rc, cap_sys_admin = 0;
-
-	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
-				 CAP_OPT_NOAUDIT, true);
-	if (rc == 0)
-		cap_sys_admin = 1;
-
-	return cap_sys_admin;
+	return cred_has_capability(current_cred(), CAP_SYS_ADMIN,
+				   CAP_OPT_NOAUDIT, true);
 }
 
 /* binprm security operations */
-- 
2.30.2


