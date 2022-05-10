Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BC522221
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbiEJRTz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbiEJRTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 13:19:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CADEAA
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:15:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e194so19197623iof.11
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nz2pEIp4h8cJ+3fUaGrr4f9bDrmIrqCco4B5dxN+LMQ=;
        b=RXZK9JrWJFMdbES+R8ZI1PUkoSfJCGPXf8zlSL6PvM58zUqaBQuh3k5XeJj7hoawbR
         yP7DTyfdlG/G7eAJDc1TrzwRmdxSqVQVMirk+c5HRq4kU6ZHhQ/tpskF/fSNUZE1smGh
         9rjxQIYGeB2rO4n1f3qDfxcrwCVNTxJ8IT6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nz2pEIp4h8cJ+3fUaGrr4f9bDrmIrqCco4B5dxN+LMQ=;
        b=0Y/Vb6+8BTpt3HjmISPbSeq3T55RbcI3O9fAenv7Swvk7rvL/g0sB8gGqIAMJee5VM
         mFjAmL4uKkpsLWvcGCmImOv1HDG5oA7l2nIFt+2V2jH64wnJWREgDBaxLjFiTiYP6wMQ
         lE7oqwSepGMrAbH4KpUXYOCUeM7EmDG/Y8vG1weqy4Me4XPENOnKCwQqlHJOzgBjRWg3
         0OYzjSVU10oCoj8ZAq2I5XTqZAgd9UN0mfnGXVi6XElqtrUIqybLlibtF4veRqUcywVM
         XuTv0Ef1emthFC49hH+veJNylvk28BGPPnb0HEnX2Ert8qwgJP0GKCjIZ/HAOMvg/Yei
         8pDQ==
X-Gm-Message-State: AOAM532O3dnYzH8N2qKhRN+vb444rCGJJSarA1fHBnA86faoh68ix8qd
        SmKqZA2WGWTMrZpntc+etsUhZw==
X-Google-Smtp-Source: ABdhPJywkpOBOgFEV80tGD822xrFf6WotOLN36/A0N2Tj06aJZxqhBQeUvyjOwyeEJ6OZ0afH5a7xA==
X-Received: by 2002:a05:6638:12d3:b0:32b:7235:6a08 with SMTP id v19-20020a05663812d300b0032b72356a08mr10620263jas.27.1652202942204;
        Tue, 10 May 2022 10:15:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t190-20020a0254c7000000b0032b3a7817cfsm4474033jaa.147.2022.05.10.10.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:15:41 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] selftests/arm64: Log errors in
 verify_mte_pointer_validity()
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510164520.768783-1-broonie@kernel.org>
 <20220510164520.768783-2-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dfb1b1d4-e932-733a-2cae-1cf850801625@linuxfoundation.org>
Date:   Tue, 10 May 2022 11:15:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510164520.768783-2-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 10:45 AM, Mark Brown wrote:
> When we detect a problem in verify_mte_pointer_validity() while checking
> tags we don't log what the problem was which makes debugging harder. Add
> some diagnostics.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../selftests/arm64/mte/check_tags_inclusion.c       | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> index deaef1f61076..b906914997ce 100644
> --- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> +++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> @@ -25,8 +25,11 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
>   	/* Check the validity of the tagged pointer */
>   	memset((void *)ptr, '1', BUFFER_SIZE);
>   	mte_wait_after_trig();
> -	if (cur_mte_cxt.fault_valid)
> +	if (cur_mte_cxt.fault_valid) {
> +		ksft_print_msg("Unexpected fault recorded for %p-%p in mode %x\n",
> +			       ptr, ptr + BUFFER_SIZE, mode);
>   		return KSFT_FAIL;
> +	}
>   	/* Proceed further for nonzero tags */
>   	if (!MT_FETCH_TAG((uintptr_t)ptr))
>   		return KSFT_PASS;
> @@ -34,10 +37,13 @@ static int verify_mte_pointer_validity(char *ptr, int mode)
>   	/* Check the validity outside the range */
>   	ptr[BUFFER_SIZE] = '2';
>   	mte_wait_after_trig();
> -	if (!cur_mte_cxt.fault_valid)
> +	if (!cur_mte_cxt.fault_valid) {
> +		ksft_print_msg("No valid fault recorded for %p in mode %x\n",
> +			       ptr, mode);
>   		return KSFT_FAIL;
> -	else
> +	} else {
>   		return KSFT_PASS;
> +	}
>   }
>   
>   static int check_single_included_tags(int mem_type, int mode)
> 

Nice. Thanks for the patch.

It would be a nice addition to print mode names as strings to make
it easy to understand. Could done in a future patch. e,g: MTE_NONE_ERR etc.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

