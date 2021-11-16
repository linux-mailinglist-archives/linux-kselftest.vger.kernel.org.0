Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BA452A5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 07:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhKPGNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Nov 2021 01:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhKPGNN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Nov 2021 01:13:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA303C061570;
        Mon, 15 Nov 2021 22:10:15 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 131so54230288ybc.7;
        Mon, 15 Nov 2021 22:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS3V9ZFiQuQx5sGhaVvxlp3tQZvQUYn0CxpmzAd9h/0=;
        b=IkoAiQwEjjhwLdEb3iEhseLmoeXU3PhOgvRVbqZ1rk3D4WWg0qAjq6uDLc+Uyv4uje
         BCnT1b7Juxb1XhfeyjtRiK4JF31AtKpY2hhwCAUCrNnz7lu8DgO/IlJ6CE/8BKPmH5IN
         eVUeJHbblM1T62OHHFCnzDVxq1j8AVPB6H6awq4C1l4dIUGXcVVF9TrT14rf4WatIKvW
         rrAEg3k4cXh0QYmBKR+AtH/5tbKO/umEsMnUpe3eXXDeXnzc9gHCd8mfPx/GEcL7asca
         3n2qT8acHznVb/N8i6JkM1q94XxJOFEDPnsngnk+1XkbfJRJzSGHgf9PTa4Y6IKmclNE
         aqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS3V9ZFiQuQx5sGhaVvxlp3tQZvQUYn0CxpmzAd9h/0=;
        b=MpIyVYEg+h4wjCSJufgQpeAVJhe7Dsy+a2q2H6kd44MVzVh5DV3OGxtTeqy5pL5K8X
         EMAS1Zd/aos4jPEsUGBD/sH0jcIolxMMRH1i5A4g6+6P188aJ2/TWAgjgB2WIEepV0LB
         Yzvgvh8rryJhoYGJPwllXipzbg/A0ldSNcu+CK+PD8CGju36sqtTDnQRZC2HXyZZIRhB
         JX00Ta2jmadJuJK2EOnsjfaDF/xMFdXgddlcl6x5qdMj5MONigjlPH6vcXwUJ3GoAOeQ
         pFHorlSLaVdjorJoqRYO3LsUulHqR6nsR/wiqWxha9hLYfh2J4ywLcwZjc6YZp8fzLEf
         PsZQ==
X-Gm-Message-State: AOAM533SX0ob+wgg/hlSDvq2z+dukI601yHhiVYbe372PTXtDFUh6kQk
        8lLv2MXv9rwRQ/ymintN8Zqk3BnXZ+Q+TfjCGds=
X-Google-Smtp-Source: ABdhPJw+yz0E/TV+dfgEdSDWXQzvt2+zFLlF76FxNEzbyIrgRqbtAqR8VpYn8vFjHjRMXF4elVl9pscLOmco9Kg9czM=
X-Received: by 2002:a25:d16:: with SMTP id 22mr5524100ybn.51.1637043015216;
 Mon, 15 Nov 2021 22:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20211112155128.565680-1-jean-philippe@linaro.org>
 <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com> <YY6WLDizLBxnhgnP@myrica>
In-Reply-To: <YY6WLDizLBxnhgnP@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Nov 2021 22:10:03 -0800
Message-ID: <CAEf4BzbS-4sWORntzqh7qhEo=5cpzca0WA5ars70LxwzZwxgKA@mail.gmail.com>
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 12, 2021 at 8:28 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Fri, Nov 12, 2021 at 04:17:21PM +0000, Quentin Monnet wrote:
> > 2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> > > building") uses the target libbpf to build the host bpftool, which
> > > doesn't work when cross-building:
> > >
> > >   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
> > >   ...
> > >     LINK    /tmp/runqslower/bpftool/bpftool
> > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
> > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
> > >   collect2: error: ld returned 1 exit status
> > >
> > > When cross-building, the target architecture differs from the host. The
> > > bpftool used for building runqslower is executed on the host, and thus
> > > must use a different libbpf than that used for runqslower itself.
> > > Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> > > build makes its own library if necessary.
> > >
> > > In the selftests, pass the host bpftool, already a prerequisite for the
> > > runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> > > the bpftool that's already built for selftests instead of making a new
> > > one.
> > >
> > > Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> >
> > I realised too late I should have cc-ed you on those patches, apologies
> > for not doing so. Thank you for the fix!
>
> No worries, I usually try to catch build issues in bpf-next but missed it
> this time. I'm still slowly working towards getting automated testing on
> Arm targets, which will catch regressions quicker.

Are you planning to contribute it to BPF CI? Or you meant you have
your own separate system?

>
> Thanks,
> Jean
