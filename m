Return-Path: <linux-kselftest+bounces-30021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2485A792AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1281710B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3918D65E;
	Wed,  2 Apr 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ma0mDsD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AC186E54;
	Wed,  2 Apr 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610107; cv=none; b=LlUYacDgM3XVs4fn9uLVsiHk+8VGegqM5wiKBVgiGp5Z22Xo451zAj57afa9QrtSjmV/KpUnF3M4XlpR3ZLWJ4uCeLHhuoHiraAD1oYWCvMgU/O3HgS7rvMwtmkKwmbpgSKMJau9ddwlDHKoa6fg7P30MoGJkRp960KjLRxVZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610107; c=relaxed/simple;
	bh=L2eJ9dyKowSVILlslW8p6owpdPfPJCZP2lxzSlEEm4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It5f3Danfy+iX/3MrWbGYuuqB4nw0h7hlkF/qeljSFm4iRDXfL7e99yQ/RRqfnnCjAGEzim6fCMXo1pnzSVSPfTTn4uBxM7e6FuFB+gLTNOLxmpEUT9pcrQYdnM1l9iY6RxYSml98/nwP52Go8zkr7ulIj8jalaRXL0RGsZXfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ma0mDsD7; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743610105; x=1775146105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c1vC5PQObwSRnrwFndUeVO1NivEsO2o9+Qe0hvf7HYM=;
  b=Ma0mDsD7J1SmHIg8ihn/KS02F8tLHW2CpaSR9jwbstl4pwuo/cogcYpA
   nOeO255jenoQbO6WtEv4dWiqON+cAlg08Yu1maV9XqlvQXpTXrVg2zZWz
   j2AxQrY91rvPU8UUJBAg/OVsOok4vKVVIEBNQ+E5+rimmblQV4eRKAEfL
   s=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="392250945"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:08:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:33674]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.46:2525] with esmtp (Farcaster)
 id 8b5e1693-98e0-4752-bfa2-b66a2ae4dca2; Wed, 2 Apr 2025 16:08:19 +0000 (UTC)
X-Farcaster-Flow-ID: 8b5e1693-98e0-4752-bfa2-b66a2ae4dca2
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:08:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:08:02 +0000
Received: from email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:08:02 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com (Postfix) with ESMTPS id 84EFE42240;
	Wed,  2 Apr 2025 16:08:00 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [PATCH v2 3/5] mm: userfaultfd: allow to register continue for guest_memfd
Date: Wed, 2 Apr 2025 16:07:19 +0000
Message-ID: <20250402160721.97596-4-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402160721.97596-1-kalyazin@amazon.com>
References: <20250402160721.97596-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/userfaultfd_k.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d144..bc184edfbb85 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -212,6 +212,10 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
+#endif
+
 static inline bool vma_can_userfault(struct vm_area_struct *vma,
 				     unsigned long vm_flags,
 				     bool wp_async)
@@ -222,7 +226,11 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 		return false;
 
 	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma))
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	     && !kvm_gmem_vma_is_gmem(vma)
+#endif
+	    )
 		return false;
 
 	/*
@@ -244,6 +252,9 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 
 	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	    kvm_gmem_vma_is_gmem(vma) ||
+#endif
 	    vma_is_shmem(vma);
 }
 
-- 
2.47.1


