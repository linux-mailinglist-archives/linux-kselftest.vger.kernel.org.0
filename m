Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE749EEA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiA0XL6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 18:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiA0XL5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 18:11:57 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E4C06173B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:11:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d188so5626777iof.7
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 15:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aT9qZCD/r6lIpUikPXbdoH9+ikbx9vSepHUfRfOtdds=;
        b=LSn/yZBj7+lTfmY6hiqcaiFaNFi+v72l93gi29lMMuhQ9SW6uOpcWk+VK+UOJP/T6b
         kHPh4X7Ril+8AIOz+ZhXymZTeCFr0g8bX+YW7y3Xh7KEEnck/Xk/WZ/9J7tZl39ZJ3a4
         lNmO8x49n+pJGtcwS48lHZUdvUKoU/vHVSNSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aT9qZCD/r6lIpUikPXbdoH9+ikbx9vSepHUfRfOtdds=;
        b=3T+dT81QIfKJKv4J5UYZH1T5Q+/I3IPsO/hnkeoVfKaumAw/Q3msKBxPXk/a3OuI8x
         vKvxaGrT2SJkW4lI6DoLf9EoJLhhc3/3E2puWsa8iN3A2B5KHIv26FbhbCXajwUHslkd
         EHp6hi78AvxAY98Wge4P6glymusgBIKjFRz93Wi6x7ekNNY7CssrSFrOt1p4xtdt36NC
         ml87Qjjv2w4VB2wDt8Mqdny8sb+u+PrgX1vEMGZW8BLOo43r3Buhx1Y2EhBwekrS9wmM
         4ZrseuYBVXFQ8XMgN3YBMBBlfS08iOxll57pJj/t76bXWmP/aQkTSE2HfrI/UkIbv3kO
         KKLQ==
X-Gm-Message-State: AOAM530ZfL/UsMYgkoSjhLlYMl26vIBspK788QQl06pJDsmsJVCF6zO5
        /MXVC3U0Jw1Y3cWRuDKTezTPZQ==
X-Google-Smtp-Source: ABdhPJxFxOmg9wE7I//aW4Nh2f7O8J9072xtlARw6DKGFD6PUvV6iORgesAqCo1BWVwn8EM1dVes3g==
X-Received: by 2002:a05:6602:2492:: with SMTP id g18mr3598869ioe.24.1643325117014;
        Thu, 27 Jan 2022 15:11:57 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:fcdb:3423:ed25:a583? ([2601:282:8200:4c:fcdb:3423:ed25:a583])
        by smtp.gmail.com with ESMTPSA id h13sm13271677ili.31.2022.01.27.15.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:11:56 -0800 (PST)
Subject: Re: [PATCH 3/5] selftests: openat2: Print also errno in failure
 messages
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
 <20220126102723.23300-4-cristian.marussi@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9152aeab-6f89-7825-3705-e358a2106662@linuxfoundation.org>
Date:   Thu, 27 Jan 2022 16:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220126102723.23300-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 3:27 AM, Cristian Marussi wrote:
> In E_func() macro, on error, print also errno in order to aid debugging.
> 
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   tools/testing/selftests/openat2/helpers.h | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
> index a6ea27344db2..ad5d0ba5b6ce 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -62,11 +62,12 @@ bool needs_openat2(const struct open_how *how);
>   					(similar to chroot(2)). */
>   #endif /* RESOLVE_IN_ROOT */
>   
> -#define E_func(func, ...)						\
> -	do {								\
> -		if (func(__VA_ARGS__) < 0)				\
> -			ksft_exit_fail_msg("%s:%d %s failed\n", \
> -					   __FILE__, __LINE__, #func);\
> +#define E_func(func, ...)						      \
> +	do {								      \
> +		errno = 0;						      \
> +		if (func(__VA_ARGS__) < 0)				      \
> +			ksft_exit_fail_msg("%s:%d %s failed - errno:%d\n",    \
> +					   __FILE__, __LINE__, #func, errno); \
>   	} while (0)
>   
>   #define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
> 

Looks good. Will apply to linux-kselftest rc3

thanks,
-- Shuah

