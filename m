Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACC929A5D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ0HvW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 03:51:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34900 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgJ0HvV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 03:51:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so438946pfo.2;
        Tue, 27 Oct 2020 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0TgzwCQyLcbxOPAv7GqkDMwH11sjIKMqSi7RJONsgD8=;
        b=AiaQ/wVH6ACHqWJT1/4uquhvfhTdENyXnafs/oAn7KULi7K0oAv3ZQ2QXInF0zmM28
         vRwRO2J4z0uy6Alr374aC0SDoMwgFMXIvrPumw7DgJD+/keLRSmGVyJMNOYd03x5eMfZ
         4NGTanVC19vTN60IMHmMJuc5kzPY16PhCyf4VRLbDk3XUKFQzlnFGR0jMfapRx1JSnjC
         e3+kSfVtElLYCHlQ1eV5yWbBfliGwU5t4+NoMZi+gZr0vTJNziz1mXt1/RLvsAk+KJgY
         EB5PCkJjh1pPZEyZh4KEXNjbQqqAAITkbmJ/Z3/Z1YS8v3LCVAI75TtAbSlxv2SU+O4N
         fn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0TgzwCQyLcbxOPAv7GqkDMwH11sjIKMqSi7RJONsgD8=;
        b=NxqWATYeh3gJ6a4/gPW/3+96wBSa1GwMwNlyaCP/Q54h8vu/FKXVw5tU6bE1Ue/aXB
         K1kzMps3qHXCCdzse6qM1OM0RzdwFhDPYtyM7ZR9P0KauMR90L3Z6oYq2IhcRzYBi5VP
         Aq0Fi9KpGJkKpP5mp2r2VoRwGal6ZF5rilnU87Mwh1LFT4OEviLUtSTGK6nH8trXeN5a
         QeNx/WOkkKcfks9XAhvOOhMnxrACYLgFtt4FXV60Necd5kaEsGnz7i+5esPRWuyxY7zr
         UVs4uNIpe83od9LcS3bq9w4BjfMpmNyjtw/ZC+7kIP5rC6Tc7t7Rd1/XyQpY2mWEN0/H
         UByw==
X-Gm-Message-State: AOAM533+PyAb59XtmB4/y2zLEDRJNx9m2NqmruIzkwhKE4jrqlZRFWNN
        W1qVLsJuu38xDZkR0AIVwRZz1/r+h8TYJuBf
X-Google-Smtp-Source: ABdhPJwOATGhQrAIb0ZD9AMPEVSauH8/Iu+IQhqT1GFwVV8ySesu17fZp1dwPFZ6hyo2fJXgpYqKwg==
X-Received: by 2002:a62:7cd4:0:b029:152:b3e8:c59f with SMTP id x203-20020a627cd40000b0290152b3e8c59fmr1071350pfc.2.1603785080468;
        Tue, 27 Oct 2020 00:51:20 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id q24sm1354823pfn.72.2020.10.27.00.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:51:19 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201026183523.82749-1-98.arpi@gmail.com>
 <CANpmjNNQtGC_jDp8TSHRHOMXi7aTQgwjtUiCWE+YqBgq-G2z5Q@mail.gmail.com>
 <f25c881d-03f9-e246-d8d4-e985d9662d04@gmail.com>
 <CANpmjNMVjuNOh-P6dENhyk_+=AHqkZYugQ3KQS9T3qXTrUSXGA@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <1c1e0924-40b6-17e1-11c3-081970484340@gmail.com>
Date:   Tue, 27 Oct 2020 13:21:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNMVjuNOh-P6dENhyk_+=AHqkZYugQ3KQS9T3qXTrUSXGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27/10/20 1:14 pm, Marco Elver wrote:
> On Tue, 27 Oct 2020 at 06:14, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> [...]
>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>>> index a423fffefea0..16bf9f334e2c 100644
>>>> --- a/include/kunit/test.h
>>>> +++ b/include/kunit/test.h
>>>> @@ -142,6 +142,12 @@ struct kunit_case {
>>>>         void (*run_case)(struct kunit *test);
>>>>         const char *name;
>>>>
>>>> +       /*
>>>> +        * Pointer to test parameter generator function.
>>>> +        * Used only for parameterized tests.
>>>
>>> What I meant was to give a description of the protocol, so that if
>>> somebody wanted, they could (without reading the implementation)
>>> implement their own custom generator without the helper macro.
>>>
>>> E.g. something like: "The generator function is used to lazily
>>> generate a series of arbitrarily typed values that fit into a void*.
>>> The argument @prev is the previously returned value, which should be
>>> used to derive the next value; @prev is set to NULL on the initial
>>> generator call. When no more values are available, the generator must
>>> return NULL."
>>>
>>
>> Oh okay. I am not sure if this is the best place to add documentation for this.
> 
> I think it doesn't hurt to add, but have a look at the comment above
> this struct, which is already a kernel-doc comment. It probably makes
> sense to move the comment there to describe the new variable.
>

Alright, I will move the comment there.
 
> Thanks,
> -- Marco
> 

Thanks.
