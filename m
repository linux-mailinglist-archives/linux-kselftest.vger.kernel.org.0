Return-Path: <linux-kselftest+bounces-3012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F582DE99
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 18:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BA41C216C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841B1803D;
	Mon, 15 Jan 2024 17:44:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517B182A1;
	Mon, 15 Jan 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDKFZ6Xz5z6J9SV;
	Tue, 16 Jan 2024 01:41:38 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
	by mail.maildlp.com (Postfix) with ESMTPS id B08F6140594;
	Tue, 16 Jan 2024 01:44:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 17:44:13 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Mon, 15 Jan 2024 17:44:13 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Thread-Topic: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Thread-Index: AQHaB7erJOXV16DWQEa9TDH5jPoMHrDW7X2wgASoGYCAAA4dMA==
Date: Mon, 15 Jan 2024 17:44:13 +0000
Message-ID: <b1663110e1ca4301834f403270357bea@huawei.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
 <20240115164723.GB50608@ziepe.ca>
In-Reply-To: <20240115164723.GB50608@ziepe.ca>
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
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, January 15, 2024 4:47 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>; Kevin Tian <kevin.tian@intel.com=
>;
> Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
> Murphy <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-
> philippe@linaro.org>; Nicolin Chen <nicolinc@nvidia.com>; Yi Liu
> <yi.l.liu@intel.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>;
> iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
>=20
> On Fri, Jan 12, 2024 at 05:46:13PM +0000, Shameerali Kolothum Thodi wrote=
:
> >
> >
> > > -----Original Message-----
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, October 26, 2023 3:49 AM
> > > To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>=
;
> Joerg
> > > Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
> Murphy
> > > <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-
> philippe@linaro.org>;
> > > Nicolin Chen <nicolinc@nvidia.com>; Yi Liu <yi.l.liu@intel.com>; Jaco=
b
> Pan
> > > <jacob.jun.pan@linux.intel.com>
> > > Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.o=
rg;
> Lu
> > > Baolu <baolu.lu@linux.intel.com>
> > > Subject: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
> > >
> > [...]
> >
> > Hi,
> >
> > > +static ssize_t hwpt_fault_fops_write(struct file *filep,
> > > +				     const char __user *buf,
> > > +				     size_t count, loff_t *ppos)
> > > +{
> > > +	size_t response_size =3D sizeof(struct iommu_hwpt_page_response);
> > > +	struct hw_pgtable_fault *fault =3D filep->private_data;
> > > +	struct iommu_hwpt_page_response response;
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +	struct iopf_group *iter, *group;
> > > +	struct iommufd_device *idev;
> > > +	size_t done =3D 0;
> > > +	int rc =3D 0;
> > > +
> > > +	if (*ppos || count % response_size)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&fault->mutex);
> > > +	while (!list_empty(&fault->response) && count > done) {
> > > +		rc =3D copy_from_user(&response, buf + done, response_size);
> > > +		if (rc)
> > > +			break;
> > > +
> > > +		/* Get the device that this response targets at. */
> > > +		idev =3D container_of(iommufd_get_object(fault->ictx,
> > > +						       response.dev_id,
> > > +						       IOMMUFD_OBJ_DEVICE),
> > > +				    struct iommufd_device, obj);
> > > +		if (IS_ERR(idev)) {
> > > +			rc =3D PTR_ERR(idev);
> > > +			break;
> > > +		}
> > > +
> > > +		/*
> > > +		 * Get the hw page table that this response was generated
> for.
> > > +		 * It must match the one stored in the fault data.
> > > +		 */
> > > +		hwpt =3D container_of(iommufd_get_object(fault->ictx,
> > > +						       response.hwpt_id,
> > > +
> > > IOMMUFD_OBJ_HW_PAGETABLE),
> > > +				    struct iommufd_hw_pagetable, obj);
> > > +		if (IS_ERR(hwpt)) {
> > > +			iommufd_put_object(&idev->obj);
> > > +			rc =3D PTR_ERR(hwpt);
> > > +			break;
> > > +		}
> > > +
> > > +		if (hwpt !=3D fault->hwpt) {
> > > +			rc =3D -EINVAL;
> > > +			goto put_obj;
> > > +		}
> > > +
> > > +		group =3D NULL;
> > > +		list_for_each_entry(iter, &fault->response, node) {
> > > +			if (response.grpid !=3D iter->last_fault.fault.prm.grpid)
> > > +				continue;
> > > +
> > > +			if (idev->dev !=3D iter->dev)
> > > +				continue;
> > > +
> > > +			if ((iter->last_fault.fault.prm.flags &
> > > +			     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> &&
> > > +			    response.pasid !=3D iter->last_fault.fault.prm.pasid)
> > > +				continue;
> >
> > I am trying to get vSVA working with this series and got hit by the abo=
ve
> check.
> > On ARM platforms, page responses to stall events(CMD_RESUME) do not
> have
> > an associated pasid.  I think, either we need to check here using
> > IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID or remove the check
> > as it will be eventually done in iommu_page_response().
>=20
> That doesn't sound right..
>=20
> The PASID is the only information we have for userspace to identify
> the domain that is being faulted. It cannot be optional on the request
> side.
>=20

Yes, it is valid on the request side. But this is on the response side.

> If it is valid when userspace does read() then it should be valid when
> userspace does write() too.
>=20
> It is the only way the kernel can actually match request and response
> here.

The kernel currently checks the pasid only if IOMMU_FAULT_PAGE_RESPONSE_NEE=
DS_PASID
is set.

https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@l=
inaro.org/

> So, I think you have a userspace issue to not provide the right
> pasid??

This is not just ARM stall resume case, but for some PCI devices as well as=
 per
the above commit log. So do we really need to track this in userspace ?

Thanks,
Shameer

