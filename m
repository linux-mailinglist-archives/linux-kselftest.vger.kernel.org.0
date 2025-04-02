Return-Path: <linux-kselftest+bounces-30022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69EA792B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0591893E3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014331922E7;
	Wed,  2 Apr 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YXKDZHre"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127E18A93F;
	Wed,  2 Apr 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610108; cv=none; b=awqktwdmCGcdJQ4i+G88ig4h1pmbvnrGehVUo+lTlgA3JUaVSjHSVC56BDEUfD4mhjtjDjQBsFK9xY+jAM6FeK1ZX+jkh979xIss0oNvVm6RChYhZ9JJeSqEFqwyDdLDYCJFGUT1ijpFdDOIHyJQAoeJe+lSBMs2LTeDc9Fzhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610108; c=relaxed/simple;
	bh=fI1nvaNtpBr5b3P3q5KUGnap3tBP7XHTJLD6Xdv8vPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsM+SijS0NS+FgiRy+svNlfVcrW6PepeHRhqthDnspoDn5qST38Kwciehfk8s1OikW/w0KzGxO5ZO91SiiF4f/Jysapptn3JEJRiPznKNCMjeNS4spquC+3UUWgbCBOxeVaC/mzzbUlqq5nGXCpm/6iqUnUYLe7+Hy70FsBEhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YXKDZHre; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743610105; x=1775146105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKvQStBu+rMX8UPjQS1EH5XeuJ9x01oElWsxsBsndIY=;
  b=YXKDZHreyX0AZ9lqQwYMrSPLfT0b3KBUH9Ir7tbD8Q58l70PDkp8zGi8
   AKwjQa4q8vg4CtPqShwtzIb5OHzG6/+0HU3GDSxhakbs/IWieOZJwxoh9
   CnYWXv6z105dE3C0CKbhzo3TmCLoPYRs058dqiEm1Gjv5jjuvMi/RSbr7
   M=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="184231774"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:08:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:23064]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.91:2525] with esmtp (Farcaster)
 id 9fca53eb-8c49-414d-98bb-13cf3c17e564; Wed, 2 Apr 2025 16:08:23 +0000 (UTC)
X-Farcaster-Flow-ID: 9fca53eb-8c49-414d-98bb-13cf3c17e564
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:08:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:08:15 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:08:15 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTPS id 3A4DA40BE5;
	Wed,  2 Apr 2025 16:08:13 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [PATCH v2 4/5] KVM: guest_memfd: add support for userfaultfd minor
Date: Wed, 2 Apr 2025 16:07:20 +0000
Message-ID: <20250402160721.97596-5-kalyazin@amazon.com>
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

Add support for sending a pagefault event if userfaultfd is registered.
Only page minor event is currently supported.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 26b1734b9623..92d3e6b51dc2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,9 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#ifdef CONFIG_KVM_PRIVATE_MEM
+#include <linux/userfaultfd_k.h>
+#endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #include "kvm_mm.h"
 
@@ -380,6 +383,13 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 		kvm_gmem_mark_prepared(folio);
 	}
 
+	if (userfaultfd_minor(vmf->vma) &&
+	    !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
+		folio_unlock(folio);
+		filemap_invalidate_unlock_shared(inode->i_mapping);
+		return handle_userfault(vmf, VM_UFFD_MINOR);
+	}
+
 	vmf->page = folio_file_page(folio, vmf->pgoff);
 
 out_folio:
-- 
2.47.1


