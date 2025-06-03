Return-Path: <linux-kselftest+bounces-34202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363AACC10A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 09:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AE1188432B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CE268C6B;
	Tue,  3 Jun 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glvRPAXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1FD2686B3;
	Tue,  3 Jun 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934771; cv=none; b=arR/BrSW6ENMPPTYDnipwzCMC4crTWXiNQGmlfsDGncRUy2nQRp0azMuZm/ffxY13jyvwY4UIbKmWdukv4apdZJRcKX1qv51w/QzVghL3rRkqwYEYfyrjR7JXwy+lvcD9rYRipl3z+OnQQ0Xzghgm9FpokVCSp/ExQNbQIcPytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934771; c=relaxed/simple;
	bh=56OvzeerDwzgeauclku9aTidkmN34AE7R4xLIov9A2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjZz0q/dy4W82aUb9INgtW2rOBaieJNHfJ7z7rzoAinFr19OFaCgQiRUFH6kJKhaBq3C0YCM1rwlDM79PusbqgQdjTjQbT7Ri9LiqLMLyELXLECs9+38heBa47oe1wX1k7by7e/7R5eGu90UfqZPoQOp3ibNN4Ol9UZj1twuzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glvRPAXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70147C4CEED;
	Tue,  3 Jun 2025 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748934770;
	bh=56OvzeerDwzgeauclku9aTidkmN34AE7R4xLIov9A2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glvRPAXCWMTv46/bEjU9dXzmIAo9bS6YOO4TWNAeb1eD5NBlbhrpd1MUw0gfyq7iZ
	 UI0ITf5G9DWx3SbMAgGtSgrR/CtqhyTK6toEEGj5ExJScvBhF9cfXbKsj+DKEkxEda
	 fHFT2rpMKyxGnLAY/PW85Bv1iwCtynVs+X60WPfgHiI79NXzbKcZRD0DhA740vI9OU
	 wNusUb048Zrf6r27swrpQTZkdY/Ei7SGfQAaD0fKLaO0nT7VfkT8gYXqqtL1ChMXyI
	 b4nF3Sl/L7/KJm9qQV+GzAB3FO5ubiMeFf72t84ECV6HQWvvA0gZ+/cHiil6wCOnwm
	 JBJ8MbAJpY3IA==
Date: Tue, 3 Jun 2025 09:11:43 +0200
From: Joel Granados <joel.granados@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
Message-ID: <ueyiol53fpx3nvj4y2mespc3qekaco5sy5wn43lypkfie36h7u@gpc62pmkmkiy>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250526170951.GD61950@nvidia.com>
 <CALzav=f_12DE4iJ4XxU+jsaEcP2LZioVfuVwGMnK8a=JJbA0JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjhz76lozamlraev"
Content-Disposition: inline
In-Reply-To: <CALzav=f_12DE4iJ4XxU+jsaEcP2LZioVfuVwGMnK8a=JJbA0JA@mail.gmail.com>


--zjhz76lozamlraev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 04:01:52PM -0700, David Matlack wrote:
> On Mon, May 26, 2025 at 10:09=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> >
> > On Fri, May 23, 2025 at 11:29:45PM +0000, David Matlack wrote:
> > > Drivers must implement the following methods:
> > >
> > >  - probe():        Check if the driver supports a given device.
> > >  - init():         Initialize the driver.
> > >  - remove():       Deinitialize the driver and reset the device.
> > >  - memcpy_start(): Kick off a series of repeated memcpys (DMA reads a=
nd
> > >                    DMA writes).
> > >  - memcpy_wait():  Wait for a memcpy operation to complete.
> > >  - send_msi():     Make the device send an MSI interrupt.
> > >
> > > memcpy_start/wait() are for generating DMA. We separate the operation
> > > into 2 steps so that tests can trigger a long-running DMA operation. =
We
> > > expect to use this to stress test Live Updates by kicking off a
> > > long-running mempcy operation and then performing a Live Update. These
> > > methods are required to not generate any interrupts.
> >
> > I like this, it is a smart way to go about building a testing
> > framework.
> >
> > Joel had sent something that looks related:
> >
> > https://lore.kernel.org/r/5zoh5r6eovbpijic22htkqik6mvyfbma5w7kjzcpz7kgb=
jufd2@yw6ymwy2a54s
>=20
> Thanks for sharing, I've started to take a look. Joel, please take a
> look at this series too and let me know your thoughts.
Added to my back log. Looking forward to see if this fits into iommutests.

Best

--=20

Joel Granados

--zjhz76lozamlraev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmg+oCYACgkQupfNUreW
QU/umAv/RtySM7YTm5G0rHUHuQ1r3KCBdSR0ku5U3nrBZUxZZxb4XgTaVOR4ZRC3
CQJ1DOY18chw7SDLkPQarIMJx8GjvfxTiETen9cKWpDL/Vn5CWJk4ldJy84LEjPx
K/Iuz9H3WB2SycK5BYJuP+yzEDHRNemJIseIklAgIAVc9ke/Ixfd/JQCiJDo5akp
g6yJRfMNfsBb1iD68SWrMZzzEx7kLfYt0ldBFkXWLbdRp1No9aLzYZKQG+aQcxd1
+3X6lMXI31PB4VdNoNxDLtZm1DLDQhWVx+KOwwDNY6Xk51vRkWQxkt3zLxQaAff7
+tnc7qoG+Y8jbnYDNUQj6AaHAFv4ykonPnfxT6xWc07/dUJGabWVIZJLVLd2hDqA
09cdPx5GxswZYanyQA0hbgTKFIhYm6y6YqLIW8/TsvA+jE9XKUHEXnp3t06XhlCY
u8A3ePLEX/+RtjQd9BVYy6u9L0+RIkuu5drK81IBE/VJoM15BFIWavWkhcsrCeFP
66rvPEuE
=Zzxz
-----END PGP SIGNATURE-----

--zjhz76lozamlraev--

