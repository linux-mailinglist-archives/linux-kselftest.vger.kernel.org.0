Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E16C646B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCWKHy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCWKHx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:07:53 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC911A;
        Thu, 23 Mar 2023 03:07:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B45E3320091E;
        Thu, 23 Mar 2023 06:07:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 Mar 2023 06:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679566067; x=1679652467; bh=RblL6dUXbHKVKjlWP7JvMod56DsSWn6tJf5
        9H9jjOmE=; b=mQVgBPkYc+VxFHo7RvOF8NxLcfSYDwxTGyRcwYUmUEXkDAtGtMY
        x67WfLlMsIMPyQACggvooS0BvVN917tgHdj3CAAhQisZTcKtUMErdBDAvTyGPqkw
        vk0oPoGN8iK1p/IvfH+zxTmrOEkUNVV2jHOAT+kb/HSzGhjtn2MG+5sD6wP+gFp5
        qdX85yzTPw20WiuP08EaGFkDjfURtttaaLlHwlvxfSnSkb9wgf1QFMORVl0zKssv
        EqH233cs078wtjTVuplmhm3hfIu1x1FIdRN6mEeXmXDPd84MnLdeVDRCBgxmyJSg
        Za6EKm1djL5AyD4AS2BhPDXhdDh7l75yI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679566067; x=1679652467; bh=RblL6dUXbHKVKjlWP7JvMod56DsSWn6tJf5
        9H9jjOmE=; b=N89kIBnxfyKQtevzWOgKY/rIphGp4XESBJl6Ar8gb07Gd9i6f0t
        1ntBFWmNgLfB7FY5gPzh9kCdBbflU3j6fa7d8TP1SCgeS8oY8NMsODRAQqQOMKv/
        4se+g+BnOqic+zabSD0bDc2qCPqSoyUyhQW3tNPL2+7QKli0PLOKMEHtVv3Hxg0s
        twTfH0bd/vdE2Ph8xgQ9braPO7B3XjmOqqzg7lBhzycyNcbzz3j3s7G1kUTav7Rc
        jjBw3i1JzgzjAtYV5XEWBK3D1ugw9LULLN7df66cMmPH7RT34cqnYbVuw3Go1dzl
        aPW9n+/rsJCJQioPydiLkclUPdY9OD/axFA==
X-ME-Sender: <xms:8yQcZDcQnGaTC4OFRVBLi5wUAZBAsRCVFqePBH-iWzvMbfL_K082mg>
    <xme:8yQcZJNtrtMUr_RGuXShShb3J1-Trt3CXZoYNbePY0-aVsxlTi4_prgqL2AnXNKHX
    voymzWIYrXTS4kWnOQ>
X-ME-Received: <xmr:8yQcZMgRm0wl9YOsTn3pJ6It-qaKkyukq_b1zOUWERJX4wRthOHptcUS9TgaxbPzyr2pvYNXhJxTR3_lC5IgKsx-DdWXqS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8yQcZE-uQwmjdRZ76kgj1r8TPXnockXqTpdgOZ5GuN9wujZoXHtnMw>
    <xmx:8yQcZPv1gy_oBH_iqETUpC9qVqbWfQo6JgmAS_ZcmAgHjkX9F1JyDA>
    <xmx:8yQcZDHaebgqmeg5COoe3JLn2oraiOVeD8aNxIOnU0ohacJc5ZrdJA>
    <xmx:8yQcZDDzhJnYuGYsqeoZ-HRQSt67OfgazFsnaGosuSu7YlPyOLeBrw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 06:07:46 -0400 (EDT)
Date:   Thu, 23 Mar 2023 11:07:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <20230323100744.qirdtwsd327apau7@houat>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=KUg+18wJe=O29tgOB0tQghAk030kONEm5fOzJHgKLgw@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 03:30:34PM +0800, David Gow wrote:
> I think the questions we therefore need to answer are:
> - Do we specifically need a platform_device (or, any other specific
> device struct), or would any old struct device work? I can see why we
> would need a platform device for cases where we're testing things like
> device-tree properties (or, in the future, having e.g. USB-specific
> helpers which create usb_device). Most tests just use
> root_device_register() thus far, though.
> - What helpers do we need to make creating, using, and cleaning up
> these devices as simple as possible.
>=20
> I think that in this particular case, we don't actually need a struct
> platform_device. Replacing these helpers with simple calls to
> root_device_register() and root_device_unregister() seems to work fine
> with this patch series for me. (It does break the
> drm_test_managed_run_action test, though.) So I don't think having
> these helpers actually help this series at the moment.

I'm not sure that a root_device is a good option, see below.

> That being said, if they used the KUnit resource system to
> automatically clean up the device when the test is finished (or
> otherwise exits), that would seem like a real advantage. The clk and
> drm examples both do this, and I'm hoping to add an API to make it
> even simpler going forward. (With the work-in-progress API described
> here[1], the whole thing should boil down to "struct device *dev =3D
> root_device_register(name); kunit_defer(root_device_unregister,
> dev);".)

Oh, yes, please make it happen :)

The current API is a bit of a pain compared to other managed APIs like
devm or drmm.

> So, I guess we have three cases we need to look at:
> - A test just needs any old struct device. Tests thus far have
> hardcoded, or had their own wrappers around root_device_register() for
> this.
> - A test needs a device attached to a bus (but doesn't care which
> bus). Thus far, people have used struct platform_device for this (see
> the DRM helpers, which use a platform device for managed resource
> tests[2]). Maybe the right solution here is something like a struct
> kunit_device?
> - A test needs a device attached to a specific bus. We'll probably
> need some more detailed faking of that bus. This covers cases like
> having fake USB devices, devicetree integration, etc.

Yeah, from the current discussion on the IIO and clk patchsets, and what
we've done in DRM, I guess there's two major use cases:

  * You test an (isolated) function that takes a device as an argument.
    Here you probably don't really care about what the device is as long
    as you can provide one. This is what is being done for the DRM
    helpers at the moment, even though it's not really isolated. The
    device is essentially mocked. This could be your points 1 and 2.

  * You want to probe the driver with a fake context. The device and
    drivers are very much real, but the device tree (or whatever) is
    mocked. This is what the clocks patches from Stephen are doing. This
    could be covered by your point 3.

> I'd suggest that, for the majority of cases which only care about the
> first case, let's just use root_device_register() directly, or have a
> thin wrapper like the old root_device-based version of the DRM
> helpers[3]. This will probable serve us well enough while we work out
> how to handle the other two cases properly (which is already being
> looked at for the CLK/DeviceTree patches and the DRM stuff).

I disagree, and I think your cases 1 and 2 should be merged. We were
initially using a root_device in DRM. We had to switch to
platform_device (but actually any device attached to a bus) because a
root device isn't attached to a bus and thus the devm resources are
never freed.

When a function takes a device as an argument, there's a good chance
that it will use devm nowadays, so we ended up exhausting resources
pools (like IDs iirc) when running a lot of tests in sequence.

So yeah, I think you can't just assume that a root device will do even
for a true unit test that would test an isolated function. It either
needs to be tied to a bus, or we need to force the devm resource release
when the root device is removed somehow.

Maxime
