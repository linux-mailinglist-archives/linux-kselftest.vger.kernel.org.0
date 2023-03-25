Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386F56C8FDC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 18:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCYRgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCYRgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 13:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9EF947;
        Sat, 25 Mar 2023 10:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4540FB8077F;
        Sat, 25 Mar 2023 17:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68067C433EF;
        Sat, 25 Mar 2023 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679765746;
        bh=wg84xIhBALI4SENDb3ban1q6622XYKEa5PF6zoiunlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=muHgoGV6Rd+mQI6DYCmmBGKK3W+rFpcOFk4Y18Ex6t3BbSwDKoJLjv1YPhXCBnpXK
         9tK8fmOveyMz+Z9vLmWZuNNv8Hm378CwzS8YHN2Ui70M00nf0NOgkDK35rkohwO+Cl
         yBzTqOlqf9n/oacDn3SL2dqOKnwJY91o36nW8FYpG2MEvn+VHLqLsfK808UCf4Xs9P
         wugRwMgz9/KyXahBkeEryk53R4iqFkT6voNaJL53aLsQIAhj/IUnKKDHCtfv1ses5k
         xojVF/cxk1VGWN01AC1IyHiH2s+4upq5OEE8SdCGb7g2jQhXyQZne9B7t1nh18fvq6
         TQUIxAzyybw5Q==
Date:   Sat, 25 Mar 2023 17:50:44 +0000
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
Message-ID: <20230325175044.7bee9e7d@jic23-huawei>
In-Reply-To: <20230324123157.bbwvfq4gsxnlnfwb@houat>
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
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 24 Mar 2023 13:31:57 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
> > On 3/23/23 18:36, Maxime Ripard wrote:  
> > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:  
> > > > On 3/23/23 14:29, Maxime Ripard wrote:  
> > > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > > > 
> > > > > This is the description of what was happening:
> > > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/  
> > > > 
> > > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> > > > when root_device_register() is used is not because root_device_unregister()
> > > > would not trigger the unwinding - but rather because DRM code on top of this
> > > > device keeps the refcount increased?  
> > > 
> > > There's a difference of behaviour between a root_device and any device
> > > with a bus: the root_device will only release the devm resources when
> > > it's freed (in device_release), but a bus device will also do it in
> > > device_del (through bus_remove_device() -> device_release_driver() ->
> > > device_release_driver_internal() -> __device_release_driver() ->
> > > device_unbind_cleanup(), which are skipped (in multiple places) if
> > > there's no bus and no driver attached to the device).
> > > 
> > > It does affect DRM, but I'm pretty sure it will affect any framework
> > > that deals with device hotplugging by deferring the framework structure
> > > until the last (userspace) user closes its file descriptor. So I'd
> > > assume that v4l2 and cec at least are also affected, and most likely
> > > others.  
> > 
> > Thanks for the explanation and patience :)
> >   
> > >   
> > > > If this is the case, then it sounds like a DRM specific issue to me.  
> > > 
> > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > properly deal with hotplugging.  
> > 
> > I must say I haven't been testing the IIO registration API. I've only tested
> > the helper API which is not backed up by any "IIO device". (This is fine for
> > the helper because it must by design be cleaned-up only after the
> > IIO-deregistration).
> > 
> > After your explanation here, I am not convinced IIO wouldn't see the same
> > issue if I was testing the devm_iio_device_alloc() & co.  
> 
> It depends really. The issue DRM is trying to solve is that, when a
> device is gone, some application might still have an open FD and could
> still poke into the kernel, while all the resources would have been
> free'd if it was using devm.
> 
> So everything is kept around until the last fd is closed, so you still
> have a reference to the device (even though it's been removed from its
> bus) until that time.
> 
> It could be possible that IIO just doesn't handle that case at all. I
> guess most of the devices aren't hotpluggable, and there's not much to
> interact with from a userspace PoV iirc, so it might be why.

Lars-Peter Clausen (IIRC) fixed up the IIO handling of the similar cases a
long time ago now. It's simpler that for some other subsystems as we don't
have as many interdependencies as occur in DRM etc.

I 'think' we are fine in general with the IIO approach to this (I think we
did have one report of a theoretical race condition in the remove path that
was never fully addressed).

For IIO we also have fds that can be open but all accesses to them are proxied
through the IIO core and one of the things iio_device_unregister() or the devm
equivalent does is to set indio_dev->info = NULL  (+ wake up anyone waiting on
data etc). Alongside removing the callbacks, that is also used as a flag
to indicate the device has gone.

Note that we keep a reference to the struct indio_dev->dev (rather that the
underlying device) so that is not freed until the last fd is closed.
Thus, although devm unwinding has occurred that doesn't mean all the data
that was allocated with devm_xx calls is cleared up immediately.

