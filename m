Return-Path: <linux-kselftest+bounces-47323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DBCB1184
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32483027FC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D60430CDA9;
	Tue,  9 Dec 2025 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9C/SU9i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAF30B520
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313565; cv=none; b=pEe7lJ8zw5NcIOdAAA/L+IDn2pZLrMg3WbguW4Pe54gXkTKBZiX9C8ZDLzC3gQNc9QNc81XZcxFz6uhqdqBJosXYlfUK5Q0CwSUeicGfouENEFWzNNuoJcMl0dHIku47ctl8Zo7Oq1Gs7rY7h4fsiHicvnLuer7dOT53FFbl6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313565; c=relaxed/simple;
	bh=gK8PYV0Ut8umvNmJJee7/9an5YvBL6+gILLBE0W0pjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZukx/Fp45R/Lj/eUh+oqjqSO/I/OuhVIH/+95w/LA/Gla8TCUuoINO5nN/iAMkTYNUBBCwSinoeqDKv1VmgH5wbHF1dpb6DjqRkKnuSFRD2ZrwvxOaV02fFaK9YjLRJCF6ZFtgO1ErkiKVScLHXaDTxTM87bIdyCjXKP0mtqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9C/SU9i; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3ec7ae7492aso8321529fac.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313558; x=1765918358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eILdFka/rsHJNMit/75Sq+eu11TjmQop/YtCpvpq3fA=;
        b=h9C/SU9i2BXm+Lt0xk3FLwcDlrhZL2w2HyL8nkPrMRnLsTD8Pchpd6M+9UjatznUW1
         58UsYkrlw+KcchRgEvezNdHMPAMblwq9n9sBCx4XrvXHYj0/TARXIHgk63VCbFaSr77f
         Q3N/Ze0T0j1C1BF+2cPh67ZHahfH/Zr4xUkrXGaSLgoGK6WRBSgLB/51GuzoACm0XMaJ
         RlF+58zx7vjCqqQKPcRokis5+3Gix69D32ufx6BkteQWxgx2uoxLpvzZqtrKt/Kq9MLH
         yZAhvikIyjq4V9ULTCm71XL//6zqS94Q9rOSuLeQACQBHwSDFLQSi2z0WLPaQ6WUfAMc
         QR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313558; x=1765918358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eILdFka/rsHJNMit/75Sq+eu11TjmQop/YtCpvpq3fA=;
        b=GECKmuRtAskeeV6GZz3kMEF9g0/6U7FR9mCxBu/ndi8bY6LdHLB6ur25ohEhxzaAgQ
         zVkWMoFY2MLtZZjJiIaupukwISpQyE3Ywsdd+O06pyvHcDAfPEATYM3StKHjqDq3XaJZ
         WkrL13JAQc5+pcpuKYES7A5uz2wvCAV1AjzGJ5dFC6Q75Ckwt2Yl+24ZDxhQuur+SpBX
         xhF+HHwSWxnK+5YEeThaeR+mrwibWU3WY8O4vpd7FLvRAhn5YWqSq9vR06gGbuuOdBz5
         ALa/XGgoIkfECFIKRQQL5b1QgU4WyGw3sR16Va69esStj3IxE5IWfK7LWNTrTPJ7QAlW
         NGcg==
X-Forwarded-Encrypted: i=1; AJvYcCUBJYdhYDrOc2/olz71K5XXjnftQezkdRM4Ef7ZgFexY4awSLEosNdEG1w5g4udy+bRnLYD5iFbepRRZmC1XhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUEEH5LQudWXS+9snuthb3N6+djq1GKz4TOCvGNGVbw7KrrV8
	w1WvMs+vnXMJu/egEgWFMJkEn8MxsXqztTZ6NQycCZox/JrSW/jR284621ITw4q5sr+df7zjnqD
	39q/APFRD/iy2HwXxlixVWC096w==
X-Google-Smtp-Source: AGHT+IGFO7LxHdl3SUALrs39mwNrx9NW2pYEpCVi8R5YZ4pkCq168hpaasS4MHYzaxE05YVUGX0GL3A0G5bIBNL23w==
X-Received: from ilbcp5.prod.google.com ([2002:a05:6e02:3985:b0:433:e44:c729])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:4d08:b0:659:9a49:8f57 with SMTP id 006d021491bc7-65b2abec3e1mr136653eaf.28.1765313558233;
 Tue, 09 Dec 2025 12:52:38 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:09 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-13-coltonlewis@google.com>
Subject: [PATCH v5 12/24] KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
to use the virtual PMSELR register when it could be outdated and lead
to an invalid write. Use the physical register when partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
 arch/arm64/kvm/sys_regs.c          | 9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 27c4d6d47da31..60600f04b5902 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
 	return read_sysreg(pmcr_el0);
 }
 
-static inline void write_pmselr(u32 val)
+static inline void write_pmselr(u64 val)
 {
 	write_sysreg(val, pmselr_el0);
 }
 
+static inline u64 read_pmselr(void)
+{
+	return read_sysreg(pmselr_el0);
+}
+
 static inline void write_pmccntr(u64 val)
 {
 	write_sysreg(val, pmccntr_el0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0c9596325519b..2e6d907fa8af2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1199,14 +1199,19 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
-	u64 idx, reg;
+	u64 idx, reg, pmselr;
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		if (kvm_vcpu_pmu_is_partitioned(vcpu))
+			pmselr = read_pmselr();
+		else
+			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, pmselr);
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
-- 
2.52.0.239.gd5f0c6e74e-goog


