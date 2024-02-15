Return-Path: <linux-kselftest+bounces-4758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3758567A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29691C24162
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DAB133411;
	Thu, 15 Feb 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="l/GwnRw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C3133402;
	Thu, 15 Feb 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011034; cv=none; b=tCptxWeSjAZcNrxms3dmc2UCneEUnbY/xFv7Nh2v968LaQcSw5Me1yKVmeD1+2tY6ygvvFSkmJKeymJxULUVOOYRsDbsBBmRjC7qit9TGdudmki19mW5wJcsrv5sKhUaQjgNILJXxuVPnkpHpzfZJujso09kjMhq97D/wtiksU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011034; c=relaxed/simple;
	bh=CL+Rj3ZLuJ5la4ZGM017nsWmxKEWlrMPGavFVfobjzQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOp7UkFz3S/p0RzRcDXRJBI8bxEUsKq6o0hR8ScY41sENN4hXinn/KotRXoeywibQCl31U1AfU15lC5YI90Bf+6q1n+fa8qfsM0JJOXp4I1L4dgeBPWX72dxFjJ2XPeyJ+OpSRiXQzKJ/1Ggx6CVvC0VWF2bO1HujO0O2cBJOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=l/GwnRw5; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=WWVRVO4rk5Tr7MGrSTJbAXSf75JgVNtQ8ev+YYa16zs=; b=l/GwnRw5UzfMaqCsW4OboRGYEx
	1en5wnZIj7wZTmkGsJw9OalyZeMt8Fr/GYFwD+TTN+UeMY4Qto/ZOti+Vg0JFBGXcEWN+r214tyXr
	RJ3DtJMBE5IrZv6vQQSspz3tPiXQGd71UJrWSvuxexeLWwt6K33d7E0nhHaCbehnXsEs=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgh-0001E5-1O; Thu, 15 Feb 2024 15:30:11 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgg-00089r-Od; Thu, 15 Feb 2024 15:30:10 +0000
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
Subject: [PATCH v13 02/21] KVM: pfncache: remove unnecessary exports
Date: Thu, 15 Feb 2024 15:28:57 +0000
Message-Id: <20240215152916.1158-3-paul@xen.org>
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

There is no need for the existing kvm_gpc_XXX() functions to be exported.
Clean up now before additional functions are added in subsequent patches.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

v8:
 - New in this version.
---
 virt/kvm/pfncache.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 10842f1eeeae..f3571f44d9af 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -94,7 +94,6 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(kvm_gpc_check);
 
 static void *gpc_map(kvm_pfn_t pfn)
 {
@@ -346,7 +345,6 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
 	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
 }
-EXPORT_SYMBOL_GPL(kvm_gpc_refresh);
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 		  struct kvm_vcpu *vcpu, enum pfn_cache_usage usage)
@@ -363,7 +361,6 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->pfn = KVM_PFN_ERR_FAULT;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 }
-EXPORT_SYMBOL_GPL(kvm_gpc_init);
 
 int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 {
@@ -388,7 +385,6 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 	}
 	return __kvm_gpc_refresh(gpc, gpa, len);
 }
-EXPORT_SYMBOL_GPL(kvm_gpc_activate);
 
 void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 {
@@ -426,4 +422,3 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		gpc_unmap(old_pfn, old_khva);
 	}
 }
-EXPORT_SYMBOL_GPL(kvm_gpc_deactivate);
-- 
2.39.2


