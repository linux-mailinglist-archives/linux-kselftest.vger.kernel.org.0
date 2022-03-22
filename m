Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D734E39C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiCVHqk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiCVHq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 03:46:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD138BD9;
        Tue, 22 Mar 2022 00:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2370B81C16;
        Tue, 22 Mar 2022 07:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B408C340EC;
        Tue, 22 Mar 2022 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647934940;
        bh=uh1ULGAkBHUBMe2X6Hg0BdqpJIOUvOjHgP7tYdHOhP4=;
        h=From:To:Cc:Subject:Date:From;
        b=B7NaCOboxskKEqk973igY3cVlcuqHu2ccpPyYd4wlVvNeoEXeJx3HFP6Ie3c6esvu
         C5KFSYAH3sWHhbquYE+rbbjkRUkNwkmmaNKGatW74jkK2k0hmnDF32Q6Bl4NFD+vDV
         mGigJrNMN7L6f12oFwsUm9IQ6MWoWeeo46zkmq7UMgQI4kwT6JuFkDbDCKvdCWhT+V
         OTjZuSN2XGIKq1ejXKZWP5RC9eV5UmmNxm0nvvLULUHk8doST+0S9cv0bk96fuhjO1
         4n9+NZVxXy60itTCX8A8UP4J9Pp6GtfvPoqv9UwjIjDM2iWAQO9lvSIlTOUAdLz3n1
         34tpajqlA4UjA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-sgx@vger.kernel.org (open list:INTEL SGX),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] selftests/sgx: Use rip relative addressing for encl_stack
Date:   Tue, 22 Mar 2022 09:43:11 +0200
Message-Id: <20220322074313.7444-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Simplify the test_encl_bootstrap.S flow by using rip-relative addressing.
Compiler does the right thing here, and this removes dependency on where
TCS entries need to be located in the binary, i.e. allows the binary layout
changed freely in the future.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..1c1b5c6c4ffe 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -40,11 +40,7 @@
 	.text
 
 encl_entry:
-	# RBX contains the base address for TCS, which is the first address
-	# inside the enclave for TCS #1 and one page into the enclave for
-	# TCS #2. By adding the value of encl_stack to it, we get
-	# the absolute address for the stack.
-	lea	(encl_stack)(%rbx), %rax
+	lea	(encl_stack)(%rip), %rax
 	xchg	%rsp, %rax
 	push	%rax
 
-- 
2.35.1

