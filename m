Return-Path: <linux-kselftest+bounces-4262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88284D097
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AD21C22E0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2313132C0C;
	Wed,  7 Feb 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkP6UW/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48912E1FF;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328757; cv=none; b=XCSGxIPlIX0xUYnhGsN8k4qhDha/1mQgTWkyYyMRLXWBgfUbJ9XbHAZTFgxgwfNrXGvPpd08NVTx9pCG7wl72SxAEB7a7is68OpNMYDZG+3Qm2rlqDh0fpIJZzZKcodtDFNV3T9EdlhSWxEltkC/NyCI0nJ5jr77ngHhVhpPEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328757; c=relaxed/simple;
	bh=3pK7WhYRNrzUuExDIrRQm3nMz+8daA5Durxbr8goEqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZtypkzkCruF4+WtzOYcROMg4XRswVp+w/KiV5Pkt5D2IyB/I+A1LewlIl8jvFokHESKQ67+pIZo1yCqhxd3EncJswtjBpdv3TfD/50S35jtpEWxvd/NJMsmVt1Y+geGbSQaS9YwvDo99pkZqjdBEtDwPzJjiwurdYQMC5uqinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkP6UW/r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328756; x=1738864756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pK7WhYRNrzUuExDIrRQm3nMz+8daA5Durxbr8goEqA=;
  b=MkP6UW/r7J2zFPdKcii71cIHypVuCxcYH4n9BtlYmiefG3pi82t5a3Oa
   bAjUhDe2W+0qGJFJhvsjNph6g6BSDk7PiaiS9niDXjo2qIyj/Ez0v/ksh
   32cxftjDiDD3y5BWEh+uNOlP02A/Eu90grm69zlZKLB2aORKkilug60Ce
   4kttSkCAhNpmAN/f1mgGZPT8GCHJz33eNpF9sJJL+JVCjg/neVJ8kSkrx
   3mxo0jg7MRvXFoWJgE08tZjHBbrnS0u0sE+gTaA5lQxbTsK0tYEyWppeQ
   sxUCEbxZu1F+Zf3sXnRX4wx7U3kgj4X6zcD/eEjM7Q4p+fJ7AFv3quVdW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622640"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622640"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020744"
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
Subject: [PATCH v2 16/25] KVM: VMX: Invoke vmx_set_cpu_caps() before nested setup
Date: Wed,  7 Feb 2024 09:26:36 -0800
Message-ID: <20240207172646.3981-17-xin3.li@intel.com>
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

Set VMX CPU capabilities before initializing nested instead of after,
as it needs to check VMX CPU capabilities to setup the VMX basic MSR
for nested.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3409607122d..fc808d599493 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8912,6 +8912,8 @@ static __init int hardware_setup(void)
 
 	setup_default_sgx_lepubkeyhash();
 
+	vmx_set_cpu_caps();
+
 	if (nested) {
 		nested_vmx_setup_ctls_msrs(&vmcs_config, vmx_capability.ept);
 
@@ -8920,8 +8922,6 @@ static __init int hardware_setup(void)
 			return r;
 	}
 
-	vmx_set_cpu_caps();
-
 	r = alloc_kvm_area();
 	if (r && nested)
 		nested_vmx_hardware_unsetup();
-- 
2.43.0


