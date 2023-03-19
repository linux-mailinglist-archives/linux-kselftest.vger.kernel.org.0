Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046956C0230
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Mar 2023 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCSN6L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Mar 2023 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCSN6K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Mar 2023 09:58:10 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF8B919C65;
        Sun, 19 Mar 2023 06:58:08 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32JDw3SE031207;
        Sun, 19 Mar 2023 14:58:03 +0100
Date:   Sun, 19 Mar 2023 14:58:03 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] tools/nolibc: tests: add test for
 -fstack-protector
Message-ID: <ZBcU63x/bXih3vTm@1wt.eu>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
 <20230223-nolibc-stackprotector-v1-5-3e74d81b3f21@weissschuh.net>
 <ZA3OhLBmUz3fui+f@1wt.eu>
 <6c627adf-d25d-4135-8185-e59f215f89ee@t-8ch.de>
 <ZA6TmjtAJ5lvFCeF@1wt.eu>
 <4d2b4237-48dc-4d78-ab42-47f78cb76ab8@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d2b4237-48dc-4d78-ab42-47f78cb76ab8@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sat, Mar 18, 2023 at 04:49:12PM +0000, Thomas Weißschuh wrote:
> On Mon, Mar 13, 2023 at 04:08:10AM +0100, Willy Tarreau wrote:
> > On Sun, Mar 12, 2023 at 11:12:50PM +0000, Thomas Weißschuh wrote:
> > > FYI there is also another patch to make nolibc-test buildable with
> > > compilers that enable -fstack-protector by default.
> > > Maybe this can be picked up until the proper stack-protector support is
> > > hashed out.
> > > Maybe even for 6.3:
> > > 
> > > https://lore.kernel.org/lkml/20230221-nolibc-no-stack-protector-v1-1-4e6a42f969e2@weissschuh.net/
> > 
> > Ah thanks, it seems I indeed missed it. It looks good, I'll take it.
> 
> Do you have a tree with this published?

No, it was only on my local machine waiting for me to retest all archs
with it (in the past I've met build issues due to some variables being
preset by some included files so I'm extra careful). I've just rebased
it on latest master and just passed it to Paul for inclusion now.

> So I can make sure the next revision of this patchset does not lead to
> conflicts.

Do not worry too much for this, just tell me upfront whether your next
series is based on it or not and I'll adjust accordingly based on what
is already merged when I take it.

> > > > > @@ -719,8 +784,11 @@ int prepare(void)
> > > > >  /* This is the definition of known test names, with their functions */
> > > > >  static const struct test test_names[] = {
> > > > >  	/* add new tests here */
> > > > > -	{ .name = "syscall",   .func = run_syscall  },
> > > > > -	{ .name = "stdlib",    .func = run_stdlib   },
> > > > > +	{ .name = "syscall",        .func = run_syscall         },
> > > > > +	{ .name = "stdlib",         .func = run_stdlib          },
> > > > > +	{ .name = "stackprotector", .func = run_stackprotector, },
> > > > > +	{ .name = "_smash_stack",   .func = run_smash_stack,
> > > > 
> > > > I think it would be better to keep the number of categories low
> > > > and probably you should add just one called "protection" or so,
> > > > and implement your various tests in it as is done for other
> > > > categories. The goal is to help developers quickly spot and select
> > > > the few activities they're interested in at a given moment. 
> > > 
> > > I'm not sure how this would be done. The goal here is that
> > > "stackprotector" is the user-visible category. It can be changed to
> > > "protection".
> > > "_smash_stack" however is just an entrypoint that is used by the forked
> > > process to call the crashing code.
> > 
> > Ah I didn't realize that, I now understand how that can be useful,
> > indeed. Then maybe just rename your .skip_by_default field to .hidden
> > so that it becomes more generic (i.e. if one day we permit enumeration
> > we don't want such tests to be listed either), and assign the field on
> > the same line so that it's easily visible with a grep.
> 
> Actually this works fine with a plain fork() and the exec() is not
> needed. So the dedicated entrypoint is not needed anymore.

Ah, even better!

> No idea what I tested before.

No worries. I've yet to find a single occurrence of a test being created
straight without exploring various approaches ;-)

Thanks!
Willy
