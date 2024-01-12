Return-Path: <linux-kselftest+bounces-2921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0C82C4FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75D51F21B4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30BA175B7;
	Fri, 12 Jan 2024 17:46:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200817C81;
	Fri, 12 Jan 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBTRS1S4Bz6J9YF;
	Sat, 13 Jan 2024 01:43:48 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 30698140B2F;
	Sat, 13 Jan 2024 01:46:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 17:46:13 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Fri, 12 Jan 2024 17:46:13 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Kevin Tian" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, Yi
 Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Thread-Topic: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Thread-Index: AQHaB7erJOXV16DWQEa9TDH5jPoMHrDW7X2w
Date: Fri, 12 Jan 2024 17:46:13 +0000
Message-ID: <b822096cc3b441309d99832c587be25a@huawei.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
In-Reply-To: <20231026024930.382898-5-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, October 26, 2023 3:49 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>; Jo=
erg
> Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> Nicolin Chen <nicolinc@nvidia.com>; Yi Liu <yi.l.liu@intel.com>; Jacob Pa=
n
> <jacob.jun.pan@linux.intel.com>
> Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; =
Lu
> Baolu <baolu.lu@linux.intel.com>
> Subject: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
>=20
[...]

Hi,

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
> +
> IOMMUFD_OBJ_HW_PAGETABLE),
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

I am trying to get vSVA working with this series and got hit by the above c=
heck.
On ARM platforms, page responses to stall events(CMD_RESUME) do not have
an associated pasid.  I think, either we need to check here using
IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID or remove the check=20
as it will be eventually done in iommu_page_response().=20

Thanks,
Shameer


