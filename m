Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B965186D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 02:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiLTBpQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 20:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiLTBot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 20:44:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1918E04;
        Mon, 19 Dec 2022 17:31:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 65so7511285pfx.9;
        Mon, 19 Dec 2022 17:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BigzFLPlvZFjuTMGj6sWmRm6jCkWTOK0szBmhDmhITw=;
        b=IDgps55Sh65Q7oz/Rf8hAbSLyRP+XSxK4k/WU8rBu8k+SlatD20ZIomDLuGq7l6yvQ
         FWmNGrmKEsboHbwFI4PWI9GYA7bmP3qTJzHnqJpObLhBklg0XWsXJUi23NIyszudeD4Q
         hduohbUdlAeS+SKdp0M8n5y0aK/Y8qEYj6OVwhJ0CUy5LmuAbLjA9PHp+hEYSXRQrPuP
         56gOwe8V09cd87aa9m7qzJkCT9M40CiFGCvREDKXL+EJf0C8yRvYoTw/XJFBwsRL385y
         rdOLd6sWBWS6iXPNg0z/H8GJ/sQcFy0zyD4GH7JREdtswQ0Z5f2xNDcD9aEeRErRjI7M
         qZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BigzFLPlvZFjuTMGj6sWmRm6jCkWTOK0szBmhDmhITw=;
        b=KHr5KoFz5oHwvHgq0SdeDq/Ois1duKkPvHpy0EAYkjOr5tVjtNfOuRZKjkz1uvRdDX
         nZOZbB5YtvrIeAb2h+gTVXU4CH2UKNaCZQAGoFC3p3J76u9gny0BsMvm4Amenkr05eK+
         hqIIDtrbj6l7M0TcKAmedWRFZRhB20rPFRHxjHuav6gw2s71kNRiaqaajrcxKqg0FmQ8
         6GccFT/VW4m/LT8Zw7vejZerAIWYBDbETgaDTwOnZesykvjpZDUwPtq1pWYFO/k1Zy/T
         qxIeA4R+/bSSmv9K7nf0IkiQuyiE41puBN5wIz4He3DNPWPmpdymcgPClcW7FIMGXAdw
         ED1Q==
X-Gm-Message-State: ANoB5pl/6j5TPhLKpCIZlEJF3IVMA6W7A+JK0/xdE7VdZEXtX+HtkyMY
        wn5XQxUqzpBaR+L5khhh72k=
X-Google-Smtp-Source: AA0mqf7OTy+bo/zeNJSAjDuAXyyFqND6wqeSCFRpp+bzccQ35QyHoEAwo9QkslCzipf7yZK8Mkblxg==
X-Received: by 2002:a05:6a00:d6b:b0:578:1e81:6776 with SMTP id n43-20020a056a000d6b00b005781e816776mr39981626pfv.22.1671499880114;
        Mon, 19 Dec 2022 17:31:20 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id 85-20020a621458000000b0056bbeaa82b9sm7322667pfu.113.2022.12.19.17.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:31:19 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:31:14 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
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

On Mon, Dec 19, 2022 at 11:45:08AM +0800, Leo Yan wrote:
> Hi Changbin,
> 
> On Sun, Dec 18, 2022 at 06:35:08AM +0800, Changbin Du wrote:
> > Show the real problem instead of just saying "No such file or directory".
> > 
> > Now will print below info:
> > libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
> 
> Recently I encountered the same issue, it could be caused by:
> either missing to install tool pahole or missing to enable kernel
> configuration CONFIG_DEBUG_INFO_BTF.
> 
> Could we give explict info for reasoning failure?  Like:
> 
> "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
> please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
>
This is vmlinux special information and similar tips are removed from
patch V2. libbpf is common for all ELFs.

> > Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> 
> This log is confusing when we can find vmlinux file but without BTF
> section.  Consider to use a separate patch to detect vmlinux not
> found case and print out "No such file or directory"?
>
I think it's already there. If the file doesn't exist, open will fail.

> Thanks,
> Leo
> 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 71e165b09ed5..dd2badf1a54e 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> >  	err = 0;
> >  
> >  	if (!btf_data) {
> > +		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> >  		err = -ENOENT;
> >  		goto done;
> >  	}
> > -- 
> > 2.37.2
> > 

-- 
Cheers,
Changbin Du
