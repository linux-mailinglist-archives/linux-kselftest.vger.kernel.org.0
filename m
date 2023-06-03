Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F42720E9F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFCIGA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIGA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:06:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CCE40;
        Sat,  3 Jun 2023 01:05:58 -0700 (PDT)
X-QQ-mid: bizesmtp73t1685779549t2ig12j6
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:05:48 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: 5CNn+SP0K2tsOionl/0qwFkto2mrob0OpN+vWURE2tYM65THhHtj71FAAGwF9
        OHfpVFQZWFWNg003NYWU3Fed3VjmEgjfH0VEiKfzoCC9x1lPpUpqjuPCBEQ9cwGb+kNx2uz
        8ODZZl0Vg7kpMG+4idFATFRnoD6xllszwiioL1IQZq3pJIjiEteOcwnQLkmLihMC8Ytr2ZQ
        Lzn60B7Gv+NrtWbnPlaedDpvBa9WjGx9avOWjpeM4bMz/256y4uPHB5E9Tjok94D2WBYBTC
        m4Be7XkPDi4Pup0R0s5A8AHaU8EkG6y+r9ZCTgb1kOD8bMbb0O+VVSUGpm7Dd+oVBHZP4VM
        1TIfWKoEdDYVJ4W7R2/hnRWOyFGos/MH4eqN9UbQfL2A6wCucm5MFDIzLdPDYAvtQq94QKf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14226334804372199419
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 04/12] selftests/nolibc: fix up compile warning with glibc on x86_64
Date:   Sat,  3 Jun 2023 16:05:30 +0800
Message-Id: <0626464891e7fc938e6f7a55f1f475f31fbc6f37.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compiling nolibc-test.c with gcc on x86_64 got such warning:

tools/testing/selftests/nolibc/nolibc-test.c: In function ‘expect_eq’:
tools/testing/selftests/nolibc/nolibc-test.c:177:24: warning: format ‘%lld’ expects argument of type ‘long long int’, but argument 2 has type ‘uint64_t’ {aka ‘long unsigned int’} [-Wformat=]
  177 |  llen += printf(" = %lld ", expr);
      |                     ~~~^    ~~~~
      |                        |    |
      |                        |    uint64_t {aka long unsigned int}
      |                        long long int
      |                     %ld

It because that glibc defines uint64_t as "unsigned long int" when word
size (means sizeof(long)) is 64bit (see include/bits/types.h), but
nolibc directly use the 64bit "unsigned long long" (see
tools/include/nolibc/stdint.h), which is simpler, seems kernel uses it
too (include/uapi/asm-generic/int-ll64.h).

use a simple conversion to solve it.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/20230529130449.GA2813@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d417ca5d976f..403f6255c177 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -174,7 +174,7 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
-	llen += printf(" = %lld ", expr);
+	llen += printf(" = %lld ", (long long)expr);
 	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
-- 
2.25.1

