Return-Path: <linux-kselftest+bounces-17770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC6975D8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 01:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87B81C22851
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727D184539;
	Wed, 11 Sep 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ug9M3aBG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A113DDB8;
	Wed, 11 Sep 2024 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095663; cv=fail; b=uEWq13N2DIdn2Nj/Nn8RjMZHA+lWk7wLfxB9VC/JEAAVJebdoZEICy3Lv2e7hRblanORg9kX2QVqrLnXWaaLL6NpwmKG6UMfbT26vJh81iL8MAZA4wDESqMkm8V5Zp8kTI3ksPUPq/pqAbw9/B/cNS2mrvdLY3J2r/nZmz7cVm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095663; c=relaxed/simple;
	bh=gUD6WYUdMRsQTussxwPUASdmE2ylT6yfkBvYekYxqMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tat46gAtzKbJQUpAFqb2kSJL5xgC289h6I+bh7rnGYpZMl49l57swWoa5OhqBRJlDl1F0MHtaAfRQPu3LxuLPoeA1BpiFIDe0IGBwAQJqMcsuErwEBDKtdGnVDXr2UOpGgnvXM+HgwLLk3Gz6645v2qk89VF9KdzvYkiJ0b7DBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ug9M3aBG; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES9307ANzjbErQD56/okaIoB1zdI8BasqpyKn2tkzWI0vw9hy90ik69p+O7HNHz2i6LS7ph9jw7W2b14Uqno+Bh5gm4OALK+QtH3+zvFpflMhcYzOgr2fT8dmtC/plhYqBpbEyOoNnwN9FNUDYt23sXpHja2OioyhN+1hiZlH550TpWJBcWrNc7+EZ0MGFmzTwyL2JbU1YUTzAMi67UYv03iRHe4aNuOY0ee3M64z2EdvnHtr+LOpk3aXGPtgOakr2XADt/8ufd0o+7m7hd9l6IJRuVjTVnBqxlIvz7v9MI468DODbBtmy3eg92m1t0ySIIXlPr6cpMfK3Qt0p/UkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr6OTcZE+Ko9pe9FcK0UYGwWv0Jj/QukkvBLDu1H6D0=;
 b=RNWXEm9E1PWRvisAgT54aHMqjIodhWINXlW/eqOlNJp9GPp125hxzJzYjWq34RpOLFBSj5OdsHq6UxOAJoxMJ/2IkDIiMGBGgKd4SE+hgQbKxE9bsvIYSaJxSS2VF2NO10ryRpSzyEhhdeiAEzbg/dbSA+tL4nLfZpq/QElb9KE7PdBdyLSvJ8ICpfmeMXn/680CYMFZGKoqhCD0w+MMxngHOMqLcSM8usvE4DLCZOplvyDdx4qyonxCkTdksHamCZR4M+v1GTyCH3xGy+3Z38kgctulbBm4g/VbABrLhBxtwZWfjDRhzlntNIwRhsyW9AqbPmDJ2/w4C8R7ghvTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr6OTcZE+Ko9pe9FcK0UYGwWv0Jj/QukkvBLDu1H6D0=;
 b=ug9M3aBG+c0oiwfAVSsqk2oXpCzHvw7XXSi2rtg422OjCEKvhWUheDyaz1y2hp2CM/fgEBfnKjP84D7Lz9G7xD+MK/weznItM/59XYNXcNq7ZZEqszOSX9x/imGQCoulkVyUTGeexXPbXa9Pjsbsi1KBe3YjdExFhioAyuUhUJHYGpI9Chp2f9ECIlHC/HWTmNSaWQSrleURlnakaKjWh3wgYPhOEU7/Wq901yERGgwxmSJtk5k1bC0pnxkhHWS6/uD8i1E6kevmscHyrgwRjOoWLD/5k1BTvHaqSp4STu259NmUrwmdGgN28BgLo9HJTJ2IK/T4s3HOesy5FxbrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 23:00:57 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 23:00:57 +0000
Date: Wed, 11 Sep 2024 20:00:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <20240911230054.GP58321@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: YQBP288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::11) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecfc301-0cf3-44a6-3b9b-08dcd2b59877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b68xM506sf57Iv4ZZJH1ViWJMCv7rQPN3WEdRzjWq3xPHvE9WeSu0BRfHm2r?=
 =?us-ascii?Q?2nfdYhY8ukd1DM3IbuFgGENqoCbJwmym1Oxzf7CzEXTGs86vDbaLgJ2kN09W?=
 =?us-ascii?Q?UDUtXr78lIBGYkQaPzXqLddJKBpbHNg3NB4iZ8VfHVN/PFX93nG2quPrSdLx?=
 =?us-ascii?Q?JGdDw/g2cYYR5OemkEQTKuJuSX3wAfGfKPJdiu7AgLD4J529LmPUFmn1cLj+?=
 =?us-ascii?Q?sOpkVnF5F4JAQE7wWXeJAIJmS07MFgwBCjVLGs74FArp5xXzWIWq6E6GrGBS?=
 =?us-ascii?Q?pV1e+KEMDhp8u6yyAVzjwxlo3mWtUvrK8yuyv0J16/ee3o3oGnAUr89rpSg+?=
 =?us-ascii?Q?1sj3WS9ho8Rel+x3VLjAXshtZTAfuq58jXtbA58ZnhekikZ01EH+/N2x8ObM?=
 =?us-ascii?Q?yHmr1pMJe2oNSij0eGmc/nGzihatm4hPkj5CcCcp2uEpSqmmzk5E6JLxhoOb?=
 =?us-ascii?Q?voCpmnxThTIjNrsYrc4tzoSbgzqK2r4UgjCAcT9sEbBSRB9xLqmbDmCzKixe?=
 =?us-ascii?Q?Qv/JEdCX6WT1Y13LG3Ly3q2q+PW6GoqBfTesxm9TYTNeksC9JzpbQi6rylth?=
 =?us-ascii?Q?JGnl/tV0sOIuYkBFi7MUsLP4Z73wgEWrRHpqowTkhV0gTmo7C+EsKP4+u7VJ?=
 =?us-ascii?Q?Y1R2w+7t/Zp1XUm68IUFOIyjejb42OTpFz1YosP+aLIhngdCyxj4sv0iOubt?=
 =?us-ascii?Q?KZKHWchDEsjpDNQ3NSru0/CVZrdRwBcbBKjLN6TOdbKulXB5COG9P6z7KsZD?=
 =?us-ascii?Q?xoONoA7mRagh5rp/uO/Ki7yLg5/jy1/gmYZYPxcLjpAJco7sEtZt7ORhW5TJ?=
 =?us-ascii?Q?ryNlCdV7xserlWc1eGEz6E6Fuk3SAXhUS+QK+uZN8znKTxQJXOSGeGfB6oX4?=
 =?us-ascii?Q?Mw8SeZ6cTWfOoUXSn6tV+SveLLRaYbr7e2YyVsOrWAv11hNUBXGn12LabLUO?=
 =?us-ascii?Q?s4gxb53wrR/nHOq2xIp1pawcOSiqiJPjihLWVENwnkLbz/woRmY/bJS5k4FD?=
 =?us-ascii?Q?OGhPm8LNa0Nj7e0E9bDq5mOQ7f72EGJhPv9ox+EH3hrNLyLxGcSkQB8L8kTi?=
 =?us-ascii?Q?HiqomNVmjBK/WNa8OuJ1oxnKTeiod99R9d/O7uN0N0R09K6B/C858Y2LroUa?=
 =?us-ascii?Q?fyJWwOl9UGMPx2pv3sMqw/sSobAEAZsYM15nkPQcgVNB2ETYgFZJB4pfZkJp?=
 =?us-ascii?Q?sn+oVQGXYY655c1WVxYOa7mxRK3ALK0KfcezRGTF23VXdcZT65mHitfWxG3J?=
 =?us-ascii?Q?mkI84wj76AqmBCcbmwtg2Hq36bKmAhoXHtDNBPkSlBjbIQ1tvaCHg+LfM6ja?=
 =?us-ascii?Q?VH9dVGM2J+rgwTWtUtNRgOJgXUEDUNpLDgYJeoMP9cwUhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EN+5bBAuErBlMKBH4FblflMqX0dcGg3NDl6JesnIEzXTjpg6nOsGmR7k09Gv?=
 =?us-ascii?Q?ClOSq89fivM3i9QwcVT7fIUCTcvlflc6ulSoIr6q8TPfe2munhx2oER/6wZt?=
 =?us-ascii?Q?DqKNdRs66DsV1FbKx6vWMQ4frQD1ka6IIMYIX0UVlhN4Ov6W3F6XIyJbJls3?=
 =?us-ascii?Q?b+noy4gT0ajXYNEA4maRDypWjHjSp1jAnrHcY3o3a2b0cf8sNL+x+kAIae7J?=
 =?us-ascii?Q?fFt32Rh1EieRX2WQVrp7c5feLztBAyIPcne8ZZxXnmFMuW0qEG91DBcXv7P/?=
 =?us-ascii?Q?ocbj7gvUkr3Tp4IWBLBYk6RRARv3225j9LJ+KXL4rUcQhumvGdtI/EGpeZqk?=
 =?us-ascii?Q?BuUQcUzV60dBU4MRATcVpQG3W+FdnWuBGsqxVTZox2sqrprcPEAxVM6/tFJ3?=
 =?us-ascii?Q?q/twjRXHcZhFhR+F6j7TmiLkBTQDg312qIfvpIMOAmrC2DzRaI5y+1cjrJhy?=
 =?us-ascii?Q?Z3phDPK2e2wjVfnveD0KA8B3xJsdorfGdm01qQrCvWVTaaDHgIlWSbhaqSTO?=
 =?us-ascii?Q?bXjYFhsNQms8A+Oki5aKlvF4DdY1WCrnLKJTOonhL8bRe1T1UZB2pcYIVFAY?=
 =?us-ascii?Q?dcnQM2aqAvyMIy8WbRnBRazXIcapVgTzEgf0TTeNXiRtcUgFj6HW9TP2VbkQ?=
 =?us-ascii?Q?WZt14AIwZr7Ch+0Uxv7oYaLRhxGxsxTzzIqGQ9+uhaI9wEXabgTyq+Vb1ww0?=
 =?us-ascii?Q?fgWuzbdaLMvQlD9yem1KJxg59c3qS5G5e59uo9tH30MnHVRv0z1JkSCuHB8I?=
 =?us-ascii?Q?+vI+3fqCxychT1/YnGp732DbfJwdyV07ldRS96p+/AcaM6mfQ5rh5n7PfQU+?=
 =?us-ascii?Q?S93mvvYNcf4aeu7+9VD+5ANeCYofwKwtEIq7bHjvNHCv1iuicG9JE2RM+37x?=
 =?us-ascii?Q?qfDU0wA/8/QkFrEMw0sZuqezNHSRaSbbMldLB+bGzRWCxMlC0aeSX53g9cOe?=
 =?us-ascii?Q?t2sf1BG4Ed/WT3TsGhWAV0TSsOzFR5Qw3LovnNnYCRfzjoVf6bd5I32ZzW1K?=
 =?us-ascii?Q?Yo81ZsWAJQUTcK3QJnCrbtYeKxU9Gt9T0KOJ04DQaBfZYnExgVIJmGNmrG0d?=
 =?us-ascii?Q?ja1CqbR5cZl8Qy8a3+8g2kqNkkNoiUfGoO5qauY+n764XCCtGdTK60jeufaV?=
 =?us-ascii?Q?gxnRowbACJS6ABhN2YhVoVNKBXhRKG2iCFT/75PKvsu7RMerOqhe7YqP8sed?=
 =?us-ascii?Q?b5jIkbJUzJv9zmgUuzBFN08ZLQ9xcty3Vc90D/coUfxOrzPjUEKb4vHrM+XM?=
 =?us-ascii?Q?w/Bnu15V9MG75DAPH0cd5ARlBIT67HXhUYtSZDGv33Tc5mdrIMcEqA96yrn5?=
 =?us-ascii?Q?8dxLOQ9M96RUK0zBlONHKm+s2AzESqBix84jNGy+PKMmCoVSyylYwXs14dcw?=
 =?us-ascii?Q?izBDYXsPDr0OPrd9W0V0kUrgY1KQLHS7z2C7umTvShVXYtODc43bba+jcMt2?=
 =?us-ascii?Q?bF3UxYRBlE+Qf8YtlvkzYTofDmX3uxt3EsqErcAh3/gu3GEdj6acaxSHrlJj?=
 =?us-ascii?Q?fgNETXPIH/0p7AQyhCyYn+V8qFuQau7zdbIzVyqnt5jSaUYe7F+nfG4FSxQf?=
 =?us-ascii?Q?//qY4yWpcqEUEs6bH5UlVcdv7b95+Ho9Zpp+AUSR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecfc301-0cf3-44a6-3b9b-08dcd2b59877
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:00:57.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v7cIdn0V5eY+yC78OsVckpTahFojRzOdbr/qCvEGl6OCySIfnR2Ai+f+wtRanVE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

On Wed, Sep 11, 2024 at 06:25:16AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, September 6, 2024 2:22 AM
> > 
> > On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
> > > On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> > > >
> > > > > +static int arm_smmu_viommu_cache_invalidate(struct
> > iommufd_viommu *viommu,
> > > > > +					    struct iommu_user_data_array
> > *array)
> > > > > +{
> > > > > +	struct iommu_domain *domain =
> > iommufd_viommu_to_parent_domain(viommu);
> > > > > +
> > > > > +	return __arm_smmu_cache_invalidate_user(
> > > > > +			to_smmu_domain(domain), viommu, array);
> > > >
> > > > I'd like to have the viommu struct directly hold the VMID. The nested
> > > > parent should be sharable between multiple viommus, it doesn't make
> > > > any sense that it would hold the vmid.
> > > >
> > > > This is struggling because it is trying too hard to not have the
> > > > driver allocate the viommu, and I think we should just go ahead and do
> > > > that. Store the vmid, today copied from the nesting parent in the vmid
> > > > private struct. No need for iommufd_viommu_to_parent_domain(), just
> > > > rework the APIs to pass the vmid down not a domain.
> > >
> > > OK. When I designed all this stuff, we still haven't made mind
> > > about sharing the s2 domain, i.e. moving the VMID, which might
> > > need a couple of more patches to achieve.
> > 
> > Yes, many more patches, and don't try to do it now.. But we can copy
> > the vmid from the s2 and place it in the viommu struct during
> > allocation time.
> 
> does it assume that a viommu object cannot span multiple physical
> IOMMUs so there is only one vmid per viommu?

Yes, the viommu is not intended to cross physical iommus, it is
intended to contain objects, like invalidation queues, that are tied
to single piommus only.

If someone does want to make vIOMMU that unifies multiple pIOMMUS, and
they have the feature set that would make that possible, then they
will need multiple IOMMUFD VFIOMMU objects and will have to divide up
the nested domains appropriately.

Jason

