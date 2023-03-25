Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52ED6C8C30
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 08:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCYH0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 03:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYH0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 03:26:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11F423A;
        Sat, 25 Mar 2023 00:26:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so4976507lfv.4;
        Sat, 25 Mar 2023 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679729208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUqUy5aXzM7x5TkWSCnYgWDsZ2sawvSz0ieoGTz0b7o=;
        b=FnFONsKg4jOMkONdwV7QaqhebcOQXeYGz8uvi9qug0a3cFnoSUECjIe/6KmkS0Fw8G
         CvTOC1T7nquFarjV0bAEQRWuG9lVAXQdAsnX30jZH0g5YgOcJkrQUGrGdYGRl16ESk2v
         ZYjECO/iA5iHuG5oI/BEbVRM0AKxulSUMBor7CqW2erT3g9l+0WQglQu5W1q2GksqKcm
         wAH/MNtvTuegqetEpELiYuG2SX0YY7d1JdkfmXFz/N8U+MEG6snuPwJPk3UPpIDaEzil
         Y3D8hnddAEJopTtbGiBlApYid13qeuLWBLlcOSOSWEVSwDge82fYB3lw+Hd32neAE+ny
         ZK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUqUy5aXzM7x5TkWSCnYgWDsZ2sawvSz0ieoGTz0b7o=;
        b=sRmRr+3mQW1ZUtr3TPfMxOx65Y6cbI+Ru5lfnD6puC+53PPSfdyWYWHvszOVhu7qGv
         sllTx6jxLVITe43peluIxD2/qzFfTy/39/+JHvXuHAmQfCAqpc2eFzguQxVI1fOESZgw
         EVdjfhR5RUWWd57JBH4w1e/vD5tvulogzomvkWFNKL690RFfk4GDkmNK4GyB2mo89ssg
         n8BBUQGb14YQE0P59PSCbtRdnHrKSceu2YVWYs/SEYSwb7s30iZBgj70ca3p2icK3Y3d
         Dy4ynOYCgwn+9hNebKNUCLF9I9LxZYczLBQPicbxb603EECHiKHjDKTzjrttoXFdDEVW
         1T1w==
X-Gm-Message-State: AAQBX9d9KXXVgShiCmaPq1xNwCR/YNabC8uqCRPKJB1Uqtl4DGT4c9BW
        DnlQvW0bLSKb9wk+mNWGWsxn2Oy3Qk4=
X-Google-Smtp-Source: AKy350b485YMS888UHx+t+vmCvXAheSSugvbCaWsEM6rIhxdz6e7c4a9HotyLR9eYwt+RAb6XSbPaQ==
X-Received: by 2002:ac2:43ca:0:b0:4e8:50e8:b96d with SMTP id u10-20020ac243ca000000b004e850e8b96dmr1282935lfl.39.1679729207879;
        Sat, 25 Mar 2023 00:26:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id i17-20020ac25231000000b004eafa77e435sm1158704lfl.146.2023.03.25.00.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 00:26:47 -0700 (PDT)
Message-ID: <f43a3820-12f1-0b0d-cc77-c8caf6b35d90@gmail.com>
Date:   Sat, 25 Mar 2023 09:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
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
 <a02044e7-3210-a0c2-ceda-8c19fadd237a@gmail.com>
 <CABVgOSmSEYRqxTXCEttZvpE33euxvRYE-3scZ8DrOSibeZW=bg@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CABVgOSmSEYRqxTXCEttZvpE33euxvRYE-3scZ8DrOSibeZW=bg@mail.gmail.com>
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

On 3/25/23 06:35, David Gow wrote:
> On Fri, 24 Mar 2023 at 18:17, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> On 3/24/23 12:05, Matti Vaittinen wrote:
>>> On 3/24/23 11:52, David Gow wrote:
>>>> On Fri, 24 Mar 2023 at 14:51, Matti Vaittinen
>>>> <mazziesaccount@gmail.com> wrote:
>>>>>
>>>>> On 3/24/23 08:34, David Gow wrote:
>>>>>> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen
>>>>>> <mazziesaccount@gmail.com> wrote:
>>>
>>>>>> I think that sounds like a good strategy for now, and we can work on a
>>>>>> set of 'generic helpers' which have an associated bus and struct
>>>>>> kunit_device in the meantime. If we can continue to use
>>>>>> root_device_register until those are ready, that'd be very convenient.
>>>>>
>>>>> Would it be a tiny bit more acceptable if we did add a very simple:
>>>>>
>>>>> #define kunit_root_device_register(name) root_device_register(name)
>>>>> #define kunit_root_device_unregister(dev) root_device_unregister(dev)
>>>>>
>>>>> to include/kunit/device.h (or somesuch)
>>>>>
>>>>> This should help us later to at least spot the places where
>>>>> root_device_[un]register() is abused and (potentially mass-)covert them
>>>>> to use the proper helpers when they're available.
>>>>>
>>>>
>>>> Great idea.
>>>>
>>>> The code I've been playing with has the following in
>>>> include/kunit/device.h:
>>>>
>>>> /* Register a new device against a KUnit test. */
>>>> struct device *kunit_device_register(struct kunit *test, const char
>>>> *name);
>>>> /* Unregister a device created by kunit_device_register() early (i.e.,
>>>> before test cleanup). */
>>>> void kunit_device_unregister(struct kunit *test, struct device *dev);
>>>>
>>>> If we used the same names, and just forwarded them to
>>>> root_device_register() and root_device_unregister() for now
>>>> (discarding the struct kunit pointer), then I expect we could just
>>>> swap out the implementation to gain the extra functionality.
>>
>> There's one thing though. If the goal is to do a direct replacement and
>> if automatic device deletion upon test completion / test abort is
>> planned - then it should be there also for these initial wrappers.
>>
> 
> Yeah, that's an excellent point. It's a pretty subtle change in
> behaviour to suddenly introduce that, so changing it behind the scenes
> is probably unwise.
> 
>> If these wrappers don't yet include the automatic device clean-up - then
>> it probably makes more sense to just do the kunit_root_device_* defines
>> because the tests are likely to need removing the explicit device
>> clean-ups when proper APIs are finished.
>>
> 
> I sent out my prototype implementation of this here, which does do the
> automatic cleanup:
> https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/T/#mf797239a8bce11630875fdf60aab9ed627add1f0
> 
> It's probably overkill to squeeze into your patch series, though,
> given it also adds and uses a whole new kunit_defer() API.

Thanks for letting me know. I did also prepare this commit yesterday:
https://github.com/M-Vaittinen/linux/commit/b784a90f8cc64ff83e802ec818e662fae1d0c264

It does use the existing kunit resources for clean-up. I am not sure if 
it is worth a shot or should I just drop it and use the root-device API 
for now. Any educated opinions on that? :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

