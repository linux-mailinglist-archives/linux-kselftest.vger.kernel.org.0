Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6D78D350
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjH3GWP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjH3GV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 02:21:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3669FE9;
        Tue, 29 Aug 2023 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693376512;
        bh=jAC7zdPl6J/oupWD8g3GrVUHLLz+k4Rn+GTZrriAvqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXdsmEwJBPxlmUWo9byETFQW3nJxb/+cCg1QWzkSxKJ3rEa7EKaIGPmx+Hvmd1bxt
         GLXjpY09nZy5E2F944RpfrpDzcyEIyRTJfHY9Xyth1nR+TjQgBtOjOyTK35EhFP9Ha
         M2/Dn77LYSSAqPR9X5VsGFSNz5lagmSUzhOz078w=
Date:   Wed, 30 Aug 2023 08:21:51 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <3663d244-627f-4928-ab2e-0328cd6a8fb1@t-8ch.de>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
 <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
 <ZO25u3crGixkGKWe@1wt.eu>
 <b2c2ca69-b9bb-40b1-a05a-6d2f66e01034@t-8ch.de>
 <ZO3gvcoe8wZM+f5A@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZO3gvcoe8wZM+f5A@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-29 14:12:45+0200, Willy Tarreau wrote:
> On Tue, Aug 29, 2023 at 12:16:23PM +0200, Thomas Weißschuh wrote:
> > > OK. But then, doesn't it mean that if we don't provide our stdarg.h,
> > > the compilers' will be used ? I'm asking because we're already using
> > > va_list and va_args, for example in vfprintf() in stdio.h, which
> > > precisely includes <stdarg.h> so it must indeed come from the compiler.
> > 
> > It will be used *iff* -nostdinc is *not* passed.
> > 
> > I think we need to clarify the definition of the word "provided".
> > For me it means that the compiler ships an implementation of this header
> > file in the compiler-specific include directory.
> > 
> > If -nostdinc is passed this include directory is not actually usable.
> 
> OK I understand better now. I thought it was always usable.
> 
> > If a user wants to avoid the implicit usage of any system-provided
> > headers they need to pass -nostdinc, as far as I know there is no flag
> > to keep only the compiler-specific include directories.
> 
> So that means we may also have to implement our own stddef.h to move
> size_t there, and limits.h and move *MAX there as well if we want to
> support this. I'm not necessarily against this, it's just that we need
> to be consistent.

We would have to, *iff* the goal is to provide *all* headers in nolibc.
May goal was more limited:
nolibc should be self-contained, it should be able to work at all
with -nostdinc.
If users need more standard headers for their application they can add
those either as shim, custom implementation or from the compiler.

> Also something is puzzling me. If a normal program builds with -nostdinc,
> it means it does *not* want the libc's (nor the compiler's) headers to be
> included, probably because it comes with its own. In this case why would
> we impose ours ? For example, let's consider this tiny code snippet:
> 
>   $ cat arg.c
>   #include <stdarg.h>
>   va_list blah;
> 
>   $ gcc -c arg.c 
>   $ gcc -nostdinc -c arg.c
>   arg.c:1:20: error: no include path in which to search for stdarg.h
>       1 | #include <stdarg.h>
>         |                    ^
>   arg.c:2:1: error: unknown type name 'va_list'
>       2 | va_list blah;
>         | ^~~~~~~
>   arg.c:1:1: note: 'va_list' is defined in header '<stdarg.h>'; did you forget to '#include <stdarg.h>'?
>     +++ |+#include <stdarg.h>
>       1 | #include <stdarg.h>
>  
> You see, that's why I'm finding it confusing that we define headers that
> are supposed *not* to be defined with -nostdinc.

I'm confused.

If the user doesn't want to use nolibc they should not explicitly add it
to the include path.

> I think we need to carefully check what is supposed to be defined and
> what not when -nostdinc is used normally so that we defined what programs
> expect and not what they expect us *not* to define. Recently we've been
> empirically fixing nolibc-test build failures but it's just a test program
> that comes with its own biases. Maybe trying to build some portable libs
> that use very little from a libc (e.g. xxhash, liblzo etc) could give us
> some hints about certain basic assumptions that we do not fulfill.

It makes sense to figure out what is needed by larger projects from a
libc. But it feels to me like a bug vs. feature discussion.

Making larger real-world applications work is a feature while making the
following work is a bugfix:

$ cat nolibc.c
#include "nolibc.h"

int main(void)
{
	return 0;
}

$ gcc -nostdinc -Isysroot/x86/include -c nolibc.c
In file included from sysroot/x86/include/nolibc.h:98,
                 from nolibc-test.c:1:
sysroot/x86/include/sys.h:10:10: fatal error: stdarg.h: No such file or directory
   10 | #include <stdarg.h>
      |          ^~~~~~~~~~

> > One usecase is in nolibc-test itself, where Zhangjin ran into weird
> > and inconsistent behavior of system includes being pulled in.
> > By using -nostdinc we avoid this.
> 
> I see but a normal libc ought not to build with -nostdinc. I mean, we
> can define whatever we want once we know why we're doing it, but I think
> that as long as we find it confusing between those how are modifying this
> code, it will be very difficult to explain correctly to users. We're
> definitely missing some design rules I think. Maybe -nostdinc should be
> needed only when using -include nolibc.h for example, I don't know, but
> I still find that we're papering over a wider problem.
> 
> > I can also see this being useful for normal users.
> 
> I agree, that's also my concern actually.
> 
> > > > I could not find anybody doing this differently.
> > > > Using builtins seems to me to be the normal way to expose compiler
> > > > implementation specifics.
> > > 
> > > OK but it's already what the compiler does itself in its own stdarg that
> > > is provided. That's why I don't understand what specific case we're trying
> > > to cover here, I feel like we're providing an alternate stdarg in case the
> > > compiler doesn't provide one except that I've not seen a compiler not
> > > provide it (even tcc comes with it), it's like stddef.
> > 
> > It's all about supporting -nostdinc.
> 
> But unless I'm mistaken (and my example above seems to support this),
> a normal libc doesn't build with -nostdinc. That's the point I'd like
> us to clarify.

musl:

$ cat /usr/lib/musl/lib/musl-gcc.specs
...
*cc1:
%(cc1_cpu) -nostdinc -isystem /usr/lib/musl/include -isystem include%s
...


dietlibc:

$ cat Makefile
...
DEFAULTCFLAGS=-pipe -nostdinc -D_REENTRANT $(EXTRACFLAGS)
...


klibc re-adds the compilers include path,
This is an alternative we could also use:

$ cat Makefile
...
NOSTDINC_FLAGS := -nostdlib -nostdinc -isystem $(shell $(CC) -print-file-name=include)
...

(these are all I checked)

> > FYI stdint.h is also provided by nolibc, gcc and glibc.
> 
> True but that one didn't surprise me because it came with C99 and was
> usually shipped by the libc when compilers targetting previous versions
> were used, so I didn't see this as a replacement for the compiler's
> definition actually.
> 
> I don't know what dictates what goes in the compiler and what in the
> libc.  I'm fine with having to redefine everything that's missing if
> that's needed, but as indicated above, stddef.h and limits.h are
> missing despite being quite common.

I think it's not really clearly defined what goes where.

There was also a longer discussion on LKML about linux/stdarg.h [0]

The gcc authors argue that Linux should not ship a custom stdarg.h.
But in reality Linux, musl, dietlibc (and probably some more) today are
shipping their own stdarg.h.

> We have an interesting comment at the top of nolibc.h which says:
> 
>  * The available standard (but limited) include files are:
>  *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h

This is out of date. It's missing signal.h, stdint.h, unistd.h.

>  *
>  * In addition, the following ones are expected to be provided by the compiler:
>  *   float.h, stdarg.h, stddef.h

What does "expected" mean here?
nolibc itself is perfectly fine without float.h and stddef.h.

>  *
>  * The following ones which are part to the C standard are not provided:
>  *   assert.h, locale.h, math.h, setjmp.h, limits.h

While true, a lot of other headers are also not provided.

> I think I draw the line based on what my compilers have always provided.
> That's definitely something we can redefine (and update the comment),
> I'm just seeking consistency, and I think you can understand :-/

I do understand.

To reiterate it here explicitly, in my opinion it's a worthwhile and
consistent goal to make "nolibc usable standalone with -nostdinc" for
maximal control by the user.

If not, I'd like to use the "-nostdinc -I$(cc -print-file-name=include)"
method to avoid dependencies on system header for nolibc-test
specifically.

Thomas

[0] https://lore.kernel.org/lkml/CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com/
