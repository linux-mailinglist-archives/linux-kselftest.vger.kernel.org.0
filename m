Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439486C4C43
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVNst (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 09:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCVNss (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 09:48:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6ED5A6E7;
        Wed, 22 Mar 2023 06:48:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so12660452lfe.10;
        Wed, 22 Mar 2023 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679492892;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92oTNP+sKoipbZFz7skaTllICxMbhqwCfT6iOU7a8rc=;
        b=cCPyYH9pJ1b9o0ofAqIlqifdD12pUu1NQwYP9kb8lXRzfL4HmGVqyGma3L5K3RXifB
         inMJCpIgXEXhLtUjonU+VlUmg4st6QF7DI2JB5dw0urxuQiL8g+O6GWrtDt88+ZSgGXo
         Pnbd03wYUq1i3wpe4uA8IwDnHdMpoimsBnAbV+DgFkoVGfnz05X+m81o0Ghab6d/sd9r
         z70Fg6v5MTR4WCX7JEhpzzLlKZo40T2ebswSQSC7BY2O3SvljC6N5qRbmZhpifbCaZik
         y/7pETxnAeXnqqKeLUL/TAaMESuQmzmci8xgkQ99u44b9EwFabcI/Sr2xsq5d60uQLbg
         zi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679492892;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92oTNP+sKoipbZFz7skaTllICxMbhqwCfT6iOU7a8rc=;
        b=zy2I2LqdzUkhdlUwX60ps+LLV9IAjPIegu7w1IzejxDTTm6hBtmWq38bphx5ibvBGp
         HXDhAelkLyQvOt/uOqy4qDXjYU8LfCxGVpjrCr7dO9tXchduji1Rj1uUFJdp3ZwM166Z
         cJfdd0wd+dnC6pJ5ZCK13LRJp3UbKMEx5lu0D1txU9wJayIOUMqEIMEVkhseuV9I/Lc3
         PqqwauMHf2pVpy+jK0/sUqBQo3UyLr9dScNVaz/PDUODGuNF9pKNUh9QWpycGa0/jjpb
         jkWunttGtq2iMj1s2sfTGq1gFRlwkqjqmyt7G6lrbjw8AV+mxGRXgK3CASuwCuSFUsBb
         9TSw==
X-Gm-Message-State: AO0yUKXZFICd/vlrrHK8V7kQjZkfcsb+juKBm2QP45Qt8TmPKkGUYCrv
        9lOoQHqFu7ru0RNPOnBbsTo=
X-Google-Smtp-Source: AK7set/DsbRSjiFXY1QVWeKBJ5mRkh2cXJeChEojpUx0NG2pipiDPmSEh3CZhu7PWl8H4ITE4/x62Q==
X-Received: by 2002:a19:c206:0:b0:4e8:3f1f:3646 with SMTP id l6-20020a19c206000000b004e83f1f3646mr1898313lfc.55.1679492891602;
        Wed, 22 Mar 2023 06:48:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id t18-20020ac25492000000b004d58bf6a61asm2545811lfk.230.2023.03.22.06.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:48:11 -0700 (PDT)
Message-ID: <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
Date:   Wed, 22 Mar 2023 15:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBrvhfX/NNrJefgt@kroah.com>
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

Hi Greg,

Thanks for looking at this.

On 3/22/23 14:07, Greg Kroah-Hartman wrote:
> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
>> --- /dev/null
>> +++ b/drivers/base/test/test_kunit_device.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * These helpers have been extracted from drm test code at
>> + * drm_kunit_helpers.c which was authored by
>> + * Maxime Ripard <maxime@cerno.tech>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <kunit/platform_device.h>
>> +
>> +#define KUNIT_DEVICE_NAME	"test-kunit-mock-device"
>> +
>> +static int fake_probe(struct platform_device *pdev)
> 
> Please do not abuse platform devices and drivers for things that are not
> actually platform devices and drivers.
> 
>> +{
>> +	return 0;
>> +}
>> +
>> +static int fake_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver fake_platform_driver = {
>> +	.probe	= fake_probe,
>> +	.remove	= fake_remove,
>> +	.driver = {
>> +		.name	= KUNIT_DEVICE_NAME,
>> +	},
>> +};
> 
> Why do you need this fake platform driver at all?
> 
> Why not just use a virtual device?

I can only answer on my behalf. In my case the answer to why I used 
platform_devices is practicality. I wanted to test devm_ APIs using 
KUnit tests and I was pointed to an existing implementation in DRM (seen 
in these patches). It didn't seem to make any sense to re-invent the 
wheel by writing another implementation for the existing in-tree 
functionality.

Maybe Maxime had a better reason to go with the platform devices.

>> +/**
>> + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
>> + * @test: The test context object
>> + *
>> + * This allocates a fake struct &device to create a mock for a KUnit
>> + * test. The device will also be bound to a fake driver. It will thus be
>> + * able to leverage the usual infrastructure and most notably the
>> + * device-managed resources just like a "real" device.
> 
> What specific "usual infrastructure" are you wanting to access here?
> 
> And again, if you want a fake device, make a virtual one, by just
> calling device_create().
> 
> Or are you wanting to do "more" with that device pointer than
> device_create() can give you?

Personally, I was (am) only interested in devm_ unwinding. I guess the
device_create(), device_add(), device_remove()... (didn't study this 
sequence in details so sorry if there is errors) could've been 
sufficient for me. I haven't looked how much of the code that there is 
for 'platform devices' should be duplicated to support that sequence for 
testability purposes.

The biggest thing for me is that I don't like the idea of creating own 
'test device' in <add subsystem here> while we already have some in DRM 
(or others). Thus, I do see value in adding generic helpers for 
supporting running KUnit tests on devm_* APIs. Hence it'd be good to 
have _some_ support for it. And having them in drivers/base/test seemed 
like a correct place to me. What I really don't know is if there are 
legitimate use-cases for using platform_devices in DRM tests. Perhaps 
Maxime can shed light on that.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

