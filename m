Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2F7B119F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 06:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI1EgV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1EgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 00:36:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE711F
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 21:36:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32336a30d18so4538386f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695875778; x=1696480578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2bcLuLiz5kt9TeX+bNBG/mep7u1wIsN3ZLYP7gCuuA=;
        b=YN75xvsv6MvgDQi7nxxXdq49AdWejQ3dD2SpVgOUwRoeR9l8b65CNdUN/l8GC7D4ph
         EHOGsnhESeVJvOxEjFxraq077E5I60T3hw4RAh9qcmh3hueOEsq7r+NzUknXDvy/NySr
         A3A4CeCFpP5WXaaT+A+gdho4jvg+wF1phhDjK/EN9P6NdxBVLbWyRVcNYrm9dc5cX1xT
         c3zoFsBsQG7qk+qO4V+sXFF6EzQ5kr+1K0LwbGsLJsAlRvtHaF5SGOM+O5d6/N4tipID
         s4/RMKRQfkPtoMACj1VKSuvnFTGrrrflVAPMlRLGBiVKdK8JRHistM10enZKJCcOnuqF
         Pjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695875778; x=1696480578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2bcLuLiz5kt9TeX+bNBG/mep7u1wIsN3ZLYP7gCuuA=;
        b=GwYm/HJyn//RSM0VpUw50xmF1e4cKDrB37mBcDxSktfB1SHfx966yReF++K90jsdVd
         4PCuN4oeXSZ+ObXai35s8HY2Dq7jTyITZ7mGNqB9B8S5F978toelLTREb11nqGhdUleL
         7gNxS6E2MmLfOch2IHK2ucsBczYel/T4BPcXmaSvu+Hd31tRzLaxvhTJiWjLbiNX+qEH
         nA497HCLB94VfuGSsI0oxRSy4i8TqSxabCFQtpUOfnjkQ8O3MJm6hs84buQhZ1JJ1pCr
         TRndtAHmeHoYpr4Rm9NnKdbQ8wf48uGeTUuBxRc4BSh3s2qODVDOpZYBm8EDj8W+mcP/
         hfsQ==
X-Gm-Message-State: AOJu0YzNnes9Eh/6FsSo9+BMyAmcC/hkZePGb3Irnj2rLAuMkSVDFLQD
        NHerqlMwnF3VmqUfSKVMMUQ9lg==
X-Google-Smtp-Source: AGHT+IEKQquHV5xUHZcRSr2EmP/MAa80mSZoGKUcYQEprN4XvYxeuyq9TeAwGMT3RBc8MSsAjuYg7Q==
X-Received: by 2002:adf:e90e:0:b0:323:36f1:c256 with SMTP id f14-20020adfe90e000000b0032336f1c256mr154063wrm.11.1695875777785;
        Wed, 27 Sep 2023 21:36:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0031c5b380291sm18511301wrs.110.2023.09.27.21.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 21:36:17 -0700 (PDT)
Date:   Thu, 28 Sep 2023 07:36:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: debugfs: Handle errors from alloc_string_stream()
Message-ID: <55e247b6-e3b2-44a8-89c2-3cca9340dba2@kadam.mountain>
References: <20230927165058.29484-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927165058.29484-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 05:50:58PM +0100, Richard Fitzgerald wrote:
> In kunit_debugfs_create_suite() give up and skip creating the debugfs
> file if any of the alloc_string_stream() calls return an error or NULL.
> Only put a value in the log pointer of kunit_suite and kunit_test if it
> is a valid pointer to a log.
> 
> This prevents the potential invalid dereference reported by smatch:
> 
>  lib/kunit/debugfs.c:115 kunit_debugfs_create_suite() error: 'suite->log'
> 	dereferencing possible ERR_PTR()
>  lib/kunit/debugfs.c:119 kunit_debugfs_create_suite() error: 'test_case->log'
> 	dereferencing possible ERR_PTR()
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")
> ---
>  lib/kunit/debugfs.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 270d185737e6..73075ca6e88c 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -109,14 +109,27 @@ static const struct file_operations debugfs_results_fops = {
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>  	struct kunit_case *test_case;
> +	struct string_stream *stream;
>  
> -	/* Allocate logs before creating debugfs representation. */
> -	suite->log = alloc_string_stream(GFP_KERNEL);
> -	string_stream_set_append_newlines(suite->log, true);
> +	/*
> +	 * Allocate logs before creating debugfs representation.
> +	 * The log pointer must be NULL if there isn't a log so only
> +	 * set it if the log stream was created successfully.
> +	 */
> +	stream = alloc_string_stream(GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(stream))
> +		goto err;

So when you're programming, there is an aspect where you are telling the
computer what to do, but there is also an aspect where you are
communicating to other programmers.  Checking for IS_ERR_OR_NULL() works
in terms of computers, but in terms of communicating to humans it's
misleading.  And to be honest the comments are even more confusing
because they suggest something complicated is happening so I had to
review the code extra carefully.

When a function returns both error pointers and NULL then it means
it is an optional feature which can be disabled.  Error pointers means
errors.  NULL means disabled.  So typically the IS_ERR_OR_NULL() or
NULL check looks like this:

	blinky_lights = get_blinky();
	if (IS_ERR_OR_NULL(blinky_lights))
		return PTR_ERR(blinky_lights);

	blinky_lights->blink();
	return 0;

This means that the function requires the blinky feature to continue.
If blinky_lights is an error pointer then it returns an error.  If
blinky_lights is NULL then PTR_ERR(NULL) is zero which is success.  We
didn't blink the lights but only because the admin told us not to.  It's
a no-op but it's not an error.

In this case, alloc_string_stream() is not optional.  It only returns
error pointers.  It can never return NULL.

I have written a blog about this in more detail but already this email
is probably longer than my blog was.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

regards,
dan carpenter

