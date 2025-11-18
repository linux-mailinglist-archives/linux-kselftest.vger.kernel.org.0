Return-Path: <linux-kselftest+bounces-45912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C7C6B6C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 20:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1585F4E2E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA42E1C57;
	Tue, 18 Nov 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gTocrXkh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337642D7387;
	Tue, 18 Nov 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493918; cv=fail; b=SP8mPYOFrxGtnUREGrUn9RUqzfTn2rROf2pyStVUzpJjDq30DUfCYgFGWfN54l1oCzo60khI5tEaCGQTkIcb/OcuP3bnZMYt+m/l7wNAE17saN3yRFxU+LqPl6PqdhSFGU5a/qu6l5ccEIk3GLzsp+BuJxouISdcvtrXwF2vyLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493918; c=relaxed/simple;
	bh=yQ/CjXqcLhqAMJASNyBFjrMzzZrr9aDAkFqP1U/GTYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/kc+Efe6s3Ent3MEtvz+hkqDEyBdnNUNf1e7UGbq6XaEx5L/ld5kQW8hMmnqyILOCxJyrEiPTDTvx4v1tl96UNXCIQ7bWH4L0mV869opuh9EbkQdIXT6sqowhr767vYkJvDGzaocY23lOIPxXSrcdS/+ujCj+hT+6ulFNimCMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gTocrXkh; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Szalit/YSRrR5R/ugURXq93e7t7aHo8ej85weGryTETFj3mg5IksDuSEKA3QJkddt+5gd/uN7Op6LVENGPRHuv4ZVmKsuaBczck8UJKYH0S9AOrKUhq/CPYnz1+LGoRbDjcku7tr5cCsGL6y1gzNlJuzv1ph7D+iMgal3FZ6/dJhF3hVh/icQDVYrs3RDniGTC3VD3V+Xanu4lhXD2RgBlzQIkM4hYF95oqTdVFBG2NF+eH2Da4FF6FVOMpAcVkjUJir4fJu5xMVNohNyEHToI9wsyLOLUW3Le8fYZvGRlbAkIL4v0O43Uk2sKqwUpOEfF/iLm0a0N1B/JOr50LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK7H83f+9zqXWZnIBktN0Bk6zUJibu41irz5864dZQA=;
 b=XB7YSejkzKnkJChV5UE9A9TtWNjR7bqMG23AGaPn5kQOXbyrz84oUyJy+NJK/cEOswXcwtbMwQG7/wdlH5+PAkM+Kkt63uqeWAjVJILBeGYUFdIZx43tg7LyyIojByZq0vPYoCqa5RZIvAVJVmRTLs64aO6nERtxrgnJLBcDbDzAxaQgF4tnjSjcez5M4hJtwFJJkw0MVY2m2VBS9OWoTlRW/k42Y+N8jQ7YVnFWopx5JqtQaI+269zTdNHh0UM1THJuJ/DoB/kQPIKVgPPbqdgkzHelVUzHDaGzf1yCdSwU3oHliap+1pWaVicVTQbJeca1AGhUpq8nGkASLMkQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK7H83f+9zqXWZnIBktN0Bk6zUJibu41irz5864dZQA=;
 b=gTocrXkhI+zHDxOSAXUKWS28Cmuzi9Ossa88RFN/giqteEZR40C8ywBJIiKgUB5pO1UlVEfiqOz5t4wX3y2o6a1ZN2HBg3kIlrP5M4H6abPNLCk9vxah1CffHDqGabqPxDHOIOehWJTojh3hUKZauuAlzJ+RH3h3mzMJnJ6ut0u4SEOvR4cRrcc7T8dYpjEv/zMhPAanrGoOrUL4KE5h9hZ4jINpQsHRj8pubI/znpK0mb74QpMIgzyeTb8+duJOLE99bhsKyB5BV3CtYIM1xYA5CivfigCV0ngtIs+mzcx1lF04SkPN6hHQ23HsLkD0WUYNpi4yA674LpVK5zHEHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:25:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:25:13 +0000
Date: Tue, 18 Nov 2025 15:25:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Matt Ochs <mochs@nvidia.com>,
	patches@lists.linux.dev, Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Message-ID: <20251118192512.GT10864@nvidia.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <9-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aQ5L/NXA+pYfK9zf@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ5L/NXA+pYfK9zf@Asurada-Nvidia>
X-ClientProxiedBy: BN1PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:408:e1::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 399bc6d9-7a44-48a6-bd2c-08de26d83253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c73CQ3nfS4k8OQj0Jj6WAiiyLMH1dZF4bV2F6NxvaExib3X1ROJZUrDLoVm9?=
 =?us-ascii?Q?fE7/lNmGIx1JSMr4SDLNxMCEeNgtHQMscep/NZMvDljkzGyLtCD6X76jFlLM?=
 =?us-ascii?Q?rMHEtbl101Nt5N5lWtvPQoA55lSvnsymLeUQynWgRll4lxhaFF1Jss5WYqeb?=
 =?us-ascii?Q?2PW6a+ryi68L61IxOIXcliB9h/BaITpKprRiOClQ+EbYAaw/JvzVU03Mc7qX?=
 =?us-ascii?Q?8i42yByDHFewGm/3zyUTLF0RIa+PlZQ3OJcVtkh7Z7cTv9rtbB3juj/ruOxp?=
 =?us-ascii?Q?m45dH7zBW4kwKAWqQvTTaGMKa533iLhQAwkqdqSurOLtJ5YG4RjLr1HbCTL0?=
 =?us-ascii?Q?Y/srmKGDSeoQGcAhyoJWTQukQ2JEjNTXevUMJEq4UcAHhYdF87LBmI99LNnb?=
 =?us-ascii?Q?d/LJxc+W1mzmlJqC4lJKn4NUHbwKQnPIMFCetVbvmKFzbvEI9j8WZBFWfb7A?=
 =?us-ascii?Q?IaG9O0etSsR505ySsyn8xapR45v6qdhTAY6+oCM58djevpRtIp82g84FqoWb?=
 =?us-ascii?Q?7v1amv6+w6uDYxeozcj0ro8/yiSBRun1fTXQi5v6Wf07DIZMq9/7G7wUmxyo?=
 =?us-ascii?Q?/tAxmxuUuzEIIELofrpVRAB/1LfhSdKFClCooTBxSuP6xcgz54MGvnmZg01E?=
 =?us-ascii?Q?wHiOg3xuUt7bszIqrTOhXP7kzMgOoMBcV0w1SbRHPmEwuge0uNcv09FFvmvH?=
 =?us-ascii?Q?oc964w3C5PL+ZjNHNdqGUwYbNLD8el8YR9RHVnDWFBpKc/xKDeHfy0WAYKvu?=
 =?us-ascii?Q?v1783vKfURXq2RX2ZqRuToeNZcCB7wJMEQh3tamOFOYtioJ05WVy7IKMdoEr?=
 =?us-ascii?Q?hHKXJqkIaLGaA1nKzwlg8XjuMoTbWl0gOedauChnVCHvWsiQIJHxF8mJeKfK?=
 =?us-ascii?Q?E064+dPL5l1xskipa6Lx8G9D0z1k2XdVJRLXZrtOf8uTObJkPqS9birAXUVs?=
 =?us-ascii?Q?7Y0csejWwfMT++7T2X68apoZMhOQguDdxquWw0Tekh6n2f1O8+XHQRn9cgBM?=
 =?us-ascii?Q?uAN5dvOw+YrhR4ivEzoE6lwI9ExZqchIWsXReU1ZwrzeU4xlaVlS2Cy+e2KY?=
 =?us-ascii?Q?xuKXDGNYMHNzHNui287DPTXB6bfle/xWTKqFyg+ch4sUv5OHmYwio7RD4Zqk?=
 =?us-ascii?Q?QrP7EWwXYf6pIqhmLEqsxaOx7kG2i3MvmFBDkhis8u0JAPFZGUxOa/fMMq2t?=
 =?us-ascii?Q?zRIgygtlf7FRpIaBHaUcrXCSnLn9f9SVMxpht6ePArJBapJQGo3VdTc0spcl?=
 =?us-ascii?Q?KyaQd0aTwBiWjmZ+0o1JRuLIRcDK/uZqDxcABCQjWk/RGuwMYsnFQR4yTImF?=
 =?us-ascii?Q?ACelMbfTQNmoOUKaYy789e+q/aAnwA4nc/43BsenFsAPgE3p4nCHv6j7+usy?=
 =?us-ascii?Q?00GdNHzJ7bbvh7o3TE6giI42GGazpum+5A9Zrvmelmowyuea2ouanWMQW7DH?=
 =?us-ascii?Q?MC8Y/5kA2ECcN7DdAed22c2HLfRjcEXw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+v9GOhHIcwPoZi7czPXFSYVKGnAjEyBw1E0htHLEENei0CRszPkQIS1VrIWn?=
 =?us-ascii?Q?y5O92//BtGmI3gJXymyw+1c0z9sysKeiu5I1SeZzlaQLhciZr5HlbrqMuSsH?=
 =?us-ascii?Q?r+WZ13TDGjONn3SA9zbOrnoftl/XsSOjFfQ6CwU8QWZAW2bPfpPoN3GMaGsj?=
 =?us-ascii?Q?hnec3W3kEemVmpwWh1NQwNDauR4qziWjcvSkZvqLPjqZTVdglZCgda5YYJg8?=
 =?us-ascii?Q?qmAXXiTbJt8WPIk4sovc2JSjbDhh1UsaZmsGgTHwqCL0aam/9ow0iAbsAt0P?=
 =?us-ascii?Q?uu/uP9xUWp4mld6gYuKokYIUqs2YB4SDC2xUZQ0ZAGoK4HEaBpEav1aDmEVq?=
 =?us-ascii?Q?pO/t/OY7FNkUJ4jIwTjC0HHXYh+r5c4tZNUvd8RJw1oPzidwlZnbWZZriqmA?=
 =?us-ascii?Q?hvq1lfkd6cpic11R44nEFgRZZ6NLxvuzujPlAFMVIEOZww/fxdNAIEg6YIIn?=
 =?us-ascii?Q?1XMpBBWuLAkzWXnlb7yxxOA3RVi9oUti/iwQze9Sk18E0FV8bS/qFUC0JGdu?=
 =?us-ascii?Q?QEU1cKsRYCR7uIVumvbGvv2kStToqVgsWxMKy3OddRbWxDmPkDhDprOn/LP6?=
 =?us-ascii?Q?E419VBrfJxTgxvu1k8oy1vld4FeJs36ygSb6oFOEg8znBpsW89Zieipgc3DC?=
 =?us-ascii?Q?B7iDssFXcObqsZqYC8JEmCyx90GzskvpWpa82gG1DzwI461yaIPaLsStqg6h?=
 =?us-ascii?Q?mv+1vzFijHKR6w9/jI8AvxhXv7kHSRYHlqJSB7svNvop1jBx6QaAKlW+hw7L?=
 =?us-ascii?Q?nV47nnFgJ6bPomNmavmqLsYE+HEBX60K3qbVsJWkM588ordwq3+Fpkdd5aSX?=
 =?us-ascii?Q?q/YEHrhGVRt6X1LVXxZKFvBefcItwqWzq8DpHyRwkjsD10S+lsBXppDmKHq2?=
 =?us-ascii?Q?pFUm6BNKycl1WjhJzqKFAlmQGdeAdihRVqwW86bUWIpnEZKCyjjmZ9kCElKv?=
 =?us-ascii?Q?UJEu2zwerDkUfeICCIKpCeyBAbAHAUE1PmrUO0/J3XasA+wIs5/TeNNhWPzo?=
 =?us-ascii?Q?MzPMsUvLTQmiIRI/+5jSC0Y2OVib+IjzxMtF1QudNMYJplNlvrsjtH/8btg0?=
 =?us-ascii?Q?u+aZEv+B5ghsODpdNqAlpqHnqFWCczlG8dZl8sUE4XyRgb1DVGXvgq+Nc2AH?=
 =?us-ascii?Q?mCC0Mg1fqP8M/SUqc35V1iT0iUPKpyxiTmseAu2TrbquxRIgcLIE7CDSwHvw?=
 =?us-ascii?Q?k7RhtGl3bNsTMSXGMKER3HSkT+ikfqUSdBdlN3tEGHmnqA+ApfhPk+L8Fusn?=
 =?us-ascii?Q?XyPLFSrbFCgkpRIhq/iHRnuULo1bdWEFgBdFA/zcivoqMCMyPNvWmpxRMOY8?=
 =?us-ascii?Q?0giilUXMjqJ54Xmre1VsdyQ0Bo8kLq09apsDMJ37GU47rSSGtc2H4gslq5O0?=
 =?us-ascii?Q?ryDzzleX2j5vOm6cr9IV2qOXjgQDtvnJsVsH1hdiv9y6eZYuqVq/NR5USHvv?=
 =?us-ascii?Q?KnumCe2lk/LcwftXV23LPAUtsfG4MnE+lMlMIQUt4VgTlN9gP3WkJZgMaZ3c?=
 =?us-ascii?Q?i1xfEBWJTGZK/lU5CweHvVTEIBHennKWNg+96Ts9If6h62eZioJzg9tfaR9J?=
 =?us-ascii?Q?mx98K6gvx+ay2wThCUE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399bc6d9-7a44-48a6-bd2c-08de26d83253
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:25:13.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UGGmHRutpizCL90cRD6ChUh53vNEKduAPYVRyGD1b37NshzlPsGONRwKyjGkqXi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

On Fri, Nov 07, 2025 at 11:43:56AM -0800, Nicolin Chen wrote:
> > +static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
> > +{
> > +	struct iommufd_test_dma_buf *priv = dmabuf->priv;
> > +
> > +	kfree(priv);
> > +}
> 
> Missing
> 	kfree(priv->memory);
> ?

Yes, thanks

Jason

