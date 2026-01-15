Return-Path: <linux-kselftest+bounces-49069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CCD2939D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BD5B300FBC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE6330B06;
	Thu, 15 Jan 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehqXKrw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB33242B0
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519335; cv=none; b=ZwNGbrxAriECtxcwINn6OZ4DpsbFyiTmOVM2y6qRQfEJkpv1FSIH/q+Ab9eKXNuudAjFt3AV8ZKqQti50C29OJ76V15fvDh6mWUg+3mPMgkP2QhhCuFHX9nxPsUjFJ5mPfGjATK9Us/GGqBvupY4j30jhxyxTcpkIIeqQM4/gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519335; c=relaxed/simple;
	bh=O8JPsEukT2yzt7zvNXp8mKQmoxRMvqrQ7tGet8dBl4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pv1EPUifWeiOg1Y866Uhapc5a2KFv8Riv7zhN7/w4U/8RB7lGcZwZNEbnQVaRJCQH/MinA00LMwxonHlXE9dErQa2nBpP5wJdL+jiZQBe8ycJrldPgjMsWIThkeETEEXCJfRjCt3hsNMXAykTWI75ix53nrF9iyC6x3bmOsMvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehqXKrw5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81f3fe5ca8eso1327557b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519333; x=1769124133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htGq+Uz9N574rHPXi8Cv7teGXNue+pPUNMmd++slxUM=;
        b=ehqXKrw5QjjssZ765G5dOIKdZ0BDNRZ5nvEREHLfkCHs9YY+FrxSq5pbAZtfuJJgch
         k8MCl+4dTb+X0h7CcKdxdyqM01irhlVJ7UC2jiRwo1EXaMzsQ99s1dsfWUi0/hdTJI/f
         ekUd34S6NFmJJuftxQPabLV+DLCw8EUVtWcKCM0l3dueOgmbF0nNbF0jsy4qGJaPKoXq
         /m/4WR19SP+6QdpsdFWfQt5wqJXbRjW8I4zeRt9w1/eFug4x017lvurPS45HsaO9Lcq0
         gpSaG1wuD9hQV0TjcVc6dcnhWgEtHQgR40tRXOVn8DF/1g0pkULshEO3/nfmflt/vfoa
         pONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519333; x=1769124133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htGq+Uz9N574rHPXi8Cv7teGXNue+pPUNMmd++slxUM=;
        b=EwKaMJLMUtjJkFICA49V7o7O+yxXAbgaDzVgdb46Xp7l9NLG/qvyiabTbapIaZFVgO
         QYc9Qfbf6Dp0ENayV1Bg7RLOrzQYk9iCxQQjLDg0JhWPnInw2q75EiTbZl+h56JSsJbz
         jQjCK/zVqsNxr/3K19pwZH2PgXao7YfROiDVHksUH05yaIQjOcUnscdkIrYiK3dv2cNL
         d2HJ/6uJDg6kSWk05iPuhHcjw3oCigGNJdiqfdor7Nm9j7V72przkefIg1YrmhFY6Mnh
         nZLyozMYlkNU6mnUEiw4qAzB0Iv6yUrSKpfwHH3aK4++CM6CLTHFkKCdWnQRM0M5uBXS
         BfNg==
X-Forwarded-Encrypted: i=1; AJvYcCV/8FesKdFwJ1E+TrOQjnm+ImC9SzNNcVqbBbasOokHxj370jAp8SBqWxbXexhM2hqEUINSPewMgkVBY2BnYBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs89i+M9yHJSE1Wm+tRihHSDp1SAvoYcMirKSMtE5nmnHudfS3
	cKXjB2TtC3WL4E/upQKpwvhB7Phl3Tx5rNktfX2c3RxBAxx/mVX17M4mCVao3I5aqO+JcPlzbuE
	dwzqHkW8+RUn+4g==
X-Received: from pfbk10.prod.google.com ([2002:a05:6a00:b00a:b0:7dd:8bba:63ab])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c9b:b0:81f:50ea:5d97 with SMTP id d2e1a72fcca58-81fa0355280mr985031b3a.44.1768519333438;
 Thu, 15 Jan 2026 15:22:13 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:40 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-2-jmattson@google.com>
Subject: [PATCH v2 1/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to either
 hPAT or gPAT
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When the vCPU is in guest mode with nested NPT enabled, guest accesses to
IA32_PAT are redirected to the gPAT register, which is stored in
vmcb02->save.g_pat.

Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirected
to hPAT, which is stored in vcpu->arch.pat.

This is architected behavior. It also makes it possible to restore a new
checkpoint on an old kernel with reasonable semantics. After the restore,
gPAT will be lost, and L2 will run on L1's PAT. Note that the old kernel
would have always run L2 on L1's PAT.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7041498a8091..3f8581adf0c1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2846,6 +2846,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DE_CFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+	case MSR_IA32_CR_PAT:
+		if (!msr_info->host_initiated && is_guest_mode(vcpu) &&
+		    nested_npt_enabled(svm))
+			msr_info->data = svm->vmcb->save.g_pat; /* gPAT */
+		else
+			msr_info->data = vcpu->arch.pat; /* hPAT */
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -2929,14 +2936,24 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 		break;
 	case MSR_IA32_CR_PAT:
-		ret = kvm_set_msr_common(vcpu, msr);
-		if (ret)
-			break;
+		if (!kvm_pat_valid(data))
+			return 1;
 
-		svm->vmcb01.ptr->save.g_pat = data;
-		if (is_guest_mode(vcpu))
-			nested_vmcb02_compute_g_pat(svm);
-		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+		if (!msr->host_initiated && is_guest_mode(vcpu) &&
+		    nested_npt_enabled(svm)) {
+			svm->vmcb->save.g_pat = data; /* gPAT */
+			vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+		} else {
+			vcpu->arch.pat = data; /* hPAT */
+			if (npt_enabled) {
+				svm->vmcb01.ptr->save.g_pat = data;
+				vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_NPT);
+				if (is_guest_mode(vcpu)) {
+					svm->vmcb->save.g_pat = data;
+					vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+				}
+			}
+		}
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
-- 
2.52.0.457.g6b5491de43-goog


