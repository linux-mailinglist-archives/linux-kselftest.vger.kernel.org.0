Return-Path: <linux-kselftest+bounces-4766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E28567CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46110283FDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9658133993;
	Thu, 15 Feb 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="XfG+wQCD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A451132478;
	Thu, 15 Feb 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011053; cv=none; b=i26Fv7GtMRXtnnzNp1eUl0vo1gnRIpuEfcAl5y0bgBwqSoN/sp9YO68b7Frpf7ESMOJTyeGA7Cqcm9qU17E7QiSayIQT3OSaFleO0qy/qCkFLrncOcreRNhy0HxM+KBRXy1ebTTwd9dOtBLhFpGzaXU8upRkHv+a6CS1Bu3dLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011053; c=relaxed/simple;
	bh=b0E/zOycocm6Yr7BxMZaBkE498Ra5SmJqkm/mI5IhO4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdOGWUAdEG36XZafsHdXxaEPEVUbGT3FWF+ksoBvGkxlFgIhY9QQxXyJRCYPgx7/nZRpMoRiAC49pYb9XgOXn/steCQalgZmJ3Rm2w/lLq0+GnxmE+L4kbMzBVNoyoPAGdzLpzqIIgJPTt4kxMbqr7zYbvdRomTOSLKSE0GC8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=XfG+wQCD; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=p6NNZuK1RvdNGHYjSL7HNP2fH297L2tC12ZYacWjRj4=; b=XfG+wQCDKa6hHYYDCxJ7Nc0BWP
	sg2NEHdSnaRun8+V2R7rqcKRnA9bn36TBGzn0BB9d+O59EQENPYGDnV5j7EzSPKwJNjhSJgqszFQH
	Rhogth/veO7q4XwVpy7Tk3JgWAqrj9pPVe4nIDXXnIxuQPiIuBsFq9Bg9x+j0ZO4JIY4=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radh3-0001H4-WF; Thu, 15 Feb 2024 15:30:34 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radh3-00089r-Nb; Thu, 15 Feb 2024 15:30:33 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 09/21] KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
Date: Thu, 15 Feb 2024 15:29:04 +0000
Message-Id: <20240215152916.1158-10-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215152916.1158-1-paul@xen.org>
References: <20240215152916.1158-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

Some pfncache pages may actually be overlays on guest memory that have a
fixed HVA within the VMM. It's pointless to invalidate such cached
mappings if the overlay is moved so allow a cache to be activated directly
with the HVA to cater for such cases. A subsequent patch will make use
of this facility.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v13:
 - Define kvm_is_error_gpa() to check GPA validity.
 - Add an either/or address check to __kvm_gpc_refresh() as requested.
 - Make sure memslot is NULL if the cache is activated with an HVA.

v11:
 - Fixed kvm_gpc_check() to ignore memslot generation if the cache is not
   activated with a GPA. (This breakage occured during the re-work for v8).

v9:
 - Pass both GPA and HVA into __kvm_gpc_refresh() rather than overloading
   the address paraneter and using a bool flag to indicated what it is.

v8:
 - Re-worked to avoid messing with struct gfn_to_pfn_cache.
---
 include/linux/kvm_host.h | 21 +++++++++
 virt/kvm/pfncache.c      | 94 +++++++++++++++++++++++++++++-----------
 2 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 41ee515b304e..043cc824d55a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -148,6 +148,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 
 #endif
 
+static inline bool kvm_is_error_gpa(gpa_t gpa)
+{
+	return gpa == INVALID_GPA;
+}
+
 #define KVM_ERR_PTR_BAD_PAGE	(ERR_PTR(-ENOENT))
 
 static inline bool is_error_page(struct page *page)
@@ -1343,6 +1348,22 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
  */
 int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len);
 
+/**
+ * kvm_gpc_activate_hva - prepare a cached kernel mapping and HPA for a given HVA.
+ *
+ * @gpc:          struct gfn_to_pfn_cache object.
+ * @hva:          userspace virtual address to map.
+ * @len:          sanity check; the range being access must fit a single page.
+ *
+ * @return:       0 for success.
+ *                -EINVAL for a mapping which would cross a page boundary.
+ *                -EFAULT for an untranslatable guest physical address.
+ *
+ * The semantics of this function are the same as those of kvm_gpc_activate(). It
+ * merely bypasses a layer of address translation.
+ */
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
+
 /**
  * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
  *
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 97eec8ee3449..4e64d349b2f7 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -48,7 +48,14 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!gpc->active)
 		return false;
 
-	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
+	/*
+	 * If the page was cached from a memslot, make sure the memslots have
+	 * not been re-configured.
+	 */
+	if (!kvm_is_error_gpa(gpc->gpa) && gpc->generation != slots->generation)
+		return false;
+
+	if (kvm_is_error_hva(gpc->uhva))
 		return false;
 
 	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
@@ -209,11 +216,11 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			     unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-	unsigned long page_offset = offset_in_page(gpa);
+	unsigned long page_offset = kvm_is_error_gpa(gpa) ?
+		offset_in_page(uhva) : offset_in_page(gpa);
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
@@ -221,6 +228,10 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	void *old_khva;
 	int ret;
 
+	/* Either gpa or uhva must be valid, but not both */
+	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) == kvm_is_error_hva(uhva)))
+		return -EINVAL;
+
 	/*
 	 * If must fit within a single page. The 'len' argument is
 	 * only to enforce that.
@@ -246,29 +257,39 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
 
-	/* Refresh the userspace HVA if necessary */
-	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
-	    kvm_is_error_hva(gpc->uhva)) {
-		gfn_t gfn = gpa_to_gfn(gpa);
-
-		gpc->gpa = gpa;
-		gpc->generation = slots->generation;
-		gpc->memslot = __gfn_to_memslot(slots, gfn);
-		gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
+	if (kvm_is_error_gpa(gpa)) {
+		gpc->gpa = INVALID_GPA;
+		gpc->memslot = NULL;
+		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
 
-		if (kvm_is_error_hva(gpc->uhva)) {
-			ret = -EFAULT;
-			goto out;
-		}
-
-		/*
-		 * Even if the GPA and/or the memslot generation changed, the
-		 * HVA may still be the same.
-		 */
 		if (gpc->uhva != old_uhva)
 			hva_change = true;
 	} else {
-		gpc->uhva = old_uhva;
+		struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
+
+		if (gpc->gpa != gpa || gpc->generation != slots->generation ||
+		    kvm_is_error_hva(gpc->uhva)) {
+			gfn_t gfn = gpa_to_gfn(gpa);
+
+			gpc->gpa = gpa;
+			gpc->generation = slots->generation;
+			gpc->memslot = __gfn_to_memslot(slots, gfn);
+			gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
+
+			if (kvm_is_error_hva(gpc->uhva)) {
+				ret = -EFAULT;
+				goto out;
+			}
+
+			/*
+			 * Even if the GPA and/or the memslot generation changed, the
+			 * HVA may still be the same.
+			 */
+			if (gpc->uhva != old_uhva)
+				hva_change = true;
+		} else {
+			gpc->uhva = old_uhva;
+		}
 	}
 
 	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
@@ -319,7 +340,16 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 
 int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
-	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
+	unsigned long uhva = gpc->uhva;
+
+	/*
+	 * If the GPA is valid then invalidate the HVA, otherwise
+	 * __kvm_gpc_refresh() will fail its strict either/or address check.
+	 */
+	if (!kvm_is_error_gpa(gpc->gpa))
+		uhva = KVM_HVA_ERR_BAD;
+
+	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva, len);
 }
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
@@ -329,10 +359,12 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 
 	gpc->kvm = kvm;
 	gpc->pfn = KVM_PFN_ERR_FAULT;
+	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 }
 
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
+			      unsigned long len)
 {
 	struct kvm *kvm = gpc->kvm;
 
@@ -353,7 +385,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 		gpc->active = true;
 		write_unlock_irq(&gpc->lock);
 	}
-	return __kvm_gpc_refresh(gpc, gpa, len);
+	return __kvm_gpc_refresh(gpc, gpa, uhva, len);
+}
+
+int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+{
+	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
+}
+
+int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
+{
+	return __kvm_gpc_activate(gpc, INVALID_GPA, uhva, len);
 }
 
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
-- 
2.39.2


