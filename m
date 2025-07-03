Return-Path: <linux-kselftest+bounces-36476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E8AF7F79
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD557B796F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD682F198F;
	Thu,  3 Jul 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYOqxv/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1925A359;
	Thu,  3 Jul 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565339; cv=fail; b=P0oqJFNHdF2NQRUl2EflMYQUxSdlmABSsub5p+dy+6JoWz/WlygZEfgoHTsX190yqnFtPgR1MByhumEooLxEegS9wj1j7ziniAtENDAnGzt44pDlLDZrUMuy6m4FYq8IezK1zGnU9PtkdemgkvsMVkAHhai84nQ1qLlv2MN9ceE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565339; c=relaxed/simple;
	bh=jSeIaKsjGdobDLK1Si63DZ/ZRJFuVsiXOf7kehqnvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yjo1tv9BABtWWN6q18Ih9E26CRYW+T/GKzLZfMJE9ozHXrXlsJ2GtTaoNxIytz5PzbJoGsP61y6QPbqM45lLKe12GVbxw+iSOYKPQEIYMPVNYiQMzQdSk9xi9naKe1nSKdE/VZlx76VqCO9SfuhMkWPexVOHLH8x369OrGPs3jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYOqxv/c; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2Ijk6NBUkDduksvbmXxc5+Yogll4HkiLollhFYmUG7vZfZ15+N0i3d1x/sJdgfhpv9fZpcSb8vfiBqzTj1P79WdjlR8Sibn79MLauKamMxf2Zy6BebPtTSFbvAV+HTXV/Z7GkTdwXXzojHEV6ToNMwuIUutF/5kSJmvmmmIflVnKb9Q49iXLh6uIsR2QElC98q6Dcm8PE8ya9Aopl3JDWWj/EyuUAWCk2GilMnAyJ0fAiJHiGFF9Dojzq1Izz/2UGggXsDr6uOQHlDy6eJqFttkgc6RP/cNz//kmC97Y9mun+r0BI0yAR0ftiTSHYHqMhDEiwO6134pjxc8wUy/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY7nZjyoVGoBsEEsCJ7kgtHsKCFOhRhsRxFnuIQLR3U=;
 b=COkZAF68r2ZvE1ZRtIQ+Sv8WKHGL37qSjnJHxc59IJqi75PnHBajG3PzczUa/0wABBlJpmQnd11KN7s2+KQU47E/BSCdtaVABuWOAozO2ELc0f6FZthGWsUIRhPITrhd9PnmWXeMS73c+LySzeW7i8szMEc0n7t6h/BP7dtVGW2f8bAqqniLqwflSC9fI0rZc04u7vtE9o4k03VPIFqV5Z4yd4xwlbWauokJJb3ohvHXBWGPiB5HmHGmHDDmm00oYwEc0LcqUjiVOYBRBpSEBlyQAw5ClVF/AP412uHZACthBBSHDB8KKQWinoetLN1xc6OlGEY5A5b19oYrpxhXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY7nZjyoVGoBsEEsCJ7kgtHsKCFOhRhsRxFnuIQLR3U=;
 b=AYOqxv/c8b7ntIpfpXP4tBQwCwfhr1T7eeEc/JKQ9obmfAm2WZ7CylsS2i5hpx7ipvpMq+c6gihHz8EfFF3u86eIYg9cpjrL1AaUM/WagIy7mXYI0nzS4FvjfTXgqaSP2ekUnnln1/hcFpJZal8uOvMgLWaON8Ylpovv7gY1CVStAobcICqKHU40yBCAqTSAKo39c6t4NrvBMgRaORo4u0tJwgHTODrm5WfDQpUhsCWCHGXW8Nj3wKGOXY+0O75FWj8SAzDrVrzBp98SekfZ3YHhTbARqiwu2hX0Tf+WbWAS+GZX5111DiGZoKee08kVcNxXJXhdZgQS6XSCpax7EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 3 Jul
 2025 17:55:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Thu, 3 Jul 2025
 17:55:34 +0000
Date: Thu, 3 Jul 2025 14:55:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250703175532.GF1209783@nvidia.com>
References: <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
 <20250702180541.GD1139770@nvidia.com>
 <aGaXqwzfLwsgCH6n@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGaXqwzfLwsgCH6n@google.com>
X-ClientProxiedBy: SA9PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:806:27::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f9f43e-8e7e-44b6-6e62-08ddba5acf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sODyGP6MIzYr0wLqsEuD7dntAXtBLwvhdUgj9y8JS3hIVugDvFPS2kriLm5?=
 =?us-ascii?Q?pkkmV+w+Mf91SwcUIXGKNDy3K1xZL4wCX4ScnggQThbr41qMPimH49BETWgZ?=
 =?us-ascii?Q?ode1DkQ+h7lqr/QZJp19AtAKblVXhhy3obL4GgiF0vqZcGXY341suVS/bQzz?=
 =?us-ascii?Q?n/xfXkBiUTBFFVgct55fUhkyTHkB47hAKNmpsqDljDZ7haSrcp1Ak9SDTZ8D?=
 =?us-ascii?Q?tKFUjnBmBM06otoQo5zlqeMX+QhZFOmHqAhyHrbXaI0WwDePnVgr6rQITJqX?=
 =?us-ascii?Q?h8mAgdcKWKfzTUiPCIA7s6etrNG7Kz/5VbcDeNouM6bj8/ySTeoNWBbNDeX2?=
 =?us-ascii?Q?3rpwB/thlcdc8BXTUiumxVuIMLOOKmA2ZOOf7qzcjfvuck5l1487vxHCbZQw?=
 =?us-ascii?Q?YuVJeDKPsP2CgAOJd0obNIO1oOM0Koq+gqlWB5Zq8Pt7GriykLRgp65f9D3j?=
 =?us-ascii?Q?9HToSGg8Z9dzo+V/qJXXubalbmJ7+pY981M7JlXA6H3SW9zhME2lxldjX0+L?=
 =?us-ascii?Q?4j2JcVkJA1iCt6O+5ITNMD/+U0fzhPKzQzPxe+NyP5gW6mmhXg+gOOhr3Q3d?=
 =?us-ascii?Q?DxANTXAU5pNMAOvp1DIIJOGfJFt9uc54a2DEoQxHerDeMDyapru179NjxZ79?=
 =?us-ascii?Q?ue84JT5GFJRowXydaz2XzCX+SLQV3czZO98sTt1uHbE1B8x1fDAKvrVXa9yS?=
 =?us-ascii?Q?1WRc2V2Usp4YI6WZWgyY0XWl5CkVEr9/Y6oJ40Xu2Kv9lAHXC6G2hmFJ82ou?=
 =?us-ascii?Q?82iDf2ahSLst6F6EInqg5kpELj7C+PjY7CoefNmPyTYRVS/4/6pTRZBCMoTX?=
 =?us-ascii?Q?HSOUbKgHFk3XG54jj/tUlJ4Qrr/O1RsIeSnG3rSxr3P04O8Fv8BgKxL5OyAn?=
 =?us-ascii?Q?fSnpt+7rabrr5ZvhovmFMuCh+sfLmrYeevic9ebwxBdYSNk1elczIomUUB6B?=
 =?us-ascii?Q?ShAxOCWTAo2atQlBU0gkNzAzvtuw4tYYGGBplcGQ+iyUPwJjEXWLW14FYixy?=
 =?us-ascii?Q?gZpSEW3VBw8aS+7TrXxCYpS0FEkgl5p8bh7f82flA2K6rEw0tJkeFTfIGhOy?=
 =?us-ascii?Q?l3T93apN9jcBaVOPytnsE/NDosnh/8wHubBlwg6Z7555HhAukjgtCYGPrt0e?=
 =?us-ascii?Q?0MiOSDu0+6NV7LsLBEOgjVGambhmAkymVW1sDiUlxtrd++VKPeGzW7PRyc8j?=
 =?us-ascii?Q?SesjThIKwPvjPWHFrMYEVCU2loPfPQqAMSJg67N9zb0y+jTAB2wDPfJFAc9e?=
 =?us-ascii?Q?PGGp5Jc6RTOVXpg823r+wUaVMwRr/yagIg5OPdyOJQhvaUbSaNKl9eTIZXxn?=
 =?us-ascii?Q?58b6wknLRq57htE20SXxLeIXeRX+J10/+w7LVdbo2vcCxgNAtDgx3wBz+SPw?=
 =?us-ascii?Q?3zHMrR7ufdoVDQ9wy4Q8EKFWjaoYNFFz1tHSaD7dZqPWmxGZUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYMxpzotLOmcfL2diPLMwfhxKff2tIz47JS9kwTqcvVbMR5OHuc+YCw0jaYJ?=
 =?us-ascii?Q?WD9f8Y0t9t90YiciktzussSiynTPGW909+6j4cR71kT3leaHX3070qUD314f?=
 =?us-ascii?Q?RVexf21q6ZHbFVUpV1PdTASAlhjAPySX0ykUnDTD14mQhKZGx/n4CoRD2AtE?=
 =?us-ascii?Q?rqRQzCSX/hpZjyjPi9t26/9J9nuRcrQtddq58T56AntUPAWoZc4t+y9KILxZ?=
 =?us-ascii?Q?fBuS7YYHrxEGkqtUP8I/24r/mX+uiG6PSgcfUlABu2XkPsF6+JMGF9uHJ+JZ?=
 =?us-ascii?Q?lX1FB0P+sWJ5K3eI9zYKwe9CsAfAr3PXKpjWoNa9eJmo7mi8WStPL3u/jrmu?=
 =?us-ascii?Q?8LVxiZuTMCoGZWg5E8SxkZG7ynuQdQSo5yn0BQ808H7/cBNOpr2+Ej5hdPt/?=
 =?us-ascii?Q?beyjiyepRnqsa2d24O1xzLoDhzg2dvbejkIzBd71daLdWtVAMiIM4BPPrE+i?=
 =?us-ascii?Q?vvT6SERrEq5RLVOM6WwdBx9DKykQg0L9wpQ+aJuWI+j5PYSHnknOO95Ub9nt?=
 =?us-ascii?Q?feBqoJse79qIThE2uSqHaKNv2LtcShuyc35Vbu9QYc4m26cjwxJieTtJqBz7?=
 =?us-ascii?Q?My9d6lItNoEi6kmt+BM+SJgn2Il1mZXEnEzrkLgNIY6E02teCwhGFeX8CpwG?=
 =?us-ascii?Q?Dqv3UnUvVyZCg5lLZMnI7qvgFpPNstVXif2hlGhDffnzedhKIwPlcjqvoEcp?=
 =?us-ascii?Q?Zq+2t/aVz7MgR+b0j1HGgjIBT755PEBrnVXNs9Fcz6VY1fcCOYfjjO6U9/0D?=
 =?us-ascii?Q?oAF6p7EsMuJsJj2Jfx+tPyyIugzfEcl5/yHJh2VOfPRbLW3QXeTNaWFDVLmG?=
 =?us-ascii?Q?+53PNYYfwGhTAt/1NY9u5boEb96Lb1NHxYR6Dx8ToHNdYC4pvNMQgTswwOh2?=
 =?us-ascii?Q?ESlKzRmfxWdsta9H3o1FzyTojjQ1r+aBbSFOMG6qbiJHQKSfN6MPwz1xyny/?=
 =?us-ascii?Q?M53ckPW7KEPIgZLDrJlV8EtwiLYoDTlj6v5+djwcolqGsIz0tQ6ZVpwb0UTq?=
 =?us-ascii?Q?dVHKHCwJwQMXTTwG8T6y3PMsTo3bEfU0ohVAuU+w22l+4iBAvRJAClMb7FO6?=
 =?us-ascii?Q?c2W26uJ9q+Ad3zrOr2QBcVNGjEUPQc4+y9ifaLV73/tIWD0KA64nsgxcUk0E?=
 =?us-ascii?Q?PcOmDk+aPcBda8Ta1VwqnwQ4hM+0VtAAuudvVCEfYn+VU/Ltb/8Mq1nGeY0M?=
 =?us-ascii?Q?8UZYV993k4TR/emRQ+hHYfiUvTCg0k8RovC8xsBbh44wD5uOvSe3eRdIy8Cv?=
 =?us-ascii?Q?KT5HLlUN2i2izO18DjEkm3kZf4B18VBVuSC3ry2EMWa1fZ1HBlzqlTQsGXOX?=
 =?us-ascii?Q?IiHHnvnBtz+EBpX5uYEcfAURa8rkyB0Id/rpcT+FmuXWfdduAtYVk6xwWlNK?=
 =?us-ascii?Q?CB+0CVyLPWmM9lUT70SMLEmT5toYBc0CURsRqV4yrEu1sVDneor6R2ouZSzC?=
 =?us-ascii?Q?1IsFibs3E2NMsVKvQIEWxdHZwo6+hYTruRrKyGHVf6O9yMiuswX0qX6uAbem?=
 =?us-ascii?Q?5NF9FronLD5YCeqsjV8Eu6PFV5X0mVumGAXKv5OOwbP/LE7mujAb5J8PK+ww?=
 =?us-ascii?Q?snHnuPY4BEewfyypDTXTZ8zrecCrv4FworeuApjZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f9f43e-8e7e-44b6-6e62-08ddba5acf1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 17:55:34.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcTSHCWdDj19siofnJUY7SwUjXDgR1trpwCD/49gGvUjcI71jYsWIVpj8oylv7Qj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

On Thu, Jul 03, 2025 at 02:46:03PM +0000, Pranjal Shrivastava wrote:

> Right.. I was however hoping we'd also trap commands like CMD_PRI_RESP
> and CMD_RESUME...I'm not sure if they should be accelerated via CMDQV..
> I guess I'll need to look and understand a little more if they are..

Right now these commands are not supported by vSMMUv3 in Linux.

They probably should be trapped, but completing a PRI (or resuming a
stall which we will treat the same) will go through the PRI/page fault
logic in iommufd not the cache invalidate.

> > The goal of the SMMU driver when it detects CMDQV support is to route
> > all supported invalidations to CMDQV queues and then balance those
> > queues across CPUs to reduce lock contention.
> 
> I see.. that makes sense.. so it's a relatively small gain (but a nice
> one). Thanks for clarifying!

On bare metal the gain is small (due to locking and balancing), while
on virtualization the gain is huge (due to no trapping).

Regardless the SMMU driver uses cmdqv support if the HW says it is
there.

Jason


