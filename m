Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63A6F0F32
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjD0XnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 19:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbjD0XnC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 19:43:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6175040FB;
        Thu, 27 Apr 2023 16:42:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9505214c47fso1723030166b.1;
        Thu, 27 Apr 2023 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682638972; x=1685230972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUlftFMQG/nmWGeOn+1YPkFCl4D5GTil/3fkguZjWM0=;
        b=pa4d5xwQzC2locTY3gPMPASKVeXayCDl9KcPXWXN+q0pMCEDrVVnA2+MXVP9o/e6NU
         EUKCojDx/XIxG6ScM4D7khM28ADklUOdokWnHxPGMfIyycx7XhLj7W/oEfT1D3ITSZaF
         cjbMTxZ7hIlsg+wMwGNLiYn9ckVZWjrvYPmRc/OiLjzsWVmnpWXPhLT7WV023O9i6Chi
         eQELvGbnN6+nUBnjTl3FRpYxlqgSW0js6lvKvRUXk+sNXIibxH5gMVfxovJOpt/5/dcX
         ++so/TyIdErONKLHHCz42dCyrYSsx/vmAmuLTrh6gDMqNZqwwP+g7ArxgHQgjONyKsju
         iFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638972; x=1685230972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUlftFMQG/nmWGeOn+1YPkFCl4D5GTil/3fkguZjWM0=;
        b=OEZ/T0S4TuPDhfTQ6GDtVH0RozhGS8ztcVMyKhVr0Qlyuds+gd9u9h/PhbAS5bGBpq
         OCWdzOMUEeS2QA+cBWnP8J/w3E2ITkDfegbRLqHZ0veYCTl21EK+ifBGeFYtgEy9Neuz
         ECs0/LXY4WHpuFZrT0FoB3R/sTCZAE2obECqzTEcmWLH74FTXYe1SqA3i+lt+eWigkuF
         lHjOI1EgOO74408/9/M07ZAiI+ndPAfrwvAq1DiwUEV14I6G2UoHeYnmwoy2FyKfiRU3
         HmGrsdDAg12XJq2mU2qBKpQR08qNxQ0qclc2H/t7mSm8qopBPbiaoNnBveJpVBPXLFuB
         UbIA==
X-Gm-Message-State: AC+VfDz4PWtco94K7ME2O7b8ArHWrir++PXl5hDuo2as3kCn6Yyru+ND
        QQgMQsQdbqCAiVf8lih4TJKW5IWuzMRxtHn/naA=
X-Google-Smtp-Source: ACHHUZ5WWMRF8S4mg49Zu1cIc9MR9R9ECYWxvmLB2L87Ad48iPMBZJMLcx2ImZFiGbgqsSIQ0HMrIItnPDBpGz5LB00=
X-Received: by 2002:a17:907:a089:b0:932:7f5c:4bb2 with SMTP id
 hu9-20020a170907a08900b009327f5c4bb2mr3555970ejc.75.1682638972567; Thu, 27
 Apr 2023 16:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
 <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
 <CAEf4BzZ_4kcM5=Jo3JoWQWugS3wkrtoteyM8YqkykFvYywG+kg@mail.gmail.com> <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
In-Reply-To: <CA+PiJmTsEsUi3c5soodZHxS_PvMPnJG-4bFvdfpLq-kPZ0j4UQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 16:42:40 -0700
Message-ID: <CAEf4BzatBnBH8RHczLerMsW4NvTtx6xj5COjGzVvTkRxfciw4Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Daniel Rosenberg <drosen@google.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Apr 27, 2023 at 4:36=E2=80=AFPM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> On Wed, Apr 26, 2023 at 4:39=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Don't know, show the sequence of commands you are running?
> >
> > I have linux source in ~/linux, and KBUILD_OUTPUT set to
> > ~/linux-build/default. And it only takes this:
> >
> > $ cd ~/linux
> > $ make -j90 # build kernel
> > $ cd tools/testing/selftests/bpf
> > $ make -j90 # build selftests
> >
> > And that's it.
>
> I've tried the same, modulo some paths. I'm pretty sure it's version
> related at this point.
> The current issue I'm seeing is "error: indirect call in function,
> which are not supported by eBPF" when using GCC-BPF for
> progs/bind4_prog.c

I don't think GCC-BPF is able to compile selftests properly just yet.
So I guess the problem is that you do have some version of gcc-bpf in
the system and selftest's Makefile tries to build gcc variants of
test_progs? That's bad (I don't have GCC-BPF locally, and everyone
else apparently as well).

So for now just `make BPF_GCC=3D` ? CC'ing Jose, we should probably
agree on some criteria of "GCC-BPF is really capable of building
selftests" and adjust Makefile to only attempt GCC BPF build in that
case.


>
> Currently using clang 16.0.0 and gcc 12.2.0-14.
> I did manage to get it to build by just commenting out TEST_GEN_PROGS
> +=3D test_progs-bpf_gcc
