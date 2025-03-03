Return-Path: <linux-kselftest+bounces-28105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7922EA4CED3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4494E170D0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FEB241132;
	Mon,  3 Mar 2025 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CxnXxHYZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2B239594
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 22:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042398; cv=none; b=G7MFCrfM0G+47VAz5somSs1vCCyYt2lSS8bYREHNo0ewVxKjN7Wf/qcC+lJyQE3Kk+25iqZjmWb+CoZc0dJRJmOfZ7gOMte053QBg2kaLT8RJaYQB5dOBX8kim/FVAYXQ+DfP6tKObDbLwZ1e7FXkmilPFj4ZRM9ScwP7q7pPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042398; c=relaxed/simple;
	bh=oMiBPDZwgZr5dhcoZQIs4/IJPi1MUwF4a7itoyTuCso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw/7OlzzmI6RX7gqvQszphTPTkEZkHT/1cFeFirTo48HoST/1/gd9Agb934ZTujWMKSlArf2G/Dauwp+7Qx9CRnghMElUSFjCNtSdgk6x586xWhbM8JBshUiOoq45FrpGYSqYSzayqZoczWDZV+vcfLgKF+xM3wZ8s6a5FWV1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CxnXxHYZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223480ea43aso123999645ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 14:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741042395; x=1741647195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSJ9VliM2a+aTryqldG0CH+Q28sfdpKDs8cwc/DPQU0=;
        b=CxnXxHYZW+6+02UjXEd/W0U3wCrXSGBHe5FKWLIm7dbBruAZmKN6C9dcX/tu1NQY1q
         BprpyoGcQRYAEtF1KCEIJEt4EwqZ1Uyl06fgk03q1ZyLs4Jlyu4iwKwEwtlyjoHLFupM
         tr82bZmHNAJdXI2LQM+XN5S0pvMSJ9ALGN9YmyJr2nNjaC823i5J6eu3cWm4T6bNCy2q
         RVMEiEabtG4vcf/MjHC2zkscNo57KM0H47wL39B27hvQ2YJ2TUOfvx2SNXuNVT4W763J
         2GsHMK4iZ04DL+69CXkaDHcGReLSyRKfeYGNplNSrSeG3u0GXR2vATY+w/GlDVFZ4I9Y
         BauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042395; x=1741647195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSJ9VliM2a+aTryqldG0CH+Q28sfdpKDs8cwc/DPQU0=;
        b=wk1ytc0GjZnuxfouBknGyRWh06hTCdr4KtTlVOUNheqrVigDVEjDdQ5GikWnoEA7vJ
         ZRG/y/hsS0AH5P3Y0L6Vs6CGmSpr5jb5XA1YeEytXB+2hBCtq9S7G+EpqMDNKj6bpT7o
         U/ap2zX2f8Ncq9lmto0lVzKlMOWtI9KZgHFb/IiPE/u9hGRtl08Jj9J9EnBtrpbVHk8c
         +eew0a24AWzEngR4UJJf1xJsvGIymVmqYQwzHfceLDoXq4hScVqhVRJx6/8cVa/34MLV
         cqXQYn95u1+MaKYJyQhc5HEnd4vlkFC3WjI6PWSWGTaALj95TX0wkLZ/IlDgYeW7pway
         HlAA==
X-Forwarded-Encrypted: i=1; AJvYcCWU2kLNVnTEmdr6Yx7AnXoccq1kXGtvPQqGldtvlKUeFV7f1jew7Pjq9zGIT/1NIY/UzvSDCqwGCnafzjbGF7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBWfCnewLr7jfKYFBPhcjHZVLhA7xWH2xfYCXMMweHLYviajn
	MOeeJV0yE9OjTGB5keV6PzHHLhV3S2cR8bUiUa4M46gE0zntNvI87kDRuEKiZEk=
X-Gm-Gg: ASbGnctbSctHXveT19guJieAd/7Ntqzkq/10bwi1g4Ald9SMN0kg8tFAHQntqej7KFP
	tQNZIR2ggw7kyQVPUtbo0r4sc6kwhRdInFjNTvo6aLL2Ul6iDY4KNO37wvbRBy+UjfUqHPyZIcf
	2twEC8bjqOIVIzqQTc9ZrceWNQ+KATugY1T+B5y8qYxgTPwTuJCCg3LZ27yNEkm4AaFfLgfWkN8
	vfR1IaYXzQFPLmQLhwYwBB2a+PiNkl3hiIVe95u4WRsbQYyPhNKXn20zCFOr9fG4tUiKpoqTd7E
	IEB7i3nrKs9bmKLOaLhFhwNN8claV62yuBbwrUb4C4AAv/Boga7fqlnASQ==
X-Google-Smtp-Source: AGHT+IFgJxk7LwSBEIbBrY7Dr1CLOJZk/TMcnbzG8visvcRF+/r9iXWzrvGMz6kqm+x+c1jOver7mQ==
X-Received: by 2002:a05:6a00:244d:b0:736:5504:e8af with SMTP id d2e1a72fcca58-7365504e9edmr9350148b3a.24.1741042395376;
        Mon, 03 Mar 2025 14:53:15 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb4fsm9440601b3a.129.2025.03.03.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 14:53:15 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 03 Mar 2025 14:53:08 -0800
Subject: [PATCH v2 3/4] KVM: riscv: selftests: Change command line option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kvm_pmu_improve-v2-3-41d177e45929@rivosinc.com>
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

The PMU test commandline option takes an argument to disable a
certain test. The initial assumption behind this was a common use case
is just to run all the test most of the time. However, running a single
test seems more useful instead. Especially, the overflow test has been
helpful to validate PMU virtualizaiton interrupt changes.

Switching the command line option to run a single test instead
of disabling a single test also allows to provide additional
test specific arguments to the test. The default without any options
remains unchanged which continues to run all the tests.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 40 +++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 284bc80193bd..de66099235d9 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -39,7 +39,11 @@ static bool illegal_handler_invoked;
 #define SBI_PMU_TEST_SNAPSHOT	BIT(2)
 #define SBI_PMU_TEST_OVERFLOW	BIT(3)
 
-static int disabled_tests;
+struct test_args {
+	int disabled_tests;
+};
+
+static struct test_args targs;
 
 unsigned long pmu_csr_read_num(int csr_num)
 {
@@ -604,7 +608,11 @@ static void test_vm_events_overflow(void *guest_code)
 	vcpu_init_vector_tables(vcpu);
 	/* Initialize guest timer frequency. */
 	timer_freq = vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency));
+
+	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, timer_freq);
+	sync_global_to_guest(vm, vcpu_shared_irq_count);
+	sync_global_to_guest(vm, targs);
 
 	run_vcpu(vcpu);
 
@@ -613,28 +621,30 @@ static void test_vm_events_overflow(void *guest_code)
 
 static void test_print_help(char *name)
 {
-	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
-	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
+	pr_info("Usage: %s [-h] [-t <test name>]\n", name);
+	pr_info("\t-t: Test to run (default all). Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
 	pr_info("\t-h: print this help screen\n");
 }
 
 static bool parse_args(int argc, char *argv[])
 {
 	int opt;
-
-	while ((opt = getopt(argc, argv, "hd:")) != -1) {
+	int temp_disabled_tests = SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVENTS | SBI_PMU_TEST_SNAPSHOT |
+				  SBI_PMU_TEST_OVERFLOW;
+	while ((opt = getopt(argc, argv, "ht:")) != -1) {
 		switch (opt) {
-		case 'd':
+		case 't':
 			if (!strncmp("basic", optarg, 5))
-				disabled_tests |= SBI_PMU_TEST_BASIC;
+				temp_disabled_tests &= ~SBI_PMU_TEST_BASIC;
 			else if (!strncmp("events", optarg, 6))
-				disabled_tests |= SBI_PMU_TEST_EVENTS;
+				temp_disabled_tests &= ~SBI_PMU_TEST_EVENTS;
 			else if (!strncmp("snapshot", optarg, 8))
-				disabled_tests |= SBI_PMU_TEST_SNAPSHOT;
+				temp_disabled_tests &= ~SBI_PMU_TEST_SNAPSHOT;
 			else if (!strncmp("overflow", optarg, 8))
-				disabled_tests |= SBI_PMU_TEST_OVERFLOW;
+				temp_disabled_tests &= ~SBI_PMU_TEST_OVERFLOW;
 			else
 				goto done;
+			targs.disabled_tests = temp_disabled_tests;
 			break;
 		case 'h':
 		default:
@@ -650,25 +660,27 @@ static bool parse_args(int argc, char *argv[])
 
 int main(int argc, char *argv[])
 {
+	targs.disabled_tests = 0;
+
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
-	if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
+	if (!(targs.disabled_tests & SBI_PMU_TEST_BASIC)) {
 		test_vm_basic_test(test_pmu_basic_sanity);
 		pr_info("SBI PMU basic test : PASS\n");
 	}
 
-	if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
+	if (!(targs.disabled_tests & SBI_PMU_TEST_EVENTS)) {
 		test_vm_events_test(test_pmu_events);
 		pr_info("SBI PMU event verification test : PASS\n");
 	}
 
-	if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
+	if (!(targs.disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
 		test_vm_events_snapshot_test(test_pmu_events_snaphost);
 		pr_info("SBI PMU event verification with snapshot test : PASS\n");
 	}
 
-	if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
+	if (!(targs.disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
 		test_vm_events_overflow(test_pmu_events_overflow);
 		pr_info("SBI PMU event verification with overflow test : PASS\n");
 	}

-- 
2.43.0


