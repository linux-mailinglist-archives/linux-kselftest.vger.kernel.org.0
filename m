Return-Path: <linux-kselftest+bounces-33218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C5ABA39E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65788507B45
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9182820C1;
	Fri, 16 May 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjwW8P6m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48328151E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423204; cv=none; b=nfuyv34fKDecGkobEGWobMOjmkdj/RQu5M8rQdk2bwEhi2fABo+SpJYc1a9xcKUfhUTn9JQjCidXqeHg7Ql3GiNFzeunJLtAHZ60zNPayZ/UCySM4IbKTHuS5r4mwy4vLyO8tTcFfjgPNB1Xqsr7nkmamHnrKpmGHp1aCHX3fjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423204; c=relaxed/simple;
	bh=NuB/f6nkq4OHFjVHs3gXXIOsYIstssVeMan9gyJklK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsAqd7JgF/jEOwry2UJKN1WpDWfkSFBTMPnxo8Q8MOqlcnwq6CXpyUIYekf3rAoealtkQq90ECjAY30Hmo3b6QKeX7zINZd0U8U+MXlWjZA3YHR4nVGb8pu9Nv8zwVPLNjlFvgAgI8JUIdMg+M0OB81pUN2fjD5JZAgjpGSSRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjwW8P6m; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231e059b34dso6636955ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423202; x=1748028002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcD6u0JZ2o5dpCGxWEFpq76ioIg39n0Fm+ILo2b7fTo=;
        b=mjwW8P6maoDIIbGFFNwK97/yj8bo7I0LSYbVCYRHIkRdmadi0sB2A+stpItNvu/amb
         XfMiDf9/M1UBoxk3h/um2ikuxsa2cyWBpssL6pN5v+ATJXvTQPlrxLQ5QYtJPf7VU9Mm
         3yQLA2gsHV+YLaf1x5vDZpxfgzVCLctzeGLv2n/USSrEegGY009AEeobfhJcsUk13dkJ
         S0cSUmyUuLp2JkjarNbkujX9H8PvhvpOiHCIN8uGSNhHLIxa5Y17nzZe1lyBtlbJ7PRI
         X06dRR8vSfOVMdAuTnayTVxJUXhmyPpiPFIoFDJG88CeEgtaXPYinrGHi4KSGFzwRUr9
         pRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423202; x=1748028002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcD6u0JZ2o5dpCGxWEFpq76ioIg39n0Fm+ILo2b7fTo=;
        b=tlGA5QJ1NDkCqsp98URz0DaqPxOYmVAYX8MluFOhwo9xlLEqp9b21PI+hLWHyF/CMO
         b2q70VwY0o2jVh/YPFSAntXB0nO2Hg+7oFuGu8QI6OuMzpE/X1bQPlyKkWvJUX5RJz6S
         Y71aaoB18T+YG5PItIABanZhDe7pz8voF/75leQ1dwLGDp7AjMTvu0Wp72JBrmwqw3/T
         ax/vjqI9Z50KGscxXNHEdwW4Sn45aoUOii7leCxu4kjO7wBcbMfLhrb3bS0Cko3eZUd/
         QmKIrL43jY0ybs/dPKYN66zzzMm7MnMmMiqrJIh/k9wWZfF4GVc2npl3ukOD0ES6PZma
         jg9A==
X-Forwarded-Encrypted: i=1; AJvYcCWEaTctp9krgKTEOmpyQ4Tjn4Ss5N4sc+6Xt6WT6azYjDuLRYKGVj07HxhDgJsiot3tRLvGh8vBrRWWIcwvSek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1s2nbECNDmn+NTDLbVUIwjHKFwvbKENmd6Z4ewTifGuttsniY
	hTdOMR1iK8fal2Jq5oGYB1uphz0oc671q2BGrcqYci1hGsvVgb82lSa1Js1+8jKxcgcB3WWvkXZ
	ujxjoqQ3hXtCaILeqcCK1LsXO1/Na5YuadDeVISzbIfc/IvduOEJvCamW8YX1QYpmZqkHwuyJBg
	qJzv0=
X-Google-Smtp-Source: AGHT+IHAks9p6aEl1daXh7zR8tIAiKXLPdB+oQKMTtgz7kcarMzyttyq7vXQeQX44ygO4jg4JLr2qMfpus3k
X-Received: from plpe4.prod.google.com ([2002:a17:903:3c24:b0:22e:4288:ad7])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40d0:b0:224:194c:694c
 with SMTP id d9443c01a7336-231de3764d3mr58245605ad.28.1747423201887; Fri, 16
 May 2025 12:20:01 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:29 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <02fa2a32b0628bf9e8e9700a79fa02f0b13b2e90.1747368093.git.afranji@google.com>
Subject: [RFC PATCH v2 09/13] KVM: x86: Refactor common migration preparation
 code out of sev_vm_move_enc_context_from
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium

From: Ackerley Tng <ackerleytng@google.com>

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm/sev.c          | 29 +++---------------------
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/x86.c              | 39 ++++++++++++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6c06f3d6e081..179618300270 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1871,7 +1871,7 @@ struct kvm_x86_ops {
 	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*mem_enc_unregister_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 	int (*vm_copy_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
-	int (*vm_move_enc_context_from)(struct kvm *kvm, unsigned int source_fd);
+	int (*vm_move_enc_context_from)(struct kvm *kvm, struct kvm *source_kvm);
 	void (*guest_memory_reclaimed)(struct kvm *kvm);
 
 	int (*get_feature_msr)(u32 msr, u64 *data);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b3048ec411e2..689521d9e26f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2000,34 +2000,15 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	return 0;
 }
 
-int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
+int sev_vm_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm)
 {
 	struct kvm_sev_info *dst_sev = to_kvm_sev_info(kvm);
 	struct kvm_sev_info *src_sev, *cg_cleanup_sev;
-	CLASS(fd, f)(source_fd);
-	struct kvm *source_kvm;
 	bool charged = false;
 	int ret;
 
-	if (fd_empty(f))
-		return -EBADF;
-
-	if (!file_is_kvm(fd_file(f)))
-		return -EBADF;
-
-	source_kvm = fd_file(f)->private_data;
-	ret = kvm_mark_migration_in_progress(kvm, source_kvm);
-	if (ret)
-		return ret;
-	ret = kvm_lock_two_vms(kvm, source_kvm);
-	if (ret)
-		goto out_mark_migration_done;
-
-	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
-	    sev_guest(kvm) || !sev_guest(source_kvm)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	if (sev_guest(kvm) || !sev_guest(source_kvm))
+		return -EINVAL;
 
 	src_sev = to_kvm_sev_info(source_kvm);
 
@@ -2066,10 +2047,6 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		sev_misc_cg_uncharge(cg_cleanup_sev);
 	put_misc_cg(cg_cleanup_sev->misc_cg);
 	cg_cleanup_sev->misc_cg = NULL;
-out_unlock:
-	kvm_unlock_two_vms(kvm, source_kvm);
-out_mark_migration_done:
-	kvm_mark_migration_done(kvm, source_kvm);
 	return ret;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 35df8be621c5..7bd31c0b135a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -757,7 +757,7 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 int sev_mem_enc_unregister_region(struct kvm *kvm,
 				  struct kvm_enc_region *range);
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd);
-int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd);
+int sev_vm_move_enc_context_from(struct kvm *kvm, struct kvm *source_kvm);
 void sev_guest_memory_reclaimed(struct kvm *kvm);
 int sev_handle_vmgexit(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 422c66a033d2..637540309456 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6597,6 +6597,43 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 	return 0;
 }
 
+static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
+{
+	int r;
+	struct kvm *source_kvm;
+	struct fd f = fdget(source_fd);
+	struct file *file = fd_file(f);
+
+	r = -EBADF;
+	if (!file)
+		return r;
+
+	if (!file_is_kvm(file))
+		goto out_fdput;
+
+	r = -EINVAL;
+	source_kvm = file->private_data;
+	if (kvm->arch.vm_type != source_kvm->arch.vm_type)
+		goto out_fdput;
+
+	r = kvm_mark_migration_in_progress(kvm, source_kvm);
+	if (r)
+		goto out_fdput;
+
+	r = kvm_lock_two_vms(kvm, source_kvm);
+	if (r)
+		goto out_mark_migration_done;
+
+	r = kvm_x86_call(vm_move_enc_context_from)(kvm, source_kvm);
+
+	kvm_unlock_two_vms(kvm, source_kvm);
+out_mark_migration_done:
+	kvm_mark_migration_done(kvm, source_kvm);
+out_fdput:
+	fdput(f);
+	return r;
+}
+
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -6738,7 +6775,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		if (!kvm_x86_ops.vm_move_enc_context_from)
 			break;
 
-		r = kvm_x86_call(vm_move_enc_context_from)(kvm, cap->args[0]);
+		r = kvm_vm_move_enc_context_from(kvm, cap->args[0]);
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
 		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
-- 
2.49.0.1101.gccaa498523-goog


