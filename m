Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5E6C64BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCWKWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCWKWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2164D52B;
        Thu, 23 Mar 2023 03:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6496EB82055;
        Thu, 23 Mar 2023 10:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7136C433D2;
        Thu, 23 Mar 2023 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679566953;
        bh=1nfT8Rc7boLFxMEOqe2mpQaNUrd14bwQB4DnxjJCq1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pR7xEzh+c16R6uPuvPSBbyL9NhyC5n8pzkVPj8qllPuMGPZ1Qgbn5g02VESrPSxrD
         Y0on6jmc1Md4itsbfAwy6SjHmzEOV9iiSN5uSiFgERjImMJ3K3aWXU7CvvoqXMaDbZ
         6IrYeVOG+IbEF9gKHCuMhqxOHpohSt3Pl526riDA=
Date:   Thu, 23 Mar 2023 11:21:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBwoRgc2ICBJX/Lq@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323101216.w56kz3rudlj23vab@houat>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 11:12:16AM +0100, Maxime Ripard wrote:
> On Wed, Mar 22, 2023 at 07:57:10PM +0100, Greg Kroah-Hartman wrote:
> > > > > +/**
> > > > > + * test_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
> > > > > + * @test: The test context object
> > > > > + *
> > > > > + * This allocates a fake struct &device to create a mock for a KUnit
> > > > > + * test. The device will also be bound to a fake driver. It will thus be
> > > > > + * able to leverage the usual infrastructure and most notably the
> > > > > + * device-managed resources just like a "real" device.
> > > > 
> > > > What specific "usual infrastructure" are you wanting to access here?
> > > > 
> > > > And again, if you want a fake device, make a virtual one, by just
> > > > calling device_create().
> > > > 
> > > > Or are you wanting to do "more" with that device pointer than
> > > > device_create() can give you?
> > > 
> > > Personally, I was (am) only interested in devm_ unwinding. I guess the
> > > device_create(), device_add(), device_remove()... (didn't study this
> > > sequence in details so sorry if there is errors) could've been sufficient
> > > for me. I haven't looked how much of the code that there is for 'platform
> > > devices' should be duplicated to support that sequence for testability
> > > purposes.
> > 
> > Any device can access devm_ code, there's no need for it to be a
> > platform device at all.
> 
> Sure but the resources are only released if the device is part of a bus,
> so it can't be a root_device (or bare device) either

The resources are not cleaned up when the device is freed no matter if
it's on a bus or not?  If so, then that's a bug that needs to be fixed,
and tested :)

thanks,

greg k-h
