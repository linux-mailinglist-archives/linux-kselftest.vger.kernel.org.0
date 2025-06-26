Return-Path: <linux-kselftest+bounces-35929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE6AEA7E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BF17E6AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B9D2FCE1E;
	Thu, 26 Jun 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDq5WsJZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC32F548F
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968369; cv=none; b=IPkvW7bttDRbOtPOwKiLakRBvMtCHCDVPJfgRFMYBcP6sJOaU7mRz8XkE7iLk57cEHD35m1Kuy0zAXOkV1Zlwb97PNrVtcGbBFw7UQx1M7AalZhyDLWame5Hu8wmZ0tlprXKIzRBn0L+2VP1p4z1VXpgF0a5dmjGJQEireX8x/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968369; c=relaxed/simple;
	bh=Sugt0ZAWw0whdfnB19zyTKRQsY2Z9PQHTBS1EdvqwWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xy1xs8k1xOfr7Kr6q9qKsaT2Stq4OymBPhCEzrm0pnNJtglwNk79jNll1ZRgGqPrJ2/ihRRcuAN4HoDRmzr2Pqr2Bb/flURH0Ud4aiAEkZPzIHkSCzA0vaOFntbEfzdLEFzyC6sf8c+BEOgcyVQnjB2WOj27jDxJTxkQKTFBnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDq5WsJZ; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-40aa3e76fe6so1444986b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968365; x=1751573165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oR9vFP5SFauEza8dTMYPljjE6wfKaScNOs3wNYF4UAU=;
        b=ZDq5WsJZWvybAKocwRUs5ZbWjrgywIYuGhkevDJ53sqrPvHt8e9wjCyfUl+sol6ALT
         u2udCPI9GynRzK2OKdQuLZxnglExgG2mNdLYGgHLzRWYByzpQvQOVVwAQYDqP92C5VJt
         pJ+tgfRSSsYCJLs8NbuZCotuHKB/AfbpnS7WAhMmlu7fM/2ZI33r+Vv2uf0GrtBgjGGv
         8irjKoL5QtfjPnMfHKRfw/w/Q+SHx1aavhphlJc+rsX2hTK1P7O3XzW+b/WQbrLZnuxP
         6a7AKv/H19wt6tAeEHofSZPVA3x92OwWTh+wM9KsTCVuSUIwWtXJ5zmWkzgkYZsxdbrZ
         MTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968365; x=1751573165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oR9vFP5SFauEza8dTMYPljjE6wfKaScNOs3wNYF4UAU=;
        b=qMTMCTbhCKXZou260+vEDc+wPvyy/M6FyBM9Yl0NR2eJQvYa2JcwS1S1kz9Tdj/tOn
         EzDuksaNHxs5chvrJ+UJqMfHKv4pf6DJCKJmI15hFXH+JqFpOAy6utyKU8pa1T6L6zIZ
         zsh8RZJGUdYU6561g73qT8AvL0sfNk/0pNRT/wdsAxRkHs/tWV8oEElSKFD0SrxQIZ1m
         1PVLUQ54rW5BrOgeyGJ5Hmttc9FFyyYu4VksOZa/fzZVsHRXhNau1HPYf5bhL37B6uJR
         uVpPGGdOc9xu+L2+xcDgjQwb5Ahm5rw1LJQUwlXOObSxoJFjU8f/kqRNPDlJ5rbfE7b7
         2cjA==
X-Forwarded-Encrypted: i=1; AJvYcCVp0jnHg79uMpnmJgM/PcgsnLeck1Qi5Ve7JC1L+SOJJjC5t+Zg9SIOpU/+ZVmZvG94R+bvwkaLsAXV8H6/wwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/oC5aSvPItsmIywXMT8Pinh1+bIdjrn3EIKDwzysmAlqbm9/
	CEg1mEAmxKKAt6mTp7qaYURzxUEa9AiCFfT04vQrXaYTOX3MNFoi/AorAD8HpktjSwRLgVg1ske
	u3VcFXQ8ketiv6nOqF19kZ/UGig==
X-Google-Smtp-Source: AGHT+IHKPzqyXuHjLhNaVF48d4dlM1ddP8qVK1Z3JzzP3RzzSVDOilpZen/JKG4nnFQT/I6NY42YIxRN76XnpGTzTw==
X-Received: from oobbq3.prod.google.com ([2002:a05:6820:1a03:b0:60e:fcff:daa1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3196:b0:401:e721:8b48 with SMTP id 5614622812f47-40b33c31cf5mr524973b6e.8.1750968364756;
 Thu, 26 Jun 2025 13:06:04 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:49 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-14-coltonlewis@google.com>
Subject: [PATCH v3 13/22] KVM: arm64: Writethrough trapped PMOVS register
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
index 771d73451b9a..cfbce4537b4c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1173,6 +1173,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
@@ -1181,7 +1194,9 @@ static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
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
2.50.0.727.gbf7dc18ff4-goog


