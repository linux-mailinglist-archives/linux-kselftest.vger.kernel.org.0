Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5493442371
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhKAWdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhKAWdQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 18:33:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F6C061714;
        Mon,  1 Nov 2021 15:30:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so2278168plf.4;
        Mon, 01 Nov 2021 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRrO5EGa6gdgx8iaVIWAkfDm2sXFhoGpRVfHTpWiTSY=;
        b=opbZ5BZODCqrm5+tcV2j4pqGXufFb6qhNlpTaQb2o+yV8MU4lOH7oVnMK79GUPtt07
         qc39vG+pCkP583D7Aq37brysFtNv+lV3B6wONBQ0RRq7U6Lag9u2n24MAuyZF2Z0+YX2
         ArrAvWkX4Zy67OOwJAs/3HGjinTVorHDVf65fzGXypIPcqWUPtUztujtoi0EYNDqO462
         YnTYaT+iiKRra3Hb9Jqpv49vrVwS+lpAU/P1DmrtUK/brTHwrhjIoJA7JNEKlKOd29wD
         4bfhgPwrvcOz94QEvEL8X1aN7C1YJ9ylV7V5Hs2JGI/r2sXla4arOKbTFQJv76RZUvmZ
         L+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRrO5EGa6gdgx8iaVIWAkfDm2sXFhoGpRVfHTpWiTSY=;
        b=68LJ1YQYPkUxWe9Om3mSuO3fJagSOw27YHnpcD5Q0wTJY/e+EWvTx0LgmZ0vIKUm3B
         yfhpL+h1Z15ty3QySYUSkQ+LWBoRUPfubiUxlFKWBOFX6CVrUBNh3cFlGZGO7CWhOgSh
         UMPTZzqqb0yCaATYgT1E2jd8kLVBZq0ASCegcfeS0yocwKGFUeN0wg2SJnWLQUNDBc4D
         mRUxF6PWNmAvErlrK8ay9fCsRhPSRQqqsuIHytED17DF7dEn+ew50bTy3ZiHdp8Q0Fpj
         jsOq0GVdK6F1r1LSKFdmtNoUVv9hYBqOT9mI9qEfLGLSKDBZsJjTpS8ITEWHX6rMCRZ0
         MSWA==
X-Gm-Message-State: AOAM533+CzrQehRT/YV4v8OCxN35bXLJSj3BPDqZ/l/ejtsoIQVbiNcf
        tNqW4R3Gie0pDtwxgtxqHXBajG9KZ3HQ9IXoTXM=
X-Google-Smtp-Source: ABdhPJz+L8IoYIJ71wwqO6IX+4Z7mJ9xU8r2f8nTJk1G+Vt6yIiqvlfC3Zh8karFboiZirB6GmBCaDFRmTN5pS6ZFf4=
X-Received: by 2002:a17:902:f542:b0:141:fa0e:1590 with SMTP id
 h2-20020a170902f54200b00141fa0e1590mr4881822plf.20.1635805842627; Mon, 01 Nov
 2021 15:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211101124310.3947887-1-yangyingliang@huawei.com>
 <CAADnVQJS_2St=iaqHU+zasy_0A0bidJN=STnkHrNcSNL5vO1Dg@mail.gmail.com> <90518c5d-36ea-ec97-9f14-0687fdd6074f@fb.com>
In-Reply-To: <90518c5d-36ea-ec97-9f14-0687fdd6074f@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 15:30:31 -0700
Message-ID: <CAADnVQ+aeAnBEN=dp92q0RBXT+Um1ha4_F=sQ7fr08Sa3qauLQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] bpf/benchs: Fix return value check of bpf_program__attach()
To:     Yonghong Song <yhs@fb.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
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

On Mon, Nov 1, 2021 at 3:21 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/1/21 3:00 PM, Alexei Starovoitov wrote:
> > On Mon, Nov 1, 2021 at 5:35 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >>
> >> If bpf_program__attach() fails, it never returns NULL,
> >> we should use libbpf_get_error() to check the return value.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> >> ---
> >> v2:
> >>    don't use 'int err'
> >> ---
> >>   .../selftests/bpf/benchs/bench_bloom_filter_map.c      | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> >> index 6eeeed2913e6..4afaa4adb327 100644
> >> --- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> >> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> >> @@ -304,7 +304,7 @@ static void bloom_lookup_setup(void)
> >>          populate_maps();
> >>
> >>          link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
> >> -       if (!link) {
> >> +       if (libbpf_get_error(link)) {
> >
> > Please use ASSERT_OK_PTR() instead.
> > See how other tests are doing it.
>
> I actually looked at this. ASSERT_OK_PTR() is defined in test_progs.h
> and test_progs.h is ONLY included in files which eventually linked to
> test_progs. That is why I didn't recommend to use ASSERT_OK_PTR().
>
> Maybe it is okay to include test_progs.h in benchs/*.c. Or we may
> want to refactor to a separate header file to contain these macros
> which can be used for test_progs.h and other applications.

hmm.
Looks like bench_ringbufs.c has the same issue doing:
if (!link)
and bench_rename.c too.

Probably would be good to fix in all bench-s.

If test_progs.h cannot be included directly
copy-pasting ASSERT_OK_PTR in a reduced form into bench.h
is probably cleaner than open coding libbpf_get_error.
