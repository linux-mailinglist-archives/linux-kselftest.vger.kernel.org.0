Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D774F5B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjGKQjq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 12:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGKQjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 12:39:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A308CA;
        Tue, 11 Jul 2023 09:39:39 -0700 (PDT)
X-QQ-mid: bizesmtp70t1689093568tma672az
Received: from localhost.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 00:39:27 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 7jw2iSiCazpo/LBoTHiWUTFOO0T2xxVuLXpc0XNSJCcOdmxfxczJzCGNWvpSP
        O3MTKSEmLAA6Oqt1rjKurirN48Op1YM6jvIoybGvWrueLI9SKopBDAs6DHcRPYNw/H3suyr
        9PtlYkSHMpqq8yULFzMckX2Tp9TfhrttXvFss7CQ+d/vrmNuPzsglqUj9mrKHE1ke/jDNx2
        K2UbqeCat0L1ekFXYGehneLAVYF4OrSkdlZz0JIibJ1x2qGQ3bCZaOesfIshEBccxZQaPN4
        PL7fDw+etfIy6XdslbucE2luDDFoNYsNnWPwRPxpyTOJbXMsnF4io3p2fKn3HtfpSRFYVUi
        LhNpfm86HcGpHnbY8sB7heyZUdvFZ55klm1gj2ErEEFV/8NFeI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4955814651562134539
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 01/12] tools/nolibc: rename arch-<ARCH>.h to <ARCH>/arch.h
Date:   Wed, 12 Jul 2023 00:38:30 +0800
Message-Id: <20230711163830.10271-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZK0HouRo8g6jqkTi@1wt.eu>
References: <ZK0HouRo8g6jqkTi@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Thomas, Zhangjin,
> 
> On Mon, Jul 10, 2023 at 05:51:39PM +0200, Thomas Weißschuh wrote:
> > On 2023-07-10 15:23:40+0800, Zhangjin Wu wrote:
> > > > On Sat, Jul 08, 2023 at 11:26:42PM +0800, Zhangjin Wu wrote:
> > 
> > > [..]
> > 
> > > > > As a preparation, this creates the architecture specific directory and
> > > > > moves tools/include/nolibc/arch-<ARCH>.h to
> > > > > tools/include/nolibc/<ARCH>/arch.h.
> > > > 
> > > > I'm sorry but I still don't understand what it *provides*. I'm reading
> > > > it as "we *can* do this so let's do it". But what is the specific
> > > > purpose of adding this extra directory structure ? It's really unclear
> > > > to me and worries me that it'll only result in complicating maintenance
> > > > by adding even more files, thus even more "include" lines and cross
> > > > dependencies.
> > > 
> > > Willy, I was assuming you had a look at the discussion between Thomas
> > > and me, so, I didn't add the link to our discussion, it is more about
> > > the 'clarity' of code "include" [1].
> > > 
> > > I have proposed the idea in the discussion but got no response yet, so,
> > > sent this revision for more discussion, obviously, it is better to
> > > discuss more there and get more feedback from Thomas and you.
> > 
> > To be honest I got overwhelmed at some point and instead of figuring out
> > to which series' I already responded and which not I only responded to
> > those where I had time to do so immediately.
> > 
> > Keeping the amount of in-flight serieses lower would help this.
> 
> +1 on this. First it's difficult for me to assign contiguous time on
> the subject so I can't grasp all series at once, and I'm terribly bad
> at context-switching, which takes even more time and induces confusion.
> Less topics at once, more focused with less reviews of reorganizations
> will definitely help.

me too, let's go back to the original rv32 support asap ;-)

> 
> > > The v0 included "crt.h" before "arch.h", Thomas suggested me include
> > > "crt.h" in arch_<ARCH>.h, just like the "compiler.h" did. His suggestion
> > > did inspire me to think about how to treat the relationship among crt.h,
> > > sys.h and arch.h.
> > > 
> > > The idea behind is we have many directions to divide nolibc to different
> > > parts/modules:
> 
> Again above I'm seeing an opportunity but no explanation of why this
> is needed. Thomas already mentioned that you're speaking about just
> trying to factor out a few tens of lines. I'm not seeing *why* we
> need to re-split everything yet again.
>
> > > - one is arch specific (arch.h) and non-arch specific (the others)
> > > 
> > >   This method is used by us currently, It is very good to put all of the
> > >   arch specific parts together to simplify (in the files to be
> > >   added/maintained) the porting of a new architecture.
> > > 
> > >   But to be honest, It also confuse the modularity a little, for
> > >   example, like sys.h, crt.h should be a core function/feature of
> > >   nolibc, arch.h is not so. arch.h only provides the necessary minimal
> > >   assembly "pieces".
> 
> But that's precisely the principle: keep arch-specific stuff as minimal
> as possible, keep most of the rest generic but easily overloadable if
> needed as we know that archs are not all 1:1 equivalent.
>

This patchset applies the same principle but mixes some other
requirements ;-)

Agree with "archs are not all 1:1 equivalent".

> > >   both sys.h and crt.h are not a sub modules of arch.h (although they
> > >   have minimal arch specific code), so, like sys.h, crt.h should be
> > >   included in the top-level headers, not in arch.h,
> 
> Why ? Keep in mind that these are only include files, to in the end,
> *all* of them are included. The ordering is the only thing that really
> matters.
>

Yeah, I know this. The only thing confused me is the relationship among
crt.h, sys.h and arch.h, the include position should better reflects
their relationship, currently, we have mixed two "divide" methods
together, one is arch and non-arch, another is the parallel
functions/features.

so, the only left question is where should we include crt.h in? Firstly,
I put it like sys.h (In my mind, it should be), If you two both agree to
put it in arch-<ARCH.h>, I will renew this series with it, this is
definitely a lighter way than the reorg method, I don't persist ;-)

> > >   reversely, the
> > >   minimal arch specific should be included in crt.h. To do so and to
> > >   avoid include the non-crt part, the split of arch.h is required, and
> > >   therefore, the <ARCH>/ is created to put the divided <ARCH>/sys.h and
> > >   <ARCH>/crt.h, otherwise, there will be many sys-<ARCH>.h and
> > >   crt-<ARCH>.h in the top-level directory of nolibc.
> 
> Then doesn't it prove that you don't need that crt-<ARCH>.h and that
> instead it should just be in arch-<ARCH> like the rest of the same arch ?
> 
> > > - another is the parallel functions/features (like crt.h, sys.h, stack protector ...)
> > > 
> > >   This is used by musl and glibc, before sending this proposal, I have
> > >   taken a look at both of them, musl is simpler and clearer, we apply
> > >   the similar method:
> > > 
> > >   musl:
> > >       crt/crt1.c
> > >                  #include "crt_arch.h"  /* arch/<ARCH>/crt_arch.h */
> > 
> > In musl crt_arch.h seems to be used in different ways. So it makes sense
> > to split it from syscall_arch.h. In nolibc there is no such distinction.
> > And everything will end up in a global namespace anyways.
> 
> Exactly. Musl is musl and nolibc is nolibc. Musl is a regular libc in that
> it provides a .so that is built from many .c files. As such it's desirable
> to split along certain edges. nolibc contains no single C file. It's only
> meant to be included as-is in the user's C file. This changes a lot of
> things, even in terms of splitting. Also keep in mind that musl is a
> general-purpose libc, and that some distros are entirely built on it.
> nolibc doesn't have such goal nor expectation, the first user was a
> preinit code I wrote long ago, and the second one is rcutorture which
> contains a while() loop around gettimeofday() IIRC. We must not just
> blindly imitate other components' choices because they work, when we're
> dealing with different constraints. If ours are acceptable, no need to
> complicate everything.
>

Willy, I know the difference between musl and nolibc, the musl code
referenced here is only used to clear my confusion about "the
relationship among crt.h, sys.h and arch.h" I mentiond above.

BTW, I do think nolibc have more using scenes, I like it very much and
have used it in my own "Linux Lab" open source project [1] to let it
work as the minimal rootfs to speed up kernel features learning and
development, I do like the 'kernel-only deployments' feature behind
nolibc [2], although there is something like "Unikernel Linux" [3], but
that differs from a normal Linux system and is more complicated ;-)

I'm even imaging using it with a pure-header shell and a pure-header gui
to let them further work together as a tiny rtos ;-)

[1]: https://github.com/tinyclub/linux-lab
[2]: https://lwn.net/Articles/920158/
[3]: https://github.com/unikernelLinux/ukl

> > >   With this method, the "crt_arch.h + crt.h" together provide the C
> > >   RunTime (startup code, stack protector, environ and _auxv currently)
> > >   function, the "sys_arch.h + sys.h" together provide the syscall
> > >   definitions. The arch specific parts are hidden behind, and only
> > >   require to include the crt_arch.h in crt.h and sys_arch.h in sys.h, no
> > >   need to include the whole arch.h for all.
> 
> Everything is included all the time. *everything*. The more files we
> create, the more "#ifdef FOO_H" gets evaluated, and the more maintenance
> burden it adds.
>

Agree with less "#ifdef"s.

> > > As a summary, the core obvious reason here is, to this crt.h itself, it
> > > is ok for us to include crt.h in arch.h in code side, but reversely, I
> > > do prefer to include arch.h (and therefore the crt_arch.h) in crt.h,
> > > crt.h is the core function should be exported, arch.h is not, it only
> > > provide some low-level helpers for crt.h. If we treat sys.h as a core
> > > function and crt.h as a arch specific thing, it does confuse a little.
> > > This reorg may also help the similar future functions who require arch
> > > specific support, but of course, it does require to add/maintain more
> > > files for a new architecture, but it also allow to develop/debug at a
> > > smaller fineness.
> > > 
> > > In current stage, include crt.h in arch.h is not that unacceptable, but
> > 
> > Why would it be more unacceptable in the future?
> > 
> > > if reorg is a better direction, why not do it currently, because we do
> > > have two functions (crt.h and sys.h) in <ARCH>/, if only one, it is not
> > > urgent ;-)
> > 
> > > Is this explanation better than before? welcome to discuss more ;-)
> > 
> > Personally I'm not convinced :-)
> 
> Neither am I.
> 
> > The arch-specific code in nolibc in mainline is currentl ~200 lines per
> > arch. With this series in general it will be even less.
> > If at some point there are many more architectures it may make sense to
> > introduce an arch/ directory then.
> 
> And even then I'm not convinced because the number of archs will remain
> low anyway.
>

We have 8 now, the maximum may be 'ls -d arch/*/ | wc -l', it is 22
currently ;-)

> > > Like musl, if required, another top-level arch/ may be required to put
> > > all of the <ARCH>/ directories together to clean up the top-level nolibc
> > > directory.
> > 
> > At the moment in mainline there are 26 files in nolibc.
> > That does not seem excessive, in fact it looks to be less than most
> > other kernel directories.
> 
> Indeed :-)  Note that it started with a single one!

Yeah, I learned the history, but I do think we will have more, as the
requirements become more and more ;-)

> 
> > > As explained in another reply, it is really hard to write a just ok
> > > commit message for every change, sometimes, the justification is
> > > 'obvious' to some develoers who have the background information or who
> > > have dicussed together, sometimes,
> 
> Sometimes yes, but most of the series come with propositions to improve
> something. The commits making the major changes (and the cover letter)
> should justify why this is a desirable change, what it implies not to
> have it and what it may imply to have it, what possible alternatives
> were considered and dropped sometimes (e.g. when hesitating between two
> approaches), etc.

Ok. 

Thanks,
Zhangjin

> 
> Thanks,
> Willy
