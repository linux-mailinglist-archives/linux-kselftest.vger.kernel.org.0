Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE3784BA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 22:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjHVUws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjHVUwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 16:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6753CF1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692737520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XLui8B57SJb6dmFNOQaUJZo2WVZ47mpS7Qsyz0IiRk=;
        b=BvyhxX2HsfqtR/FfeAoYWoX1JyVi1pt1u5+8egEEeANi8dieyJDjFVECYGOBjTkNcBlruB
        +gczr3VVeLvKzPRrPLk9kZU4+roU11RQmvP9HZyRXXpeWOM3NGDNpptV49quPnDt5zRf0S
        ZW/FqJyxPHTeauYctMriRAZo/6gph1s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-QgdRtwwHNfulP_WmRP-moQ-1; Tue, 22 Aug 2023 16:51:58 -0400
X-MC-Unique: QgdRtwwHNfulP_WmRP-moQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bfe6a531bso340065966b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 13:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737517; x=1693342317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XLui8B57SJb6dmFNOQaUJZo2WVZ47mpS7Qsyz0IiRk=;
        b=SdPuFKmKrPSddR9n33VoMiwugmNmQD3YfsZYE1uCC5wN10xJ3+Q++BYQKnPxYjZZY2
         McrPpBGGKlHA4enMoGyK/m3q0otYn6soHdRH9QDKNOtGh8R1SaRfp5UUxxr/raqfUD4q
         gQrZl579WuNnsB3kYlEi37KdTgIMVjzkgCKdZgXEL1fG+JnQod+Y/uZFtVZCTxMLz+Yl
         isqsW9JUZWidsEHZ9SePngMaLkKlIzroqWjlxY4QQsVkfrg9XCI0mrvc1T1JHi7Ve26n
         AzzsI2N3Ottsn5/zoHIu24GmhNO3yHeWgAVr8gYfHYmPmGJy5R1ffZki8dG0/l2R/7k3
         XTrw==
X-Gm-Message-State: AOJu0YxbYDU228jsO/xdlYAF7wn/OJJIoVAS34uD3uA9+E2r3kLPHszw
        Prp1vvqSjkswQE28Ng5PHEYHO4rSGeeCgA8qSxUcZLk4J6c+9qKHv1JFY7bEuRSLIcWHHTYrItf
        0uqBr2P0dC95rBKB8fxQkf2yt52Vc++5tqWj1Z5ogzoaF
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id u22-20020aa7d996000000b00522d6f4c0ebmr7256015eds.40.1692737516975;
        Tue, 22 Aug 2023 13:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNcZZMTNRhQ/wVLWqr83IsqKzBJcMdIjR1e2iyPIrwYLZHNPDWf2vJaZLk2I2cpotnkIlKBCLEHXXEoehx2E=
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id
 u22-20020aa7d996000000b00522d6f4c0ebmr7256011eds.40.1692737516708; Tue, 22
 Aug 2023 13:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
In-Reply-To: <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Aug 2023 22:51:45 +0200
Message-ID: <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Justin,

On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Ben, author of commit dbb60c8a26da ("selftests: add tests for the
> HID-bpf initial implementation")
>
> On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Hi, I'd like to get some help with building the kselftest target.
> >
> > I am running into some warnings within the hid tree:
> > | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> > hid_bpf_ctx' will \
> > |       not be visible outside of this function [-Werror,-Wvisibility]
> > |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > |       |                                      ^
> > | progs/hid.c:23:35: error: incompatible pointer types passing 'struct
> > hid_bpf_ctx *' \
> > |       to parameter of type 'struct hid_bpf_ctx *'
> > [-Werror,-Wincompatible-pointer-types]
> > |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> > offset */, 3 /* size */);
> >
> > This warning, amongst others, is due to some symbol not being included.
> > In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
> > can see inside of the testing tree itself.
> >
> > Instead, `struct hid_bpf_ctx` is defined and implemented at
> > `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
> > the tools directory is a separate entity from kbuild and these tests ar=
e
> > meant to be built/ran without relying on kernel headers. Am I correct i=
n
> > this assumption? At any rate, the include itself doesn't work. How can =
I
> > properly include this struct definition and fix the warning(s)?
> >
> > Please note that we cannot just forward declare the struct as it is
> > being dereferenced and would then yield a completely different
> > error/warning for an incomplete type. We need the entire implementation
> > for the struct included.
> >
> > Other symbols also defined in `include/linux/hid_bpf.h` that we need ar=
e
> > `struct hid_report_type` and `HID_BPF_FLAG...`
> >
> > Here's the invocation I am running to build kselftest:
> > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=
=3Dx86_64
> > -j128 V=3D1 -C tools/testing/selftests`

I think I fixed the same issue in the script I am running to launch
those tests in a VM. This was in commit
f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).

And in the commit log, I wrote:
```
According to commit 01d6c48a828b ("Documentation: kselftest:
"make headers" is a prerequisite"), running the kselftests requires
to run "make headers" first.
```

So my assumption is that you also need to run "make headers" with the
proper flags before compiling the selftests themselves (I might be
wrong but that's how I read the commit).

Cheers,
Benjamin

> >
> > If anyone is currently getting clean builds of kselftest with clang,
> > what invocation works for you?
> >
> >
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > Full-build-log:
> > https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> > (V=3D1)
> >
> > Thanks.
> > Justin
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
>

