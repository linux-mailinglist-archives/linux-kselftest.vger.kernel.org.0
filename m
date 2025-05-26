Return-Path: <linux-kselftest+bounces-33813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E62AC4362
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEA16343C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3713D994;
	Mon, 26 May 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SRlEFFq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0B7483;
	Mon, 26 May 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279901; cv=fail; b=MMO/onrH1DXjS78r5xpGgz4zjI3o4gVlVpt1LTJJgPdP/lEykYuevcjA8ZD6w3f/wQtZAXpHgsswJeWpqgfi79eKZ72EAPPqlhRKJwGmJQB7usERuLOsofJEk6x4O7SfVMgeSyJIBqLu5Tf3Gvrrs5XVh5JXAmxF5pWn+vQgQm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279901; c=relaxed/simple;
	bh=U1rVaFjpPww9f7rOjBT7j6GctGmnPKzYyCxr9rubUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a1tKCFtYU4vKUGur0nrXVugGsXWTJmaTl6K/dH/c8/kxVudG1jcL8LODiWkRu3tNsArnGlhU82l1lTvYz/7ZzOLsr6G5OX9D9CUS8163zuYNAa/oh7f/j5Mdt8ngyH6nyqPgMPLL5RX1dx+p/b7be4ErYGa8ddug/3d0aAhPAFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRlEFFq/; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC3S9e0HkcQBtlp52Np+dBrmUXvScrSKcvTFwFvgrjjjS96aZQKT5UYiAYvxkQ40DWJef6MinAciQM9F5CDbrqT/sirnUKBfa+cHCFazVF0sHtefuq3aobsFLU+89dou11qhUVAZHmiw7KWxotsAsDYMbY5xV0xN4E5UONB1Qv6d+jAZN5t+vX7BT/HqhLKbaZqf7B1FkZ+7hsGlLpzqkoPAmOpk0PtOiguusZeBwCEX2GZg+EqtoCTST5Lw6AJ7XYgmSFzfkPzvg3X0KVkqJ4PsVTL8nw5WwgFcag/9AvxjNyMjIIE3+C2ZBUy7Iu6hYybhZPsLT4NlxXZCMO+yWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmMSYbvIIyeVTWoMZrinwoOmEvyuSYarnZwVeeLsMjw=;
 b=MGSgdbGwuMBjW4fHYEeysXB4oL1kPLGE6yHtGIarWuetVnBwAvcpv4XiprcarOO+hobPTqi6K6ScXcVTlvx3JvYZFO9dsQkkTMnHisAMX/IfUVtt8QGxlJ+kiXo2GT/rEF1VqjUX2M0/URqiBd+VAb5pFFFGN5Gm07669v95P1f33miZErStmInPSaetln/YmQiAFvyEVw1XVjhFrs8j/G6rIT53+9gXsDRjDviU0ejaa6Fx7l9D1qufu289W08b0tF4s3k6FV2zdJowrPFY8dp1/C+Znvn+ipyb7Jg77qax0ttaivYA2s9utynN7I3IMfX5ydox4WBWM6CE8gT7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmMSYbvIIyeVTWoMZrinwoOmEvyuSYarnZwVeeLsMjw=;
 b=SRlEFFq/cuJRpgJWqyg4z4yJiIuFMnABJKFaaYW/cBP0E7e9uAT352ifc4iRiGvm55awogBgMcO7xZ8iUwHbm5y8iw0+iYw/ZJS11O6tBmf5aAeubItYlW74gMrf6FWEaOOKI/o1U1KdUBOiRodjL+qOrKChVcirXxnD2Pb9nwwHA7MDQwkCQD2GORGOiRmycOE55BSQAvQivshEtomlcoAMCvbtDQlRxPVPXFseg3ji1gLvUSs5lFIS3jWjN9Yuj5pdZMGWfWtV+hM5Jjjj1pLq02sKI2WemjPIKZdW3MFJdpwtqqHi4knS6G42RAxyH7nSqTArHNGxQGjczYlrpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 17:18:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:18:16 +0000
Date: Mon, 26 May 2025 14:18:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 13/33] tools headers: Import
 drivers/dma/ioat/{hw.h,registers.h}
Message-ID: <20250526171814.GG61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-14-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523233018.1702151-14-dmatlack@google.com>
X-ClientProxiedBy: MN0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 116f64d1-441d-44d6-50df-08dd9c794d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0cP/XrQq9e7cG5yH9l27KhNP4jhqtBZVC3FemEgRAegYHAlt/qtqggPLOsJ?=
 =?us-ascii?Q?ScArOUDP5L1gsViuehHyDx1nwZbLkOFnZpt3LKlg/4WT4KzLZxt6rCwXaGD0?=
 =?us-ascii?Q?Ys9mZy/z1xTg3kjbL+g2MKgYHLDVC5pVgo2QKMQFyGg4fELd5J1r5ZopeQzo?=
 =?us-ascii?Q?Rh1lTKV9LsLCOSUl3JRzlhCsXkr0sQMvi2e5fpGu4r5ROzwhhSfj1/c+IySq?=
 =?us-ascii?Q?oZCDdTxfrcLRtv9fYOKMSkQuUlNkVcQwF9gsy5w97rmWrnn3WkqRdxmEOgCX?=
 =?us-ascii?Q?im+9buf6L2/zAnxURnNPGqZrelJnlzP8odkvBV9Txcz/kwnR7KZZp1CGnAsz?=
 =?us-ascii?Q?KLTfnS6QT5jhHeKCo7MFc0igwkJSiogT4QGO6jUb+kc+PWv+AGut0EP7W8Wo?=
 =?us-ascii?Q?ArrWqTeB4QK6O4nWiVqvpFCmIvMmtwKs5kaursL88KPufXTF8zzTk82spQDr?=
 =?us-ascii?Q?UgaWULIggun3MsRRI+0+GDgirQCCh83LCO7sepRSPs7En1XO0NBlxqHVybjQ?=
 =?us-ascii?Q?rK31n/3SMOLlY21WbFVFZAiSWPQV4n1Yg6xLTfC3SmC33u2UTg/3UTQPrOIo?=
 =?us-ascii?Q?2yKItx96EMXiHTAHjoOUHeYXkm94V7kyqV4arhw/9ZofsAOFgqj/m2xxPAWv?=
 =?us-ascii?Q?jFtguMTe9ctIpXTg+NNV23l3rsc2qwaj6qzgipdl2NOKPNrlhYrES1zOxrCS?=
 =?us-ascii?Q?4qs4+V+XHwGlwVM82umlE6WIpgecoLbgSEYI0UKhmHLATKyc4J3Ua0tnE14S?=
 =?us-ascii?Q?GknQyzr2B4iz0BGk7Dcxh7wNu9xJAOCp5SmYvc5wyaZ+fubDzS5MKcKM8cGj?=
 =?us-ascii?Q?/KJiFLSeq4PINScoKW6OyhdnNc3+BqIHsWbZ7cLqqzO6RVExin4e1oYeGpO1?=
 =?us-ascii?Q?w2jF5GAnQ185T79Sg9DCe0ja0JqFCN32L4e0j6RVhkFfESXWDQS4NaJtzXWQ?=
 =?us-ascii?Q?WruV/ukV8dgiff8ZJmgi2Eng5ePIqOeSVtaqVEJ1HhQC72vKfUh3OPaLBy8k?=
 =?us-ascii?Q?hKpoUdc7WXkmKIOQ9XWOcu8ZNd/sxjDxTQ0RiNzGpc9I1mYXii9OfLrIc8FM?=
 =?us-ascii?Q?ZMeEG/uoSQmqNLWOEknR5zBYZOb2sN7z7RJSgE63rcsg2hoDo3qUmh+G6hLR?=
 =?us-ascii?Q?inI00PAZnM/xS2vF6bLN5QwUcASL2+YYLg1hR9QaFmZiDE8M5lpJK0a3bJeL?=
 =?us-ascii?Q?pFmrddsG3ewQcVwb8apmzWBlnn3N8wRBzrYvJLBq0vq6XECk/GS+ROam7Y7S?=
 =?us-ascii?Q?0NouxMkOmGceoFjXAHbIDU7sbmh3FWzac5yiYdfdyCjcAnDQaUXZ5mkR4n97?=
 =?us-ascii?Q?lgR16t45IBek9u+vx+1e6LqmITb1X1Dk/ADke2N39dhgLUGUUZ2Lz5TNo2NP?=
 =?us-ascii?Q?CTWpH8WyxFBzuTHB6e18N1zyoGdfurQzR7q+4QWWEI0pC74TYr1vmQRPlWYP?=
 =?us-ascii?Q?F1dCNsdYi7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LYb+25kjN12Mu/FSrweHK/0Om0k2KQemAdXRVrPNj2/loWmX3l/yRNxRbS+i?=
 =?us-ascii?Q?XpS+6L96gzNhjYpXfo3TvCj062qsjQhsP1lR2jy8WgySormU1f6RVFYS3pIL?=
 =?us-ascii?Q?W8FtD1kj5Rp3//Zll6DTtQz9X5ipBHbSxY3rNe28cYs+HQ1E1SwHu9XkeyoI?=
 =?us-ascii?Q?6+JVUoAj+nikj/N4KHN3b4bc31Npb7U1jmW+Ynu93fLhVP9BhqMXP8Bzkzqv?=
 =?us-ascii?Q?xXzeEDOCPUn6dbpGAc1VnOeMkL/0Rb3znJ07/fBTsNKlSjcXOAucZmz7slPw?=
 =?us-ascii?Q?wkUFsHi/WQ4XzQH5jgsj91duIKjxCj5UA78Kpu6Ox9ehl8cObZvbR1nXK2Jm?=
 =?us-ascii?Q?nNwxiMgBfR9ES0vIIezEmnM7jmV7d1C+llmIhQ4MIHsn3UimbgXnsnv1HU0S?=
 =?us-ascii?Q?fszdwJSqhoXEwASXJcjoMq1AvEqhBf7/YM/cYHzDKVBjGss2/phdVYWzBq15?=
 =?us-ascii?Q?zShhmSj4FaS/DgLmJXIJuSpgnF7uBQ4f0tt7P2XkDVZnFw8DOS3HOmUZyEMF?=
 =?us-ascii?Q?IeCCwZIgf4oIEdHKYbCvNm22qay6+oGiJ1fQJ1anvAzNZeJdKXund2ISWkQm?=
 =?us-ascii?Q?zxZb0Yancg7wcL5ataS8n5DGORK25sqXBshHka1HgRXxkw9/hH80ZHYP8Rbe?=
 =?us-ascii?Q?OGmlXUIVlPrCfoPvUTBn5GqjbxN9npCgRlLCs1GwOpJCvVgD2uWREf8RAYIL?=
 =?us-ascii?Q?BRsr5aepWUOTNLPUwCMqn6ASI+UOdRzC6siEhSyHCtp6GXjV3eCwNYXUh2Cq?=
 =?us-ascii?Q?SIx+wZNFuoqIbPbV/lhtoTTto67JYwnpysVbrRsERmRXnF+raJHprGIL9IFd?=
 =?us-ascii?Q?OoOjEJEgRawzHtYW+H+DQb6bGTSZEiT6OAvZlnoduyFGoizIKfU+yRRCJS4d?=
 =?us-ascii?Q?JG3Yaxr/Qa9SCrjTWEMaDB/G20ZybHJ8XGpYHmnNcare4fThNm3ERgUQp8B9?=
 =?us-ascii?Q?CgK179Yincscs0oJALSz2APE/AP3VsVfjtml6Dx7o/eZGgI7aPOvoOoWzjnm?=
 =?us-ascii?Q?zY2un2rQX8DNX3W8DK+elKfLFm+hWzkcI87X9+RWW7ti5Gy59QHtMVOazo0V?=
 =?us-ascii?Q?M+hHXuqkQPDtJPsd6q3MKtAZWEkdn1zackyRnjFUrWUu3+C/ogTsAKOMF/dk?=
 =?us-ascii?Q?pFNKylMXDidMki7X+adYBPHvTthJedkTiewN/2HI1hna+iA+92tgb9CcHCu6?=
 =?us-ascii?Q?jHhcA0C+dMTsZgeboDwaqHUvBZjabgUHmh6vCzUJtooLRpzKqNbU7TJM8CrG?=
 =?us-ascii?Q?QlXo/nhXr+gKL8/QV/BE5oQNJx2qDN5JhPF+2q3aIJ2DVNoUTa1kYPVTI8Bn?=
 =?us-ascii?Q?22z/KCn3pGn+Rtk4mt38QGRu2E5wj1XszQS7zvV/nKbsG35o0+wozg6xBWED?=
 =?us-ascii?Q?ZG1ICLn3m4rK5WAx961aK8TUuTxHM7EzD4Hiq6MTNf1M+qQfjUcYjIel4SlX?=
 =?us-ascii?Q?SCzOVOrrDwP3vVH1sw0I9PEwtalFXk9WO6M6D1o/yp23VDzoHHkn8x6UrnPO?=
 =?us-ascii?Q?AWkckk0DhmREnUB6caUmCKQOrsCOVX3CAXsPSlF4cbaGowbglk1mNFr7F5Iw?=
 =?us-ascii?Q?3Gmhrni87fqTtCpEYM/NWCpmnhpmWUfRuHS3Pzzr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116f64d1-441d-44d6-50df-08dd9c794d4b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:18:15.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0G3jarrZLl1OjTka+p290jx909StCTshM06dJdMwP7EYvG69ySXOioeu9fJcCq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

On Fri, May 23, 2025 at 11:29:58PM +0000, David Matlack wrote:
> Import drivers/dma/ioat/{hw.h,registers.h} into tools/include/ so that
> they can be used in VFIO selftests to interact with Intel CBDMA devices.
> 
> Changes made when importing:
>  - Drop system_has_dca_enabled() prototype from hw.h
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/include/drivers/dma/ioat/hw.h        | 270 +++++++++++++++++++++
>  tools/include/drivers/dma/ioat/registers.h | 251 +++++++++++++++++++
>  2 files changed, 521 insertions(+)
>  create mode 100644 tools/include/drivers/dma/ioat/hw.h
>  create mode 100644 tools/include/drivers/dma/ioat/registers.h

I think you'd be better to not duplicate the code but just #include a
shared header from  drivers/dma/ioat/ and so on for the other patches
too

Jason

