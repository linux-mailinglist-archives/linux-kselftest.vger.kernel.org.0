Return-Path: <linux-kselftest+bounces-28106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74474A4CED4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5C41898399
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2185124168D;
	Mon,  3 Mar 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jifWr2nx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBE23FC75
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042399; cv=none; b=q9mNc9W78hGPuQEo8BE+2R3ze3s5qdRPnt7pkWaRmcZp/YM1gN053U94JRmsm7ELW9J2kxgolTykXYWnsJP1thzux6TsFVLEj5YSmLOXA/UiRrQDXH1wmfDbhSeXBA8k3+WKtYMaQ+RuHzxi1BnUvHuvAYO0FY66huF+LEeCf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042399; c=relaxed/simple;
	bh=nT1SZDmhRpluE6T0UXqXL8ivt7r+ikBYyrkgQ9kcFWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpsWWENarWYXeuVqb5VC6b1YXNq7FBZUZ2jElXQnIFoc+afSdqWs+F3YR8Jsv2rcYEiIIXP5Txs1TfKMZl+euYLzw3bOX8YHPw9IWkeDMuGjSl0YSPjJi33/YJVmRm7uVGGhYdfYRvPOI+3/T4Xp/eS+APCpPtz1c7SY7zbInrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jifWr2nx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so92314355ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 14:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741042396; x=1741647196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCtM/lSFNLHVQ6KX2EDg2QNHrviALMnTGfDgB4f3TXM=;
        b=jifWr2nx4e35qYZjqR6eXb8khK+zuhylyXa25mW3z0ZH4ij1JG0qWGVhxOdHF+Sgy9
         wukzH02Bb5J1DpS8p0esZEhFF/Kh9//vKDoMhAO1MfgK2/DtIR9i/ThlSo5XDiwtDTG1
         TsPpTZW9Y2+ZbjzJrLNHni7BhU+lxelqzeJD8kOO6uTCksLY8Iatmnvj+0bPUbrtvmmf
         yx9+JEMt4jOF7DJ2KLnZKbEeheVPsLMlvFYSdLb5yANVm2x1+ry2hEGgCtSJqUmzxMpc
         mbnZubhuU57YEdRdIIGVBLQ6d3SIi7Pt/k0Jpb/VR2YCLYtJ/ivNdeijVS8+qn8OWl6C
         vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042396; x=1741647196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCtM/lSFNLHVQ6KX2EDg2QNHrviALMnTGfDgB4f3TXM=;
        b=QQe4SR4iJLL7xp9Fr08u6r5fOttIeUF372j4KCSx0VDBmDUjFHl9puJp1+Ky9XiY2Y
         rOqOjt4T0gWu8B/vzOYQw5XmKYC1PqI8IbNVktt4rg4cKmCFbbwu4EoEJHRBxWH9YcUU
         KXPWZ/ycpmW7RZ9OJkHhLYUXxeHylyiTdpV68u5Hyzi+ZYuUfB6vq6Kv8qBb96g2WTSD
         fk/qcR1hPz2SKzpHJcc1wxOqPRa8RlhZJUCRgaO1CDpR/EJ1boeV7feE5Aa7zcLyKfev
         5yHjW/+lgim2PjDFECSfi5+MI6V07NxSapECUHOk7sihRvvn5EUwqTm9fouJu6D0sweh
         ZPdg==
X-Forwarded-Encrypted: i=1; AJvYcCXN6ULtlb5I8sE69mvP2K7S+JDmIwQuDuvq+pJwVq9F1PsnmFfWRc2WT7ehmIbv9w76P1Kq4yuHKvlgOLFE544=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGfAcsMWMJfnPnQHkG92Gr6S7J5OPvcttaGsVFHnPC8a0fzf8
	67VBx6cujTSw4x/Cc/dq4eFjqBGOxNcCUh+MtYXFd53ckptr+E6uL6TLF5DJlZA=
X-Gm-Gg: ASbGnctD7HbAUs9ltMptpPbre+I085J9Swi7WsZQkatZIXgDkiJZVTl+GXMPPxpa1Hd
	QSFd+42rHY00eaAoKxOzp3Lio93+/kMZ9VBYPFWOVZ4qs/ZpxPNb5hanxlD+HxszRbn18a0oARK
	khSaateqUri/4BPcT2LvxzrndvnOKsNAqF6ufR5dG66fBDFPdl9zX2RyfXXeZgevQZ6+4x9fI0C
	FIJRaU/6fO7yXJ5Sv7kQfkoX0CxD3GdJl0JyIuuQRLmysS9Vpb68Zlq84CqRiIpiLfgjbfuD4nZ
	aS/4D8NVN+lHGeZd4NyJ8dyv7rS/U6IqCwOwyATssQDIysVfcsfL1M3tgQ==
X-Google-Smtp-Source: AGHT+IGXirVkG7YmM+e3F/UoJqVCuA4YUPHtWRuh1VU5G5YFfQvPrt0/VrZAaOMzGSWX8Cr6YTAmAg==
X-Received: by 2002:a05:6a00:92a1:b0:736:3ed1:e842 with SMTP id d2e1a72fcca58-7363ed1ec20mr10954047b3a.20.1741042396365;
        Mon, 03 Mar 2025 14:53:16 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb4fsm9440601b3a.129.2025.03.03.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:53:16 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 03 Mar 2025 14:53:09 -0800
Subject: [PATCH v2 4/4] KVM: riscv: selftests: Allow number of interrupts
 to be configurable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kvm_pmu_improve-v2-4-41d177e45929@rivosinc.com>
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
In-Reply-To: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

It is helpful to vary the number of the LCOFI interrupts generated
by the overflow test. Allow additional argument for overflow test
to accommodate that. It can be easily cross-validated with
/proc/interrupts output in the host.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 38 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index de66099235d9..03406de4989d 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -39,8 +39,10 @@ static bool illegal_handler_invoked;
 #define SBI_PMU_TEST_SNAPSHOT	BIT(2)
 #define SBI_PMU_TEST_OVERFLOW	BIT(3)
 
+#define SBI_PMU_OVERFLOW_IRQNUM_DEFAULT 5
 struct test_args {
 	int disabled_tests;
+	int overflow_irqnum;
 };
 
 static struct test_args targs;
@@ -478,7 +480,7 @@ static void test_pmu_events_snaphost(void)
 
 static void test_pmu_events_overflow(void)
 {
-	int num_counters = 0;
+	int num_counters = 0, i = 0;
 
 	/* Verify presence of SBI PMU and minimum requrired SBI version */
 	verify_sbi_requirement_assert();
@@ -495,11 +497,15 @@ static void test_pmu_events_overflow(void)
 	 * Qemu supports overflow for cycle/instruction.
 	 * This test may fail on any platform that do not support overflow for these two events.
 	 */
-	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
-	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
+	for (i = 0; i < targs.overflow_irqnum; i++)
+		test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
+
+	vcpu_shared_irq_count = 0;
 
-	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
-	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
+	for (i = 0; i < targs.overflow_irqnum; i++)
+		test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
+	GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
 
 	GUEST_DONE();
 }
@@ -621,8 +627,11 @@ static void test_vm_events_overflow(void *guest_code)
 
 static void test_print_help(char *name)
 {
-	pr_info("Usage: %s [-h] [-t <test name>]\n", name);
+	pr_info("Usage: %s [-h] [-t <test name>] [-n <number of LCOFI interrupt for overflow test>]\n",
+		name);
 	pr_info("\t-t: Test to run (default all). Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
+	pr_info("\t-n: Number of LCOFI interrupt to trigger for each event in overflow test (default: %d)\n",
+		SBI_PMU_OVERFLOW_IRQNUM_DEFAULT);
 	pr_info("\t-h: print this help screen\n");
 }
 
@@ -631,7 +640,9 @@ static bool parse_args(int argc, char *argv[])
 	int opt;
 	int temp_disabled_tests = SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVENTS | SBI_PMU_TEST_SNAPSHOT |
 				  SBI_PMU_TEST_OVERFLOW;
-	while ((opt = getopt(argc, argv, "ht:")) != -1) {
+	int overflow_interrupts = 0;
+
+	while ((opt = getopt(argc, argv, "ht:n:")) != -1) {
 		switch (opt) {
 		case 't':
 			if (!strncmp("basic", optarg, 5))
@@ -646,12 +657,24 @@ static bool parse_args(int argc, char *argv[])
 				goto done;
 			targs.disabled_tests = temp_disabled_tests;
 			break;
+		case 'n':
+			overflow_interrupts = atoi_positive("Number of LCOFI", optarg);
+			break;
 		case 'h':
 		default:
 			goto done;
 		}
 	}
 
+	if (overflow_interrupts > 0) {
+		if (targs.disabled_tests & SBI_PMU_TEST_OVERFLOW) {
+			pr_info("-n option is only available for overflow test\n");
+			goto done;
+		} else {
+			targs.overflow_irqnum = overflow_interrupts;
+		}
+	}
+
 	return true;
 done:
 	test_print_help(argv[0]);
@@ -661,6 +684,7 @@ static bool parse_args(int argc, char *argv[])
 int main(int argc, char *argv[])
 {
 	targs.disabled_tests = 0;
+	targs.overflow_irqnum = SBI_PMU_OVERFLOW_IRQNUM_DEFAULT;
 
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);

-- 
2.43.0


