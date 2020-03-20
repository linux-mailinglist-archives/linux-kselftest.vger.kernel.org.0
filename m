Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A98818D793
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Mar 2020 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTSpa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Mar 2020 14:45:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41615 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTSpa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Mar 2020 14:45:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so3519937pgm.8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Mar 2020 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwN/iK5iDZvFrYVZbWULT4p92fGuDe2KXG/Bof+uCXI=;
        b=NpgkQSI+WiFDZ5WtK6lqwq3XhTbhb8bjdGSNuR6Lb8PmQlPrRNZ2ctyFwmodISdBgO
         S929gvO2ZqlrN26Ty4DNDikYqN+XF3cJV24D0mLf0jw32NBlXZRkQmHRrpz6+kzmXzWM
         mKb2bXckr7Tkdek1EDhqbY+sJBZEAr/wrbBZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwN/iK5iDZvFrYVZbWULT4p92fGuDe2KXG/Bof+uCXI=;
        b=IZd+35qnrxAYL9WWt9DA0om6YafZU/tz21DSF22COEHfy24yGiTHTER3z0PuzGVMLL
         b2s7QWFsP8J4xD9m+nvXKmxP9D85CzIlmmaHg2sRZoe0jAs8L9SPOAtTIK+IUMAGkdwK
         xK4+9gL8JfJeudDtJ82r39mNKPpofTArW6r5DioidVK177gFazmKCa/JVjZ9lliJkWyf
         P3wVNHFUlZgKfWqkhT1APKr7UQIBxQIEYDLtn2pBv98hd0h9G0r8OzXensfRn80s2fzj
         YkWN2gFJ8HtHsAkCGcm3L7SXEt3Pgspp9flVKWXcULijmAJTTtiyNDv8W+Gz61VN0Bff
         jC1w==
X-Gm-Message-State: ANhLgQ3SEfuz9atv09Mp1sikvmXVl5jVDWW0zUNpEvOVl7yeOg4zXaHS
        Z4TQxE8EtXzxKFoYPjPCrCslhUZqULk=
X-Google-Smtp-Source: ADFU+vs0y6MyK1KccgqGgyjwzOz1iqQxYxG4p04gWRw+MvFrmd/jLMtpKnqaFtMKljPFbz8MBpW5ZA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr9609712pgh.53.1584729927385;
        Fri, 20 Mar 2020 11:45:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm6302501pfn.156.2020.03.20.11.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:45:26 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:45:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        osa-contribution-log@amazon.com
Subject: Re: [PATCH v2] selftests: Add support for argc and argv.
Message-ID: <202003201144.CF5A8A1E@keescook>
References: <20200320131428.98093-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131428.98093-1-kuniyu@amazon.co.jp>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 20, 2020 at 10:14:28PM +0900, Kuniyuki Iwashima wrote:
> Currently tests are often written in C and shell script. In many cases, the
> script passes some arguments to the C program. However, the helper
> functions do not support arguments, so many tests are written without
> helper functions.
> 
> This patch allows us to handle argc and argv in each tests and makes it
> easier to write tests flexibly with helper functions.

Can you give an example of how this would be used? I'd still prefer to
see this as creating a custom struct within the test metadata struct so
the harness only has to parse argv once.

-Kees

> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> ---
>  tools/testing/selftests/kselftest_harness.h | 43 +++++++++++++--------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..680a6e42f58b 100644
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
> @@ -241,7 +244,10 @@
>  #define FIXTURE_SETUP(fixture_name) \
>  	void fixture_name##_setup( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
> -		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
> +		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> +		int __attribute__ ((unused)) argc, \
> +		char __attribute__ ((unused)) **argv)
> +
>  /**
>   * FIXTURE_TEARDOWN(fixture_name)
>   * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
> @@ -261,7 +267,9 @@
>  #define FIXTURE_TEARDOWN(fixture_name) \
>  	void fixture_name##_teardown( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
> -		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
> +		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
> +		int __attribute__ ((unused)) argc, \
> +		char __attribute__ ((unused)) **argv)
>  
>  /**
>   * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
> @@ -293,19 +301,21 @@
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
>  		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
> -		fixture_name##_setup(_metadata, &self); \
> +		fixture_name##_setup(_metadata, &self, argc, argv); \
>  		/* Let setup failure terminate early. */ \
>  		if (!_metadata->passed) \
>  			return; \
> -		fixture_name##_##test_name(_metadata, &self); \
> -		fixture_name##_teardown(_metadata, &self); \
> +		fixture_name##_##test_name(_metadata, &self, argc, argv); \
> +		fixture_name##_teardown(_metadata, &self, argc, argv); \
>  	} \
>  	static struct __test_metadata \
>  		      _##fixture_name##_##test_name##_object = { \
> @@ -321,7 +331,9 @@
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
> @@ -634,7 +646,7 @@
>  /* Contains all the information for test execution and status checking. */
>  struct __test_metadata {
>  	const char *name;
> -	void (*fn)(struct __test_metadata *);
> +	void (*fn)(struct __test_metadata *, int, char **);
>  	int termsig;
>  	int passed;
>  	int trigger; /* extra handler after the evaluation */
> @@ -695,7 +707,7 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
>  	return 0;
>  }
>  
> -void __run_test(struct __test_metadata *t)
> +void __run_test(struct __test_metadata *t, int argc, char **argv)
>  {
>  	pid_t child_pid;
>  	int status;
> @@ -709,7 +721,7 @@ void __run_test(struct __test_metadata *t)
>  		printf("ERROR SPAWNING TEST CHILD\n");
>  		t->passed = 0;
>  	} else if (child_pid == 0) {
> -		t->fn(t);
> +		t->fn(t, argc, argv);
>  		/* return the step that failed or 0 */
>  		_exit(t->passed ? 0 : t->step);
>  	} else {
> @@ -755,8 +767,7 @@ void __run_test(struct __test_metadata *t)
>  	alarm(0);
>  }
>  
> -static int test_harness_run(int __attribute__((unused)) argc,
> -			    char __attribute__((unused)) **argv)
> +static int test_harness_run(int argc, char **argv)
>  {
>  	struct __test_metadata *t;
>  	int ret = 0;
> @@ -768,7 +779,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
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
