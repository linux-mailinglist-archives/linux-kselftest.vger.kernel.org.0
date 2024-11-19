Return-Path: <linux-kselftest+bounces-22251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB569D23D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D82B2553B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BD1C4609;
	Tue, 19 Nov 2024 10:50:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E431BD9C8;
	Tue, 19 Nov 2024 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013452; cv=none; b=DrvEl6qY7YsD9VMZHJvIsXg4FWxxDRTlMYsXcSfSV9ZMUHKdiDFN2apyeRp12aI8ZIu67/O3HhRw0vuUnEMTOYbedVaC+xeq4b6D6/mXIq7C56TUPHEBSNNqWyjtFVcGph6EiSZ9Cnh7VAjOAnKVYwZxwH453JN4UrOclp+BSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013452; c=relaxed/simple;
	bh=G7RoBGkStSSVy2yB0dVJ9/CUQPsYjk9IqRXaK6YZCok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbSlOBTPuFuYqOOMd6q1TdwrkKJWv/UYDfbD6S1Qyy30XSAuduIAITE5W5I60pTxucyEAwUxSVNXGHu3rdZ5Yhi6NaSK5fXXzd7cqB7lotR53XJLb2hu6/NbzQ3huTTYvHOBvIg7Iz7bSigbX0jrUrwO8ZM3DexyjzvXGEIuVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt12n6NKdz9v7JS;
	Tue, 19 Nov 2024 18:29:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AE98B1400CD;
	Tue, 19 Nov 2024 18:50:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S4;
	Tue, 19 Nov 2024 11:50:41 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 02/15] module: Introduce ksys_finit_module()
Date: Tue, 19 Nov 2024 11:49:09 +0100
Message-ID: <20241119104922.2772571-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1ftryxtw15KFWDKFy7Awb_yoWrKF48pF
	Z3Gas8WFsagr4fua1ftrWDWw13KrW8Cr4avFy3Crn3AF1vgrWjkF4Fy3ZI9a45GrW8GF4k
	GF4Fqry8GFW7JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr
	1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUsJPEDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEfwAEss

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce ksys_finit_module() to let kernel components request a kernel
module without requiring running modprobe.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/syscalls.h | 10 ++++++++++
 kernel/module/main.c     | 43 ++++++++++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5758104921e6..18bb346bb793 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1233,6 +1233,16 @@ int ksys_ipc(unsigned int call, int first, unsigned long second,
 int compat_ksys_ipc(u32 call, int first, int second,
 	u32 third, u32 ptr, u32 fifth);
 
+#ifdef CONFIG_MODULES
+int ksys_finit_module(struct file *f, const char *kargs, int flags);
+#else
+static inline int ksys_finit_module(struct file *f, const char *kargs,
+				    int flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..81f79c9ea637 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2852,7 +2852,7 @@ static int early_mod_check(struct load_info *info, int flags)
  * zero, and we rely on this for optional sections.
  */
 static int load_module(struct load_info *info, const char __user *uargs,
-		       int flags)
+		       const char *kargs, int flags)
 {
 	struct module *mod;
 	bool module_allocated = false;
@@ -2953,7 +2953,13 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	flush_module_icache(mod);
 
 	/* Now copy in args */
-	mod->args = strndup_user(uargs, ~0UL >> 1);
+	if (kargs) {
+		mod->args = kstrndup(kargs, ~0UL >> 1, GFP_KERNEL);
+		if (!mod->args)
+			mod->args = ERR_PTR(-ENOMEM);
+	} else {
+		mod->args = strndup_user(uargs, ~0UL >> 1);
+	}
 	if (IS_ERR(mod->args)) {
 		err = PTR_ERR(mod->args);
 		goto free_arch_cleanup;
@@ -3083,7 +3089,7 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 		return err;
 	}
 
-	return load_module(&info, uargs, 0);
+	return load_module(&info, uargs, NULL, 0);
 }
 
 struct idempotent {
@@ -3170,7 +3176,8 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 	return u->ret;
 }
 
-static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
+static int init_module_from_file(struct file *f, const char __user * uargs,
+				 const char *kargs, int flags)
 {
 	struct load_info info = { };
 	void *buf = NULL;
@@ -3195,10 +3202,11 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 		info.len = len;
 	}
 
-	return load_module(&info, uargs, flags);
+	return load_module(&info, uargs, kargs, flags);
 }
 
-static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
+static int idempotent_init_module(struct file *f, const char __user * uargs,
+				  const char *kargs, int flags)
 {
 	struct idempotent idem;
 
@@ -3207,7 +3215,7 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 
 	/* Are we the winners of the race and get to do this? */
 	if (!idempotent(&idem, file_inode(f))) {
-		int ret = init_module_from_file(f, uargs, flags);
+		int ret = init_module_from_file(f, uargs, kargs, flags);
 		return idempotent_complete(&idem, ret);
 	}
 
@@ -3217,15 +3225,16 @@ static int idempotent_init_module(struct file *f, const char __user * uargs, int
 	return idempotent_wait_for_completion(&idem);
 }
 
-SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
+static int _ksys_finit_module(struct file *f, int fd, const char __user * uargs,
+			      const char *kargs, int flags)
 {
 	int err;
-	struct fd f;
 
 	err = may_init_module();
 	if (err)
 		return err;
 
+	/* fd = -1 if called from the kernel. */
 	pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);
 
 	if (flags & ~(MODULE_INIT_IGNORE_MODVERSIONS
@@ -3233,8 +3242,22 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
+	err = idempotent_init_module(f, uargs, kargs, flags);
+	return err;
+}
+
+int ksys_finit_module(struct file *f, const char *kargs, int flags)
+{
+	return _ksys_finit_module(f, -1, NULL, kargs, flags);
+}
+
+SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
+{
+	int err;
+	struct fd f;
+
 	f = fdget(fd);
-	err = idempotent_init_module(fd_file(f), uargs, flags);
+	err = _ksys_finit_module(fd_file(f), fd, uargs, NULL, flags);
 	fdput(f);
 	return err;
 }
-- 
2.47.0.118.gfd3785337b


