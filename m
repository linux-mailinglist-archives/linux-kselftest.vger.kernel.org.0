Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE77768EE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGaHem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 03:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGaHe1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 03:34:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52B1BDB;
        Mon, 31 Jul 2023 00:33:15 -0700 (PDT)
X-QQ-mid: bizesmtp81t1690788769tazke485
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 15:32:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJm85FAZbkyW/ARdkukn/5LhQOlgp3bb1aSv8vaTE8cp43kPg84Gb
        aMBELMYE/aDW+oGKaST/q+B3pDjxpg2JDjd9NIJGO5f5O83NVNHtQSLjQ+a/EerQr1jQRfH
        bl5yjDQ4CvsCsrXPyGX/9PbC7PrOhxqgV+suiH9/Gno80p3O7tZYUXUOwJ6r9YZpKOHuyPm
        tCjY5NRWscY6zQ+GU/9wOUNQXxyvNb1DUHqFuGlmYVjjEWAzni3A07zT1tK2Et+yF7O0dXr
        I0etkqOryfKdPrJhfN0Oegw6aa5xarfQh+m6XVix6ODYHR0I8O5oepGOW9YcTw3A0LgTWOH
        3cfTt7sDULc/eehuisq/Woyz302dBBbp8yEZHlbo+R5BIDWrMDYjDRICMA9G/kBZHlRhAty
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5349350938179748455
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: Re: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Date:   Mon, 31 Jul 2023 15:32:43 +0800
Message-Id: <20230731073243.21265-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d8dee88-16af-464f-b7f3-55b77dbc3c46@t-8ch.de>
References: <7d8dee88-16af-464f-b7f3-55b77dbc3c46@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> Note:
> 
> It seems your mail client does not add the prefix "Re: " to responses.
> Is that intentional?
>

I use a lightweight 'b4 + git send-email' method to reply emails,
sometimes, I forgot manually adding the 'Re: ' prefix, perhaps I should
write a simple script to do that or carefully check the Subject title
everytime, Thanks!

> On 2023-07-31 14:48:26+0800, Zhangjin Wu wrote:
> > Hi, Thomas
> > 
> > > As we want to enable compiler warnings in the future these would be
> > > reported as unused functions.
> > > 
> > > If we need them in the future they are easy to recreate from their still
> > > existing siblings.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
> > >  1 file changed, 99 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > index 03b1d30f5507..53e2d448eded 100644
> > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > @@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
> > >   * of failures, thus either 0 or 1.
> > >   */
> > >  
> > > -#define EXPECT_ZR(cond, expr)				\
> > > -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
> > > -
> > > -static int expect_zr(int expr, int llen)
> > > -{
> > 
> > Why not a simple 'static __attribute__((unused))' line, then, no need to
> > add them again next time.
> > 
> >     -static int expect_zr(int expr, int llen)
> >     +static __attribute__((unused))
> >     +int expect_zr(int expr, int llen)
> >      {
> 
> Personally I don't like having dead code lying around that needs to be
> maintained and skipped over while reading.
> It's not a given that we will need those helpers in the future at all.
>

It is reasonable in some degree from current status, especially for
these ones are newly added, but let us think about these scenes: when we
would drop or change some test cases in the future and the helpers may
would be not referenced by any test cases in a short time, and warnings
there, but some other cases may be added later to use them again ...

I'm ok to drop these ones, but another patch may be required to add
'static __attribute__((unused))' for all of the currently used ones,
otherwise, there will be warnings randomly by a test case change or
drop.

Or even further, is it possible to merge some of them to some more
generic helpers like the ones used from the selftest.h in your last RFC
patchset?

Thanks,
Zhangjin

> Thomas
> 
> > 
> > Thanks,
> > Zhangjin
