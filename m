Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45C777FF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHJSJL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjHJSJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 14:09:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C01728
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 11:09:10 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26820567a96so1413241a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691690950; x=1692295750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZA6CEiwrXGmKCo4HzAg+4dNTQSYp2lyGfBxT58BX1k=;
        b=q0jGi+OjzV+GO7+s2YkYtHQRcufIGOrSEvJ/RdKdGau653Wn71Lqm6OQP9rpwPxIDr
         G+WR6h1kr2arSJqBzU9riM6xqCNaduY7ULU2bw3E4Lh6tf9XlyVCx6sQVChFbHNR1kor
         ECwzddcGhMOzUYzUF1iXfGnj+dwnyWhcmYKAcRErJjmoWIEPLFZs0iLBb3AC0w0W7Ot3
         6Uy7FxbsNHM2B44KSttVctEFwtv1O5C4dGCxRcrV6yZF2yRtxKJjZTHjn7kgbnybM0Se
         RnZQBfYNLVDnj4a7NA/DJU6OjirVTs48QFgllsMnQogE47yXBaXemS4deZesK3/Lh5IF
         l3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690950; x=1692295750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZA6CEiwrXGmKCo4HzAg+4dNTQSYp2lyGfBxT58BX1k=;
        b=LCeXFU2T/RMH6M33ceUpKMkiwWv8Oq+fMBGox8ZmENBtIdbI6co4DfXTyaLGPdCgvw
         i/MmBKUofVwjrJDA1w3Bd2xSMD/kT8MKGoKoNT/R2qYGFn2CJoDEDTIegrLuI9k1qj7X
         Co14JIzWa/Ru5GASTEcc0uky/baDTJxpnYmzdm+O2giHFrt87p+vcnGfsQTuJvu2X+YE
         c3xnDVjOTbfL2dS52RqYzBrSZop8r+KfkU/ih0XDruHUUpROzYQtrOBjuWqGb6/NUm/Q
         2oL6snyu/6PIXz1VJiuoqBcAWWXlYjKiuPohhAW/OzmsWfIzMPgjKFo/BHSxx8S63EzM
         wxsw==
X-Gm-Message-State: AOJu0YwLT/tATerpQPAKiHZCuMYe079mQuuA2ZnyVkEJvKf1bpq3Eljc
        TDhiZ0oCmJwcxvcEVRgG64lyJjY=
X-Google-Smtp-Source: AGHT+IHSaQ4aZmd8MIdgX6r7UqBsLG4470xdZ9xBw4J+GJzxLX6Hvu3rBPJ6ERqIclixWKSiZIDvpDU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:a78a:b0:268:2c37:3f59 with SMTP id
 f10-20020a17090aa78a00b002682c373f59mr711983pjq.4.1691690949813; Thu, 10 Aug
 2023 11:09:09 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:09:08 -0700
In-Reply-To: <tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com>
Mime-Version: 1.0
References: <tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com>
Message-ID: <ZNUnxJ26/4QfvoC+@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From:   Stanislav Fomichev <sdf@google.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Daniel =?utf-8?Q?M=C3=BCller?=" <deso@posteo.net>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@google.com>,
        Manu Bretelle <chantr4@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/10, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.

Thank you for doing this! I do remember complaining about it on the last
"let's bump the limit" patch :-D

> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  samples/bpf/offwaketime_user.c                |  1 +
>  samples/bpf/sampleip_user.c                   |  1 +
>  samples/bpf/spintest_user.c                   |  1 +
>  samples/bpf/task_fd_query_user.c              |  1 +
>  samples/bpf/trace_event_user.c                |  1 +
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |  1 +
>  .../bpf/prog_tests/get_stack_raw_tp.c         |  1 +
>  .../bpf/prog_tests/kprobe_multi_test.c        |  2 +
>  .../prog_tests/kprobe_multi_testmod_test.c    |  2 +
>  tools/testing/selftests/bpf/trace_helpers.c   | 74 ++++++++++++-------
>  tools/testing/selftests/bpf/trace_helpers.h   |  1 +
>  11 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/samples/bpf/offwaketime_user.c b/samples/bpf/offwaketime_user.c
> index b6eedcb98fb9..5e6934f2d932 100644
> --- a/samples/bpf/offwaketime_user.c
> +++ b/samples/bpf/offwaketime_user.c
> @@ -149,5 +149,6 @@ int main(int argc, char **argv)
>  		bpf_link__destroy(links[i]);
>  
>  	bpf_object__close(obj);
> +	free_kallsyms();

Do we really need to free the symbols? IOW, is it enough to load them
once and keep them around until test_progs dies?

If we do, I wonder what would happen when test_progs runs in parallel mode?
Feels like if we're adding this alloc/free, then load_symbols
should return some object which free_kallsyms should free?
And ksym_get_addr would also work on that object, not on the global
state..


>  	return 0;
>  }
> diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
> index 9283f47844fb..548ca1e9fcac 100644
> --- a/samples/bpf/sampleip_user.c
> +++ b/samples/bpf/sampleip_user.c
> @@ -230,5 +230,6 @@ int main(int argc, char **argv)
>  
>  	free(links);
>  	bpf_object__close(obj);
> +	free_kallsyms();
>  	return error;
>  }
> diff --git a/samples/bpf/spintest_user.c b/samples/bpf/spintest_user.c
> index aadac14f748a..895a64afaf78 100644
> --- a/samples/bpf/spintest_user.c
> +++ b/samples/bpf/spintest_user.c
> @@ -88,5 +88,6 @@ int main(int ac, char **argv)
>  		bpf_link__destroy(links[j]);
>  
>  	bpf_object__close(obj);
> +	free_kallsyms();
>  	return 0;
>  }
> diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
> index 1e61f2180470..3eb9477541fb 100644
> --- a/samples/bpf/task_fd_query_user.c
> +++ b/samples/bpf/task_fd_query_user.c
> @@ -419,5 +419,6 @@ int main(int argc, char **argv)
>  		bpf_link__destroy(links[i]);
>  
>  	bpf_object__close(obj);
> +	free_kallsyms();
>  	return err;
>  }
> diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
> index 9664749bf618..a8b9343126fa 100644
> --- a/samples/bpf/trace_event_user.c
> +++ b/samples/bpf/trace_event_user.c
> @@ -348,5 +348,6 @@ int main(int argc, char **argv)
>  
>  cleanup:
>  	bpf_object__close(obj);
> +	free_kallsyms();
>  	err_exit(error);
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 26b2d1bffdfd..4786396e554b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -170,6 +170,7 @@ static void kprobe_multi_link_api_subtest(void)
>  cleanup:
>  	close(link1_fd);
>  	close(link2_fd);
> +	free_kallsyms();
>  	kprobe_multi__destroy(skel);
>  }
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
> index 858e0575f502..4e1c564746e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
> @@ -146,4 +146,5 @@ void test_get_stack_raw_tp(void)
>  	bpf_link__destroy(link);
>  	perf_buffer__free(pb);
>  	bpf_object__close(obj);
> +	free_kallsyms();
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 2173c4bb555e..d6c0b5f2f887 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -488,4 +488,6 @@ void test_kprobe_multi_test(void)
>  		test_attach_api_syms();
>  	if (test__start_subtest("attach_api_fails"))
>  		test_attach_api_fails();
> +
> +	free_kallsyms();
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> index 1fbe7e4ac00a..c25f262832b7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> @@ -86,4 +86,6 @@ void serial_test_kprobe_multi_testmod_test(void)
>  		test_testmod_attach_api_syms();
>  	if (test__start_subtest("testmod_attach_api_addrs"))
>  		test_testmod_attach_api_addrs();
> +
> +	free_kallsyms();
>  }
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..08986f70836b 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,9 +18,32 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> -static int sym_cnt;
> +static struct {
> +	struct ksym *syms;
> +	unsigned int sym_cnt;
> +} ksyms = {
> +	.syms = NULL,
> +	.sym_cnt = 0,
> +};
> +
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int cnt = ksyms.sym_cnt;
> +
> +	cnt++;
> +	tmp = realloc(ksyms.syms, sizeof(struct ksym) * cnt);
> +	if (!tmp)
> +		return -ENOMEM;

Should we do the usual len/capacity scheme here to amortize the cost
of realloc (like doubling capacity when we reach it)?
Calling realloc on every symbol doesn't seem right.
