Return-Path: <linux-kselftest+bounces-20258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FB9A6821
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF011C2262A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752131F9408;
	Mon, 21 Oct 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E8PZDkmB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DA1F890E;
	Mon, 21 Oct 2024 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513316; cv=fail; b=QFM73erQKbqMYq9AcZJggC5bmzgsrNVL8TtPxO+2UK1jDIHAohTx+XuKtcAwZRuQSJI/FQfaMouQHuLbgbh0/KH28ktyh/nkpSWuGUv1Vh4kmIYYsR5NR4ibL7X0RntAI8qJxCpF1QhhTCjIv2nrx7VkWkm0XO7Av1Mzljvc2Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513316; c=relaxed/simple;
	bh=nAe8IkLcPUj9p9vXOONaoko0jB6wS+ueRj6tu2jNXcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNeyNToOnFcetp7EqW3BxI4KLb37yVIvtihKtOL9XN3MB+HS365P0D5oZQY5IUoXJbuU9X3kpUjRxl9BgVmD4UxEu1PwBDmTyxRbxxrhpnU8R6PQa4w2p50RYvEan5UUg03M5eUPLNzk+ttERGTZESk7DGw3ZBeoDVskWPec4dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E8PZDkmB; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phj4PjwwCtXoOi4Q5Q6RnrS8Y+mSs3RCg6WoXKM7iDUUIAuC2hxlxLTeThnvGiOC8i0hR8h/CXPhklJrLfhkID7sZuO9TEK9MmCBhfW7/N12Y6JDtk6VQv4c6PtzFJwKMmJd0YozvJspo4pZm1loaDgNJbSUhVZOJppfabfzf7wvBM2eVwQv4gTYWk7hYwYuM9kdlPDdo1DAonu4RwIVYv6BdzzRyUANG06gwRUbghcIjJPpsKmMLIa2exkH8Ol8txEEtSHDjpQvIeRXd1kDlXUytGtbPyeh+4dnwmWHdUGFSrrxG4Lpwut9cZv+rL5xPHHPxcJOfxhnFSeSOJM8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zn16QjR2VSFxFGVFUl7eHish0OGuh5CxUJ70pGbdhU=;
 b=DmMURyRob3BibqHElTj3UrHEds2grbZBoz1fuT6PdwN2WlkvX6V5UlcU2QhwNdiStaIGtTsVc5nLvSxF6sl8FF5IRNxYy0RSnUYcY3SPDSSQ2D3sqnk/hooYsAn7CSULEZbFoHgHMmVUBQ3/UKJbIwkkk4Cp0httb4XdHYL52cIVonM5NoWdN8rIvHUPsPhMuxuJ3TQEfSrXA8QSMX0mevQF3cGxSRa7wJj1Aka0kAAfpLVu8HT7IadixoQnPcfNgw3c/24KrT9duQeK2qLYC0SqH6amqWlOaCEeOV+VQV8aWsu3l00WQP8AiyZEHpcLK7of86ZG/7R17nROWVoHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zn16QjR2VSFxFGVFUl7eHish0OGuh5CxUJ70pGbdhU=;
 b=E8PZDkmBY2ZSteRvaTVEJcZKm/vZBU4GODBxkIt/4i9NcAUKCX1+DLGzHvhCzjIS2eeJO1sFtmseRrtzvCGcyrEeL2M1fIjPksqqZKoJstMDEebvjLbN2WDeGzv4dxnfOXkcbX9Tp0K8o2H+an+I1lk52BV5FIlVAOkfSLDgWQu7uOAzizQrQ6xmmG5qD0Fru3KZA0PKVD7Q/QkKrtgw76m+8Hv+4bNus/YvLm5LyvXYriPEjak6sfrxPNgX3Auq93DoZtb/dj6FcAI5jpxVXpK3z8qrqLNZnPqjnf172DhzW8JW9wyzLAvrf7MsbN3QYrD3O1b92qzfkNBAirZQhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 12:21:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:21:49 +0000
Date: Mon, 21 Oct 2024 09:21:48 -0300
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
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 01/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <20241021122148.GP3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
 <20241017184556.GQ3559746@nvidia.com>
 <ZxRecZKbXd7cLOqy@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxRecZKbXd7cLOqy@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0473.namprd03.prod.outlook.com
 (2603:10b6:408:139::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d7bb37-7f79-477b-1c6e-08dcf1caf016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJWfTNu5GykX89Gxuj3Jibfrektv86dXruPipfSjNrpmYEq6qFkVulYYEABO?=
 =?us-ascii?Q?asQi5w7yI4NfRfTyc8Qqdx07UAXuQxLeiZbJv5KbwMw2/viYOD1kHlrxlI9S?=
 =?us-ascii?Q?WgqCe7hktVbOwu1vrhdENQPS+Am5TWtDAoDftQP5cX2JN81Ih98w7UX5YhF3?=
 =?us-ascii?Q?soVLaIKFAlD+L/phROcThYmQTiPMIKGX9tszhG828NEgqm3D8/GUKyzv7dO/?=
 =?us-ascii?Q?rMFSJ4/Wf4sy5a4gRsjVXzovj54J9No+hs1BbXrhWZkhVXl6b0SOby3RO2uW?=
 =?us-ascii?Q?pIefQZZLSCDr4fMgGCxEyP/yhltheNuMYRVYmnJyoMLWec5EAuznUdMOviLL?=
 =?us-ascii?Q?DZ+u3Ih7mh4drWRld0+7IYG/7XQZkurvi/78x9xti6TnKiueXSmhaT7jmO0y?=
 =?us-ascii?Q?gu+AeoogDeZ/rH6e9qGPtb+xDqS/LC+WUz/Qvr9AIV/r6q7sUIVy13THcLc7?=
 =?us-ascii?Q?YjGGvEk7MkQQrkojiXWOH9rfGt0Y6PLu9U+K50Xnc8kkbDBkaqwRwEieueRp?=
 =?us-ascii?Q?sCpc0HUqHk7nOWbzCIOnndMYkQi4oKy5f1Ginm4CavswXvn0DBeeOWKL10wg?=
 =?us-ascii?Q?ynpDlh4eokNCtZ6A5o1eUBG9gafbi2RvaF8HN4ZQ6p+MBl3R+GicJAgbvfDA?=
 =?us-ascii?Q?XrXjWz9bNjPhbcQ5SY+KFGwtU9yzbzFNjJcMK6O2S/hig0wF0UX5ghoykdfK?=
 =?us-ascii?Q?OQn/Slkaqtpng45VygCtK8Sno/YZyJLAwkjr2kWjddD6tyjqFbelsZVcjcQM?=
 =?us-ascii?Q?QRvFk8J0G/78EDW5OF2zNqFbI0gq8mVb5h7ql4PkEhETI5mV3iEJZJ3sUvWo?=
 =?us-ascii?Q?45CaQanOuRgYinfmt2Dg2gubHtmvD6zDPjVaWHRlNrClyezx9iBNdhPm7i8E?=
 =?us-ascii?Q?CGCfbIw+q1E0H0LO7uYEGWMJAiSvwk00V3g0tfOR5lvqY8DEvyc2MocUI0Rn?=
 =?us-ascii?Q?8UQU7mt6BnLehOIJuDIvnpzTutu7n0GScl7Q1+9C71HqgaKRMNwIkPysEkMY?=
 =?us-ascii?Q?C6nh66vgfGiJQ65HqmqeN2H/IwVWglPpR/F6jE1pXZ8oNJzpmapsXEHmpf9G?=
 =?us-ascii?Q?K0fXltl69NM1PfuiQZSDIm3UDgzGA1NgQPXmQbHjajSBcUk22z1Z4DT2AyTM?=
 =?us-ascii?Q?9h8VbVv1MlzF/QyIOhoclIyStyz26VU85u+bC7EC/JNe72u4jdkeBCf3Hxik?=
 =?us-ascii?Q?c/DvcS0Z6irTMYsZUVimA+O84ivEL+wN0rvlCTquaDjVrJY+XL95lzxTT+4l?=
 =?us-ascii?Q?J+GLtv631LKSTu8gQGVIAsy5RH5dcM4CWdJOAlWjcAPwcFpb0MrjVeunama8?=
 =?us-ascii?Q?znJ5pFzOEGAVa0rdnKtGnDAb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mo+2gwNWuafiIB6axUNH32o0L2eawN3PRcS/qHWrP79CuKASeZ0rn/fhMApL?=
 =?us-ascii?Q?qe7YAgVnVLZ0fX5UZovyFAuIvgvSZrpWJTV6A37M93MTiXMEGA5bbuPNZAYQ?=
 =?us-ascii?Q?sSxajCnDXv9MqDpcXUtto9dzMa0bZJ8ZZR+jWvQirvmFOIlEcGPba0TT1HkG?=
 =?us-ascii?Q?z11/8OgNuXcDiX0lPDTZP0Rp+f2D3HP1WcXs6vKayVX4Bc6eO89kZilcnrtU?=
 =?us-ascii?Q?DtiBnck0RgXAfCudIkKYbcLGEkC3VDGO6iG5GpqyTNbWOjWg34u6HCoHHb5m?=
 =?us-ascii?Q?PYA66hbK7dmQyP2FVzSSeOqoc5txmi5g8NeX/lmwZ7QFkrPpLKPGjszLKUTi?=
 =?us-ascii?Q?6MrpCq4s0rYSVm/CVdh+oby3bokqj48BGiH5lsYVydTX0CUli6yqlxiCk6oH?=
 =?us-ascii?Q?BeusWY3c/m/hr1Tb9WJaR7qHOUnxUW3A5xpYZc1gUsNuE3n8BGif5ZZUjxV6?=
 =?us-ascii?Q?4DJHYgpxC1R1TV8XkYfwWxLQNAD/MubHFhhdr501YZXGFyDZAEExnpab09DX?=
 =?us-ascii?Q?glm1dZyTgDWhAnklpbhGs8E29IIIHHvXhHlH+5SP4Y9xwLx3oY4uel3jMo5w?=
 =?us-ascii?Q?0Y3wmOp9CUEU+WfxEdap/pmhoxVfyI4enZy5smuTIyATpFxqS9Wkt7+k9IWg?=
 =?us-ascii?Q?prySm2AUvseGJyfbGLhv/v/qzszzVkGmrfURSvj7uT3mqEqpTumkqNkR/3xI?=
 =?us-ascii?Q?tPpqhRvuKwPmKdqYvVDmXHgifqGiQguWmJk5mHmJmZlpwYwKoPX6Two7X6JP?=
 =?us-ascii?Q?y36JZbdxSxyBy3kNRClaNrotadIadZxnRXBFo+CwAFolO4bSaYijag06eqNN?=
 =?us-ascii?Q?v4f4CbSJ5uPQXlf4I71MLBlmExpdljko6oxu9kKq9hBQWKa0e2oIfgI1BHAd?=
 =?us-ascii?Q?GVywhANCQZ35U0/PYP5OwtHFVDZViuZdAfMz9W1bsS36z5DH3cQ3uaWhzz3a?=
 =?us-ascii?Q?YBjHtdv+J18GjZ/WimEJYnqmGzBscbJzxROwYQkWPrTJmbOM07iV381WfB6u?=
 =?us-ascii?Q?3p470VRts0hcIfdsZyOUM4vdi4WD1ATa9jUJErWvHeaUQCNWbqSygZbyEo1K?=
 =?us-ascii?Q?XHRjr3Mfg+jSy+7Nk3aLoB5vorYJeHYSXlUBkZuWxAPXsJFBtTxSlY+JupHE?=
 =?us-ascii?Q?wtoEDaDVQPW10o4nAT9YsNtGY/7PiQtJ7yI7QCmmHXbpjGFmQcEj08jpIjyp?=
 =?us-ascii?Q?Q5T4tgv3JuzFFIPAW20XJU/1ZfgjeSGl+ZODLt559FEefnZ5vhywnXuulmtK?=
 =?us-ascii?Q?wUfCnPbPzRyVat31aHtBAlHbsttn5O2mHomUpUfYFjbYNgwTQtjG1rfxahSH?=
 =?us-ascii?Q?hhQmQ6l4vXY8RFHCcHy/FkbMjRdBn8t1PSxtqHjDcfBrvKabXNsx6N5OKY8B?=
 =?us-ascii?Q?nF6BF6kr39BxQde7/Mo7kNX6tKTvY1q/69k8QESB5Km2S/m6cNwHdlkYCTh/?=
 =?us-ascii?Q?eD1S1NKdV3OtnOkNbdfsNw5Hf4hB0EacPGRE2qBP7AuQgB4neTF9kKSd+eLs?=
 =?us-ascii?Q?/FX68qSiyQV8xfKl9CKfeqEdY9fAHHYCv8M8X+b2Wwquc/aNKTyXpk3AWgw0?=
 =?us-ascii?Q?DHaRfp6np11eGasdh1s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d7bb37-7f79-477b-1c6e-08dcf1caf016
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:21:49.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYhK7fD06XTRSvGfsgqdDawyGPprSPbeaLNdnIR63WmZziACXAm9j7dAnywNPQXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901

On Sat, Oct 19, 2024 at 06:35:45PM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 03:45:56PM -0300, Jason Gunthorpe wrote:
> > > +struct iommufd_vdevice *
> > > +__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
> > > +{
> > > +	struct iommufd_object *obj;
> > > +
> > > +	if (WARN_ON(size < sizeof(struct iommufd_vdevice)))
> > > +		return ERR_PTR(-EINVAL);
> > > +	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VDEVICE);
> > > +	if (IS_ERR(obj))
> > > +		return ERR_CAST(obj);
> > > +	return container_of(obj, struct iommufd_vdevice, obj);
> > > +}
> > 
> > Like for the viommu this can all just be folded into the #define
> 
> It seems that we have to keep two small functions as followings,
> unless we want to expose the enum iommufd_object_type.

I'd probably expose the enum along with the struct..

Jason

