Return-Path: <linux-kselftest+bounces-38516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F5B1DE0E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10C358679C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C47527F727;
	Thu,  7 Aug 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U35JFMmW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780B24DD17
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597832; cv=none; b=C0R2QJ4T9elzns9ctPBYzVtiQuy8jvKdeUjXcSIrXQQteKDCyG8oXup0l+hvcmdCLs/wn0MYpR+lU1Uuc2l8ST5ugl5KudE7I2dx0+aemwjVAMUXUqYRjba4UAj7bub2AvWrub+3qqww70Z3/4D8DflPcnbF+mbF2E7vXQ2osrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597832; c=relaxed/simple;
	bh=RXVJT3xKKpDFgdngx9y4dlRBL6JQNyl8/5ZSR2/B66Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOqB2Xfic1StUz3YZm805WpuhLgp5wF7YQ/sUtVLQTNEVRvGC0Z9WSj7wuaovCqAZsOzuggiqRMhbQ3+9RQb46spD9q/pip+hpns5wxkVjusObNKQCUeY+GbG+an/BksqkNhcTDef5RJr1KTphENkXkteK3/D7hCbDg+i+uTVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U35JFMmW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-242abac2cb4so18204235ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597830; x=1755202630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3/DP/toZqy9fmiCiLsTNtC3sfq1PRsX7V9GLb3O0mQ=;
        b=U35JFMmWGwUcgwDR+NKWxUhJKmVhg30H8aZc9PS4fSQ5E151HpcNUYV4pRFDxUtn7N
         K7x/cqi8pBi0HMhjj7THDfQM89CR9Jhkx/CDLGzN0dbPXT49/iD+WQDv0aMi2l4Xra7/
         RMhNmWSwxRFo8MT0xTRa7oajKyM90ARR2gICPmcazZ2k+e/QApEyGCVOd384Y+3ozjoW
         5hsStYmu3vxTNIB420Bu4IJWNeI6w6zxUJiuE92JocQOywtncQnISPNOLktbSgPNiv2r
         ujhXCNLUbDPgegFFN4pwYysdqBZQeTHkxWUz+eIbmrDfEwhgUSYZXglnrmDMZswZovoj
         9r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597830; x=1755202630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3/DP/toZqy9fmiCiLsTNtC3sfq1PRsX7V9GLb3O0mQ=;
        b=rXYxJVbKWkVoAqevwFKpw3ieGXLtuk4QefjvUg4LCoW8wpSTFGOBKGkMKOpOJ1Drkr
         r/1E7j2yen3lZ54PycrnNn6PoprCmZi4Vi6qFvzRxV8G34QeRAUYEBL/Gz4U2Fm5n3hU
         G/hiab2mGiJ1UUPveGP6U9ADtJa5c+76bedQ5W66YNRu1h7EyJUCNSfzCJ4yLm8mzf1W
         o1ARCU3ZAdhxEbkra+kIE9u9buiF0WAJEQFs95qx6ljHk8l8yCFg2XUe/AcTM3rRtMpO
         lziHtWN8iZaakskSaW6h1WFZa4HaM8GWQNenqvOYgdNR0s+I0enO3iFclpZl4gKHHXLV
         g/jw==
X-Gm-Message-State: AOJu0Yy+DTawiR3JgPifLg4iZhZznlLlEMD397fM2OSHmB/PhE9ie25M
	0xXflRQ1AwlHMbqNLmEDe7q36soZ6F9Dfe7KKDetiOLgPcW0CsNvM67iAwhQSdU2yWNAJCwrizO
	1scoPai6Ka6vcY9DI8ttlDGWsv0OUOi2lQspHbB3auPxli35U/jYDZrqgqlDXAV7zhQFi/UrjCN
	0qN3gq+zfxboJFBTyqYONcTj+swAIBVv0W0Wu/FuvT9VA=
X-Google-Smtp-Source: AGHT+IFJRnQ83ttz5IZxiNzcWF87OdqmEuYc3wMh19wWZE0+e7hLOUX6rDQmIqYB8sf4aztyJmmEccl9/A==
X-Received: from pjpy17.prod.google.com ([2002:a17:90a:a411:b0:321:370d:cae5])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cd:b0:21f:4649:fd49
 with SMTP id d9443c01a7336-242c222b0abmr4455255ad.49.1754597829703; Thu, 07
 Aug 2025 13:17:09 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:17 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-22-sagis@google.com>
Subject: [PATCH v8 21/30] KVM: selftests: TDX: Verify the behavior when host
 consumes a TD private memory
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
2.51.0.rc0.155.g4a0f42376b-goog


