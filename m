Return-Path: <linux-kselftest+bounces-2935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811482C6E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232181C21A5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1617722;
	Fri, 12 Jan 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PqeonxXw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78B2175A3;
	Fri, 12 Jan 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240112215611euoutp01652c7af9e2c3d60ce82af0bc96ac27f4~puExS00OF1899918999euoutp01i;
	Fri, 12 Jan 2024 21:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240112215611euoutp01652c7af9e2c3d60ce82af0bc96ac27f4~puExS00OF1899918999euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705096571;
	bh=6zCGMWCax/qJYpkJrdkcT6JwsFwHR3HjXz+MQ9iqCzQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PqeonxXwIBXV2fASQAVbNTxPdZnliuU4gKErTEDsEzWkiqkDAHOw2IwDCpe1+V4bv
	 Kp3F+yck7UtD60v9xLbRDwNNqeBhJ8HWMhXGXrQevuecqX6jWP8cZdHgFxsifntKcM
	 cORKbtT9YGrxCV8Yup/l1TVdj3m1I+f3ckwNvJdY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240112215611eucas1p1a9663c9ea3ce3dcd894815053dd56953~puEwipuPJ2821928219eucas1p1B;
	Fri, 12 Jan 2024 21:56:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.A8.09539.A75B1A56; Fri, 12
	Jan 2024 21:56:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6~puEvWNvf02838228382eucas1p16;
	Fri, 12 Jan 2024 21:56:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240112215609eusmtrp2bb2b77f8af2e051db05780cab5914189~puEvU_2Be2234422344eusmtrp2v;
	Fri, 12 Jan 2024 21:56:09 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-07-65a1b57a47ea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.01.10702.975B1A56; Fri, 12
	Jan 2024 21:56:09 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240112215609eusmtip287e4849dd24c90e8ed0d2a1c744fa705~puEvI1R7w1480514805eusmtip2b;
	Fri, 12 Jan 2024 21:56:09 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 12 Jan 2024 21:56:08 +0000
Date: Fri, 12 Jan 2024 22:56:06 +0100
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, Yi Liu
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20240112215606.36sth724y6zcj43k@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="c4dq2qnbv4wtniq5"
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZduznOd2qrQtTDdoPWVtsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO4rJJSc3JLEst0rdL4Mr4sPkte8ELzYq/VxIbGNcqdTFyckgImEg0
	b2xk72Lk4hASWMEosffnT2YI5wujxOPvv6Gcz4wSFz++ZIJpWXPnMwtEYjmjxJ8fN1nhqlbM
	nMUE4WxhlPjybw8bSAuLgKrEtrl72EFsNgEdifNv7gDN5eAQEVCXePYlAKSeWeAes8S113NY
	QWqEBTwl3q8/BtbLK2Au8fjEdSYIW1Di5MwnLCA2s0CFxKelF8HmMAtISyz/xwES5hSwlzh+
	5ikrSFhCQEni+2oviKNrJU5tuQV2moTAP06J51tnM0PUuEjs75GCqBGWeHV8CzuELSPxf+d8
	qPrJjBL7/31gh3BWM0osa/wKDQpriZYrT6A6HCXWt7awQAzlk7jxVhDiTD6JSdumQ+3ileho
	E4KoVpNYfe8NywRG5VlIHpuF5LFZCI9BhHUkFuz+xIYhrC2xbOFrZgjbVmLduvcsCxjZVzGK
	p5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQm0dP/jn/awTj31Ue9Q4xMHIyHGFWAmh9tWH2B
	UYolLz8vVUmE9+DzBalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotg
	skwcnFINTIplc+d9nbjV+p+a76UfH2cm3PfofMzuXp+Z+nm2ZcuPm+2bMi9UrZowj7vFYq/u
	6wPhgtv9Klhsvc9u0SpYs/DDliU7Zp9kuNLAXfVE6/WCmz/67Up5pv5/mnAkOvzawyIB++q5
	3V7mR8J+iHdfnPxv0vosI8byDan2ATlfmTQWK8wNPFwg1rNnLneT8DIf1z18Xy/zq5qKRa1z
	tg7/lPPy7N5fc856RmypPS9yeeu6M39Zrb3XNF/80Hzm+ra366UbfGw//b1qwbrjUURnbab5
	OyblxF2/329Njg0WmaTocTj7o1+iU9SaMCbu4xbXDspzO1SIsz/zCvvS0NQtF9J5/tudabV8
	J26cuXaqoU2JpTgj0VCLuag4EQD5aHN4HQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7qVWxemGqzaommxeeJWNotfXyws
	lh5cz2LRsPoCq8XMGScYLTpnb2C3WPp2K7vF5V1z2Cym33nPZrH36WM2i4MfnrBaLD87j82i
	5Y6pxdyf11gc+DyeHJzH5LFm3hpGj8V7XjJ5bFrVyeZx59oeNo95JwM9Jt9YzujxYvNMRo/e
	5ndsHp83yXls/XybJYA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
	JTUnsyy1SN8uQS/j4le3gmeaFRfPb2dsYFyt1MXIySEhYCKx5s5nli5GLg4hgaWMEjN6/7BD
	JGQkNn65ygphC0v8udbFBlH0kVFizZztjCAJIYEtjBIL1gaB2CwCqhLb5u4Ba2YT0JE4/+YO
	cxcjB4eIgLrEsy8BIL3MAveYJf7+esEMUiMs4Cnxfv0xNhCbV8Bc4vGJ60wQM+0knn3cyA4R
	F5Q4OfMJC4jNLFAmcXzRWXaQmcwC0hLL/3GAhDkF7CWOn3nKChKWEFCS+L7aC+LkWonPf58x
	TmAUnoVk0Cwkg2YhDIIIa0nc+PeSCUNYW2LZwtfMELatxLp171kWMLKvYhRJLS3OTc8tNtIr
	TswtLs1L10vOz93ECEwj24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6qkgjvwecL
	UoV4UxIrq1KL8uOLSnNSiw8xmgLDcCKzlGhyPjDB5ZXEG5oZmBqamFkamFqaGSuJ83oWdCQK
	CaQnlqRmp6YWpBbB9DFxcEo1MNVNXP23v52HR9pEf/EhTsl9NcoW79mlWWWv/mWfV3rU+0+l
	zozT875PCHWte/F41h/DU8YKicLRU8/cD71Y63vhkHn65V+TDYxcNKw6pufOey/isMthzbb5
	Wd9+HN5hZRzYJfM4hNcvabqi4XpV1tSKPPEutxOx1W3nWB1vPj18fp/BvXuLHtn+YIw+334g
	a9vcyQeaDe3yFZfVBNh3i/w8M4XvQXvg9Lpj4mUfItYwhaRaG7WXHyw5+OmoWxmL8aWPUkIL
	/kYu/razeMZuxxTPX4JLl+veu8G9WTfT9G/n/gDO/AvGHx/dLZ0Xvvojh0v01jOTJxeZH160
	r9v471IduYWcy2S6Hx0Tm8r346oSS3FGoqEWc1FxIgBRFj8yuAMAAA==
X-CMS-MailID: 20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6
X-Msg-Generator: CA
X-RootMTR: 20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
	<CGME20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6@eucas1p1.samsung.com>

--c4dq2qnbv4wtniq5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
>=20
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.
>=20
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
>=20
> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.
>=20
> The iommu selftest framework has been updated to test the IO page fault
> delivery and response functionality.
>=20
> This series is based on the latest implementation of nested translation
> under discussion [1] and the page fault handling framework refactoring in
> the IOMMU core [2].
>=20
> The series and related patches are available on GitHub: [3]
>=20
> [1] https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@=
intel.com/
> [2] https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@l=
inux.intel.com/
> [3] https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-del=
ivery-v2
I was working with this branch that included Yi Liu's
wip/iommufd_nesting branch. Now Yi Lui has updated his work in this post
https://lore.kernel.org/all/20240102143834.146165-1-yi.l.liu@intel.com.
Is there an updated version of the page fault work that is rebased on
top of Liu's new version?

Thx in advance

Best

>=20
> Best regards,
> baolu
>=20
> Change log:
> v2:
>  - Move all iommu refactoring patches into a sparated series and discuss
>    it in a different thread. The latest patch series [v6] is available at
>    https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@li=
nux.intel.com/
>  - We discussed the timeout of the pending page fault messages. We
>    agreed that we shouldn't apply any timeout policy for the page fault
>    handling in user space.
>    https://lore.kernel.org/linux-iommu/20230616113232.GA84678@myrica/
>  - Jason suggested that we adopt a simple file descriptor interface for
>    reading and responding to I/O page requests, so that user space
>    applications can improve performance using io_uring.
>    https://lore.kernel.org/linux-iommu/ZJWjD1ajeem6pK3I@ziepe.ca/
>=20
> v1: https://lore.kernel.org/linux-iommu/20230530053724.232765-1-baolu.lu@=
linux.intel.com/
>=20
> Lu Baolu (6):
>   iommu: Add iommu page fault cookie helpers
>   iommufd: Add iommu page fault uapi data
>   iommufd: Initializing and releasing IO page fault data
>   iommufd: Deliver fault messages to user space
>   iommufd/selftest: Add IOMMU_TEST_OP_TRIGGER_IOPF test support
>   iommufd/selftest: Add coverage for IOMMU_TEST_OP_TRIGGER_IOPF
>=20
>  include/linux/iommu.h                         |   9 +
>  drivers/iommu/iommu-priv.h                    |  15 +
>  drivers/iommu/iommufd/iommufd_private.h       |  12 +
>  drivers/iommu/iommufd/iommufd_test.h          |   8 +
>  include/uapi/linux/iommufd.h                  |  65 +++++
>  tools/testing/selftests/iommu/iommufd_utils.h |  66 ++++-
>  drivers/iommu/io-pgfault.c                    |  50 ++++
>  drivers/iommu/iommufd/device.c                |  69 ++++-
>  drivers/iommu/iommufd/hw_pagetable.c          | 260 +++++++++++++++++-
>  drivers/iommu/iommufd/selftest.c              |  56 ++++
>  tools/testing/selftests/iommu/iommufd.c       |  24 +-
>  .../selftests/iommu/iommufd_fail_nth.c        |   2 +-
>  12 files changed, 620 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.34.1
>=20

--=20

Joel Granados

--c4dq2qnbv4wtniq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWhtWkACgkQupfNUreW
QU8/pAv8D4KTohFrO9O/fJaowA1ej0E90/Y/0yMRldOc/hUCO9OL1m/+S3mndDho
QRBdwSLmeqSnZm7HJzQEaWULb2YBooS0y/SeY2F/fbYbgV6/oJFNllUukedb/x1F
4LvzxKp3agIEHGbBdmzMa131yhzQJZFC4AMMDPporcOoOfQjsXGB1w0TX1E7ngNE
n4oI89D8d7y42un9/eeY43zgXxylENp8jQSrleGcM5Eop09xv3uW0SBaeLbOopxs
uU2u4+wy+tUiAqbzdO2ObiAoJaFX2SMm7dlSttIDsm5OKhcYRolwhorqsV+NqIqN
vSbA/IuGmlxlB+pFBa6UuobrKEADQg3YzmFLIpnOeRzkZibmynf15US6058hwwOn
jUhbhMSwX4dFQ3Jlto0noQJmn95Sv0x3FJ/mdn/bQynBGptPOlX2V2QWtfea0h7x
FoIbfSHE+mIVeKhnC+/Ot1P9E7WW93WRAzwk8tbYaq17mZH+P3ejJLvmzFvSxFc1
buViNbPz
=Llua
-----END PGP SIGNATURE-----

--c4dq2qnbv4wtniq5--

