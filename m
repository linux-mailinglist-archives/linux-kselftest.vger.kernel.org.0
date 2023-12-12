Return-Path: <linux-kselftest+bounces-1737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10C80F83B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10CD282E0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86365A7F;
	Tue, 12 Dec 2023 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDNJ/IHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361BD47
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d2e29bd3ddso33130075ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414045; x=1703018845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOWQKACugG9g7cz1/AmBUQwWqXmyF/X6aVaYz3Y0fys=;
        b=UDNJ/IHKmtJ0j28WMjuk+m9CN3Op+Hz24erYtTuumRJJ/J0nin0FhYj7YKIER0ku+w
         iQuotmQcQmsckniodpcM1uJUz0zyARyz2oQVoSEELJxV5q6jBaPG8+mv0hk3A3JOiTxl
         dnIIwW8g6Pj66xMKwAMB+g3U+dMQUdKf+60pAs4eK4/xMnxW9TkcFgoTA/09rLambB7W
         vkT/hh72Fl12kYfm601qAomyAMzylkOTq5IZ49AOCwD0XJF6gzkQ0YKfDbVlV4R1g8cz
         RX5fClFysaAkfE0Ejq0Cr9Yha3UisgsBYmea165C83mFolvvm+cun5xr7Z0+EnYltigY
         rHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414045; x=1703018845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOWQKACugG9g7cz1/AmBUQwWqXmyF/X6aVaYz3Y0fys=;
        b=CS+Vx4bm4wbXu/39rwKwVksWoFH09mHfkIiAhgkUNJ6TO8KAVtA7bDRb5wJK9jejm1
         Viaqn4FQSQ7kIARmn9izcmi8lhMXueR2l8ZrBdWz/LOQHijIUCMHg1kRp1Q9iNv1YC0g
         tr718fvpM3iBCmvqIeVxWoecmdrPxmZ28RHfbeR9FUMPT3tQep3IyNNHPaMK20fxES3v
         9laVLoG+EYeMGxPH1dWsaTvVitizSp5Eq0Slh880DBSQTsh7JwgGjMUcetwFx021jMxZ
         9k+DsdoanULYr4C8DqTdyMOlXpFGOynxXZ+/Vrihw+778S3pWr+HmeaZLVh09JPs7DGU
         CqJA==
X-Gm-Message-State: AOJu0YyR+qWZPI2/e+Rqq6BmWgcxh38T5HVbZdsRJilyngR4D12isKpX
	8ZUx4uhYHctxZwwB1IgDSvNoXHleZd9OJL/WmR7z7UN275ehUzqGhyGiuL+APQz/YJuJXEuJzgD
	x719QGWaSdasJuLBoeT+83pB74b6yf8eLA1CzalC7bvLNvR8a+3T67b/Bqlv4LcBQvA5Iu20=
X-Google-Smtp-Source: AGHT+IGLlrmxTENwZC6SGbM6jr4r7WDmCiJAWrdAa/8w6lr8saM6Dsnuvy2FguUg9MN6N/MAkqVuDY/IjA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:32cb:b0:1d0:c3e7:d4c with SMTP id
 i11-20020a17090332cb00b001d0c3e70d4cmr53041plr.2.1702414044401; Tue, 12 Dec
 2023 12:47:24 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:29 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-15-sagis@google.com>
Subject: [RFC PATCH v5 14/29] KVM: selftests: TDX: Add TDX IO reads test
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

The test verifies IO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a2b3e1aef151..699cba36e9ce 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -429,6 +429,92 @@ void verify_guest_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_READS_TEST_PORT 0x52
+
+/*
+ * Verifies IO functionality by reading values of different sizes
+ * from the host.
+ */
+void guest_io_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xAB)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xABCD)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xFFABCDEF)
+		tdx_test_fatal(4);
+
+	// Read an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_reads);
+	td_finalize(vm);
+
+	printf("Verifying guest reads:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
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
@@ -444,6 +530,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
+	run_in_new_process(&verify_guest_reads);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


