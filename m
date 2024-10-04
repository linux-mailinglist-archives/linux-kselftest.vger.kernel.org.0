Return-Path: <linux-kselftest+bounces-19027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A197C99056F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872C51C21438
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5A215F6A;
	Fri,  4 Oct 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZaJBfKXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE70215F5A;
	Fri,  4 Oct 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050951; cv=none; b=hL2RMvV41osUibkKOet3JGG9jq6piijqsYm8KeGlp6Rd9kimHG8Irbrn3Uf4/kI6kYoZ3aEsoerCsm0jiyv3tclFRgrR8csQgrBnOEGIjlQ2/NbdXAQgGTYmzFWI2EyY5iCP0jy116l7CG+ec9xS65XoOvDRM0D8x6CIfvGEpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050951; c=relaxed/simple;
	bh=d5e3re3bKYhsCTezzJ6vHBEGbT/gEBMfZwqxRw4jXj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbFJP1ZrBpJ39IZzK+KsvZ5476B3i7O2NUvSToIhjwcXBBGgE+YVfdkFsZFsXCL9WOwHvmJVJBvkx8Hxqq5N0s2OEEBhvMvuQdcrkRNAiXpR+4GlDNFmdiHad1/2C8KUUkEjKaGBPlHZ/s6ZvPnXvnpgm+qX8ZPcXCjyJcxaTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=ZaJBfKXk; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050951; x=1759586951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H0Of6mnihpmPtExDP0xT26xF0R3YjWEN9KFRfWKloXQ=;
  b=ZaJBfKXkQsgJvyAx03v2yOqYJ4WNw/exbFyk3N4DcKEisgHakV9JK6JK
   kQjXQb7+X9FurUVsI7r408ZLlTfDI07WP/LWMofFMNpLQFZGmdb1QsaoR
   oYiyCXFPQ4pI4Xu6WxoHGfbdbYYioBK9gnOu+KsaYh1hPPmGIcTco9X/Q
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="339710839"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:09:10 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:48210]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.194:2525] with esmtp (Farcaster)
 id 4e6ccfcf-09ca-4d48-a91d-b8dd0cd98837; Fri, 4 Oct 2024 14:09:08 +0000 (UTC)
X-Farcaster-Flow-ID: 4e6ccfcf-09ca-4d48-a91d-b8dd0cd98837
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:07 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:07 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:09:07 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id C101D40600;
	Fri,  4 Oct 2024 14:09:05 +0000 (UTC)
From: Nikolas Wipper <nikwip@amazon.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Nikolas
 Wipper" <nikwip@amazon.de>
Subject: [PATCH 3/7] KVM: x86: Check vCPUs before enqueuing TLB flushes in kvm_hv_flush_tlb()
Date: Fri, 4 Oct 2024 14:08:06 +0000
Message-ID: <20241004140810.34231-4-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004140810.34231-1-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In Hyper-V's kvm_hv_flush_tlb(), check targeted vCPUs and store them in a
bitmap before flushing their TLBs. In a subsequent commit, remote TLB
flushes may need to be aborted, so allow checking for that before starting
to enque the flushes.

No functional change intended.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/hyperv.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6e7941ed25ae..e68fbc0c7fc1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2134,26 +2134,21 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
 	if (all_cpus && !is_guest_mode(vcpu)) {
+		bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
+
 		kvm_for_each_vcpu(i, v, kvm) {
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			__set_bit(i, vcpu_mask);
 		}
-
-		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
 	} else if (!is_guest_mode(vcpu)) {
 		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
 		for_each_set_bit(i, vcpu_mask, KVM_MAX_VCPUS) {
 			v = kvm_get_vcpu(kvm, i);
-			if (!v)
+			if (!v) {
+				__clear_bit(i, vcpu_mask);
 				continue;
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
+			}
 		}
-
-		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
 	} else {
 		struct kvm_vcpu_hv *hv_v;
 
@@ -2181,14 +2176,19 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				continue;
 
 			__set_bit(i, vcpu_mask);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, true);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
 		}
+	}
 
-		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
+	for_each_set_bit(i, vcpu_mask, KVM_MAX_VCPUS) {
+		v = kvm_get_vcpu(kvm, i);
+
+		tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, is_guest_mode(vcpu));
+		hv_tlb_flush_enqueue(v, tlb_flush_fifo,
+				     tlb_flush_entries, hc->rep_cnt);
 	}
 
+	kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
+
 ret_success:
 	/* We always do full TLB flush, set 'Reps completed' = 'Rep Count' */
 	return (u64)HV_STATUS_SUCCESS |
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


