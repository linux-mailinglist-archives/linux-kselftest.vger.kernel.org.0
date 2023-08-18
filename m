Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A2781266
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbjHRRzB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354920AbjHRRym (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 13:54:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49708271B
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:54:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdbf10333bso9850685ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692381280; x=1692986080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHXWV/B/cvY4kqn9fUvDdyjZst03D3h3M1qgX6mrFEs=;
        b=co0pvlQcs0eSdS/PK/KnMwNQyscrpA8V0sXzjFt/4y/jrDaAvOkcbnjNirV5hRdZnD
         wGoGGHbZBx9ALxN1lYdjY38p+42bcLM4jrdi1QYksQZq0Vvb4+3EQ0yTBpvbU25bvnJO
         HZLHFbEtlkupMoJXEe4WcZENaLRcoEUSeMmr2X5I+7n5/wJ9qdwXXBV1iJ81+MzR9h4y
         J5902fI5V0VdeBsSi5mtFKBiaJjZCxIlx0zPOVA1t2MT3IS99704hCCcIyuwp22vim22
         igEYueUrXrE1UePCbb5XIKygelRpwS2vjAyitaABVD60QnO4bd6KVXvp+j3IggeAMO/r
         X+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381280; x=1692986080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXWV/B/cvY4kqn9fUvDdyjZst03D3h3M1qgX6mrFEs=;
        b=CNpItM4IMLzHK78B4VY5HcxypBYwD/i2RsFS0ByR31F4h+qkSpngaflUgfbA2DFj1e
         GDdjjUXBYZA2FFcOqjqKayKFTJr1QWUvA+DvyDZssUj8/skdV8OW6CwDrmLBRKu5/X/5
         HQfy8O+WvoOhqp5AuNa4qxPhXVgAdM8W3GKET+bg9qDWnbk8NdkaVudnZhKylDVunj/M
         cit5R6x8CUjQ08mkIJdGcfIInKn6qKNtZEZ5JtyKIJ/bJ3acwgNz0d4mXzsbFS4QRpSC
         BKUjHHOfHAnMdq6O3uXUbdRJqXq9j0nWcsNpVGOLWYVZBrnvsoGbDhqkJIheeqbv8iDK
         LEdw==
X-Gm-Message-State: AOJu0Yz4f7Fj18GNeT7PQNoKPlnz7w43fhkA/Onrg2GuWGb5DpHwp/Bg
        5iOEgv7oN8qc0aCQu24axOc=
X-Google-Smtp-Source: AGHT+IGI8pvyhBeyuTX+WuyEZelHh07E99ABGw0i6MhfKS7PBl284B0XDf+7TmF6tNGicqZ16Yafjg==
X-Received: by 2002:a17:902:e546:b0:1bb:a522:909a with SMTP id n6-20020a170902e54600b001bba522909amr3384854plf.37.1692381279532;
        Fri, 18 Aug 2023 10:54:39 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001bdc50316c3sm2036506pld.232.2023.08.18.10.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 10:54:38 -0700 (PDT)
Message-ID: <ea89e904-f164-beac-cc3c-12014eaef401@gmail.com>
Date:   Sat, 19 Aug 2023 00:54:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] selftests/tdx: Add .gitignore
To:     Sagi Shahar <sagis@google.com>
Cc:     shuah@kernel.org, kirill.shutemov@linux.intel.com,
        mika.westerberg@linux.intel.com, wander@redhat.com,
        kai.huang@intel.com, mathieu.desnoyers@efficios.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kselftest@vger.kernel.org
References: <20230818170454.19493-1-tuananhlfc@gmail.com>
 <CAAhR5DG-QXw9p5avOVEhyfz6e4VGQSP_GBaZa9mb034D_fb9GA@mail.gmail.com>
Content-Language: en-US
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <CAAhR5DG-QXw9p5avOVEhyfz6e4VGQSP_GBaZa9mb034D_fb9GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 19/08/2023 00:45, Sagi Shahar wrote:
> On Fri, Aug 18, 2023 at 10:05 AM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>
>> Add .gitignore to ignore tools/testing/selftests/tdx/tdx_guest_test
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
>>   tools/testing/selftests/tdx/.gitignore | 2 ++
>>   1 file changed, 2 insertions(+)
>>   create mode 100644 tools/testing/selftests/tdx/.gitignore
>>
>> diff --git a/tools/testing/selftests/tdx/.gitignore b/tools/testing/selftests/tdx/.gitignore
>> new file mode 100644
>> index 000000000000..56dd26b77c07
>> --- /dev/null
>> +++ b/tools/testing/selftests/tdx/.gitignore
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +tdx_guest_test
>> --
>> 2.34.1
>>
> 
> tools/testing/selftests/kvm/.gitignore recently switched to a positive
> filter which might be easier to maintain in the future if you add more
> tests. You might want to consider just using the same .gitignore here.

Thanks for the feedback, it looks much more cleaner. I will send a patch 
v2 with the file copied from tools/testing/selftests/kvm/.gitignore.
