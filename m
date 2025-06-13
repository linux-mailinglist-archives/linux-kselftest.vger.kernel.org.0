Return-Path: <linux-kselftest+bounces-34940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7BAD952B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674863AD5B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA472C08CD;
	Fri, 13 Jun 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZ9DKfe2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB012BF077
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842072; cv=none; b=X3/P9ZcX+l2R2PggZcE40Y3aFTjLkUvkrwC1ji546ua0k1HPTl3tvhtR0YuRfKm41TWSzw+frvjH+5fdYmD5EI5HFqXmeCIdPNFelcc3RjVdJ5Q9jzdZZ03qVu5k7wZQowHjQ/HgF0orxJA4i17/aZ766LqtUQWDulAO8bdlJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842072; c=relaxed/simple;
	bh=uqIxOmX3BYXbbCv1CMHqHbbyU277l6eBkNwagdau+oY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LM92Gi9nCyWyEiYEYEjL3W7Ft0htBJjnysrYAui++wUBXZvV01RCCSctaBqTA8FVjqfZ5ImI37mAvKjpmq1sbu4dkoyP2pA02YWiiKVV3lFFc0lVTTdBZ9uUBlES3077BtXw+cKy3zEfrhG2yYJp92+zY0YPCWAk+Ixu60ymuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZ9DKfe2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7489ac848f3so422192b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842069; x=1750446869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/svNuuxjLlsSpnXIsQtll5AlQK2Oa/4goaN4sSAXj0=;
        b=uZ9DKfe2jk/5QcYfSeiGO/YcrkPJfSHJXc8I2ZqyYvpKaWdIWbq1cbQpO3C7P5lFoe
         YbE8BHtpRlRU1KOx8xAHXKVh61gaMckS9KqUE87V0Xzf8s6HzI2tnP9M/g47RKBi7rc2
         hMLRIraYsHd6DqGIRzI0rCqxjTc1L6Sue9WLkKG06cdfx5QUaLdfqeFQsJtpgv6RCE7A
         iHKgairVLxDJExdiLARgkexbIwt/iTmOeTpH9iPO8Fbx7P1NTNkweQo8ajqTPDasw+Dm
         wPi54FVFkS1lat1ksCNu4wrU/6Kicc8S+/OI89Ku/TM1THYW/pIU36GJ2ZrMemkYBQoa
         P0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842069; x=1750446869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/svNuuxjLlsSpnXIsQtll5AlQK2Oa/4goaN4sSAXj0=;
        b=t0uqqntIiiTKWMEBajtE9pwTZR647AOFX+zF50Asbn3EakdXESUHCsugPcy9r89OX5
         iO8VauNzJutPJhsLOfZeYB3s20SP0A/9/HDiOJeMqrWGFKqwqVR1ESnYjHQG0JUc3a86
         fC/18+C/emxl90npZTiN5cKLGdD5dDnvaKAPbkr6jHPJQauddWDkk5F0VxP+50RnFVoJ
         SpnLJIdmFDbfeXW3uxUy6FHq5k5UMsGPd+euX/9vXlrVtmMgH7TrBLgRBsJnGDXNny2V
         +TZKIbBkWMI7n6WtokcgSMm3de5+0sLb0WC/t/rqoep+wT7dYi/RYNoWhSQle+8w7if8
         TIcA==
X-Gm-Message-State: AOJu0YxV4FkHfoMB//yZ6CVVu2d+La51dCY/RgQTMCYXE3KBV1xDbUSc
	MmnG8HVzkNSrW0x6maNoGVZNvCcaMsq/tCVSEqLFpaZngmJJMYjKYWso6m0Aw3UOn1tp/3sEX9K
	Uyo1Yb7jKlRiZiA80jS3eKjUgaxfqrXwsYxMTe8jebwUT2EW6kLPcyi+TgpZVQT9ytZyqXXl/8d
	T5/4zS5+eTTvl9oC8XG14XQR7dWkOS2fF8zTLTCfAdm6c=
X-Google-Smtp-Source: AGHT+IFsYD1YyKIZHNpOeAVzaehTtViz3NuufMHX1K/2IHUCVmKQpLnEvTjx4pMeMGAWKjwf/SjSKMjEtA==
X-Received: from pfuv8.prod.google.com ([2002:a05:6a00:1488:b0:747:b76c:ab92])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a19:b0:746:2ae9:fc3d
 with SMTP id d2e1a72fcca58-7489cffb6bbmr654798b3a.23.1749842069428; Fri, 13
 Jun 2025 12:14:29 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:38 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-12-sagis@google.com>
Subject: [PATCH v7 11/30] KVM: selftests: TDX: Adding test case for TDX port IO
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
2.50.0.rc2.692.g299adb8693-goog


