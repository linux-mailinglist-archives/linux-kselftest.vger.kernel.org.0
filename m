Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9566DC909
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDJQF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDJQFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 12:05:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C580A7;
        Mon, 10 Apr 2023 09:05:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f26so7419448ejb.1;
        Mon, 10 Apr 2023 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142723; x=1683734723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVjLfNtBrKxtCcfxvBYkIZ+9NrsFrjbA5yaTUpDWRqk=;
        b=dNNEZ+J9y8fxGs583ZvtpMBFduZpF+gGXd85xKDJxb+cu8M0rETW02Opeu9Elvr0Q6
         oH8W82+ioklpFCgZs8zhTOwIi8DiC101XQOtSlVAIt3j2fW9V5udYVwGsimO3tTEIqff
         50vnLioJYOO59Y0ZqEis07iQ9m6tnQqy6NTB8GJoDCz0R0CoL/FB06F0yLaOq44Um1gl
         DcBt78mm4lxvA5AHylFXAPtzuOkwpzJptNC/br1JM5iJmQ2uqUpWSLmI8o4VGHoi4b36
         O8CSEQtYsE3tfZKW9LclU/OBjQzjzJhJ2sdx0UE8Oiq5bQ7yYou0jl+vaNBxCAtMSji7
         Gzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142723; x=1683734723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVjLfNtBrKxtCcfxvBYkIZ+9NrsFrjbA5yaTUpDWRqk=;
        b=h2rut+nnJdlSGft/uZpFuPMFQ1NNzgAObGYhrhkzTL/LtIN2XRQCjEW5ZdP/ozRBM0
         VqWri53ve9VhEmis0TmalBvV+OHN8s2vCxT49wwGqoYFbUKYgIKeHpMdbSAa0nn9te15
         HatBC8XtTmVdRAP2zNLqW0VOt+xHOVHx5KLQYeRp+45vIeY2S7OMRSnPV+u2PjAYE1+b
         xuXEVHWS6Uq4zDnuKfvBtAKO/RT0XXaWV9hPaNo/7kvidSarJOCYOks0iAGy/Z2vWqwH
         2EjJNue7pRH0bw9ZJ6UiSQ2n2/3KKjRq3Am7lILttj/rwxLQlyzeidJAYDVMxtyKIgdr
         VRTA==
X-Gm-Message-State: AAQBX9fNqYbmwfB2mLlyI6RlKwzIZ6q99qLZ9yqF7uwCe5nBIufo+JAM
        2q18hoJ21h6CIWVDGFhBebY=
X-Google-Smtp-Source: AKy350ZvJSA1nnzosjr5bhvvnr+1442VxjKvMzCAiyfLNjv0iIKyccNtq0yNenUUNRmcYEQFfkjimg==
X-Received: by 2002:a17:907:78ce:b0:94a:7d5c:2fab with SMTP id kv14-20020a17090778ce00b0094a7d5c2fabmr4064919ejc.72.1681142722963;
        Mon, 10 Apr 2023 09:05:22 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b0094d69608f5fsm281387ejb.97.2023.04.10.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:05:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 10 Apr 2023 17:05:20 +0100
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: Fix segfault
Message-ID: <ZDQzwP3K8WOImluJ@krava>
References: <tencent_0D62BF818D106C96C26594CAC76BF3281306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0D62BF818D106C96C26594CAC76BF3281306@qq.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 09, 2023 at 04:15:25PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> When the number of symbols is greater than MAX_SYMS (300000), the access
> array struct ksym syms[MAX_SYMS] goes out of bounds, which will result in
> a segfault.
> 
> Resolve this issue by judging the maximum number and exiting the loop, and
> increasing the default size appropriately. (6.2.9 = 329839 below)
> 
>     $ cat /proc/kallsyms | wc -l
>     329839
> 
>     GDB debugging:
>     $ cd linux/samples/bpf
>     $ sudo gdb ./sampleip
>     ...
>     (gdb) r
>     ...
>     Program received signal SIGSEGV, Segmentation fault.
>     0x00007ffff7e2debf in malloc () from /lib64/libc.so.6
>     Missing separate debuginfos, use: dnf debuginfo-install
>     elfutils-libelf-0.189-1.fc37.x86_64 glibc-2.36-9.fc37.x86_64
>     libzstd-1.5.4-1.fc37.x86_64 zlib-1.2.12-5.fc37.x86_64
>     (gdb) bt
>     #0  0x00007ffff7e2debf in malloc () from /lib64/libc.so.6
>     #1  0x00007ffff7e33f8e in strdup () from /lib64/libc.so.6
>     #2  0x0000000000403fb0 in load_kallsyms_refresh() from trace_helpers.c
>     #3  0x00000000004038b2 in main ()
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

I had to apply by hand, there was some fuzz:

  patching file tools/testing/selftests/bpf/trace_helpers.c
  Hunk #1 succeeded at 18 with fuzz 2 (offset 4 lines).
  Hunk #2 succeeded at 48 (offset 4 lines).

but other than that looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 09a16a77bae4..a9d589c560d2 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -14,7 +14,7 @@
>  
>  #define DEBUGFS "/sys/kernel/debug/tracing/"
>  
> -#define MAX_SYMS 300000
> +#define MAX_SYMS 400000
>  static struct ksym syms[MAX_SYMS];
>  static int sym_cnt;
>  
> @@ -44,7 +44,8 @@ int load_kallsyms_refresh(void)
>  			continue;
>  		syms[i].addr = (long) addr;
>  		syms[i].name = strdup(func);
> -		i++;
> +		if (++i >= MAX_SYMS)
> +			break;
>  	}
>  	fclose(f);
>  	sym_cnt = i;
> -- 
> 2.39.2
> 
