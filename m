Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D289718079
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjEaM4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 08:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjEaM4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 08:56:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACAE43;
        Wed, 31 May 2023 05:55:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 095FD3200344;
        Wed, 31 May 2023 08:55:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 May 2023 08:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685537713; x=1685624113; bh=TN
        miHdZhWOkezbPkUch2xBo3I6cLpUI+xAR+spYzjUU=; b=P3ZVR313xaZq1L9ex6
        1/B8heApIn8lIi3m/LT92rCZ7zSV0ipqrTHOSO/LPVKNif4jRuhYw5P33PVP3I7f
        aGIQ5QtAy45a7v1j0jIWvGLrss/SKEmARHG0BD4vhOmdTY4jgDp9YYABJpkl/VsK
        8A542RsnJZBrbWiIOxnmFOu1IiK7BbS2cMGniKUIh+Y+KU4xVUBw4THAn2Blzb8v
        8GgKFjJezXe0f7xD1w7A2H9IrwXBrcpjp17L1jBAYnxoAGeLRKNgBxUvfzHQeTT3
        eqYYdqA0MyBVTUqGME7INEzU9tsUindb8RzJyQHH8zbxX03j3vs5YT2S6yPg0w1J
        kL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685537713; x=1685624113; bh=TNmiHdZhWOkez
        bPkUch2xBo3I6cLpUI+xAR+spYzjUU=; b=V9+odI0IaCSY/FDVJcpaFyaxW5VJ3
        99AB4sDFI6CFyo8AM0pvmHJYXerBcTtB8HERBvSofZ1FgZn0SzDYwf9u2t3njj76
        sF789RmZ7o+HHVJOETxarS/J5pOvCGtvVuB8c4G609a6H4nyIZYHInIGeZ4mcl1H
        f0UXH7UK0iXUrAvrYyKCrH4fHqU1f9CqYxni881rXKKUVscQuiK25IuxHqgFoJZz
        hGuN+3wOhie8nr6sPNUhtyCvdAq0CY5c9D31qiZQpMYKhudKmTCyerMA4C7/0E8p
        /CKjqeScN19zMvw0ywoAoiT2roOy9s96VCGoWWDOGcko07baKTvZ6sdMg==
X-ME-Sender: <xms:sUN3ZH5mlIOARJn5ScOXCAiO-hGrzE5Izsq5fJZ1UZ5nXdAKLKNuuA>
    <xme:sUN3ZM7zYmL1Q4j_x8TlV2B_WZyPDKZbnCXAkx0DKqQY6GogzArdinzPTwuJbZeHB
    26ngIZ0f3MdF8nRbDY>
X-ME-Received: <xmr:sUN3ZOc6dSisFmh9o142Aqo_OAxU97Z9ZVQG2RK21OMrqC_SYHEQ0vVyWJmMnG8fga-7Z81FtqzITJGMAouVwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:sUN3ZIIKrXCnFCu0HkDm8PbHXzBAO3FvhwV-CQcGjGArrx5tt4v3yA>
    <xmx:sUN3ZLIJOhmSIVi2nx-SPHZv75wPrLYlGWW2PP8ky9gKQVEPN2O5DA>
    <xmx:sUN3ZBypaq-brivOa1VpJGCp4HewVR_R1WFGqMpzh3Fm4p35JypmTQ>
    <xmx:sUN3ZD9nAO5G58EsfdNgsV-sSZTaJj26Y3QRogr56gWwLGvn9CpHNQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 08:55:12 -0400 (EDT)
Date:   Wed, 31 May 2023 14:55:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] kunit: Fix obsolete name in documentation headers
 (func->action)
Message-ID: <3fv3ev3nuxzr7bej7beglrm6qoptyvzngbzdmwpjpobdhmc45v@4utejosaezjk>
References: <20230530075557.1558422-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssq2ktuf4cygn225"
Content-Disposition: inline
In-Reply-To: <20230530075557.1558422-2-davidgow@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ssq2ktuf4cygn225
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 03:55:57PM +0800, David Gow wrote:
> The kunit_add_action() and related functions named the kunit_action_t
> parameter 'func' in early drafts, which was later renamed to 'action'
> However, the doc comments were not properly updated.
>=20
> Fix these to avoid confusion and 'make htmldocs' warnings.
>=20
> Fixes: b9dce8a1ed3e ("kunit: Add kunit_add_action() to defer a call until=
 test exit")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20230530151840.16a56460@canb.auug.or=
g.au/
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ssq2ktuf4cygn225
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZHdDrgAKCRDj7w1vZxhR
xRahAP9tI8OwmLz3baTjIvsQJ7UwE6w3c/Ei+8UNZpftVn1mEgD9GTT+1unOzR5k
zLgUGlh52rfTHKqhPj7y8I/0pcjECAQ=
=4uQN
-----END PGP SIGNATURE-----

--ssq2ktuf4cygn225--
