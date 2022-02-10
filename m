Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E994B0FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiBJOF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 09:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242591AbiBJOF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 09:05:27 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655C21B
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 06:05:28 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADB1A4004C
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644501926;
        bh=zKXhRO/iKyX7h/YxXn3Y6EhBscMlQ0dLk5x/LHBq8KY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tDcqdVz0TLEF8AGnlZRUTNWm9Onu6Ags5FP7q3aXx5fKisM1hFr9TNJD9iRHrVe/1
         qX+EopV3UnHqvpF5HRHSUlzXBGDZDUQnvvf8/M/YOXS3+djATWlh+CxNkpFr1hY6Vn
         RW9ZS2LwzBv80UQpj59fOsSnWijybsVUt8bGUaXXoxFEwJbs9hSiSyuiubrnluOpCm
         ZZW9lV6Xu+Xf0LM6M3BIEfHEvhZ3oB32JPcbRKSodnQFRe6I3votUAtD3T/fV7A8zO
         nf4C7vpkUvuqR/gXALLJQmsV7S2nJXOc2BzRuA/X/MIWvtBbi1t7t7ZiF0iBTucVch
         aR4FRkSvTAp3g==
Received: by mail-ed1-f70.google.com with SMTP id dn20-20020a05640222f400b0040f8cdfb542so3387433edb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 06:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zKXhRO/iKyX7h/YxXn3Y6EhBscMlQ0dLk5x/LHBq8KY=;
        b=PXPVwig9eOtEJSvFVSzu4py5A9A62oyinAjKS/3KqsqyQWFspMp9oRalYmIzqiLMu6
         BsDXEEr4+8iwRY5WlQsJQDF3AXljJjNclP2Vc2WG42hP7SBoTAJYeQlY2A9oZa4DKSc3
         Qpd98eHP72NbAZQtCyM9DveTRbxAGJao31fYKjuWEj4N2ztSyDg6CiOowwQl54Mmhq06
         tdbnHgYMvtTUPS1DWNWV3Um4+lJg3P6T9xY3YEAaslZwSSwPkt/U7/aDIA+4COl3e29P
         XJTfqncVh7A5dd0CaPUrsdTVjFWqREoGEqqZ5EuDCQFxwKlvhqfbWzs0niWIRcBCpBeR
         dB1w==
X-Gm-Message-State: AOAM531dSmt0ns5109Tz5rilY15EI8PjAlAmq7bqCU4nY3dOa1i98bGh
        mbW7RNmM3q6oM7phEk7o1wlDtJm533wwguYCCW6WdrwuOz0hwn3dPjyBn13HMQlEcHs1rY0+jnI
        ZeysntFPJVv064kBApmTIhCCIRRrO8y+sdihyIPQPRgnHIw==
X-Received: by 2002:a17:907:3ea9:: with SMTP id hs41mr6869697ejc.727.1644501926432;
        Thu, 10 Feb 2022 06:05:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye7QQ/M4O+aQStNkXT2r87JXvIqUAITU2CmbxyLbP+hraXKwtnrC+00UUlx02GVr7CyioUXw==
X-Received: by 2002:a17:907:3ea9:: with SMTP id hs41mr6869681ejc.727.1644501926248;
        Thu, 10 Feb 2022 06:05:26 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i6sm9812939edf.20.2022.02.10.06.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:05:25 -0800 (PST)
Message-ID: <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
Date:   Thu, 10 Feb 2022 15:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
 <YgUXcGC1mH7VX1d9@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgUXcGC1mH7VX1d9@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/02/2022 14:47, Sebastian Andrzej Siewior wrote:
> On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
>> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
>> do_softirq fails for such kernel:
> 
> PREEMPT_RT does use soft IRQs.

Correct. It does not use do_softirq() code, but follows different path
with ksoftirqd.
Shall I rephrase it towards something like this? Or maybe you have some
more accurate description?

The implementation detail is that do_softirq() is in ifndef.

> 
>>   echo do_softirq
>>   ftracetest: 81: echo: echo: I/O error
>>
>> Choose some other visible function for the test.
>>
> …
> 
>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> @@ -19,7 +19,7 @@ fail() { # mesg
>>  
>>  FILTER=set_ftrace_filter
>>  FUNC1="schedule"
>> -FUNC2="do_softirq"
>> +FUNC2="scheduler_tick"
> 
> What is the purpose of this?
> 
>>  ALL_FUNCS="#### all functions enabled ####"
>>  
> 
> Sebastian


Best regards,
Krzysztof
