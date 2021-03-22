Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E70343899
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVFao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 01:30:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:18631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhCVFai (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 01:30:38 -0400
IronPort-SDR: AjJ3GGFEXiHLSY2yJbUyOWlC9DgBsNq4+qSBv9V8twpMCcnGcZxWcoi5xym02lzcXr9fmJHWtA
 lntZymlkKI4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="190298151"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="190298151"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:37 -0700
IronPort-SDR: sL+mgQO3gB8Uo2ngFekJ0fXYa2NGgQuTzNIYKVBT5tivjJonoJzNp7ax26UU5YQe/t+i8sz8M4
 dS3LHDBe8ckw==
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="607238763"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:37 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V4 06/10] x86/fault: Adjust WARN_ON for PKey fault
Date:   Sun, 21 Mar 2021 22:30:16 -0700
Message-Id: <20210322053020.2287058-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210322053020.2287058-1-ira.weiny@intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKey faults may now happen on kernel mappings if the feature is enabled.
Remove the warning in the fault path if PKS is enabled.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/mm/fault.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..731ec90ed413 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1141,11 +1141,12 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 		   unsigned long address)
 {
 	/*
-	 * Protection keys exceptions only happen on user pages.  We
-	 * have no user pages in the kernel portion of the address
-	 * space, so do not expect them here.
+	 * PF_PK is expected on kernel addresses when supervisor pkeys are
+	 * enabled.
 	 */
-	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
+
 
 #ifdef CONFIG_X86_32
 	/*
-- 
2.28.0.rc0.12.gb6a658bd00c9

