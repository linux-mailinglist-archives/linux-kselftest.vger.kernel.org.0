Return-Path: <linux-kselftest+bounces-26569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D25EA34D24
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D08E1890FB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49D266193;
	Thu, 13 Feb 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tn1YGnB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0F24A059
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469922; cv=none; b=CTWqyQCNH7IPLCoMKOrbofAQz49iMCPL6ILvqZd+3HqpZSUG53D4eVRkGynWi6LDOVuBqMym0n9g1uXaxoMf09CW1gKQTArHf36MioKMs/dTWhka5b8WxohN2q+m72SC4xjcgGcM6q7s+eC5Hpmh1P8a2UUPWlOrXmx/ahtPQ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469922; c=relaxed/simple;
	bh=8pKyMBfXuEtgrdtamp8/WpKCSvEo2LV50PmpBYaaRjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+uVgg6TE3FnbOB8cKBSej5Y0UAeJvZSEPY8KTuDyV25PDpbwId20zefFSfoGal8NvnfQL8/kKEGEkBe9PmEUuI136z3FosTPlZNck0Rqcca7vTBaquboQPe3jis2v/pR0VhB4L+e01twWAOPL7SwhWK8NIbuDLgQWDJW6YeyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tn1YGnB4; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7217bc53c3fso363161a34.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469918; x=1740074718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmHXIlcJk1VfwtTE28LC1EoomuNmvTwmFjxrDabFHQ=;
        b=Tn1YGnB4FcFYl/HBDe9gSNPBSMUoTe8HPmiiw7EoA4Wk87yOVcoDsKCQouc/2McdUg
         Zk8SbT8oe+nvvqJJohT+Lg+ma0QH+5dJ11wRKCF6wAK5BBQQOPDABRCk4hC3IO8T8sRD
         jfODn3nAU2l2J84O3fxr5mGj4YeR05Ci9+j082/Z08XFgZN8RrSDBhwspRXX1wE0Tsgi
         f5r1zFXsyy8mSFYFo+iJzZ89vKH8FJfJxVMtDI753v5klmlhz9mnNoBNz/COwkN2wtzL
         04JVcAOanRvkX+IXYtqL+MJ5Nkau2QXN0y31SUnhmtVjzWl+cvPwzuW3Ctq5gI3BEUPP
         sJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469918; x=1740074718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmHXIlcJk1VfwtTE28LC1EoomuNmvTwmFjxrDabFHQ=;
        b=HQ0UGcbyt2AzVimZgqAvrj4Gd/e6WZ+TmEfaHAbZEo0N1SZIvUT08QEXtp1DmDNOKx
         +WKHiq0MY7v0/lxSecf9PNehwzZjHCLtt9CfPLsErju93dBwnaE+oumYF8fyCU1ABgDu
         uZj8HvOx9yVT0EtOyBu61ssr7eY4+JkzaZrEERf1MG/hbEMV6sVuOn0k11xJN2kaMZ8/
         uCFwM8FpHVHNk/p3zPT61AatmKzW7jokVpoEppH151i/CjG3y25BL21nMltUPxpaMGJT
         rUVK3iqJh7NZW8zTjf7fINSg+FL0STZ8kX2GQg+aQseSyAHiFS/KyJLoXR9yc8a7O3lD
         4IVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQxBle9wjMHwyV/ANnY83yZfhhxRXmCVCeEmJlawCom25Yecaj7EM1lTIc7fR3KPc2axAMGN9d7eCpWn+G+6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTu5TizN1LNKZ794wcm4jQxDWCSd20cvYY4d1cxBWTN8P/sHA
	KzGTqmOnnA6jib7BMnT/6aWvqavye+VDC1kRGHS7iVYADit6WfIxok/fpWH3lKLPDytMqf4tbEJ
	pNy4x04bq7i8HI1YOTeh2aA==
X-Google-Smtp-Source: AGHT+IEPQuY488WihJ9lnDNXDb7htCah6QKRYBC+xgjB8r+rrhYaQ8nPCffsdD7EeCbuFDrMZJ2tPweIg0P5+S+XlQ==
X-Received: from oojj18.prod.google.com ([2002:a05:6820:a012:b0:5fc:a1f1:36ea])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:6709:b0:726:fb20:7f6d with SMTP id 46e09a7af769-726fe7789d8mr3155212a34.8.1739469918079;
 Thu, 13 Feb 2025 10:05:18 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:12 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-4-coltonlewis@google.com>
Subject: [RFC PATCH v3 3/8] KVM: arm64: Cleanup PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
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
 arch/arm64/include/asm/kvm_host.h       | 198 +++++++++++++++++++++--
 arch/arm64/include/asm/kvm_pmu.h        |  38 +++++
 arch/arm64/kvm/arm.c                    |   1 -
 arch/arm64/kvm/debug.c                  |   1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |   1 +
 arch/arm64/kvm/pmu-emul.c               |  30 ++--
 arch/arm64/kvm/pmu.c                    |   2 +
 arch/arm64/kvm/sys_regs.c               |   2 +
 include/kvm/arm_pmu.h                   | 204 ------------------------
 include/linux/perf/arm_pmu.h            |  14 +-
 virt/kvm/kvm_main.c                     |   1 +
 12 files changed, 255 insertions(+), 239 deletions(-)
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
index 7cfa024de4e3..80e5c09790b9 100644
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
 
@@ -705,6 +705,35 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+struct vncr_tlb;
+
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
 
@@ -1385,25 +1414,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
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
@@ -1555,4 +1570,157 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_s1poe(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
 
+#define kvm_vcpu_has_pmu(vcpu)				\
+	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
+
+#if IS_ENABLED(CONFIG_HW_PERF_EVENTS)
+
+DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
+static __always_inline bool kvm_arm_support_pmu_v3(void)
+{
+	return static_branch_likely(&kvm_arm_pmu_available);
+}
+
+u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
+void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
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
+		if (!has_vhe() && kvm_arm_support_pmu_v3())		\
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
+
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
index 646e806c6ca6..efe1ea0c5ac0 100644
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
index f838a45665f2..53db98dbfd5f 100644
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
index 6c5950b9ceac..5bf9f582ca8d 100644
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
@@ -26,6 +25,8 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc);
 static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc);
 static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
 
+#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
+
 static struct kvm_vcpu *kvm_pmc_to_vcpu(const struct kvm_pmc *pmc)
 {
 	return container_of(pmc, struct kvm_vcpu, arch.pmu.pmc[pmc->idx]);
@@ -247,6 +248,16 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
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
  * kvm_pmu_vcpu_reset - reset pmu state for cpu
  * @vcpu: The vcpu pointer
@@ -318,16 +329,6 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
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
@@ -775,6 +776,11 @@ void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
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
index 0b3adf3e17b4..3affc9074d71 100644
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
index f6cd1ea7fb55..edf6695eed3c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -17,6 +17,8 @@
 #include <linux/mm.h>
 #include <linux/printk.h>
 #include <linux/uaccess.h>
+#include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
 #include <asm/cacheflush.h>
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
deleted file mode 100644
index 147bd3ee4f7b..000000000000
--- a/include/kvm/arm_pmu.h
+++ /dev/null
@@ -1,204 +0,0 @@
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
-DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
-
-static __always_inline bool kvm_arm_support_pmu_v3(void)
-{
-	return static_branch_likely(&kvm_arm_pmu_available);
-}
-
-#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
-u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
-void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
-u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu);
-u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
-u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
-void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
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
-		if (!has_vhe() && kvm_arm_support_pmu_v3())		\
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
-static inline bool kvm_arm_support_pmu_v3(void)
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
-static inline u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
-{
-	return 0;
-}
-static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
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
index 4b5b83677e3f..35c3a85bee43 100644
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
@@ -165,12 +173,6 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
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
index faf10671eed2..34455126f5b7 100644
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
2.48.1.601.g30ceb7b040-goog


