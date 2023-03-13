Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7956B6DD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 04:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMDI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 23:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjCMDI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 23:08:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 819DEC14C;
        Sun, 12 Mar 2023 20:08:17 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32D38AAT006824;
        Mon, 13 Mar 2023 04:08:10 +0100
Date:   Mon, 13 Mar 2023 04:08:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] tools/nolibc: tests: add test for
 -fstack-protector
Message-ID: <ZA6TmjtAJ5lvFCeF@1wt.eu>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-5-3e74d81b3f21@weissschuh.net>
 <ZA3OhLBmUz3fui+f@1wt.eu>
 <6c627adf-d25d-4135-8185-e59f215f89ee@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c627adf-d25d-4135-8185-e59f215f89ee@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 12, 2023 at 11:12:50PM +0000, Thomas Weißschuh wrote:
> FYI there is also another patch to make nolibc-test buildable with
> compilers that enable -fstack-protector by default.
> Maybe this can be picked up until the proper stack-protector support is
> hashed out.
> Maybe even for 6.3:
> 
> https://lore.kernel.org/lkml/20230221-nolibc-no-stack-protector-v1-1-4e6a42f969e2@weissschuh.net/

Ah thanks, it seems I indeed missed it. It looks good, I'll take it.

> > > +int run_stackprotector(int min, int max)
> > > +{
> > > +	int llen = 0;
> > > +
> > > +	llen += printf("0 ");
> > > +
> > > +#if !defined(NOLIBC_STACKPROTECTOR)
> > > +	llen += printf("stack smashing detection not supported");
> > > +	pad_spc(llen, 64, "[SKIPPED]\n");
> > > +	return 0;
> > > +#endif
> > 
> > Shouldn't the whole function be enclosed instead ? I know it's more of
> > a matter of taste, but avoiding to build and link it for archs that
> > will not use it may be better.
> 
> The goal was to print a [SKIPPED] message if it's not supported.

Ah indeed makes sense.

> The overhead of doing this should be neglectable.

It was not the overhead (that's only a regtest program after all), I
was more thinking about the difficulty to maintain this function over
time for other archs if it starts to rely on optional support. But for
now it's not a problem, it it would ever become one we could simply
change that to have a function just print SKIPPED. So I'm fine with
your option.

> > > @@ -719,8 +784,11 @@ int prepare(void)
> > >  /* This is the definition of known test names, with their functions */
> > >  static const struct test test_names[] = {
> > >  	/* add new tests here */
> > > -	{ .name = "syscall",   .func = run_syscall  },
> > > -	{ .name = "stdlib",    .func = run_stdlib   },
> > > +	{ .name = "syscall",        .func = run_syscall         },
> > > +	{ .name = "stdlib",         .func = run_stdlib          },
> > > +	{ .name = "stackprotector", .func = run_stackprotector, },
> > > +	{ .name = "_smash_stack",   .func = run_smash_stack,
> > 
> > I think it would be better to keep the number of categories low
> > and probably you should add just one called "protection" or so,
> > and implement your various tests in it as is done for other
> > categories. The goal is to help developers quickly spot and select
> > the few activities they're interested in at a given moment. 
> 
> I'm not sure how this would be done. The goal here is that
> "stackprotector" is the user-visible category. It can be changed to
> "protection".
> "_smash_stack" however is just an entrypoint that is used by the forked
> process to call the crashing code.

Ah I didn't realize that, I now understand how that can be useful,
indeed. Then maybe just rename your .skip_by_default field to .hidden
so that it becomes more generic (i.e. if one day we permit enumeration
we don't want such tests to be listed either), and assign the field on
the same line so that it's easily visible with a grep.

Thanks,
Willy
