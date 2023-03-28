Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D675D6CC08E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjC1NWq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1NWp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 09:22:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD87285;
        Tue, 28 Mar 2023 06:22:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br6so15769538lfb.11;
        Tue, 28 Mar 2023 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009762;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e6hzu72dowoGBX7SULV30FXFNndxb6X/e6UQcdzccI=;
        b=m52tPZgyugHSriVGqtsrEaMwvAHvPdVNoFPqS2XyW951RpPrJxie9sWp8mzzqdMO7r
         q85Rvkkrunq/5OET9916/DZFrBC/E10qDAdOLMIVqhe0ZtA9mHpIMdhqb3OIJxfLxOR+
         3nTr6kS1YuQQ6zXzwUtw+R0Rdj/e16JxguTZ3DA5yJGe5HHQpgzcsNXDgC4kBS10LDxr
         iBi6cVJHQMXlW7uSMpnHZp5ST7x2AmAqTzspJtrg4zQztRtm55akAg7h5rSbQHuq8duJ
         ZBvuT8BCaeBATZPHlXtUQhuCvqRZcxnrNB0fNv8+vqOJvumXWeQASjrwuZ5lIXCd/EdO
         gf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009762;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e6hzu72dowoGBX7SULV30FXFNndxb6X/e6UQcdzccI=;
        b=6gBBubCIGt/jNrJYxLYRebHuetBXEL0v2vavK/+nl+7t/ClGLNLKP0wuihJ4GN/aWG
         MOn+FqU3iYR89koIvOQrXsW5GrYX+sCo+Fdt9WtGmlqNvPCztZ1d69OpEKkEoQxYYZcH
         XDq8QHcWSLKWvTsDytbMc+0eHBnIXRBdBiqmP0LYR8LyQS8I13zdGXs5FMZVFbNWYhtp
         rSvb1pJWjDhDLC9PiNoW8m1yzLNuJej7wM0Y7oQgsPO8xh3qcvZzdQ5DPpj60VCKhWEZ
         jx4o61D0i0EEiFaooFimfuQ4ZNrUhWaFdGNE/l1WPCt6l1Rm5vV7CW2S9Qkamef7rkj1
         mMig==
X-Gm-Message-State: AAQBX9ed2JOP8sPCwQGTXesA2KXB0WbjRu9goxMKYBS/BX7yrfLl08WV
        WuBOPG2aW5+bZw7gc2mniKE=
X-Google-Smtp-Source: AKy350bPyQayaZ2agMiFg4NkWQ/BywBUB/RCVmAfCsHPD52OyXEIDUY1RCwdZULvYIkYMvKcY0Cl5Q==
X-Received: by 2002:ac2:519c:0:b0:4e9:8cae:c620 with SMTP id u28-20020ac2519c000000b004e98caec620mr5343204lfi.61.1680009761810;
        Tue, 28 Mar 2023 06:22:41 -0700 (PDT)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p15-20020a2ea40f000000b00295a8d1ecc7sm5091282ljn.18.2023.03.28.06.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:22:41 -0700 (PDT)
Message-ID: <e9619a2a-b6c8-e7f9-6018-45541608d0c5@gmail.com>
Date:   Tue, 28 Mar 2023 16:22:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com> <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
 <ZCGONl0mC8oyBj-0@kroah.com>
 <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device
 creation
In-Reply-To: <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
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

Hi David & Greg and thanks for working with this!

On 3/28/23 15:45, David Gow wrote:
> Thanks, Gred and Matti.
> 
> On Mon, 27 Mar 2023 at 20:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Mar 27, 2023 at 03:20:06PM +0300, Matti Vaittinen wrote:
>>> On 3/27/23 15:01, Greg Kroah-Hartman wrote:
>>>> On Mon, Mar 27, 2023 at 02:34:02PM +0300, Matti Vaittinen wrote:
> 
> I'm happy to keep working on this, but would definitely appreciate
> your feedback.
> 
> I've put my work-in-progress code here:
> https://kunit.googlesource.com/linux/+/refs/heads/kunit/device-helpers%5E%21/#F0
> 
> It creates a "kunit" bus, and adds a few helpers to create both
> devices and drivers on that bus, and clean them up when the test
> exits. It seems to work on all of the tests which used
> root_device_register so far (except those -- only
> test_iio_find_closest_gain_low so far -- which create multiple devices
> with the same name, as the driver name won't be unique),

I wouldn't worry about it for as long as it's just because an iio-gts 
test does something silly. Those tests are currently only in my personal 
playground and changing those tests should be pretty trivial.

And right after saying that - the test_iio_find_closest_gain_low test does

a) register a 'test' device
b) perform test on devm_ API
c) unregister the 'test' device

d) register a 'test' device (same name as at step a)
e) perform test on devm_ API
f) unregister the 'test' device

My assumption is that the test device would be gone after step c) 
because there should be no references to it anywhere. Hence, I wonder 
why registering at step d) fails? (Or did I misunderstand something?)

> and the drm
> tests work fine when ported to it as well.
> 
> There's still a lot of cleanup to do and questions which need
> answering, including:
> - Working out how best to provide an owning module (it's currently
> just kunit, but probably should be the module which contains the
> actual tests)

Maybe there is something I am not seeing but how about wrapping the 
kunit_device_register() in a macro and getting the THIS_MODULE in 
caller's context?

> In any case, does this seem like the right way forward?

I am by no means an expert on this but this does look good to me. I 
would keep this as clean, lean and simple as possible in order to keep 
understanding / debugging the problems exposed by the tests as simple as 
possible. At some point someone is wondering why a test fails, and ends 
up looking through these helpers to ensure problem is no lurking 
there... Hence, I'd kept the code there in minimum - meaning, I might 
not add kunit class or even a driver until tests require that. (Even if 
it would not look as good in the sysfs - as far as I understand the 
kunit sysfs entries are a 'test feature' which should not be present in 
'production systems'. This is not an excuse to make things bad - but (in 
my opinion) this is a good reason to prioritize simplicity.

Anyways, thanks for the work!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

