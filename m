Return-Path: <linux-kselftest+bounces-20964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DC69B4C7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A881C21654
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8918FC9D;
	Tue, 29 Oct 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EAq+7WXU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5E31A89;
	Tue, 29 Oct 2024 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213357; cv=fail; b=ZhJkQxFBYHp7Vw6L+i9IJGXbKwRihGOvv/uLx4CL7WQ0njxVvE08ubSAcnEA6aAXj0LXaYGHsgn5wnPIXGuZjzFElLcCcArUUH2WuKaEs6UAD5tpGmO8O4ssNOvxxULWAOddCyYnV0Pm5AKILDAdzXVukFiCaQDad0+B+Zw1rxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213357; c=relaxed/simple;
	bh=oJSqrhiKYI0KKAppWC4wfQsfWiQFd8AMC4y3okMGifc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JzV7+e/pEKFGG9itBFtcUUbpFPRvlohYsRKH1Wh3fqDuilXtiHJZurVBcRX0wGf2MqOuDNn/q6wq1sKNBW8SGQ6kQ56VZzGEUHVFhWd4c4LXPfOxGyNCYS66yVm8EIGjT/n/Wk8/aBpUjHUzVAi6w95cpy0FUPmefEM4qcjb980=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EAq+7WXU; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PALF8yJmF7wiPf176HYadr3C8rQjyoABsgw2Z5Nc3pB3FI+VBG2XUHFay5gfgmWoiiO4w1u+NCs6UC8wRvjlU0Gmgr7QtCpdHpo68cq5gOXZ4PBF0FQlZ1vbf3oTHf2H9VXqRx+FsNmFtwAFzdHEboSB4ilEew5+0OsHWSqCx/vhuGQlbLB3JUBjqko9gpVfWhS1T8cJcUSMZ1AzBwSkygpUj/yQFv8mrXaNzrYeU5VHJ+kMTUWyOtBN4gtsRGgrtP9Go8p1ZpyOw3PjsHUZvqTnMUXP+Kq2X5BYYbo5QKM/QqdpnJPTtyBLG2xIekvFsrx1ylIiVxoRQnnLAzmt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzWm4iIwGYJ+pWuaN96kFdF/eGbdzRTM+OhKBTcrgAw=;
 b=WscmkdNzV7+HKgcN/1GJCOTtoCMOLZFzAaiLALjVZ8Nnu2wHfvbHFNiUz7BB3h1mOfupMxbuTfk+58WPRU7bEscvybPtIITUf/D9PCq/YrV56bctRExSyrLs4CrhastFpnxaOGZzGU+T6NVbRP56pUKiDvFeZorFv/CssSHUAc6flolLdl3/pdWJKKJadV7rJRTy/iKF5sRz+GOdcCwSF51stCvAkHYK4sAw60BIBfVLSp4oODrjySil1zHwuVNRqrXlv49QQHYLHlss5i/N5LWLrCmyodArTP/wkH8ns3oU0uvTjaUMuBn5aqxtT+hzDqLmceKZlmmnfLRu3J96Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzWm4iIwGYJ+pWuaN96kFdF/eGbdzRTM+OhKBTcrgAw=;
 b=EAq+7WXUZcAuwqgRJ5zMqQZ4pAla+L+CSZY4Pz5x7EpZJPoSNFSazijQCaMBfpMYQagZsnMIkQ1+f68hY1k7/O+Oihnt7xf/XXETsuvWG3OXNjF5lbbFO/3REhCYb8wCKGi+JG1UW+XjgJ564MVCLOR5+0jfWwS3Fkiuvs5cs5aceATNU23TRhvRQywKULC0yxQdEj2qGAkBU40A1EWKBtiL2aQwNWVYSbCRQk+ibrDCaCTyELLDKE/g8Cp1WT6We+bYVYVYHwKGJDd4TNuSw1d1M440LVgWgLTP21g8GL0bkNWkRLAPfnBEkgOvLZq+1f/sfU4YUVlrA6dDRsqNTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 14:49:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 14:49:09 +0000
Date: Tue, 29 Oct 2024 11:49:07 -0300
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
Subject: Re: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Message-ID: <20241029144907.GB209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:208:134::48) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: dd43b185-3966-4ecf-83de-08dcf828d806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0zMoWWcStlEUeQtihC6LM07oWgBFbryhC0kWs/1fP8YoQ/jZ4EaY7X7Dbby?=
 =?us-ascii?Q?1iKIqI1tm9fdFBlrTv4jzwpCpWi3xuC08mJVCUansuLuI0R6R+ZJ5lYWBv02?=
 =?us-ascii?Q?bWJYy03C//bZYF+SENbA1ECKPt4rE69xU4gVgC7e7iCYzla0lAOirsktbbGj?=
 =?us-ascii?Q?zwHt5kYgbYPn8juy5S56u1X2lvXnvkSmXO9+RO5m1N3mMeUfMph7vL93JrEB?=
 =?us-ascii?Q?kHTg1JlmIYqXyESgUc2QdwErrAZdZVMqCsHmDIb5pxA/WM1vN2wevTxu067/?=
 =?us-ascii?Q?uZR4UXw7SZo2nAq67hADmaTq7wXU2lCN0EQuBpL/lfi0guAq9Br0x4OYjvqb?=
 =?us-ascii?Q?Xy02DnIHkbeK8jGvADXlDL1PKOayj4PGAUN2liAP42+3WxRyWNHYUV3VRU5h?=
 =?us-ascii?Q?EQXxuDT+YzvOUphUyIPJ02UW8472Sbr9fh/dXglarQU1dxQaHMkw2jQZ4i25?=
 =?us-ascii?Q?aPWMziEZMOcfra3C2gaFrzIr4Dx83YMFZ11EXjyxpkIUogOfl1vNYcaeYeig?=
 =?us-ascii?Q?UF9wa8202+FiKEl8sSUklRhUJDd/4iY2KAHiwNXhS6Adok7a1pGYxabPncdu?=
 =?us-ascii?Q?YFKGve7QFCRLIgnjrR+xdZqmZuK+ByPUvwejbXPD87fASvaOr976oE9h+ioe?=
 =?us-ascii?Q?AK2nXIT66+xbv3kre8wdEP2+G5DxF95wohTB7ZdqdkYMpCvcr7gY5pzYyPCL?=
 =?us-ascii?Q?TvlpQZ61Ep8XEGBfanE4JsLAEi4b/J6EvmjVf8jAlcbF3IGyk/veFeW6BK0Y?=
 =?us-ascii?Q?O1veAXPMgT0Q8sOTWDgZc66DyQXP3tXf4r91/UECjKnYykRFVARlZK0dD+Dz?=
 =?us-ascii?Q?/9+Sn2voMgHZpmoXzlEvuzYb6fttZe4Sv7l73oFf0y65QmOsQsKgBCaLIWtY?=
 =?us-ascii?Q?SCXLTQTKIjWcnDOq5f/JCUruSRuuqWxx53bFbS52/ccJa5DOBE+QiGlrGr4z?=
 =?us-ascii?Q?nTAAN39nV3xSH1ruvcaEmO6CuiclHFS9f6x7dAdFBKnWfH3LYf3GlZPBoeti?=
 =?us-ascii?Q?Z+Hn+6foJaBelgQs7c6LJUIBltKWDKP+KjsakgOexn2d5Vo4xWkYR/1ez90e?=
 =?us-ascii?Q?gYP2MpCNVvUM4r5yQ/RHZp/vD7BENwnibeFWG5KbotVvfE53OZMGlno1vwXn?=
 =?us-ascii?Q?/YVSysbbomhqlw2CvYwP+ahs4YykJGIq+h2kHwtaxTKFoyk50yyuFclHwwwa?=
 =?us-ascii?Q?3CQk2+QdraJMzr4j80Q6+SAjKLkVq7Xp1I5V0OOmmd7bKI31zR4dd8Pifprv?=
 =?us-ascii?Q?HGb0wEb0MJAoJPVt7q3xNTYAKzaAT/MRH7YVxWRpx7b7OpJoFj5C8bryxLXS?=
 =?us-ascii?Q?NN+Bs5+jfEoTr0YIBhjeXMP2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VD1Y1TtqffxMrebB7k36NR7YFIK/MHizV/ThOaZ3mOXHM3PD0N6Ksg6Z+gsa?=
 =?us-ascii?Q?gSKDJl1f6ELY8OpRw6H3abkwsgQWcg/n3scewXSfHjv5TQSAs+kQKmAyik/T?=
 =?us-ascii?Q?Gut4WQ/BsiJ31jn8QwR7RbR/iZM1iTs8XckaLXqQhjOHMH2MuZTnpVtVfath?=
 =?us-ascii?Q?0JXnLlYraVprTnkua8ayiS6kUDNPqeIV145mZDx+NvAh4trsOW/ZwMjC1MPa?=
 =?us-ascii?Q?sCs3GWky10sgxJtPZswx+55mmmyvRsUbGePR0U11ty1q87f2n9t3XMTFLzwI?=
 =?us-ascii?Q?kYBpOm7NUN8t44qKngUynyprp2ymMv5Sx9DaCGu+wGefYBXjUyILM3r9CTPm?=
 =?us-ascii?Q?H8hTkLcoOcsuVUlTCLZwEcgH//RY3d+8WGzj1rY5UJ1qA8c+eg/1kWYCchNZ?=
 =?us-ascii?Q?3WpEjPUnYU20OBzlW+uge69SomVPOApivYauDRExfBQkrui2NmJPByw17vkU?=
 =?us-ascii?Q?FvDK6Q0Dx3oF1MtWexVPZF/DBfmCZUelbf7gV2R891wCzCaylvWCN7HoxeZ4?=
 =?us-ascii?Q?+ICOtWMEW1O4B5MvNUXNEU9BT/U51elpDTdjz1UXbU3dV1nfOsrJxgMMTcY8?=
 =?us-ascii?Q?tiVl6JJqzsFzcIgjdDvrIfGDEsH+AlERIf5+USM5nljG+UKwpZ0PfcM62Auh?=
 =?us-ascii?Q?eBqa0oDwXjQ98anC5IiZjaCHuTuDUQScqZDJxbMk3AoxB8eB3jNjwu6NJzUx?=
 =?us-ascii?Q?OlcD5+R1ftSt6K1JYxT8c1VGCI3UQHFwGhJ9KLa1xc5AF1A0gvzZl3pFJpNO?=
 =?us-ascii?Q?GcqS+9G9kiOKwDC0FIqv5+qnVSvJt+Q3qTFk/FJzyi8nsfX1ZtlUB9P/PlgR?=
 =?us-ascii?Q?BDLUKXX8mBQwHF51qNpUVCPYiCs45+lIxaiuopSnh5DTkZOaymDC46aebG+D?=
 =?us-ascii?Q?genCq82YxvJ2uP01mCNfyKnVjKPKqxK5CWrMWdhUOHnKm8OdOWOCxW0PYVkX?=
 =?us-ascii?Q?3wp1ud6d+AgMJk1OvrRI0vVFwSthMU/IE001fLzaZUJK0tQA2ARGTZmAeu3s?=
 =?us-ascii?Q?1uFDdSk0Il+vX7Hg+L8XFyO7sN+qcPz4spovdJZ/3THMscc1aMDJ+YqxCEPv?=
 =?us-ascii?Q?IJ8pgWWAaBGb/9cHouf0Geo9Rl5yJR+jtmAwc6gYMtM5pcnGc0DWBTn+na0D?=
 =?us-ascii?Q?sLuPDZ/YX72abSxzqnG5506jY29gNQwkQQUGuj9z6YZNxPXAZCe/9aaBvpX7?=
 =?us-ascii?Q?amrfoMM8Wy/8W3uWsGAy0wvXCA/KvOlH9GFtbuGOwAuvfhlgMFbs9jSsD52W?=
 =?us-ascii?Q?OXVC1HSr2hLhqS3ev3IBdWWdIIW6S79tdfHJX2HyrnlharUqgfzQAbhrFS++?=
 =?us-ascii?Q?R8nnkvbwy6QB/COJGTiOTnYEO9oQx8w4DAt6ASikvRTkvwIMVzyZQFAzLxvW?=
 =?us-ascii?Q?9WPSnrDhgEn/S/ulWsZnoy62KwE7FWuSobeq2jLKO0Rm6FrT1gIYWfeYZl80?=
 =?us-ascii?Q?ijkxaCF9VpHC7XKVQGYtaNWB20cQLuzOtBg3+F0OPZNgalplxcyiKgQ60kkl?=
 =?us-ascii?Q?zhtWTp7IjmwUERZTphR8fzBrqVvq+NkNLVgsmbAd3htyMaOQfNQLRvDbxw8G?=
 =?us-ascii?Q?gYHqpFfmwDdq0tGehlE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd43b185-3966-4ecf-83de-08dcf828d806
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:49:08.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GLS6jjBtDUvBclRtvZvzT6/uND/XGrXQrJAzRCeTcRBab2xaFdK2XRQudBxdMnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820

On Fri, Oct 25, 2024 at 04:49:43PM -0700, Nicolin Chen wrote:
> To support driver-allocated vIOMMU objects, it's suggested to call the
> allocator helper in IOMMU dirvers. However, there is no guarantee that
> drivers will all use it and allocate objects properly.
> 
> Add a helper for iommufd core to verify if an unfinalized object is at
> least reserved in the ictx.

I don't think we need this..

iommufd_object_finalize() already does:

	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
	WARN_ON(old);

So, we could enhance it to be more robust, like this patch is doing:

void iommufd_object_finalize(struct iommufd_ctx *ictx,
			     struct iommufd_object *obj)
{
	void *old;

	old = xa_cmpxchg(&ictx->objects, obj->id, XA_ZERO_ENTRY, obj,
			 GFP_KERNEL);
	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
	WARN_ON(old != XA_ZERO_ENTRY);

It is always a driver bug to not initialize that object, so WARN_ON is
OK.

Jason

