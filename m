Return-Path: <linux-kselftest+bounces-49074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A59D293DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD4E30EC0AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B07332913;
	Thu, 15 Jan 2026 23:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQoV1DHQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B832D7F3
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519343; cv=none; b=Ik/jVK9BRIg9z4ZKfN2MxQGhhl3fHHeO75TUIbdTdWVHaetL0v4aFjYyXcWT0QR82AcFfXAyx2jE4I+NwEOsvikT+ntNWx+Eme1YQLhgswlGLwoMoLq3S85nJqasrOwsrIUiJ5hVK246eaKF8CUqnLwkQeBe7nG0lR3Cfj0iXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519343; c=relaxed/simple;
	bh=2NzeuSJSVheMxnsV7mxVLQattsOjStF0SiM4zA2NR6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gsN1+kE0yw7SH0Ej2C6OCpJ0K+RLthxWbpWBzDzS0CPzo0CbvOMNVUOGZG6a/gNQFMTWgokZZQON5Ig3y8tpYUN4l6XSKNJxDi7T3C0DuP1+ll1zJfAIVgzEioY2Et09Mzk1kHh4sX2vR2Va+EjzKD+flrh90lkMtGJik8ha/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQoV1DHQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c5e56644646so1233056a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768519341; x=1769124141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4Qn/qvBRqPl8GPJICacl87zhupPz7yPwc1Yli3IWWE=;
        b=sQoV1DHQm7uYCzYzRazQfEVB98VoG9z4OofGW32r4mRv0yZy2vYvBljkzKd6VaVzya
         u3KNcfgh+BVtRZhVldmXXZa6eMQEGFNQN0OjTJoVxwVUxYOaZxOnul7i7mIO4QSghIpc
         Mdp//pDfvs2+JNiZ5egcPuq0b1y6hY4CHXi8Q7X3NwCFBqFAnIbLxQvaSAGVa2JZfBUt
         +9n7w2eH0/IxfB7j0cnNGOLgTTrLps3OHzb3HlB5f+Qx0oV8qgxfqIG0IRKE4Y6Yn5iE
         WlI00rEexmHHZoox8RJsbou9RTbG3An1QBfv1ANnZXtEzhxjJWHpNkEvELkNxpcZBe9+
         RBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519341; x=1769124141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4Qn/qvBRqPl8GPJICacl87zhupPz7yPwc1Yli3IWWE=;
        b=F85TKk2guUkk/peB9KxDwFv3YB/ZUThvAzL4qGPNqHgSmrRqStwhymewWp2vxBGOZB
         TKbw0F3guPaAo2Gj8lOZYXXkXkBTmscRFluYOJgKec0jVULjncQnWzLdBhyIQo8WXN+B
         hyG/fZ1WplxPXCyLCvY+m/hpxOFBw7I75i5F7IOR0wRe5iy9yx6gUMsufNJQOLxBmaiz
         ekGChVnghEZDJIGQPIIShAkXJuGj6Eg607ZqsTwwvwwl5EdQhP2P3bVjp+14pS66L/Yt
         B2Qg6cF+6R251DT4tcIM7Q6RJA4nL9Kz5tUEhk9JIDbrqWwy0HJUFeno4ypKIB1aISty
         bN9w==
X-Forwarded-Encrypted: i=1; AJvYcCXre0YvZ9o1qMRe7yfadIqQ5h9dGkyFDq1GS9gwJoRZ5GLWeODc4DEGrwjBHyJXGZUnXySKmzjc2EiQAyOCRv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6tzSjc7womxQspF0TNby3NaMmB3NAsRRFQJVe9odh5dBc215
	NQcwwGduUvhYTbaBVDsBjjJRpeedXySiTsxSoKQ0pr7q8QYuAi5R2v/l0nzNd+HsMCHzyRqrL0x
	RvXv4p4C0h/2hbw==
X-Received: from pjy23.prod.google.com ([2002:a17:90a:f17:b0:34c:e971:cfb1])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b86:b0:34c:9cec:3898 with SMTP id 98e67ed59e1d1-352678d9b78mr4080056a91.13.1768519341059;
 Thu, 15 Jan 2026 15:22:21 -0800 (PST)
Date: Thu, 15 Jan 2026 15:21:45 -0800
In-Reply-To: <20260115232154.3021475-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115232154.3021475-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115232154.3021475-7-jmattson@google.com>
Subject: [PATCH v2 6/8] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'flags' field to the SVM nested state header, and use bit 0 of the
flags to indicate that gPAT is stored in the nested state.

If in guest mode with NPT enabled, store the current vmcb->save.g_pat value
into the vmcb save area of the nested state, and set the flag.

Note that most of the vmcb save area in the nested state is populated with
dead (and potentially already clobbered) vmcb01 state. A few fields hold L1
state to be restored at VMEXIT. Previously, the g_pat field was in the
former category.

Also note that struct kvm_svm_nested_state_hdr is included in a union
padded to 120 bytes, so there is room to add the flags field without
changing any offsets.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/uapi/asm/kvm.h |  3 +++
 arch/x86/kvm/svm/nested.c       | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 7ceff6583652..80157b9597db 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -495,6 +495,8 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE	0x00000001
 
+#define KVM_STATE_SVM_VALID_GPAT	BIT(0)
+
 /* vendor-independent attributes for system fd (group 0) */
 #define KVM_X86_GRP_SYSTEM		0
 #  define KVM_X86_XCOMP_GUEST_SUPP	0
@@ -530,6 +532,7 @@ struct kvm_svm_nested_state_data {
 
 struct kvm_svm_nested_state_hdr {
 	__u64 vmcb_pa;
+	__u32 flags;
 };
 
 /* for KVM_CAP_NESTED_STATE */
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5fb31faf2b46..c50fb7172672 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1789,6 +1789,8 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 	/* First fill in the header and copy it out.  */
 	if (is_guest_mode(vcpu)) {
 		kvm_state.hdr.svm.vmcb_pa = svm->nested.vmcb12_gpa;
+		if (nested_npt_enabled(svm))
+			kvm_state.hdr.svm.flags |= KVM_STATE_SVM_VALID_GPAT;
 		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
 		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
@@ -1823,6 +1825,11 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 	if (r)
 		return -EFAULT;
 
+	/*
+	 * vmcb01->save.g_pat is dead now, so it is safe to overwrite it with
+	 * vmcb02->save.g_pat, whether or not nested NPT is enabled.
+	 */
+	svm->vmcb01.ptr->save.g_pat = svm->vmcb->save.g_pat;
 	if (copy_to_user(&user_vmcb->save, &svm->vmcb01.ptr->save,
 			 sizeof(user_vmcb->save)))
 		return -EFAULT;
@@ -1904,7 +1911,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		goto out_free;
 
 	/*
-	 * Validate host state saved from before VMRUN (see
+	 * Validate host state saved from before VMRUN and gPAT (see
 	 * nested_svm_check_permissions).
 	 */
 	__nested_copy_vmcb_save_to_cache(&save_cached, save);
@@ -1951,6 +1958,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (ret)
 		goto out_free;
 
+	if (is_guest_mode(vcpu) && nested_npt_enabled(svm) &&
+	    (kvm_state.hdr.svm.flags & KVM_STATE_SVM_VALID_GPAT))
+		svm->vmcb->save.g_pat = save_cached.g_pat;
+
 	svm->nested.force_msr_bitmap_recalc = true;
 
 	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
-- 
2.52.0.457.g6b5491de43-goog


