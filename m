Return-Path: <linux-kselftest+bounces-35488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCDAE2557
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EA316800A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2225BEE0;
	Fri, 20 Jun 2025 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4L05MAEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588C259CBD
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457943; cv=none; b=eUX5vQPOHzDJPndyy0iOSt3UiAzKC4lCZT6lBoJ9xuXfnQpTqT5nw0+dgWzjItSH1JL5QrvpGVV6r1eaMdfSXQ0TS4m+jt5liHjYNjNas3nZOHMZXySz6EWijJkn6Hg3A8O8evtpr0QnRPoyOGxnfyzzqVOUCFl0K0X2qUDwZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457943; c=relaxed/simple;
	bh=yMGaPG1CZQkU3Bq8XdwQsHNu1kFzSYzZgl5dA+p/rKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFCydw855FDUCtyFMoFVBLNzZq1HYoHd84CVFSI3JqtvTx7rB/p1rAKGJrEZd0irzJgn2D7UUhpginT1FJkt/H4u9ONF8PafGo0906APHN690vmhVj8nLWZRWDjNysazNknOlz2FRwGIHJq+b7WIWzCrMcxFbbM6JFlyjHp8MvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4L05MAEd; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddc5137992so27491865ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457937; x=1751062737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=evXfKUBhSeG+2oly7f+qnRnfAE1yqFxCmvksu6Guakw=;
        b=4L05MAEd9mBEL8yU95i3IBx5kciKhcXWgeqgGyv2qKblvATzu89jWtccYMwybuTNrP
         0Y7cMvGjd84bgA7H5wLSrdeiKjLIFiwDCC76vAZnTdewMhsMtq2nYkpbxlit3rO0q7z0
         ixy8Vras9MBVijExVSrgLBCrQwZUetK1jdLA+97kzLfvH/m0HaK55r/aeNmfKwDqE3M3
         WzZq5KNsqEWlDSlCetxInka78F/jj2l48XZhH7cE2dcczPgHWXQTQ3Jtpohk4ceNA/z2
         NNw9Jdu3q+UybwkiwEcdEEvy9FCpEndbxye4hnfInlBmncJwTdvhpDXLUWQaJ0m1ecVp
         DAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457937; x=1751062737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evXfKUBhSeG+2oly7f+qnRnfAE1yqFxCmvksu6Guakw=;
        b=KAMbUJ5LZEW6JWzjk/GgmrB7d070uy/xMAKKsRnTB48+Qv9BbxAPZWda5NpTcZyrY4
         PsQVzO0cGHXSIX+STZaAUGwsu2mXSxboCZekNJPk0oKxgdRIlv61hcnu00F8tWB0b5dG
         p91coSd2DYjDp/Se++JiCG/Rg8aSaLycBaizmPZY/Zr73Ad+7Dt5SJ1Va/AzaRTmjOx3
         vxIgnD6TGXA1VVhpWzRyYm26PcjtWAZLBQUQQ+YTeXNaTfsACBbpY0eEcTaPxBFo3VJh
         lAYK7Z/ls2/C2zIdw6VDw2FynKqEalHDCNPC8lg6fG8DJcoAC5tkVvNLJ2bLIn0cVHkU
         lrqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxp8q7BQGgQHDaVhHGCmf4+eNWFHaMW9hSSTVv3uYp2qeyTROSvOmoEZeAB26iV7gcrH7xhoMC7ty0BkWjEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHKhflvzNhN1v6PZqXqBI3tqiS/6N+M0AN60U8RMiFC/4M81J
	huZ667y0iQuGRtfAINSd9/wNUzkZbQzqMGTpcuBwDfo5f8BUFG4pR+rPGXfS04uF3tPg20IB8LP
	fvBxPvcbHTXWqpuunnojs0QFsVg==
X-Google-Smtp-Source: AGHT+IFQNwOuHEkKN7g4qywdhJQMH3Ei639Gg+Rq7B3OB/2GxQkU/gqG6/aq0ZsCLexdUvss75SIoe73NPnJzqeZ9A==
X-Received: from ilue6.prod.google.com ([2002:a05:6e02:b26:b0:3dd:b662:5c3b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1a4f:b0:3dd:bb7e:f1af with SMTP id e9e14a558f8ab-3de38cdcc11mr49042745ab.20.1750457937447;
 Fri, 20 Jun 2025 15:18:57 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:20 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-21-coltonlewis@google.com>
Subject: [PATCH v2 19/23] KVM: arm64: Enforce PMU event filter at vcpu_load()
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

The KVM API for event filtering says that counters do not count when
blocked by the event filter. To enforce that, the event filter must be
rechecked on every load. If the event is filtered, exclude counting at
all exception levels before writing the hardware.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu-part.c | 43 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 19bd6e0da222..fd19a1dd7901 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -177,6 +177,47 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 	return hpmn;
 }
 
+/**
+ * kvm_pmu_apply_event_filter()
+ * @vcpu: Pointer to vcpu struct
+ *
+ * To uphold the guarantee of the KVM PMU event filter, we must ensure
+ * no counter counts if the event is filtered. Accomplish this by
+ * filtering all exception levels if the event is filtered.
+ */
+static void kvm_pmu_apply_event_filter(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 evtyper_set = kvm_pmu_evtyper_mask(vcpu->kvm)
+		& ~kvm_pmu_event_mask(vcpu->kvm)
+		& ~ARMV8_PMU_INCLUDE_EL2;
+	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
+	u8 i;
+	u64 val;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
+
+		if (vcpu->kvm->arch.pmu_filter &&
+		    !test_bit(val, vcpu->kvm->arch.pmu_filter)) {
+			val |= evtyper_set;
+			val &= ~evtyper_clr;
+		}
+
+		write_pmevtypern(i, val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMCCFILTR_EL0);
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, vcpu->kvm->arch.pmu_filter)) {
+		val |= evtyper_set;
+		val &= ~evtyper_clr;
+	}
+
+	write_pmccfiltr(val);
+}
+
 /**
  * kvm_pmu_load() - Load untrapped PMU registers
  * @vcpu: Pointer to struct kvm_vcpu
@@ -199,6 +240,8 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
 	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
 		return;
 
+	kvm_pmu_apply_event_filter(vcpu);
+
 	for (i = 0; i < pmu->hpmn_max; i++) {
 		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
 		write_pmevcntrn(i, val);
-- 
2.50.0.714.g196bf9f422-goog


