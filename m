Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983AD4E356B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiCVAUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 20:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiCVAUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 20:20:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E253A996A;
        Mon, 21 Mar 2022 17:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 964E0B81AD4;
        Tue, 22 Mar 2022 00:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEECC340E8;
        Tue, 22 Mar 2022 00:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647908207;
        bh=YlyUCO5y2ERrucJsUmGBREikf0B6qtk2gUE7OvCynHE=;
        h=From:To:Cc:Subject:Date:From;
        b=bIqL1HycAoJkZtTfxeoUwrUfOlD03Opn23/+tsl/fj0UjSM+rJtIqWFaYAw1UgB2l
         e8UwyfpFHrlzixhnS39BoWngU5xFsjHVT2qC/fmwAx3sxS7WEZ7vMuI8rIV7+TUiTh
         KE9Io/A7Jk0ALTkfTtc0+nDQEFpURxQ8Yw69OpXZFIvWazZrBF/yK+/KsPrzOW0M4t
         MFlbL9Z7aiY3n2+Ypo+61MZjSPW+9FeI1ENnQc9OISDkqZztSTP9CyvNi8/04tkclh
         lsRLPG0/p3jfAMtS3HGgvjCRObA2/UmODU3OeM9OoyTilhadzJoXJukvfIpY86mGmV
         smWSyeUnT3DHg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftest/sgx: Use rip relative addressing for encl_stack
Date:   Tue, 22 Mar 2022 02:17:41 +0200
Message-Id: <20220322001742.34974-1-jarkko@kernel.org>
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
This has been in my mind for a while and since the kselftest is
seemingly growing, I thought it is better to get rid off such an
artificial limitation on the binary layout.
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

