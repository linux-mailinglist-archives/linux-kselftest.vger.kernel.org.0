Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA70481359
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhL2NPL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:28053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240276AbhL2NOc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783672; x=1672319672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fnag2JsrCvT03RIc81RlUKs1q0XbDEnd56R7/rL5qvg=;
  b=Ly2LLsBm2QnPAmju9oLKTSqk+LzswyxGK65dGmhrRqvHG6ynnQ6+UGvs
   P7lsBFJqNyFxiNf0SAO5mOsykyhp1tgX9N1o8pIcvjfw9DNQWK6mhk/sy
   BnGI76OhddIRDf5LGnXYgAZkDKEGcxNaAFSMPtRLDsOmukZGTIfMkLPPr
   TfCVrc/CmEr0hPAPOvRQU75jWBybmfg/wuwQN8yBAlM1emTuqkgdMBONJ
   qMs63Av/kJRnLrL6CPF5PVTm4M4oHX+LdyG21QF1nVi44nkhfRvEX1dr9
   onVSjvYHiH6XZ4TZurfB0Ln5w7OiZ4POiY4wbogimMgTYQGTTHG2UqUop
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876160"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281210"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:42 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 17/21] x86/fpu: Add uabi_size to guest_fpu
Date:   Wed, 29 Dec 2021 05:13:24 -0800
Message-Id: <20211229131328.12283-18-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Userspace needs to inquire KVM about the buffer size to work
with the new KVM_SET_XSAVE and KVM_GET_XSAVE2. Add the size info
to guest_fpu for KVM to access.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 5 +++++
 arch/x86/kernel/fpu/core.c       | 1 +
 arch/x86/kernel/fpu/xstate.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3795d0573773..eb7cd1139d97 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -522,6 +522,11 @@ struct fpu_guest {
 	 */
 	u64				xfd_err;
 
+	/*
+	 * @uabi_size:			Size required for save/restore
+	 */
+	unsigned int			uabi_size;
+
 	/*
 	 * @fpstate:			Pointer to the allocated guest fpstate
 	 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3daea097c618..89d679cc819b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -240,6 +240,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	gfpu->fpstate		= fpstate;
 	gfpu->xfeatures		= fpu_user_cfg.default_features;
 	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->uabi_size		= fpu_user_cfg.default_size;
 	fpu_init_guest_permissions(gfpu);
 
 	return true;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0c0b2323cdec..10fe072f1c92 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1545,6 +1545,7 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 		newfps->is_confidential = curfps->is_confidential;
 		newfps->in_use = curfps->in_use;
 		guest_fpu->xfeatures |= xfeatures;
+		guest_fpu->uabi_size = usize;
 	}
 
 	fpregs_lock();
