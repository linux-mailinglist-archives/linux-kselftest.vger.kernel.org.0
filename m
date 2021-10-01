Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B841EDAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 14:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354419AbhJAMmt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 08:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhJAMmt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 08:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B97506126A;
        Fri,  1 Oct 2021 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092065;
        bh=iep6jGFfJ4nFekG8ES6bQtdtbNoJktEPiZn3xVnh0eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6gkDJvGndm8UY0eOoDWMCJoXqb3GhC0bAxQuhSZ/eo1NRj4zvenvu3jQhFwRWg4P
         WTaxwgANVWqcKDPnDWdl9jj/S49JfqP4Uq/dX1RzmEwF7ndQOHZffAV1tE1smDpQrt
         ge4/fTMNYzH1KCZrOZPLlUTfaooiJMN3s01yA5/kzbGA2DJz5Uaqm1xtpzdYpcZaCa
         kVH3X4GpGPwmkOuY8bnwPXrb4na3e5YSNYrp9d0S+2pp/M3N84VSIWsPT9rbVjFExj
         0udYDP9yH756s9+H36k8PzlPNjvrFblRui1QQJJWj+uYwNAzhGHX+HGaoZ+QmixaVE
         zBPiiH9WfZFqQ==
Date:   Fri, 1 Oct 2021 13:40:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kbuild-all@lists.01.org, Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 19/38] arm64/sme: Implement vector length
 configuration prctl()s
Message-ID: <20211001124014.GB5080@sirena.org.uk>
References: <20210930181144.10029-20-broonie@kernel.org>
 <202110011351.yhJYSPTs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <202110011351.yhJYSPTs-lkp@intel.com>
X-Cookie: "Pok pok pok, P'kok!"
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 01, 2021 at 01:20:12PM +0800, kernel test robot wrote:

> config: arc-randconfig-r043-20210930 (attached as .config)
> compiler: arc-elf-gcc (GCC) 11.2.0

I suspect you're reporting architectures in alphabetical order - can I
suggest making a priority list of widely used architectures?  I know I
tend to zone out issues which look like they only occur on less actively
maintained architectures as some of them have odd architecture specific
issues that really need to be fixed at the architecture level.

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFXAa4ACgkQJNaLcl1U
h9B6NQf9FrPqIW4X+JT3hSFEQS69ej1VzaONDCE7AOvgET6ogGk/gyeolAWf6XI9
TEvpmJhQYkvDp2SafLdM4BEpbulf41PijGEXFP2kphgUOftwimc//DuvA627pPBV
ePPH1VkS6w8pdahSNrvmOTqQbBIlcSUJmcjovcH3W2RCqEN4zGTPmrN1iiPhWP+A
Ct0pOwx4joL6H/WvGaCvuusrLz/n5JYeMa75PyhsH2u3U2tYnb9rEKu52Y4vQV+B
mZMyK40T/vGf/GpsYdESDJS+lmgNmFwwZu7Mo4YFJs5/E8LvRhkwBY2Fbfber3xp
o1PmB0PlwB207g727FGsbCWt64JhjA==
=SE65
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
