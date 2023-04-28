Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301A6F1D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjD1RUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1RUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 13:20:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB92D50;
        Fri, 28 Apr 2023 10:20:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ed7e49541so4152566b.1;
        Fri, 28 Apr 2023 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682702427; x=1685294427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orF2TGjKH9RnkI54wP/gNHzEqDj6sbeR6PxFmMBG6iU=;
        b=Og6im9eIF6DaYG2GWJ5b2TKo9T6LHVbDSI0mRdlIMWomUWZJqYz62QFIt0Wf4XxZfk
         ECtGRKZN/GPSuYSJFdzw8JTKZBztaKXICMfDh/W6JQnlMYnk8zqQcvCmPfARv9YNb+Rk
         vGLmbfzCS/pH4ue6J8AcHQvPLnF9Zc6/NyiJvfxN8bt5ojGg6Wk6tQg0LZTLm8UivTG+
         AAhFOAodZj8oyEq/iK1u2MYPnenON4Oo220ZYgq0TwfF2mg2WSVK+npODFrwK4cwrBp6
         shIxTMqGnbFh0K6OJ9uvcncy013NihsMSIFPVLm9ZHoXRypMgheDJ2hneNpIKvxmPfyu
         NfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702427; x=1685294427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orF2TGjKH9RnkI54wP/gNHzEqDj6sbeR6PxFmMBG6iU=;
        b=DPBOMhOxVGhuqOO+BqOncCpYBFT+2Okv/CDH9p+AXrUeIaQpAo+qNkz45Qzjmqa2AD
         bkETdbRrkWOvVnRF8HbyIk2/mUZCdfnW9ugCf1Xu/mHErFBnwKuUzeSJ6UkZeC6ZKyoh
         2+Z/ePGajENB2YWObEIMkN7VLY0uOEI7YMnByxoGy6YUPp9Lubkb7RMHIRUMiVHcLNwc
         51TIHAZR450/hXZG1KFF+wyR2k/Ll5uEGQiG+2d/F8lzqcAWli5G2KBnjfk3n4BwSyRb
         zpNvDi4BVA8zIpJuiHZ+CKnWcXL66vvbivfI/BA3HT8BmeQXLI9tORCrm9AltcH3xPHR
         zdKg==
X-Gm-Message-State: AC+VfDzRdtSWlTMJSSgSu6olc/kzheLKR1p/hOfN7wxigfsHSmd2u9Xk
        jUcmUVU5zAZhJtwT4pK9K9iVb5n3R4bMtbmCmpU=
X-Google-Smtp-Source: ACHHUZ4TjhFZe9MIfvPxUNoAWXx/IV5F5hXGaGCwsr/HgJpKWF1URF/cmz9de4Ju8388pxFCrtZLaOOfo1loiwbySuk=
X-Received: by 2002:a17:907:9703:b0:94f:8605:3f30 with SMTP id
 jg3-20020a170907970300b0094f86053f30mr5739104ejc.24.1682702427237; Fri, 28
 Apr 2023 10:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
 <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
 <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com>
 <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
 <CAEf4BzatBnBH8RHczLerMsW4NvTtx6xj5COjGzVvTkRxfciw4Q@mail.gmail.com> <874jp0bcoy.fsf@oracle.com>
In-Reply-To: <874jp0bcoy.fsf@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Apr 2023 10:20:15 -0700
Message-ID: <CAEf4BzbOCHkBJq5OFNtwcbFWVjZBosECiYx_dLgnNYTX_MdAaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 28, 2023 at 2:04=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, Apr 27, 2023 at 4:36=E2=80=AFPM Daniel Rosenberg <drosen@google=
.com> wrote:
> >>
> >> On Wed, Apr 26, 2023 at 4:39=E2=80=AFPM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >> >
> >> > Don't know, show the sequence of commands you are running?
> >> >
> >> > I have linux source in ~/linux, and KBUILD_OUTPUT set to
> >> > ~/linux-build/default. And it only takes this:
> >> >
> >> > $ cd ~/linux
> >> > $ make -j90 # build kernel
> >> > $ cd tools/testing/selftests/bpf
> >> > $ make -j90 # build selftests
> >> >
> >> > And that's it.
> >>
> >> I've tried the same, modulo some paths. I'm pretty sure it's version
> >> related at this point.
> >> The current issue I'm seeing is "error: indirect call in function,
> >> which are not supported by eBPF" when using GCC-BPF for
> >> progs/bind4_prog.c
> >
> > I don't think GCC-BPF is able to compile selftests properly just yet.
> > So I guess the problem is that you do have some version of gcc-bpf in
> > the system and selftest's Makefile tries to build gcc variants of
> > test_progs? That's bad (I don't have GCC-BPF locally, and everyone
> > else apparently as well).
> >
> > So for now just `make BPF_GCC=3D` ? CC'ing Jose, we should probably
> > agree on some criteria of "GCC-BPF is really capable of building
> > selftests" and adjust Makefile to only attempt GCC BPF build in that
> > case.
>
> Being able to run the selftests is our goal at the moment, but we are
> not there yet, no.
>
> What about making the kernel build system to emit a visible warning
> before it builds the GCC variants of the tests programs?  Something like
> "this is experimental and will likely fail".

Given gcc-bpf can't build selftests right now, should we just disable
it until there is a version on which gcc-bpf works? We can make it
such that you can force it to build using gcc-bpf (make USE_GCC_BPF=3D1
or something).

>
> >>
> >> Currently using clang 16.0.0 and gcc 12.2.0-14.
> >> I did manage to get it to build by just commenting out TEST_GEN_PROGS
> >> +=3D test_progs-bpf_gcc
