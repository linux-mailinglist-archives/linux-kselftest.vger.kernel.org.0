Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A570FD44
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjEXRyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEXRyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:54:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131BB6;
        Wed, 24 May 2023 10:54:36 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684950871teid7j3l
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:54:30 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPiQNaLNfvtQg60iCEjU86KTaag2QHiPU3ih6Rb4YpBvqJza1CLGu
        LpFlDQrCd1CzUUzmNws22YxZUV8d6W8jYPZ2nrEDEaDmsZpm8iPmoW9lOOfcyOqguLm1+zY
        2K7WSkALc/5XCjQUw2A2znLCN1tjC1H9y9lzWCm0I/PH1PsorxoBge3kGufcq0lhKqef5e+
        CVmpEhsvbuFluOifXkdyczY4POc8Y4WJ4pvpPA80rp4wtPUOpsnYC4ZwPE+ZmXe13mDpm5R
        oYI+sqLkgRmeyX24IgJ2tlqgWzMkjR5iyKIG0UMIDDV0BFXbEJZqwkNZiE2lhmIzdCQFt3r
        amaHK22+U+HoGiOcPDSAkQo8WB4QmfyssStP9B443w1uR+/5UunbTM1SORuiw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11833202980194447425
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 07/13] selftests/nolibc: remove the duplicated gettimeofday_bad2
Date:   Thu, 25 May 2023 01:54:19 +0800
Message-Id: <f26de8e1abb27035442e9c7c58aecf18bb4e902c.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
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

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c86ff6018c7f..a9c07018ac9d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -575,7 +575,6 @@ int run_syscall(int min, int max)
 #ifdef NOLIBC
 		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
-		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
 #endif
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-- 
2.25.1

