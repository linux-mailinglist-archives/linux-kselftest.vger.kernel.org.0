Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA76A474D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 17:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjB0QxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 11:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjB0QxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 11:53:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F522B46F;
        Mon, 27 Feb 2023 08:53:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10ED8B80D78;
        Mon, 27 Feb 2023 16:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6931BC433D2;
        Mon, 27 Feb 2023 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677516780;
        bh=OYmyRiD0A+BqV+mfTn2kCuA6YJl03zygH/UZ7pYtlTg=;
        h=Subject:From:To:Cc:Date:From;
        b=dttdgN8GHdNtgfOLKRxZqcOjyH4yNDcr59n7uh1LCWQVWGZowhE5DYs8p6jR8zXQC
         Tjl60VEVWQ0Kq3868WtbWpK5hbVqZbOxqvX8cCmOieDZY1RPeLJRSwsMVNrSQgstTg
         4Bf+yoT1nK6Q+Yx6pZDjTvjxzGvPycJVH0ZinKixWcsVuI2uu8Ycj/JgVYSqJDckx9
         5ujLEKqJZCZFVf7VoZNY7uGQjmtVgKAC04B7+pTMb9F2Cw16MXzkFgZQ80pP8CGSVu
         DRYMGkQB/kIOKrl5HkocWEhRrU9U5CEC+QOSYKc4Qhf825R32Pl/hp9XxxWD3WZ+Zz
         I4+11D2nx1y5g==
Subject: [PATCH] SUNRPC: Ensure test case arrays are properly terminated
From:   Chuck Lever <cel@kernel.org>
To:     geert@linux-m68k.org
Cc:     linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Date:   Mon, 27 Feb 2023 11:52:59 -0500
Message-ID: <167751664019.187639.5290505948970809072.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Geert Uytterhoeven reports:

...
        ok 9 Encrypt 13 bytes with camellia256-cts-cmac
        ok 10 Encrypt 30 bytes with camellia256-cts-cmac
    # RFC 6803 encryption: pass:0 fail:0 skip:10 total:10
    ok 3 RFC 6803 encryption # SKIP Encryption type is not available
8<--- cut here ---
Unable to handle kernel paging request at virtual address 73657420 when execute
[73657420] *pgd=00000000
Internal error: Oops: 80000005 [#1] ARM
CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.2.0-rc7-00133-g373f26a81164-dirty #9
Hardware name: Generic DT based system
PC is at 0x73657420
LR is at kunit_run_tests+0x3e0/0x5f4

On x86 with GCC 12, the missing array terminators did not seem to
matter. Other platforms appear to be more picky.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c |    5 +++++
 1 file changed, 5 insertions(+)

Hi Geert -

Finally able to reproduce. This simple patch seems to address the
crashes for me. If this patch fixes it for you I can push it to
Linus before the v6.3 merge window closes.


diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 0a7c5280e4e3..ce0541e32fc9 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -519,6 +519,7 @@ static struct kunit_case rfc3961_test_cases[] = {
 		.run_case		= kdf_case,
 		.generate_params	= rfc3961_kdf_gen_params,
 	},
+	{}
 };
 
 static struct kunit_suite rfc3961_suite = {
@@ -780,6 +781,7 @@ static struct kunit_case rfc3962_test_cases[] = {
 		.run_case		= rfc3962_encrypt_case,
 		.generate_params	= rfc3962_encrypt_gen_params,
 	},
+	{}
 };
 
 static struct kunit_suite rfc3962_suite = {
@@ -1415,6 +1417,7 @@ static struct kunit_case rfc6803_test_cases[] = {
 		.run_case		= rfc6803_encrypt_case,
 		.generate_params	= rfc6803_encrypt_gen_params,
 	},
+	{}
 };
 
 static struct kunit_suite rfc6803_suite = {
@@ -1907,6 +1910,7 @@ static struct kunit_case rfc8009_test_cases[] = {
 		.run_case		= rfc8009_encrypt_case,
 		.generate_params	= rfc8009_encrypt_gen_params,
 	},
+	{}
 };
 
 static struct kunit_suite rfc8009_suite = {
@@ -2029,6 +2033,7 @@ static struct kunit_case encryption_test_cases[] = {
 		.run_case		= encrypt_selftest_case,
 		.generate_params	= encrypt_selftest_gen_params,
 	},
+	{}
 };
 
 static struct kunit_suite encryption_test_suite = {


