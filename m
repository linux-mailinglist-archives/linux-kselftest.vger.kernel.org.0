Return-Path: <linux-kselftest+bounces-36557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD2AF936C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835EE6E04C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8772FD894;
	Fri,  4 Jul 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3jCvbLu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FB2FBFF7;
	Fri,  4 Jul 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634016; cv=fail; b=aZIii50owwWHoddKfiRTKDg4iXW8tddr+kMGniryc9SI9lOjzMucGSxvaigRpVu7KNe7DHE2zlFABL/GeTBS666R/ptxr3I1ov/9qgXVYgUOroRLCu2IxyA9flCT7qv/lpt5zfv7N7WLtPBK3aYqS/pVCss4LudZvOOpRRi/GiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634016; c=relaxed/simple;
	bh=PRQAeEi32Waw6mEkuExW7+Rdf7KOUeEhQw0+3J5sFaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CmJ0Vc7+hwOMAZMZTARnjIPZS8S9OovUY01Qi6KEIeDIjVAOGQKVXwUmQqKrS4/JaakaWo3ECdu4KRuCij/lLscrH7RlBU1OFrIGcF9Zqtbq24caDxGKK9/Ttlx6RKqmDtkNs3re75V9CHrEA2sp+E4cHoPmpkbL8s/z00GhO2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3jCvbLu; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYnMOzmvqb+rZU7Z/R5amrR1gmJVsCefHO14Sqj2Ji8P4CF9Zn79MV2ydlZjwyE9VkknpVwtgsvdOt+AQcZQHdaFKKE58k/tFwbdvS3broz08DLyZXbNKg5RwDYaON1jvAgYTrKGn1MNYei7hUXJdWqFgKoIYPzgienoZepOReCspRJTz4ipjZfHYsAwT2ILbPOzWfUIy40H0bsIO+EUgL14csZgZjMJBbliaom/HXdTETVguistfNYpp7rYzDQ1/ucV/DN2NRZSTqQM1zA+C22igYFjAPcxsrZexc6i24gYoDpiQZIWD87mfuuO/hzfJjdGEQNp+bMET6WJnOQekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eed0DD+HMlSaNgieWnMP+fvOJ/0NZrloJQF+EPG590=;
 b=PgN5te+e7f2rVqzEtzzSZsEvm6l+3fBrpWjn/1KBB4t3jT6ZOJCtcYAoEhtpfY7/gnBX78yUtSsgbwyip0bZWmibMg6Dw1m2jUlf7FNqD+dlHTnhMn7dW5beGDbW26ycavZMrJQm3tRNhdCuqvHJbEa5omqXGmVChj80xUcWfwx92uOlhWAViCjJqepIBSa0VNCJXBLg6dmE6aFwaS8qyHVKBAz3uC8PzweCqLvtIlv0ghk6frEk7DAIjFAQ9VZN/UyxM+xTFbpYvR+LHNacgyiOAg84s1IwWRuMbeGeS36MjD05a+aagXmZpSX/84UjaiHvMvdFeN/7KOsncL+lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Eed0DD+HMlSaNgieWnMP+fvOJ/0NZrloJQF+EPG590=;
 b=m3jCvbLug3oMC6XjUVOMk3QrETmadwAobNe1AXbEJCJk4vNAMMBiawgZBh/B02LfZVod2dXklnTuzXtW3OxseMik4TnVHeSf9DJpMy+js9Zg0/iCI1y5N2mlQHCcH0cm7GeCiD1B39ZERoWouGFTrjmrPTN4vB4BfilmTBPMAV+hGM4yy+TwK85ENohaCyPTHI+5fHSenl23nODZV0o2w/LIeGjiGgyvIH+oBfnmkVFx+0Cc9zYqIPNrf5zUZ9G5ZkEUPV8McQTR15/eYE4w+iS5Boh4MN8cyExR675BAa7jokNGzyCaSynGIAnvuK/gJOyF+DO8gpirI5EWJLlsGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 13:00:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 13:00:12 +0000
Date: Fri, 4 Jul 2025 10:00:09 -0300
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
Subject: Re: [PATCH v7 03/28] iommu: Use enum iommu_hw_info_type for type in
 hw_info op
Message-ID: <20250704130009.GO1209783@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f588bf6a47cbaf350a03e5a1680074b852fb5502.1750966133.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e389b4-7348-40ad-cddb-08ddbafab607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r014FOUX0wCF612S1TwQwOo1Wy7h24SYvo3C8vtd58uoRjEeNTgU1vsmeGG5?=
 =?us-ascii?Q?Sppr1WpxmtxAmIHTwB53dAM81BhNxsXaFTHxBL/010vf+Vte1HmCeBo98A3B?=
 =?us-ascii?Q?2me4VDHEqdNQOnSKFF9JAq1jjPMJcNliGv9n/YpBdPwAZdyl68WGT4qdP/vy?=
 =?us-ascii?Q?Pm5nTQ2qeBOWI5xOSNewfKTEojMsN0OcUijpQAKNwJAeqlU+7TGahHSVHPwi?=
 =?us-ascii?Q?ndv7G0p27NBETwYtZfWO3EXWQN1ZLkqEMeja3SkN7ykY6NsDwqS45pld3tpC?=
 =?us-ascii?Q?KKab9dsW8AVuEf5TRFRrXa7lOxFJ/hJxGnHMQcdGAFQRBpE0W2Uz+MKYH2Nh?=
 =?us-ascii?Q?kVHGtCDvRfS4g1kmoPgq338RV6qu2bGvtaDgMa1GRNALrOVSb1J5GZfhzDNq?=
 =?us-ascii?Q?ejKAEQoWYV7qMbsBjv2lYhZ1rBrMmuZ/qiKXGh5ryKWT7KqckCjT0cl1DZsS?=
 =?us-ascii?Q?lPSSnOLZmN98mlknPmIef9Fbq9fwkLvuU5rAnait1Y62og2xiDWCBIeWnmnC?=
 =?us-ascii?Q?tU+ozZMFytKnUuLBB2fFY4iZrAIpVC3Wx0QNf7apqciHaffN9IOr/Bhp7mL5?=
 =?us-ascii?Q?cX4ke2niuoebOnyEv7HYcL3bKLctROXRolSP4TnxB/cHmSmGq8nR2KksMrhu?=
 =?us-ascii?Q?BQ7TI6m85GE3NQiLNtaqqBISg2TC971OixnEMsdWqfpfGsaqMqUpCzBDwlsV?=
 =?us-ascii?Q?x5klS0vJUGQSFkqJ0wRM+0H7koOWACy1uD4vR/Tk2SVbUkIWs+eHyQNH+jqQ?=
 =?us-ascii?Q?IpZ+s2c8L7ihzSg2udw/h3UNYPPx9u8isel0Ojj+58AXNWKncqflYBWFIFJm?=
 =?us-ascii?Q?TeTKaEeJK6ZI0u1lEgRQngzv/gvhjkUvcIt9uRojOun1FTI/YjndTB32Bvyd?=
 =?us-ascii?Q?Pb8KA/g8MQS9OiVsuhLEofuV1JWzp0tvRo0zrR3vm8/U1thci433npfcAuYU?=
 =?us-ascii?Q?n/q3uzXTY3zqjv/buj3WtutVX4Rc3Id98qH2RUMxRETTUB09gaqFmxycCxw3?=
 =?us-ascii?Q?KH06nLE7EdpcFzcn2s71j/cCk1g54R2mdo6cdREFzp+AATzKaI+bzBq1SJ6z?=
 =?us-ascii?Q?VM2YJDu/uUt6+FF8seC6Vig6rY9i8T7DWilju3qDsykLqUd5ju89r2g7xGiO?=
 =?us-ascii?Q?vaQ09mE2ytGqKMqOsK+jMDbEnQylDKFKUL737yatvvVs0wd3lrRIynRTx8ku?=
 =?us-ascii?Q?DhTzII9GHK4vyGjbrdRf8HRK+g9TH7uF8ysnqvvQqIGqC7bFhel7AYlHOpkp?=
 =?us-ascii?Q?ID3p7b9jLI4C75Tvw0RZ186zvMkBLLvd3XEg9lCb2boUXietf6f3k8e9x5/V?=
 =?us-ascii?Q?B6d7HcSYE+T53sxtbcu3D/V8PYMXm4YGe2iKmFVUOd6N4p0wXh6L66q+Kxvv?=
 =?us-ascii?Q?ZhSbu2/WDUPpxJI3GzYscj72jI1D232q+TKKlkGyBSge6ztO3bEqPLzniXqP?=
 =?us-ascii?Q?ICrj++ZqnM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxmNyhMqS80mcO3tFHM2qzfY99wM7jn8/pEdQg2Q8xaQgC9PcW5dsf19QU5v?=
 =?us-ascii?Q?SvXKDLgpgteRzuMpI6fmFYsZlRLM2u7LzVmwlgc+jaeskD6pBmhs3LNbnWEC?=
 =?us-ascii?Q?On/PjZBJ/5uFUWch/X0l2Y2o4G22Ftijp98PLR82D/NhFAKyZS2/1YjIjdyR?=
 =?us-ascii?Q?3eT83HNh6GtUbhE3F2YyH3q50XQ5aNfRj3D7DQepLfHgCoXYaAFXUKApcIq6?=
 =?us-ascii?Q?tfQt8rYNkwMn3SMim+T/BQzRFLs7BaASOK+kzjmNTrljCsBo5g2FL9mcYaLe?=
 =?us-ascii?Q?4Gm/FOmsE1v2ZBQn+es8iPNfKTaHze9xl8QJxDD7XGz1w3ZSz/qJQZgWe7Bm?=
 =?us-ascii?Q?SZCmAyTR8KhdiBQTh6pqwlMxaSAV7v2xxpy11a4n5J6TW5g4cenHzodszSH9?=
 =?us-ascii?Q?cU3kuBLTvZe6d8HiTtwpGrVa3GE3+iY5/hbmZNUgzsi1tD2hRk8INAw7/51a?=
 =?us-ascii?Q?u0ZymsXg48SqW612LYLnRHK8HNeiZ/F4iRb5ZfW9PyRocv2WSUZoMCYznKzM?=
 =?us-ascii?Q?PLrF3C0a47vU1JoQZV1e9VUsvddUI76XUX6Jq9aj4MiMt9AoiDSwCEMftCre?=
 =?us-ascii?Q?T7cakJgYpFCcA5rlkisX+MsPUDbx+UwRzpG4IkwP2BFRygbTjGi08aqP0jjT?=
 =?us-ascii?Q?gFVc4j5S2g1ijfE2kOW1vof8yyPYPSrPU0X2rVoRdkT2L5GOo2Lqaf4bm+wa?=
 =?us-ascii?Q?dbf9coDAC9cEph/zwDK9UHjAKg0dvzQtR+dmm6a2rcT4Q6AE2WC/K//HNRop?=
 =?us-ascii?Q?2KRh1SOzywflYqnVcbNzS3s2WADEya+Z65XGAsB7CMTp5vJiGNcgr0Ib2JN5?=
 =?us-ascii?Q?gkRjYdo2EIH6hlxfdO8/HFKrC9hfPX9Rjsqapv7WpEmxMxByx9VJdpqbj0gu?=
 =?us-ascii?Q?p70PKAFQJe4wBm5hjUInqaP9RYeM20hSePzaxZLCf/4vZSPrSC9vCuos/ay3?=
 =?us-ascii?Q?oK0ZgeG8PYLZ7hLBXN65hVV8Jrh5MvTnbLSyUSz6pKaVDed4FGn2F2ZdmLgR?=
 =?us-ascii?Q?WRkGLNQIJ+RNcRRS5bxdPMLe7btFeeSHfMVV4C85D8lTE5XZ2B1aC5kaFwaI?=
 =?us-ascii?Q?mO/rUyPV9pzXPzZr8SF9gadvKLnntOAf9PyOmq1/CvxwAR4gT5/j2mk2JvYc?=
 =?us-ascii?Q?9xm1WVMC5WmSyTLo8agaeFe9wWZ1obu1NDdcHHGqQfrWgfF7qUWDDr/4r1f0?=
 =?us-ascii?Q?ZLnxGwN1JYWimCuWal7gZF5Q2glZM9+4hLVLDTsVNJKdiE1lfvtbV2CwYHpe?=
 =?us-ascii?Q?brxR6FJvV8lGAuvf5tr1Nrqi7ifSv16aNQEULQym+TqqAcwgFNN5sfEto6D4?=
 =?us-ascii?Q?ozZwLba35UHO13C1cJp4uBmYfSRVrHgH0Ql0Z7ubd7q4A4qsdY3FAGQqzVjN?=
 =?us-ascii?Q?JpSC+C5pj+kMpMeNGBGmOEOmTDKiUCREMi2PAcXFBR/1uuCyIeC43XIXzSx/?=
 =?us-ascii?Q?XxujvdG51w/nDs6HsWRAtrI2EUemA4wc7d+8JOovxfRKFQlogRQnWtaodXpp?=
 =?us-ascii?Q?CzC8nukPEM8AkBcERnwPs9jG91+dCS1uexot6PVkDC1FgPFBLKYcfLwLLP7W?=
 =?us-ascii?Q?+ACLBberCBp7vKbdvL9r4bvqJ0a66ARdkR7sDJ6m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e389b4-7348-40ad-cddb-08ddbafab607
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:00:11.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqCOQm/1BrlECiFigBAVs2u7H4qqjh1nNZWCvsmOcK0NnJhe57+YgGWMEubUPsIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

On Thu, Jun 26, 2025 at 12:34:34PM -0700, Nicolin Chen wrote:
> Replace u32 to make it clear. No functional changes.
> 
> Also simplify the kdoc since the type itself is clear enough.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/intel/iommu.c                         | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 3 ++-
>  4 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

