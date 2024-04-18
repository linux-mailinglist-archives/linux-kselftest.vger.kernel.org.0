Return-Path: <linux-kselftest+bounces-8363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4138AA2DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B5B21AB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881ED1802C9;
	Thu, 18 Apr 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/Bbmdpm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C1179204;
	Thu, 18 Apr 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468936; cv=none; b=AHJgMNTFdSYhRjaqn7Z8fgbhknGgmVoI18JXcYHe/m5DUiwMayRINy70QtIR2Spz7XMeHf+XF3AdYL75iIitTT1EQkHyUawkEchOvGmqPEwGpoO4SDAkBDbD2VQLqYDOXAPCkW0hi7nR8ez2mR3Bjlu+v8ZnHog8H8TMufh+aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468936; c=relaxed/simple;
	bh=8Q5mHERO3TSsf9UBiBduLaMBg9k96KmVbsHQLPWjcu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H36F50v4iCkzgqW52vfoodi+jYWbKTsXOiy0tlhlB/fzs3yyQza3QZxaOGoGZ6xnJj0wvSqr3Yyc6FAH9LDIhgRnoiZmAmY2FYgHaAmkLm3GxFkyLm+tRwHKRwCjcCPRUNsvn/4ikRCj+zzFQqc0n3gixQ6Ceqp9yiy3Vw+tNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J/Bbmdpm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hX4HLV/CfHBx1G0t4ug9fAZz09QcMHZGPcRafQhkYa4=; b=J/BbmdpmevtDd/uokShWGlYYjd
	/TwpZDY5GkWyg989M8XEmXu0Mo+cI22qFss8N/OCarIkR42Wl3jAhTg3dKAoAf2XkiA49ZPaidM2x
	AjlnxcWsW6G1yxGV6l2p8BeHZt9SLPQuuh3KYx9V1BmVDujaPKoCF3a5DY8jX+NIZ9cer9aznCR3n
	kRuXOSo19RGy3DXqqCP6NHNrsdZxTv7f50A8bdeX98OIqjJw8xZDimpfaUNPwc0N6DtitH1XKNv0y
	VHR4eOowQZGPKvdatgDe7FsXboFxk4+u4EIclauuELL0FXptH7D41QBBd/uzCzNTtPumZVP0hlzEe
	51Y1qDHw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-000000060xf-1u7B;
	Thu, 18 Apr 2024 19:35:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-00000000Asi-01VS;
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
Subject: [PATCH 07/10] KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
Date: Thu, 18 Apr 2024 20:34:46 +0100
Message-ID: <20240418193528.41780-8-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to monotonic raw
clock") did so only for 64-bit hosts, by capturing the boot offset from
within the existing clocksource notifier update_pvclock_gtod().

That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
clocksource changes") but only on x86_64, because its original purpose
was just to disable the "master clock" mode which is only supported on
x86_64.

Now that the notifier is used for more than disabling master clock mode,
(well, OK, more than a decade later but clocks are hard), enable it for
the 32-bit build too so that get_kvmclock_base_ns() can be unaffected by
NTP sync on 32-bit too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 00a7c1188dec..44b3d2a0da5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2245,7 +2245,6 @@ static int do_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	return kvm_set_msr_ignored_check(vcpu, index, *data, true);
 }
 
-#ifdef CONFIG_X86_64
 struct pvclock_clock {
 	int vclock_mode;
 	u64 cycle_last;
@@ -2303,13 +2302,6 @@ static s64 get_kvmclock_base_ns(void)
 	/* Count up from boot time, but with the frequency of the raw clock.  */
 	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
 }
-#else
-static s64 get_kvmclock_base_ns(void)
-{
-	/* Master clock not used, so we can just use CLOCK_BOOTTIME.  */
-	return ktime_get_boottime_ns();
-}
-#endif
 
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
 {
@@ -9819,6 +9811,7 @@ static void pvclock_irq_work_fn(struct irq_work *w)
 }
 
 static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
+#endif
 
 /*
  * Notification about pvclock gtod data update.
@@ -9826,26 +9819,26 @@ static DEFINE_IRQ_WORK(pvclock_irq_work, pvclock_irq_work_fn);
 static int pvclock_gtod_notify(struct notifier_block *nb, unsigned long unused,
 			       void *priv)
 {
-	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
 	struct timekeeper *tk = priv;
 
 	update_pvclock_gtod(tk);
 
+#ifdef CONFIG_X86_64
 	/*
 	 * Disable master clock if host does not trust, or does not use,
 	 * TSC based clocksource. Delegate queue_work() to irq_work as
 	 * this is invoked with tk_core.seq write held.
 	 */
-	if (!gtod_is_based_on_tsc(gtod->clock.vclock_mode) &&
+	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode) &&
 	    atomic_read(&kvm_guest_has_master_clock) != 0)
 		irq_work_queue(&pvclock_irq_work);
+#endif
 	return 0;
 }
 
 static struct notifier_block pvclock_gtod_notifier = {
 	.notifier_call = pvclock_gtod_notify,
 };
-#endif
 
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
@@ -9984,9 +9977,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	if (pi_inject_timer == -1)
 		pi_inject_timer = housekeeping_enabled(HK_TYPE_TIMER);
-#ifdef CONFIG_X86_64
+
 	pvclock_gtod_register_notifier(&pvclock_gtod_notifier);
 
+#ifdef CONFIG_X86_64
 	if (hypervisor_is_type(X86_HYPER_MS_HYPERV))
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
-- 
2.44.0


