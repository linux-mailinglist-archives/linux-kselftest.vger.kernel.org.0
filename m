Return-Path: <linux-kselftest+bounces-49076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B53D293B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 695A5301AAAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB4332EB5;
	Thu, 15 Jan 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxPsHpYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F2330B2F
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519350; cv=none; b=Ob/cWH9+Vql7VcOCm65/rcDghQcXJZHeSg8Lw2O0ILV1aF6o5pFEdyI3kbCZ5k/2mBHNKoJEg7iVzVNSxRGX/K9DxLhOPkBmqJIPZY4ulxdwhDFBsB+i5r0KOKywWUIpYkSkBvsemNDJ0Xnn8L+Jk0vX/y6FnMw7e8dBcdVxWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519350; c=relaxed/simple;
	bh=QGaBI2jmMXiz5Zzh8UzMEfKuZBd6orN3mlkFUEX03hI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i4o9uBpWKPYKDi6UhC1eyXn1ISW0mqud/PJZQS0faDr2riWMlK0nprRtZpX6V1Znx8Jjg45uNOQEgFRP3Z06yKx3+/FNFgOIasOdKUXsg2o6QIuutPZ1oWEuhKwAK5QF9Ry6pzJINlt/QuxnIUyU4PE1tkkoeFFJV93Z7Wc3Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxPsHpYF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so2388845a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519343; x=1769124143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X41FAJWB3N1JsaEn1Z67wfrNr3PEAApqVjSGPombTu8=;
        b=cxPsHpYFdUSeHGJ9xX3z+/Yt6qKvljuGIAInnN2I65i78DPIUmHJV6UmYqeMdVtKkd
         zr9ylpi1hpiZJURV6smmbLB7kbHcIX0sQnzLXcsVEEEUkSjo2ehvXtjIIB8TmLdB3XPC
         hzNtEoD8mEU/XyuVQm6QbOyFHbp3YCrjD7T3NX9fu6nfYDKowuaAYpjtQtD0TO3zMdpB
         jir6ay6CnKDpvSzGOEHdpupD+EKaSGeGyXctWEdQ47bcmILjWFiq32uEzUb/y/51eHNZ
         /SHXLXH+D2WYy5i1SqJJMgmobI4LqcJ3v1BVYqVmc4oq7cLwZaRdZJgmVlRWMlwgfcyw
         aGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519343; x=1769124143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X41FAJWB3N1JsaEn1Z67wfrNr3PEAApqVjSGPombTu8=;
        b=P3/DyboKjixuKAQQf5h5qlFP+qo5A5hXSHnREdDRJxoPdzOwZG3KbofRYDO1qb4D/d
         97tZvqvoQnLjaDkwqlf9KRHYJnDboNq3e59Hoa9RnNS4vCel3ieQ9nPwIdmM0DW2mgOR
         cCFxLQUltldcUjCI/K0C4zbDUIhqaRTj2JnKSFYx1V9/ZAAdlgghT/Qf6QKMcBO23VD5
         0RG0hUgC57gmvQC8MRi1tnlG5pTqcls9DLiaSt/yAR1JRi1u555P1H4RIuU6iBCToAW4
         YBWatnlRwz9zgc+bZ8yR9vsWs7p401cqOPh8idLKI+sOpiNyl5jm8KqMmfsOtYIxFReQ
         rMEw==
X-Forwarded-Encrypted: i=1; AJvYcCXJIbQaMtmBVy8WT3SDceBnRfnkYAJ4yYHjGKfojU/2d9g4XoUQOwcCtIxz99q8g8vNJsAi/s2yoXde6SWc/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGLK/kZu+Neb3HhZ2f/xzAkj7v0Mm4Ppkboeh7tR/dpcxvY2h
	c/R0AaTCMXgt8Ev5dhvEdQeOJpqJIkgFbP8QobIgqjMd5Ob8JqSI8c0AZYBLzaBdiXHbGeJ5OWa
	xteXWM88X62tDMw==
X-Received: from pgct22.prod.google.com ([2002:a05:6a02:5296:b0:c1d:b0b3:5e63])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7116:b0:38b:e9eb:b12c with SMTP id adf61e73a8af0-38dfe67bddemr1490481637.31.1768519342651;
 Thu, 15 Jan 2026 15:22:22 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:46 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-8-jmattson@google.com>
Subject: [PATCH v2 7/8] KVM: x86: nSVM: Handle restore of legacy nested state
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When nested NPT is enabled and KVM_SET_NESTED_STATE is used to restore an
old checkpoint (without a valid gPAT), the current IA32_PAT value must be
copied to vmcb02->save.g_pat.

Unfortunately, the current IA32_PAT value may be restored by KVM_SET_MSRS
after KVM_SET_NESTED_STATE.

Introduce a new boolean, svm->nested.restore_gpat_from_pat. If set,
svm_vcpu_pre_run() will copy vcpu->arch.pat to vmcb02->save.g_pat and clear
the boolean.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 9 ++++++---
 arch/x86/kvm/svm/svm.c    | 8 ++++++++
 arch/x86/kvm/svm/svm.h    | 6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c50fb7172672..61a3e7226cde 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1958,9 +1958,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (ret)
 		goto out_free;
 
-	if (is_guest_mode(vcpu) && nested_npt_enabled(svm) &&
-	    (kvm_state.hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT))
-		svm->vmcb->save.g_pat = save_cached.g_pat;
+	if (is_guest_mode(vcpu) && nested_npt_enabled(svm)) {
+		svm->nested.restore_gpat_from_pat =
+			!(kvm_state->hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT);
+		if (kvm_state->hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT)
+			svm->vmcb->save.g_pat = save_cached.g_pat;
+	}
 
 	svm->nested.force_msr_bitmap_recalc = true;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3f8581adf0c1..5dceab9f4c3f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4217,9 +4217,17 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
+
 	if (to_kvm_sev_info(vcpu->kvm)->need_init)
 		return -EINVAL;
 
+	if (svm->nested.restore_gpat_from_pat) {
+		svm->vmcb->save.g_pat = vcpu->arch.pat;
+		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
+		svm->nested.restore_gpat_from_pat = false;
+	}
+
 	return 1;
 }
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 39138378531e..1964ab6e45f4 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -219,6 +219,12 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/*
+	 * Indicates that vcpu->arch.pat should be copied to
+	 * vmcb02->save.g_pat at the next vcpu_run.
+	 */
+	bool restore_gpat_from_pat;
 };
 
 struct vcpu_sev_es_state {
-- 
2.52.0.457.g6b5491de43-goog


