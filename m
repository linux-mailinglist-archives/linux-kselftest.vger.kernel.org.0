Return-Path: <linux-kselftest+bounces-1306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B860B807760
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397DB1F211A0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB816E5A2;
	Wed,  6 Dec 2023 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SzNvZRGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8218D;
	Wed,  6 Dec 2023 10:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwj2baAOmcLCN1n3dmXObCLchli8fzmTThjSMaHMI43u85VzW4ht2QXYES4s4J8tMlh8CKJ9cX3GxMU++uJhHkq3UxLfRLhxmkNenTP3v2HDYSxDYOjzUZvHvufEdZ4/CO9FdD9PIWqGeNZdfgZ8hQCkqDGhmHS5Hke9zzFNzEA5cOOSm/LD/oTM+HIzXjiVceyuS4fpFZi0teQPumoaaugJ4RglvGjwEehx6YqA7fKWNRPy93YLpwZDV5Kn5o3hryMCT42FE9EUWgktfaqliWvi8g26tp16Y4AEtEduu0Y8aAmI0oMVGVW80cYcUJB+haLZWUOhpeMFc5AZdjyrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5vbd8Qcti6CTZErBmuMZ80/9bUgK22lc24goIQ9LnA=;
 b=oWyQxZTlHN0kerbizeAAcu/l0YZ9bs1MDoCRb7yvFpK4Nigik3IFrdS/J8RJZXHGzlJys1qiC8ztWLxfG//BvL+Pm3XtY5G6U0afUriK75npD6EZmDLpT5TGzFAQi5nAZCafn1QV16aTw8aqSHzlAUZM9w6rdCbvKBQ7kpT11Ub0kt4gBCPAiYP0kI6o/RvP8WYCIU4mZlbXrZ+bzVazjL4PqNjHJ4r2pVU16knlmbKiOp8isPP0XiSfclhhPi/g/ZoFChEfwMSFRyw/vCsGg6R8Fp3wp6otTmB7WyH22wE0mlhAHXpJ5Fm5LRgJXcNYDkp94ByvxcATym5SnIvYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5vbd8Qcti6CTZErBmuMZ80/9bUgK22lc24goIQ9LnA=;
 b=SzNvZRGowmzDQMn2hdJfjgfzpNR0vaE40Q4/+niEbeCUmGx3ywHR5ryPS6Mx2rbBioozYhruxIRrTb4izbHAKaqtArzBC2m3HUiUnnox2KVfqj5i50/AvmfvESU3crCqJQnSqe8F1p9XKbEfVmUM/93hdHbOZ1qkAihTbojze+0SuLGyUFZ/EroIqNxSzAPqrdW/qGob4Yck9FJVLIA/Ls7SHKKwMDGOCfztxuL52vzrdwdvGkuTYQY7AQuyG8vahenjpl1CUYV3SLxb756q9uyIzeX0KT8SKPaWwF7refxoeA6+MNe7x8ZWqrUcAmFYqIJzzAnidMj0u6nPdBDV1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:16:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:16:37 +0000
Date: Wed, 6 Dec 2023 14:16:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
	xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 4/6] iommufd/selftest: Add
 mock_domain_cache_invalidate_user support
Message-ID: <20231206181636.GX2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-5-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c04468b-bf3b-4825-bc4e-08dbf6877c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BW13batBTqnzg4/SHuFraHq/iDKlPF241S/fnysBgNysleAG8SV7v3v1ZmawuZSQucCvigRjaGkJhhZ1ttwoOD+n453/p7AkNn69dAHsUFxZ4sdu17LPYAXIj8zMuKnsAJRoM7geT3el26j+hMGZ2OUzrRuJMiQNxI2Rgkppg8HUYF/9f774p3ppusVMxH/pc3rHNULV0YK4gyn9gRU2o0L2RTphL9gD2rG9fi0eeY7TZQnVL4UeVho5ZquNRuX/c9FbCgCU2ggBHj0aR05ZytUqJfYoliUNR6fCQGbs+u3OfJKEJckrwYULxXigtAn4z5xlmbw7g1Zd+lpAuz1LuJRDwPvkGmHcluFlNMNoyQl8PCJViFYqxCtaegdwh9+wSPhUWqcILN8nIMDjrJ5gWmahSVtEP+6avdRdjh5VHthtZ+FiJ7pXO4zTrTheL0P0qHBRb0NlQtcwlgyBDeGbnSYFDas2seyy8U44ChMmYZjK1/WzTS7O8OAXY7WPIz7KYvAYNtWLQwmzivhxRTfZ/rXZ6mezXHrjsPrJbJw73SGUUimeJAc9X0RrP9TVvEZV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(36756003)(7416002)(2906002)(4744005)(5660300002)(41300700001)(33656002)(6512007)(6506007)(26005)(1076003)(2616005)(478600001)(6486002)(83380400001)(38100700002)(8936002)(4326008)(8676002)(66556008)(66476007)(316002)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQh8d5eTuKkL0rJ/5H5hKeKhW0CWOYIQ6NSamGGUDufB0ezIbFxz85/lZuKw?=
 =?us-ascii?Q?9DDRGU8UPqnq0Pjp8NnL6oVu4PoA07uESWhBrWQ4yTiFlMyzavOeK8zAqqS/?=
 =?us-ascii?Q?JyJIc1ppNpI7NNj0Y8jPYAvp6HaQBHFRzqJWl1GF3gpWTk+VHLkulOQPD3PB?=
 =?us-ascii?Q?72+Q58HYd+/exznr9P1jv1SbPCOFnfOHgbFT/OAs1p437UbMmUZpPYDJ2uDa?=
 =?us-ascii?Q?MvQWUET45JNWH4HKE8TLSfLrjWP+ylcCFWG+B1m7WVM5rLFUNzcZPJRecBAR?=
 =?us-ascii?Q?audjySe78eUxg9hEr8/XzbDbpaGZKt7sJL5HU6wHmoUz0tXDPy2fyGxNw6oO?=
 =?us-ascii?Q?d1KXCbr97ArDqWBO80jq/yMVBKNPXMAwDHIoygKLjCJ5f0sWm2F//yu/HaqP?=
 =?us-ascii?Q?eI+FlRW78pc88/rb0GdAmU/RUfJT5fX8Qe+wAu7/a+fome6U5uBcJkcryVVI?=
 =?us-ascii?Q?cCkwsn4rd+pMXymWs0aEi62S2wyaFw937SsaHz+Twq6pIIrd5pyRSvQQZ7T+?=
 =?us-ascii?Q?CxKyqoIBhRl2+PI4yNvorADE6Ea+1dk8SlB4KlYCzi/05iFfbvjcpeC9SUae?=
 =?us-ascii?Q?RsFYE8+gBaHdWhHZSsvuZKaN9NKuX2Imn2wWX0isXsmiyoTbnj67IbIooEMz?=
 =?us-ascii?Q?h/sYuM+y/72GVfuLfsF07B/O++Ar0+QSGQxP8/iDsU0W/znFMgse8pVromg2?=
 =?us-ascii?Q?sgD8QYI9oUDDGten8zbf+tASMpK2zv+aEmmMu55hGIsAY1eUO/Y8rxZrjW9W?=
 =?us-ascii?Q?XDUlCHqKtfhnoVlT2d9RamT+FLGXDDzKjEBd9wj1uWEQ2zxlEYOMrCvWOAmY?=
 =?us-ascii?Q?K5zDVQm/uAaQ0WkBWVkezxhl1wQ26CKvz/XGbACb0TNiPHITuLdXB532zwyK?=
 =?us-ascii?Q?iEH+iRFzNeabkamAWlpdw4izhkbtsffHT82r7ruoMWLPtJwPHUZz5luo0kK3?=
 =?us-ascii?Q?y+qur82ZT5Qo7SQKj4ifRqKNXi19D3y4oLjdbXYFjlF4Xpi4169i1dtFcvT8?=
 =?us-ascii?Q?QM/P8oStzpeJKX9u+d4fbiAVAxd2EoYSLvk/R30g7gB+GPpLfZvOQWClWps7?=
 =?us-ascii?Q?cBrTM+fZkERzk7k8DnLgRxbx+GdO5Xlc0VSjATYUvSmlzamqXwK0tFjzmUTT?=
 =?us-ascii?Q?L9wz+DgRGWVN5pz2Natz6nojJoODB8BY8b3Aq/+d+t4DrwvJt2TNhpHfJsSO?=
 =?us-ascii?Q?rOZN8LdJl0jBOLRx3Vza38c5q9q18QD/8VXIexQpYyzEc+LXfVcABnDZLHPx?=
 =?us-ascii?Q?C7OMHXlTvaybOK+wZupczPjHRVVFXDLRNC8DRasYwCAkKIcI+ttTt+j+M4Lo?=
 =?us-ascii?Q?Vr9uorltPs/rpiVjq4jwDSGdJA5NoyUMn2vNB7sf+VV1btFFORKsOHeOiVEl?=
 =?us-ascii?Q?DkJCBaAicawIe1h5dtcu2kfIpG60gcdOjA3WfBaCPO7f6urmTRTQdit/Kdml?=
 =?us-ascii?Q?RPZO4vvqkVFKquYwLJ/SlM1WcezZ7QAOhrijaJ3YvnH70x0DJtSeXk5PsRDE?=
 =?us-ascii?Q?PCNTksx/+4NUverivaPWv+11YkhOwTGQN6kAx1TNJz5isqNzBY6RhRgxu8XR?=
 =?us-ascii?Q?q0pBXrdJqcXKCWGlYoHVreoIYBpdx7m7MYW9L7qK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c04468b-bf3b-4825-bc4e-08dbf6877c61
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:16:37.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CIhDhtlT7BQ6Ckbhqu5Jdby8FDeZolj/WACk8VJm3sCGDlbgpUTF16/eEYD0+7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On Fri, Nov 17, 2023 at 05:07:15AM -0800, Yi Liu wrote:
> +static int
> +mock_domain_cache_invalidate_user(struct iommu_domain *domain,
> +				  struct iommu_user_data_array *array,
> +				  u32 *error_code)
> +{
> +	struct mock_iommu_domain_nested *mock_nested =
> +		container_of(domain, struct mock_iommu_domain_nested, domain);
> +	struct iommu_hwpt_invalidate_selftest inv;
> +	int rc = 0;
> +	int i, j;
> +
> +	if (domain->type != IOMMU_DOMAIN_NESTED)
> +		return -EINVAL;

The core code already checked this, and it is only present on
domain_nested_ops so it is checked twice already..

Jason

