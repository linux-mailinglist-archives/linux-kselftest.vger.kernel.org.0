Return-Path: <linux-kselftest+bounces-26572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C43A34D2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D373A465C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB7C266B44;
	Thu, 13 Feb 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6HUOFkk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE124BC1E
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469924; cv=none; b=FTCN8YhOiBLbpQGE4OTsD+9LWNPp/ZMFDrbdaBjPrSoGcVM+3pCXVdt2HMJ1dnXeUudues/yIISdAtGfTWIKbOlmlzQWj1UdTEHVRxTSUG/s0LV/41JZ1fcegPcoYyCeX/TU0+ZvmaLugR/oKsTu3zXuwOC2qJdXY2Qisbsq95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469924; c=relaxed/simple;
	bh=IPomACu1+8aSUcgHjl+TvhZac7fz1cEIHmspucDQtRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pb2S3WI/LLJ+CSutrHIIRnbo6vwfF4xHHqmuB8/zlx1wL3Q4mmMAM44Xdth8t5/8EKqwL3yfF5XRyopSCowzE+BI5Ncl2ybAXjPIDLzL1oIuUtVOHE9rgYk0ZYGuzeUu40AsvqDNrosn1u/pxINe3UjAzumGCJbAMaO4Qbt8Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6HUOFkk; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-3f3df5dfbd2so380671b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469921; x=1740074721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbnJYyoVJc3D9vRYHg6DaJudE2uBzpyQ/LXCAOcJbR0=;
        b=X6HUOFkkw9OmX3kr4Kpa2Nc8JhKXROlJatDFDCCgvtFJn48apX1qGcEHT1En/CKXCX
         tzhpeLFQwkJyPg0xNXuiN78oCSFICv+ziIbW+5jYjcXfy0OP3QPEWbEx1isJ9y7ilXE+
         aRuNthLKiry2dWCe1ME235LMQCCXwKvTZ38kLb616c8SeO5sm7fpJGgBotROLoZo4Dsy
         Pvpoe2CqPXdEc5wIFaYFBPkz6yDuLg4fRd5kFCKfQJxf5i5y43azz74lUi76kRZOK0Qx
         2aZDonaXIdyIu6IWUr7mRcWNuh8KgZogQ4hfBCo+3yTZGMBVZFNKLRoykzs//mELVxIc
         VCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469921; x=1740074721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbnJYyoVJc3D9vRYHg6DaJudE2uBzpyQ/LXCAOcJbR0=;
        b=XqaVZ73/kA+fajBqrgEG7HVedVRheDDi1dJT6iTwP/6GA+2vJRxifIxID1cs5vsneY
         oLwFZP/58uvhE9W/Iohp3lIawgsLQrUJQI1Xk7YsfWqidBIG+wjvG3+1zcg9SFsHsfiG
         lCcnoIP3/fnez27EWFE1VpJSO4DqevZglmouf19CIoYTYrxzzl5vfFvgFiNneKTjY8Wm
         giIEQQotnuhDRmJ1FKPWvwPtwBNj1k24NBRG1G2oztI11J8fzsc4OJD/6yEkFlsLSk1z
         ZEaf/scQ49h1AJFJ+/rHJw4g6vqyFB2jNr1QT0lbt3Ip6LOwIGSAsB/ZOS9XvVPR1UjN
         I0gw==
X-Forwarded-Encrypted: i=1; AJvYcCXi0mj71wLvqlQvFzfPDMqn+U6WCVCtlt96f8RAjW046vi+VnI4W/gaXu1tf7h23LZkqJ/SH/QrP9lrleMnlVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4UimjZT2MvZ/ua08UYdiLXXzKvRlFDdSlELN2sbl3mF2fyEo
	ZrX+AUYTG9SWgfM3OlWSEKWOHCofnmqqe22gEIfTJ5Kl14QGwD5l8zB4mFp3oNG+yD+mkO4jOj3
	HedzuXZWRWvxPEuVrXGCPww==
X-Google-Smtp-Source: AGHT+IF2I7xGWAZbPu73m/0jZgOAhV4gawbbUKrOiVZZ7yZX4HGebgHLSfWQvDaf3SHQjpSi0BuBMnr+ogGJwijyPA==
X-Received: from oiww6.prod.google.com ([2002:a05:6808:4d06:b0:3f3:ca1b:13d8])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3c88:b0:3f3:ca45:4315 with SMTP id 5614622812f47-3f3d8dcbdabmr2920400b6e.9.1739469921296;
 Thu, 13 Feb 2025 10:05:21 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:15 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-7-coltonlewis@google.com>
Subject: [RFC PATCH v3 6/8] perf: arm_pmuv3: Generalize counter bitmasks
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
2.48.1.601.g30ceb7b040-goog


