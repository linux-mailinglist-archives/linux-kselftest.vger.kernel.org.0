Return-Path: <linux-kselftest+bounces-30778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013CA88E54
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F58E7A695A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DE21D5A9;
	Mon, 14 Apr 2025 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wn9cE2dJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4821C168
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667341; cv=none; b=X7HLyR09E63U7hUx5Fmzd5iIMKJS/lD3fqUbhlGKCNzDMk62Em2agPC6yyBwKM8oGalkv/Afzwpzi/ugtojA9OQH3UgTkqzOLDonW8nKP3VqP4w8mdb3ZjeG11KmpK05chNPVEqt1DeqCYVjMmlepaTq/7xy32nFq+pwRXen/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667341; c=relaxed/simple;
	bh=SzuLpOtOjZ4283rbOdX2eus9Xjdq4xVD7b4UypnO9Mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lld+A6tGIyOiPsnoeUUPOBGR3HG7l/V7D1y0AevxF/q7ukLv9HvkUmiaXnwI/9amHErIxsvRHTauNJ0ZchKww5oqUUeFADSQlSN07D067G7INOf+zd/g5B1NG98xRT88nPDyK7/xHxgKuyKs0OLzOgzeoMvDC7M7pdRskaImKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wn9cE2dJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b078af4b07dso959940a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667339; x=1745272139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZKN3GfIxfYZ7IMwoz+StT3fWXyoh2WeyUI3/2uuukE=;
        b=wn9cE2dJmHuC1uxgxgtjMn4MpPvNom03r6YCuBqaDA04nGoFErR3xjjvfbrMrzL0RS
         JxgLy3CKNHHABCwkuSFqvsphwTfMlpd+QncJeu1aE6O7rxKJFiyO0kyvnhwD93J7ckPC
         82+Lx0LtncV6AxNRM7BSLS/yFpVG29a1icipFIu5ICPZkmJrlGXd8P44avkFSc/EVvfu
         wSrBskNR/LCjQ9ovA29vfpna1cbEZ5usSN99ZVSGGockSwvr5pkbwNAwj/+fAdc2rimM
         4U6O/5OaPOoNYPjkeQxwoE5/idD8fLHvcyuSN/cf19Ii2ZT9BRwQwuRkBCq+p8jYoFfI
         Clig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667339; x=1745272139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZKN3GfIxfYZ7IMwoz+StT3fWXyoh2WeyUI3/2uuukE=;
        b=IX+K3XPfG9EmJhwuYl4JvpfITNIEFzyaiJSyWDieD3rcgt56a/2bQdyNF5Xvk6wHa/
         3mC6TiljgmWnXmn5bk6BjNcNbnTSlngnSvsPaS8OKovPEZUKRD2eSs55i3RpB588rkT8
         yU5VWVgzbSSCZbNQTti6axunqMOW0g7aza9v5h8hoA6pF5tWFnlKbQV5MOSQgwEggcQr
         G86rlvGP2s/bO8UXw00bUkjhs9tRvPwCPYHJVBtWbf7XnNb8BX0OcZHlt5OLrUaLTXIM
         /ZfiEpcr4XATLQoIJjoYj7PDwXFKHCp3CoPGeov7hGJcwdCdU37ot7w7RRHX6w5ISPgo
         uFiw==
X-Gm-Message-State: AOJu0Yx2vIG3C9BT3SmqSXfU81TZPU3Q/6TBLHjMQchh9Ds7AXYzyncy
	f9J5t5NGSgjfu4GU8FnYd8LfFzYQjJDMdKEKIztQsrEaC2XeBZF/c/9ABgjTwMvxf964pZ4WysG
	kYn1kQ6JWpSSeq9uZ9DZ1fiTrPJz7CLJz2Tb2NDiAxdAW7cmlT0HMHHQ+bPor3675y84UZYuFL6
	Y/RAXBU0YcISVzIe8z/49YF5ceicD03en4MVCMMkA=
X-Google-Smtp-Source: AGHT+IFwz6bs3Jno4CBwjDP6DY/136fQKAMa28TRHFuzEFMDStfePRgpN6f0IE+VncQ4sU0XUX7lPUXivw==
X-Received: from pfbcd18.prod.google.com ([2002:a05:6a00:4212:b0:739:3659:ad9])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f688:b0:215:b473:1dc9
 with SMTP id d9443c01a7336-22bea502637mr188034325ad.46.1744667339098; Mon, 14
 Apr 2025 14:48:59 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:43 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-15-sagis@google.com>
Subject: [PATCH v6 14/30] KVM: selftests: TDX: Add TDX IO writes test
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

The test verifies IO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  3 +
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 79 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
index a6c966e93486..e7440f7fe259 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -7,6 +7,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
+#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
+#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_HCALL_HAS_OUTPUT BIT(0)
 
 #define TDX_HYPERCALL_STANDARD 0
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 22143d16e0d1..f646da032004 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -308,6 +308,81 @@ void verify_get_td_vmcall_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_WRITES_TEST_PORT 0x51
+
+/*
+ * Verifies IO functionality by writing values of different sizes
+ * to the host.
+ */
+void guest_io_writes(void)
+{
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_1 = 0xAB;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
+					   PORT_WRITE, &byte_1);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
+					   PORT_WRITE, &byte_2);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
+					   PORT_WRITE, &byte_4);
+	tdx_assert_error(ret);
+
+	/* Write an invalid number of bytes. */
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
+					   PORT_WRITE, &byte_4);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint32_t byte_4;
+	uint16_t byte_2;
+	uint8_t byte_1;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
+	td_finalize(vm);
+
+	printf("Verifying guest writes:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 1, PORT_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 2, PORT_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 4, PORT_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	TEST_ASSERT_EQ(byte_1, 0xAB);
+	TEST_ASSERT_EQ(byte_2, 0xABCD);
+	TEST_ASSERT_EQ(byte_4, 0xFFABCDEF);
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
@@ -315,7 +390,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(5);
+	ksft_set_plan(6);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -326,6 +401,8 @@ int main(int argc, char **argv)
 			 "verify_td_cpuid\n");
 	ksft_test_result(!run_in_new_process(&verify_get_td_vmcall_info),
 			 "verify_get_td_vmcall_info\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_writes),
+			 "verify_guest_writes\n");
 
 	ksft_finished();
 	return 0;
-- 
2.49.0.504.g3bcea36a83-goog


