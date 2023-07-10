Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4C74DA73
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjGJPxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjGJPxA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 11:53:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9EE10CF;
        Mon, 10 Jul 2023 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689004300; bh=Ntyvxdbr7G90GrTijqSJerUHVYiyjf3KhGK8d6FqJXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUWabtn0+X2jARWFTLJJjxT9O/4LijXryK1e3Ogd7GHRWTZqO19TruMsjyNGykRUB
         2bynX9EoCnONHKcHsThZRez8+wRdP05nZCShbGz7oI3z9EZa+zBmG3XUasf5pNRdmR
         4rbzMfiZiArPukeewe24AeB68tYVSlrwLX+gHbg0=
Date:   Mon, 10 Jul 2023 17:51:39 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to
 <ARCH>/arch.h
Message-ID: <22356a24-7694-461e-bdd1-e5daf84f59f5@t-8ch.de>
References: <20230709095657.GJ9321@1wt.eu>
 <20230710072340.10798-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710072340.10798-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-10 15:23:40+0800, Zhangjin Wu wrote:
> > On Sat, Jul 08, 2023 at 11:26:42PM +0800, Zhangjin Wu wrote:

> [..]

> > > As a preparation, this creates the architecture specific directory and
> > > moves tools/include/nolibc/arch-<ARCH>.h to
> > > tools/include/nolibc/<ARCH>/arch.h.
> > 
> > I'm sorry but I still don't understand what it *provides*. I'm reading
> > it as "we *can* do this so let's do it". But what is the specific
> > purpose of adding this extra directory structure ? It's really unclear
> > to me and worries me that it'll only result in complicating maintenance
> > by adding even more files, thus even more "include" lines and cross
> > dependencies.
> 
> Willy, I was assuming you had a look at the discussion between Thomas
> and me, so, I didn't add the link to our discussion, it is more about
> the 'clarity' of code "include" [1].
> 
> I have proposed the idea in the discussion but got no response yet, so,
> sent this revision for more discussion, obviously, it is better to
> discuss more there and get more feedback from Thomas and you.

To be honest I got overwhelmed at some point and instead of figuring out
to which series' I already responded and which not I only responded to
those where I had time to do so immediately.

Keeping the amount of in-flight serieses lower would help this.

> The v0 included "crt.h" before "arch.h", Thomas suggested me include
> "crt.h" in arch_<ARCH>.h, just like the "compiler.h" did. His suggestion
> did inspire me to think about how to treat the relationship among crt.h,
> sys.h and arch.h.
> 
> The idea behind is we have many directions to divide nolibc to different
> parts/modules:
> 
> - one is arch specific (arch.h) and non-arch specific (the others)
> 
>   This method is used by us currently, It is very good to put all of the
>   arch specific parts together to simplify (in the files to be
>   added/maintained) the porting of a new architecture.
> 
>   But to be honest, It also confuse the modularity a little, for
>   example, like sys.h, crt.h should be a core function/feature of
>   nolibc, arch.h is not so. arch.h only provides the necessary minimal
>   assembly "pieces".
> 
>   both sys.h and crt.h are not a sub modules of arch.h (although they
>   have minimal arch specific code), so, like sys.h, crt.h should be
>   included in the top-level headers, not in arch.h, reversely, the
>   minimal arch specific should be included in crt.h. To do so and to
>   avoid include the non-crt part, the split of arch.h is required, and
>   therefore, the <ARCH>/ is created to put the divided <ARCH>/sys.h and
>   <ARCH>/crt.h, otherwise, there will be many sys-<ARCH>.h and
>   crt-<ARCH>.h in the top-level directory of nolibc.
> 
> - another is the parallel functions/features (like crt.h, sys.h, stack protector ...)
> 
>   This is used by musl and glibc, before sending this proposal, I have
>   taken a look at both of them, musl is simpler and clearer, we apply
>   the similar method:
> 
>   musl:
>       crt/crt1.c
>                  #include "crt_arch.h"  /* arch/<ARCH>/crt_arch.h */

In musl crt_arch.h seems to be used in different ways. So it makes sense
to split it from syscall_arch.h. In nolibc there is no such distinction.
And everything will end up in a global namespace anyways.

>                  void _start_c(long *p)
>                  {
>                         int argc = p[0];
>                         char **argv = (void *)(p+1);
>                         ...
>                  }
> 
>       src/internal/syscall.h:
>                  ##include "syscall_arch.h" /* arch/<ARCH>/syscall_arch.h */
>      
>                  ...
> 
>   glibc: (it is more complicated than musl)
> 
>      csu/libc-start.c, sysdeps/<ARCH>/start.S
>      
>      sysdeps/unix/sysv/linux/sysdep.h, sysdeps/unix/sysv/linux/<ARCH>/sysdep.h, 
> 
> 
>   With this method, the "crt_arch.h + crt.h" together provide the C
>   RunTime (startup code, stack protector, environ and _auxv currently)
>   function, the "sys_arch.h + sys.h" together provide the syscall
>   definitions. The arch specific parts are hidden behind, and only
>   require to include the crt_arch.h in crt.h and sys_arch.h in sys.h, no
>   need to include the whole arch.h for all.
> 
> As a summary, the core obvious reason here is, to this crt.h itself, it
> is ok for us to include crt.h in arch.h in code side, but reversely, I
> do prefer to include arch.h (and therefore the crt_arch.h) in crt.h,
> crt.h is the core function should be exported, arch.h is not, it only
> provide some low-level helpers for crt.h. If we treat sys.h as a core
> function and crt.h as a arch specific thing, it does confuse a little.
> This reorg may also help the similar future functions who require arch
> specific support, but of course, it does require to add/maintain more
> files for a new architecture, but it also allow to develop/debug at a
> smaller fineness.
> 
> In current stage, include crt.h in arch.h is not that unacceptable, but

Why would it be more unacceptable in the future?

> if reorg is a better direction, why not do it currently, because we do
> have two functions (crt.h and sys.h) in <ARCH>/, if only one, it is not
> urgent ;-)

> Is this explanation better than before? welcome to discuss more ;-)

Personally I'm not convinced :-)

The arch-specific code in nolibc in mainline is currentl ~200 lines per
arch. With this series in general it will be even less.
If at some point there are many more architectures it may make sense to
introduce an arch/ directory then.

> Like musl, if required, another top-level arch/ may be required to put
> all of the <ARCH>/ directories together to clean up the top-level nolibc
> directory.

At the moment in mainline there are 26 files in nolibc.
That does not seem excessive, in fact it looks to be less than most
other kernel directories.

> > Zhangjin, very often in your series, the justification for a change is
> > missing, instead it's only explaining what is being changed, and I must
> > confess that it makes it particularly difficult to figure the benefits.
> > I'm only seeing this as an opportunity for a change ("can be split").
> > I could have missed something of course, but I can't figure what problem
> > it is trying to solve.
> 
> Willy, thanks very much for pointing out this and so sorry, "commit
> message should tell why but not how" is in my mind, but sometimes, it
> may be lost especially when the change list are 'huge' (must improve).
> 
> In reality, It is a little difficult to just explain it at the right
> dimension for this change, so I have wrotten several versions of the
> commit message for this change locally (and also for the other changes
> too), at last, I choose the one currently used.
> 
> As explained in another reply, it is really hard to write a just ok
> commit message for every change, sometimes, the justification is
> 'obvious' to some develoers who have the background information or who
> have dicussed together, sometimes, it is not easy to just write
> precisely about the core justification, to improve this, here is the
> list I plan to do, hope it help the others too:
> 
> - discuss more before send new patches, especially for 'new' or 'big'
>   change

This sounds like the correct thing to do for reorganization patches.
It should be very easy to describe and very annoying to actually do.

> - reword carefully about every change before sending patches (show
>   benefits to let maintainer 'buy' (merge) them)
> 
> - send the patches not frequently, keep the mind conscious, not like a
>   "flood"

> [..]
