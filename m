Return-Path: <linux-kselftest+bounces-26073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1624A2D2D2
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E6F16B5A5
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222018B483;
	Sat,  8 Feb 2025 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsHtKx+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72DD154C00
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980089; cv=none; b=lMA+nGE10iAR35vjOV75nINbAL6mpYRfVkWeXw2SsIC9/Wp1qaaJDRT1rLD+oIUSaf++iYy36YPWkPY146k92EgQIBFBiRKptsoP+y6gklpOBjGc9/7QkFJ2hTs2qzOCN9bOu/eg3J21G3tH2gbME7jqC1Q74LmUYQhtIpTVsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980089; c=relaxed/simple;
	bh=LQBYMp4KmUXKjINd8GkhcF2qurugv4q68hUcGJQNnjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhiViZfHhYbbyHSaxRDMjvzDvjZhQTsw4e+BXyYLnUgX9/cYlt658fAJDBsZ1Ckud193Hwqi5rhKEvgpdk25KFA6t/PpOpzPwyGnKCKdXRnOOMG7MtyzEfMNgfVEsk3x8xb0u4hV5bw1umtrwAFnYq4O88XXgyaFkhR6wRifv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsHtKx+W; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-847500c9b9aso503697939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980087; x=1739584887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0ITpSot12bWRIgUxfFL1nJMNuEe3fyU4TCb+rHvco=;
        b=WsHtKx+WDJOKNaUauQa96j4suPxy5k0mhq7/IFflync0k7Bb7Eo13HzPLlkYXNM5rO
         UQC34q6hmhU/y0RifQK8a7n3dh/AFUvjG6SCFTusyZx39xjEKEs9RT6RzcsvxmzI8avy
         ONDg64/PsLTe7Kd5eDeAoXtJWkUE2DM7wQI7Tg7n7AuJ/wc2xWOW5Fppy+optDM+Pnhg
         7YpFTuoE2co5Uge254VNBhJwL6TVDgkrpbOOe2GYp8Ycz9OKuFHDLzDCoTQPouF1REvd
         SD4PvCSRCMJ81sEPCLsMUFni8rZfLTtgmj6OL09w7MGb+w1SSEVT5j+28iEtZMxQzSmG
         h0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980087; x=1739584887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0ITpSot12bWRIgUxfFL1nJMNuEe3fyU4TCb+rHvco=;
        b=IfeT4TNQ2iilHpagCK/5C6mAH6JU8Z23fPfUuRKVxn8LjeaRZvB26YIRweTJqlPORJ
         CrMQSM/UjRLpqXqXW1tU5rqFZtXRSOmHLiLbOEpUntzFw1OqFKyLRhBQz0eHoks5qmck
         UgvMhU6N4Ypw902Pmyhm2ndGMd40EfG5rjv7OlS1HIJbvwiUZ9y3Fl+1QrIbAE8c5mSv
         Vqm6HeoCZqag/GPgQ3BXC2qwQDCh/GuibOL5qhCWRLCamdQuBgkK9bH+clZdWwpA5tBL
         rNY4jUW6YWMXlQGLZ/uaSLD0cotTlBBAMA1B5MZYdPovEkbYjQNDdC5FXzGvwnZrSbuX
         2UzA==
X-Forwarded-Encrypted: i=1; AJvYcCWMERqGYrW4dqRzM+xuoLZpzS4qaAPng3RFsueLfZPUB1v7lWqy4WgAPLcDCjnUCHi3QZ+N8wpnpcOq3ndIUVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1GlLkNQm1EQaAECh74v/L+PxTe9CnuIPfsHvtvkYUXYNpHW6
	rKPbqFGl2XSJ9Wq2bex4mDoe0fREkP99r2u6DDnIuckHzfCV9q2Y6zb3ki+vBEl5V3Wjv/PT/Uv
	YJx36gyA+Z7RvrBxsmJuIag==
X-Google-Smtp-Source: AGHT+IHGzAbpz5Gck/2Rf7WgkWKxzSWHxb28Hylkb71d1eO6uNKmPJkkI+3L+zJwZvOSJQqcK2g9jZxrFbjtaCAz6g==
X-Received: from ilbeh24.prod.google.com ([2002:a05:6e02:4c18:b0:3d0:499b:8e3d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:20c9:b0:3cf:cdb8:78fb with SMTP id e9e14a558f8ab-3d13df0fb5fmr49647775ab.16.1738980086868;
 Fri, 07 Feb 2025 18:01:26 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:11 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-5-coltonlewis@google.com>
Subject: [RFC PATCH v2 4/4] KVM: arm64: Make guests see only counters they can access
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

The ARM architecture specifies that when MDCR_EL2.HPMN is set, EL1 and
EL0, which includes KVM guests, should read that value for PMCR.N.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/debug.c                                  | 3 +--
 arch/arm64/kvm/pmu-emul.c                               | 8 +++++++-
 tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0e4c805e7e89..7c04db00bf6c 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -36,8 +36,7 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
 	 * to disable guest access to the profiling and trace buffers
 	 */
-	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN,
-					 *host_data_ptr(nr_event_counters));
+	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, read_mdcr());
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 6c5950b9ceac..052ce8c721fe 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -993,12 +993,18 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+	u8 limit;
+
+	if (arm_pmu->partitioned)
+		limit = arm_pmu->hpmn - 1;
+	else
+		limit = ARMV8_PMU_MAX_GENERAL_COUNTERS;
 
 	/*
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
 	 */
-	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+	return bitmap_weight(arm_pmu->cntr_mask, limit);
 }
 
 static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index f16b3b27e32e..b5bc18b7528d 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -609,7 +609,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  */
 static void run_error_test(uint64_t pmcr_n)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
 	destroy_vpmu_vm();
-- 
2.48.1.502.g6dc24dfdaf-goog


