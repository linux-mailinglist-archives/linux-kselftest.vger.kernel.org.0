Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D93507D26
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiDSXVU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 19:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358459AbiDSXVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 19:21:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1D38BC0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 16:18:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e194so102188iof.11
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/E/g0r1l7hhQAfIUhRVbsUEHaUTABUFgpPrJRsq6vrw=;
        b=c+BBOmZ+D/s45k/qSYD3oA34sarEMQaA8IK58sGH6r8xaEKGK4CsvyiZuqEgaEcUtp
         drh4cf5hk4AiRe3kPu/SJWrLAdUh9Yt0ELj4OY5cTKsISjwEb0p3wk2WVzbmtwH6+Ynm
         rWQwCwRygS7kl6hjatbRyXdVYF5pwwdzYyjRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/E/g0r1l7hhQAfIUhRVbsUEHaUTABUFgpPrJRsq6vrw=;
        b=xhpwymkZJdDkcnNR+67tFeg3M8tjurlQPLnnwqWEKHsee9UouIWpVDrOhnwcHtlaVF
         CE2KUrb3uIMLcL3E6vOVIhmoSMDOvqqL5OWcpw+xtDZN7P8AGozHPsEQC5mAo1l8hiMY
         5GoqitjDKQJx/Q5i1hNtzvZf+UgLRTlocLFOCG7TyGfc5r0lO7ecSON5tzpEhHxYHXl0
         lnB+ixH6Pz1CgZuc6uktDr4pWNf1UM/OmafqTdlaoafhEFd2BqBTADZDbxFNnpB1U4uZ
         ygzKlVwaMzMo6jTq5dyc/Hdqr5h61w3Li3zj9YnpKGNkEF0g3Q/3qPBcOuWboHoLlKAE
         wdUg==
X-Gm-Message-State: AOAM533lenwOoZcqDPwErOFprgWvNt8f/jhVru5ci8jJaOhhgqE8xRPC
        RbBfK1xBWiagjkRY7XGbQMYd6g==
X-Google-Smtp-Source: ABdhPJwfigiCpfFTIIdSJJnbOcRHoa3FJBMQkGQcwjRFpBZ9WGHKSiQj7m2lDe8zHo4z2CHhalTrhQ==
X-Received: by 2002:a6b:3c08:0:b0:64d:1af2:8ebb with SMTP id k8-20020a6b3c08000000b0064d1af28ebbmr7544708iob.95.1650410309644;
        Tue, 19 Apr 2022 16:18:29 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y13-20020a056e02118d00b002cb2ceb6feasm9269566ili.81.2022.04.19.16.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 16:18:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests/ftrace: add mips support for kprobe args
 string tests
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ze Zhang <zhangze@loongson.cn>, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220416114848.25288-1-zhangze@loongson.cn>
 <20220418132957.2b7591e9@gandalf.local.home>
 <20220419101232.3f56542fdf84af846eaf47fd@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4e50d556-ff4d-4622-632b-476754561190@linuxfoundation.org>
Date:   Tue, 19 Apr 2022 17:18:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220419101232.3f56542fdf84af846eaf47fd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/18/22 7:12 PM, Masami Hiramatsu wrote:
> On Mon, 18 Apr 2022 13:29:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Sat, 16 Apr 2022 19:48:47 +0800
>> Ze Zhang <zhangze@loongson.cn> wrote:
>>
>>> This is the mips variant of commit <3990b5baf225> ("selftests/ftrace:
>>> Add s390 support for kprobe args tests").
> 
> Thanks for adding MIPS support!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you!
> 
>>>
>>> Signed-off-by: Ze Zhang <zhangze@loongson.cn>

Thank you all. I will pick this up for next

thanks,
-- Shuah

