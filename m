Return-Path: <linux-kselftest+bounces-35486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D3AE254B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97B61668C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA325A352;
	Fri, 20 Jun 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gt7J+bX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554324BC0A
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457940; cv=none; b=P0oSK5gmeOVwOEO3Lm18MmroriHtuFkuh5rG8Kv3/UQegjRx7rGKN15Wfb3UGJXT9QyaoGA/DSfPZLq+aAnHZgzW2CAxbZUUwoFKmetyVH0KoCU7I6xIvAvypGNqqvtFHeiQ8WD3XGYY9swFIhfp3m39iUnlL4er1Zl0Ndb6u2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457940; c=relaxed/simple;
	bh=y1VZ87bDMvhFxKKb8KOnkNsslQVDRlVgHyTOA2XQMHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rd+JaITcDIqct9L9QImjbC4EePI0mrLifYyxpXMx07xHuGzRksYjFz+NdiL3B2/Q5VQv9eQX/6pl+x82ogqvc4t570GTUVf+sNXxZrTeBpm8GjBGkVsOwG7wHdcdCjXHNUyuK/yqtjsKrfIW8ZwYV6N0EuqHWhpid5J4yj0UGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gt7J+bX; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-875b64cccd6so403764439f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457935; x=1751062735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCeKccnUmGK0t6piLYL2X+QAR4eGmRxuwVO46fLii9o=;
        b=0gt7J+bXZsmFNHsm/F54vSpepp6/EUdA0ClcoHg+lAPPgvxhRJgk6DvVT/M1jwGEuj
         2YiNfomAX3Y7MLDW2mndyrlxpKChvWVz6stq3XXi2qfe9smH18Rna15x+fGAjo8EWNTV
         dnEiyaZm7kBaYRR3xGRIcJd9K2zrwM2m5qWHIJ8mVQ83jqVmjZIrHb00eYBWNez0IWfa
         jx3ZmMkvdFGspLLbwPzsVw/gYEEO1Ztumzoon8c9HDTgj7qkU6e7bzB+UuU/GfC9SD7S
         3OWlSol3iC6tcZ/uD4oUE8aIQu4QFcG5GbW4yCFni1pIHyLYV9UeauWjUFZjWjycBhMn
         PgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457935; x=1751062735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCeKccnUmGK0t6piLYL2X+QAR4eGmRxuwVO46fLii9o=;
        b=e2Y5uR7IA4VEdwtE1EDKqJckn2SaMA3YLTvh/bunPZV4MQ/EVqZRoFsoNtfac+XWS+
         w0MBcKAnuXw2z2bssn25oiO7+B9A3TQ00BOJph3CQAeUT+mOliiAONwpJjSFIaAK/QOK
         MJj1ZKVc4CwMQILREAGLaP7DxMLw0JSTSMVPXKqEy6aMFPIuPf/0x6IVSQzrjaArx5fv
         OXCrd2c6JAny54N0ttgu+B3slxjZ8Z/F6P71mUn1UpHjUQjjoEnNU6X85oHSIIqgAPMU
         zeUND4hXzh4xZCncPV/nwpbCTQdwv68IsdscoJAON0sJfOAThnoEeaUAPufw4OLHz1fc
         Yy/g==
X-Forwarded-Encrypted: i=1; AJvYcCUifAAmaM+gvHzt3GI/8B3L7jkbJ5cmx7tjnMMVAY9cOH4WJJJ9tm7e1PQFFIgNK7eTBrR6McrX8Uxy5nTypBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4izlS1q7TluVRd1CIof4EHD2qT4mO7wNkx0OHi8+aQND6pbG+
	wHP//2koveKdMHODQKkzFiS3PyoFFOhd2pwH+2WArI6uD9zR5hYxWiY7TNt+cvDqb/vyGVSqsWb
	Ul3Nk5aYmBi30L956oQk2d47fEQ==
X-Google-Smtp-Source: AGHT+IGAgAXt4VAt9nwcok51fvIV/dFkwYe009yCTofFAGBTMKz3erZRuxZTNNWRigmqT+1olC2QwZa0BzFYekCXXQ==
X-Received: from ilbdi5.prod.google.com ([2002:a05:6e02:1f85:b0:3dd:754f:1dc4])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1fc9:b0:3dd:edef:894c with SMTP id e9e14a558f8ab-3de38cc04cfmr43152805ab.14.1750457935204;
 Fri, 20 Jun 2025 15:18:55 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:18 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-19-coltonlewis@google.com>
Subject: [PATCH v2 17/23] KVM: arm64: Account for partitioning in PMCR_EL0 access
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

For some reason unknown to me, KVM allows writes to PMCR_EL0.N even
though the architecture specifies that field as RO. Make sure these
accesses conform to additional constraints imposed when the PMU is
partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 2 +-
 arch/arm64/kvm/sys_regs.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 90fc088ce3d3..5f0847dc7d53 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -884,7 +884,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = kvm_pmu_hpmn(vcpu);
+	u64 n = kvm_pmu_guest_num_counters(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1ea7d092ec59..b64b60e297bd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1266,7 +1266,9 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    !vcpu_has_nv(vcpu)	      &&
-	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
+	    new_n <= kvm_arm_pmu_get_max_counters(kvm) &&
+	    (!kvm_vcpu_pmu_is_partitioned(vcpu) ||
+	     new_n <= kvm->arch.arm_pmu->hpmn_max))
 		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.50.0.714.g196bf9f422-goog


