Return-Path: <linux-kselftest+bounces-1181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92512805B22
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338AF1F21652
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE067E8E;
	Tue,  5 Dec 2023 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eo34XWay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35317675D4;
	Tue,  5 Dec 2023 17:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0D6C433C8;
	Tue,  5 Dec 2023 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701797452;
	bh=CwZH8dp4E6n8XqkzFtg8ZeyfOny+4HhH2LzxKqY45/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eo34XWayzo1yJIrgJEuVirn1KuAJ+0ua2w/vTh2EcI8xwiKp/gbo39WkN0UCHBKGR
	 BJ5BHYJ1Qew/EmfyAP6UUgwVOzL9+KmH9VkQkYNa1g4WjJEul68Q66H4Z5r/XaLggs
	 UmgJ5WWiwP3rUxNeLI/TGqEurRJQVrSx4dvN4+Es=
Date: Wed, 6 Dec 2023 02:30:45 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Message-ID: <2023120602-vaguely-primarily-b6b2@gregkh>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>

On Tue, Dec 05, 2023 at 03:31:33PM +0800, davidgow@google.com wrote:
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
> 
> These helpers allocate a on a 'kunit' bus which will either probe the
> driver passed in (kunit_device_register_with_driver), or will create a
> stub driver (kunit_device_register) which is cleaned up on test shutdown.
> 
> Devices are automatically unregistered on test shutdown, but can be
> manually unregistered earlier with kunit_device_unregister() in order
> to, for example, test device release code.

At first glance, nice work.  But looks like 0-day doesn't like it that
much, so I'll wait for the next version to review it properly.

One nit I did notice:

> +// For internal use only -- registers the kunit_bus.
> +int kunit_bus_init(void);

Put stuff like this in a local .h file, don't pollute the include/linux/
files for things that you do not want any other part of the kernel to
call.

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

Shouldn't "struct device_driver *" be a constant pointer?

But really, why is this a "raw" device_driver pointer and not a pointer
to the driver type for your bus?

Oh heck, let's point out the other issues as I'm already here...

> @@ -7,7 +7,8 @@ kunit-objs +=				test.o \
>  					assert.o \
>  					try-catch.o \
>  					executor.o \
> -					attributes.o
> +					attributes.o \
> +					device.o

Shouldn't this file be "bus.c" as you are creating a kunit bus?

>  
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=				debugfs.o
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> new file mode 100644
> index 000000000000..93ace1a2297d
> --- /dev/null
> +++ b/lib/kunit/device.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit basic device implementation

"basic bus/driver implementation", not device, right?

> + *
> + * Implementation of struct kunit_device helpers.
> + *
> + * Copyright (C) 2023, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +
> +#include <linux/device.h>
> +
> +#include <kunit/test.h>
> +#include <kunit/device.h>
> +#include <kunit/resource.h>
> +
> +
> +/* Wrappers for use with kunit_add_action() */
> +KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
> +KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister, struct device_driver *);
> +
> +static struct device kunit_bus = {
> +	.init_name = "kunit"
> +};

A static device as a bus?  This feels wrong, what is it for?  And where
does this live?  If you _REALLY_ want a single device for the root of
your bus (which is a good idea), then make it a dynamic variable (as it
is reference counted), NOT a static struct device which should not be
done if at all possible.

> +
> +/* A device owned by a KUnit test. */
> +struct kunit_device {
> +	struct device dev;
> +	struct kunit *owner;
> +	/* Force binding to a specific driver. */
> +	struct device_driver *driver;
> +	/* The driver is managed by KUnit and unique to this device. */
> +	bool cleanup_driver;
> +};

Wait, why isn't your "kunit" device above a struct kunit_device
structure?  Why is it ok to be a "raw" struct device (hint, that's
almost never a good idea.)

> +static inline struct kunit_device *to_kunit_device(struct device *d)
> +{
> +	return container_of(d, struct kunit_device, dev);

container_of_const()?  And to use that properly, why not make this a #define?

> +}
> +
> +static int kunit_bus_match(struct device *dev, struct device_driver *driver)
> +{
> +	struct kunit_device *kunit_dev = to_kunit_device(dev);
> +
> +	if (kunit_dev->driver == driver)
> +		return 1;
> +
> +	return 0;

I don't understand, what are you trying to match here?

> +}
> +
> +static struct bus_type kunit_bus_type = {
> +	.name		= "kunit",
> +	.match		= kunit_bus_match
> +};
> +
> +int kunit_bus_init(void)
> +{
> +	int error;
> +
> +	error = bus_register(&kunit_bus_type);
> +	if (!error) {
> +		error = device_register(&kunit_bus);
> +		if (error)
> +			bus_unregister(&kunit_bus_type);
> +	}
> +	return error;
> +}
> +late_initcall(kunit_bus_init);
> +
> +static void kunit_device_release(struct device *d)
> +{
> +	kfree(to_kunit_device(d));
> +}
> +
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

Ah, so this is the match function to pass above?  If so, why do you need
it at all?

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
> +
> +struct device *kunit_device_register_with_driver(struct kunit *test,
> +						 const char *name,
> +						 struct device_driver *drv)
> +{
> +	struct kunit_device *kunit_dev = __kunit_device_register_internal(test, name, drv);
> +
> +	if (IS_ERR_OR_NULL(kunit_dev))

This is almost always a sign that something is wrong with the api.

> +		return (struct device *)kunit_dev; /* This is an error or NULL, so is compatible */

Ick, the cast is odd, are you sure you need it?  Why would you return a
struct device and not a kunit_device() anyway?

> +
> +	return &kunit_dev->dev;

Again, why this type, why not use the real type you have?

thanks,

greg k-h

