Return-Path: <linux-kselftest+bounces-4259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A98B84D08A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA64FB24B10
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62712E1FE;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvKP5vq8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659D1292FC;
	Wed,  7 Feb 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328755; cv=none; b=UWhfyvdiaNF0zTwrH4Z5jLanZNGymV2tC6JJuHHcO4TQqcU4DWYCrc3nwrz74bllZHnPe4bYjd1D6y0Tl378YjlfNcWDTkzlFXveJ9upSG+l/QaUTkdvEsS6JXIAOShnpB/8WxqMBovDAxOo6qqQyHfk86AME5Ew6PyOKjkvBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328755; c=relaxed/simple;
	bh=6yDtgID+NU20uYplexiB1KaOa+Pw5BLzopQ2Vyh34IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLB485q6UQMb4VctwcADQ29huHLplZAbhjBjs7roNHEzG/4Rw63P8RVikxENU4f8fc4Q9xeh2GnTWnZZwt+Z9MtnoSrLhCOfM2JNhEjG3FqoLRp69rEtCRCiQHRhZc9gUe0sgRTKbLYT011v08LnMw5aEZN9YXT/B3Ej3rbj1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvKP5vq8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328755; x=1738864755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yDtgID+NU20uYplexiB1KaOa+Pw5BLzopQ2Vyh34IM=;
  b=jvKP5vq8i560Dtekp3lYw5efJ5hMWesynOUWh5KKbcslaDhZ4ZDu0e4u
   2BKZSX9rR2ZAhnp9TbkDjjSnE2CjjDYAG12EV4sd8aFWNAFOSukdlFzv+
   dP2EWKDqru3LmaYtFzGmigJy+rOLp8ntys8hKJ6sx/UyDIxo8i9IvnR+5
   3Ra/jArneBrnqlgq8I86T/daEtGIhNHJ3f01a0km1SnKNQsOe8he687RF
   V71cE0Yg2XVETJhqAJ24bkzYyKsNlHX800wAi6XR/N30pGSO+qXXyKRMS
   4Rm8GBwoFOhYLGid9/cHOUr16u5XWvn066/SM4DdQp1+4Io2Xw9yjDyPq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622618"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622618"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020737"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:57 -0800
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
Subject: [PATCH v2 14/25] KVM: VMX: Disable FRED if FRED consistency checks fail
Date: Wed,  7 Feb 2024 09:26:34 -0800
Message-ID: <20240207172646.3981-15-xin3.li@intel.com>
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

Refuse to virtualize FRED if FRED consistency checks fail.

Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/capabilities.h | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c          |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index e8f3ad0f79ee..73bf6618c425 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -400,6 +400,16 @@ static inline bool vmx_pebs_supported(void)
 	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
 }
 
+static inline bool cpu_has_vmx_fred(void)
+{
+	return boot_cpu_has(X86_FEATURE_FRED) &&
+		(vmcs_config.basic & VMX_BASIC_NESTED_EXCEPTION) &&
+		(vmcs_config.vmexit_ctrl & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) &&
+		(vmcs_config.secondary_vmexit_ctrl & SECONDARY_VM_EXIT_SAVE_IA32_FRED) &&
+		(vmcs_config.secondary_vmexit_ctrl & SECONDARY_VM_EXIT_LOAD_IA32_FRED) &&
+		(vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_FRED);
+}
+
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1f265d526daf..a484b9ac2400 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8113,6 +8113,8 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_DS);
 		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
 	}
+	if (!cpu_has_vmx_fred())
+		kvm_cpu_cap_clear(X86_FEATURE_FRED);
 
 	if (!enable_pmu)
 		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
-- 
2.43.0


