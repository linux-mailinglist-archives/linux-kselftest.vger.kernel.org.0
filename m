Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ADD7D5FF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjJYC2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYC2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 22:28:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC04B9C;
        Tue, 24 Oct 2023 19:28:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7af45084eso49799737b3.0;
        Tue, 24 Oct 2023 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698200908; x=1698805708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkXuQzkQb+jK+JnLy74+lQFSLJd+H01wVDWMIZ2Mra8=;
        b=C5RWjBaFAL8BFWcZ+eW0T+fLS/GW0/62fL9trz/QszVBEfVJtix66Ghk/9ERYnBPC2
         nchs6dAdzSriViu+qrtBfX6aKggl+7haRW+1rG7s8Zav5UlewUh50dC9CC5Wbyfs4FZO
         QdORIx8bF79KXRJyh0R6LJUW8cv+00kn3gigrj9Fb8sU2I/2fwfx9CzW1nr3NPR58ana
         mHiGcZbmj7DK6P6DxSFH9th0dzSvUWqu6iS+cB4224UVf5G7wYLvEXFBNzsKHC1vwFLP
         +qWF7MprOm0bHkHmuVFTP88CI3oBgHALBjRnys3letj5LfrC6S6+NTYqqEKhI0frpIWh
         HQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698200908; x=1698805708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkXuQzkQb+jK+JnLy74+lQFSLJd+H01wVDWMIZ2Mra8=;
        b=QbGdo0rIJoJIPOwPxI1JRls/3q7dJIXn/Bug7ZCNtWxezpPD9y/qT7Hw8W/lFCMfEI
         dGqNl4+GXd6dx/O+4rR+67K2YDk6RMahJ7fQPjc/YKmaD3JA+ly0Y/fpLeHR0Fn82I1p
         XbQf76pfHu6XKfRz5lCkqADPu4xyROPsYxUSwfBdA9JsDGVK0CuC6NYdpqr9Aya8a8b/
         Ik46ggmzdLpT2KTrnHGpX0Ul4P9UHtU9oKsbwEKgTiX0Rma/P5vcfndeANLXwV/E0mFz
         36K9cwaLsokoqI+eVrQtRKDYIqtagy4rbsriYyQWpGOBFDrpdrVgNOmNNQVPnjmZ521K
         cdMQ==
X-Gm-Message-State: AOJu0YwIBHxQ6U54ZEtVhvP7sjRmAR2vamMdQQXI48CLpIztSL/HNSX8
        PkbSi5cn3pbUTnX6jerIByc=
X-Google-Smtp-Source: AGHT+IG6Cs/nZ3XDq7UeLBk+Eo+fCu4fZ2A/k4C9XO3gtRuYUm+XXRQmaUII/q0OR3a9RMIIEAefOA==
X-Received: by 2002:a81:6d8d:0:b0:5a7:b8e6:6441 with SMTP id i135-20020a816d8d000000b005a7b8e66441mr12768735ywc.16.1698200907837;
        Tue, 24 Oct 2023 19:28:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:7b3b:34a0:2070:c5ce? ([2600:1700:6cf8:1240:7b3b:34a0:2070:c5ce])
        by smtp.gmail.com with ESMTPSA id n189-20020a0de4c6000000b005777a2c356asm4570839ywe.65.2023.10.24.19.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 19:28:27 -0700 (PDT)
Message-ID: <7d703c4c-1a24-4806-a483-c02efb666059@gmail.com>
Date:   Tue, 24 Oct 2023 19:28:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Add malloc failure checks in
 bpf_iter
Content-Language: en-US
To:     Yuran Pereira <yuran.pereira@hotmail.com>, yonghong.song@linux.dev
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        brauner@kernel.org, iii@linux.ibm.com, kuifeng@meta.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <DB3PR10MB68356D7CDF6005480BE5876CE8DEA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
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

Thank you for the patches.

I found you have two patches in this set.
You can generate both patch at once with git format-patch.
format-patch will give each patch a number in their order.
For example, the subject of this message will be

   [PATCH bpf-next 2/2] selftest/bpf: Add malloc ....

And, you put both patches in the same directory.  And sent them at once
by giving the path of the directory. For example,

   git send-email --to=bpf@vger.kernel.org path/to/the/directory/

These patches will be sent in a thread instead of two independent
messages.

On 10/24/23 18:52, Yuran Pereira wrote:
> Since some malloc calls in bpf_iter may at times fail,
> this patch adds the appropriate fail checks, and ensures that
> any previously allocated resource is appropriately destroyed
> before returning the function.
> 
> This is patch 2 in the sequence should be applied after d1a88d37cecc
> "selftests/bpf: Convert CHECK macros to ASSERT_* macros in bpf_iter"
> 
> Patch 1:
> https://lore.kernel.org/lkml/DB3PR10MB683589A5F705C6CA5BE0D325E8DFA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
> 
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 526ac4e741ee..c6cf42c64af3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -700,7 +700,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
>   		goto free_link;
>   
>   	buf = malloc(expected_read_len);
> -	if (!buf)
> +	if (!ASSERT_OK_PTR(buf, "malloc"))
>   		goto close_iter;
>   
>   	/* do read */
> @@ -871,6 +871,10 @@ static void test_bpf_percpu_hash_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc")) {
> +		bpf_iter_bpf_percpu_hash_map__destroy(skel);
> +		return;
> +	}

You can just do "goto out;" here.


>   
>   	err = bpf_iter_bpf_percpu_hash_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
> @@ -1048,6 +1052,10 @@ static void test_bpf_percpu_array_map(void)
>   
>   	skel->rodata->num_cpus = bpf_num_possible_cpus();
>   	val = malloc(8 * bpf_num_possible_cpus());
> +	if (!ASSERT_OK_PTR(val, "malloc")) {
> +		bpf_iter_bpf_percpu_array_map__destroy(skel);
> +		return;
> +	}

Same here, even it will call free(val), free(val) will do nothing when
val is NULL.

>   
>   	err = bpf_iter_bpf_percpu_array_map__load(skel);
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
