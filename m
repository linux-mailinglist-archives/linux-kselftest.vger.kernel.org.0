Return-Path: <linux-kselftest+bounces-29683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A3BA6E140
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C61B7A5D6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9C26B2AF;
	Mon, 24 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4W15rJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6926B087
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837626; cv=none; b=ZVzd0P55eXHNlt1iBHvcuq8argZrAYFhiAFs2qpaXPp7jUbiuyn9K85DdLsyQk/48+yONjvEOFyJpKPyRNqyhOY5CfSkhbIqowY8X/ohgC4A8QhEM4rXhUdm6+UrKCRWoAtqquva3PSavwlffR24Bmn0y83B6RMHpKFWVN55jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837626; c=relaxed/simple;
	bh=tLEAHwFsGl0uTcmsj5p4KoOmnVEl0UIhLCLr4C2CpFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EE5l30AVcHNhSzkIvbJWBkVx+aD5hLgYJv0eaDhmefXByB1rV/CUyNR5XkVwVYe9nkkNTF2I7BfiWh0fHybu+sRhN53wfp3MAPe0g4xK7nAMP4jbhQEHhfUus5CAORy+CuFJMXvFAra9AimhpfLIkh/DrAqSaTKmMF1JvHmHpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4W15rJ1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso12524398a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837624; x=1743442424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m1dzEiSB0TnXn8z4Uk//mVwwzT73iVmqUPR4PdJQimU=;
        b=F4W15rJ1e5GDeU2KQ6J2Oll+Q8qMM+n1Fh+ORwztJO5KFMVFq1Qy52AYYVvsNd8NFB
         Bpn4iTmZYBO6KfInuyVkyX8V9I+HNHPlbb9rPvYiok+YH4+s+0wWISnw6ycpxiVD0GOF
         LvTl8ZNzpR7kok49Yyb+NbSbTqtbIXenAx8h51zakBenBS8GGFo6iwKyNDdpGEjTopTJ
         hAHJ2877fpwvEqpmC/RI4UTZs1FS2oiophBlFXGuZYn2LwaxrLWTDsnl+Z5vrZzvcV61
         mbYUAEMvI/RCqgF5icfblfuuP8aRgJZWvyAm2bscqWymtMAYKFKLbhmXCbXbpMTuI+Hs
         MtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837624; x=1743442424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1dzEiSB0TnXn8z4Uk//mVwwzT73iVmqUPR4PdJQimU=;
        b=nPQEkXgKwx/NcZ3TkoiFPYisQSQfFr75Ac6jX7niQpc6x0zTwQ1jxkbwPuri0NVbYh
         Kcp7ZsMmTIfe59mc8anSsvS9v/CAxLHSZutKmFUbvuzBT633fYzMX5LqtWaIXRVQ/pqU
         xw3BPly4AFgizAyZAJjY8vna0mQrCulQ/WpNuMOvPuRjhbVBtm2M8a9fxweVDbjny053
         m7f9pKQpjrH2rzKTofwLrS7DT3wzysZy0GVn2eLiDSrYJd2pCqbAggn73mF+6+ZrWuTD
         d/dLCCjY3r84EGIX3lxRA2scV28Tp102imRnOuIbERgiaCMDHIhHSZYsVTcrHf9gnKjj
         aPoA==
X-Forwarded-Encrypted: i=1; AJvYcCWv4SIG2atXWU5Z2P28a2gTcE9GXLFG3MuYcyIFWjKDOy+faKz/MV9XZr2DjJO52NMaiY93B1iXLZPS+yjcNvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFagOlJUsSgPL44LTZnlXvETPrB1dTVSQ1exw0mwGZTnRpTmy
	y1GNQqyJK3BG5j9kYsVEN44nhvEabTfRl4uCAwjG36ocuT4fBYrUANi1I2wn2ImvawsYJVkZdTC
	AosPB3g==
X-Google-Smtp-Source: AGHT+IGHdqNaZHSbA93dO3we1p4to3OBaAJ87qlwbaP5lP7uoA4gJwD6qAmceHmEt8Oo8wq8FMI7Brlio3aM
X-Received: from pgkk2.prod.google.com ([2002:a63:2402:0:b0:af1:dadf:28e7])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:168e:b0:1f5:709d:e0cb
 with SMTP id adf61e73a8af0-1fe43437231mr23271595637.39.1742837624000; Mon, 24
 Mar 2025 10:33:44 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:12 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-33-mizhang@google.com>
Subject: [PATCH v4 32/38] KVM: nVMX: Add nested virtualization support for
 mediated PMU
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

Add nested virtualization support for mediated PMU by combining the MSR
interception bitmaps of vmcs01 and vmcs12. Readers may argue even without
this patch, nested virtualization works for mediated PMU because L1 will
see Perfmon v2 and will have to use legacy vPMU implementation if it is
Linux. However, any assumption made on L1 may be invalid, e.g., L1 may not
even be Linux.

If both L0 and L1 pass through PMU MSRs, the correct behavior is to allow
MSR access from L2 directly touch HW MSRs, since both L0 and L1 passthrough
the access.

However, in current implementation, if without adding anything for nested,
KVM always set MSR interception bits in vmcs02. This leads to the fact that
L0 will emulate all MSR read/writes for L2, leading to errors, since the
current mediated vPMU never implements set_msr() and get_msr() for any
counter access except counter accesses from the VMM side.

So fix the issue by setting up the correct MSR interception for PMU MSRs.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/vmx/nested.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cf557acf91f8..dbec40cb55bc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -626,6 +626,36 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
 #define nested_vmx_merge_msr_bitmaps_rw(msr) \
 	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_RW)
 
+/*
+ * Disable PMU MSRs interception for nested VM if L0 and L1 are
+ * both mediated vPMU.
+ */
+static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
+					     unsigned long *msr_bitmap_l1,
+					     unsigned long *msr_bitmap_l0)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int i;
+
+	if (!kvm_mediated_pmu_enabled(vcpu))
+		return;
+
+	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
+		nested_vmx_merge_msr_bitmaps_rw(MSR_ARCH_PERFMON_EVENTSEL0 + i);
+		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
+		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
+	}
+
+	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
+		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
+
+	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR_CTRL);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
+	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
+	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+}
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -717,6 +747,8 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_PRED_CMD);
 	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_FLUSH_CMD);
 
+	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
+
 	kvm_vcpu_unmap(vcpu, &map);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
-- 
2.49.0.395.g12beb8f557-goog


