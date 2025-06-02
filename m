Return-Path: <linux-kselftest+bounces-34164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9882ACBBA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C811886DBC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A722D9E3;
	Mon,  2 Jun 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW04qRes"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28222D9F5
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892555; cv=none; b=vD97D270ZFoj1raIu+xdn59ta+bqBVfujVafI5XGxsLZI+Pe/oYBWJ3AEwzQXJx0uLzeAI3TA7Tk2WmBIegIeSBTZ4MKPGx3D706OS9AXFp5bXZEdahG6HEW1qFG82KcyyQe6cWknbBRELpDbnkO3VIY5mRglGnuqR6FpShRYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892555; c=relaxed/simple;
	bh=PoWjuOi8eYoIqV1zexvNE+wuPqOMbkZ5+/3Bw3NmTHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJBEEBGDFiX1oSXb9/Hwzdg7KQ0xAVhu6E/hG9sR3pkAKlKWin+M1gAHEgCZlvre/VVcpvKcmpyo2rBcJ8wzbZAEXKAwOPPg56wbSUVoqRDN2S+OizJqEA31lDepqtwQxHIFrujt9Zbr/oe82IgP7MYIvYphIX4vCjANdXZ9IfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WW04qRes; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3dd789f3b99so99215625ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892549; x=1749497349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/Q7iQgArbZ1+tQ0dSc/WoTlOEBgZJ24X0IeGAOsgLg=;
        b=WW04qRespJD8GYTYLixvcguycs1Aj2zrL7TvjricfWwD7ZgBOeXwyGcg1gg7nmq3jp
         w+GeDHsaHGSMcc5vsbmgV8etWE4jQ2r/kr91rBr5k389v5ize0kAmxyPcx1uR8uXmmZq
         y0U/nH3whXtdzFYWhK1CmDSPEdGVSYF8C5/77WCi7BUwtypYqmbFm5Vq+vCPPVMa1Iz5
         AmdjhzqaxbtplI7QLwuGAZoEjRXV+jtBSU5fZNMR6DE6m80Ji1gkc7bBHLfQBRIM+5/T
         1iUKUCnZx+SBffTXJ9iNn6TVk/BXddu9Tw9+4N6irRdK61pNrFZQwN1B4YQ8V7+t0ySl
         KGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892549; x=1749497349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/Q7iQgArbZ1+tQ0dSc/WoTlOEBgZJ24X0IeGAOsgLg=;
        b=f3mvHrrdiUYn7+4wKPz6ncZdXryPOE7K+/q+9GpVhBhoiNgdx7pBi8hHy0Kyp1Skdl
         wqo8rn6L3dzS42MRLrJUXw4//nw0gDz1MZey0VGP3y3rkZcdPDPpM53Ffr98SDE8SYyA
         vXe0YLLebZE3RPHINqhJiCuUZG8ZxU0b4UMUuEUfN2ZOMe5I0+by4W9VgXRciDtnx6dC
         skMXsRKIr3ZyCnnkY9pUMxAGfb1rB4egYvBp8o3im1FwOmUmEBcNfzXVfNiaFcZj4J3Y
         r3lgJU44UEGncebqg5NbSQuM9xcPrJFDQrPZ6v+RCVaepYtv8KawDVhGHYsLPkW6mW4M
         XBPA==
X-Forwarded-Encrypted: i=1; AJvYcCUvGbDwQrunpiYymmlOSKJ7XCXr4DLg9z60gUBo7MR+9L5Fr9GtAuzh1pSoOJkRE1kAgexpvZwmV0Nj8Mdooc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrT5yLXje0sw4hs/sLyI+dmKS1iV/anUrB0yKvH5dihA4p/j5A
	eLsQMLnZjx5HKceUbnhY8dLfl4oRkvNBYdLEosaTrE5iWdPIovi0QBMUM/dnESDksgYpm/TDEYU
	ILpTKnfB6wONNpWMzTDIi3F0P1g==
X-Google-Smtp-Source: AGHT+IFh0r8fdtRevJfULp2m0AI+wpxfd5UxvO3vZFtqup+r9hHTOSopW5KVBegS6S2BOnnva8v5qQTcx27amQki3g==
X-Received: from ilbbn9.prod.google.com ([2002:a05:6e02:3389:b0:3dd:a4c2:242b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3e02:b0:3d4:3db1:77ae with SMTP id e9e14a558f8ab-3dd99c28958mr177500035ab.18.1748892548842;
 Mon, 02 Jun 2025 12:29:08 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:56 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-12-coltonlewis@google.com>
Subject: [PATCH 11/17] KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
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
index 32c003a7b810..8eee8cb218ea 100644
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
index afd06400429a..377fa7867152 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1061,14 +1061,19 @@ static void writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
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
2.49.0.1204.g71687c7c1d-goog


