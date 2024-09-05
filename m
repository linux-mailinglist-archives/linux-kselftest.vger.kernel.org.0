Return-Path: <linux-kselftest+bounces-17284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B196DF3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FEC1C22254
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B282919EED4;
	Thu,  5 Sep 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CH79BrYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EB101DE;
	Thu,  5 Sep 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552647; cv=fail; b=fknOIkwOLWtrpwRBYmuEN+XMdchczaetBAkF539EEjmQ5qGL215/6YOzLHEFgFMZHFIB0rP4AFG8PeB0+Zo5FjKivxMnzISFqlDvJZOYkDIH8SGAw3hGrJBYcutvLnS1rAvGfFuLjey1tRlBmxW0brPkZ7CFw9+a8HKn+Y6KhbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552647; c=relaxed/simple;
	bh=KZNbSmPckcPEu5Q23zXB/TURbVN5ka+4B2z4zN2TBX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tc7ZUjDuF43HEuT4lMTbXkJRCWlVGft/NHsosC6TF8Xv+KckbfZcRuOiw/XioWyYmryJAYYdCK1G3n6FBFJHtASh26U/1Kd+B2ymCav6nsucXJWci6RCeF2De73qP8IOzJ3/VqM5rkKH+xykG20Ayu6a1Wh7372wGSqHEF4IFMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CH79BrYp; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ0fZs7KTX0OUhpAll51ttKwUjPqGzzGu30rqH47B3GTjwi4xdSLvBiM3epHNIw6cTz/+0L2gwUxRsDEdjstIJg7DS2H3EwC4xf9VI2cEw8cLgV+NE60kGXug1Skjbg2yQrU1X8TbwqOETbl92LyXThtpWLxKCbq/RdQ/bZT7e+v1Q/OGw/oiBbiKirjETCx611mr8xmzJgOKIpQ3BNVDaeYlVZ8viz5wPuy3zbVDjf4p7G3UBt4AxPPYK1a3zeRcNkcNuOBYkqrbX/K3piEaVdNRchGLD8zG+D49Ub2LH2mgLFy+gIfdKlMrQoQMuoU8kdjQ/JJaemkxWd6vtJz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0t3hrL7BJd4cbB3P0hNlAKEy+2njJnlOzXxViXR4Hs=;
 b=uklNf4YAeyRSFphVEw5rQYDjjJXib9rV+l3NnjuPFLkj+waozd8+zHTzjDf3IxZNVt0Acv7TRTpkjawYUdnvSoS8Yqhmfv2r+oRlCWkOGiNHbOXBvhvjLq6hgc8d9t4Afm1RtHPCZpabaMbWpyskJ4wPjXSQna2p6QpUyhA3gDGzf3+/0d86asWf7lWYFJ7+imFAUWKmtImWc0ZoV8ySRubtlKElUF2pgqe8c6fWHm0isEeiqoNSLZ/xIbD6G9hTV68cGia8cOS42RnvAKn+XC4iKXQgZkVKDxr/ccND7maFtcaKVT2pwYue0nVTudW834XREUuzEBn156IVM2WApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0t3hrL7BJd4cbB3P0hNlAKEy+2njJnlOzXxViXR4Hs=;
 b=CH79BrYp5HfmGZhcAw8GssV+YmsznxminCNtAF9xkQ0lj5DmxATc9nklv4EuYbEtJiNBhNmUMKR/SIpsCNKNC9iqmDY+7zXUMA67+zGs0S6kjyuuaSViDMUV/e596C1hWglKSmIgi6F8t2erEiTK9q2bjk15TJdSEskm1KLnUlAyjQjh1uhVa0fmNsO1ayqvGQUpmZCWMgeyxGcQw/hlKH+m6hy9ahwZvgNEK+z5CePE/EaMTtrl/t54eEUm59EVtmiUBNWnbiWB3kLMCpPN7gLxKNzRKryv7V7fA5GaCj1T2pYRyWQOXh3NJpcl9PpClfLdyQXYl4IUaEhRpYFxuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Thu, 5 Sep 2024 16:10:43 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:10:42 +0000
Date: Thu, 5 Sep 2024 13:10:41 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 09/19] iommufd: Allow hwpt_id to carry viommu_id for
 IOMMU_HWPT_INVALIDATE
Message-ID: <20240905161041.GR1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <31c866485c79a0b43dec0d69d1fc6f23fc654e29.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31c866485c79a0b43dec0d69d1fc6f23fc654e29.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fc5f65-8f55-4ff2-80ea-08dccdc54ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WQhYe2BOVJ75B2d5DLJJ8ZSNIOiaO4j7IP22/S1XmweBlF5PLVbkSjyANQc?=
 =?us-ascii?Q?hTMqmuqks7sL10azQ3Cg21D2beQIA8iela1mlwyr4PKiAWAq5iEW+0Lazwyd?=
 =?us-ascii?Q?8q/Cq9obawUqMKxoFwGp0qoPlKdzuyEwKrOZmQHZVyy2rXf5wOoZTEc1vSdC?=
 =?us-ascii?Q?7vOQ6xXbUUouNfR49tcE+WMkbSiD8kc4en1GZS43aso9LgKfXap8Lb+vYF2a?=
 =?us-ascii?Q?3YDMtKotnH+N1KVqFadBrSUKNCh8Cvdyk1rrItmmbVzG5gXcOJJZI0rHGXag?=
 =?us-ascii?Q?hfUes0MfRtF+V+8GeT/xqCMk1vaSbv/BvrFzShGSFf1FsEf2lMkUgEC0HHzD?=
 =?us-ascii?Q?pKLSq3F83J3lScpE8ma9ffli9RKRSFtPpZpMRqPqVbQeolL4Evn0fZGBaqQP?=
 =?us-ascii?Q?MLHrDctDtoJi3c23oO2OAlaga0FhQIMqGeCR8415fTpp8j7YWYvgA8ihtGf8?=
 =?us-ascii?Q?QSjnO++dsEV45STOh9DTXjQzE/M4a+XQbGOxf8SceqTaWhjgyS+IWhjd98A5?=
 =?us-ascii?Q?0t91e+vLHhoKyBvWJGbUlsfeJErwrmISiBRMC2qjCla4kErbRzYVCKZnBgXP?=
 =?us-ascii?Q?uK0PMgHucPhFcvaZy+fb2OedPp/hvavaKUFRe62DoM/dQEszxzcOd/dxknC+?=
 =?us-ascii?Q?8OBxsdAaU6aLpeWOcEEBYoxPbvpuYoqeRCU9Wnv8E/16xU1rnlMFDnteL8O2?=
 =?us-ascii?Q?voOJAbc4IzU+LzVIYNMMmrtXwQYWokYHbP8p7qx61by19YprPzFcZVLV3Wev?=
 =?us-ascii?Q?miP6P+G4uU5aInqOtFPg3hcokgbLHkfKIfXCQVgG5Ai0CHn8Q1zX79KuK+CC?=
 =?us-ascii?Q?zvuq/td0LVapEfMVlYn+zPz6gJLQHdCMuOSOJ2pvKZsI2MHzkfrRVhFFayBK?=
 =?us-ascii?Q?kSLwW+80qC/UuwhryhSfTrTzqBuSsT+mi2mgxvQNTPX8Q9vx1Xaou0DHRonG?=
 =?us-ascii?Q?5uLX/yAKhIcEwnZCEca2aJErut1U74KuInPg6YpUhY6YEry6Wv2+JSKAAIwx?=
 =?us-ascii?Q?iLdh2dqZOwwtHgryvQ7HkKOKaqWElXPj/AfMrBlWIuALPUx0H9+zLm8EY6ov?=
 =?us-ascii?Q?iCGJa5pSDDz+VUy/hGH1RA5CZsN/cc42CXm/bV1wcHXvEeqS6L7QgfwcaTTi?=
 =?us-ascii?Q?Kay3R9bYiaLXjgjMuj11C3P2hXSW+aZPm3ypeu24aBExHnu2UDLCA7TTCjkp?=
 =?us-ascii?Q?hbCVCvld7KEYAW4vd9RCeCEctU99E7fr9hcAxAB3QO2HKVQL+vdtOwZRUdb5?=
 =?us-ascii?Q?/8ByxO61a3Kr8o0PY/5BaSoRyBtRJtZkqW8MJLvE5TptbXXKQ09/FqUOgEbz?=
 =?us-ascii?Q?4UxsZWa7Gdj4XpQeA2cn0YUANnhtMs04skZuMZDXwnXHYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+I42XjUY55HsA+m58dJf3wYdx1P9XOlmoJFqDFb98Q/D9JKgP+jIO4VPeuX+?=
 =?us-ascii?Q?d0gC/VoB5Wk493nFCJaSQ/Og3hyA8zWSoK013SYrM8iiesqLtOaFW7Nhru/F?=
 =?us-ascii?Q?ZvbF6wuZPdJTIig4+G0FIEquabccIA7nAjFyu0nc+bZ0/NWIjqwN0rbRmY0z?=
 =?us-ascii?Q?95lhygd2V6njo5ciKewmXV4WiYVcOPGXyAv0YKd/Lehng6zDirvwk6oKwEMC?=
 =?us-ascii?Q?OWTBsx7Jmhw9Hj6AJHCazB2a2rE6kqWMpywh7Yd4HMYLzbEvleycx74qLB49?=
 =?us-ascii?Q?v9uJ6M3ENOpZ1RljI2wKpf/KfgBQvvEB+VR1hFy3uoiscNCk22EAYprfFBXK?=
 =?us-ascii?Q?KCvJzvf/UUhUr8SG68YhmfE5Qq16iO4u4fEyi1KpuBehEKag5Rf29avAO1j/?=
 =?us-ascii?Q?yEJSoOAOO0V0ppvCBos7cVgcJymV8mbUwxgI2RaIOPjmSBRX71k84jIT2hl4?=
 =?us-ascii?Q?4DRoffIj+SuVyoplAMm7Ye/7l7ZyTrO73FOCkwhocmHVQ5vL2/AuLS0GKFGo?=
 =?us-ascii?Q?FWqR4q7s5OgqwoaRqumLrQnVxv29jUsF9KE0Xp/6tbUCtvIa9Wcg8A3ptlbi?=
 =?us-ascii?Q?hyM5D1kOX3si/aV+ZSvVNHOBWIt7/moiaftZg+3WbEsTMxxkcB1EluFlAdOz?=
 =?us-ascii?Q?1Z12nk8/+kTpnBh1m/JhWtynfTnxIutaX8DuXiCZSEzT+E9zbwVFR56lDRP6?=
 =?us-ascii?Q?ZLMQk0mZFrTd1wcsTSFNDqku4Vmfqf4bIjpv2VOkuktUsS0fZsUO81DJ38Jm?=
 =?us-ascii?Q?7l+1tasmer9bCQpCyN4kkgCo46rfnFi5hqXP64SSybP5UVOdmU8w0+0Nc+zO?=
 =?us-ascii?Q?wpLEabLvzl47oaZA0DltTbI8gOpa07dC5CTPeIhmkJh2/twTjASxsnPJO5gi?=
 =?us-ascii?Q?vNMFJj9U9wwrI6V382yOd2eZ0zKrUFsuNbiSeyjT94BpialOhR8IfdRevsd+?=
 =?us-ascii?Q?jHG//+IqjeLr2j7HKxTmFmjIaMi0k2KpdciEMBrRI+F6u0FqMDxWS/nVrqMu?=
 =?us-ascii?Q?V9KurrnAOHcOIYbq9VAJiQXUVljPF2QTm/AesPQcKsoQNS5k9g0ThoAPgUGm?=
 =?us-ascii?Q?BZKazmuLlLFPLvylgBHqvELIc+UyFSITy8I99WK/7NIDDk19EIUjwt9SYmvB?=
 =?us-ascii?Q?ITEg36nZvp0eS6iOq5fPm2YT8XgOXPspCQCBfY5yqifDvk7XH3Wbsuog3K2D?=
 =?us-ascii?Q?X8cdFXVFdscHNUaIc1I6PKMcf97OhjEEg1oSbMznnt3f6v3s5xuRIX/2B7jI?=
 =?us-ascii?Q?2xXsqYwbqzPLKsGiZNSZUCOCqoJu9OsZdbRU+k2/TQbyLunh7cDqsjZM6v4q?=
 =?us-ascii?Q?FE4ViYD2JKqBUO/bKD1uoFSryloUzx9II4N5bvIH8XkJTUI3cZyeeFmSRg6G?=
 =?us-ascii?Q?gnT5BQuAgISQdpAsETi3NeyBuiUYKOh+5Y9YOQJseK7kcTNcsIRC1A+DIL2B?=
 =?us-ascii?Q?WXXT6sK1EnDeLpXGUVSbI7fFyr1z82EM9z9EqCg1s9BXaxqFOszM4b3RNbSh?=
 =?us-ascii?Q?Q8c7jac6DP2+LfLNyzDuOQ6cp5Qt9d4DasiznOP+RMrTJ3tWFn1XtgGKsqqa?=
 =?us-ascii?Q?I0dU36FiWTUWGA/PVTdY9AQy61owWOR8KisLgPIB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fc5f65-8f55-4ff2-80ea-08dccdc54ace
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:10:42.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWW3aPYfzzcVCa5jPG6oWKtpuNqj7He61vQ2UyFFdjw3Y9ZHJQlS0ufRZJzmJi0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

On Tue, Aug 27, 2024 at 09:59:46AM -0700, Nicolin Chen wrote:
> With a VIOMMU object, use space can flush any IOMMU related cache that can
> be directed using the viommu. It is similar to IOMMU_HWPT_INVALIDATE uAPI,
> but can cover a wider range than IOTLB, such as device cache or desciprtor
> cache.
> 
> Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id,
> and reuse the IOMMU_HWPT_INVALIDATE uAPI for VIOMMU invalidations. Driver
> can define a different structure for VIOMMU invalidations v.s. HWPT ones.
> 
> Update the uAPI, kdoc, and selftest case accordingly.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 32 +++++++++++++++++++------
>  include/uapi/linux/iommufd.h            |  9 ++++---
>  tools/testing/selftests/iommu/iommufd.c |  4 ++--
>  3 files changed, 33 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

