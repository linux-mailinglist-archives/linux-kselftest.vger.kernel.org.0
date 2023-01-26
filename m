Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBA67D69C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAZUnT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 15:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAZUnS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 15:43:18 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8C7167D
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 12:43:16 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i17so1290488ila.9
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 12:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SlJgdiGbpLH2OCrekdQ+HXRQAFULLWTJy3ISycRFo8=;
        b=ezYBzhGea1B+COmIaV8EpE0m9F1KFEE6si+x1qFz4sa4s2bAp8+/KTss6Fma/YBKSI
         0RMuaZLmiKnz0UViiF+gaE/lHWWCori2Rx2NbUv2YPO9E46uPC5BTFlC8cG6GohQoxZW
         V3pB+LrnRfeIdwZOtexodsOuH+eC+iHXpcI6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SlJgdiGbpLH2OCrekdQ+HXRQAFULLWTJy3ISycRFo8=;
        b=qvTw0KlCbkQ4Bu+y+ZVawOHd1QZ2fb6Q17EqNaqcSCwLbF3IpluIBgBJdTVzk7Ag51
         oQ/J0dNAOFgNg4huGVUd/ITSvcqK3enZvzQSUF37P4XJBSZFmz7hXwiUt2N54xFbt4qC
         LfxXqwOkA4CoeWijBMza9j5HlX3lcFbZxo9ekDsPk8TqRDJ2BI57FdDHm9/4l2KMyMpc
         +P2Bwx2dtqncAWWkvFte45kavWpU+ANnZrGkqvwyA2DKIaSFFaTNMmh/YM3O+056gSB0
         ePFAuVaeC+0v1jpAG8UhRDk8EDukhc7RNqoWBlVHNOyH/ZVwsCMZfjZAajdr79u8IMnJ
         SJUQ==
X-Gm-Message-State: AO0yUKUqmowWrOqJuYny/5eh5EmlELwUHxbT8NSWX9rUv9U51HmOVujH
        Wif9cmvLMyj9W+vrx5b/rhi0UA==
X-Google-Smtp-Source: AK7set+njbIDB3ZxHZTssVgUai6JBZ8bzyJhMxiqmjkKmEuPGk/ixDcO9wDAGU1diuyOQmov0iV7cA==
X-Received: by 2002:a92:c68e:0:b0:310:9a08:ac86 with SMTP id o14-20020a92c68e000000b003109a08ac86mr1672299ilg.2.1674765795672;
        Thu, 26 Jan 2023 12:43:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k16-20020a056e02135000b00310bde806e8sm399028ilr.12.2023.01.26.12.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 12:43:14 -0800 (PST)
Message-ID: <350d21a9-ac48-7da8-aa5e-d51ad794730a@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 13:43:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] selftests/tracing: Fix some testcases for recent
 change
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <167309832823.640500.13244630381161014364.stgit@devnote3>
 <20230108163128.2860894d@rorschach.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230108163128.2860894d@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/8/23 14:31, Steven Rostedt wrote:
> On Sat,  7 Jan 2023 22:32:08 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> This includes some patches to fix 2 issues on ftrace selftests.
>>
>> - eprobe filter and eprobe syntax test case were introduced but it
>>    doesn't check whether the kernel supports eprobe filter. Thus the
>>    new test case fails on the kernel which has eprobe but not support
>>    eprobe filter. To solve this issue, add a filter description to
>>    README file [1/3] and run the filter syntax error test only if the
>>    description is found in the README file [2/3].
>>
>> - Recently objtool adds prefix symbols for the function padding nops,
>>    and the probepoint test case fails because this probepoint test case
>>    tests whether the kprobe event can probe the target function and the
>>    functions next to the target function. But the prefix symbols can not
>>    be probed. Thus these prefix symbols must be skipped [3/3].
>>
>> Thank you,
>>
>> ---
>>
>> Masami Hiramatsu (Google) (3):
>>        tracing/eprobe: Fix to add filter on eprobe description in README file
>>        selftests/ftrace: Fix eprobe syntax test case to check filter support
>>        selftests/ftrace: Fix probepoint testcase to ignore __pfx_* symbols
>>
>>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 

For selftest patches in the series: (Assuming patches 2&3 depend on patch 1.)

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
