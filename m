Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83CF46DD98
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhLHV3L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhLHV3K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:29:10 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B000C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:25:38 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so4076906otu.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vTplaHA8dACYaNRJ7c99MAwqPqMNOUpH/T8J8+0tyxw=;
        b=hWTxjrqosr+1DcGt2tRCkFcpkINz1Z96h5k8CwbfX3cuSGWLUX8VcT6jxlkZ1CrixT
         vRJ2BuGEI7dl53IsOu5tnPk3Vic4v/Ih58ahSODj1YCpJS6OG7fjwq1mD2VWumzsdUhz
         BVNsChOrSwkPYbd+08qRZy4wyOeP2kT1Vl2ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vTplaHA8dACYaNRJ7c99MAwqPqMNOUpH/T8J8+0tyxw=;
        b=pNONSoyoVfXNXiwaBJGfVq/IP4c7at2wNOGIwcsrJFTF43E+RHitJZFJA8v5wvY8XC
         GnMZiNkEvudpZ1efBRKgrbLkrY15au74bAWhQA55d7vwvgyVzOIylSFRBZIpmmW+d7gz
         2IzIqH4qeL2FwBsDNpWGCqd6Kx8Verrp8+iiy92Ay8snkJxc8keza4NnwCWqATiQUYTf
         ML4+9YrJ6JhSNYUMLBFQpz/fdgz1LoRPzK8N08wWTCFKVzQ+dBdmnCs992TC06baEBgT
         KdSARIlMidCKR8xiupNVn1E2dNYEfZZJ5fsxPd8qDKVqXBWWo9qohyf9S1iFcGYKOSD8
         Fa1w==
X-Gm-Message-State: AOAM530ysOJWYjzaBpgj8Q2lFxOqxtlRTz3CR1wdy/HveCALgxSbWpbZ
        Hw6ZkhAX3DU9vD4YmPLKAWs/2gpfK+EHyw==
X-Google-Smtp-Source: ABdhPJxGDRLvRucHxyslIHBl7vElGLuJx9Xe2feNaQWNV+qYs8YRDab6m4Hu/YP+HZfbQP+uU+IdaA==
X-Received: by 2002:a9d:578a:: with SMTP id q10mr1712667oth.149.1638998737713;
        Wed, 08 Dec 2021 13:25:37 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w17sm679324oth.17.2021.12.08.13.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 13:25:37 -0800 (PST)
Subject: Re: [PATCH v3 2/3] kselftest: alsa: optimization for
 SNDRV_CTL_ELEM_ACCESS_VOLATILE
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211208211745.533603-1-broonie@kernel.org>
 <20211208211745.533603-3-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <62df6074-6d22-2a4d-0191-369de56a2fe3@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 14:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211208211745.533603-3-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/8/21 2:17 PM, Mark Brown wrote:
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> The volatile attribute of control element means that the hardware can
> voluntarily change the state of control element independent of any
> operation by software. ALSA control core necessarily sends notification
> to userspace subscribers for any change from userspace application, while
> it doesn't for the hardware's voluntary change.
> 
> This commit adds optimization for the attribute. Even if read value is
> different from written value, the test reports success as long as the
> target control element has the attribute. On the other hand, the
> difference is itself reported for developers' convenience.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Link: https://lore.kernel.org/r/Ya7TAHdMe9i41bsC@workstation
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/alsa/mixer-test.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
> index ab51cf7b9e03..171d33692c7b 100644
> --- a/tools/testing/selftests/alsa/mixer-test.c
> +++ b/tools/testing/selftests/alsa/mixer-test.c
> @@ -307,9 +307,13 @@ bool show_mismatch(struct ctl_data *ctl, int index,
>   	}
>   
>   	if (expected_int != read_int) {
> -		ksft_print_msg("%s.%d expected %lld but read %lld\n",
> -			       ctl->name, index, expected_int, read_int);
> -		return true;
> +		// NOTE: The volatile attribute means that the hardware can voluntarily change the
> +		// state of control element independent of any operation by software.

Let's stick to kernel comment format :)

> +		bool is_volatile = snd_ctl_elem_info_is_volatile(ctl->info);
> +
> +		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
> +			       ctl->name, index, expected_int, read_int, is_volatile);
> +		return !is_volatile;
>   	} else {
>   		return false;
>   	}
> 

With that change:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
