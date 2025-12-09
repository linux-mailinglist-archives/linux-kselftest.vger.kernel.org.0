Return-Path: <linux-kselftest+bounces-47313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6789CB1108
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 21:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A4D30C7BD7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8752308F07;
	Tue,  9 Dec 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBD3RLVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6192FFF8F
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313549; cv=none; b=FLDn56Imn3B3fIluJUeIS96FwavqANqzyWZPHItH7wtN5QLvQkG8tmnoPLX/RAPybBzCZk8vN6Y5KjgkC9jr7hLWfxVhbdOuAu0HL85/qIq+qb19Q01uItXFolyrsnZ3zegC+he9oMvIGKuL3Ig/r49R0vIqk0yNblIWtghCDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313549; c=relaxed/simple;
	bh=xhgsH7VuPbYxutqiwHT9/OQJv83re1fwT8FPiWsqnmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEuVspg60coOgGkhOCEOBzFzXqGeM/FeG43AmyQHzLqjxBc51KagAPMmWk9Fcs9YTCv/q3PIflkV9E9bCShHmuYSCrpq8Rb+ehkceSLDX0GTHdVjhxbD+yDvg/uZWJFOEuUdO4LFwSwagDElwQC9oAM+eC2USwk0Y0XUY2bdzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBD3RLVe; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3ed1781e961so2985683fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313546; x=1765918346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nU4SZZiqzmEBDGaqnOKa3zbJ+UV1JK/WP+4z3ISxHr0=;
        b=KBD3RLVek+LlK2TSasBWqd9eXdot5utUHoVJ5SAtx7KHXIx3yReBwOEKzeQFPAt8S4
         X3Ed5PStXYbO9inJmnc5VoJX892VGqWLezlTiLQLpjq+M5hYHJdR729ibJZZmQgVAiMV
         WhoXI9pvIi5CpUNT9WLatL+ebLnFPvoag5vd5+PLxkkby/ypkqINYgUw8YalLZmrMW+U
         92jVhnLwIjxgQ4E4I4M6lya9gylYYvpfWf7BIFAQzOOfCAgJsODCFbsNyYemSvuF8bwd
         y0dQzkmu3sCFm9zkcdOKj7kxdnFOk2Fo2loRXHa/34q3jcVu4XWNmRDyXSNcq7O2baFx
         oCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313546; x=1765918346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nU4SZZiqzmEBDGaqnOKa3zbJ+UV1JK/WP+4z3ISxHr0=;
        b=BFl8xtJIXlldqJxTE9NPX8q0ftJQyYN79GXgh30uo5zC4qOBOg/xhOcBKUagmJdyMK
         v2lAdr/rgrSoAiAcEATksY0zjK/M9FAkUAChV6KqdxnkAHaYqA+qKwhqxV3Ns++6e+zH
         /XnwcM1Nw2cOwIO1F+xaU18z96gxkxCtfwUPhEuLGRWDQhVH+y3KBOu3ZzEXj7D7JYlC
         KwO6mKFHMZCoL1P0GDQbZlfjGa6SFRJiAtiucF3UYY71f3W2bnRxC1owLBQr+ePvq0xC
         zxr7RqtXuODvcQtzryxRWRiiU/H4i9N5HgGQ4x5U/qhc5A+TGiErGNbLgTrvsCikIOcE
         qNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRYk1ipcEzDZxYfpvTrV4XzKeXDEz5Vvtlb6cOVmnTFun9zlgtAu/47mHG6ztJczFf8SYi9Gq1CcEXle28dSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWn9T5r/4vr0+/WtJaQPOMXgCPb8oasStwZbPih8HB4c8VDZ+Z
	rSm9rrc1V7DSIC3goZftvn1ExUGeWQMVMeCnQz/mwAwL9T9rtgTefwLN1OO33XBw69PZvgKf6d9
	Z579zkhKQAXonagil5Gogga0oBw==
X-Google-Smtp-Source: AGHT+IFTAojYGX7mwXtTP/8YDMBz+eRxv1aZJcv87i7iIEe8Y4VXsg/VmkpZtN9aG2jKXs0+7TmzxHPwou8ROcGDdw==
X-Received: from oaqy6-n2.prod.google.com ([2002:a05:6871:2c6:20b0:3f5:4f00:dfbf])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:568e:b0:3e8:3176:a342 with SMTP id 586e51a60fabf-3f5bd88ead1mr170402fac.22.1765313546407;
 Tue, 09 Dec 2025 12:52:26 -0800 (PST)
Date: Tue,  9 Dec 2025 20:50:58 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-2-coltonlewis@google.com>
Subject: [PATCH v5 01/24] arm64: cpufeature: Add cpucap for HPMN0
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

Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
counters reserved for the guest.

This required changing HPMN0 to an UnsignedEnum in tools/sysreg
because otherwise not all the appropriate macros are generated to add
it to arm64_cpu_capabilities_arm64_features.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++++++
 arch/arm64/kvm/sys_regs.c      | 3 ++-
 arch/arm64/tools/cpucaps       | 1 +
 arch/arm64/tools/sysreg        | 6 +++---
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e25b0f84a22da..ceddc55eb30a0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -555,6 +555,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
@@ -2898,6 +2899,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
 	},
+	{
+		.desc = "HPMN0",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_HPMN0,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
+	},
 #ifdef CONFIG_ARM64_SME
 	{
 		.desc = "Scalable Matrix Extension",
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ec3fbe0b8d525..c636840b1f6f9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3214,7 +3214,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    ID_AA64DFR0_EL1_DoubleLock_MASK |
 		    ID_AA64DFR0_EL1_WRPs_MASK |
 		    ID_AA64DFR0_EL1_PMUVer_MASK |
-		    ID_AA64DFR0_EL1_DebugVer_MASK),
+		    ID_AA64DFR0_EL1_DebugVer_MASK |
+		    ID_AA64DFR0_EL1_HPMN0_MASK),
 	ID_SANITISED(ID_AA64DFR1_EL1),
 	ID_UNALLOCATED(5,2),
 	ID_UNALLOCATED(5,3),
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1b32c1232d28d..8efa6a437515d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -41,6 +41,7 @@ HAS_GICV5_LEGACY
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1
+HAS_HPMN0
 HAS_HCX
 HAS_LDAPR
 HAS_LPA2
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 1c6cdf9d54bba..24d20138ea664 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1666,9 +1666,9 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
-Enum	63:60	HPMN0
-	0b0000	UNPREDICTABLE
-	0b0001	DEF
+UnsignedEnum	63:60	HPMN0
+	0b0000	NI
+	0b0001	IMP
 EndEnum
 UnsignedEnum	59:56	ExtTrcBuff
 	0b0000	NI
-- 
2.52.0.239.gd5f0c6e74e-goog


