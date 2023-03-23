Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1D6C60CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCWHbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjCWHbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:31:13 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AD1969A
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 00:30:49 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536af432ee5so381666477b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679556648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWT1Gw2yi+3vK2gNl+xpMFAgTNnvSfipucL84qfFrSY=;
        b=mNRXJEE5j7NWmxfm6yq0TgZrq8KZ6NehssDaMl/i8PclsC6Ieq9qIHiORKa2SjJu5Z
         AWTzKiEORWNXVPzSdDK+Q1bHgqYLBk/2GOyh1NV6GW8GVqJDlXu2tv+zLN3r7LVcCgsQ
         fsgcVNh7+MIekKRWiPOlLH2v0wKzpjL8Ly4xdYa3r2N3SeLG6urb88hE0AEAbdvQNeHP
         4ucN0d2bi4lpdZSgt54yJ/gUlxARvvsWkp9cUVktpihTKZd4DUNnCgykxvnciTtS13NC
         42lG63NRQCOj/ioG4B1w+Cv0LoC/17uInkdzHAFXbrqT+DYdfSHJMfyJ3lZ67f3ndfJZ
         tHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWT1Gw2yi+3vK2gNl+xpMFAgTNnvSfipucL84qfFrSY=;
        b=BNQyLd8N6iiLunSy8+fEBDh374ky5GJO5yCCG2qGGaanEmSPH5ykK1Z4HkUlScKB6a
         76e18O1fYMPkHKeLHGhUQiH1z/Wb4T23Cz9l3+NxVa8L8pumNtJG+rQ2s0PoFFtNiQyf
         FK4yNssOZeXKq+rg13sjf7/HUU4dkrDJldIiPY+KOzROMGYcSfLwD9uove/y5QBWB3KD
         FN8ZEpXI7wo18xG94s+L9uIhDb2hv9ppg8OcDxlXhGjlPBLID1hGk9O3d9wH3oyUI6w5
         MUl7A9Msm/fe6uAQsqmrSRqSAu86iH731IeJ+WWHcv769KCaB/hvwJ1UfnFhk0lHRpFC
         oaLg==
X-Gm-Message-State: AAQBX9dYgc/Q9JgVfqKDVUtlg4iobnBK7XswLoWL8E3FzeEUFnBQvpxN
        opOvpQuu/jOOKGC9QpMb9GQJ5hQRVKEHE14S4ybqqw==
X-Google-Smtp-Source: AKy350Zr3/bsC8HMJr79Ki3V1zJSQEQ7UB4oeK7ej/6KDeIZA8o7EtLz7VX3T9RLPjj/vCtvysI/Is120+XpGkII+LQ=
X-Received: by 2002:a81:507:0:b0:533:a15a:d33e with SMTP id
 7-20020a810507000000b00533a15ad33emr1449251ywf.5.1679556648373; Thu, 23 Mar
 2023 00:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679474247.git.mazziesaccount@gmail.com> <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
In-Reply-To: <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 23 Mar 2023 15:30:34 +0800
Message-ID: <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device creation
To:     Matti Vaittinen <mazziesaccount@gmail.com>
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006f05da05f78c4127"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000006f05da05f78c4127
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Mar 2023 at 17:06, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> The creation of a dummy device in order to test managed interfaces is a
> generally useful test feature. The drm test helpers
> drm_kunit_helper_alloc_device() and drm_kunit_helper_free_device()
> are doing exactly this. It makes no sense that each and every component
> which intends to be testing managed interfaces will create similar
> helpers so stole these for more generic use.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> ---
> Changes:
> v4 => v5:
> - Add accidentally dropped header and email recipients
> - do not rename + move helpers from DRM but add temporary dublicates to
>   simplify merging. (This patch does not touch DRM and can be merged
>   separately. DRM patch and IIO test patch still depend on this one).
>
> Please note that there's something similar ongoing in the CCF:
> https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
>
> I do like the simplicity of these DRM-originated helpers so I think
> they're worth. I do equally like the Stephen's idea of having the
> "dummy platform device" related helpers under drivers/base and the
> header being in include/kunit/platform_device.h which is similar to real
> platform device under include/linux/platform_device.h
> ---

Thanks for sending this my way.

It's clear we need some way of creating "fake" devices for KUnit
tests. Given that there are now (at least) three different drivers
looking to use this, we'll ultimately need something which works for
everyone.

I think the questions we therefore need to answer are:
- Do we specifically need a platform_device (or, any other specific
device struct), or would any old struct device work? I can see why we
would need a platform device for cases where we're testing things like
device-tree properties (or, in the future, having e.g. USB-specific
helpers which create usb_device). Most tests just use
root_device_register() thus far, though.
- What helpers do we need to make creating, using, and cleaning up
these devices as simple as possible.

I think that in this particular case, we don't actually need a struct
platform_device. Replacing these helpers with simple calls to
root_device_register() and root_device_unregister() seems to work fine
with this patch series for me. (It does break the
drm_test_managed_run_action test, though.) So I don't think having
these helpers actually help this series at the moment.

That being said, if they used the KUnit resource system to
automatically clean up the device when the test is finished (or
otherwise exits), that would seem like a real advantage. The clk and
drm examples both do this, and I'm hoping to add an API to make it
even simpler going forward. (With the work-in-progress API described
here[1], the whole thing should boil down to "struct device *dev =
root_device_register(name); kunit_defer(root_device_unregister,
dev);".)

So, I guess we have three cases we need to look at:
- A test just needs any old struct device. Tests thus far have
hardcoded, or had their own wrappers around root_device_register() for
this.
- A test needs a device attached to a bus (but doesn't care which
bus). Thus far, people have used struct platform_device for this (see
the DRM helpers, which use a platform device for managed resource
tests[2]). Maybe the right solution here is something like a struct
kunit_device?
- A test needs a device attached to a specific bus. We'll probably
need some more detailed faking of that bus. This covers cases like
having fake USB devices, devicetree integration, etc.

I'd suggest that, for the majority of cases which only care about the
first case, let's just use root_device_register() directly, or have a
thin wrapper like the old root_device-based version of the DRM
helpers[3]. This will probable serve us well enough while we work out
how to handle the other two cases properly (which is already being
looked at for the CLK/DeviceTree patches and the DRM stuff).

If the resulting helpers are generally useful enough, they can
probably sit in either drivers/base or lib/kunit. I'd rather not have
code that's really specific to certain busses sitting in lib/kunit
rather than alongside the device/bus code in drivers/base or some
other subsystem/driver path, but I can tolerate it for the very
generic struct device.

Regardless, I've left a few notes on the patch itself below.

Cheers,
-- David

[1]: https://kunit-review.googlesource.com/c/linux/+/5434/3/include/kunit/resource.h
[2]: https://lore.kernel.org/all/20221123-rpi-kunit-tests-v3-8-4615a663a84a@cerno.tech/
[3]: https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/tests/drm_kunit_helpers.c#L39
>  drivers/base/test/Kconfig             |  5 ++
>  drivers/base/test/Makefile            |  2 +
>  drivers/base/test/test_kunit_device.c | 83 +++++++++++++++++++++++++++
>  include/kunit/platform_device.h       | 13 +++++
>  4 files changed, 103 insertions(+)
>  create mode 100644 drivers/base/test/test_kunit_device.c
>  create mode 100644 include/kunit/platform_device.h
>
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 610a1ba7a467..642b5b183c10 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -1,4 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +config TEST_KUNIT_DEVICE_HELPERS
> +       depends on KUNIT
> +       tristate
> +
>  config TEST_ASYNC_DRIVER_PROBE
>         tristate "Build kernel module to test asynchronous driver probing"
>         depends on m
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index 7f76fee6f989..49926524ec6f 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  += test_async_driver_probe.o
>
> +obj-$(CONFIG_TEST_KUNIT_DEVICE_HELPERS) += test_kunit_device.o
> +
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
>  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/base/test/test_kunit_device.c b/drivers/base/test/test_kunit_device.c
> new file mode 100644
> index 000000000000..75790e15b85c
> --- /dev/null
> +++ b/drivers/base/test/test_kunit_device.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * These helpers have been extracted from drm test code at
> + * drm_kunit_helpers.c which was authored by
> + * Maxime Ripard <maxime@cerno.tech>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/platform_device.h>
> +
> +#define KUNIT_DEVICE_NAME      "test-kunit-mock-device"

Personally, I'd really rather this be a name passed in by the test.
What if a test needs to create multiple distinct devices?

> +
> +static int fake_probe(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +
> +static int fake_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +
> +static struct platform_driver fake_platform_driver = {
> +       .probe  = fake_probe,
> +       .remove = fake_remove,
> +       .driver = {
> +               .name   = KUNIT_DEVICE_NAME,
> +       },
> +};
> +
> +/**
> + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
> + * @test: The test context object
> + *
> + * This allocates a fake struct &device to create a mock for a KUnit
> + * test. The device will also be bound to a fake driver. It will thus be
> + * able to leverage the usual infrastructure and most notably the
> + * device-managed resources just like a "real" device.
> + *
> + * Callers need to make sure test_kunit_helper_free_device() on the
> + * device when done.
> + *
> + * Returns:
> + * A pointer to the new device, or an ERR_PTR() otherwise.
> + */
> +struct device *test_kunit_helper_alloc_device(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       ret = platform_driver_register(&fake_platform_driver);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       ret = platform_device_add(pdev);
> +       KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +       return &pdev->dev;
> +}
> +EXPORT_SYMBOL_GPL(test_kunit_helper_alloc_device);
> +
> +/**
> + * test_kunit_helper_free_device - Frees a mock device
> + * @test: The test context object
> + * @dev: The device to free
> + *
> + * Frees a device allocated with test_kunit_helper_alloc_device().
> + */

This really should be automatically called when the test exits,
probably using kunit reources. Ideally, there'd also be a function to
free it earlier, which can be done by calling kunit_remove_resource()
to lower the refcount.

> +void test_kunit_helper_free_device(struct kunit *test, struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +
> +       platform_device_unregister(pdev);
> +       platform_driver_unregister(&fake_platform_driver);
> +}
> +EXPORT_SYMBOL_GPL(test_kunit_helper_free_device);
> +
> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
> new file mode 100644
> index 000000000000..2a9c7bdd75eb
> --- /dev/null
> +++ b/include/kunit/platform_device.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __KUNIT_PLATFORM_DEVICE__
> +#define __KUNIT_PLATFORM_DEVICE__
> +
> +#include <kunit/test.h>
> +
> +struct device;
> +
> +struct device *test_kunit_helper_alloc_device(struct kunit *test);
> +void test_kunit_helper_free_device(struct kunit *test, struct device *dev);

If these helpers are supposed to guarantee that the resulting device
is a platform device, let's reflect that in their names. Otherwise,
let's not put this in a platform_device.h header, but maybe something
more general, like kunit/device.h.

> +
> +#endif
> --
> 2.39.2
>
>
> --
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =]

--0000000000006f05da05f78c4127
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDi
ch0mE7rBc0a2+AdEcEAhnOHDyXe2BhNrPQNNAzpIHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjMwNzMwNDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApPJUBNe5iVhCmuNwpchl
Xa9rvZ306yqRVKVGF9+in/L3jk/Egvxg25lqOQcIGpN6FCV4V/VupJ2jtS5Gr4oGtHqACWuYI65N
etjFLZ4mxfVf/foStLDdrxRHoGdPXv8V8TBV/cbI7eKittARfP7PE8vlhRY+mdNcutMuxlCB0MPz
mRgdZWtewQXpZUuVBApR9vhvuPk2YtS1rZCYLvHCNOWAxQZNhXgqPR3slTLWFU+0EfbCjAeS+/S3
DE5P/Cayq/FRB/S5kEkm3yXm5Q+/yoim+iL7LRZvklW6tkiXKf4rbE6YvBjTBQOfR5Nh8dqvG9EV
VqpcT9+SsK0X6VC0HQ==
--0000000000006f05da05f78c4127--
