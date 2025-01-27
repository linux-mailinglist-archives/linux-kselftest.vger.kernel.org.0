Return-Path: <linux-kselftest+bounces-25256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC806A20070
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E123A4397
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3D1DDA34;
	Mon, 27 Jan 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIm7qApz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62D1DC19D
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016457; cv=none; b=hQaMXaj40rGel9wX6Eh1/B2Pu2xd/nbXgk8WFxs9gXEpfbpGS5Si38011qpI+kRSDoIpPSjvJOTrzgjDM6ci0Wh/pJ2ZhFmJa3yr3f+rEedtT0Y9FFvZNGuNIUQnELJPlYw0OSBPVHOmxlo9h9P7qkAS/w+Gq+6ZpxzEzvIlNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016457; c=relaxed/simple;
	bh=SZa0a0KzR+LD1LUzSHL466MizkYLm52X6tOmDCEf1DM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hjyIUON5KLQ8Mikjt4/KnKrSpL16OqZ4xz0NsY56RxQoItIGxSMoGVoJlsMGBs3h+XSgKzQceKad2ehI/fCwAZVCSd3zc7fPW3RWyu3vxscyAc/sX7u1DiY3gg6LuFG8WdsU6GYbGxCiytku0ydBbocLQBeHqr7u2lmq7PfKyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIm7qApz; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ce51b2fcc6so83946125ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738016454; x=1738621254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eB/WXdYtPvN5Ab5ru245YZuFbSt2Wl8WSfh8CIWhE9E=;
        b=pIm7qApzgYFclMU3e/6xRUZdvTo7iWPuuLywAaBsvBCCtpUagjgLroAbel7JEUsf0I
         332TbuaFwjZ8jzBBuXrBoij02D+BXhjhCchpSURqnp44i0tv5BjU2jYSonY7Z9JIWXk7
         Wbak2xcW8P8dJ1oq10j2hk/C36uqoXLkTVMAjmNd8WDEoDyJ4YY0wyjgKjzWdrYMC6oH
         JJpDsMSsUni1z8jC0yB0Wq7pnk9ukBeQdXwCCIG3CtKKrmCwosjpaXyUrWKkS5hPASTI
         sxFmc9wKsayfH+gSUSq6yd9ZiTAugwdRtcBzS21VlUdE4xSDg9CGrwD2gwFCczi4n9Sm
         ggEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016454; x=1738621254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB/WXdYtPvN5Ab5ru245YZuFbSt2Wl8WSfh8CIWhE9E=;
        b=Qu7QZpozYz9E9gasM33JUrwW8Anf/NbQ4K7ZUHxAXc0655pa3HoZwf0fPWjlaSUFwj
         VWxyLtdmVZn6+G+QVyxGo3PNej7tima6ruQY3DfDFDLiWrE6yKxL4R2D5UoKatACHSHG
         qFgf6jVfWbZRHCuXfgq1APmGYsygxQbKWDXtwiIce2V2JKu4wAOJqmqAjD+sqW/CpGy1
         1Z33lZ90tfJKO1S1nrIy570xlXtqv+vqV1OQmYotTfjoNRTY2PXAO5TPmPCXmqUIt22J
         qsx1BoDruGi3Fatkh73LmkATOIlrS9OzKHRTduDC5UDQaJjH2yc3kCwQqmXy7CQa6ozC
         6xcA==
X-Forwarded-Encrypted: i=1; AJvYcCUpdokmqQ3L8rFcJvgIKyhtT99AAXW8jxj2fyJuXn8go8EDEFfdKu//JaH5TVgxSN/Ey7vQOa4yfV9ivnHauqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0MK0ke+NAASFg8sUx/xKjSisxmZN2EeCeGRc2g6vnUiMtCB5
	y3H+7ICwDNVbO5w057V3ORArYUYaU1kysRhdaCR+1LBwAJuLXPVqtIXpYR4qJtH0b5VhawffOsi
	DzDgsc8H9bLXoQ6VV72rVDQ==
X-Google-Smtp-Source: AGHT+IHlnPj0B51G4F3gaUMK8xZM3/o5eoR0afyVhEDX9mUYzTDBYrn3lVxOBnfUacMgZ4+x5YUCgf5OnSaiN01GgQ==
X-Received: from ilbdz9.prod.google.com ([2002:a05:6e02:4409:b0:3cd:deb8:6a64])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1fc9:b0:3cf:c88f:7555 with SMTP id e9e14a558f8ab-3cfc88f7680mr123300885ab.17.1738016454065;
 Mon, 27 Jan 2025 14:20:54 -0800 (PST)
Date: Mon, 27 Jan 2025 22:20:29 +0000
In-Reply-To: <20250127222031.3078945-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250127222031.3078945-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250127222031.3078945-4-coltonlewis@google.com>
Subject: [RFC PATCH 3/4] perf: arm_pmuv3: Generalize counter bitmasks
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

These bitmasks are valid for enable and interrupt registers as well as
overflow registers. Generalize the names.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 include/linux/perf/arm_pmuv3.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index d399e8c6f98e..115ee39f693a 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -230,16 +230,23 @@
 #define ARMV8_PMU_MDCR_HPME		BIT(7)
 #define ARMV8_PMU_MDCR_HPMD		BIT(17)
 
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
2.48.1.262.g85cc9f2d1e-goog


