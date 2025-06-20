Return-Path: <linux-kselftest+bounces-35492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBAAE2567
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94EA67AD7CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F825B303;
	Fri, 20 Jun 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wog8UAfk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97025B69D
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457946; cv=none; b=bW+FaeKvPDKEwTimG9lm1gKoiwUCGcIVBf0vqit0B3Q3antNQ22SHqpqqaEAAQymZEhKNMX+yVQrZdQgUbPNVjRVeiX0A+axcQWGHzcGXFuabwabKBeFN/zNzG4YjznWua1vSqeVyUC4Jc8mNh4Q/0m9bHTH3+fHQld5FWxKb8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457946; c=relaxed/simple;
	bh=pIKenjuivsuNxrfTX5gucCTB8XKdbMKFSXxxmN3Vba4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TgG5058OzxDOgwUxB4hdoRjf9HdzZGd2E6QcDcFKosXJWjuShw7wEOBRLhaOmdAylFzmtWFOS7D92cWvkk1mTq8MQk899W67TpMGhOzILLRmSokuR5YCVss9aPc0OqfLqqxJelipeFh3YY8NTzwL9/lYIVjw3k8RtPq/1pkU564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wog8UAfk; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso30250965ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457942; x=1751062742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlIaNmwKSlc4jhDaObR1hwnxm1Q7OVOS47yjE2eb8lw=;
        b=Wog8UAfkxq3pVmu/3h/QYYY7c8eZpwn1cAHYygUvs8n9+qOTbCsNVOin588M51TePO
         XBLsPOUjv8Py3ncOsJReZn88Pt/rDRt6nnIu2hajfDbQ0gEAUb04su4aXoaxRv8nFOaI
         dKmcm3KVhja/GyidA5SgtrU/hctFXEbPSvbw1QvCrvVGH90fgiJJI5ydsnoVLMgE7yKh
         Ggr/uClek29tL9VPhwLlae1/FMvZkWrmpT4NfijMlGROKl7TP8itPWVuHh+r2/Mx7NFZ
         NJn1eVNpOJdpkNIJ4q3jdwq/Q0KHfMvq+hf6ksbwkZTBJxEO6QKRCOjMHzls/u4MUg6t
         34JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457942; x=1751062742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlIaNmwKSlc4jhDaObR1hwnxm1Q7OVOS47yjE2eb8lw=;
        b=lfeyX1fk5e2xBafjN9os70PiwxlAh8KCnPiNceUtUsmusWdkz1mpfj32JmYPMrvXd/
         FBJ70ADp8/89K2Cf/Yamc7l5Dg4uN0xYY4vi4f8pnTgdrcZnTl8eX6IVl0HmkDr9rcLw
         zSwgvrjjcfe43BEv1200gFyCpJ9PepSq/0BDuBCO0r5pXcT0THGQimJAEVy8obs1c5kC
         5OxoonWjZ5LbsC+QH1NAWspPknr4ZvYTrWOljGNNviR3lSAxblpHNl1JEXSAmTSKyhEi
         IUdngLkTkV00O6ZV5csldn1ljSrH78ORM1SZvlLspw88xTEkPFPhj6B49EGuX9Act+DP
         4k8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/fP2FjkXZt+aen5NbSxM+a43ot14zRGEAacQHFABu63jZb/dKE8Pl8avFUiwzMdR6T95KZ60CUj2jad+8BQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTFnta4SVJpbOLKlrfhQ002b67EyPeRmx8TBtrvzJQPel1L8V
	AuCwWZnZSg7o4sdtV+bF/mSXhe8HGuFoOoo65EcL07VUIMLzr9QcpCFOH5aRwjriHRMStgEvSkn
	a2ArCvf/9ulLBbCJfGzUEaJnUug==
X-Google-Smtp-Source: AGHT+IGCeCVOZ/lzFtZabgEj5uIBvECJLOzYYRnqGjmZi9n0ocVr8mmsA3q0AfByPW+K8EB/QVJMTveOMkHDJeFyrA==
X-Received: from ilbbs5.prod.google.com ([2002:a05:6e02:2405:b0:3dd:ca16:cb9])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:258e:b0:3dd:d338:5c7a with SMTP id e9e14a558f8ab-3de38c1bed9mr54498185ab.4.1750457942046;
 Fri, 20 Jun 2025 15:19:02 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:24 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-25-coltonlewis@google.com>
Subject: [PATCH v2 22/23] KVM: arm64: Add ioctl to partition the PMU when supported
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

Add KVM_ARM_PMU_PARTITION to enable the partitioned PMU for a given
vCPU. Add a corresponding KVM_CAP_ARM_PMU_PARTITION to check for this
ability. This capability is allowed on an initialized vCPU where PMUv3
and VHE are supported.

However, because the underlying ability relies on the driver being
passed some command line arguments to configure the hardware partition
at boot, enabling the partitioned PMU will not be allowed without the
underlying driver configuration even though the capability exists.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 Documentation/virt/kvm/api.rst    | 21 +++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/arm.c              | 20 ++++++++++++++++++++
 arch/arm64/kvm/pmu-part.c         |  3 ++-
 include/uapi/linux/kvm.h          |  4 ++++
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4ef3d8482000..7e76f7c87598 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6478,6 +6478,27 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_ARM_PARTITION_PMU
+---------------------------
+
+:Capability: KVM_CAP_ARM_PARTITION_PMU
+:Architectures: arm64
+:Type: vcpu ioctl
+:Parameters: arg[0] is a boolean to enable the partitioned PMU
+
+This API controls the PMU implementation used for VMs. The capability
+is only available if the host PMUv3 driver was configured for
+partitioning via the module parameters `arm-pmuv3.partition_pmu=y` and
+`arm-pmuv3.reserved_guest_counters=[0-$NR_COUNTERS]`. When enabled,
+VMs are configured to have direct hardware access to the most
+frequently used registers for the counters configured by the
+aforementioned module parameters, bypassing the KVM traps in the
+standard emulated PMU implementation and reducing overhead of any
+guest software that uses PMU capabilities such as `perf`.
+
+If the host driver was configured for partitioning but the partitioned
+PMU is disabled through this interface, the VM will use the legacy PMU
+that shares the host partition.
 
 .. _kvm_run:
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 374771557d2c..0ef7ebb68d17 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -369,6 +369,9 @@ struct kvm_arch {
 	/* Maximum number of counters for the guest */
 	u8 nr_pmu_counters;
 
+	/* Whether this guest uses the partitioned PMU */
+	bool partitioned_pmu_enable;
+
 	/* Iterator for idreg debugfs */
 	u8	idreg_debugfs_iter;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7c007ee44ecb..97c320ed07c1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -21,6 +21,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/psci.h>
+#include <linux/perf/arm_pmu.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -38,6 +39,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_pmu.h>
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_pmu.h>
 #include <asm/kvm_ptrauth.h>
@@ -383,6 +385,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_supports_guest_pmuv3();
 		break;
+	case KVM_CAP_ARM_PARTITION_PMU:
+		r = kvm_supports_guest_pmuv3() && has_vhe();
+		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
 		r = cpus_have_final_cap(ARM64_HAS_RAS_EXTN);
 		break;
@@ -1810,6 +1815,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_PARTITION_PMU: {
+		bool enable;
+
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			return -ENOEXEC;
+
+		if (!kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu))
+			return -EPERM;
+
+		if (copy_from_user(&enable, argp, sizeof(enable)))
+			return -EFAULT;
+
+		vcpu->kvm->arch.partitioned_pmu_enable = enable;
+		return 0;
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 2c347e7a26d8..2388590f4843 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -38,7 +38,8 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
  */
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
 {
-	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu);
+	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu)
+		&& vcpu->kvm->arch.partitioned_pmu_enable;
 }
 
 /**
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c74cf8f73337..2f8a8d4cfe3c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -935,6 +935,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_GMEM_SHARED_MEM 243
+#define KVM_CAP_ARM_PARTITION_PMU 244
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1413,6 +1414,9 @@ struct kvm_enc_region {
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
+/* Available with KVM_CAP_ARM_PARTITION_PMU */
+#define KVM_ARM_PARTITION_PMU	_IOWR(KVMIO, 0xce, bool)
+
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
-- 
2.50.0.714.g196bf9f422-goog


