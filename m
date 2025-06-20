Return-Path: <linux-kselftest+bounces-35485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5980AE2544
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0577616E21B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454A259CA8;
	Fri, 20 Jun 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzNUkUeq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920552561DD
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457938; cv=none; b=S/LtVVubZ7x2qYWvWrd68aWf/1Nlv1Dd/sGBKO22at9XegxcC0Vc5Vi8H+LAINNvl2cYoAdZw5vkRZ17eTuuqSRX1NWD7ilYapTH//Tyt5/2BfX8Hbuvsv7+BzNJAxHGauu1vkFMWhYaqAQYHpPpCnTip6P/TWeNku7eqRvH2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457938; c=relaxed/simple;
	bh=V8F6QXbKZ5qjKUOB8cB6Qj1Bq4o1xFCNUWAnMMd+Y5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhovPLW+k41miFOYyGYOPfv693hNMjV5AHiY303UE9KhgNpuobPjTytud4dUBvadAHaGxTzdJge6rScK09MDosSdlUHyBX3jRyGdxSmD96gf+QLlDfI7IwSsQQRDRi3I9CUfK6hK4kIBx8RHa/XO4rmqUADS8rJ+JRol2G7DEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzNUkUeq; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso180717539f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457934; x=1751062734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZyFqXYBMWnJqAFxJ0Fisis6DfGC/d8Ag5of3Smukjk=;
        b=WzNUkUeqARsMtJDYI8pU53xrnKrtAmWGGes7HeuZALE1YQZqlvuxX3qbAhG8y0bRIO
         qS2K41eYvKN0h/Y2mfoS0j9YTudGZe8xDnWf6nz7BzhCDi+ntPkV1CPyVSwu/35IFV0t
         co7wBA5AlY1SWM5HrSv+5C1Uel64Mjg63Qykr18rrcNVbwIQo6q9pV9qCupg7f1jWHrv
         qDm1BoaYUdkRA+xuehQt3DZ554GHkZmmurvq75kDUxv8Xqsdg0JfUOOhv8tXNaCV7jB4
         QD2NrayP4z617GKLQzpSjlfY8fVAuRoIebfbArZfPkp/DZuVLA1Y91VcSA+0zgyzUSlz
         RcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457934; x=1751062734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZyFqXYBMWnJqAFxJ0Fisis6DfGC/d8Ag5of3Smukjk=;
        b=A03jZTaVZFJXX+Ic6jifvTbN3cx7KnonjLnoikQ2H0u1T38k4tmKAUQGo4C0C9AkNj
         yTk1kgkUE9qilr060HgtWRQNHvUv1WkpjT+nYdVKsjyYYO1eLbts6Xr7QRTGZXAgz/6/
         HbCbH9XBVM1POU3opIc6zPdnMTA6sSM+HO89W7V1ruI1t3qRhyXxOb46V2i32JZjXoTE
         Fp/1WkvUA24sbD3TsTih4slxuKSgj3y5tfYvCuZDpCGwDoNkV3ObOQOaYaMaWeO82bo0
         foNqD4vHzALKt8TMoePwirL25PU78WsPyL1U8oImxW0vB9iJMSjbpjQFBGxqdM/q29Qm
         adLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUl3z8wQWLMiOXzSF38LAJyywLZOWg0tdrk6GId0Jy3hVxSWG1OUZthWdb+/VLQdvovEOIoTppzjJXXNjm8Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjruCFI/7xt1qwOoUpNhPKf2PvsOl6P4LnUAwbGvWXc7KbJGa
	URrPpEzyu+3y/Zy7m7JfQ6i6A5b53NqH3t5MpQfLnPijZ0UWuR21qOV42dwhwQ7xHP7xUPyDcWa
	iNFOJKyQuPRhDrIPi1hq2UlLKpQ==
X-Google-Smtp-Source: AGHT+IHH9vAF0PeeIga9bJPbVv5gkEIZ1wU4Ll5A3y00fis/xcMt2D7wL+QOVfQw74a3+dOyehd4c5Bz0GZvUuruOg==
X-Received: from ilbdd7.prod.google.com ([2002:a05:6e02:3d87:b0:3dc:a0cf:cd86])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:178e:b0:3dd:b4f4:2bcc with SMTP id e9e14a558f8ab-3de38c986b2mr44226395ab.13.1750457934106;
 Fri, 20 Jun 2025 15:18:54 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:17 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-18-coltonlewis@google.com>
Subject: [PATCH v2 16/23] KVM: arm64: Setup MDCR_EL2 to handle a partitioned PMU
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

Setup MDCR_EL2 to handle a partitioned PMU. That means calculate an
appropriate value for HPMN instead of the maximum setting the host
allows (which implies no partition) so hardware enforces that a guest
will only see the counters in the guest partition.

With HPMN set, we can now leave the TPM and TPMCR bits unset unless
FGT is not available, in which case we need to fall back to that.

Also, if available, set the filtering bits HPMD and HCCD to be extra
sure nothing counts at EL2.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_pmu.h |  3 ++
 arch/arm64/kvm/debug.c           | 23 ++++++++++---
 arch/arm64/kvm/pmu-part.c        | 57 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/pmu.c             |  2 +-
 4 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 4e205327b94e..1b68f1a706d1 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -94,6 +94,9 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
 
+u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
+u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
+
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index a554c3e368dc..b420fec3c754 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -37,15 +37,28 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
-	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
-				MDCR_EL2_TPMS |
-				MDCR_EL2_TTRF |
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, kvm_pmu_hpmn(vcpu));
+	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TTRF |
 				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
+	if (kvm_vcpu_pmu_is_partitioned(vcpu)
+	    && is_pmuv3p1(read_pmuver())) {
+		/*
+		 * Filtering these should be redundant because we trap
+		 * all the TYPER and FILTR registers anyway and ensure
+		 * they filter EL2, but set the bits if they are here.
+		 */
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_HPMD;
+
+		if (is_pmuv3p5(read_pmuver()))
+			vcpu->arch.mdcr_el2 |= MDCR_EL2_HCCD;
+	}
+
+	if (!kvm_vcpu_pmu_use_fgt(vcpu))
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 269397a1fcbc..289f396bd887 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -118,3 +118,60 @@ void kvm_pmu_host_counters_disable(void)
 	mdcr &= ~MDCR_EL2_HPME;
 	write_sysreg(mdcr, mdcr_el2);
 }
+
+/**
+ * kvm_pmu_guest_num_counters() - Number of counters to show to guest
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Calculate the number of counters to show to the guest via
+ * PMCR_EL0.N, making sure to respect the maximum the host allows,
+ * which is hpmn_max if partitioned and host_max otherwise.
+ *
+ * Return: Valid value for PMCR_EL0.N
+ */
+u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
+{
+	u8 hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
+	u8 nr_cnt = vcpu->kvm->arch.nr_pmu_counters;
+	u8 host_max = *host_data_ptr(nr_event_counters);
+
+	if (kvm_vcpu_pmu_is_partitioned(vcpu)) {
+		if (nr_cnt <= hpmn_max && nr_cnt <= host_max)
+			return nr_cnt;
+		if (hpmn_max <= host_max)
+			return hpmn_max;
+	}
+
+	if (nr_cnt <= host_max)
+		return nr_cnt;
+
+	return host_max;
+}
+
+/**
+ * kvm_pmu_hpmn() - Calculate HPMN field value
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Calculate the appropriate value to set for MDCR_EL2.HPMN, ensuring
+ * it always stays below the number of counters on the current CPU and
+ * above 0 unless the CPU has FEAT_HPMN0.
+ *
+ * This function works whether or not the PMU is partitioned.
+ *
+ * Return: A valid HPMN value
+ */
+u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
+{
+	u8 hpmn = kvm_pmu_guest_num_counters(vcpu);
+	u8 hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
+	u8 host_max = *host_data_ptr(nr_event_counters);
+
+	if (hpmn == 0 && !cpus_have_final_cap(ARM64_HAS_HPMN0)) {
+		if (kvm_vcpu_pmu_is_partitioned(vcpu))
+			return hpmn_max;
+		else
+			return host_max;
+	}
+
+	return hpmn;
+}
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 67216451b8ce..90fc088ce3d3 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -884,7 +884,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 n = kvm_pmu_hpmn(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
-- 
2.50.0.714.g196bf9f422-goog


