Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7394D52CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 21:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiCJUGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCJUGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 15:06:23 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B718BA50
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:05:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b7so3516325ilm.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jy8ONBCRpaMkod1rac1TAZ1goslYPoLIQxLQcFB1lIw=;
        b=KWnzT1bgcazyAsiR5JMJcD6ysH5Uyvl0mXPqF6qcrPj+UPRAQm/yHT6Qk2GGDTJsVE
         vSW7vO+o7nvkGwnbXmFFJ2Rg/C7AfwCgxcPA2T21v69A913c+H8ayuwxis5bNy/aEuHQ
         vBtIHlhOZdG7/2FCyfOLqpwl+hwEBbkZNe/jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jy8ONBCRpaMkod1rac1TAZ1goslYPoLIQxLQcFB1lIw=;
        b=ZBr8kRTkHa3ZyfwzKT4cl8RbIZPuzRaqdRyVU8DwVrUslhSJ5vPCPfqwho1s7Mfq3O
         IPyQQAq66RxIpEiDBBOy0ehTgPV22Ty0+2wyRLd2JGzq2Y54bb+XXdYFt9e18ZgIJoBc
         j3FKvyWrgVIAACGw6pAakl51xfPetDvaAMJ3DQQRtkbMv0MaOtkGhF155DkFeCGqzFuE
         lcttfHvUIs8MK1pYlX4trA1yndl+iv36R7RUhphchLVE8PMxm57+xN9yirD4mq6qmjuS
         Tj4/gZKixOFfa9ID95anSFAFdoZiRoWo0DIopibxHYqh4U71+KDluyrPq1+Tif8+vP9n
         w5bQ==
X-Gm-Message-State: AOAM532v6WUWaiH/dNbyYGuoElicwQYvSXu/OO7+5t98yn+6wV69gT71
        t6/tpuNr5ErBAvKM2dPKrne1sx9WXeBmcw==
X-Google-Smtp-Source: ABdhPJy0BbmJNBcZ13cMZAR/aeKSKexKyBs9tWzVpiSfF090ZmNRWCJk4IJU9XiTTtSlpDup0Gw3Ag==
X-Received: by 2002:a92:ca4c:0:b0:2c7:7088:e1c4 with SMTP id q12-20020a92ca4c000000b002c77088e1c4mr1204314ilo.123.1646942720419;
        Thu, 10 Mar 2022 12:05:20 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k4-20020a5e9304000000b00640dfe71dc8sm2906184iom.46.2022.03.10.12.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:05:20 -0800 (PST)
Subject: Re: [PATCH v1 3/4] kselftest/arm64: Refactor parameter checking in
 mte_switch_mode()
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-4-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1255c2ba-07f6-628a-86e9-f255d1845e92@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 13:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220310144335.2097457-4-broonie@kernel.org>
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

On 3/10/22 7:43 AM, Mark Brown wrote:
> Currently we just have a big if statement with a non-specific diagnostic
> checking both the mode and the tag. Since we'll need to dynamically check
> for asymmetric mode support in the system and to improve debugability split
> these checks out.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../testing/selftests/arm64/mte/mte_common_util.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
> index 24b0c14203cb..9b4529ef2b29 100644
> --- a/tools/testing/selftests/arm64/mte/mte_common_util.c
> +++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
> @@ -271,9 +271,18 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
>   {
>   	unsigned long en = 0;
>   
> -	if (!(mte_option == MTE_SYNC_ERR || mte_option == MTE_ASYNC_ERR ||
> -	      mte_option == MTE_NONE_ERR || incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
> -		ksft_print_msg("FAIL: Invalid mte config option\n");
> +	switch (mte_option) {
> +	case MTE_NONE_ERR:
> +	case MTE_SYNC_ERR:
> +	case MTE_ASYNC_ERR:
> +		break;
> +	default:
> +		ksft_print_msg("FAIL: Invalid MTE option %x\n", mte_option);
> +		return -EINVAL;
> +	}
> +
> +	if (!(incl_mask <= MTE_ALLOW_NON_ZERO_TAG)) {
> +		ksft_print_msg("FAIL: Invalid incl_mask %lx\n", incl_mask);
>   		return -EINVAL;
>   	}
>   	en = PR_TAGGED_ADDR_ENABLE;
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
