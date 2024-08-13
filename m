Return-Path: <linux-kselftest+bounces-15248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CB950AA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43181281555
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F133C1A4F08;
	Tue, 13 Aug 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOFsY0Cb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27D1A38FD
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567401; cv=none; b=NmFiKp0pp3/eTETPrTgp2Ko/RKb+DqYjsVDNnuBAYrcj/chKVkZY9SctV+Kx7J0PGRfSP1DNqS8FdMj7W1tnhnPKOM7oE75Kbjsv1+NkLO3rhp935qPf/Dlkxpx2+sJwaEYDOxsMxeN+BvDsSWys/T2nBZMoLe63xKGUKOQ4Lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567401; c=relaxed/simple;
	bh=hbna4WT6ykCjoJ+xsQHxPsp0+nTsv9npl8xnbl9uBlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RRe0PH5AShOrhtV8M/plxTZMzXmygO2pM2tkVA+b8aJ+uCf5fBze50dtvSJUyf5GqEm8ANJ+gLXYR1n16oWFGanDYCDwcLtfqiSNPZDuak2OprLunKZ32l7/g9W1io62zisTA5fxAEhjgq3mVGaJtcx36rep/T6GqYuXqkGIhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOFsY0Cb; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-39b349a0234so532955ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567399; x=1724172199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxu2u9J8ROI353JNXDar5TUy9JdYSVQrvfs197UIlhk=;
        b=rOFsY0CbrKWoExUJ7k1S/esI+MCxXotPFCIVRATYPJREzR3Qqg/Ni/ZG2NdIeEqV2d
         LkLwJse4o/Tq6QXq0QUATpBToMyhuF6jSsjY3Vlk/98w0NCA1YzPawbSrHwBvdHLDqFE
         uCuHHEEpSv7BewGMXEy3Nm1P85v7tQXQeUBT+kzHUgPMn8qORkdG2Pc5SMDnsFezGR8T
         4jduXxv07An/hvjfiw0CvCofgGx9A9RvDhq3tb+rs/CWgyspM44NQUKCgw1n9GoTGI7t
         EeZxebzTckK6nM67levHLVB89oLKW3YjF5sqUyzHpA0RoirzM1zHMRK1iJIi3UfqDnLO
         ydJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567399; x=1724172199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxu2u9J8ROI353JNXDar5TUy9JdYSVQrvfs197UIlhk=;
        b=K4M7YncEA71m4gdIJ2jtWc5m1p6EkpHbdIYfYmUGoZ+i9czNT4KzVrh7hKXmzfels8
         t75OeVEUPjt2r4QUTf1OqPVZ4cBQgjGwAyPAtrab9htgQCfqSfExFuAFAn4IxVB0FqfN
         oHIqBGLhAYk5p4UIzk2MPOKrm38vFmLSeDYjNIQSOovmVeTrUFBNKK+/2k2LF6IZRb5G
         4mPZ2lla4QhE/+I+Mj7k7hCh/rTEKjHRbUG/PcKIXOalqn4GLuFNUp2r8IjjKEQQiEaJ
         shqnGkFIN5rX8JITdPZ3ACnt64CteE7B1CjPypIQcY0xh89dPphA+4j0MEORDN/TplBF
         Dacw==
X-Forwarded-Encrypted: i=1; AJvYcCWhugBmuK30FvKwX/7CjYIBqRUHNGxNs9iP5IbwpYZAxeLzNYmQvdPn3CeiwW6FZblPbRqIu2zZzD9uVSNoPeDLz4FE7UmdxvUtzNlAhWga
X-Gm-Message-State: AOJu0YyBCCc1IHjT+q7Us6nmOPvrf3ZpjREyDhstmHLkC2Fni2p9gvqA
	tzYHTdtu9ElaDOKCS536FMfR3Y7nkLV+s1MkKeOGK9XTLi+EeNWkUaZ/83OrYDVG4RZDbyWFW2U
	0SRZ1aODUvNM716dhbAV+PQ==
X-Google-Smtp-Source: AGHT+IElI/1oLpRVwVZMfLBr3yjf0cJI9FMrVKLvemCl2STD5dQWccho2EdHMGhA6wjGDeXQ60Glka2UTwaKewegew==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:9818:b0:4c2:31f5:3137 with
 SMTP id 8926c6da1cb9f-4caaf459bcfmr5907173.0.1723567399664; Tue, 13 Aug 2024
 09:43:19 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:44 +0000
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-7-coltonlewis@google.com>
Subject: [PATCH 6/6] KVM: x86: selftests: Test PerfMonV2
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
index fae078b444b3..a6aa37ee460a 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -750,10 +750,63 @@ static void guest_test_core_events(void)
 	}
 }
 
+static void guest_test_perf_mon_v2(void)
+{
+	uint64_t i;
+	uint64_t eventsel = ARCH_PERFMON_EVENTSEL_OS |
+		ARCH_PERFMON_EVENTSEL_ENABLE |
+		AMD_ZEN_CORE_CYCLES;
+	bool core_ext = this_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	uint64_t sel_msr_base = core_ext ? MSR_F15H_PERF_CTL : MSR_K7_EVNTSEL0;
+	uint64_t cnt_msr_base = core_ext ? MSR_F15H_PERF_CTR : MSR_K7_PERFCTR0;
+	uint64_t msr_step = core_ext ? 2 : 1;
+	uint8_t nr_counters = this_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
+	bool perf_mon_v2 = this_cpu_has(X86_FEATURE_PERF_MON_V2);
+	uint64_t sel_msr;
+	uint64_t cnt_msr;
+
+	if (!perf_mon_v2)
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
+	guest_test_perf_mon_v2();
 	GUEST_DONE();
 }
 
-- 
2.46.0.76.ge559c4bf1a-goog


