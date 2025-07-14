Return-Path: <linux-kselftest+bounces-37307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366FB04B5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8563BDF00
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190AA292910;
	Mon, 14 Jul 2025 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zy20dyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADB28C865
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533989; cv=none; b=N81rnsaO5Fzdqx6Noa8NIWOFWRPRRX5ZOicl4YNth7eaZBXGtuT+BVUy11qw95x+Z/2d94hmO1wm6rlPlyWUd2swmHbbCh0KyxqkH2FxFcI6Ek2jaJfZh6MJhr8WG5rap9P8KcAc8R5TMapluE5TpPmwWvcaPMrOm8BIqFM387k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533989; c=relaxed/simple;
	bh=ncTcOod7yCrp61IU4E/ZxVDp0M1AnUaADW8CBXec3HY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHInu2BNnKgrlhkOlHd6/Eww3baq9r+smSW/D8zksqagkpVJDro3TvV6LlJ33OVR0qap5ubkqaQZFBUtJnnbaqmy/YrENUo8U7irUuIf1Yx3gr6Cc5YzY8Jtj70du9wi/f+BnEAxHq9ZrRaa6o344ogH/qswwxc6YEZX+HCl2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zy20dyl; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso106597485ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533984; x=1753138784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlCY+xVyEz2zjr3F2/cg+ko0FQSJ5xemxrZgto3SvkM=;
        b=2zy20dyljdshDyqGJEUumogjkTtSE9KU8/lqJ/zNPFpG7mpNTJ0Olju8rlfLoyBsA/
         85CfPV0hjXTekfAGr4v0t4dCPHBS74QBrp/RFOOcaqOr9viVRlxUrc3ywJO6s+kRLPbf
         upWKw4Ro5HYgA0RUHTVWZ0dfMC5KooqzzN5USxEIv1MV8/pnlYK23iPHTzQnB9hQ4g6s
         7PRnww2EkZIIexWOuOHMjOLFvTIvlW33rrYZ7UpRRJ8ALvae4ijFteP35hv3RT71K5EP
         Sn6Emi7C259SVR6vTHf/OrVGIk8Me4itWcWqKjx5bajaJSywzZw8PHa/O5cmDU/C0I8H
         voeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533984; x=1753138784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlCY+xVyEz2zjr3F2/cg+ko0FQSJ5xemxrZgto3SvkM=;
        b=L8mlxkjE3pU8izZ7RAEoCzIOgLml9J8KLF55vO90er/qn+fEMRSQXJzY7p3dHPKQhq
         q+rfHOX6IEKekRkyqphJy7QviAnoN/hIWeZtpNtEe45QTpuArz4FJdtbctcU6L3ceLry
         3I0MKQqzUWRWcP0FeGICf7jqY11h4zqKCZ91YPpGTlTEmftFZ31wczjatD7Ni/slk3ok
         4Sqz1ySPWplmZnEkqwcnIOk8QpCId00ijWObJwcKY4aKvrAj5rAHlF+OzF4IOdq1I571
         kvD2k2p5ALpuWZCrJXOP0/oAfCU7CgQivfSuTn3txMrLviQliClRDZjHxFDZbofBeAPj
         OKgw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Bwau8d7udYqzA1GDzu9B9V8hC0Bg5vIZ1OFx8LcpsRzOonIssKVPsuxI3KSFD2idQh+0jM91+0fDp94P8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFlIG510D95G25eLK8XbWHnjZ09EHIuLn8XwtRYi/JQ+gTowob
	Ycxyd0qP3SPJxWY24ToqeZoNPNtxIKJcoFEZ0WPIGxK0SbwmxiKi2nq+ia0Syjt3KMANmIInCMq
	DvMqwc44iih4OE2DkrRL268PREw==
X-Google-Smtp-Source: AGHT+IFGXdkNXkw8CoL88YaoE7byRV8SLefT+pkkqRRylYQFB4bn+wurTk8lSssQNgyaC/vm8Th1YX76JUVCTQT87g==
X-Received: from ilpp15.prod.google.com ([2002:a92:d28f:0:b0:3e2:47cf:3c9a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1582:b0:3df:49fa:7af5 with SMTP id e9e14a558f8ab-3e279250199mr5991275ab.21.1752533984589;
 Mon, 14 Jul 2025 15:59:44 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:08 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-15-coltonlewis@google.com>
Subject: [PATCH v4 14/23] KVM: arm64: Setup MDCR_EL2 to handle a partitioned PMU
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
 arch/arm64/include/asm/kvm_pmu.h | 11 ++++++
 arch/arm64/kvm/debug.c           | 23 ++++++++++---
 arch/arm64/kvm/pmu-direct.c      | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 62c8032a548f..35674879aae0 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -96,6 +96,9 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
 
+u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
+u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
+
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
@@ -158,6 +161,14 @@ static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
+static inline u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 1a7dab333f55..8ae9d141cad4 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -36,15 +36,28 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
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
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 2eef77e8340d..0fac82b152ca 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -136,3 +136,60 @@ void kvm_pmu_host_counters_disable(void)
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
+	u8 nr_cnt = vcpu->kvm->arch.nr_pmu_counters;
+	int hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
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
+	int hpmn_max = vcpu->kvm->arch.arm_pmu->hpmn_max;
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
-- 
2.50.0.727.gbf7dc18ff4-goog


