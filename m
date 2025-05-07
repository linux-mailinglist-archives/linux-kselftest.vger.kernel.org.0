Return-Path: <linux-kselftest+bounces-32565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54683AADF27
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159B39C2997
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2985F25D91E;
	Wed,  7 May 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zd/BF2x8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4712139B0;
	Wed,  7 May 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620661; cv=fail; b=mXJzoc7pbodaNnhRPgQoDWFXg94JJ/0v+uQUsTNZFDOVol4LZYDzdp0S2zNYdNr1M9PYgDdQYapBpu/qPd/03FJOTuofLcDzavIziw2SzjfQagbNAbJK7sV97yMLllfVdeOT+1mSgMKftnzZCfwE0iA6oF+zT41svuLWBcTle8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620661; c=relaxed/simple;
	bh=9kVuF9SuTwGqXJcsGBZXeGyCTVbkHkTjAFJy4hYNlhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNHXflJMhJZKPs79wQvee9Y/27WeLdHGkV3U+zq+0AELF6kz1l0+ynaphczBrtZGebx0SLgmw2sXDP+MmdGBU47CIrsz4HlLRGReKvPSwpcGtTNOHbt+1TM2e8eeL7MLJg6s4fazDOJ9HTjIOc6REucMSnckli91HTuY6GsYboI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zd/BF2x8; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuVkR4Jg9pM9WoA/2GuoDzM74VLp14FxWHctbalI6pUo0VGpwIzHPl/DiySG/HKsHPfjpK9a/YDh+NdXWHHrUQV0W0/ErBJl9dISikVZgk3DXEKWONRms+h7gkBNGzMGbao5zc6R1+Qh4JC4oSi0QNA1kuZVqbr4Eqw2XMzK2KPMLUqg81zCM4t7Y4awgodkasxiF/b2Z1FD/b3/xHGFDyuX4SiJd1kZ4teVG67Dh3wSu/9/sPtz97F8XA8G2EB1HNKyemApcwUve4ruSJrsttiJ/ERKojHLGKtOz0G+DhghgCjwMYVk/wEQnsfGc5XEEtqqtp51N47x9OjSqak2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiPYKrLB2KgQAFeWA2BLy7fwbQqpWo40Qyp5UAIyVqc=;
 b=ogR4EhSYTItEXbcm2Ag39MUzJ2mYXHPExlYOq3lh9tOErhZnVurNWIvGOflrlKWJUSiAvsxhf2KrmoFAQuE7gYoQb+HwgjHhZSKZmwdqsdNdae33axcG5+awypyTCnetD/qbS+/575fbUUPe0y4atdJ+44qPr/otP4CGMfTXSjbj3nkCoRsywW4lb+4Vgo26LeEsvOKjL7BgDGdkLHf66alUpqmNCv/iDWJbRMAUfqkdYqWrOj4xtP3tc08nu6Tu/T06pxqZOIH3EoamTHa2P1FBBn3PYNiRo2/vYdCcVlkT9oalqYFNyvkzc9NfQwkbrKvxlGZeKRcHjvz9gBXJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiPYKrLB2KgQAFeWA2BLy7fwbQqpWo40Qyp5UAIyVqc=;
 b=Zd/BF2x8qosFqg6fI5FMPREefEyaCpMQI4L7NddExndxW8W0oWUeG7RmPGIh/tI1UvtzR6JyX6Qy9an33ukePbnVI2kz5BZZg7ahpYZERLsQUmsmtnm5cv2dUYtC7e6cEB53c5s3vBjVrDBVtnHlPaZZFr3IR4J9c1QP+WOCpOza6i1iwnq9cYdU/rQx34zXKytgaqEis+ZsIYTjG/GEroqdX/BTC1fb9rvm9HeEnw1gimEC8Q9oN2EXbJZWiPYUO7uQdwVhR+vXGXcNGKep9ylsY+LfGwmLwEU4M1Zqu8RSe018VH6iGiLlCNG7Q3yRGZSG+afOopH5M0FJJkLSLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 12:24:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:24:12 +0000
Date: Wed, 7 May 2025 09:24:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20250507122411.GA90261@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia>
 <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
 <20250506125847.GA2260709@nvidia.com>
 <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
X-ClientProxiedBy: MN2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: fa930583-c8f2-44a7-da69-08dd8d62131a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1SIFASQsJjrylfYsPicamaQ8AZ16zQUwA9aRj58exYdkDdKji7KXSnGamb7g?=
 =?us-ascii?Q?0TgtzbgcCDgK7gg2ZmiOAJLrCSHynte1uo2qwN5wm8wgayy1c7HGM66VfQSB?=
 =?us-ascii?Q?2+fufkYM2yTb3cahsBQkzVxi6SKiP+oDlXd+hZjUPlvDQj+Wavw5fFEV99Uj?=
 =?us-ascii?Q?7aNBqicnF+fW2Xxv3pla4ZJisqYCMsiNw10172C3ZwtPjPbSCwyWm8YrbsSl?=
 =?us-ascii?Q?WDAXD+eqyhxZkcx9tcyKyuHNwOpL0UeZO0sezNQdwi7DPF5AyH6OJJqTIhVf?=
 =?us-ascii?Q?oQpnhu9C7dxPNCPqp7pVW/d549nU5al/T43I7Xb1ASRzCsgctsdiM7mD1BYF?=
 =?us-ascii?Q?rWrnebJ98V0XH1GVJ5sIb8szmpsf8EX3/MyiaGRcq3Fq5fRSDbf41MTYMTWx?=
 =?us-ascii?Q?1hWENDp5qVbldra+j3Mo/dR4aCe988qtIsHifPhTju3H0CeLxhLw4JqrXkMn?=
 =?us-ascii?Q?iO9Oy6uagXX0pHJRZdvabzBZbP5Df4kdw4JKm8WzasDDuXa8C92LXbFXIO8R?=
 =?us-ascii?Q?EeqC0egO6Ch+vSKwox7K3Gu1wa9HyX20XF6pl9nt9Zikc/kCcakEapiz8vmP?=
 =?us-ascii?Q?iz8dvHyxTiMfIhasFPAf4sJqZflOotDQVTFbFM5UU+ZFJX8dHw00ea9gyH+x?=
 =?us-ascii?Q?E/yspAGx6wXv9PDdutnfwv5C3hdEfUTdpcBASUhytu/MAuXLe+mOqZGedOJf?=
 =?us-ascii?Q?seYaUjdsRxcHg8RqvhgxI/tFyIw0XuVn83OJBFZTeI5pwFOmJhoDxSZ3si6q?=
 =?us-ascii?Q?QThErZk+Ax8mQMiYYG0su97DDuXbN/v6vQKI/GufcDrBJXFInBq7UqcEL25C?=
 =?us-ascii?Q?SEhbCKsmKbWN1aSQBtxyAedIznJ2AV8mFhjJUXeGcA+Vxzyb7ku7ZdD7VvVT?=
 =?us-ascii?Q?S01gPiQjVcbhVYt01L/xRRVV3/4QwFiOi9ZYjhfSQ8psF5MeRhAoqG/4F0QR?=
 =?us-ascii?Q?ksP+ytuj95uuBUn1vhUV1/5GeWoBchfKIuK/Jd664O0owM9DLahZOt0YWQOF?=
 =?us-ascii?Q?ESfQPRIQRPTNXVaLPYnT2s0D/fuesLqXD7lNAbXlb4HqIPjIuVEdziJ3Ig9+?=
 =?us-ascii?Q?DkElP9Ted38OTuWF/+QKWJTeiqXzf5LUuiSNI5NY7Pd9Br7e49DUJdBxu+n3?=
 =?us-ascii?Q?WTDErtrmaDGiJwSshZmoTYiW2ZtRhIRexBPk/N9n+H/XQgZ1oQRDUsoeowkp?=
 =?us-ascii?Q?EfB724FUw83kk6Ks2US9krWiBvLlYaGpJcJCbLtRv53kzADHM+KrPS1A8qv9?=
 =?us-ascii?Q?0fMIH8iG3sDHFfZSAnguuyXFZW7E67mwPZGiMUmXOe8JKmFgOYLjVMB8JqzM?=
 =?us-ascii?Q?wozavddZC5MZ8vSfs6N6FuCpzdcqASUheRlA08bis/onDLfkt2GMgMWF+xEO?=
 =?us-ascii?Q?taBDDQ3NG54Yhx4zkmIku6I6CNRgbYy1GKyUtSLaK8knOvjaQHbZP1Q2Jj8W?=
 =?us-ascii?Q?FUrbnXgPZKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FjAA3jntSFwV0JWTgxnDEIEFpTl2yLuXHON40yFgtlcwuEGEPLRBILRpz9Pc?=
 =?us-ascii?Q?+a21zGOEU/ozOTy+Hi6RDWW7iXq7/e7B38SMDyOR8z/rvSEyKJgP3bGYkGkr?=
 =?us-ascii?Q?x05LYA/1+bw2dm3dirY35zcChZ+kttz37+idU6zQxpzKwc39POrPLhud44YZ?=
 =?us-ascii?Q?O7pxzUzEqJfu++a3l/gGe45DQb+VwdGQAAybLBFSP2IcPiRiIQxsFjyyKRov?=
 =?us-ascii?Q?4TJ693BYx+t+Mw7MnMV5yJ1E6m4yGERcfmYbo0b9LrncLa4Z3r4Eh9+3yINM?=
 =?us-ascii?Q?SFws2cp8kW+CL+o4uicHJYu4q96JEH40IZVVxWRER5X+VjAM2bMqBQ0XB6pD?=
 =?us-ascii?Q?G9UI7n43pJela7z2PRSUyXfvoJDbSFfec7iSAZnR9BaaEETuVPcmgLKeQO8h?=
 =?us-ascii?Q?RyFaIhEAmMUsAJTj1qYyDgY7CLraicC7MODxGOcuZ0VPzFeVf56JdrkcvERp?=
 =?us-ascii?Q?4gSlEUn9D1TSjktBr0yvW7muNNpAjNplqtxw9B3Spnv+FVf+SWloZ89pTKzc?=
 =?us-ascii?Q?fLmYsP9CDSEAvH+VM8U2jYNsS9+qz8AxsMK3QC8+2J2D0Adf4aeUVJZ9XdlO?=
 =?us-ascii?Q?JQrkwUx+5wYkdtHhbq0lG9AVO3rz2Rqu3TLH/VG6u5fIY3NIiUmJJc6ipnSu?=
 =?us-ascii?Q?2f09VBb/zfSKRAoP9CGkSjgyD6/57TvSTaH4Qx1xaaoTXVShmbIDSONDJ9LC?=
 =?us-ascii?Q?FiOH59m9IYXNfwzbwCtTkSf7f/7rfzcqo7ijcXtkuaJHwNFLSy39jTg+lEEN?=
 =?us-ascii?Q?ihR5zDTfFat+5sIlg8Jb174F4T0wxdG4qUAaORy+JA+TINiux8Szgjag9oNc?=
 =?us-ascii?Q?ETUzpl9LJTy3MjWrmRwGHqDwXTSwU8TKlFRsAlb0HxIoCuFqbz6oo+Rd00mu?=
 =?us-ascii?Q?HtOcTUHKWl+eBrKPT7LAomSqT6EC8+Rlx1aKRV/NTm9fYXK3JZTsEsav5Nci?=
 =?us-ascii?Q?aSMlUA0Siwm6a5IaKDtRNI+O5A63RYDDa2tNTBpYz//TV0Wnd3MVITVzXe6M?=
 =?us-ascii?Q?/aCkmVEoqTfjwk2HznQIDTTC2m+JMrHbYjWOY+7/lF9Nt9VuFNExSaXxJc24?=
 =?us-ascii?Q?A1Y65vKuIxl0fS+VGos8JTcC9PuJMUtLUt/BL6aNa1WBP53DVhO7v2iPKvNR?=
 =?us-ascii?Q?/PYe8hoa/j51ppHFYqfqhY/j1QdTWPfD689/16wxYyDEFXoSCQxRwmPWKkBm?=
 =?us-ascii?Q?6w1gf9PT8m5JtRsTDl6unNsYTAZAHmuJYnIHHhAYGKLZHUqUNuS/lEAqLYgE?=
 =?us-ascii?Q?1NQZH+ZXipphVtB3xerK7lPAZN7oTQQgWJ3e60T22lzzYcQuhM2lp/WsCZeD?=
 =?us-ascii?Q?Kd4LWj8WupSDcYU3K/4kL6v15+Yc7GHB8BsCL6XC5hJG+A3nI0StxjAj4iY1?=
 =?us-ascii?Q?sLzHI5y++D6dZO1rqDguzPbV76QWbpirqF0DriT3FfNiomJEHsZEKeUhrmUE?=
 =?us-ascii?Q?AHj/c7AsaAnABLQ407kJQjgefv/J2BOfu7NSsJnJqaIEm0j/PKBXxrHidQSD?=
 =?us-ascii?Q?dv8LrIWwSRcm7yX1wXqPK7/TlLRhTNUAhuT6PnooFVXjuyuan1oTxcuzFH3i?=
 =?us-ascii?Q?bkFo1iR22uv4a4jXjGyhWwpSc6dspvvJGI4o7uIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa930583-c8f2-44a7-da69-08dd8d62131a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:24:12.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ts1ODMsYYU6bvMtr2vJRsyXEbjNguqUDljQumkQW0HWLcU2UKVBOVzDsJWgcomz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

On Wed, May 07, 2025 at 09:18:29PM +1000, Alexey Kardashevskiy wrote:

> > We should not destroy the vdevice for something like that. In a CC
> > case that would unplug it from the VM which is not right.
> 
> vdevice is not directly seen by the guest, is not it? The guest will
> see, for example, an "AMD IOMMU" and assume there is device table
> for all 64K devices, and so on, it is QEMU which will be
> reallocating vdevice in the host's IOMMUFD. Did I miss something
> here? Thanks,

I imagined the vdevice would trigger the CC call to create the vPCI
function in the guest attached to the secure iommu. At least some
arches will need something like that.

The "AMD IOMMU" I expected to be created by the viommu object.

Jason

