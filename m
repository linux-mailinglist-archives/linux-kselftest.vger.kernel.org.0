Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E295760B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiGOLnT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jul 2022 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiGOLnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jul 2022 07:43:16 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6387F69
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 04:43:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10bd4812c29so5860510fac.11
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jul 2022 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VQI+n5ZVexq/RFQtI9uTeCBYc9Q8ptTIuUXze5tj8Kk=;
        b=uZGvy+WcHMyYVjCAleBI4P+bCDSsNwSmTD9uDqJfTlJZz91e04FQ09gTeV6bl9KAYc
         LbPfGGF2CE+5ipsiGFGyAMKjQ/jolT0xAYXhfatc+uv/Vof3YQQncGpJQXIqAcj8u6SE
         K9R2XwIZItbdjoRhs3pC0rlt272PcbQc2bFrSJvhd9YamEY2M1FqxX+iRUpFMSjoA2Oz
         6R4Gyk6dVKYrkLS6N/ePpQVEAot9E0g5KpFuQfkxMckUCN/qF1iv06O7ph3Mf+C1109x
         Jmq4Uj8xZwr6/f6Q1tzSjqKU3GSwcbXqyWIeWBnXtcxx51bewl7OAKpc8VN1v7QOhvFJ
         gm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VQI+n5ZVexq/RFQtI9uTeCBYc9Q8ptTIuUXze5tj8Kk=;
        b=8QzVcOwsJdG0q4gw6MmEsKolbE+rZpleXxzU90s6ei/t6S9MXj064eE+hy9Qu85Mpv
         v+RHY2/1F+hRtt0NfUvZGw9EHU1HbSlLIGJQAmGgnXIpYM8q4vwBbWxB7KmM0iKLjGXa
         bkPnP/cBeadz/eDfYSNaUJhvs6/mxeV4t8xUhUm+MzlAfu7lTujpYwSyt7ukYvDwW5LC
         x3E2ickHEOkEHvx0ngrrBelv4TCXjhNhVSIDKi4ZiDH+IDcuMP7z3qowgeNdwDJ/LQYk
         mLBYdtxFycltf57cVQerhDXkf49pMSACZrVo7MiybcB+mX5862oigYUaCrrm4J2CT0hP
         7I9w==
X-Gm-Message-State: AJIora+xsbold7Gd+cOQ2lhU6/+jpLne7iVzBDYrTjveqDdbPJXZ+Kcz
        a7fKKlFWzRNX5XfsNXe44k+oBQ==
X-Google-Smtp-Source: AGRyM1v1cEuvsOrEB1NGvZu3qaCyx+3hVDMt28UI411gif+IDxpkN5hrzgkEzpAQ7jhWf5EFqpP44Q==
X-Received: by 2002:a05:6870:b148:b0:101:a001:77f with SMTP id a8-20020a056870b14800b00101a001077fmr7612760oal.90.1657885392547;
        Fri, 15 Jul 2022 04:43:12 -0700 (PDT)
Received: from [192.168.1.195] ([187.36.234.139])
        by smtp.gmail.com with ESMTPSA id r41-20020a056870582900b00108b31bf8fbsm2233890oap.53.2022.07.15.04.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 04:43:12 -0700 (PDT)
Message-ID: <df984423-a751-2251-e392-840675da31e5@usp.br>
Date:   Fri, 15 Jul 2022 08:43:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/9] drm: selftest: convert drm_format selftest to
 KUnit
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-5-maira.canal@usp.br>
 <20220714235137.GA485839@roeck-us.net>
 <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
 <5f9b35b4-09fa-a8a9-3181-cd8cd7898d03@redhat.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <5f9b35b4-09fa-a8a9-3181-cd8cd7898d03@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/15/22 03:59, Javier Martinez Canillas wrote:
> On 7/15/22 02:03, Daniel Latypov wrote:
>> On Thu, Jul 14, 2022 at 4:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Fri, Jul 08, 2022 at 05:30:47PM -0300, Maíra Canal wrote:
>>>> Considering the current adoption of the KUnit framework, convert the
>>>> DRM format selftest to the KUnit API.
>>>>
>>>> Tested-by: David Gow <davidgow@google.com>
>>>> Acked-by: Daniel Latypov <dlatypov@google.com>
>>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>>> Signed-off-by: Maíra Canal <maira.canal@usp.br>
>>>
>>> This patch results in:
>>>
>>> Building powerpc:allmodconfig ... failed
>>> --------------
>>> Error log:
>>> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
>>> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3712 bytes is larger than 2048 bytes
>>>
>>> presumably due to function nesting.
>>
>> This can happen when there's a lot of KUNIT_EXPECT_* calls in a single function.
>> See [1] for some related context.
>> There were a number of patches that went into 5.18 ([2] and others) to
>> try and mitigate this, but it's not always enough.
>>
>> Ideally the compiler would see that the stack-local variables used in
>> these macros don't need to stick around, but it doesn't always
>> happen...
> 
> Thanks Daniel for the explanation.
> 
>> One workaround would be to split up the test case functions into smaller chunks.
>>
> 
> Maíra,
> 
> Could you please look at splitting in smaller chunks to mitigate this issue ?

I'll look into this during the weekend. Thanks Guenter for the report.

Best Regards,
- Maíra Canal

> 
