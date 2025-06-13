Return-Path: <linux-kselftest+bounces-34948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C343AD9545
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B33B450A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A82E62D4;
	Fri, 13 Jun 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RUIUECsU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA67247DF9
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842084; cv=none; b=ZouglpDFi0JmVhn6pzMgtH2CXWaPFtVsAmMKVZamTN4B1+GzRRt8nv2/eQfJ7rYGHWHg3KEaGJKRRALNH7i+kCLhxHvVyMzJhzhaxjfPkB5qOteQaHugB0N7WdyZLRArGSF+UYCUxChA86RUU4a+ugIEfmALf4LrY4LphlGZYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842084; c=relaxed/simple;
	bh=gB7leVldU3Q+/K2dvULRGODaLqYXhPw7nhUc71aLv2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RESBchPahkV8jqh0BLQ/EEh1B9T3Kp92+D2M7anIj9z0w7JWV/RUK19k8dCh1UkhvL7gVjmlKsBpkSMJuGHpDoMEVaoEZWnREl3edAJumTnkHPs6blL+I2MKStRIsRDrUu2PctEBYfiBDTyvGQM4AVUk+PC/JrS628htUYrfq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RUIUECsU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso2330949a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842082; x=1750446882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9p4glGj+JFvfl5WfXSVa1QcEpc+ehsxYbyir+NTtj2U=;
        b=RUIUECsUkDzwt1KwDHpgZflwJwJyMXEEAuPOORenD11INmelQOySk5/MWVurRPYICL
         PovOKopH9LERkfsK0acF7tbiUMIYSgiiNTeDPAW/fXnw16DctjAuoYBz6GOYQKde2i4q
         uyrKvsPb6H/z2yXididisDZhCV+gFFmKRSk9cDo95YLxnshRImWiWOoCj4rJjYCN6voM
         z9jBS1qAUem2evZraZlhrNThwx6hLTlR/YeFK4SC8cSjr9tgdeJuJ13WGmNDlle8lFDA
         3alhS9RiKCq3DgyIHaIZB+XUHU4xfb2x8YIfufRrtSZ+UxmL0NaHSLD5xoE/w8ZS5nFi
         WdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842082; x=1750446882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9p4glGj+JFvfl5WfXSVa1QcEpc+ehsxYbyir+NTtj2U=;
        b=B5AiCuYn80TXeIRGG7DJ6MCzEbvYztmNZBPkgQzj3HXQPEOWK2MaJ0pdWXPMGYiK3q
         P9+AVUb9Zm6/6+4MTGltt/nD9n8fJiSasH9sAPv1/kiCaZjzOhhGMLrUSLbPWR+uoYu6
         8ki3zLG7uQAI9UhTTp7/Eu4UYPgMiITgGwtmDD5jcpPDkXY2N8NwxYDgn+xo8o84vBgL
         6M6uYEJEH+egbLIVfPL8188fIZ8PW1X8Sf/Za0tmO2KnOdyTWMmit3V+pCxGIBpA5P7N
         BlFcMDD7csUsUtnN1Z6HLtRkYhOoi/LlCItxb2TUpTP2ihsqeJy5gLPUhgJ2d4WR0L60
         IzAg==
X-Gm-Message-State: AOJu0Yz0Zalsc0YCSuTrt9BBdzH3jOrgYVAzCM5jEKycWH/y+tGtPLQo
	4lrw5lwVNqXiUr3YXhMiic/quW3UfNGed9Y7wewUKMIe1y7W5ABK+U8IpEOqd9MJfnVaHtkFDu9
	rWeemw6YyQRINZn9RsYLtjwTtHdhrhCkxV0s4eTPjitNB+/1+8pFo2tG14K+sB+u3URKmVa2D28
	Sib0QsbRn7TDfGrORPqQ+MboWGKquuytG11iqWlwvnGKY=
X-Google-Smtp-Source: AGHT+IHfouRTUogXGPkW4ugX6w/2YUe1t4Q6+8l6WO+bVjHwKE9QByebDntsgccifWGOIya/D+bam5qG5A==
X-Received: from pjbsr4.prod.google.com ([2002:a17:90b:4e84:b0:313:2ad9:17ec])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d0a:b0:312:18e:d930
 with SMTP id 98e67ed59e1d1-313f1d4e217mr956309a91.19.1749842081564; Fri, 13
 Jun 2025 12:14:41 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:46 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-20-sagis@google.com>
Subject: [PATCH v7 19/30] KVM: selftests: TDX: Add TDX MMIO writes test
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

The test verifies MMIO writes of various sizes from the guest to the host.

Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 14 +++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 85 ++++++++++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index fa0b24873a8f..2fd67c3e5128 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					    uint64_t *data_out);
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index 8bf41e667fc1..d61940fe7df4 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -123,3 +123,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					     uint64_t data_in)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = MMIO_WRITE,
+		.r14 = address,
+		.r15 = data_in,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 563f1025c8a3..6ad675a93eeb 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -804,6 +804,87 @@ void verify_mmio_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+void guest_mmio_writes(void)
+{
+	uint64_t mmio_test_addr = TDX_MMIO_TEST_ADDR | tdx_s_bit;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(mmio_test_addr, 1, 0x12);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(mmio_test_addr, 2, 0x1234);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(mmio_test_addr, 4, 0x12345678);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(mmio_test_addr, 8, 0x1234567890ABCDEF);
+	tdx_assert_error(ret);
+
+	/* Make sure host and guest are synced to the same point of execution */
+	tdx_test_report_to_user_space(MMIO_SYNC_VALUE);
+
+	/* Write across page boundary. */
+	ret = tdg_vp_vmcall_ve_request_mmio_write(PAGE_SIZE - 1, 8, 0);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Verifies guest MMIO writes.
+ */
+void verify_mmio_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t byte_8;
+	uint32_t byte_4;
+	uint16_t byte_2;
+	uint8_t byte_1;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_writes);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO writes:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 1, MMIO_WRITE);
+	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 2, MMIO_WRITE);
+	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 4, MMIO_WRITE);
+	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
+
+	tdx_run(vcpu);
+	tdx_test_assert_mmio(vcpu, TDX_MMIO_TEST_ADDR, 8, MMIO_WRITE);
+	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
+
+	TEST_ASSERT_EQ(byte_1, 0x12);
+	TEST_ASSERT_EQ(byte_2, 0x1234);
+	TEST_ASSERT_EQ(byte_4, 0x12345678);
+	TEST_ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
+
+	tdx_run(vcpu);
+	TEST_ASSERT_EQ(tdx_test_read_report_from_guest(vcpu), MMIO_SYNC_VALUE);
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -811,7 +892,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(11);
+	ksft_set_plan(12);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -834,6 +915,8 @@ int main(int argc, char **argv)
 			 "verify_guest_hlt\n");
 	ksft_test_result(!run_in_new_process(&verify_mmio_reads),
 			 "verify_mmio_reads\n");
+	ksft_test_result(!run_in_new_process(&verify_mmio_writes),
+			 "verify_mmio_writes\n");
 
 	ksft_finished();
 	return 0;
-- 
2.50.0.rc2.692.g299adb8693-goog


