Return-Path: <linux-kselftest+bounces-4258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8899A84D080
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89FE1C21267
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442D12BF18;
	Wed,  7 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCB9h80F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10E127B40;
	Wed,  7 Feb 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328754; cv=none; b=NhpX6zDodKTMSnKnai/ywGt+We0mUna8mztBlNTB1Pwjwsykf6FU96a/uFf88XzvRadnkCA35VbF/FjiXSbzPJRzxXs608/FN5Hk3wifXjycZLmoTdt/whdKisAWWf1UIprwK6eqlhOPSq2MH4o5cWr9US3Y7HBVpjsmvqNgCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328754; c=relaxed/simple;
	bh=yTi4kr3PlzXNPrwqknVaKsYqhBkec/CNGRO3VuNenIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D128TCLDPMq5OzUb+E8n/Nz0S6jcS2Kv9j6EOygWpihi5cpIMSfwMLzoPksuDe/un7MgeaZmXZYtGvmdiUpA3a39hP0jNZjosR+15MzmVPocLhOcqr3o1IDykYnRL8egcKSwqJG0jte/dO8VhlO81zbTphxjwNABvaC6hgYhxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCB9h80F; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328749; x=1738864749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTi4kr3PlzXNPrwqknVaKsYqhBkec/CNGRO3VuNenIU=;
  b=OCB9h80F7FAanD2ydW1HwX83AWeHVomZP1XI5gtKVGBrJ6QMXttwHb2+
   Hed4Wl0a2WKc+5Kvf74/AsOfCe76wej4ZwEOPCqdNUk14GIljTH2GAXy0
   wYhbpIb9sS7eD0W/hC1QtunqirRyCuGqbp+ZtpXpz7d0DI1g8WU97wc++
   OCqNNm5+oaBk10c/CiwZiM54hjf4aUzKGFh2gyJLHC7kZQnTMSPXPHPiG
   vxrMGHwg3Dla5aS2vR68X2F7FQsGonot5rNn9DQse3lFLguRlhI0QC44t
   qnZWsrdftvuP7K9o84sqA89HvThib+nmZ3tSgCwX6l1cNKen5s/zk+zM1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622567"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020727"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:56 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 11/25] KVM: x86: Add kvm_is_fred_enabled()
Date: Wed,  7 Feb 2024 09:26:31 -0800
Message-ID: <20240207172646.3981-12-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kvm_is_fred_enabled() to get if FRED is enabled on a vCPU.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Explain why it is ok to only check CR4.FRED (Chao Gao).
---
 arch/x86/kvm/kvm_cache_regs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 75eae9c4998a..1d431c703fdf 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -187,6 +187,23 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
 	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
 }
 
+/*
+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
+ * a vCPU is running with FRED enabled, because:
+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
+ *
+ * More details at FRED Spec 6.0 Section 4.2 Enabling in CR4.
+ */
+static __always_inline bool kvm_is_fred_enabled(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
+#else
+	return false;
+#endif
+}
+
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-- 
2.43.0


