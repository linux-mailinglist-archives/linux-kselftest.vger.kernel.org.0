Return-Path: <linux-kselftest+bounces-4761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB498567B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF82283DCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF05133419;
	Thu, 15 Feb 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="uN7n7u9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8B1350C1;
	Thu, 15 Feb 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011040; cv=none; b=LjgyUqcgIEq5oPiaXEgz/pl0zrQoO5fnoX2ibChTVr4gVLtQYL8MUOG1fuUv2hK8kcSyqxEDDl3iuOp0Vz3jyFB+UsRPXkvg5GuUYyBNKq+HWkPrvjjehgUSc7luflChnfSmOORRxf4bl/N71xJgvmejumOqb2K52/OT+sDhBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011040; c=relaxed/simple;
	bh=R8mjm6bTMdSdKqKArLsYNQPe2oXTn04HDiw3MW+30do=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgyNRQnmDeUX2cAY8PnjMYHlDgVgryiSQXPuxQVvXwordZPOMEVKhyUMVvoSHBG/VaFt5pSNUYt8ud+xCCuPJl+9e4l47oyMxmAZX8naLmTUDcWLR/FNZ1jXHtl4P5XkCecbYKd5fYoEaJIcBe5sWlF+Ot3ruNCixFbsS9C2pbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=uN7n7u9Q; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=DVmkuHvAJAn35Oz9caMUxenePj8iuuNulYJyd17+sk4=; b=uN7n7u9QS1Sm1pOOOlhRLCrfcV
	g/qevuY49oxJ5QtFWbF4Wnu8gLqzuDqXrdUCqK6TOjJXAuT46wWIG5zTi+Pfc2UQKl4DZzftLPpvt
	/igCmUawwEcNjKWix9bVW5A68/uYt+ZiBXnqPbeuHUpExhAotK3N35oSeEXgKGDNeuLU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgd-0001Dx-R7; Thu, 15 Feb 2024 15:30:07 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgd-00089r-Fl; Thu, 15 Feb 2024 15:30:07 +0000
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
Subject: [PATCH v13 01/21] KVM: pfncache: Add a map helper function
Date: Thu, 15 Feb 2024 15:28:56 +0000
Message-Id: <20240215152916.1158-2-paul@xen.org>
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

There is a pfncache unmap helper but mapping is open-coded. Arguably this
is fine because mapping is done in only one place, hva_to_pfn_retry(), but
adding the helper does make that function more readable.

No functional change intended.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

v8:
 - Re-work commit comment.
 - Fix CONFIG_HAS_IOMEM=n build.
---
 virt/kvm/pfncache.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2d6aba677830..10842f1eeeae 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -96,17 +96,32 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_gpc_check);
 
-static void gpc_unmap_khva(kvm_pfn_t pfn, void *khva)
+static void *gpc_map(kvm_pfn_t pfn)
 {
-	/* Unmap the old pfn/page if it was mapped before. */
-	if (!is_error_noslot_pfn(pfn) && khva) {
-		if (pfn_valid(pfn))
-			kunmap(pfn_to_page(pfn));
+	if (pfn_valid(pfn))
+		return kmap(pfn_to_page(pfn));
+
 #ifdef CONFIG_HAS_IOMEM
-		else
-			memunmap(khva);
+	return memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
+#else
+	return NULL;
 #endif
+}
+
+static void gpc_unmap(kvm_pfn_t pfn, void *khva)
+{
+	/* Unmap the old pfn/page if it was mapped before. */
+	if (is_error_noslot_pfn(pfn) || !khva)
+		return;
+
+	if (pfn_valid(pfn)) {
+		kunmap(pfn_to_page(pfn));
+		return;
 	}
+
+#ifdef CONFIG_HAS_IOMEM
+	memunmap(khva);
+#endif
 }
 
 static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
@@ -175,7 +190,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			 * the existing mapping and didn't create a new one.
 			 */
 			if (new_khva != old_khva)
-				gpc_unmap_khva(new_pfn, new_khva);
+				gpc_unmap(new_pfn, new_khva);
 
 			kvm_release_pfn_clean(new_pfn);
 
@@ -193,15 +208,11 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * too must be done outside of gpc->lock!
 		 */
 		if (gpc->usage & KVM_HOST_USES_PFN) {
-			if (new_pfn == gpc->pfn) {
+			if (new_pfn == gpc->pfn)
 				new_khva = old_khva;
-			} else if (pfn_valid(new_pfn)) {
-				new_khva = kmap(pfn_to_page(new_pfn));
-#ifdef CONFIG_HAS_IOMEM
-			} else {
-				new_khva = memremap(pfn_to_hpa(new_pfn), PAGE_SIZE, MEMREMAP_WB);
-#endif
-			}
+			else
+				new_khva = gpc_map(new_pfn);
+
 			if (!new_khva) {
 				kvm_release_pfn_clean(new_pfn);
 				goto out_error;
@@ -326,7 +337,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	mutex_unlock(&gpc->refresh_lock);
 
 	if (unmap_old)
-		gpc_unmap_khva(old_pfn, old_khva);
+		gpc_unmap(old_pfn, old_khva);
 
 	return ret;
 }
@@ -412,7 +423,7 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		list_del(&gpc->list);
 		spin_unlock(&kvm->gpc_lock);
 
-		gpc_unmap_khva(old_pfn, old_khva);
+		gpc_unmap(old_pfn, old_khva);
 	}
 }
 EXPORT_SYMBOL_GPL(kvm_gpc_deactivate);
-- 
2.39.2


