Return-Path: <linux-kselftest+bounces-4770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547F5856833
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AD31F29715
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AFF134730;
	Thu, 15 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="sISZNeaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D42133988;
	Thu, 15 Feb 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011874; cv=none; b=ElBPpwr3jAzrjbYA9jkE2YXXAvZKcKtM/PBJ7n1kiwlRsh9bTQB4dhuT7LzNymHTtuV5jzVZNgTNMt7nNZMDtlBnw+W02LAUS19F+wpplPTSUTBIo4yQess1ym0k1feFstL65cg77YscgRIF6lQ3o2Lutbx7DSWry+gCxj+285I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011874; c=relaxed/simple;
	bh=VRnws1u5TYtqSIKl1DEqeV2+fWCO5s7JpMyqvcgXJYM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR5zQBSpQA/ogZzfb5pjv06v7F7+2ODuWO6jCo87akvS24rj/Ca6RsJRf3c6Fp18tV758o3pzmP+zhWFNoi8sqvrBe/IoewduwSHpVumQ0rD0sTltUc0FWZKMyg2p3j/8bkdiXMoNGcAZuOAcujrh9Bdvptb6m+8Njzw5KrxwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=sISZNeaz; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=oWxMi1Cq+3Oy+z1gazw2wQP+W9Y2VE65Jj+9Nc1gV68=; b=sISZNeazYwXkmpW0QAtc8+qM7X
	OL8hHyHTqik5cMz7/ZF2Waa781QdxDJFHdexNBwSXkTl7ypiR4boD8SkdUWWPttcH0188tvtNFpgV
	lxcv5DL+NECOzEQBPJPtSDb1V/DCcDGjpZomHyNLbBBgj30oOyngWldXLu285+EG63Tg=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduM-0001Wa-Ck; Thu, 15 Feb 2024 15:44:18 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radha-00089r-Gp; Thu, 15 Feb 2024 15:31:06 +0000
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
Subject: [PATCH v13 19/21] KVM: pfncache: check the need for invalidation under read lock first
Date: Thu, 15 Feb 2024 15:29:14 +0000
Message-Id: <20240215152916.1158-20-paul@xen.org>
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

When processing mmu_notifier invalidations for gpc caches, pre-check for
overlap with the invalidation event while holding gpc->lock for read, and
only take gpc->lock for write if the cache needs to be invalidated.  Doing
a pre-check without taking gpc->lock for write avoids unnecessarily
contending the lock for unrelated invalidations, which is very beneficial
for caches that are heavily used (but rarely subjected to mmu_notifier
invalidations).

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v13:
 - Use Sean's preferred wording for the commit comment.

v10:
 - New in this version.
---
 virt/kvm/pfncache.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 4e64d349b2f7..a60d8f906896 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -29,14 +29,30 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 
 	spin_lock(&kvm->gpc_lock);
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
-		write_lock_irq(&gpc->lock);
+		read_lock_irq(&gpc->lock);
 
 		/* Only a single page so no need to care about length */
 		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
 		    gpc->uhva >= start && gpc->uhva < end) {
-			gpc->valid = false;
+			read_unlock_irq(&gpc->lock);
+
+			/*
+			 * There is a small window here where the cache could
+			 * be modified, and invalidation would no longer be
+			 * necessary. Hence check again whether invalidation
+			 * is still necessary once the write lock has been
+			 * acquired.
+			 */
+
+			write_lock_irq(&gpc->lock);
+			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
+			    gpc->uhva >= start && gpc->uhva < end)
+				gpc->valid = false;
+			write_unlock_irq(&gpc->lock);
+			continue;
 		}
-		write_unlock_irq(&gpc->lock);
+
+		read_unlock_irq(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
 }
-- 
2.39.2


