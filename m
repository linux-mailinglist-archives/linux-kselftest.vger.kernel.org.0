Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0136525387
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353036AbiELR0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356999AbiELR0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:26:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CB6F498;
        Thu, 12 May 2022 10:26:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l15so4023298ilh.3;
        Thu, 12 May 2022 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QKm3n0v8rk6VHx9tGn2YwNzy4klIX/9lzZ8DLlwYNkI=;
        b=I6uckV0hW9685lv/BrD/CU5YywPkCnJ0C5a8IOrIceMeCqikNXqMwglMnH4UO2Ypel
         fkhT1i+MWp5IHRefROev7XKpF0DnEhLVsGI70nW5FBnVBhfGmQNqOF79AWIszHJDLlGu
         tOWK+iqCqn4SnBoJ+rh7yEq3L3lfqAiFdKYikc6Dzm+gPJDDmWpfjw1kMloSjdCVI+CE
         R3TAvQQX8QoNB26QVw3LKNBSB5V+F0dBFrZZp4IJrottvsV0wmP5hYHcBj6ZAoVXleFm
         q1bUxWf+H4MccRO8cj3SxA5vWPlaznpZGDzkc9hdG5hbw/DcAsXdEWprH8CmkrWUjslA
         cAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QKm3n0v8rk6VHx9tGn2YwNzy4klIX/9lzZ8DLlwYNkI=;
        b=MbnN2JAjM58wZAeAPIJhcoVUQcLE3v29bOKdImKNrbM1Z+IT8BXBuLLyyPlny/ex4I
         M51gQw37AsnYTOuzPIv23BG5+hG4KysFFbTKc1+kiagE8rQ9zRHqnewYtxTOu86PVSH0
         c04QmWVxzJ8BAEARU2YjLowHC6ARAgiWQiTLng5Ri2c1low+HlGyhIBIo5k+F5rgYM44
         GVgb+TzzOS5gcPQBIBz0J8N95Z05ZS+7Fso6qJqco64rAMSDK2bcpCTMIeCJyXBybCEh
         TfCvgrGAYTspEnzxPPfS4om3htbni5EI7UVFh/bHrFgdA3ezeAYbVZlVx2nG1KRZM+QJ
         VlWg==
X-Gm-Message-State: AOAM530QQX6ZynvH7Rh4KawVeZyn7yGd5xZzOA0GtSR5NwYw5jAofd/+
        x6m+7/sPSKJX+DUH8RLKIz0=
X-Google-Smtp-Source: ABdhPJxqFWzsj34P2hAjM6BBEKPVVGCVSqoNPfvIeXNfYGWVvSx4+gSnimbShO6ArmPqcwmxb3ETJw==
X-Received: by 2002:a05:6e02:2190:b0:2cf:8529:e291 with SMTP id j16-20020a056e02219000b002cf8529e291mr620684ila.22.1652376395589;
        Thu, 12 May 2022 10:26:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:fdf4:a10e:cb39:9b64? ([2600:1700:2442:6db0:fdf4:a10e:cb39:9b64])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b0032b3a7817c8sm21178jam.140.2022.05.12.10.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 10:26:35 -0700 (PDT)
Message-ID: <5b2783a2-76bf-ce6f-89b1-d0fe05b80b82@gmail.com>
Date:   Thu, 12 May 2022 12:26:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] KTAP spec v2: prefix to KTAP data
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
 <5ca35c47-6145-4ec1-6c05-3c46f436cb4d@gmail.com>
 <CAGS_qxpE9qGsS1LqaobVGFKFgV6TwvwNLR4e9PG5zsfPACSf_Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAGS_qxpE9qGsS1LqaobVGFKFgV6TwvwNLR4e9PG5zsfPACSf_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/12/22 10:25, Daniel Latypov wrote:
> On Wed, May 11, 2022 at 11:01 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> ================================================================================
>> #### discussion notes:
>>
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> PRO: minimally invasive to specification.
>>
>> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> CON:
>>
>> KTAP does not include any mechanism to describe the value of <prefix string>
>> to test harnesses and test output processing programs.  The test output
>> processing programs must infer the value of <prefix string> by detecting
>> the <prefix string> in the "Version lines".
>>
>> The detection of a "Version lines" might be a match of the regex:
>>
>>    "^.*KTAP version 2$"
>>
>> This risks falsely detecting a "Version lines", but the risk is small???
> 
> Agree this is a risk and also think it's probably small, but it's hard to say.
> I think the $ anchoring the regex is probably safe enough.
> 
> As noted earlier, this tracks with what kunit.py already does.
> That was necessitated by dynamic prefixes such as timestamps, etc.f

That is a good observation.  I nearly always have the prefix timestamp
on my console output, and thus remove the timestamp with a regex when
processing the data.

-Frank

> So I think this is probably a fine risk to take.
> 
> I imagine we could add constraints of prefix string, e.g. must have []
> around it, etc. if we want to try and minimize this risk.
> But I don't know if it's necessarily worth it, given what we know right now.
> 
> Along those lines, I think I like this approach (Alternative 1) more
> than Alternative 2/2b.
> I'm not sure we need a structured way to specify metadata in KTAP yet?
> The prefix seems like a reasonable candidate, but do others have ideas
> of other bits of metadata we'd want to be able to declare?
> 
> Daniel

