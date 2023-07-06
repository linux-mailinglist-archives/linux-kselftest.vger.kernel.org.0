Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EFB749802
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGFJLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFJLg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:11:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65484DB;
        Thu,  6 Jul 2023 02:11:34 -0700 (PDT)
X-QQ-mid: bizesmtp80t1688634683tlze7x0a
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:11:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 1U/NVTUyJNRxt0P5nSwuMLL2FGvAjGF+dkHW2Y/MJag7QbharIuxgGfpjt2s2
        tlCqyBfgiEUyRn4LJfDaZ2WIOF/af919RI9ktDUb7l5FJVo0Ba8w8GVh/l0tQPj1z6QcN8a
        1N6nAaSHLzyR5FDxWP56pQimBWiHZCM40Pdv53FIYwzo4yoL2XIzET4qDKsDpHJkLC2xznd
        VyJF8LRWJedFUt3y/4XngpJkppYB5OGdHjOyFlOPM0xoP0L69LoBxkdXDX8BGhNHayPRN1v
        QsORCI1YSIqNj8XwlWWlBJvH/mWzEOwwFGR0nEf7/k0cfZCryyZhNXzqpFfCbz2ggWvb+jM
        aawzVAHqisghajm85ohCE0jA8/AKUKaymEyIHXIb2Dupvf3fA9LzJnsFKv0Jw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1037799378191978913
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 4/5] selftests/nolibc: report: extrude the test status line
Date:   Thu,  6 Jul 2023 17:11:17 +0800
Message-Id: <89f3668f48d01fdac847bdfa085867cb641bad27.1688633188.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688633188.git.falcon@tinylab.org>
References: <cover.1688633188.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

two newlines are added around the test summary line to extrude the test
status.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 2c53bf41967b..10e9e5c1bdd0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,9 +85,9 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("%03d test(s): %03d passed, %03d skipped, %03d failed => status: ", p+s+f, p, s, f); \
+		END{ printf("\n%03d test(s): %03d passed, %03d skipped, %03d failed => status: ", p+s+f, p, s, f); \
 		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
-		printf("See all results in %s\n", ARGV[1]); }'
+		printf("\nSee all results in %s\n", ARGV[1]); }'
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
-- 
2.25.1

