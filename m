Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7F6C546D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 20:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCVS77 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCVS6z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 14:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942B169CCD;
        Wed, 22 Mar 2023 11:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E776CB81DB5;
        Wed, 22 Mar 2023 18:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FB8C433EF;
        Wed, 22 Mar 2023 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679511432;
        bh=/imnV0x8iGBAk5tPyVtciG7NBjjG0y02B1qw0YmV2Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wnz6xohsZpdBarPAm4bU+cZ6XESC6K7V9uQqtrnOP0bxjU1Mvh98bPHJ61lb3g7x2
         WxV7ToBC8kwblA27wHEHT8zodzSgsE4p8cE1mw8gBCswLp5rVNctyHSu+pJXGfPBdf
         giRiuA5LFAoMZI2wrPLXaDAkbRHcH2nRwCwD7Zzk=
Date:   Wed, 22 Mar 2023 19:57:10 +0100
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
Message-ID: <ZBtPhoelZo4U5jwC@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
> Hi Greg,
> 
> Thanks for looking at this.
> 
> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
> > On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
> > > --- /dev/null
> > > +++ b/drivers/base/test/test_kunit_device.c
> > > @@ -0,0 +1,83 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * These helpers have been extracted from drm test code at
> > > + * drm_kunit_helpers.c which was authored by
> > > + * Maxime Ripard <maxime@cerno.tech>
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include <kunit/platform_device.h>
> > > +
> > > +#define KUNIT_DEVICE_NAME	"test-kunit-mock-device"
> > > +
> > > +static int fake_probe(struct platform_device *pdev)
> > 
> > Please do not abuse platform devices and drivers for things that are not
> > actually platform devices and drivers.
> > 
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static int fake_remove(struct platform_device *pdev)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static struct platform_driver fake_platform_driver = {
> > > +	.probe	= fake_probe,
> > > +	.remove	= fake_remove,
> > > +	.driver = {
> > > +		.name	= KUNIT_DEVICE_NAME,
> > > +	},
> > > +};
> > 
> > Why do you need this fake platform driver at all?
> > 
> > Why not just use a virtual device?
> 
> I can only answer on my behalf. In my case the answer to why I used
> platform_devices is practicality. I wanted to test devm_ APIs using KUnit
> tests and I was pointed to an existing implementation in DRM (seen in these
> patches). It didn't seem to make any sense to re-invent the wheel by writing
> another implementation for the existing in-tree functionality.

That's fine, but please, let's do this right if it's going to be in the
driver core, that way we can actually test the driver core code as well.

> > > +/**
> > > + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
> > > + * @test: The test context object
> > > + *
> > > + * This allocates a fake struct &device to create a mock for a KUnit
> > > + * test. The device will also be bound to a fake driver. It will thus be
> > > + * able to leverage the usual infrastructure and most notably the
> > > + * device-managed resources just like a "real" device.
> > 
> > What specific "usual infrastructure" are you wanting to access here?
> > 
> > And again, if you want a fake device, make a virtual one, by just
> > calling device_create().
> > 
> > Or are you wanting to do "more" with that device pointer than
> > device_create() can give you?
> 
> Personally, I was (am) only interested in devm_ unwinding. I guess the
> device_create(), device_add(), device_remove()... (didn't study this
> sequence in details so sorry if there is errors) could've been sufficient
> for me. I haven't looked how much of the code that there is for 'platform
> devices' should be duplicated to support that sequence for testability
> purposes.

Any device can access devm_ code, there's no need for it to be a
platform device at all.

> The biggest thing for me is that I don't like the idea of creating own 'test
> device' in <add subsystem here> while we already have some in DRM (or
> others). Thus, I do see value in adding generic helpers for supporting
> running KUnit tests on devm_* APIs. Hence it'd be good to have _some_
> support for it.

I agree, let's use a virtual device and a virtual bus (you can use the
auxbus code for this as that's all there for this type of thing) and
then you can test the devm_* code, _AND_ you can test the driver core at
the same time.

> And having them in drivers/base/test seemed like a correct
> place to me. What I really don't know is if there are legitimate use-cases
> for using platform_devices in DRM tests. Perhaps Maxime can shed light on
> that.

I agree that this could be in drivers/base/test/ but then let's test the
driver core, not just provide a dummy platform device.

If you want to test the platform driver/device api, that would be great
too, that can be plaform device/driver specific, but don't use one for
some other random driver core functionality please.

thanks,

greg k-h
