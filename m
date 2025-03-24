Return-Path: <linux-kselftest+bounces-29668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0BA6E121
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DD91898066
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FF267B91;
	Mon, 24 Mar 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tof9gi2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDFD267B1C
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837602; cv=none; b=QmGYVXPwQBNcjMcoQhbPkgcY7Jj3kG/RW1rWQnTQVJgn57MY9ajIW7cLGuP2T+eyqxLR00FUqHMU8pjdYesM+h+IVwrrFvhRgQwLg/Ec0U3rj6K2vrcqCOkLdk3H0ObXvJ3SG07CzKiIJz3f9EsaxaVVsxesoH5RwJBl0xLgbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837602; c=relaxed/simple;
	bh=5qOPwwrxnQsx7uNK7PsLpk4FpylCW4KwiTr6opmkLZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LU+/SjYz2MOi8dS3oHOkM7mm2PiwVvq6BUXSqFi3KhpokegEWfKAQIkOCxFNFbHAo6taBoDBoz0F0LGbyJM2YtkEPkp0Vzu6LCD8lDDrpKkeZBKiBuBdHX/r8yzMIkZDD+y4BfL2x6qdNoLZl3TrRrd/gFMZU5A4FHTwW3krUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tof9gi2O; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ade807fso132556265ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837600; x=1743442400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rcOpnJuyQafXKIM3t3NDl4D1Wy5EWhwivUY6bQgJ2Ig=;
        b=tof9gi2O6OfpkkQ4puiCPlL7wXk6OiiPSypGup2WLbU+MQUMSoDWfvLu7Y/k2CN98A
         dsuL+tJYvGP+yreT79YQ6HlPtbzav2CfQkLkst6x7mBkF50LH/RGffacg1h+BUM3IgTc
         JbNWabJOmL04gQglarcV6dok2K3Lh/TKonwpbMc6W9JDQ6olnnFy6dGLnrcw93zAUpDp
         O/qSu1QhbJ1MI/tmYVfYVPERPj5EP24+jAO+YXki5yFxWnCnLnbe/Ajn0hcprBRWkB07
         hrdBKN8NvXPoUys2Qt/BvFMh+CQeZm2U5EHZ5e7sVQk8FEIOw6bJ3jtdWZ6QNqnGsX7m
         GOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837600; x=1743442400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcOpnJuyQafXKIM3t3NDl4D1Wy5EWhwivUY6bQgJ2Ig=;
        b=HVB+/T0XUUe/QwvXcl67iZR9pbllW4PYYDhsWHB5rKPwnDXN+JLj4N56Ri6IlhsQpZ
         w0PKXJLfk580Fo23Gj8t67Rn2JzbjKzZeWdnWS/yr4JynWfCnzrvH9SfAwp7GFAfdThd
         hzqrjNKJ7Wiqwnz+/gy7pwLJf07SsjHHjZy7XKCOzgSnjsDva1SVxxoCFMiPnWrjLxgR
         b0vIJlH/HZDicF3jelgJXQeDHeK0oxzoOto07Zn5Io5hxLNdLJQdiHgSw8Q65YzGqWjB
         gphHF4RtZvDiGqOqu/EcNNZipxVg5UxoKchP0kbAsR2+Ds+cfJPvfEYdEItWhkCxybia
         AqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHV8T+1YC5TJ68xoyPrQgvNETDWUDwZm7GiQfaUjqOOReX/80QjHVIROzENzNN8TD4/7vnzLr85JlvzSZuMXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExTQWPIyDWaKBTv1dbXme1JyNoGuwwgEqELDTQFb8yBOkG6rT
	xtRqsxD0SM5qcuC+XJAhitbXZXgTDr/kJimZ8iZyNRId/Od9Yzg0zYyx6kqrM5BePw+tFR8IL60
	2zpCfLw==
X-Google-Smtp-Source: AGHT+IHUO+nVYTje/CxANJJGo3on5RcFF6XTIavPoEExwPpO1NjAc4cYfof26CrUOcsMjaHQJm3pjkVgG3XW
X-Received: from plho1.prod.google.com ([2002:a17:903:23c1:b0:223:49cb:8f99])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4403:b0:223:4bd6:3869
 with SMTP id d9443c01a7336-22780c7ba5bmr212349475ad.15.1742837600009; Mon, 24
 Mar 2025 10:33:20 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:57 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-18-mizhang@google.com>
Subject: [PATCH v4 17/38] KVM: x86/pmu: Add perf_capabilities field in struct kvm_host_values{}
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

Add perf_capabilities in kvm_host_values{} structure to record host perf
capabilities. KVM needs to know if host supports some PMU capabilities
and then decide if passthrough or intercept some PMU MSRs or instruction
like rdpmc, e.g. If host supports PERF_METRICES, but guest is configured
not to support it, then rdpmc instruction needs to be intercepted.

Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 ++------
 arch/x86/kvm/x86.c     | 3 +++
 arch/x86/kvm/x86.h     | 1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index acd3582874b9..ca1c53f855e0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7908,14 +7908,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 static __init u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
-	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
 		return 0;
 
-	if (boot_cpu_has(X86_FEATURE_PDCM))
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
-
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
 	    !enable_mediated_pmu) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
@@ -7928,11 +7924,11 @@ static __init u64 vmx_get_perf_capabilities(void)
 		if (!vmx_lbr_caps.has_callstack)
 			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
 		else if (vmx_lbr_caps.nr)
-			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+			perf_cap |= kvm_host.perf_capabilities & PMU_CAP_LBR_FMT;
 	}
 
 	if (vmx_pebs_supported()) {
-		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
+		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PEBS_MASK;
 
 		/*
 		 * Disallow adaptive PEBS as it is functionally broken, can be
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1ebe169b88b6..578e5f110b6c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9786,6 +9786,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
+	if (boot_cpu_has(X86_FEATURE_PDCM))
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, kvm_host.perf_capabilities);
+
 	r = ops->hardware_setup();
 	if (r != 0)
 		goto out_mmu_exit;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index dbf9973b3d09..b1df4ad2341b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -46,6 +46,7 @@ struct kvm_host_values {
 	u64 xcr0;
 	u64 xss;
 	u64 arch_capabilities;
+	u64 perf_capabilities;
 };
 
 void kvm_spurious_fault(void);
-- 
2.49.0.395.g12beb8f557-goog


