Return-Path: <linux-kselftest+bounces-38029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495BB13A05
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3187E16B0D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79225F7A7;
	Mon, 28 Jul 2025 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkYfL3fx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192625DAE7;
	Mon, 28 Jul 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703081; cv=fail; b=DPKJJy//p03O/lI5OdW2h1lrk3PCe35izm5qOoEE9Qq/QDip6NzeDYI26CZZCbHX1XDom8LfZCfCt/X3UYyq5ychWKDyZwdCBid73DHbSQB3F3BGgCzB44yvpbIMK2QR1lMPRq1CGipneed7UjDBEFy0F7wSfq95bHp6Rq1gB5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703081; c=relaxed/simple;
	bh=30oiIyw6IQJizwKGBlZriEPMIvbrkzOqekDskq45n4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sy7e6bzI/SAbUPaetOCHLu0BgBfa6ZK18d0KwBAtHKHbwl8mqq6M4rLxCiewPuY3ew1DeaHyiChy0jV7VNQF70Voxm73QVG+0A4T5UIwNfPGNHrinFQpAPerZT9gcS/NBuEtrmVFSBSebYEbOIICiR+siDdx15tggBn6R5USBj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkYfL3fx; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc8B0JXotyx0xIVVvZfdU0zwne/rs2HIz1qBTVOhe+fgQ4RupKy1HfWjqswUnyU3pF8TJVEp8L1jO9ub/WFLBLqcjYwVwhMH5dmI9ktBdpn8T/NoMTyM7RA7a0OiZRckuzj0wPBpPi1eivNloNcLQvg3tD2NeSYBKM3EcybOetcZMsQkYiSbZBlBGQCAgxXU13P1gC0bxTQ3x+zdtApkeeayfVg1QPviZ4ofezv3wSwD/pk1w+PLddPYqhgAOE+TxAOdBKvxbGSlNv1wDv72+jingT1Uzbfm8h6t3Ra+LNNg6p+J7i+sdgHBqQch0avlss6Fb60tfX2DWg5AuWxP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64O5ruImSg/d6nUJPSuP/LhpECzJ4Cty47+2wI5u1Uo=;
 b=uVVDvkqOywOQHYlJ/qJ9keUMxrZ1lYaFSt22gb8VPPDh+jKds8+27eujhTb9SMYfcR/G/6PspSzk0paJ0pdNOvm0Oaq5g2ekOMkbMQDVAdY3JcWcNgiWBvg1Xhg2ywCgE5GKNeXbPyO4T18Gl5thT4rqcrG9JEsvSnMjSEKc6758hoi7VH9HEk01ts+pKg4jBDLjxCzrKIKAhFQZAiOqN0pkNX8DPfVZ14xZ9/1YyfJaBcPwcAjVPPcf3YBbKkqGenLJ+kB8TQZqj2AANTfpo65Uy83+TGP4YObI8L46JWf9thGQttkkbJaM6pHzX+aIBWSdC951sghVgVck0VZVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64O5ruImSg/d6nUJPSuP/LhpECzJ4Cty47+2wI5u1Uo=;
 b=MkYfL3fx/wptV2aYgQzhNrU9UXiOgjAq25iC1N3tRxQyxFvEpeG1RuAwQ2ydi/zTNLUQKRqqxa1pJSlHVQVJjuUSgmjKNfHKgOAWaTPgXCSm8vuHtYUx3aqzzcyf9pBLtn0eZHIIAE8/mt3Ck6GcYYTAVMCU67mq47RT7aK/hZKZ35OabdxCIKK3f4SKCjs73+fmZ8JRSG3BtfwhIB3sJbVc0ezrns1mOAZhlEquBgfggbC0BU+abwDSUYIVKFnstUoS5NCbdgGBUC5i1OvSHYbSBrM/YSImYL+yae34nZH+DhcN25gHVJL97TKjvbuNQldzdON8EChVQ3KYEU1wGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 11:44:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 11:44:35 +0000
Date: Mon, 28 Jul 2025 08:44:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 01/15] genpt: Generic Page Table base API
Message-ID: <20250728114434.GA26451@nvidia.com>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <1-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <vbbvejcofng2jpgozzgbh5ifnmdqrtfjs6ix2jvuw4rfwdek5n@3cldml5ry57t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbbvejcofng2jpgozzgbh5ifnmdqrtfjs6ix2jvuw4rfwdek5n@3cldml5ry57t>
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cde5f1-d515-474d-4547-08ddcdcc1fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5znpgZgNgar8PfSLiqvlK/QhDn1OK93XhFyHsOIfjITFIh4/6YGrBByPorp?=
 =?us-ascii?Q?pU4rqwa63K90Wi1ybdGOGCNMoBmX64DjTc1jOWBGl3eK4l05dPmpOxrOubUt?=
 =?us-ascii?Q?WTKFIEfO3CAu43/mxS1P5Co3venUrMe1ZY0FUmJPd6Es7IHnq0MI7I1L+YEo?=
 =?us-ascii?Q?vK0mWPjb0TKHc4hqpievw3xZx2bTkq81q8mb4g3BOStR+gVV/IfUGvoymYN5?=
 =?us-ascii?Q?zJUCG/IdYu1i52/9CPHXoE92EH6ViHGE2xZk3+bwNeCuxJa2pWer5Q36O2N3?=
 =?us-ascii?Q?XrhdlJLLiLZHJzXYYCLeLSDzmLaQX/hthSQUV/tRb4+ttt7jZPjV+wwf2vuq?=
 =?us-ascii?Q?VsagXrouhrSZ5GK8HK39Vqgun6EHLiJj/4rjVllhGLZKlO813qro/BY7yNNg?=
 =?us-ascii?Q?YqMeERhzrrdWWR5ywkwZ1PmmQXKEdaXX1qc5Nv8s2SLimyTHJ8JaRh9n18rx?=
 =?us-ascii?Q?xVd0nsIOTX7Bhctm8TIrQhZDI4gZfncuCb9IRDZroBjV+TQk2t0p4LQPa5XW?=
 =?us-ascii?Q?w8VU8qZdherLBp9zaXsqMAc1/RvK/R0phdupeuxqxkDYFNMi1uKgavkw1PU3?=
 =?us-ascii?Q?o2obHpl2bK5wDK2J/Kp2+mHw/HXNLaS9RZ5oilfBXsh2cOobvV8zO9SCx+CU?=
 =?us-ascii?Q?HpV8u/632nidk/UmDMJMZs+Nb6YmrB8lgD8Y0RDJGi/sPr7CZuYZJvEQ+Cup?=
 =?us-ascii?Q?MOXFF9NFWitu8Gj+JRRKKs6ZeEs13+9TCVO80lPfaCGSLnHl7HyP1ILVnQwd?=
 =?us-ascii?Q?aT1tXFjSfZycT2Kj+MxPKpn+4DzYImsSA7K8aFM/5bxJhzx+2BrF3BlOICzU?=
 =?us-ascii?Q?6/ElY1rG1flvsZ25QjLAnlwGkvQY2pI44rfpwkxAylsn1hJMe2V6xybZvotw?=
 =?us-ascii?Q?UJSPM8H+JjH0wmSkt3FMJjiIE/7rN55gDYr8L/yaJJbWgjfW6MDXONrEWOS1?=
 =?us-ascii?Q?bB+4yZU2zJMwWThVMgHVsbiVSF1MGh8/5tFW8MCWF9f+C3fG1r0hMOuRzqJR?=
 =?us-ascii?Q?6hdzNxb/9zJIcl1q2wrrjyBEFZZjNf/Ie8PNadm5F8zqVV6lLhad3jS6e2eq?=
 =?us-ascii?Q?P2liVq6gPPaKr1H+ZoYbqRforCThw0mfl0Zxeg8HVspZnPwNA3Pgvx63MQTV?=
 =?us-ascii?Q?9ZICmGRxt6MdFik3Tj+G7mnaOPb+7qGGANzy07g2U3/ylvHCYdlxlQvEAQoR?=
 =?us-ascii?Q?TCjqmvPOpTlvzx1ogciCFIo7VLqQklCIn+M5MYf/I/zVRC2rpknXO0/vFJ1P?=
 =?us-ascii?Q?7Icf4gLwcwRELQxq4zZ7xxhr+9igx8CaAsrVnYhcTMbfmRYoT8Ct7zGctw11?=
 =?us-ascii?Q?NSZoIdg2cx2uYS7DpvaI37ZIpA154ZndFun8bSpeSC9UM0rNB30RYiDfWbqM?=
 =?us-ascii?Q?KfOkp8tgzn4slR6n4llMeah6GqAsSRdLUTLaON3S+Fpgx/TjADyRpFkrJ9On?=
 =?us-ascii?Q?2N1h6SvCU4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vra7KWCvZrMEmwj8RqfZDQ209ZB7QZSoetXkbNCQ//PTD6lN5S/zjrTnHRAG?=
 =?us-ascii?Q?/qiKBYYvul//xkQfbN/ZWvJrKEzsof8IZA5Lh31eBaKGWGtx3a0Hrtk3+5wN?=
 =?us-ascii?Q?M29VqAZegYtyhFy2UxnmkLxYQ3JGs04w2cn/dTUWJF5HLLYaF5WuSu97ISMk?=
 =?us-ascii?Q?U6tKkmEXa75xqueFq21GR1niCgbepBcMUrZiD7n/g00oqSXZcafuNBhSMnE9?=
 =?us-ascii?Q?4kMXZdaeEgFGXbk6Jci9dvvE7BbkYHEa10se3R2l7izBL992/1dpTansNcqk?=
 =?us-ascii?Q?7WuyJeoULYBeQbfmV7ITSw9vER1Wva5Yvyf9pPChyGYv04Zw6C3+UJQ92nE4?=
 =?us-ascii?Q?2N/PHrhA4sT+GVGuqIyMSWaplWLX8gvkuy+352BNjC31og5Kv1OWlwFVhsbo?=
 =?us-ascii?Q?HCugnshodwm0z8zW+cshNFPaOF7mNSF+OzbLnqhGCPqGBMinQJVXA/gS5Kks?=
 =?us-ascii?Q?lKmzX+nYGPLtw7UrdnQGI2TzIqCtZNClVp3vjSKRyqjvhuYwMQC4y+nyfnE8?=
 =?us-ascii?Q?LKRgd8F+NFEa6vz8x5y19VCBZZa8p7GZAtPgKQTyLaKE1p5oCN0Cv2LuzAZo?=
 =?us-ascii?Q?GwBfQawyX/TqpfyTTVY7gwWgJ4yXMCbJymXB/z8dz5Xet7YScxTcJlVpwr2P?=
 =?us-ascii?Q?juUi7incW5/cCnEkVCT4N+htkytmSt+FansYaTNGPpfv+R+Js2zieuNbsUTF?=
 =?us-ascii?Q?dayI+/cx86ZKBrwB8LEJ4yGHjL5f4RendR6b0oOZLblMqqioqLcyPYCRJSuN?=
 =?us-ascii?Q?Z5Jg96QX/rOSW0Vd+NbdD3RYA5FvswDc3ZMJd71W6STvuQBuZFLYj+1HxAs6?=
 =?us-ascii?Q?ViT0yuDMdxC1Uk9A+KVCfimPXBKEgoGm/+mKOJJ3G2W6IMhB7lKlBGvQyOGX?=
 =?us-ascii?Q?vdGChVqaDHX7qSW6Ur7Q949X03NuDVwlVccn/b6lGtyJzTbHkQeKpYE719PA?=
 =?us-ascii?Q?IrKhy3sW4sgsSIcYxAdJzHnXI6VSFBY1Cu0sUYZFjKCulL0x9h4BUjGeZgWQ?=
 =?us-ascii?Q?zE3J/41mBykGihsZNVr+9yVQO0YPuHqJm+oZmfNLiC4ZuVOS2nxjmpQrWuQ4?=
 =?us-ascii?Q?armeM8JQgzkv0BbaTV9iEtCNftNJhx/wF+BrvZAkg/cAcuEgmC7bhtZS8kWr?=
 =?us-ascii?Q?1kjeOHrUlqbGzldGAkn/ArgUrVLs/SgVbHssi8zot3Yf0i81fxLOqlcC3Ahn?=
 =?us-ascii?Q?kRk6XfjpH6d31oWjGoMoy0SBsVZ1Xioq/O0qtIvlGfylIHCxgRqWP/El8hVM?=
 =?us-ascii?Q?Vfdp3j9VDNylE6WOPYMCbhfOXex5HZTv2kXsZERzxkhSnwxmb2Em/57R3/Ca?=
 =?us-ascii?Q?oxgBWIr8sAd8Sc2dsFT5Z2Nasw9LzQezh6nABbshRXeL5jzq9oauypn6Tg5B?=
 =?us-ascii?Q?KrEMnWvYEMxMoL19OxiKR7VZdKdmZqA7GO+iBROFfbu/6dSfsxuhB54aPgly?=
 =?us-ascii?Q?fKSroPTNIMnuMfELa9vYU8XZf8SB6aFe7sVPKfVFELDnQwJ3aQT4fONGjlWJ?=
 =?us-ascii?Q?mghKoqM4ETj4uycjUiTW3XIjejE5pvB9sRWaXz3G+9Phz+qkvwOZwAcrs5nX?=
 =?us-ascii?Q?8K6jb/wse1LCf3KOoMI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cde5f1-d515-474d-4547-08ddcdcc1fe6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 11:44:35.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiU+IkjdbUD50RQvYTGrCMyv5z+RHzEBR2rcFoVdH8yrcuszQKP7JOUS1mONRqx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394

On Mon, Jul 28, 2025 at 11:23:42AM +0000, Ankit Soni wrote:
> > +static __always_inline struct pt_range _pt_top_range(struct pt_common *common,
> > +						     uintptr_t top_of_table)
> > +{
> > +	struct pt_range range = {
> > +		.common = common,
> > +		.top_table =
> > +			(struct pt_table_p *)(top_of_table &
> > +					      ~(uintptr_t)PT_TOP_LEVEL_MASK),
> > +#ifdef PT_FIXED_TOP_LEVEL
> 
> I am not able to find definition for above macro.
> Was it intentional to leave the macro 'PT_FIXED_TOP_LEVEL' undefined?

It is defined per-format. Right now the only format that used it was
armv7s which isn't likely to progress. So I can drop this out.

Thanks,
Jason

