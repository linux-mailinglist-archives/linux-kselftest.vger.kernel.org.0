Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65186C644D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCWKBf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCWKBX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:01:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678112CF6;
        Thu, 23 Mar 2023 03:01:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi9so26915737lfb.12;
        Thu, 23 Mar 2023 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679565677;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2cd905ZoLiKel3mCZ0Fwtfw+cLv261/aTIvnI8JCEU=;
        b=a1Dor71CR8r5pF15Szq6H8LfViMKitHFgFKoc86TbtGlaa+WD8YMRXRtsxo/6P3mN0
         JkKzTiHEzQhyk0jGfvmJY0i0IpGcrH4qTgVQgQ8pwLR2LDeCuVDCpef/hh0dkj68wB8y
         kVQLQpTut9gyf8ZQ4wWLUM1XlEh5admmvpgcXMEYrm6gm2xRtCorxLIUkv4/FdB7u1J1
         DIN4HADbbKtTX4052tV2V4UZScnYVhaoIdq36Ftd6YCZcUt+Rhq5veuVCR4QZXHAkvS0
         Us1dv6KNYyGyhx/ACSEGUicECBy9QGLk7mXJcpwEHTYDo4S/BN8TYpUhmzNjZ8Pd3bs6
         pbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679565677;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2cd905ZoLiKel3mCZ0Fwtfw+cLv261/aTIvnI8JCEU=;
        b=6mrfjIjph0f/v+ocBZopiF/Ace9PiqR4xK44+uj3BasXOMtnrqqHTznPIHUvqJnDnw
         ggk/TIBfyTXPasDsELLD5EetOPTVkwXCvPwll8DowY5QXJJ0d2SF8arAlzHfZDfi8Gba
         /oy2GMSOTTICyZWxJU0i2c36jvPvoN3kqpMH0nazN50+FjCyuoMP8FdeRDTqvN6tcAHT
         7DFFaxchvolqS5Dq87Qo5SQAvskPXveM0wZWoNgczCdRSWDQxNMsNmebqHGUbzUT6kXt
         GB0ImDh8EZFkTfciyT0qLFlwkxiLEUl8wk8JSvX5xTDxL0nCksyy9qBDCmt8CcTRT2Fz
         7Hpw==
X-Gm-Message-State: AO0yUKWJMb4/F3bWpzTdfXVoK4xJyDCiNFVdkNn45ZCjnNiv6TeeVKhI
        NemxlXJQTjzRLMwQxSuNH7A=
X-Google-Smtp-Source: AK7set8lP9RoZ40YO56sP/zWLegHq3ygSgjiUnuEVmsgugWLm/m57lN8YNiApRh6AI2bqSUL3lm1ow==
X-Received: by 2002:ac2:5d45:0:b0:4dd:b479:1c9b with SMTP id w5-20020ac25d45000000b004ddb4791c9bmr2336138lfd.26.1679565676817;
        Thu, 23 Mar 2023 03:01:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id v18-20020a056512097200b004db4c79d845sm2861272lft.184.2023.03.23.03.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:01:16 -0700 (PDT)
Message-ID: <91c8dc84-8eae-15d9-3d55-976c2c806421@gmail.com>
Date:   Thu, 23 Mar 2023 12:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
 <ZBwUp/fRIjQZtjF7@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBwUp/fRIjQZtjF7@kroah.com>
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

On 3/23/23 10:58, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
>> On 3/22/23 20:57, Greg Kroah-Hartman wrote:
>>> On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
>>>> Hi Greg,
>>>>
>>>> Thanks for looking at this.
>>>>
>>>> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
>>>>> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:

>>>> The biggest thing for me is that I don't like the idea of creating own 'test
>>>> device' in <add subsystem here> while we already have some in DRM (or
>>>> others). Thus, I do see value in adding generic helpers for supporting
>>>> running KUnit tests on devm_* APIs. Hence it'd be good to have _some_
>>>> support for it.
>>>
>>> I agree, let's use a virtual device and a virtual bus (you can use the
>>> auxbus code for this as that's all there for this type of thing)
>>
>> Hm. The auxiliary_devices require parent. What would be the best way to
>> deal with that in KUnit tests?
> 
> If you use NULL as the parent, it goes into the root.

As far as I read this is not the case with auxiliary devices. Judging 
the docs they were intended to be representing some part of a (parent) 
device. I see the auxiliary_device_init() has explicit check for parent 
being populated:

int auxiliary_device_init(struct auxiliary_device *auxdev)
{
         struct device *dev = &auxdev->dev;

         if (!dev->parent) {
                 pr_err("auxiliary_device has a NULL dev->parent\n");
                 return -EINVAL;
         }

As I wrote in another mail, I thought of using a root_device for this 
IIO test as was suggested by David. To tell the truth, implementing a 
kunit bus device is starting to feel a bit overwhelming... I started 
just adding a driver for a light sensor, ended up adding a helper for 
IIO gain-time-scale conversions and I am slightly reluctant to going the 
extra-extra mile of adding some UT infrastructure in the context of this 
driver work...

Well, let's see. Maybe I change my mind after a good night's sleep :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

