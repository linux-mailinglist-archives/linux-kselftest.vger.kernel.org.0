Return-Path: <linux-kselftest+bounces-38506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2BB1DDF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B9A5864DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488127602F;
	Thu,  7 Aug 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktw5nj8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88E275AFF
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597817; cv=none; b=m7Bo2FoNCIcIUldHbsqq4kj7wqIv2eguuuGaHJcDGlthDXHI/1CT5CmNiEet3ERl/6wQQmDDK0zD95Bbi1k0FNuyoRcmZqgn4GyWbFn7pJLDIkvGk2oBGD0wcXFFy7cDzbzoNvGEQNRro+jbF5hh875uDdMPjGU5GBoh3OZ5EZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597817; c=relaxed/simple;
	bh=8/991SaqhfbOuXxYGVBkbjKMlNrrAbPc+jQ8DkNet6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hyO0wCxlr745WlbRHx+oDpnJZeBRZJRCR3bMa5mx4REWjaskY/w6p8tff5iCCCS7oWFZfSaQ90s8qiN7CQxGaeP0hSIpSsY/8W+6r/13sj7Bu/7kRnMZfqpe11Cf+8ZoiFClq+MBL4xWbAahCymFMnNYkchqx96J5zcb7XHnxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktw5nj8h; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bf3e05024so1400642b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597815; x=1755202615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qod859ACwAJ9KJXJ66Pu3+9/i9Fm4EF7ZGslehKFgPA=;
        b=ktw5nj8hoBYBZya6tgjKW1e0edgY0Gyc4rjJmkPbKOJaXe16ikMFwbfC3zw7xxMgDe
         SAH9GcOYDGpLrmFS+X8UdaR2lJwRR4v+F1+ZqZYHx+mo2oaQs4q3nrXzRQmHrTeFDeJQ
         Yd6RJ2zMcetkFhH3hI2/ots2HHTDqJR3My27eVB8pzlrboIH8AWujf/iRwQHIldV/KyT
         5RcGiWL3lMRo4YuLqX/YLJI9UdM6mvc3PsgV9uGccM4l1On9bpXawLx4GBeUEwSxwzdp
         hjKRBWxSGdOLtnp8Y/oVp2xGfRVv4sz36oYLFCEHaobnojnc7dcJgbYtpfpehf1JSkIT
         Xxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597815; x=1755202615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qod859ACwAJ9KJXJ66Pu3+9/i9Fm4EF7ZGslehKFgPA=;
        b=JFwo0Jz+h/dXcQlwgOPWPuOLVsVI0fUgbPdE+vLIgTn/EWUj46C6LIai3QTAhDgbHG
         vzN9KeLn19pC26UjczpTRvV/NnOhcxIbpygLtH3FDECmWUJeuVqszfyEEskYj/j4kVhH
         awiMJZVIwew6+h3wZ1PJ3V6etZ3TS8ZOtysrbT5SFfWzTbU0uNX6wPkVDVE2zR9NRRSK
         BaqkEQtfz5WKYf3q92UdCXo52OTB6c1Pked0PPPXtzft05aDbxzwtUPSuHbidroCYxVQ
         YZABmlN/sA3PWM75vQdRuLCjxtSwPxa+JHa/9kx4GfoMvSCWbQ9yavQP+ZkTNIFYp+EK
         JGJA==
X-Gm-Message-State: AOJu0YyCZyL7NUpQiN8ntKXSJsiqsuS1NKMa+bTMpEc7x7CCfWsyyeEg
	CFbMXYB/AEIf+CnCUvl7GOS5ydbXb1B81IDjjfJT5O7oxxW9xGf3zYXdD6GqyvbRfrF+7fthxj0
	Gg8UzjOZlSx0Z5mMnk68jGJRF3ejnAKchwWUxsc6mIakiBEhh/i/BwzHij1BtKCoUR5VSwgv/Zj
	mfRWnXvBSpM6yyzO1ZeXydw0V5VUTRiW8wv//+UvmlV6A=
X-Google-Smtp-Source: AGHT+IElhGKAW5wN//qmv94pEi0jFcwaYTH9QkghkSjAapFDDJMVQZjNYUu6DUB+rXi8WiqKmyIVXaKSpQ==
X-Received: from pftb22.prod.google.com ([2002:a05:6a00:2d6:b0:76b:fe87:6051])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1389:b0:736:54c9:df2c
 with SMTP id d2e1a72fcca58-76c46111288mr619107b3a.15.1754597814594; Thu, 07
 Aug 2025 13:16:54 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:07 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-12-sagis@google.com>
Subject: [PATCH v8 11/30] KVM: selftests: TDX: Adding test case for TDX port IO
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/test_util.h | 20 +++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 35 +++++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 78 ++++++++++++++++++-
 3 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index dafeee9af1dc..cf11955d56d6 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -13,6 +13,19 @@
 #define PORT_READ	0
 #define PORT_WRITE	1
 
+/*
+ * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
+ * called in the guest.
+ */
+void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
+			uint8_t direction);
+
+/*
+ * Run the tdx vcpu and check if there was some failure in the guest, either
+ * an exception like a triple fault, or if a tdx_test_fatal() was hit.
+ */
+void tdx_run(struct kvm_vcpu *vcpu);
+
 /*
  * Run a test in a new process.
  *
@@ -57,4 +70,11 @@ void tdx_test_fatal(uint64_t error_code);
  */
 void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
 
+/*
+ * Assert on @error and report the @error to userspace.
+ * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since execution
+ * is not expected to continue beyond this point.
+ */
+void tdx_assert_error(uint64_t error);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index 6c82a0c3bd37..4ccc5298ba25 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -8,8 +8,37 @@
 
 #include "kvm_util.h"
 #include "tdx/tdx.h"
+#include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 
+void tdx_test_assert_io(struct kvm_vcpu *vcpu, uint16_t port, uint8_t size,
+			uint8_t direction)
+{
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
+		    "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
+		    vcpu->run->exit_reason,
+		    exit_reason_str(vcpu->run->exit_reason));
+
+	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO &&
+		    vcpu->run->io.port == port &&
+		    vcpu->run->io.size == size &&
+		    vcpu->run->io.direction == direction,
+		    "Got unexpected IO exit values: %u (%s) %u %u %u\n",
+		    vcpu->run->exit_reason,
+		    exit_reason_str(vcpu->run->exit_reason),
+		    vcpu->run->io.port, vcpu->run->io.size,
+		    vcpu->run->io.direction);
+}
+
+void tdx_run(struct kvm_vcpu *vcpu)
+{
+	td_vcpu_run(vcpu);
+	if (vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)
+		TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n",
+			  vcpu->run->system_event.data[12],
+			  vcpu->run->system_event.data[13]);
+}
+
 int run_in_new_process(void (*func)(void))
 {
 	int wstatus;
@@ -69,3 +98,9 @@ void tdx_test_fatal(uint64_t error_code)
 {
 	tdx_test_fatal_with_data(error_code, 0);
 }
+
+void tdx_assert_error(uint64_t error)
+{
+	if (error)
+		tdx_test_fatal(error);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 7d6d71602761..97330e28f236 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -3,6 +3,7 @@
 #include <signal.h>
 
 #include "kvm_util.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
@@ -25,7 +26,7 @@ static void verify_td_lifecycle(void)
 
 	printf("Verifying TD lifecycle:\n");
 
-	td_vcpu_run(vcpu);
+	tdx_run(vcpu);
 	tdx_test_assert_success(vcpu);
 
 	kvm_vm_free(vm);
@@ -69,9 +70,78 @@ void verify_report_fatal_error(void)
 	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], 0x0BAAAAAD00000000);
 	TEST_ASSERT_EQ(vcpu->run->system_event.data[13], 0);
 
-	td_vcpu_run(vcpu);
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+#define TDX_IOEXIT_TEST_PORT 0x50
+
+/*
+ * Verifies IO functionality by writing a |value| to a predefined port.
+ * Verifies that the read value is |value| + 1 from the same port.
+ * If all the tests are passed then write a value to port TDX_TEST_PORT
+ */
+void guest_ioexit(void)
+{
+	uint64_t data_out, data_in;
+	uint64_t ret;
+
+	data_out = 0xAB;
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					   PORT_WRITE, &data_out);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					   PORT_READ, &data_in);
+	tdx_assert_error(ret);
+
+	if (data_in != 0xAC)
+		tdx_test_fatal(data_in);
+
+	tdx_test_success();
+}
+
+void verify_td_ioexit(void)
+{
+	struct kvm_vcpu *vcpu;
+	uint32_t port_data;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
+	td_finalize(vm);
+
+	printf("Verifying TD IO Exit:\n");
+
+	/* Wait for guest to do a IO write */
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IOEXIT_TEST_PORT, 1, PORT_WRITE);
+	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	printf("\t ... IO WRITE: DONE\n");
+
+	/*
+	 * Wait for the guest to do a IO read. Provide the previous written data
+	 * + 1 back to the guest
+	 */
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IOEXIT_TEST_PORT, 1, PORT_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
+
+	printf("\t ... IO READ: DONE\n");
+
+	/*
+	 * Wait for the guest to complete execution successfully. The read
+	 * value is checked within the guest.
+	 */
+	tdx_run(vcpu);
 	tdx_test_assert_success(vcpu);
 
+	printf("\t ... IO verify read/write values: OK\n");
 	kvm_vm_free(vm);
 	printf("\t ... PASSED\n");
 }
@@ -83,11 +153,13 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(2);
+	ksft_set_plan(3);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
 			 "verify_report_fatal_error\n");
+	ksft_test_result(!run_in_new_process(&verify_td_ioexit),
+			 "verify_td_ioexit\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


