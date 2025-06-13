Return-Path: <linux-kselftest+bounces-34950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 242E3AD9548
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A1D1BC3E9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD12E6D0F;
	Fri, 13 Jun 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clpE+JMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE42E6D14
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842087; cv=none; b=u+Yb3mgxkzKB1VVlbrDmXpI9XEbZynXch3PJZ6KRrHePjaUCTv1Zylc9nNSdNNLlDI1/tQB+uYbb/748+bD1Yhuw/wusOMJIyr/NQ5tse7JxDWMNGtPW75FgWn1yYSROLZ+ygDUjL8uw6SiUJjzFaFGK9curBypY+ZyUutw2zMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842087; c=relaxed/simple;
	bh=ZDHbd532GCXq4+Wx1lJLULWSC4TyKkWgWdn+qq+pg3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVI6Aw2DC1uJvzAwt3HGAI8XzixndLKJtqFEGvxHbityqI/C/qya4GUvH7ZAEoDdPIhajpakh890RP6k/3+ARezNhn+FJdakOYUf/99lFh1/tjdpw6tMBMsMBOGcWwj05tBegfSGEYyaAqG8Vq9r6xs4h2KBNOg8mvF5NseftOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clpE+JMA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234b133b428so17248475ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842084; x=1750446884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSem4my8PEVCL1FyWJdYHzfToitzpttknCPI+ZxEpoM=;
        b=clpE+JMAGI4tNpZIa2F739kls23FI7gJZvNq30Np5mUr5EPCcPpb6ne3gv7Nnb1eS9
         3CBzkrVNfhXQr+t/uHGBSz6/9Q/Uv9/3b2tYEAP67R1QKQ0OIx4oQ107j0mxfor49qW3
         joG9UxH5dCdb1ybFFOkOTio20+h1Q+Vs9h9uK4etSX9TFjR8VYBk3uA3wWI6QYWhub5S
         5BCtqRE5aOsD55Ev7BrLOuVqmBM3T73P06CbEtCP6gOxyJPiwDqm6Kg6c6yV6YwRIqrj
         N4iqdh04kZLhc0GzN7KBQF4cIJgxKrXhrOTbuR8I9loP62tUot/XRsqxiJY61exWRi8t
         VJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842084; x=1750446884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSem4my8PEVCL1FyWJdYHzfToitzpttknCPI+ZxEpoM=;
        b=YvwdDEUN6xe5k78OkuCujaLaCmIIk2XfRhNNXqjj9OBop9jFyz+7vwAO4pZWcLB8YY
         wnP9qc+FJYMwYxlhiIaVZu2IXI/194ijybmbFN/M3Rcmp+K+o7Xye6kVY8wEAKpcaOMR
         mjVPn/pLgVXweQ/sbnVHcVpIdhBIxim4ldMQPFUuW37BkwxGxIl/1h0aH2r2+b8xec7p
         zFrSsfTBTdCWqfvEEJOXTikBgwKmz9IwoqbwSbLf9hcHxki10XNvvmjyi1Sci7lfhfMs
         FmzsA+ThPn7ZYAcRqIvxBQg0UZtaNE3hYhQkIxkstZV9ZQPOVqhGyTXPPqM/hT3aAQup
         g8Rw==
X-Gm-Message-State: AOJu0YyssTrJn4ZofTG30cA196zVNh93Yu9gxtZdv/MbhLssE6Nxe2B1
	2OzyI56mwUpnEb7Oes35FXmAlq4nyewN+pEKAuRQwBS8MpLIgkoM0gn5ujIyisXgWQTTtHJY/tp
	3yGFbh1MGvm5rNP0IWvcLs2XtgpkyaNhzGky4uLH3Nqaz5EhWcWqvf2XxenKHc9AXY7DmosSliS
	lq0SQmPdrZUBK+4XVx4q8e0/uWf8XNnE8lI+K7SfLdqx8=
X-Google-Smtp-Source: AGHT+IHoFi2FEXxt6RGl8CP0XU+1XYYnXNl8HBy73IZAP7OdJlDmHDOpVJoQYvp/U3PxFXoTzi0LO4LOEA==
X-Received: from pjgg14.prod.google.com ([2002:a17:90b:57ce:b0:2fc:2c9c:880])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d487:b0:234:c8f6:1afb
 with SMTP id d9443c01a7336-2366aeea601mr11815165ad.0.1749842084414; Fri, 13
 Jun 2025 12:14:44 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:48 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-22-sagis@google.com>
Subject: [PATCH v7 21/30] KVM: selftests: TDX: Verify the behavior when host
 consumes a TD private memory
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

From: Ryan Afranji <afranji@google.com>

The test checks that host can only read fixed values when trying to
access the guest's private memory.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 83 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 2f75f12d2a44..b6ef0348746c 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -959,6 +959,85 @@ void verify_td_cpuid_tdcall(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Shared variables between guest and host for host reading private mem test
+ */
+static uint64_t tdx_test_host_read_private_mem_addr;
+#define TDX_HOST_READ_PRIVATE_MEM_PORT_TEST 0x53
+
+void guest_host_read_priv_mem(void)
+{
+	uint64_t placeholder = 0;
+	uint64_t ret;
+
+	/* Set value */
+	*((uint32_t *)tdx_test_host_read_private_mem_addr) = 0xABCD;
+
+	/* Exit so host can read value */
+	ret = tdg_vp_vmcall_instruction_io(TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
+					   4, PORT_WRITE, &placeholder);
+	tdx_assert_error(ret);
+
+	/* Update guest_var's value and have host reread it. */
+	*((uint32_t *)tdx_test_host_read_private_mem_addr) = 0xFEDC;
+
+	tdx_test_success();
+}
+
+void verify_host_reading_private_mem(void)
+{
+	uint64_t second_host_read;
+	uint64_t first_host_read;
+	struct kvm_vcpu *vcpu;
+	vm_vaddr_t test_page;
+	uint64_t *host_virt;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_host_read_priv_mem);
+
+	test_page = vm_vaddr_alloc_page(vm);
+	TEST_ASSERT(test_page < BIT_ULL(32),
+		    "Test address should fit in 32 bits so it can be sent to the guest");
+
+	host_virt = addr_gva2hva(vm, test_page);
+	TEST_ASSERT(host_virt,
+		    "Guest address not found in guest memory regions\n");
+
+	tdx_test_host_read_private_mem_addr = test_page;
+	sync_global_to_guest(vm, tdx_test_host_read_private_mem_addr);
+
+	td_finalize(vm);
+
+	printf("Verifying host's behavior when reading TD private memory:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_HOST_READ_PRIVATE_MEM_PORT_TEST,
+			   4, PORT_WRITE);
+	printf("\t ... Guest's variable contains 0xABCD\n");
+
+	/* Host reads guest's variable. */
+	first_host_read = *host_virt;
+	printf("\t ... Host's read attempt value: %lu\n", first_host_read);
+
+	/* Guest updates variable and host rereads it. */
+	tdx_run(vcpu);
+	printf("\t ... Guest's variable updated to 0xFEDC\n");
+
+	second_host_read = *host_virt;
+	printf("\t ... Host's second read attempt value: %lu\n",
+	       second_host_read);
+
+	TEST_ASSERT(first_host_read == second_host_read,
+		    "Host did not read a fixed pattern\n");
+
+	printf("\t ... Fixed pattern was returned to the host\n");
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -966,7 +1045,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(13);
+	ksft_set_plan(14);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -993,6 +1072,8 @@ int main(int argc, char **argv)
 			 "verify_mmio_writes\n");
 	ksft_test_result(!run_in_new_process(&verify_td_cpuid_tdcall),
 			 "verify_td_cpuid_tdcall\n");
+	ksft_test_result(!run_in_new_process(&verify_host_reading_private_mem),
+			 "verify_host_reading_private_mem\n");
 
 	ksft_finished();
 	return 0;
-- 
2.50.0.rc2.692.g299adb8693-goog


