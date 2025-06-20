Return-Path: <linux-kselftest+bounces-35469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D458AE24F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA395A2740
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8523E354;
	Fri, 20 Jun 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvy23RWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAC23ABB6
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457919; cv=none; b=FXnY0p1cRCbgvaLk1+ZPKLgtObeqOfDtzppB9lBhgbLuMpPGzeEc55A2r4IAcMaCJpb/gKNENm7aEYa/QCzgcuyNYl36CEvZAFzeICKcaELwOqbYQ/D2EwpQBOIjEhrMIKMq6exdgfz/y1qkHPRDcbV8R6i9I0FwqHFIIK2ZUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457919; c=relaxed/simple;
	bh=/MLHiy+d8eVTeEEbOWcTciIGqCC3NZq1YQ/d7snJV4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYECYovgsFVDwFvnY1nHgwXii8TIJ0F1nrfseZWoVnOt+U1p9Bb4bfiMeJ8MUCBaftSLOEsFKl0oi24eIYY5MAyhZPWcCtq4087D1P1rfSpu7fwVWsO6bBSDbOFhy3Fu9pW0MS1zFL02AcF/CnT8HgOnuP+6D19MeSUMjbR87Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvy23RWg; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so18052705ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457916; x=1751062716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycwbhAp7Zd2F37ixHvuXJ2dafaPBGypIo/idKjOgZXE=;
        b=hvy23RWg0l9nDJm7oXpJNWqrcRPsJWwprMxgxMa22gumuzb3UTXQkV2YujP147UVui
         n8B5tZlqMm+evPPaKpeD0ApFTnOsA1EkAyCzZ3WV179OCVBOVwaU+PdMboKqogzKcqun
         eRkvCg6UNXieWQCBnM/02PT6MimW1Rlu9zL5+oUYmpOUc7BQAgx6XA22IPIYuIjcCfX+
         SppjY8TU93GQspmaeUVCet96jqvQa1okSINfG8NyQ7jN4ntFlYoQonVXjHAFBES+no33
         tYU+4ohF9Tv8Ik2qZN1AmJ8Jg28MDo3Igz1kFkQX8dmmOAy6kQynKg+x3XLLovSFyhwc
         bINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457916; x=1751062716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycwbhAp7Zd2F37ixHvuXJ2dafaPBGypIo/idKjOgZXE=;
        b=kz1Ep79ve7roVFfmbhj90LDjB+hplVWQ5VGH2AGcfq9XxQTWD4uvX5vRQ2fUtxgfes
         9LFmtUqR52R7eAthoh+wiWBIwoovx2kceJdPdtDZ8bQidbdRisTekClkcZks/Efyui6q
         kQTw2Gae7ecQvglgwPM/CV1nl4n1HDns5Q3xfFBu+PvgBxdu3EnUbXpltwWtCs0QmjkJ
         Tcag/+fSecZ7PKUJofyNiKutjQ3qbli3jpIIYCfBc1058NB7VMwAj1IJzXdFQxFWPz+J
         qL3uI1QV5zb8N68vu+AQPOSRjyfKaDxIQpdYP0NdR93YTugG5eJzxPupkqxN5COn3pA8
         QXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKq00NKMyEJe6+l6JeLwxKwr/7tjUJ2EdQoAYlfqkYZ+at0CobBSDBRR5BH1V81rUch89piu7+kvUtcGPUg2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TqTCcWaf8X4N8cCde7k4E8LGOpK/G47v615Iqv2bqtyDKVs7
	KWT0agH+O6CEO3hk1hvGr7G7reqTXxD/BrF2gzK6SuYJ1I1OTWQElCNFesqxn4AklTB1wMGynVN
	+Y1XlIlr1ypwyh1mSZDNBvDZkIw==
X-Google-Smtp-Source: AGHT+IHdG4exJg/OMLEag+SmUtZLjuBoL7XDzzcwpjklziK4h+sFdGNrbUVUxPa6LEbWOqyaRb+b3/J1oVJBEuicPg==
X-Received: from ilbcp2.prod.google.com ([2002:a05:6e02:3982:b0:3dd:c6fb:13fb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:c26c:0:b0:3dd:c18b:c03e with SMTP id e9e14a558f8ab-3de38c21fe9mr52496035ab.5.1750457916490;
 Fri, 20 Jun 2025 15:18:36 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:01 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-2-coltonlewis@google.com>
Subject: [PATCH v2 01/23] arm64: cpufeature: Add cpucap for HPMN0
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

Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
counters reserved for the guest.

This required changing HPMN0 to an UnsignedEnum in tools/sysreg
because otherwise not all the appropriate macros are generated to add
it to arm64_cpu_capabilities_arm64_features.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++++++
 arch/arm64/tools/cpucaps       | 1 +
 arch/arm64/tools/sysreg        | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..278294fdc97d 100644
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
+		.desc = "Allow MDCR_EL2.HPMN = 0",
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
2.50.0.714.g196bf9f422-goog


