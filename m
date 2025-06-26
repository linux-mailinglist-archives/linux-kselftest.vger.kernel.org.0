Return-Path: <linux-kselftest+bounces-35920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D070AEA7C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6483A8E39
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6F22F3623;
	Thu, 26 Jun 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChDZxUFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D92F2373
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968358; cv=none; b=rXAj6W9Cn/+sB7bV0dVagMJvLuXriKJK4+qt1Zh1tNZIVrDJS2s8zoLWcdAqkHklQS+GH8fiMvbrlvfWSqj2oGJwlKLSCW3IczeR7CMe0ct9XXj7LEXqhmZOM+Haii7NvuePeD+x/Bba9una5sHt6Tm3fxouKjV2xxc/hW7A8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968358; c=relaxed/simple;
	bh=lsw/9JDLn48QzC9luGx5RzoWfLOk/GJ1m1FQZZ1NVxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlWXkwiUzSfCQySgAckn7kKQkrxMmpNMBt8npCj6XPbqFfXBfsAfx40ZSzphTQR184AcfFBaC7awguijJUTXWv7vyAc3xkDc9dcN77z5AKWwPB9DPVbHFJZwItLUHgt39Jsx2fpv1YoA98fcs6JV+BLpVEnmYiBjrSsJdJBxVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChDZxUFU; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso33338315ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968356; x=1751573156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRv3wKa2Rgdejn+APGtlkMboACuL4RazR5HzeTmIwac=;
        b=ChDZxUFUnCTip/myGX7Ut6Xb2CUkDU42vY7EFzcMtDIN7V8upfECnPfel9KPnxBhRy
         Ln0NSc6BK8H1sUvxjatCEqxSaFjipm22w60uj8J8sHAy+E3HKmjQAbTYhAqzUfTixwkh
         FFjCrKjSLi2kXjLz1tTG7sYBQ8VXku1hTz4ZRtZ354eQC6F8LbwFolBXMWW6prbf0/j/
         +B/pgS2lRSQ+fEfRlbYeFXKhQciMFD1JND0pCpTy3JInNeiwEi+Jd9vQGGixbdSBeEyN
         zLCmsSXBVYsLoJVuFEX52JhEb8rGxB9j4xZTAgEoRufDp6CXSSryOhkm1L/aJM+08Ey+
         D/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968356; x=1751573156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRv3wKa2Rgdejn+APGtlkMboACuL4RazR5HzeTmIwac=;
        b=E+Fy6e2sLH0ee6EXRG+PPNl05BEkjPSVtovhaWD6Reu1vwxrNZ4rFYswvc9CZlWXb6
         yEhDdLFhKmuCs/hrk7bIfpB72uf0go8OVzDGl9VfvHxc6FizjoB0CgPHYmnpV1Meu4Mr
         0sJKr5VB/j5LP6aSZMvRdi7XqKZRDFSRGobQr67hApunU5VU3N+oOPgTlSH71soMmhFU
         rmk3mSrV7ABaEuvkYxAPM1z92rZBbyX+bccos2t52WA0Yw/EedRpD+U075IDODHdmTSv
         dNoJW+KniHMVxn/+lACuWY7pqFA6gGpFvgjbPG/qKRmd/zt5shLT91LFz0ozDGzB9TEL
         iwFA==
X-Forwarded-Encrypted: i=1; AJvYcCWMeyMRgEa/An+LkzhzNdujsRzOP70S4GRs6MgbIM62oQzYILPbh24wJmTomsFXMQZzjilHjLgvQ+e38he0H7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiaqPgmYEpCaUrC8EVnAjE1oUonxpAw8ncYohCeyspYGV+Aezj
	KdVp43fwGZG9xRO0NTT3Cpc/ULPY56wqhDtejRGwOD9VELPYd+vt13xtpmzN0ljHSaLj4oYPD73
	hLRyMomi0MDGrs0frXPHZqySSsg==
X-Google-Smtp-Source: AGHT+IG65ARbJWB/ki57K8Y3eggnPaWo7RnX/DLSE7yaShoxZ2aPYQNL7voLM09Vn/2MpXgpwJ03tWhv2B8Hv2lH5g==
X-Received: from ilbeh24.prod.google.com ([2002:a05:6e02:4c18:b0:3df:41b8:3ac1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:c241:0:b0:3dd:d321:79ab with SMTP id e9e14a558f8ab-3df4acbedbdmr12502385ab.18.1750968355585;
 Thu, 26 Jun 2025 13:05:55 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:40 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-5-coltonlewis@google.com>
Subject: [PATCH v3 04/22] KVM: arm64: Cleanup PMU includes
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

From: Marc Zyngier <maz@kernel.org>

Reorganize these tangled headers.

* Respect the move defining the interface between KVM and PMU in its
  own header asm/kvm_pmu.h

* Define an empty struct arm_pmu so it is defined for those interface
  functions when compiling with CONFIG_KVM but not CONFIG_ARM_PMU

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h      |  2 +-
 arch/arm64/include/asm/kvm_host.h       | 15 +--------------
 arch/arm64/include/asm/kvm_pmu.h        | 15 +++++++++++++++
 arch/arm64/kvm/debug.c                  |  1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |  1 +
 arch/arm64/kvm/pmu.c                    |  2 ++
 arch/arm64/kvm/sys_regs.c               |  1 +
 include/linux/perf/arm_pmu.h            |  5 +++++
 virt/kvm/kvm_main.c                     |  1 +
 9 files changed, 28 insertions(+), 15 deletions(-)

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
index 27ed26bd4381..2df76689381a 100644
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
@@ -1487,25 +1488,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
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
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index baf028d19dfc..ad3247b46838 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -11,9 +11,15 @@
 #include <linux/kvm_types.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmuv3.h>
+#include <linux/perf/arm_pmu.h>
 
 #define KVM_ARMV8_PMU_MAX_COUNTERS	32
 
+#define kvm_pmu_counter_deferred(attr)			\
+	({						\
+		!has_vhe() && (attr)->exclude_host;	\
+	})
+
 #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
@@ -68,6 +74,9 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
 
 struct kvm_pmu_events *kvm_get_pmu_events(void);
+void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
+void kvm_clr_pmu_events(u64 clr);
+bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
@@ -161,6 +170,12 @@ static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 
 #define kvm_vcpu_has_pmu(vcpu)		({ false; })
 static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
+static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
+static inline void kvm_clr_pmu_events(u64 clr) {}
+static inline bool kvm_set_pmuserenr(u64 val)
+{
+	return false;
+}
 static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 1a7dab333f55..a554c3e368dc 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -9,6 +9,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/kvm_asm.h>
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 7599844908c0..825b81749972 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -14,6 +14,7 @@
 #include <linux/kvm_host.h>
 #include <linux/types.h>
 #include <linux/jump_label.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <uapi/linux/psci.h>
 
 #include <asm/barrier.h>
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
index 99fdbe174202..eaff6d63ef77 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
 #include <asm/cacheflush.h>
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 6dc5e0cd76ca..fb382bcd4f4b 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -187,6 +187,11 @@ void armpmu_free_irq(int irq, int cpu);
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
+#else
+
+struct arm_pmu {
+};
+
 #endif /* CONFIG_ARM_PMU */
 
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e2f6344256ce..25259fcf3115 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -48,6 +48,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/perf_event.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
-- 
2.50.0.727.gbf7dc18ff4-goog


