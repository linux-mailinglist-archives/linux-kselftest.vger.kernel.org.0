Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481526D0BFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjC3Qy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjC3Qya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 12:54:30 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E3EFAA;
        Thu, 30 Mar 2023 09:54:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D95503200932;
        Thu, 30 Mar 2023 12:54:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 12:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680195258; x=1680281658; bh=Cu/vpXYO39IAGQphP3eZA6Aln0263bHcHt9
        rjdw3sxo=; b=jNsXA+9SWjEnSLx736a6bHtVYczYQDPRbz+XnriZY2ZzMlnJaqI
        9Lv268YJehKkh50ut1DPsJeipRAJl+y6vxZrOcqPWxEWSZK7LospX1uH74syOMz8
        ZIjbpGIJ/i2KB7F0d4f+zkgLTDxrVflyVfKd9Br5R3zsIO5sdx+Mukjzf1cZgmEQ
        KVNt4DV4N/KligGQDbdt9NaDHl+pSaRxfS5HuVtYt6PKg+5Ye4y1g9Erf+Qdt1mM
        sddiFvW2Zg2YaXXpukF0/naCumsOETYVJRGDvvyRvseoatUtj+Lmsz5Q+lC8t+DP
        mR+G3szT3osSgS9kXhtJ7g3TcedIljA3qsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680195258; x=1680281658; bh=Cu/vpXYO39IAGQphP3eZA6Aln0263bHcHt9
        rjdw3sxo=; b=K8u7XBPMuCPvy5DJBUHisPfn4q5YNoA+deMi9v6rWraHMSN44Ho
        CkIFh8lPbQVM8L8nMgJnHIn7BXF4Xg8ABTb80BK4zGt6NTjQhAGetasPn4pywm+B
        a7qaPpvqzx8hb5mrGGSck2vAzIm99+1YxGQCZPunAZBhRBvRerG2OvVsYEQCokRt
        Aa+800WdTHygFDJnLW50YXDi0Ys16ZC32WHGFF5yrLm5BigZtd8knX8OnqEbfyXI
        6W5ODyAigrXy1SNgAsEVtXqKsm6WzL/1e4rB4nqgTC3aCE+ZvvtrSLK4E/b1OAOT
        MDS1SB5R1d0gMp4lrET5xIghKu8pfVSjZpQ==
X-ME-Sender: <xms:ur4lZMbcDG89pR1r19C3br3Pd0bqpVMJjvbp9faRV4SVkgzY5wmWjA>
    <xme:ur4lZHYAUlm-AbWsdvEJsi5fWO96PzZOz0KV84VnXEh8t1pLlfu4c_Rr65IRUnmEN
    lglZPUrvzhq4xQiPpM>
X-ME-Received: <xmr:ur4lZG-OfGy3Z9LLgscvkAeiE1rwne8LSzim8cOJAjQE-SzR6OM6nq50ZW3b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepveetfffftdfggfdtheekhedutedtjeeiuefgffejlefhveekjefffeef
    heeuleejnecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghh
X-ME-Proxy: <xmx:ur4lZGrLN-6Yw5eZtLB_eTAXQSNu4IiQOwxrbKTjzI8SKjZR_9FCuw>
    <xmx:ur4lZHqcfjwaS3ALSok0EvmH0kotLBREdymUZGls9OQ4tTnb_cL6Og>
    <xmx:ur4lZETY3A-UArSObdTlvMhF4umR9UdJw7ko7iOBWlwl2B3OEGD97A>
    <xmx:ur4lZK2a3vRxOCHwIarH0Yyqy_zua_ZK03044UW5h_pJOE6y9_W_bw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 12:54:13 -0400 (EDT)
Date:   Thu, 30 Mar 2023 18:53:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 3/7] kunit: Add kunit wrappers for (root) device
 creation
Message-ID: <20230330165335.gwcpoxx7mpwamxx6@penduick>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
 <f2c7f7b04f7e4ee7b9cef73ecba672f5fa40eb73.1679915278.git.mazziesaccount@gmail.com>
 <ZCGFgypeuJXqNwQt@kroah.com>
 <e027fc0c-83e0-be6f-d62b-dac00ce9b761@gmail.com>
 <ZCGONl0mC8oyBj-0@kroah.com>
 <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSnUCsxPf1mAL03GQzaw_kFtgf5J7aTPodo=j6O+wYZ2iQ@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Mar 28, 2023 at 08:45:09PM +0800, David Gow wrote:
> > > Ok. I understood using the root-device has been a work-around in some=
 other
> > > tests. Thus continuing use it for tests where we don't need the bus u=
ntil we
> > > have a proper alternative was suggested by David.
> > >
> > > > Do the right thing here, create a fake bus and add devices to it.
> > > >
> > > > Heck, I'll even write that code if you want it, what's the requirem=
ent,
> > > > something like:
> > > >     struct device *kunit_device_create(struct kunit *test, const ch=
ar *name);
> > > >     void kunit_device_destroy(struct device *dev);
> > >
> > > Thanks for the offer Greg. This, however, is being already worked on =
by
> > > David. I don't want to step on his toes by writing the same thing, no=
r do I
> > > think I should be pushing him to rush on his work.
> >
> > Ok, David, my offer stands, if you want me to write this I will be glad
> > to do so.
>=20
> I'm happy to keep working on this, but would definitely appreciate
> your feedback.
>=20
> I've put my work-in-progress code here:
> https://kunit.googlesource.com/linux/+/refs/heads/kunit/device-helpers%5E=
%21/#F0
>=20
> It creates a "kunit" bus, and adds a few helpers to create both
> devices and drivers on that bus, and clean them up when the test
> exits. It seems to work on all of the tests which used
> root_device_register so far (except those -- only
> test_iio_find_closest_gain_low so far -- which create multiple devices
> with the same name, as the driver name won't be unique), and the drm
> tests work fine when ported to it as well.
>=20
> There's still a lot of cleanup to do and questions which need
> answering, including:
> - Working out how best to provide an owning module (it's currently
> just kunit, but probably should be the module which contains the
> actual tests)
> - Improving the API around drivers: probably exposing the helper to
> create a driver, and add a way of cleaning it up early.

I'm not sure we need to give the ability for a test to pass a driver.
I'd expect there's two main use-cases: either we want to test a function
that uses a device as an argument, or we want to probe the whole driver
and test it.

The former is covered by kunit_device_register(), and I'd expect the
latter to be covered by the work Stephen is doing, where we will load an
entire overlay, which will in turn probe the driver.

> - Properly testing it with modules, not just with kunit.py (including
> looking at what actually appears in sysfs)
> - Experimenting with using probe, etc, callbacks.
> - Cleaning up lots of ugly, still experimental code, documenting, testing=
, etc.
>
> The thought of trying to expand the match function to support, e.g.,
> devicetree occurred to me, but I _think_ that devicetree-based tests
> are probably still better off using a platform_device. Regardless, it
> can probably wait to a follow-up

Yeah, probing the entire driver will require to instantiate the device
the driver expects, hence why relying on the overlays also makes a lot
of sense.

Maxime
