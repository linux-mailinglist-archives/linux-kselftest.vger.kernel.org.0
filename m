Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF91E18524C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCMX16 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:27:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39476 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMX16 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:27:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id s2so5891871pgv.6
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tiFZifHABrIihIfLAilpnPNa34Or637DFmBwGz6qsE=;
        b=ZrpPr1iZD6WsTRwW1ADrN+wsqQN/RGfRQHJz5oZ3TMg/IUpK9fmvbNxUb2kLFKV341
         2kneeRtyrhpTCG1u7bSuKQnxgwrRN068R9e4gjclVUso3F4S6LS7cnvBITabqVZnnD3P
         uKZbkHyUBESTXZCX8tavVv4ynoYRtHXfemA0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tiFZifHABrIihIfLAilpnPNa34Or637DFmBwGz6qsE=;
        b=DP+OJu4FAgYlui7o/i5CyzV6yxFs/REiERrnm+QGsIoizF1n5PReyCxDT7q8RUvFw8
         PVNF4UqBoTfL9tlzhmDywCgZ2bCbW8W5Uv0wKdvmNQyLPPVFMMp9uFANyNqq0m/mvmDD
         B4Z2BLtb3mD5iUfpDCAnFGZtaFVgTn8g8/stsMcqOZxRtsZQOzQH4v22Nzw+DrYASs3R
         4ewkJ4eaAqlMdtD0tau9whxb7aIh+8N9plgyTpFufeqD8BWcJZSH0ytHd66z0mmnu253
         5iKsUD+ZeZ0/RZuZtMusiW75htuWlSM1eGZCiTQyYBU/znNADDZQxjbCXv/0ZyWC/NyE
         UxsQ==
X-Gm-Message-State: ANhLgQ0ZimEujgDQDK+Z+UBFUcQTlgMtF+MEfbmpExqM/dmMQjwMel4Z
        KLUJV2ic4+Qd9GWyGDuhc7DRuA==
X-Google-Smtp-Source: ADFU+vvWTGEjVFYjtZV3wy+y6DlGY3xrVp8xaP7kamkbuouf9Lo2/WbxmGZ+IKIgJMs2dRa1CQZuOg==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr15782301pgk.113.1584142076175;
        Fri, 13 Mar 2020 16:27:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm12482946pjt.3.2020.03.13.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:27:55 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:27:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] kselftest: run tests by fixture
Message-ID: <202003131626.8EF371151@keescook>
References: <20200313031752.2332565-1-kuba@kernel.org>
 <20200313031752.2332565-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313031752.2332565-4-kuba@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 08:17:50PM -0700, Jakub Kicinski wrote:
> Now that all tests have a fixture object move from a global
> list of tests to a list of tests per fixture.
> 
> Order of tests may change as we will now group and run test
> fixture by fixture, rather than in declaration order.

I'm not convinced about this change. Declaration order is a pretty
intuitive result that I'd like to keep for the harness.

Can this change be avoided and still keep the final results of a
"mutable" fixture?

-Kees

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++---------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index a396afe4a579..7a3392941a5b 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -637,8 +637,11 @@
>  } while (0); OPTIONAL_HANDLER(_assert)
>  
>  /* Contains all the information about a fixture */
> +struct __test_metadata;
> +
>  struct __fixture_metadata {
>  	const char *name;
> +	struct __test_metadata *tests;
>  	struct __fixture_metadata *prev, *next;
>  } _fixture_global __attribute__((unused)) = {
>  	.name = "global",
> @@ -684,7 +687,6 @@ struct __test_metadata {
>  };
>  
>  /* Storage for the (global) tests to be run. */
> -static struct __test_metadata *__test_list;
>  static unsigned int __test_count;
>  
>  /*
> @@ -698,24 +700,26 @@ static unsigned int __test_count;
>   */
>  static inline void __register_test(struct __test_metadata *t)
>  {
> +	struct __fixture_metadata *f = t->fixture;
> +
>  	__test_count++;
>  	/* Circular linked list where only prev is circular. */
> -	if (__test_list == NULL) {
> -		__test_list = t;
> +	if (f->tests == NULL) {
> +		f->tests = t;
>  		t->next = NULL;
>  		t->prev = t;
>  		return;
>  	}
>  	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
>  		t->next = NULL;
> -		t->prev = __test_list->prev;
> +		t->prev = f->tests->prev;
>  		t->prev->next = t;
> -		__test_list->prev = t;
> +		f->tests->prev = t;
>  	} else {
> -		t->next = __test_list;
> +		t->next = f->tests;
>  		t->next->prev = t;
>  		t->prev = t;
> -		__test_list = t;
> +		f->tests = t;
>  	}
>  }
>  
> @@ -729,14 +733,15 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
>  	return 0;
>  }
>  
> -void __run_test(struct __test_metadata *t)
> +void __run_test(struct __fixture_metadata *f,
> +		struct __test_metadata *t)
>  {
>  	pid_t child_pid;
>  	int status;
>  
>  	t->passed = 1;
>  	t->trigger = 0;
> -	printf("[ RUN      ] %s.%s\n", t->fixture->name, t->name);
> +	printf("[ RUN      ] %s.%s\n", f->name, t->name);
>  	alarm(t->timeout);
>  	child_pid = fork();
>  	if (child_pid < 0) {
> @@ -786,13 +791,14 @@ void __run_test(struct __test_metadata *t)
>  		}
>  	}
>  	printf("[     %4s ] %s.%s\n", (t->passed ? "OK" : "FAIL"),
> -	       t->fixture->name, t->name);
> +	       f->name, t->name);
>  	alarm(0);
>  }
>  
>  static int test_harness_run(int __attribute__((unused)) argc,
>  			    char __attribute__((unused)) **argv)
>  {
> +	struct __fixture_metadata *f;
>  	struct __test_metadata *t;
>  	int ret = 0;
>  	unsigned int count = 0;
> @@ -801,13 +807,15 @@ static int test_harness_run(int __attribute__((unused)) argc,
>  	/* TODO(wad) add optional arguments similar to gtest. */
>  	printf("[==========] Running %u tests from %u test cases.\n",
>  	       __test_count, __fixture_count + 1);
> -	for (t = __test_list; t; t = t->next) {
> -		count++;
> -		__run_test(t);
> -		if (t->passed)
> -			pass_count++;
> -		else
> -			ret = 1;
> +	for (f = __fixture_list; f; f = f->next) {
> +		for (t = f->tests; t; t = t->next) {
> +			count++;
> +			__run_test(f, t);
> +			if (t->passed)
> +				pass_count++;
> +			else
> +				ret = 1;
> +		}
>  	}
>  	printf("[==========] %u / %u tests passed.\n", pass_count, count);
>  	printf("[  %s  ]\n", (ret ? "FAILED" : "PASSED"));
> -- 
> 2.24.1
> 

-- 
Kees Cook
