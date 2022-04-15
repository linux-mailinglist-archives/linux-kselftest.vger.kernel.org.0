Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C75030F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Apr 2022 01:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356087AbiDOVrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356140AbiDOVq7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 17:46:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E3120AA
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 14:44:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so8056484plo.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Apr 2022 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Gk+7fgGBPOWKPaXdAN9G57GRLaAX6Nk2DK6Zn7gSK5k=;
        b=tIGkFJJuPZDSGI4it8k7JxuUjCNwZAbl/3s9Hgz3l1DMc0D59fzyeNgGgyKdivVctr
         M9Hjj+77f01PG5h6DIsywnwVXxQWkjtn0PkLMozT/xR0PZMkdLzFoBMN9TnmMvzVyD4O
         qBWsk+oYXwhaG7/asWuHpGUBwjrBNNKZoWT+Msxzs7slq8829FUh4FCXZDTG4yx1SZSI
         6SFhM4pY3ynCQBIwGLR5KSvinvTtvbPKptteJQcYFCX6aITkybSGgOQfAnRuRs5LNVde
         /e1Gr7+0c5echJqyynG9oifs646cTpxqAXreGSFDVcjwiYdxFrb49wGUjR1OHp4bFY1U
         F6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Gk+7fgGBPOWKPaXdAN9G57GRLaAX6Nk2DK6Zn7gSK5k=;
        b=5YdaaqGi7U3vi/hIlR4XUWZZXQfNi6XpvGr1YuQYYEQ74KAwNJ5ZY7cW5jkt7gCbiL
         /gC++d6mCfLqywAvRLkcLb8aRWl5AfhkSR70egjmMYAK9l2hrAc/2eJ4XmmBtGvgW7Gc
         O0RZ6JWIggSLyEPHWzs/geC78rv6yNNtZSDYbl58+2zVXIg6rploF2Ehjo9UbNelyw4l
         cdgqFx2Ym2N5dGjGuqZMX/oMnfSAKg2RF6ld0J5Fc42vYk6Wpnfy0fFCqz1xc/BHS2Oh
         E77MJRoy3lvovkR8d8DobdIIorspGyVUSfOCYhymBBHoG/lleh2Drbvc3+qyLlykF7DO
         Dzdg==
X-Gm-Message-State: AOAM530J2HFF4zU2kqkJS+KCFV2jVatw6yAoPGtLJX1spKKA50gfiPRA
        CmtV751ePXCmXNm97nCNyJpwfA==
X-Google-Smtp-Source: ABdhPJyWM5pz48kb/gf6V0OQcpljp6SwfU3pPBli48/v5anhU19PFACJaNco1IfCGjtuixSSvMEtKg==
X-Received: by 2002:a17:90a:6c64:b0:1cb:93b2:b6a9 with SMTP id x91-20020a17090a6c6400b001cb93b2b6a9mr6322512pjj.144.1650059069323;
        Fri, 15 Apr 2022 14:44:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:2d:3:51d5:33b1:431b:be0? ([2620:15c:2d:3:51d5:33b1:431b:be0])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm4003287pfl.15.2022.04.15.14.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:44:28 -0700 (PDT)
Message-ID: <f496b0c6-ad94-1837-1edd-3f6f9c00b927@google.com>
Date:   Fri, 15 Apr 2022 14:44:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
Content-Language: en-US
From:   Steve Muckle <smuckle@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>
References: <20220318021314.3225240-1-davidgow@google.com>
 <20220318092159.6f275782@gandalf.local.home>
 <CAFd5g461Poh37o=3m6EXppdX7oS0D5vZxvFAEtzJMwtBD1VJEw@mail.gmail.com>
 <f65c2381-1e9c-5945-7672-848d1826532d@google.com>
In-Reply-To: <f65c2381-1e9c-5945-7672-848d1826532d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Joe Fradley who is also looking at KUnit with Android.

On 4/15/22 14:43, Steve Muckle wrote:
> On 4/4/22 13:13, Brendan Higgins wrote:
>> On Fri, Mar 18, 2022 at 9:22 AM Steven Rostedt <rostedt@goodmis.org> 
>> wrote:
>>>
>>> On Fri, 18 Mar 2022 10:13:12 +0800
>>> David Gow <davidgow@google.com> wrote:
>>>
>>>> Does either (or both) of these features sound useful, and is this
>>>> sort-of API the right model? (Personally, I think there's a reasonable
>>>> scope for both.) Is anything obviously missing or wrong? Do the names,
>>>> descriptions etc. make any sense?
>>>
>>> Obviously I'm biased toward the ftrace solution ;-)
>>
>> Personally, I like providing both - as long as we can keep the
>> interface the same.
>>
>> Ftrace is less visually invasive, but it is also less flexible in
>> capabilities, and requires substantial work to support on new
>> architectures.
> 
> The general feature looks useful to me. I'm not sure the ftrace based 
> API is worth it given it is only offering a visual improvement and has 
> some drawbacks compared to the other implementation (won't work with 
> inline functions, dependencies on other features). Livepatch is absent 
> on arm64 which mostly rules it out for my purposes (Android Generic 
> Kernel Image testing).
> 
> cheers,
> Steve
