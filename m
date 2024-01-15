Return-Path: <linux-kselftest+bounces-2978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2E82D9A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB211F22087
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694B175BD;
	Mon, 15 Jan 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="MHrFpF5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD7175A5;
	Mon, 15 Jan 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=TGoYbz9rXouSd9WFL4ciI9FwoKQtj7ZUq9cOLPJ0RRg=; b=MHrFpF5IJ+PfFQlCE294QZkLS7
	j1/pDVM5hSybbNPSM6bz27B/hEc8rQyVvvivfowOtblwXmtVBmpjhVNlW+rsILZE79dR237K3WYe4
	sWL/GJ3zw5LqApPZ60YVEe5o0HHNWZ/i5HLLuN8wc99AFrvl6Mtrl/xbbb4PtGW9BywY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMiY-00035c-L6; Mon, 15 Jan 2024 13:09:30 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMXN-0002kM-4Y; Mon, 15 Jan 2024 12:57:57 +0000
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
Subject: [PATCH v12 10/20] KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
Date: Mon, 15 Jan 2024 12:56:57 +0000
Message-Id: <20240115125707.1183-11-paul@xen.org>
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
index df53fea73747..d595d476a5b3 100644
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


