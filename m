Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BE6CF36C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjC2Toa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjC2ToS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 15:44:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1F55A3;
        Wed, 29 Mar 2023 12:43:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 287C4320082A;
        Wed, 29 Mar 2023 15:43:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Mar 2023 15:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680119002; x=1680205402; bh=7fJNXQMgupYfTfzXjUT/VSxxmReLzs9mghv
        5xKeEkEw=; b=YMrEz4K5HIombsOqi/BTS1U0U4a3C24Tq0rTiALpR3++DDywfut
        dNjr+s/KXnf+PikPClXtjnLLVzDd9jIK1ZRCBie3TgpEMdqznPRRuDPmlezlBwsK
        peKslDAwg2DPt1EQRxW/L3N3PhUMnmEj+2pAfK9YriS0NRY1zSnKocqVRv3eddTt
        xh5upaamzA7PW9MDpV2vB+UHoPtu5u4EfYD9fNC45nu7Lj+YC3u5zny72gAy9/br
        QcSeZUK7pvHuaW8rpiwP6IF2DwrNkwojY+Zkkqtbh8eUj3I3nMdUEsz2W8kiW27Z
        hoTyuMFY+d8cZtsW60B+RmaYZwzkLqQALcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680119002; x=1680205402; bh=7fJNXQMgupYfTfzXjUT/VSxxmReLzs9mghv
        5xKeEkEw=; b=JWvn+CUvHHVcyJJTBhbShimHD82B8geTFc9Nk45mijBxErPVsC3
        NstcM5fy+2prNS3WY8fVkFSw7kkNAhLLq9QF9fDX4qoC+dOzUO98g+BMlHXooL95
        f7gbLBcmFu0HF9weDBybkEjUbWw4STdgmLoy6bOyo5vOko11mxXQ8O9s69oAWuSx
        mKfP4842tuxR2IFSteFWQNfVBtmDqOnqGOAm1IwHX35Kv33QRGMn5IjJdqI7L2xW
        S0hmUbmarn3QfPOK5q+BYu77axj5PI2OWBRVQnh/mOMGQ0dKaG70BN+ePdx45Qmy
        FGrUzaopbsDVpxgZLTrHnpsq8GJr9u4Qlcg==
X-ME-Sender: <xms:2pQkZKFKuwUzCpTWzq8-gzR7bK204dAz-vNQ-cfD7Kkp1Yhoopzyag>
    <xme:2pQkZLWILWj5M8PYD0SBLrg6YFzQFmH2PahnRMUabVGDRUjj-Hr9W7iWWcSYFY9q8
    k0nsi3GFgelnrL1eKI>
X-ME-Received: <xmr:2pQkZEIrcjgRZ4BFpYsBj3l9bF4R-LHhI5YTEKBjK2PjQ1X2tez9ROQ0ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeeitdeuffevieeufedtuddvffffffegfffgkeeihfelleektdelhfev
    hfduudfhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:2pQkZEEjNf1jhq2iHMQh7Vq0Jy1Q-PU9n2tXfCmZenjPELS4Gjnspg>
    <xmx:2pQkZAUtfKcVcd36jSNkx610YGENlHZZGiu2NKQlG5Lo9L2wETrhfw>
    <xmx:2pQkZHNF1Dc3Rv60Ie034K46e1BsI_fjMqvGSCkaM47nkbY_mh_yLg>
    <xmx:2pQkZBvPwNxcBE0Yni0iyKuKgVClJQe0c_OYi3tW-HXNwy-nslNWtQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:43:21 -0400 (EDT)
Date:   Wed, 29 Mar 2023 21:43:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230329194320.who2gobizgffbzqz@penduick>
References: <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <20230324123157.bbwvfq4gsxnlnfwb@houat>
 <CABVgOSn8H=9pQfY7Exc-e37Nm6u299AJLYup6R-_97v5Fb4bpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSn8H=9pQfY7Exc-e37Nm6u299AJLYup6R-_97v5Fb4bpQ@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Sat, Mar 25, 2023 at 01:40:01PM +0800, David Gow wrote:
> On Fri, 24 Mar 2023 at 20:32, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
> > > On 3/23/23 18:36, Maxime Ripard wrote:
> > > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> > > > > On 3/23/23 14:29, Maxime Ripard wrote:
> > > > > > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > > > > >
> > > > > > This is the description of what was happening:
> > > > > > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiy=
tl@houat/
> > > > >
> > > > > Thanks Maxime. Do I read this correcty. The devm_ unwinding not b=
eing done
> > > > > when root_device_register() is used is not because root_device_un=
register()
> > > > > would not trigger the unwinding - but rather because DRM code on =
top of this
> > > > > device keeps the refcount increased?
> > > >
> > > > There's a difference of behaviour between a root_device and any dev=
ice
> > > > with a bus: the root_device will only release the devm resources wh=
en
> > > > it's freed (in device_release), but a bus device will also do it in
> > > > device_del (through bus_remove_device() -> device_release_driver() =
->
> > > > device_release_driver_internal() -> __device_release_driver() ->
> > > > device_unbind_cleanup(), which are skipped (in multiple places) if
> > > > there's no bus and no driver attached to the device).
> > > >
> > > > It does affect DRM, but I'm pretty sure it will affect any framework
> > > > that deals with device hotplugging by deferring the framework struc=
ture
> > > > until the last (userspace) user closes its file descriptor. So I'd
> > > > assume that v4l2 and cec at least are also affected, and most likely
> > > > others.
> > >
> > > Thanks for the explanation and patience :)
> > >
> > > >
> > > > > If this is the case, then it sounds like a DRM specific issue to =
me.
> > > >
> > > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > > properly deal with hotplugging.
> > >
> > > I must say I haven't been testing the IIO registration API. I've only=
 tested
> > > the helper API which is not backed up by any "IIO device". (This is f=
ine for
> > > the helper because it must by design be cleaned-up only after the
> > > IIO-deregistration).
> > >
> > > After your explanation here, I am not convinced IIO wouldn't see the =
same
> > > issue if I was testing the devm_iio_device_alloc() & co.
> >
> > It depends really. The issue DRM is trying to solve is that, when a
> > device is gone, some application might still have an open FD and could
> > still poke into the kernel, while all the resources would have been
> > free'd if it was using devm.
> >
> > So everything is kept around until the last fd is closed, so you still
> > have a reference to the device (even though it's been removed from its
> > bus) until that time.
> >
> > It could be possible that IIO just doesn't handle that case at all. I
> > guess most of the devices aren't hotpluggable, and there's not much to
> > interact with from a userspace PoV iirc, so it might be why.
> >
> > > > I'm not sure how that helps. Those are
> > > > common helpers which should accommodate every framework,
> > >
> > > Ok. Fair enough. Besides, if the root-device was sufficient - then I =
would
> > > actually not see the need for a helper. People could in that case dir=
ectly
> > > use the root_device_register(). So, if helpers are provided they shou=
ld be
> > > backed up by a device with a bus then.
> > >
> > > > and your second
> > > > patch breaks the kunit tests for DRM anyway.
> > >
> > > Oh, I must have made an error there. It was supposed to be just a
> > > refactoring with no functional changes. Sorry about that. Anyways, th=
at
> > > patch can be forgotten as Greg opposes using the platform devices in =
generic
> > > helpers.
> > >
> > > > > Whether it is a feature or bug is beyond my knowledge. Still, I w=
ould
> > > > > not say using the root_device_[un]register() in generic code is n=
ot
> > > > > feasible - unless all other subsytems have similar refcount handl=
ing.
> > > > >
> > > > > Sure thing using root_device_register() root_device_unregister() =
in DRM does
> > > > > not work as such. This, however, does not mean the generic kunit =
helpers
> > > > > should use platform_devices to force unwinding?
> > > >
> > > > platform_devices were a quick way to get a device that would have a=
 bus
> > > > and a driver bound to fall into the right patch above. We probably
> > > > shouldn't use platform_devices and a kunit_device sounds like the b=
est
> > > > idea, but the test linked in the original mail I pointed you to sho=
uld
> > > > work with whatever we come up with. It works with multiple (platfor=
m,
> > > > PCI, USB, etc) buses, so the mock we create should behave like their
> > > > real world equivalents.
> > >
> > > Thanks for the patience and the explanation. Now I understand a gener=
ic test
> > > device needs to sit on a bus.
> > >
> > > As I said, in my very specific IIO related test the test device does =
not
> > > need a bus. Hence I'll drop the 'generic helpers' from this series.
> >
> > So, I went around and created a bunch of kunit tests that shows the
> > problem without DRM being involved at all.
> >
> > It does three things:
> >
> >  - It registers a device, attaches a devm action, unregisters the device
> >    and then checks that the action has ran.
> >
> >  - It registers a device, gets a reference to it, attaches a devm
> >    action, puts back the reference, unregisters the device and then
> >    checks that the action has ran.
> >
> >  - It registers a device, gets a reference to it, attaches a devm action
> >    that will put back the reference, unregisters the device and then
> >    checks that the action has ran.
> >
> > And in three cases: first with a root_device, then platform_device, then
> > a platform_device that has been bound to a driver.
> >
> > Once you've applied that patch, you can run it using:
> >
> > ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/ d=
evm-inconsistencies
> >
> > You'll see that only the last case passes all the tests, even though the
> > code itself is exactly the same.
> >
>=20
> This illustrates the problem very nicely, thanks.
>=20
> I played around a bit with this, and I'm definitely leaning towards
> this being a bug, rather than intentional behaviour. There's actually
> an explicit call to devres_release_all() in device_release() which
> seems to suggest that this should work:
> /*
> * Some platform devices are driven without driver attached
> * and managed resources may have been acquired.  Make sure
> * all resources are released.
> *
> * Drivers still can add resources into device after device
> * is deleted but alive, so release devres here to avoid
> * possible memory leak.
> */
>=20
> My "solution" is just to call devres_release_all() in device_del() as
> well, which fixes your tests (and the drm-test-managed one when ported
> to use root_device_register() or my kunit_device_register() API[1]).
>=20
> --8<--
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 6878dfcbf0d6..adfec6185014 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3778,6 +3778,17 @@ void device_del(struct device *dev)
>        device_platform_notify_remove(dev);
>        device_links_purge(dev);
>=20
> +       /*
> +        * If a device does not have a driver attached, we need to clean =
up any
> +        * managed resources. We do this in device_release(), but it's ne=
ver
> +        * called (and we leak the device) if a managed resource holds a
> +        * reference to the device. So release all managed resources here,
> +        * like we do in driver_detach(). We still need to do so again in
> +        * device_release() in case someone adds a new resource after this
> +        * point, though.
> +        */
> +       devres_release_all(dev);
> +
>        bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
>        kobject_uevent(&dev->kobj, KOBJ_REMOVE);
>        glue_dir =3D get_glue_dir(dev);
>=20
> -->8--
>=20
> It doesn't _seem_ to break anything else, and I've managed to convince
> myself that it's probably the correct fix.

Yeah, as an outsider, I came to the same conclusion last time...

> (Albeit, as someone with a limited knowledge of this part of the code,
> who also hasn't had quite enough sleep, so take that with some salt.)

=2E.. but as someone that also have a limited knowledge of that part of
the code, I certainly wasn't sure it was the proper thing to do :)

> Still, I'd agree with Greg that it'd be great to have versions of your
> tests upstream before making any such radical changes.

I just submitted them.

Thanks!
Maxime
