Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCB78D1D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 03:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbjH3Bsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 21:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbjH3BsG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 21:48:06 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4070122;
        Tue, 29 Aug 2023 18:48:03 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7924a3eb5afso171795139f.0;
        Tue, 29 Aug 2023 18:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693360083; x=1693964883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lrXl+IkL773Hdi+O0O6b0ok2HlU+lC6ZL5UEZGArd/k=;
        b=Ff4SkYcG/4EREJFqdu2OYB5pKAaaV8GCEyEMT/9W2lnyKjDudAO6lDgMItypGWV3Ly
         WgkDbPlfAYfBwTNAjgpL1TPqJ27+K96U5OMzcQzDDLUV85+7o/D2NODi/Hxruhk3ApXc
         v3mSWRB7WQqWNa13Cr35FE8WyDg/3sR5tuKgGKWjxdsQbBu+xH+2aoiJlF1ghaQj6PCR
         q05rsp0Kh22tXafwSw72m0tbwJTnOvqVf8OPAEDGVRSLCCV/6G+XzyT4Cify3TvvDBHv
         SNgHqYXGvCYI9bCqh7wXFM1X8G2ANrKdNDuuILnFfA8a+9ZNCXwndiGGXwAFzba3VNaM
         6vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693360083; x=1693964883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrXl+IkL773Hdi+O0O6b0ok2HlU+lC6ZL5UEZGArd/k=;
        b=XWpKpCpilZqKOigoXOYf8Vm504dK5jBl1fHJYfK3UX0rqhUJThVVPzqscOiwlkZCzj
         XKbQ/dt+d+hPcOM1aUjCXRfVDvk6olKxg6ub38MQOoHK7Fsk0cvUCUzGFTdGoOFh7o1d
         9XHxYBfDnPBy4uINd2qrjDpQaBVon5OourHgIbhNdwZeDzp6LBF/1zM5oOUaEJr2LX8c
         DqkJQxUGNhtIKa+hMUCX7lmbqE/XJtjSb+nBtAIbvLZ9uDlwA46rx1iUFaVUpyD42vaV
         i2jXuThvsbGlMF+HdREFrNLgZSYPPzaoP/ozgZQ6brJ6EZM+8SDUY9kmhl9gXFyHWEMd
         faxA==
X-Gm-Message-State: AOJu0YyBtmYy+595ayD4sHFGjlwlbcBPjmyew5CZ3j91gUjjhL7h/sxu
        Ey852JKjhbxuLQ+/K+tHf4njquxjB18=
X-Google-Smtp-Source: AGHT+IEFITAE1+1v/asfaRh9oIzYuRGNr5xkyjuLwh+OXXP/+fO/uHERs/WApYuDqbNRhHu0iqj5mQ==
X-Received: by 2002:a5e:df0d:0:b0:787:1557:3834 with SMTP id f13-20020a5edf0d000000b0078715573834mr1013281ioq.20.1693360083087;
        Tue, 29 Aug 2023 18:48:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21-20020a02cf35000000b0042b394eb984sm3519450jar.105.2023.08.29.18.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 18:48:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a6f8cde5-a5d4-93ae-d6a8-c8ab4cba3c77@roeck-us.net>
Date:   Tue, 29 Aug 2023 18:48:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/9] kunit: Add ability to filter attributes
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmoar@google.com>, shuah@kernel.org, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
References: <20230725212522.1622716-1-rmoar@google.com>
 <20230725212522.1622716-5-rmoar@google.com>
 <55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net>
 <CABVgOS=7vtnJ09SRptaW6Gpv2nKVvc1hssL+6K29u5VeL8hYdw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABVgOS=7vtnJ09SRptaW6Gpv2nKVvc1hssL+6K29u5VeL8hYdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/23 17:24, David Gow wrote:
> On Wed, 30 Aug 2023 at 06:46, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Tue, Jul 25, 2023 at 09:25:15PM +0000, Rae Moar wrote:
>>> Add filtering of test attributes. Users can filter tests using the
>>> module_param called "filter".
>>>
>>> Filters are imputed in the format: <attribute_name><operation><value>
>>>
>>> Example: kunit.filter="speed>slow"
>>>
>>> Operations include: >, <, >=, <=, !=, and =. These operations will act the
>>> same for attributes of the same type but may not between types.
>>>
>>> Note multiple filters can be inputted by separating them with a comma.
>>> Example: kunit.filter="speed=slow, module!=example"
>>>
>>> Since both suites and test cases can have attributes, there may be
>>> conflicts. The process of filtering follows these rules:
>>> - Filtering always operates at a per-test level.
>>> - If a test has an attribute set, then the test's value is filtered on.
>>> - Otherwise, the value falls back to the suite's value.
>>> - If neither are set, the attribute has a global "default" value, which
>>>    is used.
>>>
>>> Filtered tests will not be run or show in output. The tests can instead be
>>> skipped using the configurable option "kunit.filter_action=skip".
>>>
>>> Note the default settings for running tests remains unfiltered.
>>>
>>> Finally, add "filter" methods for the speed and module attributes to parse
>>> and compare attribute values.
>>>
>>> Note this filtering functionality will be added to kunit.py in the next
>>> patch.
>>>
>>> Reviewed-by: David Gow <davidgow@google.com>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>
>> This patch causes all my s390 boot tests to crash.
>>
> 
> Thanks: I can reproduce this here.
> 
> Looks like this is an issue with string constants in the tests not
> being writable. (I'd've thought my testing with KASAN would pick up on
> this, but I guess string literals are in a writable segment on
> x86_64?)
> 
> Regardless, using char[] for the filters seems to work here. I've sent
> out a patch to do so:
> https://lore.kernel.org/linux-kselftest/20230830002116.3768675-1-davidgow@google.com/
> 
> That fixes the issue with the stacktrack below, but if you bisected it
> to this patch, maybe there's another issue. The tests weren't
> introduced until 76066f93f1df ("kunit: add tests for filtering
> attributes"). I don't get any crashes with this patch applied, though,
> so let me know if something's still broken.
> 

Your patch works just fine. Maybe bisect acted up ? I don't recall seeing
this happen, but who knows.

Thanks a lot for the quick fix!

Guenter

