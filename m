Return-Path: <linux-kselftest+bounces-34366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB44ACEDCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 12:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B607A5C36
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95421C182;
	Thu,  5 Jun 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFxvB3m/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E7218821
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119828; cv=none; b=MebMZ1FU0kU/fr7t2Lhhnf79pn5mTT474mbA2VHPpz2WJ6tq9RsZ7ROXUMD6HclaArkuXmXfm+0lGKw9o2Zcc3H+Zqy8Em/MZWZTxcBmMmvdFUTWO37VzbySbic58WGrolCO+gl8/J1Ciuo6y0C9Xd6dVKsXRSUYL7gxLIW9eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119828; c=relaxed/simple;
	bh=KbwWFQ1kTo+qRw1U/gTjGAckXKWUWt6XmW7dlBGCSqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDskZpN9UBZFiEN2DKPzmQC07UKbBSQBZC5AomOJv/AGzx6LdgK+zhS6lI8qrX98KwzzpNtJHTpOQfpQUaeUxH61d5z4P7p9SfqT218C/XxdiAhsQpuRJX4PCTYTwuVE4F3ChVFaJETpyMGgevAH0OI1/JrHWjDBHrIqYMDPEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFxvB3m/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749119825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amWbxwyASZoUP07CpGcLTUSUvzxbgFk3ulFVLl61SIw=;
	b=UFxvB3m/NmZFQ4HCFPecHfmIpmoMLhnv+SFZIVy+/t+Z/9yLA88T0Be5ee99ubrXV1jv07
	lFtYxtvOXnJbZ3LGm1tqjJnQy88BSB8yEzGKk18fHOUXNeYQgmBZPBe94A3o0p1YqhIj+F
	BwzoZsDgK7Yd78q0ud+blzYtDaSWYWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-XybFjlU7MbCQr6r_TOqxDA-1; Thu, 05 Jun 2025 06:37:04 -0400
X-MC-Unique: XybFjlU7MbCQr6r_TOqxDA-1
X-Mimecast-MFC-AGG-ID: XybFjlU7MbCQr6r_TOqxDA_1749119823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d57a0641so5614115e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 03:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119823; x=1749724623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amWbxwyASZoUP07CpGcLTUSUvzxbgFk3ulFVLl61SIw=;
        b=oknnl9ORToAVrPn1QX9C3TCa4LoIW/lloJnoQv1rwX/aKnSBrgx9Nc6Q9gdyw6FRXu
         a2xMgswh80rud8FGHBoqN+A5K6mj5w+Fc6h5ZFeUJiE+ROSYkp6L+o1hjpXRfohuBSTG
         OOpaMPjtj2XwM7GWbHMI8otUG9PTfrshdtDOWX/l9heiT0wc1B5qT80o6VgQpretUhwV
         dxHZHlH7EXbySU1/syuxOvZLsSLZrqfHeMdZjvBCvwYDXj17Txr8uLTc/TU+9GdP/deM
         lGJYe5A6hApIvkofPCLJAcO8spXamJb6BprsS6d/QmTzAWRpLFoDhDCW3Uu6h6FQu3LA
         lHDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnoDFLJSJR12buBXKFMln+WSnf61wnK3xuCx19ThemtSzedjooS9ZpCzu0Fiy3zwDD9UBy20Imfy9FPC9N8NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9iERLsXiryIEjCvMT+CXqtZ+c7M/lfHpt4gjEb2NuGnNHleT
	QVUDpDxl5drKOdwObjgB8oEjQ39ysgnqnREGTrPJQDdvR58+i0gs2ZXg8YNXROBeGSy7GF8DXPT
	V+uCZ1ANKwh1jCN8LGhrWmcFYHCTRQ4eG7FV0IVvpEGw4KXwmFmEabVvYaw4SS0p3NR9ORQ==
X-Gm-Gg: ASbGncsY9EbuhBab8Lu/gT/lEl86AcpdhrJZyKvCZVGbFmudZ7/II7jBUUjyDb5oLOB
	fI0o4UUmdVMxbZRbUcLPPMsSxkn/1tfr0bcRVC8tKBMqhdQWcdJssEKS2IQD0ZQk+nFY7jdlZFi
	TY59iDtCLiNOwGyH99NTSmUrzEewqRrDDpb/xMYfnUKaUsulBwyGqxSRL4jg5L1iwkXxTKzeRYs
	QQDluctTKAb+slLXDjjidEHMD0Kgr4+/2JV7olNEH8lyzMiQumV2gT4kCRDCh/R/QMKNqOMOW7g
	OsNQ4NKAz/271yINdq6RW88wU50UOYoasrDXhYDPbFlW3z8OMqafWjuxZ5yY1mkg6i11uACi0A=
	=
X-Received: by 2002:a05:600c:3b2a:b0:450:d5c8:29ae with SMTP id 5b1f17b1804b1-451f0a72e7bmr51415175e9.1.1749119823009;
        Thu, 05 Jun 2025 03:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtZcZkRv3ekScQM6gx63V+kNA53R9LzjK0Zl5xkWmfvukrEiqxBs91K876Y3Lvx+XWubrwg==
X-Received: by 2002:a05:600c:3b2a:b0:450:d5c8:29ae with SMTP id 5b1f17b1804b1-451f0a72e7bmr51414985e9.1.1749119822583;
        Thu, 05 Jun 2025 03:37:02 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm14105175e9.2.2025.06.05.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:37:02 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Colton Lewis <coltonlewis@google.com>,
	Ricardo Koller <ricarkol@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 4/4] KVM: arm64: selftests: arch_timer_edge_cases - determine effective counter width
Date: Thu,  5 Jun 2025 12:36:13 +0200
Message-ID: <20250605103613.14544-5-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605103613.14544-1-sebott@redhat.com>
References: <20250605103613.14544-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_timer_edge_cases uses ~0 as the maximum counter value, however there's
no architectural guarantee that this is valid.

Figure out the effective counter width based on the effective frequency
like it's done by the kernel.

This also serves as a workaround for AC03_CPU_14 that led to the
following assertion failure on ampere-one machines:

==== Test Assertion Failure ====
  arm64/arch_timer_edge_cases.c:169: timer_condition == istatus
  pid=11236 tid=11236 errno=4 - Interrupted system call
     1  0x0000000000404ce7: test_run at arch_timer_edge_cases.c:938
     2  0x0000000000401ebb: main at arch_timer_edge_cases.c:1053
     3  0x0000ffff9fa8625b: ?? ??:0
     4  0x0000ffff9fa8633b: ?? ??:0
     5  0x0000000000401fef: _start at ??:?
  0x1 != 0x0 (timer_condition != istatus)

Note that the following subtest only worked since the counter initialized
with CVAL_MAX would instantly overflow (which is no longer the case):

	test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);

To fix this we could swap CVAL_MAX for 0 here but since that is already
done by test_move_counters_behind_timers() let's remove that subtest.

Link: https://lore.kernel.org/kvmarm/ac1de1d2-ef2b-d439-dc48-8615e121b07b@redhat.com
Link: https://amperecomputing.com/assets/AmpereOne_Developer_ER_v0_80_20240823_28945022f4.pdf
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 .../kvm/arm64/arch_timer_edge_cases.c         | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index be8bbedc933b..b4d22b3ab7cc 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -22,7 +22,8 @@
 #include "gic.h"
 #include "vgic.h"
 
-static const uint64_t CVAL_MAX = ~0ULL;
+/* Depends on counter width. */
+static uint64_t CVAL_MAX;
 /* tval is a signed 32-bit int. */
 static const int32_t TVAL_MAX = INT32_MAX;
 static const int32_t TVAL_MIN = INT32_MIN;
@@ -30,8 +31,8 @@ static const int32_t TVAL_MIN = INT32_MIN;
 /* After how much time we say there is no IRQ. */
 static const uint32_t TIMEOUT_NO_IRQ_US = 50000;
 
-/* A nice counter value to use as the starting one for most tests. */
-static const uint64_t DEF_CNT = (CVAL_MAX / 2);
+/* Counter value to use as the starting one for most tests. Set to CVAL_MAX/2 */
+static uint64_t DEF_CNT;
 
 /* Number of runs. */
 static const uint32_t NR_TEST_ITERS_DEF = 5;
@@ -732,12 +733,6 @@ static void test_move_counters_ahead_of_timers(enum arch_timer timer)
 		test_set_cnt_after_tval(timer, 0, tval, (uint64_t) tval + 1,
 					wm);
 	}
-
-	for (i = 0; i < ARRAY_SIZE(sleep_method); i++) {
-		sleep_method_t sm = sleep_method[i];
-
-		test_set_cnt_after_cval_no_irq(timer, 0, DEF_CNT, CVAL_MAX, sm);
-	}
 }
 
 /*
@@ -975,6 +970,8 @@ static void test_vm_create(struct kvm_vm **vm, struct kvm_vcpu **vcpu,
 	test_init_timer_irq(*vm, *vcpu);
 	vgic_v3_setup(*vm, 1, 64);
 	sync_global_to_guest(*vm, test_args);
+	sync_global_to_guest(*vm, CVAL_MAX);
+	sync_global_to_guest(*vm, DEF_CNT);
 }
 
 static void test_print_help(char *name)
@@ -1035,6 +1032,17 @@ static bool parse_args(int argc, char *argv[])
 	return false;
 }
 
+static void set_counter_defaults(void)
+{
+	const uint64_t MIN_ROLLOVER_SECS = 40ULL * 365 * 24 * 3600;
+	uint64_t freq = read_sysreg(CNTFRQ_EL0);
+	uint64_t width = ilog2(MIN_ROLLOVER_SECS * freq);
+
+	width = clamp(width, 56, 64);
+	CVAL_MAX = GENMASK_ULL(width - 1, 0);
+	DEF_CNT = CVAL_MAX / 2;
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
@@ -1047,6 +1055,7 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 
 	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+	set_counter_defaults();
 
 	if (test_args.test_virtual) {
 		test_vm_create(&vm, &vcpu, VIRTUAL);
-- 
2.49.0


