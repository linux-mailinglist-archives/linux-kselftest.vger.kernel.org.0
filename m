Return-Path: <linux-kselftest+bounces-26882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CEA3A410
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28A17A0F79
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC74270EA0;
	Tue, 18 Feb 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WfMpSMvp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44D26FA77;
	Tue, 18 Feb 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899288; cv=fail; b=PLhTva7PJpgfVLOHyug7O4lZ5oGXaqFEyeabbqIfB9Dv+0bOvYHYeExeM2uA+JuSf1OU/GlqOR9pMIkdxCQb48Ewe/8VpDEbTqP61USQhSnogfba8QqnuGvxJyg8bNkXpM3JciqNcf4Mo/YfIv44B22AOr0GqLjIE0fCHh90ZDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899288; c=relaxed/simple;
	bh=QiaJKEWiXF/mcRz+QXGgNEthncF0gmkt7bSiagdbs0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ScJueW9U3UqgMJfYginrjYb03mwK4j8iM3kmcFzrmUFxR9vjnjUnyqYt4V5ZBwgC4vxi599VSPyHGHmpkiYGY+sF0J85zs5ibUvhfm2lgEUWoWwy7IAxae865+u9n9Num1JhHmB61e+WqDhuTAcphbkXt4K6Q5k5d6LQX2HZ9Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WfMpSMvp; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7Kd5BhVMyRWAM+NCKmcRSCpgW8Suy8qPPIqxCx18FpGrgOhjgi+6L4PrGgBi9G+8UxvtkyEfZgWGDwps3Witzd/j9yCg6I8lOORNq4YjqGwJPO4K/G9+kjKImteIX79Vi673XBvM8/5xJaP2l8/JHcTvrEhcB0nK7ME0jHW2TSt0JQ1Nborad4XpaA47J3LltENeNFCUU4ooOc17h+ZJtJB8vwuNci+MXFbgtvA6rPad6pmp4+SJufrV/EmAWij/QUNvo/lapFzv7OK1m08IoRDIJhmq9HPVVl31RFQWe7BuMp0vCHFIGrW8V0MyAYiWgJVwxszgJdRK5ciUq7F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW/DyHjqbGLeTC28HCYsuRSpzZClGAf2gJ5k3Qdchek=;
 b=tBjgKz4gXC18ODoAndjlevLtGWV2BJwyN5StwMEW6BpnCZ7AAeFxh35N+88P3mrkD6A9odZAIPHZdGNf9ndh4skG4WrEeMHYRpOTFtT3J1vwGl/fsHmrEd1CE+oZrBOW4n+ZATgR5BI5HIaKD6VcDKCq1wtCR94r/JBxdF6AF2l6h9u/JC/Epk7TuI3dQuDQqPJrXO40rTbI1NoRmojksaLzznMpIekqg3WGipZ8aiiIiFyypdI822hq1+NKLMuFYS13dzbBshGlirqSH01OtMA30LO+G+AoRUA0nEbcYIprGvDtWCjvspc14s8qDEWreVx2/pCFcQ1NnaAgW/M4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW/DyHjqbGLeTC28HCYsuRSpzZClGAf2gJ5k3Qdchek=;
 b=WfMpSMvpF0+3FbFfvNQW59jmBXGTZddQqBL2Rsc5tC8LvpJ8IQysuog1UBWB4Xt9/KNp6uCwo98sESXm7mOerIHxM6h0CbOgnOqk0SHZH9Qhq4yYZKRds2aUukrr2W2ivgPuBv0QQnd2IqAXmvez6QxCc4FhRcu70564Z9pD61X3LlnCjexymskdSWS4j3k3fyHYUlAbA0fXM5lZMAjqCX7AMOavweKYBxziaaU+9cYdhbeLjUDS6HaBaf3BMD4JfuwCjboleS5SfUcVW27PuDohx9xggpL4oayBgTNelEMDKkgk8vKhtCS22vKnOLE3zPFW9cGxMg8VzoqyKIuQ9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:21:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 17:21:22 +0000
Date: Tue, 18 Feb 2025 13:21:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <20250218172120.GH4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: e844ba09-a296-4254-7385-08dd5040aa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R17oi/ZVWhKoL3WLcmHCoL3ryOpkwqas898n0T5a40Lol1MV4Lj+0DMaqc2T?=
 =?us-ascii?Q?j/KmgSM6TbpkFr7eRDf7hJO1cSaQ77PKhkNBpiG73nNXxwq90kEv/uOac0U2?=
 =?us-ascii?Q?hVkaGLlJCEjPahQFzEDsSjZWnihFmrpFEPywJtcmnFakDGL2eiKubpLnt+6T?=
 =?us-ascii?Q?V8blcnNuFRRASfmXURuOpSnrheBDJXhZARxyHcMDoEWwkAwH99rt03+lRNMV?=
 =?us-ascii?Q?qjjwE95GrXaVRhlBciU/l9SXUgo3pcNbRkGygWj+JlU0Gw5OmCeze0tNedSV?=
 =?us-ascii?Q?iFE/5zSrOUjfx4EnHtNh8RCDD2FijHbd/5mVYpF6AloTjNYjOsa7fy1IVxtz?=
 =?us-ascii?Q?r/X71fbPFutkIklBTyj6Csvh5EPKHP1M4WlJ9WTRsfKcnn70v4RU2dmnUCdY?=
 =?us-ascii?Q?se2/zo5KWA82aCQCkTr9+YXKjLpWadCgDKcnD+BPmolBtOvI7X4v+l6qhUD0?=
 =?us-ascii?Q?f/S9pn7uaE37RVesSOyZiJoJcVTIBTRGlL64MZakLj2poxBQyPwyxUpZgAyc?=
 =?us-ascii?Q?ZZQKj/cPHjrF8xOCw+oc7WLZKk0A0SmuNg3QRRYF0he08w2BSEGEOWE9swEU?=
 =?us-ascii?Q?tlryCd1SBljreRS9R+c4sk0SaEEwVaPAK80WMmdAFQDteMvsk3qgAeueHiWZ?=
 =?us-ascii?Q?ExHyxdHJgclQpdqwIM25GC2t846CIsTxGuXzBRzJZl1BurOLUn88JRte1vC2?=
 =?us-ascii?Q?oX/iC2NN6KgI20KclIUqjwqgl9fgYtQfweRc6aSfLe+UNHNdPJK148fIPkjB?=
 =?us-ascii?Q?Laoqbk4bArmq2aMA8kGHtf8F1VeIUkJyW7p3hKsJVfaBbmpB4hSrBsAz+6g+?=
 =?us-ascii?Q?vfE7QNZgQscvL6VfARqQ0aATY05RLVsK4wA/s18ro3PDkI+BW7fmKk1ylcbO?=
 =?us-ascii?Q?uIciE2/YybD87uzp9x2ogGULzEt3yYWv86oz9BrZIr5o/byfIPRAiclvQfNW?=
 =?us-ascii?Q?Uw0omjg5mYtu+Ak8f6Pgh+kyeno8LuzzETBQ+/wkWeyc1cKF90efJTvn2a8v?=
 =?us-ascii?Q?4DjY8keMkpe19uJ08hi/QaYFkkcp2UZ+ZFbe6oAQ4okb++GFQ85Y8WG8+kvm?=
 =?us-ascii?Q?5nJ3KZWShyUCpugyOvPKlrBofRJetOwFVbkQ4Iv9rOYcnw3w5asqYMyQ638u?=
 =?us-ascii?Q?uzGUE3oSG7SX9xZAoj4Iz7aNi2IhgTR3eTmY5iaXOplhATypbTcr3x8fcDBy?=
 =?us-ascii?Q?BGWdZXjyUayqT4Qa9RqxFXSGoBJ0qudlUNYSNXXhIqJMULEVmenSvCAR1Jd1?=
 =?us-ascii?Q?BiKJDaqd8uEmEYeBjhBCeMWktwYjYIYv2iVORbo3QgOuJ9CKihnIK7aUa4o8?=
 =?us-ascii?Q?7PtjK6/b7O3U2KrsCF3h4PQKMlBdcYg02hoXZ02eq2x+Y+YdGMuQFBOJd6hi?=
 =?us-ascii?Q?uClpDz1OW10zmMw/LH3zELsbV9q4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OINx11ju4nRBlMZW9nOlyDbScite7bVIq5eBCqIQldLfyn3IFGDVnhJ9BGT2?=
 =?us-ascii?Q?iT+isq1ydUY93q2B36m6PhH1lDKBhnWcI6qnfk7xyJzAg9qfWiKPG7LaffwM?=
 =?us-ascii?Q?1sjllrSdRgnQVmywtoM9C7OGdcEzCh9w7rQVWBmaa/7GD4AjNFyhCMvoIpRJ?=
 =?us-ascii?Q?OK6ea8WzG7cFtCa/oXZ9sO8sP674Sr4ngOyAE8mO+VkaeZZ6FEqP2DDeTf8z?=
 =?us-ascii?Q?9WkdlFaNAFgQbYeBJ+/nJVmPzPc615djFycaYoF+dWKSHR/2CwicyieTySrk?=
 =?us-ascii?Q?Qz/bp6LZV3NroVJpKraZ+/mgSvIfIqo263OsbREAEMQMKyr5Pm3UmvPYvOaW?=
 =?us-ascii?Q?DTzUS/v+7K3/QgyT1M7j9V44z/v6m0WgZtrpcAZcaZsuJVZijCdrarkqw0es?=
 =?us-ascii?Q?J6+GU1x5EAjMcTaJZr69Vhj7RHBTSUctdHSZ+UPg1fIeN3Knhm32QkyTDvAu?=
 =?us-ascii?Q?sko8BAe9DZzvCVnyss4FJksCXUX1CKbcGdwJYrLKSctyOOCjV4tDxFngkCMG?=
 =?us-ascii?Q?4q7TaIWFoh/FlFTA+I0wPPQPECyQNIyE/KakrNjSP8cjPPPX/LuiDUGp9Ieq?=
 =?us-ascii?Q?yHi5mXcDf5yifMfkimfZleZNUx8IXJM4lDGMvuuikgDjAghSAaiBSeZYSbrG?=
 =?us-ascii?Q?lQ1kIBzHs81wvozHzoW2ms+fPwNnGBzFhxA8/1MaDNPiFPyFW5llrkMIc14d?=
 =?us-ascii?Q?ooADyG4DaYke82y7tC6vOOGv54I5BANAfuJPfIH78+JHJAWSTjo4dmUoUOBK?=
 =?us-ascii?Q?d9lXdN+pP5A8b4kZutwK5q3I4pQTyzZQDC2yreMCGbDLEHqn87XFabsiJqWH?=
 =?us-ascii?Q?eoDmVEWYQJIDZyl6BFPP0J9HirngLG7qAzjFs7WTwAF20SUmhItOWqANWyuY?=
 =?us-ascii?Q?kvZMuVObeab2t8WMxZSr+uffu625mJ9knllqZ5220uBGylvSXSEKDUjvUxUU?=
 =?us-ascii?Q?Wl2Px3D6vT4p3ELz6FN/nW/9+nkRUZXfnyg2VT08plY842nlfxujDuQLC60Q?=
 =?us-ascii?Q?mK0lIDvxvTrfEVRHekkpsfkkZYKkqfBVpciKnvdy500yvR76fq0AMdy5qB6M?=
 =?us-ascii?Q?4S1fzesvfAJs9g+FpJE6dQ6UzxpgKd0JMh5/JC8c2mQZ+kxfz+KkLjxxyPVo?=
 =?us-ascii?Q?7XBOiodl7xes+ceycqKeb0oSvwVNkQx7kwpfpyj0cE2dCyqcKOjSKjBziLpM?=
 =?us-ascii?Q?0dmEJHN8AVgEKuiR9kmE/wRfXDxJLHP5EiCR9aYr88u0IQCrtjyeoT8pzibH?=
 =?us-ascii?Q?8SQjS37dwuEi+WIfpe53qtAIkYh45IMwtXm0y4uojYr95HYykoxZ4FTlv8aY?=
 =?us-ascii?Q?2YtUEsbUeLAnli1zoqgTD2dj5z31fnHLAP4Q4z/79uEwUAZgrxTKR7Vy4gvU?=
 =?us-ascii?Q?+tKEfUJBPq797uZw65FnpxUxn+3vUP+8HRpLTo2sWdP/zIrExQBPKQ5amRGt?=
 =?us-ascii?Q?/bueFGR9A4mIB3DqkL2nEfAarei4LMcC6PGvgJZD22YHB2lsqrNkLlWJHBJB?=
 =?us-ascii?Q?fra89p4JTmZZkww9jIADRO5ECzZd/UByJDu4t9JbBL+S0UMuBD0j4SWXVXaX?=
 =?us-ascii?Q?1gjQ+fYKqeSxtSec0bHO5XTxUEgLzNMNLAPxG6wb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e844ba09-a296-4254-7385-08dd5040aa37
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:21:22.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKmMmmONrr56WysWjLEbUdYiKyXS6S496XiRDsIoBMcUCNecxwJkPzauaM61MA++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

On Fri, Jan 24, 2025 at 04:30:43PM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1051,7 +1051,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
>  				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
>  				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
> -				    STRTAB_STE_1_EATS);
> +				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
>  		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);

You also ran the test suite?

Jason

