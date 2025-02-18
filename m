Return-Path: <linux-kselftest+bounces-26894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BBA3A65F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8DC3B3590
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C726FDAA;
	Tue, 18 Feb 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+57Nrtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54426FA77;
	Tue, 18 Feb 2025 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904658; cv=fail; b=hxq5EZ9xrbJRYwlzMl1bl9/RZxINvvPIMa1U5sn7htb0UZoMvP3mRmZsOo/KISo6iQjMAT1gNmN0GahwwqLSuXqxffMJCAWZEIKYN1w4Wsc6WdqMsgRb1Q4lrM6JF4LwXM6gyeJcFvanyNgcZDz8rFKBLJslXzEhhbnwncEieto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904658; c=relaxed/simple;
	bh=cbLOk2W7F4HF+ul8Nh7yd/bqRa52yeFG5nhzosB7P6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deU8wunqcmod77BicOZH2RYqqf3nlHSa7q/0KA+WOOYeRid6OlG6J42dEzMC33MlCJ7uuAsSvEnT3bCuFnfJK3rmv9GXUf4/axKQqpYHWTNEsdv8A3YQd59xXspnLzH0gCkYRNGRE8DSAleKaea9KOUI/GAzv0BzWz2raHto7Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m+57Nrtd; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vrpv+kt3QlyonoEbYuigPe66cNQZOdKgsrn13HCOMoDX6hFBGkqSBDg5XeVUpoejhX38lT45dqjl9oScvfv8cUiOTVCL8OQORcrUyKYBZTXHaQGuCKPZ6DusJhR2VqFm+NfA7U4fm9IfGOm8jrG8J3rzulAN6GX3O3+NkcnQQ48ycjBHFdfNRUQXMEcyf0/YsXvLwzBIb42BZzmdHeMJjo1+cb4uWx0LtvNJoAHTkRM36VQNiSzQAKmayxCtgbKONSvV4Xvh9LSFUzRQSD8JUe2gUyXrMUYnhtXHhl3VOE5H2OZbRBrXncPYW1z+BvlnQTBtfOgDF+jQp4qoHAJYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06G6Zxu/6SzCl+MXNXO00VM9y3HZOv0+ejkQmZHpZoo=;
 b=AAz8vuoO9MJTT/M3AEulbz2lTXMICv3/j9EyMD1pNIfsBynQC2IrxPQQqGyu/aVIIh49F+KAOrMuk3gTuIujdamMOzwzXdWyZW3EuuZunuISI02JhIqFDmQGA1mx8/WpGEE84lfOsN4jcjeZRtLDEHH/GJQOqzTRnawLomhCffUbkTgRf/WajE0CmxsItSZsl9NaOgTlAHFrLgfjHpLkta+ZIY/Tz9Xbwck14IItCb8Z/VRhMKjRmvFpUYXYlrt+Pvo4/GuKssnobOCqA7VEM3eKDT1ML3+gTdaQRxsikXPVPmeAzY/axHWFkqvjlfEI2Q68NuzJtKTz6BjcYsdahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06G6Zxu/6SzCl+MXNXO00VM9y3HZOv0+ejkQmZHpZoo=;
 b=m+57NrtdWwarlxcnWTFXS7JY+gTKkyTPVDu4UGfBVCJwOZbDb5dKSHDVOMERZfOt5wDbPE2iw4/lBMJ0fE9oAf4ZYyw1fOBd4KbztkBP7I3EYLuI++9ZACtqf3T0c/sJ90zpWxPwPq7m+BX+/jleP9B/Z1rBdzzNZSuKSCBTRHRw4X7UeissFkYA8tz0vv3R8JIfA5XyID1T1zLhde/WDq2tKFtImouirHAd5N8LVuLt9dj+j1PosSNvVnvoDMnegpScVbj3kBWMYj5LACazNhZdNhi5Hzd1WInXtSsbkBzZ2XuC+jdEktLdm1l05HwvAwhqZbXz8Z7eIMNc0sudow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 18:50:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 18:50:53 +0000
Date: Tue, 18 Feb 2025 14:50:46 -0400
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
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250218185046.GK4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7TRNL0u0YmN30ax@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd315dd-be0a-47e8-916b-08dd504d2b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4VsJxl4gf5d+eCzfGx+Fn1YkZ9ebekOCEVh45/J7k3/OZP0ylHVclk5gcA4B?=
 =?us-ascii?Q?EKm4PNPz8+4dSAwoRUKGzrpygODDuDa1NXsp4zP+U7mZh/1yK2PuPFBTaHBF?=
 =?us-ascii?Q?a4PgnWKpekjoAFfyRoTp+4z7YyZzvOjJsedyFAQKbx+DLj/IMtY3qZPdmq2T?=
 =?us-ascii?Q?HduFEtQdnvt4lvGr64w6oAsdP1qUyznifyxHhv3D/M9wE9z3PutZzr4nJyA1?=
 =?us-ascii?Q?OVr6kMTTCKHHZgDLrYxtVrulesn7Z9bag4L7NX11Zblu4UfQiOAJHhW0t/X+?=
 =?us-ascii?Q?rsu9Y0O9zGsbTypFwDR1e0a5BflkhLAszBJ/9iHWI6zDjGrX3sB6em+MslyE?=
 =?us-ascii?Q?uynC7rJt0E2HhVlzpWg0JZ6jD3AVnTYiB461R793cPhTO0hj+5aAkF12OSnX?=
 =?us-ascii?Q?hZmW5W3sSb8TIfw2kS7vQQa9Z6xgCNgOrUbz7JVt38T8tL8BwSSmgz3ra+oN?=
 =?us-ascii?Q?3OZgmPqwL6tfw61JJAOMAwTyqpHp/0D9hqj/1MIqJRUYLOY6QFYfMT7YzYId?=
 =?us-ascii?Q?xG9U/aX8Mnekic8bzsbta0YCO1GI/gSJLAw428A67bPe4rb5RmVGd+fmPYmb?=
 =?us-ascii?Q?Hyljwm6mlBnVF/4OPZQF0OPftxnwwTHrFrRaCme8Xsf5bhLSIcKepoA+Sz/h?=
 =?us-ascii?Q?vjESQCUtk0RTTuE0CxyKWU/afquZ7Oob9YDzpqAl5h8Q/+wDXRLwhU00LTtf?=
 =?us-ascii?Q?tKEyNakAI0V2BSZrBjIH3dpnk5edJzABrf9CPF9ZPxwCSw1YWDotc2xE0GsI?=
 =?us-ascii?Q?WcDBy7WniyQLkQ5Os4c1fvn+BrzUSh6p4ajNYqv69FGiGM8EgLO4O2/2eDxU?=
 =?us-ascii?Q?zBNPacGHm/taaIkmm2zcYwX0szp8b9tYOcz/QMBt9AY4PUoLz6kNklQggke+?=
 =?us-ascii?Q?Lw4TPgDm1FkdzpiDGxsrPmubn2QGkFxLeGvXAJGR/JqTgfdnbmv3InSLnusi?=
 =?us-ascii?Q?O45FPj2GyefH++pLove/oJmeBAoky9kpLoyvbhj0LfSymtwKZZstQAC5mvqQ?=
 =?us-ascii?Q?maM6+RZUjaVKOInBTTfvdM69O0DtITeTATRCrcnnous8sUqGyxuXOp3/aIcW?=
 =?us-ascii?Q?WoJKGktgCy+rjnRwG7dZUR7/hIbEdPO6ALqo0MSHQjY02WXlun4aqqcoHRk+?=
 =?us-ascii?Q?B1X2tjL8kgqPclJMe7UmXgXdquen/kEWNLSoNeipByaBxairSfwzsdXz8jlb?=
 =?us-ascii?Q?LaGAvHa7YfPdc+2GN24oJ+K1k8EbTbQ4/akfIEdSb82TZpeoI5dwnTLCy/vU?=
 =?us-ascii?Q?zxcFdqXSdxEM6Za5g4KcZImPesE74vK7DikvrAHMyni+0njUUDiOArWQqZDe?=
 =?us-ascii?Q?hsYv3LLA5HuO9YQYiWvk7bl+eOc8AyWx06MP9YE+XmmwoQik6k3g3MWMWSR3?=
 =?us-ascii?Q?H3NPEGAZYi14RpxZQ4eEqETO8WbL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xpx94vQTjMjf5WVM8OQoZeiSakrWKCSRcO1EH8/JTLTJLfRSxOqV9TTtNJXY?=
 =?us-ascii?Q?7EnuRkooI1O1gG17Mxo5q44W+rBK3dYmb+q9aZRzZGOKI5OAi9QmVjJhPMza?=
 =?us-ascii?Q?b+MjDUR1P+/Lrm/fx1KTUeLWbw4Pb0SJyhH2Q9UgBYVurIa/zR4+5kpxB/8L?=
 =?us-ascii?Q?99OtUq327PqKPoiXAhAVGG5gxM+7jLS965v+iRIyqP2fSbbSzmB8MRSUayff?=
 =?us-ascii?Q?TnKAe02oWbKI+57wEHeQTV+l6vP0oPNbhNkCMCunglAPj9XIxvpHObiXSY3q?=
 =?us-ascii?Q?SmA+nV+bKCDH/LaDNKhTfA5eQQdncWnLTtZv8NYhlBh+L8VLeABj570+IZRe?=
 =?us-ascii?Q?xBkOJ7nYtYGB5bOv9aeuBA/5tF0uLFKh425ZjkBnETqWX8cpy1ZXDt0wsP8P?=
 =?us-ascii?Q?QTfYtMdfbK+SeUFJQESl9zZnsf2Z9my2KpwPyRAD8UtsES2ye/5oBsQ6D0OQ?=
 =?us-ascii?Q?sy95f4uQRf51furBT2T9FygDir18Sr+oaTc+Pzbo9uKp3KoCt2tXlmME5ULI?=
 =?us-ascii?Q?bk6qSQ8/yrPGjvevUN7tuaFV05A9LhEiDIUPEeVDzOvedrIKUo+30i619auV?=
 =?us-ascii?Q?NNnalKn2L3Hrs0zyTv/9/zAxkOFa/h/21U3N1bd7x0TdUZKa2cV/iqthVUMp?=
 =?us-ascii?Q?rBQMQ8ZjQWM6jrzztEgymeLDAbLfKLqroUE5vvgHzi+rtLzZo3we0bqR3Dpa?=
 =?us-ascii?Q?BG0wGZ/EtS1FtClQ+9e3mssqEPknLhXWNSjauWZos185fH6vS+dRD85ye8G+?=
 =?us-ascii?Q?pmnoyXicdqabeGnE8LtOq3yZGHDLaShanMsnofQ57lDVkAQ5mYKvZ1+CODoH?=
 =?us-ascii?Q?UaNnlci63J/rqcMwcWlpcSauDN535YU/8yLXhpaiI/igKrM6MCMpfq+FUk0f?=
 =?us-ascii?Q?uXNS3wLR9Ii9y/wcTkZJSXEB1LSH159L1+ehnODu1kD3aaknvLrpaqdTJqwg?=
 =?us-ascii?Q?t0PDhC8gT/7Oel2s2AS72bqXnw6UMKSwHAzrncJABV6DhUFNJJ6EbcxB/Yck?=
 =?us-ascii?Q?67IVB9e8qpuBc8bVrcVkg6vgHArihz0YBg153qAIyMuvp1QSl4V9A3c/hPZD?=
 =?us-ascii?Q?nNlsnP77s6JybqduK9pEs0y+50ShJREhXOyAfV52EaGs5zAnOcOhfhvHJZQQ?=
 =?us-ascii?Q?6pnjCk5uH09EjENIRmTNGu2A1uRH8SzybQvvpwvVXwMgx6JsORM8hmfL1xOH?=
 =?us-ascii?Q?ZJNbX1iWFgt93/P5HMWS8xgxJh5ZrtwBFJtFi4OhURGZzJhvT8DOmj10WicD?=
 =?us-ascii?Q?jq/F/KIHRrbEtptvm2D5+s90uOoyY26kTG2Vr+tJxSZtMvS/HGSFPcxH+GXJ?=
 =?us-ascii?Q?mnOZLI16opDc8thHOBS1hZYxspfZNlCA0YyVU7daA4dvH5HLkJGj1ad2joDZ?=
 =?us-ascii?Q?OYaHQ668in5A6oths3dJ2Q2sclMfLXoemq1CZ4fsueSBIGTy8ASgFfG5hlzG?=
 =?us-ascii?Q?kYqPrWYSE0uz2G5MjbhEcNCbZ2V+919N+JScUDPn+QK8mhIBO5kNITJ/fJfg?=
 =?us-ascii?Q?d10TNQdiYNUp9fCiQgHKL+nl4jMm9smbbTKfb/8+AbAlRdXCoCQfxncOmqan?=
 =?us-ascii?Q?YF/4cjRNri2HiyI5d6A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd315dd-be0a-47e8-916b-08dd504d2b9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:50:53.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqucsQEV6lIHmCGIHyhuyEO0L96jI06L0bIjIHVxLlaz6DQiAL+tDvO5mheTBSQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208

On Tue, Feb 18, 2025 at 10:28:04AM -0800, Nicolin Chen wrote:
> On Tue, Feb 18, 2025 at 01:18:21PM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 24, 2025 at 04:30:42PM -0800, Nicolin Chen wrote:
> > 
> > > @@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > 
> > There is still the filter at the top:
> > 
> > 	switch (event->id) {
> > 	case EVT_ID_TRANSLATION_FAULT:
> > 	case EVT_ID_ADDR_SIZE_FAULT:
> > 	case EVT_ID_ACCESS_FAULT:
> > 	case EVT_ID_PERMISSION_FAULT:
> > 		break;
> > 	default:
> > 		return -EOPNOTSUPP;
> > 	}
> > 
> > Is that right here or should more event types be forwarded to the
> > guest?
> 
> That doesn't seem to be right. Something like EVT_ID_BAD_CD_CONFIG
> should be forwarded too. I will go through the list.

I think the above should decode into a 'faultable' path because they
all decode to something with an IOVA

The rest should decode to things that include a SID and the SID decode
should always be forwarded to the VM. Maybe there are small
exclusions, but generally that is how I would see it..

> > This already holds the streams_mutex across all of this, do you think
> > we should get rid of the vmaster_rwsem and hold the streams_mutex on
> > write instead?
> 
> They are per master v.s. per smmu. The latter one would make master
> commits/attaches exclusive, which feels unnecessary to me, although
> it would make the code here slightly cleaner..

I'd pay the cost on the attach side to have a single lock on the fault
side..

Jason

