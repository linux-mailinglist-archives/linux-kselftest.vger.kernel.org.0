Return-Path: <linux-kselftest+bounces-1369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E959808D76
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 17:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818951C20A23
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C94174F;
	Thu,  7 Dec 2023 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VhYYKIWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081212D;
	Thu,  7 Dec 2023 08:34:15 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231207163413euoutp0279de2e085bb1441180e627a0b8002936~emdX6IhAB1719117191euoutp02M;
	Thu,  7 Dec 2023 16:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231207163413euoutp0279de2e085bb1441180e627a0b8002936~emdX6IhAB1719117191euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701966853;
	bh=nn6jn19KtGOVkHJwOYqRT+AyYpXASL1MfX7r8o4hm4c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VhYYKIWqTOxOu+yXXvbxzvwx0kN3dhi241xucEIiWgErIBCU2JoQJbBtjh6b4i0CT
	 Nd/BAq8aGpEVFA47umvkHZ525mLM4+KNU3lQ66tCm1nT9aB85k87mNJAqT7INrZosb
	 p0TYuhszwiUDcfJPucMwdESL8hk1Q5UpOLi4zaz0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231207163413eucas1p20ff921c258c513b930001947f0e8525d~emdXhh0LB2821528215eucas1p2Y;
	Thu,  7 Dec 2023 16:34:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9D.CC.09539.404F1756; Thu,  7
	Dec 2023 16:34:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7~emdW-BSQe1347013470eucas1p29;
	Thu,  7 Dec 2023 16:34:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207163412eusmtrp134a8a9ae626c4930acb169bd2b2b584f~emdW_OzR11775617756eusmtrp1Z;
	Thu,  7 Dec 2023 16:34:12 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-a7-6571f4041aca
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.86.09274.404F1756; Thu,  7
	Dec 2023 16:34:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207163412eusmtip2b7f0bd60ffac208f6ccdfa6bfd192e00~emdWwikJX2375423754eusmtip2G;
	Thu,  7 Dec 2023 16:34:12 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 16:34:11 +0000
Date: Thu, 7 Dec 2023 17:34:10 +0100
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20231207163410.ap3w4faii6wkgwed@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="o63jdwrj6qj2d4lk"
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZduznOV2WL4WpBjdvW1tsnriVzeLXFwuL
	pQfXs1g0rL7AajFzxglGi87ZG9gtlr7dym5xedccNovpd96zWex9+pjN4uCHJ6wWy8/OY7No
	uWNqMffnNRYHPo8nB+cxeayZt4bRY/Gel0wem1Z1snncubaHzWPeyUCPyTeWM3q82DyT0aO3
	+R2bx+dNch5bP99mCeCO4rJJSc3JLEst0rdL4MqYPmk7e8Hq8Ir+5+1sDYyr3LoYOTkkBEwk
	Ts7/y9rFyMUhJLCCUWJOw3NGCOcLo8Ss9v3sEM5nRomDXz6zwLQsPHyQBSKxnFHiwcrpjHBV
	D//PgMpsZpRoWt7DBtLCIqAiseDYbyYQm01AR+L8mzvMXYwcHCIC6hLPvgSA1DML3GGWOPXi
	HitIjbCAp8SXa7PAbF4Bc4l9Ty5C2YISJ2c+ATuDWaBCYvHPd+wgc5gFpCWW/+MACXMK2Evs
	ObIO6lIlicOTPzND2LUSp7bcYgLZJSHwjVNi0qyVrBAJF4ntPauhGoQlXh3fwg5hy0icntzD
	AtEwmVFi/78P7BDOakaJZY1fmSCqrCVarjyB6nCU+LToMxvIRRICfBI33gpCHMonMWnbdGaI
	MK9ER5sQRLWaxOp7b1gmMCrPQvLaLCSvzUJ4DSKsI7Fg9yc2DGFtiWULXzND2LYS69a9Z1nA
	yL6KUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMJWe/nf80w7Gua8+6h1iZOJgPMSoAtT8
	aMPqC4xSLHn5ealKIrw55/NThXhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqem
	FqQWwWSZODilGpiC422e6k6a8+XFBdPLbbend83MTIyQzL+Z0x9+2/XTqcjDJVMVue1Nrh30
	9vT3y/euFjAWfJYlpn/p7LPw9IyM0F9fkru/TF+0V/X2px/XdOeFf71k5crJVhe788TDo/7X
	p0X82Co++X327zkz2Fun/fu33jNaaJvO9LTdp9i9Xyixzgq6lhWg+uHXciHfpcxc9VI5gTH/
	NKdPfrZM9enR2yUTrivy7RUMYtjseKbj/N+jZ3fIHzOMrXhbu+n0da+6S2E1Ctq31ri+fzQx
	c8mEuZNOf5U8dLLDUO3ZvP9nA/+IaTd0nvrIFLT9o9bENaoLui9fOtz+ylpG9YWDtWPQb5fn
	UQ/rNNlty7nS33p6KbEUZyQaajEXFScCAHtnLcogBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsVy+t/xe7osXwpTDc4vELfYPHErm8WvLxYW
	Sw+uZ7FoWH2B1WLmjBOMFp2zN7BbLH27ld3i8q45bBbT77xns9j79DGbxcEPT1gtlp+dx2bR
	csfUYu7PaywOfB5PDs5j8lgzbw2jx+I9L5k8Nq3qZPO4c20Pm8e8k4Eek28sZ/R4sXkmo0dv
	8zs2j8+b5Dy2fr7NEsAdpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJcx6+dhxoKV4RXvuzcyNzCucOti5OSQEDCRWHj4IEsXIxeHkMBSRomj9z6z
	QiRkJDZ+uQplC0v8udbFBlH0kVHi8okvjBDOZkaJEw+7mECqWARUJBYc+w1mswnoSJx/c4e5
	i5GDQ0RAXeLZlwCQemaBO8wSB3/sZgGpERbwlPhybRbYBl4Bc4l9Ty6ygtQLCRRLTJuRAhEW
	lDg58wlYObNAmcSMv7fBSpgFpCWW/+MACXMK2EvsObKOBeJOJYnDkz8zQ9i1Ep//PmOcwCg8
	C8mkWUgmzUKYBBHWkrjx7yUThrC2xLKFr5khbFuJdevesyxgZF/FKJJaWpybnltspFecmFtc
	mpeul5yfu4kRmEq2Hfu5ZQfjylcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQlEd6c8/mpQrwp
	iZVVqUX58UWlOanFhxhNgWE4kVlKNDkfmOTySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
	UrNTUwtSi2D6mDg4pRqYVmuv3poWXb3Uo8Dgf5X0nMucr4rtj5/5MHXf1Llq9ufNb8WZd52y
	NLNJXb9Tca70invxzyN4jWOZX7Ur75yVLhjl8Up90Y0jBjszjV7eFFA/xKK1vNXIzm/9Z825
	k+/Ylq18tPTLlrKLP21ZjtUb3o6qksh7ZMTo1q5o5c6QWHcidJfQnnesM6TmnhV6vJnBsN16
	dcelGfwf3ikve7uuQ+7xbSX/GevnuL8uKH4l8SRPsNJ+hvaGzZkNQSGCpx2f8TktDZn2LX37
	zNkr59ZFO5+dE73bSS2RI/mM2vrybwv3Mgh4Swt3drPesnxw5vAW/+wpM95PKX5Rbxl17fZS
	hteHHy3yWJGRFzXnzoRFqkosxRmJhlrMRcWJAFOykcS6AwAA
X-CMS-MailID: 20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7
X-Msg-Generator: CA
X-RootMTR: 20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
	<20231026024930.382898-5-baolu.lu@linux.intel.com>
	<CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>

--o63jdwrj6qj2d4lk
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:49:28AM +0800, Lu Baolu wrote:
> Add the file interface that provides a simple and efficient way for
> userspace to handle page faults. The file interface allows userspace
> to read fault messages sequentially, and to respond to the handling
> result by writing to the same file.
>=20
> Userspace applications are recommended to use io_uring to speed up read
> and write efficiency.
>=20
> With this done, allow userspace application to allocate a hw page table
> with IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag set.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |   2 +
>  drivers/iommu/iommufd/hw_pagetable.c    | 204 +++++++++++++++++++++++-
>  2 files changed, 205 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iomm=
ufd/iommufd_private.h
> index 0dbaa2dc5b22..ff063bc48150 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -237,6 +237,8 @@ struct hw_pgtable_fault {
>  	struct mutex mutex;
>  	struct list_head deliver;
>  	struct list_head response;
> +	struct file *fault_file;
> +	int fault_fd;
>  };
> =20
>  /*
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd=
/hw_pagetable.c
> index 9f94c824cf86..f0aac1bb2d2d 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -3,6 +3,8 @@
>   * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>   */
>  #include <linux/iommu.h>
> +#include <linux/file.h>
> +#include <linux/anon_inodes.h>
>  #include <uapi/linux/iommufd.h>
> =20
>  #include "../iommu-priv.h"
> @@ -38,9 +40,198 @@ static void iommufd_kernel_managed_hwpt_destroy(struc=
t iommufd_object *obj)
>  	refcount_dec(&hwpt->ioas->obj.users);
>  }
> =20
> +static int iommufd_compose_fault_message(struct iommu_fault *fault,
> +					 struct iommu_hwpt_pgfault *hwpt_fault,
> +					 struct device *dev)
> +{
> +	struct iommufd_device *idev =3D iopf_pasid_cookie_get(dev, IOMMU_NO_PAS=
ID);
> +
> +	if (!idev)
> +		return -ENODEV;
> +
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	hwpt_fault->size =3D sizeof(*hwpt_fault);
> +	hwpt_fault->flags =3D fault->prm.flags;
> +	hwpt_fault->dev_id =3D idev->obj.id;
> +	hwpt_fault->pasid =3D fault->prm.pasid;
> +	hwpt_fault->grpid =3D fault->prm.grpid;
> +	hwpt_fault->perm =3D fault->prm.perm;
> +	hwpt_fault->addr =3D fault->prm.addr;
> +	hwpt_fault->private_data[0] =3D fault->prm.private_data[0];
> +	hwpt_fault->private_data[1] =3D fault->prm.private_data[1];
> +
> +	return 0;
> +}
> +
> +static ssize_t hwpt_fault_fops_read(struct file *filep, char __user *buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	size_t fault_size =3D sizeof(struct iommu_hwpt_pgfault);
> +	struct hw_pgtable_fault *fault =3D filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done =3D 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group =3D list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;
> +
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			rc =3D iommufd_compose_fault_message(&iopf->fault,
> +							   &data, group->dev);
> +			if (rc)
> +				goto err_unlock;
> +			rc =3D copy_to_user(buf + done, &data, fault_size);
> +			if (rc)
> +				goto err_unlock;
> +			done +=3D fault_size;
> +		}
> +
> +		list_move_tail(&group->node, &fault->response);
> +	}
> +	mutex_unlock(&fault->mutex);
> +
> +	return done;
> +err_unlock:
> +	mutex_unlock(&fault->mutex);
> +	return rc;
> +}
> +
> +static ssize_t hwpt_fault_fops_write(struct file *filep,
> +				     const char __user *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	size_t response_size =3D sizeof(struct iommu_hwpt_page_response);
> +	struct hw_pgtable_fault *fault =3D filep->private_data;
> +	struct iommu_hwpt_page_response response;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iopf_group *iter, *group;
> +	struct iommufd_device *idev;
> +	size_t done =3D 0;
> +	int rc =3D 0;
> +
> +	if (*ppos || count % response_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->response) && count > done) {
> +		rc =3D copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		/* Get the device that this response targets at. */
> +		idev =3D container_of(iommufd_get_object(fault->ictx,
> +						       response.dev_id,
> +						       IOMMUFD_OBJ_DEVICE),
> +				    struct iommufd_device, obj);
> +		if (IS_ERR(idev)) {
> +			rc =3D PTR_ERR(idev);
> +			break;
> +		}
> +
> +		/*
> +		 * Get the hw page table that this response was generated for.
> +		 * It must match the one stored in the fault data.
> +		 */
> +		hwpt =3D container_of(iommufd_get_object(fault->ictx,
> +						       response.hwpt_id,
> +						       IOMMUFD_OBJ_HW_PAGETABLE),
> +				    struct iommufd_hw_pagetable, obj);
> +		if (IS_ERR(hwpt)) {
> +			iommufd_put_object(&idev->obj);
> +			rc =3D PTR_ERR(hwpt);
> +			break;
> +		}
> +
> +		if (hwpt !=3D fault->hwpt) {
> +			rc =3D -EINVAL;
> +			goto put_obj;
> +		}
> +
> +		group =3D NULL;
> +		list_for_each_entry(iter, &fault->response, node) {
> +			if (response.grpid !=3D iter->last_fault.fault.prm.grpid)
> +				continue;
> +
> +			if (idev->dev !=3D iter->dev)
> +				continue;
> +
> +			if ((iter->last_fault.fault.prm.flags &
> +			     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
> +			    response.pasid !=3D iter->last_fault.fault.prm.pasid)
> +				continue;
> +
> +			group =3D iter;
> +			break;
> +		}
> +
> +		if (!group) {
> +			rc =3D -ENODEV;
> +			goto put_obj;
> +		}
> +
> +		rc =3D iopf_group_response(group, response.code);
> +		if (rc)
> +			goto put_obj;
> +
> +		list_del(&group->node);
> +		iopf_free_group(group);
> +		done +=3D response_size;
> +put_obj:
> +		iommufd_put_object(&hwpt->obj);
> +		iommufd_put_object(&idev->obj);
> +		if (rc)
> +			break;
> +	}
> +	mutex_unlock(&fault->mutex);
> +
> +	return (rc < 0) ? rc : done;
> +}
> +
> +static const struct file_operations hwpt_fault_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.read		=3D hwpt_fault_fops_read,
> +	.write		=3D hwpt_fault_fops_write,
> +};
> +
> +static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
> +{
> +	struct file *filep;
> +	int fdno;
> +
> +	fdno =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0)
> +		return fdno;
> +
> +	filep =3D anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
> +				   fault, O_RDWR);
> +	if (IS_ERR(filep)) {
> +		put_unused_fd(fdno);
> +		return PTR_ERR(filep);
> +	}
> +
> +	fd_install(fdno, filep);
> +	fault->fault_file =3D filep;
> +	fault->fault_fd =3D fdno;
> +
> +	return 0;
> +}
> +
>  static struct hw_pgtable_fault *hw_pagetable_fault_alloc(void)
>  {
>  	struct hw_pgtable_fault *fault;
> +	int rc;
> =20
>  	fault =3D kzalloc(sizeof(*fault), GFP_KERNEL);
>  	if (!fault)
> @@ -50,6 +241,12 @@ static struct hw_pgtable_fault *hw_pagetable_fault_al=
loc(void)
>  	INIT_LIST_HEAD(&fault->response);
>  	mutex_init(&fault->mutex);
> =20
> +	rc =3D hw_pagetable_get_fault_fd(fault);
> +	if (rc) {
> +		kfree(fault);
> +		return ERR_PTR(rc);
> +	}
> +
>  	return fault;
>  }
> =20
> @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_=
fault *fault)
>  	WARN_ON(!list_empty(&fault->deliver));
>  	WARN_ON(!list_empty(&fault->response));
> =20
> +	fput(fault->fault_file);
> +	put_unused_fd(fault->fault_fd);
I have been running your code and have run into some invalid memory in
this line. When `put_unused_fd` is called the files of the current task
is accessed with `current->files`. In my case this is 0x0.

The reason for it being 0x0 is that `do_exit` calls `exit_files` where
the task files get set to NULL; this call is made in `do_exit` before we
execute `exit_task_work`.

'exit_task_work` is the call that eventually arrives here to `hw_pagetable_=
fault_free`.

The way I have arrived to this state is the following:
1. Version of linux kernel that I'm using : commit 357b5abcba0477f7f1391dd0=
fa3a919a6f06bdf0 (HEAD, lubaolu/iommufd-io-pgfault-delivery-v2)
2. Version of qemu that Im using : commit 577ef478780597d3f449feb01e853b93f=
a5c5530 (HEAD, yiliu/zhenzhong/wip/iommufd_nesting_rfcv1)
3. This error happens when my user space app is exiting. (hence the call
   to `do_exit`
4. I call the IOMMU_HWPT_ALLOC ioctl with
  .flags =3D IOMMU_HWPT_ALLOC_IOPF_CAPABLE and=20
  .hwpt_type =3D IOMMU_HWPT_TYPE_DEFAULT
  .pt_id =3D the default ioas id.

I have resolved this in a naive way by just not calling the
put_unused_fd function.

Have you run into this? Is this a path that you were expecting?
Also, please get back to me if you need more information about how I got
to this place. I have provided what I think is enough info, but I might
be missing something obvious.

Best

>  	kfree(fault);
>  }
> =20
> @@ -347,7 +546,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  	struct mutex *mutex;
>  	int rc;
> =20
> -	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
> +	if ((cmd->flags & ~(IOMMU_HWPT_ALLOC_NEST_PARENT |
> +			    IOMMU_HWPT_ALLOC_IOPF_CAPABLE)) ||
> +	    cmd->__reserved)
>  		return -EOPNOTSUPP;
>  	if (!cmd->data_len && cmd->hwpt_type !=3D IOMMU_HWPT_TYPE_DEFAULT)
>  		return -EINVAL;
> @@ -416,6 +617,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		hwpt->fault->hwpt =3D hwpt;
>  		hwpt->domain->iopf_handler =3D iommufd_hw_pagetable_iopf_handler;
>  		hwpt->domain->fault_data =3D hwpt;
> +		cmd->out_fault_fd =3D hwpt->fault->fault_fd;
>  	}
> =20
>  	cmd->out_hwpt_id =3D hwpt->obj.id;
> --=20
> 2.34.1
>=20

--=20

Joel Granados

--o63jdwrj6qj2d4lk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVx9AAACgkQupfNUreW
QU9RlgwAj5is2oXSVp8Xie0QFxlEtXICxKaEZu8KHaniwAHQyUUw6TKTh9sOFfq7
+3xdfSZ14aQMHo44LKIXm3XjuVjOcFN99CzFWAqRH50bCD8xxBrSCymlmoaW6Ay8
xoOsGquPD9uIIWmNmUZGzSZvrFn7PyVEkRdu0pKQ6xQdDIV9TZT0wxCor0gxW+vV
ecxPBbR86NNmRpw5nxYdloUMmAU04hUavVstm4Ois3Wr2D2axyOiKleE72c581+l
H7/yUOC1/jbmRxgUwUjbRSnlkQ7bpaKWtHX+lmVjUSdsob0N67wzrijWSobOIT3J
yF9P58nzWAgUYJdFf1lcp1VY+iUPQEl6IVGygOO7w5gbnB91fmC4zk0xQTN0y3ax
gp7YsKCCzbqlnMlrnOm4W2AOeelUlxX/E1MLOJ89QLCVdESJWoSpjQJRLA2J273V
TW5OYCP95hGOCzntYqb35XRob16ZuSj1TJRloOhMjGD1Nccc7WpErY2+sqWn8XBD
7PrAoGeZ
=2R+o
-----END PGP SIGNATURE-----

--o63jdwrj6qj2d4lk--

