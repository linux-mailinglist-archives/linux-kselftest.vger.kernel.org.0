Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE425FACA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJKGWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Oct 2022 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJKGVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:47 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8169588A31;
        Mon, 10 Oct 2022 23:21:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29B6Kt5D005367;
        Tue, 11 Oct 2022 08:20:55 +0200
Date:   Tue, 11 Oct 2022 08:20:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: tools/nolibc: fix missing strlen() definition and infinite loop
 with gcc-12
Message-ID: <20221011062055.GC5107@1wt.eu>
References: <Y0LsreRGq3nbe2xC@localhost.localdomain>
 <20221009175920.GA28685@1wt.eu>
 <20221009183604.GA29069@1wt.eu>
 <9e16965f1d494084981eaa90d73ca80e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e16965f1d494084981eaa90d73ca80e@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 10, 2022 at 10:03:53AM +0000, David Laight wrote:
> From: Willy Tarreau <w@1wt.eu>
> > Sent: 09 October 2022 19:36
> ...
> > By the way, just for the sake of completeness, the one that consistently
> > gives me a better output is this one:
> > 
> >   size_t strlen(const char *str)
> >   {
> >           const char *s0 = str--;
> > 
> >           while (*++str)
> >   		;
> >           return str - s0;
> >   }
> > 
> > Which gives me this:
> > 
> > 
> >   0000000000000000 <strlen>:
> >      0:   48 8d 47 ff             lea    -0x1(%rdi),%rax
> >      4:   48 ff c0                inc    %rax
> >      7:   80 38 00                cmpb   $0x0,(%rax)
> >      a:   75 f8                   jne    4 <len+0x4>
> >      c:   48 29 f8                sub    %rdi,%rax
> >      f:   c3                      ret
> > 
> > But this is totally ruined by the addition of asm() in the loop. However
> > I suspect that the construct is difficult to match against a real strlen()
> > since it starts on an extra character, thus placing the asm() statement
> > before the loop could durably preserve it. It does work here (the code
> > remains the exact same one), but for how long, that's the question. Maybe
> > we can revisit the various loop-based functions in the future with this in
> > mind.
> 
> clang wilfully and persistently generates:
> 
> strlen:                                 # @strlen
>         movq    $-1, %rax
> .LBB0_1:                                # =>This Inner Loop Header: Depth=1
>         cmpb    $0, 1(%rdi,%rax)
>         leaq    1(%rax), %rax
>         jne     .LBB0_1
>         retq
> 
> But feed the C for that into gcc and it generates a 'jmp strlen'
> at everything above -O1.

Interesting, that's not the case for me here with 12.2 from kernel.org
on x86_64, which gives this at -O1, -O2, -O3 and -Ofast:

  0000000000000000 <strlen>:
     0:   48 8d 47 ff             lea    -0x1(%rdi),%rax
     4:   0f 1f 40 00             nopl   0x0(%rax)
     8:   48 83 c0 01             add    $0x1,%rax
     c:   80 38 00                cmpb   $0x0,(%rax)
     f:   75 f7                   jne    8 <strlen+0x8>
    11:   48 29 f8                sub    %rdi,%rax
    14:   c3                      ret    

Out of curiosity what version were you using ? 

> I suspect that might run with less clocks/byte than the code above.

Certainly for large strings, but not for short ones.

> Somewhere I hate some complier pessimisations.
> Substituting a call to strlen() is typical.
> strlen() is almost certainly optimised for long strings.
> If the string is short the coded loop will be faster.

Yes, and more importantly, if a developer takes the time to explicitly
write a loop to do something that matches such a function, it's very
likely that they already considered the function and did *not* want to
use it for whatever reason. And the problem we're currently having with
compilers is that they are not willing to respect the developer's intent
because they always know better.

> The same is true (and probably more so) for memcpy.

Yes, I think that we'll eventually have to stuff a few asm() here and
there in a few such loops as compilers become less and less trustable.

Willy
