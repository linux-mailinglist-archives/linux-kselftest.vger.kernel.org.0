Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404F7825A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjHUIjY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjHUIjX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 04:39:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B6ED;
        Mon, 21 Aug 2023 01:39:08 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso47328601fa.3;
        Mon, 21 Aug 2023 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692607147; x=1693211947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IECZJwfzWqV3ML3celupM7EA4bKWRVVmBVuuWwEJse8=;
        b=ACZZEkIwNKX4OpBbsKkMSBiqR2j0sV5I8zk/huB/zXn/DLqEHalmNlnDXVwCFyKGIc
         jOvkT9AF99Taj1E/+XQGnyfZms++dYnm0exV+OIMw7UhgLofE5ALAhgZgwWk/fNYoMVd
         ft/y5/7zyz87VC9CxqnQh+Dy3Fq+XZvQZJIr0FplJ4UmbcaqLTQpusu19kUk6QmshHWl
         HUC71VZxQcCCjIy6RN7L1BGL4ipjmmpgGgTGQYTpuxBRjbpQBQorQgFjDjmiUDO7Tl0z
         bM3uPvYHuzN1G2533tY9xVtRcjNykiffvIOJ2i4o9lGfEMdKQtyQf4ijWDlo/HhfTPoD
         Aqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607147; x=1693211947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IECZJwfzWqV3ML3celupM7EA4bKWRVVmBVuuWwEJse8=;
        b=Q/t9HydfiUvCZKAt+tE2X8cFtCbPfkD5FhASBok5tVYkC0/y6ysHhDP7F6WJfHnHk+
         Z5EKLjko09ttpjqZM4ZPSnBGBffIufcAAVpALh080aXCylbEG1qZE5o8MEwsjDlMLy/I
         NToOuWZN7B0Vi7sxcNne6AyUbbHeleo2TH2yzzhoL2NgWwYvWijayV4Mz08eHh969Wum
         N+TvMc9Ga4LuOlM3H6vjMpC+IeUW5qbbcFiKwxfUmk1FULI/Ln3TXSzlcbGK/m2Pg1w2
         rVkcdOrQWEMlkHBJan7IOnPEA7cB6apYRTdwTCr3uI517NBsZ0FdYvR+D9c04VG+ujT1
         8SHg==
X-Gm-Message-State: AOJu0YzDrjR6BProUw46yZRzx8xdDlYdoKz50cxR/J1HJrTa4kuNnRk8
        Zw8LyIbVmD3M4F+BF+B+yRA=
X-Google-Smtp-Source: AGHT+IGyo+Hzoy3CTUwnNc9+qaOLyCBmHDTjpmJXZtyJ03peLGY/jj272oiSmuHsNgBwb07eU1L0EA==
X-Received: by 2002:a2e:b613:0:b0:2b6:dfef:d526 with SMTP id r19-20020a2eb613000000b002b6dfefd526mr4039171ljn.11.1692607146656;
        Mon, 21 Aug 2023 01:39:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id md21-20020a170906ae9500b009829d2e892csm6175705ejb.15.2023.08.21.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 01:39:06 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 21 Aug 2023 10:39:04 +0200
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, sdf@google.com,
        yonghong.song@linux.dev, Rong Tao <rongtao@cestc.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZOMiqE0QY2Lrw2UC@krava>
References: <tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 21, 2023 at 02:45:20PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v6: Apply libbpf_ensure_mem()
> v5: https://lore.kernel.org/lkml/tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com/
>     Release the allocated memory once the load_kallsyms_refresh() upon error
>     given it's dynamically allocated.
> v4: https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/
>     Make sure most cases we don't need the realloc() path to begin with,
>     and check strdup() return value.
> v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
>     Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
>     Do the usual len/capacity scheme here to amortize the cost of realloc, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>  samples/bpf/Makefile                        |  1 +
>  tools/testing/selftests/bpf/trace_helpers.c | 59 +++++++++++++++++----
>  2 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 595b98d825ce..a49d0f759f5a 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -199,6 +199,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
>  TPROGS_CFLAGS += -I$(srctree)/tools/include
>  TPROGS_CFLAGS += -I$(srctree)/tools/perf
> +TPROGS_CFLAGS += -I$(srctree)/tools/lib
>  TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
>  
>  ifdef SYSROOT
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..316a7874a12b 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -14,14 +14,48 @@
>  #include <linux/limits.h>
>  #include <libelf.h>
>  #include <gelf.h>
> +#ifndef __must_check
> +#define __must_check
> +#endif

I think you need to fix this on samples/bpf side

I tried to play with the samples/bpf/ includes, but couldn't find a way to
make this work.. selftests base includes on tools/include, while samples
have $(objtree)/usr/include as first include and AFAICS the __must_check is
defined under __KERNEL__ ifdef

I guess the reason samples use $(objtree)/usr/include is to get some struct
definitions which are not in tools/include, but looks like some samples objects
already use vmlinux.h include, so that could be the way forward to fix that

or get rid of the trace_helpers.c or bpf/selftests dependency ;-)

> +#include "bpf/libbpf_internal.h"
>  
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static size_t sym_cap;
>  static int sym_cnt;

nit, sym_cnt should be size_t

jirka

>  
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +
> +	tmp = strdup(name);
> +	if (!tmp)
> +		return -ENOMEM;
> +	syms[sym_cnt].addr = addr;
> +	syms[sym_cnt].name = tmp;
> +
> +	sym_cnt++;
> +
> +	return 0;
> +}
> +
> +static void ksyms__free(void)
> +{
> +	unsigned int i;
> +
> +	if (!syms)
> +		return;
> +
> +	for (i = 0; i < sym_cnt; i++)
> +		free(syms[i].name);
> +	free(syms);
> +	syms = NULL;
> +	sym_cnt = 0;
> +	sym_cap = 0;
> +}
> +
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
>  	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
> @@ -33,9 +67,7 @@ int load_kallsyms_refresh(void)
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
> -
> -	sym_cnt = 0;
> +	int ret;
>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> @@ -46,17 +78,22 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
>  
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ret = libbpf_ensure_mem((void **) &syms, &sym_cap,
> +					sizeof(struct ksym), sym_cnt + 1);
> +		if (ret)
> +			goto error;
> +		ret = ksyms__add_symbol(func, (unsigned long)addr);
> +		if (ret)
> +			goto error;
>  	}
>  	fclose(f);
> -	sym_cnt = i;
>  	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
>  	return 0;
> +
> +error:
> +	ksyms__free();
> +	return ret;
>  }
>  
>  int load_kallsyms(void)
> -- 
> 2.39.3
> 
> 
