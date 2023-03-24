Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F31E6C7837
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 07:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjCXGwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCXGwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 02:52:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DCD23110;
        Thu, 23 Mar 2023 23:51:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi9so907067lfb.12;
        Thu, 23 Mar 2023 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679640716;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk/ed4+XfFwEchqbdltoxfan+i9Te3TsmlJnxgT6m/Q=;
        b=ZhWAte9OqCboqs9hPe9W4JbP7vCYvUr3dH1GlAP0EQvX3lv5DXstw+oMS/mMNvRHpB
         /jvRunjWfuFu8F/ieXrJBBwk3UWR4S9+J3scR8+rzN1VMpsNnoI4PUHMLfpMKttCrE03
         UJA9wlR4WaZD8F+4MbA7b1xq7yr7KPkPnO7Dd1DxiDoHpXWRAfAM0gTQo8YVBuBlkRRk
         nkKa/36ItsxlXJl//8H73dOyHsGsFwnqx+u6ixSRMrrlfZovu0BQOFl5ZW+VpUKcOcmS
         cJSwEpDeWmZsiKgKjyI+ZEssU9OfhLFj/HlHFDKfNYhCQD16hgYOil5Y0srT/dXmKMTi
         w+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679640716;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk/ed4+XfFwEchqbdltoxfan+i9Te3TsmlJnxgT6m/Q=;
        b=q06QLlujqmkpJProlE75C688xacFk7WXGllsKUzOrqu4YZbsF9YQ22PNTnAw6Y6HdY
         O1VWSNor+a/eqKQKq45EBVq2NcA5Ti3TDVCVbQh2aGeahXGJ/G2i5NhCYU4NktO5gFtN
         vUCxZeJYvOQVVEX3WI6sJxnj6zJHvWg46X5VxPGKLMAwssStMDAQZFP143PQ8Yh/AcGc
         WvVhrbLp+N8A4Hie0s44oGgo65/rrO2JOSDLyI/SUWS+tUVC/arB7ht5xLfLOrMFqLMP
         jx62iS+fpwgh9CUiv+FT3xnbfFeKnXT6LR4ehUYX4k7Nf02EX6Wwj4n+By5EjrT88ID8
         cv7Q==
X-Gm-Message-State: AAQBX9f8Mkz0jFmFLGBAwbGFsarEMaTQeS/mgOKC2KCF9m7VraSWX1ci
        eIrG77PZ4ZwiC2o7Kw8V9uw=
X-Google-Smtp-Source: AKy350Z07gd+jV3lRuExt/8tE8Khn0RJCOm7TWFXoITIc3FummmamDEopfiXJOQHBc7jRJO7XApHVQ==
X-Received: by 2002:ac2:55b8:0:b0:4db:2cdf:4c12 with SMTP id y24-20020ac255b8000000b004db2cdf4c12mr372100lfg.43.1679640715818;
        Thu, 23 Mar 2023 23:51:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a05651211e200b004e83fbba141sm3211668lfs.164.2023.03.23.23.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:51:55 -0700 (PDT)
Message-ID: <97f60824-7067-62cc-2882-d998072886ce@gmail.com>
Date:   Fri, 24 Mar 2023 08:51:53 +0200
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
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

On 3/24/23 08:34, David Gow wrote:
> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> On 3/23/23 18:36, Maxime Ripard wrote:
>>> On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
>>>> On 3/23/23 14:29, Maxime Ripard wrote:
>>>>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:

>> Ok. Fair enough. Besides, if the root-device was sufficient - then I
>> would actually not see the need for a helper. People could in that case
>> directly use the root_device_register(). So, if helpers are provided
>> they should be backed up by a device with a bus then.
> 
> I think there is _some_ value in helpers even without a bus, but it's
> much more limited:
> - It's less confusing if KUnit test devices are using kunit labelled
> structs and functions.
> - Helpers could use KUnit's resource management API to ensure any
> device created is properly unregistered and removed when the test
> exits (particularly if it exits early due to, e.g., an assertion).

Ah. That's true. Being able to abort the test on error w/o being forced 
to do a clean-up dance for the dummy device would be convenient.

> I've played around implementing those with a proper struct
> kunit_device and the automatic cleanup on test failure, and thus far
> it -- like root_device_register -- works for all of the tests except
> the drm-test-managed one.
> 
> So if we really wanted to, we could use KUnit-specific helpers for
> just those tests which currently work with root_device_register(), but
> if we're going to try to implement a KUnit bus -- which I think is at
> least worth investigating -- I'd rather not either hold up otherwise
> good tests on helper development, or rush a helper out only to have to
> change it a lot when we see exactly what the bus implementation would
> look like.

It's easy for me to agree.

>> As I said, in my very specific IIO related test the test device does not
>> need a bus. Hence I'll drop the 'generic helpers' from this series.
>>
> 
> I think that sounds like a good strategy for now, and we can work on a
> set of 'generic helpers' which have an associated bus and struct
> kunit_device in the meantime. If we can continue to use
> root_device_register until those are ready, that'd be very convenient.

Would it be a tiny bit more acceptable if we did add a very simple:

#define kunit_root_device_register(name) root_device_register(name)
#define kunit_root_device_unregister(dev) root_device_unregister(dev)

to include/kunit/device.h (or somesuch)

This should help us later to at least spot the places where 
root_device_[un]register() is abused and (potentially mass-)covert them 
to use the proper helpers when they're available.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

