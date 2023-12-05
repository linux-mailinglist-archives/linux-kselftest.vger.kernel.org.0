Return-Path: <linux-kselftest+bounces-1127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB5804D03
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C771F214C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5003C6BA;
	Tue,  5 Dec 2023 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN64jr1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637C3C08A;
	Tue,  5 Dec 2023 09:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A567C433C8;
	Tue,  5 Dec 2023 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701766807;
	bh=8Zo030DW5StfuPpy+njP5VItWjRf8nBa5Yz4US41iQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fN64jr1pg+CWazm5c3TXifGsIZdN/ygc6shGctLcCYLrMXTRaahakjnOU3OikcwXC
	 gn3VucgB3t2LK1l9JTPYMK4Es8pyO50US+oPAltzfmx8dsTNnDH2Dbwx1Att+SJXzu
	 +/9LKa7KHQqvItvVi0ZflbSvq8vc8IDK6A9T0CdY+AJtZD8wP0JE23LYDJEZwTJ3WX
	 WofyjHk/qWsRZW+zXLZr5CxvLoA4ijwguGB6N7Q/sBY3jH3BOibzuOchjPqNDDcTjH
	 rkXEaW4WNWmw3RuhGGiBW4Yo8E6Akd7antXw7xmMIGZ/klDRhbM7P8CBhSYijL85y5
	 po2/sFdtOImIA==
Date: Tue, 5 Dec 2023 10:00:04 +0100
From: Maxime Ripard <mripard@kernel.org>
To: davidgow@google.com
Cc: Rae Moar <rmoar@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Message-ID: <ssrsr5lter2vbwvkghbtv4cwr4keckapbeyw24deobnwb22hc5@j65aqmf2wjsb>
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e57g6kre6lemgyu3"
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>


--e57g6kre6lemgyu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks a lot for working on this.

On Tue, Dec 05, 2023 at 03:31:33PM +0800, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
>=20
> Add some KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_register_with_driver()
> - kunit_device_unregister()
>=20
> These helpers allocate a on a 'kunit' bus which will either probe the
> driver passed in (kunit_device_register_with_driver), or will create a
> stub driver (kunit_device_register) which is cleaned up on test shutdown.
>=20
> Devices are automatically unregistered on test shutdown, but can be
> manually unregistered earlier with kunit_device_unregister() in order
> to, for example, test device release code.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst |  49 +++++++++
>  include/kunit/device.h                  |  76 ++++++++++++++
>  lib/kunit/Makefile                      |   3 +-
>  lib/kunit/device.c                      | 176 ++++++++++++++++++++++++++=
++++++
>  lib/kunit/kunit-test.c                  |  68 +++++++++++-
>  lib/kunit/test.c                        |   3 +
>  6 files changed, 373 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 9db12e91668e..a222a98edceb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -797,3 +797,52 @@ structures as shown below:
>  KUnit is not enabled, or if no test is running in the current task, it w=
ill do
>  nothing. This compiles down to either a no-op or a static key check, so =
will
>  have a negligible performance impact when no test is running.
> +
> +Managing Fake Devcices and Drivers

                 ^ Devices

> +----------------------------------
> +
> +When testing drivers or code which interacts with drivers, many function=
s will
> +require a ``struct device`` or ``struct device_driver``. In many cases, =
setting
> +up a real device is not required to test any given function, so a fake d=
evice
> +can be used instead.
> +
> +KUnit provides helper functions to create and manage these fake devices,=
 which
> +are internally of type ``struct kunit_device``, and are attached to a sp=
ecial
> +``kunit_bus``. These devices support managed device resources (devres), =
as
> +described in Documentation/driver-api/driver-model/devres.rst
> +
> +To create a KUnit-managed ``struct device_driver``, use ``kunit_driver_c=
reate()``,
> +which will create a driver with the given name, on the ``kunit_bus``. Th=
is driver
> +will automatically be destroyed when the corresponding test finishes, bu=
t can also
> +be manually destroyed with ``driver_unregister()``.
> +
> +To create a fake device, use the ``kunit_device_register()``, which will=
 create
> +and register a device, using a new KUnit-managed driver created with ``k=
unit_driver_create()``.
> +To provide a specific, non-KUnit-managed driver, use ``kunit_device_regi=
ster_with_driver()``
> +instead. Like with managed drivers, KUnit-managed fake devices are autom=
atically
> +cleaned up when the test finishes, but can be manually cleaned up early =
with
> +``kunit_device_unregister()``.

I think we should add a test for that, just like we did for root and
platform devices. We've been bitten by that before :)

> +The KUnit devices should be used in preference to ``root_device_register=
()``, and
> +instead of ``platform_device_register()`` in cases where the device is n=
ot otherwise
> +a platform device.
> +
> +For example:
> +
> +.. code-block:: c
> +
> +	#include <kunit/device.h>
> +
> +	static void test_my_device(struct kunit *test)
> +	{
> +		struct device *fake_device;
> +		const char *dev_managed_string;
> +
> +		// Create a fake device.
> +		fake_device =3D kunit_device_register(test, "my_device");
> +
> +		// Pass it to functions which need a device.
> +		dev_managed_string =3D devm_kstrdup(fake_device, "Hello, World!");
> +
> +		// Everything is cleaned up automatically when the test ends.
> +	}
> \ No newline at end of file
> diff --git a/include/kunit/device.h b/include/kunit/device.h
> new file mode 100644
> index 000000000000..fd2193bc55f1
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
> + * kunit_driver_create() - Create a struct device_driver attached to the=
 kunit_bus
> + * @test: The test context object.
> + * @name: The name to give the created driver.
> + *
> + * Creates a struct device_driver attached to the kunit_bus, with the na=
me @name.
> + * This driver will automatically be cleaned up on test exit.
> + */
> +struct device_driver *kunit_driver_create(struct kunit *test, const char=
 *name);
> +
> +/**
> + * kunit_device_register() - Create a struct device for use in KUnit tes=
ts
> + * @test: The test context object.
> + * @name: The name to give the created device.
> + *
> + * Creates a struct kunit_device (which is a struct device) with the giv=
en name,
> + * and a corresponding driver. The device and driver will be cleaned up =
on test
> + * exit, or when kunit_device_unregister is called. See also
> + * kunit_device_register_with_driver, if you wish to provide your own
> + * struct device_driver.
> + */
> +struct device *kunit_device_register(struct kunit *test, const char *nam=
e);
> +
> +/**
> + * kunit_device_register_with_driver() - Create a struct device for use =
in KUnit tests
> + * @test: The test context object.
> + * @name: The name to give the created device.
> + * @drv: The struct device_driver to associate with the device.
> + *
> + * Creates a struct kunit_device (which is a struct device) with the giv=
en
> + * name, and driver. The device will be cleaned up on test exit, or when
> + * kunit_device_unregister is called. See also kunit_device_register, if=
 you
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
> + * kunit_device_register or kunit_device_register_with_driver. If KUnit =
created
> + * a driver, cleans it up as well.
> + */
> +void kunit_device_unregister(struct kunit *test, struct device *dev);
> +
> +#endif
> +
> +#endif
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 46f75f23dfe4..309659a32a78 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -7,7 +7,8 @@ kunit-objs +=3D				test.o \
>  					assert.o \
>  					try-catch.o \
>  					executor.o \
> -					attributes.o
> +					attributes.o \
> +					device.o
> =20
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=3D				debugfs.o
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
> +#include <linux/device.h>
> +
> +#include <kunit/test.h>
> +#include <kunit/device.h>
> +#include <kunit/resource.h>
> +
> +
> +/* Wrappers for use with kunit_add_action() */
> +KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister=
, struct device *);
> +KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister=
, struct device_driver *);
> +
> +static struct device kunit_bus =3D {
> +	.init_name =3D "kunit"
> +};
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
> +
> +static inline struct kunit_device *to_kunit_device(struct device *d)
> +{
> +	return container_of(d, struct kunit_device, dev);
> +}
> +
> +static int kunit_bus_match(struct device *dev, struct device_driver *dri=
ver)
> +{
> +	struct kunit_device *kunit_dev =3D to_kunit_device(dev);
> +
> +	if (kunit_dev->driver =3D=3D driver)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static struct bus_type kunit_bus_type =3D {
> +	.name		=3D "kunit",
> +	.match		=3D kunit_bus_match
> +};
> +
> +int kunit_bus_init(void)
> +{
> +	int error;
> +
> +	error =3D bus_register(&kunit_bus_type);
> +	if (!error) {
> +		error =3D device_register(&kunit_bus);
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
> +struct device_driver *kunit_driver_create(struct kunit *test, const char=
 *name)
> +{
> +	struct device_driver *driver;
> +	int err =3D -ENOMEM;
> +
> +	driver =3D kunit_kzalloc(test, sizeof(*driver), GFP_KERNEL);
> +
> +	if (!driver)
> +		return ERR_PTR(err);
> +
> +	driver->name =3D name;
> +	driver->bus =3D &kunit_bus_type;
> +	driver->owner =3D THIS_MODULE;
> +
> +	err =3D driver_register(driver);
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
> +	int err =3D -ENOMEM;
> +
> +	kunit_dev =3D kzalloc(sizeof(struct kunit_device), GFP_KERNEL);

The preferred syntax is sizeof(*kunit_dev) here

> +	if (!kunit_dev)
> +		return ERR_PTR(err);
> +
> +	kunit_dev->owner =3D test;
> +
> +	err =3D dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
> +	if (err) {
> +		kfree(kunit_dev);
> +		return ERR_PTR(err);
> +	}
> +
> +	/* Set the expected driver pointer, so we match. */
> +	kunit_dev->driver =3D drv;
> +
> +	kunit_dev->dev.release =3D kunit_device_release;
> +	kunit_dev->dev.bus =3D &kunit_bus_type;
> +	kunit_dev->dev.parent =3D &kunit_bus;
> +
> +	err =3D device_register(&kunit_dev->dev);
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
> +	struct kunit_device *kunit_dev =3D __kunit_device_register_internal(tes=
t, name, drv);
> +
> +	if (IS_ERR_OR_NULL(kunit_dev))
> +		return (struct device *)kunit_dev; /* This is an error or NULL, so is =
compatible */
> +
> +	return &kunit_dev->dev;
> +}
> +EXPORT_SYMBOL_GPL(kunit_device_register_with_driver);
> +
> +struct device *kunit_device_register(struct kunit *test, const char *nam=
e)
> +{
> +	struct device_driver *drv =3D kunit_driver_create(test, name);
> +	struct kunit_device *dev;
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drv);
> +
> +	dev =3D __kunit_device_register_internal(test, name, drv);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	dev->cleanup_driver =3D true;
> +
> +	return (struct device *)dev;
> +}
> +EXPORT_SYMBOL_GPL(kunit_device_register);
> +
> +void kunit_device_unregister(struct kunit *test, struct device *dev)
> +{
> +	bool cleanup_driver =3D ((struct kunit_device *)dev)->cleanup_driver;
> +	struct device_driver *driver =3D ((struct kunit_device *)dev)->driver;
> +
> +	kunit_release_action(test, device_unregister_wrapper, dev);
> +	if (cleanup_driver)
> +		kunit_release_action(test, driver_unregister_wrapper, driver);
> +}
> +EXPORT_SYMBOL_GPL(kunit_device_unregister);
> +
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 3e9c5192d095..a4007158bf36 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -8,6 +8,9 @@
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
> =20
> +#include <linux/device.h>
> +#include <kunit/device.h>
> +
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
> =20
> @@ -687,6 +690,69 @@ static struct kunit_case kunit_current_test_cases[] =
=3D {
>  	{}
>  };
> =20
> +static void test_dev_action(void *priv)
> +{
> +	*(void **)priv =3D (void *)1;
> +}
> +
> +static void kunit_device_test(struct kunit *test)
> +{
> +	struct device *test_device;
> +
> +	test_device =3D kunit_device_register(test, "my_device");
> +
> +	KUNIT_ASSERT_NOT_NULL(test, test_device);
> +
> +	// Add an action to verify cleanup.
> +	devm_add_action(test_device, test_dev_action, &test->priv);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, test->priv, (void *)0);
> +
> +	kunit_device_unregister(test, test_device);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, test->priv, (void *)1);
> +}

Oh, it looks like you do check there, sorry.

I guess I would have expected an explicit test for that, but that works
:)

> +
> +static void kunit_device_driver_test(struct kunit *test)
> +{
> +	struct device_driver *test_driver;
> +	struct device *test_device;
> +
> +	test_driver =3D kunit_driver_create(test, "my_driver");
> +
> +	KUNIT_ASSERT_NOT_NULL(test, test_driver);
> +
> +	test_device =3D kunit_device_register_with_driver(test, "my_device", te=
st_driver);
> +
> +	KUNIT_ASSERT_NOT_NULL(test, test_device);

Should we test that the probe (and remove) hooks has been called too?

Maxime

--e57g6kre6lemgyu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW7mlAAKCRDj7w1vZxhR
xU4PAQCjM9+Z6n9hbVCI8aLj8Ymg5hS+I+cvVeg0Z7R+FUIkkQD/VNYXM8lRvjLP
Dyd8pxaT/Rn7N+WCbBGoQIOlRDdvmQs=
=bV3k
-----END PGP SIGNATURE-----

--e57g6kre6lemgyu3--

