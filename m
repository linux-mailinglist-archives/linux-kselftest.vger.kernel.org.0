Return-Path: <linux-kselftest+bounces-20995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015859B520C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E61C228E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C041DDA2D;
	Tue, 29 Oct 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZ5fWP8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AC2F56;
	Tue, 29 Oct 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227694; cv=fail; b=kxebh+NgS8ypSWfdFx3le+keMAahvEWjAe+m9Rkw3lPcMSeBRZRyIbuqqYQfNxDkZTzErl3Ec4IlB6jo6lgt/3gz32LbDzkSyCzzLrMWuilHX/7E/Ccs7OOVW/vIA2dCzNYe/MS0qxOr04PlTkJP9SQNlE+Nf5AWtT2gL5MKNOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227694; c=relaxed/simple;
	bh=fzA0eYafe7RG8dGTKpj1CxramSpmFC85y+oIuOQSkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odVBQSl7B0WCvKNSqcObRE4PkvicEF1XXTbAOaPm7zJZsc+cGqitFjwNTpRbqweAiFieH12s9iNTQm/D77DIURwPV7RGNvKfLEnjzFOjeiSdHXMinbI8ltlbH4fCIn5ZVHIt2VaOphIiZ4ezLke7snX5DIevzsF5FiHQPxsods8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZ5fWP8j; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA7Dhud7Zzli6ode14NEejW6y4TWcOa5dcLrIArqzTU7YO4ohSxmk9OuZlsFy2aTSzL8vFppuvnN1lofYq3Qjwj6SB53nTdcB+1YfH9S0NJyjB8VymdXtwx0tZs8JmSKCRQ/4o6VbLkwdgGgtpXU87lneobS8/oLg5qEDpZKNyRwxN+n3qjpdSk2yDx3Y5iEeJ65ChCkTFrqvXqlgbnd6VeggaaNIQtLT9iREaXKvewFndw9pnr34p5NZN9iLvkiObhJb9neILzatlnnnCgWtHZddJjTL4XKCHZlvsJjLfvY5cO67cEA2XR7FizBa/0vvUFnvh8NITmiFaXLe+Z1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWogyfmM8Oaqvd3nq/Bi239CFKoadaPEHMmfRUgAtA8=;
 b=Kcx8YIkwS6o3Optt//i1jRxOVFmKCWffgEWV8QtZsz1ruf+DCK2BxLDX13VGZxUhgxTFyJhW2I3Dry7mhGrsM8STdtEDf3WuIqMVFzbYBwj3I8B7o9HhyYdIJl6ikhevusYO90FvBNayTUD3Tpr1SBv/5QfOmt5c+uc2BJWeMq59QOqeZqxRQyarSh5riMuHGz0bmFcYGtXcGl49B5/VYpnaLZUhMMSs50OThIi4z+b8IPlA315QRkIvmyIVyxeHhCONZshOXDUCrds38KmfqB+y76WaG+Fg/ik/+fTB8A5Fliw/4Hr642DTLLeP2kvS2k5qNS3+hbhWvXH0R3uhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWogyfmM8Oaqvd3nq/Bi239CFKoadaPEHMmfRUgAtA8=;
 b=SZ5fWP8jOKwUXnt9ZRESRmavbw0kmx5JCP9KLeBWSeIyjXUPBz/b5Q+h5d4yUJwMyGKlDNlNVSMl1vx8smGs+ShADU5QRWff7x/1yteBoF5gGhRhhEmvZ02vfM5vj4hRrGs4ZXWxY8166erAONgmhaujD2dq01PMdUmiOhKq55yGRDGhlN2hLPtkmz/N3kRVBHZhPG8v6RTwC5gXb7dSJkeq+0+QM1zC5yRJY2oJfeXloD3LGCXiaSq4vuFy7ltCKRSO6y473mOW09jWwPbqAJrHF1SKMsAo9wcrFZwwlt0agkLAxqCkVmH+X5J0T5yKOUvhiY0pUMVcud+Bat2U1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 18:48:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 18:48:04 +0000
Date: Tue, 29 Oct 2024 15:48:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 01/13] iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and
 IOMMU_VDEVICE_ALLOC ioctl
Message-ID: <20241029184801.GW6956@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
 <20241029155824.GJ209124@nvidia.com>
 <ZyEblBMkvuq2rPAT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEblBMkvuq2rPAT@Asurada-Nvidia>
X-ClientProxiedBy: BN1PR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:408:e3::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c25f4c8-6b35-40a8-0b17-08dcf84a3878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZESqJ+LTEwkioVSvrujIbtWwHYLo+JJ0YafOFTynJzFyGwQ3Hgp7GXI9JkYa?=
 =?us-ascii?Q?VobiBybWNhb9yNI/lMwNW3gURBkl65rUl0SlkHbwcmWHQZtIkFpXgfJf5fmt?=
 =?us-ascii?Q?vGralxgA/X0ryXyS4OlV+A9uxXvs9s73imHBFzn2xQb7z5HgLL9Km5NC/TNh?=
 =?us-ascii?Q?q3bNplUgb2lJmoGdrh1wYoljxjXWK8BIQUFtes9B8cpp/vBLBmGExPgevJV2?=
 =?us-ascii?Q?o+Ttf7i7AjnnytGgtiFzQYexuCPn9O0V/yR/i+LmfI4DutoYDOwG8pYavyaW?=
 =?us-ascii?Q?S0eKtf+Xt7SZ6woPu8eNGZAE6vU2ZhYxCPwkCmGRUm2pZcvKf4MAEeWqlwpT?=
 =?us-ascii?Q?zE2sAp+HDubPgTMDqvmVkyBas/lBZ4SFjK/M9Pmn+EEo1hxfmVJ47SHXCCUZ?=
 =?us-ascii?Q?SZr7Uj+gQAaC8bJWXAtipmHY12z7VBlCK9/+kETq36Bx7rQLv6kwXYXUAxCl?=
 =?us-ascii?Q?DBbmiaCpvBZ8CFSZx39zMu00O+3BkeVpvOe0U2GlGeQ8I7hG8BJLafUI8CNr?=
 =?us-ascii?Q?73P/hUwfNjZIoRk8qLYwsC3nWneWOgVWykQtt5sA8CcG2cALEJDuhywtBT6y?=
 =?us-ascii?Q?C+z+rCqkRcU56adKY19wRsaaqgaqIvFMy883Wb6Jj3RyzaXZI0ipbn0xYYbs?=
 =?us-ascii?Q?MXLuYxe21DqRIqt2oa8VsZOjvgGG9CNQynw3u78VG31UQvlw3xbOtyCRZshz?=
 =?us-ascii?Q?Jc/lhWHNDzyxptu3V39/urGq+cBu83utvHur/97pN9LVAYlW6U7FMsXZbVSV?=
 =?us-ascii?Q?aFv96/9neTgbV0leLsiFLmryeWSgeGIwyhoHKqnK9mQjimgXeIoKgjTcRweH?=
 =?us-ascii?Q?FMFjPWnOYuHV4haY2NpY8iTFaoU1ZGHmBo58S1vuSI3MaNVNemiZjGDdc5xz?=
 =?us-ascii?Q?XlC1iFWwSRvgrhy+aQJfP8tXoR3jhlviMeXKkkZJxeXSFxbOViN73nh0HRpI?=
 =?us-ascii?Q?q4XJltB9taCcc97B71U0Oc1s8tGfWpcBi8tbVBhEPc/imIalDEaBEz7E9lzd?=
 =?us-ascii?Q?VIjNe1eyfZXp+er+BZiWZ6guhAOx3iV55ewW8pR/xnx0S60epitekqpJFvay?=
 =?us-ascii?Q?4L2ad9D2zWf9JV+fdIUJolzw/6oVHXuIZrH0ye9KMH4iAFXojjp5y5ORI5C6?=
 =?us-ascii?Q?8ZRu2qRNG6X1aHN7dtVdxl8868G1BzphhZKzGgq/W1cs0uMqnDxUNfvxlOu4?=
 =?us-ascii?Q?5MQGP7abGqs+mf9V19X6kDu0tf6MAMMpQp84/wMDEIDrXM0t0nUrqAA6hAxG?=
 =?us-ascii?Q?B/bUCY76LDFxNWCxZZtCHGa5Ojp87ZDnERbee7ipPKfbK/f6+SzO7guXHrzY?=
 =?us-ascii?Q?GBh89m1wLK5pmQ40a7g7vYQW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIXPEzD2sLMOsYbaybhSGurmzAD32LF8WnaS43I3rRAbn32lpTfQN8FpPoy0?=
 =?us-ascii?Q?zbXFYzZkaIjGGHM1C+rqGKaM8NETU+1zQZO/gjddlHImgb0/SIvQVnAvFfbK?=
 =?us-ascii?Q?gcp15rNuIZQzUJ1FGhAGFUdcaYJK7Dx7uPRADEUIjMzYKg/b5j0C1TFl1oO+?=
 =?us-ascii?Q?iF8yxy+RfPE9ymPvNGwL7ub5RyhEysMmXudPYwKeSHvQg1kD4CZt2gh7iOJW?=
 =?us-ascii?Q?5UTgxPpVaM1akjLyvcFLrU7bMc8WoN+cUFvW4vb63JCUrGj2XKHAh4vB77Cm?=
 =?us-ascii?Q?auX0KokO23xA69qPzVpmYe78CFrPZQw55Jisnucvnczg2D3FLFk8I2aBnlJV?=
 =?us-ascii?Q?vF19K1mApMzZpiwAB1yVKWyTRSBxMs3VSlwSlUCV12kH5SvnkCQjIsUkFffk?=
 =?us-ascii?Q?ddbIANU35LiI4y18Er15/vqZXlACPOZbHov3z2E0+V8yKQ+MDnAzUPfV2LwO?=
 =?us-ascii?Q?gyA5c3pENAWGTeAc0nUXcHmqTBljVthFYadP5Wq/o9X2S/G9MfJx++Zcgk4b?=
 =?us-ascii?Q?WXqTzoRk0i2SSI1Puhi+DVArpp3GzSSpqqCHohIjCG8uOQDM0oZYivBvPk+f?=
 =?us-ascii?Q?utolplPaDuFNvWbXuwsX+o+enrS7ghWpW81Lapr7GoLVDoDitYR60FwT0KYB?=
 =?us-ascii?Q?ItpmBBhvLHIFSAVb9puDTHj5y+CfVe2IEOMNlAlzp8iN1NUppcu5MJffZYGO?=
 =?us-ascii?Q?Hb8zqFRLF1htEIuUm9/ephlZ1wk18MSqX7r4KNRZ5nEpXo62TYXbFOT3Wuh8?=
 =?us-ascii?Q?y9VaQ6dovHVBqufHrmaL7+I61iblH8Ac1JWzXjPAhhX7mifLzr0CDwinW98Y?=
 =?us-ascii?Q?Js3E7/j9+vt8TTiJJqx0ACHozyZSukiDGQZJToPfh7TaMdTb8TnFtM4LDX4V?=
 =?us-ascii?Q?zOEmN7cB3bFsJanX00x81L8qxkO7qqaJULaX+QZE8iqJgj5Mjk7CzoKL3ciO?=
 =?us-ascii?Q?w9ViBn8r2bEOdXHZjvPxC7bQlbFFTZriIW1u5ndlr98LdT4j2ybzcWyveZRZ?=
 =?us-ascii?Q?ETIEF/xMjRct4Dh/lkN/jT8stzh9V/ayLamEljd/DxTXfSUkhYBs9uCD17Co?=
 =?us-ascii?Q?lulsSz7C0ieEe86J69BMprPpsJsZx/Atoi7q/kbSJwYh0p3H99IJrVh+3NgF?=
 =?us-ascii?Q?Wp/DX8mIm77WDkvuFHIJQPG6R3TIw7l5ozLXysvE4YcrMgTDYAO8gq+Tmnxc?=
 =?us-ascii?Q?n2KIiU24As+XliWqo7jEJHHNDfpyGaql6TgEFiVDQZf2FpD0n55D0h+Ot1Ew?=
 =?us-ascii?Q?8FiPChqCB5t/4v4jtUxFe0c1p8wmdQVv5/KxCAV2D3z40UWGvtyvEkxEVExX?=
 =?us-ascii?Q?6YcUXGyEIZRLLi/5oz/WRcWwVSgpMcrI1KXZ7CQRGay1s3omNlMvQzM5CnmG?=
 =?us-ascii?Q?nGyA+7jjrbcOyzTOEk6thmFTWlX0qUqjSEpbZEZbCwuRy6vMnGWDlUoHz/70?=
 =?us-ascii?Q?IFjU1fD9gIXAajLDlJqR5T68muoW5IQ02MgEbKOv+Ad5BGg/ReR6gZdFySRO?=
 =?us-ascii?Q?sSeZlJE8ZaEGtVtiFzs4QQALginNz070YbeBP4TPOX9an7WOewSKtws//+Cz?=
 =?us-ascii?Q?JFaN3b6j4l60RDgSDTE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c25f4c8-6b35-40a8-0b17-08dcf84a3878
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:48:04.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEYqvWr0KtVykakz7+Ke1IMOPSSmzgc7lRlJYuasnNepQzXNwldGqk0eh5nRsu5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

On Tue, Oct 29, 2024 at 10:29:56AM -0700, Nicolin Chen wrote:
> On Tue, Oct 29, 2024 at 12:58:24PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 25, 2024 at 04:50:30PM -0700, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > index 5fd3dd420290..e50113305a9c 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
> > >   */
> > >  void iommufd_device_unbind(struct iommufd_device *idev)
> > >  {
> > > +	u32 vdev_id = 0;
> > > +
> > > +	/* idev->vdev object should be destroyed prior, yet just in case.. */
> > > +	mutex_lock(&idev->igroup->lock);
> > > +	if (idev->vdev)
> > 
> > Then should it have a WARN_ON here?
> 
> It'd be a user space mistake that forgot to call the destroy ioctl
> to the object, in which case I recall kernel shouldn't WARN_ON?

But you can't get here because:

 	refcount_inc(&idev->obj.users);

And kernel doesn't destroy objects with elevated ref counts?


> > > +		vdev_id = idev->vdev->obj.id;
> > > +	mutex_unlock(&idev->igroup->lock);
> > > +	/* Relying on xa_lock against a race with iommufd_destroy() */
> > > +	if (vdev_id)
> > > +		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
> > 
> > That doesn't seem right, iommufd_object_remove() should never be used
> > to destroy an object that userspace created with an IOCTL, in fact
> > that just isn't allowed.
> 
> It was for our auto destroy feature. 

auto domains are "hidden" hwpts that are kernel managed. They are not
"userspace created".

"Usespace created" objects are ones that userspace is expected to call
destroy on.

If you destroy them behind the scenes in the kerenl then the objecd ID
can be reallocated for something else and when userspace does DESTROY
on the ID it thought was still allocated it will malfunction.

So, only userspace can destroy objects that userspace created.

> If user space forgot to destroy the object while trying to unplug
> the device from VM. This saves the day.

No, it should/does fail destroy of the VIOMMU object because the users
refcount is elevated.


> > Ugh, there is worse here, we can't hold a long term reference on a
> > kernel owned object:
> > 
> > 	idev->vdev = vdev;
> > 	refcount_inc(&idev->obj.users);
> > 
> > As it prevents the kernel from disconnecting it.
> 
> Hmm, mind elaborating? I think the iommufd_fops_release() would
> xa_for_each the object list that destroys the vdev object first
> then this idev (and viommu too)?

iommufd_device_unbind() can't fail, and if the object can't be
destroyed because it has an elevated long term refcount it WARN's:


	ret = iommufd_object_remove(ictx, obj, obj->id, REMOVE_WAIT_SHORTTERM);

	/*
	 * If there is a bug and we couldn't destroy the object then we did put
	 * back the caller's users refcount and will eventually try to free it
	 * again during close.
	 */
	WARN_ON(ret);

So you cannot take long term references on kernel owned objects. Only
userspace owned objects.


> OK. If user space forgot to destroy its vdev while unplugging the
> device, it would not be allowed to hotplug another device (or the
> same device) back to the same slot having the same RID, since the
> RID on the vIOMMU would be occupied by the undestroyed vdev.

Yes, that seems correct and obvious to me. Until the vdev is
explicitly destroyed the ID is in-use.

Good userspace should destroy the iommufd vDEVICE object before
closing the VFIO file descriptor.

If it doesn't, then the VDEVICE object remains even though the VFIO it
was linked to is gone.

Jason

