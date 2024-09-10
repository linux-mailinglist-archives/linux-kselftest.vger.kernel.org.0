Return-Path: <linux-kselftest+bounces-17605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5675973BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86BD1C250FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EAA1A2563;
	Tue, 10 Sep 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="lqhhk/nq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BD1A0B1E;
	Tue, 10 Sep 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981790; cv=none; b=jlh9WN4hQrZZ6wFGMRlBn2UMCx8rwGFkAqJH+CNapTtF7BuKZjLTC0iln1yCwNTu2W1X9tYrU+Y/lYWjcLxUuyHY3vAAUm1vcRZXtiEQtrQH0EECO7PLbFoZTonPKkfyoDxwutOL42hHrit0MEJ8evXUf5GPoMSMKq3LvpsDBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981790; c=relaxed/simple;
	bh=itnc9gRgJy+e6+5K0E7HXZ5B4JuLftNx3P5bSoOBP7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUYLTETpHqkoFnj6eHUlp2D/PI6f9E7Iy6/AJHQSVW6EbRGtbsLKVKVYSRf5mslJpAlH6QHqqu5bNDVsnQ2wTazpJMkloRWRn5lPgIMdhbBz+kV07evj/9f2vHVxdfk7gQyNveBZD8k3q1isIa1wOl44mSddR+dVydvydAdJw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=lqhhk/nq; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981789; x=1757517789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Km2TrPXosr7uX6oYzMA+218QoXlL+9LaKCD4YvBno24=;
  b=lqhhk/nqiulfoDQJzCvbQHRjNTyIF7c9TfclsnWTEjph5b35oxkuKBVa
   al1AeL2UoZ+v9/6UPaDddgEE6w7kTPHlnV9M8OF5s+2AnKLOh2QZN6zTg
   L03kZYXuYHLtqW37vs8c5JxHAkn6WDN3ixLivfNtceFm2Kh1lQNDyJVyv
   U=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="124219001"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:23:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:55695]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id 418f5ccd-c6c8-424b-bda0-10b12e0c347f; Tue, 10 Sep 2024 15:23:06 +0000 (UTC)
X-Farcaster-Flow-ID: 418f5ccd-c6c8-424b-bda0-10b12e0c347f
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:05 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:23:02 +0000
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
Subject: [PATCH 03/15] KVM: x86/mmu: Introduce exception flag for unmapped GPAs
Date: Tue, 10 Sep 2024 15:21:55 +0000
Message-ID: <20240910152207.38974-4-nikwip@amazon.de>
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

Introduce a flag in x86_exception which signals that a page walk failed
because a page table GPA wasn't backed by a memslot. This only applies to
page tables; the final physical address is not checked.

This extra flag is needed, because the normal page fault error code does
not contain a bit to signal this kind of fault.

Used in subsequent patches to give userspace information about translation
failure.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/kvm_emulate.h     | 2 ++
 arch/x86/kvm/mmu/paging_tmpl.h | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd..afd8e86bc6af 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -27,6 +27,8 @@ struct x86_exception {
 	u64 address; /* cr2 or nested page fault gpa */
 	u8 async_page_fault;
 	unsigned long exit_qualification;
+#define KVM_X86_UNMAPPED_PTE_GPA	BIT(0)
+	u16 flags;
 };
 
 /*
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d9c3c78b3c14..f6a78b7cfca1 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -339,6 +339,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 #endif
 	walker->max_level = walker->level;
 
+	walker->fault.flags = 0;
+
 	/*
 	 * FIXME: on Intel processors, loads of the PDPTE registers for PAE paging
 	 * by the MOV to CR instruction are treated as reads and do not cause the
@@ -393,8 +395,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			return 0;
 
 		slot = kvm_vcpu_gfn_to_memslot(vcpu, gpa_to_gfn(real_gpa));
-		if (!kvm_is_visible_memslot(slot))
+		if (!kvm_is_visible_memslot(slot)) {
+			walker->fault.flags = KVM_X86_UNMAPPED_PTE_GPA;
 			goto error;
+		}
 
 		host_addr = gfn_to_hva_memslot_prot(slot, gpa_to_gfn(real_gpa),
 					    &walker->pte_writable[walker->level - 1]);
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


