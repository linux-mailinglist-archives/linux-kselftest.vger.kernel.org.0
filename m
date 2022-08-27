Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA35A3716
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiH0Krd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0Krc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 06:47:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE1785B4;
        Sat, 27 Aug 2022 03:47:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f17so3846419pfk.11;
        Sat, 27 Aug 2022 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UiHwxXfvf1lDenWPgsX45rCLCR+OFcWjJxU/UZK7aIo=;
        b=N3jkl6qBfSNVLEFzksiBm1DIrDicLiM88RZroDY5uc2qA38yAEVblgA3G76oMG7d50
         x3M5Bl9JDfgliUFD5LjuksYya1DfUD+E8UGgOUGcNEYLJ/0HzEseNeVT3X6hYPWlpIZt
         4xHJOOnsSVyVi7fpzFxZSTcrx9xoeMXvExO9Mrht7bQRRyaUgq3iCJIOIoldSJXPmC8k
         w2NEcZBS75d1i7JSDHP2BaVrgQKRPKiH5ALpgt0S+ZZlzP3W86O52OwkY1JMimJnV8VF
         0mu9g7UcHPJpZnc/9L8i45TSdUU4nDMrvETKkxvbxHUCyBva7ZhZb6S9mKJSR5jNbUl0
         qYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UiHwxXfvf1lDenWPgsX45rCLCR+OFcWjJxU/UZK7aIo=;
        b=YxEad2+uEQlBhkmGMo9M14D1rj0wjp7XPHXiSe0uV9Hp/zEv2SaRsd5UFLV7V0eDyH
         becS9jVGgFZQ/Bn12sZEtqQx2+70aQ1Dwb1aSgbqAol9nPnqdJmYBScKRap2Qt0Ob96P
         hFSzL2UA40LiWiWevrGetHAMAB8Sf7u6NolzC+Trxby58FF67PIRd7AEKL7m8FrddOO1
         QcBLIKqrcDdYOGVVdY1CflKjgeFNxhR3W33qJlI+ORDNrfMXLCuNVfNfvYS+c6K74UQG
         4n+cd1lSmPDUuOjZHpDTwQbT0D/rPYZJxp+dPJBuPjhl4anVjlWs2kv3bLHx+HESTTxd
         Uc4Q==
X-Gm-Message-State: ACgBeo2jGS7NJUcG72PDMaNFuGGQ8i3WRopJ/zLb7DyKrM0u194c5MZI
        aGnswh0mSWWLtdWC4XtmtIt50+MRVmgh+puw1e0=
X-Google-Smtp-Source: AA6agR49sEvqpMA2cK1Xwqyg1sP2oY2XiyKOFpintjr1QcEOsgqXyRFQYnpvPbDjpRDr7tnp0yFrlagsFv1Me4W/UcI=
X-Received: by 2002:a65:6944:0:b0:41b:4483:35cc with SMTP id
 w4-20020a656944000000b0041b448335ccmr6796918pgq.296.1661597247459; Sat, 27
 Aug 2022 03:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220826012614.552860-1-james.hilliard1@gmail.com> <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com>
In-Reply-To: <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sat, 27 Aug 2022 04:47:14 -0600
Message-ID: <CADvTj4p8pykr4Vy-YSLcaXsfmuWAmZ9ay-np6mxTdwOT1LBnXw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 10:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 25, 2022 at 6:26 PM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > Both tolower and toupper are built in c functions, we should not
>
> Really? How come? Can you point out where this is specified in C
> standard? From what I can tell you have to include <ctype.h> to get
> toupper()/tolower().

See background on this sort of issue:
https://stackoverflow.com/a/20582607
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=12213

(C99, 7.1.3p1) "All identifiers with external linkage in any of the following
subclauses (including the future library directions) are always reserved
for use as identifiers with external linkage."

>
> This seems like yet another GCC-BPF quirk?

Seems GCC takes a stricter interpretation of the standard here than
llvm.

It's also documented behavior in GCC:
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-std-2

See:
The ISO C90 functions abort, abs, acos, asin, atan2, atan, calloc, ceil,
cosh, cos, exit, exp, fabs, floor, fmod, fprintf, fputs, free, frexp, fscanf,
isalnum, isalpha, iscntrl, isdigit, isgraph, islower, isprint, ispunct, isspace,
isupper, isxdigit, tolower, toupper, labs, ldexp, log10, log, malloc, memchr,
memcmp, memcpy, memset, modf, pow, printf, putchar, puts, realloc,
scanf, sinh, sin, snprintf, sprintf, sqrt, sscanf, strcat, strchr,
strcmp, strcpy,
strcspn, strlen, strncat, strncmp, strncpy, strpbrk, strrchr, strspn, strstr,
tanh, tan, vfprintf, vprintf and vsprintf are all recognized as
built-in functions
unless -fno-builtin is specified (or -fno-builtin-function is specified for an
individual function).

We could disable builtin functions but it seems more correct to just
rename it so that it doesn't conflict.

>
> > redefine them as this can result in a build error.
> >
> > Fixes the following errors:
> > progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> >    10 | static inline char tolower(char c)
> >       |                    ^~~~~~~
> > progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
> >     4 | #include <bpf/bpf_helpers.h>
> >   +++ |+#include <ctype.h>
> >     5 |
> > progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
> >    17 | static inline char toupper(char c)
> >       |                    ^~~~~~~
> > progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > index 285c008cbf9c..9ba14c37bbcc 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> > @@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
> >
> >  unsigned long last_sym_value = 0;
> >
> > -static inline char tolower(char c)
> > +static inline char to_lower(char c)
> >  {
> >         if (c >= 'A' && c <= 'Z')
> >                 c += ('a' - 'A');
> >         return c;
> >  }
> >
> > -static inline char toupper(char c)
> > +static inline char to_upper(char c)
> >  {
> >         if (c >= 'a' && c <= 'z')
> >                 c -= ('a' - 'A');
> > @@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
> >         type = iter->type;
> >
> >         if (iter->module_name[0]) {
> > -               type = iter->exported ? toupper(type) : tolower(type);
> > +               type = iter->exported ? to_upper(type) : to_lower(type);
> >                 BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
> >                                value, type, iter->name, iter->module_name);
> >         } else {
> > --
> > 2.34.1
> >
