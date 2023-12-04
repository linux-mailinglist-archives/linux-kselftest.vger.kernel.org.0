Return-Path: <linux-kselftest+bounces-1070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34636803849
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AFC281194
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E912943A;
	Mon,  4 Dec 2023 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MM+RUq0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D6BC4;
	Mon,  4 Dec 2023 07:07:51 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231204150748euoutp02612dc70d95eb7aa494fda7f09bc801a2~dqWECJvV02140321403euoutp02I;
	Mon,  4 Dec 2023 15:07:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231204150748euoutp02612dc70d95eb7aa494fda7f09bc801a2~dqWECJvV02140321403euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701702468;
	bh=UduKPnQm68cXoxlHdEmWZOKtyfnkbxFsmJeY5avud44=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MM+RUq0UtMW7ws7H0S0Ou7vD5Bb+wBju4aAGFv4Kt7/pWjTu95F68zZDBmZ1ugg/U
	 k/jFoeaGx2CjCIHbRFzDpe1BpW2vZ0XAkLZVShqt9wHehoNAoLx600dSQhE52i/PiN
	 M8QwqPB9bqLZas0CYERPA4zKDRM0HZy4dTBNIhRA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231204150747eucas1p26333e09142452af0e86679cdc4da337d~dqWDs4D2V2804828048eucas1p2u;
	Mon,  4 Dec 2023 15:07:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8D.C6.09814.34BED656; Mon,  4
	Dec 2023 15:07:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a~dqWDIvRbe0222702227eucas1p23;
	Mon,  4 Dec 2023 15:07:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231204150747eusmtrp15777265caed2d957daeb1957804eccf0~dqWDIBHpR2293022930eusmtrp1Q;
	Mon,  4 Dec 2023 15:07:47 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-8f-656deb4362d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.F6.09274.34BED656; Mon,  4
	Dec 2023 15:07:47 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231204150747eusmtip12a603491717507856a186d16753c948c~dqWC6ygJe0939309393eusmtip1X;
	Mon,  4 Dec 2023 15:07:47 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 4 Dec 2023 15:07:46 +0000
Date: Mon, 4 Dec 2023 16:07:44 +0100
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231204150744.db3hfpq4v55cuavn@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="g7qzvqsc57itqwgz"
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZduzneV3n17mpBvf+mVhsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO4rJJSc3JLEst0rdL4MpYtvgGS8F0jYofLQ9ZGhibFLsYOTkkBEwk
	9p6bzN7FyMUhJLCCUeLSkn1sEM4XRonGk0uYQKqEBD4zShx97gDT0bP6BhNE0XJGiVOTlkJ1
	ABX92XEFytnMKLFk8TQWkBYWARWJ2e2rGEFsNgEdifNv7jB3MXJwiAioSzz7EgBSzyxwh1ni
	1It7rCA1wgKeEu/XH2MDsXkFzCU6rz5nh7AFJU7OfMIC0sssUCGx72IkhCktsfwfB0gFp4C9
	xPEzT1khDlWS+PqmF8qulTi15RbY0RIC3zgl/rxsZ4JIuEhsfbyUHcIWlnh1fAuULSNxenIP
	C0TDZEaJ/f8+sEM4qxklljV+heq2lmi58oQd5AoJAUeJnVdZIEw+iRtvBUEqmIHMSdumM0OE
	eSU62oQgGtUkVt97wzKBUXkWksdmITw2C+GxWWBzdCQW7P7EhiGsLbFs4WtmCNtWYt269ywL
	GNlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKbQ0/+Of9nBuPzVR71DjEwcjIcYVYCa
	H21YfYFRiiUvPy9VSYR33q3sVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6Yklqdmp
	qQWpRTBZJg5OqQam2JwKBifhK68PO+dEnDTi0FKXfP0ktf39R86q6oMTRE8/Sd8d6V60dsvP
	wyeY3swo4Nf9wsW44Ooe6xcNrwoaSj0tHhhWWIUbij7SYvFb5DFrRZaWtqbjR0vxO4/XJfh9
	n2eotpTBiW3Dv32W/7sfW3PmfnhwpJPzUWr7m0nyagkGC2b/5FEOWmS1sP3Q71y/xje1liH2
	ywr9ezf4T5OtmtBbxblquqiRZLv2wojrz56K5186Pf1N8Df3b64Hud4obJ/5js9MbdrEN/43
	s7/dKUsomffzecn81q5Ky6tzn7zhusK95/j3lILWvu/SXO+el7mvsj+lMI/Pt/0I35XkhiID
	v6LrNbr7dr8vb29XYinOSDTUYi4qTgQAyRVWRBwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xu7rOr3NTDU5+4rPYPHErm8WvLxYW
	Sw+uZ7FoWH2B1WLmjBOMFp2zN7BbLH27ld3i8q45bBbT77xns9j79DGbxcEPT1gtlp+dx2bR
	csfUYu7PaywOfB5PDs5j8lgzbw2jx+I9L5k8Nq3qZPO4c20Pm8e8k4Eek28sZ/R4sXkmo0dv
	8zs2j8+b5Dy2fr7NEsAdpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJdx4cMP1oKpGhWTl2xgbGBsUOxi5OSQEDCR6Fl9g6mLkYtDSGApo0Tfz0es
	EAkZiY1frkLZwhJ/rnWxQRR9ZJR48rWDBcLZzChxeP1uZpAqFgEVidntqxhBbDYBHYnzb+4A
	xTk4RATUJZ59CQCpZxa4wyxx8MduFpAaYQFPiffrj7GB2LwC5hKdV5+zg9hCAnYSzz5uZIeI
	C0qcnPmEBWQOs0CZROe/fAhTWmL5Pw6QCk4Be4njZ55C3akk8fVNL5RdK/H57zPGCYzCs5AM
	moUwaBbCIJAKZgEtiRv/XjJhCGtLLFv4mhnCtpVYt+49ywJG9lWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiBiWTbsZ9bdjCufPVR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4Z13KztViDcl
	sbIqtSg/vqg0J7X4EKMpMAgnMkuJJucDU1xeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJ
	anZqakFqEUwfEwenVAPTCrfSs7NnXSxIdCgx+NG18kLPBK28pQmLBDg858YE/ZFjKmt/0J2j
	Wf9Rje9E2hmliT42M3Q1Ut65G3ex75+1QCtX/rzPlYP/oh4e368f61jPriUnzvnterehi+Tc
	74fXKj5/frScj3vq3bxqBRtFltaJpyx9WkWrrzX26H2cIX+hjdn8gorbyq3X2c3KDuxKj605
	eLbEtX7uLIcSxaqoS67X8jbaPtorvcRUYMIUmfLbWdESnMWPb1+885Tr0gsWnjfrVs713cLc
	d1z+0qEnOsuSwu3yH21mifNxkrnwteb+h0OXXqVc/Rbxz/Xi/nnM3x4Zr7l2PE2hZ5IPx5yz
	UaV8iberChceZfexXF2vxFKckWioxVxUnAgAWaTaSbkDAAA=
X-CMS-MailID: 20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a
X-Msg-Generator: CA
X-RootMTR: 20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
	<CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>

--g7qzvqsc57itqwgz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
>=20
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

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

--g7qzvqsc57itqwgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVt6zgACgkQupfNUreW
QU/YxAv/amK6Yf/ek3gmC/YYj6UNyrZPgjipdI6JkSodKr8gwAAS/1zf9pAmXTwT
3REQr0utcNlpQ8kpoAEuuufpScq9cG3QiVMZfH3XggOywuWLv3nhPsiynQnkBauq
90r7lEUWUZd+fRZdM3IjaC96IqYDxQ1yKeIZ15ZJ3G5cf313NmTOP2nCUJoIb953
MMY8L9R0fCkYpFo8R1rIh0sDJKc9V4jD6nQfhfGWG4Ip1jKSoI4ZrGlSVX+Apnqd
bv/4+n0pypUK6h6jfVTDH5WTN+gpHGK3JxMuYVOh27rnkzZc/W5t5gEdcYK12ZzV
T60qTF2kGs6rCNveylvvV62fN7LofVfxsYcHiak9+He/W0C1PhHwfgp399315kKo
cNtIK+bk1EKyQJqct9h89mWcYIXsXl2jBeXY8O57u+Q7IRxST5KXiWNkc5XJowJq
hSnK4E6QPJ4gFF6Vq1MYhjdYZyDD2n+UHY4cfjO9HXEmZ8zUya61u18uPRdy0Ils
VPflK8/n
=5JsO
-----END PGP SIGNATURE-----

--g7qzvqsc57itqwgz--

