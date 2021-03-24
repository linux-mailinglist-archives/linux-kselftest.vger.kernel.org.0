Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D6348231
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Mar 2021 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhCXTuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Mar 2021 15:50:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:32552 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237639AbhCXTuh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Mar 2021 15:50:37 -0400
IronPort-SDR: jKClsJYegC00vhcihbSl5NtM9N6r5ALiWp//kKuASTSOx6grsJad0v3U+JUHHjQqqBuz5FSjzG
 DpzqY37FX/4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275899792"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="275899792"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:50:37 -0700
IronPort-SDR: +aY3NsFtar4oXIAGoqRiDJlXJb1oJ95QIdDNlGt3JyeCUc4+nFulSjO+UoaFD2SHMT06DF7R/T
 j95OItNvcz5A==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="409000093"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:50:36 -0700
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
Subject: [PATCH V4.1] x86/fault: Adjust WARN_ON for PKey fault
Date:   Wed, 24 Mar 2021 12:50:33 -0700
Message-Id: <20210324195033.2490353-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210322053020.2287058-7-ira.weiny@intel.com>
References: <20210322053020.2287058-7-ira.weiny@intel.com>
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

