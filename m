Return-Path: <linux-kselftest+bounces-21102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85949B64B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080CE1C21BF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33721EE039;
	Wed, 30 Oct 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="oDrV65BT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B91EB9E3;
	Wed, 30 Oct 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296225; cv=none; b=PlCDqg/eHtY4KC/xsZXFEOGxs4K3oezbPpYROcNyqRelRXtQrqedbPr2HZDcMxLOx9AOeNSPpswoeTvKmCCQ55qQpryReZznWtCwG086fYf9hqJT9sgUbpoEV1jdmgHQIm3vZLz9EmTQMB8FQntrtGCp45SJ2MFw3ZTIFCP+W4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296225; c=relaxed/simple;
	bh=o28RC50910aHKQu18l82oQQPAJIOFbPuumxlWDQ4D1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUjcRws4gJl3v0aj5w3AsjiOsoj0f0Hdt1JsE51SIroFpvlVrGqa6lBJpXb6r8KobqQVlLHa2NbD0a9qiWVj6bRMiYKhsEtc9wa0StBZEXsKdd48YWKF/qk+raawYTdrKZ/7W3pzb2g3Vi8FTWXEtL6/Go34eWVWrRP1VOjVKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=oDrV65BT; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730296224; x=1761832224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynq07QFehgBeqYs8R/uKHAJgtPgDIcbxY2M616fmmig=;
  b=oDrV65BTT+7F34u4+gjz5JlHr55nkHWLuYHUXyYBJ6aImCdk8DcbgVRx
   Szl7FJ5pjLnNgaoj1cOiC8xwTE3nZXd01sCIcMCDCbHT7qMvvjUs42CE1
   iP+s065v7pJKlVC36vG9G1BjxwOEBLbVNAS5dQOzwf10GMYr7uG2QLoFJ
   o=;
X-IronPort-AV: E=Sophos;i="6.11,245,1725321600"; 
   d="scan'208";a="691697056"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:50:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:54095]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525] with esmtp (Farcaster)
 id e1e6c02d-939e-42c5-ab8b-438e8ae0b6bc; Wed, 30 Oct 2024 13:50:16 +0000 (UTC)
X-Farcaster-Flow-ID: e1e6c02d-939e-42c5-ab8b-438e8ae0b6bc
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:50:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:50:11 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 30 Oct 2024 13:50:11 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id E3BF841309;
	Wed, 30 Oct 2024 13:50:01 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <tabba@google.com>, <quic_eberman@quicinc.com>, <david@redhat.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <jthoughton@google.com>,
	<ackerleytng@google.com>, <vannapurve@google.com>, <rppt@kernel.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <graf@amazon.com>,
	<jgowans@amazon.com>, <derekmn@amazon.com>, <kalyazin@amazon.com>,
	<xmarcalx@amazon.com>, <linux-mm@kvack.org>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v3 3/6] kvm: gmem: implement direct map manipulation routines
Date: Wed, 30 Oct 2024 13:49:07 +0000
Message-ID: <20241030134912.515725-4-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030134912.515725-1-roypat@amazon.co.uk>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Implement (yet unused) routines for manipulating guest_memfd direct map
state. This is largely for illustration purposes.

kvm_gmem_set_direct_map allows manipulating arbitrary pgoff_t
ranges, even if the covered memory has not yet been faulted in (in which
case the requested direct map state is recorded in the xarray and will
be applied by kvm_gmem_folio_configure_direct_map after the folio is
faulted in and prepared/populated). This can be used to realize
private/shared conversions on not-yet-faulted in memory, as discussed in
the guest_memfd upstream call [1].

kvm_gmem_folio_set_direct_map allows manipulating the direct map entries
for a gmem folio that the caller already holds a reference for (whereas
kvm_gmem_set_direct_map needs to look up all folios intersecting the
given pgoff range in the filemap first).

The xa lock serializes calls to kvm_gmem_folio_set_direct_map and
kvm_gmem_set_direct_map, while the read side
(kvm_gmem_folio_configure_direct_map) is protected by RCU. This is
sufficient to ensure consistency between the xarray and the folio's
actual direct map state, as kvm_gmem_folio_configure_direct_map is
called only for freshly allocated folios, and before the folio lock is
dropped for the first time, meaning kvm_gmem_folio_configure_direct_map
always does it's set_direct_map calls before either of
kvm_gmem_[folio_]set_direct_map get a chance. Even if a concurrent call
to kvm_gmem_[folio_]set_direct_map happens, this ensures a sort of
"eventual consistency" between xarray and actual direct map
configuration by the time kvm_gmem_[folio_]set_direct_map exits.

[1]: https://lore.kernel.org/kvm/4b49248b-1cf1-44dc-9b50-ee551e1671ac@redhat.com/

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 virt/kvm/guest_memfd.c | 125 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 50ffc2ad73eda..54387828dcc6a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -96,6 +96,131 @@ static int kvm_gmem_folio_configure_direct_map(struct folio *folio)
 	return r;
 }
 
+/*
+ * Updates the range [@start, @end] in @gmem_priv's direct map state xarray to be @state,
+ * e.g. erasing entries in this range if @state is the default state, and creating
+ * entries otherwise.
+ *
+ * Assumes the xa_lock is held.
+ */
+static int __kvm_gmem_update_xarray(struct kvm_gmem_inode_private *gmem_priv, pgoff_t start,
+				    pgoff_t end, bool state)
+{
+	struct xarray *xa = &gmem_priv->direct_map_state;
+	int r = 0;
+
+	/*
+	 * Cannot use xa_store_range, as multi-indexes cannot easily
+	 * be partially updated.
+	 */
+	for (pgoff_t index = start; index < end; ++index) {
+		if (state == gmem_priv->default_direct_map_state)
+			__xa_erase(xa, index);
+		else
+			/* don't care _what_ we store in the xarray, only care about presence */
+			__xa_store(xa, index, gmem_priv, GFP_KERNEL);
+
+		r = xa_err(xa);
+		if (r)
+			goto out;
+	}
+
+out:
+	return r;
+}
+
+static int __kvm_gmem_folio_set_direct_map(struct folio *folio, pgoff_t start, pgoff_t end,
+					   bool state)
+{
+	unsigned long npages = end - start + 1;
+	struct page *first_page = folio_file_page(folio, start);
+
+	int r = set_direct_map_valid_noflush(first_page, npages, state);
+
+	flush_tlb_kernel_range((unsigned long)page_address(first_page),
+			       (unsigned long)page_address(first_page) +
+				       npages * PAGE_SIZE);
+	return r;
+}
+
+/*
+ * Updates the direct map status for the given range from @start to @end (inclusive), returning
+ * -EINVAL if this range is not completely contained within @folio. Also updates the
+ * xarray stored in the private data of the inode @folio is attached to.
+ *
+ * Takes and drops the folio lock.
+ */
+static __always_unused int kvm_gmem_folio_set_direct_map(struct folio *folio, pgoff_t start,
+								 pgoff_t end, bool state)
+{
+	struct inode *inode = folio_inode(folio);
+	struct kvm_gmem_inode_private *gmem_priv = inode->i_private;
+	int r = -EINVAL;
+
+	if (!folio_contains(folio, start) || !folio_contains(folio, end))
+		goto out;
+
+	xa_lock(&gmem_priv->direct_map_state);
+	r = __kvm_gmem_update_xarray(gmem_priv, start, end, state);
+	if (r)
+		goto unlock_xa;
+
+	folio_lock(folio);
+	r = __kvm_gmem_folio_set_direct_map(folio, start, end, state);
+	folio_unlock(folio);
+
+unlock_xa:
+	xa_unlock(&gmem_priv->direct_map_state);
+out:
+	return r;
+}
+
+/*
+ * Updates the direct map status for the given range from @start to @end (inclusive)
+ * of @inode. Folios in this range have their direct map entries reconfigured,
+ * and the xarray in the @inode's private data is updated.
+ */
+static __always_unused int kvm_gmem_set_direct_map(struct inode *inode, pgoff_t start,
+							   pgoff_t end, bool state)
+{
+	struct kvm_gmem_inode_private *gmem_priv = inode->i_private;
+	struct folio_batch fbatch;
+	pgoff_t index = start;
+	unsigned int count, i;
+	int r = 0;
+
+	xa_lock(&gmem_priv->direct_map_state);
+
+	r = __kvm_gmem_update_xarray(gmem_priv, start, end, state);
+	if (r)
+		goto out;
+
+	folio_batch_init(&fbatch);
+	while (!filemap_get_folios(inode->i_mapping, &index, end, &fbatch) && !r) {
+		count = folio_batch_count(&fbatch);
+		for (i = 0; i < count; i++) {
+			struct folio *folio = fbatch.folios[i];
+			pgoff_t folio_start = max(folio_index(folio), start);
+			pgoff_t folio_end =
+				min(folio_index(folio) + folio_nr_pages(folio),
+				    end);
+
+			folio_lock(folio);
+			r = __kvm_gmem_folio_set_direct_map(folio, folio_start,
+							    folio_end, state);
+			folio_unlock(folio);
+
+			if (r)
+				break;
+		}
+		folio_batch_release(&fbatch);
+	}
+
+	xa_unlock(&gmem_priv->direct_map_state);
+out:
+	return r;
+}
+
 /**
  * folio_file_pfn - like folio_file_page, but return a pfn.
  * @folio: The folio which contains this index.
-- 
2.47.0


