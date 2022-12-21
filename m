Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F0652BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 04:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLUDzg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Dec 2022 22:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiLUDzd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Dec 2022 22:55:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BA1EED2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 19:55:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d15so14317365pls.6
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LG53lA26L/ncngjFCHRhyvrs5xf1POMXaF/i7pP2T2w=;
        b=jE8ug6sV2Ksmc1BjKlm2igxId/ENjDWpxJUXauuLCDWxTXh5ogm7qEZcDK557UrubC
         CrP+Ib8pkTZdIZEdo3nkWvf5LrUWmr4jzVAoTsF/GdW73ifIopte2waaoubyn/9pOerY
         WAfRkiwcznSlocee7G/hOSFzDtFRdLMj3soEhqVIsFxGlXL84laUyc3rDUUFohWw9FGU
         5ITGwmYLdSoJpaDqay0DHYJdne1DhHXdxu/ZhO87WLlQPJXGXJ9pxE54c3n2Yam5WAMJ
         Z4jmRQbXMkrl9CI0akL6yhV89RmgjdmqRaldmqh7AzpJGJFOPNEePFm2YBQD/wudUzJD
         Jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG53lA26L/ncngjFCHRhyvrs5xf1POMXaF/i7pP2T2w=;
        b=ugv2PVRMAdIYgcnBe9MTmmSbCcPIlguPkUJZlc6+yKp9VLG3ngFpf80qj9hBumg6nN
         e+Ea+mAwW2oRfT+4hO7iXaqk6vc/ud0emtAfXW0Sl6RKQq2/Ja4sn3AZ93mW4z3Cbq0Y
         Z8M7Ace3T/W8gdBB2hKTJXwu6LKvIYiQjIfCp1bydEhxbxzc54Bc4mcdc7l/eY1MWDci
         DhY+kzkaZGjvvaEcQ+BFwJx7/o+n0VaMPzXVYObjmJdRGSsvXUk5uHJDvVFATC38QxuN
         xpTUuxlT3+7vOd5ocX1Fg9ea6fRYCU3nW0gdNcI2j3ZMcJll/4ShThI34DcfWfYfYCUD
         CJ0g==
X-Gm-Message-State: AFqh2kqU0MwPL0bDLPmxpGFZmMo24OU/JRj9CtyHtthUWkC1LYqfeVXF
        FvR+fLvaCkTsMd+CnoylDduvMQ==
X-Google-Smtp-Source: AMrXdXucR+r5a6DTmL41q4+SegBpEAwe4Wonw64R9urkdQSpXNK8K3BOVXCMoHZst4hjRq8i7ONt9w==
X-Received: by 2002:a17:902:7405:b0:18f:a4e1:9908 with SMTP id g5-20020a170902740500b0018fa4e19908mr661321pll.15.1671594931937;
        Tue, 20 Dec 2022 19:55:31 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b00188fcc4fc00sm10165715pln.79.2022.12.20.19.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 19:55:31 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:55:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
 <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 20, 2022 at 04:13:13PM -0800, Andrii Nakryiko wrote:

[...]

> > > > > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> > > > >   err = 0;
> > > > >
> > > > >   if (!btf_data) {
> > > > > +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> > > > >           err = -ENOENT;
> >
> > btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
> > section, therefore, bpftool dumps error string "No such file or
> > directory".  It's confused that actually vmlinux is existed.
> >
> > I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
> > better choice?) to replace -ENOENT at here, this can avoid bpftool to
> > outputs "No such file or directory" in this case.
> 
> The only really meaningful error code would be -ESRCH, which
> strerror() will translate to "No such process", which is also
> completely confusing.

Or maybe -ENODATA (No data available) is a better choice?

Thanks,
Leo

> In general, I always found these strerror() messages extremely
> unhelpful and confusing. I wonder if we should make an effort to
> actually emit symbolic names of errors instead (literally, "-ENOENT"
> in this case). This is all tooling for engineers, I find -ENOENT or
> -ESRCH much more meaningful as an error message, compared to "No such
> file" seemingly human-readable interpretation.
> 
> Quenting, what do you think about the above proposal for bpftool? We
> can have some libbpf helper internally and do it in libbpf error
> messages as well and just reuse the logic in bpftool, perhaps?
> 
> Anyways, I've applied this patch set to bpf-next. Thanks.
