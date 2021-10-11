Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2551428DB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhJKNWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 09:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhJKNWc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 09:22:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06794603E9;
        Mon, 11 Oct 2021 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633958432;
        bh=LBwIwOty85QDOC3THb1be6KrVEGV3fYy4H3zIBQBU5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJ2cHs1QRCeIJ2LGAvHTzYXBLr1ecLna04Cj6YsPJ1hWKrdhe7GQccic+Mw/1BNmp
         9/6vqBIFPejBBCbyWb/KQd4q3zzOWhBL0Yg+U5iWViggVFrUNbdfUkuuOgNtvOpRYH
         LtlTubMFLVOXg78CzQN2ZrVXBAkTXLHt2trPS1pDZs3ubJH+acA+ThmhSR5fC1F/ht
         NlVtFoK54bPrkoP/fs+sUdfDmIVCYi7RCFE/SjNL193VofWH8Ea9qiAgD5ACQIIC/L
         hR0NfQQT9R5vO+7Ws88tF1PzVWtReRPwWBzPwYZat+WjMB/0OK0J/y752CcdwYZKC7
         aRHhn7orIBYxg==
Date:   Mon, 11 Oct 2021 14:20:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <YWQ6HpO2Wvl007ku@sirena.org.uk>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011120507.00000c13@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cXjaZWrSpNaeo2og"
Content-Disposition: inline
In-Reply-To: <20211011120507.00000c13@Huawei.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cXjaZWrSpNaeo2og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2021 at 12:05:07PM +0100, Jonathan Cameron wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Signed-off-by: Mark Brown <broonie@kernel.org>

> A few more editorial bits to add to what Alan pointed out.

I think I updated everything, thanks.  Please delete unneeded context
=66rom mails when replying.  Doing this makes it much easier to find your
reply in the message, helping ensure it won't be missed by people
scrolling through the irrelevant quoted material.

--cXjaZWrSpNaeo2og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkOh0ACgkQJNaLcl1U
h9A5dQf/XSX4FOdThios8/yo/cAdumDle0nKTbZgMz/jVLXUszLkigJl5TFI9BlW
DhDjSxC4QoCflpXx0gPQbInZ41NWS2L46y0o9bUrs+j+YKAaGVkygMkazhFPT3v8
4N58y+ELjeQEmqlwKnhg6iW/GRPZqYjF2Yf/n8UsDCbHIV6NqCJA+FybADYU2Vqo
E2mFaRScZ8SVcmL0KVXdM9TGmi1CA/l4onjGDgTyu8dTADW9G+D89UooOu/mhEHk
wujYTSvvNRpcYeAZ6NFUXcFsdOF6I8lDQ+qxEApye1i6CzLvkEh54rErYroWW/Dx
KGCraFdZ0dVWvZoFoMO4fk5VA28nEA==
=222A
-----END PGP SIGNATURE-----

--cXjaZWrSpNaeo2og--
