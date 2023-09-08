Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56304798BDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjIHSC2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245679AbjIHSC1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 14:02:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17361FDF;
        Fri,  8 Sep 2023 11:01:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F28C433CD;
        Fri,  8 Sep 2023 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196057;
        bh=hk9L2W57X5Tbgu0Jcm3U7It8/YndrZpaVGTFEGP4UbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQeQmi4SqVD0cJU3+LQkmOZSpnpKM78ociXZEw6LkWYUbYx8+3gNVoS5vBo848q9l
         8OV7YG90DJuuvvnXm+Une9d+rF+t+hSxwM11uEFqj/zjXmK9D7/qNmGgGf2jyXzIu4
         4ov9ZwbhkquOG5cP1zNPyN/Qu/1diFYQ6oDUmwuUC+wM6LocIb7zeSg+6ahgsnmgYP
         7WBtZaBhRU9MvVD2jKw02if1NmneszBb8LSuuq0+7PmKyRpuCHiqoh9lbxEKhjCTVL
         rLfDm7S+q7KnIpVzJUaLHiXbxUqEd14eUHZ4aSinrLeGoE1iCVYnefxiTQSetncO1P
         5GGGFFG9fx62w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 16/16] selftests/nolibc: prevent out of bounds access in expect_vfprintf
Date:   Fri,  8 Sep 2023 13:59:53 -0400
Message-Id: <20230908175953.3457942-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908175953.3457942-1-sashal@kernel.org>
References: <20230908175953.3457942-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 9c5e490093e83e165022e0311bd7df5aa06cc860 ]

If read() fails and returns -1 (or returns garbage for some other
reason) buf would be accessed out of bounds.
Only use the return value of read() after it has been validated.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 55628a25df0a3..8e7750e2eb97c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -769,7 +769,6 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
-	buf[r] = '\0';
 
 	fclose(memfile);
 
@@ -779,6 +778,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 		return 1;
 	}
 
+	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 
-- 
2.40.1

