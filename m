Return-Path: <linux-kselftest+bounces-30020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6045A792AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36E8170E16
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18E18DF80;
	Wed,  2 Apr 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vL5HfYGw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D918DB1E;
	Wed,  2 Apr 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610078; cv=none; b=TO590mLpLuh/7oLDqH3BvOqjhQXBotiBw595RPbPLFmnPs7TWciEEB3ADtT8Po+yTHTOsHXaZRGEuHHHh11y2uVTgm+KRnmkFNWtzT+avZtN4KTqBWFcZLdbQ8eW420kdCOQ/Zr/vI6DCC4kLMr+uZbHGQZX8tDGfvTF1j1vqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610078; c=relaxed/simple;
	bh=qv6pZdIpkJtUfJWzbSecbEskHyocrByLILtVy0wJSSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsJFg5GI76EPmf/BadZhZ+8yJiaj1hpucHyWLx7DmaEakMWfj3R23wylOHjtCyxEeoAi3xJh2gtZiNFfT1uVUNU7wRAQsK4ZOMZkwIRHz4y689MQpYRO7r+ppeQixkbMFtPJ5Yc+NhVXWCb5k8ogvOb4vMiI9WMzjv0pRGRiCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vL5HfYGw; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743610077; x=1775146077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UqLHY0tozEGhyxnF+okEAbfVCr65ECLQO5uKTF2y+bU=;
  b=vL5HfYGwwYz4U6qjGxGuvuAXnWT2QL4iU/lzl05RQ31w49TKIc4Qvr/W
   pZ9+dBt9Rwcj8ihXLsmy261K8DgU0DBQyMkYKHoRDa6Q9+Y+ncCCG3TFr
   c4aMRym1iwiDAmJd3uyxMyRwNGpiWsgMBzXjO0fu2dadb7l3T4vZR24tp
   o=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="812710781"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:07:51 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:29109]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id 0dbab0ac-a3ac-4e29-911c-8594f554e27d; Wed, 2 Apr 2025 16:07:50 +0000 (UTC)
X-Farcaster-Flow-ID: 0dbab0ac-a3ac-4e29-911c-8594f554e27d
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:49 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:07:49 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTPS id 1F660C061B;
	Wed,  2 Apr 2025 16:07:47 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [PATCH v2 2/5] KVM: guest_memfd: add kvm_gmem_vma_is_gmem
Date: Wed, 2 Apr 2025 16:07:18 +0000
Message-ID: <20250402160721.97596-3-kalyazin@amazon.com>
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

It will be used to distinguish the vma type in userfaultfd code.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 virt/kvm/kvm_mm.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbf89e643add..26b1734b9623 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -416,6 +416,11 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	return 0;
 }
+
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &kvm_gmem_vm_ops;
+}
 #else
 #define kvm_gmem_mmap NULL
 #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index acef3f5c582a..09fcdf18a072 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -73,6 +73,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
 #else
 static inline void kvm_gmem_init(struct module *module)
 {
-- 
2.47.1


