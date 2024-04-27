Return-Path: <linux-kselftest+bounces-8975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C236C8B45DA
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F7F282E6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BD64CB38;
	Sat, 27 Apr 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkwhuFHy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEB4AEC7;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216786; cv=none; b=a4tpuIxzALZaVb9T545/Njs5BNyN0zp3k80WOUg/R9xjBWBekkSUps/61fgm+UJW/x4CwHqFKS2TBzeZ5/N27ARCHeGkSySR3q6Tw8SaZ0xcGeUuEzfhOYMrafV5HGWdobUM7UUl3Fkg0yll/Ciy5XrTdknhwm1Dyz7K/HIgKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216786; c=relaxed/simple;
	bh=MfsZSEbRwBJ9w5jCG1r9UNHwXDhRvX+YH1b8L7lq6jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvsxMcOhGwVyYv9Jr2ifIvwEclTL9IQB8DYS+zoZTndWHwaY+9D9ffXc8bmgIV7mgK9GyvwqJmoV9iu3THDt+It6tVbj5Mcp6Y9LWnRRMzcum5LgV3iYCw5APBEJ3EVCeCeWHj7B6xbKgvy/OvY7syFkMcuvxgw6JazM5l9d/Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jkwhuFHy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LhUA0U4IOeUA/e+o4NGCvx07Pxtovz/JSXQ/6S+Lttw=; b=jkwhuFHyGP0W6eB0FCnQXRFH1i
	k4V8nJu/xHElplfQ/c7+njx0qvE8deBVDcTyE9rgOoghUUN5igilN5V+rqmTDMsJdhi77EBjPax08
	lA8P+A6XkAY08ZqqKSYqa0ObaIFU/zIhg1qD8D+i6rdt/dusU1Gb8Kp+2Zr3Z0Db+IG0+gwih/M8j
	rz68Ifm9ozpxAEai5f4RwNjVPSIy0hdirWJRWl8LRdwQuonmQ0XMaLj6mpsdCgF+19itDnfWgpwvq
	E8mZg+A1HzWTtwr9kEqbWA1PL8cyvMk6XTgd8953Bb8gr1Wj+cnR/ghH+HjPdxiNrpFw0z1wxLzV9
	y/8okUJw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5h-00000007Jwn-00cY;
	Sat, 27 Apr 2024 11:19:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bh-20OW;
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
Subject: [PATCH v2 11/15] KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
Date: Sat, 27 Apr 2024 12:05:08 +0100
Message-ID: <20240427111929.9600-12-dwmw2@infradead.org>
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

Let the callers pass the host TSC value in as an explicit parameter.

This leaves some fairly obviously stupid code, which using this function
to compare the guest TSC at some *other* time, with the newly-minted TSC
value from rdtsc(). Unless it's being used to measure *elapsed* time,
that isn't very sensible.

In this case, "obviously stupid" is an improvement over being non-obviously
so.

No functional change intended.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ef3cd6113037..ea59694d712a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2601,11 +2601,12 @@ u64 kvm_scale_tsc(u64 tsc, u64 ratio)
 	return _tsc;
 }
 
-static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
+static u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 host_tsc,
+				     u64 target_tsc)
 {
 	u64 tsc;
 
-	tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio);
+	tsc = kvm_scale_tsc(host_tsc, vcpu->arch.l1_tsc_scaling_ratio);
 
 	return target_tsc - tsc;
 }
@@ -2758,7 +2759,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
-	offset = kvm_compute_l1_tsc_offset(vcpu, data);
+	offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 	ns = get_kvmclock_base_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
@@ -2809,7 +2810,7 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		} else {
 			u64 delta = nsec_to_cycles(vcpu, elapsed);
 			data += delta;
-			offset = kvm_compute_l1_tsc_offset(vcpu, data);
+			offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data);
 		}
 		matched = true;
 	}
@@ -4024,7 +4025,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (msr_info->host_initiated) {
 			kvm_synchronize_tsc(vcpu, &data);
 		} else {
-			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
+			u64 adj = kvm_compute_l1_tsc_offset(vcpu, rdtsc(), data) -
+				vcpu->arch.l1_tsc_offset;
 			adjust_tsc_offset_guest(vcpu, adj);
 			vcpu->arch.ia32_tsc_adjust_msr += adj;
 		}
@@ -5098,7 +5100,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			mark_tsc_unstable("KVM discovered backwards TSC");
 
 		if (kvm_check_tsc_unstable()) {
-			u64 offset = kvm_compute_l1_tsc_offset(vcpu,
+			u64 offset = kvm_compute_l1_tsc_offset(vcpu, rdtsc(),
 						vcpu->arch.last_guest_tsc);
 			kvm_vcpu_write_tsc_offset(vcpu, offset);
 			vcpu->arch.tsc_catchup = 1;
-- 
2.44.0


