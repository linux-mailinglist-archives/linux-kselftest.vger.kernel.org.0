Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09CD7149C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjE2NAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2NAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 09:00:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24391;
        Mon, 29 May 2023 06:00:18 -0700 (PDT)
X-QQ-mid: bizesmtp78t1685365209tn304cds
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 21:00:07 +0800 (CST)
X-QQ-SSF: 00200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YPLNKIjmriA1LyRD/9GVh50DK49bFM+u4kQwihN+a4qP4/e9Lr+I
        tlmnaNZ+nIUm6A2omPGy/+sSzZrOubvL+5ZvqVr3IsHscrGxbzvQRuwqG7viOZO6b+sh992
        HUiH7R5VAiWB6QaViufuoxqSKbNbwowdK7F797RyTOJhl1+JgSrGd+24WyK7eVDXzu83zSv
        eDNpUtxLJstDd39F4/RIIHuzZzCNldhAlJF4/t0rfGfd1dgRmCa3+IYz/wD7XfyhPtK57Ao
        Rmvu4usRDG5AyT2Kj66AC6iBUeSMjXIqPJypayw8mcuGFHrB0/PmUIReymTHZVQCZWy2w7j
        hLj7rV3KyYOR8VuFnHZ7q1HAwSUI7VPcjcPc9a8f6dEHBjOv8+WhJvLFKrnmy9ZVB6+7sNR
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 879951463538973120
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 3/7] selftests/nolibc: fix up compile warning with glibc on x86_64
Date:   Mon, 29 May 2023 21:00:01 +0800
Message-Id: <aeb48b9cf6fc4674f7560166f22c7dc87d02302d.1685362482.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685362482.git.falcon@tinylab.org>
References: <cover.1685362482.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It is able to do like glibc, defining __WORDSIZE for all of platforms
and using "unsigned long int" to define uint64_t when __WORDSIZE is
64bits, but here uses a simpler solution: nolibc always requires %lld to
match "unsigned long long", for others, only require %lld when word size
is 32bit.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d417ca5d976f..7f9b716fd9b1 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -174,7 +174,11 @@ static int expect_eq(uint64_t expr, int llen, uint64_t val)
 {
 	int ret = !(expr == val);
 
+#if __SIZEOF_LONG__ == 4 || defined(NOLIBC)
 	llen += printf(" = %lld ", expr);
+#else
+	llen += printf(" = %ld ", expr);
+#endif
 	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
 	return ret;
 }
-- 
2.25.1

