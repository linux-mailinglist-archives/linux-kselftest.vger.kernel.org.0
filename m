Return-Path: <linux-kselftest+bounces-48815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB9D16050
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81602306527B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F225393B;
	Tue, 13 Jan 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiRo5sbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10E288522
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264249; cv=none; b=XbW6g5cx6JuF+RdlVw2RJX+WrPD6pGVErf6uBOnFwQ/fxk8y1SN8FwwBQb9nvfYv4GBbOfvJ6emEWsIWe+cPCjKWxz97oAjuAFaAe3HQGaay4FjAKldWf9jJgVjiha5iX1aFq/aNxG6peT0FCI19rWnm5RQk/BjUNkLVXSzMli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264249; c=relaxed/simple;
	bh=GXNfsZodxJg18lIVOowWLOQoXl4JDdLPRWwv0h+oAGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBGa7/1gCDlDkUKxuXO8KJZGoiziY9mxVMtb4q3OyynDK4SEpzWX0ILQTLULlormBtaa178q+swrm7bLNZ8pVr74e0cp+H/N5wIPrE2H/hoP7FDAjIESOVUcmwIO7v0H8ri3xl847EHw5hMyWE5a5ceU2pySWy1rmumfVhwce24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiRo5sbL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso14221000a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768264248; x=1768869048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BxdR1vY6NdM1JiLZatN+UvPHxnxGanJUBcgu7o+uIY=;
        b=WiRo5sbLe/QeNo75WnxGMf8App4wa0u+6MCzq41PgiKeaB1FH3xf/wxM15+wJhhlUJ
         7J5sKH96zvyaVK+zw6ru7Xe57x8ph/v0hrmnYbY9x3h1tspdDoyJIGemq1NJsScThkfY
         w+ikfcuZxqU+8e1u7aKFJ15/Eq4kPcClD2OxyzpDzwzvRoruCjDBgoGsOiCZXOCO+OMu
         7QeYuhR1c5v4d5t/M0DxAwGoEhu6GbhviCQYwJZiGTDQ4q59Lp+Xu/YBHGRwU70sSzaC
         k7rhCV0l78UtjU9CNNPKxJnVzkbIS81CPsVLWFuFXY3UuilFrpNOIkn++cLSr/AyY/u7
         WoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768264248; x=1768869048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BxdR1vY6NdM1JiLZatN+UvPHxnxGanJUBcgu7o+uIY=;
        b=XIfZKNniFuukMHJ3/86ZOvX0RJmUzyfMAuw3+HOv8xkHvslBBjQWoHUYU8zEc0wdWu
         9YhHw5/tRo1IhTeyga11LRI8KLhDxQ464BgOSFRnzjN6P/o/blLYk4hUZ6IEYhasUW9X
         uFy3IIdn4Ho5WPjrey15GsJi2/UASHrw3xeJ5Ie2H/wsyMyYN7oiGwEfYLIYmhgSmgbh
         RdA63vBam9Us/hi1DssivyR1K0vL+H2AmQZRDQDMQEazCaq87eZEJLBA6tQMP3uwMSDN
         3cdvepi2EFknsfvbJGGr0Rjo5vZZ0knGo9IMP1PpJpX/ejf3RavPF2n2PisH640BAK6g
         5L7g==
X-Forwarded-Encrypted: i=1; AJvYcCVlXArz36wn54kyyBGo7dS+b6Ekpwe6CEVehOXEVUr/plUN2iAVIMig598umq+Rh8/QMgMgQnqhZMwcwNcQEmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTIgCtJU8u1hs/aHx2zv9Hd9tuYhU7qHMDDkvRn/h4yEHTZD9
	ewae/nDuqeJBq7TSfjSww0CnyOw8fVIaLcruSsTxT0hzK5nHRsfocgVkdK1gRrsl4jISHHFrB1q
	AMFGJ0Lj5XTugvg==
X-Google-Smtp-Source: AGHT+IHe5+A3CkmMwfa6NX/c/y3dmZRsvN4fz2G+7h6Oyq2lMwLT16xSzZnTnDPJSkfFMjPIdXJMlR/jIYa48w==
X-Received: from pjok19.prod.google.com ([2002:a17:90a:9113:b0:34c:5a1b:47fb])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5708:b0:340:bde5:c9e8 with SMTP id 98e67ed59e1d1-34f68cbe5c9mr16431579a91.22.1768264247741;
 Mon, 12 Jan 2026 16:30:47 -0800 (PST)
Date: Mon, 12 Jan 2026 16:30:03 -0800
In-Reply-To: <20260113003016.3511895-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113003016.3511895-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113003016.3511895-9-jmattson@google.com>
Subject: [PATCH 08/10] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on emulated
 #VMEXIT from L2 to L1
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

According to the APM volume 3 pseudo-code for "VMRUN," when nested
paging is enabled in the VMCB, the guest PAT register (gPAT) is saved
to the VMCB on #VMEXIT.

KVM doesn't implement a separate gPAT register. Instead, the guest PAT
is stored in the IA32_PAT MSR while in guest mode (L2) and nested NPT
is enabled in vmcs02.

Save the current IA32_PAT MSR to the vmcb12 g_pat field on
emulated #VMEXIT from L2 to L1.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 90edea73ec58..5fbe730d4c69 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1197,6 +1197,15 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
 
+	/*
+	 * KVM stores the guest PAT in the IA32_PAT register while in
+	 * guest mode with nested NPT enabled (rather than in a
+	 * separate G_PAT register). Hence, the IA32_PAT MSR is stored
+	 * in the VMCB12 g_pat field on #VMEXIT.
+	 */
+	if (nested_npt_enabled(svm))
+		vmcb12->save.g_pat = vcpu->arch.pat;
+
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
 		vmcb12->save.s_cet	= vmcb02->save.s_cet;
 		vmcb12->save.isst_addr	= vmcb02->save.isst_addr;
-- 
2.52.0.457.g6b5491de43-goog


