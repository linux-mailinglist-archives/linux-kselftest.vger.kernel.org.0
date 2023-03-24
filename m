Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654706C77AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 07:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXGMB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 02:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCXGL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 02:11:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D828EBF;
        Thu, 23 Mar 2023 23:11:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so615991ljd.5;
        Thu, 23 Mar 2023 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679638314;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM/9ztoT/B4vUWoqEtcJ/mBDI2hPUMi+qwBObmjPQnQ=;
        b=I6UJLmx6Bf0+CI05WH88vDbAkVgJPlajuRALVs65+1+IFQaF9Knc4le70YBQVIWyLn
         9liQd33uH0AG67yf86+nTBHUBgVSzMzmss6F4llgG258fYkjCi+wk8REFNRv3Dtu4zwi
         MPq19p3kWOUtt9NCoIx1IaJWNAVuOe0FMfxEU6rof9M/H9Q0GPK0muKLWVy63HSGFBpt
         vz0KywUi/2mjVgfB74N6KsG29KkCo9QrmopQMtLxdnxzhweMokkluvpzXL/DJ9qGTv5F
         9dFkIBfgHnIJrJ/NlKszbELNG3194tzy+6Bh80axEwpHh2bcZMoVW0A/V3oqpO6st/Qy
         MLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679638314;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM/9ztoT/B4vUWoqEtcJ/mBDI2hPUMi+qwBObmjPQnQ=;
        b=im2hhMX56AVjUkn8SYyMM7h628jksJkSdPgic+XKUc58QoLHzWTF5l2OBrUJCxY1iY
         E472s2jTjRMfkDmOOid0EKj3r4rBzkrpB2t7W9fS5eqP3weVr+Qz/UtNBZs7ycPnfvKW
         4IwLLknt3lFnmSLH6Od5PIE6N4IQoFKZlg8osCTpxaN4/GhV5CYOoIlCbQbGpUszQnxI
         w4WKTREAU5ARVDxSzXo9+WW/BqWh2b/cTTAFsmq4mG51tOxg08YeDD+IHY3+XTB4/xc7
         r3oyQb41ymUMItb3bUSqPQ3JtyFmv14Q1Ap4Y7BClllY4V44FY3MMmdyu+5P+Xrqp0aI
         1W/w==
X-Gm-Message-State: AAQBX9ey6Nhy/pCRoBOnV8LRqh6fi4s3GSvYrDwHU/YEVaVOVFdKpfo6
        d7m5MK9/PcOO9zfskSul4uc=
X-Google-Smtp-Source: AKy350ZATp3UfRcfJoro0cY3guZd4fxEMIqWmM6sagwQ40dD1ww55fSE7zN736oc11T3YWTg5oERcg==
X-Received: by 2002:a2e:6a0d:0:b0:29f:199e:f6de with SMTP id f13-20020a2e6a0d000000b0029f199ef6demr439764ljc.47.1679638313914;
        Thu, 23 Mar 2023 23:11:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id a14-20020a2e88ce000000b002935f85760bsm3266638ljk.71.2023.03.23.23.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 23:11:53 -0700 (PDT)
Message-ID: <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
Date:   Fri, 24 Mar 2023 08:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <20230323163639.xtwpid2uunwnzai4@houat>
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

On 3/23/23 18:36, Maxime Ripard wrote:
> On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
>> On 3/23/23 14:29, Maxime Ripard wrote:
>>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
>>>
>>> This is the description of what was happening:
>>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
>>
>> Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
>> when root_device_register() is used is not because root_device_unregister()
>> would not trigger the unwinding - but rather because DRM code on top of this
>> device keeps the refcount increased?
> 
> There's a difference of behaviour between a root_device and any device
> with a bus: the root_device will only release the devm resources when
> it's freed (in device_release), but a bus device will also do it in
> device_del (through bus_remove_device() -> device_release_driver() ->
> device_release_driver_internal() -> __device_release_driver() ->
> device_unbind_cleanup(), which are skipped (in multiple places) if
> there's no bus and no driver attached to the device).
> 
> It does affect DRM, but I'm pretty sure it will affect any framework
> that deals with device hotplugging by deferring the framework structure
> until the last (userspace) user closes its file descriptor. So I'd
> assume that v4l2 and cec at least are also affected, and most likely
> others.

Thanks for the explanation and patience :)

> 
>> If this is the case, then it sounds like a DRM specific issue to me.
> 
> I mean, I guess. One could also argue that it's because IIO doesn't
> properly deal with hotplugging.

I must say I haven't been testing the IIO registration API. I've only 
tested the helper API which is not backed up by any "IIO device". (This 
is fine for the helper because it must by design be cleaned-up only 
after the IIO-deregistration).

After your explanation here, I am not convinced IIO wouldn't see the 
same issue if I was testing the devm_iio_device_alloc() & co.

> I'm not sure how that helps. Those are
> common helpers which should accommodate every framework,

Ok. Fair enough. Besides, if the root-device was sufficient - then I 
would actually not see the need for a helper. People could in that case 
directly use the root_device_register(). So, if helpers are provided 
they should be backed up by a device with a bus then.

> and your second
> patch breaks the kunit tests for DRM anyway.

Oh, I must have made an error there. It was supposed to be just a 
refactoring with no functional changes. Sorry about that. Anyways, that 
patch can be forgotten as Greg opposes using the platform devices in 
generic helpers.

>> Whether it is a feature or bug is beyond my knowledge. Still, I would
>> not say using the root_device_[un]register() in generic code is not
>> feasible - unless all other subsytems have similar refcount handling.
>>
>> Sure thing using root_device_register() root_device_unregister() in DRM does
>> not work as such. This, however, does not mean the generic kunit helpers
>> should use platform_devices to force unwinding?
> 
> platform_devices were a quick way to get a device that would have a bus
> and a driver bound to fall into the right patch above. We probably
> shouldn't use platform_devices and a kunit_device sounds like the best
> idea, but the test linked in the original mail I pointed you to should
> work with whatever we come up with. It works with multiple (platform,
> PCI, USB, etc) buses, so the mock we create should behave like their
> real world equivalents.
Thanks for the patience and the explanation. Now I understand a generic 
test device needs to sit on a bus.

As I said, in my very specific IIO related test the test device does not 
need a bus. Hence I'll drop the 'generic helpers' from this series.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

