Return-Path: <linux-kselftest+bounces-17614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AB973BD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295351C25F58
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231319E83D;
	Tue, 10 Sep 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="EO7w9DT+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346BB19ABBB;
	Tue, 10 Sep 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981958; cv=none; b=Let1by3GakUuI/aZvckDlA50mpX5MxJl5cZEoB0h/oITS8Fisg2anokVI0vRKI5JuGmI9YQxFHxLh0eAYGssUSF0T0QBi43VtyWPDtW4EM5x0YAKE8YGr8NllIIzMQ091VijxO85hyY3fhnQniVHqDS82lqJmGFFBt+Nz+fShVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981958; c=relaxed/simple;
	bh=9hr/0kawES/adepKkQ9yHHYMngxIVaVfaZIR1M8p5u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuFND5G1DTSHM3iYUNSr0q0KKz3WRnkagimTOzn2+BnD7vpvWt8JG7SjpYaEyiFPEJ0jU+qTjo9I8IYe6/Ju77XdUeqykRyrmDrbQH+BkzmZJs3WuAnmrtjHOp2OSLEbbgUFO92z449+ZNeh0gHcYQuKjbbp8GFhDQ9tZuQ1MFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=EO7w9DT+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981957; x=1757517957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHvBgv0Npw60N9xHTv3fpyMvYJu/4r16iS7NVuI/vEA=;
  b=EO7w9DT+4/auSp7v7nsiCLqBKiphLJMGCi7IcockpSDp7gwb1V0zxl34
   kWQG7PKLaDKyx+fGt1CAEbNdVo00D1ifxKt5O9R6mL122h1zAABB2hY/+
   /EjRgZv2f2mrbBWrVQS62wqbcrUgGqwghJc70Ng8btBFZqg0zpt5KqJna
   E=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="124582879"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:25:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62383]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id ed13ad4c-99ab-45f6-a219-529a4081f79b; Tue, 10 Sep 2024 15:25:54 +0000 (UTC)
X-Farcaster-Flow-ID: ed13ad4c-99ab-45f6-a219-529a4081f79b
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:47 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:25:44 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 12/15] KVM: Introduce KVM_TRANSLATE2
Date: Tue, 10 Sep 2024 15:22:04 +0000
Message-ID: <20240910152207.38974-13-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a new ioctl that extends the functionality of KVM_TRANSLATE. It
allows the caller to specify an access mode that must be upheld throughout
the entire page walk. Additionally, it provides control over whether the
accessed/dirty bits in the page table should be set at all, and whether
they should be set if the walk fails. Lastly, if the page walk fails, it
returns the exact error code which caused the failure.

KVM_TRANSLATE lacks information about executability of the translated page
and doesn't provide control over the accessed/dirty page table bits at
all. Because it lacks any sort of input flags, it cannot simply be
expanded without breaking backwards compatibility. Additionally, in the
x86 implementation the 'writable' and 'usermode' are currently hardcoded
to 1 and 0 respectively, which is behaviour that might be relied upon.

The ioctl will be implemented for x86 in following commits.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 include/linux/kvm_host.h |  4 ++++
 include/uapi/linux/kvm.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b23c6d48392f..c78017fd2907 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -84,6 +84,10 @@
 #define KVM_MAX_NR_ADDRESS_SPACES	1
 #endif
 
+#define KVM_TRANSLATE_FLAGS_ALL                \
+	(KVM_TRANSLATE_FLAGS_SET_ACCESSED |     \
+	KVM_TRANSLATE_FLAGS_SET_DIRTY |         \
+	KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED)
 /*
  * For the normal pfn, the highest 12 bits should be zero,
  * so we can mask bit 62 ~ bit 52  to indicate the error pfn,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..602323e734cc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -512,6 +512,37 @@ struct kvm_translation {
 	__u8  pad[5];
 };
 
+/* for KVM_TRANSLATE2 */
+struct kvm_translation2 {
+	/* in */
+	__u64 linear_address;
+#define KVM_TRANSLATE_FLAGS_SET_ACCESSED	(1 << 0)
+#define KVM_TRANSLATE_FLAGS_SET_DIRTY	(1 << 1)
+#define KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED	(1 << 2)
+	__u16 flags;
+#define KVM_TRANSLATE_ACCESS_WRITE	(1 << 0)
+#define KVM_TRANSLATE_ACCESS_USER	(1 << 1)
+#define KVM_TRANSLATE_ACCESS_EXEC	(1 << 2)
+#define KVM_TRANSLATE_ACCESS_ALL      \
+	(KVM_TRANSLATE_ACCESS_WRITE | \
+	KVM_TRANSLATE_ACCESS_USER |   \
+	KVM_TRANSLATE_ACCESS_EXEC)
+	__u16 access;
+	__u8  padding[4];
+
+	/* out */
+	__u64 physical_address;
+	__u8  valid;
+#define KVM_TRANSLATE_FAULT_NOT_PRESENT	1
+#define KVM_TRANSLATE_FAULT_PRIVILEGE_VIOLATION	2
+#define KVM_TRANSLATE_FAULT_RESERVED_BITS	3
+#define KVM_TRANSLATE_FAULT_INVALID_GVA	4
+#define KVM_TRANSLATE_FAULT_INVALID_GPA	5
+	__u16 error_code;
+	__u8  set_bits_succeeded;
+	__u8  padding2[4];
+};
+
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
 	/* in */
@@ -933,6 +964,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_TRANSLATE2 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1269,6 +1301,7 @@ struct kvm_vfio_spapr_tce {
 #define KVM_SET_SREGS             _IOW(KVMIO,  0x84, struct kvm_sregs)
 #define KVM_TRANSLATE             _IOWR(KVMIO, 0x85, struct kvm_translation)
 #define KVM_INTERRUPT             _IOW(KVMIO,  0x86, struct kvm_interrupt)
+#define KVM_TRANSLATE2            _IOWR(KVMIO, 0x87, struct kvm_translation2)
 #define KVM_GET_MSRS              _IOWR(KVMIO, 0x88, struct kvm_msrs)
 #define KVM_SET_MSRS              _IOW(KVMIO,  0x89, struct kvm_msrs)
 #define KVM_SET_CPUID             _IOW(KVMIO,  0x8a, struct kvm_cpuid)
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


