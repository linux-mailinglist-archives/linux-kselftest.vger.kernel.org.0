Return-Path: <linux-kselftest+bounces-47335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C483CB12BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D38AF30E1D64
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA93307AFC;
	Tue,  9 Dec 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAEjPpC8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5030DEAB
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313582; cv=none; b=l/OptSl8Z8a5bzIpkO/Dmxq9ZyRkE4NLdYtuJSHZjvm0128Q1rm7cFljXl2H5juN3sN5cxJ0mc/r14xuH8n/W+lYj54r9YxUJj5gOhBTtjQX/dCL7Nqby04YR7Pq7+gJbiIILIVcPnxPESZMXuF0I67MCuXykiw22lorM7hKkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313582; c=relaxed/simple;
	bh=wqxAcEnfjWslc6FMnBqUCDwEB4TrUdMmPgJYpyRpr/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGJDbCN9qIIPv/n9sZuuMmIznNqEIicLKOfyVXAMdU9t8cxHqZMmaVCCkJVFL83oskXNiMyzEGFTFqBJDBidfk1zoU6TFHm4am2WdBg7wC8GHXEvsr6MyL3lxCnjxrIPE7Nziklf35i7kmqcwLR2eZLc+9v4PLCR960ojc3nGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAEjPpC8; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c6d917f184so5665328a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313568; x=1765918368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4FZ+/Cx29XCU0NwopF8BMz21OlcWT5NMANeA7QHOoI=;
        b=vAEjPpC8V1ktQqPp21zU8bjuW49m94BQhX9NK/oZGfgOGY8dPosJwuPl5VV18vyXoT
         m8Sc47OfOpafdwcYGACd7pnLBfhWxOdiWZQCTOKAyfaXGV9yJ8GGvipEgP9yQqaU1M7I
         kiyanzwmyzt75uwFDDhd1YqHiXvNlHABLbvbZCUrfKYsn755VxmtvrB6dw2esiJMhFrr
         0TpAthQgg3BzGQH+4e1SxFb1y42I88f/sH7lmixqcO4idffEeXIOTJpztRhxDRgPZySb
         heYIMrv+WZvwQh3DhBhd+f9b8xYgTPIOZjQpyEvCJg9e74MhHQ7NQ+uJCIXaCdfB4qwN
         8bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313568; x=1765918368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4FZ+/Cx29XCU0NwopF8BMz21OlcWT5NMANeA7QHOoI=;
        b=mBkWqQ7EgxeB1Asv94UQXR0yhp1OlyL8lI0NKsQ30GnkX45pD476H3XKQ/1Ii2WgEH
         e04o8rneBaqIKZuuy8r1WsCJ4QpomOgnafKTjVY+CDdzn0WzIneiZG6EWRz4vmPLgfKy
         rokACDOf2NUVQsJIVG/2oq2UDJ/85qe9vNvCe6b3z1BIiKeQETa4AJ83D4KHnjPPSoy8
         kdB9TflPA/tFvCBqBDUdfl+13UmAPjVow9jgCJvRX3qpmVlOsnKCnNAV22bhjcCfVOwu
         3nx9E/jbdVrQy8tqmQCEs8DhehPuVDrO+6oU1Vu2K/5mFxbrbmPrKIP2UmCJVdxq4LT9
         L71Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZhQ3/VNoXEDAQFOHbac2d/oaMkZFMWDcvdvyrXWUFqZP8oH3IKkShuTDodRAStnCgMoSLqk4fyb417sTb9lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gfxfkvrYE56BZNbJikG3EfCyRTRogpezW3rX1Eq9e2c1WAme
	jKvOfgd7//EaXk/yfI6P2ggwKNGzMghp24MZg2Bxu/0q/ZVJ7DeNsPDOJuolEqhVuPXHXeOApcP
	KNiIqjvZ8dSVYA3bOEazPQpVXWw==
X-Google-Smtp-Source: AGHT+IEBRlr1/jXDGJ9Zvft6mZlSqQM12FXY9uBTued7GbCi/EnMLdFhp2WodcmHfDpcFufyHRIReuOYMmyMkLnTYg==
X-Received: from otvq6.prod.google.com ([2002:a05:6830:4406:b0:7c7:3060:b521])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:60c9:10b0:7c9:5bef:ec3 with SMTP id 46e09a7af769-7cacebb3449mr70790a34.12.1765313568461;
 Tue, 09 Dec 2025 12:52:48 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:19 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-23-coltonlewis@google.com>
Subject: [PATCH v5 22/24] KVM: arm64: Add KVM_CAP to partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KVM_CAP_ARM_PARTITION_PMU to enable the partitioned PMU for a
given VM. This capability is allowed where PMUv3 and VHE are supported
and the host driver was configured with
arm_pmuv3.reserved_host_counters.

Ordering is enforced such that this must be called before the vCPUs
are created to avoid the possibility the guest is already using one
PMU configuration that gets switched out from under it.

The enabled capability is tracked by the new flag
KVM_ARCH_FLAG_PARTITIONED_PMU_ENABLED.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 Documentation/virt/kvm/api.rst    | 24 +++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/asm/kvm_pmu.h  |  9 ++++++++
 arch/arm64/kvm/arm.c              | 15 +++++++++++++
 arch/arm64/kvm/pmu-direct.c       | 35 ++++++++++++++++++++++++++++---
 include/uapi/linux/kvm.h          |  1 +
 6 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 57061fa29e6a0..ef1b22f20ee71 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8703,6 +8703,30 @@ This capability indicate to the userspace whether a PFNMAP memory region
 can be safely mapped as cacheable. This relies on the presence of
 force write back (FWB) feature support on the hardware.
 
+
+7.245 KVM_CAP_ARM_PARTITION_PMU
+-------------------------------------
+
+:Architectures: arm64
+:Target: VM
+:Parameters: arg[0] is a boolean that enables or disables the capability
+:Returns: 0 on success
+	  -EPERM if host doesn't support
+	  -EBUSY if vPMU was already created
+
+This API controls the PMU implementation used for VMs. The capability
+is only available if the host PMUv3 driver was configured for
+partitioning via the module parameter
+``arm-pmuv3.reserved_guest_counters=[0-$NR_COUNTERS]``. When enabled,
+VMs are configured to have direct hardware access to the most
+frequently used registers for the counters configured by the
+aforementioned module parameters, bypassing the KVM traps in the
+standard emulated PMU implementation and reducing overhead of any
+guest software that uses PMU capabilities such as ``perf``.
+
+If the host driver was configured for partitioning but the partitioned
+PMU is disabled through this interface, the VM will use the legacy PMU
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f92027d8fdfd0..8431fdebcac43 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -349,6 +349,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
 	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+	/* Partitioned PMU Enabled */
+#define KVM_ARCH_FLAG_PARTITION_PMU_ENABLED		11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 47e6f2a14e381..6146120208e39 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -111,6 +111,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu);
 void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
 void kvm_pmu_set_physical_access(struct kvm_vcpu *vcpu);
+bool kvm_pmu_partition_ready(void);
+void kvm_pmu_partition_enable(struct kvm *kvm, bool enable);
 
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
@@ -327,6 +329,13 @@ static inline void kvm_pmu_host_counters_enable(void) {}
 static inline void kvm_pmu_host_counters_disable(void) {}
 static inline void kvm_pmu_handle_guest_irq(u64 govf) {}
 
+static inline bool kvm_pmu_partition_ready(void)
+{
+	return false;
+}
+
+static inline void kvm_pmu_partition_enable(struct kvm *kvm, bool enable) {}
+
 #endif
 
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1750df5944f6d..d09f272577277 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -20,6 +20,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/psci.h>
+#include <linux/perf/arm_pmu.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -37,6 +38,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_pmu.h>
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_pmu.h>
 #include <asm/kvm_ptrauth.h>
@@ -132,6 +134,16 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_ARM_PARTITION_PMU:
+		if (kvm->created_vcpus) {
+			r = -EBUSY;
+		} else if (!kvm_pmu_partition_ready()) {
+			r = -EPERM;
+		} else {
+			r = 0;
+			kvm_pmu_partition_enable(kvm, cap->args[0]);
+		}
+		break;
 	default:
 		break;
 	}
@@ -388,6 +400,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_supports_guest_pmuv3();
 		break;
+	case KVM_CAP_ARM_PARTITION_PMU:
+		r = kvm_pmu_partition_ready();
+		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
 		r = cpus_have_final_cap(ARM64_HAS_RAS_EXTN);
 		break;
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 2ee99d6d2b6c1..6cfba9caeea0e 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -45,8 +45,8 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
 }
 
 /**
- * kvm_vcpu_pmu_is_partitioned() - Determine if given VCPU has a partitioned PMU
- * @vcpu: Pointer to kvm_vcpu struct
+ * kvm_pmu_is_partitioned() - Determine if given VCPU has a partitioned PMU
+ * @kvm: Pointer to kvm_vcpu struct
  *
  * Determine if given VCPU has a partitioned PMU by extracting that
  * field and passing it to :c:func:`kvm_pmu_is_partitioned`
@@ -56,7 +56,36 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
 {
 	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu) &&
-		false;
+		test_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &vcpu->kvm->arch.flags);
+}
+
+/**
+ * kvm_pmu_partition_ready() - If we can enable/disable partition
+ *
+ * Return: true if allowed, false otherwise.
+ */
+bool kvm_pmu_partition_ready(void)
+{
+	return kvm_pmu_partition_supported() &&
+		kvm_supports_guest_pmuv3() &&
+		armv8pmu_hpmn_max > -1;
+}
+
+/**
+ * kvm_pmu_partition_enable() - Enable/disable partition flag
+ * @kvm: Pointer to vcpu
+ * @enable: Whether to enable or disable
+ *
+ * If we want to enable the partition, the guest is free to grab
+ * hardware by accessing PMU registers. Otherwise, the host maintains
+ * control.
+ */
+void kvm_pmu_partition_enable(struct kvm *kvm, bool enable)
+{
+	if (enable)
+		set_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
+	else
+		clear_bit(KVM_ARCH_FLAG_PARTITION_PMU_ENABLED, &kvm->arch.flags);
 }
 
 /**
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52f6000ab0208..2bb2f234df0e6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -963,6 +963,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
+#define KVM_CAP_ARM_PARTITION_PMU 245
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.52.0.239.gd5f0c6e74e-goog


