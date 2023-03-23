Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688BD6C61E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjCWIhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCWIgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:36:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9D113E0;
        Thu, 23 Mar 2023 01:35:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g17so26706346lfv.4;
        Thu, 23 Mar 2023 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679560522;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pdHeu+OYwfQcrXeWqWzkN8CDOChWPoZiGOZF4nIm0A=;
        b=DsX75UTzxRHECZs2WpbGcMH6vdbNKlxQrpx7j251FgVPfcUxTI0nzy7pJU9R29QHtM
         H2MBbUTI1/WbMdOEGEaMy8sYwSwBbFkxA3eiFoLOH6TaIyLnPTCVbq8UKdFpmqf/z7Sd
         Yc59a1fOIR9qfPaCKQ+b7pmRdv3eUXH2KAW6x36mekrIeH5wDv3JR4RANmcM+XKuhXcL
         E+v7YYcslAGhC3XaO+ByNPAJ8rY4u6EIXHzUKnf7gwK3bt4nIqx96s759Cfci5gP5QPx
         N/117rBU7QkKbJCq2vBejHZTf/ZCFMipWFgBDBDAdv7BowUb/uujSx+paaOCjwgJ7woJ
         OLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560522;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pdHeu+OYwfQcrXeWqWzkN8CDOChWPoZiGOZF4nIm0A=;
        b=Tlmu+m+QgF1ME2AhlyOhdMvs6yeoBUz66M3Qgta5FTcJngb6+EaPpUyEbrVgVhtaBE
         hkTF75kXobpOLb2MIcwZ9/nIh5XMNKHas9p4VW88NVhdAkJ4iz/6yE5Q7RBNHi2OEnLW
         G0G+/hh5buBjkaCFiG0a/3r5PoHixn6uBnITgIJ+jRVTUszz5nJhtxPsfGsEHxsp0fyx
         uOyltUOaRapux9aD41yLw1QNh3gHkIuUU8RlN3TLF4oCBUmQ4gJsNp54MsiJxcep4aO3
         8qC7U15sLs5qD3nuc6NLXYM3d9dEu9h4aXuObt+26/537JZZxAVxfl6ta6bHjcQbeqAU
         e97A==
X-Gm-Message-State: AO0yUKXbljObCEzWHEQr62thhl3MWqoxmLLjEwtsBHFrhspLp2hjbiE+
        vMq4icKFoJu1lhUM2e3eXYg=
X-Google-Smtp-Source: AK7set8VNOo83bSdDXG/Hxdx4b5KY0z1mnf9aus7ahe0kRA877L5/FaHgiiAc6QcagfZ4hI67Ca2yg==
X-Received: by 2002:ac2:4a71:0:b0:4d2:c70a:fe24 with SMTP id q17-20020ac24a71000000b004d2c70afe24mr3248939lfp.1.1679560522469;
        Thu, 23 Mar 2023 01:35:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e854e000000b00299ab2475ebsm2905981ljj.1.2023.03.23.01.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:35:22 -0700 (PDT)
Message-ID: <9d46a37d-21fe-328f-18b0-e5435756aeef@gmail.com>
Date:   Thu, 23 Mar 2023 10:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
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

Hi David, all,

On 3/23/23 09:30, David Gow wrote:
> On Wed, 22 Mar 2023 at 17:06, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> The creation of a dummy device in order to test managed interfaces is a
>> generally useful test feature. The drm test helpers
>> drm_kunit_helper_alloc_device() and drm_kunit_helper_free_device()
>> are doing exactly this. It makes no sense that each and every component
>> which intends to be testing managed interfaces will create similar
>> helpers so stole these for more generic use.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Changes:
>> v4 => v5:
>> - Add accidentally dropped header and email recipients
>> - do not rename + move helpers from DRM but add temporary dublicates to
>>    simplify merging. (This patch does not touch DRM and can be merged
>>    separately. DRM patch and IIO test patch still depend on this one).
>>
>> Please note that there's something similar ongoing in the CCF:
>> https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
>>
>> I do like the simplicity of these DRM-originated helpers so I think
>> they're worth. I do equally like the Stephen's idea of having the
>> "dummy platform device" related helpers under drivers/base and the
>> header being in include/kunit/platform_device.h which is similar to real
>> platform device under include/linux/platform_device.h
>> ---
> 
> Thanks for sending this my way.
> 
> It's clear we need some way of creating "fake" devices for KUnit
> tests. Given that there are now (at least) three different drivers
> looking to use this, we'll ultimately need something which works for
> everyone.
> 
> I think the questions we therefore need to answer are:
> - Do we specifically need a platform_device (or, any other specific
> device struct), or would any old struct device work? I can see why we
> would need a platform device for cases where we're testing things like
> device-tree properties (or, in the future, having e.g. USB-specific
> helpers which create usb_device). Most tests just use
> root_device_register() thus far, though.

Funny timing. I just found the root_device_register() while wondering 
the parent for auxiliary_devices.

I think the root_device_[un]register() meets my current needs.

> - What helpers do we need to make creating, using, and cleaning up
> these devices as simple as possible.
> 
> I think that in this particular case, we don't actually need a struct
> platform_device. Replacing these helpers with simple calls to
> root_device_register() and root_device_unregister() seems to work fine
> with this patch series for me. (It does break the
> drm_test_managed_run_action test, though.) So I don't think having
> these helpers actually help this series at the moment.

I am afraid that further work with these helpers is out of the scope for 
me (at least for now). I'll drop the DRM and the helper patches from 
this series && go with the root_device_register(), 
root_device_unregister() in the IIO tests added in this series.

> That being said, if they used the KUnit resource system to
> automatically clean up the device when the test is finished (or
> otherwise exits),

My 10 cents to this is that yes, automatic unwinding at test exit would 
be simple - and also correct for most of the time. However, I think 
there might also be tests that would like to verify the unwinding 
process has really managed to do what it was intended to do. That, I 
think would require being able to manually drop the device in the middle 
of the test.

> So, I guess we have three cases we need to look at:
> - A test just needs any old struct device. Tests thus far have
> hardcoded, or had their own wrappers around root_device_register() for
> this.

As said above, my case fits this category.

> - A test needs a device attached to a bus (but doesn't care which
> bus). Thus far, people have used struct platform_device for this (see
> the DRM helpers, which use a platform device for managed resource
> tests[2]). Maybe the right solution here is something like a struct
> kunit_device?

This sounds like, how to put it, "architecturally correct". But...

> - A test needs a device attached to a specific bus. We'll probably
> need some more detailed faking of that bus. This covers cases like
> having fake USB devices, devicetree integration, etc.

...if we in any case need this, wouldn't the kunit_device just be 
unnecessary bloat because if the test does not care which bus it is 
sitting in, then it could probably use a bus-specific device as well?

> I'd suggest that, for the majority of cases which only care about the
> first case, let's just use root_device_register() directly,

After finding the root_device_register() - I agree.

> or have a
> thin wrapper like the old root_device-based version of the DRM
> helpers[3]. This will probable serve us well enough while we work out
> how to handle the other two cases properly (which is already being
> looked at for the CLK/DeviceTree patches and the DRM stuff).
> 
> If the resulting helpers are generally useful enough, they can
> probably sit in either drivers/base or lib/kunit. I'd rather not have
> code that's really specific to certain busses sitting in lib/kunit
> rather than alongside the device/bus code in drivers/base or some
> other subsystem/driver path, but I can tolerate it for the very
> generic struct device.
> 
> Regardless, I've left a few notes on the patch itself below.

Thanks but I guess I'll just drop this one :)

> 
> Cheers,
> -- David
> 
> [1]: https://kunit-review.googlesource.com/c/linux/+/5434/3/include/kunit/resource.h
> [2]: https://lore.kernel.org/all/20221123-rpi-kunit-tests-v3-8-4615a663a84a@cerno.tech/
> [3]: https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/tests/drm_kunit_helpers.c#L39

Thanks for the thorough analysis and these links! This was enlightening :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

