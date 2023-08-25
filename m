Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E4788ECB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjHYSgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjHYSgm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 14:36:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E49210A
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 11:36:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007abb15e9so1892063e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692988597; x=1693593397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfc+svOzCxvB7yRJtIEcq1qIHS1pzaD7yBQ0frUfrOs=;
        b=Fbyo8i4DUT7CRSUZhuSpG1rSoSWlUGLlxwdscAVjilPHwlKCw/l+Y38zplZL94R3Go
         SWLn7P5ndcDgZybrt/hyyURDN59dhFJNLEQ+m1Swn9vo9md5zfLurImt/ZDlhS287NuO
         rmPMpf0Tflz8yPZvirTNpK7E6p1bq3czP9f2v+mm4Uyb87n0WjKjmxI3tyL//k2/WvPE
         vZVzePxJ1DSWbDhbKNP/npcIeA/PJ4Ah60yE+aVHFZRHI55oPO7WX9vSv4KQLtXqjIRN
         m8bfZYhzzmMLOAySl3kdo45qvtCS0uaa3I8q34j3KLzafSOwBkxm5qg/1cQgxKbDvhy4
         EOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988597; x=1693593397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfc+svOzCxvB7yRJtIEcq1qIHS1pzaD7yBQ0frUfrOs=;
        b=K9jqw6+vmR7yoI4PB7wgMvd6nSd7ANtm5cHc/WDfoXBpvt0qyTBHT2pZ3+lNB2GkQx
         St9CnYZYh7TGSsLjOPEqzbZPjhZSZNiSOHcC5DLF15guqYU8llS1mv2ekoTaRFmICb2L
         Q0ElUWqQJ9SbQRqJ6GDYXMYo7tPhFPyPfdqdMnCbCwKS5nhrPodrsNHjrcuxMMEVqz2O
         tY7cf7k1PmuxEOARS9ugzD4NibBx6wHXDlRTPPFAl3HR/zuUTVCI9WM4VHEYW9/ICrrD
         eJ+D8uyC2kc0ZEBPvn8/2G/OIu2OLcFCfyvdwd0Q9ETNVeyt2GUymZRNeFz0O4WXnJ7H
         b8mw==
X-Gm-Message-State: AOJu0Ywc0cUc2CsUK35d0CkLlVzedtz7VSgwKHNuoN/GG1GXKk5wFGRQ
        Xsf7MPUlAWETFnR4vf3UBTz8wjupESUJI5pSbL7ZAA==
X-Google-Smtp-Source: AGHT+IGrldydCJQJSKs/g27Dr7xBAtnXV9y0Ay5Jeene2HWimKFVvOs3WUFSh0gFcSelV2Qw9y7BcbTiWTe9zY+5qlA=
X-Received: by 2002:a05:6512:220f:b0:4fb:81f2:422b with SMTP id
 h15-20020a056512220f00b004fb81f2422bmr17047884lfu.54.1692988596632; Fri, 25
 Aug 2023 11:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
 <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
 <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
 <CAO-hwJ+DTPXWbpNaBDvCkyAsWZHbeLiBwYo4k93ZW79Jt-HAkg@mail.gmail.com>
 <CAFhGd8pVjUPpukHxxbQCEnmgDUqy-tgBa7POkmgrYyFXVRAMEw@mail.gmail.com>
 <CAO-hwJJntQTzcJH5nf9RM1bVWGVW1kb28rJ3tgew1AEH00PmJQ@mail.gmail.com>
 <CAFhGd8rgdszt5vgWuGKkcpTZbKvihGCJXRKKq7RP17+71dTYww@mail.gmail.com>
 <20230822214220.jjx3srik4mteeond@google.com> <56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com>
 <e99b4226bd450fedfebd4eb5c37054f032432b4f.camel@gmail.com>
In-Reply-To: <e99b4226bd450fedfebd4eb5c37054f032432b4f.camel@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 11:36:25 -0700
Message-ID: <CAFhGd8ob_qet6ODduHz2=sjGXkHaFMzrtu1FFkN0eUWQvpyPrQ@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 25, 2023 at 6:01=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-08-25 at 10:08 +0200, Benjamin Tissoires wrote:
> >
> > On Tue, Aug 22, 2023 at 11:42=E2=80=AFPM Justin Stitt <justinstitt@goog=
le.com> wrote:
> > > > > > > Which kernel are you trying to test?
> > > > > > > I tested your 2 commands on v6.5-rc7 and it just works.
> > > > > >
> > > > > > I'm also on v6.5-rc7 (706a741595047797872e669b3101429ab8d378ef)
> > > > > >
> > > > > > I ran these exact commands:
> > > > > > >    $ make mrproper
> > > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 headers
> > > > > > >    $ make LLVM=3D1 ARCH=3Dx86_64 -j128 -C tools/testing/selft=
ests
> > > > > > TARGETS=3Dhid &> out
> > > > > >
> > > > > > and here's the contents of `out` (still warnings/errors):
> > > > > > https://gist.github.com/JustinStitt/d0c30180a2a2e046c32d5f0ce5f=
59c6d
> > > > > >
> > > > > > I have a feeling I'm doing something fundamentally incorrectly.=
 Any ideas?
> > > > >
> > > > > Sigh... there is a high chance my Makefile is not correct and use=
s the
> > > > > installed headers (I was running the exact same commands, but on =
a
> > > > > v6.4-rc7+ kernel).
> > > > >
> > > > > But sorry, it will have to wait for tomorrow if you want me to ha=
ve a
> > > > > look at it. It's 11:35 PM here, and I need to go to bed
> > > > Take it easy. Thanks for the prompt responses here! I'd like to get
> > > > the entire kselftest make target building with Clang so that we can
> > > > close [1].
> >
> > Sorry I got urgent matters to tackle yesterday.
> >
> > It took me a while to understand what was going on, and I finally found
> > it.
> >
> > struct hid_bpf_ctx is internal to the kernel, and so is declared in
> > vmlinux.h, that we generate through BTF. But to generate the vmlinux.h
> > with the correct symbols, these need to be present in the running
> > kernel.
> > And that's where we had a fundamental difference: I was running my
> > compilations on a kernel v6.3+ (6.4.11) with that symbol available, and
> > you are probably not.
> >
> > The bpf folks are using a clever trick to force the compilation[2]. And
> > I think the following patch would work for you:
>
> Hi Benjamin, Justin,
>
> You might want to take a look at these two links:
> [1] https://nakryiko.com/posts/bpf-core-reference-guide/#handling-incompa=
tible-field-and-type-changes
> [2] https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portabil=
ity-and-co-re.html#dealing-with-kernel-version-and-configuration-difference=
s
>
> The short version is: CO-RE relocation handling logic in libbpf
> ignores suffixes of form '___something' for type and field names.
>
> So, the following should accomplish the same as the trick with
> #define/#undef:
>
>     #include "vmlinux.h"
>     ...
>     struct hid_bpf_ctx___local {
>         __u32 index;
>         const struct hid_device *hid;
>         __u32 allocated_size;
>         enum hid_report_type report_type;
>         union {
>             __s32 retval;
>             __s32 size;
>         };
>
>     };
>     ...
>     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx___local *ctx,
>                                   unsigned int offset, ...)
>
> However, if the kernel does not have `hid_bpf_ctx` definition would
> the test `progs/hid.c` still make sense?
>
> When I tried to build hid tests locally I run into similar errors:
>
>     ...
>       CLNG-BPF hid.bpf.o
>     In file included from progs/hid.c:6:
>     progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct hid_bpf_c=
tx' \
>            will not be visible outside of this function [-Werror,-Wvisibi=
lity]
>     extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
>     ...
>
> And there is indeed no `hid_bpf_ctx` in my vmlinux.h.
> However, after enabling CONFIG_HID_BPF in kernel config the
> `hid_bpf_ctx` appears in vmlinux.h, and I can compile HID selftests
> w/o issues.

Even with enabling this configuration option I was unable to get clean
builds of the HID selftests. I proposed a 4th patch on top of
Benjamin's n=3D3 patch series here [1] using the #def/#undef pattern.

>
> >
> > ---
> >  From bb9eccb7a896ba4b3a35ed12a248e6d6cfed2df6 Mon Sep 17 00:00:00 2001
> > From: Benjamin Tissoires <bentiss@kernel.org>
> > Date: Fri, 25 Aug 2023 10:02:32 +0200
> > Subject: [PATCH] selftests/hid: ensure we can compile the tests on kern=
els
> >   pre-6.3
> >
> > For the hid-bpf tests to compile, we need to have the definition of
> > struct hid_bpf_ctx. This definition is an internal one from the kernel
> > and it is supposed to be defined in the generated vmlinux.h.
> >
> > This vmlinux.h header is generated based on the currently running kerne=
l
> > or if the kernel was already compiled in the tree. If you just compile
> > the selftests without compiling the kernel beforehand and you are runni=
ng
> > on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
> > definition.
> >
> > Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
> > to force the definition of that symbol in case we don't find it in the
> > BTF.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >   tools/testing/selftests/hid/progs/hid.c       |  3 ---
> >   .../selftests/hid/progs/hid_bpf_helpers.h     | 20 ++++++++++++++++++=
+
> >   2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/se=
lftests/hid/progs/hid.c
> > index 88c593f753b5..1e558826b809 100644
> > --- a/tools/testing/selftests/hid/progs/hid.c
> > +++ b/tools/testing/selftests/hid/progs/hid.c
> > @@ -1,8 +1,5 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   /* Copyright (c) 2022 Red hat */
> > -#include "vmlinux.h"
> > -#include <bpf/bpf_helpers.h>
> > -#include <bpf/bpf_tracing.h>
> >   #include "hid_bpf_helpers.h"
> >
> >   char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tool=
s/testing/selftests/hid/progs/hid_bpf_helpers.h
> > index 4fff31dbe0e7..749097f8f4d9 100644
> > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > @@ -5,6 +5,26 @@
> >   #ifndef __HID_BPF_HELPERS_H
> >   #define __HID_BPF_HELPERS_H
> >
> > +/* "undefine" structs in vmlinux.h, because we "override" them below *=
/
> > +#define hid_bpf_ctx hid_bpf_ctx___not_used
> > +#include "vmlinux.h"
> > +#undef hid_bpf_ctx
> > +
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +
> > +struct hid_bpf_ctx {
> > +     __u32 index;
> > +     const struct hid_device *hid;
> > +     __u32 allocated_size;
> > +     enum hid_report_type report_type;
> > +     union {
> > +             __s32 retval;
> > +             __s32 size;
> > +     };
> > +};
> > +
> >   /* following are kfuncs exported by HID for HID-BPF */
> >   extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> >                             unsigned int offset,
>

[1]: https://lore.kernel.org/all/20230825182316.m2ksjoxe4s7dsapn@google.com=
/

Thanks
Justin
