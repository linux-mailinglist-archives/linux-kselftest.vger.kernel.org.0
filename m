Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE04A64F880
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 10:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLQJoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQJoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 04:44:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3552BFAC7;
        Sat, 17 Dec 2022 01:44:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so4640792pjj.4;
        Sat, 17 Dec 2022 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0F7XgSh4lk06FOLRNHKF2kV+VO1INRzQ0bcSatSeds=;
        b=N5fjP7As1Zzz61dd6EC9g78w7G+5aKo/Mhv3GL+EHAq17YxuojHWYi9+efQSdr87qI
         ScZnVCj3qWpIaoOo+XXE04i24zu1uMrWg0Z7C0OK73TkVNH5pK7tCiwSj1uOWyWw8Ub4
         88o6TNAAREOdG8VfVTJfmjJvYvkuiPE0b/XUQHi2ZUBTDanzWvZUMavtjewAgJjuvCBW
         X4n0QKJ10d76vbc9wzXwUKH8v0QM1ZmwGwZ3wPvS8zH1sZvBnry3a0IaGz4Rq8tQCh8R
         jN8qMCnbpT7RfMbfhb+5O4NNnTeynaMJEUnaqnpOAOoCeAX2sjmc7M1abhOsvUG3AqJH
         2DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0F7XgSh4lk06FOLRNHKF2kV+VO1INRzQ0bcSatSeds=;
        b=HXZqWUFoDHIRbjV5cOJ+IXUJTzkHj303a+DXsyE8kZFLlK/I+VKIfPbfKzrAT+NS1Q
         WFDxv0yiX0CGL3RfZi/v5DgPsuRV9YP8NOX6DSolpq0DiKq6BNVknkv+HTemLlXX/tcl
         EOIxf59t10AF6sQ79DOqHlUuYf6GzmogerZFy/H6xTT7N69q1Vh9ntT84b2ayyyG5tkl
         UBPElcUIUdxBk+PpJOSVJ5TFV4zCdFUceXBgpaHE/Xcc5xRwvTYVkhkLyRLJXFzy8MRM
         JHYK81nX4EhvVsEg93sChKPswwTQHDsyB/oUYWE00CKjqpYNJ8Yny49w3vJiWBXs+KG/
         gchg==
X-Gm-Message-State: ANoB5pl8lZ3hi5C1EXEj9TOw96kVjbJmwuLcKEAMj0PnUQVcKWFbG9pW
        i8LI9caCFlpw1UMMiwmRx4c=
X-Google-Smtp-Source: AA0mqf7spPTJdbn+dXewR2kbKjWTP/4raxKZjpotHyZQ+gXGsBQzgnaBcD/ZEM4qYkaLFfLBX9Dcww==
X-Received: by 2002:a17:902:ee44:b0:189:7816:2eeb with SMTP id 4-20020a170902ee4400b0018978162eebmr36126544plo.3.1671270241550;
        Sat, 17 Dec 2022 01:44:01 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b00172fad607b3sm3074195plj.207.2022.12.17.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 01:44:00 -0800 (PST)
Date:   Sat, 17 Dec 2022 17:43:53 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
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
Subject: Re: [PATCH v2 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <20221217094353.srlmo2xydiek4e7j@mail.google.com>
References: <20221129134217.52767-1-changbin.du@gmail.com>
 <20221129134217.52767-2-changbin.du@gmail.com>
 <CAEf4BzZ=+DVkNT+Ti2L_ZyqrxwajfN04ou9XDrju704O6Ake4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ=+DVkNT+Ti2L_ZyqrxwajfN04ou9XDrju704O6Ake4Q@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 30, 2022 at 04:55:13PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Show the real problem instead of just saying "No such file or directory".
> >
> > Now will print below info:
> > libbpf: can not find '.BTF' section
> > Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index d88647da2c7f..1adc0f6019a0 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >         err = 0;
> >
> >         if (!btf_data) {
> > +               pr_warn("can not find '%s' section\n", BTF_ELF_SEC);
> 
> let's use consistent form of error messages:
> 
> pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
>
okay.

> >                 err = -ENOENT;
> >                 goto done;
> >         }
> > --
> > 2.37.2
> >

-- 
Cheers,
Changbin Du
