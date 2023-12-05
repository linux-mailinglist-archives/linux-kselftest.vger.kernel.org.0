Return-Path: <linux-kselftest+bounces-1123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428E804C5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 09:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF7F2816D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD63C47C;
	Tue,  5 Dec 2023 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmEZYxE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE40D4F;
	Tue,  5 Dec 2023 00:30:11 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf898c43cso1778589e87.1;
        Tue, 05 Dec 2023 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765010; x=1702369810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPX4+BGX4HrclWT0seEGlKqhkOkVidDG8/OL7KroYgM=;
        b=dmEZYxE9D9jLOGeGCkH96TsUFYhM1EnvTx+iSOlhQaFUR1QNNW4iHSZIsaO+QROQTc
         whxPeoEyCXq5Y72scGKLTAxPW7tR8eglU9lWuAatsxkG28+w5MPEMXRtjbWLPE3Y4E4y
         D34PDlHASzBxdxd31Bu745wFjRHOx6dPh2jZ+c+0SzOlPpGXb0ySItMY6l2oopCe4dmA
         GmQZ3BBgPFcR6JYtHxn+vTJNkRTchOTkIMtV5ajcrXyliW/xFLF29iFE6rg6uics0JKa
         8VR5yG8xauZYIFEtH8P3RJL+Y2yr9AfFBUrTPLN6G1b/WGAZvOP7usGCmZLU7rNXseS3
         Rd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765010; x=1702369810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPX4+BGX4HrclWT0seEGlKqhkOkVidDG8/OL7KroYgM=;
        b=AmZWmevue8mFCR4zrbHc2pbgXmgGZ5EMUNTDVcOgQpEUSmu79z6usJNcGXItEQRPX4
         mJ0lg9lyCXPJApyemetKxZn+z2i3p8GUBKwPRGeSjeACs4h4+lCDvNfWwkyAx+dJXhJ0
         zaABK4NzYEykZ4gRzaj+T8HmSQQbay6/lWnjvdvPZea678Qgk1lqUmtu5dDZW1MZQdnK
         yKSB9ZUbOzrfeyMipa8sDLxqQ5RIzmyy4YfC4Zfas/h8aqF/QWdtiYCQ/j9FiSCXOw+w
         TXz7kN+tvuj8s35BaijyaoP4TllmZ9spVzwtZkfw09wrkXEOz6ZK1Zs8g88w8mvccbSf
         Hm0Q==
X-Gm-Message-State: AOJu0YzyLavr6TswC1iUb3ki2O3OJUrp8pmT3VpZBkdGHuzWpGq1bNG8
	IYI6QIK7na2upcmUQU0x6CU=
X-Google-Smtp-Source: AGHT+IEWm90qXXmXJXSrvogut31Ab68O5Ygka/dO8KnZT/ScNME3M1dnx37Zrgvna+9b4v5YcKjAtg==
X-Received: by 2002:a05:6512:b96:b0:50b:e77c:b1e2 with SMTP id b22-20020a0565120b9600b0050be77cb1e2mr2039969lfv.65.1701765009395;
        Tue, 05 Dec 2023 00:30:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id z28-20020a19505c000000b0050bfe37d283sm316199lfj.262.2023.12.05.00.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:30:08 -0800 (PST)
Message-ID: <ddb65f28-e900-44ef-aad3-568093540c38@gmail.com>
Date: Tue, 5 Dec 2023 10:30:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Content-Language: en-US, en-GB
To: davidgow@google.com, Rae Moar <rmoar@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 09:31, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> Add some KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_register_with_driver()
> - kunit_device_unregister()

Thanks a lot David! I have been missing these!

I love the explanation you added under Documentation. Very helpful I'd 
say. I only have very minor comments which you can ignore if they don't 
make sense to you or the kunit-subsystem.

With or without the suggested changes:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> --- /dev/null
> +++ b/include/kunit/device.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit basic device implementation
> + *
> + * Helpers for creating and managing fake devices for KUnit tests.
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#ifndef _KUNIT_DEVICE_H
> +#define _KUNIT_DEVICE_H
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +#include <kunit/test.h>
> +
> +struct kunit_device;
> +struct device;
> +struct device_driver;
> +
> +// For internal use only -- registers the kunit_bus.
> +int kunit_bus_init(void);
> +
> +/**
> + * kunit_driver_create() - Create a struct device_driver attached to the kunit_bus
> + * @test: The test context object.
> + * @name: The name to give the created driver.
> + *
> + * Creates a struct device_driver attached to the kunit_bus, with the name @name.
> + * This driver will automatically be cleaned up on test exit.
> + */
> +struct device_driver *kunit_driver_create(struct kunit *test, const char *name);
> +
> +/**
> + * kunit_device_register() - Create a struct device for use in KUnit tests
> + * @test: The test context object.
> + * @name: The name to give the created device.
> + *
> + * Creates a struct kunit_device (which is a struct device) with the given name,
> + * and a corresponding driver. The device and driver will be cleaned up on test
> + * exit, or when kunit_device_unregister is called. See also
> + * kunit_device_register_with_driver, if you wish to provide your own
> + * struct device_driver.
> + */
> +struct device *kunit_device_register(struct kunit *test, const char *name);
> +
> +/**
> + * kunit_device_register_with_driver() - Create a struct device for use in KUnit tests
> + * @test: The test context object.
> + * @name: The name to give the created device.
> + * @drv: The struct device_driver to associate with the device.
> + *
> + * Creates a struct kunit_device (which is a struct device) with the given
> + * name, and driver. The device will be cleaned up on test exit, or when
> + * kunit_device_unregister is called. See also kunit_device_register, if you
> + * wish KUnit to create and manage a driver for you
> + */
> +struct device *kunit_device_register_with_driver(struct kunit *test,
> +						 const char *name,
> +						 struct device_driver *drv);
> +
> +/**
> + * kunit_device_unregister() - Unregister a KUnit-managed device
> + * @test: The test context object which created the device
> + * @dev: The device.
> + *
> + * Unregisters and destroys a struct device which was created with
> + * kunit_device_register or kunit_device_register_with_driver. If KUnit created
> + * a driver, cleans it up as well.
> + */
> +void kunit_device_unregister(struct kunit *test, struct device *dev);

I wish the return values for error case(s) were also mentioned. But 
please, see my next comment as well.

> +
> +#endif
> +
> +#endif

...

> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> new file mode 100644
> index 000000000000..93ace1a2297d
> --- /dev/null
> +++ b/lib/kunit/device.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit basic device implementation
> + *
> + * Implementation of struct kunit_device helpers.
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +

...

> +
> +static void kunit_device_release(struct device *d)
> +{
> +	kfree(to_kunit_device(d));
> +}

I see you added the function documentation to the header. I assume this 
is the kunit style(?) I may be heretical, but I'd love to see at least a 
very short documentation for (all) exported functions here. I think the 
arguments are mostly self-explatonary, but at least for me the return 
values aren't that obvious. Whether they are kerneldoc or not is not 
that important to me.

I think you did a great job adding docs under Documentation/ (and the 
header) - but at least I tend to just jump to function implementation 
when I need to figure out how it behaves. Having doc (or pointer to doc) 
also here helps. I don't think it's that widely spread practice to add 
docs to the headers(?)

> +struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
> +{
> +	struct device_driver *driver;
> +	int err = -ENOMEM;
> +
> +	driver = kunit_kzalloc(test, sizeof(*driver), GFP_KERNEL);
> +
> +	if (!driver)
> +		return ERR_PTR(err);
> +
> +	driver->name = name;
> +	driver->bus = &kunit_bus_type;
> +	driver->owner = THIS_MODULE;
> +
> +	err = driver_register(driver);
> +	if (err) {
> +		kunit_kfree(test, driver);
> +		return ERR_PTR(err);
> +	}
> +
> +	kunit_add_action(test, driver_unregister_wrapper, driver);
> +	return driver;
> +}
> +EXPORT_SYMBOL_GPL(kunit_driver_create);
> +
> +struct kunit_device *__kunit_device_register_internal(struct kunit *test,
> +						      const char *name,
> +						      struct device_driver *drv)

Very much nitpicking only - but do you think either the "__"-prefix or 
the "_internal"-suffix would be enough and not both? (Just to make 
function a tad shorter, not that it matters much though).

> +{
> +	struct kunit_device *kunit_dev;
> +	int err = -ENOMEM;
> +
> +	kunit_dev = kzalloc(sizeof(struct kunit_device), GFP_KERNEL);
> +	if (!kunit_dev)
> +		return ERR_PTR(err);
> +
> +	kunit_dev->owner = test;
> +
> +	err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
> +	if (err) {
> +		kfree(kunit_dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	/* Set the expected driver pointer, so we match. */
> +	kunit_dev->driver = drv;
> +
> +	kunit_dev->dev.release = kunit_device_release;
> +	kunit_dev->dev.bus = &kunit_bus_type;
> +	kunit_dev->dev.parent = &kunit_bus;
> +
> +	err = device_register(&kunit_dev->dev);
> +	if (err) {
> +		put_device(&kunit_dev->dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
> +
> +	return kunit_dev;
> +}

...

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


