Return-Path: <linux-kselftest+bounces-38514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA087B1DE07
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2227B3E92
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C127E7DD;
	Thu,  7 Aug 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIsxf155"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38385239E7D
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597829; cv=none; b=KWj/mKGRdWtio5bR+dcnxhEzB28mS4HkgjMfbM/Rjr53O3iSRTfXcnGJBjwqA0wS42f3TSBLZhwxjqBtIXMczQlHzfi8DJN3RyEUOj1K2JnedUnM6XSENui4ouzlVlcxB7RH7+jbDjx6iQi5cFMrAUAeXJ2xmakezw0HqjIR1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597829; c=relaxed/simple;
	bh=NkZ9cw2OQkpKTyBr6XnTKZKOxHkmBwe+wNgxb8ukCTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFZyUCiSV4qcOlFvIsEgJulfZLH0SYQ3latDAeD0CLc14Pm6mEOFjYLYsgH28xNWXZ3ihkGoX1WW4dmn46+FjBNs80J6Z874YPgcS3/SyABeQH4+Wumi8ltn/V8RDsF/KpF0EopJGXp/GRJDXi4bzIB2xZ4RzcKu0Q5d/V0tRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIsxf155; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1435644a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597826; x=1755202626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGXEvvh28CILFU8veFYJPuuhWeDvdlK202GCjoHljc0=;
        b=CIsxf155Nn4ORlGN3obiaE94G2wj22Vnm3QOGfkzU+dflRorlXhpJj3o4NwdZnUoAI
         nE0jXotWm++qCYJk1ZzCFZ8hD7zWY4ugI5YNrC1nJgts5hkNij6JGj6U3DUzKpcEs6OW
         uEtnAW0fsLncJBl61evYtczbH+LIHqWKMhGQFBNg/Tohuo9mek5Lv+xml8bsSGZSZ+bp
         bbBeIjwZdNeoai28uLAY290UKIdFyaBIkNHwBemAT2bxpUHkqpRPGyJ4K+qMq5djtF50
         0dgXkMYpoGJLN6tDAb4dh7NfZARWP8o0hmdrobGuRmO+ieHRaxLjR/EcoVomAsUviWnX
         Zlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597826; x=1755202626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGXEvvh28CILFU8veFYJPuuhWeDvdlK202GCjoHljc0=;
        b=aicwtWeE3cUUTn2syP4GtDmRx2VKa/cb/tWPP3Ya5960rwMLqcLgPdckau1zZ9ZhPb
         hBNtyfepsFezfWJH7ohT51vaEEvJaia+kPXHYlab6gVvLqonkv2moWmHmhbPiG24s0mL
         /AT8Uf5qENTjP02jOvmXq8V7N6+3pNX5Ws5GZf2J7TE2KLlTVrKirKlnPm9JplGG6uea
         1MupioDu7j5FGE4qFvZPD41wZniWNwPtXBOyGUyLtR5T+YHh8rxyRe3yKctDvu7zmEHB
         ILuCZors8SVj6cQn7bbKrvdreersSapoebjwhAAVickrfx5TpJLf//3fKvegyYGXpr0k
         SxWw==
X-Gm-Message-State: AOJu0YztPguXxDejYDoqBz1TEqgOxFEYANddSLFvLqpxak7M3Ruh4NVe
	qy12KRcOKG3mbgdtIP2SlNjqz5GbKQ7tdGpqCmwO/9s1hCklTZIzki2gIANwCV1VK6Kobm3l/jg
	ZLaC6LcX2MOVMNAaJefOOMU592864i4h8U1m6rpYe7AiULIDVi5svOJertseaz4M42AbIGjTvgj
	wh4b4erTOLv/ZqAoT2Sp2VODlqD9eI77hOXPvUNYWEiXU=
X-Google-Smtp-Source: AGHT+IEt1bokf2gwgVn7hdK2GrWh3MEGT0E9AT9JiLMbohoSe5t35nvuUxv5BuJLVfGUiWauYYMf6L5SXw==
X-Received: from pjph9.prod.google.com ([2002:a17:90a:9c09:b0:320:e3e2:6877])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5249:b0:320:ff84:ceb5
 with SMTP id 98e67ed59e1d1-32183b3f039mr501997a91.16.1754597826341; Thu, 07
 Aug 2025 13:17:06 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:15 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-20-sagis@google.com>
Subject: [PATCH v8 19/30] KVM: selftests: TDX: Add TDX MMIO writes test
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
2.51.0.rc0.155.g4a0f42376b-goog


