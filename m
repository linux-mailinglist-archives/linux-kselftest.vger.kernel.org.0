Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA335230E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 00:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhDAW6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 18:58:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:11530 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhDAW6i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 18:58:38 -0400
IronPort-SDR: dui/g2P/GGrVuqZk2FY7siuSxrKXhN57D6ClSJOiBYJyRdY83+muKkkxoAG4pg8IDieNX72Epl
 tPxASwsBrIJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190117107"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190117107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:37 -0700
IronPort-SDR: Iu6fTwQoZ98uMmFHDB6Z8+rKIc+0xugOW7VluQv1j6K3mita2jQ/Fub6hUzbaajpXc3KEAqIyg
 qCFecINMnZVA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611092362"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:37 -0700
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
Subject: [PATCH V6 06/10] x86/fault: Adjust WARN_ON for PKey fault
Date:   Thu,  1 Apr 2021 15:58:29 -0700
Message-Id: <20210401225833.566238-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210401225833.566238-1-ira.weiny@intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
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
Changes from V5:
	From Dave Hansen
		Remove 'we' from comment

Changes from V4:
	From Sean Christopherson
		Clean up commit message and comment
		Change cpu_feature_enabled to be in WARN_ON check
---
 arch/x86/mm/fault.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..0e0e90968f57 100644
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
+	 * when PKS (PKeys Supervisor) is enabled.
+	 *
+	 * However, if PKS is not enabled WARN if this exception is seen
+	 * because there are no user pages in the kernel portion of the address
+	 * space.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
+		     (hw_error_code & X86_PF_PK));
 
 #ifdef CONFIG_X86_32
 	/*
-- 
2.28.0.rc0.12.gb6a658bd00c9

