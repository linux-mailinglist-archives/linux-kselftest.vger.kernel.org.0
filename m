Return-Path: <linux-kselftest+bounces-36553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A6AF931D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330631694E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153D2D8DC8;
	Fri,  4 Jul 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="noYnFLzx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626024BBEB;
	Fri,  4 Jul 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633420; cv=fail; b=EXTThpZKrGgQ53FkayT7JfcqNHGW5pV6AbeGuKrm8xRrOteKN2Vl3xowr/7l6j7wL9Oz/HbIQTiFgOluVLfT5X7TdJyoTshR3eY789n0bgh4D4N3hXam75+zsq4lvu0Via83fTxCY46KZABGpIN331w7LcxlwMXVjLnk3TjllDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633420; c=relaxed/simple;
	bh=emWf0HrLoNDy5pHygqkRfU4ctgL/ECATggfuiuD+4EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SosSBQbe+pB7Fl6TN5ByGDGN/aEEADzUkS8nslsv61FrPwgXAJt/fWkVbJsz4MMHplUqgdzGwknqvo+UXGexUyDtl/q/EVM5vFiZT56q0KjLF/9UeqSfdTvDuNnR+ZAtkKdZBDjXH33QbbCMxxaWkkVAHysEjj8dmT4sAkYNgAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=noYnFLzx; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgjqCZdhWXLKo+xz2soXraDhYWhR8n8FIOxxIP2YooH4C6/tUsF26s3UZ5Aei5ipDIH6KzxENVub5NN7ajTeho7YOGYPRLi40QsUroD3Zj8S+6JKpptzKfCBeeZzDd66scCNUwYf5AYysFrjIhwdq9npGys5aCAMH8DkV3SzUQzvif7HJGXMWa4YObp0KuC5bc/RtcujmLQt5EIRP+Chob869BxJu/c9B4MtE93qN/aMYJEuSVNec3l/t2QMmabC9sFtEHOT3AA/BhqcUqblemZbsIXa7bX3XfT2xDITnSZcobmgOpk0jiOF12wzMEJiNuRTISwegS3KnBsVY3gjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5BsbG46p1zUCrqduq/LutwtwMWaGeqoE8ruCplZ6T8=;
 b=LxjpxFr97xQG/H57HS1rnG989fkxPaq1GDmK/lXydalssqajxmyheBNfV2KRLf2YCnl86VNkMFL075OWox34CKYo88qSPaso5nVhLzdt9KWKb1FxjBsM/ysa4t2TCKPLNVYJUsMUlEvqg+R2c75IaEGkFkqcpYK28x9BJXYKHU7836dvaAnASr/QCHbiVFb8cciL9Vvl9ubUQxhjSw7tYLfwoScNfJw4YQ8HlvA4Fkfz/etHFKiE3BMHc6Zg/j5uAlg27KzV0KhuwQywQ/sBivQ1XOhlOD1KVWufnUXzivVohh4iRczpas+SU8bcDqndN37ouSYAhacsUNeNsxMesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5BsbG46p1zUCrqduq/LutwtwMWaGeqoE8ruCplZ6T8=;
 b=noYnFLzx1J1wEBGTmXcdqXESBVYZLJj5x5g797foBDCBEXbKThfusHF6SucBUggtr/9QHXWwg05YRfndoOA6R5Og8NeZE+Ly31AkRWcwpG7E0reUcl1yJilKRhILdeX1+Z5N3UF5g5t/bsRzFjQ5eWnvRcTmhdFNcb9vP2a3TNvfoqhwBzun9brXOJqhXETxW3OyRA5acRqbH7CzZIhgVBNbjwLY1Y+MgFpUHc8QnmPZt6rPszN+uRLElG6hCKCXBHiRKZJqaMJXv6APrre9OEaSNp0lVKBCD9XT11+mRFc9s+UoFZz/VU45dvUwTx7gy6UB27ftOUp43VaSvmr+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Fri, 4 Jul
 2025 12:50:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 12:50:14 +0000
Date: Fri, 4 Jul 2025 09:50:12 -0300
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
Message-ID: <20250704125012.GK1209783@nvidia.com>
References: <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
 <20250702180541.GD1139770@nvidia.com>
 <aGaXqwzfLwsgCH6n@google.com>
 <20250703175532.GF1209783@nvidia.com>
 <aGbQipeSn0aZnwZU@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGbQipeSn0aZnwZU@google.com>
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0c21f6-115e-4892-04c6-08ddbaf951e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?frM0v4p5HBgCyz39E2xVXzLzzD4W0nq1z1dwxe2Y1CMNoJjszZ/21HIO0ZNK?=
 =?us-ascii?Q?sVOMvaJryXJeEBgLSn+FZrBdn9dW3AmrZ5AUcmUc54Rm5Qe7q7kZGmyRCATb?=
 =?us-ascii?Q?HQhvnZ9boLjfwTMjD/LaA+wu41gkGBQ9+ntooyQiIKClnn291P0AdVIHbL7h?=
 =?us-ascii?Q?iZTJPq4FpBNiO08jT93L1M2lf9c6hrrF24v6f/mLFQZJOfjnMYghhZt1XzN6?=
 =?us-ascii?Q?iVP1ZOeJum5HBeomXQR5o9XCh4idGhxAcMqs2roUEqd/s3U6mBSB5a29c0Xd?=
 =?us-ascii?Q?DMLPjAkub6JhzWh4G60c8T8kiA3Qay2f7c4rTgA4SKBtCkhWcnX402lYo0dx?=
 =?us-ascii?Q?kyz1KU5ewG+mqf9PDZhdUoaft/sK3KOl2X/0iBx6rCqTROmnKyCkGs7C7hKi?=
 =?us-ascii?Q?RyPEEmkJTJbjx8ORSMv2XOtGdUxGcmfOOsb381l7gh8+bZvHFMTRbReR9Cny?=
 =?us-ascii?Q?WuuW6CUs3ZVIfW+5c3+D86s/VzMVHzcg/sZJsuOs+NFYL5muP6Yqqv+2u6ze?=
 =?us-ascii?Q?VOYj/qSG7YYvOr0xJ44HeixeouprR7maMvoxGNPg0yDVO98sZD5mA2vfsMp9?=
 =?us-ascii?Q?nDFkdm6Z7OE3KD8/EAShhTYDsDNWYFxnWDnuKaf5Q6KQNEtYUTrbW27Xftu9?=
 =?us-ascii?Q?nJbU+cDz9gG0kWsSt0sMPwkW+1HZcAbEsS9+iDFj2CfZ5uXjycSG/1qBspbJ?=
 =?us-ascii?Q?e+nROwxszkx/721ufOpKKx0+OnAfUc13x1LRQkyS3W2zMxLQdY4P0goajAWD?=
 =?us-ascii?Q?uPj5aHbDDlRU+aiBKDjzFYL1g3uphLEbxxbhRF7XjnsxUPT3ec4fpMKTz2uw?=
 =?us-ascii?Q?UMOR7c9GQ2rvnWaHt/Cl4dAznl9vRqeenrd22NUS3c+XFrRC3VtB9AMaN+Cv?=
 =?us-ascii?Q?5l58Icfo36KW9T5YQ7zzfShVGogjYtHSyO1r8Z4SKBWWTnO+N0XqviHezgQD?=
 =?us-ascii?Q?Cc4oteVp2hQavYOTy4H3q4obL+t4Xd+hskH6OeiRAvKI22/t5sYtYv6ePaqT?=
 =?us-ascii?Q?1kTIU7fZoWiQmHE+rspsVCGIq9m6r2zoIcOWUUEwb9d/XZW2wq+lFQhsJjCd?=
 =?us-ascii?Q?jpxC/oMQm+GGUb7pdZuz4AW11vWUnai4rI+Nut2O2qMcg1z24oIBJYBzA5WG?=
 =?us-ascii?Q?F3zr4KrBFRENueeKWgQbA72Ry+/FnccfqTe0LYXOp1x92+hDYusGyFEFIdX6?=
 =?us-ascii?Q?L9544aU8irifgn4J8w6PJCt4R6Sl88Iy43mZN9mrqsMpQw9g3dV29tbxyPRZ?=
 =?us-ascii?Q?SpHoFYbxSPIbskipPKGipUlYTiMcOgfKwJKkknCxXV0GRizbEk0G4oVWvKWk?=
 =?us-ascii?Q?EWixJzQeHzt9IZhiJry/sMitQo9B9BJnqYFxuOXQhxW5Ur8yHWIY3S9xpsS2?=
 =?us-ascii?Q?xSdtKigCvTJ5kl4gA69ci8tAxJChLqtO8Hg+0j25XNSbAArcdudpnDBCvToV?=
 =?us-ascii?Q?abQODt3d78U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3QidcJ4fI40mIEgiQSoRC8t8GpPq1iLxJeNWTqeXpxoVwQjevQWnvhLO2Sw?=
 =?us-ascii?Q?MzGaFed5ohOVz1RoL5jRLqsPyGg7diA0AkP6wbTIt4OXXYVAnzMHHZK9/GCi?=
 =?us-ascii?Q?QtZRI0ZXj15fTe3yGcOskAo5JvKsUMLNKuNobcyS6Z2IG9xfOlu+uI3QsOb+?=
 =?us-ascii?Q?+1p/pefz/n/HNP1w0AsSVjN8jAW7QdJtSsv6LXj8PCtiSvLstKdlwTcpk/1I?=
 =?us-ascii?Q?S6GeeanbSvPE7oTe4R3vvQIxTFP6y1Ao1YowspmHqxEnABdKpFUg9cPtOmEm?=
 =?us-ascii?Q?r+0Yj6/i6ZxEF4yjUrplAUnwrlosiMTd9aKfgU9VI4NDW9srla3PaDzN0beP?=
 =?us-ascii?Q?ycY96uPO07iGINR/hI0zCzfqrDjDeEbhcIBsaN06W81GgC+q3PoZxx09XRZx?=
 =?us-ascii?Q?DwCxNhWYw45bqTqrYo4CI0feHLw/tgg5pMQdAe1ZR9CUwvGMHI4vw/78QwbO?=
 =?us-ascii?Q?PEjelDLevQWZQ1a65R3IEAHXW3HJ3eYtl+9u3QQLdG0Z9VyM3k+mFEfWp+zU?=
 =?us-ascii?Q?ohMIBV/Kt035VCwsuWTKNX243Dnsl0NvvQAmVl6omLMhL08XwQ3MsmfBrr8C?=
 =?us-ascii?Q?8qTNQ8qG0d4z+w+iAtKBYvc3KygFKxVUsjHFFdKeyav7ri77+xsUhhr7pSlD?=
 =?us-ascii?Q?Ckf6FHRbHh0uQT1RVrKefyNYK2mizMlv801DX7c4mugYGbWEKn2CAeG9ew+f?=
 =?us-ascii?Q?rw/Jc/an6QCnMywGkGnJcQUhYdDEl4dpxTFiFJnzDk4BN4HmV/zK4P6s5XJ/?=
 =?us-ascii?Q?di2aV8hUncqSl0P9VllSGvRA+lkTzs8qQGEwryhA86IfJdQE5UisjMqkvi6q?=
 =?us-ascii?Q?IDqeinvR/6oZSynTBKVWo6KZRyLAyLQBo5i6eGOyF9wqdRzVZUY2ZOPHhpWy?=
 =?us-ascii?Q?bEsvNu5Xa7NH1fRtk1djXMfDpbdtUzlXktxHBSklRhBSSu1rENHdEUoR59K7?=
 =?us-ascii?Q?sXZe6I05kt1vuI4ztk8LHp0bpLcmk2nrtFI2dtBuvksO/ASOSXUzsBmoyWji?=
 =?us-ascii?Q?cWuAd/8jurRjppmpRMxZu1PjcxvfruhNFhZEs9QGYA/PfbOMw90kTyjvyksr?=
 =?us-ascii?Q?960OA8muonv3GhH/Pfha/bCO6nYUWB87rzHjXeFwzKCtnLTaaLHyUunDAV9x?=
 =?us-ascii?Q?RLkv+Sj693/id7bMA0H6xIXStEx5ibWh7q6albkxYnG9Mkeq5zqH+HUTIxx3?=
 =?us-ascii?Q?UXA6lik/tkp23QVSYeKnWleDugnGs/y709F3H9VPlgS4TqFBZwQ6jP7x91RX?=
 =?us-ascii?Q?0zJ/ziXo/xODv0d0RdDPCulVjJXI4/R58copFOHt0CHFrMa+AYV0umxhh1oE?=
 =?us-ascii?Q?LtcrbVl1Sjwc5d1L2bq8FO4Xw76li/sZLgDZi563uA2iWMpvbGqZE9Eq0N0r?=
 =?us-ascii?Q?G9rKRUvb1P89Josq0nkcDsqRP77hQ5VAmfAwazVCsN8H77i6gs5/cU2Y30SN?=
 =?us-ascii?Q?b03hcpoD1Zd/hX95nIK4uHPLPG2Go7n9K4lIG5F8B8cuZjWBkXYXdpMtOoGR?=
 =?us-ascii?Q?zZaPuFmxDquCtJDMurCK1Ko+eufCXXI2FFyPkogXCKeN1GOtBjMiizAzabii?=
 =?us-ascii?Q?sBX0ATZEKrOqga9GGP56HaWdXX6x/Lsd8xLVPvuz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0c21f6-115e-4892-04c6-08ddbaf951e2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:50:14.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ayn2lZehmaDtiC1KWMPVcGTomLFrblAEkZkWc1h+WgoIfgwB9fU59zOCjLROMrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

On Thu, Jul 03, 2025 at 06:48:42PM +0000, Pranjal Shrivastava wrote:

> Ahh, thanks for this, that saved a lot of my time! And yes, I see some
> functions in eventq.c calling the iopf_group_response which settles the
> CMD_RESUME. So.. I assume these resume commands would be trapped and
> *actually* executed through this or a similar path for vPRI. 

Yes, that is what Intel did. PRI has to be tracked in the kernel
because we have to ack requests eventually. If the VMM crashes the
kernel has to ack everything and try to clean up.

Also SMMUv3 does not support PRI today, just stall.

Jason

