Return-Path: <linux-kselftest+bounces-15677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21916957332
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 20:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990621F22CCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7218950C;
	Mon, 19 Aug 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mxI6rLJk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD0184535;
	Mon, 19 Aug 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092110; cv=fail; b=PEUaAKqoUfVpdmg5W9WEHz8YUKF+G6uL0yshl4+2liJFAGlqvuIPZeEYrAHcGGHveyyRxgAhF06wLL3n2YI7GNcOolUoq1OcT/7mxPAyc7cJrhtjYHJ2LP5GArkHIv9rr8k8AhskkwICn5jbo0oCMLYUJTCu15T52B7OjxOgdwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092110; c=relaxed/simple;
	bh=qJuSWOCyvF9L16WCsUed/n3FO1wO24JLGcPuv+geB9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoJEAA1eKF2QZL9B38/8W7mfzOw3WKdH8TYyYrr+vnRl9yZEpMtLE1zADkk6D6hlD6nEoE728hfIxH27gqbIX8fMrQKXERZRhqP+sdmPewCNbU2f3SeShO5SO18Czcm6TWmW+YPoD5JVLBxtw965Fin5vz2/F/jqFH0AFKPjQTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mxI6rLJk; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glt9UvD/0GaUJkVhSS8MemihBFjyc1pXEr3BDvUDxDTgB4+5Ui5B+XDqO6XSxJPM/U96klrvNW7swKHO78oG8bUEjeN9HjGfdXZh9n7LN3Cn8rGC/fYsFhaQWgr+Lk4RlkAfc1Ajoae4nkx1jf3Av8xqYdYWirYm1ItFYgVFDJSIN+yjg46oTLSv7pBOSO+vlIgHjiBE02XsfmWTqq+Eh9a+F38dp9f++XE0/6FxNXno3Hrt38+oaUyooN3piPa0KrqEzsiqYiC1sk3jPoSlxxrpMJF9exbKuUpYElUaG7gb0YtAud+eAc7lAHdrzQiORvtEPvkfVB4K6IJNbosLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyYCse/RPVbGaHFM2PDEZ/drMYu1D4LpjywatprS5ag=;
 b=NnthgmCpDe5FxAI3PlilzTMXc/fivE8B1/Dk5mKnccM/Wddhdln61JIPmd6bFUeyPNAk+6BbupVvmOQaOZsZUypW+Z91y98BNNh1lBGJkr/hkohf4qD/2nkg52n9QOQ8423t2Xuq2wlMOr0AhJSShSIaSpfMl4R0PkljLC7RjQUV2+viNv9RiBoYArtWljbXjz0jgEJI4hqwb8yCB1+HKS4Pp6kV5S32ka7981D+A+5i/yNRiLL4RvdnOUzHs0oRRE33X2jD90yx1brDHvLtAt6iyKn23WXovyfElwXb93XHEoUZ7lGmqWymLGaWIbPfHjckbKOwDUjhPuSCepCKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyYCse/RPVbGaHFM2PDEZ/drMYu1D4LpjywatprS5ag=;
 b=mxI6rLJkF0ndzMUT+kb3m4cPjD5dBA/Zc2bSg3Vb+nFu4bFwq7EgEzJrgv7MAwQMpGv8Ciwnrf9lAbeAZxcYHA47IcCSPkwfVVyyuET7OE0ZGvlXAXsiDEmROpBybZ5pzgqBiLPXJw3790J+LYUIgIr+TAj9Xm+aQBqkqdujgfzrd3JCExHRt8FpqvTCB5c1cQjzQi4F60Ic6YSnc5UFl0da80aaekk4mmb03OpUPTVYzlM2ciG1w+76mAC9tv5CVwag+97p0cvVzX2Bf/tsEKr4ujXChTUuVnxf5XQrBCna+tLzAddAoH+7/ZS/1+m3gNSJBDp/QVnJ/kZwMUHa1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:28:26 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:28:26 +0000
Date: Mon, 19 Aug 2024 15:28:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <20240819182811.GR2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
 <20240815233635.GV2032816@nvidia.com>
 <Zr6iPtiZ/afonJ5k@Asurada-Nvidia>
 <20240819173615.GN2032816@nvidia.com>
 <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsOMu3OnMn49cDXf@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR0102CA0052.prod.exchangelabs.com
 (2603:10b6:208:25::29) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 063f9c19-7b9c-4f63-ac5d-08dcc07cb712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V+NFBa+xAxaPDJtRAuh8x9JoJrS4iBUKYT46eVnSv8SPlS9SM/vdMirICMmc?=
 =?us-ascii?Q?k4XTgf1FGPQtDG9QMNVUzb9m/AAgIQKMoKbS0VNMqhRsNsPJFNRViTdMukik?=
 =?us-ascii?Q?BYafMTFCgAbBwQNy8Xq7mX02itdEVtDyWqiW8D/aJrFHGmKCpRHMO2JKRLP6?=
 =?us-ascii?Q?YOFDGLn+XiSMxrfGNnKj5SMQ8YKUxardq9yZKYVkagYDmMYsjwQjGnaiIPh2?=
 =?us-ascii?Q?C6OWyhKkdR7Wg++3u1q29zK7HJc25bDpCQCrI3WwpaDqSvM7xD287sLr+nBJ?=
 =?us-ascii?Q?oOPtNPBl98DPKz6L6eZSioRaGqqzYqjsOR+CVS/mwNiKQH1AeMr6+PosEA2r?=
 =?us-ascii?Q?R6DwZZLTs6ZPdpErFRfAuWlDpCMI3UMDmvkBHWosYayLLCS+hM3NNQYARE6l?=
 =?us-ascii?Q?16mqQM0N0tCWWOa16KTA8su4BMG/+ROCdmcA5dB5zdF55kNpIL5xUe0KSTBs?=
 =?us-ascii?Q?XFaKQ+CxOalpeYWZh/61iDRT7gRzMP6qbAAoVRl7+5ugHLWklOalIcWVW3so?=
 =?us-ascii?Q?oXGr5uYT5tKo6zdhKtaSv/iOJjmUvdwMK63NiPOlLXlSXfo2Rjq0GknXAmpF?=
 =?us-ascii?Q?ZoA6uD+GT9lz1iOjbeQkxka+7PVH8yetkLwWq7RFB8jooSaM/WvbupxpkIBJ?=
 =?us-ascii?Q?73mX1aSdZwUEbGFpdlP5ocCfjg6RVrHRTLqBpZiIBX0/V2MVcnDN8UmTjxQo?=
 =?us-ascii?Q?6QN+IpZ27bXKWkIUOWEl94FV6eMjzzZ6S1ZzbvEdKFuEZN1ZtA8JkL/NA4Zh?=
 =?us-ascii?Q?4P9MrwUkrRgjzvxIgscw6y+b775GigNJe7e6dmtwbKCj1AKEs9zFp6cpIyl8?=
 =?us-ascii?Q?CaRKh+vUvRsK2ag9Mz3Z9ZjYO8aey4+bYS3bGk/RZdvNEasQI7nKNhWICSgf?=
 =?us-ascii?Q?zINxMYVvRVg4B4TlY6NQPcy3ZmTG0mkSRNMRz5mQtkDFCgE6C68Dy2zOQ573?=
 =?us-ascii?Q?pGTOCFBdyTnSANnghjfzrXMPpI/gYeDqib2Anch92Qe6+TrG1SmMf30I3Rpv?=
 =?us-ascii?Q?4a3PurvUMb8vP+Nd78gkB390+XMeiPMZ+elkQaYY6mg4Y8PDKvPdsY8YZgQn?=
 =?us-ascii?Q?OWnlUNQEmuXqdFyG7dWyDAnWdoc3E7ftRn+Xrkkqm3/bOSGe6T2njew/Qcyr?=
 =?us-ascii?Q?mLu+/BFSj71xn8qd87xHpPPK9XlI5Qchq3mYiUF9nTVKN9cLYZlJpmCokbpz?=
 =?us-ascii?Q?ZgQpRnkDMPRvXZr/pbLfXYroWg0Si4xmc+xvfqbFbVA52PtDVBhIYnA51zdN?=
 =?us-ascii?Q?jp3czv766lxBHvoiAWYLoJfhIC/BpikjvhCKfzgzfrkJkSh1LWFmT6W+ll7m?=
 =?us-ascii?Q?2ZWIqUbCPmMSnl6b1i0UG3d3phyo6XCaraHTq0Msy1MyTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pBoLCV4UjEbQVCTn08f44BvRL6ZSDoiJM8TkVS85kkIiW4CvwAdqX8JXJTB6?=
 =?us-ascii?Q?MBt9jrvpgahFiQYt1PBN18frjrWFc9bfAvlkis4S9JUVCm/aycNW7zz7kcjY?=
 =?us-ascii?Q?uivbx6ZS1/Z9y+TFeeJA29fQLavwVHIy6KzIWpb36YekW4/LPoC+GTpqM2eA?=
 =?us-ascii?Q?DW9s+sFoZhSk812IUfO+efRiOH5M6F2IEJVAQhBM+dacadOJWcy00nH4F4TO?=
 =?us-ascii?Q?6788bOep//ck0ktE9Kw9QIdgOuYQMeWcFn1+b3cBHM8weRve0Pi+PvzYY4nc?=
 =?us-ascii?Q?2DQ/ZehzCZxXA9P7aTm+rYMUns1LTqBQkDFuguCcdXjXUekwgzJx5V7vN+qk?=
 =?us-ascii?Q?7EeitiH/pvsMfodiFBtG5vr9ifEQZKUOa2Q1UAn+yyqexa4+7yLmV2Y4xEHk?=
 =?us-ascii?Q?rptPo9wdee+TfZRJ2D9iUsswsNEVsw88t+nP8H5TITkEmjFzYHJxmaJrl0Oe?=
 =?us-ascii?Q?/e41HZ7YsurfuuMI5HsbxTVsaxPj+Q7/7GOevT+Wx2SGGNtvAk9VdjXAPhil?=
 =?us-ascii?Q?OEOU9WfhhyrTcGHVs5nBt2d/cbo0DW0X/iL9KC/uyqYNfe++B2QElRTrvL53?=
 =?us-ascii?Q?KNuVEoBkY1/8v1j9raHQT+sUefmsRksmSqvqiZrsBoXr7Z2FvxLy2Bs6RMHi?=
 =?us-ascii?Q?PbJmNihK9cQ9ySZeYSvpCJzIpcr1TDJYNwiBX9f9ganMl5efR/Lg0Cncr1mp?=
 =?us-ascii?Q?S1vtplH1Wfk4j7VAi/gPqjiotVEdpsQAuQNphcIjRiyQCnPC5kWd6PS1+Vil?=
 =?us-ascii?Q?kpgwVFWCaCjygnsajJ1pk8k3PhlCV0AQyopO88MkVwrAcXxklHLRcpJiP/9l?=
 =?us-ascii?Q?gNZIlI0Mmevwc57/70NyqSyHjkUgUp2Wh5IRrx/gHmD/ewP3RG0el0KTn8X2?=
 =?us-ascii?Q?GbEgbGrfUJTR5LZu/Uo5oPz9M8bYAY2ZfPFvjdc/4D4f4CFXKsr42JuDBOP0?=
 =?us-ascii?Q?myY8RPihQWvYyiQMaeoC7PNi3kBOPDxlxVt2HvR6g4qR/1Er5IaOcfIrCZH8?=
 =?us-ascii?Q?3AtNU1KYl/wl+Oz9y5i5nf1XUh6mo3bvdTZICI++v9VDL+iL8JfFOowWBWp/?=
 =?us-ascii?Q?flj/DWV3+O9KDWSh7d7HlbyypxByzxw/fxADRBjyB+w1ouG9VZ2MHM+B6GiI?=
 =?us-ascii?Q?6eNPiIzwP5FwfNyiI+iWB70MJN5sGlXfXgOanp533SJB69EDJeL0969bXXjq?=
 =?us-ascii?Q?P1GNua2hBUiDteJLxH/iSIrRsFlbP8I5++z73u/IENF1AiYlO6mzXbkK6ZQx?=
 =?us-ascii?Q?mN0Bxfd6TRAo8H4AnjqT17Fyv4SIVCYpkfGaHq79rrooqNBKd3CGwcZJbsgz?=
 =?us-ascii?Q?YgAIUO7x1RmPbVJ1IIr3msTgJqRCYej/ZIEsmd1OTvTyFRFOu0GHTKmPKrpn?=
 =?us-ascii?Q?Iw8+cQ14QiKicpR6Y6fs61s4WXQQS7dac9ib55XvPAieFQR2SjoFDg/u2n9q?=
 =?us-ascii?Q?/r630L/27Ocve35iBoNP00vOPLi8exlLCf61uAah2eo+t5Da6n/sgyQFtf55?=
 =?us-ascii?Q?7VNh1Sh8rk/RyK1pCepOd3za/sSflGJIM6bjnT8ZZ6olyTwCjO8arQnTTOyq?=
 =?us-ascii?Q?qmXvZTKI7Y5AqONHhIJ0wpn9qbN1nRtBgTpjygGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063f9c19-7b9c-4f63-ac5d-08dcc07cb712
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:28:26.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6wzU6eWS7Wp8A5TFuXct/re87tkthaS2A/fK/YGcxjkGiO0F9jXpITp2gAkbHc1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

On Mon, Aug 19, 2024 at 11:19:39AM -0700, Nicolin Chen wrote:

> > But nesting enablment with out viommu is alot less useful than I had
> > thought :(
> 
> Actually, without viommu, the hwpt cache invalidate alone could
> still support non-SVA case?

That is what I thought, but doesn't the guest still have to invalidate
the CD table entry # 0?

> Though we still have the blocker at the msi mapping... It still
> requires a solution, even for viommu series.

Yes, small steps. The point of this step was to get the nested paging
only (without msi, pri, etc, etc)

Jason

