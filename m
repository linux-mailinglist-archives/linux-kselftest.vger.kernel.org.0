Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01D06C49E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 13:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCVMHi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCVMHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 08:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C1199D4;
        Wed, 22 Mar 2023 05:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2EC162066;
        Wed, 22 Mar 2023 12:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B714AC433D2;
        Wed, 22 Mar 2023 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679486856;
        bh=mEJBZcKnQmCiiCvxN31byXP3FWkhhpXgi2bleto/pZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVvHbdtIrceHMsNsG1JliX1Imp2jpxAyB/7iKh6TAQO8mXt5KOMRLzmxLzzL10QLR
         d04cpbbZPQJNxSY4glIF7yKTzHJj0nrruhfXM5nfoLymMbB6IKaxeMmYQbz1ymPSIE
         f0cZTDrkreVxliUPoQqB0NzaEvaB8MqLF/edGU5U=
Date:   Wed, 22 Mar 2023 13:07:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
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
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBrvhfX/NNrJefgt@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
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
> +#define KUNIT_DEVICE_NAME	"test-kunit-mock-device"
> +
> +static int fake_probe(struct platform_device *pdev)

Please do not abuse platform devices and drivers for things that are not
actually platform devices and drivers.

> +{
> +	return 0;
> +}
> +
> +static int fake_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver fake_platform_driver = {
> +	.probe	= fake_probe,
> +	.remove	= fake_remove,
> +	.driver = {
> +		.name	= KUNIT_DEVICE_NAME,
> +	},
> +};

Why do you need this fake platform driver at all?

Why not just use a virtual device?

> +
> +/**
> + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
> + * @test: The test context object
> + *
> + * This allocates a fake struct &device to create a mock for a KUnit
> + * test. The device will also be bound to a fake driver. It will thus be
> + * able to leverage the usual infrastructure and most notably the
> + * device-managed resources just like a "real" device.

What specific "usual infrastructure" are you wanting to access here?

And again, if you want a fake device, make a virtual one, by just
calling device_create().

Or are you wanting to do "more" with that device pointer than
device_create() can give you?

Again, please do not abuse the platform device infrastructure for things
it was never ment to do (i.e. create fake devices that are not really a
platform device.)

thanks,

greg k-h
