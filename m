Return-Path: <linux-kselftest+bounces-19985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE6E9A2924
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A07B2B1BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531B1DFDBE;
	Thu, 17 Oct 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IHofSX/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0E1DFD9A;
	Thu, 17 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182916; cv=fail; b=GRNPyYEgjRwy22gBsUTpGpSo7Ggnht+G/LYQ9IJSPI2mO2kYd9YZCVh3Xm+T+j6dWhC3qlAGdBPLIPBZoK7r3+UU7CFYZm2B+PCnG8u0o8eTa+kbutzhMHOBLRBIYfFHelidv1wps5fMkxy/PO8Zid8G+bJN273oCyets9dPNrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182916; c=relaxed/simple;
	bh=EngLTlQc37z6J5xLS2xmEGSK12eabnNZHfBDwpbuct4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOyaqdupbEOLphbX+x7kdMgxNq0FV3lDLl3A8PBQs2Rl297GMjJSIp08sVGrMJSzX+PruJ68uie1Vk5nZEqV/i1G42CAzeAwUhI+l0d16FDTfwQGeIPNTI7ji01levLuZCe82EbZoqc/F2Ndun2yWVhRhvZV6KGpxTgc6E/VDHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IHofSX/l; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxxup1s0aVkdtuW41476eDE5icbn35DkjPjpmDclgrDEDKvxj8xQzp6jlSz+QCkQdaMSFYQwdDEnI+/JrG8ZmZQx/TvkjM2bqYnXYX/w1+1go1uNom7ovzjE7QkZgW74NGTxoAszFx3U7Y7+PHRW7hkfM6364kiI4X82rS2qXf5WsLAVg73nQBEsWGiFiw4VMLHIupwF44eFXaEcHYJ36FPHDr48x0vWr8OGE80XhFNynCzU1tR4xJsEmFJqJubtIxjawh/OqVmauDej+y3BZLNov9m2QsYlZNRJ1U5hEC2zVIKRNAz89Tdbv+DlJiYCtw1RUjcyH1P+cfAWZO7ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBg0YXFOMp239k9VBJb7SU2t9yBJcx5/6IKYdVT0gww=;
 b=Sf8e9Tq/7t0iuyhHdk4BB0TxSTrmOhbzTQLWEdW/5xrKMgbywtK11J2Dzn6kgoz3jXj2hCVgKktJ62yeH+t3BEWadtLV4PI8Wg42OBYel6QokZksnZfPbfl+QaDN27w1BD/Xq4T4zIOlA49leaPTZ1kfHdAfVuksX3xX8TfMms57KnlMTNIkBcoJKDRZC+3NMwUKAh/JafsVTHguPtHik6tGfn5l9ac1BZvYDjKxQ1BsL5TpNtR5pSep95v5txBeXYUB4P1fspKLaUk3WKrkWNLLduxunNA96hvv7K3zoaCv+M9Dq6e6r3Td4SJFfNyhXxKeXiBssN+aSFCFGHG6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBg0YXFOMp239k9VBJb7SU2t9yBJcx5/6IKYdVT0gww=;
 b=IHofSX/l96+fgiGeK1rJ7k0AU0wqx7rKTd4jXGEigfC6s/dZW9PejQsQODXigS6i36DIFFyNLXaEiUMdoFLtZXABwFgmn11ca2zyswrOsGBfrGpzeToKo4bIf8renJ82th9eH73UCyJnNrzf1FNAnHvoWnINVZVnGz2raoz4n8aGIHuXJSPRuoF81UEzLwd3KX/cBxnV1D2RKjdhQ1v0vB6faVwyrR/it/ihJ0jSsCFnbbOwYdLdx5iCqgresk5rukrGK0pTr9Tw0csdBssomsCqJSY5ze+1OjF2Kd1sCFVnR9hmHX20eaxBZVK1MJyUgh52m00Yfz27C0X2st4VsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:35:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:35:07 +0000
Date: Thu, 17 Oct 2024 13:35:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Message-ID: <20241017163507.GC3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com>
 <20241017153749.GA3559746@nvidia.com>
 <ZxE3U+9lUXwDEBx5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE3U+9lUXwDEBx5@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0364.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1d3abf-b81f-4180-11e8-08dceec9a95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ov0afFUf7k7G2dutHuXZvGT56nx4iu5HVYBXmx+FLv6niBhBEAxj/A09zddG?=
 =?us-ascii?Q?XiTt/oJx9czjLpfMVYdxlTY3PRePZAiFMxPB716MMRAKhhaazfrbulomRtLg?=
 =?us-ascii?Q?W7Xr5HimOoTnElLJ8g9hhcEoiNFQcckll2nOP7iVHFUEN4ESH7xNO3Kk2jsy?=
 =?us-ascii?Q?DpwM2aO5VcRuhcyRt3sZxGYPpPeI8drCAvSkw6VbGy86sN3E6fpSMInVaBH7?=
 =?us-ascii?Q?8r2zUW6GlFNK1qU9PYyXpnNgnq1VIfl2s4g17G19Ay1ALPT307MQptz7MO1O?=
 =?us-ascii?Q?Kh5vbOIhhXd4ogv2DWqRSyQx12n3tq7oia26nrJ6SAy6/yTBnBPqMP0AMVC5?=
 =?us-ascii?Q?MlIOjhKzT3iIJemFy/zrnGh1o3X4oFO2mHQPqk3TVI4b7r9+sz7gvfpWFbcZ?=
 =?us-ascii?Q?hU3c5tXK/oDR3NZ8F6/EW4LkLDYfXegs5a3MeVYOMoGAx9/YSrwc5VO+D4HV?=
 =?us-ascii?Q?15jYEJHWvqYhiLPFiVtIDM/+oSBSAMCZ/FWwwYi3VfO3LU97gR+cwpehcLyR?=
 =?us-ascii?Q?JtCmNX8eRT0KWdiOMMva6uSjRf/zwBHlJty3ayrdsuSHVcbz8xsXMwxDZ00u?=
 =?us-ascii?Q?/LmLdKmJCijGgMhvunZBBJmi9IRDZe7S21c5wZ84qiI51PlTieVEmCDj52Jw?=
 =?us-ascii?Q?yy4XejI+/uulqxY82It2mhRPoHs9xGSoKZQQPbR+PSBoT5iuOvxvyz5hRbdK?=
 =?us-ascii?Q?pS9LJSD83tFXViLWU0YhuS04XAKGSMD5St32xtbYCgooq/D/bB1SGX+Km1de?=
 =?us-ascii?Q?5mljLEkqVK43rDOEOlFPA4lBY18LDSldy64WgCrOyXGGI6MzRuUKjnoIc8xL?=
 =?us-ascii?Q?Oowbypn5gx203kLXKUU1b1C16Er0688OE9idnsNf2y8e8gDNhT515Ket039M?=
 =?us-ascii?Q?yrBS5nFEqYyYu2vgimNJsJTgeyVtaMonQzAWKvL45qvozcyX2Qyp99hlQFqW?=
 =?us-ascii?Q?AyaVpHR/eMm5IUE4Ffo8gpyeAC61P7Yhu85anR6VT2zRQHv4dyVgfXZNRSNv?=
 =?us-ascii?Q?YqfmnmbcWOpUKPELf1+xcENkF4WR8aUSZWkFMb2jTNQInG+BfU/iD7WbKRNO?=
 =?us-ascii?Q?ReCY1zJT9/++ttsWGvt4dBJzw3IfB0ONo/hHO2Il9l4Ny43GTqmuZMw3PVII?=
 =?us-ascii?Q?bq+negCZlmD3smfnp5Amim3A3fJU/7EpHZ83CC+bJ2k6v3nU/GfHVLESnZDa?=
 =?us-ascii?Q?pqKZykxFNG+L2fsYSgBCRBu4Fb6W7aNnU0pR8l1bJXtYfmYMNne6XKH/qG90?=
 =?us-ascii?Q?hIpGeCOf+pkQBGL6eH+ufNHcH6rLaSkcV8OxWadYSQGs/Agx1Zv9o8Uigfu7?=
 =?us-ascii?Q?4uSFCFYTHFFeiU7WT6dxpIk6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YjKrCHUQ4BeEV2guMyxBDbixsNs9KpwRvOuIIiByGzIfo+9xkNfy5iv59dI?=
 =?us-ascii?Q?iYdBucoCluwV3z7Wtm/97MbpkOJRYvlKKl1TwY4RIXJQX7YYokzuuI1xmqvf?=
 =?us-ascii?Q?TPpqJ5dMj3m9nxAftg8P4JKfnELdyrPnd8J9jUp+l2y131P5l3z4Zok2QmZ4?=
 =?us-ascii?Q?EeT3GNGVIiHbOHf6lEPFk4GVHC86XG3rW3a1/GijQ73NPW1wrXvvNs3tbSui?=
 =?us-ascii?Q?v3m8wnxu5dg1bYQu1FAck+OsNpwRChSTg9/uluiPztsZZVcl5vmRpiIRetOn?=
 =?us-ascii?Q?vUlKJk/1JegSeTdvsRUml7JHxx/V3C6d6khZw2uhhFaB4cefzsK6ZYFinPUl?=
 =?us-ascii?Q?A4zRf0DM7OhEjH8Q2Le7QH/ehkMZY7oATKUs48r1X4XA1cElhxWTKbzhIZks?=
 =?us-ascii?Q?CnuWhLybn5ML614XbRf2GOBzpemZ8XCFOJRsyVf1SkQpsT/PWg9bf997iq/R?=
 =?us-ascii?Q?JRi5cEz68L+unD1Zt8kK/IiyxXlRm+cgSDok92JwKHw4owTZTQkry0t4N4oe?=
 =?us-ascii?Q?FDTxMDxvIt8EVo/5iEkrxy++p0rJWbI8YYkuxA++h43ArZNtvrktO+dert9G?=
 =?us-ascii?Q?OTKiXjjRLTe/8n7t5j2aRZrfhv386WmKrQkXgGZbCtllMmu+qNWuOPlSPHNb?=
 =?us-ascii?Q?9Or4/w54TIPmMzcCpgaaudV07vzdSQsTk7YpBNoAWEu1FWp7YEG6roZ0kNtu?=
 =?us-ascii?Q?gD4s91Z6Tv/sFfG1oYQoNvpjwC1XLC5didGhvf/KWJXDdq+5N3N/Eo+wBjN3?=
 =?us-ascii?Q?qgZAPlgLCWije8uyHvBb4G02CsA+7dDY2zq4sRgj5agLbjuHtVAY1k2DpV5P?=
 =?us-ascii?Q?SbWOxvbRodwwXfo3An41UCrwjfcVGomeHrQyrEYvm7IGB1agjN38dwR8uCok?=
 =?us-ascii?Q?4phAG747/m5wjwAXKrmpwnoTrNyJjDNFQPl0FBZq+EuX8M+GzIY2oq3jC/ff?=
 =?us-ascii?Q?rJHwT3xr7UxCW8aesIBox5y6oe+e5ZMGmLeAzXMLNclgXnr/SSZTTyB9bPOd?=
 =?us-ascii?Q?K686C7SC86TKil/Wtkv2nNqhbyWPPOJneba/u+yqfvma/FRrgBNCuiLaYwue?=
 =?us-ascii?Q?LWuWYpA/i3VZclANhhvs4vzb0K8fhfUcnKWiFEQeyP1yRxlsNb73oInwB556?=
 =?us-ascii?Q?s39C6Z23m9enyayA9cMstsTtfZlY4FZWtBbnonJbbdeS5bTJIwEKZfM44zB9?=
 =?us-ascii?Q?xtzAV+L6shC0HeYsk6kM2xJB9KAfLACnD7MG60YLLmGoVOt+IZPEt4GqrH1V?=
 =?us-ascii?Q?v2rBWr4mJv/60L7MMOuvjyTQM7SrTLMw6TCE9ewtWc8kPYsjG3cPU2HyWphO?=
 =?us-ascii?Q?RlYw9hikO+81P2XqcsgBCH4zzUsd07iUYxK4GdrH/sLKbD0izs0xjzhC4rzF?=
 =?us-ascii?Q?hDAbHKI7LlY7W6dIIbPSJPCuiAK4YqSJQP9ReC2JZlSWh6EYU/H+7DryAG2x?=
 =?us-ascii?Q?fM/6TOz2xtRExEzblLuU4hrRZ6ErCbCRwE9YEoLAZrINb0HPS0Tj3EPjZ235?=
 =?us-ascii?Q?h4xcthqSNYTrwCyNXgLJwrYEpAu3pYuGKECFPOsRKwDiSA2FsHsWBpu3z5od?=
 =?us-ascii?Q?7vVLiLlSGlhxALtI0a0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1d3abf-b81f-4180-11e8-08dceec9a95e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:35:07.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpVfMVPF5KEUrxz1+7Vr07hkmXBNhGvSsp3yMXEh4G7OAWFZ15zTHggwffqEAohC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Thu, Oct 17, 2024 at 09:12:03AM -0700, Nicolin Chen wrote:

> > Then you can keep the pattern of _ being the allocation function of
> > the macro
> 
> If I get it correctly, the change would be
> [From]
> level-0: iommufd_object_alloc()
> level-1:     __iommufd_object_alloc()
> level-2:         _iommufd_object_alloc()
> [To]
> level-0: iommufd_object_alloc()
> level-1:     iommufd_object_alloc_elm()
> level-2:         _iommufd_object_alloc()
> 
> i.e. change the level-1 only.

You could also call it _iommufd_object_alloc_elm() to keep the pattern

Maymbe "member" is a better word here than elm

Jason

