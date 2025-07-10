Return-Path: <linux-kselftest+bounces-37002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF6DB0074B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD4D1CA578F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F612EA732;
	Thu, 10 Jul 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBXipNem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4612EA493;
	Thu, 10 Jul 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161530; cv=fail; b=sJEDmAHN9nqHdZaUVv/u4uF9WBA61CuA5hduKQ7pMfE1rSjjw++5mdJNIOe4zP1Bb3dTIwaGyEQhKL6SY/NERlcyddIj5bGyaOa3UbioGAoJ6L0N7AOG7c6akRuE37CWQEHqa/Rk5YGoQERWMmoijjJahOLSpf5DffRJub/n8wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161530; c=relaxed/simple;
	bh=clE3uB5m/LnLitKPOF/2a9w4o9ybywBvbdUO6kOJc0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sly/prxi7aj/iOhTarJtmRy2AbzkC+oTjYO4o/R94WTtMRsfqu4SzLF4HVyu3FTk2mJh+o0hebuSGlTHHGDUyKiFDB01kIagrSO8bSSimTtd2KRi047uX01Cx12gVTaelvUcHSF/joqAtvFYSsue/cbgbaA2lYzpwmYigblgbAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBXipNem; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A67fIOI2rNwSJ+biujS5zuLiUKXHtxsM1HmpHoyuXQs9rO63IQSICrafvE1ZCleLy8e0oNA/Cdv5T8M50pPs+bdEisZ/zwJfQ/eIq9RKSsftkxbRyB7bx7tv3TTg3f4urisloBH6fTM9VyG5dH+xeNkTOIwRfVkwhl6t4B7BbzEL6bamKcv029NFW3DXszBxROIJV9I20Cwz31bc4gJXIl7JrLM8do0/l9THzVSErB+MpwJ2pynxJAZcdrYZ+Ti/dm9Svp2E0zOIdB7cPOrCt8ZW8Ngq32HfBgVOmUtGcGXQaIWZIxawV9ZFINYB0dnkLZTiQkKBBBAPpJHBa/CWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa8Bi6oG4Tbg22kaaVpAf0fyLgcz+NQdKYy8jTijgEY=;
 b=pBl6RrveQLabo71is2v9ffpmz5NSuDu2p0bjJPYrQP867IbXSOAgzq10RuNy/i6XmSxDrrmgJAEybEzjLxqBoPd2zl1g7Xxv1iZpFj+2JZJtHT+mZiBtw4lZv/9yqyoC9M3T+PeXwtqxnw5EI/xngQsqdw5s4wRBf0DmOL2IsL3S+f/wlaDTiQDsGg+lTWNZicpAv78BHllXjpljhlkqaBQkZN5w173tG4kL3VelLggUfy8LANE3xi1g7MoYfDPIXViLxOAVAQoQi0n+MYQcJTsZX+s31micxqSqYsyCQymGNZ8FsIvIbAWT7N2MZ/caJo6IfSIszqYQTSlcLaDhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa8Bi6oG4Tbg22kaaVpAf0fyLgcz+NQdKYy8jTijgEY=;
 b=hBXipNemZgl6rKrcSv0YJ1WTpbu6Iq1i9gE7gOLepKivZApTO5I0NuDIFYlsnluyJKtKYhobsTtBOgYI64ZZThiFcugQTBjvUufKzmPhxyRh/GfkgCSQp2um5eocMXOzhz22tHKCgwWkbPLlnJyEEZKGPQ+1FTQGc++VtVm7nB/OJ2lmphV14spcJGS/ad+vGk+l6jFpTzB4A8G1q3D8Dwi7RDDWoZJHq8S7OJj6pJI4aUSeKRTyD8xPs30F8R5RidRb4yFjqOzpnuChEZ0au/Y656SFVxDNn7eVdxJn8/moa0k5CvXEf9BhXaWon2X+8bvwdI5rbgEwM5c3ImxKIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.32; Thu, 10 Jul
 2025 15:32:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:32:04 +0000
Date: Thu, 10 Jul 2025 12:32:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <20250710153202.GO1599700@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG-fZv39ci6yip3z@google.com>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 93920ef7-9e05-4926-cbf4-08ddbfc6ec2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XNCeu4tlCE3fK08Hre5gTx7XDH7AU/PcB3eQWF7djPbSsYaXWI843/68398x?=
 =?us-ascii?Q?fHcerWAKByiD34A+l7Ac4Do/RKQ3UBxYhplM4c8J6YbvcHy9vCX4JX9Adlu5?=
 =?us-ascii?Q?EbZ2T8T4/LmWdb9ulRYmSP/HRJx43dhEhhX/tI3HFNnY8C8WkqpPESm0vzhs?=
 =?us-ascii?Q?3gayq96FEhoHnCk/B6RCexqD8N6ZCPKxd//fg1bjwgpI3f6Sd9prBZlzs3eV?=
 =?us-ascii?Q?9ItestlaCNQ2skCN7VNI8dqTNzjnQPNqg8Az8KFUHoDUwSyFWF+hXBrcGPvQ?=
 =?us-ascii?Q?81nZNd4OIaZp4hExHCNuteEEGcpPRxx7QttmE6e5eAIZ7kOuXDUs42jkeESK?=
 =?us-ascii?Q?37lypsRlR9uBRoKRfc2VjYZPayXQ/ES01Y8TduMtBE+uoyK7WVksD0cVHl8b?=
 =?us-ascii?Q?lQUm6equJF/DyAEXdWnvf7XP2gg2iez+UFHV9+VfZn8UHPmWCqecgyn9Cm+G?=
 =?us-ascii?Q?meQdIEUbsc2/Barl153WMuK48yi/zQnf0z2c0pJdAuiuxfpD9YE0E3gCaODW?=
 =?us-ascii?Q?p8IE8GJ61KGOhbrOeC+uvve0ccoZKYTPeCjOKCQq9L6RG7x5T5FIIFtyxpk6?=
 =?us-ascii?Q?mo+kLOTZo6rrgyLvPQ4riYv5XsA23QTKmPUJJHXlq7aYBzDXHgptRAL21SWL?=
 =?us-ascii?Q?dIncgKRxVR3ZKMlpSLrQS3f8XGWfV5EPiWKybT2w4P7HFrt/27DpXAh+morb?=
 =?us-ascii?Q?+aoH6gSK+XeaCbehOpsaazDH/3ckY95C7pX8mGVxW7MGaA8PxApkN6Pvedmv?=
 =?us-ascii?Q?2ArqwJfPGYjPFb3WagW4NqDvk5uteRVKDNcFDcOJUbi/4tpe/1yRwF4atUuq?=
 =?us-ascii?Q?69BkM+jlJlMumxyipF+737iwIPNQ08x5GKvSLPtMrcXqCrBT41n8vY7S62dz?=
 =?us-ascii?Q?JS+NN//0qvLwRMMrbKU0TQbfwJPPl1TBnxqQcs5hL8eAs+6dQP1rtJiHDdOe?=
 =?us-ascii?Q?afWUCXwDbCfLLR3wqxA22z7nuLpf+AO2W+FQ0A/98OPzOPS8+cord1jKukrT?=
 =?us-ascii?Q?r6N+bAAcVgH9hRZWR/IQ3+93OKXZ/W93LiiPTElz/sLqo4mdlV25mAC4bxJc?=
 =?us-ascii?Q?Ba2IhURRhB+KI6vBYoFECDO9pIFxU9RVHwinFLRVXo9LfpJukk5EH8FQDQTk?=
 =?us-ascii?Q?ig5Q1gVeOkpPcOGzCINKahepk1gaqCgUot7lRaM3/ma9iQNPqhEu32a8MHP8?=
 =?us-ascii?Q?2yoPUCEDODknqYHrOcWl087nPuEF2qyECdjOsD7k+VHSRrGMGf5LKU0r3Pjf?=
 =?us-ascii?Q?ZZpJQP0Mev6fj46a9PedRV8bm4evhK7WKesV4kIHLrj10OoDDm/yFHCbPLme?=
 =?us-ascii?Q?pQvyLhhMiv4J++e77XsqMFXXFSRcqdWkoPynTw0Luvsx0U6JRfs0QyYaPm90?=
 =?us-ascii?Q?eqmigGEA99I6RgS4hvMGs7wIVtudlpwpgqTInnrTFhN1JhbGmAqoPF6TU9JT?=
 =?us-ascii?Q?lmIhRDjAm9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OTccSKyNhiQVN5Mog+I0cF6JZUzcX8TzU/MJapKhUI9keit8l+plPqWhmJgM?=
 =?us-ascii?Q?1Mnhy/Ovn/Jp0a5TbGibpyu1lhnmnidM0zfJ8A0wFyPgrTakO7Ze2MIeW3GA?=
 =?us-ascii?Q?Iw0G9dICDA60gvM7Y95mDP1fasftHNQt6tFqm9FSPxLJnDetKwsW94C3olyp?=
 =?us-ascii?Q?8G+9oPYMh8zeCH7ZiIY72fUItqaHlDFZK9U22ZLgDrPN9e4P2uJZKUEtiPoZ?=
 =?us-ascii?Q?pcLivkxm85HS20UDFQJXBk9C+vb62bjWerH3Ni4hGC65T0MoTE9jX1Xg1ii4?=
 =?us-ascii?Q?sJfBegAHGT2fj37j3q2h7SqJNvQH2MI64+GFplwzwRwOQ74pUum7CDFdQa13?=
 =?us-ascii?Q?kWVydmW/i62qFSZebacOWcdrbPKujald3uMycA6fSkrN/bEECX4WY6zjdBrU?=
 =?us-ascii?Q?00KlC0e6LXdVsuWy4WZE0Zanm67zexBG0lrldFladTsOIv0FavZF5uoYv8vv?=
 =?us-ascii?Q?ciVT2/whGaGiuQN9lNAytxtz3CiRjYG2sUNOIRf0j/BSXbKjoQcBIiGzKdE1?=
 =?us-ascii?Q?yeBNticEs9F7aeCZVb3LUk/fC5j/9j7tKj4AIhaQo1G81VtOESpBYMi3/apW?=
 =?us-ascii?Q?xJdwczS3ZJWYjKZQ3A+wjzIDIwO2oVhtCeNtkGs5T5aDWi6hXBP3/nsVosK9?=
 =?us-ascii?Q?HjM5c22CyMCaMEuA6SkK7i2qA4wPVgooXcmXDrjg/NSTodcZrUrnt6lBcR3c?=
 =?us-ascii?Q?1dv1chlsIpF61Hx82HxTEmNm0oCaZ2BXCGucHG+tTcOLFuDlVAg3mt+jHG7o?=
 =?us-ascii?Q?IiG6nan+GNHXuD0KF+adjaMwp15a4fTfWPAGSq/vmKDYPEu80+CBFEVRnqo1?=
 =?us-ascii?Q?L/8EC28RSYxbr2CvZWUQGzgcqueUvelP8nYpyDCMCFaR6vbs/HewVIIVser8?=
 =?us-ascii?Q?e5tzutFrobNFXXUu2orMRys9F+zD2rh/IuWY4Wj+fMNAwxK43uctkel2ZNCq?=
 =?us-ascii?Q?nTf+Y/Ps6lhwpaK6siYpV+Jl5ARr+0BCkTw5BI4YE0Qm8obqVNlft6FiXUhN?=
 =?us-ascii?Q?IFN6kyx7TCs960cY/ZGij6uOjYG1r7lSA1kbFH2XCMf4jDuzwXHCxNwbVHDp?=
 =?us-ascii?Q?X41loPESx3SExB6bd1tIj4mSX+kOic+Sc/fWmmksBBMKxKC/7BDCRfIGl+In?=
 =?us-ascii?Q?M7mIQ6KeHgUtkPx+7ngQRhoL701wnMoDVNG2NgrFb47tnBGEiFcwqEpBHbDj?=
 =?us-ascii?Q?387CkRRMu0VmCQM0Z8Jc4nKZdVxePwA+/CtW9djGL6QFMjZrKhVHIXZl53ei?=
 =?us-ascii?Q?zhqiGe1cUx0P9Pnfi0SaSeofV6kk/tXuHIwcX947Lzy7CytP3AuiVhLH38yQ?=
 =?us-ascii?Q?yBAKYH2fyoHaM342lZEmjMz3dVxnKbI4yDRzHAuamtXzo8tl3UZkFxIAmlOg?=
 =?us-ascii?Q?AC0iowaXWn0D0BUDUMMXgTYVB9Sfxq/eLhCyDtt9sRqJHuN39bXlWIIWrwTE?=
 =?us-ascii?Q?2rgPFeg4yr24XnEfNgH0+XTGgK533kWx1GH5YfyTcR3gG2FXyZpwo0Pjucdp?=
 =?us-ascii?Q?JSBYnMv2+Ah7f8HFa612zMp+Tj2EnAAVzALenG71Ojkmz7zvDfKVSC11I9mb?=
 =?us-ascii?Q?ZppCuDkB7GMsn7sVXLK00F1QGOjq8gzhdVdTLFvg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93920ef7-9e05-4926-cbf4-08ddbfc6ec2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:32:04.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk7i14YIBQ97yLOPXxZqvGR6dYNkWTAYK95wohLB24FhqDC/iyPMZC0ytvVgrnb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

On Thu, Jul 10, 2025 at 11:09:26AM +0000, Pranjal Shrivastava wrote:
> On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> > Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> > add a negative test for an unsupported type.
> > 
> > Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> > is complaining.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> 
> Note: I see a couple of warnings while building the selftests on Jason's
> tree, but these seem unrelated to this series:

This is fixed in v6.16-rc5

Jason

