Return-Path: <linux-kselftest+bounces-17610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E499973BBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425971F276C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA71A0AE1;
	Tue, 10 Sep 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XitRyemQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710681A0716;
	Tue, 10 Sep 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981885; cv=none; b=teiO/ipIqx2Yj6c/H4fmr3vzU3lHAXmjWL0X6Yga9JbSVE/nzC08bc2dNk5fau+u4J3GJIHyGHk5mb5pL1imXf4CuWZiifV38P03+5MHewknoTxxrxONiBYbF8VNeCC3qdCUp2GwOM0N069zwH4/g5ueW42gGy8OjMzgbbKrunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981885; c=relaxed/simple;
	bh=7a6wXYs7Dvqh9sEvoCjfKM7Bj1zaEgXTI4PJHU9blp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBzWLxnRCaQi3SlJs4hgCQlcZ85Lfnd9qCnGiNsMO1ssbeeOH6FDEmg89BDVD8RAOfLBYkNeHdKq7P8CrjiTgiQV0s5LRL3sq2g8R/qXTT9yxbwXlc5u0RjnUlvErYtf/JfiK9/BSQIII95LwbnBBiOTZyjcp+vLlreDWivis5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=XitRyemQ; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981883; x=1757517883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ea1U7mANR28aq/cO/4aNKTr6fML6fTywEfVWSHI4Vxk=;
  b=XitRyemQQx8qE7h0w79c73PswjYefiHQwxai2fTZrsi7L/y1U1+sk2Z7
   P5KPHVklf/iLHkJnPYV0kgZ36Q3THKkPKnTel/kVDkTinI/8ddjS05ULf
   dRlAeMVwkZ5Io5emYtgI/6Tq2No+hw5Z4DtCOY/R+pd/2GDxYLBXzhhxW
   s=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="426771577"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:24:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:38133]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.27:2525] with esmtp (Farcaster)
 id 437da87e-5527-4cc1-addb-da9ba89e99c0; Tue, 10 Sep 2024 15:24:39 +0000 (UTC)
X-Farcaster-Flow-ID: 437da87e-5527-4cc1-addb-da9ba89e99c0
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:34 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:24:32 +0000
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
Subject: [PATCH 08/15] KVM: x86/mmu: Implement PWALK_FORCE_SET_ACCESSED in page walker
Date: Tue, 10 Sep 2024 15:22:00 +0000
Message-ID: <20240910152207.38974-9-nikwip@amazon.de>
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

Implement PWALK_FORCE_SET_ACCESSED in the page walker. This flag forces
the page walker to set the accessed flag in all successfully visited page
table levels, regardless of the outcome of the page walk.

For example, if the page walk fails on level 2, the accessed bit will
still be set on levels 3 and up.

If the nested translations of GPAs fail, the bits will still be set.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3acf0b069693..cd2c391d6a24 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -287,6 +287,7 @@ enum x86_intercept_stage;
 
 #define PWALK_SET_ACCESSED	BIT(0)
 #define PWALK_SET_DIRTY	BIT(1)
+#define PWALK_FORCE_SET_ACCESSED	BIT(2)
 #define PWALK_SET_ALL	(PWALK_SET_ACCESSED | PWALK_SET_DIRTY)
 
 /* apic attention bits */
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index b6897f7fbf52..2cc40fd17f53 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -319,6 +319,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	const int fetch_fault = access & PFERR_FETCH_MASK;
 	const int set_accessed = flags & PWALK_SET_ACCESSED;
 	const int set_dirty = flags & PWALK_SET_DIRTY;
+	const int force_set = flags & PWALK_FORCE_SET_ACCESSED;
 	u16 errcode = 0;
 	gpa_t real_gpa;
 	gfn_t gfn;
@@ -395,7 +396,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * fields.
 		 */
 		if (unlikely(real_gpa == INVALID_GPA))
-			return 0;
+			goto late_exit;
 
 		slot = kvm_vcpu_gfn_to_memslot(vcpu, gpa_to_gfn(real_gpa));
 		if (!kvm_is_visible_memslot(slot)) {
@@ -455,7 +456,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access,
 								 flags, &walker->fault);
 	if (real_gpa == INVALID_GPA)
-		return 0;
+		goto late_exit;
 
 	walker->gfn = real_gpa >> PAGE_SHIFT;
 
@@ -528,6 +529,18 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->fault.async_page_fault = false;
 
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
+
+late_exit:
+	if (force_set) {
+		/*
+		 * Don't set the accessed bit for the page table that caused the
+		 * walk to fail.
+		 */
+		++walker->level;
+		FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
+		 false);
+		--walker->level;
+	}
 	return 0;
 }
 
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


