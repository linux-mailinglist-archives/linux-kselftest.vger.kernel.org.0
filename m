Return-Path: <linux-kselftest+bounces-27655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A88A46C5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC0D16D944
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1525A349;
	Wed, 26 Feb 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PMEK6OfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5D256C62
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601515; cv=none; b=BK6nt3kdZP4uFDpfu9PHugqHV/XHq5OVkQYEfWxOMBpERl2+JhsHvcaW7BEkIwygxEWgHj9iZDRxaGCVBuYitmR6pF6/TlnOzfgKo2PIZdka+QvWmESOEiPVa10OtCse2gIrVAQOCJVFMN/8jeQO5o0Ii7TpMDHNOL2TZzBwPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601515; c=relaxed/simple;
	bh=9XSeIVk0INKB27lpWUTKEMf0kFLfVrH++iNpjyRvsG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgdtyuVNFuBAXur/jNDp/ucPfBVwX7msbXeI58N7AdKvYkqN8eyQVemsTPFsVh2f7XtPVuyAaj6i/hkZtGetRxQY7kG+P4iz7cb00DCKRj3ou1GSnI8ZW1/Kfu+UOjn8GL5Z1Ou1HFSxoSdglzojwgbOBID7VhDq8QOH7tqqDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PMEK6OfK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22328dca22fso2348115ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740601513; x=1741206313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUL9vPYfIsBYwLRgV8qB6RCZqGNjsrfsVU1Ka6aFYBY=;
        b=PMEK6OfKiv7r5lLXvZ4FIM4i3tlZZZicCAz+1V3T6kbjOGfImsREskI3N8d7UBipzw
         JAf61SmxKwGSHRnEwgH/0cREdBgd0DfYrNTRB09as7G8AXpl0PGzQ7kJPmfSPZFMLWZH
         R40VxRTdUyEM2q3FghqX4NCCwS0qF3SMuT/9rPU6ZYYAwMFiub32a7LIKMN1fWT/MTSS
         6GE/v7Hl+JN1BjPRFJtomZAt88q9Cwio8PQiOnTm/5cEAwwxkW1NjlocQAeyEEZA5NcR
         4ZrK8PyBUKk7YUtR0rzAiHB/MgFFEx0b5nlLqpEALk3PnGF1aS5EQ1Z425dPqge8TSzc
         9AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601513; x=1741206313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUL9vPYfIsBYwLRgV8qB6RCZqGNjsrfsVU1Ka6aFYBY=;
        b=mxs9HjtFpHZ4M0G3ik59CM7r+3GXPnq+vNUU04nopoiE7QaQ+xCV3VIPPzqMJUxh/7
         ZBMBtoqwhk6gmwbS5Hdtgctwq6CeQw0HcI79HlYUC9cAaBIrsE8hAptugo0d4ZLa6bMU
         doOrzUwamf8R4P718sdCB+v+k3E9zDB5v+ybS7LfowqO4ytQWsx0p8rt4qa3nNN2AyPW
         RbPuRLCdcEj11TOdq1papYbDSGEOTIZilkUQnkgYZ+dEY1zPmsmx2AWkp/zI+oVSEHog
         hvxINPdPDqRtujZpi0kqGS+2oZqtPQEujk0PjLVWAJpcLGKbtHJ3kvnrhp12oTXWnq1e
         M9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXMqnkIZkSjBw9vtqYDeSFqyKnhTqcwDoI8PUuzeuCtpqyD7MCPrPfrF2UqUwPtxACZR0AYcaUW/2qJGEkV3Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCniv+0Vc1dYLPXTJnfYg5jQhvpD615KlfTEOspMIYwXvr+3oV
	vtjX71Jq4g2ADPJXstj0T2JjPee8pS1z8cUfBgvK7b9zaA3oObOashnsh/4UCyc=
X-Gm-Gg: ASbGncv35eRMHm9k7jU4+jZaa+vwEngph3fBdFQn/iAVkSRqg4uL+sTlmF/OcE0fBB2
	yqkLO1pkf7hjaGNRZOhg3LhlKmX9pYfTn93yHymPZDd/WpmQS7gBC1KWoI9LmZo29RMN7hKrBFh
	o/6MHJC7ENDbDbz2AMfcYCdg20izuFj9sAOk6IQCq/2LIiTCWVByl5lO0lz9tE1Kf+STq8y2yaj
	BhjzOp0jdGWe+dVCmiwDd1riV+ClO6lxrJI7aVah/6WUK82btCD2UmD0+Shkkl5sMA962euCsFf
	Tiyc6cCihjzTJCpEGssfCGIRwcyNgPsr4PizGds=
X-Google-Smtp-Source: AGHT+IHVxqxBZKHrXRbMLQx94rePhcj/KMG3dvOa85IKXsVDVZmW7p4O5rV92MpOYiz4YyuBZBfk6Q==
X-Received: by 2002:a05:6a00:1828:b0:732:5b10:572b with SMTP id d2e1a72fcca58-734790cbaf5mr13305359b3a.10.1740601513545;
        Wed, 26 Feb 2025 12:25:13 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm4100963b3a.106.2025.02.26.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:25:13 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 12:25:05 -0800
Subject: [PATCH 3/4] KVM: riscv: selftests: Change command line option
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-kvm_pmu_improve-v1-3-74c058c2bf6d@rivosinc.com>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
In-Reply-To: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The PMU test commandline option takes an argument to disable a
certain test. The initial assumption behind this was a common use case
is just to run all the test most of the time. However, running a single
test seems more useful instead. Especially, the overflow test has been
helpful to validate PMU virtualizaiton interrupt changes.

Switching the command line option to run a single test instead
of disabling a single test also allows to provide additional
test specific arguments to the test. The default without any options
remains unchanged which continues to run all the tests.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 40 +++++++++++++++---------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index 284bc80193bd..533b76d0de82 100644
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
+	while ((opt = getopt(argc, argv, "h:t:n:")) != -1) {
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


