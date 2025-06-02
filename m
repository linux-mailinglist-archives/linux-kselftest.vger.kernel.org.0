Return-Path: <linux-kselftest+bounces-34160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C2ACBBA0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FD916C4A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9022F772;
	Mon,  2 Jun 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhrHTX6Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89E22D9F5
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892549; cv=none; b=T4Awb9BflNydJISteB7pYyorc/nBRqOWLKsJ8ZKaEGmg6Z6ZPhQNpQOTNz9qKMQIqF8f2ROtyaKAqizqYeGiuRdf2CWITWO4wIGimKWAyA4bc+gimliWQVCMnMTGh2lzpWz5eyc17eTE6ccAJjzh1UgojxDgen1P/g9dcswiJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892549; c=relaxed/simple;
	bh=zCxK3dISxEfOML4T7vSp5Om1/JdipoyUx0Yzj/yzWcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s1Ruz6MB3LekdQl0YjCoczVaztyzq4WNkx1m17kegTkQpI0Kc6QPw2+6wXdU71wJPtogRkOCAIykCifUIWfpi1atu0pVu2r5w9l4lPaxntM/KCl/Xe6Klo7Imxdl6An+/cWF+5H3nEGgUgrSbkopE5DKGZcOXrcUnxIbsGQl69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhrHTX6Y; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3dc7f233258so55962175ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892544; x=1749497344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYJABjVP2iDArJLMl5gj3ep5scI8fjcxHEMsai9rZ0Q=;
        b=qhrHTX6Ye+QOZb7bt52FhvR56+uKSbjeH+QJzZvUdehfqcBVH2m2lxBYDrrUnQ2iPZ
         8qNVA7cTEjoWmqpPBhl4s2V1vYqBsgJvbxADHxtUEM/AE9V+sXmSeoaxtEBf87Kw7Re5
         //0IXX4Jj9V3B1BxE+Q4eJ11htc2YGo1z5t64ZmjiaBlFpHcrCfdLR5FRUkP29zcpYLE
         SaGmy6etLpowiCcIxs/IhGrkdxyP/pqZCF+rSN8zo+YSMWWcVqqft13S02X81F4yB77+
         j1cO1pG6sRSqk0UGKEsnlDM6X0WkZL+N/Tgr74kZZzvvi1LAEPPwsrxgUTekM+zMFKDN
         +cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892545; x=1749497345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYJABjVP2iDArJLMl5gj3ep5scI8fjcxHEMsai9rZ0Q=;
        b=GU1dODxA4ZyubSt8twpjNRNAziv7VNj79VL15Nu4YXOv9eDZ4GiiTWHE6xeZh5x1w1
         LVEyDeNp4ilKFFtH8bkq2I1WPB4xL0Xa0U3RmQifjsTCJQTRsi2gPo+4g/sagJ1XYxdA
         nMMwwkLAHqsgNnGZnovcz/62fHknzK/EQy6auHaUYIg+uu/VuEnqZcoDGTliK4299az3
         k3SbFAzUYbd6mMqhCg2MjzE2AmGPJXVS/oWE7pt54IBFJUHOGG7X+J1nfLae2FyImuSE
         IIEbUzpoti/X7C9gM6310aDAcVK8epPXsQoKLlQv2OCftv3CvPMln/1OSsETSB+/0/My
         R1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1t/zwjGRsv9cw0JU9z3pIfOvxXA8mSNbK3LXJCpy0+fLDAiEVsqOAkKntcP6fMwIRqiZkVUg7iXf7e+Em7Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmbJcEiZhUt/c6y7wfzjY4mBWCyssY5MHnvbbKBQquPfvEkI6
	3TXkpYJpe4t3CJmXZUbUTfHzDsypNmVMWSljujH0m27p/CSzofrId5vHt+BUTrsN3sog2B5kZBQ
	Ewi0vN6c9gGvsthEhG6QR87x/mg==
X-Google-Smtp-Source: AGHT+IGg2rWIw4S1SBhgIdtyOl3kiwsQOgXvBToZBQsbPlELmXsPKjt1+hk3s/Rllj0rwiuIByf4uJq1ToD1VufkVQ==
X-Received: from ilbbf17.prod.google.com ([2002:a05:6e02:3091:b0:3dc:a282:283e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:b46:b0:3dd:89c4:bc66 with SMTP id e9e14a558f8ab-3dda3342b61mr86473295ab.9.1748892544754;
 Mon, 02 Jun 2025 12:29:04 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:52 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-8-coltonlewis@google.com>
Subject: [PATCH 07/17] perf: arm_pmuv3: Generalize counter bitmasks
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

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e506d59654e7..bbcbc8e0c62a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -502,7 +502,7 @@ static void armv8pmu_pmcr_write(u64 val)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -738,7 +738,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a2..fd2a34b4a64d 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -224,14 +224,14 @@
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
- * PMOVSR: counters overflow flag status reg
+ * Counter bitmask layouts for overflow, enable, and interrupts
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
-/* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 
 /*
  * PMXEVTYPER: Event selection reg
-- 
2.49.0.1204.g71687c7c1d-goog


