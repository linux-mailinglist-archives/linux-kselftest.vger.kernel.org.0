Return-Path: <linux-kselftest+bounces-18121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478E97C114
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48433280FDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106B1CC172;
	Wed, 18 Sep 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vmb96NJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF251CBEB9
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692847; cv=none; b=MleR+NfOA2TWm6QodcTD7Xi2x2JlnAU5gbP4RSkwmVljXsNpQLXdG3WOKlMNcfturONfa/D7uas0k8aodBhnrnVB4YIy1AWpab446T8O/mITs5bgTD5yrPTzCpn6szQr8XfO1oydchZK3/Dx8HKlCU6A5bTX+gZ2SYriLCblNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692847; c=relaxed/simple;
	bh=7lftzIKbcSxucYuctQDN98Dpt0HaKLFwYLG6pvMyEYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pu2NVPiLBis1DdwHc1tZOc1xp66u6vSfOOoytW7V342xkGPjknswb3x+bmr0xY4TD27Gi+1bsaTcoJ66FUhm5EwVqlKUhIYGhpaJxob525XR8DhgXwk3i19jnFIAQdt56+3AzYebfFP3gK1wjuUTXlpuu+W8TQh5hIX3wJKMH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vmb96NJW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddd780071aso2775087b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692844; x=1727297644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbRHlJWsXfETUkB7lf/JUuYpXn+WfUYF/WjjWZw/9E=;
        b=Vmb96NJW5wZdL9uMiXA/Cb2yRpQB8RJCheTLsaNwk1ZC5zpnPax5BnGTjKuEvBO4rU
         Vu7p2R2jYuLJMYAsa6w75a1wozyW4EYkTtp8wpzgMzaONqA2sQMkY21ILINc4clk1rZK
         UrqU8pKo6poNv8VZTg7d42ocaXgO/2icDV486FuzgJQpD023K/JOZ4ngVE6pOkjaR9dL
         kGshk7IoZU6J9iw5qF8CSkWmRZbz3Nq7seSYW6jUm4CS86oldsaJZdxtnVpArWR+1aC4
         Tq+aizud0H67xRYF5+ztgAb9tBuKaxkWMRCj4mDxiFLLpNwftileGdEsOixNXsva/H/o
         V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692844; x=1727297644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwbRHlJWsXfETUkB7lf/JUuYpXn+WfUYF/WjjWZw/9E=;
        b=CtYfcsdkncno2hsAlk2DTZJNt/tWgR/2n7HenFqDL0QngFyiiQmYDh6RqYufoVXAnl
         OAI7/CpetPbEAY/ebzyj7GSTDLLvMtpwuvPQ2zgOEI1D/FETL8uaFNmYQBJd+HBehoLW
         00TzZNH97KkMF+RzPC/MTgL9o+HpjEVomE5YrgipziRav31phkHvTsl8z+D6iFpZ3089
         b3dncBsPudBG1XelBDl2w5tSkBZy0A4jX54QefP9IgyyNLMUlFufgGm9laSWcONFqbrR
         ChUq4mxLQr5BxudNRwedYeVKYOzSw9g69dZRXCh8OiPxjxGioGmOVDmSxvwYTuUtpEGD
         6hfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkoQ8QopUkRITTg0BfojGxrOZP9Ys4X2mHuff8qkCrvCnqlcWDbozjSLnMz2s5nk2oyHo6gj0NTYY+vPuyanM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzidrxnq6tUY4Ji2nicigEV9AAzqv4uae9Ch7TKuZflSHBe3eKP
	fu3hZ1oNXD/YMpyt2QqezqAYIvoS2Ojb7RRaeA0LVreHLXXcmu+h8toHZG6KNsoen0KxgbrXfJi
	QtNO3FlwhC0XvQX+3DcDhmQ==
X-Google-Smtp-Source: AGHT+IGX71Bs4ynlMO6RpldIhTDezO4HT10BKhTJLPvF7++iCSxwIHxzTRlwd8WiZLUT1Ztu62GuXvgr+RyuJZjJbA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:46c9:b0:6db:c6ac:62a0 with
 SMTP id 00721157ae682-6dbc6ac6618mr13380607b3.5.1726692844213; Wed, 18 Sep
 2024 13:54:04 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:19 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-7-coltonlewis@google.com>
Subject: [PATCH v2 6/6] KVM: x86: selftests: Test PerfMonV2
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Test PerfMonV2, which defines global registers to enable multiple
performance counters with a single MSR write, in its own function.

If the feature is available, ensure the global control register has
the ability to start and stop the performance counters and the global
status register correctly flags an overflow by the associated counter.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index cf2941cc7c4c..a90df8b67a19 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -763,10 +763,63 @@ static void guest_test_core_events(void)
 	}
 }
 
+static void guest_test_perfmon_v2(void)
+{
+	uint64_t i;
+	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
+		ARCH_PERFMON_EVENTSEL_ENABLE |
+		AMD_ZEN_CORE_CYCLES;
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	uint64_t sel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
+	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
+	uint64_t msr_step = core_ext ? 2 : 1;
+	uint8_t nr_counters = guest_nr_core_counters();
+	bool perfmon_v2 = this_cpu_has(X86_FEATURE_PERFMON_V2);
+	uint64_t sel_msr;
+	uint64_t cnt_msr;
+
+	if (!perfmon_v2)
+		return;
+
+	for (i = 0; i < nr_counters; i++) {
+		sel_msr = sel_msr_base + msr_step * i;
+		cnt_msr = cnt_msr_base + msr_step * i;
+
+		/* Ensure count stays 0 when global register disables counter. */
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		wrmsr(sel_msr, eventsel);
+		wrmsr(cnt_msr, 0);
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+		GUEST_ASSERT(!_rdpmc(i));
+
+		/* Ensure counter is >0 when global register enables counter. */
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		GUEST_ASSERT(_rdpmc(i));
+
+		/* Ensure global status register flags a counter overflow. */
+		wrmsr(cnt_msr, -1);
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0xff);
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		GUEST_ASSERT(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
+			     BIT_ULL(i));
+
+		/* Ensure global status register flag is cleared correctly. */
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, BIT_ULL(i));
+		GUEST_ASSERT(!(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
+			     BIT_ULL(i)));
+	}
+}
+
+
 static void guest_test_core_counters(void)
 {
 	guest_test_rdwr_core_counters();
 	guest_test_core_events();
+	guest_test_perfmon_v2();
 	GUEST_DONE();
 }
 
-- 
2.46.0.662.g92d0881bb0-goog


