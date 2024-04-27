Return-Path: <linux-kselftest+bounces-8985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC28B4600
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ABF1F24962
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E14F88E;
	Sat, 27 Apr 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C/3S/7g2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F54D9F9;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216889; cv=none; b=hfhi39zbpOnaNSvTXLSs83uyrsNDGXeN+ETMzmXerOgwE5iZUehRO0nuy7/gAoX1mi6hZlwfH+ZP1o3YJKiayItWCfs+wrBkiAATJRsOI+EO8UYp88BCypQkYSKQWvQtnYhLnccMmSEN0yqhwd3NdXzR+hmloCTUDXaDYDxzZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216889; c=relaxed/simple;
	bh=zr1wUci8Xcm3SBmkDautJw+akuAPWZdTnl8cPxx2GoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFxhoiU6CXo+zp2/hn9HqES5PpkMogX7TwgH9rEQloZ5Pipwy5RMx+RaDC+13DPtj/WHAKAs0P7mDnyrJrGBWLJzq/4pQIMkGuzyJnoMZC3K2CvQKxCtDMrUMaPR9S+Eopr4sDALn2grDF/jz5w2oFzdRDxSuz+3IH6kbAJV5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C/3S/7g2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5S2tW55GgDiFyBbw9lOzLrSN36Zzgu35eCfjV6r8WLE=; b=C/3S/7g2ZpEyQRx09JvWZeaGRy
	MstfydVMSKmDzDiNWQsVmHHabx9OQfnIVGuuynHfWhe7zBkqZrWPjQes73h15FdkhnTrE6PNu9LBi
	b14a6T+iiBXVFXYMoIITDFCnXOq/qlapJsNYPQ6D5yagLsv8JVtf0F1dfuAFc8dvnkGYjNQq558Pj
	BG4m/Ka0KD//ict8yEwYLWcCwuAqOybLY5jafWitwsG68L44u03utA67Qq97DkEKxNombNr+q3Vo7
	RdniFSrdGS2PzHBGd0tvRjFWa3WUuvJ++CudOpdwkUgDJ0giXjFwnSRrz/nUKPm/lyjRzdmhy4hhM
	dyxiJD2w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5i-0000000FeZk-0pka;
	Sat, 27 Apr 2024 11:19:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bx-2nxs;
	Sat, 27 Apr 2024 12:19:36 +0100
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
	sveith@amazon.de,
	zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v2 15/15] KVM: x86: Factor out kvm_use_master_clock()
Date: Sat, 27 Apr 2024 12:05:12 +0100
Message-ID: <20240427111929.9600-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427111929.9600-1-dwmw2@infradead.org>
References: <20240427111929.9600-1-dwmw2@infradead.org>
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

Both kvm_track_tsc_matching() and pvclock_update_vm_gtod_copy() make a
decision about whether the KVM clock should be in master clock mode.

They use *different* criteria for the decision though. This isn't really
a problem; it only has the potential to cause unnecessary invocations of
KVM_REQ_MASTERCLOCK_UPDATE if the masterclock was disabled due to TSC
going backwards, or the guest using the old MSR. But it isn't pretty.

Factor the decision out to a single function. And document the historical
reason why it's disabled for guests that use the old MSR_KVM_SYSTEM_TIME.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d6e4469f531a..680b39f17851 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2518,6 +2518,27 @@ static inline bool gtod_is_based_on_tsc(int mode)
 }
 #endif
 
+static bool kvm_use_master_clock(strut kvm *kvm)
+{
+	struct kvm_arch *ka = &kvm->arch;
+
+	/*
+	 * The 'old kvmclock' check is a workaround (from 2015) for a
+	 * SUSE 2.6.16 kernel that didn't boot if the system_time in
+	 * its kvmclock was too far behind the current time. So the
+	 * mode of just setting the reference point and allowing time
+	 * to proceed linearly from there makes it fail to boot.
+	 * Despite that being kind of the *point* of the way the clock
+	 * is exposed to the guest. By coincidence, the offending
+	 * kernels used the old MSR_KVM_SYSTEM_TIME, which was moved
+	 * only because it resided in the wrong number range. So the
+	 * workaround is activated for *all* guests using the old MSR.
+	 */
+	return ka->all_vcpus_matched_tsc &&
+		!ka->backwards_tsc_observed &&
+		!ka->boot_vcpu_runs_old_kvmclock;
+}
+
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
@@ -2550,7 +2571,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 	 * To use the masterclock, the host clocksource must be based on TSC
 	 * and all vCPUs must have matching TSC frequencies.
 	 */
-	bool use_master_clock = ka->all_vcpus_matched_tsc &&
+	bool use_master_clock = kvm_use_master_clock(kvm) &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -3089,9 +3110,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_cycle_now);
 
 	ka->use_master_clock = host_tsc_clocksource
-				&& ka->all_vcpus_matched_tsc
-				&& !ka->backwards_tsc_observed
-				&& !ka->boot_vcpu_runs_old_kvmclock;
+				&& kvm_use_master_clock(kvm);
 
 	/*
 	 * When TSC scaling is in use (which can thankfully only happen
-- 
2.44.0


