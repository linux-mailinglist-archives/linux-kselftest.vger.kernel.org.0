Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC77D7BB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJZElH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJZEko (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:40:44 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C5170D;
        Wed, 25 Oct 2023 21:40:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9b2ca542e5so343363276.3;
        Wed, 25 Oct 2023 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698295205; x=1698900005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIsqONf3Q1y0JGEcGNft9ou71IkLzaprkuT+NWbOdW0=;
        b=YD1k1p+u2WPM1LHLUVY2EdURYPaHc7K7evFpJx18Ej/tJdtuXRxGnHpQnIJuQgZQ9p
         JDu4It9xD8ZWc2f7Ixw6RVcbAN6ZBYHzkDGgiZHgy+35aj0W1bjJloPUk31a2zlEfbYt
         clz/CfYVOtIQNKV7b1Oz9ZxRgY9L9YBPvrT/imjYK0OMqwiFtW+gPiGpf37VAF2oD6Bs
         bfk6WIzx5rUPMRD3okD6TUup/TwFUxBw586eoJIQrC7VUJRMxuJVVxp7PsgwpWrlMiMl
         wW1CaQlDifWg/Hp/hGnWhG5PzveR4uqoFlfO9t47GkkYtUMGLJMkML7H27+KTmMjznLW
         d0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698295205; x=1698900005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIsqONf3Q1y0JGEcGNft9ou71IkLzaprkuT+NWbOdW0=;
        b=LPUNdX7JZjAx8c88uDatSgppQ5XtmnnrHTZaA8hrqpIaxEiZrRbYbxaMO9S2qmbwZT
         CMyanmlPMCZVBVislksjsXFIvJJdP5Tp2HXpGOUvovn2EMtBJO5GwOkOIAZzVGYJz66/
         WknIMocykmUPCactwvc0lYmPStg7Q0y6rNQHNbs4e5kwuaM4IAr4s8rwT+kh+Y0kw9sb
         egwXazDvst4FTBCgKQuLiUGB5PYxFKRRusOkRLW/pgT0odTks57XPgvZJOcZCRGRrjB6
         Yv7Ddzb7Gc0Xn9JJ+mAW8xacJBMHieRK+7FKW/miZWWdQ6Tfsqtzf+iKC+hCkuJ/eKTf
         c9RA==
X-Gm-Message-State: AOJu0Yye+Cza3tiFSxHMDogaIS4FJJjCtJaZA2bFA2I6BW+q3tfmlbJz
        27PnevBMbbPkgyD1zAty0Xf3zipGmoY=
X-Google-Smtp-Source: AGHT+IH3GZApGUxeCBeb/skljKePhuSQcKYVTS4HIvryWlSGIprA0D4h9kcdM7SqGkjOGulQkpQlXA==
X-Received: by 2002:a05:6902:567:b0:d9b:37dd:a3d7 with SMTP id a7-20020a056902056700b00d9b37dda3d7mr17308006ybt.17.1698295204735;
        Wed, 25 Oct 2023 21:40:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8355:61d5:b55:33e7? ([2600:1700:6cf8:1240:8355:61d5:b55:33e7])
        by smtp.gmail.com with ESMTPSA id g203-20020a25dbd4000000b00da041da21e7sm1921108ybf.65.2023.10.25.21.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 21:40:04 -0700 (PDT)
Message-ID: <8a14c779-441d-424c-b1f4-fdc7c5ce407e@gmail.com>
Date:   Wed, 25 Oct 2023 21:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add malloc failure checks
 in bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, bpf@vger.kernel.org,
        yonghong.song@linux.dev
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, brauner@kernel.org, iii@linux.ibm.com,
        kuifeng@meta.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026020319.1203600-1-yuran.pereira@hotmail.com>
 <DB3PR10MB6835A2CBEE0EBE31D07FABFAE8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB6835A2CBEE0EBE31D07FABFAE8DDA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Good job! LGTM

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>


On 10/25/23 19:03, Yuran Pereira wrote:
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
> index 7db6972ed952..955d374ba656 100644
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
> @@ -869,6 +869,8 @@ static void test_bpf_percpu_hash_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc"))
> +		goto out;
>   
>   	err = bpf_iter_bpf_percpu_hash_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
> @@ -1046,6 +1048,8 @@ static void test_bpf_percpu_array_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc"))
> +		goto out;
>   
>   	err = bpf_iter_bpf_percpu_array_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
