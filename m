Return-Path: <linux-kselftest+bounces-35935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1DAEA7FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CB816CA00
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDAD2FE39B;
	Thu, 26 Jun 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9dOn/5D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CD2FD884
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968377; cv=none; b=tUXdP/D3RVJMf76BfVVHQpALTvAXRTojRjMMQxZ7pQcW6wp2tCAMLrQZb/pAE4ZlQ5lZe1eCb8e2MJXem4gVp8dq407CZw/CgynzFoAmHQIZ+Yjv8DdYmJITt8fmF8rQnjoxabFM1k7Ibva4qKR8vwoLz2A9stUnwIRWXK11f2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968377; c=relaxed/simple;
	bh=gOCVNUcJxbP4E19oVaSXNAaxiVd9KT2116peS7a3WYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jldAnGHV46Vz2FLFpr9ufSgMi5+cX4qvoLhMQn3osqoh/hrq04QDnxsFnmI9MBb1kmIBSGGVmQStjbaqpVakudpf6lwc53d2YC9VU9iEZKQd90LWZ8FyxtFfI4rnuvyJcpVhA5QdYIToHp9YRurVqFia8vhksaVTmwwbkWm0afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9dOn/5D; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86cf89ff625so135837539f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968371; x=1751573171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6YI1PbJ7Kn84JnSkWupK7ZLYRCn92aoL1PXIwZUeC8=;
        b=D9dOn/5DrKjAxctMufgKLJeo6rPsYWyidZbROfbRj3KalNUIzBGfAcN2HPY+r4ojQu
         QJRs0PphmEKDzY3g4mLkgN8U/4+zqOBuwlOe11n+y8Np3AdHmL21r/E28CjWuJVVrx1e
         BVmX/Cly4iFtmfZXv+ii2RjGjF6xHYKeB3QlZ/I87WWDJsf8daSkg0teefCfBP+U98Gt
         PyrZwLrLir9ih9kiiVUp4ZdMcEwUyspWXsjv4pL73dnVh5wCRDoQpyk8oe4+Ea1VJrQQ
         5uEleY7cc34aLVE7Q1WwhTaoPZcIeicdihSYUcBbFmrnoPXIvyHVOTT/Rww3L0tuqFvg
         5uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968371; x=1751573171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6YI1PbJ7Kn84JnSkWupK7ZLYRCn92aoL1PXIwZUeC8=;
        b=T+ZOUjHANsuDkhBNgAwNesjBQV94Cla5vy4UokUbpEGP/uADegJbm3e6zCJ7TyS+jO
         o4VxGmi/9OnpS9RzS+mwQHD9fBn6c1IXJV4dmAercYy1bhP2/qN6xwlPR7auTqOV9P/s
         vyYD7FkZ/QiWi4Fw4jGO6J0g3E0ZF9wPHxrvcsw0QZy+Q3QislobC/Y3Q4o7tUk6SiJJ
         OXaH5slQonRCr23U7ctHBsnqTwDJdtXGs/aI6yzJ9HiEXp8RATAqTU4jbpj+Hx4dBkW3
         dggd/lDTkdL6ae5iT+hGZupj6GY3JqXFZjVRXb9dbWxuRdoGsheY4F6byfwK7VUImt5Z
         fyMA==
X-Forwarded-Encrypted: i=1; AJvYcCVcFmJJv0QyAv1OifvJY2yOfi9seQxkTlQDOzf+5IDQEq/ZDcejV9RmsiIp6j6bS7JI7bdEUfgHwMwZYP4B53I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eY22Yzx7Ed+Co+Aq3TW/ysNZEPMIe2Qt4XGTh1XHml5oPdSs
	oKpfNB0kPLipbuhwMnY5QDN2uWGfru5liuUsTGVb5kM9YtKftMBU6nOJo3VYshDF52G9JrK0X49
	lIQyoDHxVIJJAgyDq8oK4GXu81A==
X-Google-Smtp-Source: AGHT+IHJUkjGyGvNcWxAAAjfiD6q7g9phykRry/HcdOfgoIUsGWYJ5QzPA0/oIz6lali1a+s4FtxtR3CCKpC4TGpWw==
X-Received: from ilbbb14.prod.google.com ([2002:a05:6e02:e:b0:3df:38c1:b314])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:154a:b0:3de:25cb:42c2 with SMTP id e9e14a558f8ab-3df4acdd094mr10972865ab.18.1750968371417;
 Thu, 26 Jun 2025 13:06:11 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:55 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-20-coltonlewis@google.com>
Subject: [PATCH v3 19/22] perf: arm_pmuv3: Handle IRQs for Partitioned PMU
 guest counters
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
 drivers/perf/arm_pmuv3.c         |  9 +++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 5f6269039f44..36638efe4258 100644
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
@@ -249,6 +254,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 	return ~0;
 }
 
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 static inline bool has_vhe(void)
 {
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 4f0741bf6779..03e3bd318e4b 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -95,6 +95,7 @@ u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
 u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
+void kvm_pmu_handle_guest_irq(u64 govf);
 
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
@@ -291,6 +292,7 @@ static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
 
 static inline void kvm_pmu_host_counters_enable(void) {}
 static inline void kvm_pmu_host_counters_disable(void) {}
+static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
 #endif
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 1451870757e1..bd04c37b19b9 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -338,3 +338,20 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
 	val = read_pmintenset();
 	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
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
+	__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, govf);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 5836672a3dd9..dba7dcee8258 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -750,6 +750,8 @@ static u64 armv8pmu_getreset_flags(void)
 
 	/* Write to clear flags */
 	value &= ARMV8_PMU_CNT_MASK_ALL;
+	/* Only reset interrupt enabled counters. */
+	value &= read_pmintenset();
 	write_pmovsclr(value);
 
 	return value;
@@ -852,6 +854,7 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u64 pmovsr;
+	u64 govf;
 	struct perf_sample_data data;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
@@ -906,6 +909,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 */
 		perf_event_overflow(event, &data, regs);
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
2.50.0.727.gbf7dc18ff4-goog


