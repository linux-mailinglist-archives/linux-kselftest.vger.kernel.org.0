Return-Path: <linux-kselftest+bounces-35483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C205DAE2535
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6677B09D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328A256C70;
	Fri, 20 Jun 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRuzgIXq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92624DD04
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457935; cv=none; b=njVlfbe6yla+Z6gWzdXivity0Zb1n+U0x3CTj/0QPKlEPrEavU0AT3uO+FUg7TNeQPQIoEAVjCHYSkJnB6wDGVVHtrlitCVkd5LylqU65XQe8RRvNcPnRUqrG5dMg6gi6rLgmXfBd27OTa9U9DN1xI/G+ZewzBfECPF105igra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457935; c=relaxed/simple;
	bh=M4XcPGm72140qEI7iQ0ptN69kSxOw9Z73/VRQYhovoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hZGgzg/ymqj/1S3tnnfDzCcWZxNEfzdUAq5bAg9i/OiJm+NW1NlZli1dYp3up0HfZ9AAlYr7aHF/F0v2jf7gMA7za04YtfOoCBNFSKnET9rOk5yTMfWd68IUR5+GO+P28riqUaqelI3/XdNfnxHnoCiqzrydVMmD3W+3ypz1660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRuzgIXq; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddbb34fc1cso26075195ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457932; x=1751062732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUwcqeVf5KIMoAmCHhrWA0WRgfRVQt5PquOGXBH2GsU=;
        b=VRuzgIXq4ZgNE2gvTj71GUc9AU/hjLFwatQGAzWzjNevoK36wahhQY6S9aazL7KCwq
         ljqlE1RGHjnGvwijGn7kO5dSWBBT8eAt+o45gJB6ZC8/nPyYJwPTRRCj2k5qCdVKIh8G
         t/on6l8dAvs7clgdCUduiEl0pG/XSe2XUMB7vOVfRSIjOvWgllgG74CPpOSCPNHqKr5O
         lMyfQjJukJvgL2VyKMCoaRr+72yhG7dkOwgJ5Q5ozpaLuqa9wS9MtA6iE8NGFkqSyEVc
         eojhLOc3QH4t19pjDztmb4YBFXBfhCXkVYDyI2QFyVE3YgzyTOICYswaAOpVSMCznWNv
         6dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457932; x=1751062732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUwcqeVf5KIMoAmCHhrWA0WRgfRVQt5PquOGXBH2GsU=;
        b=DM4bzMQBZ7matgNzHjgnfvXFfHQj7cfSabOluDm+QU9NiZGPvkZFStBAP4BI+VQl6R
         qGD/b0RMcNasj2aFcQP5BjcdT3bGwUh/maGMBX4xH5OgXDl0GRIcUBNbbvHMhfOSHy25
         y1SsvcZQ9WgpkYDm06QbEdvFMk1HERKVYLBG9UCnJY8VU+N2FmkN7joUiRtsuBu2l8rp
         ys9Q5kLg+iizQmCUQBpFyZLhwz/WV2D4HmAKpm+iijq4c9Wl+9zDftIwkAptnZPO1bmq
         SZeCVhpFnn1u8k5ShlWtY5GbB7OGqjtFUiy3YMTEIC2IUS8h4c16KFA9t4MQlMvRucoT
         uuiA==
X-Forwarded-Encrypted: i=1; AJvYcCXJSpEDrQtXw+momKPgEojKsrwCGSRO4Whh9Xh3wvLq66KnKXLnd9O1bSY9tvq6JWZQQ8Hb1dM5voZY/Cb12wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18iNcBSwkDQjRcpyONRX+dGkCcbWDyoU/3/EPxdWZVrpcr4BI
	5bsH9OM/dag4l7wBdy+3oF6N4bpW14MticgXkPIE3rP+HwWcnSrF+9IFsvyZBcPI2uegYrnawfE
	4SMAsaVf1fn4UjTVL0aUJYgbG/Q==
X-Google-Smtp-Source: AGHT+IECQiJFomMTnsPbeme3Oi7RJjR0YLkrmdcXG9nsdHvxsNa0RAqjFaN0Cl+MqvohmdUapqaunpxSDwgZDSywoA==
X-Received: from ilff3.prod.google.com ([2002:a05:6e02:5e03:b0:3dd:a3df:9d57])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:16ce:b0:3dd:d653:5a05 with SMTP id e9e14a558f8ab-3de38c1bec3mr55840665ab.3.1750457932182;
 Fri, 20 Jun 2025 15:18:52 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:15 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-16-coltonlewis@google.com>
Subject: [PATCH v2 14/23] KVM: arm64: Writethrough trapped PMOVS register
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
 arch/arm64/include/asm/arm_pmuv3.h | 10 ++++++++++
 arch/arm64/kvm/sys_regs.c          | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 1880e426a559..3bddde5f4ebb 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -142,6 +142,16 @@ static inline u64 read_pmicfiltr(void)
 	return read_sysreg_s(SYS_PMICFILTR_EL0);
 }
 
+static inline void write_pmovsset(u64 val)
+{
+	write_sysreg(val, pmovsset_el0);
+}
+
+static inline u64 read_pmovsset(void)
+{
+	return read_sysreg(pmovsset_el0);
+}
+
 static inline void write_pmovsclr(u64 val)
 {
 	write_sysreg(val, pmovsclr_el0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3140d90849c1..627c31db84d2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1174,6 +1174,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p, bool set)
+{
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+	if (set) {
+		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
+		write_pmovsset(p->regval & mask);
+	} else {
+		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
+		write_pmovsclr(p->regval & mask);
+	}
+}
+
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -1182,7 +1195,9 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmovs(vcpu, p, r->CRm & 0x2);
+	} else if (p->is_write) {
 		if (r->CRm & 0x2)
 			/* accessing PMOVSSET_EL0 */
 			__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
-- 
2.50.0.714.g196bf9f422-goog


