Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1BD6E4E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQQMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDQQMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:12:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94346E9D;
        Mon, 17 Apr 2023 09:12:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 28FA45C0076;
        Mon, 17 Apr 2023 12:12:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Apr 2023 12:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681747949; x=1681834349; bh=+7
        9bp16JJKfLxn8Ztbq4ez9hshDVirLYX87ZqF+q2aE=; b=H9a6OZJKAEEau0VeJP
        FnXq3p+dMGmKiAcUUumwNvzJz/XHqS3vRRIOsGm8qATtSGC1NTWVc4M3vZu2gwb2
        ciJ9rl0cDVNl78EEAbdWmzYiNM3Qb6wc/6B2hLqfDC3q/7YkL6aNdejt49iuCPme
        TrArpaEm2Y3cNmNVRyw4po07doJYEl/nBiG/FWu3DNPmWP7GISD7gfDUn8i+tR/D
        U6gq1g5CCsKCNHegWkYwXFK0Tt+S+lvR1Fps+PHXE038XY7oGS8xLG8xTVgZNGqv
        lbTjkv4KSwj4h6oKjITQUOtpD0XupGNC6IwrP1jLUDjPUojuEPPxCOJ5uitXOGaR
        L2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681747949; x=1681834349; bh=+79bp16JJKfLx
        n8Ztbq4ez9hshDVirLYX87ZqF+q2aE=; b=caFSz5aYUSpbLaHFF9XOKboBznDlW
        7iR2IgFWM+ADsKvHfcwfn+UPHEHuezJdv3gfyrBsqMJRN0ZmTUHvDatyvbNlRcgC
        thcz1TqOShe2g/fkGFF5o9n0cf9J0R52CG0TpiP7IW0T+9ZAA3++cVlBF1C+zVYu
        OxYABtxru1clcrCoaZlaRyuvruXgBtkG76In/x3o/ERX4+0VVrlxT3xjgGB8bibg
        HqyODkYgSMOE9Y3Kd8CIcdmyxKm4ZpHV3NUpLt3UZIPN+bFOCkYkeiCNe5ZItElf
        1V4/J5FJpH5oLfl0YgpVLgCWr9FFcf7P8Ld15D/AGWWL9HlqjfvgEOEIw==
X-ME-Sender: <xms:7G89ZOLpGN4-uLchc5y1PVO10fnW1qCAa4oACZYVYz0DW4ONi9M_oQ>
    <xme:7G89ZGK9CtMtejG3b43JqnPE1uZr54pf0inJXKB6NGNnmlUGqsZGwtbX8heYto6bJ
    CvW_d4aJSTicaQ0UVw>
X-ME-Received: <xmr:7G89ZOsGcQu7UWQOP22v5tdx2FuPEvm1D_rBeke4xA4m4UCukm5g5HedbSn-n4ufLmhaAu6onDVRZDaiejRKM98Q3SG37IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:7G89ZDaA3to_jqmR8Awm5kj-mHQCXOSp1oCqbg3Hu9uOCxC9Ww8Dqg>
    <xmx:7G89ZFbf-Fkyv3Z8pYnDwqCzH2dNp6Tmn2o_V6tun_otL88wLcbujQ>
    <xmx:7G89ZPD3zN94xsnakyqtAYgovbB9n33sPfO2lC24HnyqD8KhW4r1QQ>
    <xmx:7W89ZJTcvrjSg8svEY8Tevcn3Xf0SXszUOAUYujDGCK5QTVQdgAnBw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 12:12:27 -0400 (EDT)
Date:   Mon, 17 Apr 2023 18:12:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <wiej2vps6uhozcpxeye3xfgpnlvxcbaek73px36f4jsef3e77p@ewcsmzrxzhsi>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3vntytzvfzhuvix"
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--e3vntytzvfzhuvix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 29, 2023 at 08:38:30PM +0100, Maxime Ripard wrote:
> Hi,
>=20
> This follows the discussion here:
> https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@h=
ouat/
>=20
> This shows a couple of inconsistencies with regard to how device-managed
> resources are cleaned up. Basically, devm resources will only be cleaned =
up
> if the device is attached to a bus and bound to a driver. Failing any of
> these cases, a call to device_unregister will not end up in the devm
> resources being released.
>=20
> We had to work around it in DRM to provide helpers to create a device for
> kunit tests, but the current discussion around creating similar, generic,
> helpers for kunit resumed interest in fixing this.
>=20
> This can be tested using the command:
> ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/base/test/
>=20
> Let me know what you think,
> Maxime
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Is there any news on this?

Maxime

--e3vntytzvfzhuvix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZD1v6gAKCRDj7w1vZxhR
xZR0AP45BGKIrcwUspyxe29C35X5W65gax24OfzIDvVIa6a9VAD/WkKJw+EuINNY
hnhOJyDbR/XU8EYHCa6Im7j0MVwazwI=
=WfbU
-----END PGP SIGNATURE-----

--e3vntytzvfzhuvix--
