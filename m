Return-Path: <linux-kselftest+bounces-35936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E9AEA7FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB541C444D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C42FEE17;
	Thu, 26 Jun 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbEtBbxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B102F002E
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968377; cv=none; b=oqq0dHgW54pubE+zqvFRhS8fKmMKzVb/uHmFQPJzQC6b7UvMhMSP7xaMXJZM0rOmjFhJmUw8bnZ4Srz4R9RtIgxzuKoFF1/3ntk6rSwtcIoGYCQwySWu6b2vI30mkaGE8a3FnwvpRH6B9+kX2yl03I/pMuI0PODuNDZUEPiP7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968377; c=relaxed/simple;
	bh=gH+Yd1mzVo9y7Dr3+Hxk8fddtdVh8GqAqskRlpwY6xU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evpi9vkfEDR0NM41FlKEBL13vdnefjMQHefGGuQQyiIxOy4qgVp/t/ZGvMtnqh+h9yBx39ppmISiDEqazDniwzikxQ2+9VkGvHd+ZvvIhDrFSi5UualOGzDe+Zq+re//3QGbLl66LiRUmjTUhHVDarL6waQpX8/1T4tlMyKLMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbEtBbxr; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3de0dc57859so16841485ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968372; x=1751573172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai9/sepaJ5XVOCTHqXQnbqMQb7WUqdqFh88LxqpgeeM=;
        b=XbEtBbxrk8G0itMu4AxXxhJJrIOyP6ZFUEEqGx5SKDlIWdT5LX+bE5fVGWmi9TiXxP
         iklyJBAQhesnjI4kwameANIoYix4kjytwAhJ1zqSlmiclrtzDHSOHFhPaM1kFw9G4s1u
         2d1/QpucTiRh1rT1wnbctZYhsGFozHQyven0ZUSI/wYozuaBVLjh880k+I4zyzoitoBZ
         oFpcaLAhGlXGoB2FbqskYjjQ2R+7jLn6QPAqgQGkPbWbhCdQoRoc44Byo+KKRAA3gngE
         9hkGmHRypRPabwbw+1eiP1Zl+2GewJU+i9zal6QYFgbPhA7Iw1JlQyluaeizTENO9wuZ
         Wp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968372; x=1751573172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai9/sepaJ5XVOCTHqXQnbqMQb7WUqdqFh88LxqpgeeM=;
        b=DYkClnVhZY/3VGPI7q5Pw/qBJ+XKCV4F4OdtpZIQEc83ieKFT/WCZ1EPaez4zuivwX
         tdN4asAT7/p92Kk/MkW0xew/6M/fLlnwFXqsLMzxYRX3bFkq0FpKFynamfR+jlza2BcR
         kYbVeoGXNQBh5SQCDXRj29wV5c4bZ/+paBbAHDfCeCn97iawWXDcWHPKQeVlAMmzf2zy
         YPsAz1N37Hdl5mdWvrjYFylIsK6xynaAmONKtxqfCeA8aTnnHb2aR2lUKwurhzjb9s+r
         dO47iuh7beEJpLLfuyckQnKUuRy7AHqzQMRwyXdvl/QC7hPh/w8Pq0Q/DBTE6UX6PKcy
         Wjtw==
X-Forwarded-Encrypted: i=1; AJvYcCUVbsr3TK8I0CuTP/sJB3GD4JRZY6XBTv7/YpSYWLKgQA9ZHWdQujeiP1/WveUBfHnw9aslHIekekkrK4wf72U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHr2ZdVoqg08XkwOU93WcbpGKh3VJSnYNzpqPw82Lh7fBWQd4l
	T7InLa9szfnOaJWWWSKFMb/sdS89KfafoGy3BkgN+Icn3ryVYRA9Ivj6i1yRYTjIBIpKl/vJXub
	5wuxPS3aOhZR0a4ZdfcFbeDPmSQ==
X-Google-Smtp-Source: AGHT+IHMxVNZWApbptZpNTBCT5d8XSjlwqRmfTyoWU26w+gUqtg0TL1VrqiKQldGVuUwisWThSdEUMcZDgoysCsEWA==
X-Received: from ilos8.prod.google.com ([2002:a92:cb08:0:b0:3db:8374:9a74])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1c04:b0:3dc:7cc1:b731 with SMTP id e9e14a558f8ab-3df4aacec3amr12947595ab.0.1750968372540;
 Thu, 26 Jun 2025 13:06:12 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:56 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-21-coltonlewis@google.com>
Subject: [PATCH v3 20/22] KVM: arm64: Inject recorded guest interrupts
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

When we re-enter the VM after handling a PMU interrupt, calculate
whether it was any of the guest counters that overflowed and inject an
interrupt into the guest if so.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_pmu.h |  2 ++
 arch/arm64/kvm/pmu-emul.c        |  4 ++--
 arch/arm64/kvm/pmu-part.c        | 22 +++++++++++++++++++++-
 arch/arm64/kvm/pmu.c             |  6 +++++-
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 03e3bd318e4b..d047def897bc 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -86,6 +86,8 @@ bool pmu_access_el0_disabled(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index bcaa9f7a8ca2..6f41fc3e3f74 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -268,7 +268,7 @@ void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
  * counter where the values of the global enable control, PMOVSSET_EL0[n], and
  * PMINTENSET_EL1[n] are all 1.
  */
-bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu)
 {
 	u64 reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
 
@@ -405,7 +405,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index bd04c37b19b9..165d1eae2634 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -279,7 +279,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	write_pmcr(val);
 
 	/*
-	 * Loading these registers is tricky because of
+	 * Loading these registers is more intricate because of
 	 * 1. Applying only the bits for guest counters (indicated by mask)
 	 * 2. Setting and clearing are different registers
 	 */
@@ -355,3 +355,23 @@ void kvm_pmu_handle_guest_irq(u64 govf)
 
 	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
 }
+
+/**
+ * kvm_pmu_part_overflow_status() - Determine if any guest counters have overflowed
+ * @vcpu: Ponter to struct kvm_vcpu
+ *
+ * Determine if any guest counters have overflowed and therefore an
+ * IRQ needs to be injected into the guest.
+ *
+ * Return: True if there was an overflow, false otherwise
+ */
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u64 pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
+	u64 pmint = read_pmintenset();
+	u64 pmcr = read_pmcr();
+
+	return (pmcr & ARMV8_PMU_PMCR_E) && (mask & pmovs & pmint);
+}
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 9469f1e0a0b6..6ab0d23f9251 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -407,7 +407,11 @@ static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	bool overflow;
 
-	overflow = kvm_pmu_overflow_status(vcpu);
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		overflow = kvm_pmu_part_overflow_status(vcpu);
+	else
+		overflow = kvm_pmu_emul_overflow_status(vcpu);
+
 	if (pmu->irq_level == overflow)
 		return;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


