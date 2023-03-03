Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342746A9A19
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCCPBA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 10:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCCPAz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 10:00:55 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBC62DAD;
        Fri,  3 Mar 2023 07:00:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 76ECD58206E;
        Fri,  3 Mar 2023 09:35:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Mar 2023 09:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1677854132; x=1677861332; bh=EhQ9pFjZXP4HTv7ya9gpFDV+YiUqRp+E8wi
        r3tCHXho=; b=I1headauudJSswX9EvaMaMq8BcWzxWf1GaVo8Wlw4FdySSolnyJ
        TA6uUxYnw+dJBczt/cQHmUGM0xE1M/w2OmW+SnSGEpJTCzVCCo1pUuq2F155BLp8
        u27ubW7A0hzJmJsej7z8xMbyZVV89dMs9I10LaSzt5PYlFi8duBYsojDOBz/xBZy
        MRrjwGMGgPdEE3riBCJM8SIfAYTpSK9nfM2qRwrc4YiK4xBq697RlT46sceAib5y
        J8Mi7v6p/BMKMyQJ8PIXgdAp9BaNCb7/ZrCW2+vHgeRlkmTeJPysYO5kNI8x35wE
        2g1myqJgxY6PPJtNNV+h8NnlBspDFm2i9qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677854132; x=1677861332; bh=EhQ9pFjZXP4HTv7ya9gpFDV+YiUqRp+E8wi
        r3tCHXho=; b=Trcg1C7+2n3zXd+Vk5nrLVQ9hvyeM23w9il2QRgPkTdtwBHNmOY
        RBkjbOHXWpfW2xJq902uqJFWcD5y6HST8uXHKuSVc6vh94yH3dkKID70ma+RbsCf
        6py3z7vMm7lXNxi5wJwH742NhN0NP+XGurZkPMIkPD9BxYMBy1dRZlDqhJNbjCYh
        5iM93OEFXWsBLHexd4tQ+PLnEyhzTG/XHWPEyveRApVtPct8oBY/T9f8OL04Q+xm
        MNvjkwWl6oLh+hq7EE2lr/GBgboGQIs/ReWQmHph7OYTWwSI+HRsqIjH7+/wunXf
        RwWL8QZADXkRoAoKITIBqoyqf7hn7P1Pzeg==
X-ME-Sender: <xms:swUCZB1rnweLZk35aHZiBgQWFd-oQS0q4y7Ma-f2gJ1tk6biV4p_Hg>
    <xme:swUCZIHFzqXPPzmmIzzZ8hbg8cu0hT6v9WDLAMa2qvNbZmz6_fgLUPXbYk3nsoO1S
    yzmgkFIx8dmUN1DofE>
X-ME-Received: <xmr:swUCZB5WyEYUImTMYsXup4NV2rGqlQ4CXRbFaXA3rvitzHJ1MtjSdfh1-yc7HfAJomfXhRJ-_TntgLzh0LWjcYD5iNeOtUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepiedtueffveeiueeftdduvdffffffgeffgfekiefhleelkedtlefhvefh
    udduhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:swUCZO0KN82qNQan-BTftrLDKnylngDMU3kB73-c4kbYIkWqmm5zEA>
    <xmx:swUCZEFZAKmu-VEfiiDvSkw-voCWXL5yTI1_bUG7e_svIUf71SL0Ww>
    <xmx:swUCZP8CKWwnn4NXwiUhJ2CvoZJcEA141NSgtQxxD3V1QOU_R9XBSw>
    <xmx:tAUCZK7yubatAcs36FTKgZwEIF0ZKZ47INAM8_nfsLoYZtA1K_JHFw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 09:35:30 -0500 (EST)
Date:   Fri, 3 Mar 2023 15:35:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
Message-ID: <20230303143528.2dovipmqlms74vp2@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-4-sboyd@kernel.org>
 <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 03, 2023 at 03:15:31PM +0800, David Gow wrote:
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Introduce KUnit resource wrappers around platform_driver_register(),
> > platform_device_alloc(), and platform_device_add() so that test authors
> > can register platform drivers/devices from their tests and have the
> > drivers/devices automatically be unregistered when the test is done.
> >
> > This makes test setup code simpler when a platform driver or platform
> > device is needed. Add a few test cases at the same time to make sure the
> > APIs work as intended.
> >
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >
> > Should this be moved to drivers/base/ and called platform_kunit.c?
> > The include/kunit/platform_driver.h could also be
> > kunit/platform_device.h to match linux/platform_device.h if that is more
> > familiar.
>=20
> DRM has a similar thing already (albeit with a root_device, which is
> more common with KUnit tests generally):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/drm/drm_kunit_helpers.h
>=20
> But that's reasonably drm-specific, so it makes sense that it lives
> with DRM stuff. platform_device is a bit more generic.

I'd be very happy to get something from the core to address the same
thing.

I think the main thing we needed that isn't covered by this patch is we
wanted the device to be bound to its driver, so with probe being called
before calling the test (see 57a84a97bbda).

Maxime
