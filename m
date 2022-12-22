Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB481653B0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiLVDwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiLVDwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:35 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF723329;
        Wed, 21 Dec 2022 19:52:34 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 9D18F81A20;
        Thu, 22 Dec 2022 03:52:29 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681153;
        bh=dAu4u8hilpZPllAVwu00C5OS/7zywFlN7MRAKmmU8vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feCVYsbUUPipmlfjwXpY+Bispi3vMoCpuOKrfMEolGAzEiNO+8X0jywpx1358j0uD
         Vf46EbF7dN9cXkvscwqZwrFzkGnV9KUHcM5gUgfU4VY+VKTWJtEa7mE+8N2yvv6itn
         VLsJvT077b6ewF/6H+NfU8vEqorWBe2iv1NpPncxOjtwIwvDB2FVPn7Mizhi0yZHyn
         SM9MM0N5h5CbAl+JtmCeJQDnA6sAjMkzijfsL/VXsSWvACwAkWGYSdt61c/75sT3LQ
         cC/ACddnjE0EI85M/8jEJdLmhNw7lDOJnR8sgP+xHzY7y8YyPOyFZuBpL9oQ7v5cm1
         sMou4sZAbNuOA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 4/8] selftests/nolibc: Add `-Wall` and `-Wno-unsed-function` to the CFLAGS
Date:   Thu, 22 Dec 2022 10:51:30 +0700
Message-Id: <20221222035134.3467659-5-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Turn on more compiler warnings to help spot issues. Skip unused
function warning as it's inevitable in the nolibc test suite.

While adding these flags, remove unused variables in run_stdlib()
warned by the `-Wall` flag.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/Makefile      | 2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 572fe72df68d..f6602a2c2bbd 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -66,7 +66,7 @@ else
 Q=@
 endif
 
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -Wall -Wno-unused-function
 LDFLAGS := -s
 
 help:
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f14f5076fb6d..8d69f8a0f35a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -542,9 +542,7 @@ int run_syscall(int min, int max)
 int run_stdlib(int min, int max)
 {
 	int test;
-	int tmp;
 	int ret = 0;
-	void *p1, *p2;
 
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; // line length
-- 
Ammar Faizi

