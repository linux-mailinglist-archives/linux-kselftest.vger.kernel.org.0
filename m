Return-Path: <linux-kselftest+bounces-324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162DF7F1475
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 14:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F941C215AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F781A72E;
	Mon, 20 Nov 2023 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM3nAMws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC051A728;
	Mon, 20 Nov 2023 13:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A06C433C7;
	Mon, 20 Nov 2023 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700487095;
	bh=M8hXpqu/SFXEFGkb7RfUuX8flLLBuh9b/Fq64VoHQpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hM3nAMwszfDIhSArCnA6KtTsdLLiaLRN1q7rOjqK/oYbLG8IucYrOURECM043OjZo
	 gj/3ab3Qphmljn10UavvewFUhR7J+aSEBdqddXOFFd0sgAZGjCAqZvExfqkDDCXEYQ
	 4pdVGs4vkXHOn5kVZDvdd/aQuYh5y3eIqHHU12BreIQCU5Es8GfRInSCM3wcwn7d7A
	 kFkxgalSXajpyS70czyTIMlEPbmGDxMHZjKQb6V1v40v5YgnZ9OozUShshoy3NA3Zh
	 H7zY1YKmRZEzIejoWqiB8NGBmXRHw+ROqsbMNE7iwhORDY/tCyx/oeNDTxSTsVd0od
	 TraHh8yq2L6zQ==
Date: Mon, 20 Nov 2023 13:31:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Gustavo Padovan <gustavo.padovan@collabora.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Theodore Tso <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>, kernelci@lists.linux.dev,
	kernel@collabora.com,
	Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <92219e71-4715-44e7-9522-191f268fe22c@sirena.org.uk>
References: <13fe4866-0522-4690-a060-160fdab9f54b@redhat.com>
 <1341-655b5400-1-5f647c80@80242238>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpzPcxOY99Tb7/Ji"
Content-Disposition: inline
In-Reply-To: <1341-655b5400-1-5f647c80@80242238>
X-Cookie: <Manoj> I *like* the chicken


--wpzPcxOY99Tb7/Ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2023 at 12:40:39PM +0000, Gustavo Padovan wrote:

> I also wonder how to make for subsystems that will have different test
> suites (eg something in kselftests and an external test suite). Would
> an alternative be pointing to a Documentation page with detailed info?

Why not just add multiple test suite lines like we do for other things
where there can be more than one example?

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--wpzPcxOY99Tb7/Ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbX68ACgkQJNaLcl1U
h9B4IggAg+T0prKijOeC3QNgobuJ0qxDuMVcNzod2bpIDyBJomSQITktQIs2KqJr
ksVzYw2shK6StpwGpNI6G7vICYLB6pEE0isc0m41MvtqcuewGYFdBJL7SQhtZNBN
YnRAcmNpD/HCj61MK10CZITHwSkDCzf6i2pHl6l00qS6hPeBrh0DmE28GrOvluMa
cpd6/to5SMJPVOMfIcOgmkhUMASpAWtDh4TBzwSou0q1UOkrsMyxvMk0mPF246Ac
X5By5iarDrccmWqzx5wuBLHV4sWEX2mKeVxob+4x1rJKiQFQ5v4o2Y2OCHOOaseA
JvFtSpzIfa+kwJl8u/pBqyDg0dNRew==
=ncnT
-----END PGP SIGNATURE-----

--wpzPcxOY99Tb7/Ji--

