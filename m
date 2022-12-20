Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF147651FC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 12:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLTLej (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Dec 2022 06:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTLei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Dec 2022 06:34:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E73A3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 03:34:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso3388758pjp.4
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Dec 2022 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5PyI2r45cXC4VPa82F8kchhQCGmhp0Mxv2K4MPTItM=;
        b=L7GMgutRkj3qZcXp5mrTJlXEpwbu1F0SAXifZWMH02YWGo4hvzmU2XUWBMUyIKPJFb
         5dml+ojCzx4kiyathxHYShcXYhTOa3u0S/BqwYKviEQrPml5/Fgy48H1wOyQ0U2GUq61
         EsGrwuo4pQeBzGKkO4iKgeuzby26OGVIkolGy3Wl+Qdt1/BeZHkos9eNKDSG5lI/ajBG
         ETKAidRnsolKk5Q2DxQz+AMbznaYDhMdXCIEs133YNyQWmSur5hzrrRFAI0atg89Hrz5
         e59Bez8vgRnqVtGyF3USTpTbi06QgyvjAH4qmpuGPuyRwyUh/8+b95n0qk0JK4IMmFuD
         yoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5PyI2r45cXC4VPa82F8kchhQCGmhp0Mxv2K4MPTItM=;
        b=p09Mv3SEKhNTEfjPZ7ur+ukYP1JN5ErPkknEScSdAIEGoq5Us/CNFrvc84ICOWIuvE
         KcvjsRW/7JQuKcNLTBgy6c5n8FJtLPWye5GLi0uf5YL6yDDV7Ge9vgUxnQy8ID1yEWON
         83Qmkq1jbh5eiWpCDo1fFyudbFPcOnzpZkKgccIlM3T0OFxoqiRDdMW4yAfmEvvfQ01Q
         pndmSKxBi8Mh0/S+iimqiKeqVAwLXgeI9eZ6fJH7YnR1mluwJo1n5Mk3P7IWhU6S0TbZ
         VXOJO913QPNCBLnqimAUe/ifyeoSducnNSbDVvAmMQv64frIvZGXUWP2aI4lgpmq0FOP
         FRBA==
X-Gm-Message-State: AFqh2kq/17t0jpKT16ruHo1qp5br7qjTvWbWPFIMEKEl4Yl8/GPIPrmT
        qeQDBd4WM+Y6T6JGWXgTnxb8+A==
X-Google-Smtp-Source: AMrXdXvRJRRuzf5iiZZtPcbDflEUSnOntQw6ZxrOmIwG9QK7NVw99YemyhduBzYpoEASU5mYreb0CA==
X-Received: by 2002:a17:902:ea91:b0:189:c6fb:f933 with SMTP id x17-20020a170902ea9100b00189c6fbf933mr12287704plb.28.1671536076042;
        Tue, 20 Dec 2022 03:34:36 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b00186b758c9fasm9178299plg.33.2022.12.20.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:34:35 -0800 (PST)
Date:   Tue, 20 Dec 2022 19:34:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 20, 2022 at 09:31:14AM +0800, Changbin Du wrote:

[...]

> > > Now will print below info:
> > > libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux
> > 
> > Recently I encountered the same issue, it could be caused by:
> > either missing to install tool pahole or missing to enable kernel
> > configuration CONFIG_DEBUG_INFO_BTF.
> > 
> > Could we give explict info for reasoning failure?  Like:
> > 
> > "libbpf: failed to find '.BTF' ELF section in /home/changbin/work/linux/vmlinux,
> > please install pahole and enable CONFIG_DEBUG_INFO_BTF=y for kernel building".
> >
> This is vmlinux special information and similar tips are removed from
> patch V2. libbpf is common for all ELFs.

Okay, I see.  Sorry for noise.

> > > Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
> > 
> > This log is confusing when we can find vmlinux file but without BTF
> > section.  Consider to use a separate patch to detect vmlinux not
> > found case and print out "No such file or directory"?
> >
> I think it's already there. If the file doesn't exist, open will fail.

[...]

> > > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> > >  	err = 0;
> > >  
> > >  	if (!btf_data) {
> > > +		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> > >  		err = -ENOENT;

btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
section, therefore, bpftool dumps error string "No such file or
directory".  It's confused that actually vmlinux is existed.

I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
better choice?) to replace -ENOENT at here, this can avoid bpftool to
outputs "No such file or directory" in this case.

Thanks,
Leo
