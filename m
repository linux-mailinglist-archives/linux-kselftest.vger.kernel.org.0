Return-Path: <linux-kselftest+bounces-35923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E4AEA7CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823764E2F88
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6B2F49E7;
	Thu, 26 Jun 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTKmwFWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183527510C
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968363; cv=none; b=I8ztf1NGY0Tjk8VUrTd6UM7iiwapiheTDnkXqK0nKNydievpEMPonAjPD0dpovyjZ/YnPGEDU8YPpg+FPHTrUOamv/H1eZseXsz6CSBlt0DqsUxLuFR2W8QpJ8BFEemH7smAxICuJ2CrZNia0NmAJLRuipz4gZiXsLlkjewcGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968363; c=relaxed/simple;
	bh=zDfO2v8ZbtcP2RnCvD+2EHC8b8R/WWM29bYxaxnNoHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZsEbWNpWQta1hg1B+4BZr6Lbb+T/xqLU/jKx06ppOZEut5mgmBF7gqdFLsvL+JcWNcs3WAhj4L5bWj2OxUjpY9s0CBRWr73+g9/mfqEbKjODFpOefnhc0HGvx/IhlNljGHWXWOwb4b6IW2zm4tjj7xcXuINpR0Vt8ZK6ys5ZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTKmwFWT; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso131906439f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968358; x=1751573158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWQmXlElKRqufKLx0IJBng3uEmJIOP/0SNzHgrfiOQ=;
        b=oTKmwFWTmEop0RSYQQ5GmV27f3skzFtQzPU4QqmSbkiqNMcTq77p/quyMhoJcWsCat
         vxPo557m74QVvIiMVJpJEY74DVV/bht2S+6URKbJBlmfILkDNfMUY3UJaGZ/V+7trcQt
         MUgLoDF0Kad2bvAtr3h5PzoRq+wL+ScqQEuAN7HenxLGzjJG003MWlGR53MWvgWstKMf
         fcpDiUBkswzVDJZwqwMCA2UW48zQentiOJLjbfIM9KIwmEb2U/nAPVY3t5Rwcwuh6kka
         aX4wMrWRxIuf9EmJVm6M0ZoxH9BfHfae3NN13SYuXF7F2a/v08BfvixAm62/X40W8rXl
         MqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968358; x=1751573158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWQmXlElKRqufKLx0IJBng3uEmJIOP/0SNzHgrfiOQ=;
        b=D0EtS9E71raiKewiUWM7nBw1z1LcHYfsghbAAnM0xQKZ6nWpqd+uhyZpnJdjKfBNJP
         Ou8xMxzm/OjAt9eakSyAR+W6IBX7x64g7s6rDExytYebwLjbp4XkKjIG9ENdoPOPOTKp
         vUdBnoI6aHhuB4f6wDeIkg5sCa0e0yQd837RwVotBYU3fha6DxBDin3f/Vxmnad7sVX6
         I/tDZkW9r1EOw9qBbu9TxmC/MM2fquvKaBzKLwiWynqFPsRpbbcNZ6QKA+ys86K5hrbc
         GS3xD3knT5e1H0BS2jqk9CXUQlpxzkMJhHtHfNDtJnfZrk2ilPbN9amJlAZC2Chrc6nT
         ThoA==
X-Forwarded-Encrypted: i=1; AJvYcCXjmPzPFGlCyvN6b8H6T7m7fl767GfkDbSG1ZuspzYF8CEDr9xPkga5fTXONCcGV1Uzo0VoJQtYb/JiwMa0/SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDcyE7c3avf3w9/y10JRO2deYQvqCOtnHZSFrglVsfm8dc/eh
	voHBgPKtVy6fY2Fgu4fV7Hm9O9bXit9LpJ4LfFG9VB7NcmLp+Ut94Hf3SctmPEzVb97FfqRDJdF
	XiaqRc6BQ5aSvkm/z7UBr7Kv8aQ==
X-Google-Smtp-Source: AGHT+IGgfwcSnINywDElIvOUq/qNOGZjEQuNJ0HSkOlhtmSxQvzs3JhS67z89W+d6j0EUhWxDQaGOM9wiefkiUhZhQ==
X-Received: from ilbea18.prod.google.com ([2002:a05:6e02:4512:b0:3dd:bec6:9d56])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:2683:b0:3df:385d:50a8 with SMTP id e9e14a558f8ab-3df4ab62001mr10858775ab.6.1750968358575;
 Thu, 26 Jun 2025 13:05:58 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:43 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-8-coltonlewis@google.com>
Subject: [PATCH v3 07/22] perf: arm_pmuv3: Generalize counter bitmasks
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

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6358de6c9fab..3bc016afea34 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -513,7 +513,7 @@ static u64 armv8pmu_pmcr_n_read(void)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -749,7 +749,7 @@ static u64 armv8pmu_getreset_flags(void)
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
2.50.0.727.gbf7dc18ff4-goog


