Return-Path: <linux-kselftest+bounces-17609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAF973BB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C86288A74
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8623E19DF44;
	Tue, 10 Sep 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="McST4tjY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1119923A;
	Tue, 10 Sep 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981863; cv=none; b=Mv3vxo+W2NM6jl1SF7pBZGaboRPnTL9IZWKtZ/WQLT1QcirWTODkUzFsh2YHtVG51s7Cdz59WcWdBxq/+5z7y5tuvGKTX6vefQDbgW+8U0GJGy8YtuysPZgoYAt1IhtJY1RHyds385B7zW2uAuDt7kCE5pxd3aARkbQeAMhRsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981863; c=relaxed/simple;
	bh=POQ8kozreKNtgbjSembbt5PYvEATBNIM8q9Rfx3n8fY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHXSbcQkbxcsdwYarqCf0l7E9W4dGX5XL656bFj43ffPMRUdyLqcVyLQU4B5aETSpmtXmhlslUgNk6GWm5KYQK5v25uGokru+NV5Px+YRDfe9fNzr2+XY7PokxjcRV/rsK36ZN1Ab8OALjkwQg6Gf3SlIFvn/dWcYETtCMWVKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=McST4tjY; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981862; x=1757517862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3HArsw7M4ipywp4YAC24VV8yFEbuXaMw9heDyfTkF5M=;
  b=McST4tjY70U7io27HNx5d7mYs+NDWjmHR8ThlOB4cNENgRfYmN15laco
   EMNUxNfRYyqGq+oPwagw8dmGMusJB9LfJ7jec9+q4y4BGy2waBUZoe27j
   B3pWxIcDp6xZXIFAqu+BJbDBsOmTNWsbSp1bZtUbBf101q0EE5ooiGJGE
   s=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="432460269"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:24:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:47925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id be656b80-426d-46ed-a1f5-9204a4d60b53; Tue, 10 Sep 2024 15:24:16 +0000 (UTC)
X-Farcaster-Flow-ID: be656b80-426d-46ed-a1f5-9204a4d60b53
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:16 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:24:15 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:24:14 +0000
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
Subject: [PATCH 07/15] KVM: x86/mmu: Implement PWALK_SET_DIRTY in page walker
Date: Tue, 10 Sep 2024 15:21:59 +0000
Message-ID: <20240910152207.38974-8-nikwip@amazon.de>
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

Implement PWALK_SET_DIRTY in the page walker. This flag allows controlling,
whether the page walker will set the dirty bit after a successful page
walk. If the page walk fails for any reason, the dirty flag is not set.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index eed6e2c653ba..b6897f7fbf52 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -318,6 +318,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
 	const int set_accessed = flags & PWALK_SET_ACCESSED;
+	const int set_dirty = flags & PWALK_SET_DIRTY;
 	u16 errcode = 0;
 	gpa_t real_gpa;
 	gfn_t gfn;
@@ -471,7 +472,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	if (unlikely(set_accessed && !accessed_dirty)) {
 		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker, addr,
-							write_fault);
+							write_fault && set_dirty);
 		if (unlikely(ret < 0))
 			goto error;
 		else if (ret)
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


