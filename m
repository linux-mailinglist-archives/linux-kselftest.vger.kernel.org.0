Return-Path: <linux-kselftest+bounces-46939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E3C9F066
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CEAA4E0194
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B71419A9;
	Wed,  3 Dec 2025 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="QWDOnEqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC37260D;
	Wed,  3 Dec 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764766543; cv=none; b=RF3kLHQLxOr/0qB2dwAt3wxmHiqh0ew5JvgD6gxu35yVzegIlxgytIa6DIAfeIwHGtQCvaMZu8u7ZOI+UzcIbeYE2JRp9UOD8fQGmBWzxbE/fg5eb8jZ22b6drN9YQQFI5cuShuKgNQDkS568USFIfCLbcJSX9HSvMCMqob5MqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764766543; c=relaxed/simple;
	bh=A67kbvF2gvs/0PbJlohrMN1IYAC9BkPaNJFQsQ1Cwmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G04f9txTXkwxJmvbfAE8KJb7Sv+EkGp96uVzbIz/oUKziRRSShhK1k6GOOFdfEGKSrD07yXXn4ikBC/nA8Z/LpUT+ETM4R/0qZACso2MYnlGg+opDQZz2LiOhtpxHnCciZtwFXC5c6e3uErNlWgtqGS1u6oZoLwwUNowQeAmh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=QWDOnEqy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B33Z2VV4182368;
	Wed, 3 Dec 2025 04:55:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=Jfct4EAJvCyhCvbDDprb
	kw35ReXHMdFtL/6WitwSITg=; b=QWDOnEqyR3OiImxSGcSXU89FTD5Xbv58oiAW
	KkVqppaz1iWaU2p1sTkP7OhHr2AgTbAcTPULysGnZBxGh9xwWCgBzUKsnltyzc5s
	1zX80gCG6EGTm2d6ZEQH3eyU1AwGdL0s/jvPtYfq58MG+tb2qFndDo4y7QfXkCLK
	zuLXQmDk1okfu9yZzRDyEyD2OlfRiLFhJ0gbsGHnOou5YKxiS+ZoAFXOBi7AUFzo
	kNiExMdgBnuI7Pqo49nB8umWgQdD3V/ap/ATBUJ/pgY0QuL3wlRfr2TO8nMX1azf
	eVBc0f3dmeROsMFkpVna1KTrKkKg39XsGKSRFbqZ/wwrzYAY/w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4atde52q3f-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Dec 2025 04:55:24 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 3 Dec 2025 12:55:17 +0000
Date: Wed, 3 Dec 2025 04:55:13 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>,
        Adithya Jayachandran
	<ajayachandra@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Jacob Pan
	<jacob.pan@linux.microsoft.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,
        Josh Hilke <jrhilke@google.com>, Kevin Tian
	<kevin.tian@intel.com>,
        <kvm@vger.kernel.org>, Leon Romanovsky
	<leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner
	<lukas@wunner.de>,
        Mike Rapoport <rppt@kernel.org>, Parav Pandit
	<parav@nvidia.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Philipp
 Stanner <pstanner@redhat.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Saeed
 Mahameed <saeedm@nvidia.com>,
        Samiullah Khawaja <skhawaja@google.com>,
        Shuah
 Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
        Vipin Sharma
	<vipinsh@google.com>, William Tu <witu@nvidia.com>,
        Yi Liu
	<yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
        Zhu Yanjun
	<yanjun.zhu@linux.dev>
Subject: Re: [PATCH 06/21] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-7-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251126193608.2678510-7-dmatlack@google.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEwMyBTYWx0ZWRfX+wfgkvof1LGR
 EOPqlstLZoEN1vuMttPOaZpsW7YDfwalJv/6wS5DMWDd8/K4YcaYVYziz5jvoduzsTHRwCQnAal
 BsiELT9k6B/Cp5eKkpzX8O+cvlsxPcIZdOhYt7IUTefOtoI5V4bFb0jsj7Xki5FKVQFU0z6OZD8
 SKUtwVbJpVuQOEosF1cpyUXhkoxAtJ3Oe1iny3dXolad607MOuWJixgmbR2xYvA568Dms4nBOBi
 4DFo2LKZrA3cUycOYJ/u8YOZ3un9Dqfs5nrONMXAOStac0/vNp902sDGEbC9HzTxchzOeGPVwPV
 qCphKGRiC+z84XiDHYueeIHTvvgB+hMt3JweVvRC5r5DFGp+giLfzyudLBqneLrMM9uSahKeKaE
 xf0VYkR5Z7ZwBTNn6WqieBi23UlitQ==
X-Proofpoint-GUID: R3PHzrqbtk3rjG9YYMn5Ya8cy_oQeVKP
X-Authority-Analysis: v=2.4 cv=a6c9NESF c=1 sm=1 tr=0 ts=6930333c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=fytXDJm0AeOLzV9KF_sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: R3PHzrqbtk3rjG9YYMn5Ya8cy_oQeVKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01

On Wed, Nov 26, 2025 at 07:35:53PM +0000, David Matlack wrote:
> From: Vipin Sharma <vipinsh@google.com>
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
>  {
> -	return -EOPNOTSUPP;
> +	struct vfio_pci_core_device_ser *ser;
> +	struct vfio_device *device;
> +	struct folio *folio;
> +	struct file *file;
> +	int ret;
> +
> +	folio = kho_restore_folio(args->serialized_data);
> +	if (!folio)
> +		return -ENOENT;

Should this be consistent with the behavior of pci_flb_retrieve() which panics
on failure? The short circuit failure paths which follow leak the folio,
which seems like a hygiene issue, but the practical significance is moot if
vfio_pci_liveupdate_retrieve() failure is catastrophic anyways?

> +
> +	ser = folio_address(folio);
> +
> +	device = vfio_find_device(ser, match_device);
> +	if (!device)
> +		return -ENODEV;
> +
> +	/*
> +	 * During a Live Update userspace retrieves preserved VFIO cdev files by
> +	 * issuing an ioctl on /dev/liveupdate rather than by opening VFIO
> +	 * character devices.
> +	 *
> +	 * To handle that scenario, this routine simulates opening the VFIO
> +	 * character device for userspace with an anonymous inode. The returned
> +	 * file has the same properties as a cdev file (e.g. operations are
> +	 * blocked until BIND_IOMMUFD is called), aside from the inode
> +	 * association.
> +	 */
> +	file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> +					&vfio_device_fops, NULL,
> +					O_RDWR, FMODE_PREAD | FMODE_PWRITE);
> +
> +	if (IS_ERR(file)) {
> +		ret = PTR_ERR(file);
> +		goto out;
> +	}
> +
> +	ret = __vfio_device_fops_cdev_open(device, file);
> +	if (ret) {
> +		fput(file);
> +		goto out;
> +	}
> +
> +	args->file = file;
> +
> +out:
> +	/* Drop the reference from vfio_find_device() */
> +	put_device(&device->device);
> +
> +	return ret;
> +}

