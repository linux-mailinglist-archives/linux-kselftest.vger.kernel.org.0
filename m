Return-Path: <linux-kselftest+bounces-35924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E352AEA7CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF311C45688
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4472F365F;
	Thu, 26 Jun 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGY9JTtc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDC2F3C19
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968364; cv=none; b=cO6OdTgHDH9UNtapH02QyulIbR3xa6JUmrgNInNyjFCT7Po0heZpzHPeycudwGmLlW8UMeMTM2wtzPv4pS3zbdmo12LjaqV/0DRAggSxGQuTnVAj9831jS0lXdrG/rvXjr6NL2YINVkDiKRkxsA31RNf7OPAbGbTEIYWKoYU8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968364; c=relaxed/simple;
	bh=K2xYmW/GgRMbLaQlmv0qc4PJUypEgPrPpwxJt6aim7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AtxVsT1E9uIe4w+S7+HLMXMoefHGpwJzMVDZv8x/7ol4Bqidtuwlbh6zW3I+gKnVk6mlJA4XTQq8XDdsgJq81d2yZNwDNfEgFzc+dDvftDcM4iwAzka2/3N2VMiRZOelyCLk4lezB1z8hqXC1cJbhyBBSJJ+NiHKsQTVWzd3mIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGY9JTtc; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6114c90e664so370281eaf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968360; x=1751573160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7IKRsWOtConph2bUpKtMTviRfv4NZ5l+qpFLQ4pko=;
        b=QGY9JTtc2RkySTRV7Nde7iqNyBTHJcRQIryLAQIPrqKJyac1W3WZCNknWXUKnaw804
         h3LQkaNh/w+5THpXIyZ8qm8Bf2DGP7kaNbtkdcwMJ4kldWFRHR5IgHhHHDXXyBd4dX+w
         WUSAg7iCSzv3vhObVbn1riBxagoWNu0//2I5mHEBM0L6VTnmYYLasXCz2P/8XS//TH29
         9RbBq1sRd9cvFg+NVZEaR9BtLeBqaKeSrPZW6kHEhTYknRthKgTogMJjDH9XOwB+lkqg
         NvBq7mQA2aKrkIL++Jk1bfKV4xd3kW0tjYb5H8zCdzHfN6qqzd0/f812ZHPNCSDhd20E
         uabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968360; x=1751573160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7IKRsWOtConph2bUpKtMTviRfv4NZ5l+qpFLQ4pko=;
        b=oWZ844No7TPFZrSf35KQKYQUoAo++NPK9/Iwe1kfJoe1+clD0HFZd8Ap5OB6ESt50C
         pslvmO+7Gsrfm+NK+Pud/gStTneib1wfazZ6KllTbYdYQAZEY4GifiTxR6UqbsOb3zaA
         RunCF94jFu1XyplHFqAmMq/VLGoIqVR98PVfDSnYt7rY5ABcQOotQkWP9oEmMqU6kWSK
         6eCin1JR7uoJ8MUhT683Y53utgO45FUL7tVvdfi7wD/WLwTnwXwXfI1Nq3mlGJF9+wEU
         5WyqkL0KLOL9VW5fRjHLeiXqDppB+6ca90pnKz2WVwry/GMMiNKMC5YESsOmaddzSNuZ
         THOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVjSWJ+dt66nRHGAjHeXMlF6jO08uPDZKfKce7ExU75iI4Ws698LI8aj2RtH/6psiMQVlRyiSebJ2TkVkh4hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1g3CUoKDCxnatJBnYYVfZF7UvrHVCtftDYnm+YQ0bpr+Slkk
	uNtULwWJqciHqY3AGNOumP0oVpuok8Kn7lxdM1gSfq4lJhCjFsZLDoeWUy1/IE+KRojrqd47nUI
	f7OhkvDkULOeuX+9D0SeVzD7qpQ==
X-Google-Smtp-Source: AGHT+IE+CkaZ5iXFv3dTlFyH7UdGDZHsbvzoJSe9buN7PuL7mIyZPRSBWsO96oSxssKGqZuLRqFlyodkFZoXyb0msA==
X-Received: from otber8.prod.google.com ([2002:a05:6830:3c08:b0:72b:8c86:a47f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:720b:b0:72b:9bb3:67cf with SMTP id 46e09a7af769-73afc5c355dmr285473a34.9.1750968360578;
 Thu, 26 Jun 2025 13:06:00 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:45 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-10-coltonlewis@google.com>
Subject: [PATCH v3 09/22] KVM: arm64: Correct kvm_arm_pmu_get_max_counters()
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
bits, make sure the missing counters are added back to get the right
total.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 79b7ea037153..67216451b8ce 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -533,6 +533,8 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
 {
 	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+	u8 counters;
+
 
 	/*
 	 * PMUv3 requires that all event counters are capable of counting any
@@ -545,7 +547,12 @@ u8 kvm_arm_pmu_get_max_counters(struct kvm *kvm)
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


