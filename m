Return-Path: <linux-kselftest+bounces-17606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FE973BAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0458A1C25161
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CA196D9A;
	Tue, 10 Sep 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="onwNz2cR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EE1925B4;
	Tue, 10 Sep 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981806; cv=none; b=jpftpejVLo5GCE5Ueq0ADyVSsQH9o5l3ippgErO52WvQecf20ayfPURvrP1qXq73xStPNTJY1WTz1iPLhnqOXWNLeyx265Man8Bdj4Dl+VcSacx6/TZy7WKgcVlDEncYU+mdYqmM5maYhSahFVO2GWs8O6bDNtY6plOvHS3ZeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981806; c=relaxed/simple;
	bh=QE2bk34erymW2ZNrDHe69rw53PQY4qTok1UkFXnEhLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgLoMfsQV61tH5Qaj610+NtJ5f3Ma83sXHXVIRTm4B13OuAuvNJB3LL7B/CXIdkQK+5e6EL4sBAHqym0t0KztoVnKiL1aHcCrTMYsiGB3HFPIv41C8RNOEoLpfE67/drzbY2yEZujib+ogFau599dbEc7lE1+II/hToUyAwqm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=onwNz2cR; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981805; x=1757517805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lz3T3yEcwSJRvadrpSBViYV6gSG8fKxfLSa5nbTuxyw=;
  b=onwNz2cRBMgtvZJoje0nbsyFiSjF8l2Wmr1GnLA2+WmEQGkUb0+311SF
   gaJ4K1gXw5pwCKBrEEGJGZbQJFHNd4ePtGf4Q45msPOaTJyudtVqLJ+ZV
   3nVkbKaFdX4q6ffNuzRwtRAO56CVtfXoqo2CNrH8lTuXNZa7pWcar6ow4
   s=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="758470419"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:23:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:25293]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.205:2525] with esmtp (Farcaster)
 id 36754a66-9e06-49ef-ae03-a1478e3cf7ea; Tue, 10 Sep 2024 15:23:23 +0000 (UTC)
X-Farcaster-Flow-ID: 36754a66-9e06-49ef-ae03-a1478e3cf7ea
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:23 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:22 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:23:21 +0000
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
Subject: [PATCH 04/15] KVM: x86/mmu: Store GPA in exception if applicable
Date: Tue, 10 Sep 2024 15:21:56 +0000
Message-ID: <20240910152207.38974-5-nikwip@amazon.de>
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

Store the GPA where the page walk failed within the walker's exception.
Precisely this means, the PTE's GPA, if it couldn't be resolved or it
caused an access violation, or the fully translated GPA in case the final
page caused an access violation.

Returning the GPA from the page walker directly is not possible, because
other code within KVM relies on INVALID_GPA being returned on failure.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/kvm_emulate.h     | 6 ++++++
 arch/x86/kvm/mmu/paging_tmpl.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index afd8e86bc6af..6501ce1c76fd 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -25,6 +25,12 @@ struct x86_exception {
 	u16 error_code;
 	bool nested_page_fault;
 	u64 address; /* cr2 or nested page fault gpa */
+	/*
+	 * If error_code is a page fault, this will be the address of the last
+	 * visited page table, or the fully translated address if it caused the
+	 * failure. Otherwise, it will not hold a meaningful value.
+	 */
+	u64 gpa_page_fault;
 	u8 async_page_fault;
 	unsigned long exit_qualification;
 #define KVM_X86_UNMAPPED_PTE_GPA	BIT(0)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index f6a78b7cfca1..74651b097fa0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -485,6 +485,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->fault.vector = PF_VECTOR;
 	walker->fault.error_code_valid = true;
 	walker->fault.error_code = errcode;
+	walker->fault.gpa_page_fault = real_gpa;
 
 #if PTTYPE == PTTYPE_EPT
 	/*
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


