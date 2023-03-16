Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA186BCE44
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCPLeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCPLd4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 07:33:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E55184;
        Thu, 16 Mar 2023 04:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4261BB820FA;
        Thu, 16 Mar 2023 11:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0F0C433D2;
        Thu, 16 Mar 2023 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678966431;
        bh=vDocdycxCF3x/Zn1u1sFhrHTw1xj9HPiv64qQnogRfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va//pdWzxmhiRpESjcfRBT4poZCpE+2tUIpYFsg9B2uN5d45SqlrhmBmKo0GZswmr
         t/9z2Oq0/dDgKHf2a+s9KlVJ3Zox8u8SO6IYCqkgla3EAmqFq1HrlktdbtcGZNf2ko
         lOLIIPUVQwc5RNuSiHaDcWZKChhAPW1MVZ9eSvIj8ioKHngMSj7spdSkVpPVhfaruR
         EyBbGvSqu9xW8iOEjwm8xcn+9QWFoR2I5IA1YBmrwmE7oGclZQR7xvIeLOCi+liIJp
         HRCVatfvJhlURLSV/68Pqebpl+fI9LTE2EVeWi1Z/zbXMW9Z2ArMYTtZuOji6GS+N5
         eoG9QuIIwlLSg==
Date:   Thu, 16 Mar 2023 11:33:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     kernelci@groups.io, rmoar@google.com,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Message-ID: <ad7e6e40-6542-4439-8199-d46a6fc91364@sirena.org.uk>
References: <20230310222002.3633162-1-rmoar@google.com>
 <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
 <4568b302-2a5a-4499-b2f7-12f89c031495@sirena.org.uk>
 <155efcdb-2be6-16c4-42bc-37930639060a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UVwe1GSxcWtU1Vyf"
Content-Disposition: inline
In-Reply-To: <155efcdb-2be6-16c4-42bc-37930639060a@gmail.com>
X-Cookie: ... I have read the INSTRUCTIONS ...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--UVwe1GSxcWtU1Vyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2023 at 04:45:29PM -0500, Frank Rowand wrote:

> Yes, there is no need to do a single specification change that results
> in incompatibility.  But given the previous discussions there seem to
> be plenty of other desired changes that will result in incompatibility.

Do you have a pointer to that previous discussion?

--UVwe1GSxcWtU1Vyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQS/pgACgkQJNaLcl1U
h9DAGQf9H5cCQVE7wWovMynfMODIpOC7+Z6SXi1+MsZtWfm+bRqBeAyvOqp80/tj
9K+0b5XET1aaQhEtvOZN4RdDT044i/4n/AaDc+nNK/M7R8pukbbPInu65zfKv1rc
TLbFvO7RyoyiBVLl/DckezLT5MfNA5rEfgDZLSh7VYAjrk797YQi2jsG2wavrt6H
hik9XI91StSnc0kzntjL3b22bkhwTYT5X87pHIgP9XzMj4jzyPXN6b8kQ+nWLd9g
jC+kx2/zOVMTX9rDY+YtRjepLGoSeXhoUxwXUdVW0WEwOAloD99V5ohd13fuL5lu
FEwgs+MvZ+ijQME9jtxY+4oo5kiFqA==
=Pym2
-----END PGP SIGNATURE-----

--UVwe1GSxcWtU1Vyf--
