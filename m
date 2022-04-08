Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07024F9CB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiDHSdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiDHSca (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 14:32:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B88D399C
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:30:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so11611127iok.8
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=YpRUx5naQgJOrPJtNsmh78aDsmIIkswFS8lXDrNYheqXIeJEK2ARoLdZkPcn+nfw5T
         oYiFN+5ZvBke8G2w+I4t1ThEG9QAMUoMMfn3SprosOFXtLJQ9uLglI+1t3LYKARK0RE9
         fZFK0+HB8gFFQwUCeNj0/qHoPWD0MoYjgz6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8c4w2SqV3Zwtk6hjN9XQDs1ojn8rP0mcUHvQvhzuNaU=;
        b=2YmwOLzrfijIX//f+ZtQ/ss6DiTF8k8GEHWa5lG38s4lQZzEM4b9VASpDMRahGYq/Y
         RFZi1ZWISthsVbf0bAVK0pHSIob0lCXdQJyl9HI4jlsp/8CFUoIaS8qMDMqV8SsDGmmR
         7Ladby8p3IC/IzXdRG7+SRkrK/UZED+oD1uqaN6wcFgRalBlfFE1O2Bc1gsN5SRb623j
         IwcF9A0bAHUgLB537l5LI4J9aB6CzE7651WG5wE8B3lcx2Dd1AMU9BisQmgcYj8vPjzE
         8+kbd35HSfyYtS2U7fOZ5v5/AXFNi33yxO4G/5tdlvt1peNwkWX6NlahiQfe3edsKXAP
         7/rA==
X-Gm-Message-State: AOAM532/tPHaWl0M+jGCai+ubjn9BOkF1Nc8O9rfXzvdQpp3du+wF3UX
        FG/NqxPaC3C1ypuVzS+bclICeA==
X-Google-Smtp-Source: ABdhPJz0knJI2EvKgFMOby7OjCoRi/HEQHXa7piPfbIdw92oEo/ocHWDiLbO7mI1s1H7DgX30ZuY4g==
X-Received: by 2002:a05:6638:2643:b0:323:c3e3:fcec with SMTP id n3-20020a056638264300b00323c3e3fcecmr10003722jat.289.1649442625269;
        Fri, 08 Apr 2022 11:30:25 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y6-20020a056e02174600b002c7f247b3a7sm14985188ill.54.2022.04.08.11.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:30:24 -0700 (PDT)
Subject: Re: [PATCH V3] testing/selftests/mqueue: Fix mq_perf_tests to free
 the allocated cpu set
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, disgoel@linux.vnet.ibm.com
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        kjain@linux.ibm.com, srikar@linux.vnet.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1a1d119a-e68e-a590-a518-cfb3c78ed888@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:30:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220408072431.94947-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/8/22 1:24 AM, Athira Rajeev wrote:
> The selftest "mqueue/mq_perf_tests.c" use CPU_ALLOC to allocate
> CPU set. This cpu set is used further in pthread_attr_setaffinity_np
> and by pthread_create in the code. But in current code, allocated
> cpu set is not freed.
> 
> Fix this issue by adding CPU_FREE in the "shutdown" function which
> is called in most of the error/exit path for the cleanup. There are
> few error paths which exit without using shutdown. Add a common goto
> error path with CPU_FREE for these cases.
> 
> Fixes: 7820b0715b6f ("tools/selftests: add mq_perf_tests")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
>   From v2 -> v3:
>    Addressed review comment from Shuah Khan to add
>    common "goto" error path with CPU_FREE for few exit
>    cases.
>   From v1 -> v2:
>    Addressed review comment from Shuah Khan to add
>    CPU_FREE in other exit paths where it is needed
> 

Thank you. I will queue this up for Linux 5.18-rc3

thanks,
-- Shuah
