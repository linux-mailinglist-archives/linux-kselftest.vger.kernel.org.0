Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03423790B58
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjICJcU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJcU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 05:32:20 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46EAA136;
        Sun,  3 Sep 2023 02:32:15 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3839VwLl028250;
        Sun, 3 Sep 2023 11:31:58 +0200
Date:   Sun, 3 Sep 2023 11:31:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Message-ID: <ZPRSjvAJkVTPd2rB@1wt.eu>
References: <ZO62q1lm7HSdcILu@1wt.eu>
 <20230901190317.6114-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901190317.6114-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sat, Sep 02, 2023 at 03:03:17AM +0800, Zhangjin Wu wrote:
> To be honest, although I do understand your worry, this is only a RFC, it is
> far far from killing the maintainability, I'm not expecting the coming RFC
> patchset will happen in v6.7, v6.8 or even any future versions, I'm just
> posting a discussion for some comments on a possibility and David did proposed
> a very good suggestion and we are discussing and verifying its correctness and
> performance carefully and we did get some important progress ;-)

But both Thomas and I explicitly stated multiple times that we did
find that that all of this significantly complicates the code for
little benefit. If we both find it more complicated, it *does* affect
maintainabilityi, and I find it a bit tiresome that we have to justify
ourselves when expressing a feeling of more difficult maintenance.

There are undoubtly good points but also bad ones that come from such
"simplification". The good ones save some trivial copy- pastes and the
bad one induce potential issues that are difficult to fix in the long
term. See how long the discussions about integer detection in macros
have lasted! I do have similar macros that I think I posted already,
whose purpose was precisely to turn a name into a number when the
defined macro exists. Oh sure it was quite simple and appeared to work
fine at first glance. Then one compiler complained about possilbe risk
of out-of-bounds so I prepended "00..." to each string and solved it
like this, I was happy. And later I discovered that some compilers
(don't remember which ones) are not happy when using such complex
expressions as array indexes. Then I found that when some values were
defined in hexadecimal with "0x" in front, it didn't work. Then that
it didn't work either when macros are defined as expressions with
parenthesis. So finally I gave up because the whole approach was wrong.

And by the way you should have a look at archs that have multiple ABIs
like MIPS and ARM, as I'm pretty sure that at least these two ones
define their syscalls in a way looking like (__NR_base + index_write),
which is not compatible with a direct macro-to-number conversion. That's
just an example of course, but it's a perfect example of the stuff that
I don't want to have to deal with in the long term solely for the sake
of saving a few trivial lines. The effort required to maintain this
working and trustable totally outweighs the benefits.

> Now let's back to the background behind this RFC, before sending the new
> time64 syscalls and the size64 syscalls, perhaps we need to clear some
> of these questions:
> 
> 1. Where should we put #ifdef in the new syscalls? libc-level funcs or
>    sys_* funcs?

First, we should not reference non-existing __NR_sysfoo anywhere, so
this means that we have to ifdef sys_* functions anyway. Given that
changes over time come from API variations and unification between archs,
such as select vs newselect vs pselect6 etc, it doesn't seem absurd for
now to provide a compatible sys_* interface on top of that. As you've
seen, the main difference between sys_foo and foo is that sys_* does not
touch errno and is only a syscall, while the other one may also remap
some types to better match what applications need. For example stat()
is now an emulation of the stat() call that calls a different syscall
by rebuilding completely different arguments with a local struct. We
could also have a statx() function as well. Here it's visible that if
both of them rely on sys_statx(), the remapping code has to be in stat().

It's difficult for me to establish a rigid line between this, I think
it mostly comes from common sense and judgement, trying to think whether
we're adapting the user-facing API or the kernel-facing one. chmod()
based on either chmod() or fchmodat() seems like it adapts to the kernel
which may provide either, while the stat example above seems a bit
different. Maybe this difference will fade away over time and one day
we'll even find it simpler to just get rid of these sys_* intermediate
functions and directly involve the syscalls from the libc-level functions,
I don't know.

>    Currently, multiple my_syscall* are called in sys_* funcs, so, the
>    name of sys_* doesn't really reflect the kernel-level syscall, as
>    Arnd suggested before (Willy also replied), it may be possible to map
>    my_syscall* to sys_* one by one, and then call differnt variants of
>    sys_* funcs in libc-level funcs. And also, as we discussed before, #ifdef
>    generates smaller binary size than -ENOSYS check. 
> 
>    There are three possible ways:
> 
>    - one is aligning with the current style, and reorg them in the future,
>      but many new syscalls coming means more reorg work in the future.
>   
>    - another is adding new syscalls with new method, but this will mix
>      two different styles together.
> 
>    - the third one is thinking about reorg in this stage, that is why
>      this RFC is talking about if it is possible to remove #ifdef's
>      completely, if possible, then, no need to move any of the #ifdef's,
>      the reorg will not become that simply moving #ifdef's from sys_* to
>      their libc-level interfaces.

I think that having the ability to ifdef out any such generic function
when it's already defined by the architecture like is already done for
s390 is interesting. I think we should reason in terms of most desirable
to fallback code. I mean, letting the architecture define something, then
having the early sys_* code define certain options, then having the end
of the file provide compatible fallbacks for the not-yet defined cases
sounds fine and flexible. We could then continue to mostly focus on the
generic stuff and let arch maintainers propose improvements for their
archs, or others suggest new, more optimal approaches, etc.

> 2. Is it possible to clear more about the relationship between sys_* and
>    libc-level interfaces?
> 
>    The relationship among my_syscall*, sys_* and libc-level interfaces are
>    documented very well in tools/include/nolibc/nolibc.h.
> 
>    As Yuan asked me in the last month, the prototype of sys_* is almost
>    the same as libc-level interfaces, they almost share the same input
>    arguments, return the same type, that's why I proposed the __sysdef()
>    macro to simply inherit the arguments from libc-level interfaces and
>    return the same return types from my_syscall* (only brk and mmap
>    requires (void *) conversions currently).
> 
>    The issues of __sysdef() pointed out by you require to be solved is
>    making sure people not lose one of the tailing arguments accidentally,
>    so, instead of using .../__VA_ARGS, let's use explicit arguments
>    instead, but it may still avoid some unnecessary input types and
>    return types conversions or passing and also save lots of boring copy
>    and paste.
> 
>    This is also related to the first question, that is this __sysdef()
>    also helps to clear the sys_* roles, it is possible to only map sys_*
>    to the low-level kernel syscall with the same name and not mix them
>    with its variants,

This would result in even more ifdefs because you'd have to test for
their presence in every call place.

>    and it is possible to do some normalization among
>    architectures or among different kernel versions, at last, try the
>    best to provide the same sys_* interfaces to higher libc-level ones,
>    but doing minimal normalization here may be better, perhaps only for
>    sys_* with the same name is ok, then, sys_* will be very clean and
>    with very few exceptions (such as select, mmap and clone, we have
>    seen s390 defined its own variants, we should do this in sys_* level
>    and let architecture choose a right version via __ARCH_WANT_SYS_*),
>    as a result, the sys_* will become a very thin and unified layer
>    between kernel and libc-level interfaces, and the libc-level interfaces
>    should take over the work to choose the right sys_* or their variants
>    the target architectures provided.

That's the way I thought we would do in the past but it came with many
more ifdefs. I'm not necessarily against this, but that's something to
be aware of. Another approach might be to check if we *really* need to
have this separation layer. Maybe we could simply just call the defined
syscalls from the libc functions, and for the rare archs that need
something different, then implement the arch-specific sys_* that's
called as a fallback.

> 3. Is it possible to tune the order of #ifdef's to get smaller binary
> 
>    As local test shows, benifit from the types inherit of the above
>    __sysdef(), less type conversions generate smaller binary, besides, I
>    have found, tuning #ifdef's order also helps size optimization. sys_*
>    with less arguments and smaller arguments has smaller binary size,
>    but it is not that attractive if only want to get smaller binary size
>    because the changing of the #ifdef's will be very ugly, but the
>    possibility of removing them completely may be another situation.
>    Will measure and report the size reduce percentage in our RFC patchset.

Note that every time you're observing a size change related to using
macros instead of functions, it almost always means you're having type
differences causing sign extension for example. That's something to be
extremely careful about. It's not just about size, it's mostly about
correctness.

> I will back to the time64 and size64 syscalls (necessary for rv32) soon,
> the above questions are generic to all of them, that's why I post this
> RFC discussion (perhaps, the RFC title should be something like
> tools/nolibc: preparation for time64 and size64 syscalls).

These ones are probably a good example where we might think about keeping
the separation between sys_foo and foo, because there's no such time64 at
the user level, but the syscalls differ at the kernel level for one arch,
and different wrappers might require some type conversion to preserve
compatibility, that might be easier done in sys_* functions. But I'm not
sure, that's something to see when facing it.

> And we may have more questions, for example, we may need to wrap all
> size64 syscalls under _LARGEFILE64_SOURCE to allow get smaller size, but
> time64 syscalls should be compellent for the coming y2038 issues, before
> sending the syscalls one be one, some generic issues should be discussed
> and cleared.

My goal is not to engrave in stone one choice or another. Reasonable
people adapt to evolving conditions, and that's also why it's not always
easy to respond to generic questions like above out of context. However
I do want the maintenance cost to remain low. May maintenance effort over
the last few months has more than quadrupled, requiring me to rewrite my
test scripts several times, to change my development machine due to the
breakage of compatibility for some parts, and to spend a lot of time
trying to figure how to best address issues caused by a bug in a function
meant to factor everything, and what I can say is thta deciding to change
everything and to "simplify" everything adds lots more work than what it
took to simply add the needed syscalls one at a time. So I'll be more
careful about this.

> And seems both David and Ammar are using https://godbolt.org/
> frequently, a local godbolt.org may be good for toolchains coverage, and
> it is a very good test platform for some code pieces under different
> toolchain versions and different compiler options, I have used it to
> tune the __nrtoi() macro for some randomly chosen clang and gcc versions
> but it is not enough, it must be at first right at language level and
> then fix up the implementation issues reported by toolchains or review.

Godbolt is convenient for use by those proposing to *change* the code,
it is not meant to be used by those having to *maintain* it, or it's
an endless effort.

> A test robot may be important, especially for a new feature or a big
> change, test coverage is required.

Test robots are sometimes convenient, but the simple fact that something
works with all available robots is not necessarily a justification that
it is correct nor desirable. It just saves a lot of time trying multiple
combinations, helping to spot anomalies, warnings, unexpected code
elimination or de-optimization that might sometimes happen.

> > I'm fine for taking
> > that risk when there is a *real* benefit, but here we're speaking about
> > replacing existing, readable and auditable code by something more compact
> > that becomes completely unauditable. I could understand that if it was
> > a specific required step in a more long-term project of factorizing
> > something, but there still hasn't been any such project defined, so all
> > we're doing is "let's see if we can do this or that and see if it looks
> > better". I continue to strongly disagree with this approach, it causes
> > all of us a lot of extra work, introduces regressions and nobody sees
> > the benefits in the end.
> >
> 
> It is a long-term project, it is a very long preparation for adding the new
> time64 and size64 syscalls, all of my work in past weeks are for this goal, but
> it is very hard to define everything clearly before we really work on the real
> patchsets, sometimes, new status, new suggestions ... I'm trying to discuss
> before sending any new patchsets.

That's great. But I'm not seeing how nor why a few syscalls couldn't be
added without systematically having to reorganize and break everything.
The two must be completely separate.

> > For now I still find it complicated to explain other maintainers how
> > to test their changes on all architectures.
> 
> The same to me, that is why I'm working on tinyconfig, O=, and
> CROSS_COMPILE customize support, tinyconfig is 10+ times faster than
> defconfig, for all of the architectures, it may save us by one day ...

Yes very possibly.

> And also, as we discussed before, perhaps the test repo should also
> provide the prebuilt qemu-user, qemu-system and qemu bios for a target
> architecture, especially when the architecture is very new.

For me this goes out of the scope of the project. You don't find
prebuilt qemu in any other place in the kernel either, despite it being
used quite a lot. Instead when a new architecture arrives, it should
generally point to the tools required to build for it, and expect that
not everyone is able to test it yet. It has always worked like this and
that's fine.

> > I've found it difficult to
> > switch between arm and thumb modes for arm when trying to explain it
> > lately (now with more analysis I'm seeing that I could have placed it
> > into CFLAGS_arm for example)
> 
> I used CFLAGS_i386 with x86_64 toolchain before, perhaps it is time to
> add more variants with our new XARCH variable.

Yes I think so.

> > I would also like that we clarify some use cases. Originally the project
> > started as the single-file zero-installation file that allowed to build
> > static binaries, retrieving the linux/ subdir from wherever it was (i.e.
> > from the local system libc for native builds or from the toolchain used
> > for cross-builds). Since we've started to focus a bit too much on the
> > nolibc-test program only with its preparation stages, I think we've lost
> > this focus a little bit, and I'd like to add some tests to make sure this
> > continues to work (I know that my primary usage already got broken by
> > the statx change with the toolchain I was using).
> >
> 
> Seems we have discussed this before, to get zero-installation, musl is a
> good idea, it has no need to install sysroot, but it may increase the
> size of nolibc source code for it requires to define our own structures
> and therefore not depends on the others.

I don't understand why you're speaking about musl here. If we have musl
we don't need nolibc. I was speaking about the fact that for a decade
I could simply build my preinit code using whatever toolchain I had that
already embedded linux headers with its libc and that these ones were
sufficient to get a working binary, i.e.:

    /path/to/$cross-gcc -nostdlib -include nolibc.h -static -Os -o init init.c

And it was convenient because most toolchains that users have are built
with a libc and package kernel headers under linux/. That's also why
there were some type definitions in certain files by the way, in order
to cover those that were missing from my toolchains. I think that as
long as we continue to be careful about only using our own headers for
sys/ etc this should continue to work, and I'll need to think about ways
to test this.

Regards,
Willy
