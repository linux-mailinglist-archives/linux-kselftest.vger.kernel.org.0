Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144965CA84
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jan 2023 00:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjACXrC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Jan 2023 18:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbjACXq7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Jan 2023 18:46:59 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDD1004E;
        Tue,  3 Jan 2023 15:46:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so78606786ejm.8;
        Tue, 03 Jan 2023 15:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3oSb7JXJVS/6HsFecUnGwQqOOB9BR+/FVmXe6sUvBjE=;
        b=gTbDgWlCH4NUcCEHgth2YTnVqtz4s4PKz+5t3gYtxN5MZc/LvN+nJoGJJTISFRSwrs
         w7pwymo+rn2BVMZudW2Xk6ZRv9sxlcO321RroJPRpATfUSEdl99e2+eBB6dFfFWEqyRr
         KHR4OANaK7QgwTNcrf6CpPboBwZ+H3m74npjgBNekhmRjZBp5BDdZTG28bEyZEKLe1aj
         LN0OAKAxx+3FOh4o6EhTjiNSXUmxihBDxy+xbXN2esrqPr8F88hN8W/l+k1QT4wDHM0C
         ZU3GvFfRsG3VaXyuhXEpYQVBw0ikmucnv4PLXcvg0Gabb1PjMBYaokh3LO1pb323WZ+9
         Z/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oSb7JXJVS/6HsFecUnGwQqOOB9BR+/FVmXe6sUvBjE=;
        b=57Q2UmTxvpuubDmxLNSh0wrvy9lWbT4yeOo87y3wZeDu/ld/x12HF5MFq5b4bJVCkf
         MJtxCR3EWQZ5IV9rrdNmYDNqVTQn/LKcE0X296WayEKMAcCDqYdPjpdnxyKIKlcAMAGU
         ecbhnMCAv0OfJQE0eDvC+aftYCDeuQUNnX5hUwGMgEQJfZ0VgXgFOBVdNq5JU4LgQvVS
         rhFKioxrHMj6tIzyR/5XuzhpFeek23i270FXQhvh2Zo8MNKje9mUSMUBPr0AQZJq53BK
         hlUzLc9GzS6XDNQtWUHOsiMDmd2+svcbVz6TjJjpa9OaUMug5d0hMRMJBykEgcOXZGTa
         sSJg==
X-Gm-Message-State: AFqh2kow8FDFah/O7bEibL4MExqnBpXI8ZZO/Z0+Hijqzve8o0cjnCXI
        A6YP5tEibEKT2dUQ+6vWLV0T4ygYOLsXsxDojrM=
X-Google-Smtp-Source: AMrXdXuhifcsN+8XoM8iEoIb5YJM9m8QkCS0hSkZA7F88v0P+GOkciVAILvtt3gP0l/69vPr+tvVBoIzvy8akGQX88U=
X-Received: by 2002:a17:906:f43:b0:84c:95c7:304d with SMTP id
 h3-20020a1709060f4300b0084c95c7304dmr2153565ejj.545.1672789616772; Tue, 03
 Jan 2023 15:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20221217223509.88254-1-changbin.du@gmail.com> <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan> <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan> <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
 <ea02357d-c5c7-aeff-e045-d639315d87e9@isovalent.com>
In-Reply-To: <ea02357d-c5c7-aeff-e045-d639315d87e9@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Jan 2023 15:46:44 -0800
Message-ID: <CAEf4BzZMJGrRhNeQeWB0fRsuRYUv01aZGhvDeFV2o5zdpRbR-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF" section
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 3, 2023 at 7:03 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2022-12-20 16:13 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Tue, Dec 20, 2022 at 3:34 AM Leo Yan <leo.yan@linaro.org> wrote:
> >>
> >> On Tue, Dec 20, 2022 at 09:31:14AM +0800, Changbin Du wrote:
> >>
> >> [...]
> >>
> >>>>> Now will print below info:
> >>>>> libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
> >>>>
> >>>> Recently I encountered the same issue, it could be caused by:
> >>>> either missing to install tool pahole or missing to enable kernel
> >>>> configuration CONFIG_DEBUG_INFO_BTF.
> >>>>
> >>>> Could we give explict info for reasoning failure?  Like:
> >>>>
> >>>> "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
> >>>> please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
> >>>>
> >>> This is vmlinux special information and similar tips are removed from
> >>> patch V2. libbpf is common for all ELFs.
> >>
> >> Okay, I see.  Sorry for noise.
> >>
> >>>>> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> >>>>
> >>>> This log is confusing when we can find vmlinux file but without BTF
> >>>> section.  Consider to use a separate patch to detect vmlinux not
> >>>> found case and print out "No such file or directory"?
> >>>>
> >>> I think it's already there. If the file doesn't exist, open will fail.
> >>
> >> [...]
> >>
> >>>>> @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >>>>>   err = 0;
> >>>>>
> >>>>>   if (!btf_data) {
> >>>>> +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> >>>>>           err = -ENOENT;
> >>
> >> btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
> >> section, therefore, bpftool dumps error string "No such file or
> >> directory".  It's confused that actually vmlinux is existed.
> >>
> >> I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
> >> better choice?) to replace -ENOENT at here, this can avoid bpftool to
> >> outputs "No such file or directory" in this case.
> >
> > The only really meaningful error code would be -ESRCH, which
> > strerror() will translate to "No such process", which is also
> > completely confusing.
> >
> > In general, I always found these strerror() messages extremely
> > unhelpful and confusing. I wonder if we should make an effort to
> > actually emit symbolic names of errors instead (literally, "-ENOENT"
> > in this case). This is all tooling for engineers, I find -ENOENT or
> > -ESRCH much more meaningful as an error message, compared to "No such
> > file" seemingly human-readable interpretation.
> >
> > Quenting, what do you think about the above proposal for bpftool? We
> > can have some libbpf helper internally and do it in libbpf error
> > messages as well and just reuse the logic in bpftool, perhaps?
>
> Apologies for the delay.
> What you're proposing is to replace all messages currently looking like
> this:
>
>         $ bpftool prog
>         Error: can't get next program: Operation not permitted
>
> by:
>
>         $ bpftool prog
>         Error: can't get next program: -EPERM
>
> Do I understand correctly?

yep, that's what I had in mind

>
> I think the strerror() messages are helpful in some occasions (they
> _are_ more human-friendly to many users), but it's also true that
> they're not always precise. With bpftool, "Invalid argument" is a
> classic when the program doesn't load, and may lead to confusion with
> the args passed to bpftool on the command line. Then there are the other
> corner cases like the one discussed in this thread. So, why not.

maybe the right approach would be to have both symbolic error name and
its human-readable representation, so for example above

Error: can't get next program: [-EPERM] Operation not permitted

or something like that? And if error value is unknown, just keep it as
integer: "[-5555]" ?

>
> If we do change, yeah I'd rather have as much of this handling in libbpf
> itself, and then adjust bpftool to handle the remaining cases, for
> consistency.

we can teach libbpf_strerror_r() to do this and if bpftool is going to
use it consistently then it would get the benefit automatically

>
> Quentin
