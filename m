Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6C6D31ED
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDAPPn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDAPPk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 11:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD63D1D2C6;
        Sat,  1 Apr 2023 08:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3340560EF4;
        Sat,  1 Apr 2023 15:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9217C433D2;
        Sat,  1 Apr 2023 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680362138;
        bh=7pnYJK+r7L4YvhEf4DGJOZNQphvJ8L8LOd33nnLVDfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KqCtGpNDPK6hmDFZqA265OEx0I/13VY8ZZaO+pjWWhGsnHfqDTFnZY02X0rZvdHVR
         DHeGMGFFZgoexF7aLDoHdjK2/KKg2klrOR8dX8fV5+Cu352/8jwR8WvwMUUUqOhRRJ
         wzv8GW4YKjc1hk/xTzwx/8qoJkjIuh5yK1auPMevJFm25Z8J4x02UkpJ8FbcLCn+Ch
         uEUxB/TrOJRzeqboy+maGJ53wm1seN6TzzTZDJdWsjMe+T9uDXGNUFazYzFrErfkat
         wcH9POPf6UsMLfd57otZ3UsTlL7Fx2venPLW5FzEBhEhPfaH4Mx6Jipgwxkf83L2Yb
         K16ZE7GO3hp0g==
Date:   Sat, 1 Apr 2023 16:30:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230401163046.2bec03dd@jic23-huawei>
In-Reply-To: <d9d4894e-d386-dba5-3e6a-c48c5d143e45@metafoo.de>
References: <ZBrvhfX/NNrJefgt@kroah.com>
        <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
        <ZBtPhoelZo4U5jwC@kroah.com>
        <20230323101216.w56kz3rudlj23vab@houat>
        <ZBwoRgc2ICBJX/Lq@kroah.com>
        <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
        <20230323122925.kqdnomr7i46qnyo4@houat>
        <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
        <20230323163639.xtwpid2uunwnzai4@houat>
        <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
        <20230324123157.bbwvfq4gsxnlnfwb@houat>
        <20230325175044.7bee9e7d@jic23-huawei>
        <d9d4894e-d386-dba5-3e6a-c48c5d143e45@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 26 Mar 2023 10:16:54 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/25/23 10:50, Jonathan Cameron wrote:
> > On Fri, 24 Mar 2023 13:31:57 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> >  
> >> On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:  
> >>> On 3/23/23 18:36, Maxime Ripard wrote:  
> >>>> On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:  
> >>>>> On 3/23/23 14:29, Maxime Ripard wrote:  
> >>>>>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> >>>>>>
> >>>>>> This is the description of what was happening:
> >>>>>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/  
> >>>>> Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> >>>>> when root_device_register() is used is not because root_device_unregister()
> >>>>> would not trigger the unwinding - but rather because DRM code on top of this
> >>>>> device keeps the refcount increased?  
> >>>> There's a difference of behaviour between a root_device and any device
> >>>> with a bus: the root_device will only release the devm resources when
> >>>> it's freed (in device_release), but a bus device will also do it in
> >>>> device_del (through bus_remove_device() -> device_release_driver() ->
> >>>> device_release_driver_internal() -> __device_release_driver() ->
> >>>> device_unbind_cleanup(), which are skipped (in multiple places) if
> >>>> there's no bus and no driver attached to the device).
> >>>>
> >>>> It does affect DRM, but I'm pretty sure it will affect any framework
> >>>> that deals with device hotplugging by deferring the framework structure
> >>>> until the last (userspace) user closes its file descriptor. So I'd
> >>>> assume that v4l2 and cec at least are also affected, and most likely
> >>>> others.  
> >>> Thanks for the explanation and patience :)
> >>>      
> >>>>      
> >>>>> If this is the case, then it sounds like a DRM specific issue to me.  
> >>>> I mean, I guess. One could also argue that it's because IIO doesn't
> >>>> properly deal with hotplugging.  
> >>> I must say I haven't been testing the IIO registration API. I've only tested
> >>> the helper API which is not backed up by any "IIO device". (This is fine for
> >>> the helper because it must by design be cleaned-up only after the
> >>> IIO-deregistration).
> >>>
> >>> After your explanation here, I am not convinced IIO wouldn't see the same
> >>> issue if I was testing the devm_iio_device_alloc() & co.  
> >> It depends really. The issue DRM is trying to solve is that, when a
> >> device is gone, some application might still have an open FD and could
> >> still poke into the kernel, while all the resources would have been
> >> free'd if it was using devm.
> >>
> >> So everything is kept around until the last fd is closed, so you still
> >> have a reference to the device (even though it's been removed from its
> >> bus) until that time.
> >>
> >> It could be possible that IIO just doesn't handle that case at all. I
> >> guess most of the devices aren't hotpluggable, and there's not much to
> >> interact with from a userspace PoV iirc, so it might be why.  
> > Lars-Peter Clausen (IIRC) fixed up the IIO handling of the similar cases a
> > long time ago now. It's simpler that for some other subsystems as we don't
> > have as many interdependencies as occur in DRM etc.
> >
> > I 'think' we are fine in general with the IIO approach to this (I think we
> > did have one report of a theoretical race condition in the remove path that
> > was never fully addressed).
> >
> > For IIO we also have fds that can be open but all accesses to them are proxied
> > through the IIO core and one of the things iio_device_unregister() or the devm
> > equivalent does is to set indio_dev->info = NULL  (+ wake up anyone waiting on
> > data etc). Alongside removing the callbacks, that is also used as a flag
> > to indicate the device has gone.
> >
> > Note that we keep a reference to the struct indio_dev->dev (rather that the
> > underlying device) so that is not freed until the last fd is closed.
> > Thus, although devm unwinding has occurred that doesn't mean all the data
> > that was allocated with devm_xx calls is cleared up immediately.  
> 
> IIO is fully hot-plug and hot-unplug capable. And it will have the same 
> issue. When using managed device registration that establishes a parent 
> child relationship between the devices and in combination with a device 
> where the managed unwinding does not happen on unbind, but rather on in 
> the release callback you create a cyclic reference dependency. The child 
> device holds a reference to the parent, but the reference is only 
> released in the parents release callback. And since that release 
> callback is not called until the last reference is dropped you end up 
> with a resource leak.
> 
> There are even some other places where IIO drivers run into this. E.g. 
> any driver that does `devm_iio_trigger_register(&indio_dev->dev, ...)` 

A driver should should not do that.
Should be devm_iio_trigger_registers(parent device, ...)

There is a corner where you need to detach the trigger from userspace
before release which is odd if it was attached by default. There are some
left over corners there that I think still cause trouble.

> creates a resource leak on the trigger and the IIO device. The indio_dev 
> is not a bus device, hence no unbind and the trigger holds a reference 
> so the release callback will never be called either.
> 

