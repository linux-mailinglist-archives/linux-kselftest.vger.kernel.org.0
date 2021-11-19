Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7BB45799B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 00:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhKSXkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 18:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhKSXkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 18:40:10 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D77C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:37:07 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bj13so24766061oib.4
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVNPEhMcOmOhfhojpKvCw8oyIiVQ1USECxxRocgYuuo=;
        b=bhr1pt/WQkTe1YEUocNBxT27ISrQEj7QMDkuLe5dvP+deckUmlad8hwLcpCd631PW/
         o08lTRZU6qHob4SAQtfRS0olA5g5VmUbrSLOOVXPr2jzpAumDUUm8U88TRra1dMLclXk
         rUSDuQJxOhQtnoO5TteUz3RRNodxJ996mLNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVNPEhMcOmOhfhojpKvCw8oyIiVQ1USECxxRocgYuuo=;
        b=jm6XOjNTO06cZYdcUQQ8Okm+LFnH6y8DH0HUYre8Jlf/nGd16cqYGVxmOo/UIGMfO3
         NI8zXqigWeyX3v3AWL6IAoEfAfZeR0NBA4k3GmI6U39QWoKKBoAYfWM8zGlXShEKBb80
         Q5WfMGqK0JcYqzYRoE+etB4uSW1lm8QHBs5JrIo+G1ILMIhA6VBYoqb4S5S6PPnm2vLB
         y30GcYHAUl8cKW61kEcfZHRDfdVjqrOY+clSnuqQCFA0VYwH2YPhAxVoMbW0GkK5LSWZ
         HAJl1Tt5KhupcFvp74IZN5qSecIDPmwDuuyzQLJ9FnSz8t9ib6mMNgKH4XAqkOQrKJ1/
         wxbg==
X-Gm-Message-State: AOAM533rleblH2MQIjW4j+ix0WrrzDYmGj2jir021feCrM25Q6FhXSlS
        uD5JERQl1vWibQ19dreNCdEJog==
X-Google-Smtp-Source: ABdhPJzV5x19l3UVigMY7QB0qCih3N70YjGLmr7EYU41kLicL3Zb4yXYyHKQ3NqxhS/RvpXkBZy3Mg==
X-Received: by 2002:a05:6808:18a9:: with SMTP id bi41mr3719657oib.48.1637365027254;
        Fri, 19 Nov 2021 15:37:07 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u40sm345615oiw.56.2021.11.19.15.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:37:07 -0800 (PST)
Subject: Re: [PATCH] selftests:kvm: remove unneeded semicolon
To:     cgel.zte@gmail.com, pbonzini@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211119023133.2027-1-chi.minghao@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4be7305-e0d8-68d0-68de-0e95e17563e0@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 16:37:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211119023133.2027-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/18/21 7:31 PM, cgel.zte@gmail.com wrote:

Missing commit log. Please add one and include information on
how you found this problem and tool output.

> From: chiminghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./tools/testing/selftests/kvm/access_tracking_perf_test.c: REVIEW Unneeded semicolon
> 
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>   tools/testing/selftests/kvm/access_tracking_perf_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 5d95113c7b7c..09bf6c6ca11a 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -231,7 +231,7 @@ static void *vcpu_thread_main(void *arg)
>   		case ITERATION_MARK_IDLE:
>   			mark_vcpu_memory_idle(vm, vcpu_id);
>   			break;
> -		};
> +		}
>   
>   		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
>   	}
> 

thanks,
-- Shuah
