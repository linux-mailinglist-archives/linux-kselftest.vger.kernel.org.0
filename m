Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB76D325A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDAPV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDAPVZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 11:21:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40024AFD;
        Sat,  1 Apr 2023 08:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A59AB80BA5;
        Sat,  1 Apr 2023 15:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3C6C433EF;
        Sat,  1 Apr 2023 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680362467;
        bh=VRDENP0GBG7HEPJPomXEJE7ipvrog3G07035r41JCJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h1+F7BuKL9lM30A5/t9JaKr/WJreYYGl8tgMNUJufsHzv/7TyX0pJeaZ4GqmVlE8o
         8yo1OhgVT9lsepFxu2sKxvbn1ya2ityYCNWj4Tr/RBsIdH404gWZ+kSBdvyDN1EmgN
         KAA0gJLuuTiC9ZXvovGFK2/rNXfzpv0XLBQI4JhnT6N+Kycbekeg4Da4bjjmJ1SyH4
         DKDj4TpO+HLmzJ97joKmDPt5u5bP3rS3uU9zbbDIQYQlUeySGbCvDZ9PPmTHs9of+Y
         yEQLlHS3xMX+MkvCDHITjKXTsPHNDSNOpVp6WePlDwGoOZ8axw2XyK0WiTVSq4gaao
         vQX8+PmsdI+Xw==
Date:   Sat, 1 Apr 2023 16:36:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230401163614.38f68397@jic23-huawei>
In-Reply-To: <20230329194609.7u2hgidxdk34emsf@penduick>
References: <ZBtPhoelZo4U5jwC@kroah.com>
        <20230323101216.w56kz3rudlj23vab@houat>
        <ZBwoRgc2ICBJX/Lq@kroah.com>
        <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
        <20230323122925.kqdnomr7i46qnyo4@houat>
        <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
        <20230323163639.xtwpid2uunwnzai4@houat>
        <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
        <20230324123157.bbwvfq4gsxnlnfwb@houat>
        <20230325175044.7bee9e7d@jic23-huawei>
        <20230329194609.7u2hgidxdk34emsf@penduick>
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

On Wed, 29 Mar 2023 21:46:09 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> On Sat, Mar 25, 2023 at 05:50:44PM +0000, Jonathan Cameron wrote:
> > On Fri, 24 Mar 2023 13:31:57 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> >   
> > > On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:  
> > > > On 3/23/23 18:36, Maxime Ripard wrote:    
> > > > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:    
> > > > > > On 3/23/23 14:29, Maxime Ripard wrote:    
> > > > > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > > > > > 
> > > > > > > This is the description of what was happening:
> > > > > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/    
> > > > > > 
> > > > > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> > > > > > when root_device_register() is used is not because root_device_unregister()
> > > > > > would not trigger the unwinding - but rather because DRM code on top of this
> > > > > > device keeps the refcount increased?    
> > > > > 
> > > > > There's a difference of behaviour between a root_device and any device
> > > > > with a bus: the root_device will only release the devm resources when
> > > > > it's freed (in device_release), but a bus device will also do it in
> > > > > device_del (through bus_remove_device() -> device_release_driver() ->
> > > > > device_release_driver_internal() -> __device_release_driver() ->
> > > > > device_unbind_cleanup(), which are skipped (in multiple places) if
> > > > > there's no bus and no driver attached to the device).
> > > > > 
> > > > > It does affect DRM, but I'm pretty sure it will affect any framework
> > > > > that deals with device hotplugging by deferring the framework structure
> > > > > until the last (userspace) user closes its file descriptor. So I'd
> > > > > assume that v4l2 and cec at least are also affected, and most likely
> > > > > others.    
> > > > 
> > > > Thanks for the explanation and patience :)
> > > >     
> > > > >     
> > > > > > If this is the case, then it sounds like a DRM specific issue to me.    
> > > > > 
> > > > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > > > properly deal with hotplugging.    
> > > > 
> > > > I must say I haven't been testing the IIO registration API. I've only tested
> > > > the helper API which is not backed up by any "IIO device". (This is fine for
> > > > the helper because it must by design be cleaned-up only after the
> > > > IIO-deregistration).
> > > > 
> > > > After your explanation here, I am not convinced IIO wouldn't see the same
> > > > issue if I was testing the devm_iio_device_alloc() & co.    
> > > 
> > > It depends really. The issue DRM is trying to solve is that, when a
> > > device is gone, some application might still have an open FD and could
> > > still poke into the kernel, while all the resources would have been
> > > free'd if it was using devm.
> > > 
> > > So everything is kept around until the last fd is closed, so you still
> > > have a reference to the device (even though it's been removed from its
> > > bus) until that time.
> > > 
> > > It could be possible that IIO just doesn't handle that case at all. I
> > > guess most of the devices aren't hotpluggable, and there's not much to
> > > interact with from a userspace PoV iirc, so it might be why.  
> > 
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
> 
> Sorry if it came as trying to put IIO under a bad light, it certainly
> wasn't my intention. I was trying to come up with possible explanations
> as to why IIO's design was simpler than DRM is :)

No problem :) I'm sure there are gremlins hiding there.
Part of the problem is that nothing prevents drivers doing 'wrong things'
other than us noticing when it happens.

> 
> > Note that we keep a reference to the struct indio_dev->dev (rather that the
> > underlying device) so that is not freed until the last fd is closed.
> > Thus, although devm unwinding has occurred that doesn't mean all the data
> > that was allocated with devm_xx calls is cleared up immediately.  
> 
> I'm not sure I get that part though. devm unwinding can happen even if the refcount is > 1

No IIO driver should be using devm on the indio_dev->dev, they should be doing it on the
parent device.  When the devm_iio_device_free() gets called, that doesn't actually free
the device. Just decrements a reference count (earlier on we already ensured that
it is just acting as a stub that provides no access to the underlying device for
open FDs.).

There are probably more problems hiding though!

Jonathan



> 
> Maxime

