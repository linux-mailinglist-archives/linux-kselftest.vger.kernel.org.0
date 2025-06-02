Return-Path: <linux-kselftest+bounces-34163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D69ACBBA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED893AE435
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC37231C91;
	Mon,  2 Jun 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJPoXRM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997922DF8B
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892553; cv=none; b=J5wskhLEcJ4RcPXgjNmIOmqEE9Y//Ck8z0r6k7Hxhz5jDd45t41mW1f4Q9yK52bFtyjHlRkjn4euJUm3rrA5nOHqipBHAmKXelSOGGR9zwjuafOVIu9CNF4lIRpyWxlgITFOuIb2MXMTDGGuJYC7Q14Egrq2ewbqFjLu3j3WqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892553; c=relaxed/simple;
	bh=gJd6Sg7X96ujBJm4xpL0n0BwR1+EO0NbIRmkP5OmPT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EoJi8w2ZPZMBwkyuNZeWHV3wCt1gYVLBVDQYgNB0ObDCLmSKqttFLHi/dtLj0YJWBqqDUiMPJnSzPa2SWsYi2qVNcsXkBMkTtEQWRQMUNewS3OUzLLWC/Xm0U0ERMBca+8K8Yh5vyC76bg+3bxu+Bdl9tMaZ9hiGUu/hjqwYToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJPoXRM0; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddb4ed2dcbso9577735ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892547; x=1749497347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRqT9xxCS8Kun6mHdSmbCCnl/MV3abA8LdyACjVeWc=;
        b=jJPoXRM0BVG9y0DfHxdv7KEUrF7FUc/unmtfGpMvTs5Q6kqBeTVPZoPbnIR/LGtltY
         3VfNLV68uzcmKpShBwZdeIn2nc0horX+isDFPhqunBwvZiJaoT6dBZUDrLwocvRVlxmC
         ypMfInTy3wn4aem+01zskMCLnILW+S58THYyChI4xom4dpABTQcBRUpt5+Xf49g9biyB
         ouoX4teDR0DBhvZdbmSh1zVR6xkbtJsndd/hiq0/ubSiUeyAsIG20zewUG+TVpaK6Me6
         gIaJAis+GHb+NWa73Q2L0M6QhsU2+TUjW8nC9t8lwcz0tMbr5K4X/0sBHrWDLFKcHSd9
         nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892547; x=1749497347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRqT9xxCS8Kun6mHdSmbCCnl/MV3abA8LdyACjVeWc=;
        b=CiTagcMLU+L4yW4d93FuzZgkf0N1nhMEOkrd/leMC5VRqVuaTpTjpLNUtzQStO5xKy
         Xbp4VJjojNCtzBAiLIhFZIYMgGb4MSaUo51esmDCuAmOKequB4Pw14DHbPLFh1eixByU
         euKJNzRHQQ9LjaigyjC0SMQQ04MtW16u8TEUTw1FsfSJj4XMIzhXXtSUv6o+VIb5RX3T
         hihKuUgnQgcyDvkQlUtPtYPblRX2MaLp/ao27DhZGM9dTpNa/HBK48ZK2o6J4OcdeOxm
         i//Jdo5jNh7KX9Ueimth9aJyIu58aUbf/U3gfJ1XH7XdSTarYcltI2J0qPWQYivLFMQo
         vbKg==
X-Forwarded-Encrypted: i=1; AJvYcCVAQQTvN7eJDI7B+/LfpN7ixVZh8bo9vzbGaNybScVc3VcR745CMFBDgSVjk6zug15pC9AG6f2DxUD8JTYr9QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQul+SDiwqc7ZdXWFjR6rKOpEZA3VJxfZzspxD7u3aEPIhqdf
	ZmP/zeM05ebVTOgSw1KWBL48McIXN26TtIMmwekv/Bk4DcnTgI+xIOB8ohCTCWVDe/b0iC1afwO
	832o/rA6hPWshMBD8028mq8bisQ==
X-Google-Smtp-Source: AGHT+IFMVeKyETkycXmBUpASHlOBIqAlJOgdAa/bpyVkcS9jV+S6qkzUphiHGfVK6q8KTzMSYrzDWRGuInC2fMT41A==
X-Received: from ilbbk6.prod.google.com ([2002:a05:6e02:3286:b0:3dd:b580:4100])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:4515:10b0:3dd:b5c6:421f with SMTP id e9e14a558f8ab-3ddb5c642c8mr13690965ab.6.1748892547783;
 Mon, 02 Jun 2025 12:29:07 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:55 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-11-coltonlewis@google.com>
Subject: [PATCH 10/17] KVM: arm64: Writethrough trapped PMEVTYPER register
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
 arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index d368eeb4f88e..afd06400429a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
@@ -942,7 +943,11 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 {
 	u64 pmcr, val;
 
-	pmcr = kvm_vcpu_read_pmcr(vcpu);
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		pmcr = read_pmcr();
+	else
+		pmcr = kvm_vcpu_read_pmcr(vcpu);
+
 	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
 	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
 		kvm_inject_undefined(vcpu);
@@ -1037,6 +1042,22 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static void writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				   u64 reg, u64 idx)
+{
+	u64 evmask = kvm_pmu_evtyper_mask(vcpu->kvm);
+	u64 val = p->regval & evmask;
+
+	__vcpu_sys_reg(vcpu, reg) = val;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(val);
+	else if (idx == ARMV8_PMU_INSTR_IDX)
+		write_pmicfiltr(val);
+	else
+		write_pmevtypern(idx, val);
+}
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1063,7 +1084,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
2.49.0.1204.g71687c7c1d-goog


