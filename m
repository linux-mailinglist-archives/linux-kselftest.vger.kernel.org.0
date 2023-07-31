Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E1768C41
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGaGs5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGaGs5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:48:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC268E43;
        Sun, 30 Jul 2023 23:48:54 -0700 (PDT)
X-QQ-mid: bizesmtp64t1690786128tv7gpioh
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 14:48:47 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: QityeSR92A3KJ4G72zyaN0HTxxqoyjC7ShObFSQuvAFUrjVZb+YBUpOsx4FYs
        dSFF+Le3swCbsYpROBvlOGaKpyQxs0NZYx3kU4xekvZv8D4ftEOl5qQWNbm8FaPsR3yDpry
        aiMn9QQLkcJ1hqQLm5iExH8pesG3b7hgNfMhkj1Yjb53cMJaQlfyU1VyDEpUAaggP4/+82R
        TQW/nKXFbMCOiQA6xuQ3eOIa1VdMQIIRRhIp/UaAXDZkMrAlazQguQ8PNwKI3yU+ttSai+8
        nrdtDiGl6x50ZLO0H1cLvlkcRJRskkvPgbIj1QtlLlvZkow9W1FUouGW+OOA1+OW25EMp/g
        5AnyYxVe2ceEoH+ihsEVySdOoonbIPjEdasuNDkgmtoxRdyRD0l4t2JSPDxwUuwjWGWjykZ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9979006878339547487
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Date:   Mon, 31 Jul 2023 14:48:26 +0800
Message-Id: <20230731064826.16584-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731-nolibc-warnings-v1-1-74973d2a52d7@weissschuh.net>
References: <20230731-nolibc-warnings-v1-1-74973d2a52d7@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> As we want to enable compiler warnings in the future these would be
> reported as unused functions.
> 
> If we need them in the future they are easy to recreate from their still
> existing siblings.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
>  1 file changed, 99 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 03b1d30f5507..53e2d448eded 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
>   * of failures, thus either 0 or 1.
>   */
>  
> -#define EXPECT_ZR(cond, expr)				\
> -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
> -
> -static int expect_zr(int expr, int llen)
> -{

Why not a simple 'static __attribute__((unused))' line, then, no need to
add them again next time.

    -static int expect_zr(int expr, int llen)
    +static __attribute__((unused))
    +int expect_zr(int expr, int llen)
     {

Thanks,
Zhangjin

> -	int ret = !(expr == 0);
> -
> -	llen += printf(" = %d ", expr);
> -	result(llen, ret ? FAIL : OK);
> -	return ret;
> -}
> -
> -
> -#define EXPECT_NZ(cond, expr, val)			\
> -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
> -
> -static int expect_nz(int expr, int llen)
> -{
> -	int ret = !(expr != 0);
> -
> -	llen += printf(" = %d ", expr);
> -	result(llen, ret ? FAIL : OK);
> -	return ret;
> -}
> -
> [...]
> -- 
> 2.41.0
> 
> 
