Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C698C17D837
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 03:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgCICxv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Mar 2020 22:53:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45988 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCICxu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Mar 2020 22:53:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so2126297qke.12
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Mar 2020 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fflz0dbF95SRLCJa9BmtjYe8dALMPFL3ixEaVuWgBTI=;
        b=Q+d4a/NwdOzmQTP9T/7u84gaYO2OTe+RMvgrwHSoAldhidVjAQndvpIbvk9g8J5OYA
         f9ci1dquiVpYLsJAdB7xbxOphEAcriMyalC9NB4Qx4JygUD1+8oGbnGH1zWqe4kYtECL
         rrpVFrs8hVnyNukDbQ2TsxBGfn48qhcDM0VKG/Yz/6uDSDzcZYl/AgZZ30P1wDOVINhO
         qiQWdLvi1mM8pW3J+Zcgj2kQfskcEtqYsVaPD+5VyIb25/DFs+avp3a5dJHtB0NeEVUE
         YDXly3BMBbzs3FMpvc45aD7yr5oJsm1ftsspfTRfk6RNtLie5l9DB53aFG1tZUzwFqYv
         SQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fflz0dbF95SRLCJa9BmtjYe8dALMPFL3ixEaVuWgBTI=;
        b=OkFxxewkFDKWm5PH5rmiotJH8HbIKi2O+9OStfp4M7got70ZGebJsHhlLES0mhDQCs
         vTlnJ+GKdWUewcBpN6ukeE5KXCC1NVBNuyrwN8Ec/BKxP5F4pTzfVOkUEtiHknJHC7km
         kzVcG9hX///j3+X+mlInH0KBvp4LxgUPMO2/2VWGOgTufLi2TYBDRELNdN0VMi49YcdY
         VwMB3HVIvB86cKSBSzkNf0pkZD0I9LzAMD/hFW2XRs7AxjwhzjPwZeThx24V6IJ0SsdR
         XPgSyIvVICNXsXFy0W3YtUGtTjy8XC3AWBPGrG9jd0KyFOsvtLRS11hIODqUZE9hKoEm
         8BAA==
X-Gm-Message-State: ANhLgQ2Z5VShCQbeV7ABGnu8SMay7A8hJ5AL/bSS3ROlNghdIJjGfRuu
        4Qrr+9wyX+mrvt03Zo8IjdbFOMPCKG8DaaTZTZY7Rg==
X-Google-Smtp-Source: ADFU+vsJsag292BpHlNHbUSngaCqWX8YhLLt0zF71w+H1clhFtuHq4MA2iZjfJkNR6Jg9hYlcx6wEZBDfbYD/UZ9gqg=
X-Received: by 2002:a37:65d1:: with SMTP id z200mr13417705qkb.464.1583722428829;
 Sun, 08 Mar 2020 19:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com> <mhng-b7d41554-17f9-4303-82b7-6d576fc19a9a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-b7d41554-17f9-4303-82b7-6d576fc19a9a@palmerdabbelt-glaptop>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Mon, 9 Mar 2020 10:53:38 +0800
Message-ID: <CABvJ_xizO8p8uWj9D4R0LbjFYD9ChZJi9e_XyavTpGhOoDO=Vg@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: add support for restartable sequence
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 14, 2020 at 2:47 AM Palmer Dabbelt <palmerdabbelt@google.com> w=
rote:
>
> On Mon, 04 Nov 2019 17:58:31 PST (-0800), vincent.chen@sifive.com wrote:
> > Add RSEQ, restartable sequence, support and related selftest to RISCV.
> > The Kconfig option HAVE_REGS_AND_STACK_ACCESS_API is also required by
> > RSEQ because RSEQ will modify the content of pt_regs.sepc through
> > instruction_pointer_set() during the fixup procedure. In order to selec=
t
> > the config HAVE_REGS_AND_STACK_ACCESS_API, the missing APIs for accessi=
ng
> > pt_regs are also added in this patch set.
> >
> > The relevant RSEQ tests in kselftest require the Binutils patch "RISC-V=
:
> > Fix linker problems with TLS copy relocs" to avoid placing
> > PREINIT_ARRAY and TLS variable of librseq.so at the same address.
> > https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;a=3Dcommit;h=
=3D3e7bd7f24146f162565edf878840449f36a8d974
> > A segmental fault will happen if the Binutils misses this patch.
> >
> >
> >
> > Vincent Chen (3):
> >   riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_AP=
I
> >   riscv: Add support for restartable sequence
> >   rseq/selftests: Add support for riscv
> >
> >  arch/riscv/Kconfig                        |   2 +
> >  arch/riscv/include/asm/ptrace.h           |  29 +-
> >  arch/riscv/kernel/entry.S                 |   4 +
> >  arch/riscv/kernel/ptrace.c                |  99 +++++
> >  arch/riscv/kernel/signal.c                |   3 +
> >  tools/testing/selftests/rseq/param_test.c |  23 ++
> >  tools/testing/selftests/rseq/rseq-riscv.h | 622 ++++++++++++++++++++++=
++++++++
> >  tools/testing/selftests/rseq/rseq.h       |   2 +
> >  8 files changed, 783 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h
>
> This, with Paul's updated patch 1, isn't building on my end:
>
> In file included from <command-line>:
> arch/riscv/kernel/ptrace.c:137:18: error: =E2=80=98struct pt_regs=E2=80=
=99 has no member named =E2=80=98sepc=E2=80=99; did you mean =E2=80=98epc=
=E2=80=99?
>   REG_OFFSET_NAME(sepc),
>                   ^~~~
> ././include/linux/compiler_types.h:129:57: note: in definition of macro =
=E2=80=98__compiler_offsetof=E2=80=99
>  #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                                          ^
> arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro =E2=80=98o=
ffsetof=E2=80=99
>  #define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
>                                                    ^~~~~~~~
> arch/riscv/kernel/ptrace.c:137:2: note: in expansion of macro =E2=80=98RE=
G_OFFSET_NAME=E2=80=99
>   REG_OFFSET_NAME(sepc),
>   ^~~~~~~~~~~~~~~
> arch/riscv/kernel/ptrace.c:169:18: error: =E2=80=98struct pt_regs=E2=80=
=99 has no member named =E2=80=98sstatus=E2=80=99; did you mean =E2=80=98st=
atus=E2=80=99?
>   REG_OFFSET_NAME(sstatus),
>                   ^~~~~~~
> ././include/linux/compiler_types.h:129:57: note: in definition of macro =
=E2=80=98__compiler_offsetof=E2=80=99
>  #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                                          ^
> arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro =E2=80=98o=
ffsetof=E2=80=99
>  #define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
>                                                    ^~~~~~~~
> arch/riscv/kernel/ptrace.c:169:2: note: in expansion of macro =E2=80=98RE=
G_OFFSET_NAME=E2=80=99
>   REG_OFFSET_NAME(sstatus),
>   ^~~~~~~~~~~~~~~
> arch/riscv/kernel/ptrace.c:170:18: error: =E2=80=98struct pt_regs=E2=80=
=99 has no member named =E2=80=98sbadaddr=E2=80=99; did you mean =E2=80=98b=
adaddr=E2=80=99?
>   REG_OFFSET_NAME(sbadaddr),
>                   ^~~~~~~~
> ././include/linux/compiler_types.h:129:57: note: in definition of macro =
=E2=80=98__compiler_offsetof=E2=80=99
>  #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                                          ^
> arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro =E2=80=98o=
ffsetof=E2=80=99
>  #define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
>                                                    ^~~~~~~~
> arch/riscv/kernel/ptrace.c:170:2: note: in expansion of macro =E2=80=98RE=
G_OFFSET_NAME=E2=80=99
>   REG_OFFSET_NAME(sbadaddr),
>   ^~~~~~~~~~~~~~~
> arch/riscv/kernel/ptrace.c:171:18: error: =E2=80=98struct pt_regs=E2=80=
=99 has no member named =E2=80=98scause=E2=80=99; did you mean =E2=80=98cau=
se=E2=80=99?
>   REG_OFFSET_NAME(scause),
>                   ^~~~~~
> ././include/linux/compiler_types.h:129:57: note: in definition of macro =
=E2=80=98__compiler_offsetof=E2=80=99
>  #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
>                                                          ^
> arch/riscv/kernel/ptrace.c:133:51: note: in expansion of macro =E2=80=98o=
ffsetof=E2=80=99
>  #define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
>                                                    ^~~~~~~~
> arch/riscv/kernel/ptrace.c:171:2: note: in expansion of macro =E2=80=98RE=
G_OFFSET_NAME=E2=80=99
>   REG_OFFSET_NAME(scause),

Sorry, I really missed this email. I will fix these errors and resend
this patch set. Thank you
