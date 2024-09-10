Return-Path: <linux-kselftest+bounces-17604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A638973BA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE01C2488A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D01A01BD;
	Tue, 10 Sep 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="BRmN5oRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808F19ABC2;
	Tue, 10 Sep 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981779; cv=none; b=ZjVoIoeXYWPfHi6oPQD8SRTh1jR9EE3Ha3vtNdAYjoS/7Ri6nzErEBW4SK3+RrkRu6G9LmBoIjUGnHdMl8jFWFsZUYoAOZAlQ+DGtGHKF71Y1THadVuUeJVIzaIRZlRbEvX+wizJh5bDapNQwc7IGE5vk/nErXzjJLg9joYyktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981779; c=relaxed/simple;
	bh=yMxfmheIQpBLxXd+Jqe5Df1ZtrFux0QCDdvQ4dqCPek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX11BQWVvopI2azoSssMx/Kq6IxcTeTyV+/S7j3DiYqSKv0pfTG3xMB6B/+eGO/WtQRc18Kq9q8y5X/yTg6yiAMFyHvd1/1JIkopA+wCILmWpjLgvcpBBla1bzt2lQ33ynX5RisvnoNmZMvaYnNfZ0rwqPYfpc/LBoVPbkDxAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=BRmN5oRG; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981778; x=1757517778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+gUMvE9WBFIBh4Oxm0FXV+Z2DytGGJUGYHgLlrXem8=;
  b=BRmN5oRG21bNWgFzAyljmJ3VqajcZkyX5IKG42888u4blSLd1qDlJs5b
   7TCNmq1gVBnwwwQJzdj6S13LCeYuOxnyyoYAUBifvPpLmIXO6AA0wlyzp
   dqR3C7kId49wfSVHqHn+ztUyyc73ph5PjteQsQaTDD3s+zPQskcvxGZG4
   s=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="367263917"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:22:51 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:16832]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.162:2525] with esmtp (Farcaster)
 id 85ed7a91-53a7-4f38-8884-6546c53c5910; Tue, 10 Sep 2024 15:22:47 +0000 (UTC)
X-Farcaster-Flow-ID: 85ed7a91-53a7-4f38-8884-6546c53c5910
Received: from EX19D014EUC002.ant.amazon.com (10.252.51.161) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:46 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D014EUC002.ant.amazon.com (10.252.51.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:46 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:22:44 +0000
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
Subject: [PATCH 02/15] KVM: x86/mmu: Abort page walk if permission checks fail
Date: Tue, 10 Sep 2024 15:21:54 +0000
Message-ID: <20240910152207.38974-3-nikwip@amazon.de>
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

Abort the page walk, if permission checks fail on any page table level, by
moving the check to within the page walker loop. Currently, the page
walker only checks for access flags after successfully walking the entire
paging structure. This change is needed later to enable setting accessed
bits in each page table that was successfully visited, during a page walk
that ultimately failed.

As a result, error codes returned by the page walker may observe a change
in behaviour, specifically, the error code will be built as soon as an
access violation is found, meaning that for example, if an access
violation is detected on page level 4, the page walker will abort the walk
without looking at level 3 and below. However, since the error code
returned is built from the passed access requirements, regardless of the
actual cause of the failure, it will only be different if there is an
access violation in one level and a PKRU violation in a lower one.

Previously the error code would include this PKRU violation, whereas now
it does not, which is still in line with the behaviour specified in
Intel's SDM. The exact procedure to test for violations is currently not
specified in the SDM, but aborting the page walk early seems to be a
reasonable implementation detail. As KVM does not read the PK bit
anywhere, this only results in a different page-fault error codes for
guests.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ae7d39ff2d07..d9c3c78b3c14 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -422,6 +422,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto error;
 		}
 
+		/* Convert to ACC_*_MASK flags for struct guest_walker.  */
+		walker->pte_access = FNAME(gpte_access)(pte_access ^ walk_nx_mask);
+		errcode = permission_fault(vcpu, mmu, walker->pte_access, pte_pkey, access);
+		if (unlikely(errcode))
+			goto error;
+
 		walker->ptes[walker->level - 1] = pte;
 
 		/* Convert to ACC_*_MASK flags for struct guest_walker.  */
@@ -431,12 +437,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte_pkey = FNAME(gpte_pkeys)(vcpu, pte);
 	accessed_dirty = have_ad ? pte_access & PT_GUEST_ACCESSED_MASK : 0;
 
-	/* Convert to ACC_*_MASK flags for struct guest_walker.  */
-	walker->pte_access = FNAME(gpte_access)(pte_access ^ walk_nx_mask);
-	errcode = permission_fault(vcpu, mmu, walker->pte_access, pte_pkey, access);
-	if (unlikely(errcode))
-		goto error;
-
 	gfn = gpte_to_gfn_lvl(pte, walker->level);
 	gfn += (addr & PT_LVL_OFFSET_MASK(walker->level)) >> PAGE_SHIFT;
 
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


