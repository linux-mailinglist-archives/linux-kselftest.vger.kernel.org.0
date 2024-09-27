Return-Path: <linux-kselftest+bounces-18498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F29888EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C2528416F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82B1C1730;
	Fri, 27 Sep 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jjew5vEN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0518BC26;
	Fri, 27 Sep 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453848; cv=none; b=b5GEP+VojNOqI942MtIm5rsYadjUDDU221okCf3pt2S55nEUcdS8ul7iCjVtfdXct7qH0lOKw7+EKlaXwGnLao5f4TNyFpJl/NpJgh1PIH91zaoLmDxHXtsoGxEzcgKJcayBQQFCf4GKJu0SOF16LwsXKTrtqDBYlaKbjJrp6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453848; c=relaxed/simple;
	bh=bITM0Aeng2J6eq1p6hx8dT3atihTw0CutEtJW/1eOSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9ll2GHB6+MEuGKe0ai1gkZXKNu6FaXlm3sV6qY9iqgy2Pn6DX18vgiCD/hrttjvy02oCLqLikGhNDVBTgdT3quXOKxxRqi4v7MKmxbWJyL9rViMTZ7DYb4YJJSD5bLCWH9+LvuPu/tHaWZ4Xdf6OFLeeZQ8aatdifBc8e4qFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jjew5vEN; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727453847; x=1758989847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v/pCxVzGGt00J4HeXCQPyQbX0vz+zoWW8SfA60zWySw=;
  b=jjew5vENxA3E9TV4WkYMc6Xn069QMqTuqjL3cYUK4LnuofUv0CMYfMsu
   YYMmhtNE1TKDtYMsT/WPzqJ4VoVkFMDA80MgE6PjvbLBCIaiHpWaaciZE
   q3lkcyhey0IHWaXtFHRkdbYYF8PswhSYfGewn855c9plc9KTt15/dSBWI
   U=;
X-IronPort-AV: E=Sophos;i="6.11,159,1725321600"; 
   d="scan'208";a="335991852"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 16:17:10 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:14418]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.81:2525] with esmtp (Farcaster)
 id f6dd7ae9-f1d5-4b5e-bace-701045ca9ffd; Fri, 27 Sep 2024 16:17:08 +0000 (UTC)
X-Farcaster-Flow-ID: f6dd7ae9-f1d5-4b5e-bace-701045ca9ffd
Received: from EX19D031EUB001.ant.amazon.com (10.252.61.29) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:08 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D031EUB001.ant.amazon.com (10.252.61.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:08 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 27 Sep 2024 16:17:07 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id 854B8403DD;
	Fri, 27 Sep 2024 16:17:06 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <jalliste@amazon.com>, <nh-open-source@amazon.com>,
	<pdurrant@amazon.co.uk>
Subject: [PATCH 3/3] selftests: KVM: Add test case for MMIO during event delivery
Date: Fri, 27 Sep 2024 16:16:57 +0000
Message-ID: <20240927161657.68110-4-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240927161657.68110-1-iorlov@amazon.com>
References: <20240927161657.68110-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extend the 'set_memory_region_test' with a test case which covers the
MMIO during event delivery error handling. The test case

1) Tries to set an IDT descriptor base to point to an MMIO address
2) Generates a #GP
3) Verifies that we got a correct exit reason (KVM_EXIT_INTERNAL_ERROR)
   and suberror code (KVM_INTERNAL_ERROR_DELIVERY_EV)
4) Verifies that we got a corrent "faulty" GPA in internal.data[3]

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index a8267628e9ed..e9e97346edf1 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -553,6 +553,51 @@ static void test_add_overlapping_private_memory_regions(void)
 	close(memfd);
 	kvm_vm_free(vm);
 }
+
+static const struct desc_ptr faulty_idt_desc = {
+	.address = MEM_REGION_GPA,
+	.size = 0xFFF,
+};
+
+static void guest_code_faulty_idt_desc(void)
+{
+	__asm__ __volatile__("lidt %0"::"m"(faulty_idt_desc));
+
+	/* Generate a #GP by dereferencing a non-canonical address */
+	*((uint8_t *)0xDEADBEEFDEADBEEFULL) = 0x1;
+
+	/* We should never reach this point */
+	GUEST_ASSERT(0);
+}
+
+/*
+ * This test tries to point the IDT descriptor base to an MMIO address. This action
+ * should cause a KVM internal error, so the VMM could handle such situations gracefully.
+ */
+static void test_faulty_idt_desc(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	pr_info("Testing a faulty IDT descriptor pointing to an MMIO address\n");
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code_faulty_idt_desc);
+	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 1);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
+	TEST_ASSERT(vcpu->run->internal.suberror == KVM_INTERNAL_ERROR_DELIVERY_EV,
+		    "Unexpected suberror = %d", vcpu->run->internal.suberror);
+	TEST_ASSERT(vcpu->run->internal.ndata > 4, "Unexpected internal error data array size = %d",
+		    vcpu->run->internal.ndata);
+
+	/* The "faulty" GPA address should be = IDT base + offset of the GP vector */
+	TEST_ASSERT(vcpu->run->internal.data[3] == MEM_REGION_GPA +
+		    GP_VECTOR * sizeof(struct idt_entry),
+		    "Unexpected GPA = %llx", vcpu->run->internal.data[3]);
+
+	kvm_vm_free(vm);
+}
 #endif
 
 int main(int argc, char *argv[])
@@ -568,6 +613,7 @@ int main(int argc, char *argv[])
 	 * KVM_RUN fails with ENOEXEC or EFAULT.
 	 */
 	test_zero_memory_regions();
+	test_faulty_idt_desc();
 #endif
 
 	test_invalid_memory_region_flags();
-- 
2.43.0


