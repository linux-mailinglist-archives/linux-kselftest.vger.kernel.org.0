Return-Path: <linux-kselftest+bounces-35471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A51AE24FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76C317E02E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4492441A0;
	Fri, 20 Jun 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHCn46JH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94723F294
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457922; cv=none; b=hVk+2PuBJCPZMRLtyNO+LrGqMk4X/Gjv5QOJvp2RrkLaFoeEujLX1X/OgwRpEEdDZSxHjY7segYF+WqceDnsN5KBT5pgBumBDKxKh35n6tQBHyBP2rSoRHG8HRNLtsV3Is4iDsQhUPRL+IWG++KliuCniLeiWEyef7vciCQEN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457922; c=relaxed/simple;
	bh=YIYZtYXjjIDG79viwi+LeCOmjCYAMmr9a5RXDPHvUQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l79WY688K7GUELduXZn/AclDFQcFxqVcfztkXmCF8pDZzlG2I4yydFdlSRPLp5sc4RIPc7ORdOXl/EYwjmzRF7i7P3mHhX3utZeYwKxfgNeyTW1px3bo5tjMLshDCz0ZJK5SX83s5z3rEagXOzxuV0BsXlm8YZ1ws6bCxtfgB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHCn46JH; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddbec809acso24432035ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457919; x=1751062719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp13SX1Zh+VZLmNtKrEzp/HCcjo4sCQKHBsJF62MnBU=;
        b=aHCn46JHfXsAqDl847ItrCxJPstp8TmNfe8t9PridE3GUcukpZ5flqpGgdAC46nTRQ
         81OVXEi6Q+WzaujLcYAhuK+5tB/1gTb38YGfUp/9UwCTQ7v48VxjRqO7kD6yxUt86gXR
         4ojD7u5Xr6AxLl2zf1TrCgPuXi+yE5jRPS5/lugjK42hCSPKG8qgcZVzmw/jTGEn7jf5
         1SWhN8cMLnbcLUL5zhKRu+jY7X0UNqmYospW6nrxqcY1Q98P1u0R142QTszPuzRORBsG
         IRGEBiMw/aRsW1y3dNuV4+hYpf9/MBOo/b8lHVTV1W+FzUdZBV9152/GT+oOH3E2/6la
         Uvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457919; x=1751062719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp13SX1Zh+VZLmNtKrEzp/HCcjo4sCQKHBsJF62MnBU=;
        b=I7WURdIYHtfpSjr6jKjnMvBXqw/v6GSqeuw4jYOEZcjF2QUH22rxPHKEO75FLJ4KoC
         jeb+w5GY+cJB5rda1dgFYuyjBcDgDuHxsSVy1uQoWjVHAY/1CKoqBF2Wnu1FcvcG3PPV
         ntiaxH31LpkiVdtsjCHByu3AJE9N3QKPAiVKYdi/JK6oBsWZFCXu7i5EUGthLgVqf4LP
         lTnlcTe1r9JGTXhxTatR7QPQYZyhH51s4wwgXYZ7WwbHr335HoXOZaq8qCIEJLnlALMu
         rtCFcJRrz1VH67Yek+liauJK4N8StKlWCLBvVcyse4JhGA2S2I0t8vUF5S+0h67YerjB
         eKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbESir3uCZcI2E5EetG7T9mUGH4FmFLikztKXTyQuHii1oSdSgar+afP5zlaRX4SoZjtw/zWQ6LsQqn0Tdkag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAe0xZNTS4VwzX5S1RgZ2tsyye6PJqUkm+B6rRBnqmhj8Yxr4S
	93YxzHbkxSz8vgPlQVOmsTpxTVOaL/2mcVyp1K7S4lgV1CpYPv7F+JUs03c6S+ATfc5TdMNoihq
	YCIPj4BAcSP2VjpMYW9SAxhHLnA==
X-Google-Smtp-Source: AGHT+IFEidHFMEbKk2OynEjRQvMLrVqFymZV1Kh1vRLY6IT0l2lygB4TWhQMZfNIZL6xIAJ9fHhQZ3Bjc4iSkEbXjw==
X-Received: from ilbcp10.prod.google.com ([2002:a05:6e02:398a:b0:3dc:756a:e520])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3782:b0:3dc:7fa4:834 with SMTP id e9e14a558f8ab-3de38cb06a0mr47968995ab.15.1750457918713;
 Fri, 20 Jun 2025 15:18:38 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:03 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-4-coltonlewis@google.com>
Subject: [PATCH v2 03/23] arm64: cpufeature: Add cpucap for PMICNTR
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

Add a cpucap for FEAT_PMUv3_PMICNTR, meaning there is a dedicated
instruction counter as well as the cycle counter.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 7 +++++++
 arch/arm64/tools/cpucaps       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 278294fdc97d..85dea9714928 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2904,6 +2904,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
 	},
+	{
+		.desc = "PMU Dedicated Instruction Counter",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_PMICNTR,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64DFR1_EL1, PMICNTR, IMP)
+	},
 #ifdef CONFIG_ARM64_SME
 	{
 		.desc = "Scalable Matrix Extension",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 5b196ba21629..6dd72fcdd612 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -47,6 +47,7 @@ HAS_LSE_ATOMICS
 HAS_MOPS
 HAS_NESTED_VIRT
 HAS_PAN
+HAS_PMICNTR
 HAS_PMUV3
 HAS_S1PIE
 HAS_S1POE
-- 
2.50.0.714.g196bf9f422-goog


