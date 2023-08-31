Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195DB78EEFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHaNwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHaNwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 09:52:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F911A4;
        Thu, 31 Aug 2023 06:52:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so1074858a12.3;
        Thu, 31 Aug 2023 06:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693489926; x=1694094726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYOUD5lXQca1WFTvIiOtEDQstacjLP+FCLr0A1NUsT0=;
        b=UZDOpJEBc/KhVzlOp1oYwLUdDPayQZuJqQnEgY38oaK0+Rvl4ceJqitdpnR6Pw2Ieu
         SS2DafXyPDQxQvM73xxnUBwOKxip3uf9/Kl5ZoMJemNk2nfvmrus0I9SwnWOglt2Kmnh
         v9rm6MsJghddppnL6EnJDfWHZbgSrOQ9uVhb8cl30VHPARb2S41YyghXfxJXHgm1JZuj
         nPAdwHYuv63Ir1oAl0/Kei9dE1Nb+42dRsfQji5rOsDGREB6vfgfiFLNJ+hRp6ofd2x8
         HDQ7yOzBC3rVuXeyVMhPFMDL2XWOmJ8JNP+Y/XOSY5S/jS3pw6QdaIcl8A6Pt5gEOcIR
         VkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489926; x=1694094726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYOUD5lXQca1WFTvIiOtEDQstacjLP+FCLr0A1NUsT0=;
        b=kc5RasriKlgsMtAvnXGjGe1HwFKWLXSv3jiQD13rnjGeyuUTsnG+fNqOEFCVyaCgeD
         P6rVQCb+e6V6PTr05qSHenedpMlt08dg0jMP7yhgHCIUfaq7CsketC8W3Azd+lgOAF5P
         jrImTrrvcFKLTuWsLQRUgkUduo98ipcyIq9B0b6TC779Z/tq1HQ0Eg7dRIJ1bD2qAh0j
         GpJfkrIPpndHm7kebdpHGWrJJ0c2dMPCD4L+ucUu7RpZTbzQDLy7LIisjdHce9KVQWVj
         Kps01E3zBgnbkaXl8C1/mCFTNX07+2MgZBLozK1GsLslAK+jwh2R3xVMHB9kE3HyjfVI
         HPPg==
X-Gm-Message-State: AOJu0YzGzySojt6LzXfACGJRTYHNtODSU2zsf9v/nkY4s1/PY+EEo5Eo
        rgFCV1p/SWNZOo7lZjBzLnQ=
X-Google-Smtp-Source: AGHT+IEiraQBzFw6RGp8YPRpJ1fST3v+Z2mvq7ugGZ1V9RQFFoEWTPv1Kh0qGIoblmibYEfCUGGSjg==
X-Received: by 2002:aa7:d952:0:b0:525:4471:6b5d with SMTP id l18-20020aa7d952000000b0052544716b5dmr4386016eds.19.1693489926241;
        Thu, 31 Aug 2023 06:52:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7c515000000b0052576969ef8sm813790edq.14.2023.08.31.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:52:05 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 31 Aug 2023 15:52:02 +0200
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Manu Bretelle <chantr4@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Ross Zwisler <zwisler@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf-next v9] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZPCbAs3ItjRd8XVh@krava>
References: <tencent_254B7015EED7A5D112C45E033DA1822CF107@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_254B7015EED7A5D112C45E033DA1822CF107@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 29, 2023 at 10:14:01PM +0800, Rong Tao wrote:
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
> v9: Add load_kallsyms_local,ksym_search_local,ksym_get_addr_local functions.
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
> ---
>  samples/bpf/Makefile                          |   4 +
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |   9 +-
>  .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
>  .../bpf/prog_tests/get_stack_raw_tp.c         |  10 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        |  15 +-
>  .../prog_tests/kprobe_multi_testmod_test.c    |  19 ++-
>  tools/testing/selftests/bpf/trace_helpers.c   | 142 +++++++++++++-----
>  tools/testing/selftests/bpf/trace_helpers.h   |   8 +
>  8 files changed, 159 insertions(+), 57 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4ccf4236031c..6c707ebcebb9 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -175,6 +175,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
>  TPROGS_CFLAGS += -I$(srctree)/tools/include
>  TPROGS_CFLAGS += -I$(srctree)/tools/perf
> +TPROGS_CFLAGS += -I$(srctree)/tools/lib
>  TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
>  
>  ifdef SYSROOT
> @@ -314,6 +315,9 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
>  
>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
> +# Override includes for trace_helpers.o because __must_check won't be defined
> +# in our include path.
> +$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>  
>  -include $(BPF_SAMPLES_PATH)/Makefile.target
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 1454cebc262b..4ed47dc75669 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -104,8 +104,10 @@ static void kprobe_multi_link_api_subtest(void)
>  	LIBBPF_OPTS(bpf_link_create_opts, opts);
>  	unsigned long long addrs[8];
>  	__u64 cookies[8];
> +	struct ksyms *ksyms;
>  
> -	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +	ksyms = load_kallsyms_local();
> +	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_local"))
>  		goto cleanup;

hum, this wont work right? I think you should use ASSERT_OK_PTR in here
and ther similar places below

>  
>  	skel = kprobe_multi__open_and_load();
> @@ -116,8 +118,8 @@ static void kprobe_multi_link_api_subtest(void)
>  	skel->bss->test_cookie = true;
>  
>  #define GET_ADDR(__sym, __addr) ({				\
> -	__addr = ksym_get_addr(__sym);				\
> -	if (!ASSERT_NEQ(__addr, 0, "ksym_get_addr " #__sym))	\
> +	__addr = ksym_get_addr_local(ksyms, __sym);		\
> +	if (!ASSERT_NEQ(__addr, 0, "ksym_get_addr_local " #__sym))	\
>  		goto cleanup;					\
>  })
>  
> @@ -171,6 +173,7 @@ static void kprobe_multi_link_api_subtest(void)
>  cleanup:
>  	close(link1_fd);
>  	close(link2_fd);
> +	free_kallsyms_local(ksyms);

I think we don't need to change any test that's calling load_kallsyms,
it should use load_kallsyms and global ksyms data

the load_kallsyms_local would be used in tests that use load_kallsyms_refresh
and need updated ksyms data for bpf_testmod symbols

we just need to make sure that global ksyms initialization won't race, like with:

	+static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
	+
	 int load_kallsyms(void)
	 {
	-       /*
	-        * This is called/used from multiplace places,
	-        * load symbols just once.
	-        */
	-       if (sym_cnt)
	-               return 0;
	-       return load_kallsyms_refresh();
	+       pthread_mutex_lock(&ksyms_mutex);
	+       if (!ksyms)
	+               ksyms = load_kallsyms_local();
	+       pthread_mutex_unlock(&ksyms_mutex);
	+       return ksyms ? 0 : 1;
	 }

it could be in separate patch perhaps, because currently there's the same race

>  	kprobe_multi__destroy(skel);
>  }
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 9d768e083714..154aaa08761f 100644
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
> +	ksyms = load_kallsyms_refresh_local(NULL);
> +	if (!ASSERT_OK(ksyms != NULL, "load_kallsyms_refresh_local"))

ASSERT_OK_PTR

SNIP

> -int load_kallsyms_refresh(void)
> +struct ksyms *load_kallsyms_refresh_local(struct ksyms *ksyms)
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
> +int load_kallsyms_refresh(void)
> +{
> +	ksyms = load_kallsyms_refresh_local(NULL);
> +	return ksyms ? 0 : 1;
> +}
> +
> +struct ksyms *load_kallsyms_local(void)
> +{
> +	return load_kallsyms_refresh_local(NULL);
>  }

do we need to have load_kallsyms_refresh_local?

we could have ksyms arg passed directly to load_kallsyms_local

  struct ksyms *load_kallsyms_local(struct ksyms *old);

it would return fresh ksyms and release old ksyms if it's passed as an argument

basically I mean just to drop load_kallsyms_local above and rename
load_kallsyms_refresh_local to load_kallsyms_local


jirka
