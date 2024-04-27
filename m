Return-Path: <linux-kselftest+bounces-8982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AC8B45FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9126285B53
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95974EB36;
	Sat, 27 Apr 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eyWNY0fg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A64D9E0;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216888; cv=none; b=CAIJ14pLp5MzgVV/DsWXjgEF6xIAt8alt7v6ACaTFERSsiBco/1KkiW8p7CiIx5x6WFbrGZ4eyH4Nl2m61GYkmZo4ceQQ31c0zpN+t4lkK91zlWJhWQqSxs6IGYKIPzV2IUCpE8puq7KPBdiNtKC8xQGsZQkcsTySELlJApOdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216888; c=relaxed/simple;
	bh=JgGabuAHu2kBFYqmC6hzVu4EnGRQ0JFgxHIloweNGrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGWJopikp2OHLM5NT9CdEibmgwWPcmaUbFUx623revqBfxDiYYSgs9iH+PDyzc10tHPuK1oOq12Slvrg4NHC31Y6UTmiuDc3EPFsiUtBp1vOx1UyH2d+tT4kczSQIV4iu4MLF5dKmxb0EfR+xPNbOTkKS5uj6V92q9ho2lTK3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eyWNY0fg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ICZ72GFgqWeWSew6Hy8geT+ffx42fw8pPdYL/rfeVOU=; b=eyWNY0fgoB6wWS5DiiizFp/4TP
	uyG0aGNmw97AGbTz8Z7yunbXJcGQwcpLrkFF1zMDbpdBS3sgHqMFUPSqFc7VQnf7eHYnVaohul/0W
	wrJRVU7BsF0H9R6813lWxOvX/xM5eMOVsNENQaeTsHuBmSLm74D/H6B45ZcOth+/by+9urEDbVCbl
	9zXcPsymetxxjfpJlOxNpfJTbzrK4ZXXNNjl0cPYKcrM5qgBYm7wY3BhHsx/eduWAU6He2IdBrb2+
	evnRgU1JixYDY2c4RHtnGLNNTddPI4OgCe6p1fFIp5IaLYs9tzt/PR3kRpNM8f9vvfCFgQGB9PQrb
	jXtx+8Hw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5i-0000000FeZh-0pYE;
	Sat, 27 Apr 2024 11:20:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bV-1IK2;
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
Subject: [PATCH v2 08/15] KVM: x86: Fix KVM clock precision in __get_kvmclock()
Date: Sat, 27 Apr 2024 12:05:05 +0100
Message-ID: <20240427111929.9600-9-dwmw2@infradead.org>
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

When in 'master clock mode' (i.e. when host and guest TSCs are behaving
sanely and in sync), the KVM clock is defined in terms of the guest TSC.

When TSC scaling is used, calculating the KVM clock directly from *host*
TSC cycles leads to a systemic drift from the values calculated by the
guest from its TSC.

Commit 451a707813ae ("KVM: x86/xen: improve accuracy of Xen timers")
had a simple workaround for the specific case of Xen timers, as it had an
actual vCPU to hand and could use its scaling information. That commit
noted that it was broken for the general case of get_kvmclock_ns(), and
said "I'll come back to that".

Since __get_kvmclock() is invoked without a specific CPU, it needs to
be able to find or generate the scaling values required to perform the
correct calculation.

Thankfully, TSC scaling can only happen with X86_FEATURE_CONSTANT_TSC,
so it isn't as complex as it might have been.

In __kvm_synchronize_tsc(), note the current vCPU's scaling ratio in
kvm->arch.last_tsc_scaling_ratio. That is only protected by the
tsc_write_lock, so in pvclock_update_vm_gtod_copy(), copy it into a
separate kvm->arch.master_tsc_scaling_ratio so that it can be accessed
using the kvm->arch.pvclock_sc seqcount lock. Also generate the mul and
shift factors to convert to nanoseconds for the corresponding KVM clock,
just as kvm_guest_time_update() would.

In __get_kvmclock(), which runs within a seqcount retry loop, use those
values to convert host to guest TSC and then to nanoseconds. Only fall
back to using get_kvmclock_base_ns() when not in master clock mode.

There was previously a code path in __get_kvmclock() which looked like
it could set KVM_CLOCK_TSC_STABLE without KVM_CLOCK_REALTIME, perhaps
even on 32-bit hosts. In practice that could never happen as the
ka->use_master_clock flag couldn't be set on 32-bit, and even on 64-bit
hosts it would never be set when the system clock isn't TSC-based. So
that code path is now removed.

The kvm_get_wall_clock_epoch() function had the same problem; make it
just call get_kvmclock() and subtract kvmclock from wallclock, with
the same fallback as before.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   4 +
 arch/x86/kvm/x86.c              | 151 ++++++++++++++++----------------
 2 files changed, 79 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8440c4081727..b01c1d000fff 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1353,6 +1353,7 @@ struct kvm_arch {
 	u64 last_tsc_write;
 	u32 last_tsc_khz;
 	u64 last_tsc_offset;
+	u64 last_tsc_scaling_ratio;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
@@ -1364,6 +1365,9 @@ struct kvm_arch {
 
 	seqcount_raw_spinlock_t pvclock_sc;
 	bool use_master_clock;
+	s8 master_tsc_shift;
+	u32 master_tsc_mul;
+	u64 master_tsc_scaling_ratio;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 	struct delayed_work kvmclock_update_work;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 44b3d2a0da5b..89918ba266cd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2674,6 +2674,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm->arch.last_tsc_nsec = ns;
 	kvm->arch.last_tsc_write = tsc;
 	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	kvm->arch.last_tsc_scaling_ratio = vcpu->arch.l1_tsc_scaling_ratio;
 	kvm->arch.last_tsc_offset = offset;
 
 	vcpu->arch.last_guest_tsc = tsc;
@@ -3009,6 +3010,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 {
 #ifdef CONFIG_X86_64
 	struct kvm_arch *ka = &kvm->arch;
+	uint64_t last_tsc_hz;
 	int vclock_mode;
 	bool host_tsc_clocksource, vcpus_matched;
 
@@ -3028,6 +3030,35 @@ static void pvclock_update_vm_gtod_copy(struct kvm *kvm)
 				&& !ka->backwards_tsc_observed
 				&& !ka->boot_vcpu_runs_old_kvmclock;
 
+	/*
+	 * When TSC scaling is in use (which can thankfully only happen
+	 * with X86_FEATURE_CONSTANT_TSC), the host must calculate the
+	 * KVM clock precisely as the guest would, by scaling through
+	 * the guest TSC frequency. Otherwise, differences in arithmetic
+	 * precision lead to systemic drift between the guest's and the
+	 * host's idea of the time.
+	 */
+	if (kvm_caps.has_tsc_control) {
+		/*
+		 * Copy from the field protected solely by ka->tsc_write_lock,
+		 * to the field protected by the ka->pvclock_sc seqlock.
+		 */
+		ka->master_tsc_scaling_ratio = ka->last_tsc_scaling_ratio ? :
+			kvm_caps.default_tsc_scaling_ratio;
+
+		/*
+		 * Calculate the scaling factors precisely the same way
+		 * that kvm_guest_time_update() does.
+		 */
+		last_tsc_hz = kvm_scale_tsc(tsc_khz * 1000LL,
+					    ka->master_tsc_scaling_ratio);
+		kvm_get_time_scale(NSEC_PER_SEC, last_tsc_hz,
+				   &ka->master_tsc_shift, &ka->master_tsc_mul);
+	} else if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tsc_khz * 1000LL,
+				   &ka->master_tsc_shift, &ka->master_tsc_mul);
+	}
+
 	if (ka->use_master_clock)
 		atomic_set(&kvm_guest_has_master_clock, 1);
 
@@ -3100,36 +3131,49 @@ static unsigned long get_cpu_tsc_khz(void)
 static void __get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
 {
 	struct kvm_arch *ka = &kvm->arch;
-	struct pvclock_vcpu_time_info hv_clock;
+
+#ifdef CONFIG_X86_64
+	uint64_t cur_tsc_khz = 0;
+	struct timespec64 ts;
 
 	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
 	get_cpu();
 
-	data->flags = 0;
 	if (ka->use_master_clock &&
-	    (static_cpu_has(X86_FEATURE_CONSTANT_TSC) || __this_cpu_read(cpu_tsc_khz))) {
-#ifdef CONFIG_X86_64
-		struct timespec64 ts;
+	    (cur_tsc_khz = get_cpu_tsc_khz()) &&
+	    !kvm_get_walltime_and_clockread(&ts, &data->host_tsc))
+		cur_tsc_khz = 0;
 
-		if (kvm_get_walltime_and_clockread(&ts, &data->host_tsc)) {
-			data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
-			data->flags |= KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC;
-		} else
-#endif
-		data->host_tsc = rdtsc();
-
-		data->flags |= KVM_CLOCK_TSC_STABLE;
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
-		kvm_get_time_scale(NSEC_PER_SEC, get_cpu_tsc_khz() * 1000LL,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
-	} else {
-		data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
+	put_cpu();
+
+	if (cur_tsc_khz) {
+		uint64_t tsc_cycles;
+		uint32_t mul;
+		int8_t shift;
+
+		tsc_cycles = data->host_tsc - ka->master_cycle_now;
+
+		if (kvm_caps.has_tsc_control)
+			tsc_cycles = kvm_scale_tsc(tsc_cycles,
+						   ka->master_tsc_scaling_ratio);
+
+		if (static_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
+			mul = ka->master_tsc_mul;
+			shift = ka->master_tsc_shift;
+		} else {
+			kvm_get_time_scale(NSEC_PER_SEC, cur_tsc_khz * 1000LL,
+					   &shift, &mul);
+		}
+		data->clock = ka->master_kernel_ns + ka->kvmclock_offset +
+			pvclock_scale_delta(tsc_cycles, mul, shift);
+		data->realtime = ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec;
+		data->flags = KVM_CLOCK_REALTIME | KVM_CLOCK_HOST_TSC | KVM_CLOCK_TSC_STABLE;
+		return;
 	}
+#endif
 
-	put_cpu();
+	data->clock = get_kvmclock_base_ns() + ka->kvmclock_offset;
+	data->flags = 0;
 }
 
 static void get_kvmclock(struct kvm *kvm, struct kvm_clock_data *data)
@@ -3330,68 +3374,23 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
  * that and kvmclock, but even that would be subject to change over
  * time.
  *
- * Attempt to calculate the epoch at a given moment using the *same*
- * TSC reading via kvm_get_walltime_and_clockread() to obtain both
- * wallclock and kvmclock times, and subtracting one from the other.
+ * Use get_kvmclock() to obtain a simultaneous reading of wallclock
+ * and kvmclock times from the *same* TSC reading, and subtract one
+ * from the other.
  *
  * Fall back to using their values at slightly different moments by
  * calling ktime_get_real_ns() and get_kvmclock_ns() separately.
  */
 uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
 {
-#ifdef CONFIG_X86_64
-	struct pvclock_vcpu_time_info hv_clock;
-	struct kvm_arch *ka = &kvm->arch;
-	unsigned long seq, local_tsc_khz;
-	struct timespec64 ts;
-	uint64_t host_tsc;
-
-	do {
-		seq = read_seqcount_begin(&ka->pvclock_sc);
-
-		local_tsc_khz = 0;
-		if (!ka->use_master_clock)
-			break;
-
-		/*
-		 * The TSC read and the call to get_cpu_tsc_khz() must happen
-		 * on the same CPU.
-		 */
-		get_cpu();
-
-		local_tsc_khz = get_cpu_tsc_khz();
-
-		if (local_tsc_khz &&
-		    !kvm_get_walltime_and_clockread(&ts, &host_tsc))
-			local_tsc_khz = 0; /* Fall back to old method */
-
-		put_cpu();
-
-		/*
-		 * These values must be snapshotted within the seqcount loop.
-		 * After that, it's just mathematics which can happen on any
-		 * CPU at any time.
-		 */
-		hv_clock.tsc_timestamp = ka->master_cycle_now;
-		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
+	struct kvm_clock_data data;
 
-	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
+	get_kvmclock(kvm, &data);
 
-	/*
-	 * If the conditions were right, and obtaining the wallclock+TSC was
-	 * successful, calculate the KVM clock at the corresponding time and
-	 * subtract one from the other to get the guest's epoch in nanoseconds
-	 * since 1970-01-01.
-	 */
-	if (local_tsc_khz) {
-		kvm_get_time_scale(NSEC_PER_SEC, local_tsc_khz * NSEC_PER_USEC,
-				   &hv_clock.tsc_shift,
-				   &hv_clock.tsc_to_system_mul);
-		return ts.tv_nsec + NSEC_PER_SEC * ts.tv_sec -
-			__pvclock_read_cycles(&hv_clock, host_tsc);
-	}
-#endif
-	return ktime_get_real_ns() - get_kvmclock_ns(kvm);
+	if (data.flags & KVM_CLOCK_REALTIME)
+		return data.realtime - data.clock;
+	else
+		return ktime_get_real_ns() - data.clock;
 }
 
 /*
-- 
2.44.0


