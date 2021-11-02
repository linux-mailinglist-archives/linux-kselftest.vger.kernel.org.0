Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B6E4425B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 03:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhKBCtn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 22:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKBCtm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 22:49:42 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1FBC061714;
        Mon,  1 Nov 2021 19:47:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 131so37935365ybc.7;
        Mon, 01 Nov 2021 19:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7GY8h6zM68umXpHTD3qpIkLof+dES1ipLSMSnBrE5T8=;
        b=Gl45aXCtUBhlGR+iDCCxyJL3Y6Ofy7xmwcH19hf3JCXIToOuA1+nmquyAwHpGFCr4O
         aOCi4ELLnzn931eNERNgBJL/UzQHhc2LAllLRvwgumMWklfXVqdwoU3H9gFc2JjjKddn
         HfEiZd9A97clmshxUgXP6LHJUWKX9iCBtYzbACTT6Cp7ov2IUCepY/0cKFpVUikquGXN
         CKPjuaT1bEWt7I2h026+SRE5hyASO47yKyg7aAdHJBGD4b1xr3uhYnYSMgA4ClLu4bKu
         Xb7E+8I2Ittm6hYpzKATlf4cJ5zWsaGZ4m8GQoown/xkkHQhp1U0lE8rnBpVeLu7IPeR
         nzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GY8h6zM68umXpHTD3qpIkLof+dES1ipLSMSnBrE5T8=;
        b=cN8OaU3hmkxFg2J4pMCavmzFBbu/ih8XZ2FcjGJA3zMq2IdHgn+Zp/nHxOOzpjv+rO
         XmGaGgnmqkzwmwkuWAKC61Ye6NMMECaMeIu3Vw7j3gMlVwl988L03y1ppho8dnwNyljw
         cWxEXa7ZJRhztk72uocuXvTnC7W1eh2nPahNDP/jFCaZmZPQ7ea2Y0zwLhUpXNlUK3U3
         DxqLpD+YJI2E/bCeslvvYa12e7yh6AuLumyiFxxpoydnsWAn0gk4clUFB6oYOlYsOuAV
         QAzv8Fah0y5llYL/hB2xq1ZUQxD/sTo50HvoupXmePSHjPPIAuU/0Lywoc8MW3K1Ov4g
         uoJA==
X-Gm-Message-State: AOAM532darRD5tSCBbx9POGVPTj5M4yK+pP9g/i1SVBLw4nV2Mdzi63u
        KxNeN9yn7ZuZZKfIgc8H/HrN6UBLdU7VyX1eb3s=
X-Google-Smtp-Source: ABdhPJz1hPu/k/wxlDGHJO7gGbcjFf53NL9+t4aLujDIuhL+3Ti6dwPVa6m449dlC+1vSyPQnfW1BpJm886WDp8QO5A=
X-Received: by 2002:a25:d16:: with SMTP id 22mr28723765ybn.51.1635821227779;
 Mon, 01 Nov 2021 19:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211101124310.3947887-1-yangyingliang@huawei.com>
 <CAADnVQJS_2St=iaqHU+zasy_0A0bidJN=STnkHrNcSNL5vO1Dg@mail.gmail.com>
 <90518c5d-36ea-ec97-9f14-0687fdd6074f@fb.com> <CAADnVQ+aeAnBEN=dp92q0RBXT+Um1ha4_F=sQ7fr08Sa3qauLQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+aeAnBEN=dp92q0RBXT+Um1ha4_F=sQ7fr08Sa3qauLQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 19:46:56 -0700
Message-ID: <CAEf4BzaCQecivGZuXaVJyERZPg-T6+ewPRKBEvpJ366_ZNe+2A@mail.gmail.com>
Subject: Re: [PATCH -next v2] bpf/benchs: Fix return value check of bpf_program__attach()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Joanne Koong <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 1, 2021 at 3:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 1, 2021 at 3:21 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 11/1/21 3:00 PM, Alexei Starovoitov wrote:
> > > On Mon, Nov 1, 2021 at 5:35 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > >>
> > >> If bpf_program__attach() fails, it never returns NULL,
> > >> we should use libbpf_get_error() to check the return value.
> > >>
> > >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > >> Acked-by: Yonghong Song <yhs@fb.com>
> > >> ---
> > >> v2:
> > >>    don't use 'int err'
> > >> ---
> > >>   .../selftests/bpf/benchs/bench_bloom_filter_map.c      | 10 +++++-----
> > >>   1 file changed, 5 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> > >> index 6eeeed2913e6..4afaa4adb327 100644
> > >> --- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> > >> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> > >> @@ -304,7 +304,7 @@ static void bloom_lookup_setup(void)
> > >>          populate_maps();
> > >>
> > >>          link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
> > >> -       if (!link) {
> > >> +       if (libbpf_get_error(link)) {
> > >
> > > Please use ASSERT_OK_PTR() instead.
> > > See how other tests are doing it.
> >
> > I actually looked at this. ASSERT_OK_PTR() is defined in test_progs.h
> > and test_progs.h is ONLY included in files which eventually linked to
> > test_progs. That is why I didn't recommend to use ASSERT_OK_PTR().
> >
> > Maybe it is okay to include test_progs.h in benchs/*.c. Or we may
> > want to refactor to a separate header file to contain these macros
> > which can be used for test_progs.h and other applications.
>
> hmm.
> Looks like bench_ringbufs.c has the same issue doing:
> if (!link)
> and bench_rename.c too.

bench.c does:

libbpf_set_strict_mode(LIBBPF_STRICT_ALL);

and so on error all the pointers will be NULL. So it's ok to check if
(!link) and not use libbpf_get_error() at all.

>
> Probably would be good to fix in all bench-s.
>
> If test_progs.h cannot be included directly
> copy-pasting ASSERT_OK_PTR in a reduced form into bench.h
> is probably cleaner than open coding libbpf_get_error.
