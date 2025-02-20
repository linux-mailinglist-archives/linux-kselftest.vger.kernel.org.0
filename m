Return-Path: <linux-kselftest+bounces-27097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C09A3E320
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7247A3AE142
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493A213E7F;
	Thu, 20 Feb 2025 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MEQejQ7F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD232139B0;
	Thu, 20 Feb 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073865; cv=fail; b=nAMqGbHLQu9yfN4uA5iPGoDFHDPZ6Dca0fgK8Bs4dT+PaGw6hgxIjA7U3e7YSKPjyRyu3b1+CmfAhsLE4cZCx9k4wXT5GWkStwDui4VlGxU2hHkNFfa7XErUjl0CgTCZcx6MQ9hYG33LAcFZTtsd25fOp8AmIkX4bWW2n7RqVck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073865; c=relaxed/simple;
	bh=VVI9BWOS0aRF9OxkaMyNbAPK6lEqXSVVvkTYihN9xZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZZceC4z7uboSqZfLfpnhLJIyLC/sR093DybstQBgzEyZX0XKK6eGwLx4NlqIpwhFnk85sVOWO/g5JjyXIH1DjoiJM7cLBzs482JkJ/DhuYVtCsltGpQmOFIoG0/WjbeuOsV898Onurq9DQzqUnKECUhlAcJrfGebYRb0Lyn9jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MEQejQ7F; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXVYPruzudGNzTsn7pE47H22xyeQ+xUY6O7g8ctQSwr4luuv8OaKEhSULfOVe3PC6UJAH3JoTn5WtVeJhH5qwj6PWmFsk901YntnabxNsN6ybLiS8YjN92d5Qvs55KfqMO6r/nBPJdEuAxSclYW2/2DyQRz1+VjdsgrXjHWuAPI+/Dd1PxLixFPY3kg/aVwx/rbxPn9kGhsiIoawG8MKIm4Tfm4mbGgQAMGy2QTQJuGJSLKKmg2fo8LPXjARis6UhqreQ4/PRf4gKxnoEaXuL8leSwGHeQKPVFA4YXnjb7z0YjxbSTxl9jCWB9L8cf766VwX5QTnRHbs0AiQ55d8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQNq0bU12UNpf9Vxt2SWKQ7bKcynJcK+7Y1yKWPlc34=;
 b=NtQBdYpG/NOfG358PRQQgGTo/cWnINr0kkq6xAGbNgTN5p4+7NXDNCGc+dqjnA/hWSI0TXO844OrewWXNyqSJQKvNfyXnkb0H5h875lptiIbvqxTDhbQqjDQbG7tweES2Toz3eM0qPz3PXU+q8nhLR1D1S5+EXYbZoeFxjn8W9rIcMYY2npgcD8PMFacSQ/49hc9yIjux1I0B/TNxqMho2rtPea5sqjUtsDbu0HcCVkPrJNSBHTJeAPy8BiWD1D1z92YTPOVM8DHVs5nncohizdAhrXxPO3Uo4fhrUMtAEvkbZASihjd4wf8klbGPRPTDKekjexfACNgltPhyFolPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQNq0bU12UNpf9Vxt2SWKQ7bKcynJcK+7Y1yKWPlc34=;
 b=MEQejQ7FBilzuixjDiNcO5yL8fh4iHrawrVuSDvPa520HN4tVYVcTMQw628tQhCNwKA8SYMGDUeJmJTv21cxuG9pcOhlbnS/MTXngglY9tWtcfUwX1s3+CJy4eM++DVfi+gb+G2IDFHtcjcCe4Cq4U2jaOxrDd9uqEUwK/CCGcFrCJcjXNr/Vm33zOh6M6U9f5g7SPdy1Y3jD9K1tIZjSDfw8/vghu2RGZ5RJ6jYF1mLNmeKpVDYUvMeCmh1WeMnTAjoZsFtdKiZ+iARFSjDhISBc+Y4re48yrAjigUMB6P1Yg5w21DgaCRmDZZHKaR3JLejiRpqofTu7QK8dotEYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 17:50:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 17:50:57 +0000
Date: Thu, 20 Feb 2025 13:50:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250220175055.GG50639@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:408:f8::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b48e736-088a-4d28-bf8f-08dd51d720e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bL052qY1ML6Y61n7sdFBx9sVkPBPt3mwlf2qXfM4ph68TAQy8RTkTMXteoGU?=
 =?us-ascii?Q?Po4HhS4DgsbtBIt6cySYVqnBABPHVICw7JBzXrr+y5s58WdkTaTdsgA3TTW7?=
 =?us-ascii?Q?OU+C/uC7wdZvD11vB3IfQhvEDVxLBTncxQG3ChhCoEn42T6Fo+IRHkwuhRRx?=
 =?us-ascii?Q?R+cVuc/6HJuksODUyP5O7YTApe26Ym5fxMj3i+Nui2iwAmEdsDXUTr5ONpab?=
 =?us-ascii?Q?8Nw1IjTOplXXoAXS5/mSjE1Q+VFL8KmFt4h0TsdDtRMO0G53nrx4A1M1dXgV?=
 =?us-ascii?Q?aWIolr7xHAv8AklTwTaaDhy7FtSFfrGc2TFgB/BvLl3LgvDKL6fYXKgRVVrb?=
 =?us-ascii?Q?UtYlW04kN0PeD+cJBPgewXbGQkko8n3bvM2PF/azjSmcU0nLSRUsos29oZto?=
 =?us-ascii?Q?itAvfe6SOsTy4kO8S563LQa2jp+WeK0AE49hl+As8OtO2E1gUeUTGoMjk9Rp?=
 =?us-ascii?Q?mU1HKQj2ozIubvucguul5KenVHb9QQmA2N0P/OCv68SuLEIWmwK+7KFUQNRC?=
 =?us-ascii?Q?NgQ6db5YJx3VEZp7SbyY6hIY5EUnX7XUHf81iJCBbVHLhf+4kXuenTOR+j/o?=
 =?us-ascii?Q?cQSGfLmRIxs4WmTj4/reh4dJEisSQ6ioxxMuNJ477veduziafSgQVa9wZGAm?=
 =?us-ascii?Q?W6JGp5ArfWiCwlzk7NyfUm3t0pM9bdM/yp+tdph3232gL65pJv+AraoPnhLf?=
 =?us-ascii?Q?fDwWtvOGSCOssvaEBbrM/HAnqQweYqvbvqH40fIUml3FkYYAQftidit29v0r?=
 =?us-ascii?Q?itIPv967RRZX0/EMVxIJKSQI9JazJGBCHWh1FO97CJIF+M2sxSeWzaoUA12L?=
 =?us-ascii?Q?L/g04jp+quRxJFUhdfYBsiCOV4u2XDGwHrK24HTYs3EfJ6q4/VwswfYCZU7p?=
 =?us-ascii?Q?jdTJiqtxvAvmHH6jnqoIIKTnaAiNBWpmnlnjRf+w9r+sxgVhcB7ey9ZRn9HX?=
 =?us-ascii?Q?QWBYjfwYcerK2QQhzTRJt0SY/RC84Kg1DjW2HFunI2K5IMrnyhYy4jKNBG1L?=
 =?us-ascii?Q?X226+83BrG+uf9E9/aAh7hJsg2OqRliN5sZC88CTEG+LMOmkzKsjABvwhcOW?=
 =?us-ascii?Q?7W2shlHp6DZX73yiZF4ySO4CWfViwHYHKjWktnvkJxvCXpxB1INuXQJOqPFx?=
 =?us-ascii?Q?2ximxk+eqVvQ810a959iKd65P+D+J2bmbed9sGU1xsNp5jEen2ZQovBJlo+C?=
 =?us-ascii?Q?ex2pd2RlviP/Ng7qc1q8BbV2gf9vUhSIX/UUWXT/CpVV/+EXoIv9GQD3bpwm?=
 =?us-ascii?Q?qC/zbdQqzY2qwqI9m8J4XK+UklwynxLV4J0czlo0c56QLxIJf6jgObJVWmFh?=
 =?us-ascii?Q?jVsFZNYbTMpABifNCkZe0CAoa1kKZe0iqytY3fchxY9n/Yqq/HtBC0DGCioU?=
 =?us-ascii?Q?MXL71jRD6mLKNYQFGXd6o89Q7nwG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d9noDZ804uJN+3mABFA6Tj/COsb/VdxYQc725c9lfXAlrzyZ+4D5ft75nwNH?=
 =?us-ascii?Q?QbrmMzYJs8OCk48Lz6NQqucgaL+voxjidI/ncKwRgPm0pQ3syGgYUuvulFVI?=
 =?us-ascii?Q?1zaWC7E/H+uPqZEPDwofTsvhTqLjBl+HEX4RL5YBDnWQtYG5++A/T+HMOJou?=
 =?us-ascii?Q?Qsj3IQP53hVLa8fXhwZNDg6wrVVGJPBInRV1irNdrb15jjsOAEwYQzlAQfvF?=
 =?us-ascii?Q?c+zVjTAFAEEvpjBFQRp+O+pzAD/wIqVqdLz9XZUmJ8HLg9LV7IPJmy64ZyGF?=
 =?us-ascii?Q?htwHzOgArQYkGfseicd/XwYpWpz1dOD4LCmEvDRgtWTAVZu/xjm5yGaUgtrZ?=
 =?us-ascii?Q?cC8R/Pxkbvz/VLDj6alyUL6sqO6mJF8XvwQmY+cDJ/ENK74OhE8WvFhdwP8l?=
 =?us-ascii?Q?R9OwjtPiaXpMICswx9e3xmEtkgYS5BTJBvP8kTrgyoQauRPhWm5Pt8B0sLd9?=
 =?us-ascii?Q?plX4IOz9Bkn8nx6jQUz5Vq2WUo4gfxQchAwwCXkAFHGCU21yLjNpyvmbjCt/?=
 =?us-ascii?Q?BixszC1ktHhcIEgcBGJbmamaUyfOoHbXqS/FpDNB/XopFAu5xDSvAN1pqvGR?=
 =?us-ascii?Q?X0+fxdZdy/TuY96HV7rJNv1vBpJqo8PN9+g5JoGZNW/afOI2VYUXj/bfAz2Q?=
 =?us-ascii?Q?z5Xg5k3UY3xmp73AVu6Ywj5dQ/v8OccK5F2XOG3HDDPg6lOCwZqZ2cet/tyk?=
 =?us-ascii?Q?/4xMoQ8agJjnOhC4tEnw58LGpkd+Yoj54GKlM1oNF8rEMcBy7tGLQ6bM9DEm?=
 =?us-ascii?Q?5kgyw+5+w1wkZFfYBJHgygRjXRsrL/Upvkgs6HeZ8/GLU2whgBWvgyxDpHDF?=
 =?us-ascii?Q?oD+fm5NVrywV+x/2ZOcJwhooMA41uYAg6ZfvFUW97tQGkw5yU9/kEjl7sXcB?=
 =?us-ascii?Q?JNfB9hHTox8Igfv0Jm8Pn4icgZRJddSymP/aBljg96HN/pHe4rdtJ+bqyUbH?=
 =?us-ascii?Q?MSJ81lM64yBSggsbUB2N+KLkDwWNrMGGx5MT9RyKAxS2kgNLh28fkZ8/s36B?=
 =?us-ascii?Q?+a3gNC0/l9qDzKFnZwVf7ms0yi51R1xMgOhuNElkXXUE1uo1b45TZRkFrQz3?=
 =?us-ascii?Q?1VJVGh33Cqcw47uOvlh9QGJoOeL7pKDmSa2ta3jrEGvxoJauXtZfVp1iqFnF?=
 =?us-ascii?Q?2KrdutILkCYOepkPjMhnyc+jCjTxabVp6xdig9xkgRwhrWi5b4A+9OjsXC8r?=
 =?us-ascii?Q?tueDrMgqfvR2yYwOaYZC58G4E1SltC24mi33gw1/III0d0fcao8FUBS0F52S?=
 =?us-ascii?Q?IIyC5xBTZdEKp6JTlVl//Y3YE6HTK/76EqWOoIXUY6nAFROgfcWsvK0pC9Py?=
 =?us-ascii?Q?NYl+du/kzE0puZ3ByX9AJcsKgZV0Df1natkRKZCeqJntOsDTxMgD+ITO9pVk?=
 =?us-ascii?Q?HVY/jQFwgrO5IjMygWEdZhCXKbhqTif2pYkNCo0PpEKEslZ+34a6MLBodRs8?=
 =?us-ascii?Q?qhpOkwFayH/Jn7bZj+e0ME48Y0Sd8jKGmoauq7/GEQNaKl0zqJv/W6OIYAV6?=
 =?us-ascii?Q?aFHhjs256jJDktGXJutccIBWkJEu2g1UtaOrV06prTJDju2CeE6bxTS8eRct?=
 =?us-ascii?Q?rf5OuWDkTlDJi0S/OEkk7K2E2wpGlmx/9i4U9zor?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b48e736-088a-4d28-bf8f-08dd51d720e1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:50:57.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCfsM1lw6wP+efsyMJwI1+irGmCMnxuok6kg28aG2x3uo71NNf4jEgTJhjZMmKWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

On Wed, Feb 19, 2025 at 05:31:42PM -0800, Nicolin Chen wrote:
> Now that iommufd does not rely on dma-iommu.c for any purpose. We can
> combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
> union. This union is effectively 'owner data' and can be used by the
> entity that allocated the domain. Note that legacy vfio type1 flows
> continue to use dma-iommu.c for sw_msi and still need iova_cookie.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

