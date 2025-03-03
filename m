Return-Path: <linux-kselftest+bounces-28225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA106A4E94B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47608422F36
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6039259C80;
	Tue,  4 Mar 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EE76lk97"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCD2E339D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108007; cv=pass; b=cFQLu1BzVH/U2aJZKTXKugvEIEDkwSlkQ6lIqgPJQx0xr3DuWHoh6NYa8Xo7RowdbtTgyJuT6jd8jgBzk1krNhp6p7TVeWK+jAH0TEc5wGDdcRyMmMtNNgmwMcWwxY0wTnpWeHCJZjsyaJbaMrmMaKJ/GrfsK7mO6LswpV9h+Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108007; c=relaxed/simple;
	bh=yngMXZswSSlfh1x2jJZYvt8kJxzt6cXiGjCMNtqGspo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZG8pmbMdLi/PWyfovCtahlQMfhfWG5cCFCH+WkQrnP6cXx19PJ8G+Dth0gbImMUCm5hDuGdmoL16N3C3BHR7eZjB5e6TGIR4v26n7P8ue8oqOeQj7m3NVfwsHczK+58AaaLqpKhbN302E2w4vluH9S/9Ap6jIjLtai7njOJ6hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EE76lk97; arc=none smtp.client-ip=52.95.48.154; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9634840CEC8D
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 20:06:44 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazon201209 header.b=EE76lk97
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gCf52B6zG1cC
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:51:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2B6CD4274C; Tue,  4 Mar 2025 18:51:27 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EE76lk97
X-Envelope-From: <linux-kernel+bounces-541817-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EE76lk97
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9A07941FAB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:33:30 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 2E69C3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:33:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EC33AB948
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B721423C;
	Mon,  3 Mar 2025 13:30:54 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFF213E88;
	Mon,  3 Mar 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008652; cv=none; b=txl/TsypPzv5HcxiVFi32CLVXadnHJrP6sPl/pkTw/7W7/0nY3Gb4hTc9a1hh/4NlL/mGlbGjaiCaA3d9fbL3pIwnfEedat+7OSAUdbTxaP1blj6pfI/6EWqwF5oQwsOasyDq+g1WSUNX5jSis3W+RNDKnFLlE/EBcdeJP5HB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008652; c=relaxed/simple;
	bh=yngMXZswSSlfh1x2jJZYvt8kJxzt6cXiGjCMNtqGspo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6gwBK9hRJaWdhVJoOAk4M8qV/+1veruXjaRdf+jT+S0u0nqMhkWrQyQ3+QxVWFc5BFLXXtEuu0jDJLEpPP0ROEwcCqIaKitbFfFNCtR6MRh3RaHmM1ydfEKR5pihiP54/w+zXges8H/JJ09beZLmUUzP3bbPhcKfaDCNwW5UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EE76lk97; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741008651; x=1772544651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7/xtyBJVACA1f5rni1kJ1y38BiqCsgl928AjTc2EPg=;
  b=EE76lk97+6gXjNeC/Er8mlxx2nEdBVW5+5OiBa/QmpZiSiDgLIgc5vKB
   SZn/pSjtjxd3ukmFeWps3qlTB4KAsqdVjNwIrui5bSTI+nOPAJ2SE7ArE
   yNZsmuhoJbxPNPX6nkjiMuQv2A3F0khsLgPMe2uM3VROIMMuyUF4KEFuT
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="467377029"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:30:47 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:58431]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.142:2525] with esmtp (Farcaster)
 id 95972e55-02f1-4ae5-bb4d-b9d69caeff17; Mon, 3 Mar 2025 13:30:45 +0000 (UTC)
X-Farcaster-Flow-ID: 95972e55-02f1-4ae5-bb4d-b9d69caeff17
Received: from EX19D004EUA003.ant.amazon.com (10.252.50.230) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:42 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D004EUA003.ant.amazon.com (10.252.50.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:41 +0000
Received: from email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:30:41 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-1box-1a-9bbde7a3.us-east-1.amazon.com (Postfix) with ESMTPS id 3176540617;
	Mon,  3 Mar 2025 13:30:40 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [RFC PATCH 2/5] KVM: guest_memfd: add support for uffd missing
Date: Mon, 3 Mar 2025 13:30:08 +0000
Message-ID: <20250303133011.44095-3-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303133011.44095-1-kalyazin@amazon.com>
References: <20250303133011.44095-1-kalyazin@amazon.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gCf52B6zG1cC
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712678.5999@ufMVvH+wljGEdw7G7D4/3w
X-ITU-MailScanner-SpamCheck: not spam

Add support for sending a pagefault event if userfaultfd is registered.
Only page missing event is currently supported.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index af825f7494ea..358c3776ed66 100644
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
 
@@ -332,9 +335,16 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 	struct folio *folio;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
+	folio = filemap_get_entry(inode->i_mapping, vmf->pgoff);
+	if (!folio && userfaultfd_missing(vmf->vma))
+		return handle_userfault(vmf, VM_UFFD_MISSING);
+	if (folio)
+		folio_lock(folio);
+
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
-	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
+	if (!folio)
+		folio = kvm_gmem_get_folio(inode, vmf->pgoff);
 	if (IS_ERR(folio)) {
 		switch (PTR_ERR(folio)) {
 		case -EAGAIN:
-- 
2.47.1



