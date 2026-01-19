Return-Path: <linux-kselftest+bounces-49415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76488D3B840
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E1F53038970
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B82ECE91;
	Mon, 19 Jan 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3QsyMBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9B2C2346;
	Mon, 19 Jan 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854412; cv=fail; b=skgLYl+ybQZk/iYYhCLCBUWmO9NLXUUFjdskHYaPJtPLD7gA7aMbRh+1FoayE6O51gKEsLUeVIYhzg3g2v2aSnLdEZptRP3dECzouy4ath66znNL5KUTVRLBnTqMJzUO0A8NcuQA+DhKdalQnicCuh2m90lPc329T7PNXPpIU2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854412; c=relaxed/simple;
	bh=wJZ9ZgUD3cwZfI+9HL48w9A/IV1V4AfVvvWr06T+4W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V/kyuCqDr+v8gqlz9GcCePaFfW+cOwZ73ckW4Xoa94Zz0CguEql3yeK2edGUsNAfuisEY4DuToh0zijzkFMIDf9qNJf/B8gQwynl/se1/iqNBfLiUaQuQDBQy/9rIgLwIgJdTH7hNLubUConqO/ovYQqHagkRc3QeQdnMvW1jYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K3QsyMBa; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9SMHR6SMoe2UK7AjKk6F83pJsnsOAB4U1y6SKyAvruAAxa8YT24UJOFFPDKmzwftuncfF1dHuUZKNrnmG07d434Ar1pGmophO1xCMKW+WoUDRVdWf2kUVLT6o/fEh80mabSbC28+mUA+aqKOAbqy9NOEPl0zo6SBEl81VFYsuwAA7I7zlMLz0PihHSU+3R5htLfNwpIhPPafkMnZHCOqvga2mHPBCJY4EKgb69nxmYSDqS94ssl9hCSVQbUmVqeE+6o05s1ZJk2DWkTwTyOVo4FmVSyOBo5Ej7tCferpRhrap3t8d3mmFd/z/JBgcAtV482RjuVgjo/j9jsvk5++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyCv/K/OZl6aI56VUREgKDMGkLVWyyfayyD/bLRgeao=;
 b=APVICk/7+N3D4CIjtCyQD4I5m4F51IEdOO924dj1Wmg52Tg4oonjNE0sdlrnE9p9ucyYvI77ZMnORrASHolmsIDf843k0vZPPT74oQe7SWq35x9ARaHif/ZxryPMBEqPrupNXMq7csZ6ft95I2z0MYUtvAyBBxp4f6cZLFLzp4LpArIYJfQZcWZ8e6nKNv0xFvL6z3elJIoyy5yTgfQtM0d+bqGN0nDvy/Eq6KFoeDIF6fBOcBhJcSbrwX9bdFQ15mkxOTFpEuK5sfKxkM19ojt8ziHhjVjO7J1PzOq7NN8WEMR8fMdX/6kgp4FFmcbGQbcSHJVIzIWVs19K7iJc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyCv/K/OZl6aI56VUREgKDMGkLVWyyfayyD/bLRgeao=;
 b=K3QsyMBa/d1T6otZ470eovXYiHbhmeIc8WAtCddRKm483Bk/uIkmf2z0kEW80Jked04A5v0DkbvXwz9J4MNiwCmC1DkoDiPBgy57fZhBeO76CoZd8L60BQmvIoarAwvmX+BpjEfbAGWKATQU96V2Mm4EiULVbwqCXEl/t6V9sdqEIokRi4u9mKwnVYYjA2Ba7OctcKL643oQp/cImoFDC3Y4L/XwqdG8FNzHaFO/VRYlEXGhRo5pO8FZQtlj4Fm9ZdEjl43VpAwqP7mtTJBJjIcu0E03ZTnkGZ9Vih363o+8oPrXzkzZid2DG5KNOib9TDe9qv4sKh/0QWoHiPVv8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:26:47 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:26:47 +0000
Date: Mon, 19 Jan 2026 15:26:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 13/38] PCI: endpoint: pci-epf-vntb: Support BAR
 subrange mappings for MWs
Message-ID: <aW6TY7rVM6aTnfyO@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-14-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-14-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dde1446-f394-45c5-b838-08de5799059f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dLNEmC1TuZVs4s/lKPVBiQzSh7TEdT+65SG+g5Low3ikO6qpGVgQ/EVNNQI/?=
 =?us-ascii?Q?BgzOkoWRzUkGWsEXVkXTMyUMHuAkDbwpqgMtFDBGEpKS5i/2uxTb5gi5ruF/?=
 =?us-ascii?Q?zqVd32Q6jAoKcvLQHBs4fjwjLp0cBWMgqqc2nCIfblfPY38crguB+SL+nDzu?=
 =?us-ascii?Q?MUAzsgF7S/dXYUe/SmRC5WdUxJwg0YwVbplIRz8wYBgz4onynRFUUBAWb037?=
 =?us-ascii?Q?Ftl+ech5MDcdABvCOEWqsFynKu9nhJjP56XBR6mVxGQgiNWPodw1qSJwZvLb?=
 =?us-ascii?Q?kQ2F3ElKT0D3UfoxXZMOO2lsrxPzUbzSpYwn6iB0EZPGyB4UFxWCdP+ZU12g?=
 =?us-ascii?Q?Wck0RO2fQgElHtXznRu+iXnYX8wvojcHp8WUKmX7eDyyxX2MC8LmB7x2uEbv?=
 =?us-ascii?Q?livHhnBxeahqmxeBtWVQyggWfVKTrShwTQG3j82yWElUMrgOfSeoVuuG0Is9?=
 =?us-ascii?Q?FNIJ8w0o4SMlCywc5gStLMV6ytce6GG/yVdeex69QN+dHJXiGYd14/0oOtsF?=
 =?us-ascii?Q?2MVTgDTNhKlmOPl4SKblu0DsKY2oEJPxOYlfmX4X7Uw9Vjm7vCBvNoxRxScU?=
 =?us-ascii?Q?YZC3OGKnDUOfwsAeODWLaWs7qgpgtvwwEANrhqECSst22mq9zl6g3DOdHvju?=
 =?us-ascii?Q?0Mr6hWFOun78yttNPISIC/n8mBxaHCZowE7axj2T1Q+ol3GBas/izWuCduQq?=
 =?us-ascii?Q?2Ols2j0cjWHR9Jz7uja8IOB0+V+XtP/TsFzXpnxPk3FMazhDm/eM+MrqLnYe?=
 =?us-ascii?Q?pDQqpD6lRu2/yjxfd5LcrtxXoDp4VZPb3gy4Yb9ZpIcnzGS9Fb/BcfuPwyIm?=
 =?us-ascii?Q?dVo3LvkogH5Ogi6Rhgpii1CZu/p4MPJKwzNX4wJ9HK0/zI/WlSUOaln0V6tF?=
 =?us-ascii?Q?mJNeURJMBYH+GZ+nhl/ZhLs/y6oWaOIFmCTx8aeQsAnJKxxBrb1Xw40yABQ6?=
 =?us-ascii?Q?4gBaq65Vj7BQrxwKr03/bUTYycS3H0xzxlT5+Axwk9FoiTP4tx4sn+iU28Fm?=
 =?us-ascii?Q?UGRI45jTDOpgnjKfgUpSt8FMrPE0Ibd0kGAchCPeEphNdSciznxIy4p0vvEj?=
 =?us-ascii?Q?XBOYmaGczWJtMKSl48zmbL96VgWm8mmZTTP9SEiODkhbnzZnHcjeoSyaupTS?=
 =?us-ascii?Q?c+gekwZtxMhj9ZJTNDeNuseZHb9W3ddpZpLgJVCOqbtPWbTYjX5oDWPJTGkU?=
 =?us-ascii?Q?TtoGcchQOj6h5lOTwSgTWby6SC8LfT+WQBaPRXOqZZJjigMOmCHtY0UXtY9s?=
 =?us-ascii?Q?av0nywdUljArs6xeJ1sguAQ3+9himQw9LY+mm1MhFxbE5+oCA62D72eG0Qpb?=
 =?us-ascii?Q?+Iq45SN7VSxicRQdzd4XXIpAcFtrE3MVODfZGogTz8YQUYQAs4CaNTON8yWZ?=
 =?us-ascii?Q?2w8dHDoX+f7ABhFfC32SHRW6t3pnh00HlCssBCHuAnswSg4DPcDLNX220thm?=
 =?us-ascii?Q?DGEbGKu+50LCjK+nzfiHQQ/XcJ0VmUqxQBmbCyWBibO0pR6EfBwnMRKamoMh?=
 =?us-ascii?Q?/Dt6Ee/9jkHhZloggnQPW7yInZpcVNKXv/YA137tbaoatOVTa7XmgBfdOIMi?=
 =?us-ascii?Q?NjS6tBqO40u7Zq3ozKcldqeuuT3CUa9EEWzl4LQVwkgg6yTIqJnBVxaw1jqi?=
 =?us-ascii?Q?ZrtHZVYA5fMG3Q/geiY5FOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9T5Qy/DCqu13EcXSLYgptd+/WeXO9lUMWmia80R+Z2k8N57DO3+OhnNGi9n?=
 =?us-ascii?Q?c+Y9KG9lGi6YMFimz2+eZmvGBIsuxA/T+rCI/b/grLpoe4Zed5ki/u5ORcDG?=
 =?us-ascii?Q?d1QhRNBKNEYWH1CnOkCCBnjMQuJFsvO02S1mYUNhSB2ovo9R3COOp2fmzSIb?=
 =?us-ascii?Q?tent+no+zgUz27jUFWj+djWV5clyw43X0B5EmBepGI2+aSoWR/LoUpep8m8X?=
 =?us-ascii?Q?4zOoTGSJBR17btME59slCL+HpA6lWA/iCP54mp/nOwrpO6PpiX+gcFhzkbyD?=
 =?us-ascii?Q?O2V25LMvuDksrjqwK5UQXWi03a5ik9BP0yzha9VVgB4dm8Po5OXLGCxWzC1s?=
 =?us-ascii?Q?BFztgAzOc9fk2IWQBE6expuxdEgh8eB3YKDm93OBfkkmvS4ACFOdYGoG6eDY?=
 =?us-ascii?Q?Ly9J3eF/fMq+dbmxkr00+IjF2NBmhclfQFpDmN575lTMZ61f6xMRyFqZDk7f?=
 =?us-ascii?Q?DA8gt2UFrxQa+fn4bYs1NkuBji25zoIB/2RQibv1RYRDUWAf+s4OXPVeWKze?=
 =?us-ascii?Q?UzbxbusnJqMChfTQ2uikffc93Vfx8qUXxkgmf546H0Vk0ZM+WR6jWz7icSwp?=
 =?us-ascii?Q?1+n3keVhv32hZfmpsaCjfhp0HHo4OX8CF7P2V8OdEUTxbQobp6+ZVDP4qLyz?=
 =?us-ascii?Q?31Qw+NyNP3KpM+4mqVlOpIk+z4GjYPjCX3czssrGSOf7gOuNNZY0S6Yj2eJU?=
 =?us-ascii?Q?hl5vx2yVg7aVQOhLcCyCVcjoFsgYLkgoDgltA7bFfIFFc7YwCM89K5tvLW8i?=
 =?us-ascii?Q?mxKmXgdwrLPfRVk0haOWKArcKIBIg5ni+eEqport7Y/Itu5t+m3a9l5ABQmw?=
 =?us-ascii?Q?OfLs1TCbv4vXAXXWGGkCD5gYvVkGpmbipFPvY9hdHQgw6KTge0tFqC7H0ASN?=
 =?us-ascii?Q?4xxr0iWz8U7Dn2UYcXEEf+AICv1Tj9YibSMJD2PPHdPMFR/WXirlUyBL1Inr?=
 =?us-ascii?Q?FmrdCFVRLIrsgVBoaFnmkEj7/5ryBOHsBO2ncA0n1wUrHiH7xQ6He7wooVhj?=
 =?us-ascii?Q?NeV/wxAhSLM5C8vc6kN+BB/1P3AZg2MPNc/k9Lc8UQTzgfRBK0lLe2hTyjmh?=
 =?us-ascii?Q?pwe2c3guynyhSEhSX/O1XHexZfoYGPirCR5iRBUqbZ3tfpeGXaPKo8/zQeGM?=
 =?us-ascii?Q?iMHgSSAuZZsTAedeLBw8QmecrnfC+Eu40NN43HYjnzLxqdWGLjpMnDgm3NeL?=
 =?us-ascii?Q?Qm4qH7esiFd26DYlN1K+XNUQd/gRCzkPwqd6IfrePnHqIfrt+ArbUJgi/sjW?=
 =?us-ascii?Q?dlWuS/kTqKBsfEpoMLfYq5xhqBgZuaE9NPwkQJoBax7C/9VLHWjwo0DU6jdK?=
 =?us-ascii?Q?3ivX2KUcPMw6l0h3lbyBn6insRPuAlchOQ1b2/5usgdaOxQCki9Oqw9IF5Qd?=
 =?us-ascii?Q?ViK8oPuP0Eoop03Xr9iG/HSbp+C81bUMmd9+IPlZPMBB8dfnr6hFwCpfxuqz?=
 =?us-ascii?Q?FpOzSFT1bYHFOnz+ySKrXPcOSQeeir3rzj7tREg7qDD2SR8YREJcL6ftm2+s?=
 =?us-ascii?Q?zM84kseCmsstIyiT6ke6yvfEXI9qTQpJ3ZHxFylxpYi+PEv8bHJtp0wLVUDj?=
 =?us-ascii?Q?9+2QUoSU5mAsD5FatkRRPiQYaSm0Xi8b6dCCJ1PauRwB0u+DMpUUTkWyVkC3?=
 =?us-ascii?Q?mQReUhagGVgfdqzhcwSq7/60FkoadFjoFzH4WmmUqjA4C/WXYQgVYK1m9URs?=
 =?us-ascii?Q?harD5S3C6XjeSn7FcWMAeEzZRGlzWnZA1e4/FhfEGCRu7NHh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dde1446-f394-45c5-b838-08de5799059f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:26:46.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtugJMd/ruHIbFW9l0yrnjZ5MtglrFScNpVmRGHbNYY88HmcCpY+7LCrJARk9CHsvD3F5MnrMkJe32bF1BVjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175

On Sun, Jan 18, 2026 at 10:54:15PM +0900, Koichiro Den wrote:
> pci-epf-vntb can pack multiple memory windows into a single BAR using
> mwN_offset. With the NTB core gaining support for programming multiple
> translation ranges for a window, the EPF needs to provide the per-BAR
> subrange layout to the endpoint controller (EPC).
>
> Implement .mw_set_trans_ranges() for pci-epf-vntb. Track subranges for
> each BAR and pass them to pci_epc_set_bar() so EPC drivers can select an
> appropriate inbound mapping mode (e.g. Address Match mode on DesignWare
> controllers) when subrange mappings are required.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 183 +++++++++++++++++-
>  1 file changed, 175 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 39e784e21236..98128c2c5079 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -42,6 +42,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/sort.h>
>
>  #include <linux/pci-ep-msi.h>
>  #include <linux/pci-epc.h>
> @@ -144,6 +145,10 @@ struct epf_ntb {
>
>  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>
> +	/* Cache for subrange mapping */
> +	struct ntb_mw_subrange *mw_subrange[MAX_MW];
> +	unsigned int num_subrange[MAX_MW];
> +
>  	struct epf_ntb_ctrl *reg;
>
>  	u32 *epf_db;
> @@ -736,6 +741,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
>  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
>  				PCI_BASE_ADDRESS_MEM_TYPE_32;
> +		ntb->epf->bar[barno].num_submap = 0;
>
>  		ret = pci_epc_set_bar(ntb->epf->epc,
>  				      ntb->epf->func_no,
> @@ -1405,28 +1411,188 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
>  	return 0;
>  }
>
> -static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> -		dma_addr_t addr, resource_size_t size)
> +struct vntb_mw_order {
> +	u64 off;
> +	unsigned int mw;
> +};
> +
> +static int vntb_cmp_mw_order(const void *a, const void *b)
> +{
> +	const struct vntb_mw_order *ma = a;
> +	const struct vntb_mw_order *mb = b;
> +
> +	if (ma->off < mb->off)
> +		return -1;
> +	if (ma->off > mb->off)
> +		return 1;
> +	return 0;
> +}
> +
> +static int vntb_epf_mw_set_trans_ranges(struct ntb_dev *ndev, int pidx, int idx,
> +					unsigned int num_ranges,
> +					const struct ntb_mw_subrange *ranges)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	struct pci_epf_bar_submap *submap;
> +	struct vntb_mw_order mws[MAX_MW];
>  	struct pci_epf_bar *epf_bar;
> +	struct ntb_mw_subrange *r;
>  	enum pci_barno barno;
> +	struct device *dev, *epf_dev;
> +	unsigned int total_ranges = 0;
> +	unsigned int mw_cnt = 0;
> +	unsigned int cur = 0;
> +	u64 expected_off = 0;
> +	unsigned int i, j;
>  	int ret;
> +
> +	dev = &ntb->ntb->dev;
> +	epf_dev = &ntb->epf->dev;
> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	epf_bar = &ntb->epf->bar[barno];
> +	epf_bar->barno = barno;
> +
> +	r = devm_kmemdup(epf_dev, ranges, num_ranges * sizeof(*ranges), GFP_KERNEL);

size_mul(sizeof(*ranges), num_ranges)

> +	if (!r)
> +		return -ENOMEM;
> +
> +	if (ntb->mw_subrange[idx])
> +		devm_kfree(epf_dev, ntb->mw_subrange[idx]);
> +
> +	ntb->mw_subrange[idx] = r;
> +	ntb->num_subrange[idx] = num_ranges;
> +
> +	/* Defer pci_epc_set_bar() until all MWs in this BAR have range info. */
> +	for (i = 0; i < MAX_MW; i++) {
> +		enum pci_barno bar = ntb->epf_ntb_bar[BAR_MW1 + i];
> +
> +		if (bar != barno)
> +			continue;
> +		if (!ntb->num_subrange[i])
> +			return 0;
> +
> +		mws[mw_cnt].mw = i;
> +		mws[mw_cnt].off = ntb->mws_offset[i];
> +		mw_cnt++;
> +	}
> +
> +	sort(mws, mw_cnt, sizeof(mws[0]), vntb_cmp_mw_order, NULL);

Can we require mws_offset is ordered? So needn't sort here.

> +
> +	/* BAR submap must cover the whole BAR with no holes. */
> +	for (i = 0; i < mw_cnt; i++) {
> +		unsigned int mw = mws[i].mw;
> +		u64 sum = 0;
> +
> +		if (mws[i].off != expected_off) {

can we all use size instead 'off' to keep align with submap?

Frank
> +			dev_err(dev,
> +				"BAR%d: hole/overlap at %#llx (MW%d@%#llx)\n",
> +				barno, expected_off, mw + 1, mws[i].off);
> +			return -EINVAL;
> +		}
> +
> +		total_ranges += ntb->num_subrange[mw];
> +		for (j = 0; j < ntb->num_subrange[mw]; j++)
> +			sum += ntb->mw_subrange[mw][j].size;
> +
> +		if (sum != ntb->mws_size[mw]) {
> +			dev_err(dev,
> +				"MW%d: ranges size %#llx != window size %#llx\n",
> +				mw + 1, sum, ntb->mws_size[mw]);
> +			return -EINVAL;
> +		}
> +		expected_off += ntb->mws_size[mw];
> +	}
> +
> +	submap = devm_krealloc_array(epf_dev, epf_bar->submap, total_ranges,
> +				     sizeof(*submap), GFP_KERNEL);
> +	if (!submap)
> +		return -ENOMEM;
> +
> +	epf_bar->submap = submap;
> +	epf_bar->num_submap = total_ranges;
> +	dev_dbg(dev, "Requesting BAR%d layout (#. of subranges is %u):\n",
> +		barno, total_ranges);
> +
> +	for (i = 0; i < mw_cnt; i++) {
> +		unsigned int mw = mws[i].mw;
> +
> +		dev_dbg(dev, "- MW%d\n", 1 + mw);
> +		for (j = 0; j < ntb->num_subrange[mw]; j++) {
> +			dev_dbg(dev, "  - addr/size = %#llx/%#llx\n",
> +				ntb->mw_subrange[mw][j].addr,
> +				ntb->mw_subrange[mw][j].size);
> +			submap[cur].phys_addr = ntb->mw_subrange[mw][j].addr;
> +			submap[cur].size = ntb->mw_subrange[mw][j].size;
> +			cur++;
> +		}
> +	}
> +
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, epf_bar);
> +	if (ret)
> +		dev_err(dev, "BAR%d: failed to program mappings for MW%d: %d\n",
> +			barno, idx + 1, ret);
> +
> +	return ret;
> +}
> +
> +static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> +				 dma_addr_t addr, resource_size_t size)
> +{
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	struct pci_epf_bar *epf_bar;
> +	resource_size_t bar_size;
> +	enum pci_barno barno;
>  	struct device *dev;
> +	unsigned int i;
> +	int ret;
>
>  	dev = &ntb->ntb->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
> -	epf_bar->size = size;
>
> -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> -	if (ret) {
> -		dev_err(dev, "failure set mw trans\n");
> -		return ret;
> +	bar_size = epf_bar->size;
> +	if (!bar_size || !size)
> +		return -EINVAL;
> +
> +	if (size != ntb->mws_size[idx])
> +		return -EINVAL;
> +
> +	/*
> +	 * Even if the caller intends to map the entire MW, the MW might
> +	 * actually be just a part of the BAR. In that case, redirect the
> +	 * handling to vntb_epf_mw_set_trans_ranges().
> +	 */
> +	if (size < bar_size) {
> +		struct ntb_mw_subrange r = {
> +			.addr = addr,
> +			.size = size,
> +		};
> +		return vntb_epf_mw_set_trans_ranges(ndev, pidx, idx, 1, &r);
>  	}
> -	return 0;
> +
> +	/* Drop any stale cache for the BAR. */
> +	for (i = 0; i < MAX_MW; i++) {
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] != barno)
> +			continue;
> +		devm_kfree(&ntb->epf->dev, ntb->mw_subrange[i]);
> +		ntb->mw_subrange[i] = NULL;
> +		ntb->num_subrange[i] = 0;
> +	}
> +
> +	/* Not use subrange mapping. If it's used in the past, clear it off. */
> +	devm_kfree(&ntb->epf->dev, epf_bar->submap);
> +	epf_bar->submap = NULL;
> +	epf_bar->num_submap = 0;
> +
> +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, epf_bar);
> +	if (ret)
> +		dev_err(dev, "failure set mw trans\n");
> +
> +	return ret;
>  }
>
>  static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
> @@ -1590,6 +1756,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.db_vector_mask		= vntb_epf_db_vector_mask,
>  	.db_set_mask		= vntb_epf_db_set_mask,
>  	.mw_set_trans		= vntb_epf_mw_set_trans,
> +	.mw_set_trans_ranges	= vntb_epf_mw_set_trans_ranges,
>  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
>  	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
>  	.link_enable		= vntb_epf_link_enable,
> --
> 2.51.0
>

