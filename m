Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6B788EE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHYSq6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjHYSqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 14:46:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3DCD2;
        Fri, 25 Aug 2023 11:46:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c353a395cso156639966b.2;
        Fri, 25 Aug 2023 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989201; x=1693594001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8kMb3SGZQ6eWcS2izBfAzJkuNyIE7vijCFiSkYhv/c=;
        b=pchmme6U7B78a37PLmZ1LuNV3dmzi9pNYcmJichG/F8AvZxrDlxg8ZkoNRPIPl7isp
         fmFbsl1GEpeN1S48Mt5AT9VYTPgtDCnhC4aP6s7mlHtn/CbZGObrCFwJRz9rOrOfGbJX
         3ucJGDxeuEnLv7gIr6supoY2dyREq4h9hWETy9dDV7vjwH1X9SNb+cj2ohwZLDAwcbiD
         VVkdlQk8uqovPFf39rpfeK5EVuIb8FblL0Ruv4gpNPDGcs+fDhQ0UXBy3p9PSJGDckkz
         I/PETQadfJSMoARWLeyFeYR+JCTEG4S+m7vak7sTXnWqVzFUuVi7OLqgYiZABtnplWJQ
         kzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989201; x=1693594001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8kMb3SGZQ6eWcS2izBfAzJkuNyIE7vijCFiSkYhv/c=;
        b=Q/gQD7xvvZeiBysxWCkQp0aZ2be0WZtqbLYVPTVLgL5JE29h0ccaJRuaLAE6R5zBQR
         KHK+6vJKvsKXPOINYPPuwzjmSyGc9A1azt643fZbiuMi47sZb+Ni1IXS6/4bgUBY8t+b
         M0UxoBnLEVx4KK3r21+ATRdd3goGKsgFMtHmilgchL2UYfuPLAgConMS6rBD2MnYxDFi
         gjdqtD4uo2QDNtzNvxj5YkrjqaSbVin6WOsqyVYhhF2s6uCCpyCUFLRS0Wz+ambxMpSA
         EjGCHybBgTnTw03auF4mG/iauLVrMIxHdnV6+F3U9yWtAx3r8m/anOTIMK3NE7XTtYwo
         +PVA==
X-Gm-Message-State: AOJu0YxXQcYMrpv6GV7lVU4qL0yCHh4gEd49Sm88MecvvntgSB9BxPEi
        YbzCbaVDOd9QkKef3zlYxMCKjgBHLqTKXg==
X-Google-Smtp-Source: AGHT+IFSVqIsCCp6o/KC9FED1oTxoVDQSY208QtrMRSuVRt7HfzLa54diuVazJw1+fwlshH/8kUqoA==
X-Received: by 2002:a17:907:75f9:b0:994:577:f9dd with SMTP id jz25-20020a17090775f900b009940577f9ddmr15097321ejc.9.1692989200490;
        Fri, 25 Aug 2023 11:46:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709064c8500b00993928e4d1bsm1219668eju.24.2023.08.25.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:46:40 -0700 (PDT)
Message-ID: <3226a69223806f403132a4003676b63f7bf6f7fb.camel@gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing
 header
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Date:   Fri, 25 Aug 2023 21:46:38 +0300
In-Reply-To: <CAFhGd8ob_qet6ODduHz2=sjGXkHaFMzrtu1FFkN0eUWQvpyPrQ@mail.gmail.com>
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
         <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
         <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
         <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
         <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
         <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
         <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
         <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
         <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
         <20230822214220.jjx3srik4mteeond@google.com>
         <56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com>
         <e99b4226bd450fedfebd4eb5c37054f032432b4f.camel@gmail.com>
         <CAFhGd8ob_qet6ODduHz2=sjGXkHaFMzrtu1FFkN0eUWQvpyPrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-08-25 at 11:36 -0700, Justin Stitt wrote:
> On Fri, Aug 25, 2023 at 6:01=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2023-08-25 at 10:08 +0200, Benjamin Tissoires wrote:
> > >=20
> > > On Tue, Aug 22, 2023 at 11:42=E2=80=AFPM Justin Stitt <justinstitt@go=
ogle.com> wrote:
> > > > > > > > Which kernel are you trying to test?
> > > > > > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > > > > > >=20
> > > > > > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378e=
f)
> > > > > > >=20
> > > > > > > I ran these exact commands:
> > > > > > > >    $ make mrproper
> > > > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> > > > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/sel=
ftests
> > > > > > > TARGETS=3Dhid &> out
> > > > > > >=20
> > > > > > > and here's the contents of `out` (still warnings/errors):
> > > > > > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce=
5f59c6d
> > > > > > >=20
> > > > > > > I have a feeling I'm doing something fundamentally incorrectl=
y. Any ideas?
> > > > > >=20
> > > > > > Sigh... there is a high chance my Makefile is not correct and u=
ses the
> > > > > > installed headers (I was running the exact same commands, but o=
n a
> > > > > > v6.4-rc7+ kernel).
> > > > > >=20
> > > > > > But sorry, it will have to wait for tomorrow if you want me to =
have a
> > > > > > look at it. It's 11:35 PM here, and I need to go to bed
> > > > > Take it easy. Thanks for the prompt responses here! I'd like to g=
et
> > > > > the entire kselftest make target building with Clang so that we c=
an
> > > > > close [1].
> > >=20
> > > Sorry I got urgent matters to tackle yesterday.
> > >=20
> > > It took me a while to understand what was going on, and I finally fou=
nd
> > > it.
> > >=20
> > > struct hid_bpf_ctx is internal to the kernel, and so is declared in
> > > vmlinux.h, that we generate through BTF. But to generate the vmlinux.=
h
> > > with the correct symbols, these need to be present in the running
> > > kernel.
> > > And that's where we had a fundamental difference: I was running my
> > > compilations on a kernel v6.3+ (6.4.11) with that symbol available, a=
nd
> > > you are probably not.
> > >=20
> > > The bpf folks are using a clever trick to force the compilation[2]. A=
nd
> > > I think the following patch would work for you:
> >=20
> > Hi Benjamin, Justin,
> >=20
> > You might want to take a look at these two links:
> > [1] https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incom=
patible-field-and-type-changes
> > [2] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portab=
ility-and-co-re.html#dealing-with-kernel-version-and-configuration-differen=
ces
> >=20
> > The short version is: CO-RE relocation handling logic in libbpf
> > ignores suffixes of form '___something' for type and field names.
> >=20
> > So, the following should accomplish the same as the trick with
> > #define/#undef:
> >=20
> >     #include "vmlinux.h"
> >     ...
> >     struct hid_bpf_ctx___local {
> >         __u32 index;
> >         const struct hid_device *hid;
> >         __u32 allocated_size;
> >         enum hid_report_type report_type;
> >         union {
> >             __s32 retval;
> >             __s32 size;
> >         };
> >=20
> >     };
> >     ...
> >     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
> >                                   unsigned int offset, ...)
> >=20
> > However, if the kernel does not have `hid_bpf_ctx` definition would
> > the test `progs/hid.c` still make sense?
> >=20
> > When I tried to build hid tests locally I run into similar errors:
> >=20
> >     ...
> >       CLNG-BPF hid.bpf.o
> >     In file included from progs/hid.c:6:
> >     progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct hid_bpf=
_ctx' \
> >            will not be visible outside of this function [-Werror,-Wvisi=
bility]
> >     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> >     ...
> >=20
> > And there is indeed no `hid_bpf_ctx` in my vmlinux.h.
> > However, after enabling CONFIG_HID_BPF in kernel config the
> > `hid_bpf_ctx` appears in vmlinux.h, and I can compile HID selftests
> > w/o issues.
>=20
> Even with enabling this configuration option I was unable to get clean
> builds of the HID selftests. I proposed a 4th patch on top of
> Benjamin's n=3D3 patch series here [1] using the #def/#undef pattern.

What are the remaining errors?
Could you please share your .config (e.g. as a gist).

As I said, when your kernel does not have `struct hid_bpf_ctx`,
sure you can define these data structures in the test itself,
but the test would loose it's meaning. If kernel is built
w/o HID BPF support there is no sense in compiling this test.

>=20
> >=20
> > >=20
> > > ---
> > >  From bb9eccb7a896ba4b3a35ed12a248e6d6cfed2df6 Mon Sep 17 00:00:00 20=
01
> > > From: Benjamin Tissoires <bentiss@kernel.org>
> > > Date: Fri, 25 Aug 2023 10:02:32 +0200
> > > Subject: [PATCH] selftests/hid: ensure we can compile the tests on ke=
rnels
> > >   pre-6.3
> > >=20
> > > For the hid-bpf tests to compile, we need to have the definition of
> > > struct hid_bpf_ctx. This definition is an internal one from the kerne=
l
> > > and it is supposed to be defined in the generated vmlinux.h.
> > >=20
> > > This vmlinux.h header is generated based on the currently running ker=
nel
> > > or if the kernel was already compiled in the tree. If you just compil=
e
> > > the selftests without compiling the kernel beforehand and you are run=
ning
> > > on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_c=
tx
> > > definition.
> > >=20
> > > Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.=
h
> > > to force the definition of that symbol in case we don't find it in th=
e
> > > BTF.
> > >=20
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > >   tools/testing/selftests/hid/progs/hid.c       |  3 ---
> > >   .../selftests/hid/progs/hid_bpf_helpers.h     | 20 ++++++++++++++++=
+++
> > >   2 files changed, 20 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/=
selftests/hid/progs/hid.c
> > > index 88c593f753b5..1e558826b809 100644
> > > --- a/tools/testing/selftests/hid/progs/hid.c
> > > +++ b/tools/testing/selftests/hid/progs/hid.c
> > > @@ -1,8 +1,5 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   /* Copyright (c) 2022 Red hat */
> > > -#include "vmlinux.h"
> > > -#include <bpf/bpf_helpers.h>
> > > -#include <bpf/bpf_tracing.h>
> > >   #include "hid_bpf_helpers.h"
> > >=20
> > >   char _license[] SEC("license") =3D "GPL";
> > > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/to=
ols/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > index 4fff31dbe0e7..749097f8f4d9 100644
> > > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > > @@ -5,6 +5,26 @@
> > >   #ifndef __HID_BPF_HELPERS_H
> > >   #define __HID_BPF_HELPERS_H
> > >=20
> > > +/* "undefine" structs in vmlinux.h, because we "override" them below=
 */
> > > +#define hid_bpf_ctx hid_bpf_ctx___not_used
> > > +#include "vmlinux.h"
> > > +#undef hid_bpf_ctx
> > > +
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +
> > > +struct hid_bpf_ctx {
> > > +     __u32 index;
> > > +     const struct hid_device *hid;
> > > +     __u32 allocated_size;
> > > +     enum hid_report_type report_type;
> > > +     union {
> > > +             __s32 retval;
> > > +             __s32 size;
> > > +     };
> > > +};
> > > +
> > >   /* following are kfuncs exported by HID for HID-BPF */
> > >   extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > >                             unsigned int offset,
> >=20
>=20
> [1]: https://lore.kernel.org/all/20230825182316.m2ksjoxe4s7dsapn@google.c=
om/
>=20
> Thanks
> Justin

