Return-Path: <linux-kselftest+bounces-29677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F0A6E142
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A81172D2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62726A0B1;
	Mon, 24 Mar 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1Mrbzde"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB92698A1
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837617; cv=none; b=NApd+ll1A+W8YpyDg9p2oX62EGva4lVkvxCvTJJVVnctsiyZm3H+/C2VnOEO7HLpGwT6apYd9t1iOOo+JO5An6aD1E8AVhU0PDIcGlBAewEc7mhzT1F3Z297OG3q/fLqPhJy1N4Ey0bthHXktdB5hkXXWLPAfIFBpxvrInyqlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837617; c=relaxed/simple;
	bh=ITiBlZiRHmcvBLv1rIOmuvAZXwsI7qvVjm85+vMyxA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GaV7l60aqoNn6SLE9DgH6TNOC99d03v/80+Fdas5tJEIgyegJ0/j7zZCZCRFyRHitecPdb+Jntfjprq4qP3j/LnrtWmtO9jMC8C3Fm8rWDrIXRmjp0DxxOIk9ZceketX6Rd9P2f/LiAF/W6AQbq/3VDqLHFyZBRbmja11lnI/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1Mrbzde; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so7279921a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837614; x=1743442414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NnSSKyHIRqLX/evz9sw81ueizRor/lmrUcgLZrYP6Yc=;
        b=v1MrbzdeRZSVyA8BvKX2NF8MoGn8DwgExDug+ncmUKBL7z0tKeD2MtARnFYgcTgeNH
         20521ndZo+Dt3nxuJQU/rDJrNin0t0hKfJb/HtwGhdGmmbUZP09Us7obEUBRaASVU3+e
         JlMZhoXhlOP4GudsJGvxMy6ghVEEvIAxva9lL7xT6VPJ7Np7jY8UdhJDNhir9b7t4arY
         wjz6TfahCeCTdLzQOHA9l+G2AB4e3Zu3jnG9gBYRC/4gNIWqxB1b0/8m6YwD2SvvJPKL
         fyCe474qYUkck9GkuOuITjk50RFeD7v17H1GQzo20D7Besjn657X+labwaB4g3vqiKNX
         r/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837614; x=1743442414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnSSKyHIRqLX/evz9sw81ueizRor/lmrUcgLZrYP6Yc=;
        b=qo0q+ifCOFLZBZqILo/RIIj4kduvGOkB3tj95S3zi1U58e8rKkuw8lneb25mzeV4ad
         21Y84XfTw5no2l0h0nR7KKZTec5QhSDLP6SKQ95HBODcfr5lv5jnesPSpoYutEuEf20Q
         hKEg/2Tys2oyCmdC6tdhB4JTJBlyuMC06rcUp9XyygZ084IU/7KKvS7JZ/D8psyg4HAV
         hpw0I+34MHuoGH+1PtHd4NtqmTQZf9Y8XUkCnBmlPH6eCyBs083SE4CJQW7I4/Z/9vd0
         KqfFOZrYBk3+gAglkIlPtxM2UDcbVezk8oBEABWMdhfCRlHMe4GBWwRJQK3Y+cZGNZJ2
         SCHA==
X-Forwarded-Encrypted: i=1; AJvYcCVPdJzs179pZgVIDWrTAFal2WCZSs/2k+6Pu8e62EYB9zRI3/eFtD3eNEdS7HFfTAWyQyDnHBKT9PV/pWaNjMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgEJGzGogf0rSyJscddW9bG42iUM0qnQTuCzpxiHoSBxB+KO4
	XOpKV2CndKY9Xfz8fhWKxGr9kCFJJEe1M0YvLOq6Unf1ICMiETWCsHaZcbNq3HNnIQRHJZ9pBrp
	ukTjOTQ==
X-Google-Smtp-Source: AGHT+IFw1kDW7fvKUTQlpdhZNYAssnVbQk9XuqdbzQ17QFPrU7ocYHSDgpUqHdNFn0Ydfs4WYWKqY2Gibqqq
X-Received: from pjbqn13.prod.google.com ([2002:a17:90b:3d4d:b0:2e9:ee22:8881])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc7:b0:301:1bce:c252
 with SMTP id 98e67ed59e1d1-3030fee95d3mr22162466a91.27.1742837614298; Mon, 24
 Mar 2025 10:33:34 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:06 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-27-mizhang@google.com>
Subject: [PATCH v4 26/38] KVM: x86/pmu: Introduce eventsel_hw to prepare for
 pmu event filtering
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

Introduce eventsel_hw and fixed_ctr_ctrl_hw to store the actual HW value in
PMU event selector MSRs. In mediated PMU checks events before allowing the
event values written to the PMU MSRs. However, to match the HW behavior,
when PMU event checks fails, KVM should allow guest to read the value back.

This essentially requires an extra variable to separate the guest requested
value from actual PMU MSR value. Note this only applies to event selectors.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/pmu.c              | 7 +++++--
 arch/x86/kvm/svm/pmu.c          | 1 +
 arch/x86/kvm/vmx/pmu_intel.c    | 2 ++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b3bfefc2d05..7ee74bbbb0aa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -524,6 +524,7 @@ struct kvm_pmc {
 	 */
 	u64 emulated_counter;
 	u64 eventsel;
+	u64 eventsel_hw;
 	struct perf_event *perf_event;
 	struct kvm_vcpu *vcpu;
 	/*
@@ -552,6 +553,7 @@ struct kvm_pmu {
 	unsigned nr_arch_fixed_counters;
 	unsigned available_event_types;
 	u64 fixed_ctr_ctrl;
+	u64 fixed_ctr_ctrl_hw;
 	u64 fixed_ctr_ctrl_rsvd;
 	/*
 	 * kvm_pmu_sync_global_ctrl_from_vmcs() must be called to update
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 2ac4c039de8b..63143eeb5c44 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -794,11 +794,14 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 		pmc->counter = 0;
 		pmc->emulated_counter = 0;
 
-		if (pmc_is_gp(pmc))
+		if (pmc_is_gp(pmc)) {
 			pmc->eventsel = 0;
+			pmc->eventsel_hw = 0;
+		}
 	}
 
-	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status = 0;
+	pmu->fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw = 0;
+	pmu->global_ctrl = pmu->global_status = 0;
 
 	kvm_pmu_call(reset)(vcpu);
 }
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 4fc809c74ba8..9feaca739b96 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -165,6 +165,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
+			pmc->eventsel_hw = data;
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 450f9e5b9e40..796b7bc4affe 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -41,6 +41,7 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
+	pmu->fixed_ctr_ctrl_hw = data;
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		u8 new_ctrl = fixed_ctrl_field(data, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
@@ -403,6 +404,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
+				pmc->eventsel_hw = data;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
 			break;
-- 
2.49.0.395.g12beb8f557-goog


