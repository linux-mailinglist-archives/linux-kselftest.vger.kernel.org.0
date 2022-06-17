Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907254FD8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiFQTb5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiFQTb4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 15:31:56 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D885548A
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 12:31:55 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101b0266185so2586240fac.6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EM4WuQB1JkdTQD8PY45ndgmJsVAA9Yd6J+wbPO6NpPg=;
        b=TcZ7SsxLlJOf8PjxVePN9jg050m+yfM+JWoqwMqqcRQognupSR97SauP4yE0s235yb
         ddqXUpJ2jmqQ2cPn0LYI/eUMXwGCnQYZGxq09p1VvIOFWOKnXPLd6CCuPMPvgPP+a5Of
         YbzaWxRWjHeubq5L+RnC2r7UE+g4xISk26HfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EM4WuQB1JkdTQD8PY45ndgmJsVAA9Yd6J+wbPO6NpPg=;
        b=QqjoDM4A47OgolgVQKdeBGRZJmtF+qgGU8TiuGmACWAm6WFylKhPARwMHI/hqmiQ9m
         nac96zu3tiAC7ewH4yZKwKWOMcR3lx2wWV2pRnwiiUPY8huw+hhy11g1MteMa1oQ6DDp
         ffsCZRIErTN0y4yiDtBFBDtWRQZTKA/86EGT/BgKJv1QECzbjb5ImtGVvyHEsRzf0Tws
         dgLzFRWJtCiN++r0wW/p1wB1ucw5gY1h9o5BBEqL6dIx+tprTuXRUF6swDIG6TqNpMYs
         mUtFTm2PNMURa8nakZs4VOzwg7SCBhzGx1aw2bHWXKCHaB9vcPRJtIRCoFz05UzerFTl
         R/Ww==
X-Gm-Message-State: AJIora99M3Jkhc7Kr1nHV5QaMnWqaJsebJcj0LszvuOz6oE9iMf/rk9V
        vaZaKNE/SiUU5wgpxsydLmGJ3Q==
X-Google-Smtp-Source: AGRyM1udGQRr7r3xRSI/SRpvnZ3d7wdlghukWbcfvBoS9d8ngIokzM5DUrYDRBl24rE/d98H+8gkjw==
X-Received: by 2002:a05:6870:6097:b0:e1:a94d:9a38 with SMTP id t23-20020a056870609700b000e1a94d9a38mr6481520oae.191.1655494314848;
        Fri, 17 Jun 2022 12:31:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w4-20020a9d3604000000b0060aeccf6b44sm2944399otb.41.2022.06.17.12.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:31:54 -0700 (PDT)
Subject: Re: [PATCH V3] selftests/vm: Add protection_keys tests to run_vmtests
To:     Kalpana Shetty <kalpana.shetty@amd.com>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220617111019.476-1-kalpana.shetty@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f73fd7c9-cb9c-1e89-4e22-e6931172eb91@linuxfoundation.org>
Date:   Fri, 17 Jun 2022 13:31:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220617111019.476-1-kalpana.shetty@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/17/22 5:10 AM, Kalpana Shetty wrote:
> Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
> from a single shell script.
> 
> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
> ---
> Changes in V3:
>   Shuah Khan's review comments incorporated, added protection_keys binary check.
> 
>   tools/testing/selftests/vm/run_vmtests.sh | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 41fce8bea929..b19c6b1b84c4 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -179,4 +179,15 @@ run_test ./ksm_tests -N -m 1
>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>   run_test ./ksm_tests -N -m 0
>   
> +# protection_keys tests
> +if ./protection_keys_32 &> /dev/null
> +then
> +	run_test ./protection_keys_32
> +fi
> +
> +if ./protection_keys_64 &> /dev/null
> +then
> +	run_test ./protection_keys_64
> +fi
> +
>   exit $exitcode
> 

Why not use file test operators. -x works for this case.
There is no need to run attempt to run the test.

thanks,
-- Shuah
