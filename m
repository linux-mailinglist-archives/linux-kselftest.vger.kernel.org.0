Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A44ECFB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351619AbiC3Wba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Mar 2022 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiC3Wb3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Mar 2022 18:31:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B945BD27;
        Wed, 30 Mar 2022 15:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 214DAB81D46;
        Wed, 30 Mar 2022 22:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5284EC340EE;
        Wed, 30 Mar 2022 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648679380;
        bh=5MtaFO+89wdeX5xBRMQtCufQ99P/uYV3x5p1w5FaYDY=;
        h=From:To:Cc:Subject:Date:From;
        b=nDv+jPdPELXEqiJrVGH2SktWbGeFygXDxF1W2U0Qmln9qyBdAYhqBlvep4zZe68BT
         09Ma++zjicfcEjtXPcGM5pzWH7g26rVolQQ13IB3iKzwUAH96v7BNdYNX/YLnkrikp
         JQYOEkW8bUxez+QQbDnKEVXe3WMIJYfUPaFJ+nXFJ1yN1kd0T5L/hW0KxAattnLv8H
         bebYdPsAYqMDdJ9RrV6841UECRnbchzV/3hSRndY/UyyCs1FzywqHLJHkqCmfAOb+F
         zzlEikm8j+uYVmkXYLeN6iN+uvYenG9TbyvtwgjqbKdTsIew1Yh2ihct4VsGC6A3sN
         GBlFRcR12dOzQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, nathaniel@profian.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] selftests/sgx: Use rip relative addressing for encl_stack
Date:   Thu, 31 Mar 2022 01:28:34 +0300
Message-Id: <20220330222834.139769-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Simplify the test_encl_bootstrap.S flow by using RIP-relative addressing.
The compiler automatically puts relative addresses for RIP index addresses.

In order to get a clean and tweakless solution, define separate entry point
for each TCS.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Based on Reinette's example, make proper structuring with separate
  entry points for each TCS.
---
 .../selftests/sgx/test_encl_bootstrap.S       | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..cc2353f38bcc 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -10,12 +10,13 @@
 	.section ".tcs", "aw"
 	.balign	4096
 
+encl_tcs1:
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
 	.quad	encl_ssa_tcs1		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
-	.quad	encl_entry		# OENTRY
+	.quad	encl_entry1		# OENTRY
 	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
 	.fill	1, 8, 0			# OFSBASE
 	.fill	1, 8, 0			# OGSBASE
@@ -23,13 +24,13 @@
 	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
 	.fill	4024, 1, 0		# Reserved
 
-	# TCS2
+encl_tcs2:
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
 	.quad	encl_ssa_tcs2		# OSSA
 	.fill	1, 4, 0			# CSSA (set by CPU)
 	.fill	1, 4, 1			# NSSA
-	.quad	encl_entry		# OENTRY
+	.quad	encl_entry2		# OENTRY
 	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
 	.fill	1, 8, 0			# OFSBASE
 	.fill	1, 8, 0			# OGSBASE
@@ -39,15 +40,19 @@
 
 	.text
 
-encl_entry:
-	# RBX contains the base address for TCS, which is the first address
-	# inside the enclave for TCS #1 and one page into the enclave for
-	# TCS #2. By adding the value of encl_stack to it, we get
-	# the absolute address for the stack.
-	lea	(encl_stack)(%rbx), %rax
+encl_entry1:
+	lea	(encl_stack1)(%rip), %rax
 	xchg	%rsp, %rax
 	push	%rax
+	jmp	encl_continue
 
+encl_entry2:
+	lea	(encl_stack2)(%rip), %rax
+	xchg	%rsp, %rax
+	push	%rax
+	jmp	encl_continue
+
+encl_continue:
 	push	%rcx # push the address after EENTER
 	push	%rbx # push the enclave base address
 
@@ -84,13 +89,14 @@ encl_entry:
 
 encl_ssa_tcs1:
 	.space 4096
+
 encl_ssa_tcs2:
 	.space 4096
 
+encl_stack1:
 	.balign 4096
-	# Stack of TCS #1
 	.space 4096
-encl_stack:
+
+encl_stack2:
 	.balign 4096
-	# Stack of TCS #2
 	.space 4096
-- 
2.35.1

