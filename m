Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B234CD145
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 10:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiCDJie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiCDJiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5663C75603;
        Fri,  4 Mar 2022 01:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B42A3618EF;
        Fri,  4 Mar 2022 09:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD7C340E9;
        Fri,  4 Mar 2022 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386638;
        bh=bHeESoq0k2mSEDu9DZQY+QQFO8wHekg/jk6QS3O0pUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEZ9NTT0OI4NPRUAkGocKZ6x94r0wWgcfZB9FQh0TvORgBYTRCnPx9ItN/NHWvM2d
         BUaMsHjV83KQvtldKmOnTZw/mq8H39XbmFHVMnvSzLyqU+rEFTwatNCVqBC6gzCc8n
         YTc6xTkBkHIYwKJT9ZHuiv8K8uShhMR2uemUbWwWuc6nGHd7clt0At2zEtwV1yOsW8
         F9KN4ajgNdG/o02bvOKldetVMDVHbvMQqFYQDqkxKTcbKlSF9gBFaKE8xPoFgK4g37
         9E24Vg2AUYBFhigxLz+HykcSArkB7Nq0wzPe9DUYLauq5iysOMpsInBRKQTHcQJ3Ac
         Yj0kwWqKYebfQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2.1 23/30] selftests/sgx: Introduce dynamic entry point
Date:   Fri,  4 Mar 2022 11:35:17 +0200
Message-Id: <20220304093524.397485-23-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The test enclave (test_encl.elf) is built with two initialized
Thread Control Structures (TCS) included in the binary. Both TCS are
initialized with the same entry point, encl_entry, that correctly
computes the absolute address of the stack based on the stack of each
TCS that is also built into the binary.

A new TCS can be added dynamically to the enclave and requires to be
initialized with an entry point used to enter the enclave. Since the
existing entry point, encl_entry, assumes that the TCS and its stack
exists at particular offsets within the binary it is not able to handle
a dynamically added TCS and its stack.

Introduce a new entry point, encl_dyn_entry, that initializes the
absolute address of that thread's stack to the address immediately
preceding the TCS itself. It is now possible to dynamically add a
contiguous memory region to the enclave with the new stack preceding
the new TCS. With the new TCS initialized with encl_dyn_entry as entry
point the absolute address of the stack is computed correctly on entry.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..03ae0f57e29d 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -45,6 +45,12 @@ encl_entry:
 	# TCS #2. By adding the value of encl_stack to it, we get
 	# the absolute address for the stack.
 	lea	(encl_stack)(%rbx), %rax
+	jmp encl_entry_core
+encl_dyn_entry:
+	# Entry point for dynamically created TCS page expected to follow
+	# its stack directly.
+	lea -1(%rbx), %rax
+encl_entry_core:
 	xchg	%rsp, %rax
 	push	%rax
 
-- 
2.35.1

