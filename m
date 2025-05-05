Return-Path: <linux-kselftest+bounces-32406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC0AA99DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5395117B25D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843D26AAA3;
	Mon,  5 May 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g3k+CmyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E326A1DD;
	Mon,  5 May 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464211; cv=fail; b=P7nQX/Jf8MOtsXqkb0hRm8yHbx6csYX7IsSk/OmBsi4Mh4yABFDTaE6108RRMcFwhm9Z1KhplJjQ8hKI3/UP1wG5rEjpwP2gPSE57vFoCy+ORJelXU3TDdn+V+fuQEgrzj91VB7jLQHYl43BpzC9ZRqjjoB/hf4CzDPjYlspHk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464211; c=relaxed/simple;
	bh=bddrv+CESzGpgi3HcriOZjWp+zxgRO1GcAGUYmjq1jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ITp3HNGjiUfnY1zt6r7IMAPdJcpJ8aHaGUZcyNF7Y/0c3dCuLql3jzG7dAjJV3jnjTdKBtyFUzDQ3dM6LNeLIvFnUQACFtHixEy9hpg/WlLyIUK03qcFMCb8a8eX7SEzIq9pzNeOiswz6IQLdJtre3V+T34aLlTb2SRp3UPuLEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g3k+CmyF; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4GlrnMPYJe1N+SS4Dr6u2mcH+MCOLnuGXhHCG7Hn4t2ST6K3QYqtEhb8TjKcQ0BZwpb2QZeqq6vDi8CgI0N7BVvqkNiEpcwWKVW6aIjZE+YpDdBiONMhZg10pva4oT7pB5Tw2W4/FXbsCp5EM2cw6tLB9s2bnzKBhFXp5X5W5cn6E6h29Tj6nX6ibcyefwa1PVeQ/jzrq3np2IkBAeGQP+pNUB2EM7UaPqufl2sE7THbaXtQqBF5c9zg/dczl9TO5wBj6VaA5RD/qNnR6Wus3gEHGvWkuIW4BBripclbrFvNHBgQQ2LqhsA4CCxdlrB/qrR1MUTzwUpaFlYU84Y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bddrv+CESzGpgi3HcriOZjWp+zxgRO1GcAGUYmjq1jU=;
 b=AVuk7DRLN+nhefCRTEo0oCSQ3PdZ7EC/1Oyo5DrKjjySlF4tgRVLFyw+bVHSxm1eSv979KI4ml6wSL1CfHw+rVlGwoubScb/70RYDRm0MzxV6ojpoCj1ZsMSjzGUWnSeStlmP6cwmD7eZDixn+tIWMObBSEX4Di8KHzYLquFoxIVWJ7dMev2jYkfCWk2t5SNPLdwCbxeOP/tVkQW8X4LStYITF6f5fl0tNa1drBsWWTJ1gU9cPcExhY9f+d/PhkDPUlC5EbnevIgr1chI0UtukIMQxMJoPhUixLLQvCl44iSICMvLYmxZvSELluDPFfFIqrYFYS9gn3c6UsWjOsQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bddrv+CESzGpgi3HcriOZjWp+zxgRO1GcAGUYmjq1jU=;
 b=g3k+CmyFfktpatciWui/+PPaKEQBYnBTSKEVERboXP/RO60IVPtDQHVaideJl1Yz0ZEr5jpM0wWYG4eXqw2lZhD7ThqFlVe1sdw8Z0Y1TJ9eU1nb1CNhQ4RF1w5Q05QBBRsq2hXso0mCFHXmUUO+k0pGaQiID0ztOCjG1vgwUYbGqfwTYXXKSRAoZ0mNwuQTQn4BjgZIZL5OjUDRWHKT4MPr3IKVjnTlwIJzH3teJHWxYz+PnoN/v7WElslsCCma+n4LkETM6nMbECnl32yB1tP3KK15x/beupzSb1EZU0Gn7ZhxS/JZayoJnw7/EO+A0qwn66Ez6rYZM9x2qAlmtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 16:56:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 16:56:47 +0000
Date: Mon, 5 May 2025 13:56:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250505165645.GO2260709@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
 <376566b4-6c13-45ad-b1e5-8cfe2de437bc@linux.intel.com>
 <aA+92fNNbDI3Qowk@Asurada-Nvidia>
 <20250505150109.GH2260709@nvidia.com>
 <aBjc1ny0Zs7K7gDX@nvidia.com>
 <20250505155505.GK2260709@nvidia.com>
 <aBjhUL5/n79cJ17f@nvidia.com>
 <20250505160554.GL2260709@nvidia.com>
 <aBjlJA1ZClRHftdD@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBjlJA1ZClRHftdD@nvidia.com>
X-ClientProxiedBy: BN0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:408:e6::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fa1166-e61b-4bab-eb14-08dd8bf5d243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMjRoQp5IrVmeulke5TGysJH7HbIkLEQAbgNa/Rvz2iCyokZHKMvJProvhJ4?=
 =?us-ascii?Q?JbJ+en4jr3+hg3nIRIH8PtouWpQ/xI14IYEnXPPtAK4IlPysPsQvaJ9tYa/A?=
 =?us-ascii?Q?pSwxTNlBdv/LEyB3BaIV1DLblyMt9bIZC52JFO9IzwK8V8aAcWkxKMhUhwge?=
 =?us-ascii?Q?GX3bMFokMRFVoGl8l3oJC3e8gKlePraXCSmKsZYWIsO6UfmHqU/H7weNoeuV?=
 =?us-ascii?Q?a/3RCcxE46neD4BDTsTicqbDNHw1XVEx6nwzNnroRB/ClTuteITQZWwznrUv?=
 =?us-ascii?Q?IWgy+kLKVeALFK2X/FY1U0nrWuE7/N0wZiPhzBQRC6idsxo40ClNYqi/5HYd?=
 =?us-ascii?Q?WSzxTvISuso8RXaA709ilE6sRcsFKqL+5bg+LFxaeJ3w53X3ZOqqUOab/eNx?=
 =?us-ascii?Q?C6YPPlUwNMXHvN16fmyPpUWavZ7sQk9F7L7gY32y5h2ExbWGTEnwZtS76e07?=
 =?us-ascii?Q?veaE6RRVVHDDA6zxwnh7+5PDXAQwSqhjiAQV7A6BsBJIVLI+0tWJ89engoI3?=
 =?us-ascii?Q?L7LiLhEmyh6WStlXfe1/393QF34sF5n5P5tF6zl67kQtiNr4bT03wmRRSs8H?=
 =?us-ascii?Q?qhov40TwG5aPBuLJC5q66fAdRJC/8nfi2kdicsEKpYxeH3iD0sgIyrY/LuJG?=
 =?us-ascii?Q?TRq/V3VbfyTC3cjarmQm3MFZ0cPASxb94QDfG7pndm2Vf0QggyWFBphK0Vl9?=
 =?us-ascii?Q?FN/yWbgOwif/7uVU0t3/sIma3QD8Z2sYw+HXD6HTvAlhMSHPBLUo8wsUlMxm?=
 =?us-ascii?Q?j7ysqZnhn5Geo4nX8Q2DOuPBIa5WgyzGjZspu//TikRPCIYn0G/PcPBFDWVa?=
 =?us-ascii?Q?9VV+NkPFYv/G9fPR3+psczcFh+EspFyK8NQ3GgLiXR/aS2tqBFJJQCjgzgHo?=
 =?us-ascii?Q?0WuF7A2d/ekJCU6tpNxM0c8qYcHoSE6sy0DtGnajpfEkZ/5drIQchoKtJJrU?=
 =?us-ascii?Q?qTC9+dB22tGhFOeCtazgLGoiSJnsOEI45OWHPHieJ/MhyiK7L1xRiKMwIwkH?=
 =?us-ascii?Q?5+hjJZ1BVz3DuBAOp8bkWnET8bMLaxx5OgIFC+fYTCgO9DD94kWqtU8d8b3w?=
 =?us-ascii?Q?5WR2RB9bxtdBl0OikqONfOE+c89DcVP/+EL7B5NeolaRu1s7abZy785OBrh8?=
 =?us-ascii?Q?7TDwNVWhDwkJaK+mzXiG1DyRkY7BVGQFUFuQg+Olv67eFekBMCPs56u/I0lL?=
 =?us-ascii?Q?8EPkDzdO3ZEFcLfBwyTyZVYImHKlReXQaLH9POaRLM6f68rf+yWAZTQM+add?=
 =?us-ascii?Q?VNd+IERspE/GiM4t+blhDUsi5WIKSgWT+O73F01v3vEzsIB/9q3mmQKjA2CC?=
 =?us-ascii?Q?EFMvx+VUBYnmImmoe13iBYjCHV6M0goYPw2BE5F1qvydy7SNOc4CwX/xIuXx?=
 =?us-ascii?Q?26KKDIyi9hxp7sU8QBtjMEDm9htxO1dabjX/31Y2ma+Ik5jh59dHyT6upe/o?=
 =?us-ascii?Q?jbDJaJxArRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qfdF8sVWzT0AATNNO0TTA6ajUla1bvnYtqOK0AefyaTsd7e46fSx+CwS9HtL?=
 =?us-ascii?Q?LaICxyxRsHpAAQM8QqwHTNXW39N90drIczX1ZCaCg2mSTVPY4/gY49QcL58K?=
 =?us-ascii?Q?H/482Onn3fuAR5qqpzQZBU0yjDujGu+MeP2zvNFA9/vuxK+c4fOxU5+tmSSU?=
 =?us-ascii?Q?4yS6q1ZdDTuieABun0xeR3tpVGtelO+c6m2xY1RRF2W5EwOdaeqiPYkD1H1u?=
 =?us-ascii?Q?wNFvwCt+MXNakD8mwYiCkcyYKw37oAKtzc/hQavSYOUF7JRUVPB5BQf+dOhM?=
 =?us-ascii?Q?RAmQvjfFFFuaR6cUMWWz5Dz6qq36zl4fow2AixECzSSl9dt8D+EJtLV90tBK?=
 =?us-ascii?Q?EL9IV9xs0VISHmPw/Ux6iVvKUPMet4wMIln1E2awk1Dy74iUdXQ3SJwfuVi3?=
 =?us-ascii?Q?c73J8NaKfQZfhxu39TsBwvKcUk8A5DoSAF9+T2SWdEysVyn/G9ggTydotcav?=
 =?us-ascii?Q?etjdWdOwnYmzE05P0AP0L/NeGVdpj6orlx0VP/qJr/zi4pvyMvG698q64IyV?=
 =?us-ascii?Q?N2cwIN3aFe5NATLZ4GI1A81d1IP86o4G2w0m77yAjfipzjSTaBQTLG8hY2JN?=
 =?us-ascii?Q?uQEblnMKa/zM0pRwKHxAEzD45+hjY8g0XMya//FTlqJ8+Dut2hDieUYydT0P?=
 =?us-ascii?Q?pXBnRQjTkfcuZlXcn53EgZm4/5yEsAlSiG4aXfPXWBYFZ02CGRwkGPgtyPe8?=
 =?us-ascii?Q?5z7IFked5hyf0FS8k7M5m3nEaMOaRsTMQ922yzcaS9tDLb75lRf6daAft6wH?=
 =?us-ascii?Q?sr6rJZlQ9Zi25bZ8BG95S+yiyYnhRSMDwG9RCUxeCDlJYfqKpeFKimlu9f38?=
 =?us-ascii?Q?21KgFZJk1JSNKKnbs/zXunr+jMzsgMMPPW6nUQmSaEsGCNT5P8IzbPSG2fUy?=
 =?us-ascii?Q?wiln1XrLLoQr1Ofr3NvQeGDe8RlkV5uEwTPsVTgn06OEfliCwuKcGo+0WbvC?=
 =?us-ascii?Q?vQvWO51kc4G3kqlw6LUWFIrhAvvWeNHanRMiwNgrrPiTBeFyej976AbNYqh/?=
 =?us-ascii?Q?iBFfrAIFVswqui/mF7GIC6snVpkvdrxUvY3QoP34woJp/OwqaX9oW4ZQPK35?=
 =?us-ascii?Q?rVyPweWnx5Je5O64P9a6AO+SdB8MZ4q5exrhvxFjFRKGxNoBkZZMuPZm9Drr?=
 =?us-ascii?Q?GkEtGShPeECs22Qax+mcVYZvlQoguI4rExa0V5ddnDOZDeA8HCaXxsOwhpu8?=
 =?us-ascii?Q?uDR1JLhf4TNYQQI5BduxwhWEF/djopAtUXm5UuqNspKS7SHotOxdPqVT+RRZ?=
 =?us-ascii?Q?IBdW7u/Jd2taJqT//zBceK0rQ8yVHd/m6HtuKyfLUta+WpFCBMCk826JUjXF?=
 =?us-ascii?Q?3KNI/KMEvUsIp+kk+GypLcslZOIz0lN1kpljghNY5VukI2Xk7LUXNnr+64vh?=
 =?us-ascii?Q?erVi8GnnMKAuAhb9GI8VqVFF+XEmaVGO1wHWgRbpiMNR788Slq6MnmhDhohe?=
 =?us-ascii?Q?Wg/gTJy+Yt89POyWC+BoSA5W+Pi9mvFszx9bRSMCsj/LVbHxZSn4g/yzP7Tg?=
 =?us-ascii?Q?yg6nJAssMu2N/E/WvwDefYBDAIDbV2UMZOTItDzOYAXwmipmCotE780rw0OU?=
 =?us-ascii?Q?lGdrqIrUO1HyHhQSt/D1q85XMh9fBjYcsZnjimyO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fa1166-e61b-4bab-eb14-08dd8bf5d243
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:56:46.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNU7LrzlyK/KqJGG34Rz69YCejkmdVxdOXXYLK98xPQIxu+POrGhLuuV+ExZ8s7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250

On Mon, May 05, 2025 at 09:19:48AM -0700, Nicolin Chen wrote:

> In this case, I think it's similar, so we should retain them, as
> they were?

Sounds like, if no combination of ioctls can trigger it then it should
be a WARN_ON

Jason

