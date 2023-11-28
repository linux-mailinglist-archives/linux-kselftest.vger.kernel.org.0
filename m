Return-Path: <linux-kselftest+bounces-704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0907FBC4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C121C20EB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00E5AB8E;
	Tue, 28 Nov 2023 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4OShPFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D35A0E4;
	Tue, 28 Nov 2023 14:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BD3C433C9;
	Tue, 28 Nov 2023 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701180629;
	bh=60EtB08YT7Ko8yqV3Wwijj0Q4rDlAXw7Ibne/o3zM/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4OShPFUo67/hTM7CP0T5xlROgke47ag9YYEcSS/ddt4MiwJzPweh7w6xdi0Cvesx
	 F/8yEKqXWrixCvb1kA2smHWsNtmgQN/ovflspS+geIMXD2+AJgKxKXTlYxvH7K6Vhn
	 WHbqKUN3K31QmfxQ2/pKM+CXH3J95hQTGtOETNXh/ZnWapdNWYEFpZEtLvvMXvrV+F
	 4+8ofw5pC1p64zwwB2+Axp/kGR/Oz2Q5idf3lljuruSLhgfx+NyLdo1+IwK0RAni4O
	 hvuf9HEsXlCgWGIE3Zx9ZJIVmOxHcwv2gKqkZT/JltiXlFI1ncAeRdqMRMa1u+NTn2
	 L+JXI1dxyLYMQ==
Date: Tue, 28 Nov 2023 14:10:22 +0000
From: Mark Brown <broonie@kernel.org>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
	David Gow <davidgow@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Message-ID: <1baeddbe-83ed-476e-a748-7d2838b44c5f@sirena.org.uk>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VIfEQR6tichIZgMF"
Content-Disposition: inline
In-Reply-To: <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
X-Cookie: Must be over 21.


--VIfEQR6tichIZgMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:10:46AM +0000, Bird, Tim wrote:

> I'm not a big fan of naming these with a comma in the name.  Is there a r=
eason
> you are not using dash or underscore?

That's a common patter with this sort of software (eg, bootrr does the
same).  It's convenient to just be able to use the compatible straight
=66rom DT without having to mangle it.

--VIfEQR6tichIZgMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl9M0ACgkQJNaLcl1U
h9Cktgf+Oq0BN8WyZ7CzPTibZyr6k1r2sWjG2VUqEZQKYA66zH1D965ND5J8XJB8
cqw3KD0X/8KNc/u890NCBnr7QTxlKdczAbTEMZtYAcy/7xiA41z0ITXFc6DE8/nO
V76cOaRGh2vCNkBROokKzewYxb+4MWHHFNUBu/7AXYZHVhtt4U1kcxNcm9HwvC/j
S3ubDODyZk++hbyHQhxf3ENesyQuIObeKWx6qVPieVbbeCEn3SLZH1KTEOcEr4Cz
uCkWQKMpUS4iMafKTdMigLtOE4TskFAd+eH+cFMm4Yy7bhr+5pxKmAaDleKBAORF
/OS87yV3a5qUCNslQ03RnzaSJr1BmQ==
=ujz7
-----END PGP SIGNATURE-----

--VIfEQR6tichIZgMF--

