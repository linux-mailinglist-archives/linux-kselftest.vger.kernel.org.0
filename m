Return-Path: <linux-kselftest+bounces-1069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B24803839
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254BE1C20A65
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939628E3A;
	Mon,  4 Dec 2023 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="hjp0SqUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A1C125
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=ptFuN2jCQTukRrWUGFV9UbE6tldJktPz8nHhLhWjreU=; b=hjp0SqUPe/G7dgYIalb+sdTM2U
	HnS9e3Cz/nikgNFzgekg1PBRIZWAiRg5jpXMB1YUs2aQQFe8cgHQoHEQNZKr3jLvSTOlz+7ilGkJ4
	EKxiBcFM8CqeGQdGFk/WGV2Tg/vXxhpW0SceVIGsDQyt+ufcSKsNVlfvQ64+z1Lac6jQ=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAAz-0003dk-AF; Mon, 04 Dec 2023 14:44:01 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rAAAz-00088g-13; Mon, 04 Dec 2023 14:44:01 +0000
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
Subject: [PATCH v10 03/19] KVM: xen: mark guest pages dirty with the pfncache lock held
Date: Mon,  4 Dec 2023 14:43:18 +0000
Message-Id: <20231204144334.910-4-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204144334.910-1-paul@xen.org>
References: <20231204144334.910-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

Sampling gpa and memslot from an unlocked pfncache may yield inconsistent
values so, since there is no problem with calling mark_page_dirty_in_slot()
with the pfncache lock held, relocate the calls in
kvm_xen_update_runstate_guest() and kvm_xen_inject_pending_events()
accordingly.

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

v8:
 - New in this version.
---
 arch/x86/kvm/xen.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e53fad915a62..426306022c2f 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -452,14 +452,13 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		smp_wmb();
 	}
 
-	if (user_len2)
+	if (user_len2) {
+		mark_page_dirty_in_slot(v->kvm, gpc2->memslot, gpc2->gpa >> PAGE_SHIFT);
 		read_unlock(&gpc2->lock);
-
-	read_unlock_irqrestore(&gpc1->lock, flags);
+	}
 
 	mark_page_dirty_in_slot(v->kvm, gpc1->memslot, gpc1->gpa >> PAGE_SHIFT);
-	if (user_len2)
-		mark_page_dirty_in_slot(v->kvm, gpc2->memslot, gpc2->gpa >> PAGE_SHIFT);
+	read_unlock_irqrestore(&gpc1->lock, flags);
 }
 
 void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
@@ -565,13 +564,13 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 			     : "0" (evtchn_pending_sel32));
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
+
+	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
 		kvm_xen_inject_vcpu_vector(v);
-
-	mark_page_dirty_in_slot(v->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
 }
 
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
-- 
2.39.2


