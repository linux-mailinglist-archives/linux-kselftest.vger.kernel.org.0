Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23654734BF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFSG6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 02:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSG57 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 02:57:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA04199;
        Sun, 18 Jun 2023 23:57:57 -0700 (PDT)
X-QQ-mid: bizesmtp67t1687157865t5q4c2gj
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 14:57:40 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: WrDav1T4GStU8H3DZGX1RXmzi+Ch0f4jZiwIz58gPwD/4di9t+5GipiQLAdrC
        zFPU5hnJEUMGBND3UktoJWcJl2Roazt8JAP3X41k7+DDekVIZZzFrPLjYAzZIXLzHxLJ4Y0
        Gego4TJeRVlaDUVBpBKNV1wG2l2JiVD6inr1lSEU0lbPvpdO+d3a4ODSactXWsF9UBIdNQ8
        j1+OMKiMSiQ/vmdKZeuUIQEsswocpqG/TC654WGieHVD1HcpYXKthAeg1YeJulZjmTl1F26
        drtD1VCACOclpOZ6VzSHKNglidM8bwW2xcNQWHWqL1UDGoBu96J7q5dA96S+377O3vCDSeg
        WPafxgOkpqc6yT2HDQpekSD/G9O+YnH5jpi0ZeLWzZdI1snDUDIHar9UnZFtw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15193459100436199528
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 2/3] selftests/nolibc: always print the path to test log file
Date:   Mon, 19 Jun 2023 14:57:34 +0800
Message-Id: <72617f46112e2124c2fc6509c206b51c5a1f6e0a.1687156560.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687156559.git.falcon@tinylab.org>
References: <cover.1687156559.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Even when there is no failure, developers may be still interested in the
test log file, especially, string alignment, duplicated print, kernel
message and so forth, so, always print the path to test log file.

A new line is added for such a print to avoid annoying people who don't
care about it when the test pass completely.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZIB792FtG6ibOudp@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 262a9f21d1b4..2a0c3f4fa204 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,8 +85,8 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-		if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }'
+		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
+		printf("See all results in %s\n", ARGV[1]); }'
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
-- 
2.25.1

