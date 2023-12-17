Return-Path: <linux-kselftest+bounces-2108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6978162B6
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 23:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCDD1F21BF3
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3D49F71;
	Sun, 17 Dec 2023 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Xk2ZIW/D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636049F6F;
	Sun, 17 Dec 2023 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231217215721euoutp0216bcb1dd671dfd0dab0965b2aa021efb~hvUXHPPM70916509165euoutp02h;
	Sun, 17 Dec 2023 21:57:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231217215721euoutp0216bcb1dd671dfd0dab0965b2aa021efb~hvUXHPPM70916509165euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702850241;
	bh=xjWTkZWdykopEkTNEhRt51a+5v0HDJwS+UzY+v2GiC0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Xk2ZIW/D4EI9bsKrhYn/c+vXzvgWH0u2PUOQBVN0Jg6XD/aY4z3iYWjNtC+eeeMFD
	 JhJi0bj5YENxhEwwXIMhDvuSkP7kVkTrxrxMOdmR4rQRiu+CHyMa/oTMNZhvZZxKao
	 sohhL8D9UAzaI/kMprGNSA1XiEUpo51bd/01w6a4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231217215720eucas1p1b29cb8b8caa9b5ee30fd763e0e8f05da~hvUWeSogk0989509895eucas1p18;
	Sun, 17 Dec 2023 21:57:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 44.6B.09814.0CE6F756; Sun, 17
	Dec 2023 21:57:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d~hvUV-LEM10127201272eucas1p2p;
	Sun, 17 Dec 2023 21:57:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231217215720eusmtrp2e8a2326fdf976197593cb9d29d129fae~hvUV86Ure2349823498eusmtrp2I;
	Sun, 17 Dec 2023 21:57:20 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-02-657f6ec06be5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.A6.09274.0CE6F756; Sun, 17
	Dec 2023 21:57:20 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231217215720eusmtip2e5b38905fc73a28f4359c05aa8fb2ac8~hvUVuA8jT2425324253eusmtip2N;
	Sun, 17 Dec 2023 21:57:20 +0000 (GMT)
Received: from localhost (106.210.248.232) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 17 Dec 2023 21:57:18 +0000
Date: Sun, 17 Dec 2023 12:21:01 +0100
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
Message-ID: <20231217112101.6mxn42dw62tbj6uw@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ie6luqe333dod4vz"
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-1-yi.l.liu@intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSfVBUVRztvvf27bK59NwluYMGuGCTYpBB41WSCYealzOl9PVHU9YOvBYE
	dmGfW5Baougg6LCSCbsgLWzAxrLI8GEqCIiNfFXS8qFsi6ktgeDGxwJFCMTytnKm/87vnN+5
	5547V4CLu0gfQbxiP6NSyBKlpJC4cH3ux2dbFJ8zzzXZgtDs0kkS1Z6uJ5H9/BiJNN2jANks
	69Ff0wiVWZwY6l1sBKh92ImjEwXVfFTqqOejwi9TUM/lQhLl2cZJ1LXQyUPVhgIcXRn6lUR1
	zbN8dHXCzkPf9h3hodN/6gHqMxoxNNh7G6Bzc/0EunOMQgbrDfCSD22/WoTRxywLJF1ZVAno
	jO8cPNrQeB+jNSUtgC7qiKZHarWAPnX0d5KeHLIS9HhTH0k7a3z3rHpX+GIskxj/MaMKifhQ
	GGcaaeYl50WmmmuPkofBZGgW8BBAKgxqzvYTWUAoEFNGALssUyQ3TAPY0/6NW3ECmH8uf3kQ
	rFiKtf4cXw6gPieb9+9S4bzBba8HMHfIDFwOgtoAK3pIVx5JbYY3HthwF/ai/OAPl6wrCThV
	zIOajFzMJUioXfDkXAnhwiJqKzzTMMzn8GrYobWv8DiVCrNLTSvn49RaWL4ocNEeFILf51dg
	XLcAeFM74saHYGedFXNlQeonIbTMD7qFKNiQ1c7nsASOttW58Tq4dOkrt+ELAJsXJ/jcYAKw
	LH3G7Q6HGb12tyMS/qF9CLg38oS3HKu5i3rC3At5OEeLYOZxMbf9NDTdfkBoQIDukWq6R6rp
	/qvG0ZuhvmGK/B8dBMuKx3AO74BVVeOEHvArgDejZpPkDPu8gvkkmJUlsWqFPDhGmVQDlv94
	12Lb9EVQPjoZ3AowAWgFgcvme9WmbuBDKJQKRuol0psPMGJRrCztU0al/EClTmTYVrBWQEi9
	RRti/RgxJZftZxIYJplR/aNiAg+fw9gb75maB8/s7o6+PyKX+8ZOHLS/Er7P6R2QWeHv/0xg
	+gE2sCy9PiLEmJqkP+/0NZRGKDo606oXGo7MzCizOyR6LNV09+Xd48qJQ42vpUe9kKNJ60pw
	sPdagyUplWMF049HN03vCfJ6fe+Ab9Y7G/d66vovGzFnu8dDY8LWu2dDN45un0q+GWXU8+LQ
	fNWJNW9m5m+Z+cX4dZFisiakLWU24Np2Z57f+2Gj2xT2t3CvK6/2xd1ShoV+VD2gUqv7HAmx
	koGLLeuS1+x0PqaLN+uMdXf2sQe3pey8HrPKWuK0messnzFDT5b+tiPHkRXGl+x64mf2eOb6
	mOHwcum1t0WbIpeekhJsnGzLJlzFyv4GY3DLkF4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsVy+t/xe7oH8upTDZZt57T49r+HzWLzxK1s
	Fk/Wv2azmHDhFaPFnUuKFr++WFgsu/SZyeLKvz2MFieef2a26Jy9gd1i6dut7BZzphZaXN41
	h81i+p33bBan/55itdiweDazxd6nj9kstuz/xm5x8MMTVovtV5tYLSb+WMBocXXFCiaLu1fu
	MVrM/XmNxeJBq4DF4lvnGR2kPJ4cnMfk0XrpL5vHmnlrGD1ajrxl9Vi85yWTx4RFBxg95p0M
	9HixeSajR2/zOzaPj09vsXi833eVzePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
	Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMfHYwumOlZc332fsYHxvXEXIweHhICJxMKZCl2M
	XBxCAksZJaaunMnexcgJFJeR2PjlKiuELSzx51oXG0TRR0aJp8ffsUA4WxklXixewwYyiUVA
	VWLVZTaQBjYBHYnzb+4wg9giAvISZ3feAqtnFljIKjGhZRITSEJYwEui5+ciFhCbV8BcYsru
	52CbhYDstZMPMEPEBSVOznwCVsMsUCbRsv4sK8guZgFpieX/OEDCnAIWEmdmrGKCOFRZ4vrM
	F1B2rcTnv88YJzAKz0IyaRaSSbMQJkGEtSRu/HvJhCGsLbFs4WtmCNtWYt269ywLGNlXMYqk
	lhbnpucWG+kVJ+YWl+al6yXn525iBKaxbcd+btnBuPLVR71DjEwcjIcYVYA6H21YfYFRiiUv
	Py9VSYR3wdrqVCHelMTKqtSi/Pii0pzU4kOMpsBAnMgsJZqcD0yweSXxhmYGpoYmZpYGppZm
	xkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTBaRPw8K/Ah5K9p5PLS6avta9iKZbXek+Z7f
	dm/7v6uDo0eYo+hQ0XL1vbXzeb5tE0n9eGPJpr7Z9+oCr96oPNjJcNBsdULW0oydBY3r/JX/
	iEWrJTt9eFSz+WT6pIjPVybabQ3sbyoy5bsm8l5cSqTY4P/B21enZ/EqvJ3i6RC+wm2LRvat
	yn0P3nQUOWWL3tqntTHj749Jdc5HuNMerPJ4/ZelRft3cEuTfKmD5ty3Rv4PDGxsI2a1Si2/
	PL1IRcOZY1HuTfmjHeZ1iw4c8jwVUCDetNiyOF/Rs3SqtPS6R33fznS2bjhxKSPd+tMLC2Xu
	uNn8IXnrHBezFu9ztPDSr5OSsc3njvFplT+qxFKckWioxVxUnAgAo/g33/gDAAA=
X-CMS-MailID: 20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d
X-Msg-Generator: CA
X-RootMTR: 20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d
References: <20231117130717.19875-1-yi.l.liu@intel.com>
	<CGME20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d@eucas1p2.samsung.com>

--ie6luqe333dod4vz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Yi

I have been working with https://github.com/yiliu1765/qemu/tree/zhenzhong/w=
ip/iommufd_nesting_rfcv1
and have some questions regarding one of the commits in that series.
I however cannot find it in lore.kernel.org. Can you please direct me to
where the rfc was posted? If it has not been posted yet, do you have an
alternate place for discussion?

Best

On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
> Nested translation is a hardware feature that is supported by many modern
> IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
> to get access to the physical address. stage-1 translation table is owned
> by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Chan=
ges
> to stage-1 translation table should be followed by an IOTLB invalidation.
>=20
> Take Intel VT-d as an example, the stage-1 translation table is I/O page
> table. As the below diagram shows, guest I/O page table pointer in GPA
> (guest physical address) is passed to host and be used to perform the sta=
ge-1
> address translation. Along with it, modifications to present mappings in =
the
> guest I/O page table should be followed with an IOTLB invalidation.
>=20
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest I/O page table      |
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush --+
>     '-------------'                        |
>     |             |                        V
>     |             |           I/O page table pointer in GPA
>     '-------------'
> Guest
> ------| Shadow |---------------------------|--------
>       v        v                           v
> Host
>     .-------------.  .------------------------.
>     |   pIOMMU    |  |  FS for GIOVA->GPA     |
>     |             |  '------------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.----------------------------------.
>     |             |   | SS for GPA->HPA, unmanaged domain|
>     |             |   '----------------------------------'
>     '-------------'
> Where:
>  - FS =3D First stage page tables
>  - SS =3D Second stage page tables
> <Intel VT-d Nested translation>
>=20
> This series adds the cache invalidation path for the userspace to invalid=
ate
> cache after modifying the stage-1 page table. This is based on the first =
part
> of nesting [1]
>=20
> Complete code can be found in [2], QEMU could can be found in [3].
>=20
> At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
> them for the help. ^_^. Look forward to your feedbacks.
>=20
> [1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-yi.l.liu@i=
ntel.com/ - merged
> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_=
rfcv1
>=20
> Change log:
>=20
> v6:
>  - No much change, just rebase on top of 6.7-rc1 as part 1/2 is merged
>=20
> v5: https://lore.kernel.org/linux-iommu/20231020092426.13907-1-yi.l.liu@i=
ntel.com/#t
>  - Split the iommufd nesting series into two parts of alloc_user and
>    invalidation (Jason)
>  - Split IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING/_NESTED, and
>    do the same with the structures/alloc()/abort()/destroy(). Reworked the
>    selftest accordingly too. (Jason)
>  - Move hwpt/data_type into struct iommu_user_data from standalone op
>    arguments. (Jason)
>  - Rename hwpt_type to be data_type, the HWPT_TYPE to be HWPT_ALLOC_DATA,
>    _TYPE_DEFAULT to be _ALLOC_DATA_NONE (Jason, Kevin)
>  - Rename iommu_copy_user_data() to iommu_copy_struct_from_user() (Kevin)
>  - Add macro to the iommu_copy_struct_from_user() to calculate min_size
>    (Jason)
>  - Fix two bugs spotted by ZhaoYan
>=20
> v4: https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@=
intel.com/
>  - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
>    and kernel-managed HWPTs
>  - Rework invalidate uAPI to be a multi-request array-based design
>  - Add a struct iommu_user_data_array and a helper for driver to sanitize
>    and copy the entry data from user space invalidation array
>  - Add a patch fixing TEST_LENGTH() in selftest program
>  - Drop IOMMU_RESV_IOVA_RANGES patches
>  - Update kdoc and inline comments
>  - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in neste=
d translation,
>    this does not change the rule that resv regions should only be added t=
o the
>    kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in late=
r series
>    as it is needed only by SMMU so far.
>=20
> v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@=
intel.com/
>  - Add new uAPI things in alphabetical order
>  - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user for
>    sanity, replacing the previous op->domain_alloc_user_data_len solution
>  - Return ERR_PTR from domain_alloc_user instead of NULL
>  - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translatio=
n (Kevin)
>  - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspace hen=
ce
>    userspace is able to exclude the ranges in the stage-1 HWPT (e.g. gues=
t I/O
>    page table). (Kevin)
>  - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
>  - Minor changes per Kevin's inputs
>=20
> v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@i=
ntel.com/
>  - Add union iommu_domain_user_data to include all user data structures t=
o avoid
>    passing void * in kernel APIs.
>  - Add iommu op to return user data length for user domain allocation
>  - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
>  - Store the invalidation data length in iommu_domain_ops::cache_invalida=
te_user_data_len
>  - Convert cache_invalidate_user op to be int instead of void
>  - Remove @data_type in struct iommu_hwpt_invalidate
>  - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop patch 0=
8 of v1
>=20
> v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@=
intel.com/
>=20
> Thanks,
> 	Yi Liu
>=20
> Lu Baolu (1):
>   iommu: Add cache_invalidate_user op
>=20
> Nicolin Chen (4):
>   iommu: Add iommu_copy_struct_from_user_array helper
>   iommufd/selftest: Add mock_domain_cache_invalidate_user support
>   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
>=20
> Yi Liu (1):
>   iommufd: Add IOMMU_HWPT_INVALIDATE
>=20
>  drivers/iommu/iommufd/hw_pagetable.c          | 35 ++++++++
>  drivers/iommu/iommufd/iommufd_private.h       |  9 ++
>  drivers/iommu/iommufd/iommufd_test.h          | 22 +++++
>  drivers/iommu/iommufd/main.c                  |  3 +
>  drivers/iommu/iommufd/selftest.c              | 69 +++++++++++++++
>  include/linux/iommu.h                         | 84 +++++++++++++++++++
>  include/uapi/linux/iommufd.h                  | 35 ++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 75 +++++++++++++++++
>  tools/testing/selftests/iommu/iommufd_utils.h | 63 ++++++++++++++
>  9 files changed, 395 insertions(+)
>=20
> --=20
> 2.34.1
>=20

--=20

Joel Granados

--ie6luqe333dod4vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmV+2ZQACgkQupfNUreW
QU9J3gv/V+IMJAwBGwUteuXVN0nQz7Ujp8O8qGsYlm+gxbDD1aw1FM08WWd+RuhT
SKjoA33eKWWsvoDHafVbPnwYJw02UZwmTiQYyl7RVA6fEFmW3zyhsaMKfEo3BSKP
zv6EVuyWNvpNLc7TEqjK3gfE3RIfvMvt1XeBqd9QnkiJ4uiSSrgXKw3NPaqdYYaU
NCY4bLLPhRRd0avGqPY6iIW7OkJraZ6uf4e4NZ3OGyw6+gmR94QK0vTyyHU7U1G8
BdyciJhpCrIA43eadtVs2gP1hA2ZsmVCoCaobz1aykKujd7XvAxpRxOLdQfR05M8
1RK616CKYmnA6tzUZXjxrNZzcuKosZRiQsWgEBjC2zcKQNqJJCtzVxdvyJnvshvg
67lc8nnouinDCRdkInH17ESjFRAuTBXyDBnJ/H8eULJCD/ddJcaByQvruVUtUk6j
vN/iH0sUNycpzUeK95MVfEQEI+oE1qvffFO5x+JEsJjdLEDE0NFsAGj2Rk7KbAdQ
+8AA8/kr
=0tgl
-----END PGP SIGNATURE-----

--ie6luqe333dod4vz--

