Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADC4ACB5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiBGVbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiBGVbs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:31:48 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD9C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:31:47 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so12239783ilm.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GR4yvSt4uQ+YFhNbD4fRaCObmP7kL/x3g2s6EkaKb2E=;
        b=SSy4G3WCV/9s4w/RXrOrMxQoCQGmDZ0pNskFdbfUIJ3hsbqGR0KaoM5ZGVoyJ22TrH
         ljbtBpk7HETNzk4/H0Z1eP5iPRujAVhmA5IbWkERnfjYyjLXmHrKndjdLFSbXrHbxfSa
         791oRBtIVlLEE2+/CgRJAAkG4KZlXyBEsitFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GR4yvSt4uQ+YFhNbD4fRaCObmP7kL/x3g2s6EkaKb2E=;
        b=cxohXdNdLhwFYw+K2UU5KcYU0Tyz7MDPQPF1js/CGHtjemR3vYGjUcKXsi1+5xNWaI
         muueiq5EItzzk0lYacYpIIcjpLxB3s3DKqnxNvuQpW+CJVEHuOL/7Lbx3R9RsJUea4ir
         LYKFXuV8P+cXax1NRCIZ9ppyCzo3ojqk7GSJC8nj0m6YfozovcfJWy1HlGt+vjAAaM3t
         8IWyay8D9S2l78lZTYGnCvPLngnpeBwpI+SXcciqlnhQs/FIYbkdi8d/fKZKXbBigecM
         hLapxetbld0KBew0mvpMYq56xfJVrQZlhnfG48j/ubqexETUmDRTISmSHxVBNNSckn/r
         ktEw==
X-Gm-Message-State: AOAM530sADcWu4v6ePCuOzzhjg9rLrHDrXga9ms1Np181mTAJsHunS0g
        R+4H8bESxkuTuTHk6Ylnyf3hSf4MyGgAjQ==
X-Google-Smtp-Source: ABdhPJwC34jQpOsfU+Uw9SdOgjKwsoFFNrIxvuFGF2xDqQXAiiA0oD6ysVJ9QpEGvaT4UciZENQang==
X-Received: by 2002:a05:6e02:1545:: with SMTP id j5mr713020ilu.318.1644269507088;
        Mon, 07 Feb 2022 13:31:47 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g11sm6438631iom.45.2022.02.07.13.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:31:46 -0800 (PST)
Subject: Re: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220119103332.2887370-1-usama.anjum@collabora.com>
 <3a4878b9-f175-f16f-a901-efc33b2bf89f@linuxfoundation.org>
 <24d02704-e590-63d0-4d8a-c76578249bea@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1464f5e1-d79b-b440-9a15-c0ed61599e1b@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 14:31:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <24d02704-e590-63d0-4d8a-c76578249bea@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 1:50 PM, Muhammad Usama Anjum wrote:
> On 2/7/22 11:40 PM, Shuah Khan wrote:
>> On 1/19/22 3:33 AM, Muhammad Usama Anjum wrote:
>>> If only futex selftest is compiled, uapi header files are copied to the
>>> selftests/futex/functional directory. This copy isn't needed. Set the
>>> DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
>>> path only. This removes extra copy of header file.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>    tools/testing/selftests/futex/functional/Makefile | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/futex/functional/Makefile
>>> b/tools/testing/selftests/futex/functional/Makefile
>>> index 5cc38de9d8ea..9a8c3700d773 100644
>>> --- a/tools/testing/selftests/futex/functional/Makefile
>>> +++ b/tools/testing/selftests/futex/functional/Makefile
>>> @@ -24,6 +24,7 @@ TEST_PROGS := run.sh
>>>      top_srcdir = ../../../../..
>>>    KSFT_KHDR_INSTALL := 1
>>> +DEFAULT_INSTALL_HDR_PATH := 1
>>>    include ../../lib.mk
>>>      $(TEST_GEN_FILES): $(HEADERS)
>>>
>>
>> This will be a good cleanup. However, please make there is no dependencies
>> in the futex test sub-dirs on being able to find the headers under futex
>>
> I've tried the following variations. The build is fine.
> 
> cd tools/testing/selftests/futex/functional
> make
> 
> cd tools/testing/selftests/futex/
> make
> 
> make -C tools/testing/selftests/
> 
>> I vaguely remember leaving this in place for reason.
>>
> This must have been fixed in previous changes made to the build system.
> 

Thanks for checking. I will apply this in for Linux 5.18-rc1

thanks,
-- Shuah
