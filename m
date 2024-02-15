Return-Path: <linux-kselftest+bounces-4768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7A85682D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7009A281E43
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6113343E;
	Thu, 15 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="wOERm6ZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B8131E32;
	Thu, 15 Feb 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011872; cv=none; b=u3tau9wW1xXZF/ic6t0Z2NqTe+seSHubrVhy+QsC6EBxxhnWmM21cQ48Tf7Gde068ISvNdv1BqK32PP5bENKcy8S/ZpYaY+igy647U+ZXa9TBvQzC4FCC8SltQt/TPRO/ai9c7ZxwjaI3rFZOYm4A61U58ZMJP3qd0k5OMJE41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011872; c=relaxed/simple;
	bh=tf6LMRayvs8aoSZxiqZEwaZ7V5TgcIo9fVJuyWSO+FU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIbkIkbfq95LFtAdnYBXvTYW5WXkvUI8pwJCZxe9tw9Hqj+ruhCEzlj1fO1wU8tQzkYNKaSxV/lTzsaWJsrgjFPtPcE8qhoJq/JIo+dyZG8J1OOAMEFPhPa9jsLDTDgWkvGtq9WimbL5LCb3gw4Z6FKiK6Be9tjzIBpBjbbBNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=wOERm6ZT; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=I+0HAEEY7B8ebrh7W7mzXaPfOq28o4tU8rT0p+AqpXE=; b=wOERm6ZTM/pzHUgQEadMvJJAX3
	PDRpCWSkDxShRD5XRBxbf1et0sPLU3iAt1IbskBDHW/J8BU/g8YpTS1anHfvaF0bKlU1WFfLcbMFz
	JDd+Zzm2ACaDvFpGoWLTWLSyL0gFq+2eJ/LcA/mJQz/1+DJF0P7MkfJcWIWbsgx6sf18=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduL-0001WM-SP; Thu, 15 Feb 2024 15:44:17 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhd-00089r-Po; Thu, 15 Feb 2024 15:31:10 +0000
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
Subject: [PATCH v13 20/21] KVM: x86/xen: allow vcpu_info content to be 'safely' copied
Date: Thu, 15 Feb 2024 15:29:15 +0000
Message-Id: <20240215152916.1158-21-paul@xen.org>
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

If the guest sets an explicit vcpu_info GPA then, for any of the first 32
vCPUs, the content of the default vcpu_info in the shared_info page must be
copied into the new location. Because this copy may race with event
delivery (which updates the 'evtchn_pending_sel' field in vcpu_info) there
needs to be a way to defer that until the copy is complete.
Happily there is already a shadow of 'evtchn_pending_sel' in kvm_vcpu_xen
that is used in atomic context if the vcpu_info PFN cache has been
invalidated so that the update of vcpu_info can be deferred until the
cache can be refreshed (on vCPU thread's the way back into guest context).

Also use this shadow if the vcpu_info cache has been *deactivated*, so that
the VMM can safely copy the vcpu_info content and then re-activate the
cache with the new GPA. To do this, stop considering an inactive vcpu_info
cache as a hard error in kvm_xen_set_evtchn_fast().

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

v13:
 - Patch title change.

v8:
 - Update commit comment.

v6:
 - New in this version.
---
 arch/x86/kvm/xen.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8650141b266e..11ab62ca011d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1802,9 +1802,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (!vcpu->arch.xen.vcpu_info_cache.active)
-		return -EINVAL;
-
 	if (xe->port >= max_evtchn_port(kvm))
 		return -EINVAL;
 
-- 
2.39.2


