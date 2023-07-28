Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BC767376
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjG1ReX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG1ReW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:34:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553413AA5
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:34:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760dff4b701so29679139f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565658; x=1691170458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJok0QwvQYR36IKSjL8u59VRoTv1ncFddhWzUUY4CBU=;
        b=XtTBKKi+apn2fenZceCkRVw6TxyPthsMizJvUJrPqjkPN2XI4pbqgSDa4uDCTSd/FZ
         Luwhkl++4arII4ixaGEnK+WoPSnFplB1+9+0uYlYuXC3ax638pDV07ieqSvgaYshQcyp
         rzWhvpVh7VgJH0aZBOO0gZz5olNyXWLlSAzTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565658; x=1691170458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJok0QwvQYR36IKSjL8u59VRoTv1ncFddhWzUUY4CBU=;
        b=BamDLPbvjALYpeG1pvHkLwoqO5jXIIt0sbbZ3s6IYE2/Wti6B9iKrw8tUpDi9aN7yf
         xA2Uj0RgJm1ORinAljsqpEDP/C3SHLC76uqylefHg67jM7HG9CXkxW9kP+HvpM7OZMSS
         Oot+52xpPG1PTEaW0fpGD0lWt+mowFt6Xlyhepat+7ayUhbKorMc+z82ybWbzHEj+LI8
         c1xbsPrT2Tu4TyCvThScz/MQDbyMs7mdryo01H1tD3ll+yVrjkhGc5d+ZH9I5Kmrpv0i
         t7d1a4qYKo/d/GTF0L8woXdXCoTEcSfilz2oeSvpZxqGzXZGUrU7eCYby58xW8gT9iHX
         L63w==
X-Gm-Message-State: ABy/qLYQ/h/qOeZlQeh1Sl0c868H44deVYfc1mwf5T4mTbYFomkPX9Z0
        1blGYELnesgzUr3IC+LbynfzeQIXicAJFfSWZh5ovg==
X-Google-Smtp-Source: APBJJlGurOK8bCZ2RudKd5/e+thD+HiWjwVIx2Tiv/Vlhq/itMoQKBCYEu4Myp6ksjRe3coqJq70vw==
X-Received: by 2002:a6b:3b09:0:b0:780:cb36:6f24 with SMTP id i9-20020a6b3b09000000b00780cb366f24mr199256ioa.2.1690565658763;
        Fri, 28 Jul 2023 10:34:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a10-20020a056638018a00b0042b599b224bsm1244019jaq.121.2023.07.28.10.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:34:18 -0700 (PDT)
Message-ID: <b247219c-f988-bcc2-36f5-22659e2ced96@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 11:34:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Content-Language: en-US
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
 <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
 <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
 <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
 <20230727194311.6a51f285@kernel.org>
 <5844361F-E776-4C52-BA8F-7E13D6B4EDE1@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5844361F-E776-4C52-BA8F-7E13D6B4EDE1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 10:46, Anjali Kulkarni wrote:
> 
> 
>> On Jul 27, 2023, at 7:43 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Fri, 28 Jul 2023 01:38:40 +0000 Anjali Kulkarni wrote:
>>> Jakub,
>>> Do I need to revert the -f runtime filter option back to compile time
>>> and commit with that disabled so the selftest compiles on a kernel on
>>> which the new options are not defined?
>>
>> I'm not 100% sure myself on what's the expectations for building
>> selftests against uAPI headers is..
>>
>> I _think_ that you're supposed to add an -I$something to
>> the CFLAGS in your Makefile. KHDR_INCLUDES maybe? So that the uAPI
>> headers from the build get used (rendered by make headers).
>>
>> Take a look at Documentation/dev-tools/kselftest.rst, I hope
>> the answer is somewhere there.
> Ok thanks, I will look into your suggestions.
> Anjali
> 

I sent a 3 patch series with the fix to this problem and a couple of
others I found during testing.

thanks,
-- Shuah
