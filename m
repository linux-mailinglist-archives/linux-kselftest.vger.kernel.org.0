Return-Path: <linux-kselftest+bounces-15465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E2953E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A004C28356B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE24156677;
	Thu, 15 Aug 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpRlQ6Dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A357CA7;
	Thu, 15 Aug 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765334; cv=fail; b=FaW+zfiMm8xFgZayHG8akU7Y86TouGaSNkjw6tSuQp9NrLJoQUwCO7jdK0+hsoAUWKf1xUEe++Zruq3dRLEhX1mW9xS0mHGXzam2qtXtgFfkqDU1qkfZEuh404A23A1JUiDbHPBorbaJuyI3lieE9q1I/nuvMBwqje0myd5FtjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765334; c=relaxed/simple;
	bh=Ic6XEKTpvc660wgd4Bvk7wfN2+Hi5CRmwz4fKF7K1N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sd/2W4I+3c0zrky4cvtymsWujeLSIx3OWph5Ks0nxqKyGmMBGRWscqiXHHzmABnvq03WGu6/y9vS363Mivr9NmFUrrlO2AaxJVUmDJ46pLh0ne/kadfJr02gz6XJnf/tTTcuPEp08KjBMH7ZV738ChjP/gjaWysQMg3OdYd/Gvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpRlQ6Dp; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc8RGsyaHnddF503da+QxMkan+J8Fn/FdhyEGYAlp2tn0/x6D+7J3ZWVcyg/p7GBdHMfpyqAo7Wztw+fszA6pIFJt9U+cJZup42rF53thx2HlP1HrwmXO4mD7KKvavd4DWLCUTd/t6hDI9/LdPKJKhUZuzTMQ2KbXggq+d2R1M3dCawyY9WoriLQ39tHVyefy8LGUTDU7vUTGt0P+s8QbvTMi4di0HUzwJAjc4ioWRWl+vVyOKrOGAlxD+nCvtsX3VCD2ae0oc9rEAV8QHwbTO3if+CaYSXxlqJ2JgVf3NlAHWVwW3Wb1A+YFBDKyfbKr0/UtubNR//7jfB5ktTJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnRO1a39r8KE/2J6GbMp3seZ5nJVs59ujGXDEWAn3k=;
 b=cb63DdmyHcfQDIKSVAygL+b1mDjqDMfPme97pKYQx8pHXQStF6xGZSrbyS1WiAvyLEdLpcBx+aLCtVfOmEVWZwpL45Hjs6GKx77QNZ/nPVK4FhXYFuCNY16uZcbOeJ206cWJyFrjOM0aCWeW0xlr+n3aLlYhkU83lHFoMBw8amwDplu21HR0bZ7BllxO42zAksEFvJXLBMyloPZWletXZ3LGuvy+ofFc/69Uy/6JUDLVmKL12eTbZp9qyoueFk6VTob3mNMKkTYnydy5MyQOrBBWjMISeg0mA0MkeR04V/Nm9ldIYQit/JBQSrdJklrO8+5bW6srCdOa2S05dy0YLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnRO1a39r8KE/2J6GbMp3seZ5nJVs59ujGXDEWAn3k=;
 b=VpRlQ6Dpz0KgbcxaFW25TRI1GzVc2tzBjO+/IzfWv+uNJS0dx9rP8cJbgIY25nUxSdxNXnkbU0C9NzBLjlGhu8FZeWmMXVrkBZw/pE+nw2QqHQtBOk2xSBGFya8GsBe4iW8hCrXTDzsJfzRTZj4655R++71YtpxTdcgdtFS6IEXv5HLP+hi9EOziD48X+EXvgiti7oDz+yeP8v/8sbRaWoydWRBuOL2VHM5ldvfQ4ZzNlfcTM24cUkgxz99aGFg+QrPt7BpiuYFmbhlhWZtq6OsolESAXRPUjdDEiQ5HvI1nHTsEwvkvuw0UgcewR0tYwYlD629i1P2n5GOQXbVvKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 23:42:10 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:42:10 +0000
Date: Thu, 15 Aug 2024 20:42:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20240815234208.GY2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
 <20240815190848.GP2032816@nvidia.com>
 <Zr5bENKAYJTvwEBJ@Asurada-Nvidia>
 <Zr5coJScB7AM76Wi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr5coJScB7AM76Wi@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:530::14) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0c17cb-27cc-4499-7210-08dcbd83e1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGqryB1RKfn/TOpTD50feocjH0Tg/3BjHLUA85j39fRcdtUWVTZiUcApIajt?=
 =?us-ascii?Q?ohC0XqBi/qDWRBCICnkk/u7Sfz9FKcUFNAWCh1SKGjV0qg5bTFeLlyZ44FI+?=
 =?us-ascii?Q?/Xmde+xwBPbOwtec8sdVhTYpcuLvWQwTAic2ffYmEh5MB8fyVYA2XollTzCV?=
 =?us-ascii?Q?ik3dmmv10jFoY6zFpdX8Tn8XUkH3J6VYMlG8hXqSFn9U19T6oDKohPVAPEwB?=
 =?us-ascii?Q?HFF7yherA3LK24DJo51ppOBiaa4+XZgmqdxFaZ39VREVT6GrpX4ucooO0K+R?=
 =?us-ascii?Q?2bcoN0qyOa4fs5ADYLCdl3rhGIxG/kZl4VjV2IG3Brcjf91aQ5E4ZzEAEasR?=
 =?us-ascii?Q?z5vqqUfT5jgW1Bi72xNdrKMiXz8ESJ6xsERqXCimEZCbWN4iqPAwwBnHo3Cs?=
 =?us-ascii?Q?lyZHFZe6Oq83ouymuzzULpDQpDBaYutNWKMrgb5RAQrRtkK2ZgxVmCvzeFu0?=
 =?us-ascii?Q?/5WnHH2ba+J+QKCDisJkXgtNK1TvksIr3BUSohtkAllNLSbDo9pPbijnIUpj?=
 =?us-ascii?Q?uFAqCZWcCPWasRub1xkdC7vfoEmy/wW93sDq4QuDde1f02QBn2nK2uDlTxQ2?=
 =?us-ascii?Q?9loUwi4lOsUtsZd0QSjcNFMbtd6JV1DiQoPcNKaXYyBbLbjvJGLw4iJq+thy?=
 =?us-ascii?Q?ywFIZGehAyIA/HbqENJqwQDNB180ldbRmiBIGpfLUcCr8Q5Cm35mSZOcaRzd?=
 =?us-ascii?Q?EV8Bv/soc5TMxfjBkqJnmf4EqFhrOZUW+yamnBn5H9/w1d1WEU3evxq9PL9o?=
 =?us-ascii?Q?ZJxE5fTZy/xvtfc2nuA3bVWui8Y36tXzgxC8FOJgPbUaROPsFuM2TGwMZNQv?=
 =?us-ascii?Q?yTzv7U50DrirvFHPQ7lXWOazGYtzH5/LDu1letP24CH7ebIMB82LNhXIm6W4?=
 =?us-ascii?Q?gEeUddDay3F57q/n7tQIhzyCdU0kTwHjMob+iU4o9laNZonwUx5N9MfDN5pD?=
 =?us-ascii?Q?qbIapwavNtShXx4VoZD/OBuejXj/m+Q1JfustgS7BHwGIXPgAq9ODCwXeOdH?=
 =?us-ascii?Q?+PznUJOUmkWW1W0VOejgv+7i9G85m9V2BuEDnrtgm1y46Nid1e0+TZx59oHj?=
 =?us-ascii?Q?+NdCASCccJSdiMS5xJ5wYIMvkSTK3VhEDtwQrmG0N+6o7++7CaF6Mzs6xUQ0?=
 =?us-ascii?Q?RWkM+V9+2nYzXqky12lJinLCKa2TIaThKdaHSF4z3P2jVU82sV0UMrcOhCgB?=
 =?us-ascii?Q?W4n5dus/f5+RtK/WczJMXGtxfMW9e2cABvd9sbiAYfRSBVGPrIGYBDVcBk68?=
 =?us-ascii?Q?oINCtWjTJy/JM3rpB356FCST5VYmAQudePoi0+m7Ya1P8ExUzv0qKrg9dO2N?=
 =?us-ascii?Q?uNdnSzG+AKwLRG2PXdJ0SJpQJPvFdjGb4L3ORqSZqBTbHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0sLip6BrCqBtbmwoP0E93mPqNqAn4kbVrbxC6b3KqY2Tu6dQVQPeHzwxc/U?=
 =?us-ascii?Q?SwRAySVUJepB3Fgb7fDUyrL7kuzyASrC+dAETO9zld1Q2hEFFHHUsCAcqz+B?=
 =?us-ascii?Q?XUlb+cG0B/VU+Sq+bBUcwaQ1cBtzm2S/rNJLZm+H5PHIw0HsjRK37cj4W5m9?=
 =?us-ascii?Q?Jp768JFNdBfREglhdhmSnyaIFKxya8HQ27RKRN4/pTmYWbTdUPANIm7B7mwo?=
 =?us-ascii?Q?AVmQJ392o9O2ybNYdVUqjnREzsazLZG+9Ub8v1L5VpDgtGRlV0cKubRFbTdF?=
 =?us-ascii?Q?JvKoL/neY1syHfD/EkIw1hl2nT5GM1KIMnMEX88JxTg+rqUEUErpPOCriFl9?=
 =?us-ascii?Q?NgsYmqY+5fN78O1nag5m1dOib0avP6QhtEz7Fr5619K3XuSE1EA9yuUcmvFE?=
 =?us-ascii?Q?OMCsGDgco7SJT2jPlg7lc+BgjU//KeZ7LO1naLNUbCHZxMjF1FqRxpGbKMd8?=
 =?us-ascii?Q?L/26S8nkKsqs2rYzTzDik7Lsn6005xNgASmBaTBtQSExMOFDBknNIiBHFViM?=
 =?us-ascii?Q?te9LIAPrPilt5lLc4+1OuIQlj0Nscl8qekQTuuP2nTNJLlhIynEGYmplUTsx?=
 =?us-ascii?Q?w35P1vzAlHfKp8Ct7TLLd7+3jI3zwJQtukVlqHY1L7OaekZXF6ufuxMincVM?=
 =?us-ascii?Q?XSF9DdQI/5d7SgxoSsq5tNL/ofjlLh+3EGruryflHcibxmfthBG6ZAXguxb1?=
 =?us-ascii?Q?Q7MpjuYfW7+DBdm5jqhoTyBMb1FQAJ3zWSPzRA9BZuzJzKGN/yLi9sew0Gpw?=
 =?us-ascii?Q?YBEEN2FLR3+/ZF5c6hbPiRJksKb6+azH4/aCrOelPMVwPzpDH0zxhexwlbhB?=
 =?us-ascii?Q?//blw2SJZn590lh1yNFTI39d5ezcLuqCUjgobLCGZFYTIfHFl+bfMr1e6eNB?=
 =?us-ascii?Q?aaBryCcrAdu6g36XtMZq0Tf3oeKF9zym1lt/m9+yNM6AKgBoOweYomhPG0qg?=
 =?us-ascii?Q?Q/KpN+sRswyGDoqwgbN/M+U4B+aFgHnRgZOZUZLbgritgBf49TwF0NtBB+7i?=
 =?us-ascii?Q?rOOt549T5K4IzbC7cuGSEoVV8LFKz918hkPewF0Mb/rxdRr+xQT+eSiHp22L?=
 =?us-ascii?Q?x/LS4EJWS459bMMw+MGyjr3U7RQqc7BcRUgtev54D95lAqvJi5hnjyemnkMR?=
 =?us-ascii?Q?SOTS6HIfIoX4unvayUYFNN9dezDRTFnYyIXTwXH9CWJSaQSF3RQFTUCM3hxt?=
 =?us-ascii?Q?FlvBiSvBxv/26ZLVYlCF82p/UecIOwnfmJHxgRem0SKl1DYsimLpHSHvbCEN?=
 =?us-ascii?Q?qwQBuK0+4TQdzWDKy5WW9Xa+9wTwhTFN6ed/OVx0eDPzDbw0adYy06xELMOM?=
 =?us-ascii?Q?YyowAwPqU498CaZ1TH3qcmePl6CJiefFGnz5VJ6HrlPzeDh3WUzYnAJLxN0d?=
 =?us-ascii?Q?NFeWRz21rUC+tQComu/jqFcKRTGrpanhAopZBqd68C+a6z9maKr4Mg9dReRD?=
 =?us-ascii?Q?DZM4HtxnmcwrUb8qcAKvn7APmGz9blXF52n5DaWrhtm4wvgwJgZI5CEq2x9Y?=
 =?us-ascii?Q?aOVBIKuI81CgdP/pjMsBdqG8wHldBRWHkjBDr/EbPbBIZ5UoltS6oW7TvXxt?=
 =?us-ascii?Q?tYnX2MhuVnS6eGo8pyE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c17cb-27cc-4499-7210-08dcbd83e1b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:42:10.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DCUn8vTpGglrwhA6ghFrcG3Y5OOqujqQHZbcs5DRSPF0g5cudglkBH4OK/ti+LK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On Thu, Aug 15, 2024 at 12:53:04PM -0700, Nicolin Chen wrote:

> > Maybe the iommufd_viommu_invalidate ioctl handler should hold that
> > xa_lock around the viommu->ops->cache_invalidate, and then add lock
> > assert in iommufd_viommu_find_device?
> 
> xa_lock/spinlock might be too heavy. We can have a mutex to wrap
> around viommu ioctl handlers..

A rw semaphore might be reasonable.

Jason

