Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492A6C92D2
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCZGeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCZGd7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 02:33:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC244BD;
        Sat, 25 Mar 2023 23:33:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h11so396404lfu.8;
        Sat, 25 Mar 2023 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679812436;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGJJOvtcK4rfy8EdLpv7G1dLKnVvC2mUQhS3ItGwVPo=;
        b=Iaocolml4PQftUgPU0I7aFHb5cyFWjkR9QZa7V2703kYA1eTqC8Xg2cEI8Bn3uElO5
         LZL3DAjinapxcrRk78lh0i18RhesrZivJaxOO+RCyQR/gPbK+vMzvqoZgwkE7mJTvop6
         tXLCOmmYW+4FQhbg7AOvKVJtUhQ2LBLlP3z6p0H9pw+ZE2dd0E9qv7a0bvSxkeGp44AJ
         bTLtp8ia+um0niBr9fIG8jGyCaNUXnqLGbU1nuhpxXvaYbaCqJTST4QLnx16PuK89j6M
         4hpYVbzB3vCIdkvEFkjKcvsl7nZAb5j7OYXYV9R/HRvGimEc5vXEATMHW5/iKCprhg2A
         WuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679812436;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGJJOvtcK4rfy8EdLpv7G1dLKnVvC2mUQhS3ItGwVPo=;
        b=8EvHFvJFSXt2Iw9PG3PkvPYeAqko6emE6k45R+Ved4lXxj6aMJaclO+Dztfw8CTgJM
         P3+oy6lsGLTyeFWQQjEo0r6hfTvX6iLJ5Jt+8DTG3VYIkl3bvFRV5RkqN8L6RzQEDpZf
         ugFTx0x+jNbaE0QxIsJRCezPJ0NUQSd1ii9kstdoV0JPyrCIS/YzoYqX8Y+HNpVC3zEk
         18iMnWdLjIhKT7MUovo9Ou7tv9ahfHcePzq/USlvC7kyy2jlQgXEF7pCx47JCLL7JYgh
         2qx8CvZ2DIWR9MZh8kCGV4tLnXdHMPSUSHsz3AfmGYox99RySUZ/rdBvaOCBO/E1Px1w
         Gk3Q==
X-Gm-Message-State: AAQBX9ca/ntwAiysMjDyp/WgnY8GN7tcR3ooFt5rMqXlcJ09LYPsfa4B
        GrsLgSd0ggkXTUBfcdO5sViqi38xLjw=
X-Google-Smtp-Source: AKy350ZXYYKi6F5QRiljLOTKU3HumFIG+dhc1C+mZe/xE6McpCdJ0miMd6ZVSHa1R3saSh4W+MXyGg==
X-Received: by 2002:ac2:50d7:0:b0:4e9:6097:add3 with SMTP id h23-20020ac250d7000000b004e96097add3mr2289095lfm.61.1679812435594;
        Sat, 25 Mar 2023 23:33:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v2-20020ac25922000000b004eb09081d77sm654244lfi.91.2023.03.25.23.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 23:33:55 -0700 (PDT)
Message-ID: <33f8fd51-1cc9-a280-77ec-302b822f3e7a@gmail.com>
Date:   Sun, 26 Mar 2023 09:33:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
References: <20230325043104.3761770-1-davidgow@google.com>
 <20230325043104.3761770-2-davidgow@google.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 1/2] kunit: resource: Add kunit_defer() functionality
In-Reply-To: <20230325043104.3761770-2-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/23 06:31, David Gow wrote:
> Many uses of the KUnit resource system are intended to simply defer
> calling a function until the test exits (be it due to success or
> failure). The existing kunit_alloc_resource() function is often used for
> this, but was awkward to use (requiring passing NULL init functions, etc),
> and returned a resource without incrementing its reference count, which
> -- while okay for this use-case -- could cause problems in others.
> 
> Instead, introduce a simple kunit_defer() API: a simple function
> (returning nothing, accepting a single void* argument) can be scheduled
> to be called when the test exits. Deferred functions are called in the
> opposite order to that which they were registered.
> 
> This is implemented as a resource under the hood, so the ordering
> between resource cleanup and deferred functions is maintained.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   include/kunit/resource.h |  87 +++++++++++++++++++++++++++++++
>   lib/kunit/resource.c     | 110 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 197 insertions(+)
> 
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index cf6fb8f2ac1b..6c4728ca9237 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -387,4 +387,91 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
>    */
>   void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
>   
> +typedef void (*kunit_defer_function_t)(void *ctx);
> +
> +/**
> + * kunit_defer() - Defer a function call until the test ends.
> + * @test: Test case to associate the deferred function with.
> + * @func: The function to run on test exit
> + * @ctx: Data passed into @func
> + * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
> + *
> + * Defer the execution of a function until the test exits, either normally or
> + * due to a failure.  @ctx is passed as additional context. All functions
> + * registered with kunit_defer() will execute in the opposite order to that
> + * they were registered in.
> + *
> + * This is useful for cleaning up allocated memory and resources.
> + *
> + * RETURNS:

Is this intentional? Unless I'm mistaken the kernel-doc return value 
specifier is 'Return:'.

> + *   An opaque "cancellation token", or NULL on error. Pass this token to
> + *   kunit_defer_cancel() in order to cancel the deferred execution of func().
> + */
> +void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
> +		  void *ctx, gfp_t internal_gfp);
> +
> +/**
> + * kunit_defer_cancel_token() - Cancel a deferred function call.
> + * @test: Test case the deferred function is associated with.
> + * @cancel_token: The cancellation token returned by kunit_defer()
> + *
> + * Prevent a function deferred using kunit_defer() from executing when the
> + * test ends.
> + *
> + * Prefer using this to kunit_defer_cancel() where possible.
> + */
> +void kunit_defer_cancel_token(struct kunit *test, void *cancel_token);
> +
> +/**
> + * kunit_defer_trigger_token() - Run a deferred function call immediately.
> + * @test: Test case the deferred function is associated with.
> + * @cancel_token: The cancellation token returned by kunit_defer()
> + *
> + * Execute a deferred function call immediately, instead of waiting for the
> + * test to end.
> + *
> + * Prefer using this to kunit_defer_trigger() where possible.
> + */
> +void kunit_defer_trigger_token(struct kunit *test, void *cancel_token);
> +
> +/**
> + * kunit_defer_cancel() - Cancel a matching deferred function call.
> + * @test: Test case the deferred function is associated with.
> + * @func: The deferred function to cancel.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Prevent a function deferred via kunit_defer() from executing at shutdown.
> + * Unlike kunit_defer_cancel_token(), this takes the (func, ctx) pair instead of
> + * the cancellation token. If that function/context pair was deferred multiple
> + * times, only the most recent one will be cancelled.
> + *
> + * Prefer using kunit_defer_cancel_token() to this where possible.
> + */
> +void kunit_defer_cancel(struct kunit *test,
> +			kunit_defer_function_t func,
> +			void *ctx);
> +
> +/**
> + * kunit_defer_trigger() - Run a matching deferred function call immediately.
> + * @test: Test case the deferred function is associated with.
> + * @func: The deferred function to trigger.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Execute a function deferred via kunit_defer() immediately, rather than when
> + * the test ends.
> + * Unlike kunit_defer_trigger_token(), this takes the (func, ctx) pair instead of
> + * the cancellation token. If that function/context pair was deferred multiple
> + * times, it will only be executed once here. The most recent deferral will
> + * no longer execute when the test ends.
> + *
> + * kunit_defer_trigger(test, func, ctx);
> + * is equivalent to
> + * func(ctx);
> + * kunit_defer_cancel(test, func, ctx);
> + *
> + * Prefer using kunit_defer_trigger_token() to this where possible.
> + */
> +void kunit_defer_trigger(struct kunit *test,
> +			 kunit_defer_function_t func,
> +			 void *ctx);
>   #endif /* _KUNIT_RESOURCE_H */
> diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
> index c414df922f34..0d0c48054d45 100644
> --- a/lib/kunit/resource.c
> +++ b/lib/kunit/resource.c
> @@ -77,3 +77,113 @@ int kunit_destroy_resource(struct kunit *test, kunit_resource_match_t match,
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> +
> +struct kunit_defer_ctx {
> +	kunit_defer_function_t func;
> +	void *ctx;
> +};
> +
> +static void __kunit_defer_free(struct kunit_resource *res)
> +{
> +	struct kunit_defer_ctx *defer_ctx = (struct kunit_defer_ctx *)res->data;
> +
> +	defer_ctx->func(defer_ctx->ctx);
> +
> +	kfree(res->data);
> +}
> +
> +void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
> +				void *ctx, gfp_t internal_gfp)
> +{
> +	struct kunit_resource *res;
> +	struct kunit_defer_ctx *defer_ctx;
> +
> +	KUNIT_ASSERT_NOT_NULL_MSG(test, func, "Tried to defer a NULL function!");
> +
> +	res = kzalloc(sizeof(*res), internal_gfp);
> +	if (!res)
> +		return NULL;
> +
> +	defer_ctx = kzalloc(sizeof(*defer_ctx), internal_gfp);
> +	if (!defer_ctx)
> +		goto free_res;
> +
> +	defer_ctx->func = func;
> +	defer_ctx->ctx = ctx;
> +
> +	res->should_kfree = true;
> +	__kunit_add_resource(test, NULL, __kunit_defer_free, res, defer_ctx);
> +
> +	return (void *)res;
> +
> +free_res:
> +	kfree(res);
> +	return NULL;
> +}
> +
> +void kunit_defer_cancel_token(struct kunit *test, void *cancel_token)
> +{
> +	struct kunit_resource *res = (struct kunit_resource *)cancel_token;
> +
> +	/* Remove the free function so we don't run the deferred function. */
> +	res->free = NULL;
> +
> +	kunit_remove_resource(test, res);
> +}
> +
> +void kunit_defer_trigger_token(struct kunit *test, void *cancel_token)
> +{
> +	struct kunit_resource *res = (struct kunit_resource *)cancel_token;
> +
> +	/* Removing the resource should trigger the res->free function. */
> +	kunit_remove_resource(test, res);
> +}
> +
> +static bool __kunit_defer_match(struct kunit *test,
> +				struct kunit_resource *res, void *match_data)
> +{
> +	struct kunit_defer_ctx *match_ctx = (struct kunit_defer_ctx *)match_data;
> +	struct kunit_defer_ctx *res_ctx = (struct kunit_defer_ctx *)res->data;
> +
> +	/* Make sure this is a free function. */
> +	if (res->free != __kunit_defer_free)
> +		return false;
> +
> +	/* Both the function and context data should match. */
> +	return (match_ctx->func == res_ctx->func) && (match_ctx->ctx == res_ctx->ctx);
> +}
> +
> +void kunit_defer_cancel(struct kunit *test,
> +			kunit_defer_function_t func,
> +			void *ctx)
> +{
> +	struct kunit_defer_ctx defer_ctx;
> +	struct kunit_resource *res;
> +
> +	defer_ctx.func = func;
> +	defer_ctx.ctx = ctx;
> +
> +	res = kunit_find_resource(test, __kunit_defer_match, &defer_ctx);
> +	if (res) {
> +		kunit_defer_cancel_token(test, res);
> +		kunit_put_resource(res);
> +	}
> +}
> +
> +void kunit_defer_trigger(struct kunit *test,
> +			 kunit_defer_function_t func,
> +			 void *ctx)
> +{
> +	struct kunit_defer_ctx defer_ctx;
> +	struct kunit_resource *res;
> +
> +	defer_ctx.func = func;
> +	defer_ctx.ctx = ctx;
> +
> +	res = kunit_find_resource(test, __kunit_defer_match, &defer_ctx);
> +	if (res) {
> +		kunit_defer_trigger_token(test, res);
> +		/* We have to put() this here, else free won't be called. */
> +		kunit_put_resource(res);
> +	}
> +}

I am not really sure if you must provide the 'tokenless' cancel or 
trigger APIs. They just feel a bit much to me. Well, if you have a 
reason to do so then this looks good to me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

