Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54416C650D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCWKac (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjCWK3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:29:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2FD37B61;
        Thu, 23 Mar 2023 03:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92EB3B82061;
        Thu, 23 Mar 2023 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0D3C433D2;
        Thu, 23 Mar 2023 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679567232;
        bh=c/vQUcp/ujxifAraGE6RpYgcNOCvYwMVfshFRlfNTfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0A/+uutTDkMSDW98f5fsDSzNol/TcTNI/MNcxcDs7yUY8CiQr6sfALtNZM7y1lNqD
         kMbNTiSIt+VJdpKNb6CutRbMv3xGJRs6NUi9ERrO4qUQ8c3ZCbC9btna/G4pwAE2As
         EYJkwniG61ulHDqrjvkRuL62fhpbW9LVaCkuRy3U=
Date:   Thu, 23 Mar 2023 11:27:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
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
Message-ID: <ZBwpfRGoXT/0sxlU@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
 <ZBwUp/fRIjQZtjF7@kroah.com>
 <91c8dc84-8eae-15d9-3d55-976c2c806421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c8dc84-8eae-15d9-3d55-976c2c806421@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 12:01:15PM +0200, Matti Vaittinen wrote:
> On 3/23/23 10:58, Greg Kroah-Hartman wrote:
> > On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
> > > On 3/22/23 20:57, Greg Kroah-Hartman wrote:
> > > > On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > Thanks for looking at this.
> > > > > 
> > > > > On 3/22/23 14:07, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
> 
> > > > > The biggest thing for me is that I don't like the idea of creating own 'test
> > > > > device' in <add subsystem here> while we already have some in DRM (or
> > > > > others). Thus, I do see value in adding generic helpers for supporting
> > > > > running KUnit tests on devm_* APIs. Hence it'd be good to have _some_
> > > > > support for it.
> > > > 
> > > > I agree, let's use a virtual device and a virtual bus (you can use the
> > > > auxbus code for this as that's all there for this type of thing)
> > > 
> > > Hm. The auxiliary_devices require parent. What would be the best way to
> > > deal with that in KUnit tests?
> > 
> > If you use NULL as the parent, it goes into the root.
> 
> As far as I read this is not the case with auxiliary devices. Judging the
> docs they were intended to be representing some part of a (parent) device. I
> see the auxiliary_device_init() has explicit check for parent being
> populated:
> 
> int auxiliary_device_init(struct auxiliary_device *auxdev)
> {
>         struct device *dev = &auxdev->dev;
> 
>         if (!dev->parent) {
>                 pr_err("auxiliary_device has a NULL dev->parent\n");
>                 return -EINVAL;
>         }

Yes as it wants to "split" a device up into smaller devices.  So make a
real device that it can hang off of.

> As I wrote in another mail, I thought of using a root_device for this IIO
> test as was suggested by David. To tell the truth, implementing a kunit bus
> device is starting to feel a bit overwhelming... I started just adding a
> driver for a light sensor, ended up adding a helper for IIO gain-time-scale
> conversions and I am slightly reluctant to going the extra-extra mile of
> adding some UT infrastructure in the context of this driver work...

I think it is worth it as the driver core has no tests.  So it obviously
must be correct, right?  :)

thanks,

greg k-h
