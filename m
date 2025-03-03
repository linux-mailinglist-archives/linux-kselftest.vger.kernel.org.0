Return-Path: <linux-kselftest+bounces-28053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92823A4C1ED
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7917085B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686332135A5;
	Mon,  3 Mar 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gorIPrQP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72541F0E4F;
	Mon,  3 Mar 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008640; cv=none; b=N9QzMbpi8elQ2P33FNtRqZyn3gIwt1RR0RrkmcfQMFErrd8qoVvVWUXkED4qwEM5kZlW//34INcejG1R3H29Ky9h7Wi51wTM4AUQ0XRTMsKNhljQo1ox5aSHKwSWDxS+T1v+jT1wqaAKN0tGzfydOkYyjlo4jGp+WC4w2Y1iRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008640; c=relaxed/simple;
	bh=n+gAmjIUKvZXwsygtp1toh0bKCFMgv5xeKg/NqtjJj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIbmkx9Rm27AlQDzWN069zEbADKaMXr0rkkRqk3Lq59y6rwHHWivfKgZgdP5ofu76snNurbYnpHG/SpAW24YI19/VrdBQzgN2RuQobO8HA3IMPgz9vy1Xv+T0wWDxoU51RykWmfdbQj6tgHZSPTLbouPYUOfPH746oLrc1lG/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gorIPrQP; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741008639; x=1772544639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUaunioKjZGZ2DQ4BkT3SKTdDYEcp1DDV2tTW0nbWvg=;
  b=gorIPrQPwRxmYY+/UV9nU64fuxRC7+9ByaJCqt2211kC0TpHdXmM6cHD
   7VGhuqOgyjBcfsoQLGxuAkT1VIsC9is17yJotMRSF08vYTpNWNFhGCFqn
   RVUAnAntPEHDZAY2h+lYCOyNzXphiVaP+uKbi9xBLfLMl2EQjcu7S/7Nk
   0=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="803691335"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:30:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:49609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.102:2525] with esmtp (Farcaster)
 id 568d5078-4118-4f5e-91c9-1ef7962d1e6b; Mon, 3 Mar 2025 13:30:32 +0000 (UTC)
X-Farcaster-Flow-ID: 568d5078-4118-4f5e-91c9-1ef7962d1e6b
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:29 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:30:29 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTPS id C461CA039C;
	Mon,  3 Mar 2025 13:30:26 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [RFC PATCH 1/5] KVM: guest_memfd: add kvm_gmem_vma_is_gmem
Date: Mon, 3 Mar 2025 13:30:07 +0000
Message-ID: <20250303133011.44095-2-kalyazin@amazon.com>
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

It will be used to distinguish the vma type in userfaultfd code.
This likely needs to be done in the guestmem library.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 5 +++++
 virt/kvm/kvm_mm.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f93fe5835173..af825f7494ea 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -500,6 +500,11 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
 	return ret && start == (*offset >> PAGE_SHIFT) ?
 		ret : *offset - (start << PAGE_SHIFT);
 }
+
+bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &kvm_gmem_vm_ops;
+}
 #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
 
 static struct file_operations kvm_gmem_fops = {
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


