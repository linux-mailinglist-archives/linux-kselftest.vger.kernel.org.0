Return-Path: <linux-kselftest+bounces-34157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F57ACBB92
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035973ADC07
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1E226D00;
	Mon,  2 Jun 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1OexTHaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41122A4EE
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892546; cv=none; b=LFxckVXslR95rKo4azxv3KpC1sIxcyXaI3qCKsOCzSV2sNc4HYLwrm0BxzEEc8cMAzMbRh58239asTrM2vq4tQtwggTgHPMmcz60CV2xxo6REFNkS7yMcyhvZlWZor8KfLQgaw2lqD5QMYpZI7n4vdRdCDJ8kLcSFGcSvHbp7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892546; c=relaxed/simple;
	bh=iGpFWDppkgdxqqBhrOO3aL9IGmqpmUG3I4Gjo6EbB6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P7dvaLoqaGmHNiAZFZciQ16wLY8MqqsetB6oeGSFYSnAABaZM3NlmRhhLwnxNXxi5J2lkGeMeGB36DnKtpuVQdCWqmqxONeaDFyklnVl9Nyz5GsUT9rkcVCEGXPr8jHzhKS4U1YdZDXTNY0sQkHdNCKuNXFK3oO9BwAGekxMhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1OexTHaC; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86cf306fc68so569272939f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892541; x=1749497341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuO4kHSXnGdRh+A/3T816/z1oQQQitwNMdkeN8eavRU=;
        b=1OexTHaC21Wd8e1VuCNgXXPcQnSxdLF3SbHkztlb9aCJN46qAj7Jnk6z3eArkSFSip
         nd+wKmbBhO6LAQ/rr2dIMiRmLu6CEfJm54MKQ1yephiNExNTe1AP5KDrj7u0TsF1Q5nh
         Nn3HM0vVWDfaGhZzWCQDrhyWm+p9llQ+6omjekb4otCNYExORomR9vgLy0e75DMi+1nG
         aoLbdCpL2sJ1s6UMaQAMS06uo5lp/22HGuWJJk//vPnw5RnReBywU1qJAmUs/buLgjp0
         sV+gvCM58lpMFAwtyjtjdez3ncLhizTpzGcVkpD7JhjQMKdt59Cw3sPU6EbmECms/T5d
         MWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892541; x=1749497341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuO4kHSXnGdRh+A/3T816/z1oQQQitwNMdkeN8eavRU=;
        b=W94ZyzL3yBC/3d7RokwQ6OYahzXPMjLg1NeYFrd8d9BbDZL4BVFC81uFKmBtqJfjoH
         pawl4JNvjXAowQO6/SGNplIk37DUoFBuZsaBNE9jaWfIfkPnBVOWYV4tImimAV6grQ9/
         CdETu1EVwUwviP8276l1eH86X4GhDCjljc1w9e9pjnIzKu1iId9GyhHxY9ywQUrFWT/5
         BS3DBpNcv53CnNRPpLWNIut3PvRtSnH2Pn7cvz+0Q8Z3d2hT8dFILDv3oxKONC0e0HVZ
         Ny6QqmQ1szAoqoCZw1uQdG9QIddkBS88BQ15kdG0nDPjzHAOIesKE9rV05rdbnzwI7rY
         kkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMT8eE+ynqf4TEbJhm2OCO3izDItboItabb1Njj8hOmzW/tbnbX2NVbwnwEL9rVjR/GsZqRdBUU48UralLxGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUeqq3xwGrJTuk5Eu/mMVKj7Ran7YhZc9vqUP/qvQ/XPc3g8k
	vaNdXOL+85d1xo2R+cmVkB4cz5QLmGMEEeSkKwe4+tDpoOJ3XpxBEHVgge+LOKCVm5ObEQVhy/w
	SJW1Xb2a2KPKbGDfDE+SLdHnLgw==
X-Google-Smtp-Source: AGHT+IHgAEss5g9/qKcpWYkUlDHsx3OxY7MyeLL7paDiELgy23KMB7p5zl3LoU1V5SjDTN8g9AKt5f5t5tnQMYSY6Q==
X-Received: from ilfj14.prod.google.com ([2002:a05:6e02:220e:b0:3dc:6ecb:a0cd])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:216f:b0:3dc:757b:3fb2 with SMTP id e9e14a558f8ab-3dd99c047c5mr183176455ab.7.1748892541418;
 Mon, 02 Jun 2025 12:29:01 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:49 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-5-coltonlewis@google.com>
Subject: [PATCH 04/17] KVM: arm64: Cleanup PMU includes
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

From: Marc Zyngier <maz@kernel.org>

asm/kvm_host.h includes asm/arm_pmu.h which includes perf/arm_pmuv3.h
which includes asm/arm_pmuv3.h which includes asm/kvm_host.h This
causes compilation problems why trying to use anything defined in any
of the headers in any other headers.

Reorganize these tangled headers. In particular:

* Move the declarations defining the interface between KVM and PMU to
  its own header asm/kvm_pmu.h that can be used without the problem
  described above.

* Delete kvm/arm_pmu.h. These functions are mostly internal to KVM and
  should go in asm/kvm_host.h.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h      |   2 +-
 arch/arm64/include/asm/kvm_host.h       | 190 ++++++++++++++++++++--
 arch/arm64/include/asm/kvm_pmu.h        |  38 +++++
 arch/arm64/kvm/arm.c                    |   1 -
 arch/arm64/kvm/debug.c                  |   1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |   1 +
 arch/arm64/kvm/pmu-emul.c               |  30 ++--
 arch/arm64/kvm/pmu.c                    |   2 +
 arch/arm64/kvm/sys_regs.c               |   1 +
 include/kvm/arm_pmu.h                   | 199 ------------------------
 include/linux/perf/arm_pmu.h            |  14 +-
 virt/kvm/kvm_main.c                     |   1 +
 12 files changed, 246 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_pmu.h
 delete mode 100644 include/kvm/arm_pmu.h

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 8a777dec8d88..32c003a7b810 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -6,7 +6,7 @@
 #ifndef __ASM_PMUV3_H
 #define __ASM_PMUV3_H
 
-#include <asm/kvm_host.h>
+#include <asm/kvm_pmu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d941abc6b5ee..f5d97cd8e177 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -14,6 +14,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
+#include <linux/irq_work.h>
 #include <linux/jump_label.h>
 #include <linux/kvm_types.h>
 #include <linux/maple_tree.h>
@@ -35,7 +36,6 @@
 
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
-#include <kvm/arm_pmu.h>
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
@@ -782,6 +782,33 @@ struct vcpu_reset_state {
 
 struct vncr_tlb;
 
+#if IS_ENABLED(CONFIG_HW_PERF_EVENTS)
+
+#define KVM_ARMV8_PMU_MAX_COUNTERS	32
+
+struct kvm_pmc {
+	u8			idx;	/* index into the pmu->pmc array */
+	struct perf_event	*perf_event;
+};
+
+struct kvm_pmu_events {
+	u64			events_host;
+	u64			events_guest;
+};
+
+struct kvm_pmu {
+	struct irq_work		overflow_work;
+	struct kvm_pmu_events	events;
+	struct kvm_pmc		pmc[KVM_ARMV8_PMU_MAX_COUNTERS];
+	int			irq_num;
+	bool			created;
+	bool			irq_level;
+};
+#else
+struct kvm_pmu {
+};
+#endif
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -1469,25 +1496,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
 
-static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
-{
-	return (!has_vhe() && attr->exclude_host);
-}
-
 #ifdef CONFIG_KVM
-void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
-void kvm_clr_pmu_events(u64 clr);
-bool kvm_set_pmuserenr(u64 val);
 void kvm_enable_trbe(void);
 void kvm_disable_trbe(void);
 void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest);
 #else
-static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
-static inline void kvm_clr_pmu_events(u64 clr) {}
-static inline bool kvm_set_pmuserenr(u64 val)
-{
-	return false;
-}
 static inline void kvm_enable_trbe(void) {}
 static inline void kvm_disable_trbe(void) {}
 static inline void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest) {}
@@ -1658,5 +1671,152 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_id fgt);
 void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res0, u64 *res1);
 void check_feature_map(void);
 
+#define kvm_vcpu_has_pmu(vcpu)				\
+	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
+
+#if IS_ENABLED(CONFIG_HW_PERF_EVENTS)
+
+bool kvm_supports_guest_pmuv3(void);
+u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
+void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
+void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
+u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
+u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
+void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
+void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
+void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
+void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
+bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu);
+void kvm_pmu_update_run(struct kvm_vcpu *vcpu);
+void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
+				    u64 select_idx);
+void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu);
+int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
+			    struct kvm_device_attr *attr);
+int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
+			    struct kvm_device_attr *attr);
+int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
+			    struct kvm_device_attr *attr);
+int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
+
+struct kvm_pmu_events *kvm_get_pmu_events(void);
+void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
+void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
+
+/*
+ * Updates the vcpu's view of the pmu events for this cpu.
+ * Must be called before every vcpu run after disabling interrupts, to ensure
+ * that an interrupt cannot fire and update the structure.
+ */
+#define kvm_pmu_update_vcpu_events(vcpu)				\
+	do {								\
+		if (!has_vhe() && system_supports_pmuv3())		\
+			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
+	} while (0)
+
+u8 kvm_arm_pmu_get_pmuver_limit(void);
+u64 kvm_pmu_evtyper_mask(struct kvm *kvm);
+int kvm_arm_set_default_pmu(struct kvm *kvm);
+u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm);
+
+u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu);
+bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx);
+void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu);
+#else
+static inline bool kvm_arm_support_pmu_v3(void)
+{
+	return false;
+}
+
+static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
+					    u64 select_idx)
+{
+	return 0;
+}
+static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
+					     u64 select_idx, u64 val) {}
+static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
+static inline bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline void kvm_pmu_update_run(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
+						  u64 data, u64 select_idx) {}
+static inline int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	return -ENXIO;
+}
+static inline int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
+{
+	return 0;
+}
+
+static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
+static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
+static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	return 0;
+}
+static inline u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline int kvm_arm_set_default_pmu(struct kvm *kvm)
+{
+	return -ENODEV;
+}
+
+static inline u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
+{
+	return 0;
+}
+
+static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx)
+{
+	return false;
+}
+
+static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
+
+#endif
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
new file mode 100644
index 000000000000..613cddbdbdd8
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_PMU_H
+#define __KVM_PMU_H
+
+/*
+ * Define the interface between the PMUv3 driver and KVM.
+ */
+struct perf_event_attr;
+struct arm_pmu;
+
+#define kvm_pmu_counter_deferred(attr)			\
+	({						\
+		!has_vhe() && (attr)->exclude_host;	\
+	})
+
+#ifdef CONFIG_KVM
+
+void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
+void kvm_clr_pmu_events(u64 clr);
+bool kvm_set_pmuserenr(u64 val);
+void kvm_vcpu_pmu_resync_el0(void);
+void kvm_host_pmu_init(struct arm_pmu *pmu);
+
+#else
+
+static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
+static inline void kvm_clr_pmu_events(u64 clr) {}
+static inline bool kvm_set_pmuserenr(u64 val)
+{
+	return false;
+}
+static inline void kvm_vcpu_pmu_resync_el0(void) {}
+static inline void kvm_host_pmu_init(struct arm_pmu *pmu) {}
+
+#endif
+
+#endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 36cfcffb40d8..3b9c003f2ea6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -43,7 +43,6 @@
 #include <asm/sections.h>
 
 #include <kvm/arm_hypercalls.h>
-#include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
 
 #include "sys_regs.h"
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0e4c805e7e89..7fb1d9e7180f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -9,6 +9,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/kvm_asm.h>
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index eef310cdbdbd..d407e716df1b 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -14,6 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/types.h>
 #include <linux/jump_label.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <uapi/linux/psci.h>
 
 #include <kvm/arm_psci.h>
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 25c29107f13f..472a2ab6938f 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -8,11 +8,10 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/list.h>
-#include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_emulate.h>
-#include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
 #define PERF_ATTR_CFG1_COUNTER_64BIT	BIT(0)
@@ -24,6 +23,8 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc);
 static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc);
 static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
 
+#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
+
 bool kvm_supports_guest_pmuv3(void)
 {
 	guard(mutex)(&arm_pmus_lock);
@@ -258,6 +259,16 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
 		pmu->pmc[i].idx = i;
 }
 
+static u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
+{
+	u64 val = FIELD_GET(ARMV8_PMU_PMCR_N, kvm_vcpu_read_pmcr(vcpu));
+
+	if (val == 0)
+		return BIT(ARMV8_PMU_CYCLE_IDX);
+	else
+		return GENMASK(val - 1, 0) | BIT(ARMV8_PMU_CYCLE_IDX);
+}
+
 /**
  * kvm_pmu_vcpu_destroy - free perf event of PMU for cpu
  * @vcpu: The vcpu pointer
@@ -315,16 +326,6 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 	return mask & ~kvm_pmu_hyp_counter_mask(vcpu);
 }
 
-u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
-{
-	u64 val = FIELD_GET(ARMV8_PMU_PMCR_N, kvm_vcpu_read_pmcr(vcpu));
-
-	if (val == 0)
-		return BIT(ARMV8_PMU_CYCLE_IDX);
-	else
-		return GENMASK(val - 1, 0) | BIT(ARMV8_PMU_CYCLE_IDX);
-}
-
 static void kvm_pmc_enable_perf_event(struct kvm_pmc *pmc)
 {
 	if (!pmc->perf_event) {
@@ -784,6 +785,11 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 	kvm_pmu_create_perf_event(pmc);
 }
 
+struct arm_pmu_entry {
+	struct list_head entry;
+	struct arm_pmu *arm_pmu;
+};
+
 void kvm_host_pmu_init(struct arm_pmu *pmu)
 {
 	struct arm_pmu_entry *entry;
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 6b48a3d16d0d..8bfc6b0a85f6 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -8,6 +8,8 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
+#include <asm/kvm_pmu.h>
+
 static DEFINE_PER_CPU(struct kvm_pmu_events, kvm_pmu_events);
 
 /*
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 707c651aff03..d368eeb4f88e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
 #include <asm/cacheflush.h>
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
deleted file mode 100644
index 96754b51b411..000000000000
--- a/include/kvm/arm_pmu.h
+++ /dev/null
@@ -1,199 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Linaro Ltd.
- * Author: Shannon Zhao <shannon.zhao@linaro.org>
- */
-
-#ifndef __ASM_ARM_KVM_PMU_H
-#define __ASM_ARM_KVM_PMU_H
-
-#include <linux/perf_event.h>
-#include <linux/perf/arm_pmuv3.h>
-
-#define KVM_ARMV8_PMU_MAX_COUNTERS	32
-
-#if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
-struct kvm_pmc {
-	u8 idx;	/* index into the pmu->pmc array */
-	struct perf_event *perf_event;
-};
-
-struct kvm_pmu_events {
-	u64 events_host;
-	u64 events_guest;
-};
-
-struct kvm_pmu {
-	struct irq_work overflow_work;
-	struct kvm_pmu_events events;
-	struct kvm_pmc pmc[KVM_ARMV8_PMU_MAX_COUNTERS];
-	int irq_num;
-	bool created;
-	bool irq_level;
-};
-
-struct arm_pmu_entry {
-	struct list_head entry;
-	struct arm_pmu *arm_pmu;
-};
-
-bool kvm_supports_guest_pmuv3(void);
-#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
-u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
-void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
-void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
-u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu);
-u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
-u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
-void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
-void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val);
-void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
-void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
-bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu);
-void kvm_pmu_update_run(struct kvm_vcpu *vcpu);
-void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
-void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val);
-void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
-				    u64 select_idx);
-void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu);
-int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
-			    struct kvm_device_attr *attr);
-int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
-			    struct kvm_device_attr *attr);
-int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
-			    struct kvm_device_attr *attr);
-int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
-
-struct kvm_pmu_events *kvm_get_pmu_events(void);
-void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
-void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
-void kvm_vcpu_pmu_resync_el0(void);
-
-#define kvm_vcpu_has_pmu(vcpu)					\
-	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
-
-/*
- * Updates the vcpu's view of the pmu events for this cpu.
- * Must be called before every vcpu run after disabling interrupts, to ensure
- * that an interrupt cannot fire and update the structure.
- */
-#define kvm_pmu_update_vcpu_events(vcpu)				\
-	do {								\
-		if (!has_vhe() && system_supports_pmuv3())		\
-			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
-	} while (0)
-
-u8 kvm_arm_pmu_get_pmuver_limit(void);
-u64 kvm_pmu_evtyper_mask(struct kvm *kvm);
-int kvm_arm_set_default_pmu(struct kvm *kvm);
-u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm);
-
-u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu);
-bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx);
-void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu);
-#else
-struct kvm_pmu {
-};
-
-static inline bool kvm_supports_guest_pmuv3(void)
-{
-	return false;
-}
-
-#define kvm_arm_pmu_irq_initialized(v)	(false)
-static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
-					    u64 select_idx)
-{
-	return 0;
-}
-static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
-					     u64 select_idx, u64 val) {}
-static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
-						  u64 select_idx, u64 val) {}
-static inline u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_reprogram_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
-static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
-static inline bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu)
-{
-	return false;
-}
-static inline void kvm_pmu_update_run(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
-static inline void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val) {}
-static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
-						  u64 data, u64 select_idx) {}
-static inline int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
-					  struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
-static inline int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
-					  struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
-static inline int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
-					  struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
-static inline int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
-{
-	return 0;
-}
-
-#define kvm_vcpu_has_pmu(vcpu)		({ false; })
-static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
-static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
-static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
-static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
-static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
-{
-	return 0;
-}
-static inline u64 kvm_pmu_evtyper_mask(struct kvm *kvm)
-{
-	return 0;
-}
-static inline void kvm_vcpu_pmu_resync_el0(void) {}
-
-static inline int kvm_arm_set_default_pmu(struct kvm *kvm)
-{
-	return -ENODEV;
-}
-
-static inline u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
-{
-	return 0;
-}
-
-static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-
-static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx)
-{
-	return false;
-}
-
-static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
-
-#endif
-
-#endif
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 6dc5e0cd76ca..1de206b09616 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -13,6 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
+#ifdef CONFIG_ARM64
+#include <asm/kvm_pmu.h>
+#endif
 
 #ifdef CONFIG_ARM_PMU
 
@@ -25,6 +28,11 @@
 #else
 #define ARMPMU_MAX_HWEVENTS		33
 #endif
+
+#ifdef CONFIG_ARM
+#define kvm_host_pmu_init(_x) { (void)_x; }
+#endif
+
 /*
  * ARM PMU hw_event flags
  */
@@ -170,12 +178,6 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
-#ifdef CONFIG_KVM
-void kvm_host_pmu_init(struct arm_pmu *pmu);
-#else
-#define kvm_host_pmu_init(x)	do { } while(0)
-#endif
-
 bool arm_pmu_irq_is_nmi(void);
 
 /* Internal functions only for core arm_pmu code */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e85b33a92624..d2263b5a0789 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/perf_event.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
-- 
2.49.0.1204.g71687c7c1d-goog


