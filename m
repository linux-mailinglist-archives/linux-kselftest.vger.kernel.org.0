Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3347149D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjE2NEj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjE2NER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:04:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3A9B;
        Mon, 29 May 2023 06:04:14 -0700 (PDT)
X-QQ-mid: bizesmtp88t1685365445t75bgpzp
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 21:04:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: i75H2eCteEjnLpMewxVxLDrNbTdZ6XaqgT62xHD7GAxbEuya2/NFVic9wlKR2
        a5kdGwQlpfjJNaz/YzSlhC5cSA4kagQIt3PINNuT2Ab6n1K/Gb8hBWDDwrYBCvcAdM5teIy
        tOKnMd4y8XFqHSNySJdqSIpkhrIGm9rMbckS9jbZuSK8O8MSz+MpEsOvJbYu+MaxqANEIjt
        vVBzQ1uUopCjGW00WJxlZOp576mh7k5SXdUajNV+l44GGMjwWPAcNDE7bQDJ4oQTtNsnlxk
        3AkOBDpTGFve+zAiy1AVAdMk3T6BxmWVv7KhdqlE8eHR7U2/3UDQRZ/couHwg6PX65e1LSr
        Mlj0aFqMaSpMWk5ZYcCda4bZ5eGDUnulVfBmOJIeJawj0cMpMwj4MMUoH7DHgASCg7DhcO6
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8875824386806725758
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 5/7] selftests/nolibc: use INT_MAX instead of __INT_MAX__
Date:   Mon, 29 May 2023 21:04:02 +0800
Message-Id: <330da9ee27aff3500831a936ffdedc08cc481b63.1685362482.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685362482.git.falcon@tinylab.org>
References: <cover.1685362482.git.falcon@tinylab.org>
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

nolibc now has INT_MAX in stdint.h, so, don't mix INT_MAX and
__INT_MAX__, unify them to INT_MAX.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e75ce6b68565..9ff9d87cc78e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -935,7 +935,7 @@ static const struct test test_names[] = {
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
-	int max = __INT_MAX__;
+	int max = INT_MAX;
 	int ret = 0;
 	int err;
 	int idx;
@@ -983,7 +983,7 @@ int main(int argc, char **argv, char **envp)
 				 * here, which defaults to the full range.
 				 */
 				do {
-					min = 0; max = __INT_MAX__;
+					min = 0; max = INT_MAX;
 					value = colon;
 					if (value && *value) {
 						colon = strchr(value, ':');
-- 
2.25.1

