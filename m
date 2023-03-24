Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A66C7C33
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 11:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCXKFV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCXKFU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 06:05:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5171C7DA;
        Fri, 24 Mar 2023 03:05:17 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h9so1136748ljq.2;
        Fri, 24 Mar 2023 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679652315;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1TdhMKIxAO9718z/MG/SMpXLVDcRq3DxeQ0go+1GVk=;
        b=RaLPMMFOyaI9u8rXGs0GTWVtWsWGaGWiknbmvXNAyp1jvuaq02QNOtzfoG/9zL8hfG
         NTE2EJO+C4FO5KR6p6SoS9JhYJxgS3UUTy06LVP1Xk/gio6G2gLUtnKAZQAEJSlX1AiO
         lo58C74R5ASAxTd0dFFtxt/V8YQXRC+SQWK3A8UwbnzTGTSEUf+J92PTILDVD+cknn+U
         GhnoHc1hwDS6SPcBf1rliwymo6FsPhlCB4wmx9NELGbAtoGSjNQSPWs2sMk7QXlXqqKL
         J42HzuQ129aA0BklN+546KpN4Y15rDA8zcfmdj2Gbz3zh+CaYlRmPTbpJ7Qj5+MLdc2v
         +SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652315;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1TdhMKIxAO9718z/MG/SMpXLVDcRq3DxeQ0go+1GVk=;
        b=scQ4YNLR13Ua2ZB1U0qB6SL2eCwrpgIX8eRlJUE3hsDFe3NcKld+Olw4MdIiTBgZDJ
         kbo4heMa4nHv9qtwfHqctwy1gtl+bhuIvZK5DISoEbbqxNS976vadTotb31HA7KF9Jcl
         hl8IAcEEAMGB9GGQ1wTpP4fozkxOzDV7vRfYhWHqRAMOcJDxOFzKb7rtDTFtG+hlcwsX
         S9aMNnGWZD7RPsCb18iCJl6ySLqyCC7AJpVoEPOfJPHlXPYiqLIp0IBsgBepGkuUo/J6
         s5JohBl7aZKOD9s2miavi8gB7SeQVPlcDFM/Z7d1vj4l1J1DrbXsIDaKlSihYnGbJd30
         gZBg==
X-Gm-Message-State: AAQBX9fHwqvxHIve6H8MB2iJyI2FgV/kJvzC9GYioZMD49ijW47bw4D+
        OBgPZZOsn34e4YXcMl3q4BoQbRjvIGs=
X-Google-Smtp-Source: AKy350Zx09Ki/Sp1KZWA7H1zcrTR/ZS+UGfKahGeRe+9TdvD6XhcdClepCZ3uAy2zG/K0dznr+llOQ==
X-Received: by 2002:a2e:7003:0:b0:29d:286a:4502 with SMTP id l3-20020a2e7003000000b0029d286a4502mr665455ljc.23.1679652315182;
        Fri, 24 Mar 2023 03:05:15 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id z21-20020ac24195000000b004dc4b00a1eesm3315584lfh.261.2023.03.24.03.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:05:14 -0700 (PDT)
Message-ID: <f0b4d2ad-9635-9ab8-7cd7-bfadded94714@gmail.com>
Date:   Fri, 24 Mar 2023 12:05:14 +0200
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <CABVgOSmx3A4Vwos2_8xO-XQrQAw5gvY0nc5zLpLmcJ7FtA-dTQ@mail.gmail.com>
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

On 3/24/23 11:52, David Gow wrote:
> On Fri, 24 Mar 2023 at 14:51, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> On 3/24/23 08:34, David Gow wrote:
>>> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen <mazziesaccount@gmail.com> wrote:

>>> I think that sounds like a good strategy for now, and we can work on a
>>> set of 'generic helpers' which have an associated bus and struct
>>> kunit_device in the meantime. If we can continue to use
>>> root_device_register until those are ready, that'd be very convenient.
>>
>> Would it be a tiny bit more acceptable if we did add a very simple:
>>
>> #define kunit_root_device_register(name) root_device_register(name)
>> #define kunit_root_device_unregister(dev) root_device_unregister(dev)
>>
>> to include/kunit/device.h (or somesuch)
>>
>> This should help us later to at least spot the places where
>> root_device_[un]register() is abused and (potentially mass-)covert them
>> to use the proper helpers when they're available.
>>
> 
> Great idea.
> 
> The code I've been playing with has the following in include/kunit/device.h:
> 
> /* Register a new device against a KUnit test. */
> struct device *kunit_device_register(struct kunit *test, const char *name);
> /* Unregister a device created by kunit_device_register() early (i.e.,
> before test cleanup). */
> void kunit_device_unregister(struct kunit *test, struct device *dev);
> 
> If we used the same names, and just forwarded them to
> root_device_register() and root_device_unregister() for now
> (discarding the struct kunit pointer), then I expect we could just
> swap out the implementation to gain the extra functionality.
> 
> It's a little less explicit, though, so I could see the value in using
> macros with "root_device" in the name to make the current
> implementation clearer, and the eventual change more obvious.

I think it makes sense to avoid the mass-conversions if the signatures 
for kunit_device_register() and kunit_device_unregister() are expected 
to be known by now. If there is no objections I'll add those wrappers + 
the include/kunit/device.h to v6 of this series.

I think I'll try to hold back sending the v6 until next Monday - unless 
I get really bored during the weekend ;)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

