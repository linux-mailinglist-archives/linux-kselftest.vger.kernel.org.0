Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4454A1E4B5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgE0RFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 May 2020 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgE0RFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 May 2020 13:05:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD668C03E97D;
        Wed, 27 May 2020 10:05:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w15so14855291lfe.11;
        Wed, 27 May 2020 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUnBKzODcAzrzgKgROODXSk2egtIniTlnreewvHJg+Q=;
        b=azLSxtTR1p/u00nIy8EcTYchLxLS5R4RftePWqUU2QEclcP1HPADONmkT0+6GrfG1B
         H2ntkKZm6ivMeN1R9lK65OGVClqFrpHzykeIkWZWbzdo7neNN4uA00vLgd1V+Pl7vjHU
         b6rfgGVK9Tm7DPd3JosJjNuVEiRxSNMmuIm7xQdenXlEZ+iNoHttcD6NesGEjAd4PISL
         iuyY8sHsUwD3JAs9SegWO1sEeuG1ZX8Wx1GCpL3pAC2l5P1YIeMTc9XBTtOjDEBlnc0B
         aK3rsDgWJRrwnHQtQrcwouMoSY1QO8eoq37HtngLvbK+rYW4CVUit09Wyt3CCRbxRjsT
         8NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUnBKzODcAzrzgKgROODXSk2egtIniTlnreewvHJg+Q=;
        b=f0/GGsToGZtuJgeSQ94IhhFhrX/SAM/MFw75LuIrUfDit5Af8jsTcxLGme858q7IJu
         VhQT4b+kHpUBK5Rf3zkPXXCPe/qi35NyVXdFOQ529BNcXTkCdJqWORcrXXLEoaCO6uuR
         ePcHWw0ry3HLwRqcV8n/0ceYZ+UihDMEVaMRcRKuqmZVHYWpgtxgbNxSzzBNWFEMbZ9Q
         k1mWlNbJDbOaUdKMgef9LgDLee0v6Dd/pVWfznIzJlAgo6OM3DcKWxBkpM2/Rm95VgL9
         x5SHszExipDvfvco3T59BxaSYAlo2fzkI7nIHLCmbPwGNem5HVzJcD8NVbaCiw8b2vlB
         8+6Q==
X-Gm-Message-State: AOAM532DZ2ixypzhco6yKGdxEpTb5Q3KuE+MOVRCgO+Ec9VVMkhIXmNF
        ilat7Y7Gyw7KJ2ffByZbz/KRlK/LQnWRG88WB28=
X-Google-Smtp-Source: ABdhPJxzFkIIazzdR7rADsZDkis/pY/8VT38ZI5z6GzkChgRtctlvMrOCi3JqPbfvlFhyzncSSf1KwKh8HuDTapl2j8=
X-Received: by 2002:a19:84:: with SMTP id 126mr3573098lfa.174.1590599116248;
 Wed, 27 May 2020 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367so4k3.fsf@redhat.com> <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
 <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
 <xunya71uosvv.fsf@redhat.com> <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
In-Reply-To: <xunyh7w1nwem.fsf@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 27 May 2020 10:05:05 -0700
Message-ID: <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 27, 2020 at 10:02 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Alexei!
>
> >>>>> On Wed, 27 May 2020 09:48:04 -0700, Alexei Starovoitov  wrote:
>
>  > On Wed, May 27, 2020 at 12:19 AM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> Hi, Alexei!
>  >>
>  >> >>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:
>  >>
>  >> > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
>  >> > <yauheni.kaliuta@redhat.com> wrote:
>  >> >>
>  >> >> Hi, Andrii!
>  >> >>
>  >> >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
>  >> >>
>  >> >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
>  >> >> > <yauheni.kaliuta@redhat.com> wrote:
>  >> >> >>
>  >> >> >> There is difference in depoying static and generated extra resource
>  >> >> >> files between in/out of tree build and flavors:
>  >> >> >>
>  >> >> >> - in case of unflavored out-of-tree build static files are not
>  >> >> >> available and must be copied as well as both static and generated
>  >> >> >> files for flavored build.
>  >> >> >>
>  >> >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
>  >> >> >> is chosen in analogy to TEST_GEN_* variants.
>  >> >> >>
>  >> >>
>  >> >> > Can we keep them together but be smarter about what needs to
>  >> >> > be copied based on source/target directories? I would really
>  >> >> > like to not blow up all these rules.
>  >> >>
>  >> >> I can try, ok, I just find it a bit more clear. But it's good to
>  >> >> get some input from kselftest about OOT build in general.
>  >>
>  >> > I see no value in 'make install' of selftests/bpf
>  >> > and since it's broken just remove that makefile target.
>  >>
>  >> Some CI systems perform testing next stage after building were
>  >> build tree is not available anymore. So it's in use at the
>  >> moment.
>
>  > such CI systems can do 'cp -r' then
>
> It's a discussion for linux-kselftest@ (added).
>
> At the moment `make install` is generic kselftest functionality
> and since bpf is part of that infra it looks a bit strange to
> break it intentionally.

selftests/bpf is only historically part of selftests.
It probably should stop using kselftest build infra all together.
We had breakages in selftests/bpf in the past only because
of changes in kselftests bits.
