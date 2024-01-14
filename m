Return-Path: <linux-kselftest+bounces-2953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4206482D197
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E701F21548
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931575690;
	Sun, 14 Jan 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="btSB8nXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AFE5662;
	Sun, 14 Jan 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240114171901euoutp017d9a5e4ffe55cc9cd215872b1916844a~qRlV5XdFH0168601686euoutp01i;
	Sun, 14 Jan 2024 17:19:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240114171901euoutp017d9a5e4ffe55cc9cd215872b1916844a~qRlV5XdFH0168601686euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705252741;
	bh=CxQHD6kq4IhKeSFG+n/gJm2tbKb9TRfYtb+C/DIiSNs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=btSB8nXpNS2Cz9eh6uyUM/WAscgBiCQzKyTUtAdc9SkcquZBOQcbKGT+T+pDgXmjh
	 G0niTvN9HI4pgqHSzt11QsVQCvW8mlUccYlub/8hFfuSFG02sIKT8PIa99T0OcSkrM
	 CLECNTOoKRnLzPcGhknbf7mR4e1VpjHfxZwJQM6I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240114171900eucas1p2ef2348561683c06eefe896e091a4c552~qRlUNx69y1703217032eucas1p2T;
	Sun, 14 Jan 2024 17:19:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.B8.09539.38714A56; Sun, 14
	Jan 2024 17:18:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240114171857eucas1p1e06b5a7617b9b6cd0dd86a428c0cca58~qRlSPyrRQ0440104401eucas1p1I;
	Sun, 14 Jan 2024 17:18:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240114171857eusmtrp2428c12f0cb9ccd2541afdefce67285e6~qRlSKg9ES2538825388eusmtrp2X;
	Sun, 14 Jan 2024 17:18:57 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-1f-65a4178309e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.30.10702.18714A56; Sun, 14
	Jan 2024 17:18:57 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240114171857eusmtip298d2556ec3a0ec0e7944de5f5925d1bd~qRlR8saI-1434514345eusmtip2H;
	Sun, 14 Jan 2024 17:18:57 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 14 Jan 2024 17:18:56 +0000
Date: Sun, 14 Jan 2024 18:18:50 +0100
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240114171850.mwcoutrrjxn7ltlf@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="lvqsjam64aakrwcq"
Content-Disposition: inline
In-Reply-To: <293a5643-ef36-4a34-9b6b-0f5b47061c2e@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZduznOd1m8SWpBjeuW1hsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO4rJJSc3JLEst0rdL4MpY3L6TteCdTMXde08YGxiXSXQxcnJICJhI
	HO68wdbFyMUhJLCCUeLF/nZGCOcLo0TPrOlMEM5nRokvJ2cDORxgLY87SyHiyxklru1pZoYr
	2j1pFpSzhVHi68clTCBLWARUJe42LwSz2QR0JM6/ucMMYosIqEs0Ne4FW84scIdZ4tSLe6wg
	CWEBT4n364+xgdi8AuYSC++1sUDYghInZz4Bs5kFKiTW/JnACHISs4C0xPJ/HCBhTgFniYNL
	/rFBXKok8X21F8SftRKnttwC+0ZC4BenxMY/m1kgEi4S059eYYewhSVeHd8CZctI/N85H6ph
	MqPE/n8f2CGc1YwSyxq/MkFUWUu0XHkC1eEosb61hQViM5/EjbeCEHfySUzaNp0ZIswr0dEm
	BFGtJrH63huWCYzKs5B8NgvJZ7MQPoMI60gs2P2JDUNYW2LZwtfMELatxLp171kWMLKvYhRP
	LS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEykp/8d/7SDce6rj3qHGJk4GA8xqgA1P9qw+gKj
	FEtefl6qkgjvwecLUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGanphakFsFk
	mTg4pRqYnPT27byVNvVYwWEh5XNTH1xKaN/GPKlnF6PQgRl9W+o0Puh85rd8mOgdtubhfcEN
	H5/sn79wum/ed5XeyrT/9hKtnzbtjldq/9ywUOreayUr5Sxp96COyGseuxSutz6o1UtUSNwT
	s2K9/guVq83c834Kpth7ai89zsfyketDrnvX0+5j8gv6k3fJXGNefNqHKyK2laVyfXjh8U7P
	01aTJad6fnt/VWru7FOtU9yaJndVezZ8bc/cGjt/woWnZW1LmqVUTV4U8ScbiG4q453rd3+m
	eo/Nqw2LOv4fi9ivJXrZcupHudrbd+XPzTg36dSNXwccEq33uLVvWbHze9hLl/W+ZVfvf9zW
	VdSqUmv8VomlOCPRUIu5qDgRAOPQdu8fBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsVy+t/xe7qN4ktSDVpWaVtsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0MvY9PkFW8EbmYqt/d9YGhiXSHQxcnBICJhIPO4s7WLk4hASWMoosWjrWeYu
	Rk6guIzExi9XWSFsYYk/17rYIIo+MkosPHyOGcLZwiixdfkKNpAqFgFVibvNC5lAbDYBHYnz
	b+6ATRIRUJdoatwL1s0scIdZ4uCP3SwgCWEBT4n364+BNfMKmEssvNcGFhcS+Mko8aNNCiIu
	KHFy5hOwOLNAmcS0md2MIGczC0hLLP/HARLmFHCWOLjkHxvEN0oS31d7QRxdK/H57zPGCYzC
	s5AMmoVk0CyEQRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFRnrFibnF
	pXnpesn5uZsYgalk27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuE9+HxBqhBv
	SmJlVWpRfnxRaU5q8SFGU2AgTmSWEk3OBya5vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTE
	ktTs1NSC1CKYPiYOTqkGJqVzLTd2n5vWVcSiwq11tUb9z+55E1d/tJlwI7h2OaPeszN9t1//
	6l00z2DPyo/Xz6YIWKwRrzivt3P+tnl7mkLv64k86fde5Z+2ftqZso+XZxSnW3etuf50a2F9
	6YlvgXw9t0zezFzA1K0uNG+v17UY/sZ53z2c+c1Ugm3+ujw7sHiXrD7fFkOfKgu5qe8vR/Ht
	Cc06GvK/f83xlRvWdCy+wjf158klYQurdOXnbZp9PpvjDWeI87yizzqvroZkLgvYZ/xqjtLn
	T4npX/1TD7rHBvnv2n/VpOLfGj3GvW8qJ8S8+3Bj2s6nvf+eV5pOirHxXB6pvOPgacnCRwZp
	5k9Pb1o6dd78iTN6T5pzMvzLUGIpzkg01GIuKk4EAGs1mEi6AwAA
X-CMS-MailID: 20240114171857eucas1p1e06b5a7617b9b6cd0dd86a428c0cca58
X-Msg-Generator: CA
X-RootMTR: 20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
	<CGME20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6@eucas1p1.samsung.com>
	<20240112215606.36sth724y6zcj43k@localhost>
	<293a5643-ef36-4a34-9b6b-0f5b47061c2e@linux.intel.com>

--lvqsjam64aakrwcq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 09:13:19PM +0800, Baolu Lu wrote:
> On 2024/1/13 5:56, Joel Granados wrote:
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> >> Hi folks,
> >>
> >> This series implements the functionality of delivering IO page faults =
to
> >> user space through the IOMMUFD framework for nested translation. Nested
> >> translation is a hardware feature that supports two-stage translation
> >> tables for IOMMU. The second-stage translation table is managed by the
> >> host VMM, while the first-stage translation table is owned by user
> >> space. This allows user space to control the IOMMU mappings for its
> >> devices.
> >>
> >> When an IO page fault occurs on the first-stage translation table, the
> >> IOMMU hardware can deliver the page fault to user space through the
> >> IOMMUFD framework. User space can then handle the page fault and respo=
nd
> >> to the device top-down through the IOMMUFD. This allows user space to
> >> implement its own IO page fault handling policies.
> >>
> >> User space indicates its capability of handling IO page faults by
> >> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> >> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> >> for page fault delivery. On a successful return of HWPT allocation, the
> >> user can retrieve and respond to page faults by reading and writing to
> >> the file descriptor (FD) returned in out_fault_fd.
> >>
> >> The iommu selftest framework has been updated to test the IO page fault
> >> delivery and response functionality.
> >>
> >> This series is based on the latest implementation of nested translation
> >> under discussion [1] and the page fault handling framework refactoring=
 in
> >> the IOMMU core [2].
> >>
> >> The series and related patches are available on GitHub: [3]
> >>
> >> [1]https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.li=
u@intel.com/
> >> [2]https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu=
@linux.intel.com/
> >> [3]https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-d=
elivery-v2
> > I was working with this branch that included Yi Liu's
> > wip/iommufd_nesting branch. Now Yi Lui has updated his work in this post
> > https://lore.kernel.org/all/20240102143834.146165-1-yi.l.liu@intel.com.
> > Is there an updated version of the page fault work that is rebased on
> > top of Liu's new version?
>=20
> Yes. I am preparing the new version and will post it for discussion
> after the merge window.
Great to hear and thx for getting back to me.

I'll be on the look out for your post. Would it be possible for you to
add me to the CC when you send it?

Best=20

--=20

Joel Granados

--lvqsjam64aakrwcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWkF2wACgkQupfNUreW
QU/8DAv/XjOpddXnxLaH/ajB3WuoooJbtvmnUPTQFip95w/2SKTHlurGepMXVP1C
NTts5to0LjiSqKtbdFkZo6owdwXw//l9B24FfTS60cvn2Xs80I3wss6+5bmZq2jS
Gz6hjgJnRyrAeMKwqcqiRhlyQ+uoPPBYYYrdc31Vx3fKvhaHvCwL9x2haKCg74Hw
L5bySmh8QELn5k/Dy7XgKgIY+xC0/yEICQ3/LgNS7UZhqXqyzLQJodhRB+KKl/rb
Uk7cSMRTVDTJEMrkG0CQgZIGuZukOOAKAxY14qa8AMa1ug80NoGJrctZhODX2d66
p3agnVoLNT7K27FRsQZys73a+Jfr3+xkN75GcjO+dqErP2At722pl6B+vRwQFm7/
x3GBThKDo4X73DQikpx8H4bR5T2Qi8f7YRtExdaf6PY3zzY0STkiPz4J6GDFvN1j
CNad9jk2xKhsDO8QnrllsWDV5DBO0Wb1IyIzfXxO7hqDmsUv0mZnrTIw7m0EcABG
hqZ1vl1L
=xlP1
-----END PGP SIGNATURE-----

--lvqsjam64aakrwcq--

