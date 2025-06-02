Return-Path: <linux-kselftest+bounces-34170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BEBACBBBF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C106A189482C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D871238C35;
	Mon,  2 Jun 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKc6IavZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA8230BEF
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892561; cv=none; b=sFBo/4K+gvgIwm26jy15dFbo6jG0nJFBCv0jCX0WuBtMWWmTgcWS4FLBZP03pJleaxV7fq60jkgaL5UQqTmstWL1fg0/gl0S8yRcbuHhQRW792JnF+cyKfznIKRyVBhhEee7hOtHSav4tLnoWGkvxFk5ifuaCsURPaYrROvfgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892561; c=relaxed/simple;
	bh=CcnjBedU7/MUCvahUwrHCirXtUmsFSqeBjbuRsRRORA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HgGqJ3TG0rehIlw1jG6fJpQ5sBwcjpV91O01qc4V9fSx2RQ/CTHv+0D/L1dOIgRjHahgSgsGITjaZQlYd9ouG+vCE3dS3NBRaET4tnQMRUWcyqhiCLuX0xN0DJusNv88Z8RMUdSMBuTgQsLzToB4MPZtZvwENHMM7MUH3z8Fyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKc6IavZ; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so225247339f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892554; x=1749497354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcghHp9NHNnZagjNBq90Et1fDsToCSyQRDmWBaP4jq8=;
        b=MKc6IavZyZ2vCc0m8Mw8KUOTyONnpML2pmjdMq/OJy11tOD5BHZsiprQ4ngenZ+gYD
         Q3kwzYd1bkGrGF8FOtaCTv/fDD6ul62nL8meketehgh8X0RePczxOiVPfI9Ft7KKAl33
         InFFtijp5G10n/PhoxkMDIRHO+jxGs8w3utD9iCelYdFk5KLixML5uQcgfW55x73OmiK
         P4Rup1h6DzjoqHgXLQoNsgYnIW6EjW09iolUgwPDEr5xtR5qqYutn42Q2Om3fLuBUm0r
         Fb6e+Tt01bv/mT6qY9jbUnRX3LQd10rX9YUJZZ0O7dGVej3aHn8PQL+UabP023czWAiM
         5Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892554; x=1749497354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcghHp9NHNnZagjNBq90Et1fDsToCSyQRDmWBaP4jq8=;
        b=MyyogaDf5lBio3/ddy7VRCSVPg3cp8gc0A3t4ES99uO5A6gkbHCk/isoyeb77ASruT
         UlcBXLN2D8NPxoFR2Ch/Zl9Vkrzd+Y5mrEbh4EF5dCB5hgZTesGLNbZQJECDObtoXpaV
         xiz1Q5nKcl5ShELh50Mp1NMR3haZ6ebTSKZJ7RM1XJw0CG4qEe4OA98MN7jl8xEs5mHS
         pdqYbdCoWNSVkT1fIwkM5ITQ1hSWtES1eHdBojNK8OAGmG7c6168C1OgURmCQ7R+XFqq
         C6plNP7GNKeeG9Xl9g7XNTHybwdGoRlRwndGIFm/g8I9RP0ZLbiAwSSFkQBJfqu61Fet
         cAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdLA3j+hJRbil+3eCPNjnZrPn2OmusuQSxLp1zKkPBH5tGDQ8kZlyWwC8w4kABnOjXfDiYNU4qGLLsXPiBdi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXuKZGbZoWHmHKCUzuydnME6PCDphWOlCurB3ct4HRncqFZtT
	Bh1TDmtcN7RPRoI+d0opGCagPtFppeJVe+FRQ6PIQnOH6wZYX2dboPqRue0VGe6x/pvqltBAX7h
	XHNMn5epJ/5lNsuVa1AyrSnGDMQ==
X-Google-Smtp-Source: AGHT+IEnhHZikzLqY9Iyw+UlUAPLFo203H/gjCIqwNlpl0+DZeuWgmgKIGVnEnC2cAT2atcfhzVzUE50F2kqc2B8Og==
X-Received: from ilah6.prod.google.com ([2002:a05:6e02:1d86:b0:3dd:a262:4f8c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:b21:b0:3dc:7bc9:503e with SMTP id e9e14a558f8ab-3dd9c989ce3mr159545185ab.2.1748892554217;
 Mon, 02 Jun 2025 12:29:14 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:27:01 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-17-coltonlewis@google.com>
Subject: [PATCH 16/17] KVM: arm64: Add ioctl to partition the PMU when supported
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

Add KVM_ARM_PMU_PARTITION to partition the PMU for a given vCPU with a
specified number of reserved host counters. Add a corresponding
KVM_CAP_ARM_PMU_PARTITION to check for this ability.

This capability is allowed on an initialized vCPU where PMUv3, VHE,
and FGT are supported.

If the ioctl is never called, partitioning will fall back on kernel
command line kvm.reserved_host_counters as before.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 Documentation/virt/kvm/api.rst | 16 ++++++++++++++++
 arch/arm64/kvm/arm.c           | 21 +++++++++++++++++++++
 include/uapi/linux/kvm.h       |  4 ++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index fe3d6b5d2acc..88b851cb6f66 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6464,6 +6464,22 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_ARM_PARTITION_PMU
+---------------------------
+
+:Capability: KVM_CAP_ARM_PMU_PARTITION
+:Architectures: arm64
+:Type: vcpu ioctl
+:Parameters: arg[0] is the number of counters to reserve for the host
+
+This API controls the ability to partition the PMU counters into two
+sets, one set reserved for the host and one set reserved for the
+guest. When partitoned, KVM will allow the guest direct hardware
+access to the most commonly used PMU capabilities for those counters,
+bypassing the KVM traps in the standard emulated PMU implementation
+and reducing the overhead of any guest software that uses PMU
+capabilities such as `perf`. The host PMU driver will not access any
+of the counters or bits reserved for the guest.
 
 .. _kvm_run:
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4a1cc7b72295..1c44160d3b2d 100644
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
 #include <asm/kvm_ptrauth.h>
 #include <asm/sections.h>
@@ -382,6 +384,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_supports_guest_pmuv3();
 		break;
+	case KVM_CAP_ARM_PARTITION_PMU:
+		r = kvm_pmu_partition_supported();
+		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
 		r = cpus_have_final_cap(ARM64_HAS_RAS_EXTN);
 		break;
@@ -1809,6 +1814,22 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_PARTITION_PMU: {
+		struct arm_pmu *pmu;
+		u8 host_counters;
+
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			return -ENOEXEC;
+
+		if (!kvm_pmu_partition_supported())
+			return -EPERM;
+
+		if (copy_from_user(&host_counters, argp, sizeof(host_counters)))
+			return -EFAULT;
+
+		pmu = vcpu->kvm->arch.arm_pmu;
+		return kvm_pmu_partition(pmu, host_counters);
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c9d4a908976e..f7387c0696d5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,6 +932,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
+#define KVM_CAP_ARM_PARTITION_PMU 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1410,6 +1411,9 @@ struct kvm_enc_region {
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
+/* Available with KVM_CAP_ARM_PARTITION_PMU */
+#define KVM_ARM_PARTITION_PMU	_IOWR(KVMIO, 0xce, u8)
+
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
-- 
2.49.0.1204.g71687c7c1d-goog


