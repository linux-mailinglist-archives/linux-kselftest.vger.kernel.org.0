Return-Path: <linux-kselftest+bounces-14738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EE94632D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53E11F271AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6731A707D;
	Fri,  2 Aug 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcyhGZeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB23DABFA
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623013; cv=none; b=RqRXDJUV9k7gsN/E3SIsdI5cj3oAhqlq6JdaZ6lxJMlEX4yeqwfBn2aK57Cs698at/RnbOICK4LTa4yQLV8vIwCxbjceNgPqexIcSNStNBEv4ZOpQhsTRLOXwHkR3qCJ7RyAHJeV21olcVF7dekPA/zfCG2MIvE1S4WYajkPLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623013; c=relaxed/simple;
	bh=tgoIWaFUxQM33b8qbHZPnhnEYawHBB93RkKWU1DvJ5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JoRdeCkc3vTgYhDs1E6gg+FtQwZ3CaG2YyCh1iCaGkJVwhzGAG1rZMLZG9S4x+o8q51mGNYSaFq49Z8bx4OGXaBFZ1Bp9Idj/MgB5dxql0lvj3Vc3jBb2s45q7z9FuARi01iNOftAwVQY552iw3LxWOHP7xjAlmkw5RACdBx0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcyhGZeJ; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-81fa44764bbso960455439f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722623011; x=1723227811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPSm5NDWiDpCdwUb4qZlzg9JxWn3iBSQZ4jPnuSz7Zk=;
        b=LcyhGZeJwk56GBN/EP4/Wq6x/gixCHn+xbY0DrUv+pNUrIkSm1J9Ejx5zztxpkJSfI
         1Ft3wP7iRQJGoZrdI7HD/UF9Yu8aM8EvYfynFAjWej9bJktjTETPDTXaOTLyfx763oVb
         y6/PIuc2NFT9xc+eCPiu7z+jtBH0B7QYgLsQ3Abwb/XQHJ/Un3qME3U3v9D+x53af5Wm
         cOLi0SYPEDp5a1zteAQBWJW8EV+TOlA9zBqriot9eQzdmp+vEVU2BndMxiX6aUj6Xxvg
         bsNYnihQz+903gt9O7V0aHxeHnsAtcDJmyPor4esn8WOyHJg7Jv/mX8a3+x/IDEKcqqU
         Yxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623011; x=1723227811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPSm5NDWiDpCdwUb4qZlzg9JxWn3iBSQZ4jPnuSz7Zk=;
        b=lv95N4RfDr/+4RZe0Phfy8yY1J91W7ZAJBhvaGjbnRuCeoVWeON94vQOrFEoFzfdV9
         FWjxhAvPVH8xxjVSHUZLYiDEhq3xsZDIjuY1AJXT7Xb60kHRMLwQ266fZdhpU5JMHbk5
         Vqbgys3eJp2mT3EYPnxFlMhc8oLM6i36aNE+nE5utlbajlLq+5sI2/IGd/n6e5Gf+ax2
         +U5YWicHJXHL5BklIcBwKXNJyg2eTXm2geWo8To0GVpWqmnlmXYa+1bjvsBYVzKZfEQj
         XWYF6RpoEAyJV6V1KUN494DQF5JsFmo4pJTW++5VNR3Fp9gwOXm1uTfVBGCcjw14XZN9
         SPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwNOtPaBLlKpn8yUA2DyB7Nb/2pn+umDo7m62NsUu5mVU/hcdeevzesCLhDRTbQWUShvERpxzbHRZtLFo2b7P+5GM/g5scPYjtUv9c0yA/
X-Gm-Message-State: AOJu0YxOa8vtJYoqK4wzwpqqM4SPbuvW56WIyKoCxbCuYuirIef40DjQ
	+50SRunfnvbsk1WuHcQ0i7mt04MF38lfkOiXN3Z93LmV8iNHLhYFJ7IA3/lLDjIx7zhdUgGmAiY
	jj7cQkB8ih9q3ard2uGuxqQ==
X-Google-Smtp-Source: AGHT+IGsFTuzpN6+gjclXj8JUDgT+VULd2GmamyAkeXPWpy0H9xcVwD8Jmzh08GAnse9QMclSk9M4TynhXIDCWzm3Q==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:410b:b0:4c2:7945:5a32 with
 SMTP id 8926c6da1cb9f-4c8d56c392amr239836173.5.1722623010994; Fri, 02 Aug
 2024 11:23:30 -0700 (PDT)
Date: Fri,  2 Aug 2024 18:22:40 +0000
In-Reply-To: <20240802182240.1916675-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802182240.1916675-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802182240.1916675-7-coltonlewis@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog


