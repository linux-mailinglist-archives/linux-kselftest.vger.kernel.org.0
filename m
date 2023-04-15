Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9066E2E21
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDOBPz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 21:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDOBPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 21:15:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238486EAC;
        Fri, 14 Apr 2023 18:15:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dm2so50028473ejc.8;
        Fri, 14 Apr 2023 18:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681521352; x=1684113352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC4kxkJoU5H0KyEnir1WfQCWSx6t7d24Ud56sJ7PoSE=;
        b=hbwLdFnJtyk2KnbO/WdU6+2+hQM8kH0eWv+EzVzdZwyxorRpn6LVyC9YIPOwwR5VMh
         Pqf22M0lBsfTecsgzlYN5jg3PKrBNzbOPOY4ZvTFgzgza7yWjjPbsCFb9DYfYRja0ymr
         /vTxNaLOLFDC5n5Dmywh+q/j376tNhP3PHbztAMJcM7ySjefTeO9TBkhHh+ZOQYoXaZk
         685kc0KTChqFLvFU5HpiihQgzRXftkDY2aDQUpWw+ZryVo/liieskjXk8ejImAQgSe+N
         EMpkeMrs5wild3eQycaqaeZ65TkFXS/smf45Fd1npo/dyjv3HB6KUu4djG9n8D2QQxbB
         MjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681521352; x=1684113352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC4kxkJoU5H0KyEnir1WfQCWSx6t7d24Ud56sJ7PoSE=;
        b=JmW6PSOlh0dcHt5JQwPkbYu/dIzh++DdeofrGKHOu+3tT+ZbHmXwgq1dM1himrMAS6
         W+6siT1cH+s5JaRc596MW5DEJFNK7ZsnLmwg+8sxf36pvLekK97dNQjqBDmPQUtD8n/R
         8gZlCPNqgcRilU2kDX5pN7jkmbx3BuFyHuV5ziY6zteTtX474gnMyiIQ/i25+HAkfxtG
         S1mpad3NAc7qfAWNT12jCAWkThgFPgwjQD2jMgL0o+KO26PY7Hm+B3PukM6y2XsAKHWw
         AYgKl/eyihxuDu5QIDCLFqoonMhjwQIH90cnbhidyehRYISb5UhWPAXdds0Yp2YppGYH
         mShw==
X-Gm-Message-State: AAQBX9e3cl6H8DwgggdZs446Nqo0ulfn4Qbo9BjR0XVi5zPOKXDajpKV
        LPGzP34qg3mmDWE/ltkdFDIeh03f+bnZ1GMg/4S01PkwzZc=
X-Google-Smtp-Source: AKy350aZc1kDQXDRrsAJdoYDo7bzIbPeRF8KE0ZiYxoWv56d2Y08t0DwLjaJjC11xY/qgxHf1ArGOp0K0JH+2GdqjsA=
X-Received: by 2002:a17:906:4ace:b0:94e:d57a:49fe with SMTP id
 u14-20020a1709064ace00b0094ed57a49femr429549ejt.7.1681521352400; Fri, 14 Apr
 2023 18:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
 <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390> <q5rj72tmwlpzx6qgkromem5t7q6xmen52aavfr65olnuv52f3z@wzs4p3xz3635>
 <ZDl/KFLy7wOBa2tj@righiandr-XPS-13-7390>
In-Reply-To: <ZDl/KFLy7wOBa2tj@righiandr-XPS-13-7390>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 14 Apr 2023 18:15:41 -0700
Message-ID: <CAADnVQJFxoYqBisj4w_Mm35mf3gR6YTK0QvNjQfVSjfcQK33yw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Apr 14, 2023 at 9:28=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> On Fri, Apr 14, 2023 at 06:15:38PM +0200, Ilya Leoshkevich wrote:
> > On Fri, Apr 14, 2023 at 08:15:03AM +0200, Andrea Righi wrote:
> > > On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> > > > On Wed, Apr 12, 2023 at 2:59=E2=80=AFAM Andrea Righi <andrea.righi@=
canonical.com> wrote:
> > > > >
> > > > > Building bpf selftests with clang can trigger errors like the fol=
lowing:
> > > > >
> > > > >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > > > > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types =
assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompati=
ble-pointer-types]
> > > > >         s =3D &nlk->sk;
> > > > >           ^ ~~~~~~~~
> > > > > 1 error generated.
> > > >
> > > > I cannot reproduce this and BPF CI doesn't complain about it either=
.
> > > > What kind of clang do you use?
> > > > Some special version and build flags?
> > >
> > > I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special buil=
d
> > > flag (unless Ubuntu enables some different default flags, but it
> > > shouldn't be the case... I'll double check).
> > >
> > > -Andrea
> >
> > Hi,
> >
> > FWIW, I see similar errors when I don't use recent pahole.
>
> I'm using pahole v1.24.

I believe Ilya is correct.

struct sock___17 is likely coming from vmlinux.h
Which means that there were errors due vmlinux build which
caused multiple structs to be present in BTF
and therefore bpftool generated such broken vmlinux.h

The BTF section in such vmlinux is likely much larger than normal.
Let's get to the bottom of it instead of masking build error.

Please try pahole 1.25.
