Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3D501DB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiDNVwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiDNVwR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 17:52:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA416468
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:49:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b5so3971164ile.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0JHKXPIUQwXKIyQID2uNw8AWiNJuyCq0B2NuHEUdjw=;
        b=dv9D5fNYDGcObkc1VhdDNV3GXjucyxDSnq8AFxBOd4Ons3E2R04iKBRBObfrlte5Xd
         KWo1msVoXlM72zJxXJj9OjCnEHb5QPDwTL8l5vZsIwbhhOdEp0nriEZ20xAt/MT7H61x
         oPJ5/FMYlbmLuywl6Jyn2lT+zDeQzb5mhxNhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0JHKXPIUQwXKIyQID2uNw8AWiNJuyCq0B2NuHEUdjw=;
        b=aQXH5suJ+VwdxOGyYhhq4rVinnpNYBee51uWePXOeJUGFVKuzoYurrWik2r/z7BVkg
         YRHaIJ1R6fIG/vcNqrZCCMjWw+AwyEn16flR/UrEfYCN9Xpxr6IWod5KF1QKk4eb1p4V
         6IJUTvkoKU0KQ4YknelhIIz+BggL+b1QQZMU1u1pZ+tzgvy8ms70PFlq9Beq1s3k4hg0
         tgrKTYYRI3JRYka4gbWtyyX8X6Q+Uh3KGy+K5RY42hLauUVMuqEqQtn0pHfzyikl8pfa
         8P/rvOsjM2e9LjEeP38Dg0LKWHuyeP1KKLp+ZTaEUwdnP/kHinnvFnxn1wFQyNYIoNEQ
         0lBA==
X-Gm-Message-State: AOAM531+hTzg8Qhkljkzlr2FYvKBhGcZ8789/WqVfAbuQvYcxc3Tggo2
        KftsCEYDbbxZx2m/NJipSY/4XA==
X-Google-Smtp-Source: ABdhPJxzMy3EDhRCosc7hcDTPIL3RBmm5BQ8HqWic0WC9oy4qeJYkXOIMPf9IS63ZcjhoaqKzpnvXg==
X-Received: by 2002:a92:6c08:0:b0:2c6:123f:48c9 with SMTP id h8-20020a926c08000000b002c6123f48c9mr1972848ilc.22.1649972990653;
        Thu, 14 Apr 2022 14:49:50 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v11-20020a92d24b000000b002caacf87598sm1657423ilg.1.2022.04.14.14.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 14:49:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] selftest/vm: add skip support to mremap_test
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>, shuah@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220414171529.62058-1-sidhartha.kumar@oracle.com>
 <20220414171529.62058-5-sidhartha.kumar@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae52647e-8d14-b86b-eea3-24331ad488b0@linuxfoundation.org>
Date:   Thu, 14 Apr 2022 15:49:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220414171529.62058-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/22 11:15 AM, Sidhartha Kumar wrote:
> Allow the mremap test to be skipped due to errors
> such as failing to find a valid remap region and
> failure to parse the mmap_min_addr sysctl.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   tools/testing/selftests/vm/run_vmtests.sh | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 88e15fbb5027..eae98f5de2cc 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -272,11 +272,16 @@ echo "-------------------"
>   echo "running mremap_test"
>   echo "-------------------"
>   ./mremap_test
> -if [ $? -ne 0 ]; then
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +	echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
>   	echo "[FAIL]"
>   	exitcode=1
> -else
> -	echo "[PASS]"
>   fi
>   
>   echo "-----------------"
> 

Thank you. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
