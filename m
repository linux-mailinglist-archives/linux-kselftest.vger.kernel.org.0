Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12C07795BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjHKRIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjHKRID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50972123
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 10:08:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586b0ef17daso62610437b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773682; x=1692378482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayz3zWc5n3NudgvHTBCmK21hNqKenj4cKODpSVkSh7g=;
        b=5wQtFFTKe7JU84UnUAeBPgLTdVs+EP8+6Do7b6+vVW9RuOTz9jwCgCWfe565qsLApw
         bfMG9/8zSqb5S5Qshu/bhlurAnhIS15yOErL5ifV5nrGBPJKyD4CoiZ28xyzQtluxXta
         Wv53XGNFIaJi+vkf4P3sy/JLKA/NfL+GeZlg6z6NlG9v4a4Q3maZRuuPnZuyeYNDv7CH
         MXb7RrCrhaEqhWcFIrE3ZjcBfdr12ZM9J3aObGNFDeVousviT7uBHMojSywWR3C11TMJ
         rId6X4H+ibZc4m6Y9YVrApUJfYluBz2HiA5OxlHtEkoPrsQG4CtE2+5f+bv6AymtLVKJ
         mfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773682; x=1692378482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayz3zWc5n3NudgvHTBCmK21hNqKenj4cKODpSVkSh7g=;
        b=LJWOU0Iq40XswfNNOAQCAoxAIyp6T5NuJfg+xzzYSHEX9n0HADmwF0Kv60eIN6bVZ/
         YZPshJVExLzSddxoZDp4qqlPAUsZ5ZMwv8kkyhrsTiVtPpdznx9gxlunBAYs2MEZaGJR
         2mE75BXslbaBgS6HALC1qwtgoDdXgI4h08sSM37HTMarEXaShMIPCgrhaWyUmmgT4oww
         5HjxSyPnVzSc7Gx4k+rNKYZq4SD2o3RB8q6fdWR7FXK6KeaS0ou2IQmnZWNFPJEXX4R+
         ziTfrbke3r8PVknEomt6G2P2AqzcXYkGrb4M430oKZg2mOfoL8HflDi4LuunDloGCCYW
         Jspw==
X-Gm-Message-State: AOJu0YxVa5WrDjsjjERfjhOjaYtn4BtnOQeAdKOdDBXmGFkghY3gWJSZ
        v3yl1dhzI6pwyB1qndlYJOBePUs=
X-Google-Smtp-Source: AGHT+IF253YnhQbVEgKkS2r0RUIcWNjp4R4hKGjDuiQ7+PhQKLu1ym8TIYnfVPFUKmv1uY2Nh0/7NUw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:72c:b0:589:a3d6:2e02 with SMTP id
 bt12-20020a05690c072c00b00589a3d62e02mr58827ywb.3.1691773681829; Fri, 11 Aug
 2023 10:08:01 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:07:59 -0700
In-Reply-To: <tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com>
Mime-Version: 1.0
References: <tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com>
Message-ID: <ZNZq76jCnzNy7QVF@google.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From:   Stanislav Fomichev <sdf@google.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/11, Rong Tao wrote:
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
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v2: Do the usual len/capacity scheme here to amortize the cost of realloc, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 73 ++++++++++++++-------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..cda5a2328450 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,9 +18,37 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> -static int sym_cnt;
> +static struct {
> +	struct ksym *syms;
> +	unsigned int sym_cap;
> +	unsigned int sym_cnt;
> +} ksyms = {
> +	.syms = NULL,
> +	.sym_cap = 1024,
> +	.sym_cnt = 0,
> +};

Not sure what the struct buys you here (besides grouping everything
nicely), maybe do the following?
static struct ksym *syms;
static int sym_cnt;
static int sym_cap = 1024;

Will reduce the churn elsewhere..

> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;
> +
> +	if (ksyms.sym_cnt + 1 > ksyms.sym_cap) {
> +		new_cap = ksyms.sym_cap * 4 / 3;
> +		tmp = realloc(ksyms.syms, sizeof(struct ksym) * new_cap);
> +		if (!tmp)
> +			return -ENOMEM;
> +		ksyms.syms = tmp;
> +		ksyms.sym_cap = new_cap;
> +	}
> +
> +	ksyms.syms[ksyms.sym_cnt].addr = addr;
> +	ksyms.syms[ksyms.sym_cnt].name = strdup(name);
> +
> +	ksyms.sym_cnt++;
> +
> +	return 0;
> +}
>  
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
> @@ -33,9 +61,10 @@ int load_kallsyms_refresh(void)
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
>  
> -	sym_cnt = 0;
> +	ksyms.syms = malloc(sizeof(struct ksym) * ksyms.sym_cap);
> +	if (!ksyms.syms)
> +		return -ENOMEM;
>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> @@ -46,16 +75,10 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> -		if (i >= MAX_SYMS)
> -			return -EFBIG;
> -
> -		syms[i].addr = (long) addr;
> -		syms[i].name = strdup(func);
> -		i++;
> +		ksyms__add_symbol(func, (unsigned long)addr);

Need to check the return of ksyms__add_symbol here?
