Return-Path: <linux-kselftest+bounces-1245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BB8068DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C120E1C20CF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C2182A9;
	Wed,  6 Dec 2023 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9Ilnmgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723D1BCC
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 23:44:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso5296a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 23:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701848660; x=1702453460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+g/vx1zSkUwcsn/4rcMaGsk3QCm8ubfe6fWLxasT5k=;
        b=k9Ilnmgv5cJ7CjyYriyVNdCOGrkGyu4mlzo4/AwHskcBk2S9A6+aH1ryStqj6nfei+
         QrUbEgtDOYWuUhbjVi6wFJ58QgioX/wgkdYqD8wx5DTvwfO3hoBNW3rQyFo3+ur+f0Ve
         xYQBLmWqXaRwlVc94qm+sGjP+HGLxu9JH6/JbzEj8I7JQUvEkKk3CUnkXvCUPPOUXgUU
         PwKin+XZBU71u0RBv7B+sJiM8WfdTPN0eGd5d90Q1MDiWaeRvi3YLTZ3VosQRNvGpocA
         fvdfuI0q/lXu4PANIaoaKGSwStMh5cPj07E/RGHPZn9/mKEZEPE6ZjPlyhDAiibXw8lw
         KPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848660; x=1702453460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+g/vx1zSkUwcsn/4rcMaGsk3QCm8ubfe6fWLxasT5k=;
        b=YKdXu+qQAG2uJSd/GiJScuenqF0+ZF1VQftpyBI1zDnGrTYBupG2BkSzs4W+YfrCZc
         qupxqjmh7lywzmoMiy5ZV0psP+HjKtwC6m82sadnVZ28a756foUEYd6xVE3slz6wKhSl
         xlCIXKklhQ19v04CvUTAgEj8SjGRHNoeCYJXdsnjpSWPBEi+kVQCp500TRaTAkMXinGq
         UPVW0Bn/Damyx3h6fqvUnkrCjlDJkV7ue4EvhC/SjKA3OYx6L91wNmj8z/Cbu+HzDg8A
         D06Et1E2dm3lB8sxGrjDXBKLJL9PTR1B3XzUrzGvp4XecO0d25Oxj8KZCaX+WChvy1O1
         SrUw==
X-Gm-Message-State: AOJu0YzT+hRwNxwP0cMpU9XXW95qnR6YvO9LXFjAI8X5t7Iul/404stl
	AHMRkryl4q9TmmdfICMKXUx85guImUera2DQv3A62Q==
X-Google-Smtp-Source: AGHT+IHeYvbpXAPS+aw2MsqQRN4oMPO+lm2m0HGfyfQmNkPOl4W7Pq5eObiSpjSr/npcW4Fbsb4yW/mVySV33qstLWU=
X-Received: by 2002:a50:c35d:0:b0:54a:ee8b:7a8c with SMTP id
 q29-20020a50c35d000000b0054aee8b7a8cmr66026edb.0.1701848659782; Tue, 05 Dec
 2023 23:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com> <2023120602-vaguely-primarily-b6b2@gregkh>
In-Reply-To: <2023120602-vaguely-primarily-b6b2@gregkh>
From: David Gow <davidgow@google.com>
Date: Wed, 6 Dec 2023 15:44:08 +0800
Message-ID: <CABVgOSnW7et1aonnsSLcS1LHHztXVyagAFe-U3=JX7c7xi2P4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kees Cook <keescook@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dc1d5e060bd284bd"

--000000000000dc1d5e060bd284bd
Content-Type: text/plain; charset="UTF-8"

Hey Greg,

On Wed, 6 Dec 2023 at 01:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 05, 2023 at 03:31:33PM +0800, davidgow@google.com wrote:
> > Tests for drivers often require a struct device to pass to other
> > functions. While it's possible to create these with
> > root_device_register(), or to use something like a platform device, this
> > is both a misuse of those APIs, and can be difficult to clean up after,
> > for example, a failed assertion.
> >
> > Add some KUnit-specific functions for registering and unregistering a
> > struct device:
> > - kunit_device_register()
> > - kunit_device_register_with_driver()
> > - kunit_device_unregister()
> >
> > These helpers allocate a on a 'kunit' bus which will either probe the
> > driver passed in (kunit_device_register_with_driver), or will create a
> > stub driver (kunit_device_register) which is cleaned up on test shutdown.
> >
> > Devices are automatically unregistered on test shutdown, but can be
> > manually unregistered earlier with kunit_device_unregister() in order
> > to, for example, test device release code.
>
> At first glance, nice work.  But looks like 0-day doesn't like it that
> much, so I'll wait for the next version to review it properly.

Thanks very much for taking a look. I'll send v2 with the 0-day (and
other) issues fixed sometime tomorrow.

In the meantime, I've tried to explain some of the weirder decisions
below -- it mostly boils down to the existing use-cases only wanting
an opaque 'struct device *' they can pass around, and my attempt to
find a minimal (but still sensible) implementation of that. I'm
definitely happy to tweak this to make it a more 'normal' use of the
device model where that makes sense, though, especially if it doesn't
require too much boilerplate on the part of test authors.

> One nit I did notice:
>
> > +// For internal use only -- registers the kunit_bus.
> > +int kunit_bus_init(void);
>
> Put stuff like this in a local .h file, don't pollute the include/linux/
> files for things that you do not want any other part of the kernel to
> call.
>

v2 will have this in lib/kunit/device-impl.h

> > +/**
> > + * kunit_device_register_with_driver() - Create a struct device for use in KUnit tests
> > + * @test: The test context object.
> > + * @name: The name to give the created device.
> > + * @drv: The struct device_driver to associate with the device.
> > + *
> > + * Creates a struct kunit_device (which is a struct device) with the given
> > + * name, and driver. The device will be cleaned up on test exit, or when
> > + * kunit_device_unregister is called. See also kunit_device_register, if you
> > + * wish KUnit to create and manage a driver for you
> > + */
> > +struct device *kunit_device_register_with_driver(struct kunit *test,
> > +                                              const char *name,
> > +                                              struct device_driver *drv);
>
> Shouldn't "struct device_driver *" be a constant pointer?

Done (and for the internal functions) for v2.
>
> But really, why is this a "raw" device_driver pointer and not a pointer
> to the driver type for your bus?

So, this is where the more difficult questions start (and where my
knowledge of the driver model gets a bit shakier).

At the moment, there's no struct kunit_driver; the goal was to have
whatever the minimal amount of infrastructure needed to get a 'struct
device *' that could be plumbed through existing code which accepts
it. (Read: mostly devres resource management stuff, get_device(),
etc.)

So, in this version, there's no:
- struct kunit_driver: we've no extra data to store / function
pointers other than what's in struct device_driver.
- The kunit_bus is as minimal as I could get it: each device matches
exactly one driver pointer (which is passed as struct
kunit_device->driver).
- The 'struct kunit_device' type is kept private, and 'struct device'
is used instead, as this is supposed to only be passed to generic
device functions (KUnit is just managing its lifecycle).

I've no problem adding these extra types to flesh this out into a more
'normal' setup, though I'd rather keep the boilerplate on the user
side minimal if possible. I suspect if we were to return a struct
kunit_device, everyone would be quickly grabbing and passing around a
raw 'struct device *' anyway, which is what the existing tests with
fake devices do (via root_device_register, which returns struct
device, or by returning &platform_device->dev from a helper).

Similarly, the kunit_bus is not ever exposed to test code, nor really
is the driver (except via kunit_device_register_with_driver(), which
isn't actually being used anywhere yet, so it may make sense to cut it
out from the next version). So, ideally tests won't even be aware that
their devices are attached to the kunit_bus, nor that they have
drivers attached: it's mostly just to make these normal enough that
they show up nicely in sysfs and play well with the devm_ resource
management functions.

>
> Oh heck, let's point out the other issues as I'm already here...
>
> > @@ -7,7 +7,8 @@ kunit-objs +=                         test.o \
> >                                       assert.o \
> >                                       try-catch.o \
> >                                       executor.o \
> > -                                     attributes.o
> > +                                     attributes.o \
> > +                                     device.o
>
> Shouldn't this file be "bus.c" as you are creating a kunit bus?
>

I've sort-of grouped this as "device helpers", as it handles KUnit
devices, drivers, and the kunit_bus, but devices are the most
user-facing part. Indeed, the bus feels like an 'implementation
detail'. Happy to rename it if that makes things more consistent,
though.

> >
> >  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >  kunit-objs +=                                debugfs.o
> > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > new file mode 100644
> > index 000000000000..93ace1a2297d
> > --- /dev/null
> > +++ b/lib/kunit/device.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit basic device implementation
>
> "basic bus/driver implementation", not device, right?
>

Given that the users of this really only care about getting their
"device", and the bus/driver are more implementation details, I'd
rather go with something like "KUnit-managed device implementation" or
"KUnit device-model helpers". How do those sound?

> > + *
> > + * Implementation of struct kunit_device helpers.
> > + *
> > + * Copyright (C) 2023, Google LLC.
> > + * Author: David Gow <davidgow@google.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +
> > +#include <kunit/test.h>
> > +#include <kunit/device.h>
> > +#include <kunit/resource.h>
> > +
> > +
> > +/* Wrappers for use with kunit_add_action() */
> > +KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
> > +KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister, struct device_driver *);
> > +
> > +static struct device kunit_bus = {
> > +     .init_name = "kunit"
> > +};
>
> A static device as a bus?  This feels wrong, what is it for?  And where
> does this live?  If you _REALLY_ want a single device for the root of
> your bus (which is a good idea), then make it a dynamic variable (as it
> is reference counted), NOT a static struct device which should not be
> done if at all possible.

Will do. Would root_device_register() make more sense here?

>
> > +
> > +/* A device owned by a KUnit test. */
> > +struct kunit_device {
> > +     struct device dev;
> > +     struct kunit *owner;
> > +     /* Force binding to a specific driver. */
> > +     struct device_driver *driver;
> > +     /* The driver is managed by KUnit and unique to this device. */
> > +     bool cleanup_driver;
> > +};
>
> Wait, why isn't your "kunit" device above a struct kunit_device
> structure?  Why is it ok to be a "raw" struct device (hint, that's
> almost never a good idea.)
>
> > +static inline struct kunit_device *to_kunit_device(struct device *d)
> > +{
> > +     return container_of(d, struct kunit_device, dev);
>
> container_of_const()?  And to use that properly, why not make this a #define?
>
> > +}
> > +
> > +static int kunit_bus_match(struct device *dev, struct device_driver *driver)
> > +{
> > +     struct kunit_device *kunit_dev = to_kunit_device(dev);
> > +
> > +     if (kunit_dev->driver == driver)
> > +             return 1;
> > +
> > +     return 0;
>
> I don't understand, what are you trying to match here?
>

This is just to make sure that the match function will use whatever
driver is passed through. When I originally started writing this,
there were some resource cleanup problems if there was no driver
associated with a device, though that's fixed now.

> > +}
> > +
> > +static struct bus_type kunit_bus_type = {
> > +     .name           = "kunit",
> > +     .match          = kunit_bus_match
> > +};
> > +
> > +int kunit_bus_init(void)
> > +{
> > +     int error;
> > +
> > +     error = bus_register(&kunit_bus_type);
> > +     if (!error) {
> > +             error = device_register(&kunit_bus);
> > +             if (error)
> > +                     bus_unregister(&kunit_bus_type);
> > +     }
> > +     return error;
> > +}
> > +late_initcall(kunit_bus_init);
> > +
> > +static void kunit_device_release(struct device *d)
> > +{
> > +     kfree(to_kunit_device(d));
> > +}
> > +
> > +struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
> > +{
> > +     struct device_driver *driver;
> > +     int err = -ENOMEM;
> > +
> > +     driver = kunit_kzalloc(test, sizeof(*driver), GFP_KERNEL);
> > +
> > +     if (!driver)
> > +             return ERR_PTR(err);
> > +
> > +     driver->name = name;
> > +     driver->bus = &kunit_bus_type;
> > +     driver->owner = THIS_MODULE;
> > +
> > +     err = driver_register(driver);
> > +     if (err) {
> > +             kunit_kfree(test, driver);
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     kunit_add_action(test, driver_unregister_wrapper, driver);
> > +     return driver;
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_driver_create);
> > +
> > +struct kunit_device *__kunit_device_register_internal(struct kunit *test,
> > +                                                   const char *name,
> > +                                                   struct device_driver *drv)
> > +{
> > +     struct kunit_device *kunit_dev;
> > +     int err = -ENOMEM;
> > +
> > +     kunit_dev = kzalloc(sizeof(struct kunit_device), GFP_KERNEL);
> > +     if (!kunit_dev)
> > +             return ERR_PTR(err);
> > +
> > +     kunit_dev->owner = test;
> > +
> > +     err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
> > +     if (err) {
> > +             kfree(kunit_dev);
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     /* Set the expected driver pointer, so we match. */
> > +     kunit_dev->driver = drv;
>
> Ah, so this is the match function to pass above?  If so, why do you need
> it at all?

This is just to make sure there's a driver attached, so that
driver_detach() eventually gets called on the device, which used to be
required to clean up resources in some circumstances.
This has since been fixed in 699fb50d9903 ("drivers: base: Free devm
resources when unregistering a device"), but it seemed worth keeping
it both to make these devices seem "more normal", and potentially to
facilitate users providing a struct device_driver themselves later on,
should that one day be useful.

> > +
> > +     kunit_dev->dev.release = kunit_device_release;
> > +     kunit_dev->dev.bus = &kunit_bus_type;
> > +     kunit_dev->dev.parent = &kunit_bus;
> > +
> > +     err = device_register(&kunit_dev->dev);
> > +     if (err) {
> > +             put_device(&kunit_dev->dev);
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
> > +
> > +     return kunit_dev;
> > +}
> > +
> > +struct device *kunit_device_register_with_driver(struct kunit *test,
> > +                                              const char *name,
> > +                                              struct device_driver *drv)
> > +{
> > +     struct kunit_device *kunit_dev = __kunit_device_register_internal(test, name, drv);
> > +
> > +     if (IS_ERR_OR_NULL(kunit_dev))
>
> This is almost always a sign that something is wrong with the api.

This can probably just be IS_ERR().

>
> > +             return (struct device *)kunit_dev; /* This is an error or NULL, so is compatible */
>
> Ick, the cast is odd, are you sure you need it?  Why would you return a
> struct device and not a kunit_device() anyway?
>

All the users of this only want the struct device, so it's more
convenient if that's all we return (and it lets us keep struct
kunit_device private). But it's a minor inconvenience at worst, so I
don't mind changing it.

> > +
> > +     return &kunit_dev->dev;
>
> Again, why this type, why not use the real type you have?

As above, to keep 'struct kunit_device' private.


Thanks again for looking at this; I'd definitely appreciate any
further input you may have on the design.

Cheers,
-- David

--000000000000dc1d5e060bd284bd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCU
SAVNPcJb6KpR8Jk/z3AWB2izobaHT4JsBMKkzyyUeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMDYwNzQ0MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXlh5G5KKwZk87+2gKnga
2lBUxApzPH9+krMJB7MI3HNipgv9eNgQ9jWpJGlSSuLVD9N8FrXMD4yym/PFUgo3d2m6uCz44jUj
8A29D2CrQrpO1jIhztHy9TvytVwkazp6wBjO82Vyxhz6PC1WB5NFXr30tU53Jsz4PuCro//H7mY+
JeKMuXgKBvuCeXzqDshVuwFw6jS4i+XBRzlW0bCJhFyDeP+TOmfKnu72KXrzkrDKOoVvossR8/BW
2pXbDMnysm11OfCBbtZYqdaZONo6veP2jL4AYo3c84j7n4wHUNuu3CbxvE/ZG7TmzeqFg6xlsW/S
Deb/20yi0GBYhiKs3g==
--000000000000dc1d5e060bd284bd--

