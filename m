Return-Path: <linux-kselftest+bounces-4254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29384D06C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E421F21DA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC91272D7;
	Wed,  7 Feb 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFx5vvUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C183CBD;
	Wed,  7 Feb 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328748; cv=none; b=R+//D2VtxYgdOlv/7wGM9/HTcNdnRquWqAYlniBW3gwm13cOkjWGIy6c6DDkW3HAyTDX7aYM/TCiWtXhrVnhGEkRkoXSQnIm2QtmA8ira7MYcYl+02QUZ13cN4WnoT7oX7MdwjCot7xk4F8i0oiXDcKyr4e/D/3FfZwTaLn0b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328748; c=relaxed/simple;
	bh=/ejIOyjEmSLEKy4yAWEhsQcfTxQrq3hmpN4TbywkFdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+XWb9vCsuXCnt16bvYyc+Tz53zsvG/ZK8erJdRMSHn+0ErbgoXhI3sDt/gVFTvIOVl2H8VHqK0beMIHHw4aJRYCf/qXykLXqV9weVUWdCD54biQarioQAs51AaaIJhgVtZrd1wd2gxS0QGsZcjmkbw1jrAIbBd/9N2JqAxv5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFx5vvUr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328742; x=1738864742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ejIOyjEmSLEKy4yAWEhsQcfTxQrq3hmpN4TbywkFdQ=;
  b=iFx5vvUrk1FnzNlPrZ73+gW3MhDVwC6Hw64DqpvScd13I2pAPEEDCNx0
   lmlcNRjNGhsCfWXM3OXSasDaZ1k1CBPXBMc93b/8A3r/eC2CHSEyPEErT
   TG03sxAJrolp7GCqwNMaOShLxb/lMwq0N9B+vGJjJQGRgLHZqEj27QjPK
   HEaFWDER+7mXLWRqta0Vn8FtKaCylNm3+xK1my6HOGXLiDSgUZgM3M92j
   u9LY8YOR74fTYxdbns8zlZqtzhJ1bCqVKo9dgP9FdrOEL4nqxYVGwk91G
   74UZNoFoNcE6HQwXV2CFjSpTGwziWITV7mynYcW+ZhvWXjiXP7UdKaKKc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622525"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622525"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020707"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:54 -0800
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
Subject: [PATCH v2 05/25] KVM: VMX: Initialize FRED VM entry/exit controls in vmcs_config
Date: Wed,  7 Feb 2024 09:26:25 -0800
Message-ID: <20240207172646.3981-6-xin3.li@intel.com>
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

Setup the global vmcs_config for FRED:
1) Add VM_ENTRY_LOAD_IA32_FRED to KVM_OPTIONAL_VMX_VM_ENTRY_CONTROLS to
   have a FRED CPU load guest FRED MSRs from VMCS upon VM entry.
2) Add SECONDARY_VM_EXIT_SAVE_IA32_FRED to
   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU save
   guest FRED MSRs to VMCS during VM exit.
3) add SECONDARY_VM_EXIT_LOAD_IA32_FRED to
   KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS to have a FRED CPU load
   host FRED MSRs from VMCS during VM exit.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
---

Change since v1:
* Remove FRED VM entry/exit controls consistency checks in
  setup_vmcs_config() (Sean Christopherson).
---
 arch/x86/include/asm/vmx.h | 3 +++
 arch/x86/kvm/vmx/vmx.h     | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 272af2004111..cb14f7e315f5 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -106,6 +106,8 @@
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
 #define VM_EXIT_ACTIVATE_SECONDARY_CONTROLS	0x80000000
+#define SECONDARY_VM_EXIT_SAVE_IA32_FRED	0x00000001
+#define SECONDARY_VM_EXIT_LOAD_IA32_FRED	0x00000002
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -119,6 +121,7 @@
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
 #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
 #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
+#define VM_ENTRY_LOAD_IA32_FRED			0x00800000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f470eeb2a5c8..3ad52437f426 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -484,7 +484,8 @@ static inline u8 vmx_get_rvi(void)
 	 VM_ENTRY_LOAD_IA32_EFER |					\
 	 VM_ENTRY_LOAD_BNDCFGS |					\
 	 VM_ENTRY_PT_CONCEAL_PIP |					\
-	 VM_ENTRY_LOAD_IA32_RTIT_CTL)
+	 VM_ENTRY_LOAD_IA32_RTIT_CTL |					\
+	 VM_ENTRY_LOAD_IA32_FRED)
 
 #define __KVM_REQUIRED_VMX_VM_EXIT_CONTROLS				\
 	(VM_EXIT_SAVE_DEBUG_CONTROLS |					\
@@ -510,7 +511,9 @@ static inline u8 vmx_get_rvi(void)
 	       VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
 
 #define KVM_REQUIRED_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
-#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS (0)
+#define KVM_OPTIONAL_VMX_SECONDARY_VM_EXIT_CONTROLS			\
+	     (SECONDARY_VM_EXIT_SAVE_IA32_FRED |			\
+	      SECONDARY_VM_EXIT_LOAD_IA32_FRED)
 
 #define KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL			\
 	(PIN_BASED_EXT_INTR_MASK |					\
-- 
2.43.0


