Return-Path: <linux-kselftest+bounces-35481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90EAE2533
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60E3B0552
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7A255247;
	Fri, 20 Jun 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z21KhWcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07752528FC
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457934; cv=none; b=QUo5OldduBnBH6crwo84H2Lv20eF4gKaiDoEgZVYGBvl7G3Wgajv2pnmp3Z3qvlNWJRs5sEYyw5bqzFXxCdfd9DqQxmgXDUdYlAebosejk0cLLVhvki3XBXNUUw0Br9q3triXoV0Iw+kWw9Xmt5NWVU63Q8/hvhtJKkHr7AQBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457934; c=relaxed/simple;
	bh=9RsbMC4gKstOTyv5y2QgORYLw5zb7ZTQrMSj9VZtIh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuSKAXX+N0+/ccl9Sbk9+BxtZss+TC2y3GqCxV876LAm3akFCeemygXT5mlXLAi0kYkOCvyaSrHnCzi2jz5RaJhXlJgIxq7Ft4M00c95ivGkW1DUvFUD3QN6prSSvCoIjQCxw+i5SFBvmAIsDpyFUfVzyk3i2YVF4+l8cDMvebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z21KhWcP; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86cc7cdb86fso181812239f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457930; x=1751062730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vRk6zke2lpK9XGCO0Sj8vZO43QSodRcPYun9h3GVGY=;
        b=z21KhWcP6OWvUOHxu+sQEHvr7e7IyX4i8hAqsCA3B1ZXm78qRBOtzPV1m2xtyBox8f
         fiF4c7OFrO6B69AWqEvgF+GpNlyOIl2OQV2dmlajYuSwn2fbELML46DskSrNqwlASwKm
         MjNhV8g+BDOwjZGI/e6qVm2cuil41sb01mdl8tijhcQRWfM3l8OyOUBwHzb3PrqEWAkI
         H09SRfIyPpDokCpedUnFUg7dwh5lyTdAVjCP61b+suBkoQ0PFsoEzjeNhEAqFTRQu/0P
         rGXzRO3etLYcGI3/FhQMfJTdYxKOcAW6w/WoSbD/DNU4TDTmTruRtYYsB3CbYEj/UD90
         P8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457930; x=1751062730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vRk6zke2lpK9XGCO0Sj8vZO43QSodRcPYun9h3GVGY=;
        b=qcKEQnorMoMC+/RwnNX5pUUg9Muu1k8xmkOyXvdnseAbtSPYjSmZwCQPcZb+dmnXpj
         /nEeRy5D9ctnnbwht1HRvMAUIxSkF8vXsapaZdHBv84q73AGxKF1T0XNkCsCJOnfoahA
         cEb2N19T9RVu5TFYFc8nnFlsNfrFkxU6a1aXbfhg+R/ZIc+GNjwkEjJc/OP3czJhrbE4
         vMt1ap8yrLAGfBI55mbEqSufm4TVZbhmxHpK2dQZpqjcpT7NJMjfQf4MT/kexbgsxzlf
         kvsJ79JvkqJPJacG76RoMfhqzhiDN/FM/M+0HAO9VHS/h5WmWRlt88S/A+3wcUEF6qZT
         fLmA==
X-Forwarded-Encrypted: i=1; AJvYcCW5W4HhAFy9GeD8JVc2HsHXhR7U944lVqO2lqcGs/ASdUKquv8I7Jk+WlCt+ftI+76zMMuy4VDS+SiQ17FUDtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVdax8O8PqBjZKrmnjdRpXHYziIvT61XR0YxQUl4yzq4rWBKE
	SZqQmUnrnciVxhc5KefPGwCPQxGk5ySV3mA6RDju6oizte0scYDdfSAiuVoNMuXd63ae/hlyTWZ
	dcYRNgfXywLQa+YLqUxEaL1Uf9A==
X-Google-Smtp-Source: AGHT+IEkoSb5VH84QY4nbT8Ifa51AqeoGsCAL340Tv3oIBa14LiCdgJYJOfuore5wja+yy1LW8r/DPYGzutAdJdswQ==
X-Received: from ilbbb11.prod.google.com ([2002:a05:6e02:b:b0:3de:11fe:800c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:17c7:b0:3de:287b:c430 with SMTP id e9e14a558f8ab-3de38c1ba23mr58907475ab.3.1750457929911;
 Fri, 20 Jun 2025 15:18:49 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:13 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-14-coltonlewis@google.com>
Subject: [PATCH v2 12/23] KVM: arm64: Writethrough trapped PMEVTYPER register
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

With FGT in place, the remaining trapped registers need to be written
through to the underlying physical registers as well as the virtual
ones. Failing to do this means delaying when guest writes take effect.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index eaff6d63ef77..3733e3ce8f39 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
@@ -943,6 +944,7 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 	u64 pmcr, val;
 
 	pmcr = kvm_vcpu_read_pmcr(vcpu);
+
 	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
 	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
 		kvm_inject_undefined(vcpu);
@@ -1037,6 +1039,30 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				   u64 reg, u64 idx)
+{
+	u64 eventsel;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+	else
+		eventsel = p->regval & kvm_pmu_evtyper_mask(vcpu->kvm);
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
+		return false;
+
+	__vcpu_sys_reg(vcpu, reg) = eventsel;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(eventsel);
+	else
+		write_pmevtypern(idx, eventsel);
+
+	return true;
+}
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1063,7 +1089,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (!pmu_counter_idx_valid(vcpu, idx))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmevtyper(vcpu, p, reg, idx);
+	} else if (p->is_write) {
 		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
 		kvm_vcpu_pmu_restore_guest(vcpu);
 	} else {
-- 
2.50.0.714.g196bf9f422-goog


