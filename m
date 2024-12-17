Return-Path: <linux-kselftest+bounces-23463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EF49F55DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95ED188AACE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746A11F893E;
	Tue, 17 Dec 2024 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kg3lP7/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925C1F8AEC;
	Tue, 17 Dec 2024 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459331; cv=none; b=qSE4KdURYSIfI/xtH4AijpoLO+AMv5lxzR6ydOulDa9yWS34w0q7eHpoVT7yBUKHHxIuqZV7qQcNrwQm5z39HJY6VSk9wcKx1ey3nypP4i3Ve2OWob2y2xabpOJx28m3wXfXWj4fl5paUCCD1EBy6qAe07gI0lKzW3PazzVbssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459331; c=relaxed/simple;
	bh=m06ZpDC3ycQiyX/+jlw0dUpUrcyKmws5uuBN48CVKV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF+u2pZsqfMy6FTUQ3za/OtOhA9OYwwrr0yXUNbZlgpfiqIrAqX4q4lT2JhGZfJjHOBkhdW00SA/9sCC0F6KEb+DOI1SWlSBvzkwehiGpNkrUMN6zHW60RuoUyhQaNDdX9/dn1eoA7BeoZ9EeaK9hVHV+EmLPIQpoL4mWTaBL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kg3lP7/Z; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459330; x=1765995330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/cIqhO28REfnE/vFnzIeOr5dRvBYI+ntt7bRR/bpmY=;
  b=kg3lP7/ZM7ZGkqJKMVT1OVhRLKPGTAOjMxsk3Hxf7miVHrLFwNi1Sd0H
   SLjgWyO8twxBkcq8fBEx1tP7pXF+G8D3R/Gqn6icMbIUkGLGv3FXHstTk
   uLfRx/RGZBvi+AVNwM43Ir0pcVNE8kzNNGEef932AqS5i/M2QANTmxsKs
   g=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="361530438"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:27 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:18585]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.88.227:2525] with esmtp (Farcaster)
 id 9034aab4-d5a5-48ae-aaf5-29c92cc03174; Tue, 17 Dec 2024 18:15:26 +0000 (UTC)
X-Farcaster-Flow-ID: 9034aab4-d5a5-48ae-aaf5-29c92cc03174
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:22 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:22 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 38EFFA0790;
	Tue, 17 Dec 2024 18:15:20 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 7/7] selftests: KVM: Add test case for MMIO during vectoring
Date: Tue, 17 Dec 2024 18:14:58 +0000
Message-ID: <20241217181458.68690-8-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
References: <20241217181458.68690-1-iorlov@amazon.com>
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
V2 -> V3:
- Move "NONCANONICAL" definition to the beginning of the file

 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/set_memory_region_test.c    | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 69938c649a5e..6b8d12f042a8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -29,6 +29,8 @@ extern uint64_t guest_tsc_khz;
 #define MAX_NR_CPUID_ENTRIES 100
 #endif
 
+#define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
+
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
 #define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
 
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


