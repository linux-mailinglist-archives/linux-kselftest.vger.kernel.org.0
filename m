Return-Path: <linux-kselftest+bounces-35491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C98AE255E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DFD167AD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73C25C711;
	Fri, 20 Jun 2025 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBYFSh2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A5246BD1
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457945; cv=none; b=TNYd8+2lqGWEY+1akY6Kna30GNoYUHI/vrzE3dNqR2HY5Y9x0FgRbmmZbW0JsvDEZvynMLKnKxuMGqL0d6uwP2JoArY6HMjMmBKMy/QMc4kUvYOAiAmJGB9wSZdT3s4ZRV6idi6QLyFtMLOoZ1gX5Y3EXRS5rFuWwTvSQ8E8iYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457945; c=relaxed/simple;
	bh=XedMELF7GtBc5JFPguCMW77ZmVNxloch7pPzCMErQGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCEIOigFERW8zaC1B+JE/vEgp7yceNn4R/xtkxIKu6bGSUaEaJwav/kxiL8zb4+YULh9VX5KX9cDNjWLaS16qgZALlGePvwSi7cX++8D91FPnhIwapFMifwES175wxagRi+O9XDZgYJvdWIO6W2qpCHBoJ74JROLHFMQNr46Vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBYFSh2m; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so70006405ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457941; x=1751062741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Ykp94zxfIa/dbPK+2a7kBugu0lfLOBN3b0mLEqxA0=;
        b=uBYFSh2mQE7J42P8bHNYe7Qu1FR4H7uDTzyY62lMCsB9k1yJqOnjU/17LxYt1yJTiW
         DZlQMqWSjl/M6/YzP7iVPjL1X1Hd1O27g8m806DG2OfDuCiFqjt4+zISuEBTv/TCGmQr
         u0amizaBjfEY3S/6AUWoiHWk9Jco+LUopSqZHRBrDT11kLDwuUpg2OSAT9Ag4/0jgf1k
         a9Y/IDpA7HEZ3qtrfRFNrQKVJA89WWVHgkWlGx07gmNDYkkJEiInSj8bCuYNHluHXbzi
         TgLHP0Z2bp6dB1q300on4hUyaqOyjWYaCP8IdpyMCRY1QzZagPC/6QTS4HaM0idwGOpo
         eblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457941; x=1751062741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Ykp94zxfIa/dbPK+2a7kBugu0lfLOBN3b0mLEqxA0=;
        b=W2+zR/bBFz8bGi8st4HXaoq0QNeH54sVOoDGpDB/KoCxfe0dD9c1XsmRYfZHE30Wty
         cBm6pwnSq1BTdQhXOJW0dxW/QGxrGtJrXy/jlyCBnDJrwjbbOylXQ7IYP0DnKwW14piV
         H393pWX58KqTzKPAkuNLQCex5CMRq8bP5rkSq5sQLMwTrGi5aL1UOEfhR0DSY3ZfvhT5
         MuLbGI962mvlUYtPfG8URERNh8OpyQlJnFReHhf26cfnV6JIMesxsqJy2v+CjGvyY5Dt
         GB9hSaOfDiUWq8+O7rmq7TWkKDT3C4KEug1brRWIL+aAmDeIGbXOrvypHUxcswFTlVgl
         PUwA==
X-Forwarded-Encrypted: i=1; AJvYcCXXTYpTJfT+mtKXF6zp73U4eGOJSyndw3qSVuOFRh6GILj02Forg+Z/QU5M2ukYtLbSAdlDSbadiNDt0/vxGxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkr1p4IM0rJ3kQjvRzdg83IaPtmDsD17zHm1nvYPhFP2qrkbzn
	P0mMJfxinJwPPkfWRYOTYlS4XLUlmV/6Ax8hZaZfR6iYTmJnJjERlokuyHLbGJvIje2f8pJl+jL
	5wxoBe0urnn9tch6UzCdrtpxk5g==
X-Google-Smtp-Source: AGHT+IGsN72kNwJ2dwKK78XXy9iE4CcdXHD3dDBBOtntuEfratpO+Bq/lh5Sf0arHIXBqE+w6Fo0vZ83wCMILU28YQ==
X-Received: from ilbbz6.prod.google.com ([2002:a05:6e02:2686:b0:3d6:d162:a9b0])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:214d:b0:3dd:d746:25eb with SMTP id e9e14a558f8ab-3de38cc8bb0mr44894155ab.16.1750457940797;
 Fri, 20 Jun 2025 15:19:00 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:23 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-24-coltonlewis@google.com>
Subject: [PATCH v2 21/23] KVM: arm64: Inject recorded guest interrupts
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

When we re-enter the VM after handling a PMU interrupt, calculate
whether it was any of the guest counters that overflowed and inject an
interrupt into the guest if so.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_pmu.h |  2 ++
 arch/arm64/kvm/pmu-emul.c        |  4 ++--
 arch/arm64/kvm/pmu-part.c        | 24 ++++++++++++++++++++++--
 arch/arm64/kvm/pmu.c             |  7 ++++++-
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index e1c8d8fc27bd..1e632373ba38 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -84,6 +84,8 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
 void kvm_host_pmu_init(struct arm_pmu *pmu);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a6452d10fc1e..926aeda51b9e 100644
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
index 8c35447ef103..2c347e7a26d8 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -260,7 +260,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	write_pmcr(val);
 
 	/*
-	 * Loading these registers is tricky because of
+	 * Loading these registers is more intricate because of
 	 * 1. Applying only the bits for guest counters (indicated by mask)
 	 * 2. Setting and clearing are different registers
 	 */
@@ -334,5 +334,25 @@ void kvm_pmu_handle_guest_irq(u64 govf)
 	if (!vcpu)
 		return;
 
-	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= govf;
+	__vcpu_assign_sys_reg(vcpu, PMOVSSET_EL0, govf);
+}
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
 }
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 5f0847dc7d53..65b380debc33 100644
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
 
@@ -683,6 +687,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 			return -EBUSY;
 
 		kvm_debug("Set kvm ARM PMU irq: %d\n", irq);
+
 		vcpu->arch.pmu.irq_num = irq;
 		return 0;
 	}
-- 
2.50.0.714.g196bf9f422-goog


