Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CEF78C3FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjH2MNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjH2MNK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 08:13:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696AF1BF;
        Tue, 29 Aug 2023 05:13:03 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37TCCjUv015120;
        Tue, 29 Aug 2023 14:12:45 +0200
Date:   Tue, 29 Aug 2023 14:12:45 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: add stdarg.h header
Message-ID: <ZO3gvcoe8wZM+f5A@1wt.eu>
References: <20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net>
 <20230827-nolibc-nostdinc-v1-1-995d1811f1f3@weissschuh.net>
 <ZO2QC/fw6LKdtLSb@1wt.eu>
 <2b6c62f1-c1f1-4f2c-ba0c-981e066f4268@t-8ch.de>
 <ZO25u3crGixkGKWe@1wt.eu>
 <b2c2ca69-b9bb-40b1-a05a-6d2f66e01034@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2c2ca69-b9bb-40b1-a05a-6d2f66e01034@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 29, 2023 at 12:16:23PM +0200, Thomas Weißschuh wrote:
> > OK. But then, doesn't it mean that if we don't provide our stdarg.h,
> > the compilers' will be used ? I'm asking because we're already using
> > va_list and va_args, for example in vfprintf() in stdio.h, which
> > precisely includes <stdarg.h> so it must indeed come from the compiler.
> 
> It will be used *iff* -nostdinc is *not* passed.
> 
> I think we need to clarify the definition of the word "provided".
> For me it means that the compiler ships an implementation of this header
> file in the compiler-specific include directory.
> 
> If -nostdinc is passed this include directory is not actually usable.

OK I understand better now. I thought it was always usable.

> If a user wants to avoid the implicit usage of any system-provided
> headers they need to pass -nostdinc, as far as I know there is no flag
> to keep only the compiler-specific include directories.

So that means we may also have to implement our own stddef.h to move
size_t there, and limits.h and move *MAX there as well if we want to
support this. I'm not necessarily against this, it's just that we need
to be consistent.

Also something is puzzling me. If a normal program builds with -nostdinc,
it means it does *not* want the libc's (nor the compiler's) headers to be
included, probably because it comes with its own. In this case why would
we impose ours ? For example, let's consider this tiny code snippet:

  $ cat arg.c
  #include <stdarg.h>
  va_list blah;

  $ gcc -c arg.c 
  $ gcc -nostdinc -c arg.c
  arg.c:1:20: error: no include path in which to search for stdarg.h
      1 | #include <stdarg.h>
        |                    ^
  arg.c:2:1: error: unknown type name 'va_list'
      2 | va_list blah;
        | ^~~~~~~
  arg.c:1:1: note: 'va_list' is defined in header '<stdarg.h>'; did you forget to '#include <stdarg.h>'?
    +++ |+#include <stdarg.h>
      1 | #include <stdarg.h>
 
You see, that's why I'm finding it confusing that we define headers that
are supposed *not* to be defined with -nostdinc.

I think we need to carefully check what is supposed to be defined and
what not when -nostdinc is used normally so that we defined what programs
expect and not what they expect us *not* to define. Recently we've been
empirically fixing nolibc-test build failures but it's just a test program
that comes with its own biases. Maybe trying to build some portable libs
that use very little from a libc (e.g. xxhash, liblzo etc) could give us
some hints about certain basic assumptions that we do not fulfill.

> One usecase is in nolibc-test itself, where Zhangjin ran into weird
> and inconsistent behavior of system includes being pulled in.
> By using -nostdinc we avoid this.

I see but a normal libc ought not to build with -nostdinc. I mean, we
can define whatever we want once we know why we're doing it, but I think
that as long as we find it confusing between those how are modifying this
code, it will be very difficult to explain correctly to users. We're
definitely missing some design rules I think. Maybe -nostdinc should be
needed only when using -include nolibc.h for example, I don't know, but
I still find that we're papering over a wider problem.

> I can also see this being useful for normal users.

I agree, that's also my concern actually.

> > > I could not find anybody doing this differently.
> > > Using builtins seems to me to be the normal way to expose compiler
> > > implementation specifics.
> > 
> > OK but it's already what the compiler does itself in its own stdarg that
> > is provided. That's why I don't understand what specific case we're trying
> > to cover here, I feel like we're providing an alternate stdarg in case the
> > compiler doesn't provide one except that I've not seen a compiler not
> > provide it (even tcc comes with it), it's like stddef.
> 
> It's all about supporting -nostdinc.

But unless I'm mistaken (and my example above seems to support this),
a normal libc doesn't build with -nostdinc. That's the point I'd like
us to clarify.

> FYI stdint.h is also provided by nolibc, gcc and glibc.

True but that one didn't surprise me because it came with C99 and was
usually shipped by the libc when compilers targetting previous versions
were used, so I didn't see this as a replacement for the compiler's
definition actually.

I don't know what dictates what goes in the compiler and what in the
libc.  I'm fine with having to redefine everything that's missing if
that's needed, but as indicated above, stddef.h and limits.h are
missing despite being quite common.

We have an interesting comment at the top of nolibc.h which says:

 * The available standard (but limited) include files are:
 *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h
 *
 * In addition, the following ones are expected to be provided by the compiler:
 *   float.h, stdarg.h, stddef.h
 *
 * The following ones which are part to the C standard are not provided:
 *   assert.h, locale.h, math.h, setjmp.h, limits.h

I think I draw the line based on what my compilers have always provided.
That's definitely something we can redefine (and update the comment),
I'm just seeking consistency, and I think you can understand :-/

Thanks,
Willy
