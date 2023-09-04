Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC35791DCC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 21:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjIDTvT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjIDTvS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 15:51:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7EAE8;
        Mon,  4 Sep 2023 12:51:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso25939651fa.1;
        Mon, 04 Sep 2023 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693857073; x=1694461873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3AUBpdzY9yVap/s/23ZdGK7PcPt7+ENwXsRxdz18Anc=;
        b=CQNoe/vNH7E1XrlGGEfUcjEQB5T4a0HQ0J3tRxOqIk38NWpgotTEqO7M1NrJXG37Hy
         hXZy31IlbXM1LGSjkjV2T6g6aqPVv/yJYCgc6wfNgtYA5gaAxrgJZ+k/xrb3U4ZzLe7u
         hHT0S98VEyE/rybSV+Jt8xYRfmS6J0mlODbSfKPwDFUGb68AXONz1CNV8pCJ4cHFn0Qc
         K+K4RzIffRh6CofUsH8UJrt/nEXmj6dym7BmkxZeevBo0n0n5jD0os9W2LyePp53nFWQ
         TRVBCzQB1HgPbE7CHqkCyZze1BfCIOUCRO0tOkCvMY+pDdOzQqgDvsMOE93r78mi9hAR
         ta3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693857073; x=1694461873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AUBpdzY9yVap/s/23ZdGK7PcPt7+ENwXsRxdz18Anc=;
        b=PPBVdry8RWgEFj2ivwWHF9giZzGz6pb8FbSfJsV+v9p5uBZkI+zjujsjfaxHg6EZIS
         gzHMx5i00dxxtHKCNkiB1qTpAxnqCjiIi5mhjcT/mg64DXD8nqter+GXuAKKQ6kBHdu7
         /0c9SheadrfUa4XN9ZQX9MtYkDWuaEINFMSYCH8JPKMyeoyNk2Du0Ghbcaj2DxIMs0Dq
         aMiwi5aHp3Ea7kjxfHmdCspa1OYvD0CVNTo2Wz1kFIq9Qng0pdtDKMBON7A3aUWVohxm
         2TO+GSNEp92nGTdAE/chdsaqAzNQmIuaK7wt1PNK4hxMnLVYSeCqi+Rw6RqMWBDBbcNh
         8n+w==
X-Gm-Message-State: AOJu0YyNn1U/jjEIF1/BR9pvib0FIm8ELSVcEw5n2GIOmcyLUZNWSDGS
        w+Yp/BJrYW4XM2Et6UPDn0I3B0488Hcmzg==
X-Google-Smtp-Source: AGHT+IEe5hqM2tLSPD19i5CtW5J/dyVWXpmEWt1LF6g64hsvkH9kl2jvCYwAFLOu+VdQnzFX3w1cLA==
X-Received: by 2002:a19:ca12:0:b0:500:dc8d:c344 with SMTP id a18-20020a19ca12000000b00500dc8dc344mr6345801lfg.48.1693857072696;
        Mon, 04 Sep 2023 12:51:12 -0700 (PDT)
Received: from krava ([83.240.60.62])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b0099275c59bc9sm6560549ejb.33.2023.09.04.12.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:51:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 4 Sep 2023 21:51:10 +0200
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
Subject: Re: [PATCH bpf-next v10 1/2] selftests/bpf: trace_helpers.c:
 optimize kallsyms cache
Message-ID: <ZPY1Lu8341L+d5Rw@krava>
References: <cover.1693788910.git.rongtao@cestc.cn>
 <tencent_0A73B402B1D440480838ABF7124CE5EA5505@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0A73B402B1D440480838ABF7124CE5EA5505@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 04, 2023 at 09:01:20AM +0800, Rong Tao wrote:
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

missing free_kallsyms_local

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 9d768e083714..13e618317c8b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -302,16 +302,18 @@ void test_fill_link_info(void)
>  {
>  	struct test_fill_link_info *skel;
>  	int i;
> +	struct ksyms *ksyms;
>  
>  	skel = test_fill_link_info__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "skel_open"))
>  		return;
>  
>  	/* load kallsyms to compare the addr */
> -	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +	ksyms = load_kallsyms_local();
> +	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
>  		goto cleanup;

actually I don't see why this test should need refreshed kallsyms,
it doesn't load/unload testmod, I think it can use global ksyms

>  
> -	kprobe_addr = ksym_get_addr(KPROBE_FUNC);
> +	kprobe_addr = ksym_get_addr_local(ksyms, KPROBE_FUNC);
>  	if (test__start_subtest("kprobe_link_info"))
>  		test_kprobe_fill_link_info(skel, BPF_PERF_EVENT_KPROBE, false);
>  	if (test__start_subtest("kretprobe_link_info"))
> @@ -329,7 +331,7 @@ void test_fill_link_info(void)
>  
>  	qsort(kmulti_syms, KMULTI_CNT, sizeof(kmulti_syms[0]), symbols_cmp_r);
>  	for (i = 0; i < KMULTI_CNT; i++)
> -		kmulti_addrs[i] = ksym_get_addr(kmulti_syms[i]);
> +		kmulti_addrs[i] = ksym_get_addr_local(ksyms, kmulti_syms[i]);
>  	if (test__start_subtest("kprobe_multi_link_info"))
>  		test_kprobe_multi_fill_link_info(skel, false, false);
>  	if (test__start_subtest("kretprobe_multi_link_info"))
> @@ -339,4 +341,5 @@ void test_fill_link_info(void)
>  
>  cleanup:
>  	test_fill_link_info__destroy(skel);
> +	free_kallsyms_local(ksyms);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> index 1fbe7e4ac00a..532b05ae2da4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> @@ -4,6 +4,8 @@
>  #include "trace_helpers.h"
>  #include "bpf/libbpf_internal.h"
>  
> +static struct ksyms *ksyms;
> +
>  static void kprobe_multi_testmod_check(struct kprobe_multi *skel)
>  {
>  	ASSERT_EQ(skel->bss->kprobe_testmod_test1_result, 1, "kprobe_test1_result");
> @@ -50,12 +52,12 @@ static void test_testmod_attach_api_addrs(void)
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>  	unsigned long long addrs[3];
>  
> -	addrs[0] = ksym_get_addr("bpf_testmod_fentry_test1");
> -	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr");
> -	addrs[1] = ksym_get_addr("bpf_testmod_fentry_test2");
> -	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr");
> -	addrs[2] = ksym_get_addr("bpf_testmod_fentry_test3");
> -	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr");
> +	addrs[0] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test1");
> +	ASSERT_NEQ(addrs[0], 0, "ksym_get_addr_local");
> +	addrs[1] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test2");
> +	ASSERT_NEQ(addrs[1], 0, "ksym_get_addr_local");
> +	addrs[2] = ksym_get_addr_local(ksyms, "bpf_testmod_fentry_test3");
> +	ASSERT_NEQ(addrs[2], 0, "ksym_get_addr_local");
>  
>  	opts.addrs = (const unsigned long *) addrs;
>  	opts.cnt = ARRAY_SIZE(addrs);
> @@ -79,11 +81,19 @@ static void test_testmod_attach_api_syms(void)
>  
>  void serial_test_kprobe_multi_testmod_test(void)
>  {
> -	if (!ASSERT_OK(load_kallsyms_refresh(), "load_kallsyms_refresh"))
> +	ksyms = load_kallsyms_local();
> +	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
>  		return;
>  
>  	if (test__start_subtest("testmod_attach_api_syms"))
>  		test_testmod_attach_api_syms();
> +
> +	ksyms = load_kallsyms_refresh(ksyms);
> +	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_refresh"))
> +		return;

hm, this refresh is not needed right? the test got the fresh kallsyms above
and both test_testmod_attach_api_syms and test_testmod_attach_api_addrs
should be happy

> +
>  	if (test__start_subtest("testmod_attach_api_addrs"))
>  		test_testmod_attach_api_addrs();
> +
> +	free_kallsyms_local(ksyms);
>  }
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..d64c4ef336e1 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -14,104 +14,171 @@
>  #include <linux/limits.h>
>  #include <libelf.h>
>  #include <gelf.h>
> +#include "bpf/libbpf_internal.h"
>  
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> -static int sym_cnt;
> +struct ksyms {
> +	struct ksym *syms;
> +	size_t sym_cap;
> +	size_t sym_cnt;
> +};
> +
> +static struct ksyms *ksyms;
> +
> +static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
> +							 unsigned long addr)

extra white space in here ^^^

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
> +struct ksyms *load_kallsyms_refresh(struct ksyms *ksyms)
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
>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> -		return -ENOENT;
> +		return NULL;
> +
> +	ksyms = calloc(1, sizeof(struct ksyms));
> +	if (!ksyms)
> +		return NULL;

I wonder it could be easier not to allocate ksyms, but just let the
caller to pass the pointer to 'ksym' variable on stack.. but there
might be other problems, so I guess this is fine

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
> +	return NULL;
> +}
> +
> +struct ksyms *load_kallsyms_local(void)
> +{
> +	return load_kallsyms_refresh(NULL);

I think we can have just:

   struct ksyms *load_kallsyms_local(struct ksyms *ksyms);

I don't see reason for load_kallsyms_refresh functions, perhaps it's
leftover because I don't see the function in the changelog

thanks,
jirka
