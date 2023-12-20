Return-Path: <linux-kselftest+bounces-2257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D519819DF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 12:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C321E1C22008
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2C21356;
	Wed, 20 Dec 2023 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BNloz1m3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B85219F3;
	Wed, 20 Dec 2023 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231220112350euoutp01758346f86096a24c9cfbecdd734e7677~ihnFtyeju1448514485euoutp01K;
	Wed, 20 Dec 2023 11:23:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231220112350euoutp01758346f86096a24c9cfbecdd734e7677~ihnFtyeju1448514485euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703071430;
	bh=4akjfBCJKKXoR+QIu19ue40aOmTNewVIO6wTVVNkKfc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BNloz1m3MwyTkjLlOs9VT5InPKxcmE3E+FmMMdknIzAfZAaMAcYYlWQLEGQw8MfkZ
	 HtX6StQuKqclGUuGUhUqeHuTiWEtmZMG5UO3UNeUcYXXLCXlsfkHredQJClcv/GRvA
	 zEtLOOsh7paOWaZkWmhWo3KDFTGCsj/hnbTPUUeg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231220112350eucas1p1a8f15635ff432678db8aaf25e560c9be~ihnFf0Dvk0589105891eucas1p1E;
	Wed, 20 Dec 2023 11:23:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 57.FC.09539.6CEC2856; Wed, 20
	Dec 2023 11:23:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231220112350eucas1p11c553442f801dbe4c1eed5ba73c4077c~ihnE-rCur0588605886eucas1p1F;
	Wed, 20 Dec 2023 11:23:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231220112350eusmtrp14a88447a2572fad2550de4855fd0cfee~ihnE_v-Un2729827298eusmtrp1Q;
	Wed, 20 Dec 2023 11:23:50 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-6c-6582cec6c0c7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F7.85.09274.5CEC2856; Wed, 20
	Dec 2023 11:23:49 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231220112349eusmtip1d4934d75a4f0003aca49a8bea5304afd~ihnErjRA-3005230052eusmtip1q;
	Wed, 20 Dec 2023 11:23:49 +0000 (GMT)
Received: from localhost (106.210.248.220) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 20 Dec 2023 11:23:48 +0000
Date: Wed, 20 Dec 2023 12:23:40 +0100
From: Joel Granados <j.granados@samsung.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231220112340.wtz3scdilr5m3ga6@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="53wom6cde5fkxq6o"
Content-Disposition: inline
In-Reply-To: <c6d88551-c480-4a89-ad2b-b873951fb181@intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf0xTVxTHc997fX00ljyKi3egc6MwE0CQuYwrgk63ZC+wMMjULW5TuvEC
	BGi1pRvb4sagutGga4FKyk8RxY6qgPxSByoNo/JLfkgnYQhVa1Sw8hsGERjl4Way/z7ne84n
	95zkUrionXSj4qRJrFwqSfAgBURt89ytzc23UtktJzrXo5mlDBJVaWtIZCsfIZGmaxiggZ43
	0PwUQqU9kxjqXawH6OajSRyl51Xw0Vl7DR/l6w6j21fzSZQzMEqitoVWHqooycNRw8MHJKq+
	PsNHjWM2HqqzpPKQ9u9TAFkMBgzd7R0EqGDuTwJZj9KopL8TvOvG2BoLMeZozwLJnC88DxhV
	k53HlNQ/wRjN6RuAKWyJZB5X6QFzPO0ZyYw/7CeY0WsWkpm89FrEmv2C4Gg2Ie5rVu6/I0oQ
	W6kfIg6diExeqH6OpwDNTjVwoiD9NhyZKcPVQECJaAOAVa1jPK6YAvBe1zSfKyYBXLqRx3uh
	1BmWcAeL6HMADk87/zvU95d51agBMFt7jHRMEbQXzFbXEg4maV/Y+XRgxV5Lb4QdV/oJh4DT
	xTyoUWVijoYrHQoz5k6vCEI6EM7N/0Zy7AJb9LaVHKeToXnq2TJTy+wOzy1SjtiJDoGVRXaS
	21QMi7TNfI6PwNbqfszxFqQtAvg4p2y18T4c1FzAOHaFw+bq1Xw9bMvKIDghC8Dri2N8rjAC
	WPrT9KqxHap6bavGLjirfw4cG0HaGfbZXbhFnWFmbQ7OxUL4yzERN/0mNA4+JTRAnPvSabkv
	nZb732lc7Af7dNnk/2IfWFo8gnMcAi9eHCVOAX4ZWMcqFYkxrCJAyn7jp5AkKpTSGL+vZImX
	wPInb1s0T1wGBcPjfiaAUcAEPJfl+xXGLuBGSGVS1mOtsCE9lRUJoyXffsfKZQflygRWYQLu
	FOGxTugVvZEV0TGSJDaeZQ+x8hddjHJyS8E2dJ9cs6d4q0QWv8PsKrUdlyWndwhjTO+owq5+
	ZqzcNSP89Xf/gi+97omBqXS2O/JCSXmQKSVV++SuUh1ertncFjj7aNv8p02baM+Acn8vS0uX
	TnenLArkx6YJeBWGI9mHhypDnMMfHNh+p/WHifbQt7ZFeO/5ONogaPT1/CDUp0EZ+Yp+6x9N
	pg8J3ZVrvqqo113iFDcPWK1BEcGJ7grZUF7qTrcv5lH75fesSfaO2SF1uLWocmhAaLz9CXE/
	XjxxUJwZpn41NjD3xzNbNn3fkrPh57SP6ncH4Prx/WgvlWCmgqxhyvzxyGStU93kvmqfM94q
	C5a1Ozj07Ih399TnsMKDUMRKArxxuULyD4IWDjNfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsVy+t/xu7pHzzWlGryabWrx7X8Pm8XmiVvZ
	LJ6sf81mMeHCK0aLO5cULX59sbBYdukzk8WVf3sYLU48/8xs0Tl7A7vF0rdb2S3mTC20uLxr
	DpvF9Dvv2SxO/z3FarFh8Wxmi71PH7NZbNn/jd3i4IcnrBbbrzaxWkz8sYDR4uqKFUwWd6/c
	Y7SY+/Mai8WDVgGLxbfOMzpIeTw5OI/Jo/XSXzaPNfPWMHq0HHnL6rF4z0smjwmLDjB6zDsZ
	6PFi80xGj97md2weH5/eYvF4v+8qm8fnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
	lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GWvfX2Ar6Ams2NR/mKmBsc++i5GTQ0LARGL7iv/M
	XYxcHEICSxklPh+7zQiRkJHY+OUqK4QtLPHnWhcbRNFHRokr+85BdWxllDg6YzsLSBWLgKrE
	lK5tYDabgI7E+Td3mEFsEQF5ibM7b7GANDALLGSVmNAyiQkkISzgJdHzcxFYA6+AucTPXyvZ
	QGwhgTeMEhPu2ULEBSVOznwCVsMsUCZx8MlloJM4gGxpieX/OEDCnAK2Ehvnv2WDuFRZYv7E
	Y+wQdq3E57/PGCcwCs9CMmkWkkmzECZBhHUkdm69w4YhrC2xbOFrZgjbVmLduvcsCxjZVzGK
	pJYW56bnFhvpFSfmFpfmpesl5+duYgQms23Hfm7Zwbjy1Ue9Q4xMHIyHGFWAOh9tWH2BUYol
	Lz8vVUmEd29nU6oQb0piZVVqUX58UWlOavEhRlNgKE5klhJNzgem2bySeEMzA1NDEzNLA1NL
	M2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBiYB9SAJa+l9BnNEvy8PmLlMQv6BXu8EpqmM
	+3szTkrf8H1YVbcj1+uo9tMt0zOjE12eHVOcP/n99edPihML5h1Yv+JX/y13/li1pNU8/jWn
	dj4x+fhHf+uDqrXO9/7ssKy8WfvgYnrgSpVvLLFO9614dy7vVuzMkXnqM0kgNmcJt2XfEiYG
	v8wltR+iF6/In2PV8HRCayADU9gbhdW1DzuEjsu+CGOXZuk9u8bPx/tLTKCBibtqQs+STp2U
	tgd7Tp++d6J2BwtPyClxjRS+i4V6EUafjnWH/3oUfP7DE7t3whzGnfYvi1Mlp97e/XbW1Lch
	GkuSem7MfBJv+dPBoHjjhCuJbU9nhBZH7zKJPajEUpyRaKjFXFScCABmQ0Rb+wMAAA==
X-CMS-MailID: 20231220112350eucas1p11c553442f801dbe4c1eed5ba73c4077c
X-Msg-Generator: CA
X-RootMTR: 20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d
References: <20231117130717.19875-1-yi.l.liu@intel.com>
	<CGME20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d@eucas1p2.samsung.com>
	<20231217112101.6mxn42dw62tbj6uw@localhost>
	<c6d88551-c480-4a89-ad2b-b873951fb181@intel.com>

--53wom6cde5fkxq6o
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 05:26:21PM +0800, Yi Liu wrote:
> On 2023/12/17 19:21, Joel Granados wrote:
> > Hey Yi
> >=20
> > I have been working with https://protect2.fireeye.com/v1/url?k=3Db58750=
ce-ea1c9eaa-b586db81-000babda0201-365207d33731a099&q=3D1&e=3Dee73b69d-5c35-=
49ef-9e62-2355fb797f21&u=3Dhttps%3A%2F%2Fgithub.com%2Fyiliu1765%2Fqemu%2Ftr=
ee%2Fzhenzhong%2Fwip%2Fiommufd_nesting_rfcv1
>=20
> good to know about it.
>=20
> > and have some questions regarding one of the commits in that series.
> > I however cannot find it in lore.kernel.org. Can you please direct me to
> > where the rfc was posted? If it has not been posted yet, do you have an
> > alternate place for discussion?
>=20
> the qemu series has not been posted yet as kernel side is still changing.
> It still needs some time to be ready for public review. Zhenzhong Duan
> is going to post it when it's ready. If you have questions to discuss,
> you can post your questions to Zhenzhong and me first. I guess it may be
> fine to cc Alex Williamson, Eric Auger, Nicolin Chen, C=E9dric Le Goater,
> Kevin Tian, Jason Gunthorpe and qemu mail list as this is discussion
> something that is going to be posted in public.
Thx for getting back to me. I'll direct my questions to these
recipients.

Best

>=20
> >=20
> > Best
> >=20
> > On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
> > > Nested translation is a hardware feature that is supported by many mo=
dern
> > > IOMMU hardwares. It has two stages (stage-1, stage-2) address transla=
tion
> > > to get access to the physical address. stage-1 translation table is o=
wned
> > > by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. =
Changes
> > > to stage-1 translation table should be followed by an IOTLB invalidat=
ion.
> > >=20
> > > Take Intel VT-d as an example, the stage-1 translation table is I/O p=
age
> > > table. As the below diagram shows, guest I/O page table pointer in GPA
> > > (guest physical address) is passed to host and be used to perform the=
 stage-1
> > > address translation. Along with it, modifications to present mappings=
 in the
> > > guest I/O page table should be followed with an IOTLB invalidation.
> > >=20
> > >      .-------------.  .---------------------------.
> > >      |   vIOMMU    |  | Guest I/O page table      |
> > >      |             |  '---------------------------'
> > >      .----------------/
> > >      | PASID Entry |--- PASID cache flush --+
> > >      '-------------'                        |
> > >      |             |                        V
> > >      |             |           I/O page table pointer in GPA
> > >      '-------------'
> > > Guest
> > > ------| Shadow |---------------------------|--------
> > >        v        v                           v
> > > Host
> > >      .-------------.  .------------------------.
> > >      |   pIOMMU    |  |  FS for GIOVA->GPA     |
> > >      |             |  '------------------------'
> > >      .----------------/  |
> > >      | PASID Entry |     V (Nested xlate)
> > >      '----------------\.----------------------------------.
> > >      |             |   | SS for GPA->HPA, unmanaged domain|
> > >      |             |   '----------------------------------'
> > >      '-------------'
> > > Where:
> > >   - FS =3D First stage page tables
> > >   - SS =3D Second stage page tables
> > > <Intel VT-d Nested translation>
> > >=20
> > > This series adds the cache invalidation path for the userspace to inv=
alidate
> > > cache after modifying the stage-1 page table. This is based on the fi=
rst part
> > > of nesting [1]
> > >=20
> > > Complete code can be found in [2], QEMU could can be found in [3].
> > >=20
> > > At last, this is a team work together with Nicolin Chen, Lu Baolu. Th=
anks
> > > them for the help. ^_^. Look forward to your feedbacks.
> > >=20
> > > [1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-yi.l.l=
iu@intel.com/ - merged
> > > [2] https://protect2.fireeye.com/v1/url?k=3D38b56f01-672ea165-38b4e44=
e-000babda0201-469ae350f21411ca&q=3D1&e=3Dee73b69d-5c35-49ef-9e62-2355fb797=
f21&u=3Dhttps%3A%2F%2Fgithub.com%2Fyiliu1765%2Fiommufd%2Ftree%2Fiommufd_nes=
ting
> > > [3] https://protect2.fireeye.com/v1/url?k=3Dd6e01ed1-897bd0b5-d6e1959=
e-000babda0201-bcf2b26a8dc8b34d&q=3D1&e=3Dee73b69d-5c35-49ef-9e62-2355fb797=
f21&u=3Dhttps%3A%2F%2Fgithub.com%2Fyiliu1765%2Fqemu%2Ftree%2Fzhenzhong%2Fwi=
p%2Fiommufd_nesting_rfcv1
> > >=20
> > > Change log:
> > >=20
> > > v6:
> > >   - No much change, just rebase on top of 6.7-rc1 as part 1/2 is merg=
ed
> > >=20
> > > v5: https://lore.kernel.org/linux-iommu/20231020092426.13907-1-yi.l.l=
iu@intel.com/#t
> > >   - Split the iommufd nesting series into two parts of alloc_user and
> > >     invalidation (Jason)
> > >   - Split IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING/_NESTED=
, and
> > >     do the same with the structures/alloc()/abort()/destroy(). Rework=
ed the
> > >     selftest accordingly too. (Jason)
> > >   - Move hwpt/data_type into struct iommu_user_data from standalone op
> > >     arguments. (Jason)
> > >   - Rename hwpt_type to be data_type, the HWPT_TYPE to be HWPT_ALLOC_=
DATA,
> > >     _TYPE_DEFAULT to be _ALLOC_DATA_NONE (Jason, Kevin)
> > >   - Rename iommu_copy_user_data() to iommu_copy_struct_from_user() (K=
evin)
> > >   - Add macro to the iommu_copy_struct_from_user() to calculate min_s=
ize
> > >     (Jason)
> > >   - Fix two bugs spotted by ZhaoYan
> > >=20
> > > v4: https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.=
liu@intel.com/
> > >   - Separate HWPT alloc/destroy/abort functions between user-managed =
HWPTs
> > >     and kernel-managed HWPTs
> > >   - Rework invalidate uAPI to be a multi-request array-based design
> > >   - Add a struct iommu_user_data_array and a helper for driver to san=
itize
> > >     and copy the entry data from user space invalidation array
> > >   - Add a patch fixing TEST_LENGTH() in selftest program
> > >   - Drop IOMMU_RESV_IOVA_RANGES patches
> > >   - Update kdoc and inline comments
> > >   - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in =
nested translation,
> > >     this does not change the rule that resv regions should only be ad=
ded to the
> > >     kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in=
 later series
> > >     as it is needed only by SMMU so far.
> > >=20
> > > v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.=
liu@intel.com/
> > >   - Add new uAPI things in alphabetical order
> > >   - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user=
 for
> > >     sanity, replacing the previous op->domain_alloc_user_data_len sol=
ution
> > >   - Return ERR_PTR from domain_alloc_user instead of NULL
> > >   - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested trans=
lation (Kevin)
> > >   - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspac=
e hence
> > >     userspace is able to exclude the ranges in the stage-1 HWPT (e.g.=
 guest I/O
> > >     page table). (Kevin)
> > >   - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
> > >   - Minor changes per Kevin's inputs
> > >=20
> > > v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.l=
iu@intel.com/
> > >   - Add union iommu_domain_user_data to include all user data structu=
res to avoid
> > >     passing void * in kernel APIs.
> > >   - Add iommu op to return user data length for user domain allocation
> > >   - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
> > >   - Store the invalidation data length in iommu_domain_ops::cache_inv=
alidate_user_data_len
> > >   - Convert cache_invalidate_user op to be int instead of void
> > >   - Remove @data_type in struct iommu_hwpt_invalidate
> > >   - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop pa=
tch 08 of v1
> > >=20
> > > v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.=
liu@intel.com/
> > >=20
> > > Thanks,
> > > 	Yi Liu
> > >=20
> > > Lu Baolu (1):
> > >    iommu: Add cache_invalidate_user op
> > >=20
> > > Nicolin Chen (4):
> > >    iommu: Add iommu_copy_struct_from_user_array helper
> > >    iommufd/selftest: Add mock_domain_cache_invalidate_user support
> > >    iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
> > >    iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> > >=20
> > > Yi Liu (1):
> > >    iommufd: Add IOMMU_HWPT_INVALIDATE
> > >=20
> > >   drivers/iommu/iommufd/hw_pagetable.c          | 35 ++++++++
> > >   drivers/iommu/iommufd/iommufd_private.h       |  9 ++
> > >   drivers/iommu/iommufd/iommufd_test.h          | 22 +++++
> > >   drivers/iommu/iommufd/main.c                  |  3 +
> > >   drivers/iommu/iommufd/selftest.c              | 69 +++++++++++++++
> > >   include/linux/iommu.h                         | 84 ++++++++++++++++=
+++
> > >   include/uapi/linux/iommufd.h                  | 35 ++++++++
> > >   tools/testing/selftests/iommu/iommufd.c       | 75 +++++++++++++++++
> > >   tools/testing/selftests/iommu/iommufd_utils.h | 63 ++++++++++++++
> > >   9 files changed, 395 insertions(+)
> > >=20
> > > --=20
> > > 2.34.1
> > >=20
> >=20
>=20
> --=20
> Regards,
> Yi Liu

--=20

Joel Granados

--53wom6cde5fkxq6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWCzrsACgkQupfNUreW
QU8N8gv+JAauQGZJaMEm6OPs/J47+sm+ehXncbnx309pNrvE1VZfO4l6VYwuK0ic
rGmgZoxQhqZS280dqGWxiyKLsqczKrRkDuyksa618ju7VwcglQybISvv2o324cpw
snS7XxfqL9zBBkxng7+X/6Kr5/vIQfoiDwQUC9knNGh0zBK8Ldl9vxBwzFF4F5q0
Kcc9TzozfPUsxHCtyWc0TXx9yAxI2nEo0ed07eQAtby+J4HqNO2HFzUJRydt4Dc0
tRux4XZTTGdnyMd+fILHGpJGLbjjmG9dfR+gs3Cs4CN1eZEao3b8qkR8LwLGcvkx
g5uTTyDVyHYTk11Ow6Cfvbo61CDPjl06fVtn54fKzdDB/c1NLuob+zvlk50Ej3MV
BbZlT3eXohFh1gYvk/BV+5xTH1E6tfx78KO6fMvkYpLHuOWQ2rsyhusQBq7qxo9y
oA/dcALHVFt8eSeMSaTXqVJtdyhL/xs1QjjyVTLkbI6/2SlrhCcXEjTZUrfQ+vWv
t8jZDdx3
=eK/f
-----END PGP SIGNATURE-----

--53wom6cde5fkxq6o--

