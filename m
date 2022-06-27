Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18CD55DBDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiF0I5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiF0I5M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 04:57:12 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68C0638C;
        Mon, 27 Jun 2022 01:57:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D258D1E80D5E;
        Mon, 27 Jun 2022 16:56:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NySigRwC0Z_G; Mon, 27 Jun 2022 16:56:12 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3812C1E80D11;
        Mon, 27 Jun 2022 16:56:12 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] tools: Strong conversion of void type pointer could be removed
Date:   Mon, 27 Jun 2022 16:56:54 +0800
Message-Id: <20220627085654.2902-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The void pointer argument does not require a cast assignment because it
is the address passed.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 tools/testing/selftests/x86/fsgsbase.c      | 2 +-
 tools/testing/selftests/x86/test_vsyscall.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 8c780cce941d..5d99261317e1 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -63,7 +63,7 @@ static void clearhandler(int sig)
 
 static void sigsegv(int sig, siginfo_t *si, void *ctx_void)
 {
-	ucontext_t *ctx = (ucontext_t*)ctx_void;
+	ucontext_t *ctx = ctx_void;
 
 	if (!want_segv) {
 		clearhandler(SIGSEGV);
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 5b45e6986aea..2416941a0952 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -184,7 +184,7 @@ static volatile unsigned long segv_err;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
-	ucontext_t *ctx = (ucontext_t *)ctx_void;
+	ucontext_t *ctx = ctx_void;
 
 	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
 	siglongjmp(jmpbuf, 1);
-- 
2.18.2

