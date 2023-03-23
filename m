Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1F6C6DDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 17:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjCWQja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjCWQjL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 12:39:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF835EF8;
        Thu, 23 Mar 2023 09:37:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EDCF75C00BA;
        Thu, 23 Mar 2023 12:36:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 Mar 2023 12:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679589401; x=1679675801; bh=E4
        if9a3f9X77bOqnOjkoI5r0nXevqMRV38iVxaTmEaw=; b=g6/3/dAPpfW7mZxRyV
        jPOpRzoyHXVPTKrALp/6Zwe9xO10hFRBcAvyZBM2dEjgYOK6hbiHF9bjSYJnWIT1
        wylR3m+93h12OQAGpv5Lf9/gNEFez2Ptzd3HIC3pDoU1s8GC31LpE0CfmszvhIv0
        3OklsofQDnBz3CGwMygcgs2lBOiGnJP1PJYGbkxemSIEP43Cx+YTeYD0rS3reD1k
        rWyJfDhqc3JllW5a4/Lpe16UFPI2P0qEWXgH/niYJG8NKDsm0FLs7nBSEM7OLiO7
        UQ9BGLry/ceQugSHSnjRSQ7Zd/QFs6mso1RWbMSe06G4yAXWripOvAWfCPI1W0KW
        /1Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679589401; x=1679675801; bh=E4if9a3f9X77b
        OqnOjkoI5r0nXevqMRV38iVxaTmEaw=; b=f7pdvdHCS5EL5R+baqKkwkuQa5f8G
        UOzxn6XsttwT0bX91cNI16WTUD787PcZ9N+MZW8lmNjSpExH/MG1c5aT0BfV8bFY
        76kmdLfLewjpc8fBRmVWsCZKmpUXC7Oor0co5mTlQh8slQdyE3EaMQMlB9RYC0iC
        qoiCAa4PxGNmLjPFP7PqGarH+xJufg8s3kAg9DD4EzD4XxRaCSnz6J3iSH7iXp46
        hPuSmcarS7w7EHjMzgMpdRlfGZ42A7IHEMcD91M9rHJJdmIZzvcNI/NdsLOIcCd7
        gQ07OG+n6yDvxH8zhK1a5HAY9tFk22A21HB5YJFC4kPoPN+bFEuKAeU/w==
X-ME-Sender: <xms:GYAcZHvRlh92ce2nlDK0uguK8ZvXANlPy5NmN5XVfxPIA0zCxeI8mQ>
    <xme:GYAcZIfPxQKW2_xqbBciptLp86l3JI4Ynzf8TCd4QBAqdK7bjEEe_a6zIlxmpBJep
    cMIvgYFfz_6ZcRK0cE>
X-ME-Received: <xmr:GYAcZKz-gEDOXL1E_Za4TxYfMWnklLV1yHT2dpRtjl9Lyd0IH7WQDlN4YI9RfPpO2I60B6_K2ZrYQKDVvR3SpeOmBM9KIug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:GYAcZGNjLo9mhGVw_9lWJto-Wf-giSOmya4wa_v8DmRdrG1QdnpXBA>
    <xmx:GYAcZH8Hk1nukBpZy9jJv0BsViw9_scgz8WFJvDIi3GB32EGrGhGUQ>
    <xmx:GYAcZGXnUMjfr3ZrNmfcYsbzQCldaNTfXKlHc4J5Nfet_9nAACwjtQ>
    <xmx:GYAcZLQWr1de6_fr9of5v4tTBxCm-YoY7V_mgoCHwc5kZ3NR8y1TlA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 12:36:41 -0400 (EDT)
Date:   Thu, 23 Mar 2023 17:36:39 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20230323163639.xtwpid2uunwnzai4@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="siftfz462ycziuwe"
Content-Disposition: inline
In-Reply-To: <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--siftfz462ycziuwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
> On 3/23/23 14:29, Maxime Ripard wrote:
> > On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> >=20
> > This is the description of what was happening:
> > https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
>
> Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
> when root_device_register() is used is not because root_device_unregister=
()
> would not trigger the unwinding - but rather because DRM code on top of t=
his
> device keeps the refcount increased?

There's a difference of behaviour between a root_device and any device
with a bus: the root_device will only release the devm resources when
it's freed (in device_release), but a bus device will also do it in
device_del (through bus_remove_device() -> device_release_driver() ->
device_release_driver_internal() -> __device_release_driver() ->
device_unbind_cleanup(), which are skipped (in multiple places) if
there's no bus and no driver attached to the device).

It does affect DRM, but I'm pretty sure it will affect any framework
that deals with device hotplugging by deferring the framework structure
until the last (userspace) user closes its file descriptor. So I'd
assume that v4l2 and cec at least are also affected, and most likely
others.

> If this is the case, then it sounds like a DRM specific issue to me.

I mean, I guess. One could also argue that it's because IIO doesn't
properly deal with hotplugging. I'm not sure how that helps. Those are
common helpers which should accommodate every framework, and your second
patch breaks the kunit tests for DRM anyway.

> Whether it is a feature or bug is beyond my knowledge. Still, I would
> not say using the root_device_[un]register() in generic code is not
> feasible - unless all other subsytems have similar refcount handling.
>=20
> Sure thing using root_device_register() root_device_unregister() in DRM d=
oes
> not work as such. This, however, does not mean the generic kunit helpers
> should use platform_devices to force unwinding?

platform_devices were a quick way to get a device that would have a bus
and a driver bound to fall into the right patch above. We probably
shouldn't use platform_devices and a kunit_device sounds like the best
idea, but the test linked in the original mail I pointed you to should
work with whatever we come up with. It works with multiple (platform,
PCI, USB, etc) buses, so the mock we create should behave like their
real world equivalents.

Maxime

--siftfz462ycziuwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZByAFwAKCRDj7w1vZxhR
xZYoAQD0EfI8ZCSq1KpU73P+V49HUzeC9ingQ95MQn3oUWcu3wD9HQRLsSfxvM7A
K3Xa8SyESe39WCse9VZjO2fd9YvqoQM=
=9U43
-----END PGP SIGNATURE-----

--siftfz462ycziuwe--
