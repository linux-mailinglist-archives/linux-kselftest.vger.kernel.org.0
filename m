Return-Path: <linux-kselftest+bounces-48816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A9D16026
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F36863010500
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A42BD5B4;
	Tue, 13 Jan 2026 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIddksou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC6299922
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264251; cv=none; b=UNqnXR8vRLxU4bLbMmJxUMNsU/BSR4eg/z9GMJzfl5Esz59Z+798W0s5u/ErsuiXRQsXqcXu4tON915M+Z/KNe3aASzmYs/SJ6OKX72Rn1WzmEh6Gngs8KoxlvRIehjd4y2NPD/1LnSMB/Tcoe3ZT8XJuSwgc9DCFXHxqGOyN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264251; c=relaxed/simple;
	bh=EGhyQwSph0LzMgiu5B+EdES+A6XGxqVH3cwlp19V2xg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdQbGm7a52vEM+bcQGh3CXsZ61DLwI6m4Dy1idChDA99DyrSEhiSP+BLfpN6F02k6auqeKvBMHQcQ5nN/Hd5M1fltX0dZrXXlIB3LO9Mi3OMjaUxBXVc2GXx+7ykIaPfskjTFVcP/mWX3Wer3pV4v9vQzdK98XWLlY4zCrOFRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIddksou; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c904a1168so7738275a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264250; x=1768869050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqn3ma3gV+5ioOHZfJQ8oXgHLrZbIOMhZwVIPABgW6A=;
        b=DIddksoudFL4zcnRN89gCFST/pwBkXl0yy4NI3kwxlKEZvEmafi0tFy6YN5UNndSq5
         hkjVkYZLRFeUAqDxK6Jpj+TQXKcVMsYmV2hjq8mT7ETU6sC52sqQ5NcONSTWzlWCJzgF
         D/yR9N7VzxegAiUSEp7HvhEYv7/MsuA1QGaoSPx8XrflNyb+zzdBznifX48C6YhUt2CF
         QjJCUXyBAoJP0ct2zdZY/avdvVnTCEXKZPN6z6m14WIMZp6gaSN+VGPpoqeOz0+27RlQ
         6JTA1kpgTYaIUleVctpZ8IEFT5S8Ejbte33F+kP4FQ1zhw9PV0r3B3aodiYfd1FJ4EKC
         EShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264250; x=1768869050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqn3ma3gV+5ioOHZfJQ8oXgHLrZbIOMhZwVIPABgW6A=;
        b=fMnZNFmbahy6PFu+6PS8/DnuPvooTXA3xOFg3MS+8Fy+9nWOIxpkWRO96z8orbuqbP
         4+5vRvr1cOdjzjNA7qI5wBbjuAGw4KqdCi0cVNpBuH63nalDzK5LYOKRI7MryyKyv8IM
         eTRHM8wnKoKX4d3BxpT3FfLjnbu9Q41dQXz/7xnpGXlSEPm9UZ6SsdfLJEPvn/GBbxT4
         S5XpFe7mdCM2DMxRE6zE4Y07FggfEe+70aAnwnXqG4sj2W2K3QHLEFKA3MBuZSRaUU1p
         G8fMNKfesg6A2LcGE7pIjq8RH+B9yvO8ibgX8ykwL9um2NGJBeOZwttDsVC6oy6yiqQd
         zPwA==
X-Forwarded-Encrypted: i=1; AJvYcCWDktt1AdmSRLawgCoxUMuBSLiJE58pBtuMw6ynoWCuVVW+L7yCBIodzsy/zmvBYkB3rS4QGHOxL5EueFLkRas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPedkoyfFN51IZJiEa4eye1Qa/WGWRSzozGW5NFPz0D1LhaOmR
	1Kt9OCWL7H6ajuT+3P7XNQeeOLmkCsD7UeUmX6m9vOFOkQtEedMhvjsc48a8OirroeDbWb3WXdv
	+eVgJ6pgf8QOBuA==
X-Google-Smtp-Source: AGHT+IFLNcKt2ozNKiFnGj+m7CgeLyZoO/CQAR137NPaSy1m6tiz+vtzOJT1hpH0lebhCAthvpqABnxiKLxxxg==
X-Received: from pjua12.prod.google.com ([2002:a17:90a:cb8c:b0:34c:d212:cb7f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0b:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-34f68c00b4bmr16640913a91.19.1768264249644;
 Mon, 12 Jan 2026 16:30:49 -0800 (PST)
Date: Mon, 12 Jan 2026 16:30:04 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-10-jmattson@google.com>
Subject: [PATCH 09/10] KVM: x86: nSVM: Fix assignment to IA32_PAT from L2
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Avi Kivity <avi@redhat.com>, Alexander Graf <agraf@suse.de>, 
	"=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, David Hildenbrand <david@kernel.org>, Cathy Avery <cavery@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

In svm_set_msr(), when the IA32_PAT MSR is updated, up to two vmcb
g_pat fields must be updated.

When NPT is disabled, no g_pat fields have to be updated, as they are
ignored by hardware.

When NPT is enabled, the current VMCB (either VMCB01 or VMCB02) g_pat
field must be updated.

In addition, when in guest mode and nested NPT is disabled, the VMCB01
g_pat field must be updated. In this scenario, L1 and L2 share the
same IA32_PAT MSR.

Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c |  9 ---------
 arch/x86/kvm/svm/svm.c    | 14 +++++++++++---
 arch/x86/kvm/svm/svm.h    |  1 -
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5fbe730d4c69..b9b8d26db8dc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -640,15 +640,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
-{
-	if (!svm->nested.vmcb02.ptr)
-		return;
-
-	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
-}
-
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12)
 {
 	bool new_vmcb12 = false;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7041498a8091..74130d67a372 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2933,10 +2933,18 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (ret)
 			break;
 
-		svm->vmcb01.ptr->save.g_pat = data;
-		if (is_guest_mode(vcpu))
-			nested_vmcb02_compute_g_pat(svm);
+		if (!npt_enabled)
+			break;
+
+		svm->vmcb->save.g_pat = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+
+		if (!is_guest_mode(vcpu) || nested_npt_enabled(svm))
+			break;
+
+		svm->vmcb01.ptr->save.g_pat = data;
+		vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_NPT);
+
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 39138378531e..b25f06ec1c9c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -801,7 +801,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
-- 
2.52.0.457.g6b5491de43-goog


