Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2285E2D1B9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 22:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGVHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 16:07:15 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A409C061794
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Dec 2020 13:06:29 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id t9so9232375ilf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Dec 2020 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9AfHP9RUgbPOiM4oNtMaqXuhiqhvukbABKjF1a0DOY=;
        b=R1pYaz95u9Ycvy7npq5FB3fegFBwtX0dGlIsfiplchVOGoGC7Yqe5GI3NAXXv9wKsk
         5dlmZFhXZ3qFDtXZ1hOBcG34wXJ2WgKDhQPj7SkmO1L9BZTTVVKdGo5Fr7rHeK0ulw+Q
         c/7BE/oTvJ5i4EPSLEkmH9+lm1WRRSBNUlbg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9AfHP9RUgbPOiM4oNtMaqXuhiqhvukbABKjF1a0DOY=;
        b=N/A0a5QLRBIwzXOhw6CgIbGAwGOwrv6/zqAsWHuxA5+5S87XpGKaB8WDI7jbqlS1bF
         yvdeyvdoY12l6wpUh2t6J0uCQLKBwj7ZkpSRnItAbHEn6sNQfQANfT3sVqmgEPh8i8dL
         RMnuE/wP+mB05er22QaOteeG1y3YbYLpfIgX2MIP41oWOTaYo2fpa1CCFQVeSTE1+8vX
         rUMfEyTJeXtGszOVMzHD8btKnw4mIKEAz8qJCTDUPcpvNv2cB+K/hVstMeX00XODa8EX
         JNF158T+wg2KGZIFHnqbCwtDYTMrwxRgM50LV98Tq8nOLDptVeV4COWAegEmzwab6GCK
         9o5w==
X-Gm-Message-State: AOAM531zUrMIn2zvKh3jpGlSEh8YH9LQojSjzPUv1KVA2C1hBro7CD7B
        lwE8EfhLzUTrUzGEnKTlFOFljA==
X-Google-Smtp-Source: ABdhPJydL3VULKgg9Z2FRVmDzjQU9ikvjmw3w4ALlIj62YReWcbFROnSQyeqcMdzwNXwlEWww6qHlA==
X-Received: by 2002:a92:cb52:: with SMTP id f18mr8267036ilq.41.1607375188531;
        Mon, 07 Dec 2020 13:06:28 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j12sm6694370ioq.24.2020.12.07.13.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 13:06:27 -0800 (PST)
Subject: Re: [PATCH] rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
 build error under other arch.
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Xingxing Su <suxingxing@loongson.cn>, shuah <shuah@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1606277097-5853-1-git-send-email-suxingxing@loongson.cn>
 <1169128156.59953.1606320652393.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <01ffd154-cb45-8538-dd27-8f2de87faee8@linuxfoundation.org>
Date:   Mon, 7 Dec 2020 14:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1169128156.59953.1606320652393.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/25/20 9:10 AM, Mathieu Desnoyers wrote:
> ----- On Nov 24, 2020, at 11:04 PM, Xingxing Su suxingxing@loongson.cn wrote:
> 
>> Except arch x86, the function rseq_offset_deref_addv is not defined.
>> The function test_membarrier_manager_thread call rseq_offset_deref_addv
>> produces a build error.
>>
>> The RSEQ_ARCH_HAS_OFFSET_DEREF_ADD should contain all the code
>> for the MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
>> If the other Arch implements this feature,
>> defined RSEQ_ARCH_HAS_OFFSET_DEREF_ADD in the header file
>> to ensure that this feature is available.
>>
>> Following build errors:
>>
>> param_test.c: In function ‘test_membarrier_worker_thread’:
>> param_test.c:1164:10: warning: implicit declaration of function
>> ‘rseq_offset_deref_addv’
>>     ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
>>           ^~~~~~~~~~~~~~~~~~~~~~
>> /tmp/ccMj9yHJ.o: In function `test_membarrier_worker_thread':
>> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
>> param_test.c:1164: undefined reference to `rseq_offset_deref_addv'
>> collect2: error: ld returned 1 exit status
>> make: *** [/selftests/rseq/param_test_benchmark] Error 1
>>
>> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Shuah, can you pick up this fix please ?
> 

Applying for 5.11-rc1.

thanks,
-- Shuah
