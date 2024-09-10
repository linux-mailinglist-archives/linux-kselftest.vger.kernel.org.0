Return-Path: <linux-kselftest+bounces-17603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20680973B9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E261C251AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2617319EEC9;
	Tue, 10 Sep 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="R5vVlrEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4819ABB6;
	Tue, 10 Sep 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981758; cv=none; b=SD/N8Jo+8sf+4HmrB23QBwO/WLbUbKWmz7eU314EOZ/9zE8YPNrUKLQL5L+es8zPCjwbfDs8HprMiez/9hUKyvzLuIwerflpzHf1ZQaVohuVaoQ3mcGROglirozDDRHFAAFVwj/zp5ASZPHcHVgVVQ8uqcAuFLOJZtsful2Ts4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981758; c=relaxed/simple;
	bh=B/K2QUnoSkS4ZvGZwey8z+/mNvJkvwtcoAo//x+7GQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b22ptN2yPgFW2DaX+/ty6xrKgrUmloCnRdNji1zUmSqdo6pYgQBNNvKgDt7p60nOZBWF+muQBiP3y2n6v2hjXbyFbo3g2mJ+BkuTbkmaWS1ZzOCMZMMjy0bzgkSXBJnIJoof5/FZTGWigVYFJxTrfzFd5WZID8ZHh600f3VWUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=R5vVlrEn; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981756; x=1757517756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NC1az9/hAILYnJFLiqNcORpyqC2hQx+wOpC0bECqtHU=;
  b=R5vVlrEn453Ei4Y5fhEsyz3AEMyiFQg5oo9Bl8vpN2zvo+EJKj/gaiZF
   yUmAhTMdZA2jGNJM1OFZFfXw2PjE1qR2uYW104UEYOBhEPc3eSMDt/XdP
   /fxRr0X4zCsqVeW54Jx7EaZCLqSf2fF3NjonaUfJOKEgU799xI31VMeWO
   U=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="230917179"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:22:32 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:48425]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.162:2525] with esmtp (Farcaster)
 id 56079a0b-55b2-49ad-8775-ef55f4079c09; Tue, 10 Sep 2024 15:22:30 +0000 (UTC)
X-Farcaster-Flow-ID: 56079a0b-55b2-49ad-8775-ef55f4079c09
Received: from EX19D041EUB004.ant.amazon.com (10.252.61.113) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:29 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D041EUB004.ant.amazon.com (10.252.61.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:28 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:22:27 +0000
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
Subject: [PATCH 01/15] KVM: Add API documentation for KVM_TRANSLATE2
Date: Tue, 10 Sep 2024 15:21:53 +0000
Message-ID: <20240910152207.38974-2-nikwip@amazon.de>
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

Add API documentation for the new KVM_TRANSLATE2 ioctl.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 Documentation/virt/kvm/api.rst | 131 +++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a4b7dc4a9dda..632dc591badf 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6442,6 +6442,137 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_TRANSLATE2
+--------------------
+
+:Capability: KVM_CAP_TRANSLATE2
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_translation2 (in/out)
+:Returns: 0 on success, <0 on error
+
+KVM_TRANSLATE2 translates a guest virtual address into a guest physical one
+while probing for requested access permissions and allowing for control over
+whether accessed and dirty bits are set in each of the page map levels
+structure. If the page walk fails, it provides detailed information explaining
+the reason for the failure.
+
+::
+
+  /* for KVM_TRANSLATE2 */
+  struct kvm_translation2 {
+      /* in */
+      __u64 linear_address;
+  #define KVM_TRANSLATE_FLAGS_SET_ACCESSED	(1 << 0)
+  #define KVM_TRANSLATE_FLAGS_SET_DIRTY	(1 << 1)
+  #define KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED	(1 << 2)
+      __u16 flags;
+  #define KVM_TRANSLATE_ACCESS_WRITE	(1 << 0)
+  #define KVM_TRANSLATE_ACCESS_USER	(1 << 1)
+  #define KVM_TRANSLATE_ACCESS_EXEC	(1 << 2)
+  #define KVM_TRANSLATE_ACCESS_ALL      \
+      (KVM_TRANSLATE_ACCESS_WRITE | \
+      KVM_TRANSLATE_ACCESS_USER |   \
+      KVM_TRANSLATE_ACCESS_EXEC)
+      __u16 access;
+      __u8  padding[4];
+
+      /* out */
+      __u64 physical_address;
+      __u8  valid;
+  #define KVM_TRANSLATE_FAULT_NOT_PRESENT	1
+  #define KVM_TRANSLATE_FAULT_PRIVILEGE_VIOLATION	2
+  #define KVM_TRANSLATE_FAULT_RESERVED_BITS	3
+  #define KVM_TRANSLATE_FAULT_INVALID_GVA	4
+  #define KVM_TRANSLATE_FAULT_INVALID_GPA	5
+      __u16 error_code;
+      __u8  set_bits_succeeded;
+      __u8  padding2[4];
+  };
+
+If the page walk succeeds, `physical_address` will contain the result of the
+page walk, `valid` will be set to 1 and `error_code` will not contain any
+meaningful value.
+
+If the page walk fails, `valid` will be set to 0 and `error_code` will contain
+the reason of the walk failure. `physical_address` may contain the physical
+address of the page table where the page walk was aborted, depending on the
+returned error code:
+
+.. csv-table::
+  :header: "`error_code`", "`physical_address`"
+
+  "KVM_TRANSLATE_FAULT_NOT_PRESENT", "Physical address of the page table entry without the present bit"
+  "KVM_TRANSLATE_FAULT_PRIVILEGE_VIOLATION", "Physical address of the page table entry where access checks failed"
+  "KVM_TRANSLATE_FAULT_RESERVED_BITS", "Physical address of the page table entry with reserved bits set"
+  "KVM_TRANSLATE_FAULT_INVALID_GPA", "Physical address that wasn't backed by host memory"
+  "KVM_TRANSLATE_FAULT_INVALID_GVA", "empty",
+
+The `flags` field can take each of these flags:
+
+KVM_TRANSLATE_FLAGS_SET_ACCESSED
+  Sets the accessed bit on each page table level on a successful page walk.
+
+KVM_TRANSLATE_FLAGS_SET_DIRTY
+  Sets the dirty bit on each page table level on a successful page walk.
+
+KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED
+  Forces setting the accessed bit on every page table level that was walked
+  successfully on failed page walks.
+
+.. warning::
+
+     Setting these flags and then using the translated address may lead to a
+     race, if another vCPU remotely flushes the local vCPUs TLB while the
+     address is still in use. This can be mitigated by stalling such TLB flushes
+     until the memory operation is finished.
+
+The `access` field can take each of these flags:
+
+KVM_TRANSLATE_ACCESS_WRITE
+  The page walker will check for write access on every page table.
+
+KVM_TRANSLATE_ACCESS_USER
+  The page walker will check for user mode access on every page table.
+
+KVM_TRANSLATE_ACCESS_EXEC
+  The page walker will check for executable/fetch access on every page table.
+
+If none of these flags are set, read access and kernel mode permissions are
+implied.
+
+The `error_code` field can take one of these values:
+
+KVM_TRANSLATE_FAULT_NOT_PRESENT
+  The virtual address is not mapped to any physical address.
+
+KVM_TRANSLATE_FAULT_PRIVILEGE_VIOLATION
+  One of the access checks failed during the page walk.
+
+KVM_TRANSLATE_FAULT_RESERVED_BITS
+  Reserved bits were set in a page table.
+
+KVM_TRANSLATE_FAULT_INVALID_GPA
+  One of the guest page table entries' addresses along the page walk was not
+  backed by a host memory.
+
+KVM_TRANSLATE_FAULT_INVALID_GVA
+  The GVA provided is not valid in the current vCPU state. For example, if on
+  32-bit systems, the virtual address provided was larger than 32-bits, or on
+  64-bit x86 systems, the virtual address was non-canonical.
+
+Regardless of the success of the page walk, `set_bits_succeeded` will contain a
+boolean value indicating whether the accessed/dirty bits were set. It may be
+false, if the bits were not set, because the page walk failed and
+KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED was not passed, or if there was an error
+setting the bits, for example, the host memory backing the page table entry was
+marked read-only.
+
+KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED and KVM_TRANSLATE_FLAGS_SET_DIRTY must
+never be passed without KVM_TRANSLATE_FLAGS_SET_ACCESSED.
+KVM_TRANSLATE_FLAGS_SET_DIRTY must never be passed without
+KVM_TRANSLATE_ACCESS_WRITE. Doing either will cause the ioctl to fail with exit
+code -EINVAL.
 
 5. The kvm_run structure
 ========================
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


