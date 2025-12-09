Return-Path: <linux-kselftest+bounces-47325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E9CCB119A
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BA1315CF89
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94330B532;
	Tue,  9 Dec 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnbudiAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641B30B525
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313569; cv=none; b=M6MM7IkFu2FcBhuuLg+1PJR7WovPQUxV9O2KLj6CePmdyCPI9AB/+BsMSTKwq4+QO8h2uk75NNwTJq2JpGemgukJ5JlcFBdIhCPDq2XLhaQBEGF8w+cPSzjuCmGwCcC8ZQM8f7Ofvof5G/N7maKcDNrtRyxnKRsXsHCtVSfU5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313569; c=relaxed/simple;
	bh=aCNuh2V9q56mw6LZjRPGjWZ7ahwIMSj/x17VFTK+/00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGQAgVbFkdHU9BrOET+megPOmWUaZ2Sne9HAMVpisibnisypyNesy8ZWHig+JjAEYVvy41g65RwAhkpiLYMJ03lPZvGoZz5N10U1BS765EWcWYYO4t9wgCjxK7pd0mnec89GDTIeNGlZws2du9QsgJdsxl3bScnt3FU+Zy8FtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnbudiAz; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c7599be25cso12848519a34.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313557; x=1765918357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlzYgLY8Hya1ebzZsNsRPfgfqZdf/pfSg0Aip8i1MzM=;
        b=nnbudiAzTnZClv15k4t0Yc2pbRa4HGOi3dVG2BUA9f+ktr3y6dy8ekZBSdVV6W5ikU
         dXpxgxTmAIGjm+NdzTDi81Jx8Kq3U4t5CApVYhy6rIM4oOonEI4uC1vrwsCr86kFlaZq
         MrjvnUhPbEjE/oKyIlusOqDUU8y4yIauCpEhgwE88tSWJTxAcG+eQ0MVvRN4tkJ9hXJs
         /ZTJr5Vw1IYDH8SJi41dlJ6VsNxmPlRhDjbEPXsoGa5G6LR3S3uAQIZ3l758Pfys6Ucj
         z6/ZFQUG8gnFoFBP947sqR0IkC44c2dqqdCEmj+//yqAl2CqReqZjCORCWh/kmB7ouCx
         FuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313557; x=1765918357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlzYgLY8Hya1ebzZsNsRPfgfqZdf/pfSg0Aip8i1MzM=;
        b=hFEERR/8wHAhBtXS/c7l+gOY+CEdeQlrcTriYhkdQ6R2LHL6UBXf/BLqFr0WZw7/b+
         S5rnYTKnC+npYvqRPjlrAG01XB+8SWc/bofgtesqCsVr5loMhNY62oMNKr5DfThV+6Fa
         FLN9YxD+BaJAKd/TUsZpP5oXtMpUoSXUsPWK/Y8Hbc063noRt4IMSOe9dY0syDUM6xoV
         gVfJZOb3bxUQO9453Gujt0+I0mtd7xvEl5cLrBHwtlB2m53COOTl9kuJj8ajIsDvROMs
         gjA66mkoe8cYtubW1wnAVXO7BbhN5MC+XzJ8bB9VCmjcZFRwBWRq3w71f1pKcHuRVijk
         hDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXqoUAnNm2aIrkHkIx5fzLA8+Q8Lo/MhDtcCwWCl9hHkocVyT237KLOx2Wjc4W/Jko2XbVUBVbwFzMHvAqZvnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyprtc8DdtBmMEa6gelnWTtWCShe/DGwcdggkjI0ZSYsq4CB08p
	kQML0/Q2IGqTjkR7K8IIYctkU9Vy62D7z4XVdDrTcAo2mXWzrlWiZit78FdFhT12A+Ncv1Ul1I2
	5GCTV9s7xWWELzoLe5xlgpXVKag==
X-Google-Smtp-Source: AGHT+IFjXkWMzT4yuAEaLB+dJ2qXq9BXOkkzzf3nS3SdXsepbg3bqK/U0WpaHKFNBgIw1WNvMEX2vLOAaq9kL+8k3A==
X-Received: from jabhd27.prod.google.com ([2002:a05:6638:4e9b:b0:5b7:56fc:a47d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:6acf:b0:659:9a49:8f3d with SMTP id 006d021491bc7-65b2ad9f5eamr96621eaf.78.1765313557028;
 Tue, 09 Dec 2025 12:52:37 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:08 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-12-coltonlewis@google.com>
Subject: [PATCH v5 11/24] KVM: arm64: Writethrough trapped PMEVTYPER register
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

With FGT in place, the remaining trapped registers need to be written
through to the underlying physical registers as well as the virtual
ones. Failing to do this means guest writes will not take effect when
expected.

For the PMEVTYPER register, take care to enforce KVM's PMU event
filter. Do that by setting the bits to exclude EL1 and EL0 when an
event is not present in the filter and clearing the bit to include EL2
always.

Note the virtual register is always assigned the value specified by
the guest to hide the setting of those bits.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c636840b1f6f9..0c9596325519b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1166,6 +1166,36 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+				   u64 reg, u64 idx)
+{
+	u64 eventsel;
+	u64 val = p->regval;
+	u64 evtyper_set = ARMV8_PMU_EXCLUDE_EL0 |
+		ARMV8_PMU_EXCLUDE_EL1;
+	u64 evtyper_clr = ARMV8_PMU_INCLUDE_EL2;
+
+	__vcpu_assign_sys_reg(vcpu, reg, val);
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+	else
+		eventsel = val & kvm_pmu_event_mask(vcpu->kvm);
+
+	if (vcpu->kvm->arch.pmu_filter &&
+	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
+		val |= evtyper_set;
+
+	val &= ~evtyper_clr;
+
+	if (idx == ARMV8_PMU_CYCLE_IDX)
+		write_pmccfiltr(val);
+	else
+		write_pmevtypern(idx, val);
+
+	return true;
+}
+
 static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			       const struct sys_reg_desc *r)
 {
@@ -1192,7 +1222,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
2.52.0.239.gd5f0c6e74e-goog


