Return-Path: <linux-kselftest+bounces-1310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BE807794
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FF1F214EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211EA36D;
	Wed,  6 Dec 2023 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Av/p3BCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198ED40;
	Wed,  6 Dec 2023 10:32:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfnBocwpyoOv+GCpWbasZuhvxvEFly9vX2MMlyEkXorF8VPaMJOMxwHnFmlx6/RvBgUxy7rZ+wIuD4LNBry/QdGgBikw/EDItQwWzQcgTrULQcVtZzdw+a7u/zZTsa5I3GQ3TkOS9qLSYoNmorsrfupgxWm+7yLs1TjEg/g8QJgMX2cDbcNrvsVsnvBvGXF7ArpD/gnLVxhMQll6Xp24rpisY6+I1AfsVvxFOVQmKLZtzz5IbG8JoB/ryA3J97e3HmivvLegu46tmPjsdIUCXK/Bn2tD8xWb7T3lSGmtvP0s2s3mk60F/5xGDE9zYuErqKrLgqVg0FXAv2uW/Nf3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASEAT9jBmCqkBackiVAIXVBcP11rwrA5tTsX4oQ88rQ=;
 b=gqKcH5bSxUnFU/2lvVXAok+l26kTq8vc+apQeWU+y+s0Id4dk4aNfhDZ1X8LfAYjfsGNYm83FiH9sT71ZJ1BoAudXa4s3KRuuzcUvU2IwejNPpmzeOBMuaOvKrQdGsp31Judxr1GKuTmvD5Wl1Hud1dNoWUsxC4M1Ma9raRsM+X0M89NS5CMadxe5bZX9Z5EV2UBn4HhhfI0K+pMs5d2XmmBz9mZPAxWhgXN6aZe+zhV37NKudUCY45bOdGU3EBoiRkKDP8nbLauhEtK3F4nVQ5K8eUvDu+SYQJo8lINMRtejqmYEkFp1WEg3KTq+mnofwdagESYGzI7Wj8i6JC0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASEAT9jBmCqkBackiVAIXVBcP11rwrA5tTsX4oQ88rQ=;
 b=Av/p3BCXrDdgD+JN6uC+X531+lAsp4H5nN06duuJ6duVmYRDJEfPB0FgYuxyEjygqpySSnKvPGgO/Y12Irzp9eQnfGVH9V7kuXOk3TokcMaeiHI2YNU3ZP2u0X18Uk/AxQnatkVUgeY5tjmgLocZCVVn+7G3/4qjFBJUkD1wRc4AppYVtqNpxmg6uV7dybuPFOUtt0xQYiC/SXZVknKZqEFAxQBb7u9biePB/CyyR1Hg+1PgBcnKOo+gdUiV1V957DVnUiDTduNnENvJ4iIHQiKhOqszGEJnBXp5LgoTWAVTGjCR2y+kZzat53fxWcGDturTlKcwkh55Uff9YtOTYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 18:32:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 18:32:10 +0000
Date: Wed, 6 Dec 2023 14:32:09 -0400
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
Subject: Re: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Message-ID: <20231206183209.GZ2692119@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130717.19875-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:208:234::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 960c16b9-eb15-44bb-42aa-08dbf689a8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6gY6ubHI8USWvvZlyy6CxhpQV9hisXYLeHyMe7IDYA+CX3bLcYKoSlqh9mWgJIBhCv0+z4u1a0PO5A+FAgH7GGPmwbBdySJTRMr7HRVkW7qXbFtgTexNV5uAc57d7CrnKkm80XpTGxvRry9OWHk4seRYE7Hm4xOxvYEjl0W3/E55Yqw4Jn6lsd4rSWiv6hC4f6Ao6yKZcrCtCLHox/yImiIhw19ThhoI0HNfkDefrmexW27AEcyc7aEzvd/wZasCXQpp25zH8aDpudfz3VdIMaUk49AZTjPoekCZyBpMqB0xSQyy3BNNdIOnjXr4xzi0TXuC2HZpkzigDXnz0IDN5hpNINZZy7hFJl5tZWwZN6KnmfHu2686sKIP+MXN5Twyg4dqSUYGHFBQF3snJtjgD4RTTpmavwcQUASDXTl13/Z22fnULbXqjlgBMI6r6j+c5p19CqsYbLsCVlUBZNf9xcoF2GCE4dCuzpzFloxcpBKWWspudwJRb2sqym2iLpWqzg78NL096W3Co1qTktD99CALZz7krmcybPuxHyei3Psv369GezFYzKN2WgbmGmF5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33656002)(2906002)(7416002)(5660300002)(36756003)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(6916009)(66476007)(66556008)(66946007)(38100700002)(6486002)(478600001)(1076003)(83380400001)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjFjst8kbYA9JuEeFxcLYS8g6EVpM2dhnqp9VKRdq9whttMELOOXbgRebHk2?=
 =?us-ascii?Q?dl9LLHcPxfsBtZnl43PNoQR70Gk1tQGO2IAn3PLfhE5mLXX+SdA4Lmz0/pVv?=
 =?us-ascii?Q?EnspZuiCkxnnB6yAcEJ/RzWf8M8eAWJwHwxrilUSx2lgCRjNxt6Xr4G45egB?=
 =?us-ascii?Q?k7xd6Ujr8zUtcczsvPpTNXV87M0CyFV/EGevbr4yEb+eaUnfa6gk1xxAwywQ?=
 =?us-ascii?Q?ojcAT8+N8GDx3eiXwifvYigAH+srJNwo+LwqEciaZv0Yf6uYt73LxNKOnpuQ?=
 =?us-ascii?Q?yiGeZdUX2Br86ksfsQki14/b2PO1zEROnD0Tx03Uv3lCixt79iPSMCAQsNHs?=
 =?us-ascii?Q?afr1epxeeNfiolNOmYTJrQ3XbUDEXIegTSywvDbX31lY3WQa/k1p7Fnkr3ja?=
 =?us-ascii?Q?LrOkHYT0GP/KLtFExrdqpvOtMYn9hlTVXc5slof9MG1sMJvavspMHM32YNth?=
 =?us-ascii?Q?oqZdNrgP42VBHxCbZmBuLNo5isrANCjp0oGPiUx9WLlJcC7uffC002OhXeWU?=
 =?us-ascii?Q?7aQrnsEzWYlIDztfjnKSmKAPMGBvGS9qq7F48sUqn2cYj09JTncPAZEUlR5Z?=
 =?us-ascii?Q?OfHZN+Y7OiKLDaFLOf3EjsQ/BznqvRYGyjyTBIwaJGL06JJINhypa4cFp/l+?=
 =?us-ascii?Q?t3b1MtCdp9RsrfwaFKPs92sjct/WTIz8yG23G+oSQMhAE9t8HutiFJLyC0ME?=
 =?us-ascii?Q?i/tEMNFuKSQ4Sz8Kad5/IJJ3+FcBuU8tiSFBnmS6Ha5kh+ZK+GH3udTLWbvt?=
 =?us-ascii?Q?+VilkZeFtI3m3J6rGRbEJHtZ85Fp3uKw3RK8qWpvygCcWxT18YbKsi0nz6zZ?=
 =?us-ascii?Q?M49JkTUZJsID30QjV6KYQbbzf/6sTWiZesPSuy4LmKxjGz1Jqw7hCqIC32dH?=
 =?us-ascii?Q?KCI+AfDNrCGXmAF/0FZ2JjGEhFenfjuwZO79NTrTGAiI0inPW7KUPsg82BWz?=
 =?us-ascii?Q?gx17RMHK+gd72HIm9DxDugRowH7yVQCJ7VcjROx8m1bc0eVwA/4Nujy1xzbi?=
 =?us-ascii?Q?1dGnmEtpQC7VPM5inoIWYr1sygWPzhI5IE1iD9PBJ3Ad2jQLpT1bPpaX5rJM?=
 =?us-ascii?Q?4jo9D02iuTIFfOixeBPdXuKDSjTStWKFdCL33Oto5FPwG/D2g/qG56saD/lM?=
 =?us-ascii?Q?LGKj3zoRUuINOAqj0etMPIzCF//qqwX1SefWCKBYZRt5ml3IA1Nv4n4XsUa3?=
 =?us-ascii?Q?RDfK8OJMHGbpCOaLbu/SimMbPMNThGLAXri4X29aBCz8Sthvdql1e+bKUt1P?=
 =?us-ascii?Q?8CaNIDdLkkBGhycSeuO0iTNJifcubzStAPiLjsaYR5fpS5ZNrJGMYn3/I8LJ?=
 =?us-ascii?Q?Pqp8wR+GpIekOfpdlCH3T+F6iJnfMqjKafejtgh0xLqs29JhGCVUAogt7Twg?=
 =?us-ascii?Q?k/1CyrAwW5sQud0aBDoMQPGgx2CVCOoTGkN0dljqWl6qVFyhtq3Zg06Rk4SS?=
 =?us-ascii?Q?Ys8gJjlspCnWKVR3Hs+/7bbYapKaqKoK+RY/RLQJ29gZmKnOCfaC1JwHei3A?=
 =?us-ascii?Q?rzdSDstqt4HrlH6HttLpW7ShCf9agvGgEn4msYJ/Q0209UkQ5hBZyHsJUl2p?=
 =?us-ascii?Q?8S7Hx5JCl2whaOiTtOMoEEC/bi8eObYrNxHW5WpL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960c16b9-eb15-44bb-42aa-08dbf689a8d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:32:10.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXuEgBsvmQCTAQ4SAc5Omd8oO1lRJERSU09BfYR0JiuLIrRXO2lEhNyuJPGNaai3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026

On Fri, Nov 17, 2023 at 05:07:12AM -0800, Yi Liu wrote:
> +/**
> + * struct iommu_user_data_array - iommu driver specific user space data array
> + * @type: The data type of all the entries in the user buffer array
> + * @uptr: Pointer to the user buffer array for copy_from_user()
> + * @entry_len: The fixed-width length of a entry in the array, in bytes
> + * @entry_num: The number of total entries in the array
> + *
> + * A array having a @entry_num number of @entry_len sized entries, each entry is
> + * user space data, an uAPI defined in include/uapi/linux/iommufd.h where @type
> + * is also defined as enum iommu_xyz_data_type.
> + */
> +struct iommu_user_data_array {
> +	unsigned int type;
> +	void __user *uptr;
> +	size_t entry_len;
> +	int entry_num;

These are u32 in the uapi, they should probably be u32 here
too. Otherwise we have to worry about truncation.

> @@ -465,6 +492,9 @@ struct iommu_domain_ops {
>  			      size_t size);
>  	void (*iotlb_sync)(struct iommu_domain *domain,
>  			   struct iommu_iotlb_gather *iotlb_gather);
> +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> +				     struct iommu_user_data_array *array,
> +				     u32 *error_code);

Regarding the other conversation I worry a u32 error_code is too small.

Unfortunately there is no obvious place to put something better so if
we reach it we will have to add more error_code space via normal
extension.

Maybe expand this to u64? That is 64 bits of error register data and
the consumer index. It should do for SMMUv3 at least?

Jason

