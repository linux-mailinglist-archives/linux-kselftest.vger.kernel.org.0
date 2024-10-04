Return-Path: <linux-kselftest+bounces-19070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DC991092
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AAAB31215
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9A1DD9D8;
	Fri,  4 Oct 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNgu7eDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694171DD88F;
	Fri,  4 Oct 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073072; cv=fail; b=BVTkmcgZ7b5liaMskOFNynEKhUFfC3QYHMD3Zo/rYn24bUiQfYsbh6Qgq8aBSu0svIsvr4Ke/DWjDlEiRbSuJn+PmNVhqfMVm8WGjSuMCl1tAKnf3+1wIMSxqOE8f6H+uJGpWhospEBvu502IakwJYqx6HdO0HvFquEh1hhEcnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073072; c=relaxed/simple;
	bh=iDtHpX1v0TQwSf4sC2p6V9j4DnwYjY6kH95SPVD4rjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8r5DXdihV53hW1DjqBPmPbBBIg4h0MnbWw3zbMm/cnhIleW6XS1btkYEqpNGgp6kH7IXeO2aLiIDFA93a20YRDDnGrFfJzuB8GSpm2Y300HsdQ6geNag8H88PQU4KHH8NBOsiPsKhm1TG6eRd7eKNXZgj3ZiUpZnOwUx/B6SwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNgu7eDB; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRSxFGMOjo6/Wx5p/qKPaToG71BkwLIEU8hX2RAjvhSCIyLJD93tMfuM3mTl4dEhbYcHhx9aCQOzlt8d8xdA82TBbkiQXLJDI+jHIcjZiz9KRy3rzB9BYRsXw7zA/On/EQxGtqkVnrDVBVUCoWGV32fR2LoN2VnqepnqBO2rUPo3CVKeRVCWE2q0TLQeOBX5NQ9hZyBh68N+2F9fYNR8GVGCZN/2Tl1+doZ1B7VV3/LnT3bR7x2ctnRcm+SZDu+/7gSqRNpEwFX5sXsJh5DYVjOQTxp+/XTX7g+nY355XhYwCLtXd5yyEDEPnhYNNbysX+0B9htIjzIajzrb1wvEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMVdrA5ty3hnSJaBH92IzkjbF4suwljJPiMSU+6dAks=;
 b=evOkluLFruDuN54CeipTK5V9ej519usMQb27tYI+zWH9QbySXwErrcw/x4Igh2j0DZPWQiHyQnyAU+GmcE9WnFNOIcjlLYERTEdk2jLrDy8+ToJ4gOjjKgudqG0F0JHKwkJvox/7WedeW+Y4y7b+Cry08h1KRMsy95YcQlBuEFhMTLiKjaTNmSs7HP3l6WTplyy6x/l5xvZRKh9RcnsOilzP14eC+Zo66IJYf9Y112tl8GSapTu2wRiXGwYuuIAiGfaQdo+gQiVu5qNuHHAfckFB6pwcb26p4KwVHwySJvdzGi3IEWNxOvPuR4Obj6JwU6CiGJK94GDkz7UDdO5Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMVdrA5ty3hnSJaBH92IzkjbF4suwljJPiMSU+6dAks=;
 b=RNgu7eDBAxIRCcS9a6Bkzl3wxaNeQq9H6i5mrDKqOVJwxDB2aPUOFK9HfGDBrb1bdtghfbn4jm7C+y3DP3wUM0NnOzfuKEqOH47LUoZzkBHvp7C1Zs0Ph602cB87Uw5IWAAWi0GuIQ+vDgiWDRQ4XUHplS9BbbnagiMJBC/6xe26q1ZSv6Iunl6l8780xcQ5CxqUpZNZYxpiX/BOJ9t7hw6cuZvNmK0NYMkqsIyWr6JMhkFDtBH02ceW4pmpQq51RQa7Rl/t63DU8ZHAEuHjhfeOZ+PT9C5K6T8oRIdnd0im3kzzE7v70TzyXHUD/0QDDorWmHMUr01cKcXjNMBI1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 20:17:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 20:17:47 +0000
Date: Fri, 4 Oct 2024 17:17:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kevin.tian@intel.com,
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
Message-ID: <20241004201746.GK1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <ZwAwWr+q3ZGkZCSM@Asurada-Nvidia>
 <20241004185019.GJ1365916@nvidia.com>
 <ZwBBH+9hwuGKOstl@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwBBH+9hwuGKOstl@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:208:32a::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: d0257981-dc2d-401b-87ba-08dce4b19d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dv6TBRFFj+ag+s1HBOs0mYQ6nvksJHAu7Hv1nrLuzCQb/C99tOWxxMMNmfTd?=
 =?us-ascii?Q?daO7OnviDhBGpIlto4ieOb2r/my7tGfMXkpUvVSs2yGaWPale9C4HwE4/G9k?=
 =?us-ascii?Q?y8pCW66LfhN13nzNEyh5ml7GXjWEechvi7ciubRBiqyND96Iy9rHW+41OsZg?=
 =?us-ascii?Q?+gfnJ9p32yYMxeUnRvEvWpC9Lgv2ItlAYYXfVShYeTtRrGFHZBdN7yyZ/IK9?=
 =?us-ascii?Q?0xn603KUbfjP5Y+anvjhiPjRQUz48ElgECsJ0KcBXqDJmoB7kVCenU8M5t0h?=
 =?us-ascii?Q?LpP17IRBqQ728jS8viFPtg4Wn6qMibgTO5/5D4zwm+pqd7j/g4zpFRGUGrty?=
 =?us-ascii?Q?eNoF7Vua+LBw0s6tFO3ZcFmGPxF9MYDZHj5JJs4bfYpa0SX/2dpJDScY0l4d?=
 =?us-ascii?Q?+YDfBwRf0ALqSTJY43eSu8yT2o0MIdzbRuVEsHVhPLA/Xa1QGQiCMwNOyL0U?=
 =?us-ascii?Q?cTzXEtKpj/QjdUBxOUjS0ZlMhlnJ2uouZg6/1sB1MU/tHT0SHjz7sCsgp4G/?=
 =?us-ascii?Q?Yn9GGQxMUaWPi5XPWRbOQMgBiMB00S5wckxFfHviYSX3SgOQN8GL+U2yrUgy?=
 =?us-ascii?Q?Lm+0iU4X7Bxtl7pdJ6InEk3WdcdA3ffOCt1Vb9GJJ7Td+/tTjdeCqPB597Pu?=
 =?us-ascii?Q?hwTc/eLaBJ345uG5C07tFLTtFR6LmrfHTlhvv32jvAxcWXXrVOzppA8J2hgP?=
 =?us-ascii?Q?d/CzTeaRNfQhmUWXkhl2vYL4ChYVwUBQ0TK9X5oeOl+ULj4HLWMLp8xUgJLE?=
 =?us-ascii?Q?3rmksWW677GkshknjKGcbeORL12zfUYG9GlDXXIeiPlJ5bJbdlT43hirYy8l?=
 =?us-ascii?Q?S8LitrkQKmDw4KDeAjpbI8lQSDRtTxmLQerpq7d4RkD8pN9z+nA3DF9G2tqG?=
 =?us-ascii?Q?wjxuRGlo1fiyXxDNUiVsA0ffe7/DnCTjyeIg1LGoepSGF1gLOYUhkJmTtLBB?=
 =?us-ascii?Q?IrFAblJbcaYpyhY6/Glugsz1i3PzhItzftfeF7hNYqArMZ8bv9RpIiYiDcJI?=
 =?us-ascii?Q?WZ4/5b5AFxZY7Fhmi/2Zglf1b/xCbz1pOFAs7p13624heZV+K0GiO0QJGvla?=
 =?us-ascii?Q?KR/aVxJ/Y/MI80HXwFtmUYivyW+OJmdkERnkv8wl88drzZAEyF3KL07yS6h1?=
 =?us-ascii?Q?zMtSSw4G52pjyqiyhFcCCBNTY2FutaAYR0lzlt4xPosRhleMQk2IQZLUns3p?=
 =?us-ascii?Q?jF4ghzC4QJjXh7ADLoIHZG7cEZCVqRb6M/MY+HrvaU0Vczqt+YngiouxRjqD?=
 =?us-ascii?Q?v/dyUdek0/Hpmyx9GOkWhmDX9T/AmIlnCWRxJ8Svqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0O7OYlO27tKMuLEceg9NGVlShRBt4CytO9jP4NlIC0PDNu3DL6LXLUB1dvO?=
 =?us-ascii?Q?ImuK1BWCn2TPGGwWFF+XbgRJu2ZGKWfXPKVUeryHoIl819Ah1MIWWWyr1VfI?=
 =?us-ascii?Q?lDtTaNXWSWyBLBUVxCQI7asqJWjC8jiKI/rBJ7E9Jje5jJOmFzJJgwpIZMvy?=
 =?us-ascii?Q?dGF4cAx0utO+qhpsGK3WspMziW2iljIx0Gn3+eIWwjeqHXyPDsWZ5TVw31CD?=
 =?us-ascii?Q?CIasXDRvI/adv9X56NyD6SN7PcLxMMe8PrUMLquutEa00JVL6JPS50LVxh1E?=
 =?us-ascii?Q?yvE0Oz3dJHOsdb35Qa9RBDfuV+FHxUn9lRXey8oDcx0zJcj8jsxyb7ZUi/AU?=
 =?us-ascii?Q?9lQLBqFse6Iu4JbnvCEGAGnrdpW5VW9+f3oO+dJ/CMgorAAtJ4LcYcAYEsm1?=
 =?us-ascii?Q?V8LX1Di8hoBBtpf+xDpZBHLZTJsnr2nH/RuaEdjl47iJw0juVRqMdfiX7bVK?=
 =?us-ascii?Q?4Hk0ughKKz9NJtJCMBm3mPL0ifuYeGTPizBeSwvrpYp8E4mNBD0HS6lc0gW9?=
 =?us-ascii?Q?zXyG7Iea08dAuFAZeHouNUAHcmtoqqjHH52wyYUC+5XYn0vLH3L5WiULSOPL?=
 =?us-ascii?Q?HZHODxenXNcf6pPtk1Mb/yT8bbHt24ukshM8Xpfmf8FhiTi4jW+IY38WyMMc?=
 =?us-ascii?Q?MBrXIg8IRy0JUG90BhsPW64y0f/K565buv4bQN/xwsDCVY0SVQtZWKsm361p?=
 =?us-ascii?Q?ELzdEOpTyV/KwLvht4q0Y80tnbRB/lVJDW+vxjjrAjokBc7J621+InuWJKqS?=
 =?us-ascii?Q?LqLTW6W9/FVMbXg4WduWq+n9fMiMeezMr8NE5y9luV+QmrJ3/fu75S+BPCbH?=
 =?us-ascii?Q?yOkETSowFXzjcx7gqSOZCgwz7fCzVpw1ZdYunSx2m8EJjb1pCrXFC0j9N8pm?=
 =?us-ascii?Q?hkwIk1idMhKdb6fZ/D2srHDcVo6v/47pcWXmpGYODrPWHvdOc4/qRZmyQZcI?=
 =?us-ascii?Q?4bszlBWJYt4StqpawG9aZLWIqWZtgm4alqlPcCOxy7WXVVCSP7UDTmDyBo4d?=
 =?us-ascii?Q?/ghNTgcUp6GrJyVDYr//apMphnJwaUE7lCXDF587G/RqF8Y3Vc9BBNQ+OSGp?=
 =?us-ascii?Q?SQv43vFE5+f+cNV6kQkq+i4kzgHV1FkPrfQPJAyykIxkZrpHOrSFZVTMPaAA?=
 =?us-ascii?Q?d3zSC5+KTmufHllVsUJO8Vj6MCiNJmo4pcumeHYa4ez7lmRYHDy3K73J38Nv?=
 =?us-ascii?Q?fxenDaXyBSmOr7e8OuElDzKyx7rVr1Nep8SK1aR4MC9KJMC8CxVobBqpem8o?=
 =?us-ascii?Q?NyPUd5LM1vgWsIrqoQFOyl9ieHme4BUnXN6BowSXXlqDlK8RUCYPFwRd+jMt?=
 =?us-ascii?Q?AOF7XUlx2+uOF/BWxiPjeiSDd6U6pG5EaTXc7FOCf4IvyO0bUBbMWV1VPPdL?=
 =?us-ascii?Q?nc3Hkr8s8ZfTuRJ6lia0ir0O4TN3kOL+fAfcvcbtY00hX1a8vT5F7jn7vpnR?=
 =?us-ascii?Q?2xWPQlZT0CItAjlHfI2t4SzwRA3QAajJDca01TT5kFkEyqrr9jVs8QScbD88?=
 =?us-ascii?Q?d+2qHXtkENZss4zQzABCvxw7vq+bL4RYY+wL39qBIUqfuZBYsb+Uc5ZNT7Lb?=
 =?us-ascii?Q?bfq9XCYiz/popHO0XFw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0257981-dc2d-401b-87ba-08dce4b19d37
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:17:47.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OENtIF2wrXKjFKGmIKiYq7T6X8173YndfF3a35v+0yBQkP4Pah6GxMCr66vql/qG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693

On Fri, Oct 04, 2024 at 12:25:19PM -0700, Nicolin Chen wrote:

> With that, I wonder what is better for the initial version of
> this structure, a generic virtual ID or a driver-named ID like
> "Stream ID"? The latter might be more understandable/flexible, 
> so we won't need to justify a generic virtual ID along the way
> if something changes in the nature?

I think the name could be a bit more specific "viommu_device_id"
maybe? And elaborate in the kdoc that this is about the identifier
that the iommu HW itself uses.
> That sounds wider than what I defined it for in my patch:
>  * struct iommu_vdevice_alloc - ioctl(IOMMU_VDEVICE_ALLOC)
>  * ...
>  * Allocate a virtual device instance (for a physical device) against a vIOMMU.
>  * This instance holds the device's information in a VM, related to its vIOMMU.
> 
> Would you please help rephrase it? It'd be also helpful for me
> to update the doc.

I think that is still OK for the moment.

> Though I feel slightly odd if we define it wider than "vIOMMU"
> since this is an iommufd header...

The notion I have is that vIOMMU would expand to encompass not just
the physical hypervisor controled vIOMMU but also the vIOMMU
controlled by the trusted "lowervisor" in a pkvm/cc/whatever world.

Alexey is working on vIOMMU support in CC which has the trusted world
do some of the trusted vIOMMU components. I'm hoping the other people
in this area will look at his design and make it fit nicely to
everyone.

Jason

