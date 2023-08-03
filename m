Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B389F76E163
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjHCH3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBCA30DB;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=EWfkz4+JzA39y3BqrykKODSeqlkEjyKnDKBLfiY+GuE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ig/AE/KgUWfFxj21F5PavNG2qCm5JBdo5042nfha90GMAczwMIY/O9NlmvnbZ3knW
         EYEIYxbeaLYAtO44FmwMBEp0S1ZD63RBN6MlSBjfWdy+2tRezwF3ocvxK5Tix/jYyu
         Neftr8nUENgEomhNYVegLkI+kIsTnJPG2mMrsehw=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:56 +0200
Subject: [PATCH v3 12/14] selftests/nolibc: prevent out of bounds access in
 expect_vfprintf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-12-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1067;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EWfkz4+JzA39y3BqrykKODSeqlkEjyKnDKBLfiY+GuE=;
 b=gJ18WhH9OWXlk9KTnh/w/CexA9VLB/UrRUJQFDwfWfARdOCmeWSBQgfbsGXRx1smLI4+Fcbre
 zkHVNQjYOHjCWMsimBUOfvx+Y+h5C9RE2QBpLg8ZUpLIRN+YKslVwht
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

If read() fails and returns -1 (or returns garbage for some other
reason) buf would be accessed out of bounds.
Only use the return value of read() after it has been validated.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 63f09800057d..0145a44af990 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1055,7 +1055,6 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 	lseek(fd, 0, SEEK_SET);
 
 	r = read(fd, buf, sizeof(buf) - 1);
-	buf[r] = '\0';
 
 	fclose(memfile);
 
@@ -1065,6 +1064,7 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
 		return 1;
 	}
 
+	buf[r] = '\0';
 	llen += printf(" \"%s\" = \"%s\"", expected, buf);
 	ret = strncmp(expected, buf, c);
 

-- 
2.41.0

