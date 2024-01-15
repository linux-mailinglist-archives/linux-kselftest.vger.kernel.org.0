Return-Path: <linux-kselftest+bounces-2972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1682D94E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1061C218BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA6168D2;
	Mon, 15 Jan 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="dpMcEDtG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721F175AB;
	Mon, 15 Jan 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=JUiDe6hOaIy+4uee/fAnBCB3ywCyITQC8m671brMaTc=; b=dpMcEDtG7nb+ErCgJ/rncMoljY
	vuxrqgCEb9Dy5nunHKYECPU7jeMoUDFKmt88j4f0OqytKqIk2G/4EW7EQA+7OCsw3O7e8tfhzbgN6
	xTgopbE+lD4IiKDnYJpbay7lgK7qNVwJoqizFhkpfvSMX3bdIgSTLy6F4/rmu3Cs9dkU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXI-0002kY-Np; Mon, 15 Jan 2024 12:57:52 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXI-0002kM-Et; Mon, 15 Jan 2024 12:57:52 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH v12 08/20] KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
Date: Mon, 15 Jan 2024 12:56:55 +0000
Message-Id: <20240115125707.1183-9-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
References: <20240115125707.1183-1-paul@xen.org>
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

v11:
 - Fixed kvm_gpc_check() to ignore memslot generation if the cache is not
   activated with a GPA. (This breakage occured during the re-work for v8).

v9:
 - Pass both GPA and HVA into __kvm_gpc_refresh() rather than overloading
   the address paraneter and using a bool flag to indicated what it is.

v8:
 - Re-worked to avoid messing with struct gfn_to_pfn_cache.
---
 include/linux/kvm_host.h | 20 +++++++++++++++++++-
 virt/kvm/pfncache.c      | 40 +++++++++++++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f2354f808d04..7994c4d16783 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1344,6 +1344,22 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
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
@@ -1398,7 +1414,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
 static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
 {
 	lockdep_assert_held(&gpc->lock);
-	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
+
+	if (gpc->gpa != KVM_XEN_INVALID_GPA)
+		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 }
 
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 97eec8ee3449..ae822bff812f 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -48,7 +48,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!gpc->active)
 		return false;
 
-	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
+	if (gpc->gpa != KVM_XEN_INVALID_GPA && gpc->generation != slots->generation)
+		return false;
+
+	if (kvm_is_error_hva(gpc->uhva))
 		return false;
 
 	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
@@ -209,11 +212,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			     unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-	unsigned long page_offset = offset_in_page(gpa);
+	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
+		offset_in_page(gpa) :
+		offset_in_page(uhva);
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
@@ -246,9 +251,15 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
 
-	/* Refresh the userspace HVA if necessary */
-	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
-	    kvm_is_error_hva(gpc->uhva)) {
+	if (gpa == KVM_XEN_INVALID_GPA) {
+		gpc->gpa = KVM_XEN_INVALID_GPA;
+		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
+
+		if (gpc->uhva != old_uhva)
+			hva_change = true;
+	} else if (gpc->gpa != gpa ||
+		   gpc->generation != slots->generation ||
+		   kvm_is_error_hva(gpc->uhva)) {
 		gfn_t gfn = gpa_to_gfn(gpa);
 
 		gpc->gpa = gpa;
@@ -319,7 +330,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 
 int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
-	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
+	return __kvm_gpc_refresh(gpc, gpc->gpa, gpc->uhva, len);
 }
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
@@ -332,7 +343,8 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->uhva = KVM_HVA_ERR_BAD;
 }
 
-int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
+static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
+			      unsigned long len)
 {
 	struct kvm *kvm = gpc->kvm;
 
@@ -353,7 +365,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
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
+	return __kvm_gpc_activate(gpc, KVM_XEN_INVALID_GPA, uhva, len);
 }
 
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
-- 
2.39.2


