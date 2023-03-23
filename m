Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10056C6282
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCWI6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCWI6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345D0420E;
        Thu, 23 Mar 2023 01:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B7B62531;
        Thu, 23 Mar 2023 08:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0FC433EF;
        Thu, 23 Mar 2023 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679561898;
        bh=HIzyYpqLZtsxT+R8AWZhR9/TqqXOQYhuHY3IZkewQDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTJfNAHOtDNEEmUQ2PXzwccQqjpkyOua0MiNaP2O6JeD/iRF2SOGJrh5YXbW6rAVK
         SUv8kclq8M+lAHa5w5JLIPJFIYPAk90lJwkrDjolMFU9HUXWL3wCT/baMtvhtQ5bll
         SQKl/yc0LVNDuDt9NWnmRCRVc0D6WKV4agevbfYs=
Date:   Thu, 23 Mar 2023 09:58:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBwUp/fRIjQZtjF7@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
> On 3/22/23 20:57, Greg Kroah-Hartman wrote:
> > On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
> >> Hi Greg,
> >>
> >> Thanks for looking at this.
> >>
> >> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
> >>> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
> >>>> +/**
> >>>> + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
> >>>> + * @test: The test context object
> >>>> + *
> >>>> + * This allocates a fake struct &device to create a mock for a KUnit
> >>>> + * test. The device will also be bound to a fake driver. It will thus be
> >>>> + * able to leverage the usual infrastructure and most notably the
> >>>> + * device-managed resources just like a "real" device.
> >>>
> >>> What specific "usual infrastructure" are you wanting to access here?
> >>>
> >>> And again, if you want a fake device, make a virtual one, by just
> >>> calling device_create().
> >>>
> >>> Or are you wanting to do "more" with that device pointer than
> >>> device_create() can give you?
> >>
> >> Personally, I was (am) only interested in devm_ unwinding. I guess the
> >> device_create(), device_add(), device_remove()... (didn't study this
> >> sequence in details so sorry if there is errors) could've been sufficient
> >> for me. I haven't looked how much of the code that there is for 'platform
> >> devices' should be duplicated to support that sequence for testability
> >> purposes.
> > 
> > Any device can access devm_ code, there's no need for it to be a
> > platform device at all.
> > 
> >> The biggest thing for me is that I don't like the idea of creating own 'test
> >> device' in <add subsystem here> while we already have some in DRM (or
> >> others). Thus, I do see value in adding generic helpers for supporting
> >> running KUnit tests on devm_* APIs. Hence it'd be good to have _some_
> >> support for it.
> > 
> > I agree, let's use a virtual device and a virtual bus (you can use the
> > auxbus code for this as that's all there for this type of thing)
> 
> Hm. The auxiliary_devices require parent. What would be the best way to 
> deal with that in KUnit tests?

If you use NULL as the parent, it goes into the root.

> > then you can test the devm_* code, _AND_ you can test the driver core at
> > the same time.
> > 
> >> And having them in drivers/base/test seemed like a correct
> >> place to me. What I really don't know is if there are legitimate use-cases
> >> for using platform_devices in DRM tests. Perhaps Maxime can shed light on
> >> that.
> > 
> > I agree that this could be in drivers/base/test/ but then let's test the
> > driver core, not just provide a dummy platform device.
> > 
> > If you want to test the platform driver/device api, that would be great
> > too, that can be plaform device/driver specific, but don't use one for
> > some other random driver core functionality please.
> 
> I am very conservative what comes to adding unit tests due to the huge 
> inertia they add to any further development. I usually only add tests to 
> APIs which I know won't require changing (I don't know such in-kernel 
> APIs)

So anything that is changing doesn't get a test?  If you only test
things that don't change then no tests fail, and so, why have the test
at all?

On the contrary, tests should be used to verify things that are changing
all the time, to ensure that we don't break things.  That's why we need
them, not to just validate that old code still is going ok.

The driver core is changing, and so, I would love to see tests for it to
ensure that I don't break anything over time.  That should NOT slow down
development but rather, speed it up as it ensures that things still work
properly.

> - or to functions which I think are error-prone. So, I am probably 
> one of the last persons adding UTs to code I don't know :)

That's fine, you don't have to add test code for stuff you don't know.

But again, do NOT abuse a platform device for this, that's not ok, and
the in-kernel code that does do this should be fixed up.

thanks,

greg k-h
