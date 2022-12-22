Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE13654629
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiLVSwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 13:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLVSv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A029363;
        Thu, 22 Dec 2022 10:51:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x22so6955092ejs.11;
        Thu, 22 Dec 2022 10:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wjlf9HtdBwtd5BfrKK3NoAIyLd+UFeDv/NhLgMN1as=;
        b=A4i6MI57PBStveX53sUUEvZ+x7r1V47+5xIVi+hPAAfEWErZ06/pJUlK4Hst9pX/b8
         XlJsuixCjjzgxhcnCMGoxM5AEfOvrtXGsbYxsdOnJg3yL04oHA3B4hzJ63iRKf4XCCcy
         +4ezcGTXJvXs/CsX9i+BqbEmLHYworqDNE7nCKjxq7RHtsGCXdeSufvd8EQwmkpIZRmc
         7CMhvEKfe26E8krl41lM7uYmiegPQzavuvjHeheWfjx2y3/74PG8dDEFo/mfClmMm+fM
         iVkHNcOuHpAWzrA1430NggdBSgVRlkVZw79JIUMGN3drPnGPOodEjpMsNufwvlmYqKY5
         c3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wjlf9HtdBwtd5BfrKK3NoAIyLd+UFeDv/NhLgMN1as=;
        b=sMVEBBEi07v4TAMXgZRWCpzbOI5iR8X+oUAl+WHypYpUcSFjqDS5A5IqBsdZ9y74Du
         WKzDTMJzXNPR/O5T68klx8PhXey02s7/8F7MlhU6TmNj3AL/QuDHtzkrYTBpe7Segwb5
         ugeDvg9j1UFoarbgcNCr/VPnp3F8RblqYu5kmW1EkW+qF3NITFaJOhv0rpyycE+lbeL9
         HPl3n7FQzChXN+bMrMArhCxbYPsIRHi7Z6swibmE+SbPYWkn4P9bYOQ2n6R0l2sSvcbs
         9515Nu6InFegoga2k21UuO47WWaU2oglf+a7WyKq4Yp/X6tcmMTy1I9qDig7JQU1akMO
         ITTA==
X-Gm-Message-State: AFqh2koWSQNYZmnWX2+fJcnCR3XtcpdUaO9p06RlzoEtP6ItoMUZtbdt
        3madA/gprR9mbfzXbeImnhDURSPwoakw9PXXE4/hCS2p
X-Google-Smtp-Source: AMrXdXtN2rRR20R19i6vscCm4IWwKN/GFSFnTNL5An/JnKDjI+AGAskvFSxXaCgJEImPDZBjcbQAJSLtaww1FHflMl0=
X-Received: by 2002:a17:906:f209:b0:7fd:f0b1:c8ec with SMTP id
 gt9-20020a170906f20900b007fdf0b1c8ecmr453038ejb.114.1671735100056; Thu, 22
 Dec 2022 10:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20221217223509.88254-1-changbin.du@gmail.com> <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan> <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan> <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
 <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
In-Reply-To: <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Dec 2022 10:51:28 -0800
Message-ID: <CAEf4BzaiNOo_qqo16qLACfBe6esg2w+GafqU0TtwZMprpuDBEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF" section
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Changbin Du <changbin.du@gmail.com>,
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

On Tue, Dec 20, 2022 at 7:55 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Tue, Dec 20, 2022 at 04:13:13PM -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > > > > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> > > > > >   err = 0;
> > > > > >
> > > > > >   if (!btf_data) {
> > > > > > +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> > > > > >           err = -ENOENT;
> > >
> > > btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
> > > section, therefore, bpftool dumps error string "No such file or
> > > directory".  It's confused that actually vmlinux is existed.
> > >
> > > I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
> > > better choice?) to replace -ENOENT at here, this can avoid bpftool to
> > > outputs "No such file or directory" in this case.
> >
> > The only really meaningful error code would be -ESRCH, which
> > strerror() will translate to "No such process", which is also
> > completely confusing.
>
> Or maybe -ENODATA (No data available) is a better choice?

-ENODATA sounds good to me, yep.

>
> Thanks,
> Leo
>
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
> >
> > Anyways, I've applied this patch set to bpf-next. Thanks.
