Return-Path: <linux-kselftest+bounces-17608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C96973BB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF51B22AA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A060519FA6B;
	Tue, 10 Sep 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ksa0qUrs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40919D88C;
	Tue, 10 Sep 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981845; cv=none; b=dWgHc4N+dBhwnKPpt4GweX7w8hG+nBc2NiO/P1RVzo5kBcta8GKPMRi4feHDapkHWH4GsxBJNfpOgIQ/vjZSwDxMOA+09Z7jmDgszSy4wE8GJ5j1BWEbF3XM+ospKEPI/zcVo6sA4xe6EUBTNKbLIpbhbfgZ5DhG1cF64VpV3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981845; c=relaxed/simple;
	bh=znXdsF6eiqKY2HvO6RXCANRQmaZ2fD/Ui+naRYeu3bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVdPJt9ly1xvsdJZ+TOXoyhMshZZOvIvSjjDNbcJZD+UT+PE+w5doISYhnBc8PDBqfFam5Coq8jTI+JM5R/YfeVu43aCkCGEoeIwKjnNkoxbVKDKPx5PRMKN0qdhQTYX2u8f3gxZ4VAp6yVzfNcDOw8zmjAaPEvok8AhQEZ6f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Ksa0qUrs; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981845; x=1757517845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7Ctjd+6veeZS5KO0mrV/5F4c28Jr+9mluYJ7cdyklU=;
  b=Ksa0qUrs2ixXjwU4sSoYCa/o5uFqyt//cZkM1LkhVsKAyI1XZKkYvBmo
   MEHy3K1e7gWafhv4P/TyurtW3dESIBVA35xzi4RWRuWp2zThrsalF3H8C
   inQ/IHBSqKkSnJgzGbJ7U+qbruAMJF+VHdew7x34r2t0TUUZNXdefk0Vk
   w=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="658004108"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:24:01 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:63064]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.67:2525] with esmtp (Farcaster)
 id 3e155601-fb36-42be-a9bf-a8884a254509; Tue, 10 Sep 2024 15:23:58 +0000 (UTC)
X-Farcaster-Flow-ID: 3e155601-fb36-42be-a9bf-a8884a254509
Received: from EX19D014EUA004.ant.amazon.com (10.252.50.41) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:58 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D014EUA004.ant.amazon.com (10.252.50.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:23:58 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:23:56 +0000
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
Subject: [PATCH 06/15] KVM: x86/mmu: Implement PWALK_SET_ACCESSED in page walker
Date: Tue, 10 Sep 2024 15:21:58 +0000
Message-ID: <20240910152207.38974-7-nikwip@amazon.de>
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

Implement PWALK_SET_ACCESSED in the page walker. This flag allows
controling whether the page walker will set the accessed bits after a
successful page walk in all page table levels. If the page walk is aborted
for any reason, none of the access bits are set.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c278b83b023f..eed6e2c653ba 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -317,6 +317,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	const int write_fault = access & PFERR_WRITE_MASK;
 	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
+	const int set_accessed = flags & PWALK_SET_ACCESSED;
 	u16 errcode = 0;
 	gpa_t real_gpa;
 	gfn_t gfn;
@@ -468,7 +469,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		accessed_dirty &= pte >>
 			(PT_GUEST_DIRTY_SHIFT - PT_GUEST_ACCESSED_SHIFT);
 
-	if (unlikely(!accessed_dirty)) {
+	if (unlikely(set_accessed && !accessed_dirty)) {
 		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
 							write_fault);
 		if (unlikely(ret < 0))
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


