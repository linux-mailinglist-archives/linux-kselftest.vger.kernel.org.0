Return-Path: <linux-kselftest+bounces-29684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE9A6E145
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692F07A79E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749E26B964;
	Mon, 24 Mar 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k297gcpG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054026B2BA
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837628; cv=none; b=txO1YmyugbUnBxi7HyyridN5eGfmTloWXNQLPgyNwwcs9w14slqeEH5OS4Z9fi2JtaGUIY5HGo568V9PrVEalUVJOzqgB4aeSApVgVzaI1hBHd/VIhXhYsodKCPSzxgouPmhnQhpWcet86vYnxtD5kEgtQFDm5BpxdJNb47YA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837628; c=relaxed/simple;
	bh=SPV6f+vG/kNYrdnOrV7Ud4dp6yqxNxakKCs85+jvmag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WY9O0agcW7+mkTBhMCYTx+T7Dwtr/T3VGe1uw0s+A1b4TGBycYlrViAWzJuat05zpv00BgPYJLpi9n0xMi9t1HNZRk0TqOQzJSzXMuztXlu1lVtPYimL0x0DTJtC1YxvkqS1KyPYVIHzlbwIVi/wWmWeiRa0bvlOl/kNUO3QDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k297gcpG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so7831548a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837626; x=1743442426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3FAxBAfvnTeE02w75JVrD4RSLbO6pRSDBEOxfTgOTwA=;
        b=k297gcpG3+AiZfVEIa1bic5XpHjHyo6FxbO2YOIXeEEjx3v3hugoGxcb2zBZR8uvsg
         EmT1t5jLyF2iIV7gD1/Yf1AWFAR11fZIXmm+/aeltchjq3tUVBeAC77JOFJcgneqqHUo
         bcdKnqy1fIYPIXTQJpQhvnpPSXIAVOAHubTjb/X+vGlX3rBqRpxcgtZYfU2dp3vOjx8B
         vtL+PbgbhSjREx75TThEXGnE5eMleuj9TPBJxe5l1qCQBsLOVKZ0dpYqADM/3/i3io2R
         Dt9GgaLgWEETfkwCbQ+3ngHbH4NrtQR/SSDQjxXSff/QwK1IGhw+cttoLXpVxDCypwxd
         7h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837626; x=1743442426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FAxBAfvnTeE02w75JVrD4RSLbO6pRSDBEOxfTgOTwA=;
        b=jUMXjsEkg/2uXP9xD/lQWULWQbu7D4YXvjN+/SNnZp3ISMLRR17poa4eli86yCEPqT
         /uzhvHURmVm+MgjT/sNKjHZ4/p6omOwUgQWqislXkRPiFvKM2r78AAtx/YBNtE84ZH5C
         uNC29VmvzUNZgcavuJPct1AEH8bC6mFWizeli6O03WC/7Au+qTMujksFrj/wAmdWpffw
         B0k5n/X2Hb/JmDq1bmJVHslqYCHgPHe4u5pva+gdTcSCd9r2zTL33mrYQT7UOlYcffhZ
         yB69wbYYZgQwtl0W+AD9wm986Bwc8zpXZZK+24q+CEniX7WuKpbKQvOFAjB72lU8r6c1
         zkvg==
X-Forwarded-Encrypted: i=1; AJvYcCWjoOq0mMedtbJtXlGc72XW5brSemtquyKv9xD/ON9wdGoYKQ0NgYEbQ0fxD/JuU+GkK7Y4Ek/pzcbC3azyDzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsOHOCKqnwzQpyghaCXKcNf+MBjbD/0o3Bdymf/p7lvNjDWx/L
	T1D044E8Z4qbfi8xhSYedORwWva8SzuKxpRzU9EVaIc0l+RKcba3p6dnzpT33QUJnkFmEIZW7JD
	zl9NZrQ==
X-Google-Smtp-Source: AGHT+IFNR4hLiVkO6uhlXqD3citXpGRm9BfvjKuSb2pxzfsnHIVx+SR4I6E3SRncE31NfMsm/svDGQp+t39P
X-Received: from pgbeh14.prod.google.com ([2002:a05:6a02:256e:b0:af2:3b16:9767])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d5:b0:1fb:e271:82e2
 with SMTP id adf61e73a8af0-1fe42f35752mr23440489637.11.1742837625714; Mon, 24
 Mar 2025 10:33:45 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:13 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-34-mizhang@google.com>
Subject: [PATCH v4 33/38] perf/x86/intel: Support PERF_PMU_CAP_MEDIATED_VPMU
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

From: Kan Liang <kan.liang@linux.intel.com>

Apply the PERF_PMU_CAP_MEDIATED_VPMU for Intel core PMU. It only
indicates that the perf side of core PMU is ready to support the
passthrough vPMU.  Besides the capability, the hypervisor should still need
to check the PMU version and other capabilities to decide whether to enable
the mediated vPMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/intel/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e86333eee266..ab74fdfa6a66 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4943,6 +4943,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
+	pmu->pmu.capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -6535,6 +6537,9 @@ __init int intel_pmu_init(void)
 			pr_cont(" AnyThread deprecated, ");
 	}
 
+	/* The perf side of core PMU is ready to support the mediated vPMU. */
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
-- 
2.49.0.395.g12beb8f557-goog


