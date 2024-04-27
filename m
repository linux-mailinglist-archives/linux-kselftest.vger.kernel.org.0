Return-Path: <linux-kselftest+bounces-8988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED778B4613
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0781F25113
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3650260;
	Sat, 27 Apr 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhEc64xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178524DA00;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216892; cv=none; b=jR/YuMFCpxsJLNO2D4zMz0u5eVT+exGjATlz8lfpJD4ScK5jUle5Z3I0lTXiHqlJDqCHEnPUEm5rKYyjBP66ESuczaRP4nygxkcYQCw9xFO3wamiRk7ISLFYL8S12R6+AU7DWQCaJ2HIM3WJTOsU20k0ef/C8AZB+gW+xzCCaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216892; c=relaxed/simple;
	bh=bt5ZK9z0bKFYX0/bOnrNtTFlIXKShYN2ESGBnXMeNqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coZnRS2etrXF5r9bgeG0bQvckN1sIwA3zB9aNjwIC7mpQx9jgo9GEbCKBGRp6SL0HMWvcmWDVaDqgGxFUAuFn6N9RuZIVn/3B9fsxQgd+sD6BbovdEQYFE4gkuy8uPWKGOEAnIYlVz3Kd5ar0qBvSTs5UEotWDwXwKQDsxutkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhEc64xq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/JDpaKVQe9XBet6gm2cGiomyiCiWrajRge7yHD8i1TM=; b=jhEc64xqBFfAB0bEkdVUB5Jvcj
	e9d2YjzDwcEwkh+4Q2e5eVTXYMwuLDYAueDRxvFbbO1z47+FN/bImbnSDoRUVgk94e06lVIWJSHQb
	lAwv5lLNxyZwqPTGH6qJ4E+H8Utztv03njrkJdfKsXuUsSfNjnx0FK0Qc3I3t9ro3su706bIily6E
	oYwBwftC+0DeLpa92yYA51w1lBrIGdd7F2b0KHDMpxp1B1Fuy1/yWej9FP5jmmwYGt/bR9GuzGMuI
	Qx8msONw5zhkhQGwsXM7Vxy3daH0nsPZxWhow535EkdAYpMSSoDcmZ0g2APucnhZYNgze9I9GvRbx
	NZs79P5w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5h-0000000FeZf-3mf7;
	Sat, 27 Apr 2024 11:20:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5f-000000002bB-3w9q;
	Sat, 27 Apr 2024 12:19:35 +0100
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
Subject: [PATCH v2 03/15] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
Date: Sat, 27 Apr 2024 12:05:00 +0100
Message-ID: <20240427111929.9600-4-dwmw2@infradead.org>
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

From: Jack Allister <jalliste@amazon.com>

In the common case (where kvm->arch.use_master_clock is true), the KVM
clock is defined as a simple arithmetic function of the guest TSC, based on
a reference point stored in kvm->arch.master_kernel_ns and
kvm->arch.master_cycle_now.

The existing KVM_[GS]ET_CLOCK functionality does not allow for this
relationship to be precisely saved and restored by userspace. All it can
currently do is set the KVM clock at a given UTC reference time, which is
necessarily imprecise.

So on live update, the guest TSC can remain cycle accurate at precisely the
same offset from the host TSC, but there is no way for userspace to restore
the KVM clock accurately.

Even on live migration to a new host, where the accuracy of the guest time-
keeping is fundamentally limited by the accuracy of wallclock
synchronization between the source and destination hosts, the clock jump
experienced by the guest's TSC and its KVM clock should at least be
*consistent*. Even when the guest TSC suffers a discontinuity, its KVM
clock should still remain the *same* arithmetic function of the guest TSC,
and not suffer an *additional* discontinuity.

To allow for accurate migration of the KVM clock, add per-vCPU ioctls which
save and restore the actual PV clock info in pvclock_vcpu_time_info.

The restoration in KVM_SET_CLOCK_GUEST works by creating a new reference
point in time just as kvm_update_masterclock() does, and calculating the
corresponding guest TSC value. This guest TSC value is then passed through
the user-provided pvclock structure to generate the *intended* KVM clock
value at that point in time, and through the *actual* KVM clock calculation.
Then kvm->arch.kvmclock_offset is adjusted to eliminate for the difference.

Where kvm->arch.use_master_clock is false (because the host TSC is
unreliable, or the guest TSCs are configured strangely), the KVM clock
is *not* defined as a function of the guest TSC so KVM_GET_CLOCK_GUEST
returns an error. In this case, as documented, userspace shall use the
legacy KVM_GET_CLOCK ioctl. The loss of precision is acceptable in this
case since the clocks are imprecise in this mode anyway.

On *restoration*, if kvm->arch.use_master_clock is false, an error is
returned for similar reasons and userspace shall fall back to using
KVM_SET_CLOCK. This does mean that, as documented, userspace needs to use
*both* KVM_GET_CLOCK_GUEST and KVM_GET_CLOCK and send both results with the
migration data (unless the intent is to refuse to resume on a host with bad
TSC).

(It may have been possible to make KVM_SET_CLOCK_GUEST "good enough" in the
non-masterclock mode, as that mode is necessarily imprecise anyway. The
explicit fallback allows userspace to deliberately fail migration to a host
with misbehaving TSC where master clock mode wouldn't be active.)

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Jack Allister <jalliste@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
CC: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/virt/kvm/api.rst |  37 ++++++++
 arch/x86/kvm/x86.c             | 156 +++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |   3 +
 3 files changed, 196 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f0b76ff5030d..758f6fc08fe5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6352,6 +6352,43 @@ a single guest_memfd file, but the bound ranges must not overlap).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
+4.143 KVM_GET_CLOCK_GUEST
+----------------------------
+
+:Capability: none
+:Architectures: x86_64
+:Type: vcpu ioctl
+:Parameters: struct pvclock_vcpu_time_info (out)
+:Returns: 0 on success, <0 on error
+
+Retrieves the current time information structure used for KVM/PV clocks,
+in precisely the form advertised to the guest vCPU, which gives parameters
+for a direct conversion from a guest TSC value to nanoseconds.
+
+When the KVM clock not is in "master clock" mode, for example because the
+host TSC is unreliable or the guest TSCs are oddly configured, the KVM clock
+is actually defined by the host CLOCK_MONOTONIC_RAW instead of the guest TSC.
+In this case, the KVM_GET_CLOCK_GUEST ioctl returns -EINVAL.
+
+4.144 KVM_SET_CLOCK_GUEST
+----------------------------
+
+:Capability: none
+:Architectures: x86_64
+:Type: vcpu ioctl
+:Parameters: struct pvclock_vcpu_time_info (in)
+:Returns: 0 on success, <0 on error
+
+Sets the KVM clock (for the whole VM) in terms of the vCPU TSC, using the
+pvclock structure as returned by KVM_GET_CLOCK_GUEST. This allows the precise
+arithmetic relationship between guest TSC and KVM clock to be preserved by
+userspace across migration.
+
+When the KVM clock is not in "master clock" mode, and the KVM clock is actually
+defined by the host CLOCK_MONOTONIC_RAW, this ioctl returns -EINVAL. Userspace
+may choose to set the clock using the less precise KVM_SET_CLOCK ioctl, or may
+choose to fail, denying migration to a host whose TSC is misbehaving.
+
 5. The kvm_run structure
 ========================
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 23281c508c27..42abce7b4fc9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5868,6 +5868,154 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	}
 }
 
+#ifdef CONFIG_X86_64
+static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info *hv_clock = &v->arch.hv_clock;
+
+	/*
+	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the hv_clock has
+	 * never been generated at all, call kvm_guest_time_update() to do so.
+	 * Might as well use the PVCLOCK_TSC_STABLE_BIT as the check for ever
+	 * having been written.
+	 */
+	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) ||
+	    !(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT)) {
+		if (kvm_guest_time_update(v))
+			return -EINVAL;
+	}
+
+	/*
+	 * PVCLOCK_TSC_STABLE_BIT is set in use_master_clock mode where the
+	 * KVM clock is defined in terms of the guest TSC. Otherwise, it is
+	 * is defined by the host CLOCK_MONOTONIC_RAW, and userspace should
+	 * use the legacy KVM_[GS]ET_CLOCK to migrate it.
+	 */
+	if (!(hv_clock->flags & PVCLOCK_TSC_STABLE_BIT))
+		return -EINVAL;
+
+	if (copy_to_user(argp, hv_clock, sizeof(*hv_clock)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Reverse the calculation in the hv_clock definition.
+ *
+ * time_ns = ( (cycles << shift) * mul ) >> 32;
+ * (although shift can be negative, so that's bad C)
+ *
+ * So for a single second,
+ *  NSEC_PER_SEC = ( ( FREQ_HZ << shift) * mul ) >> 32
+ *  NSEC_PER_SEC << 32 = ( FREQ_HZ << shift ) * mul
+ *  ( NSEC_PER_SEC << 32 ) / mul = FREQ_HZ << shift
+ *  ( NSEC_PER_SEC << 32 ) / mul ) >> shift = FREQ_HZ
+ */
+static uint64_t hvclock_to_hz(uint32_t mul, int8_t shift)
+{
+	uint64_t tm = NSEC_PER_SEC << 32;
+
+	/* Maximise precision. Shift right until the top bit is set */
+	tm <<= 2;
+	shift += 2;
+
+	/* While 'mul' is even, increase the shift *after* the division */
+	while (!(mul & 1)) {
+		shift++;
+		mul >>= 1;
+	}
+
+	tm /= mul;
+
+	if (shift > 0)
+		return tm >> shift;
+	else
+		return tm << -shift;
+}
+
+static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __user *argp)
+{
+	struct pvclock_vcpu_time_info user_hv_clock;
+	struct kvm *kvm = v->kvm;
+	struct kvm_arch *ka = &kvm->arch;
+	uint64_t curr_tsc_hz, user_tsc_hz;
+	uint64_t user_clk_ns;
+	uint64_t guest_tsc;
+	int rc = 0;
+
+	if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
+		return -EFAULT;
+
+	if (!user_hv_clock.tsc_to_system_mul)
+		return -EINVAL;
+
+	user_tsc_hz = hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
+				    user_hv_clock.tsc_shift);
+
+
+	kvm_hv_request_tsc_page_update(kvm);
+	kvm_start_pvclock_update(kvm);
+	pvclock_update_vm_gtod_copy(kvm);
+
+	/*
+	 * If not in use_master_clock mode, do not allow userspace to set
+	 * the clock in terms of the guest TSC. Userspace should either
+	 * fail the migration (to a host with suboptimal TSCs), or should
+	 * knowingly restore the KVM clock using KVM_SET_CLOCK instead.
+	 */
+	if (!ka->use_master_clock) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	curr_tsc_hz = get_cpu_tsc_khz() * 1000LL;
+	if (unlikely(curr_tsc_hz == 0)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (kvm_caps.has_tsc_control)
+		curr_tsc_hz = kvm_scale_tsc(curr_tsc_hz,
+					    v->arch.l1_tsc_scaling_ratio);
+
+	/*
+	 * The scaling factors in the hv_clock do not depend solely on the
+	 * TSC frequency *requested* by userspace. They actually use the
+	 * host TSC frequency that was measured/detected by the host kernel,
+	 * scaled by kvm_scale_tsc() with the vCPU's l1_tsc_scaling_ratio.
+	 *
+	 * So a sanity check that they *precisely* match would have false
+	 * negatives. Allow for a discrepancy of 1 kHz either way.
+	 */
+	if (user_tsc_hz < curr_tsc_hz - 1000 ||
+	    user_tsc_hz > curr_tsc_hz + 1000) {
+		rc = -ERANGE;
+		goto out;
+	}
+
+	/*
+	 * The call to pvclock_update_vm_gtod_copy() has created a new time
+	 * reference point in ka->master_cycle_now and ka->master_kernel_ns.
+	 *
+	 * Calculate the guest TSC at that moment, and the corresponding KVM
+	 * clock value according to user_hv_clock. The value according to the
+	 * current hv_clock will of course be ka->master_kernel_ns since no
+	 * TSC cycles have elapsed.
+	 *
+	 * Adjust ka->kvmclock_offset to the delta, so that both definitions
+	 * of the clock give precisely the same reading at the reference time.
+	 */
+	guest_tsc = kvm_read_l1_tsc(v, ka->master_cycle_now);
+	user_clk_ns = __pvclock_read_cycles(&user_hv_clock, guest_tsc);
+	ka->kvmclock_offset = user_clk_ns - ka->master_kernel_ns;
+
+out:
+	kvm_end_pvclock_update(kvm);
+	return rc;
+}
+#endif
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -6256,6 +6404,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
+#ifdef CONFIG_X86_64
+	case KVM_SET_CLOCK_GUEST:
+		r = kvm_vcpu_ioctl_set_clock_guest(vcpu, argp);
+		break;
+	case KVM_GET_CLOCK_GUEST:
+		r = kvm_vcpu_ioctl_get_clock_guest(vcpu, argp);
+		break;
+#endif
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_GET_SUPPORTED_HV_CPUID:
 		r = kvm_ioctl_get_supported_hv_cpuid(vcpu, argp);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2190adbe3002..0d306311e4d6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1548,4 +1548,7 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_SET_CLOCK_GUEST       _IOW(KVMIO,  0xd5, struct pvclock_vcpu_time_info)
+#define KVM_GET_CLOCK_GUEST       _IOR(KVMIO,  0xd6, struct pvclock_vcpu_time_info)
+
 #endif /* __LINUX_KVM_H */
-- 
2.44.0


