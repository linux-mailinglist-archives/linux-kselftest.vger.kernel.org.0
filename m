Return-Path: <linux-kselftest+bounces-34168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C384AACBBBB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5243B35B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB32367A9;
	Mon,  2 Jun 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijOckjMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9C23237B
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892559; cv=none; b=R8m11Nxdu2GlwHMR49GIZhBSqQM7cIVSqf7wmNwGV+BITOjxm9CHmZ9TwUpKwHuQmnijobEYRe5v8QFc/Qnq+Gomnxx1SvnaYFzf53Bv7i9z7erdcLyJLRbQPO/Ynvjyzl7gpk7q3Yee9XtZKdDV0vbN9aafGqnp2vBFg0WkVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892559; c=relaxed/simple;
	bh=TTLikVmKHBl9vHWgJj7ptAb8oZIRjsQGAJ+ajwQ8Eb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uvPFVhFxM76aT+AQi835GrXBmXitPFzMCovWWzZ2+q5ixPsOLhUDCy4QnCQhgjSEGSQE1QYo+RM0TnJaC6B3rVoZEJCID/qOsOcpqtx4ODY6PM+VN+PYdmQkBCkxzE8eExQV/XGyhiUAHk7Az7h8dOHlkJB8vVmfhar2q7wNCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijOckjMw; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3dda4bb1c97so17182935ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892553; x=1749497353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oY77J80y2xgj2jg9N03EbI54De+Pf+kjVEC2/miRHXM=;
        b=ijOckjMwcPwzhUSVwA1a5baggwRwj7mwdR7dB0zgOXqSnSEhWwMQmnBXg2gq7iFzAR
         JdjGXYAtKqraL35ccPvC5gpzylnW9nNCOx8Tt+BFzf11J7s+YT0KjYzMFtHxPVXbndlf
         kRDK0O3q1WY+p9cEB7VwfkCmmCC9tMpu8T9HIJqtzUfmsVrCoYcaIdTZMzDno7ZdmB2/
         YDq+3+9QLJlRg2hLKFUcVIkGRz764ecT1WFb8H0P+PJK2Ekh5dDdFv+Qc2Q27Pawvvv6
         U+Esfp5ruTPq9q9Bi/A7W9wgkYJP9aMsYwEhkBDYND+gjbj2dtUlp7RGLPZ9GiruNkWV
         t+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892553; x=1749497353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY77J80y2xgj2jg9N03EbI54De+Pf+kjVEC2/miRHXM=;
        b=K+0Hr9jLlwimpso++kMvpeJZVVKS2ZgVcI6nZ8+tXHhzqEH5qePIe6VtD0w2P5QbDt
         50Tr/EGsGXc9HQ2prUXoHybdbkCdzNjHSE6v8L7GBvNBqq9DT5jBLVAUTJCZij8SPrp9
         7KZ08w20oNHaverzjPIua29thtapan010pYRMjBXW6qfkOEas15jabienG1MBt6QqDiF
         qcMwUSR1W7VGFWjWGosM/Q8jWWAKPzYamMWjePlgHlfDKw8J//QCwQaAPTwYdyShxX5g
         9VmvVQgDev26yIDKeub6E4skukjekX+4jUno68AB8rMaIdLw37cJTEBrncKsDnPx9IyG
         Lf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9+ZsvIgyzhVN9l3ag2izMa/H5dJnX6vpzFGC+hUfgEufTxZZLyycyUiOQKJxLxMev2V0WmVKwoC+ExxKGcss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5B1ol2F5TN4pHoquWIimb4jAhKTaqAlW9a5yyQplIcwThJGXN
	7sc5b6u5a7NU9GUMXfdNjJXqrcKlE+7UmQ3IZ6cjM5vtaEubLLSMIokrjHe+ennLqmF+s5zrFCk
	9f9U8VQAf85icbApQOTm8a+b0bg==
X-Google-Smtp-Source: AGHT+IGwil/ABNZ8qf4ojpW0M3/YV2pZdfKPjkXHE38VBvyOQZsaB+n377hoKIbc0ge0ZdQrftjzuWpR/waySgTS4w==
X-Received: from ilbbs17.prod.google.com ([2002:a05:6e02:2411:b0:3dc:6a8b:b101])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:4414:20b0:3dd:b569:6448 with SMTP id e9e14a558f8ab-3ddb5696709mr16632695ab.6.1748892553051;
 Mon, 02 Jun 2025 12:29:13 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:27:00 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-16-coltonlewis@google.com>
Subject: [PATCH 15/17] KVM: arm64: Inject recorded guest interrupts
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
 arch/arm64/include/asm/kvm_host.h |  3 ++-
 arch/arm64/kvm/pmu-emul.c         |  4 ++--
 arch/arm64/kvm/pmu-part.c         | 22 +++++++++++++++++++++-
 arch/arm64/kvm/pmu.c              |  7 ++++++-
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 955359f20161..0af8cc4c340f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1714,9 +1714,10 @@ bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
 struct kvm_pmu_events *kvm_get_pmu_events(void);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
-bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu);
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu);
 void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
+bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu);
 
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index ff86c66e1b48..0ffabada1dad 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -320,7 +320,7 @@ void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val)
  * counter where the values of the global enable control, PMOVSSET_EL0[n], and
  * PMINTENSET_EL1[n] are all 1.
  */
-bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
+bool kvm_pmu_emul_overflow_status(struct kvm_vcpu *vcpu)
 {
 	u64 reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
 
@@ -457,7 +457,7 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
 		kvm_pmu_counter_increment(vcpu, BIT(idx + 1),
 					  ARMV8_PMUV3_PERFCTR_CHAIN);
 
-	if (kvm_pmu_overflow_status(vcpu)) {
+	if (kvm_pmu_emul_overflow_status(vcpu)) {
 		kvm_make_request(KVM_REQ_IRQ_PENDING, vcpu);
 
 		if (!in_nmi())
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 0e1a2235e992..1d85e7ce76c8 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -252,7 +252,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	write_pmcr(val);
 
 	/*
-	 * Loading these registers is tricky because of
+	 * Loading these registers is more intricate because of
 	 * 1. Applying only the bits for guest counters (indicated by mask)
 	 * 2. Setting and clearing are different registers
 	 */
@@ -336,3 +336,23 @@ void kvm_pmu_handle_guest_irq(u64 govf)
 
 	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= govf;
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
index 2dcfac3ea9c6..6c3151dec25a 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -425,7 +425,11 @@ static void kvm_pmu_update_state(struct kvm_vcpu *vcpu)
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
 
@@ -694,6 +698,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 			return -EBUSY;
 
 		kvm_debug("Set kvm ARM PMU irq: %d\n", irq);
+
 		vcpu->arch.pmu.irq_num = irq;
 		return 0;
 	}
-- 
2.49.0.1204.g71687c7c1d-goog


