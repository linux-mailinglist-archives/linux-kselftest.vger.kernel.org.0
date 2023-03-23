Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4866C67F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCWMRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 08:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCWMRR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 08:17:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACB26CEC;
        Thu, 23 Mar 2023 05:16:55 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h25so15765603lfv.6;
        Thu, 23 Mar 2023 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573813;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4FMFp8xZJkslMtqkMHvYjpvWPx8OtcUtmZPOURHrHs=;
        b=fCrEeeGxIrSJDv30dMQJ0t8W2AyzqNni2FqDtX9h5Hbc9Gn1UdD8yM3d1olg6bysBO
         g8RC83P9FLxsFjrQ4X21nlIRWAZM5cJ9Vq2ywYAqEzRPkKbRqQfAcNYEJC0xbWls1btN
         nA9+HGtPfpKE9EmueaRgdNJs4J2rP75tkcbiBi8SgJ8IC3zkUGorYS4fySTYlq3hpUQi
         hv7wHlNXUcfpqB32/5MtSENS+NZQGs9Vncd3SZnk7OpfsQfs/T3+VQca5zAwuWsHbXnx
         /mV/ZRQIYZKij5DnZ8N1H8qlhjyc7hxQpu8MxxVH2lrGCKD1itXx3osfSU6hJn7R5cUH
         sE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573813;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4FMFp8xZJkslMtqkMHvYjpvWPx8OtcUtmZPOURHrHs=;
        b=USwqPZFj/9Ff6p2+lE1nLhW+bFw1IDi9fAM9NgfekSncNEDUVXlGRa/17ZmxBzi938
         Vc5juVHo0DCjVwZLdFXRSDbBNaQiuYkO2YBa+TOECyLSy8W03eQJgB1hOMponH04kj2C
         ydeC+64W4iutFclanMkWmLPB2IhQabXUxntiadGysA+ldNpR7fGq56im61TzlTG4NkAX
         phiGURTAnAIZi1MGQGrIxVS0o+jwNHV9ScO6cDX4JkkbcVSGlO+q/EjFKpW8ser0wZIr
         mEWDpYi8lQOCRdoLpeRfqON2ekH2QB40c1I+doTxqRXPMMAiaqZMaIsaCqE4284PqJWa
         uklA==
X-Gm-Message-State: AO0yUKUcxqC1EqIzwHM2TL6kOJJdIVup1nxO6FA6yw9PrlTBidEwkt33
        PIRDjIr5cro49mdhVnB8LXo=
X-Google-Smtp-Source: AKy350abhup12ow4rSUua5TqFCwNGxYQ/ojoiRU+QQbRNNopwW7nh6q1tIGqklSZm8cBBLBhb6bEuw==
X-Received: by 2002:a05:6512:218d:b0:4ea:f6f2:7a7f with SMTP id b13-20020a056512218d00b004eaf6f27a7fmr1813648lft.34.1679573813329;
        Thu, 23 Mar 2023 05:16:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651203d000b004e843d6244csm2905060lfp.99.2023.03.23.05.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:16:53 -0700 (PDT)
Message-ID: <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
Date:   Thu, 23 Mar 2023 14:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBwoRgc2ICBJX/Lq@kroah.com>
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

Hi Maxime, all

On 3/23/23 12:21, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 11:12:16AM +0100, Maxime Ripard wrote:
>> On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
>>>>>> +/**
>>>>>> + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
>>>>>> + * @test: The test context object
>>>>>> + *
>>>>>> + * This allocates a fake struct &device to create a mock for a KUnit
>>>>>> + * test. The device will also be bound to a fake driver. It will thus be
>>>>>> + * able to leverage the usual infrastructure and most notably the
>>>>>> + * device-managed resources just like a "real" device.
>>>>>
>>>>> What specific "usual infrastructure" are you wanting to access here?
>>>>>
>>>>> And again, if you want a fake device, make a virtual one, by just
>>>>> calling device_create().
>>>>>
>>>>> Or are you wanting to do "more" with that device pointer than
>>>>> device_create() can give you?
>>>>
>>>> Personally, I was (am) only interested in devm_ unwinding. I guess the
>>>> device_create(), device_add(), device_remove()... (didn't study this
>>>> sequence in details so sorry if there is errors) could've been sufficient
>>>> for me. I haven't looked how much of the code that there is for 'platform
>>>> devices' should be duplicated to support that sequence for testability
>>>> purposes.
>>>
>>> Any device can access devm_ code, there's no need for it to be a
>>> platform device at all.
>>
>> Sure but the resources are only released if the device is part of a bus,
>> so it can't be a root_device (or bare device) either
> 
> The resources are not cleaned up when the device is freed no matter if
> it's on a bus or not?  If so, then that's a bug that needs to be fixed,
> and tested :)

This is strange. I just ran a test on a beaglebone black using Linux 
6.3.0-rc2 + the IIO patches we se here (but the IIO test patch modified 
to use the root_device_register() and root_device_unregister().

I passed the device pointer from root_device_register() to the 
devm_iio_init_iio_gts()

// snip
         dev = root_device_register(IIO_GTS_TEST_DEV);
         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
         if (IS_ERR_OR_NULL(dev))
                 return NULL;

         ret = devm_iio_init_iio_gts(dev, TEST_SCALE_1X, 0, g_table, num_g,
                                     i_table, num_i, gts);

  - and saw the tables for available scales allocated:

  if (gts.num_avail_all_scales)
                 pr_info("GTS: table allocation succeeded\n");
         else
                 pr_info("GTS: table allocation failed\n");

         pr_info("gts: num_avail_all_scales %d\n", 
gts.num_avail_all_scales);

(this printed:
[   52.132966]     # Subtest: iio-gain-time-scale
[   52.132982]     1..7
[   52.157455] GTS: table allocation succeeded
[   52.164077] gts: num_avail_all_scales 16

Next I unregister the root-device and check if the unwinding code which 
frees the tables and zeroes the scale count was ran:

         root_device_unregister(dev);
         pr_info("gts: num_avail_all_scales %d\n", 
gts.num_avail_all_scales);

         if (gts.num_avail_all_scales)
                 pr_info("devm unwinding not done\n");
         else
                 pr_info("devm unwinding succeeded\n");

Which printed:
[   52.168101] gts: num_avail_all_scales 0
[   52.171957] devm unwinding succeeded

I can send patch(es) just for testing this on other machines if someone 
want's to see if the lack of devm unwinding is somehow architecture 
specific (which sounds very strange to me) - although using this IIO 
series just for checking the unwinding is a bit of an overkill. I just 
happened to have these tests at my hands / in my tree for testing.

In any case, devm unwinding using root_device_[un]register() seems to 
"work on my machine".

Naxime, what was the environment where you observed lack of unwinding? 
(Huh, I am so afraid of sending this post out - I've experienced too 
many "Oh, boy - how I didn't notice THAT" moments in the past and maybe 
I am again overlooking something...)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

