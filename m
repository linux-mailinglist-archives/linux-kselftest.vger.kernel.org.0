Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1E76ACAB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 11:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjHAJRo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjHAJRQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 05:17:16 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA0CD2728;
        Tue,  1 Aug 2023 02:16:18 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3719DrhR031934;
        Tue, 1 Aug 2023 11:13:53 +0200
Date:   Tue, 1 Aug 2023 11:13:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v2 06/10] selftests/nolibc: make functions static if
 possible
Message-ID: <ZMjM0UPRAqoC+goY@1wt.eu>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
 <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
 <ZMiro1pwVvAzNel5@1wt.eu>
 <bf97900a-98bb-45dc-9451-b9728173136e@t-8ch.de>
 <ZMi+k0HsMGJxbs7V@1wt.eu>
 <4ad4b853-b89f-4c5a-a50b-28739d7b81c0@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad4b853-b89f-4c5a-a50b-28739d7b81c0@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 01, 2023 at 10:50:05AM +0200, Thomas Weißschuh wrote:
> > > An alternative would be to add -g to CFLAGS (and remove -s from LDFLAGS).
> > > This way we get full debugability including breakpoints for everything.
> > 
> > It wouldn't change much because while it would allow the debugger to know
> > where the function was possibly inlined, it's still not very convenient:
> > you believe you're in a function but in fact you're in the caller. It
> > really depends what you're debugging but here I don't see all that as
> > providing a value, at least it brings more annoyance and little to no
> > gain IMHO.
> 
> Even if it doesn't work 100% properly it wouldn't it still be a superset
> of the previous functionality?

No, we need to be able to disassemble this to understand what was done
to the code we believe is being tested. All of us have been dealing with
this already, and making that code less mappable from asm to C is quite
annoying.

> And we don't have to manually keep track of which ones should be static
> and which shouldn't (See this discussion).

We should not have to be concerned about this, because it's out of the
scope of what this "program" is used for. If we're wondering too much,
we're wasting our time on the wrong topic. So we have to find a reasonable
rule. One that sounds fine to me is to say:
  - all that's part of the framework to help with testing (i.e. the expect
    functions, errorname()  etc) could be static because we don't really
    care about them (at least we won't be placing breakpoints there). They
    may be marked inline or unused and we can be done with them.

  - user code and the calling stack from main should be easily traceable
    using gdb and objdump -dr so that when you start with a new arch and
    it breaks early (as happens by definition when syscalls or crt code
    don't all work well) then it's possible to accurately trace it without
    having to worry too much about what was transformed how.

> Would it be better with -ggdb?

It doesn't change. The thing is: by saying "static" you tell the
compiler "I promise it cannot be used anywhere else, do what you want
with it", and it can trivially decide to inline all or part of it, or
change its number of arguments or whatever as it sees fit because no
other code part relies on that function. And when you're trying to
disassemble your test_mmap_munmap() and can't find it and can only
infer its inlined presence in run_syscall() by seeing a value in a
register that vaguely reminds you about __NR_mmap, it's clearly much
less easy.

> If you are still not conviced I'll drop the argument here :-)
> (And the changes in the next revision)

No problem, it's fine to discuss the current situation. I've just
noticed a number of static on some test functions that would deserve
being removed precisely for the reasons above. But that justifies the
need for some doc about all this.

> > > I didn't find the reasoning for -s in LDFLAGS.
> > 
> > It's historic, because normally when you want small binaries you strip
> > them, and the command line was reused as-is, but I agree that we could
> > get rid of it!
> 
> I'll remove it. It was annoying to figure out why my "-g" CFLAG didn't
> work at all.

Yes I can definitely understand!

Thanks,
Willy
