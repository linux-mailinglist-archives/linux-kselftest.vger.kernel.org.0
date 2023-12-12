Return-Path: <linux-kselftest+bounces-1740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C380F842
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135A1C20DBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30816412D;
	Tue, 12 Dec 2023 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vbl2IYqN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4398E9
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e16d7537bcso23101077b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414050; x=1703018850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4egsLMzPG6RqT1HiF2arhOZ1FLT3WKNE+n1ktHUZWdA=;
        b=Vbl2IYqN1MkG2HBPLQMW/9AKGtyl7M0Zio6vfnqMpTnPrTLjzSDuAWNN9b2wDjIlGL
         24XeJnN4a5Ye6tWFeWHgpA3bqeojhVMNYf/8aPB1BSXX3lRDMQVYSboNys0PvEQNFH2s
         61ugIktVhEPu8ES1uLHGrWz1OtvQuy2+Abqls22Yackv+IQe0v4fJy4ZELH2VhrNBSaS
         c6wmoizWvc2LSpVbRHB7pbg4ozS7mtCLPBfLK84+BoBfJr5XydcDeb2+7rdPa4un0YEf
         ScnZwxTE4HLJb/AKY9+TkEFQUhFhzkwv2krEOevjrFa+XozyWDUqhouW/cDuBKnTmgER
         DU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414050; x=1703018850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4egsLMzPG6RqT1HiF2arhOZ1FLT3WKNE+n1ktHUZWdA=;
        b=AxPdO+vyMVrrCqgnGnL0Y7fb36hIvISdiRHDiWgDop3k9Iu9lbKdYP0MdtErEXEhYG
         jGrJ3HSihheVzv5jLqbL/xrcFs60TtXeQY70M0pYGZzFmUHYyP4/+IKdRngq1Ko6UchM
         bbvi5p1RjF77eQJqPwSqA8IofUkWtCEfXGJNQrbtCLU1Hc3AkLMqXOZn8Hr9cyAPpRyt
         45CSCxTt9cVcrEScSSx5GnTeSiXqCJ/0WVHKxvytDd8D0NY1M+S6eTRXH+eioRExsdzA
         T3uZtC5EqgPkqVTx66E03WRnrdz1Ss91QoHLrLILwQlGPr1fXfuVpzfmGj+5JyC09nYN
         Zm1g==
X-Gm-Message-State: AOJu0YyR2/hhcQ9bIM6zD+JO7mwabnWdmlSQuoj9IRuMlaZu7jBT9fsA
	W+Jgp8YdpeFtE4pPWLepP+LqqlH4SSl5fxVUq4fs8tg5iwCQrOxfapi/vcefJr3FdEFHi8oz6I5
	7GD3EGSseRLwH35scI3eXMwjpcbh2smjMBd/Gy5t8r5imOnqIclwo4tb4H8CZ2LizaF+sGWk=
X-Google-Smtp-Source: AGHT+IEgSqjVHuiiVhdZc1iYV7vk5vqbcM2p752JGuC/23gRP3Ry7yqtntV2qKviMwrvaZ+PKfnTQNi2Lg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6902:185:b0:dbc:c7f0:7c2e with SMTP id
 t5-20020a056902018500b00dbcc7f07c2emr6240ybh.2.1702414049815; Tue, 12 Dec
 2023 12:47:29 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:32 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-18-sagis@google.com>
Subject: [RFC PATCH v5 17/29] KVM: selftests: TDX: Add TDX MMIO reads test
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

The test verifies MMIO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  2 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
 .../kvm/include/x86_64/tdx/test_util.h        | 23 +++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index b5e94b7c48fa..95fcdbd8404e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -9,6 +9,8 @@
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
 #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO_READ 0
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE 1
 
 #define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
 #define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b18e39d20498..13ce60df5684 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -12,6 +12,7 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
 void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
@@ -22,5 +23,7 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 8a9b6a1bec3e..af412b764604 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -35,6 +35,29 @@
 			(VCPU)->run->io.direction);			\
 	} while (0)
 
+
+/**
+ * Assert that some MMIO operation involving TDG.VP.VMCALL <#VERequestMMIO> was
+ * called in the guest.
+ */
+#define TDX_TEST_ASSERT_MMIO(VCPU, ADDR, SIZE, DIR)			\
+	do {								\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_MMIO,	\
+			"Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason));	\
+									\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_MMIO) && \
+			((VCPU)->run->mmio.phys_addr == (ADDR)) &&	\
+			((VCPU)->run->mmio.len == (SIZE)) &&		\
+			((VCPU)->run->mmio.is_write == (DIR)),		\
+			"Got an unexpected MMIO exit values: %u (%s) %llu %d %d\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason),	\
+			(VCPU)->run->mmio.phys_addr, (VCPU)->run->mmio.len, \
+			(VCPU)->run->mmio.is_write);			\
+	} while (0)
+
 /**
  * Check and report if there was some failure in the guest, either an exception
  * like a triple fault, or if a tdx_test_fatal() was hit.
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 9485bafedc38..b19f07ebc0e7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -124,3 +124,22 @@ uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					uint64_t *data_out)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_READ,
+		.r14 = address,
+	};
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 5fae4c6e5f95..48902b69d13e 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -799,6 +799,92 @@ void verify_guest_hlt(void)
 	_verify_guest_hlt(0);
 }
 
+/* Pick any address that was not mapped into the guest to test MMIO */
+#define TDX_MMIO_TEST_ADDR 0x200000000
+
+void guest_mmio_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 1, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x12)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 2, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x1234)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 4, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x12345678)
+		tdx_test_fatal(4);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 8, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x1234567890ABCDEF)
+		tdx_test_fatal(8);
+
+	// Read an invalid number of bytes.
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 10, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Varifies guest MMIO reads.
+ */
+void verify_mmio_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_reads);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO reads:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint8_t *)vcpu->run->mmio.data = 0x12;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -818,6 +904,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
+	run_in_new_process(&verify_mmio_reads);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


