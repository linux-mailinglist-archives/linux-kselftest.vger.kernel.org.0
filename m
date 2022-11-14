Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E74628844
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 19:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiKNSZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 13:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiKNSZ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 13:25:29 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5742AC5D
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 10:25:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p141so8828215iod.6
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FkHhNKFsHQ57OL02enGAiyqX0XUGbcyCurvdEOfJLE=;
        b=BxDOCMaGYlp7mpwI3xB4UqhzYj0Z1TRee1deSAyXEPHVLzjqJ+ur+nu1bUttc0r8Ni
         ORRHrN3mc0s4S5IJkFzEI0Nc70BK8odBQ98Vl1T9ZTlF7oCYw2fP/EIPgF/vhbqRFNBP
         8Qu5NVmwG40c/fbqDfsNEsGiT0o6quhkbROzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FkHhNKFsHQ57OL02enGAiyqX0XUGbcyCurvdEOfJLE=;
        b=B86NzIYHQO/SzBWLS4jyRYjuW+W71QXlEQiL9ASzcH2vbPViVzvHe1QPwa5sl5fRtE
         24jQsE4XqdlbKF/wpGFjsDLZfAI8oSIvv1xq4ba7R2Z1GZ61PQQt6yNgdcXT9/r9jHfo
         TWgac+KTFBgLAetlSt3kd955WAK+ZQgY5QshOFfplkRKcsw/UaiWPHiVM0pUhOLzdrsq
         u7upKbD532Kyp6OMa1EvQUOMMtt9zUKELEvbNEencpx0RQRUPlKlT6zONM3XXZYJXq4o
         eB3+zKLL6f+jqkvK/hjGPbOXnUVdbdhMhrMt9wRodhflubUBG0Wr/tYaTSzU6dXD6+18
         sQJw==
X-Gm-Message-State: ANoB5pl7qTFCzH/d5Fm5MGRJu+t2v5LdP0TTOmqgq4s6XMJ5WPqZaDIr
        QKbRLGXsfzdwJLjwpCMXArXP1igWb++7kw==
X-Google-Smtp-Source: AA0mqf5lTvDCjYEoE0HB9FCB/lAvDg2M+f7wU/c3U8grCXe6sDC0COy5AOuiJIYuvQrrJ+u2EF5zvw==
X-Received: by 2002:a02:7421:0:b0:375:1b97:812a with SMTP id o33-20020a027421000000b003751b97812amr6071610jac.168.1668450328001;
        Mon, 14 Nov 2022 10:25:28 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k130-20020a6bba88000000b0067fb21ad9c3sm4212159iof.22.2022.11.14.10.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 10:25:27 -0800 (PST)
Message-ID: <166d074a-77ce-f0b6-87df-7c5464d4cb1d@linuxfoundation.org>
Date:   Mon, 14 Nov 2022 11:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests/ftrace: event_triggers: wait longer for
 test_event_enable
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yipeng Zou <zouyipeng@huawei.com>, shuah@kernel.org,
        rdunlap@infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221104020931.231090-1-zouyipeng@huawei.com>
 <20221105175241.858bbd5b5337fc2b8a075ee9@kernel.org>
 <20221114131028.110a91c4@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221114131028.110a91c4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/14/22 11:10, Steven Rostedt wrote:
> On Sat, 5 Nov 2022 17:52:41 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> Hi Yipeng,
>>
>> On Fri, 4 Nov 2022 10:09:31 +0800
>> Yipeng Zou <zouyipeng@huawei.com> wrote:
>>
>>> In some platform, the schedule event may came slowly, delay 100ms can't
>>> cover it.
>>>
>>> I was notice that on my board which running in low cpu_freq,and this
>>> selftests allways gose fail.
>>
>> This looks good to me, since this can just extend the waiting time to 1 sec.
>> (and most of the platforms have no effect)
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to take this through your tree?
> 

Yup. I will get this in.

thanks,
-- Shuah

