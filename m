Return-Path: <linux-kselftest+bounces-8983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A48B45FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F61C22F99
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88A4EB45;
	Sat, 27 Apr 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BWCD4+ZL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178734DA05;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216888; cv=none; b=mP4eogpPEADROPbqqKe2QspclhxlAyPQu6BJABHU5OhvyVu3ut4EUEJn0b4ZFubES1w04O0eCQedyr6hHV8JNlXWtXGgC/GeEgnEh1x8muBe6DPWE+rWIwAZnmU4sY+fyxYwqlIVo1td47Uxk3tX5izcNHwWWv0ctadN3qowdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216888; c=relaxed/simple;
	bh=ldxafWPK+uthBWvPqxKpJGFwoUJXBXL/6tlTeC52pLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCd/io8obHVn9t/wQTWJa7Fza6U7+oqUruHQdvPWoHUPcn1JgWIf5A/TLk99OpJ15ZD95MWtEH5cbYOs0B3xcKmIBfpHcIj7FFmc+1yDGrMc0rldSGbfoAjwmRKwSgNhWqgjI3ICpto/AVxN4qAPnz6w1WcytPLcDLl4Qj8kEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BWCD4+ZL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hPvcvGj1y+IOFqFEZQ+yWKdeGU+LYxE6KkMCutNBHnc=; b=BWCD4+ZLAlnVyvGB2nq9wPhDYe
	w1xCjHrsnTCmRIc9ev97eslzpHnc0glI9rxHSGHjV+OxRzqqK9+1WvK66V/wPcQFfLvHpA1VtHNh8
	TKiGCo4T5dwxFyqJdhLAwJQEmtWR5xVSErBxzfJwu28sWri1m6qqyYhZVYEuNZxQbaIhVGlq4UpNH
	pgEMCgcOWdydAZcMTggWUZW9iPncXmLoKWCXA9EYAiXYAnBf69DwPy/ICqNR1J3IFYO/Nx7pAhoOB
	aEp6D0KoiSfrqntjXYBCZq8QdaFve7/N27+N7rGO1iFFMbpyPjd4Bfl8O1w0DxnRxGK9suVh4zZi+
	QwKvkLfQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5i-0000000FeZe-0pZA;
	Sat, 27 Apr 2024 11:19:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5f-000000002b6-3hKv;
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
Subject: [PATCH v2 02/15] KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
Date: Sat, 27 Apr 2024 12:04:59 +0100
Message-ID: <20240427111929.9600-3-dwmw2@infradead.org>
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

The kvm_guest_time_update() function scales the host TSC frequency to
the guest's using kvm_scale_tsc() and the v->arch.l1_tsc_scaling_ratio
scaling ratio previously calculated for that vCPU. Then calcuates the
scaling factors for the KVM clock itself based on that guest TSC
frequency.

However, it uses kHz as the unit when scaling, and then multiplies by
1000 only at the end.

With a host TSC frequency of 3000MHz and a guest set to 2500MHz, the
result of kvm_scale_tsc() will actually come out at 2,499,999kHz. So
the KVM clock advertised to the guest is based on a frequency of
2,499,999,000 Hz.

By using Hz as the unit from the beginning, the KVM clock would be based
on a more accurate frequency of 2,499,999,999 Hz in this example.

Fixes: 78db6a503796 ("KVM: x86: rewrite handling of scaled TSC for kvmclock")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/x86.c              | 17 +++++++++--------
 arch/x86/kvm/xen.c              |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 01c69840647e..8440c4081727 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -887,7 +887,7 @@ struct kvm_vcpu_arch {
 
 	gpa_t time;
 	struct pvclock_vcpu_time_info hv_clock;
-	unsigned int hw_tsc_khz;
+	unsigned int hw_tsc_hz;
 	struct gfn_to_pfn_cache pv_time;
 	/* set guest stopped flag in pvclock flags field */
 	bool pvclock_set_guest_stopped_request;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2d2619d3eee4..23281c508c27 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3215,7 +3215,8 @@ static void kvm_setup_guest_pvclock(struct kvm_vcpu *v,
 
 static int kvm_guest_time_update(struct kvm_vcpu *v)
 {
-	unsigned long flags, tgt_tsc_khz;
+	unsigned long flags;
+	uint64_t tgt_tsc_hz;
 	unsigned seq;
 	struct kvm_vcpu_arch *vcpu = &v->arch;
 	struct kvm_arch *ka = &v->kvm->arch;
@@ -3252,8 +3253,8 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 
 	/* Keep irq disabled to prevent changes to the clock */
 	local_irq_save(flags);
-	tgt_tsc_khz = get_cpu_tsc_khz();
-	if (unlikely(tgt_tsc_khz == 0)) {
+	tgt_tsc_hz = get_cpu_tsc_khz() * 1000LL;
+	if (unlikely(tgt_tsc_hz == 0)) {
 		local_irq_restore(flags);
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
 		return 1;
@@ -3288,14 +3289,14 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	/* With all the info we got, fill in the values */
 
 	if (kvm_caps.has_tsc_control)
-		tgt_tsc_khz = kvm_scale_tsc(tgt_tsc_khz,
-					    v->arch.l1_tsc_scaling_ratio);
+		tgt_tsc_hz = kvm_scale_tsc(tgt_tsc_hz,
+					   v->arch.l1_tsc_scaling_ratio);
 
-	if (unlikely(vcpu->hw_tsc_khz != tgt_tsc_khz)) {
-		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_khz * 1000LL,
+	if (unlikely(vcpu->hw_tsc_hz != tgt_tsc_hz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, tgt_tsc_hz,
 				   &vcpu->hv_clock.tsc_shift,
 				   &vcpu->hv_clock.tsc_to_system_mul);
-		vcpu->hw_tsc_khz = tgt_tsc_khz;
+		vcpu->hw_tsc_hz = tgt_tsc_hz;
 		kvm_xen_update_tsc_info(v);
 	}
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 5a83a8154b79..014048c22652 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2273,7 +2273,7 @@ void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu)
 
 	entry = kvm_find_cpuid_entry_index(vcpu, function, 2);
 	if (entry)
-		entry->eax = vcpu->arch.hw_tsc_khz;
+		entry->eax = vcpu->arch.hw_tsc_hz / 1000;
 }
 
 void kvm_xen_init_vm(struct kvm *kvm)
-- 
2.44.0


