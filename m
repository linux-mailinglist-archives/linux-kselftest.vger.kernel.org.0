Return-Path: <linux-kselftest+bounces-25255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97418A2006E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B583D188674D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672241DD877;
	Mon, 27 Jan 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1woGYra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C11DB951
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016456; cv=none; b=RM0VgrLG8cNxz5NduxhSH0lOiV6rOx0qA9k8BjJ28O9MOCcJVD/6LlCSeSSfpvLjkdaAzvl0fGIDoqS0b04wHJ836teWtaiPJN/jQuE1el91tbcUknTiMBsVK/TZPpsw/EPUnLAL9RiiQxeLeRWU/bBeUbvVTfuemLstYXqQpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016456; c=relaxed/simple;
	bh=e+fynXqXDHpzzqW8Vs+cdjC+w3ueF0FGlAHIDITfNr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sw2MFdZmhGt1659aRQNKw4XD1dr7gNduKQdX83tK/1KZBrOSmI4iIBScMfQZEZhLsk++HuDq7+vw2pc4UQVd6pOJ3oPKjgvAMwD5dhh+yfZKKTlwWYXtFq6U2izkGxqOi+q8gWqChdfkbm9FGWOj7ep6S/L9vI1O3F+Jq/jy6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1woGYra; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3cfb365f077so32861455ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 14:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738016453; x=1738621253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaVkSfHrHzVfJjq8AwEUCvEhNWS7AN/5lexlisUUmk8=;
        b=u1woGYrauJdklAESZcnSDcLNF1a0J/801uEI1GlOHpN4qCXw0cim89NK9hPyqawmLh
         hC1TlXOD3Xuy3fAStzJuYOcsW1kaPcvQTgoFM+ZLQ3OhN81TlE2Aup2LWPxlmUYBKTGA
         iWoaFdHgyXXHq5bJUwwjV9UUfXLW3TyVUuU5It5NeCv+m3rKVXkAdEvyGJ4fIfgtRjsL
         0n1NSTyby9C/mjbdY0Wk0EJxsnmML8F5CDaGMqkU6+t9iaBU+jcXinV4bIrgqCQALNAi
         PiXvIWMNsqcab3Pod/j0Q5ACDG5+GYQKijPQ2Izj2oYAMg/9h8XhaC8ve0s+iShQILsJ
         t9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016453; x=1738621253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaVkSfHrHzVfJjq8AwEUCvEhNWS7AN/5lexlisUUmk8=;
        b=QTXSd9iLOgHxAMClWpHBhED0KZ3qM2IJgRgPEfJIWjN6eqjbOG38BAOyQF/pbiasgX
         ot7Iw1Qnn1sp+TUP3QrvA+LJFN17INXYDUqwQj1v33oLphQHjY+DQl3QToxTM8gaO7lU
         195w9L/oAtQZ6B0Lv90rVgF3qhX/eljyRpxWEa/PBg52+NiCM/uGX+lytFRBRVAKn9SE
         3fhETAzjFrFDSOHj3WFhp7aIvTqWxPMJ3oQd1stKazQqPXXrXAAyAwxbRe+pxb9Wr9CF
         sPKxoXi6IKhpQ/JVHxoAPFufAv8T4qjiamdG0op6cRCqMdFkG09rESf4yAI0UGal/vys
         ApXw==
X-Forwarded-Encrypted: i=1; AJvYcCXn/u9C8ZhfMgGegXvAjMhrS0G1z2nADyO8Bdl6XREzMpakaIKd8xGxCCJ8ckI/B1T6bz3IY9g1JEurDAVoG3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOIqtv9XgZSDOgbIyanEjHVJTbd0l0ay99mw67no26gHAdzaO
	AbGOOfn6/HYGKRvJFO67xMG/xcqvrgSti3IXqqZBJGEgaCA7M4reOIYg/5tlcOkXnJEAqSMcEGt
	P0Y1duFGttN4xjzQS5KfqlA==
X-Google-Smtp-Source: AGHT+IFYMP4DnSoUUl5kkRFoQsqHI/1D0lC2aOLiNQgEnibJSp/Pb6c49edDE2uZE1uw/6tcaw+6CTgspGEMpXa6dw==
X-Received: from ilbbu12.prod.google.com ([2002:a05:6e02:350c:b0:3ce:8579:c1eb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1f85:b0:3cf:b08e:7e91 with SMTP id e9e14a558f8ab-3cfb08e7f5bmr197753565ab.13.1738016453125;
 Mon, 27 Jan 2025 14:20:53 -0800 (PST)
Date: Mon, 27 Jan 2025 22:20:28 +0000
In-Reply-To: <20250127222031.3078945-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250127222031.3078945-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250127222031.3078945-3-coltonlewis@google.com>
Subject: [RFC PATCH 2/4] KVM: arm64: Make guests see only counters they can access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

The ARM architecture specifies that when MDCR_EL2.HPMN is set, EL1 and
EL0, which includes KVM guests, should read that value for PMCR.N.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-emul.c                                 | 8 +++++++-
 tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index f9c0c86d7e85..4d5acdb66bc2 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -610,7 +610,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  */
 static void run_error_test(uint64_t pmcr_n)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
 	destroy_vpmu_vm();
-- 
2.48.1.262.g85cc9f2d1e-goog


