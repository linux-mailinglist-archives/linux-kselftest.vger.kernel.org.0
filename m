Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFF4B07DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 09:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiBJILI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 03:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiBJILH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 03:11:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C61098
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 00:11:06 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F6BA3F324
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644480657;
        bh=rnVHj9CHiNB6vcrhWaipk1/sdp7xgf97Hh+oKwEPpOs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MrH9+pMSi1sPlREe/A/qY1FOelBoeN7FvbE1aNJIWE40Qr1ctj97rDoUmlzZQcH+c
         9CWgzw/4m6zMjZePJs66Y62mfJRN3IMiSZ96BnuKcXZvlMhuVB4iL8bRHIBm+jpKgY
         xqpToqtdaCUmcjk6C3t6oQjiSC227uwFUOQVD8AxcK/th8p4MfqMrC8OHAZUBy9oka
         JW48LChFjxuzoDMPepvts7LL+Lzq7ODD4+FR4XJ6e/ogN/v9mHm+r98xXXR7M4GHmy
         8NKJggG/ZTl9LOsaGIYaAZ7YYnIy7RYnRlTccWYLCTUvagq2YUqquTBq8k6j5csSSA
         SiepX1FSibvSw==
Received: by mail-ed1-f69.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso2912286edh.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 00:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rnVHj9CHiNB6vcrhWaipk1/sdp7xgf97Hh+oKwEPpOs=;
        b=cKnd1RU0EqSKvK75lIgJyhvq345klO/KISlZh64sPiQztdlgFpt+SaJ+8PahvDVQEG
         mQ7Ub3K2zAXPhcTlqYw5qZEvzKmSbhrYAd6joJXE48tG5+Fx0KiezsAGz2GowRiFYw0f
         NwxPE3HOjjO98ugMgslTIEQfFYXZR21mKHmtKdS3qaNQeLMH3qJxbwH/NskLt/97Vyn3
         g+JPeMTc/7zJ1QyZgUVaUXaH2ZBbx4q7ugh/8VLtlAEDvoB4GJ9GMPDPwitL7xhkCh6D
         pyEjs5/q5h9GQVuUIry9aFoN2OTfWoj+mXtYfcxi4a2NUUNY2kU5kp3Mx/pAw9pYf21h
         yo5g==
X-Gm-Message-State: AOAM531Hs3JA0d8ywq/zqfmogTN+H0YVTw1BG/NAMc0WkFUMhyFBKg8w
        q59VLFEL716rjcESrXzZY6A0HEaW57XZ7coT9cRq804xn4wnkNDBRylBj84Dm0njFzns4FlN+wa
        RoTYUiwhYRNMMVSyY8srbByHLgpjcI5GW35QA8BKs2ypaZA==
X-Received: by 2002:a17:906:5349:: with SMTP id j9mr1695989ejo.368.1644480656969;
        Thu, 10 Feb 2022 00:10:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz93CRsj8ZQh2gY9EXnoyBRs+OT8gb0AMXSmIAPsFac9M3xo7W5tdmNzg25cweSZ1IFjqp/bg==
X-Received: by 2002:a17:906:5349:: with SMTP id j9mr1695977ejo.368.1644480656756;
        Thu, 10 Feb 2022 00:10:56 -0800 (PST)
Received: from [192.168.0.97] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kw5sm6904003ejc.140.2022.02.10.00.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 00:10:56 -0800 (PST)
Message-ID: <61be0071-a6e9-f749-37e9-978a72a60897@canonical.com>
Date:   Thu, 10 Feb 2022 09:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
References: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
 <20220210000003.6b6142f9@gandalf.local.home>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210000003.6b6142f9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/02/2022 06:00, Steven Rostedt wrote:
> On Wed,  9 Feb 2022 17:24:30 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> 
>> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
>> do_softirq fails for such kernel:
>>
>>   echo do_softirq
>>   ftracetest: 81: echo: echo: I/O error
>>
>> Choose some other externally visible function for the test.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> I understand that the failure does not exist on mainline kernel (only
>> with PREEMPT_RT patchset) but the change does not harm it.
>>
>> If it is not suitable alone, please consider it for RT patchset.
>> ---
>>  .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> index e96e279e0533..1d0c7601865f 100644
>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> @@ -19,7 +19,7 @@ fail() { # mesg
>>  
>>  FILTER=set_ftrace_filter
>>  FUNC1="schedule"
>> -FUNC2="do_softirq"
>> +FUNC2="_printk"
> 
> The problem with the above, is that it is not guaranteed to trigger (and
> probably will not), where as the do_softirq is. The filtering is suppose to
> trace something that actually happens.
> 
> How about using: scheduler_tick ?
> 

This works as well. I had impression that the test is only about
filtering interface and actual function does not have to hit/trigger.

I'll send v2 with scheduler_tick.


Best regards,
Krzysztof
