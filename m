Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029278B6B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjH1Rsl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjH1RsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 13:48:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98313186
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 10:48:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso4723331a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693244886; x=1693849686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qyIITZmt6yIxcf2AHhToVSoBW9CwGLT+eBWC1sVHAU=;
        b=odR1gCkyLODs1etSs5WhGACv3cH24ciJWMHclQ8UrrQaRT6tp7Lbt47muVULy3Meim
         8wuqYAWxhVce2vZ7/dfTM7BZS4Oo3i/RYoVWgFHgFZ2ZjPmKjmncyidLczu0yTTiFgll
         PDD+lw45/CTMK1++RScIQI/jhRnm+BwqwkdXs/QDWzlRXgjhLzeGavE/LTHXKfCAOrEo
         MgAP1SJcFvGysfQFYXfu8HgRykHJF9vFOpgWurKmLBAkuhQDQ8dLCgvnUhZqO5XqEptl
         4z0K1QMbiwW3pM5x+gBfYM2ij7UlC+hu21m4mnXexyzPqfZNAv2b5D7ENphu8fUOLN0C
         H8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693244886; x=1693849686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qyIITZmt6yIxcf2AHhToVSoBW9CwGLT+eBWC1sVHAU=;
        b=GT+FUHt+bvRpWGbV0mXvX7cQBF19jxmuM/49C9CbAqnNrjL7ubSe7+463qMvLNxZ2y
         NP68zLFDoyzwFxUshK5QmX3b6ZP1uxwCdbU4VUc2hDgr8qE030Z5H1I2QsHq4y8H7E8r
         KkdfdaTJw2ysh2Yk4+P3pyBqUNsAtDr7gXYKf8e6pqNyj2Bz3AtftF8Al+cLxS7Kl57o
         E5XT1STugvTNIEIbWWlhqJCj8pGxAoqMHnKr6EssaJ1/ShZMxa7CHzUwljpM7wF0djdg
         ZKbynru9/9mkkDIdekiuVcjyPWxqIZjtIBxViuboNf9c3KuagsXC4v1qgY5q2Csy5e6v
         /s7g==
X-Gm-Message-State: AOJu0YyM8cjJ3CzV7sOaoBuxfew7jilSM/tLpL/UKizVS/aObYHdXi9f
        YyuuIFLeF6gUmu5ZGMEuycZX974m2aWAKVxBzKNxrg==
X-Google-Smtp-Source: AGHT+IG5s5Adb1+6Jj4dIei4PAmaE17im1X0zrZxagxFiTM+4t42Iq+COd07+PtZk1fzQuinZ/VGGkYh9+gBNhC9H6A=
X-Received: by 2002:a05:6402:510:b0:523:2c05:7d24 with SMTP id
 m16-20020a056402051000b005232c057d24mr23565515edv.24.1693244886029; Mon, 28
 Aug 2023 10:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
 <20230825182316.m2ksjoxe4s7dsapn@google.com> <65800771171dcaff9901dae47de960ec66602f7e.camel@gmail.com>
In-Reply-To: <65800771171dcaff9901dae47de960ec66602f7e.camel@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 28 Aug 2023 10:47:52 -0700
Message-ID: <CAFhGd8rNtEWpfJKFs+nKj_cLya0q6JSFyuzqqMCYmoi9xxBL6Q@mail.gmail.com>
Subject: Re: [PATCH 4/3] selftests/hid: more fixes to build with older kernel
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

Eduard,

On Fri, Aug 25, 2023 at 11:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2023-08-25 at 18:23 +0000, Justin Stitt wrote:
> > On Fri, Aug 25, 2023 at 10:36:30AM +0200, Benjamin Tissoires wrote:
> > > These fixes have been triggered by [0]:
> > > basically, if you do not recompile the kernel first, and are
> > > running on an old kernel, vmlinux.h doesn't have the required
> > > symbols and the compilation fails.
> > >
> > > The tests will fail if you run them on that very same machine,
> > > of course, but the binary should compile.
> > >
> > > And while I was sorting out why it was failing, I realized I
> > > could do a couple of improvements on the Makefile.
> > >
> > > [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c=
153dcb2@redhat.com/T/#t
> > >
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > > Benjamin Tissoires (3):
> > >       selftests/hid: ensure we can compile the tests on kernels pre-6=
.3
> > >       selftests/hid: do not manually call headers_install
> > >       selftests/hid: force using our compiled libbpf headers
> > >
> > >  tools/testing/selftests/hid/Makefile                | 10 ++++------
> > >  tools/testing/selftests/hid/progs/hid.c             |  3 ---
> > >  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 +++++++++++=
+++++++++
> > >  3 files changed, 24 insertions(+), 9 deletions(-)
> > > ---
> > > base-commit: 1d7546042f8fdc4bc39ab91ec966203e2d64f8bd
> > > change-id: 20230825-wip-selftests-9a7502b56542
> > >
> > > Best regards,
> > > --
> > > Benjamin Tissoires <bentiss@kernel.org>
> > >
> >
> > Benjamin, thanks for the work here. Your series fixed up _some_ of the
> > errors I had while building on my 6.3.11 kernel. I'm proposing a single
> > patch that should be applied on top of your series that fully fixes
> > _all_ of the build errors I'm experiencing.
> >
> > Can you let me know if it works and potentially formulate a new series
> > so that `b4 shazam` applies it cleanly?
> >
> > PATCH BELOW
> > ---
> > From 5378d70e1b3f7f75656332f9bff65a37122bb288 Mon Sep 17 00:00:00 2001
> > From: Justin Stitt <justinstitt@google.com>
> > Date: Fri, 25 Aug 2023 18:10:33 +0000
> > Subject: [PATCH 4/3] selftests/hid: more fixes to build with older kern=
el
> >
> > I had to use the clever trick [1] on some other symbols to get my build=
s
> > working.
> >
> > Apply this patch on top of Benjamin's series [2].
> >
> > This is now a n=3D4 patch series which has fixed my builds when running=
:
> > > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 mrproper headers
> > > $ make LLVM=3D1 -j128 ARCH=3Dx86_64 -C tools/testing/selftests TARGET=
S=3Dhid
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/tools/testing/selftests/bpf/progs/bpf_iter.h#n3
> > [2]: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020=
a8@kernel.org/
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  .../selftests/hid/progs/hid_bpf_helpers.h     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tool=
s/testing/selftests/hid/progs/hid_bpf_helpers.h
> > index 749097f8f4d9..e2eace2c0029 100644
> > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > @@ -7,12 +7,26 @@
> >
> >  /* "undefine" structs in vmlinux.h, because we "override" them below *=
/
> >  #define hid_bpf_ctx hid_bpf_ctx___not_used
> > +#define hid_report_type hid_report_type___not_used
> > +#define hid_class_request hid_class_request___not_used
> > +#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> >  #include "vmlinux.h"
> >  #undef hid_bpf_ctx
> > +#undef hid_report_type
> > +#undef hid_class_request
> > +#undef hid_bpf_attach_flags
> >
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > +#include <linux/const.h>
> >
> > +enum hid_report_type {
> > +     HID_INPUT_REPORT                =3D 0,
> > +     HID_OUTPUT_REPORT               =3D 1,
> > +     HID_FEATURE_REPORT              =3D 2,
> > +
> > +     HID_REPORT_TYPES,
> > +};
> >
> >  struct hid_bpf_ctx {
> >       __u32 index;
> > @@ -25,6 +39,21 @@ struct hid_bpf_ctx {
> >       };
> >  };
>
> Note, vmlinux.h has the following preamble/postamble:
>
>     #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>     #pragma clang attribute push (__attribute__((preserve_access_index)),=
 apply_to =3D record)
>     #endif
>     ...
>     #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>     #pragma clang attribute pop
>     #endif
>
> You might want to use it or add __attribute__((preserve_access_index))
> to structure definitions, depending on whether or not you need CO-RE
> functionality for these tests.

I have no idea whether or not CO-RE is needed for these tests or not.
My main motivation is getting these selftests building with LLVM=3D1
[1].

Perhaps Benjamin could provide some more insight on whether this is
needed or not and roll out a v2 containing my patch on top + any CO-RE
semantics  -- if deemed necessary.

>
> >
> > +enum hid_class_request {
> > +     HID_REQ_GET_REPORT              =3D 0x01,
> > +     HID_REQ_GET_IDLE                =3D 0x02,
> > +     HID_REQ_GET_PROTOCOL            =3D 0x03,
> > +     HID_REQ_SET_REPORT              =3D 0x09,
> > +     HID_REQ_SET_IDLE                =3D 0x0A,
> > +     HID_REQ_SET_PROTOCOL            =3D 0x0B,
> > +};
> > +
> > +enum hid_bpf_attach_flags {
> > +     HID_BPF_FLAG_NONE =3D 0,
> > +     HID_BPF_FLAG_INSERT_HEAD =3D _BITUL(0),
> > +     HID_BPF_FLAG_MAX,
> > +};
> > +
> >  /* following are kfuncs exported by HID for HID-BPF */
> >  extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> >                             unsigned int offset,
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
>

[1]: https://github.com/ClangBuiltLinux/linux/issues/1698

Thanks
Justin
