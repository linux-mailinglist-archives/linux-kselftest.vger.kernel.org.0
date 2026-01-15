Return-Path: <linux-kselftest+bounces-49070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2503D293BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D4830AE784
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594BD330B16;
	Thu, 15 Jan 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWSzmM15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798E330D2F
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519338; cv=none; b=bJJCKlX/ApXBkMIlExyZIe6ehg8NIVufXFTiYCkPR5+nPWjk3TtH8PePbV7JQZIDqvX5HsqjlM8S7qv5mI9F7Vu3NGeCOFjTc2+3JBMbKgPbPdCD0mMdTaCpMzCesYFDkFf09Wqd3SO70QULTWH4HLSOHxe+hFAKugqmTMMuKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519338; c=relaxed/simple;
	bh=uwL+q/W1CxUvgMFsliajMlQsLTrx9NGxQZcgHZ24XHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pekuvgo7N69yAb9Vcsu7kisyVH7D39BEQ8tCwmmjZrZ+MkFK5Al2k4wsVFb+1NSGmlhInmfta3EJ/F3RjmLCeMlheTHRhWb8jDdiTk+lISy8VD0gdUzdzPFver7sTBlNIairjTYXyxEl7TYsubTr67OWpLB8K3LC6c3VF0U9Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWSzmM15; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a58c1c74a3so10697725ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519336; x=1769124136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2a2OqxtfCuKT3wr2Ja9hUv7m6j011UQrkURc2LP8Lw=;
        b=tWSzmM15nVpgOav07acxwYd9ASDYHeLi6Z1oStsJmDbSzzBlqpOQkXTvrGKvROJCTG
         Icj2S2RVZew2E7g0pNmT+2hTrZuad95zmS0N/+Ml+cwejaBq8iZBrU/LUDo0fqjac62s
         ZuUjETsuGnHtppJ0DfCV16GigSteeQUmdzIcP3zq7LdYDBb3MF9bK+YLIdQ5V5s64lj5
         7wZnWBJ4saJeNwhDlqDtPAHucsWliTXcJtnqAU0guC2HdLwDDeCe2yCyTrB1NyC2+vqK
         THkRfud+h/aDvvhjpEFruiWX+RRawRoWrnSV5xWVjhhV8dIQJeBvt1cQkEq71JRwe6l9
         gyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519336; x=1769124136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2a2OqxtfCuKT3wr2Ja9hUv7m6j011UQrkURc2LP8Lw=;
        b=bLvuqQBJqgdfJtxG5W7QmgOGhITvXMxR57ISJ48cjfJ8VjMz4gpVHVhs36TyAlgilS
         Ai8YaTopImDGnjoh99nuMSKhjgvpBeZBGytj845UMA8LYhRQz1GPdbfE8pI4AsjRZJcg
         ZXnng0OUcJQDJahyUg6z8vaOev7lFvlmBjD6BIpIZU2kErmr3jdTStSEQ5rAQOiECqik
         ZMKDrA2YyIKNegv0nkjmONy/y13JFe9jlW1YprprlV6bYhEAJZyHwJj8p+1i/ZdpMu85
         hQdYh4f1/vUnVbPqq5J0UgBtC+XFuk52r2EKJN5IwbWZ6l00PWn2NvXYUfDFQk3YkTm9
         rrYA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOklskedbTqGOGMxgssmsnh//iEmEVHyQiwFxbva0qCa/UEXvoSfeTzv9epsd59n+AqHVnZ8SQXzGXgC2a8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jIOA/2x5jWx1b5o6jQmfBw+LuSzKQgROmyq9w+j6dsS1DqBl
	xSEXUlSSHpTpYaPiM6oMcGmfM73hexFaTaf/8g3X/sESiL/8B2Q4j547KmGIGurv5QsJxF8ITFC
	oLlatsHCg/6Ol6A==
X-Received: from plbmp7.prod.google.com ([2002:a17:902:fd07:b0:29f:2ec2:58b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a2e:b0:2a1:1f28:d7ee with SMTP id d9443c01a7336-2a7189737e7mr6780315ad.57.1768519336400;
 Thu, 15 Jan 2026 15:22:16 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:42 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-4-jmattson@google.com>
Subject: [PATCH v2 3/8] KVM: x86: nSVM: Add validity check for vmcb12 g_pat
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a validity check for g_pat, so that when nested paging is enabled for
vmcb12, an invalid g_pat causes an immediate VMEXIT with exit code
VMEXIT_INVALID, as specified in the APM, volume 2: "Nested Paging and
VMRUN/VMEXIT."

Update the signature of __nested_vmcb_check_save() to include a pointer to
a struct vmcb_ctrl_area_cached, since the g_pat validity check depend on
the nested paging control bit.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07a57a43fc3b..e65291434be9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -369,7 +369,8 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 
 /* Common checks that apply to both L1 and L2 state.  */
 static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
-				     struct vmcb_save_area_cached *save)
+				     struct vmcb_save_area_cached *save,
+				     struct vmcb_ctrl_area_cached *control)
 {
 	if (CC(!(save->efer & EFER_SVME)))
 		return false;
@@ -400,6 +401,10 @@ static bool __nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
+	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
+	       npt_enabled && !kvm_pat_valid(save->g_pat)))
+		return false;
+
 	return true;
 }
 
@@ -407,8 +412,9 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb_save_area_cached *save = &svm->nested.save;
+	struct vmcb_ctrl_area_cached *ctl = &svm->nested.ctl;
 
-	return __nested_vmcb_check_save(vcpu, save);
+	return __nested_vmcb_check_save(vcpu, save, ctl);
 }
 
 static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
@@ -1892,7 +1898,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
-	    !__nested_vmcb_check_save(vcpu, &save_cached))
+	    !__nested_vmcb_check_save(vcpu, &save_cached, &ctl_cached))
 		goto out_free;
 
 
-- 
2.52.0.457.g6b5491de43-goog


