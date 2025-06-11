Return-Path: <linux-kselftest+bounces-34764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D726AD60FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09256165FDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273724A076;
	Wed, 11 Jun 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BejBy1vI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CC248F64
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676626; cv=none; b=ALye8kZ6QMwwbO4cP9y6lcLfjA6PAxRg/1IE1AVcf1miuO58A+QPonrS+PiR3GkKMpEnCnyh6yj4OnZS+mz3WGTOuLCdBH5fLKWWnPxce614TWEsNCgajdzJVdCVv7xONJ/+I/Jgq7vQbMx1PSwiT/sKz1CIwvR3VaLtP156pN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676626; c=relaxed/simple;
	bh=l18NNuz2zr+jRstrv6kyMt+9mV72sgFutUjjJmTOoto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6CviqbueUnXwBdl282p+9+7driGBjySQ18y+ArQzbqhMadcvqH4wvhmwAIrzCBYnSTEN6I2pzTwoIV/J7m0oZjDAXNv+MRJ9fSFgxJpeiF0o+2b/5IhsWQf/oK6JnAKNk6oT7gqj2cpkFdjG0MQFeMxLjXBLGz4b8sLuiUEjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BejBy1vI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso199635b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749676624; x=1750281424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AY4z8bScFURq5DitqWrBML6dYMJAiXsDf7kOOKjRLig=;
        b=BejBy1vIR7/Xw0bj5zIm74wS/L0gIi6tqSFUNGnGyOCQuYMiPsDWQgN0vyJdtZ7aWc
         avSYCpgn9pPMrJ5D2w74p5ZfzeqrHR2uk2zGIaqAt7IOjiAH6QSjzdowFqf8iwiihPyH
         jNFY3dIU4M+Q4HX5ZN/YK2mU17YwGzIEesGeMbUK+69GSkJqCqq1U6fQTWuHLWlS4/xP
         BGJ+wDrGQsWbqybLg1bVkvBmdsL+gjzu01itNGhz/ynggapTpgFK8Zhm3DZ1gSDRnAt4
         7cyZyGmlTigWLws7ffK14yE2cetuutnNGC9pujyjH+QMYM0yTXtNmqPtuLCbBjKxbTZc
         xZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749676624; x=1750281424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AY4z8bScFURq5DitqWrBML6dYMJAiXsDf7kOOKjRLig=;
        b=ACZFvkV3phfUx8HTo0X+vj/hTQBjsfKAfzajXc5hS/yDkYsmksuCNWXktFTO6fCyYj
         /9nyXe4w8SCc/kajpXIbHPnAgec/ZBvp7kOQ3DziqI6JEXWMGsAxth/Q2J3l4hRbneTb
         19+rVdCVzZXlLSdkIpGToWKCaN1sSM4sPynH08a500kfqZMyCqDfPS7u1snPTDJ3icyg
         55SjMahCHgSO30rVM1vcknEkHRT9Y09IIGVI0ryRG+NzFDPHaLy/oBZ1nf7+AJu/3nvO
         uu2qktWb5Ut5WgGtT0lJcoSZOWm4Bfqag+AMDtH1Utqp/JRYniRdrRk5fjgMhZNCd3Nm
         i/9A==
X-Forwarded-Encrypted: i=1; AJvYcCWyrQAz8nzVtj9ehZVoee2qwJyAqyf02p/v1UT5E1Ezo/XToRJ1UcK8bEZLvkfYP6BJiOD/QiXUraY4NnO4JV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhkhYZ5DZM/OA2jIZ1/WEwf6WpiCQWCMVaG34kk2k0j41YXoZ
	AdU93tl133YQm1oVU7Y2LIT0zhZD6wfnZSC126UxFy6/TMw5i60qmAcgcqMcgw+k+tpiq2x+p+T
	1gEjUiVXCFg==
X-Google-Smtp-Source: AGHT+IFEX+YyUhAFLiB4PDLh59KjEqWsCilHKWQI2mwBOBQTb2abCAlQoUn+D5s5FIrNKX3bLlnv1X5ckyXg
X-Received: from pfva20.prod.google.com ([2002:a05:6a00:c94:b0:746:2414:11ef])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:189b:b0:736:450c:fa54
 with SMTP id d2e1a72fcca58-7487e10153dmr654396b3a.6.1749676623770; Wed, 11
 Jun 2025 14:17:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 21:16:32 +0000
In-Reply-To: <cover.1749672978.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1749672978.git.afranji@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <3a4ee24c9eea7bd25c3c7a8f7060c89ba69f56d9.1749672978.git.afranji@google.com>
Subject: [RFC PATCH v2 05/10] KVM: TDX: Allow vCPUs to be created for migration
From: Ryan Afranji <afranji@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: sagis@google.com, bp@alien8.de, chao.p.peng@linux.intel.com, 
	dave.hansen@linux.intel.com, dmatlack@google.com, erdemaktas@google.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de, 
	zhi.wang.linux@gmail.com, ackerleytng@google.com, andrew.jones@linux.dev, 
	david@redhat.com, hpa@zytor.com, kirill.shutemov@linux.intel.com, 
	linux-kselftest@vger.kernel.org, tabba@google.com, vannapurve@google.com, 
	yan.y.zhao@intel.com, rick.p.edgecombe@intel.com, 
	Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

During migration, vCPUs need to be created for an uninitialized VM.

This commit moves the TDX vCPU setup that requires an initialized VM
out of tdx_vcpu_create() and into tdx_td_vcpu_init().

Signed-off-by: Ryan Afranji <afranji@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 07583a11d6e3..4582f94175b7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -664,9 +664,6 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
-	if (kvm_tdx->state != TD_STATE_INITIALIZED)
-		return -EIO;
-
 	/*
 	 * TDX module mandates APICv, which requires an in-kernel local APIC.
 	 * Disallow an in-kernel I/O APIC, because level-triggered interrupts
@@ -692,12 +689,6 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.tsc_scaling_ratio = kvm_tdx->tsc_multiplier;
 	vcpu->arch.l1_tsc_scaling_ratio = kvm_tdx->tsc_multiplier;
 
-	vcpu->arch.guest_state_protected =
-		!(to_kvm_tdx(vcpu->kvm)->attributes & TDX_TD_ATTR_DEBUG);
-
-	if ((kvm_tdx->xfam & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE)
-		vcpu->arch.xfd_no_write_intercept = true;
-
 	tdx->vt.pi_desc.nv = POSTED_INTR_VECTOR;
 	__pi_set_sn(&tdx->vt.pi_desc);
 
@@ -3003,8 +2994,9 @@ static int tdx_vcpu_get_cpuid(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 
 static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 {
-	u64 apic_base;
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
+	u64 apic_base;
 	int ret;
 
 	if (cmd->flags)
@@ -3013,6 +3005,15 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 	if (tdx->state != VCPU_TD_STATE_UNINITIALIZED)
 		return -EINVAL;
 
+	if (kvm_tdx->state != TD_STATE_INITIALIZED)
+		return -EIO;
+
+	vcpu->arch.guest_state_protected = !(kvm_tdx->attributes &
+					     TDX_TD_ATTR_DEBUG);
+
+	if ((kvm_tdx->xfam & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE)
+		vcpu->arch.xfd_no_write_intercept = true;
+
 	/*
 	 * TDX requires X2APIC, userspace is responsible for configuring guest
 	 * CPUID accordingly.
-- 
2.50.0.rc1.591.g9c95f17f64-goog


