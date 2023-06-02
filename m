Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34B72061D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjFBP1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbjFBP1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:27:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E95A170A;
        Fri,  2 Jun 2023 08:27:10 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 861935C0107;
        Fri,  2 Jun 2023 11:27:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Jun 2023 11:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685719628; x=1685806028; bh=EA
        n509B42z4RvrXjkGuSHFSke8zfjodcTwhfhG1xSoQ=; b=MLGBdaGhzZiVYaNICr
        q9ianAiGmqejNg9pm7QFamLBy5qiYeqW/vJXKV1wf67fKYEl2WF34QojYxL5XTwp
        mXKgdnj3MwroNZuBRgWCmcw332bI5FHG96JmFXV5+nWQ8kKDnLdHpFPgtUmTTnOm
        FJVY14ATK+f1YKMb4KEY8GO5QL+mwwzqOSFPtbTzTfdGVL7x2aK4Q1rxzDGsYOXh
        zegp5M7H49Tpon6SBm2P04tncdD8tLNNvlmyGCErH0tAZpQLBPtUFOMAAo/L3bOa
        7Lu7QLCwXkNXlu0VjVq8POE02RYQEmb5QoS8jUfCMRv28hBTpl9ceHaqnjdetwYK
        LJWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685719628; x=1685806028; bh=EAn509B42z4Rv
        rXjkGuSHFSke8zfjodcTwhfhG1xSoQ=; b=GgG+/rYDns3+9qvAfUByIbOhe5Ljn
        wYtsPmlwcT4TdOyfoHmiGywqQhI8uBAKOAjHbd8cKzvUmbe4QD3ZH9Q8QqMmp8AG
        2QxnrK5363OQZP3vL+cb7bPZHXVqsMr2SuRb6zMWHq6x9z7JAuE58GDGI9j0CqA/
        /RGlEztBp30bUPVwGf+Y7yOZOMhGTEn05NOsLdJKPW9Q5FKlZ7j7JSjnMTofVG0E
        PBUUT/wDH6kjtYHv4BJc21Qvs0k0CngXgYRhKnAlNbTACEwbj+AVsrHyzzZkdQ60
        ksdWsn6k1zRLTxqtZh38oEky/o6mfHvTrejRR8yU1QgU5Qbtoa0ZKIw+Q==
X-ME-Sender: <xms:Swp6ZCcsAcapujBwFFSXjO5yJJm6I7O3Tzwf-eK4n3dSsvLG7i0E-g>
    <xme:Swp6ZMPyFCqg4jhArYoWmvZrcPHDbt7w5_8lGUfhTVo75aaRQYoFrvHcOG4OTBAtn
    HofupmBKPNHaBqbG4U>
X-ME-Received: <xmr:Swp6ZDjnKpoQgG28oUaXDmuSs8UNAkTUh_oE_7a6pxVg9g17iCIgaeGOvcNd--D54toZRE559gfd40PmXcX4NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:Swp6ZP8uhCzybm2gKzMxQJ89yCGIc9kiAGgvVx0rPJ37BYLSuQIBtA>
    <xmx:Swp6ZOvg2GdcjEd8IaaY-d4T8dvwsRJC7lp-zAfsjYGh-yjwsqfz0w>
    <xmx:Swp6ZGGC9bSxhERi_Kr3ppNjltPwDUppPYp0O8gtIQ9u09dZgKJWcg>
    <xmx:TAp6ZAWg2_SO1jtQp4YCiVZ1wcwcCOH4uMFif_MDhzdNTAj_I5slug>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 11:27:07 -0400 (EDT)
Date:   Fri, 2 Jun 2023 17:27:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <aix7tdvpegbkfe3okbrxu6phk7gnzfttrkmomocwofi5kkoaqz@25oaumodlg7j>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
 <wiej2vps6uhozcpxeye3xfgpnlvxcbaek73px36f4jsef3e77p@ewcsmzrxzhsi>
 <2023053137-leggings-grumbly-a33a@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4a5e5qpdgsdrrqyo"
Content-Disposition: inline
In-Reply-To: <2023053137-leggings-grumbly-a33a@gregkh>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--4a5e5qpdgsdrrqyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 08:20:13PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Apr 17, 2023 at 06:12:26PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Mar 29, 2023 at 08:38:30PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > This follows the discussion here:
> > > https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnf=
wb@houat/
> > >=20
> > > This shows a couple of inconsistencies with regard to how device-mana=
ged
> > > resources are cleaned up. Basically, devm resources will only be clea=
ned up
> > > if the device is attached to a bus and bound to a driver. Failing any=
 of
> > > these cases, a call to device_unregister will not end up in the devm
> > > resources being released.
> > >=20
> > > We had to work around it in DRM to provide helpers to create a device=
 for
> > > kunit tests, but the current discussion around creating similar, gene=
ric,
> > > helpers for kunit resumed interest in fixing this.
> > >=20
> > > This can be tested using the command:
> > > ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/
> > >=20
> > > Let me know what you think,
> > > Maxime
> > >=20
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > Is there any news on this?
>=20
> Can you resend, last I saw the kernel test robot had a problem, which
> causes any patch series like that to be ignored by me.

Yeah, this was due to .kunitconfig being ignored by .gitignore, which
triggers a warning for the bot.

It's now fixed (at least in next), and I just resent the patches

Thanks!
Maxime

--4a5e5qpdgsdrrqyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZHoKSQAKCRDj7w1vZxhR
xXI0AP92qZlvkY6tZTf/o96Lk7z7mgalTkrKk3lDwB+Y2+jYnAEA/uqb5/rYKIDu
y4MSGyib4QSms9nvdN7YIC53SV364wQ=
=m7wS
-----END PGP SIGNATURE-----

--4a5e5qpdgsdrrqyo--
