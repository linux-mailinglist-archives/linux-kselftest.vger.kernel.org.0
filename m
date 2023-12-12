Return-Path: <linux-kselftest+bounces-1736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BC80F83C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8252B21049
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042965A7A;
	Tue, 12 Dec 2023 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xys/pjw+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741FED
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d053953954so30442805ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414044; x=1703018844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJkjWxWHyZzDnEqdZ8iaPH05VJWonQ7XdgN0T6HdUW8=;
        b=Xys/pjw+pLjzX9w+gH0gV34rBU05Fq0CdCuNBgR6VV3/iAJcNHM0BeohIlfVm+D6P2
         dFL9eVMkT+IXicmuI8owrxMXBbUeT0yyvCPm5Z7Y7oHFH1/e1N9iWjfaFHNldGUBdsm5
         fcltnYcxn2ekD7gP1Cl8i4DqxqRY1ry8noK4k/XtOUmyAfgqD8kKZDmXTwxw0o1B9f+K
         Vq5N3DqBhM/pRWofR1NhQCUk77M2kLwfesVYc4Ti+gjbF4HeSAuGiCVGPHonFrGBGq1b
         sxdJOXDh/+6cYf7TCR62HiAzL0TLdYMqeu6WUOe7iTYzatNC48hsq6KZYhWrz+jI18wo
         cg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414044; x=1703018844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJkjWxWHyZzDnEqdZ8iaPH05VJWonQ7XdgN0T6HdUW8=;
        b=Gjqpcw1ov9ecpH5N+qYE1RTtO+pjy/1Pz5vYUF++8tBCU1gnC8mdh0HKaDmc3sdSQq
         JsnHET4Pe+R1TyukRV+m5Vy2eVJ/4efOF2KDpvlxVPFAIMEmeLOGD8GT67J5dozCWuOE
         5ALT4fGI3dLlls1a0w7kDAT8quKGSBqH3D1ZMjwkZ93CVJc72CTAoNAyBMDxnFziTJPc
         fPGxpL32nDtjvbCwDrVKk2eiZWoeC+NaohwSaDygYVqdNTZX2wpv34ESZ1GgNNCf1WMF
         UxnAUbRL0aWwnY0ahn/MkeFOavrf+E9G1iHM+HV6lNj+GwrlsgajS4Izg9IUm9jHHAmw
         PbUA==
X-Gm-Message-State: AOJu0YzZYxV3QBf3FZIrVs2VVnihvnkbvA8uBm5GtYqaCnukUBpr6jZl
	5pCrU87X9ZMFkHQOl65/jFncndnOxvDzmQnUOPyTkgcZ3v+ymMjKzXONwRgk5sBPNTFdkqoyONs
	x5uWDFNJXK49KaPqHfjcAMZmTNcDlrkPwm+e7P3sKMu/GLAkEvP0UdOn/gty5yFNWhbijRK0=
X-Google-Smtp-Source: AGHT+IHqeYC5opUgPPkQ1SaE9sI6LjAtCU7PgcgsLBBz8kpU+6ccWNAq52DxBl3PTzAdHM0JHwh97v4lLQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:ec85:b0:1d0:537e:852d with SMTP id
 x5-20020a170902ec8500b001d0537e852dmr58319plg.13.1702414042901; Tue, 12 Dec
 2023 12:47:22 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:28 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-14-sagis@google.com>
Subject: [RFC PATCH v5 13/29] KVM: selftests: TDX: Add TDX IO writes test
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

The test verifies IO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  3 +
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 91 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index 78001bfec9c8..b5e94b7c48fa 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -10,6 +10,9 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
 #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
 
+#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
+#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_HCALL_HAS_OUTPUT BIT(0)
 
 #define TDX_HYPERCALL_STANDARD 0
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 569c8fb0a59f..a2b3e1aef151 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -339,6 +339,96 @@ void verify_get_td_vmcall_info(void)
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
+	uint64_t byte_1 = 0xAB;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_1);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_2);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	// Write an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
+	td_finalize(vm);
+
+	printf("Verifying guest writes:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	TEST_ASSERT_EQ(byte_1, 0xAB);
+	TEST_ASSERT_EQ(byte_2, 0xABCD);
+	TEST_ASSERT_EQ(byte_4, 0xFFABCDEF);
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
@@ -353,6 +443,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
+	run_in_new_process(&verify_guest_writes);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


