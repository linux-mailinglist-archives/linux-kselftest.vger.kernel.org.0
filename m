Return-Path: <linux-kselftest+bounces-34156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF76DACBB8E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC481883E30
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2422A7EF;
	Mon,  2 Jun 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqso+t7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D265227BA4
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892543; cv=none; b=rdfrYCffNVMnyupC0uce4aI4b5WvpVrdEbt5eeN+JxSawOGEDNyQPJG2eJBvbgEKG2etJEOPDV20qSBxsPcn+gESLvXcatFb+zK67kZkTzNJ3rmo9EQiuPYhVSx0FEGY/AS6ERYjLwzP8+AtWQzyFn3zbN/5W55nS/ALTtsMKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892543; c=relaxed/simple;
	bh=hTJhSiv8BCxLXoZ+NIawSUFDzfOoIJdaR2ZVHq+pdOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kuZYTpZ1q6MvJJg3Tcd1AcsawGv4SE6gv8wMYvaqeT6gvTVyx7+GZPtX1d9qBEr9w/g5/WYOYzlZ2U4E2ax5s9uhYj1L2FlLEE3qyixcWsRPNe6VHpETlstcUJP4zD50VKQiVGl5syk+jIXyKoaeqPaU/rLy1NhG5lTqpWeIH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqso+t7N; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3dda536e263so20695295ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892540; x=1749497340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVB/n3He0PUlo5Tdl7uIOjIZvaOC3NNae41+U8BzpWw=;
        b=wqso+t7NhJqrApZJzbtbNVoClSpEMoimaL4X+Pks3aonRPGdeKmZnXOqwF3e9LfYVR
         IEdjJrvjabWwK/is6CHvoYHs02GmXtwWW4xZ5/j0W+jNXbu83gdfHLamZ3FI/EPm/LDe
         igP+YO+MU9ZeBkTlOKBFiLlCBINcqv7GObafx1Z9QZW8hsoJ/ar8/p+Gm2MTxSM8gLpU
         jY8qOGqysDIje/pRy6fcg5YdLpbnzdfJY1FPkhRAXHXI5kQt805U/+kF7jdjOKS+hEkl
         pRls57M1p5I2ypjOx82J9kCn/XZ/V0zk2OOvOIcQLjy1RHSeYzNR+mW8YNYO2e7M75jA
         TvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892540; x=1749497340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVB/n3He0PUlo5Tdl7uIOjIZvaOC3NNae41+U8BzpWw=;
        b=s+YMwQ6NLj2JWkZ86+UVSMNgCb6K0dHxpoCD0+aUvT9dHFfEaYjMmOeCrPIMZuObcN
         F6BxYd+p1RFB7KD4Z8sSTrIgb8UMJA3BJ+wGE25qqFEfTIMt9PYC2L07Umzjv0e4a/pq
         NWDMFdw+YYwR9MtARFayKq9PQd5YJqeZyq8tRWqCQq/9rDyCLpywt5llQ7IUrLWEXo8U
         +D/+gJmjBjs3G8nIVU6atRA94CeQDg1kh8WwO0MWi4nrg5NWnBf0OEphZYK5LtAn3Vb3
         88GrwPOUFwMjCL+Gch18jE0w9JQOIc7PqRI0vOf9zDbG+/Gmk82tKdW9bsJgTESYtiEf
         7Dsw==
X-Forwarded-Encrypted: i=1; AJvYcCXN2WVOrDiTKfsMLuPoxql2GuTqWcpzI37024av2OXsTyMc6Xzc6OPBhcZHwO6Ck1tWOBEcRkBURkYKUtK761E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqInRuL3zQUq3de9R3PML0gTPnnEfAz5i2PByeNN1aH8yR1hOR
	qS9VyPdK/oQMeeEtSqDNmbc+JAElQWIPP35CttoDRbXSp9C5VBdLfJWgPSnANhzqkYQDmOFIY/U
	IVcwN9B1lMFjJ12QXLda9HJIlqw==
X-Google-Smtp-Source: AGHT+IGP8Tr9H87Uubq0BhuyNeY27JD5iCuR6Hrz2NAJX2PVsu7lMWY1S1KfCHmBz3Zd2wWiWUQw5wTiYh98OuafJw==
X-Received: from ilbby14.prod.google.com ([2002:a05:6e02:260e:b0:3dc:64a8:fc81])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1a25:b0:3dc:8b57:b770 with SMTP id e9e14a558f8ab-3dda3370d7cmr84711015ab.11.1748892540564;
 Mon, 02 Jun 2025 12:29:00 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:48 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-4-coltonlewis@google.com>
Subject: [PATCH 03/17] arm64: cpufeature: Add cpucap for PMICNTR
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
index 578eea321a60..e798a706d8fb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2892,6 +2892,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
2.49.0.1204.g71687c7c1d-goog


