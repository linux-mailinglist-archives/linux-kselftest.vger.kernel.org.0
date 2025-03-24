Return-Path: <linux-kselftest+bounces-29660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF42A6E102
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FB53B5B3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825F266EEF;
	Mon, 24 Mar 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQTiH46V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B23266B5D
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837590; cv=none; b=oZc7korYPoeHziyNuYRvO3kbfDlBv/ztuxJU02SquaBMyW37kqFR1FXKbarfusXwOfbgf8t7TSNJrZO248OHIeNoLxJl954HzhQxFCAOFP2cjq+u9zdG/UuMSVsYKj7E7Eu57Ykk8iudm2LzW05KWUPr6ydmGkDURl5I0Ko7NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837590; c=relaxed/simple;
	bh=uZHApNHtC1srnE6XLFaAhncIb2YrpW9H049JpCQwpNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GktBeTLQMlrLmWFjdNo+t/jxLPcpe1yvi1lX0rdVtuUU3e8O75IgJQ7qUtHHbMhDEE/vwRk28PRB8BT9W54C7UGJQJmM1HqZ3cMSzDodwyZFPf63z0iDq7TMeOa/HuySoRAeN+8j4JAdv+LXVu7i7jlLbXSK8rMLCvps7XRTYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQTiH46V; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22403329f9eso65957325ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837588; x=1743442388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EQNh2u0xTlEo8Nzfc2nQDu4yd1/+qtwS3CX+UnSCF+k=;
        b=LQTiH46VZZ8v1TDQNAq/Ex4NBdXkNWMJTHryJN/9588OjpKKOS8JNsxJqfnhyjXye3
         +rxIM9CEyRNlt21i1RGwhgn8VbY1qwzcpaYZOxfX8Ac60s7F2k+Tzdy52XDREcWPvb+Y
         6r/4b+L6ZQRs4qHV5em2+3fQ52xzu5AJmm3BS2PfOT605ZYLK5sMPeOOkXViWi9R3Scc
         75CefBDWdpu3zYp/yLAuG/BYC8kILRxLm1L5vg4tGwnTnjN7IhFBpuKo7IJ3tkgrTU1t
         Clxm862XMEDXgE6PJRN6E81n8okOPKLh/xwccx9tSrRVktZraXZYPHB9w74vvPyvfIdP
         8hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837588; x=1743442388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQNh2u0xTlEo8Nzfc2nQDu4yd1/+qtwS3CX+UnSCF+k=;
        b=RTMtGoGEcIvqC7X8Q63rA0HzHIqxfCbm3mcEzKCjUkBk2FCvEE8xQZj73j/c7eOs7l
         Qy9O+VZ77y0WqQ2q5yeB9G0PmAiE2ksXRe9bJrZD2anmyFhuwkAwDaivucRh+saijSZS
         X2Nn0yOwkPCZU1ClBTGUzU6P5DMdlW6HlHjHWyBmDLny8sqCBHorQRGjopntOmvFB7jP
         CrjTdcuPt3N/42INEcI/ZQb2zxI2mLA6CHrS+vtiE2wQ1cRKXgB4mGPvv0BAZduaflIZ
         kUWQzWXlUzZjFAoia4ldYw3P74uonXUFZSqh6C2b61zRh5yWcdTXfmDUGxauflpyS4c/
         MJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCXfxfPoGtxEHFG2ogtXZNQ9pe+oN2djj483TZkG18whFwvaNcSgH1/WVsketwiTDtGVwJ7y6i4kWcwVADRENtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUtisBEF/cB0fOoZwlOB80X4/PxfpgXBNyBWoPaW7o3NPSLbp
	GOBXFB1FC3MkzxiGnPeRON3KcamQMSqIVN/7x+m3eBH6XYzpR+dUBySbtLwG3HNf13i8f4jrRi2
	G5CF2BQ==
X-Google-Smtp-Source: AGHT+IHHgQ/VTpQK+Ek9oKOxqSwHtDlsEEsDEATZSstz5FpSTkUYvsnRaM4XcmWiSvU9k8/G75kMTSuBQ3o/
X-Received: from pjbsr7.prod.google.com ([2002:a17:90b:4e87:b0:2ff:5752:a78f])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:224:2a6d:55ae
 with SMTP id d9443c01a7336-22780e2aff0mr223959085ad.48.1742837588117; Mon, 24
 Mar 2025 10:33:08 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:50 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-11-mizhang@google.com>
Subject: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
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

Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
NMI at perf guest exit.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac0d445..28161d6ff26d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 	return ret;
 }
 
+static void x86_pmu_switch_guest_ctx(bool enter, void *data)
+{
+	u32 guest_lvtpc = *(u32 *)data;
+
+	if (enter)
+		apic_write(APIC_LVTPC, guest_lvtpc);
+	else
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2706,6 +2716,8 @@ static struct pmu pmu = {
 	.aux_output_match	= x86_pmu_aux_output_match,
 
 	.filter			= x86_pmu_filter,
+
+	.switch_guest_ctx	= x86_pmu_switch_guest_ctx,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
-- 
2.49.0.395.g12beb8f557-goog


