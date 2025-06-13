Return-Path: <linux-kselftest+bounces-34941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9FAD952E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF561BC267D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA12D12F0;
	Fri, 13 Jun 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbpG9m58"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC1242D9E
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842074; cv=none; b=U9x36CVEuNqcg3JKSoRnCDKS2EtfZdJ+v2M8SooP4kb27r7KFq/2NPFVuB4AsYJATNh8g7Q4rmv5rzSoskIKXjLGUdDcAERTxMalCN9FzLQkwNY1t3aQeZuZJHooy53J23vcesNRcVDNoQbaiMka/LhTPwfEt6KnQimI79z7ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842074; c=relaxed/simple;
	bh=Avxsfm8/t8HpO7whsUccQLtn39Rse70swcdoxot3qwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IvEsfvPZHaT4C18iIFnqXyHPbTFzfLyPvew1sfCBdtJ7I3lcZznD9FXy88MidKqyGkf3IDybW4aQrd3pPsqEbQ7EAgfW9mWps9n6/jOYW50NSfpZmO/gWpNiO7km1YE45B5+GLaQEb6SbUNluOss2gWHLDViKuXCpWa72Pi+Bwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbpG9m58; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so3428914a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842071; x=1750446871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWyVXPzXj5FmoW23l8bdihrPptElHyOfK0iRRuk7KZI=;
        b=IbpG9m58GDzG07kEvfGRkR2gmK3W+y8s5WCFqMBvz2y787aH1vzyl6fnQret3tMnKE
         NKh/kKRU9bLbK1LySVe3Jn1JvyMQLlgIpNSzwEl1Kviy8pYgPJkUXIOJi0KSSktqdPn8
         8KrbqDcteYMzQ1ysnN2bLRY8+Ieg8KRhTYV9STCG32MHR0rkNQ3YndtqG1XzbgvK1ooF
         hLvHFLmuyQ7tGcasf/s62FipzJ1hq4KgjEAQy4cmrM/f/5xhSS4qjoQO0g98NcP/dqWr
         njro5TLPGPZUutXYLs1dnjtl9y92D2a7mXyxmzwZjaewb/9glRiX8MjHx/G7awRyfsTR
         42Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842071; x=1750446871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWyVXPzXj5FmoW23l8bdihrPptElHyOfK0iRRuk7KZI=;
        b=O1fYap+u3sopz6aDWIalKoEnxjJhjVuqxMQCSytGX+X+CLCSSullZEuXkgbPH8l/oj
         GgQRnxv8b+SVqQ0+kkfVhgUVVbXwNrSsmKDWYbziCo86rB4QboUD9zrxcF1Eo2SJWA+i
         2INFq57cf+CenHZPHedBELkBudzk3IA5vHP4L15rxUUJ88hyI6LZ55jJnkNXbv2sJdBy
         IgpCx52yX6G7QsNEDA7mZYDNyBb13XCo+c6oCrYTTt/LWpOsWMOy/2+UGz8HDn69Iru5
         0bxEwhkjBdhDhGVIYwxZOGOjpJ3NzrSMDXvNqe7twL+CXeTKfADCGko7vIn66QHWdleU
         MuJg==
X-Gm-Message-State: AOJu0Yya+XmjTx53r0QhY6GFDcgRfGUn59MXxfRsKpQ+Scw8/9y1mQgm
	CtygJ6aSGDzvmY3IsiofCDRdvg4b+gBil9Fh44SzVjNF2Y9dZm6z2ft4/Nyde4CiEMujKrx7pnB
	pOH+4nEXqV5VLeTeaagS6uKgL7jpZNPu/6oxUuFNjr2hLUbAJowg09gJc4sm2R6pEz6gQ2B4F87
	D91bMIs0SwQzPIFsA7d46UTnNlVyge+Y/Tr64TjoP7uQU=
X-Google-Smtp-Source: AGHT+IHX4eKa44rIL8nJJ+oGoa5OIlWorBJ8Xw4+PraBFVJeeE4W4BVlN2Ig91BK/T8HjP6pvPBrGzlt2g==
X-Received: from pjgg14.prod.google.com ([2002:a17:90b:57ce:b0:2fc:2c9c:880])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e185:b0:311:ba2e:bdc9
 with SMTP id 98e67ed59e1d1-313f1d17195mr1148975a91.27.1749842070932; Fri, 13
 Jun 2025 12:14:30 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:39 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-13-sagis@google.com>
Subject: [PATCH v7 12/30] KVM: selftests: TDX: Add basic TDX CPUID test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test reads CPUID values from inside a TD VM and compare them
to expected values.

The test targets CPUID values which are virtualized as "As Configured",
"As Configured (if Native)", "Calculated", "Fixed" and "Native"
according to the TDX spec.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/test_util.h | 15 +++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 20 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 98 ++++++++++++++++++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index cf11955d56d6..2af6e810ef78 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -9,6 +9,9 @@
 #define TDX_TEST_SUCCESS_PORT 0x30
 #define TDX_TEST_SUCCESS_SIZE 4
 
+#define TDX_TEST_REPORT_PORT 0x31
+#define TDX_TEST_REPORT_SIZE 4
+
 /* Port I/O direction */
 #define PORT_READ	0
 #define PORT_WRITE	1
@@ -77,4 +80,16 @@ void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
  */
 void tdx_assert_error(uint64_t error);
 
+/*
+ * Report a 32 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
+ */
+uint64_t tdx_test_report_to_user_space(uint32_t data);
+
+/*
+ * Read a 32 bit value from the guest in user space, sent using
+ * tdx_test_report_to_user_space().
+ */
+uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index 4ccc5298ba25..f9bde114a8bc 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -104,3 +104,23 @@ void tdx_assert_error(uint64_t error)
 	if (error)
 		tdx_test_fatal(error);
 }
+
+uint64_t tdx_test_report_to_user_space(uint32_t data)
+{
+	/* Upcast data to match tdg_vp_vmcall_instruction_io() signature */
+	uint64_t data_64 = data;
+
+	return tdg_vp_vmcall_instruction_io(TDX_TEST_REPORT_PORT,
+					    TDX_TEST_REPORT_SIZE, PORT_WRITE,
+					    &data_64);
+}
+
+uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu)
+{
+	uint32_t res;
+
+	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, 4, PORT_WRITE);
+	res = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	return res;
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 97330e28f236..bbdcca358d71 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -3,6 +3,7 @@
 #include <signal.h>
 
 #include "kvm_util.h"
+#include "processor.h"
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
@@ -146,6 +147,99 @@ void verify_td_ioexit(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies CPUID functionality by reading CPUID values in guest. The guest
+ * will then send the values to userspace using an IO write to be checked
+ * against the expected values.
+ */
+void guest_code_cpuid(void)
+{
+	uint32_t ebx, ecx;
+	uint64_t err;
+
+	/* Read CPUID leaf 0x1 */
+	asm volatile ("cpuid"
+		      : "=b" (ebx), "=c" (ecx)
+		      : "a" (0x1)
+		      : "edx");
+
+	err = tdx_test_report_to_user_space(ebx);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_to_user_space(ecx);
+	tdx_assert_error(err);
+
+	tdx_test_success();
+}
+
+void verify_td_cpuid(void)
+{
+	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
+	const struct kvm_cpuid_entry2 *cpuid_entry;
+	uint32_t guest_clflush_line_size;
+	uint32_t guest_initial_apic_id;
+	uint32_t guest_sse3_enabled;
+	uint32_t guest_fma_enabled;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint32_t ebx, ecx;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid);
+	td_finalize(vm);
+
+	printf("Verifying TD CPUID:\n");
+
+	/* Wait for guest to report ebx value */
+	tdx_run(vcpu);
+	ebx = tdx_test_read_report_from_guest(vcpu);
+
+	/* Wait for guest to report either ecx value or error */
+	tdx_run(vcpu);
+	ecx = tdx_test_read_report_from_guest(vcpu);
+
+	/* Wait for guest to complete execution */
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	/* Verify the CPUID values received from the guest. */
+	printf("\t ... Verifying CPUID values from guest\n");
+
+	/* Get KVM CPUIDs for reference */
+	cpuid_entry = vcpu_get_cpuid_entry(vcpu, 1);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+
+	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
+
+	guest_sse3_enabled = ecx & 0x1;  // Native
+	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
+	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
+	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
+	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
+
+	TEST_ASSERT_EQ(guest_sse3_enabled, 1);
+	TEST_ASSERT_EQ(guest_clflush_line_size, 8);
+	TEST_ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
+
+	/* TODO: This only tests the native value. To properly test
+	 * "As Configured (if Native)" this value needs override in the
+	 * TD params.
+	 */
+	TEST_ASSERT_EQ(guest_fma_enabled, (cpuid_entry->ecx >> 12) & 0x1);
+
+	/* TODO: guest_initial_apic_id is calculated based on the number of
+	 * vCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
+	 * and allocated sequentially on each successful TDH.VP.INIT"
+	 * To test non-trivial values either use a TD with multiple vCPUs
+	 * or pick a different calculated value.
+	 */
+	TEST_ASSERT_EQ(guest_initial_apic_id, 0);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -153,13 +247,15 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
 			 "verify_report_fatal_error\n");
 	ksft_test_result(!run_in_new_process(&verify_td_ioexit),
 			 "verify_td_ioexit\n");
+	ksft_test_result(!run_in_new_process(&verify_td_cpuid),
+			 "verify_td_cpuid\n");
 
 	ksft_finished();
 	return 0;
-- 
2.50.0.rc2.692.g299adb8693-goog


