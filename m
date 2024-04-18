Return-Path: <linux-kselftest+bounces-8370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E438F8AA318
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218841C229E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3950194C72;
	Thu, 18 Apr 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BejXjR1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41857194C68;
	Thu, 18 Apr 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469391; cv=none; b=hDjdm+FETTmwBsY9g463VlZD/L+HCv7ZCj2v+phnDlFcvjCYI1Q2pcLW+/PE6I4OqSwjkQTrdX8dkJEPO+hyfMWnLcvdP1g0JzYb+dR2t56G16UzZQrQTzEzcJHevvAFxBEgzu+X3+hZ01/FIZUW9OkjmwyWY0WFLP7CeuEFyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469391; c=relaxed/simple;
	bh=sKiS3ZpuiMcyy6TXTSQWYzInni8lO/cauQ/w7u1huLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zhi8i4fdODFIsWqqKNVnDCW1IwczHWEvnVtbZxq3IG/du3bUDyz1xWk64ck18CKJAiLkiIJ6RGiV/wLCCEkroic3AwS/64AnS6TCFmLff2csmQzVttRr3OR4iYMk75cbUBzLkMc0M1PZFn2lNpyiF9T2H4uRDJiIiWcm5ff2spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BejXjR1u; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i9sb97HlDBeFt7Dzk4l2/rP13VZEgB89kjbsK1Zc/xw=; b=BejXjR1uHxkx+p3/+TiibdhHXQ
	PtsKwTNFODrLbBlIryBYhdZz8oBvULnCeOHMk42fQYjBjX2reRUoZNYRvkk1sW4bJLw7cVGhiTgL4
	m4ksz/rnYeONj+9lFYf0qIHsOLXEdGi+TauE+mp8qwniNvvNQ0vRKwZ8Oxu30EBrX0xJ+ay2jCYxm
	mxZS28tWvwzsmfI8IyXdkTDyR5EO8vqo+zYHlvDohOknWHJjggjBwMt0XQTBenJtObYAkjvFqrAFq
	RrJP3sm9iOGO8V08Wjt+Q7fpxVdEArKOImG6hcqqKOfc/ArtJVWwC9sh7XJj+dAW6JRHJOYFSG+Vt
	gDj3rBxA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-0000000C8MO-2jYq;
	Thu, 18 Apr 2024 19:35:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-00000000Asm-0LxX;
	Thu, 18 Apr 2024 20:35:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	jalliste@amazon.co.uk,
	sveith@amazon.de
Subject: [PATCH 08/10] KVM: x86: Remove periodic global clock updates
Date: Thu, 18 Apr 2024 20:34:47 +0100
Message-ID: <20240418193528.41780-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418193528.41780-1-dwmw2@infradead.org>
References: <20240418193528.41780-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

This effectively reverts commit 332967a3eac0 ("x86: kvm: introduce
periodic global clock updates"). The periodic update was introduced to
propagate NTP corrections to the guest KVM clock, when the KVM clock was
based on CLOCK_MONOTONIC.

However, commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
monotonic raw clock") switched to using CLOCK_MONOTONIC_RAW as the basis
for the KVM clock, avoiding the NTP frequency skew altogether.

So the periodic update serves no purpose. Remove it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44b3d2a0da5b..4ec4eb850c5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -155,9 +155,6 @@ EXPORT_SYMBOL_GPL(report_ignored_msrs);
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
-static bool __read_mostly kvmclock_periodic_sync = true;
-module_param(kvmclock_periodic_sync, bool, 0444);
-
 /* tsc tolerance in parts per million - default to 1/2 of the NTP threshold */
 static u32 __read_mostly tsc_tolerance_ppm = 250;
 module_param(tsc_tolerance_ppm, uint, 0644);
@@ -3434,20 +3431,6 @@ static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
 					KVMCLOCK_UPDATE_DELAY);
 }
 
-#define KVMCLOCK_SYNC_PERIOD (300 * HZ)
-
-static void kvmclock_sync_fn(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
-					   kvmclock_sync_work);
-	struct kvm *kvm = container_of(ka, struct kvm, arch);
-
-	schedule_delayed_work(&kvm->arch.kvmclock_update_work, 0);
-	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
-					KVMCLOCK_SYNC_PERIOD);
-}
-
 /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
 static bool is_mci_control_msr(u32 msr)
 {
@@ -12416,8 +12399,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = vcpu->kvm;
-
 	if (mutex_lock_killable(&vcpu->mutex))
 		return;
 	vcpu_load(vcpu);
@@ -12428,10 +12409,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.msr_kvm_poll_control = 1;
 
 	mutex_unlock(&vcpu->mutex);
-
-	if (kvmclock_periodic_sync && vcpu->vcpu_idx == 0)
-		schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
-						KVMCLOCK_SYNC_PERIOD);
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -12804,7 +12781,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 #endif
 
 	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
-	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
 
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
@@ -12844,7 +12820,6 @@ static void kvm_unload_vcpu_mmus(struct kvm *kvm)
 
 void kvm_arch_sync_events(struct kvm *kvm)
 {
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
 	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
 	kvm_free_pit(kvm);
 }
-- 
2.44.0


