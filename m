Return-Path: <linux-kselftest+bounces-29666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF89FA6E119
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB093A8515
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD17267AE3;
	Mon, 24 Mar 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0ky/j4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436826771A
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837599; cv=none; b=dq2efj6WZdD8k7OkB+Yh+AG15Ikcelutz3v2Tc5Wd3wOBZNUQycRSZZpbo4TZviOV3giZzDhbwpkIGMtVjGbMCuCKiH5K/0uutBmGdr+jBxi6/Fuu5YoiCY5Q0tdgRa9z8rSZakuQewhSztDVa8TybZOt+b7PdATYlFrfZUdubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837599; c=relaxed/simple;
	bh=2UZFS7ZtPOsOdbmjBqXwodQu0sg74b205rrAfdCfezc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXjbyAlq/IT6/0yWf43jSVoUXcW3b8c3w30WXgJ8c8RUEkgO1xejP00wjjMn04rAk/XIjPUF4QzIF59tMhNHCBNbftKAYt8TQC+lyDi8ucz72/jNDywKC3B9+XoGygHQ/Ol33zW67eUZBuXim3hS37P6Xq0HYlS94TE2nKIfFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0ky/j4t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032ea03448so3599388a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837596; x=1743442396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/pjum03NzkfgM+Q+OY/G0cb0GEix9DxH7FdvQDwo0sM=;
        b=B0ky/j4ttoOO7HETzD0jLw2boowsp81uwV2unwnFMKdWBGKvilL+7xAvqJClQVMNhS
         LbKHR+f3/bvLQS3m+cEO7c/6sMS0IsYZiWoJxrzAgJgjNeJt4nL707m2If25c1ZsjtNh
         NvsIM08qRieZrME1aoe2J9AFbl+hAyxjNzWdOTdtriawnQWgunwLtpkJBXvRMda7KaQc
         upCP2NoMO3RUMFo5wSdv495K7fb3GJP8IuWSwRUd0tlVwjE9KQvMRkZtC2+P5a4UYWEx
         21AFlA/9I+XH26OXaRgIQeG8Nn4TCA5ZgY1UuiTiTxZlsvqEixTnyUAP1t/Kb7npX/r9
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837596; x=1743442396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pjum03NzkfgM+Q+OY/G0cb0GEix9DxH7FdvQDwo0sM=;
        b=YXHmigtmnGyxJarYcwzEqXtgINYbNo10BtixkmfX1b9NJqFcXTkztKm1xPsEPksX35
         ftaFhYHBPvYkUy1lQHFXKVbcNrS7UUpkZ5MV7fU0KX34i8+S3FBsNrmweW34S5hJMNSV
         P+69Vl7yimYd8TO3anUuM5AgX6S/r0H804FuoUTWODrA9YZGYKj/37x1G/8dwAJWtfRd
         i0aXyvD5v5nV6wnxHslffYIERXp0bib2gPKsVJOwfbCX7Gh6mGJl/fapm+4bZpiohUEA
         Q/OoXgXfG5oEASCvrDcaXETZ78WW8/lnn/309Uh72qrdBJ2pvbJExtWUCbMJgkVI3xTo
         B5ag==
X-Forwarded-Encrypted: i=1; AJvYcCUG79aTfX07Qc7Hm7qb4gf7x3pxPvBmUg+REWrvyFReDfeESYEHL/s98Msy6iF1zhYXusTINJ9vDV3CjQWinA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYp6kCBKOyeQ0I4KdfGeSFQMXAITWwYiawOGyUFMm5VDSij51v
	UHHh03gaTo+UcSB18YvzoVz89cRtbERshItl1TO5dlsC2c0x/x5KnnODX1nZz3nIYlnh9UwKtcM
	mT9YEfg==
X-Google-Smtp-Source: AGHT+IEp4Ey07lcVugyBVSb+j22AJh8dSqNsTLQcXlHV08cAfBwc+uLQMdNHEOqok620nmaX8Fc8YALvVfam
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2f8:49ad:406c])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e47:b0:2f4:4500:bb4d
 with SMTP id 98e67ed59e1d1-3030fec4e66mr22976717a91.20.1742837596673; Mon, 24
 Mar 2025 10:33:16 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:55 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-16-mizhang@google.com>
Subject: [PATCH v4 15/38] KVM: x86/pmu: Check PMU cpuid configuration from
 user space
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Check user space's PMU cpuid configuration and filter the invalid
configuration.

Either legacy perf-based vPMU or mediated vPMU needs kernel to support
local APIC, otherwise PMI has no way to be injected into guest. If
kernel doesn't support local APIC, reject user space to enable PMU
cpuid.

User space configured PMU version must be no larger than KVM supported
maximum pmu version for mediated vPMU, otherwise guest may manipulate
some unsupported or unallowed PMU MSRs, this is dangerous and harmful.

If the pmu version is larger than 1 but smaller than 5, CPUID.AH.ECX
must be 0 as well which is required by SDM.

Suggested-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/cpuid.c | 15 +++++++++++++++
 arch/x86/kvm/pmu.c   |  7 +++++--
 arch/x86/kvm/pmu.h   |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8eb3a88707f2..f849ced9deba 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -179,6 +179,21 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 			return -EINVAL;
 	}
 
+	best = kvm_find_cpuid_entry(vcpu, 0xa);
+	if (vcpu->kvm->arch.enable_pmu && best) {
+		union cpuid10_eax eax;
+
+		eax.full = best->eax;
+		if (enable_mediated_pmu &&
+		    eax.split.version_id > kvm_pmu_cap.version)
+			return -EINVAL;
+		if (eax.split.version_id > 0 && !vcpu_pmu_can_enable(vcpu))
+			return -EINVAL;
+		if (eax.split.version_id > 1 && eax.split.version_id < 5 &&
+		    best->ecx != 0)
+			return -EINVAL;
+	}
+
 	/*
 	 * Exposing dynamic xfeatures to the guest requires additional
 	 * enabling in the FPU, e.g. to expand the guest XSAVE state size.
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4f455afe4009..92c742ead663 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -743,6 +743,10 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	kvm_pmu_call(reset)(vcpu);
 }
 
+inline bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm->arch.enable_pmu && lapic_in_kernel(vcpu);
+}
 
 /*
  * Refresh the PMU configuration for the vCPU, e.g. if userspace changes CPUID
@@ -775,8 +779,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_data_cfg_rsvd = ~0ull;
 	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
 
-	if (!vcpu->kvm->arch.enable_pmu ||
-	    (!lapic_in_kernel(vcpu) && enable_mediated_pmu))
+	if (!vcpu_pmu_can_enable(vcpu))
 		return;
 
 	kvm_pmu_call(refresh)(vcpu);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index dd45a0c6be74..e1d0096f249b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -284,6 +284,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp);
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
+bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.49.0.395.g12beb8f557-goog


