Return-Path: <linux-kselftest+bounces-17612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CB973BCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B3E1F27C37
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C2199FDB;
	Tue, 10 Sep 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="NUxEeE8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2008199929;
	Tue, 10 Sep 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981913; cv=none; b=BijlByHlLCH8dLRoy+BEaY5ybxXNXjtE1gxVyllWVFoYlwBNmEGTf1DBaeiBAEREGdgn+XqW0yj6XV/YG9WgyIHkS+luTPRN203KjkXMunoTiEQopJ2GGH8AKwTv6QiRjg2Zb6ICpcFwOswIXzOxr0LJB3Xf8xhPboAIKI3Hh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981913; c=relaxed/simple;
	bh=GMykZu9zJGf4fBCWBKK4YMIS2yhYXrut9F4hJMLGt9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJa0sjrMOD6SClJ+MjncIzu0fklBVekCVNL6FP5ldAQYAjrxPNjEFqqnU4MB0Lpi34dqY8Ozyd+aK6xPakyMGv2Hz7q1n6WKe8oi+iC/VGA0FXjWfvYRgXFZYLod8rjWoU5mGutnwI1lteP5LjUwD8BiG0FszxNNJPzX5tFug30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=NUxEeE8E; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981912; x=1757517912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VCZtCvHosy1tl36gR64QE1Z05bT4o2QPSCtwKVmrIoM=;
  b=NUxEeE8E09ltCPWkVmkmnWZTr1Hl6G+ALFusMZMcNYyPwbNHEP/LkcK4
   K5722EHNuinmzC8jH9eia9JTVh+K9UGP2E/c7gh+esMLFC0/lg5MjsUVp
   GzyPwYssKqLAFb602WFuZTFu4PlHQfdXcgMx/lkr/RQJap6iY5wDZppGP
   c=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="124219849"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:25:11 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:31177]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.80:2525] with esmtp (Farcaster)
 id 21c9d66f-c03c-4e6f-b416-01e7a52443d5; Tue, 10 Sep 2024 15:25:10 +0000 (UTC)
X-Farcaster-Flow-ID: 21c9d66f-c03c-4e6f-b416-01e7a52443d5
Received: from EX19D004EUA004.ant.amazon.com (10.252.50.183) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:10 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D004EUA004.ant.amazon.com (10.252.50.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:09 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:25:08 +0000
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
Subject: [PATCH 10/15] KVM: x86/mmu: Implement PWALK_STATUS_READ_ONLY_PTE_GPA in page walker
Date: Tue, 10 Sep 2024 15:22:02 +0000
Message-ID: <20240910152207.38974-11-nikwip@amazon.de>
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

Implement PWALK_STATUS_READ_ONLY_PTE_GPA in the page walker. This status
flag is set when setting an accessed or dirty bit fails, because the
memory of the page table entry was marked as read-only

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/mmu/paging_tmpl.h  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1c5aaf55c683..7ac1956f6f9b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -290,6 +290,8 @@ enum x86_intercept_stage;
 #define PWALK_FORCE_SET_ACCESSED	BIT(2)
 #define PWALK_SET_ALL	(PWALK_SET_ACCESSED | PWALK_SET_DIRTY)
 
+#define PWALK_STATUS_READ_ONLY_PTE_GPA BIT(0)
+
 /* apic attention bits */
 #define KVM_APIC_CHECK_VAPIC	0
 /*
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 985a19dda603..0eefa48e0e7f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -244,8 +244,11 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 		 * overwrite the read-only memory to set the accessed and dirty
 		 * bits.
 		 */
-		if (unlikely(!walker->pte_writable[level - 1]))
+		if (unlikely(!walker->pte_writable[level - 1])) {
+			if (status)
+				*status |= PWALK_STATUS_READ_ONLY_PTE_GPA;
 			continue;
+		}
 
 		ret = __try_cmpxchg_user(ptep_user, &orig_pte, pte, fault);
 		if (ret)
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


