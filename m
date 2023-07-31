Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23275768D4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGaHKo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGaHKF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 03:10:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC851705;
        Mon, 31 Jul 2023 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690787296;
        bh=q0/RMbeUsJRr/8U7rBQr1RX1EBgUx1jztSSJWUG/bOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0FqEYXbuvzgRsmhAkZyTtlI8dK/tAlt4VDJmHEoz9E2dpUcdD335TpxL9bjogV0Y
         bJJO30dWC+I2WTuIqEpYi80yZJ5I1lagZnBFFfkhluq7P3dmbhBaNUMyobxZ3OUQo2
         h9IaB47Ip7Mdv+Y8a+fLrGvtAmRajbJyHw3Z9Bq0=
Date:   Mon, 31 Jul 2023 09:08:15 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Message-ID: <7d8dee88-16af-464f-b7f3-55b77dbc3c46@t-8ch.de>
References: <20230731-nolibc-warnings-v1-1-74973d2a52d7@weissschuh.net>
 <20230731064826.16584-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731064826.16584-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Note:

It seems your mail client does not add the prefix "Re: " to responses.
Is that intentional?

On 2023-07-31 14:48:26+0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> > As we want to enable compiler warnings in the future these would be
> > reported as unused functions.
> > 
> > If we need them in the future they are easy to recreate from their still
> > existing siblings.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
> >  1 file changed, 99 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 03b1d30f5507..53e2d448eded 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
> >   * of failures, thus either 0 or 1.
> >   */
> >  
> > -#define EXPECT_ZR(cond, expr)				\
> > -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
> > -
> > -static int expect_zr(int expr, int llen)
> > -{
> 
> Why not a simple 'static __attribute__((unused))' line, then, no need to
> add them again next time.
> 
>     -static int expect_zr(int expr, int llen)
>     +static __attribute__((unused))
>     +int expect_zr(int expr, int llen)
>      {

Personally I don't like having dead code lying around that needs to be
maintained and skipped over while reading.
It's not a given that we will need those helpers in the future at all.

Thomas

> 
> Thanks,
> Zhangjin
> 
> > -	int ret = !(expr == 0);
> > -
> > -	llen += printf(" = %d ", expr);
> > -	result(llen, ret ? FAIL : OK);
> > -	return ret;
> > -}
> > -
> > -
> > -#define EXPECT_NZ(cond, expr, val)			\
> > -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
> > -
> > -static int expect_nz(int expr, int llen)
> > -{
> > -	int ret = !(expr != 0);
> > -
> > -	llen += printf(" = %d ", expr);
> > -	result(llen, ret ? FAIL : OK);
> > -	return ret;
> > -}
> > -
> > [...]
> > -- 
> > 2.41.0
> > 
> > 
