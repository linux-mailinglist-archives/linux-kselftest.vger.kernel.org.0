Return-Path: <linux-kselftest+bounces-35473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48376AE2506
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18BC174FF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44302472A2;
	Fri, 20 Jun 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZnldkZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6C23BD1A
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457924; cv=none; b=EOWSeElCbruIHLDjFXuHC7//yLOY7UB3UoymrKF010JhKbS6EfjMYwRxiuKsvrnVpS16aYLvqRJsWa5YCv3hnlnwHoVeEUvHSf0DO0w15/5WCo9HIZ8tusoRWJ4+oAueqfcBC9r9kWY6VGtNKszZMa2fttD1aphwYSVGgXfbJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457924; c=relaxed/simple;
	bh=I3e4uNmpE9tSGaln+NGHh3+Y0TBXHnLrzFPU+vvpM20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yx6w5Xk/Iwv+1fKlmJRdFwTpi0cwxuAB4qyQcPbBrXU5YJimeVhUjtDawPJNsb+AqYC9jbETN1YhaaqQk84qJgpl3zpu+ZL7+zhbJzlnJnuGqiXhZjUq9HYQSPS+AyGbITLfOGVC391eO8OJAGP4Qh5Jtd475WdU8SwJAHQja0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZnldkZd; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-40a55d8135dso685126b6e.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457920; x=1751062720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWHD159eEkEd2RVAASCwDxR2pqbhwMR1y9w3LokBHQQ=;
        b=CZnldkZdamAHo/66/0xx1jg0Jm58NcF6kdwKow6COSTmb/0iq2deGCUiBVDm6dxzue
         t0t+usNf+rcmFAesr/qEK+M7Tm1nYIsTyI9YtGOdX6OR4yIuHFkmytWS/NTLY3eJWjiS
         9Q0Ed58OzUdsUHynUn2oT4Alre0Ty8EiWvrkGUxjza4kvRqNeXfKYyAmegDPWWFw6O5O
         Sr8Y2SgICJTzm7rYEkeWCifHVMK6V/UbwO4jYDAh/ZZzg32z4xapss4bnW6CAbu6Eu6t
         Xs8n3k25D23wi3UdtyFX3Q2H2jEqLsREjvhwVJ5soMyCZP03YmUXsxtbglKPOs7x0j/a
         YKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457920; x=1751062720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWHD159eEkEd2RVAASCwDxR2pqbhwMR1y9w3LokBHQQ=;
        b=mxsRMVZTAqyBmcbnYgUlprtw1vhgn6B0OByxYrf+hCWA2+wJxal0vS2KqI86vrhkg8
         6OBz5Ytt3OzEDIVi92pWg2pUHoAOrToW1D5OOH0cA7s4qGCWBYWjzL7vySQNAkI+ra/9
         iKsB0DXRKyVQg5jMXin8tRQAitHwX/ZIfHf3etaipAluN6N0hfSKM3WscMZaKZGtr0SL
         SWq0QCai5xXqPff7Uukhdo6RIR9wr6bLdb5USUX4wyZgVcCDQMfm+mjH4ZFPG/1aoNfx
         45yFsrvyPJF5SEhS52CavToiZy+Mmvwp/FdzyRSLjNgTccMOkFQptAEGfLowZ9WjmchO
         9gzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NKaQTx0Tw3cZdE0eX09CwfhbXw71u5KFtG5wz9aUIE4r85mCUG8i7KtYBnsj4PitxoUf+8u5R3OlT4bMGrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nRoSRvKQgGDjg7Zx6SO/LycSu4DUaHg3OohDInwFiozSo67X
	5TcQqEquslE8lRYo7bmRA1QiIBtugkM4QXNLWIxm7MgbqgnA2L1lr2c27raNtyTGXUDq2UzTXaS
	rgdYeZS/5vaCGZMGTGnFs/AiDgQ==
X-Google-Smtp-Source: AGHT+IF2OKmMZlYWXREsJ8oFrgMGWLo7kWe5ClPilcLSMHKtRvIA2tl/nLM95GtmJ2ppZK9UqlnZUllLoCroliosBg==
X-Received: from oibko5.prod.google.com ([2002:a05:6808:6905:b0:407:ab9e:f086])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1584:b0:406:6fd3:ff18 with SMTP id 5614622812f47-40ac7141518mr3848175b6e.34.1750457920632;
 Fri, 20 Jun 2025 15:18:40 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:05 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-6-coltonlewis@google.com>
Subject: [PATCH v2 05/23] KVM: arm64: Cleanup PMU includes
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
 arch/arm64/include/asm/arm_pmuv3.h      |  2 +-
 arch/arm64/include/asm/kvm_host.h       | 15 +--------------
 arch/arm64/include/asm/kvm_pmu.h        |  9 +++++++++
 arch/arm64/kvm/debug.c                  |  1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |  1 +
 arch/arm64/kvm/pmu-emul.c               |  4 +++-
 arch/arm64/kvm/pmu.c                    |  2 ++
 arch/arm64/kvm/sys_regs.c               |  1 +
 include/linux/perf/arm_pmu.h            | 14 ++++++++------
 virt/kvm/kvm_main.c                     |  1 +
 10 files changed, 28 insertions(+), 22 deletions(-)

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
index baf028d19dfc..a44f712668b5 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -14,6 +14,11 @@
 
 #define KVM_ARMV8_PMU_MAX_COUNTERS	32
 
+#define kvm_pmu_counter_deferred(attr)			\
+	({						\
+		!has_vhe() && (attr)->exclude_host;	\
+	})
+
 #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
@@ -68,9 +73,13 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
 
 struct kvm_pmu_events *kvm_get_pmu_events(void);
+void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
+void kvm_clr_pmu_events(u64 clr);
+bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
+void kvm_host_pmu_init(struct arm_pmu *pmu);
 
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
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
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index dcdd80ffd49d..b9882085394e 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -8,8 +8,8 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/list.h>
-#include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_pmu.h>
@@ -24,6 +24,8 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc);
 static void kvm_pmu_release_perf_event(struct kvm_pmc *pmc);
 static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc);
 
+#define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
+
 bool kvm_supports_guest_pmuv3(void)
 {
 	guard(mutex)(&arm_pmus_lock);
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
2.50.0.714.g196bf9f422-goog


