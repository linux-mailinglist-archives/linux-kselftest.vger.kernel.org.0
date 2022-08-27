Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA965A3922
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiH0RIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiH0RIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 13:08:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3628E01;
        Sat, 27 Aug 2022 10:08:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p16so5208345ejb.9;
        Sat, 27 Aug 2022 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t4YmsgZLUK6Kxn6VegF+FGswxULfoRLmy+ksomEpPk4=;
        b=ZKU21KdzTtXtLA9di6gzcMDcX2ETEJPS13mtDfhiEgM2J5DoIyyw9Wa9jPe2lSGavz
         L8eSIv5+gebaIX3er/lZ1kE5L8XRKV+F9QN6X1yBXLKS8qtuJp+ZpdAI63dOMJ4K73+7
         KViv2t0utlkCvN8aavffv9NBJuzXDB+iUoR13pbSGJBYsOay41NAGdFni9xUK69tgTeK
         hY5T9EAkkjcBJt6WBJlFHPNNDKoUC5MM1u8IAnm/Vw5bQD3mj+wgJsCJNIqKhsHzcWcv
         BOEzoZl/v8bchmhyL4KrX9f/PZiBOSyNUu3D6lF+ltazStOlwZLIjY4lWrRkuojmW4OO
         bhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t4YmsgZLUK6Kxn6VegF+FGswxULfoRLmy+ksomEpPk4=;
        b=3zwDD7/K37PNwltOyBJQaqRlposehilIYUu7HeTHidCkhMaX8hkcq+Wk5iLedeiZoN
         fjpJrkLiiZh27lD9uueLZrG1wWSGmTvvCi/kddPayFO03A5j2XReXalrmYX4LlhX0UZ4
         MddZBd3rCZpT4KE7t9TUI77XiP5FQsapCfFvrI/m5Cp+uM79PyQ0epvEI9KW5f9vWHmu
         lUoVghi+c3HuHtI/sQ16I09B6+ji+Hu3ry6w0nswQmt7PijanxYbkpmwZ7jnJJoORzlV
         OXOGEjUh+2SHciuAUHRbX/UMgcWyx2XHmpVklt2V/SjNfA3OunUW75ZzcgOpjCkQx5ZE
         QLXA==
X-Gm-Message-State: ACgBeo0PqaPVrnBOf0Opv5eQaUQRY9PFGLd5AxEKE996CQlyBrsXUbMV
        C8lQe/+vWpbVimGM5Q8xegpzfsvzOwQY3Ki56X0=
X-Google-Smtp-Source: AA6agR4l07uJ6t4lzIZsEsYOwVV3Irrndpss4hUt0gz6altEgoD/VcZ/GxY4d5l6POfslTN3rN2Iw1ax08lCREdWviM=
X-Received: by 2002:a17:907:2bdb:b0:73d:d7af:c133 with SMTP id
 gv27-20020a1709072bdb00b0073dd7afc133mr7496212ejc.545.1661620128476; Sat, 27
 Aug 2022 10:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220826012614.552860-1-james.hilliard1@gmail.com>
 <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com> <CADvTj4p8pykr4Vy-YSLcaXsfmuWAmZ9ay-np6mxTdwOT1LBnXw@mail.gmail.com>
In-Reply-To: <CADvTj4p8pykr4Vy-YSLcaXsfmuWAmZ9ay-np6mxTdwOT1LBnXw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Aug 2022 10:08:37 -0700
Message-ID: <CAEf4BzbhH9DtBsen8x9BUrAZy0d-osK57Zg=Cor-BmLyvAX+jg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 3:47 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 10:55 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 6:26 PM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > Both tolower and toupper are built in c functions, we should not
> >
> > Really? How come? Can you point out where this is specified in C
> > standard? From what I can tell you have to include <ctype.h> to get
> > toupper()/tolower().
>
> See background on this sort of issue:
> https://stackoverflow.com/a/20582607
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=12213
>
> (C99, 7.1.3p1) "All identifiers with external linkage in any of the following
> subclauses (including the future library directions) are always reserved
> for use as identifiers with external linkage."
>

Sigh, ok. Ghost functions: you can't use them without ctype.h, but you
can't define your own either. Very nice.

Can you please put all these details into a commit for the future? With that:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> >
> > This seems like yet another GCC-BPF quirk?
>
> Seems GCC takes a stricter interpretation of the standard here than
> llvm.
>
> It's also documented behavior in GCC:
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-std-2
>
> See:
> The ISO C90 functions abort, abs, acos, asin, atan2, atan, calloc, ceil,
> cosh, cos, exit, exp, fabs, floor, fmod, fprintf, fputs, free, frexp, fscanf,
> isalnum, isalpha, iscntrl, isdigit, isgraph, islower, isprint, ispunct, isspace,
> isupper, isxdigit, tolower, toupper, labs, ldexp, log10, log, malloc, memchr,
> memcmp, memcpy, memset, modf, pow, printf, putchar, puts, realloc,
> scanf, sinh, sin, snprintf, sprintf, sqrt, sscanf, strcat, strchr,
> strcmp, strcpy,
> strcspn, strlen, strncat, strncmp, strncpy, strpbrk, strrchr, strspn, strstr,
> tanh, tan, vfprintf, vprintf and vsprintf are all recognized as
> built-in functions
> unless -fno-builtin is specified (or -fno-builtin-function is specified for an
> individual function).
>
> We could disable builtin functions but it seems more correct to just
> rename it so that it doesn't conflict.
>
> >
> > > redefine them as this can result in a build error.
> > >
> > > Fixes the following errors:
> > > progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > >    10 | static inline char tolower(char c)
> > >       |                    ^~~~~~~
> > > progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
> > >     4 | #include <bpf/bpf_helpers.h>
> > >   +++ |+#include <ctype.h>
> > >     5 |
> > > progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> > >    17 | static inline char toupper(char c)
> > >       |                    ^~~~~~~
> > > progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > index 285c008cbf9c..9ba14c37bbcc 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > > @@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
> > >
> > >  unsigned long last_sym_value = 0;
> > >
> > > -static inline char tolower(char c)
> > > +static inline char to_lower(char c)
> > >  {
> > >         if (c >= 'A' && c <= 'Z')
> > >                 c += ('a' - 'A');
> > >         return c;
> > >  }
> > >
> > > -static inline char toupper(char c)
> > > +static inline char to_upper(char c)
> > >  {
> > >         if (c >= 'a' && c <= 'z')
> > >                 c -= ('a' - 'A');
> > > @@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
> > >         type = iter->type;
> > >
> > >         if (iter->module_name[0]) {
> > > -               type = iter->exported ? toupper(type) : tolower(type);
> > > +               type = iter->exported ? to_upper(type) : to_lower(type);
> > >                 BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
> > >                                value, type, iter->name, iter->module_name);
> > >         } else {
> > > --
> > > 2.34.1
> > >
