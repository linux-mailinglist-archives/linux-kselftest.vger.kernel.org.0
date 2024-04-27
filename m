Return-Path: <linux-kselftest+bounces-8981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281578B45F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D866728592B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895354CB36;
	Sat, 27 Apr 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxO5U5xo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178224D9FA;
	Sat, 27 Apr 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216888; cv=none; b=rn/cSXmMytuQ7c9WMbW7WTBNWYBI8JswE84ZoYPXUm9Bp533Q2vt5qeOiIgZZ7yI9l8rPfA2pwLyYs/uXrJuLgHmo/xAOAav8GNONnDipr4xCRehBukUzZ6YWrGPlIXcdXY3/x5h4HNqGlD0bCTbOPy4w9e1bLB1TtS4tdNFH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216888; c=relaxed/simple;
	bh=q234AdlrqFb6gEgXej3Qyt4lhLROvR6uaavVzSiG6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofbFpNGGzYYJev88XevNeDsK3dXizRiUnPlhjHEtXIZAe/tc1kfCLATNo6XUzsxxh1b9rWjGhvrwWRmOYqXdbE/j0jEcDmVt2ZM00p7asn9j8MHoygpv9NosSRPBLeOBSIN96L1PZ7/mX0P3V/3PKHANmmxwzPeAfcIEKilp4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxO5U5xo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=U35TMzdrNli2izCJdFnYbyRs0V77OD2PqLViAcJYq/4=; b=hxO5U5xofonRRT6DH2IqMSnsZg
	EcjO9Z8XG5e3WWqCQhtBKrT4Ih4VcwnV71BtwC5t2Kdfx5LwM06LNUSSB/uEB2rUc3qd3sBpPjgFo
	5W70XvRfCwgsiEv4Gubq6SFoV+fUpbhx9ad/aGzcd2cKFDK12PcoHm3C7fowtqBBG9N3euu2SFe/Y
	l+EW8Si2Z2TEoxPhIDfhUD8suRrYzxwQI/Cm5GVNKKNJz0bbpops0eoTmWlMw6rtvz2xYAQeXwrKC
	xw6bNP+sHOfOgP6FshXSFGhuuj7I5bbv0B4CrEIHNME8nIaU6663y/RsGLvLPVr8HzDWo+6HoWToP
	whoN/a+g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5i-0000000FeZj-0p1P;
	Sat, 27 Apr 2024 11:20:54 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-000000002bo-2LwR;
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
Subject: [PATCH v2 13/15] KVM: x86: Kill cur_tsc_{nsec,offset,write} fields
Date: Sat, 27 Apr 2024 12:05:10 +0100
Message-ID: <20240427111929.9600-14-dwmw2@infradead.org>
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

These pointlessly duplicate of the last_tsc_{nsec,offset,write} values.

The only place they were used was where the TSC is stable and a new vCPU
is being synchronized to the previous setting, in which case the 'last_'
value is definitely identical.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h | 3 ---
 arch/x86/kvm/x86.c              | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b01c1d000fff..7d06f389a607 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1354,9 +1354,6 @@ struct kvm_arch {
 	u32 last_tsc_khz;
 	u64 last_tsc_offset;
 	u64 last_tsc_scaling_ratio;
-	u64 cur_tsc_nsec;
-	u64 cur_tsc_write;
-	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	int nr_vcpus_matched_tsc;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6ec43f39bdb0..92e81bfca25a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2737,9 +2737,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 		 * These values are tracked in kvm->arch.cur_xxx variables.
 		 */
 		kvm->arch.cur_tsc_generation++;
-		kvm->arch.cur_tsc_nsec = ns;
-		kvm->arch.cur_tsc_write = tsc;
-		kvm->arch.cur_tsc_offset = offset;
 		kvm->arch.nr_vcpus_matched_tsc = 0;
 	} else if (vcpu->arch.this_tsc_generation != kvm->arch.cur_tsc_generation) {
 		kvm->arch.nr_vcpus_matched_tsc++;
@@ -2747,8 +2744,6 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 
 	/* Keep track of which generation this VCPU has synchronized to */
 	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
-	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
-	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
 
 	kvm_track_tsc_matching(vcpu);
 }
@@ -2825,8 +2820,8 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
 		data = kvm->arch.last_tsc_write;
 
 		if (!kvm_check_tsc_unstable()) {
-			offset = kvm->arch.cur_tsc_offset;
-			ns = kvm->arch.cur_tsc_nsec;
+			offset = kvm->arch.last_tsc_offset;
+			ns = kvm->arch.last_tsc_nsec;
 		} else {
 			/*
 			 * ... unless the TSC is unstable and has to be
-- 
2.44.0


