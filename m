Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBB788803
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbjHYNBc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbjHYNBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 09:01:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C41BE2;
        Fri, 25 Aug 2023 06:01:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50098cc8967so1413527e87.1;
        Fri, 25 Aug 2023 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692968474; x=1693573274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M6tvFngK9iF1M2/JbWMkaoMAiTkmlQHQzwjyQV4VOtg=;
        b=aeUMSb9rRbcUep9yOFTyo6sGjsTVhDSwm1s9MhC2zFSNH4nc6MLVQDoOdJIfMFdoYc
         qWC3WbxNInhCpxnkRv/nNWRAGJnQLHBknSuDP1oLXIpU61eI8q5vboBWWOX3qMH0bf9R
         w2jeda00CY+eCrhpjxsWwbJhI2F5G6Rf7QSzFT1ZDyqNPeHkuMGevZsBxePFF7RjasS2
         wqkMIZdG8C1qp6qLqvP4QjokrftbX4LYN+/KZ5oOXdvifyMh+gvIiGbNaqKMKsTmWkC4
         uNQ71mhqfMf7JXjCujkrpOdLIhBKNJ2cVmDiaNhVPZTAnBRXBRJpKVcquXkO0MhylBYc
         yHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968474; x=1693573274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6tvFngK9iF1M2/JbWMkaoMAiTkmlQHQzwjyQV4VOtg=;
        b=J5Pwec3j3cwsfL7Vpcee/jWbhWZicT6zlW12DsxfWq6lTydn7pOHTbkP8Bsg8tToeR
         eKGzWltG3AX+6I8yH+Of/xCsJ2LUx8Hi4e2dAVjWsWC7Pp0wuPlREKQpzlHYLnDsmeff
         VxSuywExLt5nWaY+zYYnLW0EglzrRdJo//DhKGikWOSe84FxlTKco7TnoLxnVChvdBDD
         wkJMWktH6xk5NNwCM9hcxQ6Z4O/DaUvxqewc1PMGTcY4cqNNEMYpN60RZRrZgxaDRbQV
         EV+GrC82oucgEUIgEUhkluaLG5TA01U+jYqI++0Mo8tYeJ8eVj2F/UyYsc3KVXJbHJPD
         rqrQ==
X-Gm-Message-State: AOJu0YyITDwdk2aark4pTiGHt8hYG679SbF3INyvccdyNBYvCdrgGy2X
        2kfYK0teBvjQ1Ab0q5uXW28=
X-Google-Smtp-Source: AGHT+IG9MOL0duEiV2Dg3iWuf4FQns40t6l6FC60UWAKbZxX3Da3ffQ9x7eVwucv5oSvXyyrUn0ZhQ==
X-Received: by 2002:ac2:4e06:0:b0:500:9d4a:89f8 with SMTP id e6-20020ac24e06000000b005009d4a89f8mr4216176lfr.28.1692968473314;
        Fri, 25 Aug 2023 06:01:13 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090606d100b0098669cc16b2sm938280ejb.83.2023.08.25.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:01:12 -0700 (PDT)
Message-ID: <e99b4226bd450fedfebd4eb5c37054f032432b4f.camel@gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing
 header
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Date:   Fri, 25 Aug 2023 16:01:11 +0300
In-Reply-To: <56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2023-08-25 at 10:08 +0200, Benjamin Tissoires wrote:
>=20
> On Tue, Aug 22, 2023 at 11:42=E2=80=AFPM Justin Stitt <justinstitt@google=
.com> wrote:
> > > > > > Which kernel are you trying to test?
> > > > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > > > >=20
> > > > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> > > > >=20
> > > > > I ran these exact commands:
> > > > > >    $ make mrproper
> > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selftes=
ts
> > > > > TARGETS=3Dhid &> out
> > > > >=20
> > > > > and here's the contents of `out` (still warnings/errors):
> > > > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f59=
c6d
> > > > >=20
> > > > > I have a feeling I'm doing something fundamentally incorrectly. A=
ny ideas?
> > > >=20
> > > > Sigh... there is a high chance my Makefile is not correct and uses =
the
> > > > installed headers (I was running the exact same commands, but on a
> > > > v6.4-rc7+ kernel).
> > > >=20
> > > > But sorry, it will have to wait for tomorrow if you want me to have=
 a
> > > > look at it. It's 11:35 PM here, and I need to go to bed
> > > Take it easy. Thanks for the prompt responses here! I'd like to get
> > > the entire kselftest make target building with Clang so that we can
> > > close [1].
>=20
> Sorry I got urgent matters to tackle yesterday.
>=20
> It took me a while to understand what was going on, and I finally found
> it.
>=20
> struct hid_bpf_ctx is internal to the kernel, and so is declared in
> vmlinux.h, that we generate through BTF. But to generate the vmlinux.h
> with the correct symbols, these need to be present in the running
> kernel.
> And that's where we had a fundamental difference: I was running my
> compilations on a kernel v6.3+ (6.4.11) with that symbol available, and
> you are probably not.
>=20
> The bpf folks are using a clever trick to force the compilation[2]. And
> I think the following patch would work for you:

Hi Benjamin, Justin,

You might want to take a look at these two links:
[1] https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompati=
ble-field-and-type-changes
[2] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portabilit=
y-and-co-re.html#dealing-with-kernel-version-and-configuration-differences

The short version is: CO-RE relocation handling logic in libbpf
ignores suffixes of form '___something' for type and field names.

So, the following should accomplish the same as the trick with
#define/#undef:

    #include "vmlinux.h"
    ...
    struct hid_bpf_ctx___local {
        __u32 index;
        const struct hid_device *hid;
        __u32 allocated_size;
        enum hid_report_type report_type;
        union {
            __s32 retval;
            __s32 size;
        };
   =20
    };
    ...
    extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
                                  unsigned int offset, ...)

However, if the kernel does not have `hid_bpf_ctx` definition would
the test `progs/hid.c` still make sense?

When I tried to build hid tests locally I run into similar errors:

    ...
      CLNG-BPF hid.bpf.o
    In file included from progs/hid.c:6:
    progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct hid_bpf_ctx=
' \
           will not be visible outside of this function [-Werror,-Wvisibili=
ty]
    extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
    ...

And there is indeed no `hid_bpf_ctx` in my vmlinux.h.
However, after enabling CONFIG_HID_BPF in kernel config the
`hid_bpf_ctx` appears in vmlinux.h, and I can compile HID selftests
w/o issues.

>=20
> ---
>  From bb9eccb7a896ba4b3a35ed12a248e6d6cfed2df6 Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <bentiss@kernel.org>
> Date: Fri, 25 Aug 2023 10:02:32 +0200
> Subject: [PATCH] selftests/hid: ensure we can compile the tests on kernel=
s
>   pre-6.3
>=20
> For the hid-bpf tests to compile, we need to have the definition of
> struct hid_bpf_ctx. This definition is an internal one from the kernel
> and it is supposed to be defined in the generated vmlinux.h.
>=20
> This vmlinux.h header is generated based on the currently running kernel
> or if the kernel was already compiled in the tree. If you just compile
> the selftests without compiling the kernel beforehand and you are running
> on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
> definition.
>=20
> Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
> to force the definition of that symbol in case we don't find it in the
> BTF.
>=20
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>   tools/testing/selftests/hid/progs/hid.c       |  3 ---
>   .../selftests/hid/progs/hid_bpf_helpers.h     | 20 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/self=
tests/hid/progs/hid.c
> index 88c593f753b5..1e558826b809 100644
> --- a/tools/testing/selftests/hid/progs/hid.c
> +++ b/tools/testing/selftests/hid/progs/hid.c
> @@ -1,8 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2022 Red hat */
> -#include "vmlinux.h"
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
>   #include "hid_bpf_helpers.h"
>  =20
>   char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/=
testing/selftests/hid/progs/hid_bpf_helpers.h
> index 4fff31dbe0e7..749097f8f4d9 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -5,6 +5,26 @@
>   #ifndef __HID_BPF_HELPERS_H
>   #define __HID_BPF_HELPERS_H
>  =20
> +/* "undefine" structs in vmlinux.h, because we "override" them below */
> +#define hid_bpf_ctx hid_bpf_ctx___not_used
> +#include "vmlinux.h"
> +#undef hid_bpf_ctx
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +
> +struct hid_bpf_ctx {
> +	__u32 index;
> +	const struct hid_device *hid;
> +	__u32 allocated_size;
> +	enum hid_report_type report_type;
> +	union {
> +		__s32 retval;
> +		__s32 size;
> +	};
> +};
> +
>   /* following are kfuncs exported by HID for HID-BPF */
>   extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
>   			      unsigned int offset,

