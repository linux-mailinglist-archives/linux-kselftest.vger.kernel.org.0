Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091706C7E3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjCXMqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCXMqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 08:46:54 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156F1C595;
        Fri, 24 Mar 2023 05:46:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4CDC23200941;
        Fri, 24 Mar 2023 08:46:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 24 Mar 2023 08:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679662009; x=1679748409; bh=Y2Q7ELOpaaew9OGvSw8gV0Ln8pK5hENZJxN
        1SeZXLxs=; b=NH+8utHLmTubICeqTsATezmQpjVNWQ/jtH5FZm1kO2UT+0vI+/v
        IiTw47DQKH5Lm3NV1KVfFaguya3Ih4kFGPdlETynAuy+fsa0qhWJVckSZplFeaGD
        wYYKECiH/33S0LbWG1fw0Dyy/3gl1q/Wzvnq7iIdzVTHIMqqe3CEJViGWqch9ag+
        m+CuGlxHdBXRi3WgK4C74Tej0l1P7MdrixRSAvu+9MtsT3T7A6nEMN/Ko4FI70sz
        33dqCfKSykPnzuDqhrQ1vXip9QdxLYm/+OGTRQOw9rPXdC6Ci1NrSpG88SCR3I8d
        Ph85C9Q2M4w6UhXtyqOl7KXZxf25iK7xmQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679662009; x=1679748409; bh=Y2Q7ELOpaaew9OGvSw8gV0Ln8pK5hENZJxN
        1SeZXLxs=; b=pJgAuaAcQa+XXxsbjGmdsbHODbnkvCqRvoF2LrEKnpK/WhUkz0L
        bLYYj5SvWEDfOSH7j+ASs2iYYkXmesP6oUGPAt68yK3VYk6Xt6YiJxG029dF7qp2
        aPnc911xOJDFPph57njw+6IJMSKzKE7ayOrMnxR4hVejqhvlyH6mpAuC/SwgBHXv
        f5T6gCaPDjPhqAIFKwSuL4trJOhDQONNUePbEwrJ00CFQUNtm35BrJI6NKETz7+I
        KTaMYojk/JqseDUDXVbBjMglehh/4nCgvvrosBjCeNE5fq7fjfixh83ts5IYM+wS
        2MkQEJ0GTd313UeV7gk737HTZS+W+bFZK1Q==
X-ME-Sender: <xms:uZsdZKKMjzE9WY5pnm4Zgv8coCT5vA92n1DzbxFdtyPo24W3ZCmR7A>
    <xme:uZsdZCKJxntBvLx4N3i5Y4wm4ydXTqaGEqk5H6OnDCQR0QTlWoQXY7De1hzMOR1zu
    1ESHrS2soUVfPU2Akc>
X-ME-Received: <xmr:uZsdZKtHdfEi0OX4dU3PE_oo8SbDWnAOZOnrIntX57ib8ztCQU-wxlcTDBU-CmzEFd-4IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepiedtueffveeiueeftdduvdffffffgeffgfekiefhleelkedtlefhvefh
    udduhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:uZsdZPaR2s37Egz-AL_TTL37_1J2LpUDAhhB-CefixNYOFKTCRGWnQ>
    <xmx:uZsdZBbuPiTdLGnFmyAzW1CHZNp4Lx66Ah5lHyMFFwwg6W2v76kIZg>
    <xmx:uZsdZLC_4QlnQYKUyoRqJ5mF_Ii_zzsR_JVBF-65ehoI_vs01-OxUw>
    <xmx:uZsdZMsUHYZhDkm-BjGdIjeS5rpHqRSkVm5NqjIJwYiC5mjmeEDjZw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 08:46:49 -0400 (EDT)
Date:   Fri, 24 Mar 2023 13:46:48 +0100
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
Message-ID: <20230324124648.fppzhkbowjg4bvbd@houat>
References: <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSnMeoRzExfqsjC_zAX_=TyqpAFuiGD6NWkus7+2Rdho4A@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 02:34:19PM +0800, David Gow wrote:
> On Fri, 24 Mar 2023 at 14:11, Matti Vaittinen <mazziesaccount@gmail.com> =
wrote:
> >
> > On 3/23/23 18:36, Maxime Ripard wrote:
> > > On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> > >> On 3/23/23 14:29, Maxime Ripard wrote:
> > >>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> > >>>
> > >>> This is the description of what was happening:
> > >>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@h=
ouat/
> > >>
> > >> Thanks Maxime. Do I read this correcty. The devm_ unwinding not bein=
g done
> > >> when root_device_register() is used is not because root_device_unreg=
ister()
> > >> would not trigger the unwinding - but rather because DRM code on top=
 of this
> > >> device keeps the refcount increased?
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
> > > that deals with device hotplugging by deferring the framework structu=
re
> > > until the last (userspace) user closes its file descriptor. So I'd
> > > assume that v4l2 and cec at least are also affected, and most likely
> > > others.
> >
> > Thanks for the explanation and patience :)
> >
>=20
> Thanks from me as well -- this has certainly helped me understand some
> of the details of the driver model that had slipped past me.
>=20
> > >
> > >> If this is the case, then it sounds like a DRM specific issue to me.
> > >
> > > I mean, I guess. One could also argue that it's because IIO doesn't
> > > properly deal with hotplugging.
> >
> > I must say I haven't been testing the IIO registration API. I've only
> > tested the helper API which is not backed up by any "IIO device". (This
> > is fine for the helper because it must by design be cleaned-up only
> > after the IIO-deregistration).
> >
> > After your explanation here, I am not convinced IIO wouldn't see the
> > same issue if I was testing the devm_iio_device_alloc() & co.
> >
> > > I'm not sure how that helps. Those are
> > > common helpers which should accommodate every framework,
> >
> > Ok. Fair enough. Besides, if the root-device was sufficient - then I
> > would actually not see the need for a helper. People could in that case
> > directly use the root_device_register(). So, if helpers are provided
> > they should be backed up by a device with a bus then.
> >
>=20
> I think there is _some_ value in helpers even without a bus, but it's
> much more limited:
> - It's less confusing if KUnit test devices are using kunit labelled
> structs and functions.
> - Helpers could use KUnit's resource management API to ensure any
> device created is properly unregistered and removed when the test
> exits (particularly if it exits early due to, e.g., an assertion).
>=20
> I've played around implementing those with a proper struct
> kunit_device and the automatic cleanup on test failure, and thus far
> it -- like root_device_register -- works for all of the tests except
> the drm-test-managed one.

Yeah, like I said you need a device that has been bound to a driver for
it to work at the moment.

I guess for driver mocks we could move to a setup where we get
kunit-specific drivers like what Stephen has been implementing for the
clocks but I guess we would need to register the kunit tests in the
driver probe which doesn't look like it's possible at the moment?

Maxime
