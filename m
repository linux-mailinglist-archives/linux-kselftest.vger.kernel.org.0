Return-Path: <linux-kselftest+bounces-47321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF813CB1163
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4771A3041883
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626C30C600;
	Tue,  9 Dec 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2pzfVdk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B8309EEA
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313563; cv=none; b=rQUC63vRn/gk7Z6W4qoy4b4hqKiA8oWVIG9UMuep7vK9TUqpE91Qumr8AXgPMwGl8f+VJEaf/ME+FHNuDOj0jE7CYuofCoOGeGstoOYWcJsumvwVKOLZ/aLCWjO/v9ZfIi7G3hbJiUPSOccPkHLI8jHYylLyu0KyMT9LSsAftlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313563; c=relaxed/simple;
	bh=0D8f0lGMl9e4KEAGFc7uVXhORDpuK8IH9gEX8a1WgT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5eRJ/lHGarMaK4ljEPk5YlKIavpXhNGpAooIRgUKpbfPsE7mPm8MwGjAxkTwy9+zKkVCycoJ0OYKZoIXtRvYmBWU8ATPPKvfscrxib4N5P6fukQ9c2iOt+O2qfLJviZFuOU05gX8FtCenvm8PiIANlWGSrqctlny1P0pbGQABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2pzfVdk; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-45074787a6dso5695273b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313554; x=1765918354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5yWZRzHwonF0ybTPKNr07gTZcgByeP7H9fiRk7DESE=;
        b=U2pzfVdk3j32d66hLo/ArCxFYmW6JmmdgOgejK9lI9gbM2SE0QL3caNUgmqOGUMRM2
         HgDFIvYFnI3TuqxgaVFlbO7e9OU84uTFF2w3h0mgVqB57FE/7hbDkX7OWnd4CzFRwVIx
         3IBFC0aUUJR+FPMttbmEPV1D4k0cNs0oDv9ZLa1X6UjI4OtKHuYtJ6zxnHGop1jSnKpS
         6ONGdSDSitJbjEtfWnlVZeluno/TNM8+qQR/RgPGBnVVlfL1M0PvojXZgWOwvedAVEdQ
         UBddKg861zdUfrZwEZePG6r8zlCDHu0Utrn4BN+EQHRzX5v+/GtFArrYmAU6ycoEOaXM
         PBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313554; x=1765918354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5yWZRzHwonF0ybTPKNr07gTZcgByeP7H9fiRk7DESE=;
        b=JuBrz+MI5kR9WTZImr5cAi/glVMwxwuj9YYI5egazDnj70zyaGpZA1GWrQchPOap1y
         EO6vCWvLfA+UYovPN9dM82CLi4pSn5c+Wqtk7WEuyHr/6WGNcc+kDSfzmQBgN7a89kLi
         c3XDDucNsPMoniTibTnbKDQ+cs79o+O2ogRNV8OJzLHfFGY/zQLnISamnkDpGTSoKXwD
         TPIW4w75u85gjU1ARfJiu8Fhs5+H4g2P9ASR9zu5NEHqjUEwhCdPNgxI3VC3oxEDlmQH
         CDy0HEozv+0Zra+3j3Ab5xRALQGak7DZoczFrZrWZrtQHIeKxZl5BqNUpNe8rmM/EFZS
         tsKg==
X-Forwarded-Encrypted: i=1; AJvYcCV6EOxu7OTAH/xMK+BjeqZI42Pbi3+XakSSp7Zv0sKMyZEgRr/Fw56yFONNPgM+Jd3Wu+PO3E8UDgRx5fUUlEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGmREBO5m7HN7YvupaD9PNKWgElTKkeNCgExjVneSfxMm6vpq
	/AHm7S+fCChMoAlrHoe75ARTC0/ZExUY/BmFBK7TfKA+FuI/ce1P2suQtAJjgXyjJKbK2AyX42D
	tLkNkN2kjrOhJwR8ErmwGVhWu+w==
X-Google-Smtp-Source: AGHT+IH2y/y/c/VHwW7FsQzg6cEqGCqxyR53g3FW4QbocbYeWU2m/DAvppskfkGhYMkbAciwVFKu+/4Kb6/59MH36Q==
X-Received: from oibbx18.prod.google.com ([2002:a05:6808:1b12:b0:453:f2f:fd82])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:191d:b0:44d:aa8b:58f2 with SMTP id 5614622812f47-45586554d1fmr140748b6e.9.1765313553989;
 Tue, 09 Dec 2025 12:52:33 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:05 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-9-coltonlewis@google.com>
Subject: [PATCH v5 08/24] perf: arm_pmuv3: Generalize counter bitmasks
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

The OVSR bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       |  4 ++--
 include/linux/perf/arm_pmuv3.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 379d1877a61ba..3e6eb4be4ac43 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -546,7 +546,7 @@ static u64 armv8pmu_pmcr_n_read(void)
 
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
-	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
+	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
 }
 
 static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
@@ -782,7 +782,7 @@ static u64 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
+	value &= ARMV8_PMU_CNT_MASK_ALL;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a27..fd2a34b4a64d1 100644
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
2.52.0.239.gd5f0c6e74e-goog


