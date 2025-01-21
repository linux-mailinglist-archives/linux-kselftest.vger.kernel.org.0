Return-Path: <linux-kselftest+bounces-24898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDAFA1871A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4313D160B47
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A331F5611;
	Tue, 21 Jan 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfLyY0fw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D451F8F16;
	Tue, 21 Jan 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494051; cv=fail; b=SKjl20Ww+JsC9GCTJT7yX+p2jTuPbsz32R4pa16CJoDHBSyOj7wCoMpRAKlZovSlizAHvjNqBvRVc9FRQvubVZvN64engCAM0uSieRQDfkw2nECmL9tbeFgkyH8RfLvE20P2T81WFE47LflhNjwm8QbTiXTAXmZJDnbPhXAVTp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494051; c=relaxed/simple;
	bh=HFHOsGdfQ/hOgmMh4dW/tvBWv0+5aNQySF+Gm2ODOAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdPZ8uqGyeV37KNEmon6mDEyeh550rO89fvn+mVaY+1/DsWFddybZrScSujDWBJkD/QelCLJaadr9Vz43Xwn335JpP6DnIrIHTgVMA5UsRmAdt96DzTkBfp/eh5PEQail2g6t9DcvGTC+TETIkMuNzsA8d5HZ0mPxpRpIF7B1OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfLyY0fw; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqsvaNrw1gmyPwaDkUoM+GuEVquC3wiHfuNEwNRvyL90BHj8oRWJs1O3zr3S14I6KBWk2hR/Q+KbFNUwSKhq7IFm3yaomj8+w9aqhnm6U5UUXrKhtmYprqAJ/tbfmtwDcP9Kwz2xOgvXsMCC7GqQ3B8FiR1FRp87p3+H2ShMy3E4clkm7n4ZVwVnIqz+DuTxzWmB79p7CXvYkr2lqQkL1/WdF2e4d50EydvhtxTXGNAVcmQvggAH0TaW9ps+jbRUt8AlCPA+1SJqaQ14jQFlJANaau4oweLhECI2VZiFcSb5KNtNvnonKGtTQBfjf3ppgdnYcvMol26wL2q1CQXdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5yRpv/jz31HxsTyrB/4XE7gZYmn9emSus//Q8MvDpo=;
 b=Rs7QmoUhvaiUKIOG5Pz6jpV0R/bNUPfvXAfRKrXoUT6aJBYLaKRZRJSiG8t4G7O3l7VdXC3ATMXQuBTKYrxh3UoAnRXHutUOs2vhyIZX6e/Yi7VNlwJ3bRJ8m+9GpaxK0aMCfbuoT5cqaRIZHIUBo7QD/B8mfqfcYwiN6HnCF0mmJcLRh9EU2KWBsh97BkjHIVtvZ2s9DQS8VWkmJoP7l2co3Tu72AtUxxObPehxyqdTikLt5bvnkz9rLt0VvFpbz/BVa0Doj4s8vTP6N5MdmwE+UD7SyQRvvv7DCNixn3uU2pechG0gsw5UapSgrf2Bz5DJrHNSU2uChGX3ySL6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5yRpv/jz31HxsTyrB/4XE7gZYmn9emSus//Q8MvDpo=;
 b=bfLyY0fwtNAzL3EzYzDNo0nGUfuFr3kYrTV9MjlOPCUEGl8sk9YHhuhu2Uv/UCo9ENYaIyRBOXkO/5riTvhLrsW0qXcjEiLk8ly2u7id8sokr6MgVfMOSBy97fHDi87DNeTWX4xQ4C9tlAThKJJxqoMAlSxahu56IaKfp3Bd18R9O3bb6V7EP3WoI/M/3AdLJ2U4QYfRvPx2sVUvwdGIcid5TkWR3j2kLAA25eQHBGH/wbkMHrUOweqIo49lkFug1ys4BAsZDWqkI+CJCxtBN089aXKAR496CtV6fUqTpslYoG96fdUZXGFmBHuBhqgItKns6gAjr4QWA1XajodKvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 21:14:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 21:14:06 +0000
Date: Tue, 21 Jan 2025 17:14:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250121211404.GB5556@nvidia.com>
References: <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
 <Z4rVg1Xg5TCiFlSb@nvidia.com>
 <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com>
 <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com>
 <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5ALWFVTOSC/8+ji@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 2899ee91-51e0-4d5e-3437-08dd3a608a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aO3FHC5sDkKqs98stiN+Vs3qx/ndnqJJnRXEw2jOT8DqC+e4srpYZfRMcOWK?=
 =?us-ascii?Q?+zZj1I/lf2oXYNIQBov0yUkbTcRVLL/F98dzdm+z1Gk0was+bfqXDbH+eExK?=
 =?us-ascii?Q?rswO8GZcUfrCtg9EhfyM10s+RpJo86jiQMOGilHc366MkrcbUMYlZ5LIXrAQ?=
 =?us-ascii?Q?tPgKpZl5G+ajAQD0oyUQx6rT7lgbRvcJuHnozARSVQJ19kTL8IKV8teMLKR1?=
 =?us-ascii?Q?a2IHzx+Q3Ftr93Id+qHI05VwivzCmUOxK41rfRl+mU4qHmU3sYgHfJEijP3E?=
 =?us-ascii?Q?XqFUh3dHRb0YAv3nMYVr9Bb7czW+BFEXG4qGyusqqlykej1DjfkCrJYLXK0I?=
 =?us-ascii?Q?2hZR3tjvGzj4UhvD8fSYlLJVAtEuW2V2d30beZH9IgkLwgHVWZ2TZELxI1az?=
 =?us-ascii?Q?6pfWssDOcl5Y+4bdQHobyc6zOo9tnYH4sKyGsU3PoO3w0QZMH6wDzKFk08RK?=
 =?us-ascii?Q?PWJF3/whLEtaLh1B86XnzwkXhFGHgcCS+gbJQJeA+n730gVSf9X+Ilr/O8Tc?=
 =?us-ascii?Q?EDdZ7JDLEfHZabO9O2GOAp8E0uFqWLxqH3LzBZGYijvnpIg9UyRaJrUBI8SJ?=
 =?us-ascii?Q?kRxUTXDYd/Jc9ByNVll+MSh8Bm9ObvSLq5gpssgyjGr8zMHAhNEB/bdb2Owl?=
 =?us-ascii?Q?5AJMVI+dtPCNaEy3B7c3rHPjWoEOt97Lxbv81co2VY6Dq4OXm986ciWw+76W?=
 =?us-ascii?Q?zIfwQaDsJ41oXXxIiO8+cqJZT6CewL+qQJf+D3dv2l8iK7pmtma3d/skuYTl?=
 =?us-ascii?Q?+ZBc0PeTfyL7J6+H3N5zis0f/5Rk01qs9dUDNGiWRIUzQ+KNh2pALoRrXqj3?=
 =?us-ascii?Q?F2ARWRi3Nesp6A8zLoh/N/9neX5wXYgPfQKCPUjeQIbSYey829suNoJmZ4be?=
 =?us-ascii?Q?3URUY7+5wIZqomDlqK0iyr9ZnukdbkyKrCjZtjl6mp1cBtgVD5xBtSFZxqt3?=
 =?us-ascii?Q?DkkQ9A5XBeIjt2BqfBXNF72IkUaXEwJYT3kzIU6w4NunFk7OVuU4tMJYSiZd?=
 =?us-ascii?Q?/UYuVGMc+TZT5sg2qg7qxxlnKY/QDI43kFoRXDYlrImn9SZH3tz96v2AZb0b?=
 =?us-ascii?Q?Jn79D8qg10HFzvEeZ87cdothM/kz6p5Htnx3C4AfTnWZ2cjzXxRN1teYF42j?=
 =?us-ascii?Q?/P46Sy6EkDDHhNFoRxW2JeMOCLDGw32tN6tEdI/OcroA2CfYne6ll8rCvajr?=
 =?us-ascii?Q?gpxSCurs9c+WQ9QipKFRJwUD6E2Z8Zg677Flxip7eaY8WweuVg+YrQr1q+3/?=
 =?us-ascii?Q?sTENVen4rJh3w1Sm8yEkrcjnIq0wKzTzb3J1NAo8gDb58lDAXU4qv2RWW8JQ?=
 =?us-ascii?Q?iZ0pV+qMuqwQRW/yRjplByD+ludhtb0bAVfzjyQXbxjewSG1wT1GYOA2lMS4?=
 =?us-ascii?Q?Nbx9hCkugfQ8Dme+e1S/O8rwASeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EdeBN9gd0vD0pkPmnVuZnEnoOSB/RuQ6vbrm4DVFJ5tTm76676zL8xZp0ekd?=
 =?us-ascii?Q?hPKIbrSlePhWxSw89H6UXTX/MDsOoxE2DxdAmvoLA86iGOhjibZVI1bRBYGM?=
 =?us-ascii?Q?sUDP42hOvD0HeORlrL20zv2plqJz7lmhbTVPVIJirrf6hCkFnXetjSd88L8Q?=
 =?us-ascii?Q?rQ7o57emuUH+1M9ykNKzRtsJ/VJ/oRKb2ALLmgDA5HcfGmEzJ7Y27Q8XD2UQ?=
 =?us-ascii?Q?ahlZrydG/EoOo6h59AD4gQVODE66le62FgR8JdWOkImOjjbPaTk1XrH5PBid?=
 =?us-ascii?Q?LKP8R/fbOrYFxt3hatYMHPwhM5cJgKO3jjQH8e4Exr/XikMGrgBM7Rcbt76v?=
 =?us-ascii?Q?B2Ccb+s9CnDfwwWnZ6Slmy1UJZuvpklMxedH06SwHb+9cW4SlftrddN89AUi?=
 =?us-ascii?Q?Azvp81dz23/YRLTzqcukKAnFvu3hyRiNdlFDLDc8/KheTBcU6e6h7gnaooHs?=
 =?us-ascii?Q?uAVm70otFj0TlrImlAIuJXCQOEF9DqmlVjpAZ0B5cK6JGFztkSoFnlv++aXG?=
 =?us-ascii?Q?kpjIpTyBattZqpgkUHx7FmFmWmI6xaGhMvlptlCzForPDDou7bF1sj4Lsl/p?=
 =?us-ascii?Q?L3NffVo/gemL32tf8s6nITJttc6ocucDIvqJnQce6LVXI19y5u9dlPiV0l18?=
 =?us-ascii?Q?eJeeoghH+1Rt5GWPK5eMrgAYJy42hT+8Fnj27BfQCueRcOcwVN9zvAHmaplO?=
 =?us-ascii?Q?gmXQcMiia2XuodauZqpcLIl1gqw9UnUMB0Ii3+jS7Ive5rof46jwq2wbMacx?=
 =?us-ascii?Q?tECDFpg4bDMF0wsW0QFE9Eibeuz6pkRM9drVRPZCEL36LGWC/JjzvkEONmJb?=
 =?us-ascii?Q?C4XxciJqGL3cOv/9msPXmykvo7mBLW77Xqp7eeCpBRbOZuENMRlbkmsb68+y?=
 =?us-ascii?Q?ORfRQRYQvT0OJPSGArTK3wFmLrO0IsohYkCxNUOnt9VtVhE94/0v3q1PStIn?=
 =?us-ascii?Q?fc3jBgJ0VMSbcN/WOWH+ghpuUobWP/rKRJR3BXffFaPe77u4EH+im6PU2j2I?=
 =?us-ascii?Q?1G9QNeuqQzwpWSMU/hYajrcJXDTHx0OMFBPW5Jn/MicyTQ9I9HB+7Go1zLPS?=
 =?us-ascii?Q?QrF3UHVgjwZN8m56PVg6ODHBk1XVFpB215wq0OdUyhRMQd3FFeopG2ScImi+?=
 =?us-ascii?Q?LPN3o98JEbmYR5n8umGGIc2mR2uE150E0imRarimYCpwPLyHiO6U2UnttAuA?=
 =?us-ascii?Q?ZdGIGG307iVejNPoIq0mU6upVW4YPaDCMZLscEX5tpmENn06oCtilnbH12wD?=
 =?us-ascii?Q?4zsE8d/W+nxE11Ow1UaApaf+5XbLbpFY6DgU+VRcVcPjdrV6n8ujN4RFlxl2?=
 =?us-ascii?Q?nFniF3a/ZYJkiTPsm+oU0VqzXfhRENog5N5IPiThglJiR1/kIWXG+8S6wLK/?=
 =?us-ascii?Q?gicvWFzgJR9lxiLO7xJanCuPiEesm9o18U3LStD4f/f0CvT9qCd/9JBlvMJx?=
 =?us-ascii?Q?Czq7YCo1dxBr8TEGtiAkk1paIi/M9VwqC8u+JEbqiir9+6UDd4ZN393JaoOX?=
 =?us-ascii?Q?/R7LcpG+icXMjMKgd/gbEOULDsA7tX/uiO7sFpMI7eMpLpjMFkVnHV/3M19J?=
 =?us-ascii?Q?dGlwQ/gfQr01apM6F5nb3gMwnBAvIzl0+ko1A9zz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2899ee91-51e0-4d5e-3437-08dd3a608a19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 21:14:06.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBB0dLXz8ZexXok2O4Dr4AXlszvH3Ve02nBLNcJdFfcpq69qItpdd7QQWKanZuGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

On Tue, Jan 21, 2025 at 01:02:16PM -0800, Nicolin Chen wrote:
> On Tue, Jan 21, 2025 at 04:09:24PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 21, 2025 at 11:55:16AM -0800, Nicolin Chen wrote:
> > > > > > IOMMU_VEVENTQ_STATE_OVERFLOW with a 0 length event is seen if events
> > > > > > have been lost and no subsequent events are present. It exists to
> > > > > > ensure timely delivery of the overflow event to userspace. counter
> > > > > > will be the sequence number of the next successful event.
> > > > > 
> > > > > So userspace should first read the header to decide whether or not
> > > > > to read a vEVENT. If header is overflows, it should skip the vEVENT
> > > > > struct and read the next header?
> > > > 
> > > > Yes, but there won't be a next header. overflow would always be the
> > > > last thing in a read() response. If there is another event then
> > > > overflow is indicated by non-monotonic count.
> > > 
> > > I am not 100% sure why "overflow would always be the last thing
> > > in a read() response". I thought that kernel should immediately
> > > report an overflow to user space when the vEVENTQ is overflowed.
> > 
> > As below, if you observe overflow then it was at the end of the kernel
> > queue and there is no further events after it. So it should always end
> > up last.
> > 
> > Perhaps we could enforce this directly in the kernel's read by making
> > it the only, first and last, response to read.
> 
> Hmm, since the overflow node is the last node in the list, isn't
> it already an enforcement it's the only/first/last node to read?
> (Assuming we choose to delete the overflow node from the list if
>  new event can be inserted.)

Since we don't hold the spinlock the whole time there is a race where
we could pull the overflow off and then another entry could be pushed
while we do the copy_to_user.

> > > Yet, thinking about this once again: user space actually has its
> > > own queue. There's probably no point in letting it know about an
> > > overflow immediately when the kernel vEVENTQ overflows until its
> > > own user queue overflows after it reads the entire vEVENTQ so it
> > > can trigger a vHW event/irq to the VM?
> > 
> > The kernel has no idea what userspace is doing, the kernel's job
> > should be to ensure timely delivery of all events, if an event is lost
> > it should ensure timely delivery of the lost event notification. There
> > is little else it can do.
> 
> Yet, "timely" means still having an entire-queue-size-long delay
> since the overflow node is at the end of the queue, right?

Yes, but also in this case the vIOMMU isn't experiancing an overflow
so it doesn't need to know about it. 

The main point here is if we somehow loose an event the vIOMMU driver
may need to do something to recover from the lost event. It doesn't
become relavent until the lost event is present in the virtual HW
queue.

There is also the minor detail of what happens if the hypervisor HW
queue overflows - I don't know the answer here. It is security
concerning since the VM can spam DMA errors at high rate. :|

Jason

