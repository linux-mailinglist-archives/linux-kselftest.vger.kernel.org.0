Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFB6DCAC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjDJSaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 14:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJSaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 14:30:07 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0609F1BD8
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 11:30:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7606d6a2aa5so2830139f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681151405; x=1683743405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYKDJKwn10X7KLBuY10/um2m58nz9p5VC59dotIeEO0=;
        b=FRdjAn56JBxgc+W8+zwgpjOs3Nr2+xBM+V86kQ+EGBTwrajmGuxhQUI/puxV05pZUX
         Cvtj62XK1mKeWW2jbxDR6jettZuvK6HGogF8sFXdwKaXnwUJqn1O5IVgIjUDDCXBS3EW
         UQwPhR4S/Av81m64se7slJLAVXyzIqvzRyUa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681151405; x=1683743405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYKDJKwn10X7KLBuY10/um2m58nz9p5VC59dotIeEO0=;
        b=k+Og6cI5u5BYsr6rVL35zrPZgYQyjjSJjCkP0Ec9Xdw2Yh+LpFC99iFjDHGymfi14W
         r+aBC9v7n1Xe5muPVVo/rUisOf7UcPTawn25qYXayn4RRX+XNUS8e/PGAS1MCbS+4HrI
         NIZJuw5gBiNvztMUcM7qB/GKCfponhhpysS9kcjdAvNofhDDMaDGITIZZ2iDl1A+3Gmf
         x+4pSoPAvPDLoij+e82ndP9+sCq8dhRQkSAQIl5RXIm8Z+/zL5P5pcmUmKSgIDFq3yvK
         Ubx3L0b9bhQ9WoZfvnA87q0BaBmflgcddaPsHVYJhLqjE3WFmeSbZXve0yXRui8z3o6q
         mWEQ==
X-Gm-Message-State: AAQBX9caJskqQTvN32pdWqs7ugpSXQv1Uv/5LQurIeJSJIkhJv4tXDFo
        cpgtDf4Wf94F8kXkZb5Lx3UmyA==
X-Google-Smtp-Source: AKy350aTt/4xClTAoIKpBxclNxt+cGRKJn1lsW7n0DD5/6/9nxr7cWLFWKFlG0cHJgwC7hfmKNtssQ==
X-Received: by 2002:a05:6602:13d4:b0:757:f2a2:affa with SMTP id o20-20020a05660213d400b00757f2a2affamr6532981iov.1.1681151405345;
        Mon, 10 Apr 2023 11:30:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cx4-20020a056638490400b0040bd4f2fcedsm588700jab.105.2023.04.10.11.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 11:30:04 -0700 (PDT)
Message-ID: <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
Date:   Mon, 10 Apr 2023 12:30:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Content-Language: en-US
To:     paulmck@kernel.org, Willy Tarreau <w@1wt.eu>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/6/23 12:43, Paul E. McKenney wrote:
> On Thu, Apr 06, 2023 at 08:26:09PM +0200, Willy Tarreau wrote:
>> On Thu, Apr 06, 2023 at 05:19:10PM +0100, Mark Brown wrote:
>>> vprintf() is equivalent to vfprintf() to stdout so implement it as a simple
>>> wrapper for the existing vfprintf(), allowing us to build kselftest.h.
>>>
>>> Suggested-by: Willy Tarreau <w@1wt.eu>
>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>>> ---
>>>   tools/include/nolibc/stdio.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
>>> index 96ac8afc5aee..6cbbb52836a0 100644
>>> --- a/tools/include/nolibc/stdio.h
>>> +++ b/tools/include/nolibc/stdio.h
>>> @@ -273,6 +273,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
>>>   	return written;
>>>   }
>>>   
>>> +static __attribute__((unused))
>>> +int vprintf(const char *fmt, va_list args)
>>> +{
>>> +	return vfprintf(stdout, fmt, args);
>>> +}
>>> +
>>>   static __attribute__((unused, format(printf, 2, 3)))
>>>   int fprintf(FILE *stream, const char *fmt, ...)
>>>   {
>>
>> Perfect, thank you Mark, I'm glad that it simplified the rest of
>> your series.
>>
>> Acked-by: Willy Tarreau <w@1wt.eu>
>>
>> Paul, feel free to directly queue this one for 6.5. If you prefer I
>> can as well queue it on my side and send it later, it's just that I
>> have exactly zero extra value on top of this one ;-)
> 
> Alternatively, if it would be more convenient for Mark to send this
> up via kselftest:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> It currently merges cleanly with the -rcu tree's dev branch, so this
> should not be a problem.
> 
> Either way, please let me know, Mark!
> 
> 						

I can take these through kselftest or can go through arm64

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
