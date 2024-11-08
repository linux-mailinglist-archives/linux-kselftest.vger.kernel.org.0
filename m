Return-Path: <linux-kselftest+bounces-21705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACF9C242C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 18:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D8B1F261FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E22123CD;
	Fri,  8 Nov 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1BTIfKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7E20DD6F;
	Fri,  8 Nov 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087611; cv=fail; b=uc6CfeQUlr1XxJI6z9tDBtSsbbsjml2Cy9vxM8+HwaiiFsVXTBylFmmOBaEe8xcEvWvkKw33ySG4kLfKJi+7+RO/dXEmaPJif2GjZHUHe+CUYzbngK4+yZ5AnMOBrJIfQhK96fCkF8FFPv2MyjIgziZHLVgDl5l2PsSQmPF7Dm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087611; c=relaxed/simple;
	bh=UCqbOxYGpYbrNcpd70WU+iXhn7Sp9M8syRAPDP2rqSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3PxIkW2P7S9yoUnjFP/4tSLfxl6EBOKh4HrDI/6WY6CAxNw5DKKrqzJIt3Qz0dg084jdAm5DR2splsSSLfyKdNWJFeMbB1ou5mIv7fZieafEbyB+qNEsgErGvv/2M16z2O/IeyL3ED/D+rTddRJBwRksVETWJkDTgIm5375Wds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1BTIfKO; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj2E9cInW8d/8eb8GS9xO7ZX1Pd2TM1UP5XXEOlepPuamqQLdDNVEhEepyFZbeGde/365tp9Jr7EF0fR+qJeCvOIi8pSU0KgJ6/ITjvZ4GfEsC19g0ZmeRzsr0M4WMwszUkM4xClErULde1JTVoOciUlSzerfCIaT81hRMbfNXv7BT+1S/k+aix+7EywwFHRoLMkHW6cxzOQh6TPChcT/eDYDSZiunxJUfaMZGbg/eouwViNPHJ/Uc3IS7413hix7qp1O9Cxlwc+QQ6GucIQFnx5jhKnMzcM5ZgPlItgphTfwAzJTHUTm9UJCW0wiPYC7+b5XK99sPOOAaEQg5VkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meRzJq51TJaFjpbHY4kQ7JLTjevT42KSZOFcEHGuIpM=;
 b=lAsIOY8xKvBFOzBnUmzsa7BJSyt7M8/EiW1q1TS1lrvakeSyBhDW1kGrQ3HFQ6Vxa60FGca5oXh0hw69rOwhe3WnXrigmPA0EvGHb0nXQUuclNzTrslU8cntlDYaAYCK3pgyMuErT9M3RsPht2+3kkOo1zdzrzQkhD+DVk74N3wVGLR6Syt2IccOc0YEJ52R4h7w793aXLKTncIBUrWdILi0aFGX0Y3PJnEFEDJ0toRD2LanVhrwLBU5p55MfvGREB3swME5/7wV3r/uwGmOt6ZUcoKeiQSCiavj5/zq+TDUqPA8NkJoDcMvyEwuorhMqTcZeU/W0U01ZrUrGpF6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meRzJq51TJaFjpbHY4kQ7JLTjevT42KSZOFcEHGuIpM=;
 b=p1BTIfKOf/4KaNmNIv9kUrgnatGPRT5CqpxwGCDtXJPR37nq0kKLSd6wz7lLfGX5yf0NzEkhi9YxsnJftWYLB+1HveIOiWv3ETX9gayiUGI9mOTTkS1SGzIyEDlYKjZSirwnhfX6ZNgE7xcNTstbRYBJHtSgjp0KB0B3jh1etDs7GNtzXdVAC3Yaa5aI3veGcJUwNqrRlRpycab8A88PafKXmu5V7/TDakN0avkoimJh7W0CnrrY2K0wxsx0taStvkzpcgfJptnkw/sOj8Iqi166gnY5GPC/Kkx4K4pvCTab5Oy4XAicdEl9jiVdZSA9MBBuxWt6Bigbsx54YkHb7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 17:40:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 17:40:06 +0000
Date: Fri, 8 Nov 2024 13:40:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 00/13] iommufd: Add vIOMMU infrastructure (Part-1)
Message-ID: <20241108174004.GJ539304@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0951.namprd03.prod.outlook.com
 (2603:10b6:408:108::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: ea30373d-78b7-4727-7a2c-08dd001c61d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wbeh2b3ZWjOub593CvyHlcmMV1qZW1p2qbYXbkKkhXwbTqcfyFbBI/YsKOsv?=
 =?us-ascii?Q?lO9L8ewtISCVXcUjkTOurWgFy8Wevu2kq5czUL/gatUCZj8fE78eXDp2wTmR?=
 =?us-ascii?Q?gxjA3pmXV4Ll121PFzf3gYu71NJZAic55xjvvOpUMucKgJn6we/wsUrrBXa3?=
 =?us-ascii?Q?TQzBk+Dc79027wpF03/KO9olMZEZpAAchlqzm07gpQ6uVmmhKzxyEI5lE1vU?=
 =?us-ascii?Q?nM4Jf3bpyRh3d9mCuaV6VL88JQnQoH8lFYZQMRmufiR42rJn7mMKWekflr0h?=
 =?us-ascii?Q?jsLJWXpx/Yi1qoDfynmY0BC8weDbzKh7k109GfmHZLuq9ispcjJ0nUWMljgz?=
 =?us-ascii?Q?BYwoJdmQBPdPwFcErz0KaYhbcQVjghIf+wFUJYthIIM5DfdKIY7pnT14lINs?=
 =?us-ascii?Q?pzMVUJ1Dfpmaqiy6xgUA9Fa5tSbl0l+EkKlLCxqSnu7XN+n7LNiy7Z4af/XQ?=
 =?us-ascii?Q?iWU1Car0Z2xumTWvzLQleGFOs9F4pcgnWQ9wwJ7ZrIY+D8P91qvA0H/DctJL?=
 =?us-ascii?Q?+bBXZu8PIOg3m4uKmOlcqcbC3F/1dQzDMUW68lsRWevtIS2NHUrtN4EHrjl+?=
 =?us-ascii?Q?dMUXmVtxO7gHIuvosPFFXs0THiEomM+SARmf2r13aRoRfZQHKrwYZvZB1oVU?=
 =?us-ascii?Q?sgLIjP8ZNyCfbAAQ+4JqbkhxpicB2ySk+52cOZOaEQqb4FdyLEDUgmKT8vcN?=
 =?us-ascii?Q?aOFoDIc+fMEb5hulbhk4Yn3p/BFVz/kItiAmkxnooSM50CGtHjZFFEAGleXC?=
 =?us-ascii?Q?c/HgPmcGzf1yDgA9g3a1sIxVUQWWm6mc/XCFsYaVn2REB4YP1iICHw2l9PaR?=
 =?us-ascii?Q?+i/GbUIYdpw06aI1iDe9Q7r9wq6DNTO2JB9MLXkoIRSASkQ10MuVb7OOmBt6?=
 =?us-ascii?Q?8pRmPrLDivqipTf+yl6N6Depm45zdkSdVvzuRBYEAlPns0z3P/6ZGrFJITEn?=
 =?us-ascii?Q?x7pmHwGhGjUeraThEW0OhjB4VqHrcbugQMC7oLN0p57xftJXJhYBF6R/orhU?=
 =?us-ascii?Q?NvmU79vxd7R9mhWIiWPJpLlPCR+9jDjs7XHJaJTQvHe11d0LkdQNBnxalsZO?=
 =?us-ascii?Q?MzJTOq/QueIxzkHoRsjnmchBA6SU6A4d6N1nnIf9TqC5L+Kgik2vhcHVLgbK?=
 =?us-ascii?Q?WFEDvjzOvmrS2/80eY6NQaKyPSskgVPdhKf/pS9OHnuQx74HusgdIM0fGLB1?=
 =?us-ascii?Q?/jcGXJm7/L7Zw6GyWU/J1I7x8mq6HQNVYVpY1xNzZW3u0iRax2U2JKEzzZKh?=
 =?us-ascii?Q?NF+AoCNsmOPFn1pbg9px66oqHWtiFMERM02hlms9kR185Li41w9jy4HB/f0x?=
 =?us-ascii?Q?iNlxJWuhjVyuhLUTGTsBIz7p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5w4BiH+1nUQOGNDWhbB9eT26aQn1J5C8Wcm1KOUFhfrPW+2E0PJlJpV5++C?=
 =?us-ascii?Q?IDTzdcFpZI9jxD3jZXxsAiyTJa58wkIbWXlAnfMcInF9pwvGbgiqkCNRW94U?=
 =?us-ascii?Q?1I6SB7wlDFKpob0LfzbdJLaFGHNOjx+7HKvWg//zfkO1Ut+x/mVh58OhlGJY?=
 =?us-ascii?Q?nzsSvrTvpOmRmcjKHWTud8tAantIw0bhD95b3kadOqjZ8pyqpxGFu+VrM1iT?=
 =?us-ascii?Q?DgGjH5Cy0kWSZzjrSa25CcTZhb3mh17FR/5zegihGfYaVnOraO1JqQhfU+pw?=
 =?us-ascii?Q?a7pGUoJ4Qsu/rXGhsBHLHZ+bE7BMQHP0iVzBw2amz/atw69d4o5FIi0+3bbD?=
 =?us-ascii?Q?VFx9V6d/Av/io1EghjS0XkvaNWtFDQychuM8nOfiBnE10DevM7+igeAPpVa3?=
 =?us-ascii?Q?bPps6ehy/WG6/YxFwOjl1tilvhaDuqBgFLpTyrt0AFNnhdQ4EFVR0EmoqX+R?=
 =?us-ascii?Q?m1e+caecHiKcAy8cKaI08fYCDyLALEUvMVEZVy4RzMTnpParwzvE1OOs0iEa?=
 =?us-ascii?Q?NLCOa+Qf6/MfL0wHNY0TiY/J2dGJzt4Tw3VHaQNbEIcVrHHCFbjbz0oqOkyj?=
 =?us-ascii?Q?xLPd7cDOmZOrnMrWdjx0T7SdVaqAbVZD5pp6GMlj10LIDIMG2RlquY/dbz0t?=
 =?us-ascii?Q?ybChW4cumUMS8ye1JtqDw7F3wCgoe74QreyfG2MIUfvPHnkWSSquL3UYt6oJ?=
 =?us-ascii?Q?FKLtnkWiAIE8hVthxg3jDueIZTMuqVtrGvHkZameO7a5/R/fmfxVPfTN+8b2?=
 =?us-ascii?Q?8w80y65ONR1wYZ77WU2dGNjzipaF5h6utSPc7nzO3kMQ+E6QRheAMwcaZpc7?=
 =?us-ascii?Q?Guuo8fo01lq+J/2Be1HPF9D+9ufN220s796VDwNjhfMyWUUhFrJME+YUZAg+?=
 =?us-ascii?Q?Nl+ErptVPnWaJihylSzk69sLjraGsZu4YXhYGT4Cop8Za6UUk6xfHbT0C4JI?=
 =?us-ascii?Q?jdLv/WZsRZZcYTyzYOLr5hqFzSrxblgaZoFdPU9CFVSPBG7VJj6wN5K7SHM1?=
 =?us-ascii?Q?Vmai9Yl/8qEXuLDsmUPVAtq6lpSAyiJ9eoQiVadnU/XoWGivHPQ4F6qjpHhB?=
 =?us-ascii?Q?EdGhGKgI+hjnb1kHzI3PrTn4Z0PUpSKGOXiwtOqmNtnfdc8MJFSfNyA90u0R?=
 =?us-ascii?Q?/WM3vARL3+bUGdh3RWK+TeTrb+eh4zLTqqlnmoTZ2ckqK2FTWquCEPoov5wG?=
 =?us-ascii?Q?dnXxnef8ZEZSn/LnJRVbzU25na75jk+uJ8IlRb20SZqosKKqTZsyrcqtBFnI?=
 =?us-ascii?Q?W0Ozj5iDQdloq/JB3whYQYuQlVs6UvB7XaJG90f7/2RFYTmsEvCD7Wv6ya+1?=
 =?us-ascii?Q?7u8D4DqQhcin/iixKpLXiIXFPl+XHWal6k5awrm2Kz7SA2mcmSpxF75p6evA?=
 =?us-ascii?Q?cUfktvESxQdQFFj2ikz8Z2NNWD0dO2emD7ceKdaBc9hqzBn5iCq/yWt6mcVS?=
 =?us-ascii?Q?hOkNVmESg6r7j/pZBmZQSfpq2fe/e7LoOmGKHB/EdzPrxnfx1sdNCqkCgbW+?=
 =?us-ascii?Q?GlE3I1V+s8dOQLSP4P65nMrV53dWDVXkkYBgcsWaCbMg/Qfn8vNIy21BFNL3?=
 =?us-ascii?Q?kEmNIu2WO4Avms0TAQDHX8K8lRpaFTapRbXwdyCo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea30373d-78b7-4727-7a2c-08dd001c61d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 17:40:05.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3wdK68Ah+nBGHdW5UBiP1L1VbIr5uAE34+pddlpDEvu05mlqlzMlO/9lKW9qn+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203

On Tue, Nov 05, 2024 at 12:04:16PM -0800, Nicolin Chen wrote:
> This series introduces a new vIOMMU infrastructure and related ioctls.
> 
> IOMMUFD has been using the HWPT infrastructure for all cases, including a
> nested IO page table support. Yet, there're limitations for an HWPT-based
> structure to support some advanced HW-accelerated features, such as CMDQV
> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
> environment, it is not straightforward for nested HWPTs to share the same
> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone: a
> parent HWPT typically hold one stage-2 IO pagetable and tag it with only
> one ID in the cache entries. When sharing one large stage-2 IO pagetable
> across physical IOMMU instances, that one ID may not always be available
> across all the IOMMU instances. In other word, it's ideal for SW to have
> a different container for the stage-2 IO pagetable so it can hold another
> ID that's available. And this container will be able to hold some advanced
> feature too.

Applied to iommufd for-next, thanks

Jason

