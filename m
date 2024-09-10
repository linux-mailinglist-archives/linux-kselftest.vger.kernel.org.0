Return-Path: <linux-kselftest+bounces-17613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608B973BD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6907C1C25CC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B519E81F;
	Tue, 10 Sep 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="fmyPc+Sv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF11925B4;
	Tue, 10 Sep 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981934; cv=none; b=vCC43e28ex+AABykKcG6mk+f/kftcu7In1HWqEQkFarFADOcxGsSoSqKue5YI54xrEVXgtigMuV8hj5Zcq5sQJZjwvcqSEncHs6HiCxGj2UZPIOShYlR6KWnTbDpICXQQLVretiA2b7pfUGheTiwdXzmuHc7l0jtVOXMXyErGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981934; c=relaxed/simple;
	bh=lwh5M10z4RNM2Da7RQPLG2d6B6aeiw/t0tqiRaPr1iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aq7nhpgnKEqgaz9dbP+CtD4fyJCyiMT4azBAyukoiW+bjCz1hiLLIdWWByEUFsW2EYgYCoiupiSRcJYxoRetbi9UMnBdZREfFO6WnqhdYUqrfbcWfpWz6MefUfNxGqFScMRJkVQvROWUTDg07F5t3ErFxEG4s7+Xi6/CvTX5M/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=fmyPc+Sv; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981934; x=1757517934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBFZ6gE4Eg8idRjndx3TROKSBGwrVfkZ4QZJ3iCcd00=;
  b=fmyPc+Sv42ljvz10vLDEpb99oxVcMkXNxj8slfOFAbfhiBAm6RBiu3sb
   Si/OOdCqj18Jt0xs1/j7x3cWfSQquVF3QcIdpuw0xkzUc/j9dy7ymU50J
   ZsLEcihw6TMOJduL3YJ7Xj3E9kbPyEWsgWEAebfZPeBcr/Uw304cc4cKr
   8=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="24631299"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:25:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:1552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.54:2525] with esmtp (Farcaster)
 id a5951997-5357-4874-bf9e-57a899457c9a; Tue, 10 Sep 2024 15:25:29 +0000 (UTC)
X-Farcaster-Flow-ID: a5951997-5357-4874-bf9e-57a899457c9a
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:28 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:25:28 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:25:26 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 11/15] KVM: x86: Introduce generic gva to gpa translation function
Date: Tue, 10 Sep 2024 15:22:03 +0000
Message-ID: <20240910152207.38974-12-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a function to translate gvas to gpas with the ability to control
set_bit_mode, access mode and flags, as well as receive status codes.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/x86.c              | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7ac1956f6f9b..ae05e917d7ea 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2160,6 +2160,9 @@ static inline bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu,
 void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
 			ulong roots_to_free);
 void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu);
+gpa_t kvm_mmu_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t gva, u64 access,
+			 u64 flags, struct x86_exception *exception,
+			 u16 *status);
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception);
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be696b60aba6..27fc71aaa1e4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7577,6 +7577,17 @@ gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
 	return t_gpa;
 }
 
+gpa_t kvm_mmu_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t gva, u64 access,
+			 u64 flags, struct x86_exception *exception,
+			 u16 *status)
+{
+	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+
+	return mmu->gva_to_gpa(vcpu, mmu, gva, access, flags, exception,
+			       status);
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_gva_to_gpa);
+
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


