Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883C1659800
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Dec 2022 13:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiL3MKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Dec 2022 07:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiL3MKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Dec 2022 07:10:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB675FF3;
        Fri, 30 Dec 2022 04:10:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s7so21685996plk.5;
        Fri, 30 Dec 2022 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4U3BkLQZ9M9DgvTBwDUlVlqOVR0cvh9rJdBcrlurSBA=;
        b=OVIpeIKhpu5JuHGPI/aq/PokRqhuXiAFB23ZB/9r2rb7QhFDCblexWoehHQw/+egq+
         KUWh/tl4ILetP0dL6wxrSAVzPfZ6c8YkZf4rYsfcU3Wj1kTU23+YmHCEID66sJSaHoYi
         tOLxjvtwjHYPvkBZKTaB1Jac5HO0fjkcwm6tAY37sY9nByCEYeEjKEXKZ/ceJzOjR/U7
         4sYNtDLsIoxCTWX6YZ4+7re8abKxFx09NkKOqJbHSColOFJHOnpdqSDYBWvLezsd40AL
         J3QO2CuKIR956aMfXLnCEsWrJwFD2TuTC338NLKQnoJI94hqpsnec5EpVpYX3ub3/mlf
         ow6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4U3BkLQZ9M9DgvTBwDUlVlqOVR0cvh9rJdBcrlurSBA=;
        b=6KyNCAVdOx0jLs6+LFW27S6oA1sU0yNY/F25VU+lGfCVQstU4rcejCqsbqRc8IOYcJ
         R8CMKSyrDq19J92Yu2V+sdhmNiQtSCWRevi89mhvkwtXsOEFf19xgx+MmVAe/n3pkhdo
         NxDhiUNzh0VseW5sG+DJyZnRIIxZqmzdfACC5E3fBWXvxsX1i9mnVx3iMQc0AFpVQP0o
         QLN58QVjGRHWha/2oI3hn3nynEtmJKyHfTfC9gFnlJQ4mzXqpNLUOPzxcEqYLJp1u1RJ
         G3W8bRnmi05TMceqsdPspDKDtzuGlgrUpgphnOkIXXT5th0gYeNhZ93Zu2L+zQZyDXDo
         wCpA==
X-Gm-Message-State: AFqh2kp4IihnY0cKf63ULBpGCBz/gQmP5dBv+PqUW8AUolvijpWeGVNU
        2WPw/UFm0q677UtbjtgWUiQ=
X-Google-Smtp-Source: AMrXdXsK+oQ1/QesWLbiOJuKHPfK3TRJdiFnhPnuZUn/s2uG8ER52z8ggxCDyTRp7FDsBOkqFRtS1w==
X-Received: by 2002:a17:902:8bc6:b0:187:16c2:d52c with SMTP id r6-20020a1709028bc600b0018716c2d52cmr35350278plo.50.1672402219123;
        Fri, 30 Dec 2022 04:10:19 -0800 (PST)
Received: from mail.google.com ([103.135.103.220])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b00186b758c9fasm14806581pll.33.2022.12.30.04.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 04:10:18 -0800 (PST)
Date:   Fri, 30 Dec 2022 20:10:20 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
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
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <20221230121020.boqhrujywruq3oi2@mail.google.com>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
 <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
 <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 21, 2022 at 11:55:24AM +0800, Leo Yan wrote:
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
> 
> Thanks,
> Leo
>
Yan, will you have a patch for this suggestion?

[snip]

-- 
Cheers,
Changbin Du
