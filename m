Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F8652A5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 01:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiLUAOf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Dec 2022 19:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiLUAOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Dec 2022 19:14:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C9205FB;
        Tue, 20 Dec 2022 16:13:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so33128844ejc.3;
        Tue, 20 Dec 2022 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CkWUTtnXtFdBonK+Hr2bihTCTKwFRgaMGiP5ubhFJM=;
        b=RxemTcOkAAOCSnKpzXAa20/l/IF8AGKsxrBEYMJMESw7nLG1JJUiYFpw3WNmBHKMYx
         2xUQwe56HvDbpg1oH5xV4EknU3X1jTx6gzFtarI2XYu9ogv3iYILKxxZxq4Xgseu0yBE
         Ak/AW9eWEVzU+slDXruur04265h479VtK5C8T+2mby54siRIrgg5QIytIiG/1RnWs4t4
         UyOIVDxizA9POLZ0ggM7+REZyWcgEHfMqGLws4nTrBIg9fTRIT1VoPYiB9cZ7UQn7J/h
         s/XFzOmTRv9JQk6ec2sqdR3DPa2ZQHXJBJ3qpIhymk5AwWJ2XaqWqqGIz50dYFUBI9l7
         cvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CkWUTtnXtFdBonK+Hr2bihTCTKwFRgaMGiP5ubhFJM=;
        b=Sp1i1vbKEyC2ht1SB5lSz0mH76NHuFlI+8e+x79YmcpvUKrylTbNUMnnYHJ7UCQiHZ
         WAqWNo+VAoUg8LX9H6b738r4CF3mLHv6e829D5IByoRUDnhjMyj+JyC9no8kg4sXqLX6
         gYWfDqSmNq2LfK3ce5hxcmOoDjD19Oait6OXMGVN8Xqie6EAllC8xuZ32X/x1H1Lt9kT
         A2+e0YoFSZJ9sGIB+mPzt6BrQMiF4fmvaV7E4NSV+Isv/aPlSc/ob/I1HKvg4HaAREYB
         NTvInaoY4cw8vtKtsqx5KN+9cCpq07hxA/vn+dPDzzK8UQ9+oYqpPCKE2HK+IjCRxdks
         6TOQ==
X-Gm-Message-State: ANoB5plBEXc9ofK0FjlrTGdZId/UQnEaYTXPYPwuVhJq89AnThxaeIjz
        HzkJ1YyZ9aS2B9gcnfG+OyIs/OpQ+6841K0tl5g=
X-Google-Smtp-Source: AA0mqf7oW7LbTNUBSaYQWZxQTaza7/YMvZf/jqph3Skp5ZguAZC6ORw10jyzshIECGsB5Rc0GjO574CzEKp94mja9m8=
X-Received: by 2002:a17:906:3e53:b0:7c1:1f2b:945f with SMTP id
 t19-20020a1709063e5300b007c11f2b945fmr7436538eji.302.1671581605781; Tue, 20
 Dec 2022 16:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20221217223509.88254-1-changbin.du@gmail.com> <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan> <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
In-Reply-To: <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 16:13:13 -0800
Message-ID: <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF" section
To:     Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
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

On Tue, Dec 20, 2022 at 3:34 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Tue, Dec 20, 2022 at 09:31:14AM +0800, Changbin Du wrote:
>
> [...]
>
> > > > Now will print below info:
> > > > libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
> > >
> > > Recently I encountered the same issue, it could be caused by:
> > > either missing to install tool pahole or missing to enable kernel
> > > configuration CONFIG_DEBUG_INFO_BTF.
> > >
> > > Could we give explict info for reasoning failure?  Like:
> > >
> > > "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
> > > please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
> > >
> > This is vmlinux special information and similar tips are removed from
> > patch V2. libbpf is common for all ELFs.
>
> Okay, I see.  Sorry for noise.
>
> > > > Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> > >
> > > This log is confusing when we can find vmlinux file but without BTF
> > > section.  Consider to use a separate patch to detect vmlinux not
> > > found case and print out "No such file or directory"?
> > >
> > I think it's already there. If the file doesn't exist, open will fail.
>
> [...]
>
> > > > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> > > >   err = 0;
> > > >
> > > >   if (!btf_data) {
> > > > +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> > > >           err = -ENOENT;
>
> btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
> section, therefore, bpftool dumps error string "No such file or
> directory".  It's confused that actually vmlinux is existed.
>
> I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
> better choice?) to replace -ENOENT at here, this can avoid bpftool to
> outputs "No such file or directory" in this case.

The only really meaningful error code would be -ESRCH, which
strerror() will translate to "No such process", which is also
completely confusing.

In general, I always found these strerror() messages extremely
unhelpful and confusing. I wonder if we should make an effort to
actually emit symbolic names of errors instead (literally, "-ENOENT"
in this case). This is all tooling for engineers, I find -ENOENT or
-ESRCH much more meaningful as an error message, compared to "No such
file" seemingly human-readable interpretation.

Quenting, what do you think about the above proposal for bpftool? We
can have some libbpf helper internally and do it in libbpf error
messages as well and just reuse the logic in bpftool, perhaps?


Anyways, I've applied this patch set to bpf-next. Thanks.


>
> Thanks,
> Leo
