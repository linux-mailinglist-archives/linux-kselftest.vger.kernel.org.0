Return-Path: <linux-kselftest+bounces-4765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7588567C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C141F2B27B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3C135A5D;
	Thu, 15 Feb 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="T53UTQn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB36135415;
	Thu, 15 Feb 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011046; cv=none; b=o3vwp2S4FYdQAh2dqrCeeT3NAKBRapffoWiG8nTC87GG8WFRXdSc74h+VH1ZJBkj5eSN+XerUScnWHxLuGuzsP98227VnrcRtDQMIu1R5duCVSQYmKPyZGIKVGgcmNkwXzsMa+R2xPcNKCi8/Wbi7poSeT5IrhNdM24OFX4DHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011046; c=relaxed/simple;
	bh=vi1T6IhyqldodRETWHSDH1iiJsgIF+uNc74DVNJPlwg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkzJEe0hJyxniyoR/j6Gmi1FSMSYNanFN7V/ho0E2L+8Bj2zno2W3ep5e7ClRynt2LBvHaU4GRCmk3+vRrWpYJKj6nWdbDJ/72CBpvgtD5hLpOgs07jZZmLtXhFWoBrkmtWB8MYDvPXq2Mq/ftk8hRwMOIeDAOPFGfmDqbzLDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=T53UTQn1; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=TQCkPB1sujZxJovh7KF/VJS4UU1Zw/7OzvD4MgUIPi4=; b=T53UTQn1iYtfBAvej0FGk6Ex+h
	typAQdFveZLy+NCDOtIpQHj67X1puZHmPB61LiAqPXfR88KZwvl1uCdyXTiadu4ZaEXDyNr6CJoqp
	5PY+eQFpWRluHEcoWcE6BFIjhn72HONttl6eVqbRHJEQQsIHR4Cjfw8DqGGID2C3CYp4=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgx-0001Fa-EE; Thu, 15 Feb 2024 15:30:27 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgx-00089r-5V; Thu, 15 Feb 2024 15:30:27 +0000
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
Subject: [PATCH v13 07/21] KVM: pfncache: include page offset in uhva and use it consistently
Date: Thu, 15 Feb 2024 15:29:02 +0000
Message-Id: <20240215152916.1158-8-paul@xen.org>
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

Currently the pfncache page offset is sometimes determined using the gpa
and sometimes the khva, whilst the uhva is always page-aligned. After a
subsequent patch is applied the gpa will not always be valid so adjust
the code to include the page offset in the uhva and use it consistently
as the source of truth.

Also, where a page-aligned address is required, use PAGE_ALIGN_DOWN()
for clarity.

No functional change intended.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v8:
 - New in this version.
---
 virt/kvm/pfncache.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 0eeb034d0674..97eec8ee3449 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -48,10 +48,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!gpc->active)
 		return false;
 
-	if (offset_in_page(gpc->gpa) + len > PAGE_SIZE)
+	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
 		return false;
 
-	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
+	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
 		return false;
 
 	if (!gpc->valid)
@@ -119,7 +119,7 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
-	void *old_khva = gpc->khva - offset_in_page(gpc->khva);
+	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long mmu_seq;
@@ -192,7 +192,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-	gpc->khva = new_khva + offset_in_page(gpc->gpa);
+	gpc->khva = new_khva + offset_in_page(gpc->uhva);
 
 	/*
 	 * Put the reference to the _new_ pfn.  The pfn is now tracked by the
@@ -217,6 +217,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
+	bool hva_change = false;
 	void *old_khva;
 	int ret;
 
@@ -242,10 +243,10 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 	}
 
 	old_pfn = gpc->pfn;
-	old_khva = gpc->khva - offset_in_page(gpc->khva);
-	old_uhva = gpc->uhva;
+	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
+	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
 
-	/* If the userspace HVA is invalid, refresh that first */
+	/* Refresh the userspace HVA if necessary */
 	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
 	    kvm_is_error_hva(gpc->uhva)) {
 		gfn_t gfn = gpa_to_gfn(gpa);
@@ -259,13 +260,25 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
 			ret = -EFAULT;
 			goto out;
 		}
+
+		/*
+		 * Even if the GPA and/or the memslot generation changed, the
+		 * HVA may still be the same.
+		 */
+		if (gpc->uhva != old_uhva)
+			hva_change = true;
+	} else {
+		gpc->uhva = old_uhva;
 	}
 
+	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
+	gpc->uhva += page_offset;
+
 	/*
 	 * If the userspace HVA changed or the PFN was already invalid,
 	 * drop the lock and do the HVA to PFN lookup again.
 	 */
-	if (!gpc->valid || old_uhva != gpc->uhva) {
+	if (!gpc->valid || hva_change) {
 		ret = hva_to_pfn_retry(gpc);
 	} else {
 		/*
-- 
2.39.2


