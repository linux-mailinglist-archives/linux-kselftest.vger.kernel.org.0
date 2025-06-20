Return-Path: <linux-kselftest+bounces-35482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E56AE2534
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434BB4A4C41
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CB23ED6A;
	Fri, 20 Jun 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJREnVd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675C253934
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457935; cv=none; b=dpUUcw0XlGdpuPu7KWfEqFWziUW1yMRl8rYg+zxwr7fkaEzUQz33JAAbtagg7uLzZihwb2Skg5fA/zGBIrwwGMNYVJFQaLSj4oMthHsJSUVTN6tqcPr3B24nML3IKnhs48GSqjh8K+VNpIZ4xR3/J4A1PycycPtP1EiLL9RN4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457935; c=relaxed/simple;
	bh=r9/vMoXr3lfiFToKxSojMMbuj31iMx90TgFdXWddsZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jA9+FFO0RKU+StbCkBPtDdaiJLytVOArVECx4uwYomXij2OEnixYmF7IHRsYYNynwd09gYdow0qKbiL3U2BVGpg9qHVkbBXsmerOtRGAM/zS3ooBSiX/YAkcPU0CWu8cp8YqAtyqAYWuALUsAZfs6EOzKiRCZIjoQ1QSLL24vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJREnVd5; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-8754cf2d6e2so196094339f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457931; x=1751062731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gZPdqHIaC5N89cxtk14Y15WeUbkAXiFR8OakDw0fW4=;
        b=wJREnVd55aygRSMWYfWIONBOEokFdusDAIP02uGKhsJr8zaLjzo8Qgm3XgbR/z9QJa
         F2VOjnDNGfdi0kyc8FzbuMFNUzvS6YJ7mjRmGkSCDw6yTqRn7BWd1RJ4HyVlczD+nV9v
         9LuP04TWFLA+AXw62z+Lp1EOV1dPjt0nRig6KC+ZKiHdhGdBqo7kmN8Pc4kbIL1OeAC2
         iMWL1MRVRm2OAYyr6GoZlDYqzAGyjuOwNQ/VFA7XVzH7QmHALPvlS+7i1AwRHZDIbV40
         ORs8+YvglyXaEMugR+Yu/fu+H5M918s5TCB+tsA8p7VLw/PBIX8OUB90bgqQdlvuQeXK
         soww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457931; x=1751062731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gZPdqHIaC5N89cxtk14Y15WeUbkAXiFR8OakDw0fW4=;
        b=e6iEyzCD4wdK23BupHSezDq1mVBN3ao4vbF3c0wNyxKGiFogZqj+lIZYKVGC/1MhFf
         TNTKyDllPA83MhzZjP5tEiOH9IyX5/18yzmNcPFGO6fRasJqsgDYUkdq+NcrcWWsRZxQ
         Q4ES0F94+65Zv6C/LFrHHgw0qhqFtNkLvHXQI9mXgxvNDKkZ3k1jG/YzFIGaAM+ddZqI
         yyf0Uhq7W+2Tq5xnHC5ggu5U8iAy1JzC+MB4UCOpDAVjCsdor1+8nU51YeKltA8zOQKf
         pjRgJmMi35wIkx1E0RBCa/drliiJQmUM0KnyE2fiC2TwdwSXzIXbywH3G9F+hx3gHf3u
         OuVA==
X-Forwarded-Encrypted: i=1; AJvYcCUjT9oJEUVxZMSGupWF+jSQmPxQQ4dFqslG2atHwAWKc3jVhgee16cx9o5MkrEGQbBW+BgdbHdF3LZpFLwXSNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYS2TdZC1Q4L1GNeP3RmRRwaYEKgDVaSX10ciRphM6Enw3bdAx
	sENAyKtvSnp6VbaVA3Hm0ccxWn5UoyZhR4Cbnp8XBNKzslPnsVIrnHvG/WhihbVzAW6DTZRP4DW
	blxTcUm8OiNjlvK3YEyd0yFdsXA==
X-Google-Smtp-Source: AGHT+IGjv4MwAm4QLbkXWrYC7rAHKw9/iUlbnKxWWkdEwdxKvGAPykFMMacviS9dcIIIxXL7XUy6syolfW7Tyi7fWg==
X-Received: from ilbbd7.prod.google.com ([2002:a05:6e02:3007:b0:3dd:b63a:d0bb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3801:b0:3dd:b655:2d6a with SMTP id e9e14a558f8ab-3de38c245c5mr47355195ab.7.1750457931036;
 Fri, 20 Jun 2025 15:18:51 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:14 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-15-coltonlewis@google.com>
Subject: [PATCH v2 13/23] KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
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

Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
to use the virtual PMSELR register when it could be outdated and lead
to an invalid write. Use the physical register.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
 arch/arm64/kvm/sys_regs.c          | 9 +++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index e2057365ba73..1880e426a559 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -72,11 +72,16 @@ static inline u64 read_pmcr(void)
 	return read_sysreg(pmcr_el0);
 }
 
-static inline void write_pmselr(u32 val)
+static inline void write_pmselr(u64 val)
 {
 	write_sysreg(val, pmselr_el0);
 }
 
+static inline u64 read_pmselr(void)
+{
+	return read_sysreg(pmselr_el0);
+}
+
 static inline void write_pmccntr(u64 val)
 {
 	write_sysreg(val, pmccntr_el0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3733e3ce8f39..3140d90849c1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1066,14 +1066,19 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
-	u64 idx, reg;
+	u64 idx, reg, pmselr;
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
 	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
 		/* PMXEVTYPER_EL0 */
-		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
+		if (kvm_vcpu_pmu_is_partitioned(vcpu))
+			pmselr = read_pmselr();
+		else
+			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+
+		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, pmselr);
 		reg = PMEVTYPER0_EL0 + idx;
 	} else if (r->CRn == 14 && (r->CRm & 12) == 12) {
 		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
-- 
2.50.0.714.g196bf9f422-goog


