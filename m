Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36404D3C25
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 22:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiCIViM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 16:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiCIViL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 16:38:11 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4DFA23A
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 13:37:11 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e22so4311941ioe.11
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2gJooIXnOYhQGoz9AUGJ6FguvABfO1pn3pmmv8J/5lc=;
        b=VY7pjgYjoIab4P/+ASIaHaWjd0mQoOuqK0kniuvmUZlhklPh9cjmRV7qG4ykPs/HEX
         lUvpoFuK1zfgrtDyGFnwkaHx2e+4GI8MZEG5FNZT4couD6ob0VusVTQTCil6an6m8JWH
         pWoeqX3ReKQejAC2yuuqQsRxySwv1c+DQKM80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2gJooIXnOYhQGoz9AUGJ6FguvABfO1pn3pmmv8J/5lc=;
        b=BBpsJ8mPzS5t917pAiYGHZLBdcyAkBlkRBrfPAuU4uwRxKhMLUcaIrpVbje4SFka7A
         eKlpg0g9ZTGg2m8M8pjhB5KH3e8bf58qEJkFqPdyw9da8GIyMBWC/qadXyi9s6AgX5uV
         Hv7VCX69VulX5fbiIczF5643R4OcLBknYcHbnS9Hi8aif0SlkIXrZW7RNyF02CGQVqbT
         r7AWxXMj0aiROatp8bVVU80jvaCxaZF5QA9NPJE6eAbEHFfe+H5M4YNnzjc/NYcoFFK8
         q6XAADqAWNpm/KxSMjxCQtifjrzq6ei7FpRpX9JexAW74EwLXgUWxmqlewQ3Vh7qjrPs
         Msmw==
X-Gm-Message-State: AOAM530FwzXNQZoAg38JKm1fPfId4oHiqAGIfHXhS4OsaYW84AnxzLqt
        URPPE6gbWliZyGJfrQQ03jDd1vmGdqupqQ==
X-Google-Smtp-Source: ABdhPJxsh+TTt/Kh1K8gfQzT7I5D9+1p4tokNYFUSJCHGvT/02VWPn+HiFHQjNzquido3goAWiq/ww==
X-Received: by 2002:a5e:d907:0:b0:645:bab6:5efd with SMTP id n7-20020a5ed907000000b00645bab65efdmr1285432iop.82.1646861831116;
        Wed, 09 Mar 2022 13:37:11 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id e8-20020a056602158800b0064683f99191sm880909iow.39.2022.03.09.13.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:37:10 -0800 (PST)
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Validate setting via FPSIMD and
 read via SVE regsets
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220309115918.22469-1-broonie@kernel.org>
 <20220309115918.22469-4-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eb43ceca-0bee-4fb3-3ae9-1f08a5764629@linuxfoundation.org>
Date:   Wed, 9 Mar 2022 14:37:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220309115918.22469-4-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/9/22 4:59 AM, Mark Brown wrote:
> Currently we validate that we can set the floating point state via the SVE
> regset and read the data via the FPSIMD regset but we do not valiate that
> the opposite case works as expected. Add a test that covers this case,
> noting that when reading via SVE regset the kernel has the option of
> returning either SVE or FPSIMD data so we need to accept both formats.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/sve-ptrace.c | 123 +++++++++++++++++-
>   1 file changed, 122 insertions(+), 1 deletion(-)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
