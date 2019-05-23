Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8080E28D66
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfEWWtl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:49:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38834 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfEWWtl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:49:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so3884463pgl.5
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRhnfhW1pi3C2ZlhJx19eGc+Tjmk+kvazd7wKA5kIrw=;
        b=eloOGmNDsmQkYtjXi8CItLfPST4WhVInOkbaIVjBjcYTtwwTCR7ARGTYzjg+ywFB8G
         m2B27oUY2MefMAgTjRLx/6B2Zjfi7aIt0G+JItlFxREh4TZWmXv08HZ3gWYr4a7rBjmf
         WRhDxu3Oee/M3eGl2Xy40nSa5xh3w3rTdNQRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRhnfhW1pi3C2ZlhJx19eGc+Tjmk+kvazd7wKA5kIrw=;
        b=AXdlkOVb+PuunCbVr119E/sKqb/aLy8FnxgFri693/+gpCGEyIPDgd7s3t6F4zEhUJ
         pIcK70UXwy5fErjDt41BKYH0UY+09QegaBJVs9bA15DnOjPp5egUFtOh9Dz9BCMRErZV
         Y+hpW2iMRuTqX4FkOd/iOXSSr9fOgVlu/hCUPX66nEMS6mLq2jvYmDyu12pUd78cVB8Q
         kC5+w9S/PSH/8i23KgQymrDnzOStdzCECxeULgHJEzOmkeESpRS6+C67PMoEnrx8rKVZ
         s1V9WU3AvftZvPS2vigrdlPqvXO2IjRNXsN6J8UuBuPXjXm7R/QM7rPhUpG4H3DY/v9z
         klqw==
X-Gm-Message-State: APjAAAXKHyXvfSd21sSosJ8ApI14oToPoJhBz+OBQRfSZyGLl4DEDlfP
        jFmeW1KWhCdOkmzHwblN1rAflQ==
X-Google-Smtp-Source: APXvYqzN01DxqxgbCPhrB0xpAR+HHvr9tb4FmsaKyTnmDEQiSu5S+m9khJPvvGEpSEerMjppREFPiw==
X-Received: by 2002:a62:6dc6:: with SMTP id i189mr107434670pfc.155.1558651779909;
        Thu, 23 May 2019 15:49:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm495618pfh.113.2019.05.23.15.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:49:39 -0700 (PDT)
Date:   Thu, 23 May 2019 15:49:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/harness: Allow test to configure timeout
Message-ID: <201905231549.0952C6CE@keescook>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
 <20190523224223.11054-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523224223.11054-2-alexandre.belloni@bootlin.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 24, 2019 at 12:42:22AM +0200, Alexandre Belloni wrote:
> Commit a745f7af3cbd ("selftests/harness: Add 30 second timeout per test")
> adds an hardcoded 30s timeout to all tests. Unfortunately, rtctest has two
> tests taking up to 60s. Allow for individual tests to define their own
> timeout.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Ah yes. Very nice; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  tools/testing/selftests/kselftest_harness.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 941d9391377f..2067c6b0e8a1 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -62,6 +62,7 @@
>  #include <sys/wait.h>
>  #include <unistd.h>
>  
> +#define TEST_TIMEOUT_DEFAULT 30
>  
>  /* Utilities exposed to the test definitions */
>  #ifndef TH_LOG_STREAM
> @@ -169,7 +170,8 @@
>  	static void test_name(struct __test_metadata *_metadata); \
>  	static struct __test_metadata _##test_name##_object = \
>  		{ .name = "global." #test_name, \
> -		  .fn = &test_name, .termsig = _signal }; \
> +		  .fn = &test_name, .termsig = _signal, \
> +		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
>  	static void __attribute__((constructor)) _register_##test_name(void) \
>  	{ \
>  		__register_test(&_##test_name##_object); \
> @@ -280,12 +282,15 @@
>   */
>  /* TODO(wad) register fixtures on dedicated test lists. */
>  #define TEST_F(fixture_name, test_name) \
> -	__TEST_F_IMPL(fixture_name, test_name, -1)
> +	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
>  
>  #define TEST_F_SIGNAL(fixture_name, test_name, signal) \
> -	__TEST_F_IMPL(fixture_name, test_name, signal)
> +	__TEST_F_IMPL(fixture_name, test_name, signal, TEST_TIMEOUT_DEFAULT)
>  
> -#define __TEST_F_IMPL(fixture_name, test_name, signal) \
> +#define TEST_F_TIMEOUT(fixture_name, test_name, timeout) \
> +	__TEST_F_IMPL(fixture_name, test_name, -1, timeout)
> +
> +#define __TEST_F_IMPL(fixture_name, test_name, signal, tmout) \
>  	static void fixture_name##_##test_name( \
>  		struct __test_metadata *_metadata, \
>  		FIXTURE_DATA(fixture_name) *self); \
> @@ -307,6 +312,7 @@
>  		.name = #fixture_name "." #test_name, \
>  		.fn = &wrapper_##fixture_name##_##test_name, \
>  		.termsig = signal, \
> +		.timeout = tmout, \
>  	 }; \
>  	static void __attribute__((constructor)) \
>  			_register_##fixture_name##_##test_name(void) \
> @@ -632,6 +638,7 @@ struct __test_metadata {
>  	int termsig;
>  	int passed;
>  	int trigger; /* extra handler after the evaluation */
> +	int timeout;
>  	__u8 step;
>  	bool no_print; /* manual trigger when TH_LOG_STREAM is not available */
>  	struct __test_metadata *prev, *next;
> @@ -696,7 +703,7 @@ void __run_test(struct __test_metadata *t)
>  	t->passed = 1;
>  	t->trigger = 0;
>  	printf("[ RUN      ] %s\n", t->name);
> -	alarm(30);
> +	alarm(t->timeout);
>  	child_pid = fork();
>  	if (child_pid < 0) {
>  		printf("ERROR SPAWNING TEST CHILD\n");
> -- 
> 2.21.0
> 

-- 
Kees Cook
