Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3906506F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 04:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiLSD7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 18 Dec 2022 22:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLSD7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 18 Dec 2022 22:59:53 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61BB865
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Dec 2022 19:59:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x66so5369096pfx.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Dec 2022 19:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zjmmMgytExuZc86mJHKJqPbT4q6H6HnndQ6YFHbefE=;
        b=u5u/i+5J3/oQvF8xoFgaMM9o1BRtRRCUXlDZu6Bsv5403ER8qQfHFd4Vt29XM8i2LT
         IZws1z+kyBfPLp5vM2iRMdB4xatd5YiE7vJgvjJ83woJTYxjX/6swDGzBcqTpgqWggX8
         lYn4IsNL9XEPAvXZ4qRc3xYrOQ7H7ujbvF/nFIrka3zifwWJpsZs69/5jY56E7lEzCnL
         aQFdB5HUaBY3itXimwfyV+yPFhxzdkT8o4fQmsFBgnoTLSG5FyciGm+ONYEgR3A7vSUh
         s9f+pgzYgE6My6lmMRM2EqLsKYwltSWfe0QdL8SMswiVRl6Jh1UywfXfUmMzPBdUokvO
         4uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zjmmMgytExuZc86mJHKJqPbT4q6H6HnndQ6YFHbefE=;
        b=ONz3O8oZVVOZKzu+RuFIb995oAYYnZAQiepW2GAe5jaRvBdjlg9hrXFpzimYQzXb5n
         j88VSMmgfrO1Muh3Y+ZXFT1TNAo47TmmYcIDodOIXA1PaTQyPo11XJ1aUSlqbjEvPSzW
         s4d8SFc5m59wKCxh72p5OnZFe5cbs6OfTXtKq9q+OR3/h+vqNKzTXW+bCE3CnsO4lSzf
         ZI5scuIK1cHLIf6xcUuZiE0VQnaoLIo9q79OBOxwFrRtEezhlBW1ETXS+xEoAMa/Qil+
         PEJJqUxfe5UKFfw0P6Ft02J88FXgC2Vjo6oW7lds3lr+Az+o3+Fl6rN6fgQRnoGDLo7j
         O7fw==
X-Gm-Message-State: ANoB5pn8ZiJDHY53eYipxafFttBacNo5irj6VpI5C/O6c/MmPQvZ7JCY
        sAHjGi4r4hwaORGfYF/vQPG8uQ==
X-Google-Smtp-Source: AA0mqf7V+EPzmndWL3rAKC3iGF5YDG/97eYSnVVZjzV4A6w3mGpONWXQx+dFwKG7isOQGlTUFZhxdg==
X-Received: by 2002:a05:6a00:a11:b0:578:866b:479a with SMTP id p17-20020a056a000a1100b00578866b479amr34638089pfh.1.1671422392382;
        Sun, 18 Dec 2022 19:59:52 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id 85-20020a621458000000b0056bbeaa82b9sm5366412pfu.113.2022.12.18.19.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 19:59:51 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:59:38 +0800
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
Subject: Re: [PATCH v3 2/2] bpf: makefiles: do not generate empty vmlinux.h
Message-ID: <Y5/hqqIwJIjdBSRh@leoy-yangtze.lan>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-3-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217223509.88254-3-changbin.du@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 18, 2022 at 06:35:09AM +0800, Changbin Du wrote:
> Remove the empty vmlinux.h if bpftool failed to dump btf info.
> The empty vmlinux.h can hide real error when reading output
> of make.
> 
> This is done by adding .DELETE_ON_ERROR special target in related
> makefiles.

We need to handle the same case for perf building, its makefile
linux/tools/perf/Makefile.perf also uses bpftool to generate
vmlinux.h, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Makefile.perf#n1067

Please consider to use a separate patch to add the same change in
Makefile.perf?

Thanks,
Leo

> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/bpf/bpftool/Makefile           | 3 +++
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 787b857d3fb5..313fd1b09189 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -289,3 +289,6 @@ FORCE:
>  .PHONY: all FORCE bootstrap clean install-bin install uninstall
>  .PHONY: doc doc-clean doc-install doc-uninstall
>  .DEFAULT_GOAL := all
> +
> +# Delete partially updated (corrupted) files on error
> +.DELETE_ON_ERROR:
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c22c43bbee19..205e8c3c346a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -626,3 +626,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
>  			       liburandom_read.so)
>  
>  .PHONY: docs docs-clean
> +
> +# Delete partially updated (corrupted) files on error
> +.DELETE_ON_ERROR:
> -- 
> 2.37.2
> 
