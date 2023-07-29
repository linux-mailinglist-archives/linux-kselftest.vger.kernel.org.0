Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D94767FC9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjG2Nzp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 09:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjG2Nzo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 09:55:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C19B8;
        Sat, 29 Jul 2023 06:55:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f8614ce5so2599649b3a.3;
        Sat, 29 Jul 2023 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638943; x=1691243743;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W5CQvw9OL6QHk2WCyd4xFMKgmuMpQv3ztQBy6irJwY=;
        b=jAl4249GqB73tejaq4qUZMi45GNzWKfIJ2EtYq61M0F2yxRD+FBdbPaGAVkKXiErDV
         o12rDchMpZfqk+HmdKureFNfFqThH/LZ/wp+BkaaIYum/VEvOsUwTDkiQa6NQKD/bFDl
         +hrfC1xJhh8E1t+wPJ9a+qsbqtlfNV89JZBOW2Q8tXA7AwavkS6oKpQhzrBFOqmqEbfz
         Gh112Zc413bf9vn8Lh6Tpxfl4m+HQ0C4PCmo8jQuqyURfLGbWqp0RH2V7lskX1Qdo8eg
         eKA1vrtW5nxV3nhS8a1mP44wiMRM9ut5apIiV3jr1E4MzoEl8KciRQmlTiqQtfjXCg72
         /e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638943; x=1691243743;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W5CQvw9OL6QHk2WCyd4xFMKgmuMpQv3ztQBy6irJwY=;
        b=ULak9977KJ+zFFSr6eX1LSNWYj4DeVpWZ2j8madF0hDpzrwU9jOSKfksR8M7lI1uh+
         1JJGS9rQlVakjjmdP75GqLTokXHlcosqKfMVlwPM9DIgy9JDJjYAEVkay3eJUrBOUUBC
         YwQ6IJbY/bMLc5I2KZfZArrMmCkUeRC95txv5F2ieMRwu/MOvu6AWmRHQ7WxykXG8qFt
         VXcW5tvbeq1fx9ufKs8Zkmz6Fl5IW2e4fHzIqXP/ZYk1Jlq7tWZQRrpOTyfBhjY4ZjWm
         SUpkj2FXoAmLbVJd1r5QFRKiUADxZgde9ylRWj2W+DDbX48M0PwRKgaCy/eAp0vBAqQ7
         qR3g==
X-Gm-Message-State: ABy/qLaxIQ0p6uuqgvRZ0lll9YAdQNukK3+ColUk0UWxulYwN0xgm0xr
        h4wtBDK/YgIQzft+MvwGy4M=
X-Google-Smtp-Source: APBJJlFEZwLcqCFfh9CE2jlYJadeiFraPAESeKzs7Z839fyJ80vxFxPJTxIRpdpTIhR+ClHsLb0kMA==
X-Received: by 2002:a05:6a00:1484:b0:66c:a45:f00b with SMTP id v4-20020a056a00148400b0066c0a45f00bmr6038915pfu.23.1690638942750;
        Sat, 29 Jul 2023 06:55:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b006765cb3255asm4737224pfa.68.2023.07.29.06.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:55:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5205b6aa-c9ea-8f9c-f42c-b840346f740c@roeck-us.net>
Date:   Sat, 29 Jul 2023 06:55:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmoar@google.com>, shuah@kernel.org, dlatypov@google.com,
        brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
References: <20230725212522.1622716-1-rmoar@google.com>
 <59dc28b1-298c-4e7b-b35f-0b94071f4cb5@roeck-us.net>
 <CABVgOS=wfUS929nKGvnRpBdEjQCHD1d5tbmGtKCBNFh2bKWO-Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 0/9] kunit: Add test attributes API
In-Reply-To: <CABVgOS=wfUS929nKGvnRpBdEjQCHD1d5tbmGtKCBNFh2bKWO-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/29/23 00:53, David Gow wrote:
> On Fri, 28 Jul 2023 at 18:38, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, Jul 25, 2023 at 09:25:11PM +0000, Rae Moar wrote:
>>> Hello everyone,
>>>
>>> This patch series adds a test attributes framework to KUnit.
>>>
>>
>> With this series in linux-next, almost 50% of my boot tests crash,
>> and many others show warnings tracebacks.
>>
>> Example crash from x86_64 boot attempt attached.
>>
>> Guenter
>>
>> ---
> 
> Hmm... It's not reproducing here (even with KASAN), which is strange.
> 
> Does the patch here help?
> https://lore.kernel.org/linux-kselftest/20230729010003.4058582-1-ruanjinjie@huawei.com/
> 

Yes, it does.

Guenter

