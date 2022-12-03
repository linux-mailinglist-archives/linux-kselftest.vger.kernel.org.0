Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11036412D6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 01:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiLCAzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 19:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiLCAyf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 19:54:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A418B1FB;
        Fri,  2 Dec 2022 16:53:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fc4so8224749ejc.12;
        Fri, 02 Dec 2022 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCAULVZ3kXh3arFt940euBarohCCAdayTSGVr11UNQE=;
        b=o1UYvdMwwEDE3C8NpaeVcrWPOlcHesZjhpAL2qKoF7Zowpb/3VstnMBHy7bmeQt93K
         A5xqoq/9cXrWv+lQl5AVP1s1cO3kwnr6Hm7vpKLlz1PA3cbi2w8h6SyuGrVV7pDna2wP
         MdNQwp7QOPYavOIZysXnAZvrtAiHwXusFnDVIYizoS3qtTBdsbAjBqMcF8XI1dAkCV1j
         XUnJ9EPjfCMZbpBDVNmXENkdiQ1nCbeNV2q9MXdLFgqJ5/bWUOaMYPoIqfLqbgL8oidf
         7QQSxuLnWau9qcMyx2hPBFapgIzbs05X+AbRs58IP2kZApKmCWdSmJgBUPfVA/kgORPk
         0D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCAULVZ3kXh3arFt940euBarohCCAdayTSGVr11UNQE=;
        b=vcXviy86SwG/FivDH7UQCOR7Q2I94dTzZI88bsNbutB0Shb4b7Cwg5tHkHAIvCVFXu
         TnGQGWJzBcjld/cvph0GZ2q2qFknrVsVttcxOQmsYogf74+M+6K5IFVLH2T5X/dsFxi/
         TC5w/szu0k5YGeoMzHq0MNLy1+X3g4FvZ21szzH9AJB3BRTSOv3ZGMCmSfMZuRebs+6N
         CwKwRZ0LFu5ZKbeTf00KRg8DSaf4oIiDcY1LNvM6TwhV6ST45sHpkg8IqjluuB4CBYJt
         rjZxPiFeJ8OGwUWEN3y3Mf02d/SzvoMoK8D9f8c8GQOiQM9pA5qbOFxURa9LoTdDq4CI
         8hMQ==
X-Gm-Message-State: ANoB5pkyxe5MvP/qA+JNqoQO6+lw7N1OxX8wrT73AtKdljnvDO+HE0OJ
        30+DbtkLc8EW6XPEp96QRTy6/CbTtfRZotQoHZA=
X-Google-Smtp-Source: AA0mqf5bomkE/+53IaY5j6ZsOzruwSTr4Og0SeFLtALu0xcg9797psXGWRcqGdRsncDXw3JHfdW9Jk05pMjSczPeGb8=
X-Received: by 2002:a17:906:414c:b0:7a9:ecc1:2bd2 with SMTP id
 l12-20020a170906414c00b007a9ecc12bd2mr50745008ejk.545.1670028837001; Fri, 02
 Dec 2022 16:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20220826012614.552860-1-james.hilliard1@gmail.com>
 <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com>
 <CADvTj4p8pykr4Vy-YSLcaXsfmuWAmZ9ay-np6mxTdwOT1LBnXw@mail.gmail.com>
 <CAEf4BzbhH9DtBsen8x9BUrAZy0d-osK57Zg=Cor-BmLyvAX+jg@mail.gmail.com> <CADvTj4qrNnrqfDxPTyjMQ2ezs5BRouuLE9961bSbdtkAAXoZrA@mail.gmail.com>
In-Reply-To: <CADvTj4qrNnrqfDxPTyjMQ2ezs5BRouuLE9961bSbdtkAAXoZrA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Dec 2022 16:53:44 -0800
Message-ID: <CAEf4BzYru_TVNjh4+brf_6akL+WyozTQtxz=RoR1eLvXy49xpw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
To:     James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 2, 2022 at 4:41 PM James Hilliard <james.hilliard1@gmail.com> wrote:
>
> On Sat, Aug 27, 2022 at 1:08 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Aug 27, 2022 at 3:47 AM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 10:55 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Aug 25, 2022 at 6:26 PM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > Both tolower and toupper are built in c functions, we should not
> > > >
> > > > Really? How come? Can you point out where this is specified in C
> > > > standard? From what I can tell you have to include <ctype.h> to get
> > > > toupper()/tolower().
> > >
> > > See background on this sort of issue:
> > > https://stackoverflow.com/a/20582607
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=12213
> > >
> > > (C99, 7.1.3p1) "All identifiers with external linkage in any of the following
> > > subclauses (including the future library directions) are always reserved
> > > for use as identifiers with external linkage."
> > >
> >
> > Sigh, ok. Ghost functions: you can't use them without ctype.h, but you
> > can't define your own either. Very nice.
> >
> > Can you please put all these details into a commit for the future? With that:
>
> Sure
>
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Is this good to apply or should I send a v2?

please add those details and resend v2?

>
> >
> > > >
> > > > This seems like yet another GCC-BPF quirk?
> > >
> > > Seems GCC takes a stricter interpretation of the standard here than
> > > llvm.
> > >
> > > It's also documented behavior in GCC:
> > > https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-std-2
> > >
> > > See:
> > > The ISO C90 functions abort, abs, acos, asin, atan2, atan, calloc, ceil,
> > > cosh, cos, exit, exp, fabs, floor, fmod, fprintf, fputs, free, frexp, fscanf,
> > > isalnum, isalpha, iscntrl, isdigit, isgraph, islower, isprint, ispunct, isspace,
> > > isupper, isxdigit, tolower, toupper, labs, ldexp, log10, log, malloc, memchr,
> > > memcmp, memcpy, memset, modf, pow, printf, putchar, puts, realloc,
> > > scanf, sinh, sin, snprintf, sprintf, sqrt, sscanf, strcat, strchr,
> > > strcmp, strcpy,
> > > strcspn, strlen, strncat, strncmp, strncpy, strpbrk, strrchr, strspn, strstr,
> > > tanh, tan, vfprintf, vprintf and vsprintf are all recognized as
> > > built-in functions
> > > unless -fno-builtin is specified (or -fno-builtin-function is specified for an
> > > individual function).
> > >
> > > We could disable builtin functions but it seems more correct to just
> > > rename it so that it doesn't conflict.
> > >
> > > >
> > > > > redefine them as this can result in a build error.
> > > > >
> > > > > Fixes the following errors:
> > > > > progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > > > >    10 | static inline char tolower(char c)
> > > > >       |                    ^~~~~~~
> > > > > progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
> > > > >     4 | #include <bpf/bpf_helpers.h>
> > > > >   +++ |+#include <ctype.h>
> > > > >     5 |
> > > > > progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > > > >    17 | static inline char toupper(char c)
> > > > >       |                    ^~~~~~~
> > > > > progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
> > > > >
> > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > > index 285c008cbf9c..9ba14c37bbcc 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > > > @@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
> > > > >
> > > > >  unsigned long last_sym_value = 0;
> > > > >
> > > > > -static inline char tolower(char c)
> > > > > +static inline char to_lower(char c)
> > > > >  {
> > > > >         if (c >= 'A' && c <= 'Z')
> > > > >                 c += ('a' - 'A');
> > > > >         return c;
> > > > >  }
> > > > >
> > > > > -static inline char toupper(char c)
> > > > > +static inline char to_upper(char c)
> > > > >  {
> > > > >         if (c >= 'a' && c <= 'z')
> > > > >                 c -= ('a' - 'A');
> > > > > @@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
> > > > >         type = iter->type;
> > > > >
> > > > >         if (iter->module_name[0]) {
> > > > > -               type = iter->exported ? toupper(type) : tolower(type);
> > > > > +               type = iter->exported ? to_upper(type) : to_lower(type);
> > > > >                 BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
> > > > >                                value, type, iter->name, iter->module_name);
> > > > >         } else {
> > > > > --
> > > > > 2.34.1
> > > > >
