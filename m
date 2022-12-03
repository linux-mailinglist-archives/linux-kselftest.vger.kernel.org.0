Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C06412C2
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiLCArv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 19:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiLCAr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 19:47:28 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBD10CB40;
        Fri,  2 Dec 2022 16:41:02 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id e2-20020a4ac3c2000000b004a092c9ddecso507871ooq.13;
        Fri, 02 Dec 2022 16:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgtFpNRH5AFLrx9UWVJAkL2FwXwekeUpezsVyYLL5Sc=;
        b=T9hc+jnDeHfGqmnI60UPi73AzAq5K0iH23yDAt+ql5SovUeP1UNaHI2a+GsHtBfLOa
         hMOQPvm1FIVjSs524eEp/yP//EGhUsInpNWW5CE25g26pnEo9+4PqwR151+iBU7+QjH6
         xnKpi5v8wO2Fawu1Q8iqPd6+8PgHe0r9qf1ggiua7JZ6ElJaUPHOC0dLXZt8vp7rU4eD
         fWCmN12jAZ31Kl+59DogGXuZQP5ahwnZ4suyR6bDPV0y6QAnNn2fL4EquFsISXE8hFvR
         IyEGRzVrqTG6wXn4qSjp2ipw5VPZvGWapAYZfWRL58e5BZoPMWmerzYG1nmifpjBf0p7
         dyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgtFpNRH5AFLrx9UWVJAkL2FwXwekeUpezsVyYLL5Sc=;
        b=dQl7lkodPp5vzoR5d2ZKtO1k1FAYJjDbrDS/SXDRGgMAlE1VY7QXl3yJO+Wd1bOEtQ
         tWavkrAWMs3pFa6FmrX7JBLAWKGS4v3AmlZw6ikLE7nd74aHicVqIGgE0BWvKTEtLOCx
         s3qlM0AnkVH9YhiJzbsR2hQVPfwQSSdnc3YZ0vGPJRtyFPKsJS5Y2JJp8m5sjjRF1/iv
         4qyp/ubT0l2yngw5Y9pqWmjS/saiwUcLhMn05vYnrYBLxdDCMcyqnwU05qVKJEnM3M+z
         rMm48hy88KeEWOluBJ29rhhZQ8s7iYT0IkCyTFHbtD+DLx52JgzAhGZCvRXoy+k6ifsj
         IG5Q==
X-Gm-Message-State: ANoB5pmJJH8vD5gYq8IKqHyy5XeKiI8Ugl2UUwvvpPXTZP0HoHq31hBB
        JteeBii8TvTbmv60eV65NT4cJOzeQhxSOz6WIOI=
X-Google-Smtp-Source: AA0mqf59EO8Jhf8nVuUwbNPV9lpUW5YNjz4AxWYOID4n4XwvJsBv1uRmt9o9VJZyylsUNus8xDOcCLc1qvyLICtMUn8=
X-Received: by 2002:a4a:ab4a:0:b0:480:7fd1:1875 with SMTP id
 j10-20020a4aab4a000000b004807fd11875mr23464626oon.24.1670028061923; Fri, 02
 Dec 2022 16:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20220826012614.552860-1-james.hilliard1@gmail.com>
 <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com>
 <CADvTj4p8pykr4Vy-YSLcaXsfmuWAmZ9ay-np6mxTdwOT1LBnXw@mail.gmail.com> <CAEf4BzbhH9DtBsen8x9BUrAZy0d-osK57Zg=Cor-BmLyvAX+jg@mail.gmail.com>
In-Reply-To: <CAEf4BzbhH9DtBsen8x9BUrAZy0d-osK57Zg=Cor-BmLyvAX+jg@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 2 Dec 2022 20:40:50 -0400
Message-ID: <CADvTj4qrNnrqfDxPTyjMQ2ezs5BRouuLE9961bSbdtkAAXoZrA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 1:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Aug 27, 2022 at 3:47 AM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 10:55 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Aug 25, 2022 at 6:26 PM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > >
> > > > Both tolower and toupper are built in c functions, we should not
> > >
> > > Really? How come? Can you point out where this is specified in C
> > > standard? From what I can tell you have to include <ctype.h> to get
> > > toupper()/tolower().
> >
> > See background on this sort of issue:
> > https://stackoverflow.com/a/20582607
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=12213
> >
> > (C99, 7.1.3p1) "All identifiers with external linkage in any of the following
> > subclauses (including the future library directions) are always reserved
> > for use as identifiers with external linkage."
> >
>
> Sigh, ok. Ghost functions: you can't use them without ctype.h, but you
> can't define your own either. Very nice.
>
> Can you please put all these details into a commit for the future? With that:

Sure

>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Is this good to apply or should I send a v2?

>
> > >
> > > This seems like yet another GCC-BPF quirk?
> >
> > Seems GCC takes a stricter interpretation of the standard here than
> > llvm.
> >
> > It's also documented behavior in GCC:
> > https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-std-2
> >
> > See:
> > The ISO C90 functions abort, abs, acos, asin, atan2, atan, calloc, ceil,
> > cosh, cos, exit, exp, fabs, floor, fmod, fprintf, fputs, free, frexp, fscanf,
> > isalnum, isalpha, iscntrl, isdigit, isgraph, islower, isprint, ispunct, isspace,
> > isupper, isxdigit, tolower, toupper, labs, ldexp, log10, log, malloc, memchr,
> > memcmp, memcpy, memset, modf, pow, printf, putchar, puts, realloc,
> > scanf, sinh, sin, snprintf, sprintf, sqrt, sscanf, strcat, strchr,
> > strcmp, strcpy,
> > strcspn, strlen, strncat, strncmp, strncpy, strpbrk, strrchr, strspn, strstr,
> > tanh, tan, vfprintf, vprintf and vsprintf are all recognized as
> > built-in functions
> > unless -fno-builtin is specified (or -fno-builtin-function is specified for an
> > individual function).
> >
> > We could disable builtin functions but it seems more correct to just
> > rename it so that it doesn't conflict.
> >
> > >
> > > > redefine them as this can result in a build error.
> > > >
> > > > Fixes the following errors:
> > > > progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > > >    10 | static inline char tolower(char c)
> > > >       |                    ^~~~~~~
> > > > progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
> > > >     4 | #include <bpf/bpf_helpers.h>
> > > >   +++ |+#include <ctype.h>
> > > >     5 |
> > > > progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > > >    17 | static inline char toupper(char c)
> > > >       |                    ^~~~~~~
> > > > progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
> > > >
> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > index 285c008cbf9c..9ba14c37bbcc 100644
> > > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > @@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
> > > >
> > > >  unsigned long last_sym_value = 0;
> > > >
> > > > -static inline char tolower(char c)
> > > > +static inline char to_lower(char c)
> > > >  {
> > > >         if (c >= 'A' && c <= 'Z')
> > > >                 c += ('a' - 'A');
> > > >         return c;
> > > >  }
> > > >
> > > > -static inline char toupper(char c)
> > > > +static inline char to_upper(char c)
> > > >  {
> > > >         if (c >= 'a' && c <= 'z')
> > > >                 c -= ('a' - 'A');
> > > > @@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
> > > >         type = iter->type;
> > > >
> > > >         if (iter->module_name[0]) {
> > > > -               type = iter->exported ? toupper(type) : tolower(type);
> > > > +               type = iter->exported ? to_upper(type) : to_lower(type);
> > > >                 BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
> > > >                                value, type, iter->name, iter->module_name);
> > > >         } else {
> > > > --
> > > > 2.34.1
> > > >
