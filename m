Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF25734C06
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFSHB7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSHB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 03:01:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C935199;
        Mon, 19 Jun 2023 00:01:56 -0700 (PDT)
X-QQ-mid: bizesmtp72t1687158107t5cb9jfm
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 15:01:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: CR3LFp2JE4mpAf5y1pCIlLMASGgjd5QRvS1f5Cg7IOlRx33kDFXmn3SGmbr8F
        R0QnHMLBWrZfc3TUdNvkA1afJtX+UfDS7aJyC8WmWi2tAJAhcxy3n54BhSJ/8MUDbXR/LDQ
        FP0D/l2lQeg6Lw3JvVTdaZFG/291CdvS3v9x2brgznApOdTqVLFtPTt53mV2PoFnDzQZYBZ
        LHfbdqgtObhhnPGY4uFTmrLG/4GGfArk1fMRX3fqRsAfIhMlpyw31fvj4JQJ2GFxKWu/Iqo
        6m3jWiIjnU5+GxeaaJWz1CnCBEAPowXv6+mqU2ONi905qP6wHKf+8ndeeY/j/yQzKqXJxTz
        5A0qz9BCIOZEtXmKYuvjTJUzalh9bVP8WUO6cWAPmx4Fm/+LAo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7841859380190966851
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 3/3] selftests/nolibc: restore the failed tests print
Date:   Mon, 19 Jun 2023 15:01:43 +0800
Message-Id: <2308942c812f5d45035457d2bf6b388b4736c9f5.1687156560.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687156559.git.falcon@tinylab.org>
References: <cover.1687156559.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The commit fa0df56a804b ("selftests/nolibc: also count skipped and
failed tests in output") added counting for the skipped and failed
tests, but also removed the 'FAIL' results print, let's restore it for
it really allow users to learn the failed details without opening the
log file.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 2a0c3f4fa204..000621f21adc 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -84,7 +84,7 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
-REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
+REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
 		printf("See all results in %s\n", ARGV[1]); }'
 
-- 
2.25.1

