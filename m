Return-Path: <linux-kselftest+bounces-8980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841348B45EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406612839C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7452F99;
	Sat, 27 Apr 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EW4mog1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB84A9B0;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216788; cv=none; b=MZJ5T/jzy5AsBapZ2YFREr9idw2tabc6iMvvXtK737Xs5XW1eUsMoOeaTOGgX3LfaNvj77T3yOKxw6J8a+fQsWic22frqV8PCDfl9+6EAIIcdNVnA3aP8/gQrAbTsgRIeA56P3P7CbUjelAodUzGYWQHvQkTijfSHKq6c7mWbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216788; c=relaxed/simple;
	bh=FXVbI53kMUIk3s8ZwOkCgeW5irzl7IqL/j7LaA+AMnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIT9lWbPwQWX6oIR6zQzH42ZlznhTL9aw60FKeparWYA5NTulxMT/gHbRs5rlzsD0JZ6eT2GaVnIfo1NxE+/XdF0eXoykU27P2S+hXpchO34UgHo3SxaMJ4GqNVq6m8ybsEfx0ZHa8HuRSaVeDRuCzgdaivHq0oJmhUQmj9qZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EW4mog1I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LALc/bAqLW4N1gPsYPS8g1LSDRY587EmxjBj1JGD6w4=; b=EW4mog1I1og+C22nCa7OL3BVdo
	0U07dr28v2ZsctJgyPis45cjA63m7ihf8T+isJckexNNSDGW0+kPzakTZh3wtqJ+oVZVxAyLVHgFj
	u44JHtI/6kDQgKke5syvbHSBbwYeqOU1DDFTYBuQqZdPc79ana5HuKKrSZK6vHlH6JTSmW64jyuaX
	CTwHSz5sv0YIeEvaPF5SHZ/Mg4FT8KfO2Agx98qIcDTQVbvlWyo9WfKdXcG1o49yy/aTJ8PePHfFX
	MCw1xyxSd1SjIQWLmoz924SELQRuaTlP32Zdm7uAru4ilNpkyL154hIEC8uKv7lVZjVmN08PNl1/3
	02NAqmAw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-00000007Jwq-45Ox;
	Sat, 27 Apr 2024 11:19:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bt-2aLX;
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
Subject: [PATCH v2 14/15] KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
Date: Sat, 27 Apr 2024 12:05:11 +0100
Message-ID: <20240427111929.9600-15-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

There is no reason why the KVM clock cannot be in masterclock mode when
the TSCs are not in sync, as long as they are at the same *frequency*.

Running at a different frequency would lead to a systemic skew between
the clock(s) as observed by different vCPUs due to arithmetic precision
in the scaling. So that should indeed force the clock to be based on the
host's CLOCK_MONOTONIC_RAW instead of being in masterclock mode where it
is defined by the (or 'a') guest TSC.

But when the vCPUs merely have a different TSC *offset*, that's not a
problem. The offset is applied to that vCPU's kvmclock->tsc_timestamp
field, and it all comes out in the wash.

So, remove ka->nr_vcpus_matched_tsc and replace it with a new field
ka->all_vcpus_matched_tsc which is not only changed to a boolean, but
also now tracks that the *frequency* matches, not the precise offset.

Using a *count* was always racy because a new vCPU could be being
created *while* kvm_track_tsc_matching() was running and comparing with
kvm->online_vcpus. That variable is only atomic with respect to itself.
In particular, kvm_arch_vcpu_create() runs before kvm->online_vcpus is
incremented for the new vCPU, and kvm_arch_vcpu_postcreate() runs later.

Repurpose kvm_track_tsc_matching() to be called from kvm_set_tsc_khz(),
and kill the cur_tsc_generation/last_tsc_generation fields which tracked
the precise TSC matching.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/x86.c              | 133 ++++++++++++++++----------------
 2 files changed, 70 insertions(+), 69 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7d06f389a607..52dbb2d7690b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -906,7 +906,6 @@ struct kvm_vcpu_arch {
 	u64 tsc_offset_adjustment;
 	u64 this_tsc_nsec;
 	u64 this_tsc_write;
-	u64 this_tsc_generation;
 	bool tsc_catchup;
 	bool tsc_always_catchup;
 	s8 virtual_tsc_shift;
@@ -1354,11 +1353,10 @@ struct kvm_arch {
 	u32 last_tsc_khz;
 	u64 last_tsc_offset;
 	u64 last_tsc_scaling_ratio;
-	u64 cur_tsc_generation;
-	int nr_vcpus_matched_tsc;
+	bool all_vcpus_matched_tsc;
 
-	u32 default_tsc_khz;
 	bool user_set_tsc;
+	u32 default_tsc_khz;
 
 	seqcount_raw_spinlock_t pvclock_sc;
 	bool use_master_clock;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 92e81bfca25a..d6e4469f531a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2493,40 +2493,6 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz, bool scale)
 	return 0;
 }
 
-static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
-{
-	u32 thresh_lo, thresh_hi;
-	int use_scaling = 0;
-
-	/* tsc_khz can be zero if TSC calibration fails */
-	if (user_tsc_khz == 0) {
-		/* set tsc_scaling_ratio to a safe value */
-		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
-		return -1;
-	}
-
-	/* Compute a scale to convert nanoseconds in TSC cycles */
-	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
-			   &vcpu->arch.virtual_tsc_shift,
-			   &vcpu->arch.virtual_tsc_mult);
-	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
-
-	/*
-	 * Compute the variation in TSC rate which is acceptable
-	 * within the range of tolerance and decide if the
-	 * rate being applied is within that bounds of the hardware
-	 * rate.  If so, no scaling or compensation need be done.
-	 */
-	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
-	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
-	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
-		pr_debug("requested TSC rate %u falls outside tolerance [%u,%u]\n",
-			 user_tsc_khz, thresh_lo, thresh_hi);
-		use_scaling = 1;
-	}
-	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
-}
-
 static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 {
 	s64 delta = kernel_ns - vcpu->arch.this_tsc_nsec;
@@ -2557,14 +2523,34 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &vcpu->kvm->arch;
 	struct pvclock_gtod_data *gtod = &pvclock_gtod_data;
+	struct kvm_vcpu *v;
+	unsigned long i;
+	bool matched = true;
+
+	lockdep_assert_held(&vcpu->kvm->arch.tsc_write_lock);
+
+	/*
+	 * When called via kvm_arch_vcpu_create() for a new vCPU, the count
+	 * in kvm->online_vcpus will not yet have been incremented and the
+	 * kvm_for_each_vcpu() loop will not iterate over 'vcpu'.
+	 *
+	 * The right thing still happens in that case, because a match will
+	 * be found only if the new vCPU's TSC is at the same rate as *all*
+	 * the existing vCPUs' TSCs.
+	 */
+	kvm_for_each_vcpu(i, v, vcpu->kvm) {
+		if (v->arch.virtual_tsc_khz != vcpu->arch.virtual_tsc_khz) {
+			matched = false;
+			break;
+		}
+	}
+	ka->all_vcpus_matched_tsc = matched;
 
 	/*
 	 * To use the masterclock, the host clocksource must be based on TSC
-	 * and all vCPUs must have matching TSCs.  Note, the count for matching
-	 * vCPUs doesn't include the reference vCPU, hence "+1".
+	 * and all vCPUs must have matching TSC frequencies.
 	 */
-	bool use_master_clock = (ka->nr_vcpus_matched_tsc + 1 ==
-				 atomic_read(&vcpu->kvm->online_vcpus)) &&
+	bool use_master_clock = ka->all_vcpus_matched_tsc &&
 				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
 
 	/*
@@ -2574,12 +2560,51 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 	if ((ka->use_master_clock != use_master_clock))
 		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 
-	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
+	trace_kvm_track_tsc(vcpu->vcpu_id, ka->all_vcpus_matched_tsc,
 			    atomic_read(&vcpu->kvm->online_vcpus),
 		            ka->use_master_clock, gtod->clock.vclock_mode);
 #endif
 }
 
+static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
+{
+	u32 thresh_lo, thresh_hi;
+	int use_scaling = 0;
+
+	/* tsc_khz can be zero if TSC calibration fails */
+	if (user_tsc_khz == 0) {
+		/* set tsc_scaling_ratio to a safe value */
+		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
+		return -1;
+	}
+
+	/* Compute a scale to convert nanoseconds in TSC cycles */
+	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
+			   &vcpu->arch.virtual_tsc_shift,
+			   &vcpu->arch.virtual_tsc_mult);
+
+	raw_spin_lock_irq(&vcpu->kvm->arch.tsc_write_lock);
+	vcpu->arch.virtual_tsc_khz = user_tsc_khz;
+	kvm_track_tsc_matching(vcpu);
+	raw_spin_unlock_irq(&vcpu->kvm->arch.tsc_write_lock);
+
+	/*
+	 * Compute the variation in TSC rate which is acceptable
+	 * within the range of tolerance and decide if the
+	 * rate being applied is within that bounds of the hardware
+	 * rate.  If so, no scaling or compensation need be done.
+	 */
+	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
+	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
+	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
+		pr_debug("requested TSC rate %u falls outside tolerance [%u,%u]\n",
+			 user_tsc_khz, thresh_lo, thresh_hi);
+		use_scaling = 1;
+	}
+	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
+}
+
+
 /*
  * Multiply tsc by a fixed point number represented by ratio.
  *
@@ -2725,27 +2750,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	vcpu->arch.last_guest_tsc = tsc;
 
 	kvm_vcpu_write_tsc_offset(vcpu, offset);
-
-	if (!matched) {
-		/*
-		 * We split periods of matched TSC writes into generations.
-		 * For each generation, we track the original measured
-		 * nanosecond time, offset, and write, so if TSCs are in
-		 * sync, we can match exact offset, and if not, we can match
-		 * exact software computation in compute_guest_tsc()
-		 *
-		 * These values are tracked in kvm->arch.cur_xxx variables.
-		 */
-		kvm->arch.cur_tsc_generation++;
-		kvm->arch.nr_vcpus_matched_tsc = 0;
-	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
-		kvm->arch.nr_vcpus_matched_tsc++;
-	}
-
-	/* Keep track of which generation this VCPU has synchronized to */
-	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
-
-	kvm_track_tsc_matching(vcpu);
 }
 
 static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
@@ -3072,11 +3076,9 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 	struct kvm_arch *ka = &kvm->arch;
 	uint64_t last_tsc_hz;
 	int vclock_mode;
-	bool host_tsc_clocksource, vcpus_matched;
+	bool host_tsc_clocksource;
 
 	lockdep_assert_held(&kvm->arch.tsc_write_lock);
-	vcpus_matched = (ka->nr_vcpus_matched_tsc + 1 ==
-			atomic_read(&kvm->online_vcpus));
 
 	/*
 	 * If the host uses TSC clock, then passthrough TSC as stable
@@ -3086,7 +3088,8 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 					&ka->master_kernel_ns,
 					&ka->master_cycle_now);
 
-	ka->use_master_clock = host_tsc_clocksource && vcpus_matched
+	ka->use_master_clock = host_tsc_clocksource
+				&& ka->all_vcpus_matched_tsc
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
@@ -3124,7 +3127,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 
 	vclock_mode = pvclock_gtod_data.clock.vclock_mode;
 	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
-					vcpus_matched);
+					ka->all_vcpus_matched_tsc);
 #endif
 }
 
-- 
2.44.0


