Return-Path: <linux-kselftest+bounces-28212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97046A4E2F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85FE19C0D28
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B62857C7;
	Tue,  4 Mar 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I2IDkUtl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45732857D3
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100799; cv=pass; b=WpGw8FoEb4WFVuD5XxRETzCnI8RgR4J0mr/ZbT29ka9OqqSdX2OA9dYvADO2yMC1uK1GkNsUzPJkI5e4dJakTnGlS00Txg1sbzMYGYKeoXSOOaKpCgJxgjd+Rtdm3CsiSeFhrkGIoHZtZDgtS6//NwMRUkXebkerd7G3DpexQwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100799; c=relaxed/simple;
	bh=O+1kyzMjMuVSclP/dGDX7WvTQ3qb9jZg68fPpc8T+yE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IifsfQ7+Ot9fvmXZUhJyv5RHgYSsYRNLw5EFPUaunKSO2jmxf8twJQ/PXH51wwMZZ0Qb+2EFnTiySurrzqd3QpmF/6gmmD2t2i0SQ9p6GRWeVKZDLAQyocTQ+UHt/x4DqDdUBGiC1PFswIzU/FQn0s81dnGq0PHt2V1ogZ1A1W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I2IDkUtl; arc=none smtp.client-ip=99.78.197.218; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id EA13E40CF122
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:06:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazon201209 header.b=I2IDkUtl
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fB22tq9zFyT8
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:05:14 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 84F934273D; Tue,  4 Mar 2025 18:04:57 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I2IDkUtl
X-Envelope-From: <linux-kernel+bounces-541764-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I2IDkUtl
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 4F59141C9E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:00 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 26EEC3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:00 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C1B18937C1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7D2116F7;
	Mon,  3 Mar 2025 13:09:00 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CA21129F;
	Mon,  3 Mar 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007337; cv=none; b=pECj3u8HVlYM/1jGdnbmLyk/Kzo7Lq8ndBAc9X+hJMMsyOX5Jd5dEi6l787IURpjufX3gmorCzHpemNuZw58Fbog61SDH2Le5GYgObjK0rs6km5uB3EBfztpeasPraHP2cxo8M6KYxDzqVmv97KcKvH4lkL6/WGSD5sP/GhF+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007337; c=relaxed/simple;
	bh=O+1kyzMjMuVSclP/dGDX7WvTQ3qb9jZg68fPpc8T+yE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGYKEEMFbZ9bXK5xECkZE0nf2Qe3QLrO++zzfxBFtX8Ric7qoSsFvRutGRLHrNxvri31lIuVC7iPq130xJE7djxXGd+N09nWEt5b/6q35SkGImk796xFdLzWg9nmHF6TYAtxhaEesfwm2SZh2qE774WgOqPGTcY0EI7KJoNLnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I2IDkUtl; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741007337; x=1772543337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fo0RfFhjOlaWjyHUEezlWZqA9yMhjyUNGY8gIayRQKY=;
  b=I2IDkUtliTSdICOOZOja+o2KRv/R5z5Ky+EeWO9Y9O4GRF/gbY69iM7k
   TWLuitm4OcSoflrJ5CngkN27xEKPjLSQqnLfuOe72oFsE1Ma2nBy1J+S1
   xEEMGj053E6Gw+dKiCB8KR92kcTU6drBRrM7O2/yzOONZNphwzDI1u6JE
   s=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="382575134"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:08:55 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:44365]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.5:2525] with esmtp (Farcaster)
 id a3ca6071-d059-430d-be89-565f65c948ae; Mon, 3 Mar 2025 13:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: a3ca6071-d059-430d-be89-565f65c948ae
Received: from EX19D015EUA002.ant.amazon.com (10.252.50.219) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:08:53 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D015EUA002.ant.amazon.com (10.252.50.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:08:52 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:08:52 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 0E275A0686;
	Mon,  3 Mar 2025 13:08:50 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [v3 PATCH 1/2] KVM: guest_memfd: add generic population via write
Date: Mon, 3 Mar 2025 13:08:37 +0000
Message-ID: <20250303130838.28812-2-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303130838.28812-1-kalyazin@amazon.com>
References: <20250303130838.28812-1-kalyazin@amazon.com>
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
X-ITU-Libra-ESVA-ID: 4Z6fB22tq9zFyT8
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705517.79828@fCBXxEEMxQ7zEAXIt6OQig
X-ITU-MailScanner-SpamCheck: not spam

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
 virt/kvm/guest_memfd.c | 94 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 30b47ff0e6d2..f93fe5835173 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -417,12 +417,97 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	return 0;
 }
-#else
-#define kvm_gmem_mmap NULL
+
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
+	end = (*offset + count) >> PAGE_SHIFT;
+
+	filemap_invalidate_lock_shared(file->f_mapping);
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
+		/* No support for huge pages. */
+		if (WARN_ON_ONCE(folio_test_large(folio))) {
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
+		kunmap_local(vaddr);
+		if (ret) {
+			ret = -EINVAL;
+			folio_put(folio);
+			goto out;
+		}
+
+		kvm_gmem_mark_prepared(folio);
+		folio_put(folio);
+
+		index = folio_next_index(folio);
+		*offset += PAGE_SIZE;
+	}
+
+out:
+	filemap_invalidate_unlock_shared(file->f_mapping);
+
+	return ret && start == (*offset >> PAGE_SHIFT) ?
+		ret : *offset - (start << PAGE_SHIFT);
+}
 #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
 
 static struct file_operations kvm_gmem_fops = {
-	.mmap		= kvm_gmem_mmap,
+#ifdef CONFIG_KVM_GMEM_SHARED_MEM
+	.mmap           = kvm_gmem_mmap,
+	.llseek         = default_llseek,
+	.write          = kvm_kmem_gmem_write,
+#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
@@ -538,6 +623,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	}
 
 	file->f_flags |= O_LARGEFILE;
+#ifdef CONFIG_KVM_GMEM_SHARED_MEM
+	file->f_mode |= FMODE_LSEEK | FMODE_PWRITE;
+#endif /* CONFIG_KVM_GMEM_SHARED_MEM */
 
 	inode = file->f_inode;
 	WARN_ON(file->f_mapping != inode->i_mapping);
-- 
2.47.1



