Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479D76A847
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHAFa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjHAFaX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820CD1FC0;
        Mon, 31 Jul 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867813;
        bh=68cbroggSXK5AuaobFuJ+Z2zDm6urN4gJ+66FGT1Uuk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OJi9b8qPlP1oIS+wo7uoBxGWfGJcbh5IH4vppHDXWwPpKJsZw7NyxC6xLZU+Xk0oH
         tIov+5UfdtYKbAxEZddRhL47R234mYUatJQN4OHVQdeZytCx5GsSXKFSduVJzXGnSE
         6/SsgtJF0xwSu7wGnx5L4il/XP7F6N6IF/Uv5XeM=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:14 +0200
Subject: [PATCH v2 07/10] selftests/nolibc: avoid unused arguments warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-7-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=759;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=68cbroggSXK5AuaobFuJ+Z2zDm6urN4gJ+66FGT1Uuk=;
 b=f5FFo8CzKRA1WOhf9Y0SVYApgArlbh3IMK9g/aVCZ2I4Rv1TeOJ6Pd9a0RsBt5Ad1uInWMaDR
 8Bqy2lWFtwIBMYMbPj7r7MHO6dN+SCk4XG7J1tu4l/zoBeJY4ZuykSv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This warnings will be enabled later so avoid triggering it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 53a3773c7790..cb17cccd0bc7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1089,7 +1089,8 @@ static int smash_stack(void)
 	return 1;
 }
 
-static int run_protection(int min, int max)
+static int run_protection(int __attribute__((unused)) min,
+			  int __attribute__((unused)) max)
 {
 	pid_t pid;
 	int llen = 0, status;

-- 
2.41.0

