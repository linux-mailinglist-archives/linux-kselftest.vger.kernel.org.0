Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E25671B6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjARMER (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 07:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARMD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 07:03:58 -0500
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 03:21:28 PST
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EA7ED6E;
        Wed, 18 Jan 2023 03:21:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 6E9572B066B3;
        Wed, 18 Jan 2023 06:02:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Jan 2023 06:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674039740; x=
        1674046940; bh=3zDauVDrBD5IYlcejFEH8P/3gtQiLfa4M6BBOvD4PGk=; b=d
        /SokZi5s6PFfRKFx/x+HhBKrl2YwDMN62J0JW917NeqW8Xwwky6FB2fJe7WAZ32o
        9pGra02D8wkjzpVi11TtTiS70iOH7RCS0QdzPgcoJj21Yhd/jkOm/D/DjKnYkSqc
        uSQji6yD8Buc0FdkFeYf0p8oOVKljlRq519ly1dXzjZdzcyBbgFyUYVm+hEYFpc6
        8HNP0AkP/Bt358lKjn6DmgEmipMoBhrCf6hNnagVKCD7L30wTuhOTh0cJ9ipGJHR
        Vnar8RGAs1VbK5hEAiEvGMzCToi3r3EN5EGkW4O6byZrvctVixkK3p6iubqW5a+Z
        IAIxSkZK/AyQFxzK0mw8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674039740; x=
        1674046940; bh=3zDauVDrBD5IYlcejFEH8P/3gtQiLfa4M6BBOvD4PGk=; b=H
        FCDVwouY+JX/r/ireSvac5FEUV1FrHnbSU0G1iEiTAqVXUZxldeaeq4kVItsikhA
        szaGX7R7h2A09rYuKcbKYLbJNKNriHJgGaZp0+Eg6E1UTonYoyb2axz+oMR3kkwU
        6QLFJNFUzrLRsPGO1kfMSRB4rVawpz0YNIuXf7zcwBi9kWkgwGLVUGL3j0yE9tHL
        93TaiZ57anz35x3o9hdzYpRjRjXhpbEN0/3FTfdTC7UjhXQxko2rIvHfUy8LVwjk
        RpsRjxnP8aYDrShh0oipc1OXVj9wqO8BsGvAj8TtSoeU1WRlvGBHKG25FosJLZ3G
        YAuqrSbyDJT8OJauTdAAQ==
X-ME-Sender: <xms:utHHYxOFGWSk2B8MSu5gKaOlu46XNB-oAn_8yvVVy37c-HFHy1TToQ>
    <xme:utHHYz_X5vsrvfF2PCNqCFgPHZjNYu7r94Re6qBNsFRGqQ5n2ME-KvOg_gbEyM1eZ
    vOSQlH-z2URA-P2GIE>
X-ME-Received: <xmr:utHHYwSYIK45Decs67Wye3QyWQhjPAski9vae8I26djfW7WTJSdkmqvRFpxVyNBq78z-x_Opa4kD0eCFfjWTRrUKc__S26wTutz7_VwtkDeUCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepiedtueffveeiueeftdduvdffffffgeffgfekiefhleelkedtlefhvefh
    udduhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:utHHY9u9B00Uanh0x1Ge0z4tj1LswOsHk5J3tzn-bXnkkuhPoyX0tQ>
    <xmx:utHHY5dcBu2e4KC6ixksKdl_8KC51esNnqCzqrkRs23Xt1Z0PIWSDw>
    <xmx:utHHY52y_3AvYbrq0ramv7Izmi6mhSPcKfDa2Mf9KPLj3YpAQebkjg>
    <xmx:vNHHYyvM53WePqH1SyXGD2Beo19IEJeUNfRm-RFelVahHBfN8_cRlQ8j6R0>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 06:02:18 -0500 (EST)
Date:   Wed, 18 Jan 2023 12:02:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joe Fradley <joefradley@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Export kunit_running()
Message-ID: <20230118110215.yexhgghqmmmkibsi@houat>
References: <20230117165039.1871598-1-arnd@kernel.org>
 <CABVgOSnAFM3HozugcOdmgEBja7Q5n1OYkV+ZJ+uFnCaWDTVneQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSnAFM3HozugcOdmgEBja7Q5n1OYkV+ZJ+uFnCaWDTVneQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David, Arnd,

Thanks for fixing this issue

On Wed, Jan 18, 2023 at 08:37:26AM +0800, David Gow wrote:
> On Wed, 18 Jan 2023 at 00:50, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Using kunit_fail_current_test() in a loadable module causes a link
> > error like:
> >
> > ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko] undefined!
> >
> > Export the symbol to allow using it from modules.
> >
> > Fixes: da43ff045c3f ("drm/vc4: tests: Fail the current test if we acces=
s a register")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>=20
> Thanks for fixing this!
>=20
> I think the longer-term solution for this is the "hooks" approach
> (which works even when KUnit itself is built as a module):
> https://lore.kernel.org/all/20230117142737.246446-1-davidgow@google.com/
>=20
> But this looks good to fix it in the meantime.
>=20
> Reviewed-by: David Gow <davidgow@google.com>

How do you want to merge that patch? Will you take it through your tree?

Maxime
