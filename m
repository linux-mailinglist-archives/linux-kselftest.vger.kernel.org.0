Return-Path: <linux-kselftest+bounces-37625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF2AB0AF87
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF644E813B
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E823B60A;
	Sat, 19 Jul 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI0dpn3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845B23A563;
	Sat, 19 Jul 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752923600; cv=none; b=Tw2HF1JxYOIpmQJAZ7JKQYLaVunC8I9TyZhbSlFrDHkaesAurbqh1ApCMYoV4H631ZaJgZW2+UNlwM5I9ZH8yN5QhF37UiLgcWcNk2kVQKB+PrJyVT6Fs+QUGxK9J9O7zg8n6QFwAlWRn46kk/glv2quDftwlJWzeFph85DoD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752923600; c=relaxed/simple;
	bh=r8lTNjeNnUfemO2GypZqiyYgLF4NkQp7YFBIugfmea8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdTqZoAFUb4S34p1P5QTBiNVabwuFh0uKPgBXD1VlMTwu9OqC9moCX8zHzjzzGrxTIM+tiN5fH8taoWb5wS/hPd6MlwWj7MeRFyYJPiXgNiquVgw7dwxwyL/h/k8F3pCKhVWvPTR0kodUXarV8cxp26WnJY/Cpu106qF5FbIYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI0dpn3E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236470b2dceso23802995ad.0;
        Sat, 19 Jul 2025 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752923598; x=1753528398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RTREgjI7+tNhJ+8DPCuoyFAFcZSAMYB6+g1NG2DmPY=;
        b=kI0dpn3E1yBiTvMwtyt+Hq+6PjEtVmlzVVHbPIf1n5cj+5TH2HotrSGHSDcMftPUAA
         chT1zlO6clLzNYZcClhgeqEh3eRgIaXJMr9lYQCpVYE5g60/ObEkRApDcir55fzwS1Ol
         lGgg5+kWfLz4tUKHrk3U9lxNyCmilW/NovNsBUpenB1X4CD2Eh3MpgkqsS6SmWt1AG7r
         LeAVT8gAnTTUplE7tqBRFOvJXW/yro5PDdZoSqRE8DEtCy8tfTzGmtSWnfP23naT840y
         teHn0N130YQnE1OEGRc6uNyS3C3z1lcjnFMMO8zlYULnOTkPnY0uqNdqsabHhEbibzNp
         MvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752923598; x=1753528398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RTREgjI7+tNhJ+8DPCuoyFAFcZSAMYB6+g1NG2DmPY=;
        b=sgNkFyb+qb8Lk2x4qwF9a/tL/Knu1MmwkOwr6ie/iymIUeNXtDIxcm7T6HCaXVFtKh
         24C/51r6ITzYeI/DKY5ST24wtSmmBrzlfb9obQTGgRS5NKa74s/1+gJ5ddvASEFF5foM
         1sDF4TGQFiLKMmnfUviqmCgkmM4Ibx+22pdw5N10EVvVYlvs49Trc328XirPOsJ+4C0z
         XoQDBkRhpD2AyQEA5f1wrnZ89gXUCWkcY1RgUQmQsDDin3j8Jg7C2Ma5MHJ4SrjgR968
         x+ZhJHjCMSGlahnQ/hf0GogrOAx10KCOJBo3xpBoeTYVSKAN33dkxWWWOfPunEKiBwX1
         PQcw==
X-Forwarded-Encrypted: i=1; AJvYcCU2grk361yeMJ+aJ7FClEzNYiv3xLPsiHUCLwlAmw9ZgGKyiYfGSHkOz2IYnGeAEGZOj5/2Np5vUfZ+nyw=@vger.kernel.org, AJvYcCWFUP/GmTA2Ju0sdr/Lux2Dt31zIqiAFTBd59R+dSLcgurPWGMi6+cUtY87EMmFBFj+WOtux+m7vtqDjSC1Gn7j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2N3tB4Ge1/PZSXX1H9KjI39G0FKXPgNjyZKTDttU2CZonOEes
	Q8E4Mr4vi//9s/NsyLaB5Y5NhIne0uEQbJ4I+rZoHhfgzqOXg5fZssM9
X-Gm-Gg: ASbGnctDc6ebQGagsOwRjBpkOkOGecaEq98rAnkly/CLW14vY6z+dCfjsvVbx8/pjQV
	a1W1XWc4ffk82BLSWCji/HgJf9pylokH1LhyWIicabnuUKedXyNZy+jihHyy2WzXwq2cijr0/X4
	mDwGrVWeJXximnsv+VbXM5epNBFgXpouQGV68/+b5Yy3+TKVuIKNemLzd/YTPiJUu3H9JQi7Bln
	CDOmu0YINJ5KdL985Wz0t+V4AqKOQ/qE0Udon9x6+kqViUYjTKJ2LQV+/XDehmfer7OXkK4RiVA
	ua155YY4Wp9xLMFtk5ccuEC03mch4pBei1ReFP3veodI1jzOCDUGAGGabuicmSa91nkU8YY0sA6
	qqzDrcbNq/s1pP16Z5udC
X-Google-Smtp-Source: AGHT+IHIGCLWVvv5yalOVOy8WKDgdJNrEc9C/gFLLDdC9BVMS/h/JNjAbdeoYEJ58i9QE8Z26itLxQ==
X-Received: by 2002:a17:903:228d:b0:23c:8f4c:6658 with SMTP id d9443c01a7336-23e2572a0dcmr188760075ad.25.1752923598310;
        Sat, 19 Jul 2025 04:13:18 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4c81sm27388875ad.114.2025.07.19.04.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:13:17 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 05:13:13 -0600
Subject: [PATCH RFC 3/4] landlock: add memfd exec LSM hooks and scoping
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-memfd-exec-v1-3-0ef7feba5821@gmail.com>
References: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
In-Reply-To: <20250719-memfd-exec-v1-0-0ef7feba5821@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752923593; l=8635;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=r8lTNjeNnUfemO2GypZqiyYgLF4NkQp7YFBIugfmea8=;
 b=8L4KmWE3ZWhZjyUmYKRhVFPDyBVShtvoNJz8LgLdOGrxWWSTRS3sKp+1bAgGYFP//GtdlcEDP
 NNLSFLkuXsQDn6+Pv0ANlAxG745Ahfj+4ht/oU7zkNMyd/AGK4sBf10
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Implement LSM hooks to enforce memfd execution restrictions:

- hook_mmap_file: Prevent executable mapping of memfd files
- hook_file_mprotect: Block mprotect() adding PROT_EXEC to memfd
  mappings
- hook_bprm_creds_for_exec: Prevent direct execution via execve()
  family
- hook_file_alloc_security: Initialize memfd files with proper access
  masks

All hooks use domain hierarchy checking to enforce scoped restrictions
with proper audit logging. This prevents multiple attack vectors:
- Direct mmap(PROT_EXEC) on memfd
- Two-stage mmap(PROT_READ) + mprotect(PROT_EXEC) bypass
- execve("/proc/self/fd/N") anonymous execution

Implement memfd execution access control in check_memfd_execute_access()
using hierarchy-aware domain checking

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 security/landlock/cred.c |  14 ----
 security/landlock/fs.c   | 195 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 194 insertions(+), 15 deletions(-)

diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 0cb3edde4d18..356dad0b7e9b 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -43,25 +43,11 @@ static void hook_cred_free(struct cred *const cred)
 		landlock_put_ruleset_deferred(dom);
 }
 
-#ifdef CONFIG_AUDIT
-
-static int hook_bprm_creds_for_exec(struct linux_binprm *const bprm)
-{
-	/* Resets for each execution. */
-	landlock_cred(bprm->cred)->domain_exec = 0;
-	return 0;
-}
-
-#endif /* CONFIG_AUDIT */
-
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
 
-#ifdef CONFIG_AUDIT
-	LSM_HOOK_INIT(bprm_creds_for_exec, hook_bprm_creds_for_exec),
-#endif /* CONFIG_AUDIT */
 };
 
 __init void landlock_add_cred_hooks(void)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d86d21034f4c..e8b58f2fd87e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1880,7 +1880,24 @@ static int hook_file_alloc_security(struct file *const file)
 	 * without going through the file_open hook, for example when using
 	 * memfd_create(2).
 	 */
-	landlock_file(file)->allowed_access = LANDLOCK_MASK_ACCESS_FS;
+	access_mask_t allowed_access = LANDLOCK_MASK_ACCESS_FS;
+	const struct landlock_cred_security *subject;
+	size_t layer;
+	static const struct access_masks memfd_scope = {
+		.scope = LANDLOCK_SCOPE_MEMFD_EXEC,
+	};
+
+	/* allow everything by default */
+	landlock_file(file)->allowed_access = allowed_access;
+
+	subject = landlock_get_applicable_subject(current_cred(), memfd_scope,
+						  &layer);
+	if (subject && is_memfd_file(file)) {
+		/* Creator domain restricts memfd execution */
+		allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
+		landlock_file(file)->allowed_access = allowed_access;
+		/* Store creator and audit... */
+	}
 	return 0;
 }
 
@@ -2107,6 +2124,178 @@ static void hook_file_free_security(struct file *file)
 	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
 }
 
+static bool
+check_memfd_execute_access(const struct file *file,
+			   const struct landlock_cred_security **subject,
+			   size_t *layer_plus_one)
+{
+	const struct landlock_ruleset *executor_domain, *creator_domain;
+	const struct landlock_cred_security *creator_subject;
+	static const struct access_masks memfd_scope = {
+		.scope = LANDLOCK_SCOPE_MEMFD_EXEC,
+	};
+	size_t creator_layer_plus_one = 0;
+	bool executor_scoped, creator_scoped, is_scoped;
+
+	*subject = NULL;
+	*layer_plus_one = 0;
+
+	/* Check scoping status for both executor and creator */
+	*subject = landlock_get_applicable_subject(current_cred(), memfd_scope,
+						   layer_plus_one);
+	creator_subject = landlock_get_applicable_subject(
+		file->f_cred, memfd_scope, &creator_layer_plus_one);
+
+	executor_scoped = (*subject != NULL);
+	creator_scoped = (creator_subject != NULL);
+
+	if (!creator_scoped)
+		return true; /* No scoping enabled, allow execution */
+
+	/* Get domains for comparison */
+	executor_domain = executor_scoped ? (*subject)->domain : NULL;
+	creator_domain = creator_scoped ? creator_subject->domain :
+					  landlock_cred(file->f_cred)->domain;
+
+	pr_info("MEMFD_DEBUG: executor_domain=%p, creator_domain=%p\n",
+		executor_domain, creator_domain);
+
+	/*
+	 * Same-domain: deny to prevent read-to-execute bypass
+	 * This prevents processes from bypassing execute restrictions
+	 * by creating memfd in the same domain
+	 */
+	if (executor_domain == creator_domain)
+		return false;
+
+	/*
+	 * Cross-domain: use domain hierarchy checks to see if executor is
+	 * scoped from creator domain_is_scoped() returns true when access
+	 * should be DENIED
+	 */
+	if (executor_scoped || creator_scoped) {
+		is_scoped = domain_is_scoped(executor_domain, creator_domain,
+					     LANDLOCK_SCOPE_MEMFD_EXEC);
+		pr_info("MEMFD_DEBUG: Cross-domain: is_scoped=%d, returning=%d\n",
+			is_scoped, !is_scoped);
+		/* Return true (allow) when NOT scoped, false (deny) when scoped */
+		return !is_scoped;
+	}
+
+	return true;
+}
+
+static int hook_mmap_file(struct file *file, unsigned long reqprot,
+			  unsigned long prot, unsigned long flags)
+{
+	const struct landlock_cred_security *subject;
+	size_t layer_plus_one;
+
+	/* Only check executable mappings */
+	if (!(prot & PROT_EXEC))
+		return 0;
+
+	/* Only restrict memfd files */
+	if (!is_memfd_file(file))
+		return 0;
+
+	/* Check if memfd execution is allowed */
+	if (check_memfd_execute_access(file, &subject, &layer_plus_one))
+		return 0;
+
+	/* Log denial for audit */
+	if (subject) {
+		landlock_log_denial(subject, &(struct landlock_request) {
+			.type = LANDLOCK_REQUEST_SCOPE_MEMFD_EXEC,
+			.audit = {
+				.type = LSM_AUDIT_DATA_ANONINODE,
+				.u.file = file,
+			},
+			.layer_plus_one = layer_plus_one,
+		});
+	}
+
+	return -EACCES;
+}
+
+static int hook_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+			      unsigned long prot)
+{
+	const struct landlock_cred_security *subject;
+	size_t layer_plus_one;
+
+	/* Only check when adding execute permission */
+	if (!(prot & PROT_EXEC))
+		return 0;
+
+	/* Must have a file backing the VMA */
+	if (!vma || !vma->vm_file)
+		return 0;
+
+	/* Only restrict memfd files */
+	if (!is_memfd_file(vma->vm_file))
+		return 0;
+
+	/* Check if memfd execution is allowed */
+	if (check_memfd_execute_access(vma->vm_file, &subject, &layer_plus_one))
+		return 0;
+
+	/* Log denial for audit */
+	if (subject) {
+		landlock_log_denial(subject, &(struct landlock_request) {
+			.type = LANDLOCK_REQUEST_SCOPE_MEMFD_EXEC,
+			.audit = {
+				.type = LSM_AUDIT_DATA_ANONINODE,
+				.u.file = vma->vm_file,
+			},
+			.layer_plus_one = layer_plus_one,
+		});
+	}
+
+	return -EACCES;
+}
+
+static int hook_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+#ifdef CONFIG_AUDIT
+	/* Resets for each execution. */
+	landlock_cred(bprm->cred)->domain_exec = 0;
+#endif /* CONFIG_AUDIT */
+
+	const struct landlock_cred_security *subject;
+	size_t layer_plus_one;
+	struct file *file;
+
+	if (!bprm)
+		return 0;
+
+	file = bprm->file;
+	if (!file)
+		return 0;
+
+	/* Only restrict memfd files */
+	if (!is_memfd_file(file))
+		return 0;
+
+	/* Check if memfd execution is allowed */
+	if (check_memfd_execute_access(file, &subject, &layer_plus_one))
+		return 0;
+
+	/* Log denial for audit */
+	if (subject) {
+		landlock_log_denial(subject, &(struct landlock_request) {
+			.type = LANDLOCK_REQUEST_SCOPE_MEMFD_EXEC,
+			.audit = {
+				.type = LSM_AUDIT_DATA_ANONINODE,
+				.u.file = file,
+			},
+			.layer_plus_one = layer_plus_one,
+		});
+	}
+
+	return -EACCES; /* maybe we should return EPERM? */
+}
+
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
 
@@ -2133,6 +2322,10 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
 	LSM_HOOK_INIT(file_set_fowner, hook_file_set_fowner),
 	LSM_HOOK_INIT(file_free_security, hook_file_free_security),
+
+	LSM_HOOK_INIT(mmap_file, hook_mmap_file),
+	LSM_HOOK_INIT(file_mprotect, hook_file_mprotect),
+	LSM_HOOK_INIT(bprm_creds_for_exec, hook_bprm_creds_for_exec),
 };
 
 __init void landlock_add_fs_hooks(void)

-- 
2.43.0


