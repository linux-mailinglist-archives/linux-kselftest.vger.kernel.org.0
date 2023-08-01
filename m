Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8576AB4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHAIuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjHAIuJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 04:50:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1784F10FA;
        Tue,  1 Aug 2023 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690879806;
        bh=N1HBf/84hnmfCbdnwqZ0eyFfZXSs6A4NmSmQ9HOb62c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEP53/pBD2koXxSzMV8+FL8/eAf2YWcbL1SJllcRFQxTNqbgN8p1tK0rpvuEERC1U
         8u2fq72RTBoRIO++oYPD8aSz8tgZnALvIsOIapkhwmZJzcIjfcgme6T6sZ3Bw7az6m
         Z36a3OEXv44FpL+CrLACjymyPJS8DILcF1Vkoe9c=
Date:   Tue, 1 Aug 2023 10:50:05 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 06/10] selftests/nolibc: make functions static if
 possible
Message-ID: <4ad4b853-b89f-4c5a-a50b-28739d7b81c0@t-8ch.de>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
 <ZMiro1pwVvAzNel5@1wt.eu>
 <bf97900a-98bb-45dc-9451-b9728173136e@t-8ch.de>
 <ZMi+k0HsMGJxbs7V@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMi+k0HsMGJxbs7V@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 10:13:07+0200, Willy Tarreau wrote:
> On Tue, Aug 01, 2023 at 09:34:18AM +0200, Thomas Weißschuh wrote:
> > On 2023-08-01 08:52:19+0200, Willy Tarreau wrote:
> > > On Tue, Aug 01, 2023 at 07:30:13AM +0200, Thomas Weißschuh wrote:
> > > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > index 1555759bb164..53a3773c7790 100644
> > > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > 
> > > [..]
> > 
> > > >  /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
> > > > -int prepare(void)
> > > > +static int prepare(void)
> > > >  {
> > > >  	struct stat stat_buf;
> > > >  
> > > > @@ -1208,7 +1208,7 @@ static const struct test test_names[] = {
> > > >  	{ 0 }
> > > >  };
> > >  
> > > For these ones it will prevent gcc from putting breakpoints there, which
> > > is counter-productive.
> > 
> > Indeed.
> > 
> > An alternative would be to add -g to CFLAGS (and remove -s from LDFLAGS).
> > This way we get full debugability including breakpoints for everything.
> 
> It wouldn't change much because while it would allow the debugger to know
> where the function was possibly inlined, it's still not very convenient:
> you believe you're in a function but in fact you're in the caller. It
> really depends what you're debugging but here I don't see all that as
> providing a value, at least it brings more annoyance and little to no
> gain IMHO.

Even if it doesn't work 100% properly it wouldn't it still be a superset
of the previous functionality?
And we don't have to manually keep track of which ones should be static
and which shouldn't (See this discussion).

Would it be better with -ggdb?

If you are still not conviced I'll drop the argument here :-)
(And the changes in the next revision)

> > I didn't find the reasoning for -s in LDFLAGS.
> 
> It's historic, because normally when you want small binaries you strip
> them, and the command line was reused as-is, but I agree that we could
> get rid of it!

I'll remove it. It was annoying to figure out why my "-g" CFLAG didn't
work at all.

Thomas
