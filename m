Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC86FEDFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjEKIoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEKIoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 04:44:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A7269D;
        Thu, 11 May 2023 01:44:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DA2D5C012C;
        Thu, 11 May 2023 04:44:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 May 2023 04:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683794652; x=1683881052; bh=R9
        VqD6wzJ9+2S9ieidssv+Mz4v5L702oFUBmV8sB3YQ=; b=wdKxKXYE4wa5dQwAkp
        AOzpijAFw9Y3TsrXoW74T9fkj64KyMGfie1hT3Zl+/prXuNGxrkG/IgDUICnpkDI
        XXGdG/S5OOAoBqZwzRnCO0RH9AiZwhDgyFItQnvtdusNtcj3Yzs5Bqxi9mztZpp0
        tVUy75KatFaWOpeHiPR0vvVyVn/RWYAVHSbpdm5qDMlNhxTUov6txAhmml/Z/Agw
        iVexPmLtGJHwdWpkKgj21165Vlgze4z41uW8cBrnLqr83cMBLzpEZQXbAnM3Qpe2
        CN20N7GtJjmIxJlshZzOMcTCClwCOFbJpuy9fq786egA0A2C1v4Z3V/h0sN/o97r
        uFWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683794652; x=1683881052; bh=R9VqD6wzJ9+2S
        9ieidssv+Mz4v5L702oFUBmV8sB3YQ=; b=iPfuyBRlzRQHD6Jt/uxdIGBQDJvnT
        y1TakYZyQbzyKERHzGZr4BPu7/WEHcwTQB6y7jjCfDxDyFWQakjbCikeZR33KN05
        Gzkn1EryxMFDPPKZXn5zsjRdxDjSa6+YeovuqECwJINMXLmNtVcL6TGjWoQcHq2V
        4tTuk1VcQXk9MtHzXGNOwcNtBPBC5RdpT+32Lk7Go6HAEyX4te1wUeGmZpogQ2sj
        sTWIohiT40eN4ZOprOMXsYmv+Ew4DFJtUKTfqJxnP1M2F0JhGui0jmvuuqSCJZEP
        Le8HKGTwhnb/UFPsuqIWYIXR8t+UaDZyNpwR+ZVtKffJZKiAPkk1H7WvA==
X-ME-Sender: <xms:3KpcZNoWBT22YbKi_MmeOwKfkZdmZBjrp96Ld3gS8nrLecDFN5mprQ>
    <xme:3KpcZPqyoPLXLB5OTFEPqWA3DTbf2pthdOOHm8sLre8U_69lC5XOejkjDRyA0ZlLD
    XuhwZGuGrXFRGiJ7ZI>
X-ME-Received: <xmr:3KpcZKMoEXF1ezspX4hHeIcvJamMW_3M9GkcD8lyskkpqmMk5M2cmV7d-9TYWr_iGImLn1vj2b7kkOPSzFejQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:3KpcZI4r-KOOBmDqhOaZYDL_rhs1x2myHwYA7Bl6T1RmxqUaLJGUww>
    <xmx:3KpcZM7j904aGfZJcjEPDCBK3g46St8CaDFULSYAykz4AkCHTElaTA>
    <xmx:3KpcZAivBX3IDCFrc0jLpuXRXklpB4PRAvyYpCh_kORIAWJ1TxlBYQ>
    <xmx:3KpcZGQni5aIO9l8I1DyI1uJPFXq0TVmw9PhEuiPc90-2YuHUAcXxQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 May 2023 04:44:11 -0400 (EDT)
Date:   Thu, 11 May 2023 10:44:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Message-ID: <7rjlinncexvux7qyx5ochk23tstalslfmh6rpqtz7dofuk3jwk@q3bsgi3lixzk>
References: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dku4l7aigas53bcw"
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


--dku4l7aigas53bcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Ping?

How can we move this forward?

Maxime

--dku4l7aigas53bcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZFyq2QAKCRDj7w1vZxhR
xcMUAQC9f1QhkLHDTh90PoFdTg2i2y/lG81SGyKT80FhMSOrpQD/eTIPWIEaLIF4
81G+f9EVTurUgMO5DP+xDigDeiqx+wA=
=szW3
-----END PGP SIGNATURE-----

--dku4l7aigas53bcw--
