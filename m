Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702078DAB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjH3ShA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjH3HXm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 03:23:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168C61BB;
        Wed, 30 Aug 2023 00:23:37 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37U7NBLX025225;
        Wed, 30 Aug 2023 09:23:11 +0200
Date:   Wed, 30 Aug 2023 09:23:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <ZO7uX2C3OAN634tV@1wt.eu>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
 <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
 <ZO25u3crGixkGKWe@1wt.eu>
 <b2c2ca69-b9bb-40b1-a05a-6d2f66e01034@t-8ch.de>
 <ZO3gvcoe8wZM+f5A@1wt.eu>
 <3663d244-627f-4928-ab2e-0328cd6a8fb1@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3663d244-627f-4928-ab2e-0328cd6a8fb1@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 30, 2023 at 08:21:51AM +0200, Thomas Weißschuh wrote:
> On 2023-08-29 14:12:45+0200, Willy Tarreau wrote:
> > On Tue, Aug 29, 2023 at 12:16:23PM +0200, Thomas Weißschuh wrote:
> > > > OK. But then, doesn't it mean that if we don't provide our stdarg.h,
> > > > the compilers' will be used ? I'm asking because we're already using
> > > > va_list and va_args, for example in vfprintf() in stdio.h, which
> > > > precisely includes <stdarg.h> so it must indeed come from the compiler.
> > > 
> > > It will be used *iff* -nostdinc is *not* passed.
> > > 
> > > I think we need to clarify the definition of the word "provided".
> > > For me it means that the compiler ships an implementation of this header
> > > file in the compiler-specific include directory.
> > > 
> > > If -nostdinc is passed this include directory is not actually usable.
> > 
> > OK I understand better now. I thought it was always usable.
> > 
> > > If a user wants to avoid the implicit usage of any system-provided
> > > headers they need to pass -nostdinc, as far as I know there is no flag
> > > to keep only the compiler-specific include directories.
> > 
> > So that means we may also have to implement our own stddef.h to move
> > size_t there, and limits.h and move *MAX there as well if we want to
> > support this. I'm not necessarily against this, it's just that we need
> > to be consistent.
> 
> We would have to, *iff* the goal is to provide *all* headers in nolibc.

That has never been my goal (especially for those already provided by
the compiler).

> > Also something is puzzling me. If a normal program builds with -nostdinc,
> > it means it does *not* want the libc's (nor the compiler's) headers to be
> > included, probably because it comes with its own. In this case why would
> > we impose ours ? For example, let's consider this tiny code snippet:
> > 
> >   $ cat arg.c
> >   #include <stdarg.h>
> >   va_list blah;
> > 
> >   $ gcc -c arg.c 
> >   $ gcc -nostdinc -c arg.c
> >   arg.c:1:20: error: no include path in which to search for stdarg.h
> >       1 | #include <stdarg.h>
> >         |                    ^
> >   arg.c:2:1: error: unknown type name 'va_list'
> >       2 | va_list blah;
> >         | ^~~~~~~
> >   arg.c:1:1: note: 'va_list' is defined in header '<stdarg.h>'; did you forget to '#include <stdarg.h>'?
> >     +++ |+#include <stdarg.h>
> >       1 | #include <stdarg.h>
> >  
> > You see, that's why I'm finding it confusing that we define headers that
> > are supposed *not* to be defined with -nostdinc.
> 
> I'm confused.
> 
> If the user doesn't want to use nolibc they should not explicitly add it
> to the include path.

I didn't understand that it was what you were seeking, I thought you
wanted to build like above, hence my confusion, see below.

> > I think we need to carefully check what is supposed to be defined and
> > what not when -nostdinc is used normally so that we defined what programs
> > expect and not what they expect us *not* to define. Recently we've been
> > empirically fixing nolibc-test build failures but it's just a test program
> > that comes with its own biases. Maybe trying to build some portable libs
> > that use very little from a libc (e.g. xxhash, liblzo etc) could give us
> > some hints about certain basic assumptions that we do not fulfill.
> 
> It makes sense to figure out what is needed by larger projects from a
> libc. But it feels to me like a bug vs. feature discussion.
> 
> Making larger real-world applications work is a feature while making the
> following work is a bugfix:
> 
> $ cat nolibc.c
> #include "nolibc.h"
> 
> int main(void)
> {
> 	return 0;
> }
> 
> $ gcc -nostdinc -Isysroot/x86/include -c nolibc.c
> In file included from sysroot/x86/include/nolibc.h:98,
>                  from nolibc-test.c:1:
> sysroot/x86/include/sys.h:10:10: fatal error: stdarg.h: No such file or directory
>    10 | #include <stdarg.h>
>       |          ^~~~~~~~~~

This one definitely is a bug, I totally agree. And I didn't understand
this from your initial patch, my understanding was that users would
want to use -nostdinc yet build using regular includes that we'd
provide.

> > > It's all about supporting -nostdinc.

Yes, but "-nostdinc" with "-include nolibc.h". It was probably obvious
to you since you were trying to make it work but I really didn't grasp
it.

> > But unless I'm mistaken (and my example above seems to support this),
> > a normal libc doesn't build with -nostdinc. That's the point I'd like
> > us to clarify.
> 
> musl:
> 
> $ cat /usr/lib/musl/lib/musl-gcc.specs
> ...
> *cc1:
> %(cc1_cpu) -nostdinc -isystem /usr/lib/musl/include -isystem include%s
> ...
> 
> 
> dietlibc:
> 
> $ cat Makefile
> ...
> DEFAULTCFLAGS=-pipe -nostdinc -D_REENTRANT $(EXTRACFLAGS)
> ...

OK.

> klibc re-adds the compilers include path,
> This is an alternative we could also use:
> 
> $ cat Makefile
> ...
> NOSTDINC_FLAGS := -nostdlib -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> ...

Another approach but not easy to pass to end-users.

> There was also a longer discussion on LKML about linux/stdarg.h [0]

Thanks for the link, interesting indeed!

> The gcc authors argue that Linux should not ship a custom stdarg.h.
> But in reality Linux, musl, dietlibc (and probably some more) today are
> shipping their own stdarg.h.

I think the main problem precisely is that -nostdinc excludes both the
system libc's and the compiler's headers (that last point I didn't know).
If there was a standard way to say "no system includes but please keep
the compiler's headers as they're the only exposed interface we have" it
would be much easier. So yes, I understand what you ended up on: you in
fact want to be sure not to inherit from the local system headers and as
a side effect you lose the compiler ones so you need to redefine them.
Then of course that's fine.

> > We have an interesting comment at the top of nolibc.h which says:
> > 
> >  * The available standard (but limited) include files are:
> >  *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h
> 
> This is out of date. It's missing signal.h, stdint.h, unistd.h.

Yes very likely, but I found it interesting to find this split that was
done a while ago.

> >  *
> >  * In addition, the following ones are expected to be provided by the compiler:
> >  *   float.h, stdarg.h, stddef.h
> 
> What does "expected" mean here?
> nolibc itself is perfectly fine without float.h and stddef.h.

i.e. "if needed we'll use these ones".

> >  * The following ones which are part to the C standard are not provided:
> >  *   assert.h, locale.h, math.h, setjmp.h, limits.h
> 
> While true, a lot of other headers are also not provided.

Sure, but these were the ones I identified by then.

> > I think I draw the line based on what my compilers have always provided.
> > That's definitely something we can redefine (and update the comment),
> > I'm just seeking consistency, and I think you can understand :-/
> 
> I do understand.
> 
> To reiterate it here explicitly, in my opinion it's a worthwhile and
> consistent goal to make "nolibc usable standalone with -nostdinc" for
> maximal control by the user.

I agree now. I think we need to make it clear that it's for when we're
including the all-in-one "nolibc.h" as an alternative to regular headers.

> If not, I'd like to use the "-nostdinc -I$(cc -print-file-name=include)"
> method to avoid dependencies on system header for nolibc-test
> specifically.

It's a bit ugly and not always easy to stuff into projects. The fact that
nolibc itself isn't self-sustaining anymore with -nostdinc is a concern
and I agree with addressing it like you proposed.

Thanks for the clarification!
Willy
