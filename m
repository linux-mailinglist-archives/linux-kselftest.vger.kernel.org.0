Return-Path: <linux-kselftest+bounces-26070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A101A2D2CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D0A16B13A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3C14EC73;
	Sat,  8 Feb 2025 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJOwVkia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF6137C35
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980086; cv=none; b=IAAmwyXU12Qw3kimea4yNNJX6RncXZCBCUuZTRhUyUYvLFXPAVo5ac/FGwCBArXsXBp/TQkytJUAgdu3lH1stLt0M6AIV5cJqhfVXvqe8sAFjOZyQhqqaLcHrMYpCJCScfBP44q2jsMBY2ckXQVmlIuK32xCwM5Q2UAw550jHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980086; c=relaxed/simple;
	bh=+qAoXvS6xc+m3hsF9w5PjnIq4aq3I0ctOVpDSrBl1Js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uAQvDAYgU4zujfJ+tSC8iGagcOrCRatkhMtZGAi0XHcFz3vRIfH/dkEjC9GZgw/SCYun79xXQOoPgoZAYA2btNLZoBJPdczECaidz+wnlmcNfOAomrbMBxHjpJrfHqFjwKQrHUUBw2w/A8gxrjyvTXlLPFiBgsU4W9JWqJ6pGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJOwVkia; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3d14bf806acso8559335ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980084; x=1739584884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O4akjcxYhNwCefv175mmgU5vTvI8B0CXOe+M7wmIh8=;
        b=MJOwVkiaTNmmHXpFv7tvDvYSHkOIeeQ8GOYVKIWreZhvgR7iE5rVwvGJPJYzbtbdRY
         ZfG0PJT8eNunXQTkdnpiz7FbKo0lstO2mNPj85OIGBDkI13bRq7vweLDskr2KUH1OG8U
         LT1rTQ+oJ1sFIu0tbRTJ9Dx34VSlXNqGMV2gbVgcimn5D6Pwli0s2bws2vNq0YPcdncc
         5thRoqlTYP/6D4RuzcUTrILqxzXVMIdEKZFuQxLqN+8sBelEIVcGLFr/UErWYFMJV/g8
         oYSchDvC7LKeo+/gaUcnBadyMLvKzDNEMo51LlYrvTV0yQkuQPjWnIvcNFSJkzL05qK/
         cZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980084; x=1739584884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4O4akjcxYhNwCefv175mmgU5vTvI8B0CXOe+M7wmIh8=;
        b=KaCnBeRc5/r4DvdenEoy4zqVHPMucC+kHlXlVXjNLF6W8pivXF5zTSq/AcsGl+aUlj
         NoCp2zbO4PlS2pcfhJlqZL+GCewjCzputLNiLgOXbZM3JGuUuRZYlr7YHgL5DEYN3GaS
         ZBJiD+OOM0tayK+3FH1rBU/sibHVG27MaS/YDNWZxBTBmSt1t0Wpi4K4hJGBTdizwkGL
         /bVtgCnfW4s54EdSR8nIVQ3AwJqVZxKpJKHZ1YV1E3GWkbmpub6sYs1UcNNxnvpQoTa7
         yvVDyrQ1Vcz4XEs9bVYkvjJDBHBw9JR+D7Qektimgouo3hJ5bJMpbRaqIKwWB70S3OUm
         AXMg==
X-Forwarded-Encrypted: i=1; AJvYcCUF2ZNh9LDOtm5L4ulRI+S/1YZ3huQdsr5UxZvwKtHs314W1dVmlAWXKdElqqobSqGHIPWDhiD5I2cl5q1wIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7gKI2u98N5DVMhhflf/IdNDfQpjR39bSjlDy37GkmdTtkiTj
	UtEp0rVJ0yqEt7fUHvGr2ksOu+mLobegqE1OEOf8eUjYysNC8nFC+aCW8R+fVxlQU3HPnnUAPTQ
	q+DDobyvl0970uEnaGh8xew==
X-Google-Smtp-Source: AGHT+IGWeZpc2qa1ckU4PjgV51Y7Hx9W1wQ1TYRDVmT/vQly3n2guK7Orb67xhImPnqLeWrkenED8+oum8nOVfQ3mw==
X-Received: from ilbee27.prod.google.com ([2002:a05:6e02:491b:b0:3ce:69d1:ce53])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:17ce:b0:3d0:1bc4:77a0 with SMTP id e9e14a558f8ab-3d13da22469mr48897165ab.0.1738980083677;
 Fri, 07 Feb 2025 18:01:23 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:08 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-2-coltonlewis@google.com>
Subject: [RFC PATCH v2 1/4] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

These bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 include/linux/perf/arm_pmuv3.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d698efba28a2..c2448477c37f 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -223,16 +223,23 @@
 				 ARMV8_PMU_PMCR_X | ARMV8_PMU_PMCR_DP | \
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
+/*
+ * Counter bitmask layouts for overflow, enable, and interrupts
+ */
+#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
+#define ARMV8_PMU_CNT_MASK_C		BIT(31)
+#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
 /*
  * PMOVSR: counters overflow flag status reg
  */
-#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
-#define ARMV8_PMU_OVSR_C		BIT(31)
-#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
+#define ARMV8_PMU_OVSR_P		ARMV8_PMU_CNT_MASK_P
+#define ARMV8_PMU_OVSR_C		ARMV8_PMU_CNT_MASK_C
+#define ARMV8_PMU_OVSR_F		ARMV8_PMU_CNT_MASK_F
 /* Mask for writable bits is both P and C fields */
-#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C | \
-					ARMV8_PMU_OVSR_F)
-
+#define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_CNT_MASK_ALL
 /*
  * PMXEVTYPER: Event selection reg
  */
-- 
2.48.1.502.g6dc24dfdaf-goog


