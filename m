Return-Path: <linux-kselftest+bounces-1669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798880ECE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999BE1F2142D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFC61669;
	Tue, 12 Dec 2023 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTgQnEFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C9A8;
	Tue, 12 Dec 2023 05:10:13 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231212131010euoutp016c53dea20d2d0e7399b11cf62260b397~gF5phdnLx1711717117euoutp01T;
	Tue, 12 Dec 2023 13:10:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231212131010euoutp016c53dea20d2d0e7399b11cf62260b397~gF5phdnLx1711717117euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702386611;
	bh=WkqzshImINpLziy/1ItP4WywwE9JFpvAyRaOB0ulk4M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QTgQnEFxUXq4Ig6szJPW6sQT+jFV9goAujAdO87SUPDcc8gMVHMPPoRkfSoQf595s
	 2a8EUPQcPliIFQnH0D5QmvEsbmxJMHew1J7gdp4TCwylLwitSyiIC6NCoAwil0Vmlr
	 f7hhTn5daKKmLPJvPIafcxNnrmDBUcpJXqFmp88Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231212131010eucas1p198776c7caea1edf7b633166c8d9b6527~gF5pTR4Yi1663116631eucas1p1V;
	Tue, 12 Dec 2023 13:10:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.3D.09539.2BB58756; Tue, 12
	Dec 2023 13:10:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee~gF5o6M68l2876828768eucas1p1g;
	Tue, 12 Dec 2023 13:10:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231212131010eusmtrp2cae2503dda123611d510aa4f3c873031~gF5o5eTft1872018720eusmtrp2k;
	Tue, 12 Dec 2023 13:10:10 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-34-65785bb21995
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.9B.09146.2BB58756; Tue, 12
	Dec 2023 13:10:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231212131010eusmtip1cd48a7c4b4d16ae1e96e73e40258d0a8~gF5otTPIy0778007780eusmtip1x;
	Tue, 12 Dec 2023 13:10:10 +0000 (GMT)
Received: from localhost (106.210.248.229) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 12 Dec 2023 13:10:09 +0000
Date: Tue, 12 Dec 2023 14:10:08 +0100
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page
 fault data
Message-ID: <20231212131008.k6s5xwjgolp6geps@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="paapshyymo2eyrec"
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZduzned1N0RWpBiv3a1hsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO4rJJSc3JLEst0rdL4MpY+HMOa8HZ6IpLDQ+YGhhPencxcnBICJhI
	nPgg3cXIxSEksIJR4nTDB3YI5wujxMmXO9ggnM+MEhu3/GbqYuQE67h/dDFU1XJGiT/T17PC
	VR2+fhPK2coo0XJ9BStIC4uAqsTTw/fAbDYBHYnzb+4wgywXEVCXePYlAKSeWeAOs8SpFxA1
	wgIhEqve7WcHsXkFzCWentjFCmELSpyc+YQFxGYWqJCYvXwK2BxmAWmJ5f84QMKcAvYS2y/e
	ZIG4VFmif+kcVgi7VuLUlltMILskBL5xShx+OwPqHReJs3PusEHYwhKvjm9hh7BlJP7vnA/V
	MJlRYv8/SMhICKxmlFjW+BWq21qi5coTqA5HiV89C5ghwconceOtIMShfBKTtk2HCvNKdLQJ
	QVSrSay+94ZlAqPyLCSvzULy2iyE1yDCOhILdn9iwxDWlli28DUzhG0rsW7de5YFjOyrGMVT
	S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAhPp6X/HP+1gnPvqo94hRiYOxkOMKkDNjzasvsAo
	xZKXn5eqJMJ7ckd5qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgs
	EwenVANTgvYTK8Gtd9S4EoscNgXYzn76+zVL+nJZ9dBLWvWFHAldJ7emL9l1cNViIZEnK9Zd
	cc28//vfzvlzudhXPohzv74gO0GvKvLCladLPO88kzW+ce3jrkmznzzesfrk0gQNmU9SYsa6
	skEyXTUhHqZ2d004j4RO/jS3RL/77Rzfutuxzpt0mNm330s0Obir67jkd7sJJtHbk1ki3nW/
	rDS657My6RqXk8iZVPHan3fY1+zrsn2vuWCtS/rDE8bTVBfHz1X+MME9bcs1p0kRKmJ3LdJm
	velcxWg10zxVfb1/3SEDj9emHpaLDN4LzThZx8T1ctoh9wX87MvUb35cFe07bQ77oYou4Z2R
	GzZK2R5VV2Ipzkg01GIuKk4EAHD4r9YfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7qboitSDe4e5LXYPHErm8WvLxYW
	Sw+uZ7FoWH2B1WLmjBOMFp2zN7BbLH27ld3i8q45bBbT77xns9j79DGbxcEPT1gtlp+dx2bR
	csfUYu7PaywOfB5PDs5j8lgzbw2jx+I9L5k8Nq3qZPO4c20Pm8e8k4Eek28sZ/R4sXkmo0dv
	8zs2j8+b5Dy2fr7NEsAdpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJcx//191oLT0RWHZk5iamA87t3FyMkhIWAicf/oYvYuRi4OIYGljBKz9yxi
	gUjISGz8cpUVwhaW+HOtiw2i6COjxOd1b6A6tjJKLN+7jBGkikVAVeLp4XtgHWwCOhLn39xh
	7mLk4BARUJd49iUApJ5Z4A6zxMEfu8E2CAuESLQvPcYEYvMKmEs8PbELrFdIoFji2tm5zBBx
	QYmTM5+A1TMLlElc/7+ICWQms4C0xPJ/HCBhTgF7ie0Xb0IdrSzRv3QO1NG1Ep//PmOcwCg8
	C8mkWUgmzUKYBBHWkrjx7yWmsLbEsoWvmSFsW4l1696zLGBkX8UoklpanJueW2yoV5yYW1ya
	l66XnJ+7iRGYTLYd+7l5B+O8Vx/1DjEycTAeYlQB6ny0YfUFRimWvPy8VCUR3pM7ylOFeFMS
	K6tSi/Lji0pzUosPMZoCA3Eis5Rocj4wzeWVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
	ZqemFqQWwfQxcXBKNTCZz/4rIVVsMdn8q2pLzW+emB631ybS6zQ1PM4WPzUWeMNX8/b+X4HJ
	UXdbJh+ZLLz16Lb5IW8VfxleSj8xq0VUKcHGbOLBeZLxMR9KHm7VzptfuVBfW4sv6c2fMCXH
	D1/5V7cfzOxlPahw/lKag9LE9Fu357kenlNmI3DqyGKXJt2bl7UnHxa9MHNni9GayL5t9x0c
	z24ROyb52fXoys61jldO5j95coJz6qvJnMEhLlWSa3hvz5q+Lsjd8u58pyhvx79K/Ce4pJiK
	+o/uP1BuuMwkZdch5eaelUFNbTv/HLx//ErwbDWnBY8snt1hmZkcyae/cXmL0MKQgralvzpX
	iP3eqTfPg/lDnVbLxQ3zlFiKMxINtZiLihMBF63rT7sDAAA=
X-CMS-MailID: 20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee
X-Msg-Generator: CA
X-RootMTR: 20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
	<20231026024930.382898-4-baolu.lu@linux.intel.com>
	<CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>

--paapshyymo2eyrec
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:49:27AM +0800, Lu Baolu wrote:
> Add some housekeeping code for IO page fault dilivery. Add a fault field
> in the iommufd_hw_pagetable structure to store pending IO page faults and
> other related data.
>=20
> The fault field is allocated and initialized when an IOPF-capable user
> HWPT is allocated. It is indicated by the IOMMU_HWPT_ALLOC_IOPF_CAPABLE
> flag being set in the allocation user data. The fault field exists until
> the HWPT is destroyed. This also means that you can determine whether a
> HWPT is IOPF-capable by checking the fault field.
>=20
> When an IOPF-capable HWPT is attached to a device (could also be a PASID =
of
> a device in the future), the iommufd device pointer is saved for the pasid
> of the device. The pointer is recalled and all pending iopf groups are
> discarded after the HWPT is detached from the device.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                   |  6 +++
>  drivers/iommu/iommufd/iommufd_private.h | 10 ++++
>  drivers/iommu/iommufd/device.c          | 69 +++++++++++++++++++++++--
>  drivers/iommu/iommufd/hw_pagetable.c    | 56 +++++++++++++++++++-
>  4 files changed, 137 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 615d8a5f9dee..600ca3842c8a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -130,6 +130,12 @@ struct iopf_group {
>  	struct work_struct work;
>  	struct device *dev;
>  	struct iommu_domain *domain;
> +
> +	/*
> +	 * Used by iopf handlers, like iommufd, to hook the iopf group
> +	 * on its own lists.
> +	 */
> +	struct list_head node;
>  };
> =20
>  /**
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iomm=
ufd/iommufd_private.h
> index 1bd412cff2d6..0dbaa2dc5b22 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -230,6 +230,15 @@ int iommufd_option_rlimit_mode(struct iommu_option *=
cmd,
> =20
>  int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
> =20
> +struct hw_pgtable_fault {
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_hw_pagetable *hwpt;
> +	/* Protect below iopf lists. */
> +	struct mutex mutex;
> +	struct list_head deliver;
> +	struct list_head response;
> +};
> +
>  /*
>   * A HW pagetable is called an iommu_domain inside the kernel. This user=
 object
>   * allows directly creating and inspecting the domains. Domains that hav=
e kernel
> @@ -239,6 +248,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
>  struct iommufd_hw_pagetable {
>  	struct iommufd_object obj;
>  	struct iommu_domain *domain;
> +	struct hw_pgtable_fault *fault;
> =20
>  	void (*abort)(struct iommufd_object *obj);
>  	void (*destroy)(struct iommufd_object *obj);
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index 645ab5d290fe..0a8e03d5e7c5 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pa=
getable *hwpt,
>  	if (rc)
>  		goto err_unlock;
> =20
> +	if (hwpt->fault) {
> +		void *curr;
> +
> +		curr =3D iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
I'm hitting an error here when I try to attach to a hwpt that I created
previously with the `IOMMU_HWPT_ALLOC_IOPF_CAPABLE` flag.

I get an -ENODEV from iopf_pasid_cookie_set which is triggered by
dev->iommu->fault_param being 0x0.

I looked around and I see that the fault param gets set in
iopf_queue_add_device which is called from iommu_dev_enable_feature
only. Furthermore iommu_dev_enable_feature is only called in idxd and
uacce drivers.

Questions:
1. Should iopf_queue_add_device get called from the
   IOMMU_HWPT_ALLOC_IOPF_CAPABLE ioctl call? This make sense to me as
   this is where the device and the IOPF are related from user space.
2. This is not intended to work only with idxd and uacce. right?

Best
> +		if (IS_ERR(curr)) {
> +			rc =3D PTR_ERR(curr);
> +			goto err_unresv;
> +		}
> +	}
> +
>  	/*
>  	 * Only attach to the group once for the first device that is in the
>  	 * group. All the other devices will follow this attachment. The user
> @@ -466,17 +476,20 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_p=
agetable *hwpt,
>  	if (list_empty(&idev->igroup->device_list)) {
>  		rc =3D iommufd_group_setup_msi(idev->igroup, hwpt);
>  		if (rc)
> -			goto err_unresv;
> +			goto err_unset;
> =20
>  		rc =3D iommu_attach_group(hwpt->domain, idev->igroup->group);
>  		if (rc)
> -			goto err_unresv;
> +			goto err_unset;
>  		idev->igroup->hwpt =3D hwpt;
>  	}
>  	refcount_inc(&hwpt->obj.users);
>  	list_add_tail(&idev->group_item, &idev->igroup->device_list);
>  	mutex_unlock(&idev->igroup->lock);
>  	return 0;
> +err_unset:
> +	if (hwpt->fault)
> +		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
>  err_unresv:
>  	iommufd_device_remove_rr(idev, hwpt);
>  err_unlock:
> @@ -484,6 +497,30 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pa=
getable *hwpt,
>  	return rc;
>  }
> =20
> +/*
> + * Discard all pending page faults. Called when a hw pagetable is detach=
ed
> + * from a device. The iommu core guarantees that all page faults have be=
en
> + * responded, hence there's no need to respond it again.
> + */
> +static void iommufd_hw_pagetable_discard_iopf(struct iommufd_hw_pagetabl=
e *hwpt)
> +{
> +	struct iopf_group *group, *next;
> +
> +	if (!hwpt->fault)
> +		return;
> +
> +	mutex_lock(&hwpt->fault->mutex);
> +	list_for_each_entry_safe(group, next, &hwpt->fault->deliver, node) {
> +		list_del(&group->node);
> +		iopf_free_group(group);
> +	}
> +	list_for_each_entry_safe(group, next, &hwpt->fault->response, node) {
> +		list_del(&group->node);
> +		iopf_free_group(group);
> +	}
> +	mutex_unlock(&hwpt->fault->mutex);
> +}
> +
>  struct iommufd_hw_pagetable *
>  iommufd_hw_pagetable_detach(struct iommufd_device *idev)
>  {
> @@ -491,6 +528,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *id=
ev)
> =20
>  	mutex_lock(&idev->igroup->lock);
>  	list_del(&idev->group_item);
> +	if (hwpt->fault)
> +		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
>  	if (list_empty(&idev->igroup->device_list)) {
>  		iommu_detach_group(hwpt->domain, idev->igroup->group);
>  		idev->igroup->hwpt =3D NULL;
> @@ -498,6 +537,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *id=
ev)
>  	iommufd_device_remove_rr(idev, hwpt);
>  	mutex_unlock(&idev->igroup->lock);
> =20
> +	iommufd_hw_pagetable_discard_iopf(hwpt);
> +
>  	/* Caller must destroy hwpt */
>  	return hwpt;
>  }
> @@ -563,9 +604,24 @@ iommufd_device_do_replace(struct iommufd_device *ide=
v,
>  	if (rc)
>  		goto err_unresv;
> =20
> +	if (old_hwpt->fault) {
> +		iommufd_hw_pagetable_discard_iopf(old_hwpt);
> +		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
> +	}
> +
> +	if (hwpt->fault) {
> +		void *curr;
> +
> +		curr =3D iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
> +		if (IS_ERR(curr)) {
> +			rc =3D PTR_ERR(curr);
> +			goto err_unresv;
> +		}
> +	}
> +
>  	rc =3D iommu_group_replace_domain(igroup->group, hwpt->domain);
>  	if (rc)
> -		goto err_unresv;
> +		goto err_unset;
> =20
>  	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
>  		list_for_each_entry(cur, &igroup->device_list, group_item)
> @@ -583,8 +639,15 @@ iommufd_device_do_replace(struct iommufd_device *ide=
v,
>  					      &old_hwpt->obj.users));
>  	mutex_unlock(&idev->igroup->lock);
> =20
> +	iommufd_hw_pagetable_discard_iopf(old_hwpt);
> +
>  	/* Caller must destroy old_hwpt */
>  	return old_hwpt;
> +err_unset:
> +	if (hwpt->fault)
> +		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
> +	if (old_hwpt->fault)
> +		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
>  err_unresv:
>  	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
>  		list_for_each_entry(cur, &igroup->device_list, group_item)
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd=
/hw_pagetable.c
> index 72c46de1396b..9f94c824cf86 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -38,9 +38,38 @@ static void iommufd_kernel_managed_hwpt_destroy(struct=
 iommufd_object *obj)
>  	refcount_dec(&hwpt->ioas->obj.users);
>  }
> =20
> +static struct hw_pgtable_fault *hw_pagetable_fault_alloc(void)
> +{
> +	struct hw_pgtable_fault *fault;
> +
> +	fault =3D kzalloc(sizeof(*fault), GFP_KERNEL);
> +	if (!fault)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&fault->deliver);
> +	INIT_LIST_HEAD(&fault->response);
> +	mutex_init(&fault->mutex);
> +
> +	return fault;
> +}
> +
> +static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
> +{
> +	WARN_ON(!list_empty(&fault->deliver));
> +	WARN_ON(!list_empty(&fault->response));
> +
> +	kfree(fault);
> +}
> +
>  void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
>  {
> -	container_of(obj, struct iommufd_hw_pagetable, obj)->destroy(obj);
> +	struct iommufd_hw_pagetable *hwpt =3D
> +		container_of(obj, struct iommufd_hw_pagetable, obj);
> +
> +	if (hwpt->fault)
> +		hw_pagetable_fault_free(hwpt->fault);
> +
> +	hwpt->destroy(obj);
>  }
> =20
>  static void iommufd_user_managed_hwpt_abort(struct iommufd_object *obj)
> @@ -289,6 +318,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
>  	return ERR_PTR(rc);
>  }
> =20
> +static int iommufd_hw_pagetable_iopf_handler(struct iopf_group *group)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D group->domain->fault_data;
> +
> +	mutex_lock(&hwpt->fault->mutex);
> +	list_add_tail(&group->node, &hwpt->fault->deliver);
> +	mutex_unlock(&hwpt->fault->mutex);
> +
> +	return 0;
> +}
> +
>  int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  {
>  	struct iommufd_hw_pagetable *(*alloc_fn)(
> @@ -364,6 +404,20 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		goto out_unlock;
>  	}
> =20
> +	if (cmd->flags & IOMMU_HWPT_ALLOC_IOPF_CAPABLE) {
> +		hwpt->fault =3D hw_pagetable_fault_alloc();
> +		if (IS_ERR(hwpt->fault)) {
> +			rc =3D PTR_ERR(hwpt->fault);
> +			hwpt->fault =3D NULL;
> +			goto out_hwpt;
> +		}
> +
> +		hwpt->fault->ictx =3D ucmd->ictx;
> +		hwpt->fault->hwpt =3D hwpt;
> +		hwpt->domain->iopf_handler =3D iommufd_hw_pagetable_iopf_handler;
> +		hwpt->domain->fault_data =3D hwpt;
> +	}
> +
>  	cmd->out_hwpt_id =3D hwpt->obj.id;
>  	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>  	if (rc)
> --=20
> 2.34.1
>=20

--=20

Joel Granados

--paapshyymo2eyrec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmV4W64ACgkQupfNUreW
QU8T+QwAhxeoC/seS4ueQ1BklBDrgoiCu/onlz5YZEPgdxDJP3xAw+j7sjzqYsgY
ROVMp5nqyjoYHOESkLSO1dIY0Ifqz0xYg2XARHFru69yvWS4O859qN8axgeiDTQ3
a7zW184TdbcuRUzXzXBWrZ6ddpS+EQm8mHtjuAoQESDx40Yc5QSURhXexQ6+rfog
ToWmxvzzdPKMx63k/gjTVFnZgw43x2aqCr5UTQliVZQBPbDYbmb/mCp1NEmELYqo
rQzJHKRJNcAs7HnPejndq90jwN6640xr1se6Sfk6jKAhoWOE9EkMPUAofrMQPAcT
vA7XAAV+G48C8g9BiM+9ugKfJMY/OcQ6OqkbxuqESz4wXevgVgsBqY9T71yoSqQB
ux2g98x955j1jkY8JxQ45VaNXN2e9N3vYIy8cthIxDxIqYuEIwSfqt++zzaeV+W2
uqizeq6nmd0WkUkgxNEWDywXuskxgn6GRsEb+3j+o+DuqOJQOgccPMadM7bfB17x
KoCNsBxP
=4je1
-----END PGP SIGNATURE-----

--paapshyymo2eyrec--

