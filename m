Return-Path: <linux-kselftest+bounces-28055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA5A4C1F9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9850017299A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19B2144D3;
	Mon,  3 Mar 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VzsappMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E42144D1;
	Mon,  3 Mar 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008659; cv=none; b=GJAaFqzhmviQ2/0dPoEmiEvqXUIdNDGnch+Y2tuAppz7SqHfeDFtb9tfLq03rpC2siYWzR2BcafV2D2o2neRxEyKIneIVZD4yRDAYqll52naNKllaGlIl5z5Vt2H4CoZJz+/qvRZaqbPImaUmNWe/SDJUqtPO6nK0MeBAT5DVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008659; c=relaxed/simple;
	bh=1EbjAiaSwLMHWFntE6x8Us7e5Tuslulew517JKZampo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcY0Pm+0bx9hMJp0wLibbf+F59aVv6cETerJygaT7egXke9Ky7UUIPhm2FTLzQ8+cjeXxomJBXROjXRkwTH6O1Wq+RDlS87rWfE54VC+/kFKRoB32Dt/tdFqQ/O5v3jUI9K2H+xd/iUA62XEWi/7p1+ef4rMSM3N9LLHkWYPJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VzsappMV; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741008658; x=1772544658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1vY8tCYPxCY4hbQpuMez7lxmv4c2waMAS4LksLgaxQ=;
  b=VzsappMVe+uMF9FL8QZwBs7coX7WCMQFxCGGwVcuZ4iLrTy8fWR6RTgN
   NUuwTvJuMjAhm57ShmOnJXzLnrkejOMlhzB9o6Xsq5EbpuN5p2Zls3RcV
   hvSB2yalX/wWV6e/f9WN+u1D+3QySesr1n+zD/k3AdOnWus4dgtFaVkq/
   4=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="803691401"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:30:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:32907]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.163:2525] with esmtp (Farcaster)
 id 415691d2-e1c3-4608-9ed6-87a92ed11fa8; Mon, 3 Mar 2025 13:30:55 +0000 (UTC)
X-Farcaster-Flow-ID: 415691d2-e1c3-4608-9ed6-87a92ed11fa8
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:54 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:30:54 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTPS id 77107406A9;
	Mon,  3 Mar 2025 13:30:52 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [RFC PATCH 3/5] mm: userfaultfd: allow to register userfaultfd for guest_memfd
Date: Mon, 3 Mar 2025 13:30:09 +0000
Message-ID: <20250303133011.44095-4-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303133011.44095-1-kalyazin@amazon.com>
References: <20250303133011.44095-1-kalyazin@amazon.com>
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
 include/linux/userfaultfd_k.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d144..440d38903359 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -20,6 +20,10 @@
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/hugetlb_inline.h>
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
+#endif
+
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
 
@@ -242,6 +246,11 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 		return false;
 #endif
 
+#ifdef CONFIG_KVM_PRIVATE_MEM
+	if (kvm_gmem_vma_is_gmem(vma))
+		return true;
+#endif
+
 	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
 	    vma_is_shmem(vma);
-- 
2.47.1


