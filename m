Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AC651564
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 23:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLSWMu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiLSWMW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 17:12:22 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FC164A4
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 14:11:43 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id y2so5476084ily.5
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Dec 2022 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+5fBxr0lCerXn/Yuwt3YA+eF3QHf4Pm/K1HNIdR4Yw=;
        b=WKqyAZIz5MUR5DDQkGcUJRFdyBbNq2tXpvuDOOH+hVMD3E+SxrOeOkx5+TlsJ/sUdT
         FXk/bdGSfJjW9Y1f1Tuxfw6uG8doVAVWWuCqAR+NzOzS7/dsaclGzGhUYJcCbg5lwmXb
         o7v99LwuQk5vgQkCJ1vuFxXZCmezv9I4nkb6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+5fBxr0lCerXn/Yuwt3YA+eF3QHf4Pm/K1HNIdR4Yw=;
        b=YWv048MTwrbduKK2l2FH/ktSgIv08VgQElgC057Bi3xr3qGdIolPbxUolB0+QnPNgW
         ZQV6ussBUE1EVq252ghf2EIWBlKeO/8DXwMHz/fE/9tXpVWXIfhqj2x3lglr7WGcknRJ
         zziS+7kHzsEfmT+xZI6wfdWDc9QxzZzcKENC+Xe4ciLVX0KLBivHqhPSfLzdLiuyQvyL
         Qiwj7r1nechkF9iomLZ6Sfa1tqozW48Ge8j2mZicE8ZHN2x/sw/5DTK2rhO+W1znzmBd
         kxNpXgSUDXPnkZ3etF0SIhGU8jFjdZXVPlLzc6oyzk/hk5a6ZaWsufXm3lVq7BFuDBPW
         1LqA==
X-Gm-Message-State: ANoB5pnzXTaKT9Q80Kp8QhqJ5i7ic3BJ+SKj8+QDv+UXSDBqbQwHS46J
        cZM3q/+hvpz0rD84Nd7+br54jA==
X-Google-Smtp-Source: AA0mqf7zghrpxEOqa7lnFcSPA7YcI61pK9QzyHtXriaC03/iIxTUF+IEgYcbz1U9j1kWNEWsoJgg7A==
X-Received: by 2002:a05:6e02:892:b0:303:9c30:7eff with SMTP id z18-20020a056e02089200b003039c307effmr4662210ils.2.1671487902382;
        Mon, 19 Dec 2022 14:11:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v8-20020a056e020f8800b002e939413e83sm3602774ilo.48.2022.12.19.14.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 14:11:40 -0800 (PST)
Message-ID: <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
Date:   Mon, 19 Dec 2022 15:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
To:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org> <Y6DQTvOrHRZ8gjDz@google.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y6DQTvOrHRZ8gjDz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/19/22 13:57, Ross Zwisler wrote:
> On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>
>> With the new filter logic of passing in the name of a function to match an
>> instruction pointer (or the address of the function), add a test to make
>> sure that it is functional.
>>
>> This is also the first test to test plain filtering. The filtering has
>> been tested via the trigger logic, which uses the same code, but there was
>> nothing to test just the event filter, so this test is the first to add
>> such a case.
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Thank you both. I will apply this after rc1 comes out.

thanks,
-- Shuah
