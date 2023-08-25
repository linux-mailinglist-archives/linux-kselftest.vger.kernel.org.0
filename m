Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FF788D21
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbjHYQUO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjHYQT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 12:19:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0A19A0;
        Fri, 25 Aug 2023 09:19:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so16788541fa.3;
        Fri, 25 Aug 2023 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692980394; x=1693585194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68aI97wABMBfVdJwALdaAZNx8N/84q4RFsaBN4wznKY=;
        b=CBdRUKkHyGsoX4xjd0g6JV7zLm/u0xrIeavalANRiBHfu/dKeA9EwjuFOzG6si1eMl
         IWRAuqtvHfdqCLYsA4OlnHpYlfIHVAAxOvAI9o5wDHbeo8/rdz9KvWZmThACoO4tO9ut
         oY8iLCjbE7vsCAXgMOuqjCIiH7i2TePsEVQRMAnOzRs2sE++mzW28g8rp5ROuwMXNx07
         Q7XnkmMRgi/W5GuZ3GQuQhIcQUmK/BX59cY0RhM64MKMf2nKru9NwwSIa2lsR2x8+6rw
         KSUDAEr6rMbUlgUeS44V6BOgpOvzEP/ZtZlPQgGZh2zthmx/pMQ3BHmMqvhP5g1YkBwy
         6Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692980394; x=1693585194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68aI97wABMBfVdJwALdaAZNx8N/84q4RFsaBN4wznKY=;
        b=FzAHW98smTCeDsAy6nH9XV5Nwb4dkeN96j3TaPHrLD/oX+Taj813fzpDmZrBGPhG90
         T/XQ27B00WjzZpNtnxlIwBiAcU+30ish0hUVcgAeIPTed2sSYUcT93qrL/oULLY4SBZC
         Edq8ZOj20vWIRunedzPVStjOMWOisgz7YZOPqUKb8+u9hqZMAg8oxGNprf/CxkHYlN8k
         LmeOPwKxvAhBzlzocgxlt+lQVnm1XYb+H6HJkoNTkUVAar1G/Of5c5wEABWmjNmBnjPv
         xUHE9PC4PTTfG5Qj2onMTXAUhl7oJV2KhX9oPb0thN3aQoqPvWInSTcASYjBC6lrAAaz
         JFDw==
X-Gm-Message-State: AOJu0YxdiolZuM0WgZtzSDWAd75hFIXV/J3DUDhcQVUAtZjQK1qli6yq
        EIEeabgKoiJpWHqSVKkDH0QtVrW4UyI=
X-Google-Smtp-Source: AGHT+IGnZ/Np5LOhIH/PYuSSLyi+cyu+a0NqFzGGLsdmSyHD1PiNfxXgQ0ByQe5KuQwhgi+2sP7ACg==
X-Received: by 2002:a2e:8717:0:b0:2bc:c11c:4471 with SMTP id m23-20020a2e8717000000b002bcc11c4471mr12132219lji.21.1692980393682;
        Fri, 25 Aug 2023 09:19:53 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c290900b003fe26244858sm5770924wmd.46.2023.08.25.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:19:53 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 25 Aug 2023 18:19:50 +0200
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
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZOjUpt16gcTSGkdl@krava>
References: <tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 25, 2023 at 06:36:24PM +0800, Rong Tao wrote:
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
> v7: Fix __must_check macro.
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
>  samples/bpf/Makefile                        |  2 +
>  tools/testing/selftests/bpf/trace_helpers.c | 58 ++++++++++++++++-----
>  2 files changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4ccf4236031c..0cd45c42af2f 100644
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
> @@ -314,6 +315,7 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
>  
>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
> +$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=

please add some comment why we did that, perhaps like:

+# Override includes for trace_helpers.o because __must_check won't be
+# defined in our include path.
+$(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=

>  
>  -include $(BPF_SAMPLES_PATH)/Makefile.target
>  
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..d62ab3b77153 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -14,13 +14,44 @@
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
> +static struct ksym *syms;
> +static size_t sym_cap;
> +static size_t sym_cnt;
> +
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
>  
>  static int ksym_cmp(const void *p1, const void *p2)
>  {
> @@ -33,9 +64,7 @@ int load_kallsyms_refresh(void)
>  	char func[256], buf[256];
>  	char symbol;
>  	void *addr;
> -	int i = 0;
> -
> -	sym_cnt = 0;

you need to release all symbols in here, for static version it was
enough to zero the sym_cnt value, but we need to release current
symbols now

also after discussing with Daniel we found there's a problem with
paralel run where both load_kallsyms and load_kallsyms_refresh and
other helpers like ksym_search are racy because another test can
just drop the cache

that was problem even before, but I wonder now it will expose more
because we will touch freed pointer instead of accessing same static
array

perhaps we could fix that with 2 sets of functions:

  - load_kallsyms
    ksym_search
    ksym_get_addr

    that work like now on global syms pointer, perhaps we should
    initialize it before we run tests or use mutex for init

  - struct ksym *load_kallsyms_local()
    ksym_search_local(struct ksym *syms, ...)
    ksym_get_addr_local(struct ksym *syms, ...)

    that work on local ksyms cache and the test frees it at the end,
    it would be used in all tests that need updated kallsyms data and
    use load_kallsyms_refresh for that


jirka


> +	int ret;
>  
>  	f = fopen("/proc/kallsyms", "r");
>  	if (!f)
> @@ -46,17 +75,22 @@ int load_kallsyms_refresh(void)
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
