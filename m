Return-Path: <linux-kselftest+bounces-20979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF029B4EB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCBC1C20856
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A8194ACF;
	Tue, 29 Oct 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jtqmDzRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505F194A52;
	Tue, 29 Oct 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217536; cv=fail; b=AoANMttlJPIFMpul0v1dw7LVDag6cqKhtwtnbRaIb34hNWFrSDsvtExYL2GlFxcqNdazRdAIthjL2AyNQ0SbU4SyUave33ERCtL2+HJm5VrrddLkJlDrvQy4NRZdESqic80/w1BJ9iNAhkoH9kfnC1qezbRPeFi98Ke1hAlKu5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217536; c=relaxed/simple;
	bh=r6Fu5yKBXT63Fcb7NYjUqAd+QwtAr6QW2U2lihsEJbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yt4IOk+Jsx0t5LlnuF2BWYdnGkFRoHKQkpInrmZ+6dseFaeBU+d7h/r+uCC4Hzozj6kpzLfsiZ2Ghloez/Wbi28WEuTFW2OH+TfEtMTmjEpZ9zVcVFxLPmcayMOf4dBca84GCvqfwWKgGJZbeBeK0zr1hWYFXk3ThfoeINOELwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jtqmDzRA; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpKFFA29KGXEeCJxTxy6wyJgRFiV3JYMc13Ahu5Q+ZFXK23O564DIi1qdA90ku7SiKhv49XXueMUyI4Rs/wRqUD3bxPhRQAuipCEDiBYDJR+epkJSLbwnIyUqLdIXv/13T/W7XyrZvsA5x4WkROboivk0aBEk5PCo/4jc0OSTxGt353fc8GI4tmihsqFv36VJI8owQWb8T/YRzg/U9Ww2v9pENN07H80PudwcmpCtPU0m5fvZYpbGuP675AIKwcpxytrP4pXdsRl1ICAHIzXTgCAOt9S40898pgI5gzo1UMPO9m4u3isTBa4ev4X9unslQFZaucxzuC2Zc3QBCLKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiGUMT41f/uYXep9JZ5sbDyCD4uSQOXPE44GhMFxC+g=;
 b=E/AylgXLJnsJgcoOZDbtP+G6ISmtYb1hQVn/NAkw9wy2dHAhaRXlbcbI6mb0eWH/L0902FLWciMmhcUc2a+vgnQSzfXG9bGwb/o428JV2A1PW+o78adDSdZR6SD4yptR+qzpzGeWgydizg7qY9LwtT48EXD2QNJCCEh3Q3CAyz1JKkt6jBfI7jlZVSyDFgZk0atehxi3aGLFEcZn6j3bXvMlNlCAKYCbroCA+tXRjWHjdHptcA/8QUVoBRgEKi0IXpypvH9sUHfO3935+gY6ozAaxlw4yqOTsyHsY/+kqzbyo3v9Mtw9aMTpaNPwHliaKqx0I3sm6DKa/jhLt5eZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiGUMT41f/uYXep9JZ5sbDyCD4uSQOXPE44GhMFxC+g=;
 b=jtqmDzRAbNwkj4AamnifjE17eL8gGbT2hdlY+eR+qUMO9rRNyViTeAdKqdMUSHFvlPvjZuZEetcwrFf5SVN+DieNXy2iz12kkT7aE26fEZ0hb+S/JBmhNzZNgmdDV8eQ+hngZX583cqulDm3YtS8FzA4oJNmgSP2Prl9EQtz5e3WSalEH2btpS4S7+fKsXtY6tyb37HQ189CzrqVhIEc1pi7gXaqvhRo+rHZGrF6a9bF7G77dqVyfL+4qz2y0xHE7AyqcdL4I5jTEadn9vzDW47DJTr5eVZ/WQoCeIZezs5m5cUQFvcDIxyx5loZMDzNjWIUAORulnl7wo3R8UFJIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:58:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:58:48 +0000
Date: Tue, 29 Oct 2024 12:58:46 -0300
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
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 02/13] iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test
 coverage
Message-ID: <20241029155846.GK209124@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <fab524b7054fc38d71b6d7a46f90e1f97538d2eb.1729897278.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab524b7054fc38d71b6d7a46f90e1f97538d2eb.1729897278.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: a8663abb-7cb8-4158-10fa-08dcf83292f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvsRG8FmXFNRG2C+hNf0YHd6ezAZvDbY40yZ5YPYM8X74yED2DCecYzJLSMC?=
 =?us-ascii?Q?XgSNpOYErZvYSmEPJQDn0JEARghCEeR3eFk6DZ9XDjbbF8Ip2X7LEhj7N1cs?=
 =?us-ascii?Q?5zDibXftMhoJlPy7G8RO1zCIOO5NZG4JMpU5dSL1KozxH9bq4EmYs8ODktoV?=
 =?us-ascii?Q?5UeFH48FPD7nhIHLnkxnXbmYYnfR9TCcj1WzYL2eEAhUrmW3aI6HDv3NF0Zf?=
 =?us-ascii?Q?WQUqN7WjgqG/M5f8I3FiiKkw6skX7bW5ovcQGvIj9X60yZt72bQOeRfr/gh3?=
 =?us-ascii?Q?bUojroPFO/e68dCLBsfPuFXbN9sytPtDVPWOfkHfvLMTdeGA1G7st5HYh4Qx?=
 =?us-ascii?Q?IvbkLiRv8NdIU7j6aTx99Ml1IWcI10nzT05PaqwhKPeEKjxj3WmUxlwGGOIK?=
 =?us-ascii?Q?db7O4UzyDop9y9fAyCZO/NMSbNDrXiJwTF2TtRgzsnI3TI5pZkTdr+6DfQQ4?=
 =?us-ascii?Q?b74rnT4wMEfzBF8zICq3joSijgQ3Um9wpWD9GYNUeEj0lD2QSXvO+01KA9jU?=
 =?us-ascii?Q?b/kK8IOMwCNs8+/8T3JnybuszPiCE1igxmx32OQz3xYyFlZ0PAXUCPgD8QMJ?=
 =?us-ascii?Q?YliT88neHLizlj06uxI2b9lTilw8cwq3Z4mPdEz3G524hl7w9l4SsrzvMtpT?=
 =?us-ascii?Q?Aw/qgSIGyRcvmyhYmyBmcHOWLN3Nxz4HVEJ77PRd6xs1ek50mVRkcR2ZhaRa?=
 =?us-ascii?Q?nKe66ntytOebsalHE6Yrk0j1ojNNkVhiAyl2OFKV/qgW4tIPa6glZyDmTtVi?=
 =?us-ascii?Q?psdGecJoPSp+npPyK60Gexgg9M50e6O9mP5JslkXLyZp6OD1VuVvmVbOlRif?=
 =?us-ascii?Q?UYGmaR3veLtv+bSzHQe78OEFWir86TyomDi8k0eGCW/gvKStdEDnHHOsEan2?=
 =?us-ascii?Q?r/o+AvZ+9H4lAW0aeH4pHIj008DtNgnnwWAEGbrahqIyl9lPVSW0Aqmfk1kE?=
 =?us-ascii?Q?Spb1uFT0d0aakHEE3ehl94bIljsrILbbTlwYwPF1Ulyw8hidf2bqUluZLPKU?=
 =?us-ascii?Q?cVdxXwC8BvT9NaGMtFNoqA/yyg4o+j2DqTY3etlU4pgBqzSFginZq+Sa58lh?=
 =?us-ascii?Q?xDcGjE/weV5CSDrIOSm48rGdx5PI6QYlWdk9NBgtHFGOehVi7OakJkDES74x?=
 =?us-ascii?Q?567bJpngaWNDpeF8BnuyRf/B9tKJlEcLVO3GMpjffxhaC8T2EJfcl43CrNny?=
 =?us-ascii?Q?wQrcdiPgF4GI79Jipr4OiJNDQ4Z7Puddr/GcwUx5q/r+nPbQ/ALqe0E1QaFv?=
 =?us-ascii?Q?A62EH0NG+F6BMxjeh9qdJObApjef8/zxP+DSqRA0bFiuJuqVq6E9wHt594k3?=
 =?us-ascii?Q?S/hv28aE+Rb5DZOJt1Ogmcxm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yE40HulfggUYjjbNrb2OsGJP0AjAAavu/6peNAxIhG4r7a3u7cimFeQ8GBvb?=
 =?us-ascii?Q?UmChogjScOzaAhrvK/k/cBfZDHdgDeqaTkaWN+SbEBXdb+ePeHjqyX7NvURw?=
 =?us-ascii?Q?3LMmY/asS8WTW50LmE77N2O9SFQ61B8p5OvOVwQG+8u8D8Qb+GawQWMifR4i?=
 =?us-ascii?Q?D/8lm8KmFYMbCNKdv2FYt0wMaL7eS2bN2dGQEWG0Ag2tQAesYRxyrsBK5tiw?=
 =?us-ascii?Q?PUiG0J+9ACVAZseJmTbe1RD4wyxwbNwOToFct6ni6YYn7Dz1Sd+SdGtDOyZC?=
 =?us-ascii?Q?Qc6PufaUFGY+1X68oJqOC/ShoRoBeeVHwNS2wx3KalG/ZldGveljyhp0DeWD?=
 =?us-ascii?Q?uRfrS7HhaRRJyEJ/d4AX6lPCfM8htERr5w7wSZJ6GWLizz+/WsHc6lbUMdmv?=
 =?us-ascii?Q?2bgdFAh2vQOvR+pUrrpLv5bB4pSDhu0uAWlTirB+yXOsG30fz31L7br6usxm?=
 =?us-ascii?Q?q8/KBgrXwXvYQ8sQOpgmipOQ1EuGz7DSlTHemgHMvTshwC6XN0tl+LNcTL86?=
 =?us-ascii?Q?QGDtTJ8LnlfcnVaNT5bOxrQHxkvSfssw8YMwlIpOWobY2UCeTWRfLUMBOMtQ?=
 =?us-ascii?Q?oL/YqTpIvrsb1vuSWiRI+dLIudOxDJlm1LpjR2CL+UliQ01V3qXr4zemNx/e?=
 =?us-ascii?Q?zRvERwEN0uiy/9gQRuPpN99JrjaPX1hqfFCUDE1nT4OX0kR7SjfC7I5sP8pc?=
 =?us-ascii?Q?8Cr7CuZpAuKUN9rsX2ThlJ0EQnecQxGyDaB629HwQ0n+qBzAeJQ4eulz5zJt?=
 =?us-ascii?Q?+E5WkqmNjI++MVIZK36lporlJCS9722y8G102h9st6O5+/YdE+OZo/SngF/J?=
 =?us-ascii?Q?0xpmgBrP7wWPZ7LD7zPY2o07TF5/dcI4iQzqOWKdqa6ZEU2ESjFCmc7cgwMU?=
 =?us-ascii?Q?airvrmoyDILrk+vJ8psQXnAmGGNPbdsvL623ipwI1TCpNTSuuLQXhVxVGYkN?=
 =?us-ascii?Q?xbjj+Ms8y15Ice6nop6YWdHFzx9UZSu8eRZ6FatVtLuIDqOyV/m0rV1lzv37?=
 =?us-ascii?Q?/4bifVmgUHS0ovDspwZVI5jIKJQ1MUtcGJjrx1zRObROahLErRQTQ5ZHA/CP?=
 =?us-ascii?Q?zKNob1NDTg2rl6HkLHfuShND3pNCuIFOuwsOP6zBIrbWN2W9PK9QfSSVp4qW?=
 =?us-ascii?Q?CXmPr138x2nDk5sIkg6bTM7ll0+MQ0bIJ6iCwXx/COKxmmuQixvn24PoMZcw?=
 =?us-ascii?Q?UV0nA6GY4nUJxNnm620qWO6ALuussr3OPt6SeYYOG58XT+OFXQEMhPEd9QhW?=
 =?us-ascii?Q?joOMUCPnlcWcxWS6+neOoCTB4k0vdRdVa6Oar6or0kFqlSF2LnRwMEgoswC4?=
 =?us-ascii?Q?h8sieh5naB+hFw9+/lK1rY4DIFR+UivzW0HFPQysEid7ZV1YtSVpkJcT9iFO?=
 =?us-ascii?Q?oy+NdLNw6GlcuqXK+epfEn9ULoJ911R96ZyFmdEaFL9rjcFtqREdpt0iNH8i?=
 =?us-ascii?Q?lOnP8D58xXrWGKUmipO4FrzssMPX1eI4lutNc709ycVDxe9Gtc53MMVOWfLW?=
 =?us-ascii?Q?54SUJ/tIYzqPp9UCr+SQpgkIIZy9k3r43g/pz2JpCL4TWNc40gjw9Od8ye4B?=
 =?us-ascii?Q?8xzZjCby0jqMoZ6aolI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8663abb-7cb8-4158-10fa-08dcf83292f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:58:48.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dr5JUH8BdNKqaCfIJoa8sxRie1+qyXyBKzjvcbB8iKWVloMA64xHReMamWHC/LI2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

On Fri, Oct 25, 2024 at 04:50:31PM -0700, Nicolin Chen wrote:
> Add a vdevice_alloc op to the viommu mock_viommu_ops for the coverage of
> IOMMU_VIOMMU_TYPE_SELFTEST allocations. Then, add a vdevice_alloc TEST_F
> to cover the IOMMU_VDEVICE_ALLOC ioctl.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 27 +++++++++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 20 ++++++++++++++
>  .../selftests/iommu/iommufd_fail_nth.c        |  4 +++
>  3 files changed, 51 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

