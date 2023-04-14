Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15446E1FE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNJxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 05:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 05:53:15 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B42B9027;
        Fri, 14 Apr 2023 02:53:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id AAF1D2B0679D;
        Fri, 14 Apr 2023 05:53:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Apr 2023 05:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681465989; x=1681473189; bh=IuAt25PuIwklRF6lreyCDjd9ANtwMrdRQyA
        e2Pl8oSw=; b=mrubuJ3pUqucxIgcnTobWejh8sU5RM2yjKfxicfUpurcdS1ql28
        qJ9G2RMu2ZjVoCmC6mqz6pv3uMONr2INMhoUIg+GpvYE5kyNpclfREj/AXloLWJb
        sO705sT66L2P4AaMMTj5mvwJ6ZGkAo8ZiLjx8i0e5yPiNPayyrIV3gxpKq1nvQCH
        vmlXnAdJo7n86K+5D3Pw/qaX3J0tnvNR1YtTGdY+sbK6iaM/gjsHyABVz73w33wA
        JqFPRdoGRRmzAcs5beo+XbZ0+UN1HmQZegzWIW7lIuDftE90s9s0TKo1Wp6pY0+A
        0AG5vP5Fi3RHpsABvcwuR41B9VERdJU1Bmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681465989; x=1681473189; bh=IuAt25PuIwklRF6lreyCDjd9ANtwMrdRQyA
        e2Pl8oSw=; b=f9lXfpp0A9wAwmAD81ZEwHm5nhO5d9rdbQud9QjZfrnmRZ35Ujc
        QfB+qB8Dxlcyn5SLuVim1cCnZn1/NDhaFK7RCaS8Xcr9d+V229M6RUfY7FuahDIa
        T1lbEZG6MnIxV7qBxXP3KXaRbCdZRkVfsVNJmgExeJ0KYmsEiKAZLhyj/nDoNPtY
        hjGWup1lSDzvwa71wfZVfcyMQCk5zHKlzGcd7C94vFnuuFpBYyj9mfjkawEFhsQF
        BcCQ7pfOEJvt4iPua7FcJjIofdpZC+/CorxEKtMqijppTh3slcnTIzPO7yL/B8ac
        icyBue5aKtJ5dkgvyCYM7N1sftyw0egiFDA==
X-ME-Sender: <xms:hSI5ZLn_QD4jvukQ6zsQ9wG8OpXcFK0j0qPjdIPviWOBNJQydlJ6vA>
    <xme:hSI5ZO0z71shGjZbdASwQAgvsdXLYpwA8FKlOvdez5o0QIZeJAALUUmvV2X_c0eT_
    iiW2zbLPmu06QuyuNc>
X-ME-Received: <xmr:hSI5ZBpiXGm4K2fc_nklEr9HGM2D63IwSY4s6_z_7zn1Gbv85wSFtLIX9ENFGAvggT7ztw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhfstddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgeehheeljeeftdektedvudejvdekueejkeevueektdeuvedthfeljeff
    gffhvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hSI5ZDmNVB3GlqWYaEjSSsij9DqSeq_XUcAvQ9GPOun19lONftL6mQ>
    <xmx:hSI5ZJ0bsU4L7UfKQ-bYVgg-VXi3fAYyWKvCBWROx6mf2nhPOtaaEg>
    <xmx:hSI5ZCts2rtlOecXu1NQ8qFGN9vAZyc0uPKg5ZBxbknzGnDwq7pPRg>
    <xmx:hSI5ZIA59Msh5M_Qvi-Q9PkOo9sJp9BfbewXfk34q74T3Cr__cO0gvy68HE>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 05:53:08 -0400 (EDT)
Date:   Fri, 14 Apr 2023 11:53:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
Message-ID: <7btnpvso6mwocb3vycxklcbq37bwdggpeuju3lp2aaye62jr7r@d27cuwze63bs>
References: <20230331080411.981038-1-davidgow@google.com>
 <20230331080411.981038-2-davidgow@google.com>
 <20230404133231.ingzo7xy7lejpqqb@houat>
 <CABVgOS=SM0NaS4aUTfv06jFWcD4K2k-dU297ssdfT0gZHQnfoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=SM0NaS4aUTfv06jFWcD4K2k-dU297ssdfT0gZHQnfoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 05, 2023 at 03:47:55PM +0800, David Gow wrote:
> On Tue, 4 Apr 2023 at 21:32, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi David,
> >
> > Looks great, thanks for sending a second version
> >
> > On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > > +/**
> > > + * kunit_remove_action_token() - Cancel a deferred action.
> > > + * @test: Test case the action is associated with.
> > > + * @cancel_token: The cancellation token returned by kunit_add_actio=
n()
> > > + *
> > > + * Prevent an action deferred using kunit_add_action() from executin=
g when the
> > > + * test ends.
> > > + *
> > > + * You can also use the (test, function, context) triplet to remove =
an action
> > > + * with kunit_remove_action().
> > > + */
> > > +void kunit_remove_action_token(struct kunit *test, struct kunit_acti=
on_ctx *cancel_token);
> >
> > It's not clear to me why we still need the token. If
> > kunit_remove_action() works fine, why would we need to store the token?
> >
> > Can't we just make kunit_add_action() return an int to indicate whether
> > it failed or not, and that's it?
> >
>=20
> So the distinction here is that the (function, context) pair doesn't
> uniquely identify an action, as you can add the same action multiple
> times, with other actions interleaved. A token encodes _which_ of
> these actions is being triggered/cancelled: the non-token variants
> always cancel the most recent matching function. Without the token,
> there's no way of removing an action "further down the stack".

> Take, for example, two functions, add_one() and double(), which are
> (*ctx)++ and (*ctx) *=3D 2, respectively.
> int var =3D 0;
> tok1 =3D kunit_add_action(test, add_one, &var);
> kunit_add_action(test, double, &var);
> tok3 =3D kunit_add_action(test, add_one, &var);
>=20
> // The call:
> kunit_remove_action(test, add_one, &var);
> // is equivalent to
> kunit_remove_action_token(test, tok3);
> // and gives var =3D 1 as a final result
>=20
> // If instead we want to remove the first add_one, we use:
> kunit_remove_action_token(test, tok1);
> // which cannot be done using kunit_remove_action()
> // gives var =3D 2 instead.

Sure, I still think we're kind of over-engineering this. request_irq,
devm_add_action and drmm_add_action all use that the irq/device, address
of the function and the context value to differentiate between
instances, and we never had the need for any token despite having
thousand of users.

Given that actions are supposed to be unrolled in the opposite order, I
think that removing the last action that match makes the most sense.

> There's also a (minor) performance benefit to using the token
> versions, as we don't need to do a (currently O(n)) search through the
> list of KUnit resources to find the matching entry. I doubt too many
> tests will defer enough to make this a problem.
>=20
>=20
> That being said, given no-one actually needs this behaviour yet, it's
> definitely something we could add later if it becomes necessary. I
> doubt it'd be useful for most of the normal resource management
> use-cases.

Yeah, I guess it's the best approach for now.

Thanks!
Maxime
