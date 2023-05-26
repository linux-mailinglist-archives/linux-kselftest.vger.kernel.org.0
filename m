Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED0711FFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbjEZGap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjEZGam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 02:30:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07100198;
        Thu, 25 May 2023 23:30:40 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685082638;
        bh=xblaIv9ff9aMttaZ5noLw4QKOmOsHQttyPbx4HeNkGU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aBIaTe/p6JjQq0FT0W+hke0XP4+ZW+GxSk6KU6/wqI5+NnjucL48g8oRUYy796ItH
         uFZwmXMYa8ydKVYECSB6NE2uaj7rUdmGqVL7b8SOMWCk2VLcqr+x6+WtODwc/oIiq0
         lX3YXgUhR0ItTKAb3cTj7u+mFWIzxKde7HXj+LM8=
Date:   Fri, 26 May 2023 08:30:36 +0200
Subject: [PATCH 2/2] selftests/nolibc: prevent coredumps during test
 execution
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230526-nolibc-test-no-dump-v1-2-62e724a96db2@weissschuh.net>
References: <20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net>
In-Reply-To: <20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685082638; l=989;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xblaIv9ff9aMttaZ5noLw4QKOmOsHQttyPbx4HeNkGU=;
 b=W55tJ8CzyJL4M+FVgABk9pXBCFnXHrsLH3hnToGetBqPIwwwEBcGilciGbU+vX0BxHEW6SDlp
 +UPfiRhJkvDBYitn3jrkk6fitFufRaPCD1xjQISCxuhD/S9qRZBuUxX
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
index 76a9a0f362b1..40fb684eaac9 100644
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

