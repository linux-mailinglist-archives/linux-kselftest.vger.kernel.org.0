Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0251797AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDSRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 13:17:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35935 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgCDSRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 13:17:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so1376892pgu.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rco2LYXauSYys/0APecfCQENUogaJ0irYLJfORHWIDo=;
        b=fibvgBkAoJq7EmaylPkXOFxf7VVSe3M2Na4WfgAxd4WlzSgT/9GLmwVzs1yKBKvQVB
         k6M1AbmAnw1KvTNSIYfSjD2q9OAwme14LVlYklwm7BP0OvdfESr05wGpqTU0svGtkuZE
         vzrBNlldnuJk061Wqllje4VVmT4Bs8EB/TMSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rco2LYXauSYys/0APecfCQENUogaJ0irYLJfORHWIDo=;
        b=ilIjKtDzvi2wAkVZp+f6I3uGX/6MBvwFKEOTXeWKhCbOC6OLcWV2cqrYzYvqOTRoCO
         1H9ObvF3GUH9JEJMtILKL4PfUhFb5kBJVvLGeJOtInG65grhpbsjucgP9xoKwSzkjzpu
         eeUI5VEN7s7aRg9vQ941W3l8L6hS9DwaZ+naqSAQLPNkDgnYykroGUZiW4F/aoSvEeUa
         MDqDdAMW6WJaQYhcu3IqYoRSa3n+vY+gwagWKjOK1hNN9NmclFx2oId5ghIGppb+3DmB
         8Qbo7Q9ozl7XH9myAQG1xYgNHDUx1DW2hCUXNdRgMncbLKbaitKzGbXSyEAg3PmNpYvY
         aXpg==
X-Gm-Message-State: ANhLgQ2Gs5GRn9XXBJBX7u/myLQjg9ZL5FF9vGwnkKxmnwW050mwBt0Q
        SBTs9E0GYh/blGaQLqqgpFokPA==
X-Google-Smtp-Source: ADFU+vuzhXF9JnrgPTD/QWsNdTxPBBmufCw/7sAVwcUNFAxGXm+kLrYI8jldyyp0SkWvqLb7bCwZMw==
X-Received: by 2002:a63:f962:: with SMTP id q34mr3591239pgk.229.1583345863665;
        Wed, 04 Mar 2020 10:17:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o10sm27750804pgq.68.2020.03.04.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:17:42 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:17:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        osa-contribution-log@amazon.com
Subject: Re: [PATCH] selftests: Add support for argc and argv.
Message-ID: <202003041016.38A4956310@keescook>
References: <20200304085204.48118-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304085204.48118-1-kuniyu@amazon.co.jp>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 05:52:04PM +0900, Kuniyuki Iwashima wrote:
> Currently tests are often written in C and shell script. In many cases, the
> script passes some arguments to the C program. However, the helper
> functions do not support arguments, so many tests are written without
> helper functions.
> 
> This patch allows us to handle argc and argv in each tests and makes it
> easier to write tests flexibly with helper functions.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>

Interesting! Do you have an example that uses this? I wonder if it might
make sense instead to allow extending the struct __test_metadata with
test-specific options so that individual tests don't have to re-parse
argv every time (the main test running could instead do it once and set
variables in struct __test_metadata (or somewhere else).

-Kees

> ---
>  tools/testing/selftests/kselftest_harness.h | 30 ++++++++++++---------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..75bee67b87fa 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -167,7 +167,8 @@
>  #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
>  
>  #define __TEST_IMPL(test_name, _signal) \
> -	static void test_name(struct __test_metadata *_metadata); \
> +	static void test_name(struct __test_metadata *_metadata, \
> +		int argc, char **argv); \
>  	static struct __test_metadata _##test_name##_object = \
>  		{ .name = "global." #test_name, \
>  		  .fn = &test_name, .termsig = _signal, \
> @@ -177,7 +178,9 @@
>  		__register_test(&_##test_name##_object); \
>  	} \
>  	static void test_name( \
> -		struct __test_metadata __attribute__((unused)) *_metadata)
> +		struct __test_metadata __attribute__((unused)) *_metadata, \
> +		int __attribute__((unused)) argc, \
> +		char __attribute__((unused)) **argv)
>  
>  /**
>   * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
> @@ -293,9 +296,11 @@
>  #define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
>  	static void fixture_name##_##test_name( \
>  		struct __test_metadata *_metadata, \
> -		FIXTURE_DATA(fixture_name) *self); \
> +		FIXTURE_DATA(fixture_name) *self, \
> +		int argc, char **argv); \
>  	static inline void wrapper_##fixture_name##_##test_name( \
> -		struct __test_metadata *_metadata) \
> +		struct __test_metadata *_metadata, \
> +		int argc, char **argv) \
>  	{ \
>  		/* fixture data is alloced, setup, and torn down per call. */ \
>  		FIXTURE_DATA(fixture_name) self; \
> @@ -304,7 +309,7 @@
>  		/* Let setup failure terminate early. */ \
>  		if (!_metadata->passed) \
>  			return; \
> -		fixture_name##_##test_name(_metadata, &self); \
> +		fixture_name##_##test_name(_metadata, &self, argc, argv); \
>  		fixture_name##_teardown(_metadata, &self); \
>  	} \
>  	static struct __test_metadata \
> @@ -321,7 +326,9 @@
>  	} \
>  	static void fixture_name##_##test_name( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
> -		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
> +		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> +		int __attribute__ ((unused)) argc, \
> +		char __attribute__ ((unused)) **argv)
>  
>  /**
>   * TEST_HARNESS_MAIN - Simple wrapper to run the test harness
> @@ -634,7 +641,7 @@
>  /* Contains all the information for test execution and status checking. */
>  struct __test_metadata {
>  	const char *name;
> -	void (*fn)(struct __test_metadata *);
> +	void (*fn)(struct __test_metadata *, int, char **);
>  	int termsig;
>  	int passed;
>  	int trigger; /* extra handler after the evaluation */
> @@ -695,7 +702,7 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
>  	return 0;
>  }
>  
> -void __run_test(struct __test_metadata *t)
> +void __run_test(struct __test_metadata *t, int argc, char **argv)
>  {
>  	pid_t child_pid;
>  	int status;
> @@ -709,7 +716,7 @@ void __run_test(struct __test_metadata *t)
>  		printf("ERROR SPAWNING TEST CHILD\n");
>  		t->passed = 0;
>  	} else if (child_pid == 0) {
> -		t->fn(t);
> +		t->fn(t, argc, argv);
>  		/* return the step that failed or 0 */
>  		_exit(t->passed ? 0 : t->step);
>  	} else {
> @@ -755,8 +762,7 @@ void __run_test(struct __test_metadata *t)
>  	alarm(0);
>  }
>  
> -static int test_harness_run(int __attribute__((unused)) argc,
> -			    char __attribute__((unused)) **argv)
> +static int test_harness_run(int argc, char **argv)
>  {
>  	struct __test_metadata *t;
>  	int ret = 0;
> @@ -768,7 +774,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
>  	       __test_count, __fixture_count + 1);
>  	for (t = __test_list; t; t = t->next) {
>  		count++;
> -		__run_test(t);
> +		__run_test(t, argc, argv);
>  		if (t->passed)
>  			pass_count++;
>  		else
> -- 
> 2.17.2 (Apple Git-113)
> 

-- 
Kees Cook
