Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDF3144A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBIAKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBIAKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:10:04 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43CC06178B
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:09:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y17so14492696ili.12
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=akc8PS5t2j1XjbrR6CgcuGW0rLr1kbq6jUz31C/0DcU=;
        b=G2F2sqG02nvIMHDsvW1ah8tVs6aTUU86GWEoocC4s68fvFgZeBRfGPD0Afl2r8MQYj
         Adtu53Ykg2YAWTl9Y3epbLqnHAOyfEK0rQwhueBcFELvDhCWJugi/relPLWnpeDs3CD4
         IDP6+7CbgKHFicHGBs5Xezd8iQ4NyOSmeHw4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=akc8PS5t2j1XjbrR6CgcuGW0rLr1kbq6jUz31C/0DcU=;
        b=GsjWtQ+2YQTC2RQ/Xn+NpuNSkJM902hytIbchAw4FcDKeGGPq8TCi6Aju0aA+ye7tn
         Pumf1STV0MgT1wNDozNzZe3U/nfnzAoDQnfcKn6z5s5fd7JVaRFQCX+yWdi9TAy6kiTC
         /g8SN3Eo/qH9Uxu2FzSoRJZFJkQyv+P5fib1rN8C6volwfpQN+/TGAUf09yDD6nm0GqJ
         66nmXryB3s19uQ7wrkELkr0Yl6E33/i16ykYXObA/c3Jvqvn8i9JYxRPFVZyBlxnFeyD
         AvZRtRQeIZ3j/g3E65dWl9UAk3yvuPgJzhH7wqghoQqoznO+Qe2eu7P1yE4+0InogXtj
         0O1w==
X-Gm-Message-State: AOAM533Jx4QFy3x3T6W6XIiZMozac2jD/t3ULM3SIZ9BwJJwL3Sjl9F8
        eAjzTxs53HzMhj8CEQ/oqtxc5g==
X-Google-Smtp-Source: ABdhPJxzZq3u/EH2OoAq4jOquUIpYtQ02A5RoV3cCqrI+bgqsz6vcFfm1uqwrlwomHTLPxsVSGfhhQ==
X-Received: by 2002:a05:6e02:cd4:: with SMTP id c20mr17789361ilj.189.1612829363145;
        Mon, 08 Feb 2021 16:09:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f9sm9401648ilu.36.2021.02.08.16.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:09:22 -0800 (PST)
Subject: Re: [PATCH v4 1/5] selftests/x86: Use getauxval() to simplify the
 code in sgx
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210201132653.35690-1-tianjia.zhang@linux.alibaba.com>
 <20210201132653.35690-2-tianjia.zhang@linux.alibaba.com>
 <YBnMCWW8tux490JK@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <91629d56-a890-18ac-7b10-b20229343d2f@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:09:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBnMCWW8tux490JK@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/2/21 3:02 PM, Jarkko Sakkinen wrote:
> On Mon, Feb 01, 2021 at 09:26:49PM +0800, Tianjia Zhang wrote:
>> Simplify the sgx code implemntation by using library function
>> getauxval() instead of a custom function to get the base address
>> of vDSO.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> This needs also ack from Shuah.
> 

Looks good to me. Thank you.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

