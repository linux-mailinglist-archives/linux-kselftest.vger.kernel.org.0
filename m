Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329577E71E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjHPQ70 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345021AbjHPQ64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 12:58:56 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172AB1FC3;
        Wed, 16 Aug 2023 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=D2PHbo0EsztXcxRMSJk7ynouAeB9gcGPg6mbvGpkXA4=; b=IIimy8fCNOMjHgos9lmvKWQNPN
        iGfrBehzONu1qS59k07b7d4+YSOY2ES5Aa2jREQdOhs5mWLvtcfwYgxILvNudfv0eYVQkIJxW95Yk
        XobtiM/k/tdcKCxBA1aJOlkWkNqejmVyaWPqRJuNgFntjhyXIukStAHGGuTyjp4dsnwcjcs98gekD
        x44e8cIyPL4NusHQsHlnHIgs4uU+PeSFnM/k2a90xxF8w0H+negx/xJajaBc0oEmc6l8tJYisMz9J
        igd+Wzzy1mk9gk+BofvAr7NQMVqAxiIltqf8KOQx4Lt+R4vEKZyUTcevJ660YH5X2Za6s4c2S8TSk
        JxYep2EQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qWJqw-000AGF-TS; Wed, 16 Aug 2023 18:58:38 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qWJqv-000SBc-R0; Wed, 16 Aug 2023 18:58:37 +0200
Subject: Re: [PATCH bpf-next v4] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
To:     Rong Tao <rtoax@foxmail.com>, sdf@google.com, andrii@kernel.org
Cc:     rongtao@cestc.cn, Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:BPF [SELFTESTS] (Test Runners & Infrastructure)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <60da4749-3009-0e40-90bd-90cd03395e45@iogearbox.net>
Date:   Wed, 16 Aug 2023 18:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27002/Wed Aug 16 09:38:26 2023)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/16/23 3:36 AM, Rong Tao wrote:
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
> v4: Make sure most cases we don't need the realloc() path to begin with,
>      and check strdup() return value.
> v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
>      Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
>      Do the usual len/capacity scheme here to amortize the cost of realloc, and
>      don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>   tools/testing/selftests/bpf/trace_helpers.c | 46 ++++++++++++++++-----
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..a1461508925e 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,10 +18,35 @@
>   #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>   #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>   
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static int sym_cap;
>   static int sym_cnt;
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

Since this patch is about improving the load_kallsyms_refresh(), I mentioned in the v3
that it would also be good to have the counterpart to release the allocated memory once
the test concluded or upon error given it's dynamically allocated.

>   static int ksym_cmp(const void *p1, const void *p2)
>   {
>   	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
> @@ -33,9 +58,14 @@ int load_kallsyms_refresh(void)
>   	char func[256], buf[256];
>   	char symbol;
>   	void *addr;
> -	int i = 0;
> +	int ret;
>   
> +	/* Make sure most cases we don't need the realloc() path to begin with */
> +	sym_cap = 400000;
>   	sym_cnt = 0;
> +	syms = malloc(sizeof(struct ksym) * sym_cap);
> +	if (!syms)
> +		return -ENOMEM;
>   
>   	f = fopen("/proc/kallsyms", "r");
>   	if (!f)
> @@ -46,15 +76,11 @@ int load_kallsyms_refresh(void)
>   			break;
>   		if (!addr)
>   			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
> -
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ret = ksyms__add_symbol(func, (unsigned long)addr);
> +		if (ret)
> +			return ret;
>   	}
>   	fclose(f);
> -	sym_cnt = i;
>   	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
>   	return 0;
>   }
> 

Thanks,
Daniel
