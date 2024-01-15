Return-Path: <linux-kselftest+bounces-3007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB882DDDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBCB1F22537
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2417BCF;
	Mon, 15 Jan 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CXTf4ULA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030217BC5
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42987bc95ffso62273181cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705337244; x=1705942044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2crKgiTXcC8UeiyKNQE9cMBlk/o9KLy3IDkuGS6sULY=;
        b=CXTf4ULANBlsxZH7fNrB1jHo8dsybZRvmn/EjjxEh5KnfABZN9bZP0941evoYudrr9
         lXHtL/ZPsnc43eRgTP4YzRQWaeulBc7pZOrsSNUAwEYPLu23TM7kiHLPN1phL9Mk171o
         xNwq+psMRxKXTchZ1aAqJVYRntT+T+KE9WvWaF94GsuvaPJ8inFA6h29AwS3Lo5EwSRn
         xch7dkqd8KzQhYnO0PgwKVJXi+4HUIpeaLL6SkXDS59lKU1AZ4Lr6zBzidXrue+QzQqh
         075QbzLJARYzcaQg+rlLfRu2HBC4noVa8lH2UAvrSa8PYP06xMgqaYA4kRQUCtnx9g1Z
         r45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705337244; x=1705942044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2crKgiTXcC8UeiyKNQE9cMBlk/o9KLy3IDkuGS6sULY=;
        b=KF6vGJdzBLPJgW99J8KHVQxt1x3fbbrZnux8do6d8/l+hOUaiWf6Aq7SGPoSN7R7a7
         x+yYr6LOMkJs1XopYyf3IJ/cItqKmqv74WdgCr7K5oxgHghQuOS9lt+UctUyXg2R9JBU
         aiogrMHxPR7T3Sa7auiLOaeL7Z1z6N0YFI1GiRuAllvHuKEyzMTA9pI8qCJtJ+InBMhe
         UiKK0GtED0J5MkKVSzfiGQ36FogBWMpTZt6sZ9KmP7OMrB24x9JHN/zZncAw0Khc7Rzm
         O/wjqPLhk6jZQ9orssSBpgMM8IlnOq6CwD7SiPQ0lJsd8z0wl7gVSiQUn3DLr64stnGJ
         5ocA==
X-Gm-Message-State: AOJu0Yyd7CA4qRTsGlo8GEaP5e/cG6e6cS19xtSUVh00GXUYc16Z7Mht
	tGMPo7zCJty/Ztu7nAcLo48hTbKSmax2dw==
X-Google-Smtp-Source: AGHT+IHytem9ZiSpp/IMZZ23Px9ow/WDIS5U8JgImTeFhW9KwLcIg20JNrAqcGdlqr/VIaHDsAnzDg==
X-Received: by 2002:a05:622a:11ca:b0:429:ffda:679c with SMTP id n10-20020a05622a11ca00b00429ffda679cmr139180qtk.25.1705337244703;
        Mon, 15 Jan 2024 08:47:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id eh18-20020a05622a579200b00425b3fd33f2sm4023338qtb.90.2024.01.15.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:47:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPQ7P-003tM0-9N;
	Mon, 15 Jan 2024 12:47:23 -0400
Date: Mon, 15 Jan 2024 12:47:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Message-ID: <20240115164723.GB50608@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <b822096cc3b441309d99832c587be25a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b822096cc3b441309d99832c587be25a@huawei.com>

On Fri, Jan 12, 2024 at 05:46:13PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Thursday, October 26, 2023 3:49 AM
> > To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>; Joerg
> > Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> > <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> > Nicolin Chen <nicolinc@nvidia.com>; Yi Liu <yi.l.liu@intel.com>; Jacob Pan
> > <jacob.jun.pan@linux.intel.com>
> > Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Lu
> > Baolu <baolu.lu@linux.intel.com>
> > Subject: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
> > 
> [...]
> 
> Hi,
> 
> > +static ssize_t hwpt_fault_fops_write(struct file *filep,
> > +				     const char __user *buf,
> > +				     size_t count, loff_t *ppos)
> > +{
> > +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
> > +	struct hw_pgtable_fault *fault = filep->private_data;
> > +	struct iommu_hwpt_page_response response;
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iopf_group *iter, *group;
> > +	struct iommufd_device *idev;
> > +	size_t done = 0;
> > +	int rc = 0;
> > +
> > +	if (*ppos || count % response_size)
> > +		return -ESPIPE;
> > +
> > +	mutex_lock(&fault->mutex);
> > +	while (!list_empty(&fault->response) && count > done) {
> > +		rc = copy_from_user(&response, buf + done, response_size);
> > +		if (rc)
> > +			break;
> > +
> > +		/* Get the device that this response targets at. */
> > +		idev = container_of(iommufd_get_object(fault->ictx,
> > +						       response.dev_id,
> > +						       IOMMUFD_OBJ_DEVICE),
> > +				    struct iommufd_device, obj);
> > +		if (IS_ERR(idev)) {
> > +			rc = PTR_ERR(idev);
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * Get the hw page table that this response was generated for.
> > +		 * It must match the one stored in the fault data.
> > +		 */
> > +		hwpt = container_of(iommufd_get_object(fault->ictx,
> > +						       response.hwpt_id,
> > +
> > IOMMUFD_OBJ_HW_PAGETABLE),
> > +				    struct iommufd_hw_pagetable, obj);
> > +		if (IS_ERR(hwpt)) {
> > +			iommufd_put_object(&idev->obj);
> > +			rc = PTR_ERR(hwpt);
> > +			break;
> > +		}
> > +
> > +		if (hwpt != fault->hwpt) {
> > +			rc = -EINVAL;
> > +			goto put_obj;
> > +		}
> > +
> > +		group = NULL;
> > +		list_for_each_entry(iter, &fault->response, node) {
> > +			if (response.grpid != iter->last_fault.fault.prm.grpid)
> > +				continue;
> > +
> > +			if (idev->dev != iter->dev)
> > +				continue;
> > +
> > +			if ((iter->last_fault.fault.prm.flags &
> > +			     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
> > +			    response.pasid != iter->last_fault.fault.prm.pasid)
> > +				continue;
> 
> I am trying to get vSVA working with this series and got hit by the above check.
> On ARM platforms, page responses to stall events(CMD_RESUME) do not have
> an associated pasid.  I think, either we need to check here using
> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID or remove the check 
> as it will be eventually done in iommu_page_response(). 

That doesn't sound right..

The PASID is the only information we have for userspace to identify
the domain that is being faulted. It cannot be optional on the request
side.

If it is valid when userspace does read() then it should be valid when
userspace does write() too.

It is the only way the kernel can actually match request and response
here.

So, I think you have a userspace issue to not provide the right
pasid??

Jason

