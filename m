Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64786E4DEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDQQCI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDQQBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:01:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB244CC14;
        Mon, 17 Apr 2023 09:01:47 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681747301;
        bh=iwWW56Gx2lHStfQUQLk6EkDugqDvy/8mdADPIa3bZBc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LAZFEc5+buhv5vFiEgQ4tVfLKtvgMm7K7xdNzjQoLSnVM8ybd6eb/wrr+lb0RMHXG
         QsJEMZB++ItERXWp2Jv43McibCD0PoMHYbumhEzpJD/vCsWmkRJzDe0Z26dbLBq4yn
         MUunnPYWPp9wjDuds29Nb9Vh+ozyU1AJbvjmVFv8=
Date:   Mon, 17 Apr 2023 18:01:31 +0200
Subject: [PATCH 1/6] selftests/nolibc: reduce syscalls during space padding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230408-nolibc-stackprotector-archs-v1-1-271f5c859c71@weissschuh.net>
References: <20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net>
In-Reply-To: <20230408-nolibc-stackprotector-archs-v1-0-271f5c859c71@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681747300; l=1322;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iwWW56Gx2lHStfQUQLk6EkDugqDvy/8mdADPIa3bZBc=;
 b=selfxBdXZN6SyUn9/aMPtG19qHA4hVIr96ooaQSSksgZp/PXoWSXp/QlxzyjnYfomFB9l7tEj
 htoVVvo6yB2DT7K+m+H1w3NCUEcJJj4a20quDM+7bESYELvKgwgdcyo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Previously each space character used for alignment during test execution
was written in a single write() call.
This would make the output from strace fairly unreadable.
Coalesce all spaces into a single call to write().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 68e22617651c..35f203556a0c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -108,19 +108,26 @@ const char *errorname(int err)
 	}
 }
 
+static void putcharn(char c, size_t n)
+{
+	char buf[64];
+
+	memset(buf, c, n);
+	buf[n] = '\0';
+	fputs(buf, stdout);
+}
+
 static int pad_spc(int llen, int cnt, const char *fmt, ...)
 {
 	va_list args;
-	int len;
 	int ret;
 
-	for (len = 0; len < cnt - llen; len++)
-		putchar(' ');
+	putcharn(' ', cnt - llen);
 
 	va_start(args, fmt);
 	ret = vfprintf(stdout, fmt, args);
 	va_end(args);
-	return ret < 0 ? ret : ret + len;
+	return ret < 0 ? ret : ret + cnt - llen;
 }
 
 /* The tests below are intended to be used by the macroes, which evaluate

-- 
2.40.0

