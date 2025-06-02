Return-Path: <linux-kselftest+bounces-34165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E282ACBBB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9B1172F72
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AF233727;
	Mon,  2 Jun 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khYSWuyw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A122ACEE
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892555; cv=none; b=YxKU5wIBb5krkD0LsGgFXPockPZ3iMehNfn4M3/1g2njbkWA8V8duMVOOsnPh41Xr2fJSU7kdN545JscWtuZ7AY96MuZg8qOzF891K81qfRijFyMK/8NCnMfP2TaoR8SDgTmG8fPGNd4X57iQAFieo0w1X/Q+6AnnJYy2f92bG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892555; c=relaxed/simple;
	bh=RyYQY6ZWwMFc6nT32sVnu5XE9OeBNCLMJOkY/XJHt/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bntBYBFiGsXZ4/ndpnjsY0cek2gyqwltYbfzZxffkoUBhuWY/0HrRTXynJReX9j6Jk8onbnnj6q4ZjXniswRDmWSPHS3Jboq3pnJSWPH71N/BG1RI9OXVAo9W8kR8Mg0hkHcM1VOzITFTD5lL5D65fSjM+aHItigKz06oWybnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khYSWuyw; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3dd81f9ce43so52009105ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892549; x=1749497349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkgTT4wWRbZ1NUmf838c82NeTMr3HJQoA5BVqQ/v/iI=;
        b=khYSWuyw9HzV9FkBarCb6oz8b1yjArseGBHZtLRrStnwQdQn5DF7MhufpBb4NfxvMh
         OsjXzTjjP4fHMuk2FezGNy4xf8Vty7S0uKtNFnVTs3FVlKh8tcMdDmg7cb+chMpfpedE
         4iXCuvd/VHgOvSFl8Sr6jFeYLGEOEWAhfi2kVgRAvJccjempLfqyxXSNQwImUoNJvR4B
         UMcydgI1kYJM50OKNt0pjsuU3FkMow6Se1gQew4QboHe8wMBU0haeSd5Ss3N1239N/6O
         QTUxs1sEhSgYbXEPeFqxFt29fCGhu9N7n1WeEYzUfOYmC76AZ5r9yDz4ToRBYHS5JwAW
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892549; x=1749497349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkgTT4wWRbZ1NUmf838c82NeTMr3HJQoA5BVqQ/v/iI=;
        b=OJRq5aIMfUS02c3bcSABTx1d98JR3VRb8ywyIjsGj5rmZmHFV85RhlnHU8lpFt2zIM
         yNNhYHwbwdeN95f69gODnT94ldAMBAwjBvPJK+YtAG/lr6zrvMMELXwdoQt7X7GaZRcZ
         ppU7T3VUGONVwdVtlZaPcULs1xU3YTpjFrbJoSqV49mNpPuHgtMqMwZ44WnYwvAaJVnc
         HPS1yT5YRy+OUU9hcAaRFBVXBCOit+KcQoo98heBkGphRVop95dHqvXNBanFtb1tXoP6
         8IhoeKF1B8ERaO3U34k2Vvzl3Q2V0kecq6R/mzcdA8yA/VClFCzfQ9IJeyq8XpvLGxdb
         pVyg==
X-Forwarded-Encrypted: i=1; AJvYcCXAWoTqf5w7TbL0zaRky4CvaQrOj6DFpHK/n5CI791gOqlbx+F6XcSsh3rQ8zlRFRJrzUgCH8B60VeFR+8Bd3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPxCrX2R5AWpLrp9bSvD5b6RxnCBavUE7QZZpcEt8/fqG0Uwx
	4hoaB921ElLrcqsxJ7ZsmDQJODtxSQWIHBx9fURpdXCwpWngy5rULgnvUkxwBxgr0HtBWfTIoB0
	IjS7jRYqDajTprom85+vJJ6ql/Q==
X-Google-Smtp-Source: AGHT+IH/msiP+hJPT5a6q/xsva/w/itdMQOY/9ZqIFVxoo9pak9WnZnc3ACatvAhfPGVJEVfjUEYVcYY8x4wERvcsQ==
X-Received: from ilbbl7.prod.google.com ([2002:a05:6e02:32c7:b0:3dc:7303:c8cf])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1fec:b0:3dc:8b57:b76c with SMTP id e9e14a558f8ab-3dd99be4926mr150059925ab.9.1748892549700;
 Mon, 02 Jun 2025 12:29:09 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:57 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-13-coltonlewis@google.com>
Subject: [PATCH 12/17] KVM: arm64: Writethrough trapped PMOVS register
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
index 8eee8cb218ea..5d01ed25c4ef 100644
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
index 377fa7867152..81a4ba7e6038 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1169,6 +1169,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	return true;
 }
 
+static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p, bool set)
+{
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
+
+	if (set) {
+		__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= (p->regval & mask);
+		write_pmovsset(p->regval & mask);
+	} else {
+		__vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= ~(p->regval & mask);
+		write_pmovsclr(~(p->regval & mask));
+	}
+}
+
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
@@ -1177,7 +1190,9 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
-	if (p->is_write) {
+	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
+		writethrough_pmovs(vcpu, p, r->CRm & 0x2);
+	} else if (p->is_write) {
 		if (r->CRm & 0x2)
 			/* accessing PMOVSSET_EL0 */
 			__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= (p->regval & mask);
-- 
2.49.0.1204.g71687c7c1d-goog


