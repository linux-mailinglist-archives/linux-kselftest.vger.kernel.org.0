Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E976900A
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGaIYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaIYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 04:24:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F4100;
        Mon, 31 Jul 2023 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690791814;
        bh=o4ZP7HQGo4gMjq/hTymI7aXSSPaGkBsKhC2IAgsvtG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsbab1ZwOC6tk39x6en9ADZqisxvSVTNqk5Cw8rEXrso4FXN3+2R6qYIvbfrQAneK
         ZycHCRorkLU0jDCRQaXf2YPV9k2xN5roj/kF79i70f0t8bflo0laIBoWtsAzttoe3S
         1THqY4S/2WoJx3M9R+x7MFuMWKaa+/HToYeSFlS0=
Date:   Mon, 31 Jul 2023 10:23:33 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Message-ID: <0d441f70-bdc3-4aa1-b392-6ec170c9a5bb@t-8ch.de>
References: <7d8dee88-16af-464f-b7f3-55b77dbc3c46@t-8ch.de>
 <20230731073243.21265-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731073243.21265-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 15:32:43+0800, Zhangjin Wu wrote:
> Hi, Thomas
> 
> > Note:
> > 
> > It seems your mail client does not add the prefix "Re: " to responses.
> > Is that intentional?
> >
> 
> I use a lightweight 'b4 + git send-email' method to reply emails,
> sometimes, I forgot manually adding the 'Re: ' prefix, perhaps I should
> write a simple script to do that or carefully check the Subject title
> everytime, Thanks!

Now there are two "Re: " prefixes :-)

My understanding is that there is exactly one "Re: " prefix iff the
message is any response at all.

> > On 2023-07-31 14:48:26+0800, Zhangjin Wu wrote:
> > > Hi, Thomas
> > > 
> > > > As we want to enable compiler warnings in the future these would be
> > > > reported as unused functions.
> > > > 
> > > > If we need them in the future they are easy to recreate from their still
> > > > existing siblings.
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > >  tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
> > > >  1 file changed, 99 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > index 03b1d30f5507..53e2d448eded 100644
> > > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > @@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
> > > >   * of failures, thus either 0 or 1.
> > > >   */
> > > >  
> > > > -#define EXPECT_ZR(cond, expr)				\
> > > > -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
> > > > -
> > > > -static int expect_zr(int expr, int llen)
> > > > -{
> > > 
> > > Why not a simple 'static __attribute__((unused))' line, then, no need to
> > > add them again next time.
> > > 
> > >     -static int expect_zr(int expr, int llen)
> > >     +static __attribute__((unused))
> > >     +int expect_zr(int expr, int llen)
> > >      {
> > 
> > Personally I don't like having dead code lying around that needs to be
> > maintained and skipped over while reading.
> > It's not a given that we will need those helpers in the future at all.
> >
> 
> It is reasonable in some degree from current status, especially for
> these ones are newly added, but let us think about these scenes: when we
> would drop or change some test cases in the future and the helpers may
> would be not referenced by any test cases in a short time, and warnings
> there, but some other cases may be added later to use them again ...

That doesn't seem very likely.
Did it happen recently?

> I'm ok to drop these ones, but another patch may be required to add
> 'static __attribute__((unused))' for all of the currently used ones,
> otherwise, there will be warnings randomly by a test case change or
> drop.

Then we just drop the helper when we don't need it anymore.

I also dislike the __attribute__ spam to be honest.

> Or even further, is it possible to merge some of them to some more
> generic helpers like the ones used from the selftest.h in your last RFC
> patchset?

Something like this will indeed be part of the KTAP rework.
But it's a change for another time.

Thomas
