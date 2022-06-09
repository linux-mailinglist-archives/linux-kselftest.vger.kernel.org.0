Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F76545579
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiFIUV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFIUVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:21:24 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4C32CCBB
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:21:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n11so3437933iod.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hbjsCkc5VcrKbwrpI2lbtI+DgR6AjeMEXFgKFCJE1kc=;
        b=BuYSNz5oIoqpmt2ae1UvZRNPsVpi+zNAvi9vURaeSLvut1JqjvF/ff88Fmso1dsdsj
         8n6o7llaRkjm7oSW81w907d36f/y5QSxxPaF+CSTg1xE5XJ8T1b8/UllbavkBqSiJVeE
         RPl73boF/sJza0Ej04A61GTdaNSOPUpY/6ShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbjsCkc5VcrKbwrpI2lbtI+DgR6AjeMEXFgKFCJE1kc=;
        b=LNUL/4Cs3mtjVe6LYbiI0DlEMldHxlVvh1YQTUitn/DzkK7bkwbGqv3LXoTHOb3XWH
         udcYotb7WjLgMiH/zqsAkjLLz8vNL+jJfmO/e1hG+spdmbZDQQsDNBMGLvUXP9/EVQye
         /GAqXBoAtoFROXBXbRZg77T4wKBPR3v0pxdvPs07BK9bBJAa/cAC/kiykajcOFW0N+h7
         grCrs91FnCvyAlfBAug2OG982QCk0BJ4ZbTtsD/JcZLnuQLUuSJfc1HF75PI1c+Wcprd
         v8QlYJqr2ZIK62mmql76UTwtTdmI6sNY2AKjVZKSfl9B3fOq+tGLZIV/Ek0c8EOYNbl5
         VdJA==
X-Gm-Message-State: AOAM532S1mI5q+tRfOFXhO9mfbrKKUm7JWu3UqtfYo0l0AnjP8VwPhLn
        cN6B3Ocf+nIUB14UUrzSGMG4Sg==
X-Google-Smtp-Source: ABdhPJx9VCZClcKJZw1lnRwB1s8ypiU40KVRrqyNTJynafJ3Gjzoc89vcjXHq8zmK/gazJTJM8wHdA==
X-Received: by 2002:a6b:4019:0:b0:669:3314:ebcb with SMTP id k25-20020a6b4019000000b006693314ebcbmr15135420ioa.197.1654806082106;
        Thu, 09 Jun 2022 13:21:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r15-20020a92ce8f000000b002d1a16ef24dsm10785788ilo.82.2022.06.09.13.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:21:21 -0700 (PDT)
Subject: Re: [PATCH] selftests/vm: Add protection_keys tests to run_vmtests
To:     Kalpana Shetty <kalpana.shetty@amd.com>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220531102556.388-1-kalpana.shetty@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b0aab3f-83f4-80f7-6df0-447561f0da88@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:21:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220531102556.388-1-kalpana.shetty@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/22 4:25 AM, Kalpana Shetty wrote:
> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>

Missing commit log - please add a detailed commit log explaining why
this change is necessary.

> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 41fce8bea929..54a0c28f810c 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -179,4 +179,11 @@ run_test ./ksm_tests -N -m 1
>   # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>   run_test ./ksm_tests -N -m 0
>   
> +# protection_keys tests
> +if [ $VADDR64 -eq 0 ]; then
> +	run_test ./protection_keys_32
> +else
> +	run_test ./protection_keys_64
> +fi
> +
>   exit $exitcode
> 

thanks,
-- Shuah
