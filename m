Return-Path: <linux-kselftest+bounces-15246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E54950A9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4831F215F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF11A3BA0;
	Tue, 13 Aug 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgq/oa8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1981A2C38
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567400; cv=none; b=Q+fdOERwJBWRaK/kvrvgpzyQ136+AfmiQgBGhZjXAJnN0FpGv/ETNRfWXPY17HqZibaGkz9Qfg4e7qISHyDDzlzFLucBXcs5Gcr8WNJpfxc6s7Mwd4T38NN0FEf8Zu1uJzW9xXnhesfBY3qccmmHS4AWFG6q9hA8rafMKebAws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567400; c=relaxed/simple;
	bh=EmQwFVXc+If+aLGuw6XYo0hnZj9qP7zy1jdY/Fa8mXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wym+0uh50M6SRAEuFJfW3/B6IvEQZOA39eoc2cnE3OvbQ9AysNotVhqtHRBYdmeXw/o8axzTKKqboABxO/ByMkdroOLAnKLgOjpcaH5Y88axtdgdvc+ItqhPrBAJoAdp0S2cWgLaEeGTbrwPEcLA1CLU55GpLlz1HLKx4a1qyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgq/oa8C; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-824cad19812so152010539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567398; x=1724172198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMXWLKxA64xiZoChdgelcLbcEELaiOp5iXK2pYOqGww=;
        b=wgq/oa8CzpznRkJ3fQlssZ+hpHCRLMtN4Ur7G5L9St59BxI4w5TrGXBzmcvtmZziQX
         xmzYW+KG5wNDl5B2acbzvPkQMans45M/50ahgEa6mE5B+akdAiYJEvEsj0s58/BeqElY
         v7+Wu7U5Khep1/SyWVBLZblkHIRwkj2ivrkvdFqyzmdd+JifD7bT7HPI80S802U1uNks
         ScUp9SpBlUcxEP+gf//yr7I1zyLL2NFQupBxdX8BquV0hTGDIOPi827QekYPnNJMH8SI
         +AEVu4DDv5g3b4L9jO0tooRVtn26eVglZBnTZQqjh1E4s71lmHh/eKhklKmUNAxsDI12
         S5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567398; x=1724172198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMXWLKxA64xiZoChdgelcLbcEELaiOp5iXK2pYOqGww=;
        b=l9JS7w4bCjpS0mk8B2fL2lzZtFgZec89aZWEBjPUVcaROF+1XNq6GqqzXOhzbNjuyc
         9qVcXIf9o7eLD467EznXxix10lZg8rEogCl17ycpa0wYMXieYUA0QgWvACgvkVl10VE4
         sR76Dt7wce9pccm8XBivX/D0KcCrF2bSiXrKnR16pZSk2rpE/XjJQMr+aAgF+NIHn4+h
         iXb66yT3tbI8ED2r1MtccXXfle+4EbkT6JOyJC38EeQHawYg7INsvptBrngu6crras8c
         LPM2DdcOEn1fq39Eu2SqWTpDFWhCxFk0XGoz+wJoNMG0ffgyxxRptwx/Bo1XHfUtNukw
         RyfA==
X-Forwarded-Encrypted: i=1; AJvYcCXgu7NG5isYyV+O5RlwZzbJF3DaIjugyWAvZlqp6upJykCeoegSOh8l+NtPGT21aNZD03ClITNg33ErkIbyjeFwrFKmAr2pG/xZ0FnIKsKW
X-Gm-Message-State: AOJu0YzyTN102nL/5Q0po7LsvALzwEZQnqGzvy9eHnAdXvYlHLZNvfg+
	5MiGACCCwZfc9sfnaWTs5C7MZj4VefyNinUryeqdg4+G83XD1DUM8ugdG4xugZWH2oEMHRCI0/b
	ZpHMeCySS5f/p701EUCyu/A==
X-Google-Smtp-Source: AGHT+IHZlNl2VWw0yLBBiEzDHzM6lXzhOGB9jiE+hED44NQa7g5LUmhhs7tT6Z7SIWGU3cSf3l3odnU3v1xRfdLb5A==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:1602:b0:809:b914:a53a with
 SMTP id ca18e2360f4ac-824dabf020fmr282939f.0.1723567397854; Tue, 13 Aug 2024
 09:43:17 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:42 +0000
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-5-coltonlewis@google.com>
Subject: [PATCH 4/6] KVM: x86: selftests: Test read/write core counters
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Run a basic test to ensure we can write an arbitrary value to the core
counters and read it back.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index a11df073331a..9620fc33d26e 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -324,6 +324,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
  */
 #define MAX_NR_GP_COUNTERS	8
 #define MAX_NR_FIXED_COUNTERS	3
+#define MAX_NR_CORE_COUNTERS	6
 
 #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
 __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
@@ -644,8 +645,48 @@ static uint8_t nr_core_counters(void)
 	return amd_nr_core_counters;
 }
 
+static void guest_test_rdwr_core_counters(void)
+{
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	uint8_t nr_counters = this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
+	uint8_t i;
+	uint32_t esel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
+	uint32_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
+	uint32_t msr_step = core_ext ? 2 : 1;
+
+	for (i = 0; i < MAX_NR_CORE_COUNTERS; i++) {
+		uint64_t test_val = 0xffff;
+		uint32_t esel_msr = esel_msr_base + msr_step * i;
+		uint32_t cnt_msr = cnt_msr_base + msr_step * i;
+		bool expect_gp = !(i < nr_counters);
+		uint8_t vector;
+		uint64_t val;
+
+		/* Test event selection register. */
+		vector = wrmsr_safe(esel_msr, test_val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, esel_msr, expect_gp, vector);
+
+		vector = rdmsr_safe(esel_msr, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, esel_msr, expect_gp, vector);
+
+		if (!expect_gp)
+			GUEST_ASSERT_PMC_VALUE(RDMSR, esel_msr, val, test_val);
+
+		/* Test counter register. */
+		vector = wrmsr_safe(cnt_msr, test_val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(WRMSR, cnt_msr, expect_gp, vector);
+
+		vector = rdmsr_safe(cnt_msr, &val);
+		GUEST_ASSERT_PMC_MSR_ACCESS(RDMSR, cnt_msr, expect_gp, vector);
+
+		if (!expect_gp)
+			GUEST_ASSERT_PMC_VALUE(RDMSR, cnt_msr, val, test_val);
+	}
+}
+
 static void guest_test_core_counters(void)
 {
+	guest_test_rdwr_core_counters();
 	GUEST_DONE();
 }
 
-- 
2.46.0.76.ge559c4bf1a-goog


