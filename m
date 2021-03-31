Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0E350737
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhCaTOq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 15:14:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:51675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235205AbhCaTOU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 15:14:20 -0400
IronPort-SDR: 13l5yCSUSa49xcacdNew7eFZCleSrAnZbShh12NyS72hi6JW1avhiUPa7J2Oa+2pIxH5UvMNOs
 YcL9P2ltxjKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171490619"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="171490619"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:20 -0700
IronPort-SDR: JkU84B66zZpAcXI/v04F3IGdywiPXk5XQoo+rWf0jLIWXQfa0+Hnr1yghVpGQvFrmE8roN/Kvd
 oDas3Iu6ArBQ==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="610625404"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:20 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V5 06/10] x86/fault: Adjust WARN_ON for PKey fault
Date:   Wed, 31 Mar 2021 12:14:01 -0700
Message-Id: <20210331191405.341999-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210331191405.341999-1-ira.weiny@intel.com>
References: <20210331191405.341999-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Previously if a Protection key fault occurred it indicated something
very wrong because user page mappings are not supposed to be in the
kernel address space.

Now PKey faults may happen on kernel mappings if the feature is enabled.

Remove the warning in the fault path and allow the oops to occur without
extra debugging if PKS is enabled.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	From Sean Christopherson
		Clean up commit message and comment
		Change cpu_feature_enabled to be in WARN_ON check
---
 arch/x86/mm/fault.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..c32d01803e26 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1141,11 +1141,15 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
+	 * when PKS (PKeys Supervisor) are enabled.
+	 *
+	 * If PKS is not enabled an exception should only happen on user pages.
+	 * Because, we have no user pages in the kernel portion of the address
+	 * space something must have gone very wrong and we should WARN.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
+		     (hw_error_code & X86_PF_PK));
 
 #ifdef CONFIG_X86_32
 	/*
-- 
2.28.0.rc0.12.gb6a658bd00c9

