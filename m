Return-Path: <linux-kselftest+bounces-30775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9564A88E4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEE01896E4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461F214A7A;
	Mon, 14 Apr 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08r7WgUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4520E003
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667337; cv=none; b=BGHD6vSZvdlHZarx4oZ/9M3waCp4oDQgdMdO3Vb2doCl7ZidyUJ9+DrM+VWGT+kB7sn+EtsGZJmYEJ4IQiiUsuBDmCTcSsj3sweoCuUtSLK4LI3SBLmBj6yCWeVXpZ9eB40NrQwI5j5h2VS57vfrmqGjul9XpDHTwqFm3RIDCbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667337; c=relaxed/simple;
	bh=/zOeabVaWmj3ZBy6cagVDkNfmaleWBzKPvbdEK8hbR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVrCTq74jl/0Pxu1IzkasvGBV/lrv2NjocJePZ7w+7Je1t09W697lQ2mqTnwNWDa6e2LZYZU+ddYsGKPx3Xvk2r/LtJDaMyfXCyjjY4p9hDIA4cl87teDwECz7gt3qpW6xyczCzBZ7eFgm6on7XwnhpIHGcZemhYIETa3TXJyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08r7WgUO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c1ea954fso2482929b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667335; x=1745272135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvxzosC3E+lxZEmxfjvYTYgKzTvlQJfvRPb3j1x3DvU=;
        b=08r7WgUOrxRIfUxUKY8nyD7zr4nsGd/e5U/oQ19rRbNESB3wvf7JpkCjq39RNYf+6t
         2Q37dD6OkQ397+iyGYgZjIq2XtiTo0MRlcfw+1v/Lcl2O0u1W0b9HxAXxesh1M+a7Mys
         mOvsCTTwKyFsV/w6tzAqe+RsCasd1DKT45nPDOcX8q6NryNThv5d9TxU3evblLtrMjjN
         WXNW7vJ+QiBfqLwxbi2ket/5mufUdHxDYjg6jtqPFE98uOXdbpmfQ6xSkOdW0e1WUNiu
         GNQbkNnkXek37CNJlCmBcwmQuzjuy2CluP4XYVLJ8aeVY8QBDd+VLfNJbrEcyB4H/1KY
         6CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667335; x=1745272135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvxzosC3E+lxZEmxfjvYTYgKzTvlQJfvRPb3j1x3DvU=;
        b=GsHelZVcKWiba9D2dcIYesZ5tLb6tpoESMzDS+afdBA5A944/vG/+ps9VsD6ZDTwx7
         21mTgyrlYVlYrSfVhFbnSbkrb2TUbaOL5N2fUvUZxoFMa0I/2bbTJdLZVljpt6MNAoNY
         XD41kyVjD8n6lt1O/bST0nTyy/K+FKCcTqljsWYBCRzlS5pMI0meF15znt8IildC2LXI
         EuVLMBvMdn5bjbz68IvjK0OMFU8AEWbZc2hqYRxdf8s45N0AnNCxuKB47Cm+F//ukrqF
         ju8P+nqhY/I7HmnqM23khQOz5jfjmPhYcgXxfXF3AXkBuchD0tXeWAXZvp7OiUm+lEUT
         /4xA==
X-Gm-Message-State: AOJu0YysDxsl+vv8CYvI39mCvzVWc6ciFePLoDPJBwT0sr+ib+kdig0f
	JEXPgQqBaG8vNEQsnKSacgxxBRR/Kqybmwu6eM1Cu+PjB773Fe4tm/kvhBmet0PgrBwQYLk7d23
	8ZMt1vk7Z+TBUudkZRuuPpYYAfygl7e7KFNsQ1fykc56rDRMIVdZhlUXEL7icaDiQUMSJK+fB84
	5LUFQDveA2ryThwcoy/bElHUpGaDWkic3A7WRdZXA=
X-Google-Smtp-Source: AGHT+IFS7Kr8bx+0klE1FP3hZnDFtbssejplTY6nzf5tgCxpJkRtMlcE6Nh8yK0e8eHxLyE5mrhr6eXvCQ==
X-Received: from pfbgm11.prod.google.com ([2002:a05:6a00:640b:b0:736:38af:afeb])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1486:b0:736:5e28:cfba
 with SMTP id d2e1a72fcca58-73bd126b973mr17147271b3a.18.1744667334573; Mon, 14
 Apr 2025 14:48:54 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:40 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-12-sagis@google.com>
Subject: [PATCH v6 11/30] KVM: selftests: TDX: Adding test case for TDX port IO
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
2.49.0.504.g3bcea36a83-goog


