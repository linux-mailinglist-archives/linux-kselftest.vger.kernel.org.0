Return-Path: <linux-kselftest+bounces-14736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F286F946329
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97669B22C09
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96F1A7043;
	Fri,  2 Aug 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHRJK8U0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA18A1547C8
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623011; cv=none; b=JCZAWSZggstAHbwNsTh4AO0R1Y0XDZUDB3ze0RmtlIht47G3YRJYcyheRUaMmpb6N+mf+fTkw1TTAlwnQYcko+Z43tHQC0SFUt1U1SL9QsGioPCxAxDQuZWaqRKS5UqqAcWEnUvUSzXgUCrmr78fArCAK6z+G5qW4PhxDWU1jtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623011; c=relaxed/simple;
	bh=CIuwjojs7rpS+psJc+RJYzi9C2oK0OF8c00W1Uh0mtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JSw9qx5HwYyNBR6p+pUj/I2r/hkOT0Sz0HAFqp0dpv/sBvUh5RZBumACIqdNMTacxs3rpU+CVDl5JFkz1vwUdTtTWruyZfPM9mKgPN4VS9fBsGFUtg+NWmzo87qraNm/TuuLG8Q+YIukpmW03xcSR4IV6Gl0FEmg9kMKg0BYpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHRJK8U0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664aa55c690so174525717b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722623009; x=1723227809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5afT5GscEIa1QvLSKyC72Wdy6HySmH8lzP6xcUBFvk=;
        b=jHRJK8U0o0yn84XyvSdyfTb262U1RZB0zAj6kQZ8OEkkAzZFh+n3Ro8TBVBlZF7xse
         Th3JeOjnsG9d5MZtBDfFhvWGciL8CfR30R4E0/0vHKlOwuY2W1Y1IIOSgHM/44vueld3
         VXLaf8d7dPx1JLT6AQvzTcArySG0CfuCxB382t9fY+jE4hZrInxonoYsop7GkyYJw1Vp
         iy2PtsJnH5/0/teKYugC3wostMmWPh9dpuxQjy2VQZtSy7Snx+pWTj/JZk4cQiood8Db
         9fQux77NanR/p9Ul58P97jgt0+74pHE4s/sinBi4MaGyJZ37WDxpLDlkBOvJLLbp3xrm
         nXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623009; x=1723227809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5afT5GscEIa1QvLSKyC72Wdy6HySmH8lzP6xcUBFvk=;
        b=r4jWO8u1RwonKlv07OBmxJYX7luRDYDXCKHVXrc+WwEd5MFNN8QFLakG18Q31bnSfR
         HPfykVQKXFZeeVaRf8boz4Un0hNhjAOPbfWvdydhMp9rKxLI2Rxedh0tB96765DMbtFu
         n3Cr8rd2rHM436c+JWGo5Xh5VIMigHa8xn6U+z6T3V8Ni1viMqu9etGvAeWdSqwV5eiK
         1bGd34pyb2aVxQCHHI5UyL4S8ovMyt2NQKRyphxU1/OWlfNSCvcnj88bX/yrmjnODtvl
         7VNnAdlmBKf/ZkUZOSrrXqWwRaRz/9YEFxSA7b2tTf63kH3q/wUxt1XtDz8lbfq1RWWy
         QzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUZejIrALgkA0UAnaNlTmzHyfb2G6TWV4rFlHc1GzogCNa2qPkyvFP0y8vFlqt7CVwGoDjlVP5376p31CbLT4TIzLfWR/uyp9U09f7qs2LW
X-Gm-Message-State: AOJu0YwdrJUx3nS31mQonA+lvTO40UrD2oKCLnrnKm1/+UQKJW04XbJL
	GtcTaxlCOvrmFbsyMwlA7cQ/cu6NnBhYiPUFrdhLi/p94FKUxSlfNcENfHF0lC5LtZkmh3gG1jT
	Yvls3RSsIo00I121TvNEQ3w==
X-Google-Smtp-Source: AGHT+IE6YNxyq3XlmN/GEMhClPJ8NMEnxfeKVtTHqCREfyuDBwl+pRKSsIGjTPym+cKPwqv8TtrR4O+MvlbIfu3RuA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:c08:b0:e0b:bafe:a7f3 with
 SMTP id 3f1490d57ef6-e0bde428581mr259975276.11.1722623008740; Fri, 02 Aug
 2024 11:23:28 -0700 (PDT)
Date: Fri,  2 Aug 2024 18:22:38 +0000
In-Reply-To: <20240802182240.1916675-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802182240.1916675-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802182240.1916675-5-coltonlewis@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog


