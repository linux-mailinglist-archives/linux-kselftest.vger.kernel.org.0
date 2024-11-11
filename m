Return-Path: <linux-kselftest+bounces-21773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4289C3BEA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A91C217B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C01991CB;
	Mon, 11 Nov 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u0sz+tHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7E1974EA;
	Mon, 11 Nov 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320897; cv=none; b=GRhd7SDwu/8DL4xvVa207eANVCZI7nJgPEUcYHpQFu6/qdSQaFmzN9c8QMTL3lvhg0D89NmOu/ZK6pSXJFxtEY5w07MgcGzXD7/md6xugrYIUtZSE1BkfBo9frKb4FMejzcOHmdMvdc03WSoy2c+p9xfDVYL84cVLEgd9GrlvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320897; c=relaxed/simple;
	bh=n797KENeKcPht39qvTxwH1l7x2mQGbvAXrsEkK9O7tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P70TDOOh96ZUnWDRNf+ZzulkWO9+RKTCSPxn2B2H/Gy4VaBaRZvZOkVSPqnN2WvMb2SgXwv6VQzfJspuhZW+NTTIhZWDCf7yjjRzTdH+8zgwh4NVm5thG00jDrXPWg3W3+NVetac+0iVDgpbXLdntrAQliqVLkHR5cCn4OsaFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u0sz+tHH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320896; x=1762856896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzdWoNEEE0WCR0PGgVygWDKm9UBymLpK5xCN/dEO6dw=;
  b=u0sz+tHHc9tFvgGCUrAoP6Pv7qD/wFtJDYAspu71YI8DzXVr7cDIALzz
   8OWcNg/PkFd1ACkfXQmGvzDaJk6igbVZBzS+iAKFh0koY8Z4nyiDpG+KN
   vYCPFj8quAkRVsgqerYfo9K2LTr62OVUW7s9Rzc/h+/kIFyDIX/Kpf/ao
   8=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="351182686"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:13 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.0.204:10291]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.63:2525] with esmtp (Farcaster)
 id f0e955ec-5ede-4893-9ec9-faaa533e2b5d; Mon, 11 Nov 2024 10:28:11 +0000 (UTC)
X-Farcaster-Flow-ID: f0e955ec-5ede-4893-9ec9-faaa533e2b5d
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:10 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:10 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 5DF85A0227;
	Mon, 11 Nov 2024 10:28:08 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 6/6] selftests: KVM: Add test case for MMIO during vectoring
Date: Mon, 11 Nov 2024 10:27:49 +0000
Message-ID: <20241111102749.82761-7-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend the 'set_memory_region_test' with a test case which covers the
MMIO during vectoring error handling. The test case

1) Sets an IDT descriptor base to point to an MMIO address
2) Generates a #GP in the guest
3) Verifies that we got a correct exit reason and suberror code
4) Verifies that we got a corrent reported GPA in internal.data[3]

Also, add a definition of non-canonical address to processor.h

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Get rid of pronouns, redundant comments and incorrect wording
- Define noncanonical address in processor.h
- Fix indentation and wrap lines at 80 columns

 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/set_memory_region_test.c    | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 1a60c99b5833..997df5003edb 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1165,6 +1165,8 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 /* If a toddler were to say "abracadabra". */
 #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
 
+#define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
+
 /*
  * KVM selftest exception fixup uses registers to coordinate with the exception
  * handler, versus the kernel's in-memory tables and KVM-Unit-Tests's in-memory
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index a1c53cc854a5..d65a9f20aa1a 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -553,6 +553,56 @@ static void test_add_overlapping_private_memory_regions(void)
 	close(memfd);
 	kvm_vm_free(vm);
 }
+
+static void guest_code_mmio_during_vectoring(void)
+{
+	const struct desc_ptr idt_desc = {
+		.address = MEM_REGION_GPA,
+		.size = 0xFFF,
+	};
+
+	set_idt(&idt_desc);
+
+	/* Generate a #GP by dereferencing a non-canonical address */
+	*((uint8_t *)NONCANONICAL) = 0x1;
+
+	GUEST_ASSERT(0);
+}
+
+/*
+ * This test points the IDT descriptor base to an MMIO address. It should cause
+ * a KVM internal error when an event occurs in the guest.
+ */
+static void test_mmio_during_vectoring(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	u64 expected_gpa;
+
+	pr_info("Testing MMIO during vectoring error handling\n");
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_mmio_during_vectoring);
+	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 1);
+
+	run = vcpu->run;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
+	TEST_ASSERT(run->internal.suberror == KVM_INTERNAL_ERROR_DELIVERY_EV,
+		    "Unexpected suberror = %d", vcpu->run->internal.suberror);
+	TEST_ASSERT(run->internal.ndata != 4, "Unexpected internal error data array size = %d",
+		    run->internal.ndata);
+
+	/* The reported GPA should be IDT base + offset of the GP vector */
+	expected_gpa = MEM_REGION_GPA + GP_VECTOR * sizeof(struct idt_entry);
+
+	TEST_ASSERT(run->internal.data[3] == expected_gpa,
+		    "Unexpected GPA = %llx (expected %lx)",
+		    vcpu->run->internal.data[3], expected_gpa);
+
+	kvm_vm_free(vm);
+}
 #endif
 
 int main(int argc, char *argv[])
@@ -568,6 +618,7 @@ int main(int argc, char *argv[])
 	 * KVM_RUN fails with ENOEXEC or EFAULT.
 	 */
 	test_zero_memory_regions();
+	test_mmio_during_vectoring();
 #endif
 
 	test_invalid_memory_region_flags();
-- 
2.43.0


