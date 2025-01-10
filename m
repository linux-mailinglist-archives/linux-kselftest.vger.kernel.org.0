Return-Path: <linux-kselftest+bounces-24216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA6A09476
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9E3ADADF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60621146C;
	Fri, 10 Jan 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i85r9kYx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730720897C;
	Fri, 10 Jan 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520714; cv=fail; b=tpwEFOsOUS/0J6altV4dUJg8v0b/sihlpdQ2nffIsEen741X/EssbVBDv8h5qfGpN+lkbyfwjjeVx3dNKbXEW6UkbQqXEe9Y55oOU80/1YgEAAEaqMhiFHtodMUCKEtJUQqGxGpVcUXC09qH5ZWlotV9DKKBx4zgquNyV6pnw2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520714; c=relaxed/simple;
	bh=MwkBvNnjN1ywUqgaOGte4I0c8lRriSplRFxnkPDIMGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJb6AeRneBkFyvTz1Twga5QRZfp6vtQ7R3GEoDKTBAtBxAasuqSWXWMHhqDXE8iE+lVwbof3n7UhHZkms308B2ZgKi1TEpbeAJo09KFHCfyLR9+CWrnlto5/2CVrBUjqyxjXbfIkHdMa+x0aUpIYAyZNHOItwb7+oJBVc/Kmd4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i85r9kYx; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoXhJyeoe/MLTSTYGLeTo8gxoXwc4bUGqUbjhEHYChM27d2ni6I59QGwT0YabBES6cxkwLZ4PB8ON7NHWe3AfnHWRwtu/YJ7KIkJ+0hauKfksgieISGe3qyNOc8us4msLhcEj0GvHjOo69MYIqM1qD6oLWp/nUx3TGDtoehGHUuDhFkCwhn7gMeNXS2Q3Ki2HYDKbHR6LMunpQQTA2Ut4lkZS63VuCuVVScqyKLgp5Divs1UtotvWprOguGiuLiDKs79jwfgVmjcS29TD/B0TSPaBRtOsnEzoq3auHke4IHZVkquXcGTd41VwscnXuolLA2IOnu0q+5ZjLjPo2UT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nKXWJEXYkbdUCHl37CqE9VmQ1BSykBrBQ4DRPMLqS0=;
 b=dgdAv0eU3XStg9072CDmH4yaEi6yHuqyouvORWgsCDiX6+u51XQfBh73gXLSrEGtbR6AXSqIjfFHd95hx5PtJah1ZPs4h7F6XZoSgWjY5w2kbSTdrAwCoo+BaBHrZNjs4rdkbIkGSOcbHBk01ZhdzfdCarf/RPGYrnshYZfFBrCOlpAhubJdYQeYr8N8FTdPpL+csF0GWDRPdo8LRYPWxHDxrlGSuJJnCAEqQifO1tMOvWFbh8UJt7Xm6oCiFyREoLkjf1OZXZ34FNqkIpxO15pMG1RjMxgLcntkvV3ta3KVo3og7n+aLGgrb+FqomLjSAE1HOc4h1TqBu9HD/8hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nKXWJEXYkbdUCHl37CqE9VmQ1BSykBrBQ4DRPMLqS0=;
 b=i85r9kYxdNp9sRUFZFKfmHoEtELYCIunv4UpWq72cgxvMyEZmTkytWmO/djS0DMy2eKacKcG0sD8o3Vi7+5/JZDwszWM4RbNXx6kKFJnvlAM5BZ0GQaqIcQ1nJqmVy//M3ffnX9r71ckZ6tyYLFpl0s0xOVQZBaglfNMblNd4p9aZul0p4eQeZcvhMSiZ6mf5l/pqK1ErTTZh4G/YIICEzoZgoMvRRx+xyWpPQ/gi9GV3Zxq3fg6WioBN0CFawRdteqyYyh3g8ic6EfHJTs2Szvxo+dQ1tJAV3LPtXSL5NNiBw01GQmI0BqPHWpidMIyV9M72UT+ZqbADtxeqLXMpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 14:51:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 14:51:50 +0000
Date: Fri, 10 Jan 2025 10:51:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250110145149.GH5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB527634DAD9FE43A6DD50A2348C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527634DAD9FE43A6DD50A2348C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 157bae20-7fb8-4bbd-9397-08dd31865055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fqla3qwxd+I5o837BUanwO4nlNpo+x47pjaDhVBzhS1fVuLwVAIYhsS7AYjK?=
 =?us-ascii?Q?tOkT79u7Sg2PEN6Z2Da+fq2o5N9cJkXA8E7Ty7wou6ZN69h5986iGqrsgSWM?=
 =?us-ascii?Q?F4lLZUU4Ir6/1DZveMxpNrt87GzKsCFGI0HRZVgWFovVPXnZgcKr815HE1o9?=
 =?us-ascii?Q?UVQIn1ayfqOshiQF/2HernaI7rBOgTAHWOsP9Mrf6ZFCksGecV0kvq6KgOvX?=
 =?us-ascii?Q?47i36XNl0oawgAzy0MyYxmUGpKodBq7rFNvvc50BRkCwPxq0GBGQqR8oAI8v?=
 =?us-ascii?Q?3QytyD7YlWmrEfFv1I9Z2bN3kNj3DI+a3XBENu/M2d7oqfQTic2yLa8MzHnc?=
 =?us-ascii?Q?FuordSdVv/PPmMYGQtPLlfELEkZbziDtyztYOFRPZ9y9JAy5vdC1DWAnHlch?=
 =?us-ascii?Q?dmP3F4ZkGqG+WmFqbEbCdR3SEM9T2C3qmK0d3W53UwaWYcA+iVQ3cNrqOCaM?=
 =?us-ascii?Q?X+TRK2k+c+F+Oeu/ihan2MFwGRk2xByKI2xWZ6otL37e3N7qobmrrHyhMj/G?=
 =?us-ascii?Q?JSKa5EnfcfVFPi49h2xiRdRpSGkOmXaOw5TQFMGa9iE9dUlUFzF+50GX/3qQ?=
 =?us-ascii?Q?9aE2TsMkK+40ncUejoFKj7dVDq3kYvTiXGUnlHDHPYWRW2nKdhUdsgsO5t4K?=
 =?us-ascii?Q?hCGauRzK191Hk1zK3o/ZWPB+/bLCLvdu6Smh3zb40Z79UYVjru7Iy2lpy4an?=
 =?us-ascii?Q?ykTrY5p2bk6uOV8o0Rfbvtmj0H5t3aS2B/UUbrRq55dccCWh/l0UYRDcECtm?=
 =?us-ascii?Q?Tux8wbpl6xXDxLT8tcJPneyuNExbwJ87o1USlxcN5da8YRkQOzX74anXUhv+?=
 =?us-ascii?Q?ow0lAjEJW20kQD+9+s7U5TYakO0OhCZfA4/zJ5cGN9/Q5eZ109gzWHNcGRlD?=
 =?us-ascii?Q?ibEeIw9SrS6wPph1RbCjONF2HDXQkSesT6niy73zPr8+inja1JbW3YtOIssS?=
 =?us-ascii?Q?YPmQzBLvagCFPbacH55Fa3hSSHqI0Gk5iGSNabw73tDEUK80xbNhirXMyUkd?=
 =?us-ascii?Q?heHqucMRiUCYy9UzpCPhhUg+v25Kmf8ztVZqJntST6YCCFLM7DmmU8vWTNVr?=
 =?us-ascii?Q?fLyX+lRgeavrPFvmKA+1qweW9Y4yskSsGYAw3HorkwzmiljtLUh/SrJH26Hr?=
 =?us-ascii?Q?Rtafvdl46amunUvjUI1bOCQ7onHTY5PzM616oxFxw5hsLV/BW0x6iz7SMa9m?=
 =?us-ascii?Q?El1vUtJX9ic+mcmyQC5uE/sQDEA/FKstrK/37Lz3vEARU4+N9rcsJXRVCE+h?=
 =?us-ascii?Q?UUpnYMdoPnLjgr7fGjv00H7CaH5Pg8941R5sRfUkcwpnoV5AIlcNpBs/D8Oh?=
 =?us-ascii?Q?YsuKe9gcUmo2DE4B3qQmMgmUH3XuAzrG5/J/i80j1bWbx4s4c8XUY3XxrF7y?=
 =?us-ascii?Q?NbsrU4uCY4BspOOynCFXbV00lbhj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sa20j6sfXylIrFq2c4V7jDomIkM/YJ14S4BvgAGgp0y5HfjZwvciU4fAv4/a?=
 =?us-ascii?Q?p8S3RdTDhcd6woRLGXzKM5i+3Lu2a9ytOF7aG/4csqlbTLtLTBXYQ3IaOv1K?=
 =?us-ascii?Q?PyT9GxTTlGd4w/ccXMY8NmAeQs0AZ5e3IkfYcR80sBjvZpFqvz+gd8p0LQh+?=
 =?us-ascii?Q?OHHVcsc1BSdMScOno4F9LxilW/yLCGxdIJ0f5AVg7E7ElJRxzZrvcZAMkK3M?=
 =?us-ascii?Q?x0HpIJ6OBKTuroE4NcDCKeNStwYEfYST1socdUdSBAgG3W3aGNOrvJL+n0qF?=
 =?us-ascii?Q?mkFT21yV8FN+4ngPlZE7VFpstdfLsuPuBRSe3uLj2x6EVTscX116YHyiYFVQ?=
 =?us-ascii?Q?wBeSJ7JBAy2ex+oQxKYOOFIhbmfynSkpkRVNAhi+kULs5PTQ+yrSzvORwtUk?=
 =?us-ascii?Q?f7PMyaBYW9aPhond4oDm+JfzcpEXSA2K7ddS3NAXjTISKergDr2I9cwu9BAB?=
 =?us-ascii?Q?hCCE70J+DT0i3aqsfj71JRKYwivBgrU7VWJKe6AKrhgIqmrtzV7drkzZnE5w?=
 =?us-ascii?Q?afslyxBA2EWyoul95Umt3awk1g3vd/seeCsiREv+5aDiyXAbTq0Rl9vlejEy?=
 =?us-ascii?Q?zbCu6YEhsm5CRbBmGOSdm0N/XIync9RMEfq7GSwB7tqz9sGZwtkWvOnMOcD3?=
 =?us-ascii?Q?U9zX7LBAl0tqhgg4RT69/9sBaR5ZIdwoGPNw/JefWB2Cx2DSWgeedeMeIuaW?=
 =?us-ascii?Q?9wD/dUZa1o9Dv4TtG7MfAC+XAJl0ywRarhpYEvbacBn6isn4PENp1P+jT0B1?=
 =?us-ascii?Q?GoVaTV/BUwPBcA+9i8Mq5SwQvLCqVRWyVDUn5TmpctVV4X4zpiSDohM2oC24?=
 =?us-ascii?Q?xdn/d87UBgn/o0L9vuLVWMmFfEFS3bDHtK3+UKTgiFX9R82p1wkVAJ8IsMq5?=
 =?us-ascii?Q?10LDHMjFfTn50Sws+fk+MVcTl0a91k6v8/wnl/XBbbD8UAv8KVrCoIS2NpdN?=
 =?us-ascii?Q?dHrHymKNSX5e1l0/90Cc9mkGEDFTEt8wXj1iFt/AKwTAQHMz16UCaw8RUBNl?=
 =?us-ascii?Q?HRwtX110FJKJEaH62Cipt/5jwcDEENIBDiqnQ+ylS5EsXfmgJS/d11Jizu6O?=
 =?us-ascii?Q?fyuiztMXQARdFR3l/PM8E5MjDvUHr/h2mq4/OUh3QGGqv+bW0Xv3Bv/pWxHB?=
 =?us-ascii?Q?F9utKZKhnUbkfSHC3UM1DhRdTBOkRLdod+uTKiydlQe2slGdN7lajD+Lrm9Y?=
 =?us-ascii?Q?NRCkFj0DKeIFZZ1hc2z0H1teaJb5OJIFHfDhAeT/g/V2SZIwrzvgwS1NHmAG?=
 =?us-ascii?Q?js/v5jEZLfIQz1rSpNRkkBGHEbjFKdgtx3zauB3rXPGdrs6Y/CKwYrjSpTsr?=
 =?us-ascii?Q?P7vhhcOk0s5RZmxb9ZxEf1cp4kZ6XpwsoERWZBz7tpA2yFL3AMpZW/pW63Ha?=
 =?us-ascii?Q?iMbFQX4DeTxRsLPS1gIX8g62YRu2zgkP8TjhKqNhN/k28uYS6+JkI9ql35Hr?=
 =?us-ascii?Q?YypX4Mmsx41ai+t0g1sAyDkb3ZJqU3EgQfVPWD6Nen9QDnNw6tIO8tz9Tlz+?=
 =?us-ascii?Q?Me2gWTsAP8AFLSeAR5pLL4P/wueuT6+MgRhKwN4P7U5xXMBH7jpwP5zMlVdg?=
 =?us-ascii?Q?bfmrhTVI6XNTQlV0xGGu8i87Qxwo1qdJri1+X6cG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157bae20-7fb8-4bbd-9397-08dd31865055
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:51:50.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU0HNpXyKSlMnSFVrM1PXqy63YnTrFd6DpsV7aauW7oHrtf1CQq33iss01pWSuYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

On Fri, Jan 10, 2025 at 07:12:46AM +0000, Tian, Kevin wrote:

> > +	if (!viommu)
> > +		return -ENODEV;
> > +	if (WARN_ON_ONCE(!viommu->ops || !viommu->ops-
> > >supports_veventq ||
> > +			 !viommu->ops->supports_veventq(type)))
> > +		return -EOPNOTSUPP;
> 
> Hmm the driver knows which type is supported by itself before
> calling this helper. Why bother having the helper calling into
> the driver again to verify?

Indeed, it might make sense to protect this with

        if (IS_ENABLED(CONFIG_IOMMUFD_TEST))

As a compiled out assertion

Or drop it

We shouldn't have unnecessary argument validation on fast paths,
!viommu should go too.

Jason

