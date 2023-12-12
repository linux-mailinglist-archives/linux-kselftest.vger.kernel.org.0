Return-Path: <linux-kselftest+bounces-1733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5ED80F831
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC01C209F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCA64136;
	Tue, 12 Dec 2023 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pluHwKNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2BE13A
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:17 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d0b944650bso29197775ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414037; x=1703018837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMXRsZ7PnaagoSZjHTHBbcv9aekrkY1R/86PgELFK84=;
        b=pluHwKNB6MxxMVJt/Iq1wFuOTqKLxcyeUr3c4v/cnbt3nzcO4VdUJVq7I/BMA0POkr
         W4K+A5vSEMtuyRdb76bk3BzPWSQ3WAARGPovGpOGDh5RIQlcmz81jj3g16LXC/LDszzH
         x5VUG10WcKZlzCAtHCYjfZYmqZbRlVFEX+uIGgkH0ollDjoVJOzQ841Wnxqlj1j5Z4n6
         x5+wLKfqSFmgEfjiHiMzSZ6cOUa25HEuIZ/F6AX7S5YB2XBadMiZbzBkEVOyfjjkRxzz
         LaEHce5C0pSyTPhLXB3qL2HNEZmIfoFRQEusACt7WvTgCW+I2Syq7jFfEcF6xNMK8YiN
         9GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414037; x=1703018837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMXRsZ7PnaagoSZjHTHBbcv9aekrkY1R/86PgELFK84=;
        b=vt1h7o1WWsboNgaGJ79QsBBZMP75HOHMdUHSZUOnRC736i54NDoMzhCMURkl7KwEPd
         7+O6AGz56JTWOQ4pc842/OOJDlTL+tmtVbbP4/SWp+gTq5F+XVHLPj+eQGbaMcGBitM9
         5IqStAC2p54tmjAQN8ZnKed1wdL1/z2hacRprfuC12oNx1a5WfV0n3gfefRwWhuHCRwv
         N7zbcLrjOptOqURnwSIdY9rXlGfyaw3HeMxrVMVVwo8UBVVWzYKXExr9rlFhMj6yttxk
         A8fD12xNMqAjY3waII6cEMU8BESk6kAj9Xad+7UXFVqL/TnGXojA0z9TVZUeu9xUNSo2
         nW/Q==
X-Gm-Message-State: AOJu0YyY8XL5HG+jM+qFqcRLnT2ShIOD0ifv7J9mf6KnHBhZJZ4Gj+K1
	jeZZi9D8uFELrapzxvw1rtEb3+7qF8QM8w8/5kPBFUH5gQ2GU/EZuVQPUfiZSbeMxkwGpRj69j5
	Pf128gUV3pob9TJKZ5eY/o7RFlcdUEPswTaqDBJ+kfZKhKClqgnUKGD+uNgKqdzcLRYQ1tz8=
X-Google-Smtp-Source: AGHT+IHRkwh7i3P/QAayIGr2a6aSSDzf6EOuyWh3BnBScYojp+3pztVUIS4d/fPqpVG0Y7OF2YfMIgAv0Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:b712:b0:1d3:46f4:7f1e with SMTP id
 d18-20020a170902b71200b001d346f47f1emr4985pls.1.1702414035248; Tue, 12 Dec
 2023 12:47:15 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:25 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-11-sagis@google.com>
Subject: [RFC PATCH v5 10/29] KVM: selftests: TDX: Adding test case for TDX
 port IO
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 6d69921136bd..95a5d5be7f0b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -9,6 +9,40 @@
 #define TDX_TEST_SUCCESS_PORT 0x30
 #define TDX_TEST_SUCCESS_SIZE 4
 
+/**
+ * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
+ * called in the guest.
+ */
+#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
+	do {								\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
+			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason));	\
+									\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
+			((VCPU)->run->io.port == (PORT)) &&		\
+			((VCPU)->run->io.size == (SIZE)) &&		\
+			((VCPU)->run->io.direction == (DIR)),		\
+			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason),	\
+			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
+			(VCPU)->run->io.direction);			\
+	} while (0)
+
+/**
+ * Check and report if there was some failure in the guest, either an exception
+ * like a triple fault, or if a tdx_test_fatal() was hit.
+ */
+#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
+	do {								\
+		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
+			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
+				(VCPU)->run->system_event.data[1],	\
+				(VCPU)->run->system_event.data[1]);	\
+	} while (0)
+
 /**
  * Assert that tdx_test_success() was called in the guest.
  */
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 8638c7bbedaa..75467c407ca7 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
@@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IOEXIT_TEST_PORT 0x50
+
+/*
+ * Verifies IO functionality by writing a |value| to a predefined port.
+ * Verifies that the read value is |value| + 1 from the same port.
+ * If all the tests are passed then write a value to port TDX_TEST_PORT
+ */
+void guest_ioexit(void)
+{
+	uint64_t data_out, data_in, delta;
+	uint64_t ret;
+
+	data_out = 0xAB;
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&data_out);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data_in);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	delta = data_in - data_out;
+	if (delta != 1)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_td_ioexit(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t port_data;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
+	td_finalize(vm);
+
+	printf("Verifying TD IO Exit:\n");
+
+	/* Wait for guest to do a IO write */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	printf("\t ... IO WRITE: OK\n");
+
+	/*
+	 * Wait for the guest to do a IO read. Provide the previous written data
+	 * + 1 back to the guest
+	 */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
+
+	printf("\t ... IO READ: OK\n");
+
+	/*
+	 * Wait for the guest to complete execution successfully. The read
+	 * value is checked within the guest.
+	 */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	printf("\t ... IO verify read/write values: OK\n");
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -85,6 +166,7 @@ int main(int argc, char **argv)
 
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
+	run_in_new_process(&verify_td_ioexit);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


