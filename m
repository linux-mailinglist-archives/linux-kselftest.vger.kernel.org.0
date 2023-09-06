Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFB7944C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbjIFUyX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 16:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbjIFUyX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 16:54:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD28519BB;
        Wed,  6 Sep 2023 13:54:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c3df710bdso281842f8f.1;
        Wed, 06 Sep 2023 13:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694033656; x=1694638456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kVCXHAEjEM8goSFYvxXt/gFxYeO8nmrzpZAICgJpDE=;
        b=WRg50l3e054AP/FJdPcq5EkqENfuhzGraycFkPkkaIWsc68bbq69C99KHh1tp37ao0
         Ii9NJ5vFq4mjeykZwiUHPPBVTbU+tMT/YHJQuV/KxowP7+zIqDdYL9h+04MYcA5Vy7S+
         2rBV3+K4uAjtRtc6QwJmD5qDO46q4oQENpqrDQB7EFqG9FIiyvh55ah+Vg3S2lrEfhGI
         O7VXINFDPCCk6n35kkahnRGqhW9NNUHejhUM4VQzGjj2ahupUb4ZhGDHFxN+u7iI7z1n
         pOYb4tvqrWmNDspaZ97z68Y1mm6CFKKCIvmvEJbhaCz3Im7uJ2SpQoXoZaCKG0aPyPjL
         ViMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694033656; x=1694638456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kVCXHAEjEM8goSFYvxXt/gFxYeO8nmrzpZAICgJpDE=;
        b=PxFHxbyarRPsr6hjMH6p7opvQyEXF+MtEuIV9ATQzo8Zi3dx85sEHVtWixm1goYXLG
         I8bjLOATPzVPQg2a1/2LHud4AnCMn+s0VLNpDpWneuL870hqTPD2J3fUZ4hkb1E5n8PK
         VS9L1y6WX2ArE+w2mwsY1jwI4zlPo3mqt0Aq/uSUuswTY1SfXmA74q835aC6JyF1x2qQ
         5AFziXkUwg9xiMiz63JJZ337EPMA6GRwsmfZaDhPU8erZBp04jT9+OUFOYOJ62wFEStX
         y3MLSXocszzGkMDFiqes8y9JKKruG4+N8eBXvLL7jw27EZDxG56WhE1RG+4TtxoQnZFo
         oRFA==
X-Gm-Message-State: AOJu0YyOtUdgoMK7qPCHRHOSr5/FaxfN//DC+S2fe7Riz16KIIVfk4UK
        P1VoBjEUaB/CTn0CruhzGgU=
X-Google-Smtp-Source: AGHT+IG4ooluzmxwcYlqOgvX4/v7UF1oQSyZHST17ujusbKy/cUFYsvzWSMQkJmILJfYgGTJTfe45Q==
X-Received: by 2002:a5d:6582:0:b0:31a:d4a9:bdac with SMTP id q2-20020a5d6582000000b0031ad4a9bdacmr3038816wru.11.1694033655894;
        Wed, 06 Sep 2023 13:54:15 -0700 (PDT)
Received: from krava ([83.240.60.62])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b009926928d486sm9420794ejk.35.2023.09.06.13.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:54:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 6 Sep 2023 22:54:13 +0200
To:     Rong Tao <rtoax@foxmail.com>
Cc:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
        sdf@google.com, Rong Tao <rongtao@cestc.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf-next v11 1/2] selftests/bpf: trace_helpers.c:
 optimize kallsyms cache
Message-ID: <ZPjm9fcy35JJZj6M@krava>
References: <cover.1693922135.git.rongtao@cestc.cn>
 <tencent_F9CAE827E2BA8193D06796FBE58ECAD16B06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F9CAE827E2BA8193D06796FBE58ECAD16B06@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 10:04:18PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms. At the same
> time, add APIs:
> 
>     load_kallsyms_local()
>     ksym_search_local()
>     ksym_get_addr_local()
>     free_kallsyms_local()
> 
> There are used to solve the problem of selftests/bpf updating kallsyms
> after attach new symbols during testmod testing.
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

looks good, I added few more coments, with them addressed you can add my

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
> v11: Remove useless load_kallsyms_refresh() and modify code some format
> v10: https://lore.kernel.org/lkml/tencent_0A73B402B1D440480838ABF7124CE5EA5505@qq.com/
>     Keep the original load_kallsyms().
> v9: https://lore.kernel.org/lkml/tencent_254B7015EED7A5D112C45E033DA1822CF107@qq.com/
>     Add load_kallsyms_local,ksym_search_local,ksym_get_addr_local functions.
> v8: https://lore.kernel.org/lkml/tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com/
>     Resolves inter-thread contention for ksyms global variables.
> v7: https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com/
>     Fix __must_check macro.
> v6: https://lore.kernel.org/lkml/tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com/
>     Apply libbpf_ensure_mem()
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

SNIP

> +static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
> +			     unsigned long addr)
> +{
> +	void *tmp;
> +
> +	tmp = strdup(name);
> +	if (!tmp)
> +		return -ENOMEM;
> +	ksyms->syms[ksyms->sym_cnt].addr = addr;
> +	ksyms->syms[ksyms->sym_cnt].name = tmp;
> +
> +	ksyms->sym_cnt++;
> +
> +	return 0;

nit, extra new lines above

> +}
> +
> +void free_kallsyms_local(struct ksyms *ksyms)
> +{
> +	unsigned int i;
> +
> +	if (!ksyms)
> +		return;
> +
> +	if (!ksyms->syms) {
> +		free(ksyms);
> +		return;
> +	}
> +
> +	for (i = 0; i < ksyms->sym_cnt; i++)
> +		free(ksyms->syms[i].name);
> +	free(ksyms->syms);
> +	free(ksyms);
> +}
>  
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
>  	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
>  }
>  
> -int load_kallsyms_refresh(void)
> +struct ksyms *load_kallsyms_local(struct ksyms *ksyms)
>  {
>  	FILE *f;
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
> +	int ret;
>  
> -	sym_cnt = 0;
> +	/* flush kallsyms, free the previously allocated dynamic memory */
> +	free_kallsyms_local(ksyms);

with the removal of the refresh function (from last version) there's
no need now for ksyms argument in load_kallsyms_local

all the current users of load_kallsyms_local are passing NULL arg

>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> -		return -ENOENT;
> +		return NULL;
> +
> +	ksyms = calloc(1, sizeof(struct ksyms));
> +	if (!ksyms)

missing fclose(f);

> +		return NULL;
>  
>  	while (fgets(buf, sizeof(buf), f)) {
>  		if (sscanf(buf, "%p %c %s", &addr, &symbol, func) != 3)
>  			break;
>  		if (!addr)
>  			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
>  
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ret = libbpf_ensure_mem((void **) &ksyms->syms, &ksyms->sym_cap,
> +					sizeof(struct ksym), ksyms->sym_cnt + 1);
> +		if (ret)
> +			goto error;
> +		ret = ksyms__add_symbol(ksyms, func, (unsigned long)addr);
> +		if (ret)
> +			goto error;
>  	}
>  	fclose(f);
> -	sym_cnt = i;
> -	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
> -	return 0;
> +	qsort(ksyms->syms, ksyms->sym_cnt, sizeof(struct ksym), ksym_cmp);
> +	return ksyms;
> +
> +error:
> +	free_kallsyms_local(ksyms);

missing fclose(f);

> +	return NULL;
>  }
>  
>  int load_kallsyms(void)
>  {
> -	/*
> -	 * This is called/used from multiplace places,
> -	 * load symbols just once.
> -	 */
> -	if (sym_cnt)
> -		return 0;
> -	return load_kallsyms_refresh();
> +	if (!ksyms)
> +		ksyms = load_kallsyms_local(NULL);
> +	return ksyms ? 0 : 1;
>  }
>  
> -struct ksym *ksym_search(long key)
> +struct ksym *ksym_search_local(struct ksyms *ksyms, long key)
>  {
> -	int start = 0, end = sym_cnt;
> +	int start = 0, end = ksyms->sym_cnt;
>  	int result;
>  
> +	if (!ksyms)
> +		return NULL;

I don't think we need to check !ksyms in here, you don't do
that check in ksym_get_addr_local and I think it's fine

> +
>  	/* kallsyms not loaded. return NULL */
> -	if (sym_cnt <= 0)
> +	if (ksyms->sym_cnt <= 0)
>  		return NULL;
>  
>  	while (start < end) {

SNIP

> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> index 876f3e711df6..d6eeec85a5e4 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -11,13 +11,18 @@ struct ksym {
>  	long addr;
>  	char *name;
>  };
> +struct ksyms;
>  
>  int load_kallsyms(void);
> -int load_kallsyms_refresh(void);
> -
>  struct ksym *ksym_search(long key);
>  long ksym_get_addr(const char *name);
>  
> +struct ksyms *load_kallsyms_local(struct ksyms *ksyms);
> +struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
> +long ksym_get_addr_local(struct ksyms *ksyms, const char *name);
> +

nit, extra newline

> +void free_kallsyms_local(struct ksyms *ksyms);
> +
>  /* open kallsyms and find addresses on the fly, faster than load + search. */
>  int kallsyms_find(const char *sym, unsigned long long *addr);
>  
> -- 
> 2.41.0
> 
