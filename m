Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580277F1FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbjHQIV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348880AbjHQIVV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 04:21:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4AE273F;
        Thu, 17 Aug 2023 01:21:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bfcf4c814so984926966b.0;
        Thu, 17 Aug 2023 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692260478; x=1692865278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBSUC9nLpujZz5zGGjUSv4NeViKHnBjmgypxXeOUcgE=;
        b=MIgVVh8nKvI6iyrSAbEuu5zot6UxH3eWTH5khCh57BqGH4BWLtBoQnZbRc3KK9NWiR
         CRJm1QQkh78SObWJYEROKZwR1oDjSl4NcUh+N2jbwAQg/tH5RWrrsLVG+BdCaBV4vv6b
         FptR2/x6jQmW1oBSFaRVeCbP7kzH/eVxkNrJfuinlEALRZ8pTqE5GJ1InVW6Zr0XA0q8
         ivyq7NFnioo0xNZW185tH474Hom38mTzoBPgqEiPyjokGBN5EgUe+IIM0Yx0TABq0aUA
         M/fYKa4Ds/f5psEYvkvO6ihJyt+SOo6MKOJ3T5D3rK2K+XQH/sJXdmWsi1K0YFjayNYx
         0Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260478; x=1692865278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBSUC9nLpujZz5zGGjUSv4NeViKHnBjmgypxXeOUcgE=;
        b=P5ffrjxPmXx0g7zyzepchBoGBYP6HO6qy6XOXEcSApmST78FsRHCjJUk0rHz6mbIu+
         EXdtLFxu6Q+FqOyLzhkYLkVz42atU1hwwIlP3g1p3c3Bv1LpgxW0rUyVpkfm0YXC/vG6
         8xfKZXi4BaGTh/aDHrvkrPj2Cy9F1TATMDAL76K8RA6fLcN5DdmQ7q6209LzPjLoDmSN
         plklhNnBWrn8V29/CjOaFR03sd+9VxXWzi1nT3zSWVB2S4MpJYjMCRu/fNKBlfdPngoQ
         WdzpF95eHwgrLhFlCFuotF0fyDmH3qrf+f0N9uixaAT52UY4gTE+rXsNmYFSXrW8/lQL
         QWTw==
X-Gm-Message-State: AOJu0YzvXzl6m5TbXyojnOmpJGJB6Qcao6S8GZuiAh2CuGH9gpOxOH/h
        ZNv4QXEJGFwH4MVJcbyqQUA=
X-Google-Smtp-Source: AGHT+IG8F8vWRoMbRxe0XzNivqXEbX46cG0CiKv0fAc3Mk9H28wKWLwrT4liVmfGqnqnBCT9aryb1g==
X-Received: by 2002:a17:906:4bd5:b0:99c:da24:bdb7 with SMTP id x21-20020a1709064bd500b0099cda24bdb7mr4578560ejv.71.1692260478226;
        Thu, 17 Aug 2023 01:21:18 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090682d100b009944e955e19sm9809102ejy.30.2023.08.17.01.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:21:17 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 17 Aug 2023 10:21:15 +0200
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sdf@google.com, daniel@iogearbox.net, andrii@kernel.org,
        rongtao@cestc.cn, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZN3YeyMkgEg1IoKP@krava>
References: <tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 01:03:45PM +0800, Rong Tao wrote:
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
> v5: Release the allocated memory once the load_kallsyms_refresh() upon error
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
>  tools/testing/selftests/bpf/trace_helpers.c | 62 +++++++++++++++++----
>  1 file changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..0053ba22f0cb 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,10 +18,47 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static int sym_cap;
>  static int sym_cnt;
>  
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;
> +
> +	if (sym_cnt + 1 > sym_cap) {
> +		new_cap = sym_cap * 4 / 3;
> +		tmp = realloc(syms, sizeof(struct ksym) * new_cap);
> +		if (!tmp)
> +			return -ENOMEM;
> +		syms = tmp;
> +		sym_cap = new_cap;
> +	}

sorry I did not notice earlier, but we have helper for realloc

  libbpf_ensure_mem

check the usage for example in prog_tests/kprobe_multi_test.c

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
> +}
> +
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
>  	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
> @@ -33,9 +70,14 @@ int load_kallsyms_refresh(void)
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
> +	int ret;
>  
> +	/* Make sure most cases we don't need the realloc() path to begin with */
> +	sym_cap = 400000;
>  	sym_cnt = 0;
> +	syms = malloc(sizeof(struct ksym) * sym_cap);
> +	if (!syms)
> +		return -ENOMEM;

libbpf_ensure_mem will also take care of first allocation and the capacity increase

jirka

>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> @@ -46,17 +88,17 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
> -
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
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
