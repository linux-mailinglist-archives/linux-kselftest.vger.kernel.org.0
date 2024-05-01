Return-Path: <linux-kselftest+bounces-9184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E61D8B869F
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269792856B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0379502B4;
	Wed,  1 May 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYoOhIkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD850248
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550161; cv=none; b=HkwAn9WBOmobZp8+sHOHiUG5LrMoxE98of5zYmEGqgUqkN1o3yqqJIxnovdpzt+ZLkPqew1wGcAvunbAyQ/jtTm/0zm1URygz47PJxq/KUmJpABM/yCBxiZaPAJ2US9m1oY0Fsm3B6O61HqoZh5q5twbWcXym6ne4I7kikLuexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550161; c=relaxed/simple;
	bh=CSSrKBrI8rSo+sPUYhzsd8kFaQ9NuUciBil+n4XQjdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTQ4eaXnVaPcAAoXKHOUGmMaY6YkvQxd71dN4tAuY4ezAIkwSoUPe+YcZlAziAeMciwBjFn8mY5zQMIwal4QAPHW4jtCtgY3K8S0NYx87ur9x1yfy5TM9+FaxDa+a0n7hAD/ehwfYmE3usvzxImVIjg4WLLraht+0j08h0G/f5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYoOhIkI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436ed871225so161721cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714550158; x=1715154958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nKPj7WgaJNMFfJtQ/FG3JQFTpsBOMZOHf0AN13j3WOY=;
        b=ZYoOhIkIUZzXIGzrhgDwJodYa4wPWO+Tfl8WK+MdALqAwrfLWuAc3bCmS3E7AMSYwY
         /bjlhrMpqPxTYyYWzyDdgaGEPBfrQfCpjvwPfB2y9ErNvGnE/Hhf+JiIRTgUN/U5kwnJ
         J5yNxh1Dj3MD5Cf/N1rThcUC77/4Sd+ub+Iy8Gey0YhX5/tqWGjX90MTqWtqs8ByvZqL
         lkmbVqqmRfjITZovFO8GcrdiwArfAhiaGLMRzTwjVvC4YU8beE1LcfoUbPt5m9pgord0
         oYImQWmnZq9uhCwFNBhNusdlOM0eWsOjqeDX94cnvkuxFItP6f3twfMxLmTMJrvCNpzv
         rBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714550158; x=1715154958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKPj7WgaJNMFfJtQ/FG3JQFTpsBOMZOHf0AN13j3WOY=;
        b=B+ilJ58hoV71P77cLhdxP3Q5ymWzJBQ/aKSa6BGUbkn18Bk7jJcjNov7kfT3CWZWdu
         fhf/Uks4fFp2rM4qdjk0gEVCw8z8kKyDHk5Y/YDZ5CmERs76721aPSEhlqHclfLvR6zC
         dogz+JZFORpsOGKu1YS+/BYKVPpuZNoOsQEFyYc4zW9bORNJ4WgwrlOsHKiREeiJYSJG
         DsCKxrr7zcUAqXs30XnrEqsJ8lu2r/P2vBMjnjbSLSUiesuFMDzo8d5fq7JlwtMqLhVl
         XTgWTqdcONxbnB/K8sDGNIzzEej3bs0+1NARc68esjxXSYwfgv6JV+2ryVi6piajkpBL
         aJhg==
X-Forwarded-Encrypted: i=1; AJvYcCUeeGzecafRi/Yp337uEsUDJhq6GS82vhsT9gpEi3ZCbSLGGjrsf1cZXbZ4bqRe/wuupw5J3qRfr5d4InOH5RCFY+CDlwVvnQEv56datpVC
X-Gm-Message-State: AOJu0YxW3kovz7WQIkMCtxcFennZTu6t/3EI/XpJg9UXDeURz3t878Di
	1hOzl+BVzdGhb/3sYws3pxASddwRNUEAM8ynG8VOJrks0nQramyO6D2/tA98YYlur3KpZwWzTy6
	wLMLMyAZJ4vtFEJ8AjMDKWk8d/LtaFJLDqMW9
X-Google-Smtp-Source: AGHT+IHy074AJAQD+kIGxioi1jE3Fxsh7zAyKazw101oENvAqcfz+MKXVOKyQ+q6z7ckyY/XFWSM33UFk0LNgeIirk8=
X-Received: by 2002:a05:622a:34b:b0:43a:ccf3:8160 with SMTP id
 r11-20020a05622a034b00b0043accf38160mr205599qtw.14.1714550157864; Wed, 01 May
 2024 00:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org>
In-Reply-To: <20240422232404.213174-6-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 1 May 2024 15:55:46 +0800
Message-ID: <CABVgOSk=jGzj55v+YWzOBCsG7Wdk68pyZr0VdAYftybv+5X67A@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver
 APIs
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000222a1c06175fd152"

--000000000000222a1c06175fd152
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
>
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

I really like this: I think it'll definitely help make platform
devices easier to use in tests. (And the handling of the unregistering
is particularly much nicer than trying to do it by hand, IMO.)

I've got a few suggestions below, mostly around naming and that it's
probably best to put this in lib/kunit/, given that the header is in
include/kunit, and there's already the generic kunit_device
functionality there. There's also a control-flow-integrity issue or
two, as casting function pointers will trigger that.

Otherwise, this looks good.

-- David

>  Documentation/dev-tools/kunit/api/index.rst   |   5 +
>  .../dev-tools/kunit/api/platformdevice.rst    |  10 +
>  drivers/base/test/Makefile                    |   3 +
>  drivers/base/test/platform_kunit-test.c       | 140 ++++++++++++++
>  drivers/base/test/platform_kunit.c            | 174 ++++++++++++++++++
>  include/kunit/platform_device.h               |  15 ++
>  6 files changed, 347 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
>  create mode 100644 drivers/base/test/platform_kunit-test.c
>  create mode 100644 drivers/base/test/platform_kunit.c
>  create mode 100644 include/kunit/platform_device.h
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index 282befa17edf..02b26f5e8750 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -10,6 +10,7 @@ API Reference
>         resource
>         functionredirection
>         of
> +       platformdevice

A note (to myself, as much as anything): for the other device
wrappers, we considered them 'resources' and so bundled the
documentation in with the 'resource' documentation.
Maybe it'd make sense to split it out into its own device.rst file. We
could optionally include the platformdevice stuff in the same file if
we wanted to consolidate documentation for "device helpers", though
I'm not sure if it's worthwhile.

>
>
>  This page documents the KUnit kernel testing API. It is divided into the
> @@ -36,3 +37,7 @@ Driver KUnit API
>  Documentation/dev-tools/kunit/api/of.rst
>
>   - Documents the KUnit device tree (OF) API
> +
> +Documentation/dev-tools/kunit/api/platformdevice.rst
> +
> + - Documents the KUnit platform device API
> diff --git a/Documentation/dev-tools/kunit/api/platformdevice.rst b/Documentation/dev-tools/kunit/api/platformdevice.rst
> new file mode 100644
> index 000000000000..b228fb6558c2
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/api/platformdevice.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +Platform Device API
> +===================
> +
> +The KUnit platform device API is used to test platform devices.
> +
> +.. kernel-doc:: drivers/base/test/platform_kunit.c
> +   :export:
> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index e321dfc7e922..740aef267fbe 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -1,8 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  += test_async_driver_probe.o
>
> +obj-$(CONFIG_KUNIT) += platform_kunit.o
> +

Do we want this to be part of the kunit.ko module (and hence,
probably, under lib/kunit), or to keep this as a separate module.
I'm tempted, personally, to treat this as a part of KUnit, and have it
be part of the same module. There are a couple of reasons for this:
- It's nice to have CONFIG_KUNIT produce only one module. If we want
this to be separate, I'd be tempted to put it behind its own kconfig
entry.
- The name platform_kunit.ko suggests (to me, at least) that this is
the test for platform devices, not the implementation of the helper.

I probably can be persuaded otherwise if you've got a strong
preference for it to stay as-is, though.

>  obj-$(CONFIG_DM_KUNIT_TEST)    += root-device-test.o
>  obj-$(CONFIG_DM_KUNIT_TEST)    += platform-device-test.o
> +obj-$(CONFIG_DM_KUNIT_TEST)    += platform_kunit-test.o
>
>  obj-$(CONFIG_DRIVER_PE_KUNIT_TEST) += property-entry-test.o
>  CFLAGS_property-entry-test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> diff --git a/drivers/base/test/platform_kunit-test.c b/drivers/base/test/platform_kunit-test.c
> new file mode 100644
> index 000000000000..ce545532d209
> --- /dev/null
> +++ b/drivers/base/test/platform_kunit-test.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for platform driver infrastructure.
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include <kunit/platform_device.h>
> +#include <kunit/test.h>
> +
> +static const char * const kunit_devname = "kunit-platform";
> +
> +/*
> + * Test that platform_device_alloc_kunit() creates a platform device.
> + */
> +static void platform_device_alloc_kunit_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                       platform_device_alloc_kunit(test, kunit_devname, 1));
> +}
> +
> +/*
> + * Test that platform_device_add_kunit() registers a platform device on the
> + * platform bus with the proper name and id.
> + */
> +static void platform_device_add_kunit_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = kunit_devname;
> +       const int id = -1;
> +
> +       pdev = platform_device_alloc_kunit(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       KUNIT_EXPECT_EQ(test, 0, platform_device_add_kunit(test, pdev));
> +       KUNIT_EXPECT_TRUE(test, dev_is_platform(&pdev->dev));
> +       KUNIT_EXPECT_STREQ(test, pdev->name, name);
> +       KUNIT_EXPECT_EQ(test, pdev->id, id);
> +}
> +
> +/*
> + * Test that platform_device_add_kunit() called twice with the same device name
> + * and id fails the second time and properly cleans up.
> + */
> +static void platform_device_add_kunit_twice_fails_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = kunit_devname;
> +       const int id = -1;
> +
> +       pdev = platform_device_alloc_kunit(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, platform_device_add_kunit(test, pdev));
> +
> +       pdev = platform_device_alloc_kunit(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       KUNIT_EXPECT_NE(test, 0, platform_device_add_kunit(test, pdev));
> +}
> +
> +/*
> + * Test suite for struct platform_device kunit APIs
> + */
> +static struct kunit_case platform_device_kunit_test_cases[] = {
> +       KUNIT_CASE(platform_device_alloc_kunit_test),
> +       KUNIT_CASE(platform_device_add_kunit_test),
> +       KUNIT_CASE(platform_device_add_kunit_twice_fails_test),
> +       {}
> +};
> +
> +static struct kunit_suite platform_device_kunit_suite = {
> +       .name = "platform_device_kunit",
> +       .test_cases = platform_device_kunit_test_cases,
> +};
> +
> +struct kunit_platform_driver_test_context {
> +       struct platform_driver pdrv;
> +       const char *data;
> +};
> +
> +static const char * const test_data = "test data";
> +
> +static inline struct kunit_platform_driver_test_context *
> +to_test_context(struct platform_device *pdev)
> +{
> +       return container_of(to_platform_driver(pdev->dev.driver),
> +                           struct kunit_platform_driver_test_context,
> +                           pdrv);
> +}
> +
> +static int kunit_platform_driver_probe(struct platform_device *pdev)
> +{
> +       struct kunit_platform_driver_test_context *ctx;
> +
> +       ctx = to_test_context(pdev);
> +       ctx->data = test_data;
> +
> +       return 0;
> +}
> +
> +/* Test that platform_driver_register_kunit() registers a driver that probes. */
> +static void platform_driver_register_kunit_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct kunit_platform_driver_test_context *ctx;
> +
> +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +       pdev = platform_device_alloc_kunit(test, kunit_devname, -1);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, platform_device_add_kunit(test, pdev));
> +
> +       ctx->pdrv.probe = kunit_platform_driver_probe;
> +       ctx->pdrv.driver.name = kunit_devname;
> +       ctx->pdrv.driver.owner = THIS_MODULE;
> +
> +       KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(test, &ctx->pdrv));
> +       KUNIT_EXPECT_STREQ(test, ctx->data, test_data);
> +}
> +
> +static struct kunit_case platform_driver_kunit_test_cases[] = {
> +       KUNIT_CASE(platform_driver_register_kunit_test),
> +       {}
> +};
> +
> +/*
> + * Test suite for struct platform_driver kunit APIs
> + */
> +static struct kunit_suite platform_driver_kunit_suite = {
> +       .name = "platform_driver_kunit",
> +       .test_cases = platform_driver_kunit_test_cases,
> +};
> +
> +kunit_test_suites(
> +       &platform_device_kunit_suite,
> +       &platform_driver_kunit_suite,
> +);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/platform_kunit.c
> new file mode 100644
> index 000000000000..54af6db2a6d8
> --- /dev/null
> +++ b/drivers/base/test/platform_kunit.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test managed platform driver
> + */
> +
> +#include <linux/device/driver.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/platform_device.h>
> +#include <kunit/resource.h>
> +
> +/**
> + * platform_device_alloc_kunit() - Allocate a KUnit test managed platform device
> + * @test: test context
> + * @name: device name of platform device to alloc
> + * @id: identifier of platform device to alloc.
> + *
> + * Allocate a test managed platform device. The device is put when the test completes.
> + *
> + * Return: Allocated platform device on success, NULL on failure.
> + */
> +struct platform_device *
> +platform_device_alloc_kunit(struct kunit *test, const char *name, int id)

I'd prefer, personally, this be named something like
kunit_platform_device_alloc(), to match the existing
kunit_device_register() functions.


> +{
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_alloc(name, id);
> +       if (!pdev)
> +               return NULL;
> +
> +       if (kunit_add_action_or_reset(test, (kunit_action_t *)&platform_device_put, pdev))

Alas, casting function pointers to kunit_action_t* breaks CFI. It's
worth using a wrapper, which can be created with the
KUNIT_DEFINE_ACTION_WRAPPER() macro, e.g.

KUNIT_DEFINE_ACTION_WRAPPER(platform_device_put_wrapper,
platform_device_put, struct platform_device *);

> +               return NULL;
> +
> +       return pdev;
> +}
> +EXPORT_SYMBOL_GPL(platform_device_alloc_kunit);
> +
> +static void platform_device_add_kunit_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev = res->data;
> +
> +       platform_device_unregister(pdev);
> +}
> +
> +static bool
> +platform_device_alloc_kunit_match(struct kunit *test,
> +                                 struct kunit_resource *res, void *match_data)
> +{
> +       struct platform_device *pdev = match_data;
> +
> +       return res->data == pdev;
> +}
> +
> +/**
> + * platform_device_add_kunit() - Register a KUnit test managed platform device
> + * @test: test context
> + * @pdev: platform device to add
> + *
> + * Register a test managed platform device. The device is unregistered when the
> + * test completes.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int platform_device_add_kunit(struct kunit *test, struct platform_device *pdev)

As above, I'd lean towards naming this kunit_platform_device_add() for
consistency with the other KUnit device helpers.

> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       ret = platform_device_add(pdev);
> +       if (ret)
> +               return ret;
> +
> +       res = kunit_find_resource(test, platform_device_alloc_kunit_match, pdev);
> +       if (res) {
> +               /*
> +                * Transfer the reference count of the platform device if it was
> +                * allocated with platform_device_alloc_kunit(). In that case,
> +                * calling platform_device_put() leads to reference count
> +                * underflow because platform_device_unregister() does it for
> +                * us and we call platform_device_unregister() from
> +                * platform_device_add_kunit_exit().
> +                *
> +                * Usually callers transfer the refcount from
> +                * platform_device_alloc() to platform_device_add() and simply
> +                * call platform_device_unregister() when done, but with kunit
> +                * we have to keep this straight by redirecting the free
> +                * routine for the resource.
> +                */
> +               res->free = platform_device_add_kunit_exit;
> +               kunit_put_resource(res);
> +       } else if (kunit_add_action_or_reset(test,
> +                                            (kunit_action_t *)&platform_device_unregister,
> +                                            pdev)) {

Nit: We don't want to cast directly to kunit_action_t *, as that
breaks CFI. Can we use KUNIT_DEFINE_ACTION_WRAPPER()?

> +               return -ENOMEM;

Nit: This is fine, as kunit_add_action_or_reset() only returns 0 or
-ENOMEM at the moment, but it could cause problems down the line if we
ever want to return a different error. I don't think that's
particularly likely, but it might be nicer to properly propagate the
error.

> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_device_add_kunit);
> +
> +/**
> + * platform_driver_register_kunit() - Register a KUnit test managed platform driver
> + * @test: test context
> + * @drv: platform driver to register
> + *
> + * Register a test managed platform driver. This allows callers to embed the
> + * @drv in a container structure and use container_of() in the probe function
> + * to pass information to KUnit tests. It can be assumed that the driver has
> + * probed when this function returns.
> + *
> + * Example
> + *
> + * .. code-block:: c
> + *
> + *     struct kunit_test_context {
> + *             struct platform_driver pdrv;
> + *             const char *data;
> + *     };
> + *
> + *     static inline struct kunit_test_context *
> + *     to_test_context(struct platform_device *pdev)
> + *     {
> + *             return container_of(to_platform_driver(pdev->dev.driver),
> + *                                 struct kunit_test_context,
> + *                                 pdrv);
> + *     }
> + *
> + *     static int kunit_platform_driver_probe(struct platform_device *pdev)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx = to_test_context(pdev);
> + *             ctx->data = "test data";
> + *
> + *             return 0;
> + *     }
> + *
> + *     static void kunit_platform_driver_test(struct kunit *test)
> + *     {
> + *             struct kunit_test_context *ctx;
> + *
> + *             ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> + *
> + *             ctx->pdrv.probe = kunit_platform_driver_probe;
> + *             ctx->pdrv.driver.name = "kunit-platform";
> + *             ctx->pdrv.driver.owner = THIS_MODULE;
> + *
> + *             KUNIT_EXPECT_EQ(test, 0, platform_driver_register_kunit(test, &ctx->pdrv));
> + *             KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> + *     }
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int platform_driver_register_kunit(struct kunit *test,
> +                                  struct platform_driver *drv)

As above, I'd prefer kunit_platform_driver_register()

> +{
> +       int ret;
> +
> +       ret = platform_driver_register(drv);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Wait for the driver to probe (or at least flush out of the deferred
> +        * workqueue)
> +        */
> +       wait_for_device_probe();

Personally, I don't mind if this wrapper waits here (even if it makes
it less of a 'pure' wrapper), so long as we document it. Can you think
of any cases where we explicitly want _not_ to wait in a test?


> +
> +       return kunit_add_action_or_reset(test,
> +                                        (kunit_action_t *)&platform_driver_unregister,
> +                                        drv);
> +}
> +EXPORT_SYMBOL_GPL(platform_driver_register_kunit);
> diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
> new file mode 100644
> index 000000000000..28d28abf15a4
> --- /dev/null
> +++ b/include/kunit/platform_device.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_PLATFORM_DRIVER_H
> +#define _KUNIT_PLATFORM_DRIVER_H
> +
> +struct kunit;
> +struct platform_device;
> +struct platform_driver;
> +
> +struct platform_device *
> +platform_device_alloc_kunit(struct kunit *test, const char *name, int id);
> +int platform_device_add_kunit(struct kunit *test, struct platform_device *pdev);
> +
> +int platform_driver_register_kunit(struct kunit *test, struct platform_driver *drv);
> +
> +#endif
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240422232404.213174-6-sboyd%40kernel.org.

--000000000000222a1c06175fd152
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIMNjMPEp0bhYGn1lF0UuG7eO7vOeBVZJ6dviUDJb9R6XMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwMTA3NTU1OFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBhnvFT
yvHpM77ldiYQoUCfhsghSGLvs0Qbj8eKftmv7jC42SDmDjF1h5DsZqkQNIsovY4JM+LCFM0G6Gni
KzXMly38lFfFmjLBcdYU3iKSG1nvRD7AtSqOMbZ5UiFcyRjJmd8nhzqeDR+pWg+IdR4kU+z3zxVo
DNWnpZpUC5dGdp6JVN5hjte+X76mt9kwBgoSW4Ym4ESI3Q18YE3W/JiUKKtorpHvcqSRhVB3W+kg
hS0zAolqo5YVRQRkZDfmaxFNPi02WJsZWBXVP2UBKSw/wlrCSW4Z/bE8HW8tHgNIihbJwyA2F9LW
sIEtbpTyNdid8ch04FeJXHKrclnwe2y1
--000000000000222a1c06175fd152--

