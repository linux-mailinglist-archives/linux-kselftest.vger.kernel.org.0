Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA7784BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjHVU5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjHVU5U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 16:57:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E63CF3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:57:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so7538908e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692737836; x=1693342636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzHAvJvU/nApA2yMoHvJ1G6cDPyhvuZ9u+E3dxZTTl0=;
        b=CZwvKWGK3DckCO7Fi8mS3W7MwGDdoUCTakynZcFLiDP12Qs5dJmvuSPK56+EGHsd//
         s8vDrDu7Bg6unT9uqT3ibMk3RpFhOr3LKZ0pDmc02GvoA9AtyrZNlwVyORhAu8GHZWFy
         95WyLiJons3xvMHdyD965uHJc59jKIxt0tp1+SzhUNHHORN7RBgyeWb9V8l7d/8eYiKp
         MKp8kGZKcktKz4f22biVRmiDQbjAEoymZimW+GqcfyLfX8+TphZHpq9uT9KQe/l6IzK2
         qZbke/ZRXqDWSc9NxgxDBPyXxkOKKfKfAFrJb4dIJ395fdM2xfUr+0oAC8JRAmuiCNhD
         n+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737836; x=1693342636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzHAvJvU/nApA2yMoHvJ1G6cDPyhvuZ9u+E3dxZTTl0=;
        b=QFNqeRyyFeuNv3TVAhC/v3xKF8etB1Xj8c63jAImuNskL/XQwkmEQUrlPbKKhksM6R
         bPGcTQjWQ6cgbqGxgq89dq2u2FJQyh/Pw/1uqAUv9orOf/W2Ktg75cL39nSbXWqc/vHR
         H/Ew3WyHYprmMStSvxAo0pBjsAdT4gZFZl0DBhyO2+WSZ21sXD4zAp79YTl2PsaOfw3S
         p/Cus2eNT204yHRkqOK+FGMqcFY1cz9CaT2N9XNokVjHXAityvLcT5lbxlzOKDk/W8He
         RNofkP6tqN5/zovWbbkzRKrQFVxpRQNGqUTLEyiLi6MmvT/T3YoIL2qfDbzogFTNU0Nn
         VfSQ==
X-Gm-Message-State: AOJu0Yx4Ltk4x7r3vdR2OcAvbZAjxHW08uwHJszBBOk0h/kXnSvYqWPK
        rNFl6NeL6QvUEbmhgMJccn+9EII5BE1U0FGW/4oaAg==
X-Google-Smtp-Source: AGHT+IENL3fGaa5c8yeC0Cvpb3NAyDAe2M8ES19Hvh6sDem/HbedUBIz+q/XLprGZ7xJXvyjWuu+0QOfvgRmwAHcxOU=
X-Received: by 2002:a05:6512:2522:b0:4f1:3d7d:409e with SMTP id
 be34-20020a056512252200b004f13d7d409emr9198896lfb.0.1692737836393; Tue, 22
 Aug 2023 13:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com> <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
In-Reply-To: <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 22 Aug 2023 13:57:04 -0700
Message-ID: <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Aug 22, 2023 at 1:52=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Justin,
>
> On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + Ben, author of commit dbb60c8a26da ("selftests: add tests for the
> > HID-bpf initial implementation")
> >
> > On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@googl=
e.com> wrote:
> > >
> > > Hi, I'd like to get some help with building the kselftest target.
> > >
> > > I am running into some warnings within the hid tree:
> > > | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> > > hid_bpf_ctx' will \
> > > |       not be visible outside of this function [-Werror,-Wvisibility=
]
> > > |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > > |       |                                      ^
> > > | progs/hid.c:23:35: error: incompatible pointer types passing 'struc=
t
> > > hid_bpf_ctx *' \
> > > |       to parameter of type 'struct hid_bpf_ctx *'
> > > [-Werror,-Wincompatible-pointer-types]
> > > |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> > > offset */, 3 /* size */);
> > >
> > > This warning, amongst others, is due to some symbol not being include=
d.
> > > In this case, `struct hid_bpf_ctx` is not being defined anywhere that=
 I
> > > can see inside of the testing tree itself.
> > >
> > > Instead, `struct hid_bpf_ctx` is defined and implemented at
> > > `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header a=
s
> > > the tools directory is a separate entity from kbuild and these tests =
are
> > > meant to be built/ran without relying on kernel headers. Am I correct=
 in
> > > this assumption? At any rate, the include itself doesn't work. How ca=
n I
> > > properly include this struct definition and fix the warning(s)?
> > >
> > > Please note that we cannot just forward declare the struct as it is
> > > being dereferenced and would then yield a completely different
> > > error/warning for an incomplete type. We need the entire implementati=
on
> > > for the struct included.
> > >
> > > Other symbols also defined in `include/linux/hid_bpf.h` that we need =
are
> > > `struct hid_report_type` and `HID_BPF_FLAG...`
> > >
> > > Here's the invocation I am running to build kselftest:
> > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=
=3Dx86_64
> > > -j128 V=3D1 -C tools/testing/selftests`
>
> I think I fixed the same issue in the script I am running to launch
> those tests in a VM. This was in commit
> f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
>
> And in the commit log, I wrote:
> ```
> According to commit 01d6c48a828b ("Documentation: kselftest:
> "make headers" is a prerequisite"), running the kselftests requires
> to run "make headers" first.
> ```
>
> So my assumption is that you also need to run "make headers" with the
> proper flags before compiling the selftests themselves (I might be
> wrong but that's how I read the commit).

In my original email I pasted the invocation I used which includes the
headers target. What are the "proper flags" in this case?

>
> Cheers,
> Benjamin
>
> > >
> > > If anyone is currently getting clean builds of kselftest with clang,
> > > what invocation works for you?
> > >
> > >
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > > Full-build-log:
> > > https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> > > (V=3D1)
> > >
> > > Thanks.
> > > Justin
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> >
>
