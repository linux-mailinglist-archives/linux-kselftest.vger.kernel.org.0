Return-Path: <linux-kselftest+bounces-37298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A227B04B37
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E287E7AFBDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE2288C08;
	Mon, 14 Jul 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUACJx5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32E2868B2
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533981; cv=none; b=bl/UiHksckxp+FlSLkbzkPXY11cRqQxuY+qO7VUt4BEA7MIAuxb7x3fG+UcGmrciKuHLBwBiNvmSRGfD2Or643iCzPwfmkmeZPa2iK3zXV10lZVIj4ugaH0Vb1lnNI1TEe68vePpy53+ybuWwI9CmnH2msIuD0W1pgJIwmGrt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533981; c=relaxed/simple;
	bh=83DjgNByW3MicWNoftr7pf8Sgs8ybpROMTZWgSw674M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QZpoB9ZPcJYR84ANCEpI6XrIPDooLgWllkKqI8SMkdQbwItqCihqS2UKsE/ELSiySqcSIBZCvli0FaYMpNzHg4eN9YmkH4Aex5Cy3MDlIFx9CTGm2D9glDU/VCN6RC4FgG7xS1yEJdVbHJa9zvChCfGob5raXI4kRH/lndNAIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUACJx5m; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-873fd6e896bso510656239f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533977; x=1753138777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXtQgo0JIkUT7TODCNQx7pYKeIXv6hb0g8DOUP6P7to=;
        b=FUACJx5mo6xzMNDLcxRqhBj7UnvTTJlxbdak1ZK2aycYSGfSzBKemoFXKLfksXl7sx
         QE6r+supNZ/1uITj2K4roR//Gf4UqFHBoeWvo8j6C/1cJaIlRq1Jb0lM17zb1PF2KlLl
         jk0g+9a+iMQBcYxegAdi3gAIUdd4TLzZ153SrCh45lWy1tyfg1NVieyRXTZASCvSwj7r
         bhE9xhAayWmI6Hk9i8iyCJbOZE+64I74yVknBfX26uqkRxHxJmt8OO8A1NhuVLWyTNRD
         kLujbqskggaREfQymX06zzprHAWMEVhPzLVB73MUcDX8+q3wSHND+irXHj0Pca/ko9Ub
         UK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533977; x=1753138777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXtQgo0JIkUT7TODCNQx7pYKeIXv6hb0g8DOUP6P7to=;
        b=JiqBsjicudxVNdGgZopctT4tTpSrh7/F4FlCt52trFLJO+dv5TOyR+KC2rJM9T4jGj
         dJ/bLVbkMI5jjyQR4sxzS6qcNIUVWUcbGOov56xvMAb57S1nlrUsEUmp+ya2C4rwupVD
         IMv6Sde9T+cgbQZ5kFik5uNG42L6cy/MtLndakKMiQ+04ZdY1F58SF1+axkm+bb8ZYJj
         K5v0RpAbGeyX8WCCovnLcgUnPfzzCcNvu2vzDcuP0f0SsaApIZRNyJemQ+bWoDp4kqs2
         fyPJUIG4bDr9YDvh2VlAKkce8vOwpZGNc+UFfeZ2QsEEB6F4NIuwdOtzMm7HRn0L3emM
         tIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iVZgJgkCj+tYvHWUEMLJgR24Y/VD+yAc87OfBnv9xF+AzN/yt+xDJz/BZ/zMqRqjOBo09MafI97DFp3n4l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXG9V0bTU8Gyl3AW21zo/+tmAv8SjxAovw86mZFDOlFXmhvHk
	v8lcxRdDjfi5w0J4lc4oyewpYhudgLhN6b5CaB86/1L7Je94MRwTtB/5oYdeDlXEANKSIi5uERE
	MfhHsRGIma6iiQpGTl6M615d/5A==
X-Google-Smtp-Source: AGHT+IHBO0mASu578wHJOGcQpQ9A5EOTJJDI2Tsl6mLeD713vdCHw+Xsr7SE46k9aYTsouWFo/KzgvhsXQhtYGQfSw==
X-Received: from ioni15.prod.google.com ([2002:a5d:840f:0:b0:855:9384:bf3d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:380d:b0:85d:b054:6eb9 with SMTP id ca18e2360f4ac-87977ff3c65mr1759326739f.14.1752533977132;
 Mon, 14 Jul 2025 15:59:37 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:01 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-8-coltonlewis@google.com>
Subject: [PATCH v4 07/23] KVM: arm64: Account for partitioning in kvm_pmu_get_max_counters()
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

Since cntr_mask is modified when the PMU is partitioned to remove some
bits and kvm_pmu_get_max_counters() uses that bitmask to determine how
many counters are on the system, make sure that function also counts
the counters that are no longer in the bitmask.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 79b7ea037153..8a21ddc42f67 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -533,6 +533,7 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+	u8 counters;
 
 	/*
 	 * PMUv3 requires that all event counters are capable of counting any
@@ -545,7 +546,12 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 	 * The arm_pmu->cntr_mask considers the fixed counter(s) as well.
 	 * Ignore those and return only the general-purpose counters.
 	 */
-	return bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+	counters = bitmap_weight(arm_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS);
+
+	if (kvm_pmu_is_partitioned(arm_pmu))
+		counters += arm_pmu->hpmn_max;
+
+	return counters;
 }
 
 static void kvm_arm_set_nr_counters(struct kvm *kvm, unsigned int nr)
-- 
2.50.0.727.gbf7dc18ff4-goog


