Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF18B76E15D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHCH25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7730CF;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=SiXyuOOX0kAfgATp0YbPKnf7iVUwVHLjveWTNqqssiQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hezgaGxRLIRMLpdr1R+Wsv3oxbMjbLxk5lOLBNIMFPM20GFGmpZ33B3okuHlqkbKW
         HgN7x0AvLODroFjwDfuWQlRogfJUAZ6pw4K8d2mCWKAuIFmCcxeZHLFA/sFdMBwMda
         WnwHWZGA2kX48+4+iRUaufOvWrGotJrOx5GN5xms=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:53 +0200
Subject: [PATCH v3 09/14] selftests/nolibc: avoid unused parameter warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-9-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=758;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SiXyuOOX0kAfgATp0YbPKnf7iVUwVHLjveWTNqqssiQ=;
 b=Q/BdMVls6YdyJeCvodtEdoB0Szlesfpr7ZaJZrW87s6bj1cDnCYLCF3ffhM7qtMKZ5hSLkYW7
 ZitYAgLlZwrD7Al8FbR8+cwSAm5D9sDwv++Rtwpkqg4OY1sSjuEm+vu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This warning will be enabled later so avoid triggering it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ea420c794536..d6aa12c3f9ff 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1112,7 +1112,8 @@ static int smash_stack(void)
 	return 1;
 }
 
-static int run_protection(int min, int max)
+static int run_protection(int min __attribute__((unused)),
+			  int max __attribute__((unused)))
 {
 	pid_t pid;
 	int llen = 0, status;

-- 
2.41.0

