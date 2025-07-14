Return-Path: <linux-kselftest+bounces-37294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAEB04B28
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 00:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7951690C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC627A12B;
	Mon, 14 Jul 2025 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ko40Dxh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652727876E
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533973; cv=none; b=BDwt5SYK5U/YnnGOFsKKIS6CYiXPNhPeZc0pfZ+89+ByDvi9NW+LpSTIGLLSmOHn31MTUChHy+vuixGJqQDio1xuGp3NpA1AufdBAhcM5i/A7Fj7obC3CjynsQRI4N78g+uuCrshTVQyUI5Qqe+qS5Chqhcu++EUN6Xc/IJLlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533973; c=relaxed/simple;
	bh=9pirQkb0m7N/ZSHonJo+EvQ3meYt9RuTsLbJDifQha4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcPtUSdYccYPGm9EYCjOFhGNBI+O+32ijyv7SWA934AHaE47gXI+XzJmlJyW3ruhXgwNGICLfpOMzRzhqonOs8wlkgJIf1YCWJeyegdIVGIm9Ig6sJ5AUWSzfF/62NoecW52XW8SZb2RtezHiHj5sW5byNZuWJdrot2Dd1q6F/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ko40Dxh+; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-40d04995b67so1198233b6e.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533971; x=1753138771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJXmYeKTGnjqKEud4aRiMq2ofHrNWARe73nlzic5/G8=;
        b=ko40Dxh+Ub++GN7XdlXq381D5rNH0Rl/ZCx5TcPpZN2s2E0mLWALqmj6xlIozfd+55
         kd4DA1i4g4tkjOu1vMDGWMYn2OYfRdMeIUOUHzhnzWYNTVHQsZUUj/aP37JqXsnhMe4c
         7zCc9oi4x1J72KLwQJbjDf8pRgYxVZT0s+eA98fnb/Aq+tafVP4gf++JtOfuRc/3p/jv
         URRVGi9IPuSrRFeMS/7Qm2SdqSeNGg78MaLaZbHGF4RXCg8z1IGNNNtlHD74Ar3l157R
         KMOL0iisWWnwo98IpzSwjkjHz7iWpDCncd/RgJMpdRBmDtFzWe+R2HVOVe8bOirPGpPz
         Z/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533971; x=1753138771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJXmYeKTGnjqKEud4aRiMq2ofHrNWARe73nlzic5/G8=;
        b=Jf2VtojT2YX+YHLWyJxY58LuqlGesCbEWyz9oXOg5g4/cQCPhwAe4VU2RdDIpGQkbP
         equpFnkFHaDmM+uLq/QC34P6cs5KkVhG1TxC7ADj3v1sgCfGTcxceMKbCNtrr34gwlYr
         Zo3Kjn/bBu6gpxwXoWfTwJQnOD0uoI7TCn2ca9SALlrUF6r29/3eiHv6iJagB91PuUys
         +pG939NrVDcgAU/LjvEm9aT4Fjx4sb1XhV7ozcYl3Z/6Gu079mIvYnvAk89OtsfLHs7p
         D4Rmh8x0i+0VqwT7rVYg6g46QsApEYjCxOjDPC8232poXqiVx1hqfWin+iWr5FmMpgme
         BYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6gDohkqrWwkq2aENL2Is7asAbKokRGF4FXvramfmM/igcUEBoXKfxUbHhBYoEmj6tFLKc7yw+z1U3p4BA2yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGMMIvWPWAaHNxU+h1oJAQzDQQE+kHqep1m9G1mtIR287ODu8
	vuktHrWAeyKO97cQtLyNlyjIGXUoMJv3tiUc3oqLjF47fhAIa5ByY/Ip+9S7U6TzSN0t6jFyW7i
	Qe08SkRcJd8IYO4paTtcxZ2TXew==
X-Google-Smtp-Source: AGHT+IFJZaaG0NKL8tBBBDgd5PVrD7hPJMlHTf5CXiCJq4KOEoeUsMaOm4Ndc7OfFJp7bHopehW6o7GpIil6kUfASA==
X-Received: from oibir14.prod.google.com ([2002:a05:6808:6f8e:b0:40c:a463:99a7])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:8859:10b0:415:9306:2e3b with SMTP id 5614622812f47-41593063055mr7134275b6e.23.1752533971422;
 Mon, 14 Jul 2025 15:59:31 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:58:55 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-2-coltonlewis@google.com>
Subject: [PATCH v4 01/23] arm64: cpufeature: Add cpucap for HPMN0
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

Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
counters reserved for the guest.

This required changing HPMN0 to an UnsignedEnum in tools/sysreg
because otherwise not all the appropriate macros are generated to add
it to arm64_cpu_capabilities_arm64_features.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++++++
 arch/arm64/tools/cpucaps       | 1 +
 arch/arm64/tools/sysreg        | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..f38d7b5294ec 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
@@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 10effd4cff6b..5b196ba21629 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -39,6 +39,7 @@ HAS_GIC_CPUIF_SYSREGS
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCR_NV1
+HAS_HPMN0
 HAS_HCX
 HAS_LDAPR
 HAS_LPA2
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..d29742481754 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1531,9 +1531,9 @@ EndEnum
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
2.50.0.727.gbf7dc18ff4-goog


