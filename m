Return-Path: <linux-kselftest+bounces-8371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BC8AA325
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E1DB25D2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D250184127;
	Thu, 18 Apr 2024 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uy4dqf1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1518410C;
	Thu, 18 Apr 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469432; cv=none; b=KwY5P1GXgSlr0gD61mucDILNrrCEdqQ4yPgkPzxm3k2VDAgAY7uJVnwnssBZEVoBLG4rDT0fhIoXe3ba1MynT3CTI9eJt9g1JqJ0p+efYFTxGWRKYCKAuYsx3mm4LpsqqkNy0KipEGHx8CwQSbb2h8cejYTQAjjmw0JrHXWynT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469432; c=relaxed/simple;
	bh=48PtL5gWdzK0GYHTiXEUyz2NGhSsoaMH/8i2OTad/Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPswwFlpIKFcPaMaSA4L9c3HbWylWbfb/WgjUqM6Ama5qoKN1znz+Tr7g6xQHUZ/Q90W/WgOWelMIIDIwhVeAHMnupYeifBdL1aoGWw5ge/UvOra4Ba28T/dcCawNNVR2yJHj7iiAbXqdNFkJ8dUJUTGhnQncO0va6CqE/n2fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uy4dqf1p; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JczFER/uLfzT7v2MtR0zw58FaNHGCbQC3EHOj6U+O60=; b=Uy4dqf1pnXh8jB/sJFLUv+aaTQ
	XLgaywOlJP8OVitgRlwm0wmmQYaXypzVX2gzb0GUz3yE01DKEDB9zeZqneJIOtHtMQgcs2tuh6Ckq
	Y58kyJADhx3GuvKTAJlRhb/hDtebWBcpdfT936YU3Hgg9w5OfPGyiZ4uVI9WohKTbK/0VlAE9+L8W
	mcfJBslja6QTu8mefvidf3XKa48Gs+gqrVeA5AlxH4J7DSzagHeexCOjI0mjYS19mZB9xNLxtx36E
	OTbTbGSBBt7qCmGPDoHSUpmbMp3P/R4mlc4/7hj7PC8L4aqmlWPopXzONhBE4S+9qZIM6oVQs9H09
	sPrKg9WQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-0000000C8MP-2o6d;
	Thu, 18 Apr 2024 19:35:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-00000000Asq-0f90;
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
Subject: [PATCH 09/10] KVM: x86: Kill KVM_REQ_GLOBAL_CLOCK_UPDATE
Date: Thu, 18 Apr 2024 20:34:48 +0100
Message-ID: <20240418193528.41780-10-dwmw2@infradead.org>
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

This was introduced in commit 0061d53daf26 ("KVM: x86: limit difference
between kvmclock updates") to reduce cross-vCPU differences which arose
because the KVM clock was based on CLOCK_MONOTONIC and thus subject to
NTP frequency corrections.

However, commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
monotonic raw clock") switched to using CLOCK_MONOTONIC_RAW as the basis
for the KVM clock, avoiding the NTP frequency skew altogether.

So remove KVM_REQ_GLOBAL_CLOCK_UPDATE. In kvm_write_system_time(), all
that's needed is a single KVM_REQ_CLOCK_UPDATE for the vCPU whose KVM
clock is being configured.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/x86.c              | 57 ++-------------------------------
 2 files changed, 4 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8440c4081727..cfac72b4aa64 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -98,7 +98,7 @@
 	KVM_ARCH_REQ_FLAGS(14, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_SCAN_IOAPIC \
 	KVM_ARCH_REQ_FLAGS(15, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-#define KVM_REQ_GLOBAL_CLOCK_UPDATE	KVM_ARCH_REQ(16)
+/* KVM_ARCH_REQ(16) is available to be reused */
 #define KVM_REQ_APIC_PAGE_RELOAD \
 	KVM_ARCH_REQ_FLAGS(17, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HV_CRASH		KVM_ARCH_REQ(18)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ec4eb850c5b..f870e29d2558 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2354,13 +2354,13 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	}
 
 	vcpu->arch.time = system_time;
-	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 
 	/* we verify if the enable bit is set... */
-	if (system_time & 1)
+	if (system_time & 1) {
 		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
 				 sizeof(struct pvclock_vcpu_time_info));
-	else
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+	} else
 		kvm_gpc_deactivate(&vcpu->arch.pv_time);
 
 	return;
@@ -3391,46 +3391,6 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
 }
 
-/*
- * kvmclock updates which are isolated to a given vcpu, such as
- * vcpu->cpu migration, should not allow system_timestamp from
- * the rest of the vcpus to remain static. Otherwise ntp frequency
- * correction applies to one vcpu's system_timestamp but not
- * the others.
- *
- * So in those cases, request a kvmclock update for all vcpus.
- * We need to rate-limit these requests though, as they can
- * considerably slow guests that have a large number of vcpus.
- * The time for a remote vcpu to update its kvmclock is bound
- * by the delay we use to rate-limit the updates.
- */
-
-#define KVMCLOCK_UPDATE_DELAY msecs_to_jiffies(100)
-
-static void kvmclock_update_fn(struct work_struct *work)
-{
-	unsigned long i;
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
-					   kvmclock_update_work);
-	struct kvm *kvm = container_of(ka, struct kvm, arch);
-	struct kvm_vcpu *vcpu;
-
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
-}
-
-static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
-{
-	struct kvm *kvm = v->kvm;
-
-	kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
-	schedule_delayed_work(&kvm->arch.kvmclock_update_work,
-					KVMCLOCK_UPDATE_DELAY);
-}
-
 /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
 static bool is_mci_control_msr(u32 msr)
 {
@@ -5018,12 +4978,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		if (kvm_lapic_hv_timer_in_use(vcpu))
 			kvm_lapic_restart_hv_timer(vcpu);
 
-		/*
-		 * On a host with synchronized TSC, there is no need to update
-		 * kvmclock on vcpu->cpu migration
-		 */
-		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1)
-			kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 		if (vcpu->cpu != cpu)
 			kvm_make_request(KVM_REQ_MIGRATE_TIMER, vcpu);
 		vcpu->cpu = cpu;
@@ -10961,8 +10915,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			__kvm_migrate_timers(vcpu);
 		if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
 			kvm_update_masterclock(vcpu->kvm);
-		if (kvm_check_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu))
-			kvm_gen_kvmclock_update(vcpu);
 		if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu)) {
 			r = kvm_guest_time_update(vcpu);
 			if (unlikely(r))
@@ -12780,8 +12732,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
-	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
-
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
 	kvm_xen_init_vm(kvm);
@@ -12820,7 +12770,6 @@ static void kvm_unload_vcpu_mmus(struct kvm *kvm)
 
 void kvm_arch_sync_events(struct kvm *kvm)
 {
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
 	kvm_free_pit(kvm);
 }
 
-- 
2.44.0


