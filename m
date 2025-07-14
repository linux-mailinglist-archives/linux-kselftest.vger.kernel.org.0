Return-Path: <linux-kselftest+bounces-37305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF20B04B4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9782F4A66D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5A27A448;
	Mon, 14 Jul 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiwBTgsO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1F289805
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533987; cv=none; b=eWC1a6MyYhQdWjR81ddQP2OX/cHxkZzkDrxgaSzIIPnwhHtXg5pTy571sh2SQh+jRUQLAHBRbH0A2oQEYp53tLdNCK35bHP/zG4vS+iJOpuJEjo+cY9f/dIcNHuIhsHSE+DTgHDNZ01NH9UsZ7H7yLzRMKKhnIEiS/mKAwbDvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533987; c=relaxed/simple;
	bh=1oRYKgyodAIezFvFunmY4ZgugzoQY527IXPevx8VDmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYbqSJUsjGasB4AbA9GRbcguNC2pd2KulCxshcvvwpX7XpV0dHlwa50+BRwt/bg8XW2Z+jdpByNhdc6QIodSnEGmqqJhW90tCU/4tR7u8PM91LKRGVw4hzDF8aVf9V641kiuZiWSb3CJkG0byrwjAHtBITYTAl+NCgX/5eucU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiwBTgsO; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so880632839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533981; x=1753138781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwV3+W7/ehj+b6ug0rN7nGCOEi4xiU5YZ2CQkSQ6/UA=;
        b=fiwBTgsOP2dUbPoCv5EqMcnQyXxubiZ0MqB0K31VGMKV5RCdk3iijhD8h2QYdCs4tt
         qn8O8iZs3lHXwbKjozwPRAMhzT2BbpsBi1Nyv/xJazBDVA9Zuklt0/0nPE8FjcWsuFyP
         BmL81OfpaWBWhkOVEZFiSAl2pYhYBj6vbdDCNZztFdy8pVLgwDqpVEZqs3gfNISst22t
         g6MCAi7Q2AehQyx471hCeizzYi6Nb6rVf7ZU1w5qOxWHqc719Hxt2KQiMJkBbzLBdEk2
         HlbGTv2T7xO9xJYnbcajc9xE45wCPyxeXRFDOBOwa3YyPiQW5nvn77z+0Vh/55MID166
         r4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533981; x=1753138781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwV3+W7/ehj+b6ug0rN7nGCOEi4xiU5YZ2CQkSQ6/UA=;
        b=dkxLtceAgyBs13YNH8KTCuAzMxjfCLAcQEaQESr1cSEIQPdG0QdTcYHzhB0GFXF8g2
         BSAC5pFiIQn4hM+EeA6mbQ93s4xg/a2+leDnMrR3j8bKySwoSbL0w+mZQFtwQ45oA67E
         hBlwwiPnOTaQRHgWJE7AxZNSD34IAsTbc6wwk7fWvh6Ge53iwkT7CX7yeG1PU0n2ngdU
         p7JsGECYnsETIzTb8clOAOK0JPoR57JcT6M3VrVbbuSPD0U/WhPWSeaLN41zcbGh15yZ
         gODmX5ohDBddhFMk5UEYk5ZUXQqip8saTyY8gMEV1EBgJhGP2Nej/inAhL4TEN9/wG9N
         1vVg==
X-Forwarded-Encrypted: i=1; AJvYcCW8gFgiJElERRRSc1bKlAc44b2P3gBqrMmzAGNFEayqhKXcMNZAfTsSe+5h9KQZpLWskkFimf9dusSInQm2maM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjADW588kw09W/zow7p5FfIyDeraSX0zteWmDrLiYK7BGlniiw
	Moorzkq9CORzeW6XpAqcpKPk3T1Do1FcUj+cxRn7ISMwcpY5qInXje2M1IArsiCCr8M6i4CuFGS
	f/dFJ9OD2q3brKUhFek0wd/03PA==
X-Google-Smtp-Source: AGHT+IG6/Fx4XUt6OiaJ27GEFxRfFyj/zm2cocalWyZGbwfyqaLHqaZuCwZo40dqJJR4NG/NpTcvClqhKJzVbklHQw==
X-Received: from ioge24.prod.google.com ([2002:a6b:f118:0:b0:867:188d:7f6c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:2c95:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-87977f7198dmr1861411639f.4.1752533981283;
 Mon, 14 Jul 2025 15:59:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:05 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-12-coltonlewis@google.com>
Subject: [PATCH v4 11/23] KVM: arm64: Use physical PMSELR for PMXEVTYPER if partitioned
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
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
index 27c4d6d47da3..60600f04b590 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
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
index 704e5d45ce52..e761538e1e17 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1063,14 +1063,19 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
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
2.50.0.727.gbf7dc18ff4-goog


