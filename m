Return-Path: <linux-kselftest+bounces-47326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D412CB115D
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592F030E6276
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927130DECC;
	Tue,  9 Dec 2025 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTA237n3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A648308F03
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313569; cv=none; b=Buf94WIYrePuFNDX4KbLjT8gchKmnBH7QiZzQiXpF5EmXEi+6uCtydHV5o/dnfad/1jOlNgTnkyINBK32jXzlW6eUJEXy+JO1ndASkNZFBebv9j5EONgIync57TLlqTsqyplvGnqByYvOSLeuD7pITNe9NYZvxCiaKoGHwuTtx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313569; c=relaxed/simple;
	bh=L6JRHNao9Dv2st9IstObJcFX6EfxZz6LafDaZCOeTJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mpgWtRVtI26KMApYmW7U+2N6b+Ry285QqvJorJdQwsW8i3F+nukp+PhMioYRs3RuNYzDVKIAjXs2sllXPPzvE4+qacPZXsVWBArL/W4S/0CfVpHxyNtChXNORrGFq2PFtxSDIQ+e5NjJ+Z4NEleqYV3a1T2np09Cwp9MczX0JIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTA237n3; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3e88de1d93aso7193454fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313562; x=1765918362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zQsEiABUjsdMkMEnByRoAgIWKd7GLr6DjLwzP+aDHY=;
        b=tTA237n3Vh+t0TIlK504bUJ84TNu3JyywoJOfI6da3cEuIcPDmvEBP055LtGPDiUQ8
         sPg87QSnOrZGUAD5KqTXFD1MV/+XIws2NjpIHidBrZcuyDlxl1+sre2N5ziwwb1/1j0s
         VgOAOJwCdAjDOTXYYcBhKOyJg2dwDqlxKUxgBK/dO0JQvyLFjDg53pk2EcHxDennl1im
         X1AKM4Tq2abZFcxxHKHvGPl/fpODydG/lhq/GDqLkYg0l8qYXxOVobanLKjGkLyQDUzZ
         MRFr3hkKh3qTeFVJZo5YeSzETycwsB/7Tq4ABxzdfZq/2trtFT/PF/m3QhsdODZbyJdE
         awSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313562; x=1765918362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zQsEiABUjsdMkMEnByRoAgIWKd7GLr6DjLwzP+aDHY=;
        b=Lo0imDBpePLtVU4fHE2dOXIK8hEMgwThtXHhjJN8np4YvoHRKmRinjV/BlBClw38Ob
         frTPrpJXj8vHJKH4lo8EB1k8bdbQq7F6jla+JvIuu41Ikj+JfDUsZwaRDzb51rzjAByY
         +ViklI0YzU/Cb0XFRM7/pV3/qvp8Lze2SglRxKcIbHp2s9CONB5CmTrW4PTYW8KpwEsD
         Na6X0QLj2PkxLoC7Z3TckIAQbyK7wzMD3G+FKV5c4byX0QcjjyCHBSr/2enbeKYO/R1r
         19GcQMNVj+aKQj0JqTijKBR3EnhzxtvhdSdkei2fsJofp2CWnmCydFiMnM2jd1o581cO
         Pz1g==
X-Forwarded-Encrypted: i=1; AJvYcCX8F3RzPeAdsUrF3pkoa4hP1vNr7ZgFuPEvz7gKxtTl4eTmv/YsN+69GnIwOIpXXUChvBSewcibkVQ+1ZMucKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtBwYRGg7vngkB7BXhdmp/CP7ZVeq7yDTLGm+nW0ao1QHEW/D
	NC1mZXXX0krFgsxQyjOLIEh6woiKpwuYsZwAA6JxblMy5AsbzcUG1vZOAs/r8wlKjP6BRH/UKIG
	c9ch43sg4Pz9wsFBtdihgkyvd/g==
X-Google-Smtp-Source: AGHT+IFRKHeoUmjGuNFSlsmzEp/JswAlPAyHOqJKqkJs0+bQVeMX9v3ykC4h/RUbKQXV9XNTVLE12IZWXk6mEzWBCQ==
X-Received: from oahn5.prod.google.com ([2002:a05:6870:3485:b0:3ec:4657:83cc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:8208:b0:3ec:3b3e:4f38 with SMTP id 586e51a60fabf-3f5bdbe25e0mr227516fac.36.1765313562359;
 Tue, 09 Dec 2025 12:52:42 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:13 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-17-coltonlewis@google.com>
Subject: [PATCH v5 16/24] KVM: arm64: Account for partitioning in PMCR_EL0 access
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

Make sure reads and writes to PMCR_EL0 conform to additional
constraints imposed when the PMU is partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 2 +-
 arch/arm64/kvm/sys_regs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 1fd012f8ff4a9..48b39f096fa12 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -877,7 +877,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 n = kvm_pmu_guest_num_counters(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 70104087b6c7b..f2ae761625a66 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1360,7 +1360,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    !vcpu_has_nv(vcpu)	      &&
-	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
+	    new_n <= kvm_pmu_hpmn(vcpu))
 		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.52.0.239.gd5f0c6e74e-goog


