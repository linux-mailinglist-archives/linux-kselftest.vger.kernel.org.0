Return-Path: <linux-kselftest+bounces-35932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F88AEA7EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE27169FD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA72FD88A;
	Thu, 26 Jun 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5DnrLHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C22F532A
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968372; cv=none; b=fkt8HxP2UT5nTeypvdiIDKwORsjF+UGIFRHpITYdwDyQRZSNNWNMEQ9fBZfahFc9dudG2tbhHgf6382QXElPZu2dJqXLazJXlU1D/cNpcIMIcR+hx1t3BUhBw1lWI+BWWFEQCVBWLE/QgSEXaxOqCQhHQJ5XYDdZ2oM6dRh23/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968372; c=relaxed/simple;
	bh=8z/ZhUBiJsaGtKB7500oDCpj9d2atPMBBLxlj1YRgaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eZDfEWnFEHnG5VgKPV4+z75+LqPZ8+1+FecGBeR3153FiNx6Ud7QoUoL3VhlEo2sJeFCAr0SgCHb7QgzvZdDSkgbmGYFB8xxspTAEfzg5EXKMqqba9aRawzURwNmQS11somoJi6NI6RWFWL4UlvzkaMLUUq+Mri4NQBN3v2Zoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5DnrLHH; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-40a793c36aaso1080828b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968368; x=1751573168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EggI+2LInzJ3wRO1GPi9TTSrlVG7gA6O9HYI2Cdzh00=;
        b=v5DnrLHHRywEmLfokm0HWA9RtZhcbh63WpF01hbh+dDJvSUhbzV0YPvKHRGFsf2t9p
         LaiDBdDiRwR39RQPCQSSMVlGzOj0bAIGyUeK2JNeUPje6i+lhHvxgYacd05NRisNY+Qs
         0j5wTxQS1E2M6hTYPer4/V7dRAyCUm+H2l1gkutg1EJJ6n9o5DK3D0s49z+TJCCYrsH2
         kAkApMUKbjm5oayg7U2aYQPvroVHVv3uf3PSF5IfYylS3TPjNIYsCdHMhz9HAsQP3hVJ
         l3tpSs/cWUC3KwqcRcv4g6+xUr7GYpKAUPzTPi9Pk8f0R8N+K1dJ91D/e9uW3ycDGBLf
         G0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968368; x=1751573168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EggI+2LInzJ3wRO1GPi9TTSrlVG7gA6O9HYI2Cdzh00=;
        b=FwOo6P5VeCCqkRS8aNDsBsQq9zuS+0N3aXAjTt2Jr4cMfOVZmGDptnfINIRuHrHfHm
         AAbvCy8O/XT8i+aL+xBCaFe4Adjx+J+lJpboJBUVAqE2J6i9C73AB33FDCl/EQ1kfaDc
         /Be4oKxPuQM4sw3ylXci3S+m940vfjgRv71DS4QeFkM7mIp02PI2MPNOU8b1+LUTXA4b
         lGUdTRd7d+U3mhvzjwUFN54wP2fS1wxWGEt9s0oQWFbKiOk3XwhT2mIm8R5e4KPCGSOI
         uRBZ0Jz/8DAovwVAf35WFB7tyaqTzEcnPfCgOK0UmvQNfaRe/GHax6Y4XOM3mfgtW5AX
         cNVg==
X-Forwarded-Encrypted: i=1; AJvYcCUJqTe7VW97aDAUjPiQYms7/8NqzgBkaOJg95LOAU1+MOOg7FP+RnVNSxztyqTzQ7XFKOmK5OfQUBnI9iKirK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVvMbNEmhcyyMPHNUcvdSmBC9G2A4+pJv6rfUHaOKHILmW98X
	QPDnfC6d9LGz+RiiGhiEFhHZg0QpCCvtEnLEtSeZ71DE9dfFFrORPeMB9wnmCm/Yiin5rCq/x/a
	fzOKrL0o8N3MEaUTo2sHuovSNQw==
X-Google-Smtp-Source: AGHT+IEDQi6MUvs/OOb8kHvz1Lzcrs7koLOsO+Cfk8AV6zjNya1DxUg2y1UQDMm5ESpCnmdsnoP82zEcgDNAL2N1IQ==
X-Received: from oigs15-n2.prod.google.com ([2002:a05:6808:68cf:20b0:40a:f58a:e126])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a14:b0:408:fef8:9c91 with SMTP id 5614622812f47-40b341ca298mr321047b6e.5.1750968368200;
 Thu, 26 Jun 2025 13:06:08 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:52 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-17-coltonlewis@google.com>
Subject: [PATCH v3 16/22] KVM: arm64: Account for partitioning in PMCR_EL0 access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

For some reason unknown to me, KVM allows writes to PMCR_EL0.N even
though the architecture specifies that field as RO. Make sure these
accesses conform to additional constraints imposed when the PMU is
partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 2 +-
 arch/arm64/kvm/sys_regs.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 338e7eebf0d1..9469f1e0a0b6 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -884,7 +884,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 n = kvm_pmu_guest_num_counters(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b80cf6194fa3..e3d53f2da60b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1249,7 +1249,9 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    !vcpu_has_nv(vcpu)	      &&
-	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
+	    new_n <= kvm_arm_pmu_get_max_counters(kvm) &&
+	    (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	     new_n <= kvm_pmu_hpmn(vcpu)))
 		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.50.0.727.gbf7dc18ff4-goog


