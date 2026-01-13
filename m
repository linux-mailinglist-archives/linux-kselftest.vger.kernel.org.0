Return-Path: <linux-kselftest+bounces-48811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E63D15FF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6163012658
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5636D279798;
	Tue, 13 Jan 2026 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0B9k/6pi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718E271448
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264244; cv=none; b=Ws28ZiUX5IWPYpfM6D0ZUlCR+iHGnZIjgYqpUXYeFieMlqLk1rBW6xeIwrCy+DHnE14358of4FZY1dZNckidoBC/Bl7Iz2z71dnAIagK+WSJWM6Di7oTS2xS0rKv6c/JTBkvkAacTMzkcJB0uQl98jQJ0U/GXeehQlwAyI6oc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264244; c=relaxed/simple;
	bh=VkCjLytO1ux9i8uRqJqOp4y4po1Gg2Hc+qogiSAqt9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PKSTbw3cWaJTLDNYR8Hz4dqrDA82oSOpTp8NRTsm/3IuQqaWNYSzqQXQrWae+ge0eulyIHLMWpC1/w4r0utISmm8QYxCye5icdxRbCLfG+yUDRtvjTN8HXD+nyODT8xS9oSVoDpqlYd7KRKTPSu4DH+yleeph69Q9QHjFudj/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0B9k/6pi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c3501d784so6565144a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264242; x=1768869042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugtMeXQoG/v0gmSJ0kvlm0/hksPZ0j77UnWX+eyrz3Y=;
        b=0B9k/6piZusNp3ndTRRDmKtE+u2KbU5pt6QypwX4OMnbw9tPVUx+DC+K8mHhzEB8eV
         a07re7QBe2l41DgIVGueTX1/WXBUxm+WQpNqxLv1lzU9A9ofUNCNB7APJnHG7IUc+kLu
         HfWzLPtQC1fLYs4dzKKVNNjxws9WzE3le31Ujj8aPzRcCEiLxpRhDx+EmN0V0PIUbfCz
         nDPLAAJ0YBHlpL2b++IALna8c1LeBTXqdOML+rOUu0CqdHbV591ZNR7koNOCvHGHz4sf
         L4sVh4rb98bCahIhoVGaBADZROLrGHci2481TqFfm6/SRsha1jxog8XSSitcdsf1TD89
         6Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264242; x=1768869042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugtMeXQoG/v0gmSJ0kvlm0/hksPZ0j77UnWX+eyrz3Y=;
        b=Ybn9wyANKCXTpJ2M9G/T5TwB3yAAytWm74sZZMqoZlVZRHlDjrTyQMbIheccQVYFnI
         vbfdKq9KBZSupW9J4qsIHUoNRZUSoVYjOYXW98sRneSjmpJNUu/Fp8o4uHUlrJC9r/jj
         jc3YA3gVYMCuf5qOIFX0u2XZEMVbfqTPCrDr1DPYuMphf7ln9P8axS2EX6ptLk60MA9g
         q2g0wIU+eEC5HyMTIQx7eF/bJH3qd0J71d+Tq8XX5lompz0Wo1HvNllbByRhs3mM/GOJ
         jVL0DE63IggAJxppuLpRz2UXPh5QdIp1IISYSCnw9wEqoYCgjNNX7lDoHgKGQqOSQRZK
         ocIw==
X-Forwarded-Encrypted: i=1; AJvYcCWhLPDqfApSr6srwslibQPebVw8SZNYlvaOpqyNTkzEKsbJhepKXkQmMmNOVfMEqEYfF3eemVdl/ZhurRQHiaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlb1m9meDbICr5zhCdcmrIG5GSbO+XeNuM6XvtdKwj6zUvkfCk
	W9h33s+DxWg7lDbOYh5j9gfUFozRT5lpG5dyG+JFNbqsUVJ80COmCJANQwSIZsrmOBTJaWlCu4P
	I4y4E4+sZj9tFYg==
X-Google-Smtp-Source: AGHT+IEccbNQ4GcGL8d7NNWxCrtOXIcCLpkLBB9GNgvN+JQUSY8qIxF0CgKlAWtcyBdkdr3anPQUtQ+G072f4Q==
X-Received: from pjbfa5.prod.google.com ([2002:a17:90a:f0c5:b0:34c:bdf1:2a21])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2251:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-34f68b65ff0mr15680469a91.13.1768264242031;
 Mon, 12 Jan 2026 16:30:42 -0800 (PST)
Date: Mon, 12 Jan 2026 16:29:59 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-5-jmattson@google.com>
Subject: [PATCH 04/10] KVM: x86: nSVM: Restore L1's PAT on emulated #VMEXIT
 from L2 to L1
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

KVM doesn't implement a separate G_PAT register to hold the guest's
PAT in guest mode with nested NPT enabled. Consequently, L1's IA32_PAT
MSR must be restored on emulated #VMEXIT from L2 to L1.

Note: if L2 uses shadow paging, L1 and L2 share the same IA32_PAT MSR.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c751be470364..9aec836ac04c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1292,6 +1292,16 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_rsp_write(vcpu, vmcb01->save.rsp);
 	kvm_rip_write(vcpu, vmcb01->save.rip);
 
+	/*
+	 * KVM doesn't implement a separate guest PAT
+	 * register. Instead, the guest PAT lives in vcpu->arch.pat
+	 * while in guest mode with nested NPT enabled. Hence, the
+	 * IA32_PAT MSR has to be restored from the vmcb01 g_pat at
+	 * #VMEXIT.
+	 */
+	if (nested_npt_enabled(svm))
+		vcpu->arch.pat = vmcb01->save.g_pat;
+
 	svm->vcpu.arch.dr7 = DR7_FIXED_1;
 	kvm_update_dr7(&svm->vcpu);
 
-- 
2.52.0.457.g6b5491de43-goog


