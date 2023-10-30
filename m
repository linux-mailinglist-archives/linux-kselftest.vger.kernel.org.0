Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29277DC0B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 20:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJ3Tjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjJ3Tjx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 15:39:53 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD37E9;
        Mon, 30 Oct 2023 12:39:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d84c24a810dso4298325276.2;
        Mon, 30 Oct 2023 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694790; x=1699299590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsBULrXurlnUUPobuOc2JUUL821FidVFYB/7ZUCqbqQ=;
        b=affjcAxq8GDH1iWylxRciBvEF76ZtfcQ79HLiXCSFutJNAa0mPHahYlZfdHOiSjRog
         4AXZd0Hrl6aYupmmAv/JC1u/3Z54aCgwYOH4Hm3OxD+ydW6J+q03dP6aCWCjA3LlhO8h
         Epdn91HY+aRGictRbd/fNFdNZAH2qHSJSvGNpBmMcv1tjSj0oRQg8B9yyc5WZztiCO24
         XdqWM1Jg2UqukWkCNX4yHffZth/GWTiA+ICn20u1b8liwSlK5ByvO57v4rQDI/cWEGG0
         QamHH0iW5b5Ja0GNYYGrdM5aL2kTDGimHYBS6Ahzj8OygSGY8K1Jh4HHMKZLXhYIe2R9
         78Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694790; x=1699299590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsBULrXurlnUUPobuOc2JUUL821FidVFYB/7ZUCqbqQ=;
        b=s6ikpTjWLaulhyM8Dzq0B2qmD7pwLNE5EO5QKN0c5D/Z4WFiu4/ixyNpsSYSOHIM9R
         mfNP7ZiK9t4MqwBn4iSCAU4w/cCBZe1zUiNQxTKr2eZ+TNkPpVlv355Rodx1XK6Zw3X9
         xTvEI/CqU3Rf3oHwrf4I8ieIqwESF+EuC2YnIRphwiTYbuBWd5YmpbdeXuqdKsDhdYey
         UfkCh8rcWjfOuOdxa2WYBPDM+lh2cGtSpGafANd74fjyLWcnjFn93N5KLge9aVcFWZ2u
         MP02Q1SSWpD/ys33NpBz4xjhPiiqEYLtiD++24agoFsJeyd2/RQY4C3o5oHQNL6Dg2x0
         89Yg==
X-Gm-Message-State: AOJu0Yz/965Wy1VTNJDSP29Ua1CJcUyAjWMs4IdnM6rq18T9LxRIiaFz
        aqCXSqtmXgpRZGT4u1dV/BU=
X-Google-Smtp-Source: AGHT+IHn+RPSeNCAzAD8bj9UAzLPTZbj8frSIeBf08GihOIWy7m2i+qPYQdsJCMar4vwnVBfSg/OtQ==
X-Received: by 2002:a5b:c2:0:b0:d9a:da03:2417 with SMTP id d2-20020a5b00c2000000b00d9ada032417mr9478650ybp.45.1698694789691;
        Mon, 30 Oct 2023 12:39:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5b04:e8d1:ce5:8164? ([2600:1700:6cf8:1240:5b04:e8d1:ce5:8164])
        by smtp.gmail.com with ESMTPSA id k11-20020a056902024b00b00d7b9fab78bfsm62003ybs.7.2023.10.30.12.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 12:39:49 -0700 (PDT)
Message-ID: <767f32a8-d00b-4bb9-bbea-f972caced064@gmail.com>
Date:   Mon, 30 Oct 2023 12:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add malloc failure checks
 in bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org,
        yonghong.song@linux.dev
Cc:     ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, iii@linux.ibm.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuifeng@meta.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mykolal@fb.com, sdf@google.com, shuah@kernel.org, song@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <cover.1698461732.git.yuran.pereira@hotmail.com>
 <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB6835F0ECA792265FA41FC39BE8A3A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>

On 10/27/23 22:24, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
> 
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 123a3502b8f0..1e02d1ba1c18 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -698,7 +698,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   		goto free_link;
>   
>   	buf = malloc(expected_read_len);
> -	if (!buf)
> +	if (!ASSERT_OK_PTR(buf, "malloc"))
>   		goto close_iter;
>   
>   	/* do read */
> @@ -868,6 +868,8 @@ static void test_bpf_percpu_hash_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc"))
> +		goto out;
>   
>   	err = bpf_iter_bpf_percpu_hash_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
> @@ -1044,6 +1046,8 @@ static void test_bpf_percpu_array_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc"))
> +		goto out;
>   
>   	err = bpf_iter_bpf_percpu_array_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
