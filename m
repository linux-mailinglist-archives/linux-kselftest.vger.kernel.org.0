Return-Path: <linux-kselftest+bounces-20024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF969A2C64
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9D5B25023
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94457209667;
	Thu, 17 Oct 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwXsxAis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF962076A5;
	Thu, 17 Oct 2024 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190764; cv=fail; b=f8Kolvwt7x0qT4oZs9B7TQBqDZn1adTUVC4O7prBabGuV089WBZ9lr9ADfC3iwHl1gcdhRFocFkzIVtsfJng3Hlg6IjA1epvxtSUoVyOHU6UPmf5D6ulS6+OhIZPdbC4lgCyoekOR/e6XiYOTUdYQYD0QwH2k9IVf16fkX8bZXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190764; c=relaxed/simple;
	bh=6xmLBgHE0HFo0JA266o+girMjiPpT3B0VoEjzkvhKcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQSsnf6hPPCxjrdVzt1XLZ6BqIh0kZk6Z7+S5JeHEOzqzoN2eOy56ykuOKGf8CwFFKgUUjX6tm40MHqFCNQnsxL2lKjubNerUcs82TqmYmgEraB9HxiUaXzUQQSbHMeu7erstY7QDKZSdzcZDwn5HGmrkUl7HAgWy6E0Xg8Osos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwXsxAis; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi8Qz0L01VHV4dM11SEc3Y5Ro7FNk9FhHM/tDH1RI69ZYUfDrPPsbUIBNtAN+x8P7EfHZNKemCfpVYtW/bhvNYTrQzFanCP1ssIs6P0wgA2lmZPgf6Bsd3h0D1OtnMrKTgHHiGpsb62vy9fNYdfk/LVRkOmf56ocCfhfOGuXTOrsArn5+tTkK7/AqivIRiIEC7pN2+a1ZFtEGpE3KDGWZc7vPZNQ3Cs29IbQQqa1JQgV5Bf2JzLUpwQOTI4NMQ6ltyFXWSoQWcX6CzSaFHv1QXxooPQ66LERtUBEDMoUSVPRfB7eKKHKfU1EYptIujtn4Ia5bhrW3ewJsfWJW77s8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kapkdpSQEeO5UeEcbzLNMK76KFIvoxgAhCuNypjH1KU=;
 b=kfJUCZs2tekq91mcbc7O6HxPJYof7Tx7thn6hnbGMkdmhRZdTJTmOxhehm2bd/8Py3WSEnYirloXr01DG/waKOo5/2pmlEk5s4u/8BC0sJUl6lvFLmYmCF4QbtzbY+QxDlLyb8DixipUooBkmIawFdksuU02rjt87GlGY46XheXDsg0cQaYzow6x4lGyGxHbcxs+I9bkFiSX5aZcdaXM/wJJDH+vTNmiC/foFkr0pczSMkKJKMP44OrnrrywC+s9eyHbr/mCnXgWtea6rKGAsAevRR4huUGSTNBzxuSLJrJlq5BLJ0m+wqj90n0UGOj9XUV/hxs3UnFFi03g0usGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kapkdpSQEeO5UeEcbzLNMK76KFIvoxgAhCuNypjH1KU=;
 b=lwXsxAisxhuqtmrLM6o5o7UsNiPhBNeqKmEUga3iW+0ZCD9JtELhbbEtt1GCMTJK4V2Nu0O9AB86C71Krh7afG80hYnRvxr4Oh8SFfqlaDS6pxl/xosqMPo0JTJkidNkaFhebYzbLoRz3X3gJvUKDL06panbgS0O/Pqfaih4WNZWvCC9BKVl68Tc+75PeTLSZY1aLDcw0kDK6fyiwCc3ChcphKOqKFG+lmAFP9LRYlmkpoffXMt5gyZmeU+xs9Bava33Jf+6M9/PpZ8CAhN2jQEVssJpel1ff72D81OQiUzCIWYAFj3MRiMeMV4LZQnf7JSnTkoUT4UCFJdDwJQVgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 18:45:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:45:57 +0000
Date: Thu, 17 Oct 2024 15:45:56 -0300
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
Subject: Re: [PATCH v3 01/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE
 and its related struct
Message-ID: <20241017184556.GQ3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556347d2e69e8b236ec946a93132181385344d4f.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:408:eb::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: f76e7c5d-cf30-4935-7739-08dceedbf044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQsWryAC+m0GSdaMVLawNAVgAPSCoRgMKBBUsHj9U/4+peoK36dxi7dqhwb4?=
 =?us-ascii?Q?t6DOFzu7I1bd/IEKfYR9Oxj3eBh1IjJBAH4d9cW90W1n4x21SRtX/VjO5UdS?=
 =?us-ascii?Q?hSXLLZSTM4cpmhcil3gw4PZBVHjxfXUNR3FUFhk9gCgH53DrGB7x48d1jJa5?=
 =?us-ascii?Q?lGUHNYwTneMPtF/YTzcatjSv7RiE5Wp9A5/dl+JwbLSFTeKrHrdOpIFHLi71?=
 =?us-ascii?Q?Od6Z/e2M3L34xbqKiJ2zurCZn1vZqHr/SomvRzdODnEsYjgRzut2WN1tCr/g?=
 =?us-ascii?Q?aRXmvP9pUDIcXpkgrw/KdmbHngduci9xC6+QyUWZpQ7bOQC28uF6Joo4baCJ?=
 =?us-ascii?Q?L1zpifNhHuXw9BPp414+CkLpokYV4y00jyHPBOyrpQXuQ9ABpUvgKoAz7Fn1?=
 =?us-ascii?Q?/VfkspOV5EkRRbqIwp4LPpzsqmBm+pWWz84sUWog9u7AP1VWCviuKm7bdBB8?=
 =?us-ascii?Q?C7TT1IkfvvdIRi9pb2qHdJXcRvaqfl9ZUlYNI0VvOBETN+x3KAc7NADQ8Sg3?=
 =?us-ascii?Q?K1Wglelwo0OdPVyWjxjO0x8DhuV9lwT77JnmHKq33bdQRnrBKNcw/Vk0fUhY?=
 =?us-ascii?Q?wmtrJKLzr9ivLA7Ld0CcnACYEFYqA4gA/5cYTxV6xUHd9Gz49ci3uqgEoygu?=
 =?us-ascii?Q?wKVFw75+ROX1D2hQLpjINuZaBMEdNA7YsihG7bP2k5qojsMAusnWJvb92gEg?=
 =?us-ascii?Q?BE7dEJyAlmHOdsM9VOOb0KRqklrvZrwttffN9TpIV3GeQhsqxjggXDNkXm2Y?=
 =?us-ascii?Q?jqF+5stgsP6fAgxEJijSlUy4en7nJe3SMc9uoZjNTOGmvCI5KxXvbmyAzEci?=
 =?us-ascii?Q?ZQeIvgKoAORel5+o9nnn3joGCpnwrjHce+AaDVs0Zb2AISKt90ZLZYYhvU67?=
 =?us-ascii?Q?JJnK2Dc9MznW+OqOpEAfjIDOvg4WRPx4Zw8r1DHYa5ajreKhLGPrlUSiak8N?=
 =?us-ascii?Q?jO6/Pz1LcWzdTF9IrCUdBvt+Q2ABh7qbsZCkS9u7djma6xUYWXOulqEbeCrO?=
 =?us-ascii?Q?fWpWjd93rox/W06NXUaPyspOuCBhr7+5kcxydXWyOxMZEDVKoL02La22WJRf?=
 =?us-ascii?Q?8+lBvhbBVv39pSNc+7mJNSNqFvHQsrM8p/B0kK25mSAV9ry5GziZBXoCstg1?=
 =?us-ascii?Q?UX6twwVe2HGJQ7EuNyRXQtLPQUoog+wRkUn5vOMA/00n0f6TuJDC635CFqE2?=
 =?us-ascii?Q?7I+8U1UEPFiGsOJgVr8wNtUjdIYffXZii11xG12wt0uud05l9dFYZkeKxdCJ?=
 =?us-ascii?Q?Uflp1jL4QCFIC9n9FOL3bZ8TK5JZTJpyBOZAWxalA3GMRV7loSdmF+at3LLX?=
 =?us-ascii?Q?/SX4DB4newuUNRl38rxRR0jS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNBR4Zfgj58dhCH2p06Gypymh88MWUaRHNd/FwwXqXfQi6+6P14tSdFH3sZq?=
 =?us-ascii?Q?dhAE3qab5FEYUDHboxJhYjZVRnDNkOdnCyJ/UdReFpoXTkLPDIm6HFDpqHBM?=
 =?us-ascii?Q?yJ8j3Co24qH7SWtiG7aE9uossmjfwg2+hNAA/1/LhJ10fiyJEmt3XolhYXhu?=
 =?us-ascii?Q?quN6rJZyNYbyqp1bWGIpKldVOP/eJlWhCtgqx/mXon1Zdf0UMlSrS8Pf+zws?=
 =?us-ascii?Q?3vWs4gj3G3o/qKMzgYeEHSA95dqcY7V40dqI4sJI6RUKI+O7Z+bAxBgouSgl?=
 =?us-ascii?Q?xLT7IN+yUl4heQPKdj+lUrBpDiQ32QlWlDkElWI0LbnSn66ROOMZCR35ZKO9?=
 =?us-ascii?Q?6fAgTkLDUjuUlL2J7fRNMJSDv7CPnR5z45uElo40dg9/n7A0BYu/+i+n9ylF?=
 =?us-ascii?Q?H4dYz4nklW4F4spMUgzZD23+IzIuC4cWaOZmV3+Dxhz8v2QVvJ1gP9z/bYFc?=
 =?us-ascii?Q?Fq4U0/G6+36E3hsWghs++kUrGn9a4YsxGTHpPxYV88RzQZ75k1z/k+w6nXMf?=
 =?us-ascii?Q?VhD356QhdUhBMqL4Ihrhb2k+3jRpXhrEMmoMqUWQimrFnWdiuxKVUQyv3x8l?=
 =?us-ascii?Q?jc+grk6/pGxNuuu1TmHBVoLB7qJ8dvAnfJ32pXcZfuVJygWno++hJIiMvrVk?=
 =?us-ascii?Q?hcAtMqHxXVLavMlwD36sZMzAjUa4Pd2HqmQsAoZBLA9PKt4ugoM2VeWh1Bik?=
 =?us-ascii?Q?j+oCm9mDZbGrapYo5h7Rr6/z/KZprEfIif2J90ZRHZdw2PwpFl7cVzmEG3TJ?=
 =?us-ascii?Q?HfrvhN2Q+/tuBOO8Ejz8RP7sxMQN+1rfR4vkpisoYa7JgzXW3BbNU3P9D8D+?=
 =?us-ascii?Q?ChtudJRepIfUaMObZAn+wxKeO/llYyx7RL+ICBjNZXJFa06pmbNXD0Oq/26b?=
 =?us-ascii?Q?6T4X94YcZSxQ6m2uPZQFDCe2alU/xSqipv8eLu+y8F8JJBs/DND3cjMMj5Yq?=
 =?us-ascii?Q?VOUTIeaIqGVF8qRfGnU3X2OzCfOquMtXdNGzEV2i1wjuyKGIh+cPr/3mbSzD?=
 =?us-ascii?Q?BAAFyfuIb1lmG3cf4h6UPf4kyQgJi51D3ySXGiI41T04lEhO3M67HgxMG4Nw?=
 =?us-ascii?Q?tgp3lCFyYLNanDSNStsglJmH1/bJPJOYxPv1/Lb3h/DgA0k4PRFnRxwA0KNL?=
 =?us-ascii?Q?Heds4KU9LLD42lbS4L6PJ2CmhQXErOOHBB02vhitzC8VPC5+++l+URPLWuPS?=
 =?us-ascii?Q?Yzs0zYBcfbKfThtnH7tbROb2k/PUk2IiXPyXIJ64JjSlwy0w4GjznM6r8Ckg?=
 =?us-ascii?Q?m2LGtv6flFUem4JJwRV8mM0CS9rO48eeHtSCS4yOayZ9QXLAJuDyKa5KK5Oq?=
 =?us-ascii?Q?+gPtS99r0irpz/ovJChDYCvU0cweAaZpb8R5Zf12V+H4b5hB/rLvQgoR4QCL?=
 =?us-ascii?Q?FgKhCULiw41FVuRLUCd237zsY9UYn8U9wuh7ISdxXwH435csDKwFZADOuCRJ?=
 =?us-ascii?Q?aFNy9tUFpCpxelal3qxEp1cMI3YIdm9WAsOv0BDkykEYyHaSdSuRZxz4E5VJ?=
 =?us-ascii?Q?BIkcPvbYLysG6TzW7v4UCev4ZtOGMqcUTaVYXtcM/hcI340SVtYryYCK+Nxs?=
 =?us-ascii?Q?RYKhDmLiuLDy67Ee/VI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76e7c5d-cf30-4935-7739-08dceedbf044
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:45:57.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unfxwlPQiMqI5U/SvoLP5Dt7iQUCqaUwoGoH4tPWgo9A63HcMXfn6I9VSxqYkZIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

> +struct iommufd_vdevice *
> +__iommufd_vdevice_alloc(struct iommufd_ctx *ictx, size_t size)
> +{
> +	struct iommufd_object *obj;
> +
> +	if (WARN_ON(size < sizeof(struct iommufd_vdevice)))
> +		return ERR_PTR(-EINVAL);
> +	obj = iommufd_object_alloc_elm(ictx, size, IOMMUFD_OBJ_VDEVICE);
> +	if (IS_ERR(obj))
> +		return ERR_CAST(obj);
> +	return container_of(obj, struct iommufd_vdevice, obj);
> +}

Like for the viommu this can all just be folded into the #define

Jason

