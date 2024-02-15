Return-Path: <linux-kselftest+bounces-4773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007B985683F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AE1F2951F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE1134CDF;
	Thu, 15 Feb 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="Lwi1WzG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006CB13342F;
	Thu, 15 Feb 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011875; cv=none; b=R9NvQ1BlgR1b0F2OhUifLnfunlgnoTustsFMmdTJpjgvqvuwLmrws1Xnbk2D1s5Y95+s4bCO6npiXSOfvF/kpUlUPwnTY8iY1tajjrrufbBSbWmZiFqu9m1yYLRqyR4Ob8O0LyHviwCSRnlyYeWXReneUo9SvE9M5S40gAgxTls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011875; c=relaxed/simple;
	bh=3ks5KToNPuDxyIalRdd12ejNyyxhdMuev5Sv7mIggz0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHbr8d1J/1PUN5ET6clKsTleglY6IgKwz6fc6v85ISYw7EJHkzrwtncq5c6j1a9e799BjZ6HQWYUlZXa90JxpHQohAXWcTdCMI90C6Hwqx5g9TGeEV0BaTVK+Zahh4iALDwVuVCNQ07p1RrWv40r70CdTA1KKhbtE9r/OLfJfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=Lwi1WzG8; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=ugeE6RuPXRs11LGZ/q1O172zbRbUzYn9PYL1VdUrDHU=; b=Lwi1WzG8xermAuKqov/mOEi3Fk
	eEAIgUxuMLBBLWZcyvcY43NQx3evbfWf1urLz5PS6iInsIO+c30kmThLfjItKheQTCnvgtcQRaF+9
	JwtxsEzhIeCmjviREC937rAG+JcPc2h3CvvCPouXnK01/9Xo3cNiGtlVUnDQSuvSmjMc=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1raduL-0001WI-No; Thu, 15 Feb 2024 15:44:17 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radhX-00089r-7n; Thu, 15 Feb 2024 15:31:03 +0000
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
Subject: [PATCH v13 18/21] KVM: x86/xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
Date: Thu, 15 Feb 2024 15:29:13 +0000
Message-Id: <20240215152916.1158-19-paul@xen.org>
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

As described in [1] compiling with CONFIG_PROVE_RAW_LOCK_NESTING shows that
kvm_xen_set_evtchn_fast() is blocking on pfncache locks in IRQ context.
There is only actually blocking with PREEMPT_RT because the locks will
turned into mutexes. There is no 'raw' version of rwlock_t that can be used
to avoid that, so use read_trylock() and treat failure to lock the same as
an invalid cache.

[1] https://lore.kernel.org/lkml/99771ef3a4966a01fefd3adbb2ba9c3a75f97cf2.camel@infradead.org/T/#mbd06e5a04534ce9c0ee94bd8f1e8d942b2d45bd6

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

v11:
 - Amended the commit comment.

v10:
 - New in this version.
---
 arch/x86/kvm/xen.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 59073642c078..8650141b266e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1678,10 +1678,13 @@ static int set_shinfo_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
 	unsigned long flags;
 	int rc = -EWOULDBLOCK;
 
-	read_lock_irqsave(&gpc->lock, flags);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+	local_irq_save(flags);
+	if (!read_trylock(&gpc->lock))
 		goto out;
 
+	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+		goto out_unlock;
+
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 		struct shared_info *shinfo = gpc->khva;
 
@@ -1703,8 +1706,10 @@ static int set_shinfo_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
 		rc = 1; /* It is newly raised */
 	}
 
+ out_unlock:
+	read_unlock(&gpc->lock);
  out:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	local_irq_restore(flags);
 	return rc;
 }
 
@@ -1714,21 +1719,23 @@ static bool set_vcpu_info_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
 	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
 	unsigned long flags;
 	bool kick_vcpu = false;
+	bool locked;
 
-	read_lock_irqsave(&gpc->lock, flags);
+	local_irq_save(flags);
+	locked = read_trylock(&gpc->lock);
 
 	/*
 	 * Try to deliver the event directly to the vcpu_info. If successful and
 	 * the guest is using upcall_vector delivery, send the MSI.
-	 * If the pfncache is invalid, set the shadow. In this case, or if the
-	 * guest is using another form of event delivery, the vCPU must be
-	 * kicked to complete the delivery.
+	 * If the pfncache lock is contended or the cache is invalid, set the
+	 * shadow. In this case, or if the guest is using another form of event
+	 * delivery, the vCPU must be kicked to complete the delivery.
 	 */
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 		struct vcpu_info *vcpu_info = gpc->khva;
 		int port_word_bit = port / 64;
 
-		if (!kvm_gpc_check(gpc, sizeof(*vcpu_info))) {
+		if ((!locked || !kvm_gpc_check(gpc, sizeof(*vcpu_info)))) {
 			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
 				kick_vcpu = true;
 			goto out;
@@ -1742,7 +1749,7 @@ static bool set_vcpu_info_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
 		struct compat_vcpu_info *vcpu_info = gpc->khva;
 		int port_word_bit = port / 32;
 
-		if (!kvm_gpc_check(gpc, sizeof(*vcpu_info))) {
+		if ((!locked || !kvm_gpc_check(gpc, sizeof(*vcpu_info)))) {
 			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
 				kick_vcpu = true;
 			goto out;
@@ -1761,7 +1768,10 @@ static bool set_vcpu_info_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
 	}
 
  out:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	if (locked)
+		read_unlock(&gpc->lock);
+
+	local_irq_restore(flags);
 	return kick_vcpu;
 }
 
-- 
2.39.2


