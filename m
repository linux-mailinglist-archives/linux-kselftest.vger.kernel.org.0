Return-Path: <linux-kselftest+bounces-8976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B628B45DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB622282E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A64E1BA;
	Sat, 27 Apr 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTm+vxkF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C844A990;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216786; cv=none; b=Uu45iypOnsm9fjwx6DhN4r/WhHGqUOiGt9gNFN8FvIEaJ1egwt+IX5saS0MzRzzCy/2h3mamyMAYkyqsT0sDQVLPSXHYrthYIBHxnkfSPFPTDYcVXuS1Cgl44FyeH4deJAR15WMyqDXjYpowlPeLE1iG/b1NbuYSM8xyicd8kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216786; c=relaxed/simple;
	bh=HCznYAv0EfRhddfdK9swdqfYALkzcbaaWAuEQfAFYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGUUuJQdQJIgr/D81jHtkA/pnUOGl1nLOjgl7o4guvK5VN2+5oDZq/4BZ21Id8sL7usJ2n3YxO5a9U/00TGHk4UaaqxjQMJ1xkX6VNSOh4fq6pkZJZnLGqOTq29B6aeZ+wyiMuH47kDLlOG2vBwKolL7lW4LQK89Ch7rR7piVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nTm+vxkF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rpfo1oUoJzRPiJFA+UCmdgAFooGLVsmHebsz9FfSOoc=; b=nTm+vxkFhMhl43Kyx8J2RVas/v
	MgEFbuFINgZfn9jT60qo3mU4baGpwZJVcBIjpTR4Do3kWwZT4QUBg98PbOUoDJbLq3/nZD2OY7Lis
	4qNu3jtQVa5vX8YsbzMFJANZWuxcIiGKD1NvVLPedn4jVv5MiY61D62uG2blUJhPWmq61mf8bx3cK
	Ox6xzXad8RByBaQdzoUhz+qkrlva0R8I8ybhudiaPmkY8jntMPVkIDd+4/PMdMM16Ko/VrzBT0Q+X
	Cnr2IMYNucMM9bhDwMYaF7Qlp3kvX5HrFhfJtQqIIGOH65r+DNSlQJGm4vBEmm7hlgAA4EKhZ4yNR
	1bHXGHQg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5h-00000007Jwp-00lT;
	Sat, 27 Apr 2024 11:19:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bl-2B7U;
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
Subject: [PATCH v2 12/15] KVM: x86: Improve synchronization in kvm_synchronize_tsc()
Date: Sat, 27 Apr 2024 12:05:09 +0100
Message-ID: <20240427111929.9600-13-dwmw2@infradead.org>
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

When synchronizing to an existing TSC (either by explicitly writing zero,
or the legacy hack where the TSC is written within one second's worth of
the previously written TSC), the last_tsc_write and last_tsc_nsec values
were being misrecorded by __kvm_synchronize_tsc(). The *unsynchronized*
value of the TSC (perhaps even zero) was bring recorded, along with the
current time at which kvm_synchronize_tsc() was called. This could cause
*subsequent* writes to fail to synchronize correctly.

Fix that by resetting {data, ns} to the previous values before passing
them to __kvm_synchronize_tsc() when synchronization is detected. Except
in the case where the TSC is unstable and *has* to be synthesised from
the host clock, in which case attempt to create a nsec/tsc pair which is
on the correct line.

Furthermore, there were *three* different TSC reads used for calculating
the "current" time, all slightly different from each other. Fix that by
using kvm_get_time_and_clockread() where possible and using the same
host_tsc value in all cases.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ea59694d712a..6ec43f39bdb0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -201,6 +201,10 @@ module_param(eager_page_split, bool, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
+#ifdef CONFIG_X86_64
+static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
+#endif
+
 /*
  * Restoring the host value for MSRs that are only consumed when running in
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
@@ -2753,14 +2757,22 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 {
 	u64 data = user_value ? *user_value : 0;
 	struct kvm *kvm = vcpu->kvm;
-	u64 offset, ns, elapsed;
+	u64 offset, host_tsc, ns, elapsed;
 	unsigned long flags;
 	bool matched = false;
 	bool synchronizing = false;
 
+#ifdef CONFIG_X86_64
+	if (!kvm_get_time_and_clockread(&ns, &host_tsc))
+#endif
+	{
+		ns = get_kvmclock_base_ns();
+		host_tsc = rdtsc();
+	}
+
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
-	ns = get_kvmclock_base_ns();
+
+	offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2805,12 +2817,24 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
          */
 	if (synchronizing &&
 	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
+		/*
+		 * If synchronizing, the "last written" TSC value/time recorded
+		 * by __kvm_synchronize_tsc() should not change (i.e. should
+		 * be precisely the same as the existing generation)...
+		 */
+		data = kvm->arch.last_tsc_write;
+
 		if (!kvm_check_tsc_unstable()) {
 			offset = kvm->arch.cur_tsc_offset;
+			ns = kvm->arch.cur_tsc_nsec;
 		} else {
+			/*
+			 * ... unless the TSC is unstable and has to be
+			 * synthesised from the host clock in nanoseconds.
+			 */
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, host_tsc, data);
 		}
 		matched = true;
 	}
-- 
2.44.0


