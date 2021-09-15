Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DA40CE06
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhIOUcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:13818 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhIOUch (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109377"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109377"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092796"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:16 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] selftests/sgx: Enable multiple thread support
Date:   Wed, 15 Sep 2021 13:31:03 -0700
Message-Id: <7b413966289d22f043762b3d20e30cb6ded936e3.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Each thread executing in an enclave is associated with a Thread Control
Structure (TCS). The test enclave contains two hardcoded TCS. Each TCS
contains meta-data used by the hardware to save and restore thread specific
information when entering/exiting the enclave.

The two TCS structures within the test enclave share their SSA (State Save
Area) resulting in the threads clobbering each other's data. Fix this by
providing each TCS their own SSA area.

Additionally, there is an 8K stack space and its address is
computed from the enclave entry point which is correctly done for
TCS #1 that starts on the first address inside the enclave but
results in out of bounds memory when entering as TCS #2. Split 8K
stack space into two separate pages with offset symbol between to ensure
the current enclave entry calculation can continue to be used for both threads.

While using the enclave with multiple threads requires these fixes the
impact is not apparent because every test up to this point enters the
enclave from the first TCS.

More detail about the stack fix:
-------------------------------
Before this change the test enclave (test_encl) looks as follows:

.tcs (2 pages):
(page 1) TCS #1
(page 2) TCS #2

.text (1 page)
One page of code

.data (5 pages)
(page 1) encl_buffer
(page 2) encl_buffer
(page 3) SSA
(page 4 and 5) STACK
encl_stack:

As shown above there is a symbol, encl_stack, that points to the end of the
.data segment (pointing to the end of page 5 in .data) which is also the end
of the enclave.

The enclave entry code computes the stack address by adding encl_stack to the
pointer to the TCS that entered the enclave. When entering at TCS #1 the
stack is computed correctly but when entering at TCS #2 the stack pointer
would point to one page beyond the end of the enclave and a #PF would
result when TCS #2 attempts to enter the enclave.

The fix involves moving the encl_stack symbol between the two stack pages.
Doing so enables the stack address computation in the entry code to compute
the correct stack address for each TCS.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 .../selftests/sgx/test_encl_bootstrap.S       | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 5d5680d4ea39..82fb0dfcbd23 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -12,7 +12,7 @@
 
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
-	.quad	encl_ssa		# OSSA
+	.quad	encl_ssa_tcs1		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
 	.quad	encl_entry		# OENTRY
@@ -23,10 +23,10 @@
 	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
 	.fill	4024, 1, 0		# Reserved
 
-	# Identical to the previous TCS.
+	# TCS2
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
-	.quad	encl_ssa		# OSSA
+	.quad	encl_ssa_tcs2		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
 	.quad	encl_entry		# OENTRY
@@ -40,8 +40,9 @@
 	.text
 
 encl_entry:
-	# RBX contains the base address for TCS, which is also the first address
-	# inside the enclave. By adding the value of le_stack_end to it, we get
+	# RBX contains the base address for TCS, which is the first address
+	# inside the enclave for TCS #1 and one page into the enclave for
+	# TCS #2. By adding the value of encl_stack to it, we get
 	# the absolute address for the stack.
 	lea	(encl_stack)(%rbx), %rax
 	xchg	%rsp, %rax
@@ -81,9 +82,15 @@ encl_entry:
 
 	.section ".data", "aw"
 
-encl_ssa:
+encl_ssa_tcs1:
+	.space 4096
+encl_ssa_tcs2:
 	.space 4096
 
 	.balign 4096
-	.space 8192
+	# Stack of TCS #1
+	.space 4096
 encl_stack:
+	.balign 4096
+	# Stack of TCS #2
+	.space 4096
-- 
2.25.1

