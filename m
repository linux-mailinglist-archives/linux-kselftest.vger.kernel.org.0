Return-Path: <linux-kselftest+bounces-11836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83C9065A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010D11C215F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C4013C9CF;
	Thu, 13 Jun 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8lkrUJS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851713C9C8
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265033; cv=none; b=Dob56W58opRoz4p6KPi1R6z9p97E9Zj0e9etbdtOPAnCjr2L4hLvLnvE8iVSL8LTuP/n7JLbMqoeEwJotHtlk5NRAucGF9ZPcJmpicLHaA/Ii2JEyhluigHkx1B/kDlu17ZFCeQApD9ou38u7IXJwmKxdEtwK4uH/WTVctb0n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265033; c=relaxed/simple;
	bh=5axXFLiU56ej6iAlwCxgImG09sIO5GEu56CrXTX6tYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAau1/vzLN/jPPZ256uQMwr41gu+nMzXZ7pgTyAeuefluiAcjrn4/3pNecYJ2CN9no2udejLbzGi01YughsJAFksY+iBjpMeeq207wsUKwccgbBMwxAB8zk+cR06EjbTBdMuoNZ4MbnlhXcb0OYCwZHHpeStcwPRLa0NTKZyIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8lkrUJS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405dffca81so120401cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718265029; x=1718869829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVUxylfqFCkJKEsBb+h9HTdEGGn8QwMJdfC0Seit0Ww=;
        b=l8lkrUJSW6lT2xrC9AxgyYgs1QOyKzNIhENVuuvv7XJuh23d5fmzDMh7liWe1EX52O
         4lfssp5/RufNtl/PclJd/9RVwSKVfWw3mukKnHTpbb7lJV5HMdYCQZBlPgrH54/uu2U3
         jV5x3PqtxLcX3r3VYT/L89oozJ28c1WeJWcNM576dI4lOfwDWHv/cb2t1QbcqK5CVfYq
         9dPs1++hju/6KusirDEaLE6HQFOrFrpS8Kp5CzXnlCwuq1H/fDzhdM4zOoJrEKgPsrNx
         iG0hAL7PHcgFE8tkcONwgkCKRr9KuLIxouOXRfu2fA04ogs5QDYgWk2YFvwuaPFJxQ2k
         Kbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265029; x=1718869829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVUxylfqFCkJKEsBb+h9HTdEGGn8QwMJdfC0Seit0Ww=;
        b=w8bqKwVRrop4sZ9UXSZu6rE/RgkLXw6rjhZAKNGAq4c+KGaVAckWZr39v4q1MmTmIv
         khunoXQMe6dU9cAdYDY6caF/W7V7tgZSWOKN2hIgcVEpuwTUBFRTWmUV6eYPLiBpVL+Q
         OFrnPNcA5e452WMvYDAuA7TL24oBoTzYI2/Tkbyjq3E/od1WpQEJY9JbUp+4QOrafQWr
         EsA694IU9RHwBAXcPfe/ZRLdxwNuWczu+KKctDcVcbGGzmwDhfohtATkwxh8ue8boyuR
         ZLI1YLR1kT6QyqB3G+p0/TJwrzdQNQqGsnHN7Bx7oJLEbT1dH3tDPQnEJepwnBiro9h0
         sRQA==
X-Forwarded-Encrypted: i=1; AJvYcCWecdZi9eyflU48Iio1MakvlM4rXVmBzkBfMQkwg+p1mBRGV+iWZTXw7NXdn0yzITwNSruoR1+OBae+K+gw/qk7O/TsjjnleZ25psxplRd2
X-Gm-Message-State: AOJu0YygmLpQTurWvQ/lPYtbw220fAnuNsAVU/gMLzskmI36MRDCEg+B
	4+drDKOshZl5EPkyn1cyYbW6XcJVeKRA3yRj2PR1A22VgFQcKF8AE5boDuUm64qUcMx8/1sb5ag
	8gtUM4Hu1twMdBasIr7wtT0etSurrh+S1/8oA
X-Google-Smtp-Source: AGHT+IFdU8P4U7BkeL+GaRcMEegAO28T6zs/xDX0n17xlUK0ETTFxa6kZ3EKv5dj4i6IEKZOyQN8y982TD5Plsho0UA=
X-Received: by 2002:a05:622a:1c08:b0:440:4673:9854 with SMTP id
 d75a77b69052e-441eea6061bmr1292471cf.21.1718265029167; Thu, 13 Jun 2024
 00:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-7-sboyd@kernel.org>
In-Reply-To: <20240603223811.3815762-7-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 13 Jun 2024 15:50:18 +0800
Message-ID: <CABVgOSm=R2-SvCRLsep_2Zk20eq7rg_RBvXK4ZYWvjWnmpboKA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] platform: Add test managed platform_device/driver
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
	boundary="000000000000bb15bb061ac0c052"

--000000000000bb15bb061ac0c052
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 06:38, Stephen Boyd <sboyd@kernel.org> wrote:
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

This looks great, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/api/index.rst   |   5 +
>  .../dev-tools/kunit/api/platformdevice.rst    |  10 +
>  include/kunit/platform_device.h               |  20 ++
>  lib/kunit/Makefile                            |   4 +-
>  lib/kunit/platform-test.c                     | 223 +++++++++++++
>  lib/kunit/platform.c                          | 302 ++++++++++++++++++
>  6 files changed, 563 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
>  create mode 100644 include/kunit/platform_device.h
>  create mode 100644 lib/kunit/platform-test.c
>  create mode 100644 lib/kunit/platform.c
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
> index 000000000000..49ddd5729003
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
> +.. kernel-doc:: lib/kunit/platform.c
> +   :export:
> diff --git a/include/kunit/platform_device.h b/include/kunit/platform_device.h
> new file mode 100644
> index 000000000000..0fc0999d2420
> --- /dev/null
> +++ b/include/kunit/platform_device.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _KUNIT_PLATFORM_DRIVER_H
> +#define _KUNIT_PLATFORM_DRIVER_H
> +
> +struct kunit;
> +struct platform_device;
> +struct platform_driver;
> +
> +struct platform_device *
> +kunit_platform_device_alloc(struct kunit *test, const char *name, int id);
> +int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev);
> +
> +int kunit_platform_device_prepare_wait_for_probe(struct kunit *test,
> +                                                struct platform_device *pdev,
> +                                                struct completion *x);
> +
> +int kunit_platform_driver_register(struct kunit *test,
> +                                  struct platform_driver *drv);
> +
> +#endif
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 309659a32a78..a980ae62eff6 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -8,7 +8,8 @@ kunit-objs +=                           test.o \
>                                         try-catch.o \
>                                         executor.o \
>                                         attributes.o \
> -                                       device.o
> +                                       device.o \
> +                                       platform.o
>
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=                          debugfs.o
> @@ -18,6 +19,7 @@ endif
>  obj-y +=                               hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=            platform-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/platform-test.c b/lib/kunit/platform-test.c
> new file mode 100644
> index 000000000000..b4fbedadc55e
> --- /dev/null
> +++ b/lib/kunit/platform-test.c
> @@ -0,0 +1,223 @@
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
> +/*
> + * Test that kunit_platform_device_alloc() creates a platform device.
> + */
> +static void kunit_platform_device_alloc_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                       kunit_platform_device_alloc(test, "kunit-platform", 1));
> +}
> +
> +/*
> + * Test that kunit_platform_device_add() registers a platform device on the
> + * platform bus with the proper name and id.
> + */
> +static void kunit_platform_device_add_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = "kunit-platform-add";
> +       const int id = -1;
> +
> +       pdev = kunit_platform_device_alloc(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       KUNIT_EXPECT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +       KUNIT_EXPECT_TRUE(test, dev_is_platform(&pdev->dev));
> +       KUNIT_EXPECT_STREQ(test, pdev->name, name);
> +       KUNIT_EXPECT_EQ(test, pdev->id, id);
> +}
> +
> +/*
> + * Test that kunit_platform_device_add() called twice with the same device name
> + * and id fails the second time and properly cleans up.
> + */
> +static void kunit_platform_device_add_twice_fails_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = "kunit-platform-add-2";
> +       const int id = -1;
> +
> +       pdev = kunit_platform_device_alloc(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +
> +       pdev = kunit_platform_device_alloc(test, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +       KUNIT_EXPECT_NE(test, 0, kunit_platform_device_add(test, pdev));
> +}
> +
> +static int kunit_platform_device_find_by_name(struct device *dev, const void *data)
> +{
> +       return strcmp(dev_name(dev), data) == 0;
> +}
> +
> +/*
> + * Test that kunit_platform_device_add() cleans up by removing the platform
> + * device when the test finishes. */
> +static void kunit_platform_device_add_cleans_up(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       const char *name = "kunit-platform-clean";
> +       const int id = -1;
> +       struct kunit fake;
> +       struct device *dev;
> +
> +       kunit_init_test(&fake, "kunit_platform_device_add_fake_test", NULL);
> +       KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);
> +
> +       pdev = kunit_platform_device_alloc(&fake, name, id);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(&fake, pdev));
> +       dev = bus_find_device(&platform_bus_type, NULL, name,
> +                             kunit_platform_device_find_by_name);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +       put_device(dev);
> +
> +       /* Remove pdev */
> +       kunit_cleanup(&fake);
> +
> +       /*
> +        * Failing to migrate the kunit_resource would lead to an extra
> +        * put_device() call on the platform device. The best we can do here is
> +        * make sure the device no longer exists on the bus, but if something
> +        * is wrong we'll see a refcount underflow here. We can't test for a
> +        * refcount underflow because the kref matches the lifetime of the
> +        * device which should already be freed and could be used by something
> +        * else.
> +        */
> +       dev = bus_find_device(&platform_bus_type, NULL, name,
> +                             kunit_platform_device_find_by_name);
> +       KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
> +       put_device(dev);
> +}
> +
> +/*
> + * Test suite for struct platform_device kunit APIs
> + */
> +static struct kunit_case kunit_platform_device_test_cases[] = {
> +       KUNIT_CASE(kunit_platform_device_alloc_test),
> +       KUNIT_CASE(kunit_platform_device_add_test),
> +       KUNIT_CASE(kunit_platform_device_add_twice_fails_test),
> +       KUNIT_CASE(kunit_platform_device_add_cleans_up),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_platform_device_suite = {
> +       .name = "kunit_platform_device",
> +       .test_cases = kunit_platform_device_test_cases,
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
> +/* Test that kunit_platform_driver_register() registers a driver that probes. */
> +static void kunit_platform_driver_register_test(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct kunit_platform_driver_test_context *ctx;
> +       DECLARE_COMPLETION_ONSTACK(comp);
> +       const char *name = "kunit-platform-register";
> +
> +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +       pdev = kunit_platform_device_alloc(test, name, -1);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +
> +       ctx->pdrv.probe = kunit_platform_driver_probe;
> +       ctx->pdrv.driver.name = name;
> +       ctx->pdrv.driver.owner = THIS_MODULE;
> +
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
> +
> +       KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
> +       KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
> +       KUNIT_EXPECT_STREQ(test, ctx->data, test_data);
> +}
> +
> +/*
> + * Test that kunit_platform_device_prepare_wait_for_probe() completes the completion
> + * when the device is already probed.
> + */
> +static void kunit_platform_device_prepare_wait_for_probe_completes_when_already_probed(struct kunit *test)
> +{
> +       struct platform_device *pdev;
> +       struct kunit_platform_driver_test_context *ctx;
> +       DECLARE_COMPLETION_ONSTACK(comp);
> +       const char *name = "kunit-platform-wait";
> +
> +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +       pdev = kunit_platform_device_alloc(test, name, -1);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> +
> +       ctx->pdrv.probe = kunit_platform_driver_probe;
> +       ctx->pdrv.driver.name = name;
> +       ctx->pdrv.driver.owner = THIS_MODULE;
> +
> +       /* Make sure driver has actually probed */
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
> +       KUNIT_ASSERT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
> +
> +       reinit_completion(&comp);
> +       KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
> +
> +       KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, HZ));
> +}
> +
> +static struct kunit_case kunit_platform_driver_test_cases[] = {
> +       KUNIT_CASE(kunit_platform_driver_register_test),
> +       KUNIT_CASE(kunit_platform_device_prepare_wait_for_probe_completes_when_already_probed),
> +       {}
> +};
> +
> +/*
> + * Test suite for struct platform_driver kunit APIs
> + */
> +static struct kunit_suite kunit_platform_driver_suite = {
> +       .name = "kunit_platform_driver",
> +       .test_cases = kunit_platform_driver_test_cases,
> +};
> +
> +kunit_test_suites(
> +       &kunit_platform_device_suite,
> +       &kunit_platform_driver_suite,
> +);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/lib/kunit/platform.c b/lib/kunit/platform.c
> new file mode 100644
> index 000000000000..ba1b0006dc45
> --- /dev/null
> +++ b/lib/kunit/platform.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test managed platform driver
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device/bus.h>
> +#include <linux/device/driver.h>
> +#include <linux/platform_device.h>
> +
> +#include <kunit/platform_device.h>
> +#include <kunit/resource.h>
> +
> +struct kunit_platform_device_alloc_params {
> +       const char *name;
> +       int id;
> +};
> +
> +static int kunit_platform_device_alloc_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_platform_device_alloc_params *params = context;
> +       struct platform_device *pdev;
> +
> +       pdev = platform_device_alloc(params->name, params->id);
> +       if (!pdev)
> +               return -ENOMEM;
> +
> +       res->data = pdev;
> +
> +       return 0;
> +}
> +
> +static void kunit_platform_device_alloc_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev = res->data;
> +
> +       platform_device_put(pdev);
> +}
> +
> +/**
> + * kunit_platform_device_alloc() - Allocate a KUnit test managed platform device
> + * @test: test context
> + * @name: device name of platform device to alloc
> + * @id: identifier of platform device to alloc.
> + *
> + * Allocate a test managed platform device. The device is put when the test completes.
> + *
> + * Return: Allocated platform device on success, NULL on failure.
> + */
> +struct platform_device *
> +kunit_platform_device_alloc(struct kunit *test, const char *name, int id)
> +{
> +       struct kunit_platform_device_alloc_params params = {
> +               .name = name,
> +               .id = id,
> +       };
> +
> +       return kunit_alloc_resource(test,
> +                                   kunit_platform_device_alloc_init,
> +                                   kunit_platform_device_alloc_exit,
> +                                   GFP_KERNEL, &params);
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_device_alloc);
> +
> +static void kunit_platform_device_add_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev = res->data;
> +
> +       platform_device_unregister(pdev);
> +}
> +
> +static bool
> +kunit_platform_device_alloc_match(struct kunit *test,
> +                                 struct kunit_resource *res, void *match_data)
> +{
> +       struct platform_device *pdev = match_data;
> +
> +       return res->data == pdev && res->free != kunit_platform_device_alloc_exit;
> +}
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(platform_device_unregister_wrapper,
> +                           platform_device_unregister, struct platform_device *);
> +/**
> + * kunit_platform_device_add() - Register a KUnit test managed platform device
> + * @test: test context
> + * @pdev: platform device to add
> + *
> + * Register a test managed platform device. The device is unregistered when the
> + * test completes.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int kunit_platform_device_add(struct kunit *test, struct platform_device *pdev)
> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       ret = platform_device_add(pdev);
> +       if (ret)
> +               return ret;
> +
> +       res = kunit_find_resource(test, kunit_platform_device_alloc_match, pdev);
> +       if (res) {
> +               /*
> +                * Transfer the reference count of the platform device if it
> +                * was allocated with kunit_platform_device_alloc(). In this
> +                * case, calling platform_device_put() when the test exits from
> +                * kunit_platform_device_alloc_exit() would lead to reference
> +                * count underflow because platform_device_unregister_wrapper()
> +                * calls platform_device_unregister() which also calls
> +                * platform_device_put().
> +                *
> +                * Usually callers transfer the refcount initialized in
> +                * platform_device_alloc() to platform_device_add() by calling
> +                * platform_device_unregister() when platform_device_add()
> +                * succeeds or platform_device_put() when it fails. KUnit has to
> +                * keep this straight by redirecting the free routine for the
> +                * resource to the right function. Luckily this only has to
> +                * account for the success scenario.
> +                */
> +               res->free = kunit_platform_device_add_exit;
> +               kunit_put_resource(res);
> +       } else {
> +               ret = kunit_add_action_or_reset(test, platform_device_unregister_wrapper, pdev);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_device_add);
> +
> +struct kunit_platform_device_probe_nb {
> +       struct completion *x;
> +       struct device *dev;
> +       struct notifier_block nb;
> +};
> +
> +static int kunit_platform_device_probe_notify(struct notifier_block *nb,
> +                                             unsigned long event, void *data)
> +{
> +       struct kunit_platform_device_probe_nb *knb;
> +       struct device *dev = data;
> +
> +       knb = container_of(nb, struct kunit_platform_device_probe_nb, nb);
> +       if (event != BUS_NOTIFY_BOUND_DRIVER || knb->dev != dev)
> +               return NOTIFY_DONE;
> +
> +       complete(knb->x);
> +
> +       return NOTIFY_OK;
> +}
> +
> +static void kunit_platform_device_probe_nb_remove(void *nb)
> +{
> +       bus_unregister_notifier(&platform_bus_type, nb);
> +}
> +
> +/**
> + * kunit_platform_device_prepare_wait_for_probe() - Prepare a completion
> + * variable to wait for a platform device to probe
> + * @test: test context
> + * @pdev: platform device to prepare to wait for probe of
> + * @x: completion variable completed when @dev has probed
> + *
> + * Prepare a completion variable @x to wait for @pdev to probe. Waiting on the
> + * completion forces a preemption, allowing the platform driver to probe.
> + *
> + * Example
> + *
> + * .. code-block:: c
> + *
> + *     static int kunit_platform_driver_probe(struct platform_device *pdev)
> + *     {
> + *             return 0;
> + *     }
> + *
> + *     static void kunit_platform_driver_test(struct kunit *test)
> + *     {
> + *             struct platform_device *pdev;
> + *             struct platform_driver *pdrv;
> + *             DECLARE_COMPLETION_ONSTACK(comp);
> + *
> + *             pdev = kunit_platform_device_alloc(test, "kunit-platform", -1);
> + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> + *             KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_add(test, pdev));
> + *
> + *             pdrv = kunit_kzalloc(test, sizeof(*pdrv), GFP_KERNEL);
> + *             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdrv);
> + *
> + *             pdrv->probe = kunit_platform_driver_probe;
> + *             pdrv->driver.name = "kunit-platform";
> + *             pdrv->driver.owner = THIS_MODULE;
> + *
> + *             KUNIT_ASSERT_EQ(test, 0, kunit_platform_device_prepare_wait_for_probe(test, pdev, &comp));
> + *             KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, pdrv));
> + *
> + *             KUNIT_EXPECT_NE(test, 0, wait_for_completion_timeout(&comp, 3 * HZ));
> + *     }
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int kunit_platform_device_prepare_wait_for_probe(struct kunit *test,
> +                                                struct platform_device *pdev,
> +                                                struct completion *x)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct kunit_platform_device_probe_nb *knb;
> +       bool bound;
> +
> +       knb = kunit_kzalloc(test, sizeof(*knb), GFP_KERNEL);
> +       if (!knb)
> +               return -ENOMEM;
> +
> +       knb->nb.notifier_call = kunit_platform_device_probe_notify;
> +       knb->dev = dev;
> +       knb->x = x;
> +
> +       device_lock(dev);
> +       bound = device_is_bound(dev);
> +       if (bound) {
> +               device_unlock(dev);
> +               complete(x);
> +               kunit_kfree(test, knb);
> +               return 0;
> +       }
> +
> +       bus_register_notifier(&platform_bus_type, &knb->nb);
> +       device_unlock(&pdev->dev);
> +
> +       return kunit_add_action_or_reset(test, kunit_platform_device_probe_nb_remove, &knb->nb);
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_device_prepare_wait_for_probe);
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(platform_driver_unregister_wrapper,
> +                           platform_driver_unregister, struct platform_driver *);
> +/**
> + * kunit_platform_driver_register() - Register a KUnit test managed platform driver
> + * @test: test context
> + * @drv: platform driver to register
> + *
> + * Register a test managed platform driver. This allows callers to embed the
> + * @drv in a container structure and use container_of() in the probe function
> + * to pass information to KUnit tests.
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
> + *             KUNIT_EXPECT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
> + *             <... wait for driver to probe ...>
> + *             KUNIT_EXPECT_STREQ(test, ctx->data, "test data");
> + *     }
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int kunit_platform_driver_register(struct kunit *test,
> +                                  struct platform_driver *drv)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(drv);
> +       if (ret)
> +               return ret;
> +
> +       return kunit_add_action_or_reset(test, platform_driver_unregister_wrapper, drv);
> +}
> +EXPORT_SYMBOL_GPL(kunit_platform_driver_register);
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000bb15bb061ac0c052
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIAiy9iNBGxBIRaFa5LJ2p/d6gxX0AOaWHjykEKGEffXcMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMzA3NTAyOVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAucqCk
aKhpLLlTSF2f6sLEPzUjGH9dYuCzumET9hyp4ihQUaoooH+PILm+DqqJb9UwlOKgOyMOJZhFQUDM
NEykYOGY06gKAZmNLx5N+ZkAKbgPryxeJ0jEDSygmLlKOWPBbQfKOBmu3qaX/UFCSLEoeVM38goT
tLehA9pAsLWV/xnKNCMIDZgXNwPgPddCZ1BPbJqaKCyjCZGfqwXInI/TxrhCLM+YX678JgIB1HhQ
OlUk2uLeommwTmm60ccBYhkMYhcDTlC+izqnIpPN1lGrx2T69JsaISr80d/vXrvYHthmm5z1qATI
1pO5xsmtneUlG4d1VJCD042vhPUo+lo5
--000000000000bb15bb061ac0c052--

