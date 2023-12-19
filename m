Return-Path: <linux-kselftest+bounces-2227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBA818CA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4407F28AC22
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27637D31;
	Tue, 19 Dec 2023 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="V/8u23P8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30F3455D;
	Tue, 19 Dec 2023 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:To:From;
	bh=jMVx70whTUww/H0RoJ5SPsXDcCtN4HuEaCQsFXCcYB0=; b=V/8u23P8JInVxOC+1r2oBWVaTY
	KKCxmLDlsRdX97GGZ4cbKmaQ6DiqLqcawHCzSc/4CGqJcJtroznNPSHzd5Q/XbnLx9yqo4pZCr5uV
	YKMaaWLe4bCRybyeTECwugdY+xe7i5GVhWKR6U6YTg1+rc7II7KVHjoTL6xygv5NgalA=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFd9y-00064z-3C; Tue, 19 Dec 2023 16:41:34 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFckN-0005h9-Bb; Tue, 19 Dec 2023 16:15:07 +0000
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
Subject: [PATCH v11 16/19] KVM: xen: split up kvm_xen_set_evtchn_fast()
Date: Tue, 19 Dec 2023 16:11:06 +0000
Message-Id: <20231219161109.1318-17-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219161109.1318-1-paul@xen.org>
References: <20231219161109.1318-1-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

The implementation of kvm_xen_set_evtchn_fast() is a rather lengthy piece
of code that performs two operations: updating of the shared_info
evtchn_pending mask, and updating of the vcpu_info evtchn_pending_sel
mask. Introduce a separate function to perform each of those operations and
re-work kvm_xen_set_evtchn_fast() to use them.

No functional change intended.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
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

v11:
 - Fixed /64 vs /32 switcheroo and changed type of port_word_bit back to
   int.

v10:
 - Updated in this version. Dropped David'd R-b since the updates are
   non-trivial.

v8:
 - New in this version.
---
 arch/x86/kvm/xen.c | 175 ++++++++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 9b8f9f8e2da2..4ebd24c3ae70 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1667,6 +1667,101 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+static int set_shinfo_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
+	unsigned long *pending_bits, *mask_bits;
+	unsigned long flags;
+	int rc = -EWOULDBLOCK;
+
+	read_lock_irqsave(&gpc->lock, flags);
+	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+		goto out;
+
+	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+		struct shared_info *shinfo = gpc->khva;
+
+		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
+		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
+	} else {
+		struct compat_shared_info *shinfo = gpc->khva;
+
+		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
+		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
+	}
+
+	if (test_and_set_bit(port, pending_bits)) {
+		rc = 0; /* It was already raised */
+	} else if (test_bit(port, mask_bits)) {
+		rc = -ENOTCONN; /* It is masked */
+		kvm_xen_check_poller(vcpu, port);
+	} else {
+		rc = 1; /* It is newly raised */
+	}
+
+ out:
+	read_unlock_irqrestore(&gpc->lock, flags);
+	return rc;
+}
+
+static bool set_vcpu_info_evtchn_pending(struct kvm_vcpu *vcpu, u32 port)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	unsigned long flags;
+	bool kick_vcpu = false;
+
+	read_lock_irqsave(&gpc->lock, flags);
+
+	/*
+	 * Try to deliver the event directly to the vcpu_info. If successful and
+	 * the guest is using upcall_vector delivery, send the MSI.
+	 * If the pfncache is invalid, set the shadow. In this case, or if the
+	 * guest is using another form of event delivery, the vCPU must be
+	 * kicked to complete the delivery.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+		struct vcpu_info *vcpu_info = gpc->khva;
+		int port_word_bit = port / 64;
+
+		if (!kvm_gpc_check(gpc, sizeof(*vcpu_info))) {
+			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out;
+		}
+
+		if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
+			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
+			kick_vcpu = true;
+		}
+	} else {
+		struct compat_vcpu_info *vcpu_info = gpc->khva;
+		int port_word_bit = port / 32;
+
+		if (!kvm_gpc_check(gpc, sizeof(*vcpu_info))) {
+			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out;
+		}
+
+		if (!test_and_set_bit(port_word_bit,
+				      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
+			WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
+			kick_vcpu = true;
+		}
+	}
+
+	if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
+		kvm_xen_inject_vcpu_vector(vcpu);
+		kick_vcpu = false;
+	}
+
+ out:
+	read_unlock_irqrestore(&gpc->lock, flags);
+	return kick_vcpu;
+}
+
 /*
  * The return value from this function is propagated to kvm_set_irq() API,
  * so it returns:
@@ -1675,15 +1770,12 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
  *  > 0   Number of CPUs interrupt was delivered to
  *
  * It is also called directly from kvm_arch_set_irq_inatomic(), where the
- * only check on its return value is a comparison with -EWOULDBLOCK'.
+ * only check on its return value is a comparison with -EWOULDBLOCK
+ * (which may be returned by set_shinfo_evtchn_pending()).
  */
 int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
-	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct kvm_vcpu *vcpu;
-	unsigned long *pending_bits, *mask_bits;
-	unsigned long flags;
-	int port_word_bit;
 	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
 
@@ -1703,79 +1795,12 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	if (xe->port >= max_evtchn_port(kvm))
 		return -EINVAL;
 
-	rc = -EWOULDBLOCK;
-
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
-
-	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-		struct shared_info *shinfo = gpc->khva;
-		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
-		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
-		port_word_bit = xe->port / 64;
-	} else {
-		struct compat_shared_info *shinfo = gpc->khva;
-		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
-		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
-		port_word_bit = xe->port / 32;
-	}
+	rc = set_shinfo_evtchn_pending(vcpu, xe->port);
+	if (rc == 1) /* Delivered to the bitmap in shared_info */
+		kick_vcpu = set_vcpu_info_evtchn_pending(vcpu, xe->port);
 
-	/*
-	 * If this port wasn't already set, and if it isn't masked, then
-	 * we try to set the corresponding bit in the in-kernel shadow of
-	 * evtchn_pending_sel for the target vCPU. And if *that* wasn't
-	 * already set, then we kick the vCPU in question to write to the
-	 * *real* evtchn_pending_sel in its own guest vcpu_info struct.
-	 */
-	if (test_and_set_bit(xe->port, pending_bits)) {
-		rc = 0; /* It was already raised */
-	} else if (test_bit(xe->port, mask_bits)) {
-		rc = -ENOTCONN; /* Masked */
-		kvm_xen_check_poller(vcpu, xe->port);
-	} else {
-		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_rcu;
-		}
-
-		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-			struct vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit, &vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
-		} else {
-			struct compat_vcpu_info *vcpu_info = gpc->khva;
-			if (!test_and_set_bit(port_word_bit,
-					      (unsigned long *)&vcpu_info->evtchn_pending_sel)) {
-				WRITE_ONCE(vcpu_info->evtchn_upcall_pending, 1);
-				kick_vcpu = true;
-			}
-		}
-
-		/* For the per-vCPU lapic vector, deliver it as MSI. */
-		if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
-			kvm_xen_inject_vcpu_vector(vcpu);
-			kick_vcpu = false;
-		}
-	}
-
- out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
-- 
2.39.2


