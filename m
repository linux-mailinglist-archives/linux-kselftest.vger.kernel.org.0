Return-Path: <linux-kselftest+bounces-26007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB2A2C713
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 16:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E868F3ADE99
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8721E08D;
	Fri,  7 Feb 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2A+en1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1E1EB1A4;
	Fri,  7 Feb 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942087; cv=fail; b=K7jfDUua3Z1DQkNxHBdvgasLrEIcnoAqoBfX1EolIahSz+un1/5b7+jWcnJdP1+k5JI7cpecsJXqvfwokpyXqJi4ArEzg6XuFNppCEs9LSzM7ZVYJAkBg7Gz3U0jOCLNOcsRlXkFPW9mPhKw/DwP+rjc+ypDALZEU6aHQpsutSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942087; c=relaxed/simple;
	bh=EXO4a1JZEeZ3BbFAdEd8HN7rQKMH33rbz72WlsV1jSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fvOE2yjy2L74dH3gULy/R0BA41l5trwa+iEFz+Kb+9kZ9XlPvIlNYdM/iOtJPeR7u/4JAE4ue0/nmAXIDzQ0XLTbHSOYwj3o9PdD6hPKd+0hplNcwwxHty02Tg6jMp2ljh7SaJv4S95oJm4PT8epd7tG/iIK/w3v6rkIbwtg6fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2A+en1a; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8+J+AOllysKKg4GFWbQGMUiWBQouuGT1yWf4oNA6DXIR015yEUpov5Ic3gTY5eu5iZSOpE52JYEGxeZsW6MrbUeU6VDsOA68GccIxMMloUK8YKNOnp8IEq7mcCGf4vtsNwoa0OM5b2XmLeVceF/xS3/ZPvhK9stMu1Hoc4Y+/U/q806jK/4ZMtsIfup2HMAqs6TO1HVZgwjwmpCzZD6dY+ng/Do4MLzrChRVZ9CzI6ZZO99gUAtDBPSLHAkqGuHgCKm5VIKsoPlrA05UWPOoThQU2Q2LFTEn6M3hvHNmFrvzh0j/CbDjni8b2M0ELeAZwRYTz4EG4I6chipK0Fbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEob+rSu3h/Q+RsvYkaVeS6ru+Hihdn24hXq5//BLwc=;
 b=BBtMjM1YB7vIzveJlkboan/eLZlrVvT35p/AXvztWHDRR0HRDrWBv2qunAVhSIdR2a7V/RS5x22PZw7fYGkYJrRy/3E3NK08r0Wv/WzwNE0uGKQYWJC4EJfuSGEqJlHfqFTSLmd7f+VUqTjfJn8F4kYtZF0WXlgvXF8+cmjsso0FC1sQGPrQ4r1vURz+gsyQ29PdVayKbrppfSIj1/ANmG0G/JYTgi/HrRnriimbcoWHHPm5i4iqGVBVo3oOxq3PG6uOdR77XYTy7ySiaVkf92yKWZalK5zqyNGgleCq/4IslwjeF1SvENLMxXwGxlY6r22RsVdwQmfDJr7voQ4zKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEob+rSu3h/Q+RsvYkaVeS6ru+Hihdn24hXq5//BLwc=;
 b=F2A+en1adjP0AsY2vtW3hT3upc25TPZ7uOp2VkBlSENlDr6NWAdyBoh3VTccztzRPU/MBK96uIH2wejZMA890VwlQdfgxy0VGoBsefN6B+lDs4/9QQGdC2Cl1QtNCcKyeJujTg4biycRUuiH5HdvZUpPvOrHQmQ7q6R2jFH77iyRzFdndml9Smly4oFOBuS7Xp3Xc+D9lNYbDkYgazPSlueDBL6V9nLcYNXv93+hdGWOdJepDp0UpNl+DsyGSR4O5aNEBV0LEfuV1C7P0NF1HNAPyNLsHtfFRsEFnLBleeZMR+MkYq3PjfAnEXY6HgFaDUMWJjED3S01jGlAZr5BIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:28:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 15:28:02 +0000
Date: Fri, 7 Feb 2025 11:28:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <20250207152801.GV2960738@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <Z6WLXTiYVzuN368E@Asurada-Nvidia>
 <20250207143020.GR2960738@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207143020.GR2960738@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0703.namprd03.prod.outlook.com
 (2603:10b6:408:ef::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: bef4de26-1b8e-446d-3b8c-08dd478c02d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oA+7td6602OBogNE7n0u7TCEg4PU8GwTgRGB4ZrKms4oag2dwdH1T8q3Vp4o?=
 =?us-ascii?Q?t3Zrhole4Gor+Qs6pBt8fhG6T5n2Bl0kUyfHvZUfRe88ose5tLubMtNHbpan?=
 =?us-ascii?Q?AH7LMJHcY0AsMbUdX9SID+Nuc6R0OkPZ4QddxOakDMlHkHbmIN3ma3XfQJ4d?=
 =?us-ascii?Q?HCSjcMj5+r11WgAcUIQIHOF2TdRGitWEZ/n292zQikQolzp2wLrRy70ixvn/?=
 =?us-ascii?Q?x+CVxtxHm4rVJaszeAc+jq2L7VNP4TwCa5N4/MCQ0hDST3RX0ZeC2ojybwpY?=
 =?us-ascii?Q?1KRvNA93aS7bggm1mghEQRAl8HF2zJZqzf62jQBZKeIfwLP4RSJI9ciiwEaT?=
 =?us-ascii?Q?PtKq2cHk4TAnDMP9TRz5/WoSyXP+9roYTLt3rOr4UDBaULVSXBwWaxfx2OMh?=
 =?us-ascii?Q?QcMSIvtTd/cQpOsEyuq8f5YNNdIPSfAilRqiFrf1YO8eKJIXcShLYq0BCWyV?=
 =?us-ascii?Q?G94bqs+VbnZmlGfMOyTeSfX/bOebCtaAfHW9locnAJAyQ4GBk/vMAMCmEukl?=
 =?us-ascii?Q?NBnhihiPkkynAeX8QkQXZbGVU3MYuDZI/lKBOsU9XDFjjhBhjAdNKtEyyNON?=
 =?us-ascii?Q?A9ltPdp+ox9rKor9dH+us0D8MSbi2SR3JVVL+7HUT4dZHJuU8GeJzn2f3hzk?=
 =?us-ascii?Q?wB015+6JDZ7G7sVKjvLFSF2TWxfESofz8utSWqnPNZKOzUFPfD6F5VQwvOtz?=
 =?us-ascii?Q?ETquGktaRlorSZ4rffTNgOCE9v4cylaFsYqyyUXMnialQV/FjbGBstlQr4vY?=
 =?us-ascii?Q?TsmmJ9Kvy8zQDRZw7RN64AaC15ucIePw/SNny0k1KKvNWDqr1ZNVCW0onevg?=
 =?us-ascii?Q?81wS900FpuUNX/rv3pOh+qPYgHYxAnaAk66sNkTFEIpoUde/3AheZ+Ie/jtK?=
 =?us-ascii?Q?jRKMn3RI+/Uqa0uskL9srcP35etwTV8la2lRZojBPGRif6bwAmv+Gi/draoR?=
 =?us-ascii?Q?rfwLvDjB+kdvc5acgOEmtWe72qwetES6iz8Tar1XmuM5xXjONNRBJmqVOgye?=
 =?us-ascii?Q?5ZzuXebrP6pQCf+w/BFs2L67roffUgeqdY5mTj4qrQsgssfge371x9F4Z4fR?=
 =?us-ascii?Q?5NqvsNHqL2T1+9CMubh4ohMIwLfH0TE+txR6C+DJseFjESD05vOIDtBt9uPI?=
 =?us-ascii?Q?g9YuL0BSFABDN5QUHEPJNXK8HO1Omm/9jWNYe1qT6nZo89EtCsQzRx+SHsGo?=
 =?us-ascii?Q?CLuZZ4n+qATACkOmgcpTvAa+ZHCDxdu7VHVfGnTD3jXvYui+jxY4pTqyjBK1?=
 =?us-ascii?Q?JNltFdNihMITPv5SOaPuV8C2otVtq9VIUOfqjfHhIfCXApWvSbM7tQvyTYHV?=
 =?us-ascii?Q?vlFYFCdqCaBcRDaBZhDnMJeUY8MxETEfnVMJlfrhdNd9doCS63v+tFo0tp0u?=
 =?us-ascii?Q?d/kp6YzqNO2aDgIF145gtiFSNosU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qtrvzjyDeK089hrF/yyczm0dT2PF54m3qVFYs60UO6Zwpqt0zsOy9kRTzZkF?=
 =?us-ascii?Q?0bz5WL7PgwdiEjBWivdGR6SuPrTVroyS1F5eigRWmY2lANIUnrwpY8iAeEpN?=
 =?us-ascii?Q?LZUnojNssorvGGOgjFz6UYvUNOT7e6yAt3tWRgLIgFx/N5h+ZTPa+4k6oNxH?=
 =?us-ascii?Q?U51Wt3Fc4xuexFEqVETa44wC3RO7QQ/7hyoKXVlZNLjOJoEoaHKV3VENbNjQ?=
 =?us-ascii?Q?JgJ0tipvLhUlzsYcO5PLb8k7/6XTtIqfUETJykNBZOIiF0JmvGejXzPqpUkg?=
 =?us-ascii?Q?kZ3qh53kFoT8ongJkWt7qtjlSC+thaYnj94Qw8zzVxe+N1QG+SekpWjrv5Yi?=
 =?us-ascii?Q?dgr9xAtQ1y42G14Ged4YSxPcWyxvfU0dYjM3VH2HSLVaQ6dlti8curPfkZoU?=
 =?us-ascii?Q?yXjI7s/ddkNVvBtKztWrnyHnVANOzEo0856kv7rd5OOr/ANajz3ZGJ8dQsqH?=
 =?us-ascii?Q?dZB/1NYthsAjaQSZyH4mfE3M7LjqVTxFlmU2HFtXfLsw5ioTW/wl3ESZQlN3?=
 =?us-ascii?Q?n1eOFlyC5LbxydUCYKjy+eWpXpk4L+CxK8KCkqaMarmM4wlirjw3m3Eybt5B?=
 =?us-ascii?Q?PTGBpp4GuhsZ0vd1DLmgk29WxClzAACwHo0b7I7FziPkeaDW2DU8rwmnJ5ZQ?=
 =?us-ascii?Q?JcsF5p12QIO5EvuhU84x4IPn3xCmqFzYmzE7d9OU1EOGEyAmZmdOzo8CqAXF?=
 =?us-ascii?Q?86W0skk3fzPKW1m38szgdRgYmDv3ohrEBB4F/c9+MqGV9rmkVLyUoIQw16KE?=
 =?us-ascii?Q?mQxdaAjHUjpBo5gkXM9i8usY0pGNWUXrPBCa163Go06Ms+2wDb+p/w1tM98h?=
 =?us-ascii?Q?r1No5pSFJ795fVfS8w/gb9ApJ1JJvhMkfvtCf1Cx53erfFowKbXc21ec7rGY?=
 =?us-ascii?Q?c/5e9ZZg8E3CgJLNRntDPnGtz3iBEsHFF8UoquxZsWRY5ZkULnLlHVtslEWz?=
 =?us-ascii?Q?cbc2sYdkmPf1ETrKBB6RWa5YiD5cOQbELW6j/dCL+an8IShPDZCcl5U8P00M?=
 =?us-ascii?Q?hu1ElNc8nRUalEM8NfDS53Hw1Er8ozsJy7MOTO/uw9KPL/Au+uaC5TVnTrHu?=
 =?us-ascii?Q?QoW0pghh5SdywVRZnaNiIzQs6XJSvKGbgI+ub8Y7rmJRJRzTRwzB+q2DT50h?=
 =?us-ascii?Q?jMwJA7v2rSq0Nu9SEFkjPZ9RXxDz7w/mOGXWgG8A9J+qvX6Brn14t/t/5uBX?=
 =?us-ascii?Q?9Hyq0rUwEojcNHpw8VNYjRnyL05T+4g83mFj8tJYNAnTmHFKxzEE3fiI5N8Y?=
 =?us-ascii?Q?FL5//Mk1Bg2LZn7IwwgCm/Ixjh4IY/CGlmO60NXVTwLIRbLgZSmoVJmQzPHL?=
 =?us-ascii?Q?X0zh6Cxxl1f72EORrGEmZifQaevpQen6QUP2Ul+x4pr2X4V6ctdgZUvbhD6L?=
 =?us-ascii?Q?jBr+svZdXh5imBLKMnre2J7s+QbX3Tc4+rIikEBoJ04Kwz+4pvOBT6dnhvg4?=
 =?us-ascii?Q?e8xT6w0EUSFd51znm8b51IW7AdqW0IhIJjjXvdmGEE+DtvWuPW2Uw7X/ywWR?=
 =?us-ascii?Q?QvfRhl4g5VV5xIcurM++MUyldxi6MpgKWksw1PnqCnnrgGmMZTqbjuHi//mL?=
 =?us-ascii?Q?YrVUr71cbvuwa3jtF9JdcAzYHN6gERVDojOcGcss?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef4de26-1b8e-446d-3b8c-08dd478c02d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:28:02.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75CRVrA3CMsXkbSD5JpeM3JimhRJaqsSmiP+Pah9gJURDHe5TkNFTNBrprTNya1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

On Fri, Feb 07, 2025 at 10:30:20AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2025 at 08:26:05PM -0800, Nicolin Chen wrote:
> > Yea, I found iopt_reserve_iova() is actually missed entirely...
> > 
> > While fixing this, I see a way to turn the OPTIONs back to per-
> > idev, if you still prefer them to be per-idev(?). Then, we can
> > check a given input in the set_option() against the device's
> > reserved region list from the driver, prior to device attaching
> > to any HWPT.
> 
> I didn't have a strong opinion, if the idev works without complexity
> then I'd stick with that on the basis of narrower scope is usually
> better.

If you make it per-idev then it is also implicitly per-GIC as well
since each idev has exactly one GIC

This would make it useful as a way to get each ITS page mapped into a
single fixed location.. 

Really hard to use from the VMM though

Jason

