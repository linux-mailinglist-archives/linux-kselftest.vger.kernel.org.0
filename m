Return-Path: <linux-kselftest+bounces-36841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC5AFEF04
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5601C42C0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102A220F29;
	Wed,  9 Jul 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLHGobru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2921C194;
	Wed,  9 Jul 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079662; cv=fail; b=BWEmhRQGKn41YZCs4S/Ic0+ODBOillaXEpCSJTPQ8ipOsnM6gsT22XMo+5hkA01BPh7qyZbxnDuHyLWCX3/aCMXfrGq95BSRFzQofyOsKvuqTlZQXmNULJZC7bMFhRCr2crR9FPyZAy8jiqya6tYqJPMWb6ZL/Wnd4hm1XKo9gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079662; c=relaxed/simple;
	bh=y2Qh6nuWI/4hcImieucNWqVO6e+geDH6oU9Q9i6KqT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cMtLmJvKQndRy8Hc6EQVlIJypvYT9IHrFPoa74A0ZcpixwyuYjhE7jYx84DQTABrjVxU9kHd9ncqk+RvP4DpDKHU/mtT6AsYjFM1zuaiEy6mWj8dEyhxZezZSXKn+T4ndcWlQ7dRQjfdeW5230lJ6B1Y5NNUnAev1cwfhA2YgtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLHGobru; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpjmvg5kcVVxbJrQgnz8OMxPYEL4ZosJcyHFq+nd/TgSpvDJlWzvxTnY5zqEM6ozasB4qOa1nlqOui3c46fmquMJCOxeC/PfhuoBntTjfJFhpM1flFlRUKCDW+9xXgcS43KrUXiv7GHqx3tfmtA2drHPEAjSN9v4rMjPWPjEebonl6y75MHxyzhTCzjaZF+r6mDDDO6X1tUZK16ksAH8glAl5nu6aKFMeLblRtPSEz8g1oMUp59OY+a0dNVa/4trdfjX9dv6nkbVITg4Dk1uuSIB2pyt65kWb2qvEHyeJROs0TJXj6a+HU5/K+vu0W+qoSJTKSuCtRpZYBWnLMRZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIwg46X23AvbKHPn4lfk3M1qqaWyaXutcPU1TpokyTk=;
 b=QQ8JVbc3Egvcxu8e2oehoyLRgmD2V7/D5FR7oB5vhxb/PgQGdB2KLfe0n0OggNe3DCekgbe34wQwLZKOlAJ9N/CvIB91PA0Us1uQBg+4Y9S6gioQ6+38QKAdmv11P4Bhwblq8vfYDnnGtBnz7cx/QvE97t1gIUbYhyPgXMfYqX6hogsXUjfLQ+h3t54IgRPsR43CnuhHKTDQDrm8q7NbCG5KvxfsBiNk06+fytqSOlrbj/SteSGNkyxFdK8ISgU+d4Z1NRT8G96xqA3hwLPI7p7Qb8prGM1q8k/5vlL4dR3F58Wkad5gO302V5IOvyCqBQINJ6dEgfd9gOEuEkLk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIwg46X23AvbKHPn4lfk3M1qqaWyaXutcPU1TpokyTk=;
 b=LLHGobruc7TPJ/PiYJODk76RrofYzGs4uc0DhfmmZf/xrLpQ9t89Rean16CIiBVsbbGScGm7EQPJts3HQV5qFTe4w+wqgOLzVUPs3oY1aUHjk83Evw3POymGTD/ep7cp4H4Pz+1A81MmP0NxP+dDAPrxSWSzBoWezj6vEprwqbjxO3quNVHtxxwxfAy0SLLe09GXCxyd7CNt+bh2D/HJBTdtIxoC8X2brYJ3zJ3UHWR0IKui2tZLajJ4DT9+M+1i/arQph1az7gx4y01RMI+sBvadqPbYSuvoVFS5blhkwB6Vz09rZ7h1rHun9Zpwej4kZpAxoFtZyus5/NrluM8Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 16:47:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:47:37 +0000
Date: Wed, 9 Jul 2025 13:47:34 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v8 04/29] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Message-ID: <20250709164734.GF1599700@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <64a4c22755d828a80a80d30f6903f4003b62ba5c.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a4c22755d828a80a80d30f6903f4003b62ba5c.1751677708.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: a18417e6-49e7-4792-1435-08ddbf084fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/x8d4o3SUlB667m+ZHNDl3MeQkgdZgh/kNF7n/it9uXXnJynAPu/OIn1A+o?=
 =?us-ascii?Q?1AEaPxjLe9AaiMbW0HVF6lYuKMQQBPyLA7tGktfLTMm3MHt8QlFAZAFf6dAo?=
 =?us-ascii?Q?+nWN/KNiatWJ7Ux9ZdIdmKPSXyVVHcWpUx85M88MdT+IWMS0Y7EDB9sQdH9I?=
 =?us-ascii?Q?5gzgN2FNmgZdn41XCWkaD+IU4ij+tpyCfkxYWU5yDcPgv74jneYn1qLarwFx?=
 =?us-ascii?Q?Kzq/Zwz0R53xq9JNClfruuuWRHli1pKGgpkvHvstAVoFV1GWHblquKZubIVx?=
 =?us-ascii?Q?Y98YJc7J9EvfsRTa5aPdtXoxvG5z5KOL7PWhMLurl+UHxXhi/ymn6HzIEStX?=
 =?us-ascii?Q?fnfUbVyiRTetr2H44nTy2uxJdUOHyTuXtK4pAqVsBHpVCVeoZs2sRhYgJRaA?=
 =?us-ascii?Q?E4f5XAwWCkBugzjOrBDiTd4Zhk8GHCvcIPAzVD7HPqVlAsRYMyyaAut4X5kt?=
 =?us-ascii?Q?YBY5R00lLmjQXXjWQkpzOFfy+SNy/hcv+vZGQTlGnPtupHEq9r2C/OE6JgyO?=
 =?us-ascii?Q?sxZEQxPAajeC+k9XAnyEFClCLFyJnPUXL+9z6vpa3fVhqUy4/4kOsOBAB/NP?=
 =?us-ascii?Q?k7B41345E/QWVPBlxwRJbO316iIVKy1SvEWePs7D8/jq3BGpd8jZQemYY6Iv?=
 =?us-ascii?Q?72d13dq2GSD7WP3z+XraZRD1gOXDjoyXooCt5HIdpu8Ox4CbiqM/eQdICsKV?=
 =?us-ascii?Q?89cAsa8u9wr6hnkUMt8bK6LWEtYVSZeeECAZg6d16iEB/rJV8Qpe9lwfEO/W?=
 =?us-ascii?Q?jAtO7hiEJEMdLMcoUTQjZjD1OshIEz2fRfcQTKnHULISXLHu5fTgv551E3SJ?=
 =?us-ascii?Q?pXauzsIXUbwW9+u5Mn2Lo6u2ffQpNTUx+A8jy89G/xDKXJZpOjH71j0Xmzd4?=
 =?us-ascii?Q?EADfBFPjnYccxNcUhALJqPmtvE8IKRESpRBRuJ2V7XIoEEO2PusMpWLZgVF5?=
 =?us-ascii?Q?Zn2NqvgvHpDjrw1qvMw26FSKqWDBf2OPOdKB3EJ+VJO22UWUWnjBSXXIsxY9?=
 =?us-ascii?Q?mvWOQkqcKSCSqv1xXDOliagSwpXiBon06zsAzZZ9lA4GpLaZ1YpOCpJZSyHQ?=
 =?us-ascii?Q?/i3G5i8/9Cg/pa7fe4QNcAUhmp2P/70VGLb8VEpZ8cbyvGQcfBWTBbYWJVFZ?=
 =?us-ascii?Q?RUky0onhxcG+fWjDrsgpzetbSWNmed+OpfKNgeMvCUfSrSE3iGt65D+HPgKv?=
 =?us-ascii?Q?deC5R49imJMIskyUgNwiYkqK4Ri/4DFE3KApwaL87Wfm74GhA1AOLnRTEotH?=
 =?us-ascii?Q?AD0Ze8j+0CytsgfH5vW5TgbAQEobHWC1MKjEAWo0YzvYIQdu6LjrX0luRmV3?=
 =?us-ascii?Q?PNVNpT0jU2nLAO9JahuW7qJMV0AAb4VUIikTCxmYGdb1loYzF6H1VMV+AK/F?=
 =?us-ascii?Q?DZLyOl95OIk/d3hfxPGPNA3ew55OmmeVYR7dVgxofmJGhRl3aeBZ8JNjQD+R?=
 =?us-ascii?Q?R1rs6EXz/gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRVLufN8+yo44QfezqTnhc+Q0NWdMdaIIcw4i8QqrKmZ5OigQEpLjLGozVlq?=
 =?us-ascii?Q?PbT94wboRFnklFZVUFDb5wc3N6odcabDvtnZX+0ECSjj5qO3VwZMn18WgUP4?=
 =?us-ascii?Q?G65o9GHrJ+umTqPNWzfTdz2WgscEXElGOHQ8eZsEVlKlrxIdeVhQmX4JyvCC?=
 =?us-ascii?Q?I7yuNHVLrivNF1j3rZe1Gh6NUM/+LiJ9X3KmM5LY9D/s7WWo/8BlYOVwPrnE?=
 =?us-ascii?Q?AFvShvNBTWx9/uwSVTyGylf8H8XhC83+B56sb2QKqWqBY2cbbQIHGwuTXamJ?=
 =?us-ascii?Q?bwmrIKt0zRbvPS3uB9kG/JVz8PlUKnLMMuUhASy9rgNaWK6sGMmtMnOzm/sa?=
 =?us-ascii?Q?7HGtJ7sdtpTx8y+HQf7OICpRVq3puQb8BPbuLJpO+zGRotWGke+KURT4QNmD?=
 =?us-ascii?Q?ngyEPipTfAi/VuPxCINYSzWYL5bXADuPqBW3lLxo6wF6w/m6c3MKicOWPT7l?=
 =?us-ascii?Q?ukQwGP84Fmvk7CsxuYDPXU2+ORzxKAfvKj2hQadvoiOboB6keZBGP1j4WpED?=
 =?us-ascii?Q?cVadF5Q167jOF8QvNvPRrVgXs5/KxnEhmezLQ+2Zptp4l4fdvx6R2Vxjp3Ue?=
 =?us-ascii?Q?YdItIbWKJRxtypiCv3Ui3TNwWCCNMxN8SPJwRpifis9m61ezQvNhiq67z0X3?=
 =?us-ascii?Q?4728PKtFn2LHYEPsISUEzLSmHHwn7atpOeaE5kUYml56189oJHDW86llbZEm?=
 =?us-ascii?Q?NRYSp76CEfICpbNu+FeJ4sQKZht8quWZWQEG+8A0zxU3NBY+L4gmISuWkvtS?=
 =?us-ascii?Q?hixWW6lD+4/QqpQQsQ3aeVf03YEynzm7p4dr3ytM2WboIhGiceS1nsOH6fzw?=
 =?us-ascii?Q?pQh/BST5hjihXnejFMG/DqaXGWkxM9ZhhoHel+QHT2LoxMIgMl3KTdTitwGG?=
 =?us-ascii?Q?a2pw+TrUo0Fb5BMFdtdR6DhVAlSXZQO67FW9brzIudd0bWd6YUi29KGAHgVH?=
 =?us-ascii?Q?awc86OPbB87dmy4wkHRZTipWBTAyC5I1ybl65PhpCuHQkgRhchomqEWX6RP1?=
 =?us-ascii?Q?BAqKx9G4q316EL7VBaYILeqKF3b1Cwu0O3U3Cm7gBfYtQ6/mIBrYF9gidjmW?=
 =?us-ascii?Q?v82RDIv+crtOdEx2XMPoZubK2qtFkQ1oNAieIUWRTzG58Ua2ZYZlUvuUIO/C?=
 =?us-ascii?Q?VjCpek28RZYIRCKWwUy6sANgJRT04eedsfxzFy246f3YoC43Gus8Eb5zOfXr?=
 =?us-ascii?Q?3GxZmzbMoOLvOWqQwzt71OxJLex6BcFoNJATEV5MoW+l2P1l2uvz7M4WbvjJ?=
 =?us-ascii?Q?Rz36GwXdHSbeVjjHuwVDw9eM6cUge1WV5Z80KKoAvpdcFUshIjX0YTQIB/Sg?=
 =?us-ascii?Q?xzI3HukJbecr+wgX2vA8AojD+ZY2BY9DVb5PgiHCkYDq2I7MoIk7Ig7cA5N6?=
 =?us-ascii?Q?5sbLO66uCQVLx6rI6HYLWlF8UyiyR62WqYSurI7LsKJ7HqVfsQMZQ+kqBqw5?=
 =?us-ascii?Q?dCPl6poI/MBePqF+wG11ql2nPxicIQevlFmzx+DW5vlS32VvMvD7+oyZQBIb?=
 =?us-ascii?Q?CKz6xgm3VqGiqFiBKKMnuwAADuocBHdEYwYYcykHf1NToQO4mINUA9P3Q57f?=
 =?us-ascii?Q?TAxlT+PjccQ12rwajDruO5n6ay02tf8xQNaJSM2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18417e6-49e7-4792-1435-08ddbf084fae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:47:37.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVpxlnz2+BVcXjPWQgSozigN+PfnBBLxb0ooWEJzr1NfgXRzy3Zz2oHNh4Nvvdh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

On Fri, Jul 04, 2025 at 06:13:20PM -0700, Nicolin Chen wrote:
> Replace u32 to make it clear. No functional changes.
> 
> Also simplify the kdoc since the type itself is clear enough.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/intel/iommu.c                         | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 3 ++-
>  4 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

