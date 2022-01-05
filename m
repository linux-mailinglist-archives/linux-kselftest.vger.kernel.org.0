Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8048529B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiAEMgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:6468 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240115AbiAEMgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386170; x=1672922170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yNfHYNLdG2Wh+iGYwcxaYZJRnv7x3kkVnNiJujxhbuA=;
  b=ixgsBPvIRBVmFoVjOmJ0AqU1ikfe2f5cumySOYX//q9Reba9e8r7Bjpf
   fvfTAX5q6sXP9f1fiXjQO0EVsyElwUeMM2usPpcuTZWTKEaWtyer6ERhK
   uzTwc74LIbY1BrFdYobrL3t9mC4KBADPZ3JzV9KEiSOnufOHWe0X/gZkw
   PLgJRPUuxa7xQH0RPoDV3nWH5KsEjP+5JGugAoicAIhTceCdB+ASCX6dD
   BkEK5yibFbNrl3k4eYNan+FN4hDG0hV/nBGGK4cJ1WwQxDfJUpUVXCKwl
   R/iFB+o+QcaGin/i+IFEs5xJhwZbvXSKE5mIx3h/lN/N0aVoo1loocSj7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249379"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249379"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004856"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:38 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 11/21] x86/fpu: Prepare xfd_err in struct fpu_guest
Date:   Wed,  5 Jan 2022 04:35:22 -0800
Message-Id: <20220105123532.12586-12-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

When XFD causes an instruction to generate #NM, IA32_XFD_ERR
contains information about which disabled state components are
being accessed. The #NM handler is expected to check this
information and then enable the state components by clearing
IA32_XFD for the faulting task (if having permission).

If the XFD_ERR value generated in guest is consumed/clobbered
by the host before the guest itself doing so, it may lead to
non-XFD-related #NM treated as XFD #NM in host (due to non-zero
value in XFD_ERR), or XFD-related #NM treated as non-XFD #NM in
guest (XFD_ERR cleared by the host #NM handler).

Introduce a new field in fpu_guest to save the guest xfd_err value.
KVM is expected to save guest xfd_err before interrupt is enabled
and restore it right before entering the guest (with interrupt
disabled).

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c752d0aa23a4..3795d0573773 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -517,6 +517,11 @@ struct fpu_guest {
 	 */
 	u64				perm;
 
+	/*
+	 * @xfd_err:			Save the guest value.
+	 */
+	u64				xfd_err;
+
 	/*
 	 * @fpstate:			Pointer to the allocated guest fpstate
 	 */
