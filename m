Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B6E6C6601
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWLAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCWLAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 07:00:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4710411;
        Thu, 23 Mar 2023 04:00:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br6so27122459lfb.11;
        Thu, 23 Mar 2023 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679569229;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhgaXnoFQYfR1j7Dc6foxNzXPnSyFAAXMgSYay3WrLk=;
        b=ey9bSKQclIG6iwUzhcWkN9niFX0lQv/AuX8whFxeOdF/WNtFNVnwV5QVJXJYdboRxU
         L9aRS4+8tHJnzgG70kjEvw7l1qu6gb7li2OzqK67PjZeFQaxNhtxnhTGNk2efniSuA4o
         EG+YC7m5bAoz3UkcjKhOjQ2HU2pyzSd7wCBZ8cJkQo/K7A4HQDNdylaesV6kTeixSbni
         s+LKns3XysNjbshB4RDNUdfFsBhKtfnJX6jEbDAdqG+Lai2ljAxwq0lSnLldvYWaszgy
         znTX+EJzpZQzNKL34P/qccHCsNXecaUiau/pVKv7PEXeVeeLvb0bLHfZuawL1w4vhCIJ
         eiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569229;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhgaXnoFQYfR1j7Dc6foxNzXPnSyFAAXMgSYay3WrLk=;
        b=gvIF2G7oiVMt122iaLyJhf65Bo2DPe1suINllHbfFmvX7GglHjN1Et5K9vnRQoPB7r
         cBYVP5smyWzjBDKhd07CIY8ZnYDeVQkf8UsXsbefaoLmhq1uhIPkp0C234m8H2LDmsoe
         ABk+xXzCe6qH2ZkQLlwJvcF8dJFXqO5wP55YmHXSUUje+bHsosYEVmt6IjMumgAms3dZ
         Fd6BZr929aYCRrJPVrnPDkr5ixQ3U6PLSrtmGj9hg0GU12yNM9049/0zs9DDD+/3u6e+
         +g54yZsLPpqE+ScBdJJiX8dYClmhih4qM3fzFU5BJD4ryy7G+JTxyW98EMZDNTK0IaiH
         lsSQ==
X-Gm-Message-State: AO0yUKWIlLKzAMqbDudT+u3JSoSqksDE3Tsal6viwnX+u4FMLTmN0TXu
        1K2IpqDRfSdJhHBKnhmAVfc=
X-Google-Smtp-Source: AK7set/DGFOMZ2ej8yISjoeVXeEWBsKlYEq+58IK3fQLcaUlF2R2qowgDqVhKtH0q/ySq9iR7CdvPw==
X-Received: by 2002:a19:7606:0:b0:4e8:49c7:b3d2 with SMTP id c6-20020a197606000000b004e849c7b3d2mr3067790lff.19.1679569228997;
        Thu, 23 Mar 2023 04:00:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e9a8f000000b002986d2069d4sm2943652lji.82.2023.03.23.04.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 04:00:28 -0700 (PDT)
Message-ID: <f1390b01-c77e-3f67-acfc-7434f87d4856@gmail.com>
Date:   Thu, 23 Mar 2023 13:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
 <ZBwUp/fRIjQZtjF7@kroah.com> <91c8dc84-8eae-15d9-3d55-976c2c806421@gmail.com>
 <ZBwpfRGoXT/0sxlU@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBwpfRGoXT/0sxlU@kroah.com>
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

On 3/23/23 12:27, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 12:01:15PM +0200, Matti Vaittinen wrote:
>> On 3/23/23 10:58, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
>>>> On 3/22/23 20:57, Greg Kroah-Hartman wrote:
>>>>> On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Thanks for looking at this.
>>>>>>
>>>>>> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
>>
>>>>>> The biggest thing for me is that I don't like the idea of creating own 'test
>>>>>> device' in <add subsystem here> while we already have some in DRM (or
>>>>>> others). Thus, I do see value in adding generic helpers for supporting
>>>>>> running KUnit tests on devm_* APIs. Hence it'd be good to have _some_
>>>>>> support for it.
>>>>>
>>>>> I agree, let's use a virtual device and a virtual bus (you can use the
>>>>> auxbus code for this as that's all there for this type of thing)
>>>>
>>>> Hm. The auxiliary_devices require parent. What would be the best way to
>>>> deal with that in KUnit tests?
>>>
>>> If you use NULL as the parent, it goes into the root.
>>
>> As far as I read this is not the case with auxiliary devices. Judging the
>> docs they were intended to be representing some part of a (parent) device. I
>> see the auxiliary_device_init() has explicit check for parent being
>> populated:
>>
>> int auxiliary_device_init(struct auxiliary_device *auxdev)
>> {
>>          struct device *dev = &auxdev->dev;
>>
>>          if (!dev->parent) {
>>                  pr_err("auxiliary_device has a NULL dev->parent\n");
>>                  return -EINVAL;
>>          }
> 
> Yes as it wants to "split" a device up into smaller devices.  So make a
> real device that it can hang off of.

Yep. This is what led me to the root_device_register()... :rolleyes: And 
seein the root-device alone could do what I need - adding auxiliary 
device on top of it just for the sake of adding one seems a bit of an 
over-engineering to me :)

>> As I wrote in another mail, I thought of using a root_device for this IIO
>> test as was suggested by David. To tell the truth, implementing a kunit bus
>> device is starting to feel a bit overwhelming... I started just adding a
>> driver for a light sensor, ended up adding a helper for IIO gain-time-scale
>> conversions and I am slightly reluctant to going the extra-extra mile of
>> adding some UT infrastructure in the context of this driver work...
> 
> I think it is worth it as the driver core has no tests.  So it obviously
> must be correct, right?  :)

Doh. Greg, I hate you :) How could one argue with something like this? I 
think I will submit the v6 with the root_device_register() due to the 
aux-device requiring it in any case. I know that will end up to your 
table still as IIO is going through your hands anyways.

I will however take a look at what Maxime said about devm unwinding not 
being done w/o a bus because I think I saw the unwinding done in these 
IIO tests even when using the root_device_register() 
root_device_unregister(). If the unwinding really is not done, then I 
will come back to this auxiliary device rehearsal

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

