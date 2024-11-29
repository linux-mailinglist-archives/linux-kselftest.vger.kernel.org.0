Return-Path: <linux-kselftest+bounces-22618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79D9DE693
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656A9164AA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFE19ABD1;
	Fri, 29 Nov 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mJVBKR0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0637155352;
	Fri, 29 Nov 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883994; cv=none; b=ZMW/6k/IV3gVqoUy3LOtAa2HYlvpHBsiXDyaLwYO8pDVFZ9zZB2JCf+VPDjleWZsyavyJnIK6JIjqduv2JiZ18ZPVjOG78XA84cndy7ICDzUyXgCZcbNzCdvwfJrstKFeYa41ucE6xd2tmpHfij9v6oW2sMp351+5JxobWZdbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883994; c=relaxed/simple;
	bh=WJvGNlSDsguJ2lBq0cA4zbQZCWHT3NXIF2YwIi55AOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWtkHwUCU3mOHYxDF/UvdGIJzzqz/+p+CnI8DTlfJg+HwfydhLz3JuDoFbe178qS8r8c6gc/+F+qJ3YVZ1vyefQAWUixyf3COWWh2Anytl0iQ6xcgLqiQvrKLebGBgAeTklwaIlOZLjbnhWpRhe6FOqW2PfxEOqnGFczKdFxeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mJVBKR0v; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732883993; x=1764419993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pruxSJBO+jg2vTrKWukJWri3CAYz3t7ISP8fRBBPjl8=;
  b=mJVBKR0vws3zANPD2VVYcF7J+adO0l7dNiq+SC26Uawswttn5bBO5k7+
   sN5qTFGeNR1a8eyEIslFhETd6RSK1zKT643MMvfvELI8hEvXOTSZw8eFF
   FUYLmrpSHGOvO1yi/kc9hgWmiidXXZyaSsiRqh4u3W33NsfpjnNMJt3Ww
   4=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="452145714"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 12:39:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:13724]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.230:2525] with esmtp (Farcaster)
 id cf81e0c5-4a2e-4985-891e-674da5678ac5; Fri, 29 Nov 2024 12:39:48 +0000 (UTC)
X-Farcaster-Flow-ID: cf81e0c5-4a2e-4985-891e-674da5678ac5
Received: from EX19D003UWB001.ant.amazon.com (10.13.138.92) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 12:39:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D003UWB001.ant.amazon.com (10.13.138.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 29 Nov 2024 12:39:47 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 12:39:47 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id B78B0406EB;
	Fri, 29 Nov 2024 12:39:44 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH v2 1/2] KVM: guest_memfd: add generic population via write
Date: Fri, 29 Nov 2024 12:39:28 +0000
Message-ID: <20241129123929.64790-2-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241129123929.64790-1-kalyazin@amazon.com>
References: <20241129123929.64790-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

write syscall populates guest_memfd with user-supplied data in a generic
way, ie no vendor-specific preparation is performed.  This is supposed
to be used in non-CoCo setups where guest memory is not
hardware-encrypted.

The following behaviour is implemented:
 - only page-aligned count and offset are allowed
 - if the memory is already allocated, the call will successfully
   populate it
 - if the memory is not allocated, the call will both allocate and
   populate
 - if the memory is already populated, the call will not repopulate it

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 47a9f68f7b24..e80566ef56e9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -102,6 +102,80 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return filemap_grab_folio(inode->i_mapping, index);
 }
 
+#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
+static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *offset)
+{
+	pgoff_t start, end, index;
+	ssize_t ret = 0;
+
+	if (!PAGE_ALIGNED(*offset) || !PAGE_ALIGNED(count))
+		return -EINVAL;
+
+	if (*offset + count > i_size_read(file_inode(file)))
+		return -EINVAL;
+
+	if (!buf)
+		return -EINVAL;
+
+	start = *offset >> PAGE_SHIFT;
+        end = (*offset + count) >> PAGE_SHIFT;
+
+	filemap_invalidate_lock(file->f_mapping);
+
+	for (index = start; index < end; ) {
+		struct folio *folio;
+		void *vaddr;
+		pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+
+		folio = kvm_gmem_get_folio(file_inode(file), index);
+		if (IS_ERR(folio)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (folio_test_hwpoison(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = -ENOSPC;
+			goto out;
+		}
+
+		folio_unlock(folio);
+
+		vaddr = kmap_local_folio(folio, 0);
+		ret = copy_from_user(vaddr, buf + buf_offset, PAGE_SIZE);
+		if (ret)
+			ret = -EINVAL;
+		kunmap_local(vaddr);
+
+		kvm_gmem_mark_prepared(folio);
+		folio_put(folio);
+
+		index = folio_next_index(folio);
+		*offset += PAGE_SIZE;
+	}
+
+out:
+	filemap_invalidate_unlock(file->f_mapping);
+
+	return ret && start == (*offset >> PAGE_SHIFT) ?
+		ret : *offset - (start << PAGE_SHIFT);
+}
+#endif
+
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
 				      pgoff_t end)
 {
@@ -308,6 +382,10 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 }
 
 static struct file_operations kvm_gmem_fops = {
+#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
+	.llseek         = default_llseek,
+	.write          = kvm_kmem_gmem_write,
+#endif
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
@@ -423,6 +501,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	}
 
 	file->f_flags |= O_LARGEFILE;
+	file->f_mode |= FMODE_LSEEK | FMODE_PWRITE;
 
 	inode = file->f_inode;
 	WARN_ON(file->f_mapping != inode->i_mapping);
-- 
2.40.1


