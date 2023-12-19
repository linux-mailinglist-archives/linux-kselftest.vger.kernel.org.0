Return-Path: <linux-kselftest+bounces-2220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280B818C85
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D761C24689
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C201DA22;
	Tue, 19 Dec 2023 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="PHo4QIvo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CE35896;
	Tue, 19 Dec 2023 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=AmbsIYupXhNEc+M3GAmFapvv+1Q9WOxTLba1bFXRLxM=; b=PHo4QIvo76d/X2kPOjUoZ5S0U0
	vCjgR8KBqfgSBjMRuvjhQWkAGLcJbAfPHuhUu/WAFmVHrvXewvzknGM2a5uLuMrlbfLq5s9Nw/6Qb
	orT5HrYtc5BIlsxtq7TYgXWVhvF2AQebyZasGjsUiBEFmkMnGz7w88ShhPHlbxIEZXJo=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFd9x-00064v-VF; Tue, 19 Dec 2023 16:41:33 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFckU-0005h9-1N; Tue, 19 Dec 2023 16:15:14 +0000
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
Subject: [PATCH v11 19/19] KVM: xen: allow vcpu_info content to be 'safely' copied
Date: Tue, 19 Dec 2023 16:11:09 +0000
Message-Id: <20231219161109.1318-20-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219161109.1318-1-paul@xen.org>
References: <20231219161109.1318-1-paul@xen.org>
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

v8:
 - Update commit comment.

v6:
 - New in this version.
---
 arch/x86/kvm/xen.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 845ff23c8399..99eeb9b68a02 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1799,9 +1799,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (!vcpu->arch.xen.vcpu_info_cache.active)
-		return -EINVAL;
-
 	if (xe->port >= max_evtchn_port(kvm))
 		return -EINVAL;
 
-- 
2.39.2


