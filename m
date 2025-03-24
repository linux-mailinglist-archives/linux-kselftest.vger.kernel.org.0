Return-Path: <linux-kselftest+bounces-29687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25972A6E15F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C316C56A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1A26E178;
	Mon, 24 Mar 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Z+tr33A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED826B976
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837631; cv=none; b=Tj2xarZUg2qTvUNoY+Mp3sFqxJ6gsYCDW7AKlwKpiSSqIAbBx2eaasRCsodNgJlabSrh8qbJOWXsf7lxF19hQOmv5hYxBVuHZKvy+sxs+WMJpdZ7txkQ36bkS6QnEZva9pVyjF1HHmZn3QlU54eLR0L4/WaCLqNaD+07y7T4YTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837631; c=relaxed/simple;
	bh=zOnGJniEN3WXnc3VeKLo8SjLrISpK18TNlsPROxYixw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLP/+X8ezy9I36oCM4sHf+de7dtRJWFo7/bGdpHT+GSteovk9XQoFzkP68qjv80+QHdEo9PnzfC5i2Ld7hqz/GkXC8kF0Bv8QdHeOCmmGuMntLaZG7ZMcbisoEZvGHhMvmh53n4LJcJsWSuUqdb0xD6BPMFJ8ATWvuSPCVOfwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Z+tr33A; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2233b764fc8so76464355ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837629; x=1743442429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+5INsqPwwbOfqQ7eFWXO61jTPMwL6br0niH/ojJ3Zxg=;
        b=2Z+tr33An67SC8ci0lyW5v2i47HRpk9AD90kJV5uWkd9NZ++1Cw3QXrHiENgKc1Zd3
         1MFtikti0MqVQfiN5o9LK7gf8SSrgjkXyu2Q4gA46IriC7OHyaXX+vDWMe8ieP1Wl3OO
         4do0/yFHX9CGSlTgmeowLs5nt5fyu31cN9Ds4XbGHwNjtRtNuj2a8V2m+xwsh3i8ipNI
         2Ke3ZTw9zDdJUSxmBWP7zfmBpZ/aiIY/vGSct3O9TBL+k8K+hzPou/J2X4C61Bt96HcF
         JEaStGf5iTx8SJkF2aiPlIvYldJf63aIx+s6JM7p9eA3Rc/pI1Ph6gfmufICFgcCOneg
         OmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837629; x=1743442429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5INsqPwwbOfqQ7eFWXO61jTPMwL6br0niH/ojJ3Zxg=;
        b=uAx/ARzLNzVbddX/WNv91YhQ025BscoP0OHGV2oAqsjYKNdo9ON/wBTWDDUdGvAKoT
         xHIjDt9SxQHpaSyYjOUxkP31mHUPY4EZ4Nhkh+KkAbWCiL1SzkN4ydfkkpjzMU5sTKX+
         30nAbE+cM9p7OMcAvpdUPODLFmRgUHNcN7EyE4+MAeqjdk1SBq7t6VuJsq/b6NYoEI+R
         WQnqfL5dhHYbpI3RQN97tBLzVhNVFwbV8HCcr+r2dBjWwx/+PCh9oAre+gYxXB+mPafc
         MMgjSeQxt/LZmfNJtzJqC1nhKhIbdY/8mPgagm7BU5DMKy8oDK41Kkdr1WgLG5y7HMm/
         fo5g==
X-Forwarded-Encrypted: i=1; AJvYcCUz1CoqA4qEz4C8HsFU7902op2tlvBQbccHWL+HpjzgxR6ldr0qMOj8g0OM1ME+vcNbe+s42Vl8MHtPpNwAz/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPM9G+QBaz1Bbcss/5VYqnFaJ8QZcInXqQGqwzSDf0FFGhGfR
	8EbhHmiVRHkt3zpkzDomBuAoBHet3/66J4pP3zEGdLudkWPByVCFfsYg9DYv1PTPRxST6kOEkIJ
	A9MeRSQ==
X-Google-Smtp-Source: AGHT+IHU2CykiJSiQvxXiEw9anmIf5P5FGVKtn7cQ47VHoNwLlgG0OkW/k4wbNcHBidn2YUs/QsPYppALFJG
X-Received: from plgu5.prod.google.com ([2002:a17:902:e805:b0:223:58e2:570d])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:224:26fd:82e5
 with SMTP id d9443c01a7336-22780e29ebfmr212668755ad.48.1742837628794; Mon, 24
 Mar 2025 10:33:48 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:15 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-36-mizhang@google.com>
Subject: [PATCH v4 35/38] KVM: x86/pmu: Expose enable_mediated_pmu parameter
 to user space
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

Expose enable_mediated_pmu parameter to user space, then users can
enable/disable mediated vPMU on demand.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/vmx/vmx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bff351992468..a7ccac624dd3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -265,6 +265,8 @@ module_param(intercept_smi, bool, 0444);
 bool vnmi = true;
 module_param(vnmi, bool, 0444);
 
+module_param(enable_mediated_pmu, bool, 0444);
+
 static bool svm_gp_erratum_intercept = true;
 
 static u8 rsm_ins_bytes[] = "\x0f\xaa";
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7bb16bed08da..af9e7b917335 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -147,6 +147,8 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 extern bool __read_mostly allow_smaller_maxphyaddr;
 module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
 
+module_param(enable_mediated_pmu, bool, 0444);
+
 #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
 #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
 #define KVM_VM_CR0_ALWAYS_ON				\
-- 
2.49.0.395.g12beb8f557-goog


