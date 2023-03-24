Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFBB6C7C5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 11:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCXKRf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXKRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 06:17:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A65136EF;
        Fri, 24 Mar 2023 03:17:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s8so1532913lfr.8;
        Fri, 24 Mar 2023 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679653051;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKI80BGooykUH8804XqZbqpXI1kCkxjaQ/+9IzL2Xiw=;
        b=Kxa+q4AEQT1i6IRajV6+FKmGNg92TFnsE6gP+npUIx5KFknE0M5js0opulMYuUKoP1
         hhojoDbNZfNRJu0Y1brF9qq2z0bXV95RWJf7/Ox0JDxliXiFtYnPBDvXhdVTAwjlHJZV
         jOA+hIxZTYT+OW1lHthZDFkBRSe26bC4yrs9mAGGVHgI8HV9IMS4f6GBcXSkAnkpcDGU
         KahndWPQnDiNwQBPLA7erzgzeaxFl7oIk4v9gU4YpiKS/8y8T3jsz6VLM9G3JnQt+mpt
         ctg1qKo5TeSkVMpSQjuChZp4n7LFAL/FD18RDYugCyn8TtDbSPsU6H5sEcpaf1/Tt0dV
         8YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653051;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKI80BGooykUH8804XqZbqpXI1kCkxjaQ/+9IzL2Xiw=;
        b=b9xlIIKJ4TEa1Dff++QizEHFumk2FGgbT1u1OLi3/Ad/XG3M57bYS9Z412fJn+FYhP
         MEzW2zT1kPiN+0USZU6nPh26a3s+YQQi6XwPtj7xukRTD9WrpWbLYpauzw+jZtaqYgxs
         DI8U/3mqB4E2SAE64lSnVPWviNWmJyztQRoUPCIV0VHlGOaAHejmjBPThFICKOHqgkL0
         UEslzLRI2P92BUjrYClskAKOfZTXwuq6hSF3Mzzgo6gnJQtjQ+s3qW3+RuEHwIsWvRx9
         KLcSB7Hm7eT0d40aQ3QHsOjGs0CKZqXgKtI5yf9/zsK8PvEQl/BHg5qwqncxoxI9uQOE
         fcbA==
X-Gm-Message-State: AAQBX9dfcdShrkZzdumpnOktF7cuJ12lMjey9eSR85DnuXoVkF1NAU3h
        TQntyZzJkT5DTxN7nu1uEdo=
X-Google-Smtp-Source: AKy350Zkz+Y0xK6vR056bzbMJ5c6SO+vEjK6lziTdDbWrWpcG33tOleLGWSLtofdUPrnpRYC4JuzhA==
X-Received: by 2002:ac2:530d:0:b0:4e9:a9e6:2752 with SMTP id c13-20020ac2530d000000b004e9a9e62752mr630594lfh.22.1679653051591;
        Fri, 24 Mar 2023 03:17:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id d24-20020ac25458000000b004eae6283565sm1669239lfn.299.2023.03.24.03.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:17:31 -0700 (PDT)
Message-ID: <a02044e7-3210-a0c2-ceda-8c19fadd237a@gmail.com>
Date:   Fri, 24 Mar 2023 12:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     David Gow <davidgow@google.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
 <97f60824-7067-62cc-2882-d998072886ce@gmail.com>
 <CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7FtA-dTQ@mail.gmail.com>
 <f0b4d2ad-9635-9ab8-7cd7-bfadded94714@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <f0b4d2ad-9635-9ab8-7cd7-bfadded94714@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/23 12:05, Matti Vaittinen wrote:
> On 3/24/23 11:52, David Gow wrote:
>> On Fri, 24 Mar 2023 at 14:51, Matti Vaittinen 
>> <mazziesaccount@gmail.com> wrote:
>>>
>>> On 3/24/23 08:34, David Gow wrote:
>>>> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen 
>>>> <mazziesaccount@gmail.com> wrote:
> 
>>>> I think that sounds like a good strategy for now, and we can work on a
>>>> set of 'generic helpers' which have an associated bus and struct
>>>> kunit_device in the meantime. If we can continue to use
>>>> root_device_register until those are ready, that'd be very convenient.
>>>
>>> Would it be a tiny bit more acceptable if we did add a very simple:
>>>
>>> #define kunit_root_device_register(name) root_device_register(name)
>>> #define kunit_root_device_unregister(dev) root_device_unregister(dev)
>>>
>>> to include/kunit/device.h (or somesuch)
>>>
>>> This should help us later to at least spot the places where
>>> root_device_[un]register() is abused and (potentially mass-)covert them
>>> to use the proper helpers when they're available.
>>>
>>
>> Great idea.
>>
>> The code I've been playing with has the following in 
>> include/kunit/device.h:
>>
>> /* Register a new device against a KUnit test. */
>> struct device *kunit_device_register(struct kunit *test, const char 
>> *name);
>> /* Unregister a device created by kunit_device_register() early (i.e.,
>> before test cleanup). */
>> void kunit_device_unregister(struct kunit *test, struct device *dev);
>>
>> If we used the same names, and just forwarded them to
>> root_device_register() and root_device_unregister() for now
>> (discarding the struct kunit pointer), then I expect we could just
>> swap out the implementation to gain the extra functionality.

There's one thing though. If the goal is to do a direct replacement and 
if automatic device deletion upon test completion / test abort is 
planned - then it should be there also for these initial wrappers.

If these wrappers don't yet include the automatic device clean-up - then 
it probably makes more sense to just do the kunit_root_device_* defines 
because the tests are likely to need removing the explicit device 
clean-ups when proper APIs are finished.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

