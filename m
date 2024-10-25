Return-Path: <linux-kselftest+bounces-20677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D149B08A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D271F269F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B415158A2E;
	Fri, 25 Oct 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+UbiNzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1F70837;
	Fri, 25 Oct 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870970; cv=fail; b=nHdQ0TPPLFjidIvJUQchlM6kzoG41YoJsMGFwZ1mdoESE3fwyhLHgrlHehhR+R3Tfm2LCVXGfTsXQU7QmEwQYrQ8T3DU1jhwG13L0jk8qhTLPl/pjjiJbI7o1dNbxQRFg2ya/437y5FiDVjmZTbtswWIuu39J009jjwM/WAVffc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870970; c=relaxed/simple;
	bh=M2dGasWbi867pbVfYgCrrAT1sqQthP+NYje4L8bRxUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A5Utr7/wUrNjz/5kBm9EMz1VCjsaeJQ//UmReQr0j5HLO5UfgKM/cfTP6l33kRjPnnhjdd5aegyH/TA/O1oPHT9k/X3HZCFwcNdU+aUgYlJQwm25TiOnjaiIDIBfgDQQ0Xe82L8CCRIYH6MAF0J9rTZv4z4wz5BWmovrq2/QzaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+UbiNzp; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1M5BCfFwvJxD4YB7bP5kmaShFOx6AbxcHnTMDn+u+wrpgMbNe+2oCuJvqg6NjEYqGRqxRcYJA8cphL2iN5UEXIMOxFlMHi+r7H7Kib5mWOpU9DFgUruV4N94PLPsmoCefQ6eqKncEyhoMzN2Exc7+O8a7+JN/6DwaHOYsBT0+0cG1s7w54gs3YWsdjNRbHu4ZYx7iGlqR/MvqwpL9os3mchG2umw3RZjdUjlMfPUNemh1tVLRbkuTY+GV2s2B+6910sTKvDbwNCxMsfsspyK8wwSFevVJFuX1IiTFqNWhcs8Ijmro+S9Xr0EgvQESr9ma1/8l/oe6eDWcnmmUwp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6dXOej46qdPs98WVrYbxcY/0RQYCd6DfKodEKq/vqY=;
 b=JjJnMusII4QEP+52jHImv8gr6o/0nn8yvLjkVoq2cTq6p+ExbQqhTmIEuuxjrFRAAaxemVXUDc5EH9uVrwdYeCX0OTCA+rrX1shZCsmzD+9Wk8Qg69rclUGwNsvAZW0Mj5VF/O4LADdbKiGrzoG2EZVtkrlwahddB8iBXsaGbl8n5ghL851T5T3G7wD3nAR/Xlz6cC+hY+W8dHApOhp0/4YT0w1FPlKXpTMCP3F17b8gb/UwYRblu46Jp/TPUTVXWnISZH7HCVv62NIkUGMK1wQtLyB3cupDAp+Lfvrbul6gy3n9oglbtaXbZ8L84k5eL25iU6pATrIZpLG9ZWqyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6dXOej46qdPs98WVrYbxcY/0RQYCd6DfKodEKq/vqY=;
 b=X+UbiNzpxq+IL8I4lsUD/fxWSb+zlOuniTNfUJQHGh3MwPTM+1m4byqNu8+9qGg1rxac0r61aaiZdTX5qMAFRFOLFc+phIgkGj5981YF0bxlahrZ62+KvS4OacKiMIpBmKaGvcXewlbqNhxjwW6P0HbFxjnQ43LHI4nR08w4snsuBczQzdOgWR8IFWLffJ1Isd4qK6AkEkogvPcbAcIWsXYb/lrrWyO1dDJa3qxFnrv1SE3Hg7W/qRFM48FmnApxGBByfCf6FBImvhnlvZGg3srNA+XlkjNwHLKIGAsp6bywosg/iLXStuN8026KwIk6mXYyCcoXP8greC1oUkezyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 15:42:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:42:41 +0000
Date: Fri, 25 Oct 2024 12:42:39 -0300
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
	"Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com" <aik@amd.com>,
	"zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Message-ID: <20241025154239.GJ6956@nvidia.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN0PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:408:ed::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 1246195f-80f9-4285-8e94-08dcf50ba908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PFixsjgNrY40P3RoUo4sfrqZkueWbv4o3OVsr3jyjA1rkKm/d9aKEVWYzXmE?=
 =?us-ascii?Q?Ql3MvHmJ21hMEc26e+zjNAzvfb+RFDhL4FQSi6+WYRRR0bitemEGaIgjtzzG?=
 =?us-ascii?Q?wxwdsbl85/gB5GeWMesLOrsApW4Bi6rU1V4eRZxf+4ZlELV0J7G+7NXg9avh?=
 =?us-ascii?Q?URP5VxXCwxFN+0xqFSyH4AGEV1n2wqu5nSd0YEp21VAiRdfR51bbbitsxunh?=
 =?us-ascii?Q?jWvU4HDpfKnPLx9G6pz4cp9uvkfioqLaET6pKid9wjkRdmmZQxvALE4EIRlP?=
 =?us-ascii?Q?gbf271qmSZUAzRMc9EhbKVJ0x9yo38lJlbeWyaV70P5hvvWxo8PT3R7MLnHW?=
 =?us-ascii?Q?YesOKCUn23mD7sjElpdGhWiuTG9o32/W3jdtkQzesWdNV7AwuHsEpz+MRZ4B?=
 =?us-ascii?Q?p9jCf2Bl1uaFXqt0jqCxh69UltH1CBYeo/BV5qIbC9veVhNl3jU2nBT1Pv5o?=
 =?us-ascii?Q?5n2kXIWXDr3rWDLhbdrkIFtI+PEzmyOd/i/X0i3PZuEtP0jUa4ZvE1qG5pvr?=
 =?us-ascii?Q?DtwLTVs0uYGWAnnDLLiojW/mbj4FyrxJKK56lQjYeKTI81R6Eodu8dIMjKI7?=
 =?us-ascii?Q?kB5uRLaX2rSYkSpiq75bL8JgyapXpZ6YPaNfC4kwD9YmsX9pHmcYUnqD73Rv?=
 =?us-ascii?Q?0IHBZXKhXC2j1o8MwrYGzSzGsYJgC9VY/LGMAf5sZYnY87ONjBYkx+Pp+yI0?=
 =?us-ascii?Q?4GKwe6KkWWs0dFb9iuHdd6rVDJwATSx6rj078Aj5qOOZV4K1/HMYR3ZoBdai?=
 =?us-ascii?Q?9WjYDk18qKU93hMcfjwlIfpJjxNB4t8+Q8cHR4aOM4D1LSFQykz0ruqbGLhb?=
 =?us-ascii?Q?znnR6r8Q7AoWYNwiTD0bjxREM8Cxjfoi6lOhrlqv3FgY/6l/jorXQJRQtY0t?=
 =?us-ascii?Q?1QWn0kxKtu2+V8UXKFMEGbU+6/MJ2E6cBW4MoTCzIMMz505xeQMkMeL2S+hC?=
 =?us-ascii?Q?uaQE5trh1TglEF7EA0a2uZnWwk1cZWFUeGRZvoW3Jl5zQAR9kC3Mv7xC+dFm?=
 =?us-ascii?Q?BUy4jo7XlMm9lUX/iiyIQwz64EykqQUVvowLb4ErSpHsxKxoLwPaKSDdfr5v?=
 =?us-ascii?Q?zF5QDfYaKeXu3KnFPJVAl7V9UTT6Z8D0z28ww30PnV2NytAkJ+NmlPbDTX/3?=
 =?us-ascii?Q?NKEltMELSwFet65pEDN8/ycTud/0Z3ms6f6qgYZ5t4MbJqmKA8IfZHxQUsfN?=
 =?us-ascii?Q?Ev6tcWO3HyzfpCU/W2IjjclgASiXtJm87dtoBb4+Uc++lVgxDhNrBI4k0vRJ?=
 =?us-ascii?Q?eEQ/7Fgo2f10b3+o+7QPUomL4JVJ+bklvgSuctP4ou60QlGVxsPLIv7SWMaE?=
 =?us-ascii?Q?AMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66uOrkb+agLHyeCVBlIeW4vdPHZglDWsGr49Ue78vZ263sKFQFtYCxQIeOH3?=
 =?us-ascii?Q?qdRnS+MHuIPCMsyayMOPFQWxwcnFl8kkijtM+jtQ8px1uoWzsL8mhwNA5Bzb?=
 =?us-ascii?Q?Asa4sJTJtSIa1gd0E+vF5zcNs1T4cq0xBU4AkNHCoAZ0G+3nQrDboQdC7TLZ?=
 =?us-ascii?Q?s9eEfaIe13WiFqburUoyzCEAJ6j9RCKK5kHwRM6cwofMiiZIhw2c6XmaKRqh?=
 =?us-ascii?Q?qzDbUF9nnVEkitKln0Q3RWzlmWJgTmNgtt/+xauVgReY5tHc/cikfEFfnW5J?=
 =?us-ascii?Q?jmyfe4by+nQXIszib0HGY2o/mCDx1VmdrK6KrMk8U6/YBZz0Ad6XbhuIsWFZ?=
 =?us-ascii?Q?5DdL8sB3jj1v1DZLic2t2nc8JS89POqKIYLXPy0zRgMznLCL/Y8uVxB5Jcl8?=
 =?us-ascii?Q?jk1fZvwR7QaeGIvNRPbE/zkwrp8w5Xxm8DFG8xWbpsJjHYIfXJT3Toq1W/tw?=
 =?us-ascii?Q?RRethd4yrPC3/PBBpoouA+dxz8R0mR+6+JbTv+vyzGAltRuFZMktkJXV1ZT4?=
 =?us-ascii?Q?S8zO27ZV3of+t63aYoO+Kbyvnm0pGBo/Fq1YTh7/vZ8seyEQ57yYIg6fG6yB?=
 =?us-ascii?Q?BfMrHjTqdCBHq5dIqTprQ4eARvU9lafWKVIIbdvvMxZg569Txv411MoyLrZM?=
 =?us-ascii?Q?MV7ZvOuhnS5ZAvaPDEt1WrubK6vzTJaNyJFsG9bnCU0PUlfacZRZNK++vOOo?=
 =?us-ascii?Q?+ijhkxDiCA5SU3saXThR6Bob1ZKoMi6AN/Cf2/koxvRabeH7PBVpsXoo0cih?=
 =?us-ascii?Q?keNPNOBciFhNCnjUOWpTkJJnt08yvjaUtP7UYD2TERhpuCftJlFGwlYtV7Hp?=
 =?us-ascii?Q?mM6fXYce6udfCyBv5BrEdHNf4sjfGv+HDjLqBFIcMg4dAVkLYeeQspNyScPP?=
 =?us-ascii?Q?VJCnpYzgc0WAXOhIgcj3XpyG/ZrHFuquH5Bd0ftAw7lGuh9+O0ggLBWrGSYs?=
 =?us-ascii?Q?FxEeWRRhlo9+kgSFQptwG5QQU2Ep08HD43f8SyUu10J7B8QjWbAg+423jl3g?=
 =?us-ascii?Q?NjsAAB/m7iQoilg5/lAxSOG+NwYYxTylJo2Xt1e93vvB3IIYQQEq526gk8fM?=
 =?us-ascii?Q?wFkDjAdbZB751Dy+/QmP00DA/21noAFgZelNCDpvMsGZk4uAiuX+ghlM7fLd?=
 =?us-ascii?Q?FBlgcvtkJUS31UM5et18ahLK2iu0cne7VOvmKfumoLGHvRMSOQyyWEWDok8o?=
 =?us-ascii?Q?tmccErHIuXyL42I7XrbPI1Th9Qd31jgCApFAJbP2fI9kiraAeQpe75Nzg8Tz?=
 =?us-ascii?Q?aa3szeiuq/dauNhRjbL2Ul0b3JvY3ABEnEMw3vCJul2NnO/ERNAl33g7lmvi?=
 =?us-ascii?Q?6gIhXZHAIErDFKJElTedZJa3EAEF9qUygAQCDSUuUb+EmRqRlnM49WqRWfgF?=
 =?us-ascii?Q?sGYJIH/Y+CMB8Kc9do5GwtU4MHshe1gugf0gT0okoKzMFykLeiraStbL1n2+?=
 =?us-ascii?Q?9duu6HCY3n3Bem5qGXd+mZE371uELCtwKgxrpZQWdNmCbi8vsyBUByoR2lyD?=
 =?us-ascii?Q?10aj3TKwX/Lxnps+dJgFHWyRtqzVSeR9BrvhmM2NuS3TOyTqaPZtn8PWSo3D?=
 =?us-ascii?Q?wQiYblTGlVLqsxTWRDD70BPfXSFnn81luHaLZKZA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1246195f-80f9-4285-8e94-08dcf50ba908
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:42:41.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGHDQav0Of8zkivkCSL02RWpIoWDQ9HPbQCsyYGXZHa0QTmDihgh+aLdibpElt7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580

On Fri, Oct 25, 2024 at 08:34:05AM +0000, Tian, Kevin wrote:
> > The vIOMMU object should be seen as a slice of a physical IOMMU instance
> > that is passed to or shared with a VM. That can be some HW/SW resources:
> >  - Security namespace for guest owned ID, e.g. guest-controlled cache tags
> >  - Access to a sharable nesting parent pagetable across physical IOMMUs
> >  - Virtualization of various platforms IDs, e.g. RIDs and others
> >  - Delivery of paravirtualized invalidation
> >  - Direct assigned invalidation queues
> >  - Direct assigned interrupts
> >  - Non-affiliated event reporting
> 
> sorry no idea about 'non-affiliated event'. Can you elaborate?

This would be an even that is not a connected to a device

For instance a CMDQ experienced a problem.

Jason

