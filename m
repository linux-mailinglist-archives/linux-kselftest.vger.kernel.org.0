Return-Path: <linux-kselftest+bounces-34090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64DAC959D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17176189C959
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28985275862;
	Fri, 30 May 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HP+ztlNC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5612D758;
	Fri, 30 May 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629651; cv=fail; b=N+x+m6gLln9ZC089QFPjisj3X6rlGovgVstg2mn+Fj60imgBzqlyq8eCDoYsj4pvpZGvhv9Nl8uyIMCpNA6jX5vCxF53xI+UyQAQA/rpeM6USQMCLr1vylDavMisGFpFwoDJwmcBgnu4JyCkpXpfcM67pavAxAy4opVIeA6gxHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629651; c=relaxed/simple;
	bh=YfV/28/g9i2mnsozFdSFbtc+OCBRqTbIjcCYNdE7t5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLjawU9Pz9cH6P5uQ+WhZ9cD0hxmb1CiHm3Gc1a4bjUCGmg2K8w19ZAdAHw7KbikuC1IAULCGWA3IVRaap+IntzZgwlS+3G9WBv8l6pePhaaCl9aBwS2zJZF+QhEPdbYSIxj83r2P+aJhSbeW8ZSF746AkS/bl7nXGm2GomGCM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HP+ztlNC; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vasdWdh6JQEZ7t3Cx1osMXn5iMhDrAufHnwQucJi1iunhF/KUJ1enB+vvTzdYTJXQMqepBxOZ6KksL36xRKPeyyZCdSN0n87cKOLPB/AscXa7Euad+ZbOzxp5xQFOOGbgZ9ngSLJsF+vmSc9ilZXsKwoPP1AHENwdMEG6q0fTMKJ3kbHdl0/Ac9QzNlXwMtVggva28SJFIN9268JTbiW3lXyMthX2Ism1uXJlAenlY3KeEikLxEEJZ+BNd28Migx4yGLj7S27JMQtYeS/q7K4b1G+NQuZYYsDpT/t0MbGGYNn8jdAVWMplcDXNYJPJ+Q7dKEE5AbsdiivhMptKTYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj7rUow2480zubdUAMpa+xDG1bv1mswdNkT3qW2RzSA=;
 b=KEjGXwvlCd1deChXPqRgAXu6k3nnleFO1ayUkOuNJTS+iA03yL3rkEG1J4tTNs4NG532R9l38x38FXgV6Im2rwVYkzsofC7evgk3CfCRV+QhdUR1kBu4cSWcsE3TKXT9gtsnoMpaRRqUjKMmIlzjMFLZlD7wv8Ykk7L0/v0fogklLq+Xz16GkOoWilbyEpGru3eWS4sLQeHlLcsWNVDKW69jH2flMBd5RopIoosbF1cOVc+wEaiAGqAwUh4WAa7EWqrmkTcq/i6ychLPOjIpsFk2mZqY7QzCpKb4T31CePOLPlBnJc6oOYaG44g7nkD0NFaImMyfFZ2OcOqnRpHUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj7rUow2480zubdUAMpa+xDG1bv1mswdNkT3qW2RzSA=;
 b=HP+ztlNC0Ker5f3DfMOXHEUQKoF0Kd2PJONV9I7Go6mgjKESsK1p7GoxqbMbWHCLSn1BgZKs3bZjGjf7a9h3MBifwdM8pPj9ZKPAriyAAzvYg2NdRsT0s4bH7eD8eLmBLDFnbnV9AyfmCztY3+tIs0jVhsfYqFljdpT93M74WmaPM6pFhYf1noY+Sq1PpYzBXN2JD9Gqk91dEV+qmX/3wbw8uUXDF0zmocqUEfq7KV6W6T8r8RnBapZTHXaQsmX0Z4coRXKhdET9KilZllYpmMNrN109Ijg628Odg7qKNhIbChp9cJlXJojxlCg/HZdy5xAA6SIFbwLNToHNpQ2+9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 18:27:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 18:27:24 +0000
Date: Fri, 30 May 2025 15:27:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Message-ID: <20250530182723.GW233377@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
 <20250514170637.GE382960@nvidia.com>
 <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
 <20250516132845.GH613512@nvidia.com>
 <aCemeved47HE6Q2B@Asurada-Nvidia>
 <20250526133046.GD9786@nvidia.com>
 <aDYHT1iCxJKO9Vnh@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDYHT1iCxJKO9Vnh@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:408:e7::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 4643113b-924d-4028-ffe3-08dd9fa79fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VAupXLZ3Lh1tIHUKTeE8dgVn8uQEbgVqMEXQo+c8DowVVRJ5AXqD618St/5h?=
 =?us-ascii?Q?xr2npl2BFF6bBZMELIKi3rM7q8MhLVQIZx3l2zwt/2m/PqiVezs9yKY7kc1a?=
 =?us-ascii?Q?mEAYGTVpBSMSwMT1Uuc7rLPq7PEFGTCGwflg1omkhwgFDzbWBm5JUYYugZTv?=
 =?us-ascii?Q?EBOvaKWup+KyKFD/42uOMu2B98Csjq7s0GGXiqlMZOi65PD2GhbteZT1G5D6?=
 =?us-ascii?Q?PkeIFbr1TN5JJ3BtIw5G6tnmYNduT6EFNzAtuhzy719OyrARVY6AXeq9Q1aA?=
 =?us-ascii?Q?P79y5vDYhpDavMA9d3TKOOIJ/mtoUGrog8J8N98AIRfspDOb3jUFt7Q4zVvy?=
 =?us-ascii?Q?Oicd3u7zymgua7bXHecs1mEkgN8TOKhDDJj1pMJqz0/ZhRlWNpNDuZtPVc3q?=
 =?us-ascii?Q?J2wHzLA90GGOhH5GKgeXNa+IwBlpYizk7EIMQnIuB8Pl2Sldza8X4BGjWSdH?=
 =?us-ascii?Q?BJo5wKUgURLs0oZiZ+Z7PLC8zeic7yyBeQrzrTIq3iiyYXDKp2YQd7olwhup?=
 =?us-ascii?Q?eXZvr+/cdPzL+gAtC3G2QNG+O4SB6eLZe2gFH3VP3b52Ydi9mjc5JiUIG3Ty?=
 =?us-ascii?Q?YsORv0hSOmziAAeBfbR+twgaFAbkZXkjnMR96ZU2sHZK/lifltwcp8kSG9Qc?=
 =?us-ascii?Q?V8zfeYLv71XKiAunZBxlbmIUYefxj8oAmGSzu5Ho5HvMEa03kFFL/aMB8DBm?=
 =?us-ascii?Q?Vp0+2h0hHberW9OG5RG7EcHa+JJlRUNL+eqvuR4PMtpqtIvtl8eMVAEph5cn?=
 =?us-ascii?Q?l0oXOHmPGSccARVjo9Cl0cmX5781HG2i1Dxkgl49jFYzdUH3VQeIt+zw+UC1?=
 =?us-ascii?Q?e/GgFAcgYUTF4VkqIBijUbX7gUAA/nJxAA1U3ILiD/bm23XX7AWAw274AziA?=
 =?us-ascii?Q?hBekwbAWj1SO/dE9G3CLrbg1X7KQS5c5p2TLnTeGeUmPBaLPV+gmfAQsjmL+?=
 =?us-ascii?Q?6h/Q9Y13PE9JWnkjnDDyirfZ6wsO1I92hMnQIM8M3ftrUahmDNntXADHriPN?=
 =?us-ascii?Q?pWZG7mqtSH/YljIUpxWp9CGStVAA8a2KZ0nI/FSe3XBSkP0YzcFk7u848g7H?=
 =?us-ascii?Q?Po5emHUlfpxB9u0In9QG9JVqw4W4S8Q5cZgP78iLLIepaonTWSZmjGF0EQc7?=
 =?us-ascii?Q?oMch2fWB7gCO+LsnjiuSJrLvygj8YwSIP7Kob3uaIRFHYme40BtE+ky5HPqW?=
 =?us-ascii?Q?PO+4im6f1oc/wt8wUwWLGjEQ6vArxuWXPg79qpnHrFgSWigah63hupUbDAYX?=
 =?us-ascii?Q?MnQgUIDi1T2ix3uQLXtuVdn1ll4+8gRImIVnuhaeF8RI9w/uRblq5jkGP+0u?=
 =?us-ascii?Q?xjwxBfZJjTqsFZ2VNxMjEyC0vo8w6O1WtxDu3UlgLPys24zlqk1u5By9YP4+?=
 =?us-ascii?Q?HdG087TClFveF9sWEvVljYV2A9k8QXxGtDekYIn06+r3Ee3Lng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1KoYzCiI6HWR0fO5OqPuIZzPx8ivNtodEYw+uvICf/fhUOnHvCeU8gzKn4c?=
 =?us-ascii?Q?WZNMLlCwOkEGHTHAGElqPVk7kWTru6ZTNv/q8O92uzsUdJFQhqTy29QslssW?=
 =?us-ascii?Q?o3eeQRXs9L9pq2RVS52ZnhSceBf9xP5K/GtQ5ivBqHdcikyNSPPTJm6JT+il?=
 =?us-ascii?Q?+EJz0YjG/yF8ywvexwCHYsRQAKwn7w7+GETd8k05qaJRpL354t6IBONxmYqy?=
 =?us-ascii?Q?eN/y6rziOuv80065sRpq+44A7DMC7uNKR7yq3DWyigLnmOyEgYpMEudF3PM5?=
 =?us-ascii?Q?8XEeHhp7AGxuAxBzOgDtrzc6Wpx82wimaN1sv32HaD7wFD52nV0ZuCTV7LSA?=
 =?us-ascii?Q?HD/RQwZsD7bosBybxWcZF/l9T2i4TzINnO7sJy9UtK6E7WZUAgbxFVKzLXSj?=
 =?us-ascii?Q?rm3hmX+IF7rqVS7kQbYV6XYu8SVAUPs2Kh4DJT6GsUga3veTEuRUTqjuiX+u?=
 =?us-ascii?Q?tszBJj0qRgNwgPecFKZlLYrmp0vAKfPtcJD72bQYUbWgdh87Hz187Hb2e8yp?=
 =?us-ascii?Q?JWovgXsfXSJSWEP3fH/mQ8Bqc19h3TMuHpTPnYAGtmKZvqYUb5e16oJ8cI3N?=
 =?us-ascii?Q?AUZv7KeYwehE2GjOfAwdsVPe0SElve8uGZzg/w0fhwzXQhkCi4zf5rMReo53?=
 =?us-ascii?Q?s064xiGJn85krnrkPbfvjyER53QSyovKOzCR5MhQTea+lZYmVFcosN9oqmCJ?=
 =?us-ascii?Q?RfF+7QR8yTJX2lgpCMD17CDH+oWQoYg8TrxTTZDZ/HBEFCtgcHc9Cj1JvmBl?=
 =?us-ascii?Q?YhULC5jbe2eFWoXmpfK0pSGMxouYj5subt+IRktt3eqaKx9Fq+v9MILR2Zww?=
 =?us-ascii?Q?dIl6f00VldkSu/KNJSchUOSKCOQqrGZQD/Rua9o0lPlo1FnKv4OGE3/UUEo1?=
 =?us-ascii?Q?4IngNZUDuw4/NIw7Xx77XoHOxgVVfXXNWNPuJr0v/RiCHkwnISL+ShqzwLoa?=
 =?us-ascii?Q?BRMExfowzvlPlguoq/4FFCHUeL12wsJGDBTp+l1dqNeeHIIgA00v78aptLvL?=
 =?us-ascii?Q?4UDCT57mFWtS2pYdmysqcqulVhcBBwyUKXbTCfBJYj+JquAr30yVkzDArrUL?=
 =?us-ascii?Q?OS2uBvAZA3q8IDqJU8N/u+yynrcUmk6CarES5nOOt8FVk5G6sZXqcS3vRD+T?=
 =?us-ascii?Q?BtKwyuDiOBCkl4Hs+zUsyI9ydp6oXsMDx+45fbK9RCENa0wJjVEukJyFx0AN?=
 =?us-ascii?Q?C7QB5SFAi83oR9ncIaQvd8gaPL/GwIQjp40ZCNERyKwFfB01W44TruZjjdHL?=
 =?us-ascii?Q?3bhs655qzOlLU7P3s42MHP/pO3d8GKw7bl9CTeKvSGd6knOwLvv/nTlTPZ/S?=
 =?us-ascii?Q?bCHFvNAHGT1+UO+K4NM7SpUpAmRpJu5rDgb+uLSJz+voOYxTDTHpZRuD3INF?=
 =?us-ascii?Q?rH4fDTtxnnZZVjp44LqTx9BbCQOcTM9u+FMwxybMQHTlJKn30G+dhG02Raa5?=
 =?us-ascii?Q?wwHDH7ql+ROtsQdBJMKeFHWm2jxS2nHdxtiMDtRhX7Drw56sixZdV8vaeZau?=
 =?us-ascii?Q?yrI52SPsqas2r0U9o1PYWhSLmSMB/BdNsXNFLIU/1fbfLVGt6m7zk/YjD7rk?=
 =?us-ascii?Q?oqyfiWQbHd/S0y+5M2It7Jk49JWhNYR3488ZDrU+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4643113b-924d-4028-ffe3-08dd9fa79fb3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:27:24.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtemQVqi/xir64QGGO5b11nWgSVdrXe5YdgjAAyOMrbIbVqbbtBtI4u5cJRn7omh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

On Tue, May 27, 2025 at 11:41:19AM -0700, Nicolin Chen wrote:
> On Mon, May 26, 2025 at 10:30:46AM -0300, Jason Gunthorpe wrote:
> > On Fri, May 16, 2025 at 01:56:26PM -0700, Nicolin Chen wrote:
> > 
> > > > You don't need to move this unless you are using inlines. Just use a
> > > > forward declaration.
> > > 
> > > Since we forward ucmd now, ictx is in the ucmd so we need this
> > > structure for:
> > > 
> > > -		if (!IS_ERR(ret))                                              \
> > > +		if (!IS_ERR(ret)) {                                            \
> > >  			ret->member.ops = viommu_ops;                          \
> > > +			ret->member.ictx = ucmd->ictx;                         \
> > > +		}                                                              \
> > 
> > De-inline more of that function probably..
> > 
> > Also seem my other remarks about not storing ictx so much..
> 
> I found that all other ictx pointers in vdev/hw_queue are unused,
> as the core simply gets an ictx from their viommu pointers. This
> means that only this viommu allocator here needs such a storing.
> 
> With that, how about a change like this v.s. inline:

So I think the other suggestion with init vs alloc supersedes this and
makes it all pretty clean?

Jason

