Return-Path: <linux-kselftest+bounces-38131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5951B17801
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EFE7B4ABE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13D26B751;
	Thu, 31 Jul 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEsAu4M5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2E26772C
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996813; cv=none; b=JVAnL/dFUeWFO8P1B7GT5yS2GRhHnTwavpiu0PYLBB4yVOy1J07YZDlFr/jmoM01dIQd4imT6j53Fs/d1b8Kwu0t2y9PX2c3HDkWGxcXKgmd+/Gp1gdhP+NHaPYu2/t077uaC6U0KwKLJYuD9IFNIN/OuYixfrMPyffrXeaywO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996813; c=relaxed/simple;
	bh=dJVDrY2Q27cbe5f5g3SYdbXAcrRsKTJJQXMYy7GKzQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ItxApbF3Krt3B1+ov4YxJxHg49+aNBauYtMBcbgwMX7zJDFtrczPp/zlwSSsQsKBIbfxY8DDpkxi/pAyHJ9uAFmKB3VbCHgCS37ATA7MKcPJRvSX7DU4PHsCsZpf2ULdn5Qi87731prGGrlgCq06diOW9IPUTbrjr4aZLrcmXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEsAu4M5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748d96b974cso1455258b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753996811; x=1754601611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfN0X/J7aY6DiirxT38OFrBMfsvwR0ADYttc8vi2o/w=;
        b=qEsAu4M53pfQbmf8l8ND9akGipU+mbxKRvKIwkHD4S+xVoRO7e6mh3WNBZydntHWC3
         NYKNy+2kybPZgd3nNrx8z1xBOJfG2vWgXF7XMILfUvTtLiKl5Ny0XLKX9TPYoceA7Aux
         OFn/u+TorCB1jGy7Aw8ilV/3vGngleOTvBmvsPFdPxptxq34H2yqz1gbPs3wDNOT/N2g
         3wiaBJvDhNZYwxcjl33f5cedlhgLlU23R+qBYFw/W2YWFasI6jZUF/lBghuC9954lMiS
         0nN+gFJ3E0QWei8oTIkl8UGngPgkjDoomWO/ugOo8yzhJj9Zx8qK86rMGHuXvxT1EgZz
         ng7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996811; x=1754601611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfN0X/J7aY6DiirxT38OFrBMfsvwR0ADYttc8vi2o/w=;
        b=JBmXaKLP74oNMYg1GoiQGW0MbHm/fh2CVPzSuqJ7PwcRGXCr3db7Od/KuppMUyvEfq
         e5oanjrwnkQN6c+cTPIcrGCSHcgwMvBTDHrYOkER9l6QAjUs6Vtx+8xHramwjobetZzV
         51klEuohqavQ8pjduNMnONWajFIdztrT4Hq0l58IyxgufEw0UPDvTGPCW4AOALctvLl9
         V2O9eO79CRIvnunsbquTE5YIuiyRPg4th3mpnW0Rww0Xv1t09Z1dtX3hYIJ9dZBBDygw
         3mIaljfCnzohTZKYrZSZQaOOPUbPZEgo9AKxUW6K5yrzu9kudZXKIVdb4yR0lZwPooRb
         gLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUHs0fNqXTjaHHlsU0DRmtWms556Z1owfp9+MrcPmXp6yGhQUcxyEvFkhmjUOZrYKNDeMz9nzzmS2bXqXiMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/md5NFgnR+o+KiItpFo4o6aOA+XmF7HkWIzZm2AyAeTW+i9hg
	PGfbcayjUcXJlEmNlwiVGInUcgOY8AbketjG96GWGJq5/WYfpMt2n4PONeBZsDkf7qqkmPLAqT6
	pAxQmy+AKKjbAFw==
X-Google-Smtp-Source: AGHT+IHVVaQAfCFFm1bPrkaJhpqvslSH1iN5k/qBiJ3rAPVRomlZwHVUqIVCdbZGo4iuoUkgmEPN1dvhXNml8w==
X-Received: from pgdp10.prod.google.com ([2002:a63:950a:0:b0:b42:1c9c:5627])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210e:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-23dc0d3e16amr14712811637.10.1753996810898;
 Thu, 31 Jul 2025 14:20:10 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:20:02 +0000
In-Reply-To: <20250731212004.1437336-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731212004.1437336-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731212004.1437336-3-jiaqiyan@google.com>
Subject: [PATCH v1 2/4] KVM: arm64: Allow userspace to supply ESR when
 injecting SEA
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rananta@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

When VMM needs to replay a synchronous external abort (SEA) into
guest, it may want to emulate ESR_ELx.ISS and ESR_ELx.ISS2.

Extend the KVM_SET_VCPU_EVENTS ioctl to allow userspace to supply
ESR_ELx when injecting SEA into the guest, similar to what userspace can
do when injecting SError.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  9 ++++++--
 arch/arm64/include/uapi/asm/kvm.h    |  6 ++++--
 arch/arm64/kvm/emulate-nested.c      |  6 +++---
 arch/arm64/kvm/guest.c               | 31 +++++++++++++++++-----------
 arch/arm64/kvm/inject_fault.c        | 16 +++++++-------
 5 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index fa8a08a1ccd5c..80315d21cda13 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -46,9 +46,14 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
-int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
+int kvm_inject_sea_esr(struct kvm_vcpu *vcpu, bool iabt, u64 addr, u64 esr);
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
 
+static inline int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+{
+	return kvm_inject_sea_esr(vcpu, iabt, addr, 0);
+}
+
 static inline int kvm_inject_sea_dabt(struct kvm_vcpu *vcpu, u64 addr)
 {
 	return kvm_inject_sea(vcpu, false, addr);
@@ -76,7 +81,7 @@ void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
 void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu);
 int kvm_inject_nested_sync(struct kvm_vcpu *vcpu, u64 esr_el2);
 int kvm_inject_nested_irq(struct kvm_vcpu *vcpu);
-int kvm_inject_nested_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
+int kvm_inject_nested_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr, u64 esr);
 int kvm_inject_nested_serror(struct kvm_vcpu *vcpu, u64 esr);
 
 static inline void kvm_inject_nested_sve_trap(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 643e8c4825451..406d6e67df822 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -185,11 +185,13 @@ struct kvm_vcpu_events {
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
 		__u8 ext_iabt_pending;
+		__u8 ext_abt_has_esr;
 		/* Align it to 8 bytes */
-		__u8 pad[4];
+		__u8 pad[3];
 		__u64 serror_esr;
+		__u64 ext_abt_esr;
 	} exception;
-	__u32 reserved[12];
+	__u32 reserved[10];
 };
 
 struct kvm_arm_copy_mte_tags {
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 90cb4b7ae0ff7..fa5e7fc701bfb 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2827,10 +2827,10 @@ int kvm_inject_nested_irq(struct kvm_vcpu *vcpu)
 	return kvm_inject_nested(vcpu, 0, except_type_irq);
 }
 
-int kvm_inject_nested_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+int kvm_inject_nested_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr, u64 esr)
 {
-	u64 esr = FIELD_PREP(ESR_ELx_EC_MASK,
-			     iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW);
+	esr |= FIELD_PREP(ESR_ELx_EC_MASK,
+			  iabt ? ESR_ELx_EC_IABT_LOW : ESR_ELx_EC_DABT_LOW);
 	esr |= ESR_ELx_FSC_EXTABT | ESR_ELx_IL;
 
 	vcpu_write_sys_reg(vcpu, FAR_EL2, addr);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index d3c7b5015f20e..018bf0d5277ec 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -847,27 +847,40 @@ static void commit_pending_events(struct kvm_vcpu *vcpu)
 	kvm_call_hyp(__kvm_adjust_pc, vcpu);
 }
 
+#define ESR_EXCLUDE_ISS(name) ((name##_has_esr) && ((name##_esr) & ~ESR_ELx_ISS_MASK))
+
 int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 			      struct kvm_vcpu_events *events)
 {
 	bool serror_pending = events->exception.serror_pending;
-	bool has_esr = events->exception.serror_has_esr;
+	bool serror_has_esr = events->exception.serror_has_esr;
 	bool ext_dabt_pending = events->exception.ext_dabt_pending;
 	bool ext_iabt_pending = events->exception.ext_iabt_pending;
-	u64 esr = events->exception.serror_esr;
+	bool ext_abt_has_esr = events->exception.ext_abt_has_esr;
+	u64 serror_esr = events->exception.serror_esr;
+	u64 ext_abt_esr = events->exception.ext_abt_esr;
 	int ret = 0;
 
+	if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN) &&
+	    (serror_has_esr || ext_abt_has_esr))
+		return -EINVAL;
+
+	if (ESR_EXCLUDE_ISS(serror) || ESR_EXCLUDE_ISS(ext_abt))
+		return -EINVAL;
+
 	/* DABT and IABT cannot happen at the same time. */
 	if (ext_dabt_pending && ext_iabt_pending)
 		return -EINVAL;
+
 	/*
 	 * Immediately commit the pending SEA to the vCPU's architectural
 	 * state which is necessary since we do not return a pending SEA
 	 * to userspace via KVM_GET_VCPU_EVENTS.
 	 */
 	if (ext_dabt_pending || ext_iabt_pending) {
-		ret = kvm_inject_sea(vcpu, ext_iabt_pending,
-				     kvm_vcpu_get_hfar(vcpu));
+		ret = kvm_inject_sea_esr(vcpu, ext_iabt_pending,
+					 kvm_vcpu_get_hfar(vcpu),
+					 ext_abt_has_esr ? ext_abt_esr : 0);
 		commit_pending_events(vcpu);
 	}
 
@@ -877,14 +890,8 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	if (!serror_pending)
 		return 0;
 
-	if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN) && has_esr)
-		return -EINVAL;
-
-	if (has_esr && (esr & ~ESR_ELx_ISS_MASK))
-		return -EINVAL;
-
-	if (has_esr)
-		ret = kvm_inject_serror_esr(vcpu, esr);
+	if (serror_has_esr)
+		ret = kvm_inject_serror_esr(vcpu, serror_esr);
 	else
 		ret = kvm_inject_serror(vcpu);
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 6745f38b64f9c..410b2d6f6ae4c 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -102,11 +102,11 @@ static bool effective_sctlr2_nmea(struct kvm_vcpu *vcpu)
 	return __effective_sctlr2_bit(vcpu, SCTLR2_EL1_NMEA_SHIFT);
 }
 
-static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
+static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt,
+			 unsigned long addr, u64 esr)
 {
 	unsigned long cpsr = *vcpu_cpsr(vcpu);
 	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
-	u64 esr = 0;
 
 	/* This delight is brought to you by FEAT_DoubleFault2. */
 	if (effective_sctlr2_ease(vcpu))
@@ -199,12 +199,12 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 	vcpu_write_sys_reg(vcpu, far, FAR_EL1);
 }
 
-static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+static void __kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr, u64 esr)
 {
 	if (vcpu_el1_is_32bit(vcpu))
 		inject_abt32(vcpu, iabt, addr);
 	else
-		inject_abt64(vcpu, iabt, addr);
+		inject_abt64(vcpu, iabt, addr, esr);
 }
 
 static bool kvm_sea_target_is_el2(struct kvm_vcpu *vcpu)
@@ -219,14 +219,14 @@ static bool kvm_sea_target_is_el2(struct kvm_vcpu *vcpu)
 	       (__vcpu_sys_reg(vcpu, HCRX_EL2) & HCRX_EL2_TMEA);
 }
 
-int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+int kvm_inject_sea_esr(struct kvm_vcpu *vcpu, bool iabt, u64 addr, u64 esr)
 {
 	lockdep_assert_held(&vcpu->mutex);
 
 	if (is_nested_ctxt(vcpu) && kvm_sea_target_is_el2(vcpu))
-		return kvm_inject_nested_sea(vcpu, iabt, addr);
+		return kvm_inject_nested_sea(vcpu, iabt, addr, esr);
 
-	__kvm_inject_sea(vcpu, iabt, addr);
+	__kvm_inject_sea(vcpu, iabt, addr, esr);
 	return 1;
 }
 
@@ -237,7 +237,7 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
 	addr  = kvm_vcpu_get_fault_ipa(vcpu);
 	addr |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
 
-	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr);
+	__kvm_inject_sea(vcpu, kvm_vcpu_trap_is_iabt(vcpu), addr, 0);
 
 	/*
 	 * If AArch64 or LPAE, set FSC to 0 to indicate an Address
-- 
2.50.1.565.gc32cd1483b-goog


