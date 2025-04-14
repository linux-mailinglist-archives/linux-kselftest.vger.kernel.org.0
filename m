Return-Path: <linux-kselftest+bounces-30785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC4A88E69
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01A77A42B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7497D2309AF;
	Mon, 14 Apr 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUS1mf2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526D221D8E
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667353; cv=none; b=rGizTgZNTsLnk4/6TST0P4hfkmPMvHsb8CBAFyhhfJfNQpkY8pmVUWUZfr9odAv4TcNTDGgt4FFoBhZLfRfW0DkQ5Y9xYpCEzyvFMBh5YWgBJOrHqnqE+ybc2eM0n0eqcScdlyNZ/hv1NidZU10xKfhGOcgagObo+zfItxoJS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667353; c=relaxed/simple;
	bh=mlhbyHDrP1jVY2Jp8YEKn1yt2fPFrcKj+zfJJ/OxYk8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O0bj2Be8VlBI6VOPqBi1xw5YXIS5LuJQcoTsiTYe8u4U0m17tIX5WoUHz939dh/fqvzuU4lOspoZ7ZOy73gXwxetgi3gnJBlyjemKzPsb4kmm9JB/Ehmh2Uz78Dd6D3iZ5GR6UB1rOrH0nyr8JClA6x3akTnJ1TACl6rBV4W3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUS1mf2B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2262051205aso32721745ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667350; x=1745272150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGA3lN556VUwTj712hkHFTKKWZZm9uKrW/wDb9eRLAw=;
        b=pUS1mf2BrbZCdsYVqXmWiqHmOFkzYKtpKNs3iROaGkEBz5b4sXFlFKFT8j5avuw2EU
         uuoYjqi2OS/KuqufRDLEPdAjkcycbZVboR6AVGPO8wHAxQRovx5JT33uEUZhT3CcWMA6
         aOlhatBHWV0xhW6SCGUUQSBnXGU7xBa+8gEcFp8MFwSnbWv/4nXVRYYx6giNp6VcK9ju
         NMYDC4vST4vujxWm4VlBKs1F8Q4AwhoxpNqPYuh4o4DOzBwipTmB9cnkHmmQsSpS6qy+
         GLbvUoe2nr4EKP1RIykKtUBEWzZOgTymq7B1eFc7jawUSIcxeamHy0WAznxbyEAQ73g4
         MHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667350; x=1745272150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGA3lN556VUwTj712hkHFTKKWZZm9uKrW/wDb9eRLAw=;
        b=F4CfbAHguZGYB7IjqpNkCO70JMZ/+4ISSjWJ1ot7acl5iD4iCror42YGCLtrsXSkeB
         0ecs/WlhDWswzomfKQtWok3mIRX/31j1/QkT0DyeyNSNLlHIFBYgujJkZ3q5bO7sbW21
         7oo8DHwTz3jFsPFFqOX4p1z/sCRv2q3tZsbreehAZEs5X2L6Aq3fbl7W/3mBJZQ/3MeE
         fLwlo7BByrruu+V87hzHr44Ngo5kKVNiKcfcCP8m+Gvq9EDTh8XW7dQfCJp9KWwfj43H
         hhthyV+bxCmzVZEHXGADNiVsU6iREFTufyvD8YhJ3BlQksm5X4vWwSD2Z6m1atGlm4oR
         FMDQ==
X-Gm-Message-State: AOJu0Yz934aGSrbgU01WmY46zkuMm8giMMv9I9fwzzoQxpUKLsXAZ9tO
	H/OAXAa9IPqCsEAESgBjaczVN5NSIfswkxP157KnrZY8+m1DxirYbwSPhEL9PBZg9lefrdmt7Qj
	4LSMipUW1jibDDUY/ftlMcnDkpwWvcxORQlzEDUZ+UMkH3+7uyuTJwSitEC5GtYd9bcaevkn0dw
	KqsjFYcpB1+uZ0ckQd8J1ghHDmScxTrPCgadVli2k=
X-Google-Smtp-Source: AGHT+IF2Xs7zgQ9BUpCVAEQyGXqLWfZX0BD9pvhxAwgFLAJIyDU3gWZXTOXn5Bv7gLn8nSYB0cbEHbCKmQ==
X-Received: from pfbgj15.prod.google.com ([2002:a05:6a00:840f:b0:736:b19c:1478])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6c:b0:224:78e:4ebe
 with SMTP id d9443c01a7336-22bea4f26e7mr186219335ad.33.1744667350413; Mon, 14
 Apr 2025 14:49:10 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:50 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-22-sagis@google.com>
Subject: [PATCH v6 21/30] KVM: selftests: TDX: Verify the behavior when host
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
2.49.0.504.g3bcea36a83-goog


