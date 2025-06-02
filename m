Return-Path: <linux-kselftest+bounces-34167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA7ACBBB3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2EC3AFD5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440C8235362;
	Mon,  2 Jun 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zF475f6k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1C227E95
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892558; cv=none; b=oeAPeGekGkvSOlcrFqQknK0gXIAjYXM4G9ByhKW2oVyH14Xy1EjJNTUKpKyRRniWdLoPpZkE+NIZAwNYrIa0NPH91AUWneUU5KEk8gb8+A+5nw43O7P3MZOxuAm/EwrkGOOpw266nNfXzWnCwoD9GEDpJpEb/TF2MqXAMbA7O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892558; c=relaxed/simple;
	bh=y3rVKdDcfaZ6JmoNjVIK4+Ctxp2l0yLp74rKxw2AHwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rM+LqDErw8+yO9qsbvaja+t7CHfBsf2RYN3jchk27oThi4hSQ/hJSbX+2OwWLOB9wH2a/w9Ycs43g2AtUlvzix2fl0R9uN5NGMawWCppMurprM/VKi6sD/Gf41C0Zpr63KRV4mvPcliSoKhcJ4E6tQpY4PFZ9oKuEgH0D6a6Hn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zF475f6k; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddb10b6260so19942845ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892552; x=1749497352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIieb9nvj3js/0lbP2t4ZJLM8sYLAoNuXbgaxM7clWY=;
        b=zF475f6k6jlFaz5tGGepBA+LPcVwWSHzi98ZGNyAN5aJWPl6dQEUOV3NyKkVH92s7x
         hvbKlQrepJ0hGmCThoESXAYAQlQnOag4NiwO6THkh6baFVDr7eBqAPdc1oJuPvzQfvG/
         cY3IQhy/tZLWDIDqWWFeZv9m0x14K37n0oATkY022brrKTL4ub7IrXfhKxJVrTr+dVVj
         1mxegiI3ffqz5pu3Ud5/tDS8g/SF2s3okDysmNPUbj+aYFLJ8rnBWjjhfTKEABYtRn3C
         KoOvhw0Y8mJ4sh927BBzen9HRPaTei/tt8tmE9tO60MjgquaelrUK7ftC5V6I2l+wDpl
         XSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892552; x=1749497352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIieb9nvj3js/0lbP2t4ZJLM8sYLAoNuXbgaxM7clWY=;
        b=sEPdhe1G0i7F5KSDiHGch9c9SLZpYazQyaCK7nUIzd1oOzf9HsLnf7auHT7Gviqa85
         fM8tC6KKyyN+Bmj3lS21WdOdOADfGZs7jb7EXXNZhYIDWIOmMPJz5H9aArNShRfowXQz
         R+C9WK6dHZGhc8f0Usqt7dgYnRLcTyIztBTxa5Cgkifg1W0u1ND+iNFwAW91cYrcG9Uz
         rnx7nsDVAfkoTNiAdlHd77NJU7KWiRgPvR2rGzACkdO1lShVO6e14tBpXUYTpqgTLa17
         4LwLxLKCsino86ePhaATNYdKxredqFdkrzq2OQYSgmVPs/OHhaoBjDBaVlhshBzBkPBH
         kadA==
X-Forwarded-Encrypted: i=1; AJvYcCWfLsuNCauMxPLn+WRlprh53aYa1UjHMo1wt0mOTMahK/UL8jnLgHmd1NDL0Cg9TIPK5JycW0zoYFmHgss5edg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltOWZ8RWTyh9kUBBFhD0Q6jLbgmSMxwxhFiKnkJ0/wDzyIbl/
	Zr/v04HjD94XtneeezYsV8XRpn0TmVN9dH7y4xZ0oxS8KCCATQNAIfkSBaIhVNnCtYt3vTX4bfV
	X6/jdBgcA8IospHICiTqKuWdC/g==
X-Google-Smtp-Source: AGHT+IFqQBQNJHZiX1hBF+LjbTaumbyKnOzaoNP3vPsriCDKKVQYIJ9OZ+1lHyJrYq4J3I7AtifVqQuuEfJTrU+N0g==
X-Received: from ilbdr4.prod.google.com ([2002:a05:6e02:3f04:b0:3dc:8616:ffc6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:2189:b0:3dc:8b57:b750 with SMTP id e9e14a558f8ab-3dda3387e2cmr94188185ab.17.1748892551894;
 Mon, 02 Jun 2025 12:29:11 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:59 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-15-coltonlewis@google.com>
Subject: [PATCH 14/17] perf: pmuv3: Handle IRQs for Partitioned PMU guest counters
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

Guest counters will still trigger interrupts that need to be handled
by the host PMU interrupt handler. Clear the overflow flags in
hardware to handle the interrupt as normal, but record which guest
overflow flags were set in the virtual overflow register for later
injecting the interrupt into the guest.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h |  6 ++++++
 arch/arm64/include/asm/kvm_pmu.h |  2 ++
 arch/arm64/kvm/pmu-part.c        | 17 +++++++++++++++++
 drivers/perf/arm_pmuv3.c         | 15 +++++++++++----
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 1687b4031ec2..26e149bdc8b0 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -180,6 +180,11 @@ static inline void write_pmintenset(u32 val)
 	write_sysreg(val, PMINTENSET);
 }
 
+static inline u32 read_pmintenset(void)
+{
+	return read_sysreg(PMINTENSET);
+}
+
 static inline void write_pmintenclr(u32 val)
 {
 	write_sysreg(val, PMINTENCLR);
@@ -245,6 +250,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 	return ~0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 4098d4ad03d9..4cefd9fcf52b 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -30,6 +30,7 @@ u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
 u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
+void kvm_pmu_handle_guest_irq(u64 govf);
 
 #else
 
@@ -74,6 +75,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 
 static inline void kvm_pmu_host_counters_enable(void) {}
 static inline void kvm_pmu_host_counters_disable(void) {}
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 #endif
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 40c72caef34e..0e1a2235e992 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -319,3 +319,20 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	val = read_pmintenset();
 	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) = val & mask;
 }
+
+/**
+ * kvm_pmu_handle_guest_irq() - Record IRQs in guest counters
+ * @govf: Bitmask of guest overflowed counters
+ *
+ * Record IRQs from overflows in guest-reserved counters in the VCPU
+ * register for the guest to clear later.
+ */
+void kvm_pmu_handle_guest_irq(u64 govf)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	if (!vcpu)
+		return;
+
+	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= govf;
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index f447a0f10e2b..20d9b35260d9 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -739,6 +739,8 @@ static u64 armv8pmu_getreset_flags(void)
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_CNT_MASK_ALL;
+	/* Only reset interrupt enabled counters. */
+	value &= read_pmintenset();
 	write_pmovsclr(value);
 
 	return value;
@@ -841,6 +843,7 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u64 pmovsr;
+	u64 govf;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
@@ -867,19 +870,17 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	 * to prevent skews in group events.
 	 */
 	armv8pmu_stop(cpu_pmu);
+
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
 
 		/* Ignore if we don't have an event. */
-		if (!event)
-			continue;
-
 		/*
 		 * We have a single interrupt for all counters. Check that
 		 * each counter has overflowed before we process it.
 		 */
-		if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
+		if (!event || !armv8pmu_counter_has_overflowed(pmovsr, idx))
 			continue;
 
 		hwc = &event->hw;
@@ -896,6 +897,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (perf_event_overflow(event, &data, regs))
 			cpu_pmu->disable(event);
 	}
+
+	govf = pmovsr & kvm_pmu_guest_counter_mask(cpu_pmu);
+
+	if (kvm_pmu_is_partitioned(cpu_pmu) && govf)
+		kvm_pmu_handle_guest_irq(govf);
+
 	armv8pmu_start(cpu_pmu);
 
 	return IRQ_HANDLED;
-- 
2.49.0.1204.g71687c7c1d-goog


