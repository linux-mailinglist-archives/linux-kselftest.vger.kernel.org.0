Return-Path: <linux-kselftest+bounces-20978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606399B4EB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CAF2883B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F8195FE3;
	Tue, 29 Oct 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3QB93yx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02041917F9;
	Tue, 29 Oct 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217512; cv=fail; b=PqyNEBs7yOC+UOAhlbyriJmh1P9BxwX9LoqHwlu7ZKtHoYxfCWPjT7B7HzFz7WI7i2E+wx0VloBzmo9YoBG14LFEvWuxnGxx3MC/PT9cgo9JHvHmfiHXCx53bOYx1bZHYgntGbQzy14Ko9Ho5tU1FNX9R0D8U5wagDvwHeaeyuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217512; c=relaxed/simple;
	bh=iMjfTzqNQ01AQnUJSvGAAjGQsiV+gccwEMQM7AvUVKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJo+/QqUpDRwnau6BZH+Yg341cxQ9QvfTHAoF9Lo/09rzx0l1kMgtKK/Bh0mUQ4Gt4fPsKtG8psSy28Um2jyKBw1jP8MjysZfN7f4X3769WefO8+ydjcNW84rPxeJopzxj9eqKoEcaxIpy2YQ8BUn65+ltdQk+Ey5hsiIIsOtc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3QB93yx; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5e7Lgna+QqYUVFnqNyHsgtjB+36yk55G+Sx+kpyWl3F083H5QtPBccpgX8o2rFBNLBXftFFTUeBrPoJ410w2L9c8J/dfPaCBDzJPF5/Fj3b7QZs1rCklFIxqBQDRWQQDzHBJeqIQGxBv97Ay0OECQqPSRjKBmdpo+gW1wULWlb4NVNo8NZCuphZOiJkmClb5CrZMDfMIH/thl55HDvzP397L2kV0avS5Uc7aNjbyseVVhLuSrbBeeRXL9rt56/XZRLM7kF5Ai63GaOHLUo9qzruXVSIzAebZzNZGxIcO+2QqxhPN8QZkVnFThT9zsTMkuGYFsnFuoHHLJjPUCJhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Pb50ul+Z1Xs2yi7Sc0Kdvwsp7+oKmKpstOm0rxmIj0=;
 b=scDYczWQLiTMnKW4WXIQm0EfOzDXs6hQk7YWb6+5Ew+OUhutPqP9NFJls6R66cOdD6q1YLRDzFr6phyf9WTvpcPjdisY4osM9Io/4+Dbv2KtUS4FePiKny5m/0bWzSr/Z5PLo730CJaMwgPwH//gIEavSOfp444VLPF4PuPgDTNsigPv/j/1x+hmQnpnngFKHmTqwfgrEOmPVd0pliwJh9Lamy/MogD1vm2489SspMhIxI3aNF8EVh+tMSBLCMzjGowoqx67hqLHGBK0Z6y15Nt5HxgWd/QOf43Qo23NVJOl9KSfXQi0BFNLuHu0BSJVE0vI5gXpWpmRMMIl3dOlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pb50ul+Z1Xs2yi7Sc0Kdvwsp7+oKmKpstOm0rxmIj0=;
 b=M3QB93yxkZ4UYGYDQfUEjQRSQDn7t4qREoyJJkXwY/lsXDvR8Mc4hL8D4BRZ+yvRTr466L1/k3vgqUM9xgN2QkIKgiez7c08BcB0rHtWjpMnH+DyvDHEqjPb9/evr2kmBJBeHshLd/2m9nN8819nwc9lLi2dOa++eVRhnlJGxW/PXI4WEWgrDVCnL4BpVsldmFsUYeBNOkxaaisssbcSPrrjANHItFBFQTQeG7m/8nXtbWCs2Dj+atbguLhRk55I7361tXpfd3fBLvxaI1wy9L79YylT+wG5rBUhqQ0iYfDXLgtkRDnib2SQeIC5xA34/ihXJ89Hh6+fToT7HkI0ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 15:58:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:58:25 +0000
Date: Tue, 29 Oct 2024 12:58:24 -0300
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
Message-ID: <20241029155824.GJ209124@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:408:fc::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: c46c3fdb-5495-4112-0adf-08dcf8328586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S00Y4De2y2KfrKfbKUmQlDdrR3Lydsl8Po+rKo7GeggYLUOZrZwgYZYKvVm+?=
 =?us-ascii?Q?7w3JOWkFeQQAPMqF79+VHXPtzZbzLr4apXfxJTUf8031IPHeLnHnWlz0v/B+?=
 =?us-ascii?Q?v+JHqPTcsBViBK/YTLeSVZeVhDFNOPIPcB/B69VBIUp/ozUFQTyb4AGTDF9A?=
 =?us-ascii?Q?mPz4HEqtA0FpI+pA+0dCaDj1DkO6LOSpJIsHmv204RbmmOVzdEf0idQjX5qw?=
 =?us-ascii?Q?/mZOUOzw1/P+qbyfU/va3YqW7Fh4DdgKAoxyOBxuD0g5Yu+pN0pBH8FWjmEv?=
 =?us-ascii?Q?Zrx4JHCcAfsGFmacwLJKoBCRx593DFXRJFQ1s88Fx6XHqX0VW4oT4sOX3939?=
 =?us-ascii?Q?E6Vlq0pIuBzDdHounk0sAq1bkZnKQ0eCVFSbcLiGWAbjHanAiFveKzXtmAOh?=
 =?us-ascii?Q?dTK197CbdKywlBarQOG01f0bctsvX2mkT2ywLfXhieVx5sfFxXRFwbxIAqZt?=
 =?us-ascii?Q?Z8t2oFE972IQVeq9Yn63qwwULBTGht/hEkPUKFK5nmuK7Fi25pjHRrIyA+Cw?=
 =?us-ascii?Q?/9B1rt2RyDSXF3UkLydOCA99RfkbtUyizR1ck4Lfsh6LqN9auPhtGNZ8B1Om?=
 =?us-ascii?Q?sI/Mvt5ThWhAYzxFjT5rNvC0NcmZAKZ0UnQDMETuYvblFfy77D5n1gKXXROr?=
 =?us-ascii?Q?YELvTl8/cfI0YM6eOKKrdienuNhHwMBQPspWHYlYQrWKtJM+l45mBa7SRlRQ?=
 =?us-ascii?Q?d202eZJl5hF2aPDB92aKdS7ZzM/E94s5TNcCnG0Ya4xRVIsiLKWFVZ30VVVZ?=
 =?us-ascii?Q?ficC8SR1uWUBUcdoNE8O1pJsTzEhVDtAgTSNECUuiVr0U7m0JZ9FmHcBF353?=
 =?us-ascii?Q?P4ljIvM9PCoYhSuu00+36DzvoR9yMMz3r+2qAj1BKQNXzcU6pCHdDbR6aAzz?=
 =?us-ascii?Q?p+4DPj3cJ3DO5PzKSje3dWGWIwkoQJOmSpnUJgPs8EFz7+lJ6MJzbRf+ZWtl?=
 =?us-ascii?Q?1tqelwvsXYDYFuWw+8QFHEwW0AkNWyA+ZfoYs425v77DewOFpplXj20nK9r8?=
 =?us-ascii?Q?8yaSzZ9QMC1ByYoTc7TU3UhxLvsDZqMB5oKWfKKH6+hOH/q1GePw2vGUBo/m?=
 =?us-ascii?Q?FW2uwXAovlcvjHbHcyL7ZVfhT4F+3iF/bSIhlJyEMCm/G2PlWA3GinEWKF4h?=
 =?us-ascii?Q?phJVEKkZ+PVWIUEzzFaFmLrHXo4mbook3ESB/+jxN1HSyy3UD1DEeMAylM75?=
 =?us-ascii?Q?yOtYCHkpFPq0PhFYrS+qdSiH/bpHllJKR2vOG27cn+UzyEGdk7qa2qJU9JcZ?=
 =?us-ascii?Q?AnLtT4HB3an9BxxPnD+gDN9yfHCwAslsl2/oeviQI/7qzMpni8IkJU6lmy2r?=
 =?us-ascii?Q?bbnOXI9T+PqwJkSRFTn23mNh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kt0x7IxOzjhhrH1zmXS22HxPVlD+457ToaKPYweFjxClw1lm+yhSqkf6Omnl?=
 =?us-ascii?Q?pIJyKmtRL5p4VYfN9xQ+qlGodW560sATymmZhDq0J/DIyxKVGbhx44BV/yyr?=
 =?us-ascii?Q?J5/Vil/NNdt7FHDWpy7/wq++bCqP3PT08qIYa1aw82+ZS0ZDJRuHYsxKtlaC?=
 =?us-ascii?Q?5Ysmkd5TEL0uMuh1Fl9kGuj2H2iHtpvQoYdfI0YyuR1diMC+DrPAHlCQCwr7?=
 =?us-ascii?Q?Spz6AHPFpDYgWYX0BpxRIuM2j/9qqToqhJj7mb8zlMsk4dSG6PSx9csnAXWK?=
 =?us-ascii?Q?nZ2NuiGWFtdowH716BNHddVMKjvQPupf2g40zdeRxgYk/ngPco0bYztGK5GI?=
 =?us-ascii?Q?qKCsQRCtyeekCOYch6YYaDtidyYydAdWdglU6jTMVXBev0cPz20o0XovRAlJ?=
 =?us-ascii?Q?EM1DRN7REMOIgudEByvuc+kDSS5XSIaBAORC8DWu67RgUTdBn+GUT4WgoJsP?=
 =?us-ascii?Q?kjHlUPLaKs8lJHrzgt5T+FRAlrx3zmIvltxhl5jXytQ87pbONr0dOtn3dJ+K?=
 =?us-ascii?Q?1JwKPvoqQrvSBTG3NOE6PpnqgMV6FRoYF7AbSPxUcwFw8akrWm1mUqfCNe7q?=
 =?us-ascii?Q?UmULGHwifsAEyQoAcuvrd/OwVpOegJrynw5Fz4cfWdXcGLd2LnATlBX53o7m?=
 =?us-ascii?Q?XVsmB0/FT5RWA9VJya5OJPZ15Jn2ZKDIZjuPV1Tnu4tp5f4YITSzweh7Fo/5?=
 =?us-ascii?Q?x4v+DaPe+TQ+ZO4jbonqWtKeZUl/J44j7v2lRs9Hb5RbxQJ5YyIC1c8b+h2M?=
 =?us-ascii?Q?EZ+Qxal2PaA7ufc1WT7YFLQz89mU8WFjKm9Jn8GKtVsNVUf9GqsOZbyow359?=
 =?us-ascii?Q?hwl8F1AgXTok/OJqp8rQQcl/T0pOAQg2txWhzn6YXqGVulLjaBkN2Tv2SONT?=
 =?us-ascii?Q?jgV82FX3toHN3YVoo+REfB+myCZF2a53LuBLlqv4mh+ONx/Td8HwKRgKF/f4?=
 =?us-ascii?Q?W6kaXIQmwrOMFhsTW7BQDUO35gHABsYZnssKzKdLtM8aYfjPLDwYv6h+unLD?=
 =?us-ascii?Q?UWr2+GIX4i/TAwHvs4jl7lR79cjQzm0gAd4MrJb5sh87+a2vS9nuhjirHSwm?=
 =?us-ascii?Q?3A3yatGqLijCkdlN/l83HiC6Jkmx0MeFTbUd+PPgYpvy+vtkKKlaArbbR1FA?=
 =?us-ascii?Q?O+B+2iZ3YUYUXrOqVSIpBIikOJa79vNHjRajvdf69Rzbj/PgqoBR1ZHCUQT6?=
 =?us-ascii?Q?tFnn3Qg6RHyeX2mwhrqo4EJqiDRGiW1H4Ot5ITJlzoHPnDjZ7XdVloc5ilVd?=
 =?us-ascii?Q?zgjlnbSAeFkRTjn9X7pLIEN1xsIJVW4zU1u8EFwYMaLCB1+Thtcu7Jat0FVJ?=
 =?us-ascii?Q?DInRRhkyiCv+PO8pV1jih3WMwxHgKjdNvyBGCcPbDEXWr9dfuYWaVO5Mm66C?=
 =?us-ascii?Q?RcI9STGPUxHVbC27KZ6UH8jwDyV97b1JB3QK0WhsjXauHOlUPbV7yZk4cW3N?=
 =?us-ascii?Q?pZNtoKiWvcUn+I3sCSSNZb+4DRSSGOKEr8duCgqbSBsCUxnspvUmktaXmOZT?=
 =?us-ascii?Q?dauY4078FTQUa5R+JopwjqHVcWHE5S03ryU3iu3xlSCkjOj8CizpOIJFpLy0?=
 =?us-ascii?Q?lH94iKW3eV+NfkJ2tHw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46c3fdb-5495-4112-0adf-08dcf8328586
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:58:25.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV2syAl1ijlRKCd00Dn1j8cawcJvjHmxu7S7rXLs7HLYxqdVZEeWYqFBVgD9N0Ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090

On Fri, Oct 25, 2024 at 04:50:30PM -0700, Nicolin Chen wrote:
> +/**
> + * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
> + * @size: sizeof(struct iommu_vdevice_alloc)
> + * @viommu_id: vIOMMU ID to associate with the virtual device
> + * @dev_id: The pyhsical device to allocate a virtual instance on the vIOMMU
> + * @__reserved: Must be 0
> + * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
> + *           of AMD IOMMU, and vID of a nested Intel VT-d to a Context Table.
> + * @out_vdevice_id: Output virtual instance ID for the allocated object

How about:

@out_vdevice_id: Object handle for the vDevice. Pass to IOMMU_DESTORY


> + * Allocate a virtual device instance (for a physical device) against a vIOMMU.
> + * This instance holds the device's information (related to its vIOMMU) in a VM.
> + */
> +struct iommu_vdevice_alloc {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 __reserved;
> +	__aligned_u64 virt_id;
> +	__u32 out_vdevice_id;
> +	__u32 __reserved2;

Lets not have two u32 reserved, put the out_vdevice_id above virt_id

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..e50113305a9c 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -277,6 +277,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
>   */
>  void iommufd_device_unbind(struct iommufd_device *idev)
>  {
> +	u32 vdev_id = 0;
> +
> +	/* idev->vdev object should be destroyed prior, yet just in case.. */
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev)

Then should it have a WARN_ON here?

> +		vdev_id = idev->vdev->obj.id;
> +	mutex_unlock(&idev->igroup->lock);
> +	/* Relying on xa_lock against a race with iommufd_destroy() */
> +	if (vdev_id)
> +		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);

That doesn't seem right, iommufd_object_remove() should never be used
to destroy an object that userspace created with an IOCTL, in fact
that just isn't allowed.

Ugh, there is worse here, we can't hold a long term reference on a
kernel owned object:

	idev->vdev = vdev;
	refcount_inc(&idev->obj.users);

As it prevents the kernel from disconnecting it.

I came up with this that seems like it will work. Maybe we will need
to improve it later. Instead of using the idev, just keep the raw
struct device. We can hold a refcount on the struct device without
races. There is no need for the idev igroup lock since the xa_lock
does everything we need.

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e50113305a9c47..5fd3dd42029015 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -277,17 +277,6 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
-	u32 vdev_id = 0;
-
-	/* idev->vdev object should be destroyed prior, yet just in case.. */
-	mutex_lock(&idev->igroup->lock);
-	if (idev->vdev)
-		vdev_id = idev->vdev->obj.id;
-	mutex_unlock(&idev->igroup->lock);
-	/* Relying on xa_lock against a race with iommufd_destroy() */
-	if (vdev_id)
-		iommufd_object_remove(idev->ictx, NULL, vdev_id, 0);
-
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 9849474f429f98..6e870bce2a0cd0 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -46,6 +46,6 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->idev->dev : NULL;
+	return vdev ? vdev->dev : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, IOMMUFD);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 365cf5a56cdf20..275f954235940c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -152,9 +152,6 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
-int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
-				      struct iommufd_object *to_verify);
-
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
@@ -391,7 +388,6 @@ struct iommufd_device {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
-	struct iommufd_vdevice *vdev;
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
@@ -523,7 +519,7 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
 struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
-	struct iommufd_device *idev;
+	struct device *dev;
 	struct iommufd_viommu *viommu;
 	u64 id; /* per-vIOMMU virtual ID */
 };
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 696ac9e0e74b89..c90fe15af98be4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -43,9 +43,10 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 {
 	void *old;
 
-	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
+	old = xa_cmpxchg(&ictx->objects, obj->id, XA_ZERO_ENTRY, obj,
+			 GFP_KERNEL);
 	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
-	WARN_ON(old);
+	WARN_ON(old != XA_ZERO_ENTRY);
 }
 
 /* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
@@ -89,26 +90,6 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 	return obj;
 }
 
-int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
-				      struct iommufd_object *to_verify)
-{
-	XA_STATE(xas, &ictx->objects, 0);
-	struct iommufd_object *obj;
-	int rc = 0;
-
-	if (!to_verify || !to_verify->id)
-		return -EINVAL;
-	xas.xa_index = to_verify->id;
-
-	xa_lock(&ictx->objects);
-	obj = xas_load(&xas);
-	/* Being an unfinalized object, the loaded obj is a reserved space */
-	if (obj != XA_ZERO_ENTRY)
-		rc = -ENOENT;
-	xa_unlock(&ictx->objects);
-	return rc;
-}
-
 static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 					     struct iommufd_object *to_destroy)
 {
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 2b9a9a80298d8e..e7385676f17659 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -55,12 +55,6 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_hwpt;
 	}
 
-	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &viommu->obj);
-	if (rc) {
-		kfree(viommu);
-		goto out_put_hwpt;
-	}
-
 	viommu->type = cmd->type;
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
@@ -95,27 +89,18 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 	struct iommufd_vdevice *old,
 		*vdev = container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
-	struct iommufd_device *idev = vdev->idev;
-
-	lockdep_assert_held(&idev->igroup->lock);
 
 	old = xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	if (old)
 		WARN_ON(old != vdev);
 
 	refcount_dec(&viommu->obj.users);
-	refcount_dec(&idev->obj.users);
-	idev->vdev = NULL;
+	put_device(vdev->dev);
 }
 
 void iommufd_vdevice_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_vdevice *vdev =
-		container_of(obj, struct iommufd_vdevice, obj);
-
-	mutex_lock(&vdev->idev->igroup->lock);
 	iommufd_vdevice_abort(obj);
-	mutex_unlock(&vdev->idev->igroup->lock);
 }
 
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -140,30 +125,16 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_viommu;
 	}
 
-	mutex_lock(&idev->igroup->lock);
-	if (idev->vdev) {
-		rc = -EEXIST;
-		goto out_unlock_igroup;
-	}
-
 	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
 		goto out_unlock_igroup;
 	}
 
-	rc = iommufd_verify_unfinalized_object(ucmd->ictx, &vdev->obj);
-	if (rc) {
-		kfree(vdev);
-		goto out_unlock_igroup;
-	}
-
-	vdev->idev = idev;
 	vdev->id = virt_id;
+	vdev->dev = idev->dev;
+	get_device(idev->dev);
 	vdev->viommu = viommu;
-
-	idev->vdev = vdev;
-	refcount_inc(&idev->obj.users);
 	refcount_inc(&viommu->obj.users);
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
@@ -182,7 +153,6 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
 out_unlock_igroup:
-	mutex_unlock(&idev->igroup->lock);
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
 	iommufd_put_object(ucmd->ictx, &viommu->obj);

