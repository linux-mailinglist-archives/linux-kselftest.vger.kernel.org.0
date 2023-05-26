Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB2712180
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbjEZHvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbjEZHvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:51:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127A12C;
        Fri, 26 May 2023 00:51:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685087480;
        bh=gPWy5ndLt8ct+Uazqw50nw4PJv+qz+MZWnYipjEuHg4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hS0Zhw49+9al2kcGPElURWIe30L2/bYj8kjizboi2kD8xqnP0LBrFnz83CKPrR42X
         SfK7Df3aVXH45ub41nImcZk3CcDZNB2Ggne5+avq1v+d4Ljrp1FdBv84xjAnLFqirN
         G+EzzKz+WFKD5/Tl0IhyKHp8BKZ/KvTgBYN3LB00=
Date:   Fri, 26 May 2023 09:51:20 +0200
Subject: [PATCH v2 2/2] selftests/nolibc: prevent coredumps during test
 execution
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230526-nolibc-test-no-dump-v2-2-a66500bf73fc@weissschuh.net>
References: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
In-Reply-To: <20230526-nolibc-test-no-dump-v2-0-a66500bf73fc@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685087479; l=989;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gPWy5ndLt8ct+Uazqw50nw4PJv+qz+MZWnYipjEuHg4=;
 b=A16KBhfIrmPXrI7A758j3aA9reNvLxMKPt3tolDoX8rZOSZw+NGQWP4roP4PFqUUkHl9iKw1f
 i/mOxuWmA9uDplYB3WGGUDFJw/6O37J6Hs8cEhEp8XykrOlNuipSP+m
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The child process forked during stackprotector tests intentionally gets
killed with SIGABRT. By default this will trigger writing a coredump.
The writing of the coredump can spam the systems coredump machinery and
take some time.

Timings for the full run of nolibc-test:
Before: 200ms
After:   20ms

This is on a desktop x86 system with systemd-coredumpd enabled.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 95ff2867a91d..3296e8567fa5 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -831,6 +831,7 @@ static int run_protection(int min, int max)
 		close(STDOUT_FILENO);
 		close(STDERR_FILENO);
 
+		prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
 		smash_stack();
 		return 1;
 

-- 
2.40.1

