Return-Path: <linux-kselftest+bounces-4771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC9856838
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058EF1F29C50
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B013474F;
	Thu, 15 Feb 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="Jc2hqxeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8F1339A7;
	Thu, 15 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011875; cv=none; b=uMccoE3SZwGNdErtcneUGkP5ziqBrICkDHYDsthZTETBoQWcMiYovu/5PQ02VB2HVedJpzVNP59EOmgHWb/X9s/QBk5UBt/iQyzHNltIfm9PSmjfY290X4JkDorMcL9w9+uP8JETBaIg1kGyz1KN0jfr6Qs/Res7GEkVzzMEhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011875; c=relaxed/simple;
	bh=3nwQ4igr4UHRdd+mgY7ZbOjy+y4K9Nat1gWNqM16aB8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nca0ZDH8udxCz4QT9uxNLUgIShDVjD31CBCqpbOOMnKhNgPpYPVxza31r6QaOtdIeGSrg3axggLHYuNPSWY4Ii3izeW3zkzuwu/UokF++2TtDtJKTOSAiCA1Hk0tGpYtO0F4TgbfuWUl/ewP+EE7IgscvL5VdeWCJLoQdwweRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=Jc2hqxeY; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=u1ta1r3MgQVT6Oph1GwmQKSncCtReBnCTMzpKGY3caE=; b=Jc2hqxeYDCBWgsreGCBjXM/BIw
	j3AlGYlS8zaYcO9vrzgZcdhd4yFQyqqqKWDMgPfjAH2z/zUH4BDoBgSRfyeg6KT6/v3xhgyO4FR4J
	zB4Cd97gfEFp79HEsvtCEnyOjNyxzYi4BK+ndLvD/Y/xpRJv3eg5OcVL2TuWQ2aeXQLA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduM-0001WS-3G; Thu, 15 Feb 2024 15:44:18 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhA-00089r-9J; Thu, 15 Feb 2024 15:30:40 +0000
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
Subject: [PATCH v13 11/21] KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is set
Date: Thu, 15 Feb 2024 15:29:06 +0000
Message-Id: <20240215152916.1158-12-paul@xen.org>
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

If the shared_info PFN cache has already been initialized then the content
of the shared_info page needs to be re-initialized whenever the guest
mode is (re)set.
Setting the guest mode is either done explicitly by the VMM via the
KVM_XEN_ATTR_TYPE_LONG_MODE attribute, or implicitly when the guest writes
the MSR to set up the hypercall page.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v13:
 - Patch title change.

v12:
 - Fix missing update of return value if mode is not actually changed.

v11:
 - Drop the hunk removing the call to kvm_xen_shared_info_init() when
   KVM_XEN_ATTR_TYPE_SHARED_INFO is set; it was a mistake and causes self-
   test failures.

v10:
 - New in this version.
---
 arch/x86/kvm/xen.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 031e98d88ba2..52edf676c471 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -625,8 +625,16 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		} else {
 			mutex_lock(&kvm->arch.xen.xen_lock);
 			kvm->arch.xen.long_mode = !!data->u.long_mode;
+
+			/*
+			 * Re-initialize shared_info to put the wallclock in the
+			 * correct place. Whilst it's not necessary to do this
+			 * unless the mode is actually changed, it does no harm
+			 * to make the call anyway.
+			 */
+			r = kvm->arch.xen.shinfo_cache.active ?
+				kvm_xen_shared_info_init(kvm) : 0;
 			mutex_unlock(&kvm->arch.xen.xen_lock);
-			r = 0;
 		}
 		break;
 
@@ -1101,9 +1109,24 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	bool lm = is_long_mode(vcpu);
+	int r = 0;
+
+	mutex_lock(&kvm->arch.xen.xen_lock);
+	if (kvm->arch.xen.long_mode != lm) {
+		kvm->arch.xen.long_mode = lm;
+
+		/*
+		 * Re-initialize shared_info to put the wallclock in the
+		 * correct place.
+		 */
+		if (kvm->arch.xen.shinfo_cache.active &&
+		    kvm_xen_shared_info_init(kvm))
+			r = 1;
+	}
+	mutex_unlock(&kvm->arch.xen.xen_lock);
 
-	/* Latch long_mode for shared_info pages etc. */
-	vcpu->kvm->arch.xen.long_mode = lm;
+	if (r)
+		return r;
 
 	/*
 	 * If Xen hypercall intercept is enabled, fill the hypercall
-- 
2.39.2


