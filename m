Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1294D43B35C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhJZNu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 09:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234040AbhJZNu1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 09:50:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7BC60D43;
        Tue, 26 Oct 2021 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635256083;
        bh=yvWbaAgszIY+i1riu8+GLyAf9j7J5wJXSpeI7MhemCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcCV5laRoidAf7SFcUPpTWeC1SxByrDOXwzPfYHBzfHZphr8LPpaZouQHh0pNNok9
         fqSnWgLd05Aaohxo825lGg3DjFc6/KWGNBVDkBG0+oHiivhCUs0LRyXCNroKxytTrs
         iL9tIZMy8kpdYjrOZBmk5DH3GJWl6qMIrhcHAp4MY25Cw3Z5Q9ImcEclcJEZea6T5T
         Papmp52XXl189wdimFUmDB2Pwgy0Q62D0CXkE05y3/DCqBOVFRqi+zVEIauSo6VO8Y
         DHO3eyUEyIucy342Oxjy2fEz7KDkkIfHt1dmh46TedyQzBH5347A5Ds8PaogJ+4szz
         NZodZ0y7vbh5w==
Date:   Tue, 26 Oct 2021 14:47:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luis Machado <Luis.Machado@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 06/33] arm64/sme: Provide ABI documentation for SME
Message-ID: <YXgHDpm2gaikm8Ow@sirena.org.uk>
References: <20211021180722.3699248-1-broonie@kernel.org>
 <20211021180722.3699248-7-broonie@kernel.org>
 <VI1PR08MB3919C2F171F2185FB3500DD08B839@VI1PR08MB3919.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T2P7sbGh2AfvhHXR"
Content-Disposition: inline
In-Reply-To: <VI1PR08MB3919C2F171F2185FB3500DD08B839@VI1PR08MB3919.eurprd08.prod.outlook.com>
X-Cookie: Times approximate.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--T2P7sbGh2AfvhHXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 26, 2021 at 01:38:51AM +0000, Luis Machado wrote:

> A few nits below...

Thanks.  Hopefully I spotted everything and rolled it in, there's no
flagging of what bits are quoted and you've not deleted any of the extra
context so I might've missed some comment - if so sorry about that.

--T2P7sbGh2AfvhHXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF4Bw4ACgkQJNaLcl1U
h9C+kAf/dJMDMxq7g3xc5n7ac4DB3VgPoBKkNmaObjcr06fAALqaW67DIBKHxmsy
6HXrVDNarTRpuVqYqeKKvD0yq/ruRrIABLaq6+O7s9b/RXBafSa297xsdrYtvDz1
lk8aDNsWo9TbEjDWq/0+MYNxTU2vFRdtUiw2QZMjqVVZ0O8FlHtXdDkdElGysw+4
NPX9yfj+Ic+mw10p6C6zQ7U0u5pBOsEFKGlyeHzpdD0j4WedPpZqqOaGoUnh/BFV
W5Vf3ExLJIIAJcitxySxA/VjQ1Aplh5EmQd8QjLdjJ4EyD9RghlBDp+HcJnPsMg6
fC/N25YATYHeJjbxrntE19h44Cg15Q==
=lVZQ
-----END PGP SIGNATURE-----

--T2P7sbGh2AfvhHXR--
