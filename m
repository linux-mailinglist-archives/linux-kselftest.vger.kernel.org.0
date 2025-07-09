Return-Path: <linux-kselftest+bounces-36846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EEFAFEFEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C51E1C469BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3B22B8A5;
	Wed,  9 Jul 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLvco79b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BC21C190;
	Wed,  9 Jul 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082406; cv=fail; b=sUluAhgTjf11LwexTcUtLfiOdSGlujkv1tEUp42q1QUWcvdw/c+Nf2n19rRV2c8tLl2DzCzyXnhpUFKUYp5Drz4KKfUG4OOlb0J8aCeFEod3U5PRbCyZSPERKwh0ISDAgYea0VUJ/dRVUCb8ADocMpmCDd2h09+tp4Bix+dqaiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082406; c=relaxed/simple;
	bh=hqa7VjyNrqtU3yOvn6DhRmycOGnSIoAUionLR/lB2uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSMleLye8MOrvILhGpS1+Fon7OuxXfZMgZVWl177I68JyIyzPSkXonL8i7jQfF/P1byCF6vBVf99naG0Q3QGJDRNQ4w0+1zVKW8imrRI2YZU6Qwc/aFpogMDt622MkKU/pDDqtULh3IMsYufTeEtXiJ+psWeyv0HWpAA75z/Qsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLvco79b; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peJVFHBs/2fX+H3FMbWXIX+yW9iweMBTV+mBhv83ERiypaLoFXTsnKfBLWPVk4YhXgfNeHDczF/6+ABsBLYsqmxkm/28es42yJu0GJO8YJCj9Q8q4mk1stLYRDDVvLUzu11bdwupcxQ/FfZ2oP+HP7f6yG4/o6YEjEyvGlL36FCIxna+z7wru67C8o1ar2ykxJQmcUf5BD0R4TBLgzR1dS8R77DwldK2ezCu8DeOjwEj6SWVJyBXhOZch2c76BFZqvBs3OsGGtN2cZzYTE6UoKjXiER7Uwr2AxTGidqPe0RAQcVd/9oyn7kf7DMoaWDEBIrPS7p1ZB8hNZFXCw+zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZk8eGKfHG0HChVyvqbRrRfcoMbhwUsxRnXD5DZKlQg=;
 b=lfmAj8Vfp5t4/NYHE7xhO6oxU+muKC1UeXpVZpX6lsF8I87czmESkrcEc/U85+WNmnv6qUQlVEDv2fpXdO0b4FEqzKNc2v6snAtwS6jg1VU3zKk+MwSWJEVlu7PD6WqRxdtnMttN253meXMuxJ+DX5Q7Dzn1QxPGHjpRf/fhqg7YxcVh08gwBiYnbW7KUQoE5MqZ6UnW+HOoAUJ8aGsNK9iLjPb5/V2YEWtslHLRZAKuComHP9U9qZ4IJITPy71OqCDSwy6KYfOeP1kG0s6n1VPpfDUFwUQcLjPeiiyCaUdq8ETgavMpXCAS+HxuHcfP2afwuQsTCAV33528DwPspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZk8eGKfHG0HChVyvqbRrRfcoMbhwUsxRnXD5DZKlQg=;
 b=JLvco79b4basN7XVqO/5DZN9kiw/oLwK/dx0qIkuMMjrsmlDaTdynkdoYsHhZV50WmH5ObyDbsBJNwsVehWUw4wnIJNBJkwEcNaWqhffLkHPtsrWn/gm73RAMnm0ICgdqiWRlhhrWqND+egPu4+NxjBYShx/yFmpRIiA2HR35qAiJgzr7CGJxspjgmWLDefn+m9bxKa/Jby100adaEQD1OmWQPTvJrrb1APTAaLQi7HveRhMwQXKIEqZMJMv30N1uUi9eqaqdRK0BofttkGBV3W34oPIVb88TbrxUKBcSi559l1vAirVCrLDsCUvXa91CFZECiDO4UcXfboWXNDBgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 17:33:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 17:33:20 +0000
Date: Wed, 9 Jul 2025 14:33:18 -0300
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
Subject: Re: [PATCH v8 00/29] iommufd: Add vIOMMU infrastructure (Part-4 HW
 QUEUE)
Message-ID: <20250709173318.GI1599700@nvidia.com>
References: <cover.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751677708.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 1707478e-63d9-4b2d-d037-08ddbf0eb23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vguLbaPAFiMnaKh6Y6NjVwdaArcAVVJwe7diGzp571PEpaPbRR1D6IZQ7Kt5?=
 =?us-ascii?Q?iLmAw80ngefVLIFaiHUDuM2x7cdN1EGbDeX15bP2ofR7e1I4iszXv24VohA0?=
 =?us-ascii?Q?LF5QTYX7h3qtpOWvKnc7KTwYkOra7OMiMl1LbfTTZ+EUwUSYeP/RU5Zm+HyG?=
 =?us-ascii?Q?21WqOoBUy+aubMMSQ81zLFQZIPEkN8L1v540ylyqYPbwrRoKiFcA/NHLjxT3?=
 =?us-ascii?Q?pjz+VkJXnOleXKpp8YI/B/P8z2/f0F7U/Vn6nx0lXMCUXzk9HPszEg5C0lMG?=
 =?us-ascii?Q?XN1wkiDjnM6Xh+aU442KNViXG0JX7j8r3OGDjCZ/t9XyMGn8fk0cvYcJQGqL?=
 =?us-ascii?Q?5BnbagizvrfdcMHm6yxIdTEHF3p/oL0ngRIAYYYTSHH9J/T1R9wRdLNU+VvV?=
 =?us-ascii?Q?SmQwQEuIIY8pZflndXHomIzWZCZJGVY4PJLYNLVG6J1lquQmjD5O8ShbUoyL?=
 =?us-ascii?Q?GGWItzNGl0KoU0yKKijLNNvQH1X5ZxA1I0WyqNhOQgHI7YT3jRqUCbvEJG5J?=
 =?us-ascii?Q?Xb7wW7SRF0b2xooT7Ld6cCDrh24zQJ5lexQPBvipqlPlt970zpes0ZupaIdv?=
 =?us-ascii?Q?GKah82DAjZ5aePtIPfiB7bOuN6HiEYTR/ZrusMlhZ48eMkA/kNJ++wvae8Gl?=
 =?us-ascii?Q?U8WhRSCeEJd/Z6sppfUynrXEKTpMV3HSMAVv5xnceXSjzChAr2Ht6lluYm96?=
 =?us-ascii?Q?ABmOSVuP8eLLMdCirvuToUA5ivb6Pq5PhtMY5G0FtrAPQxWShNONHqo3YXVp?=
 =?us-ascii?Q?b02mKkPTVI00OubBelYzOjI8wFsl2c9RYBVHBOoehe0HXe64/fKqOo1YE1N6?=
 =?us-ascii?Q?rFChhSxeV7U32I+d2MUa7hIEUPcaQYkiQDH9xMYoxop6oePARuZ3dCITvEfo?=
 =?us-ascii?Q?RQmsdka8eUBbVX1uOd5zHpRYMofRyvmJMJ+5wakCpZc5PNxiW0o4v3Y8z2SJ?=
 =?us-ascii?Q?XSfYyFKWklVCq90LViXwf6SbjGZbkH/iZmfDmkWcqpavihRhsQsb976MawT9?=
 =?us-ascii?Q?AM26Sjk0mtAAtYPlLmuJ+bIWPct4v7fZgp4LLXXXIetf98ep8I/BTgyE6Z6E?=
 =?us-ascii?Q?4vOvOaFCAFRRK70bMQ3z47KCFxBpi/NjJ/7Xk2KA3Xa6/drG2X/WGSELaSmC?=
 =?us-ascii?Q?6VcjxUFcdvzvr8GYU0ga0W3OvrQ8LRzNDawWVY676yWEozvnJgzcXIzp29Lu?=
 =?us-ascii?Q?raj/tKzB/xdpnMIaxgXeMR3j1CUd5amEbEed0R15opBoV1vBsj2Bf9oaPofp?=
 =?us-ascii?Q?X4KkLjm9eFQN26bjcb+8tlktiPukqBZF8m5IJjQQ/CQYuRMqxZRvsC/mLXVD?=
 =?us-ascii?Q?JRkLMzcqOgCdSlLzDXlfdRXuy/Qbj5tY2xgTYMvopvrtbUG5g1OAWbKtykzl?=
 =?us-ascii?Q?/KtWP0A/maV930rEwvWRbLNQZbU4gsGdPlaMjfm18y6f5I8uybTqxmSMLObF?=
 =?us-ascii?Q?C6OmJ00vBOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8F0ht+y6ZtvUgp0b4L3OAX1cGVArSyMjz/OtKqkZDhDX7eM0ZvbzyA6VeAHh?=
 =?us-ascii?Q?nTWbknEKmLFq1+pc5WhZbxa8PnGGm46Uf+K2vMDlSjE5yhDarACYvi2snkPA?=
 =?us-ascii?Q?YgQstWoujLLkLBR4ipP28uASpt0n+sEpJKWXxkiFo5Ky4KhmX60VvgrHmVg4?=
 =?us-ascii?Q?2fZh0DJuUVX1RGX+ydfqLH3lXcccGjfLVxHvgGElagpa8jrBu+iPb85QrxGi?=
 =?us-ascii?Q?CqHkfU6CHyPO5CHrtJmFElGQRw3714uABjeNVTN5IwfV7IZ0CrrxbvxiB8/f?=
 =?us-ascii?Q?LHDYx+8KzKHSQGa6W3lTVIEzEoVMqZFTfsRPupH9OXqMVH+AiiDrwShQORqU?=
 =?us-ascii?Q?g8D6j0IEDLQveLvDNfhUfMVqBEjkGc8ZZggSJTs0txNalAwcoYAnVoVxWRKX?=
 =?us-ascii?Q?HfjyUoH07PVz5Ut6/QmOuXNmqWfqn93cR7i5Q+nLTKyCLZHwaxfAiyA4d2RH?=
 =?us-ascii?Q?HXGao9E786MKK8X1aM5do2iLwlaNGv8unUS8Wr241WtJ7uyWoCTu2yA4+9J3?=
 =?us-ascii?Q?9qod4gUIjwsd3ljkuUa8dC/irq4WCuNHAE0ol4fFopXX8WFngT5G51/jWMtH?=
 =?us-ascii?Q?isPz8qihdyG4iFYLMZw+EUDfW/1K70htBY4CYdOipOzziBXXB/REHEO/9HL/?=
 =?us-ascii?Q?2UuvzGB8Cly0mBP40WeNi/y0dPZ85SN49F7WGlFOHREfgTl60+U2WuWNhbVx?=
 =?us-ascii?Q?mesrMO6d2KVWcGriHlBLZztcWNnGCKBFSXenWLiiAuLcpxYxTp3W7IGaacos?=
 =?us-ascii?Q?y8VBdVr5Q9SRdRZ9NeJoTgpapEdTF3JVAaWhL9ri+MM27Shlm5Wh/he9WrhE?=
 =?us-ascii?Q?Qvd4vLBAnn1ir/7NCebeFWD0PcxdmZTNOQqpMfpzeqrPjVUjQOBRPCucJ47R?=
 =?us-ascii?Q?1KYCLVP222f6cKpHP74XD7I1MH8ZmmedJ3GaWL9S8MoTWHdlK5EPexK6PxO6?=
 =?us-ascii?Q?hSWXxFjj0zn90V5HHpntlLNreSFMLHJaMAfURPChlVLvtnZjJD7aQL0+1a3g?=
 =?us-ascii?Q?gpBhyjhQR1fjYCDVv8aTuFp6mlGe94lqZaqNdWXTJlcwI7JdQaaR9MsUXftv?=
 =?us-ascii?Q?1V/5WFBuSf6gJe8NRsVP6kMtr/HBcSO1h+A2VUtKGpDAk7gMIzUke1rFyEvr?=
 =?us-ascii?Q?/vBQU4SGmfXrDZpgdPc1BQpHkuu9qc66Hc2bmelc2gMA7Zt3vhepA7yRBscP?=
 =?us-ascii?Q?udaKp0yslv9BDg7iAqrv+VnaVgy1IK6XrmxqMnM36N5QKW3NoIXidvThGHpe?=
 =?us-ascii?Q?6fk/G794ng8Uk00DxOkL5m76Kxn00W3Mq6ckOxefWGq6TXJuboCZhdRNctHd?=
 =?us-ascii?Q?aNyLnI99a0qATJLqqbnOW3P87aM+bC3jqZSjwthuvAJS5E41G+jmzKp2TykU?=
 =?us-ascii?Q?GemCglXSPCXyAL1I+lo2skdX2s78lcux9MdY17TMAF7a66DBM3hKpZqiBHny?=
 =?us-ascii?Q?aitDy05PXv+LrYuoj53vmROWmzFVnXwOK0ayFtXUw6FgxDPFHzmA9QnSJZHK?=
 =?us-ascii?Q?qrBdqbcfxoyki3H9fEEZwZ/IoWHrEhF/YmCz0hUeG9u3PQwPvDemMMcMNYc7?=
 =?us-ascii?Q?5qLsTXQfz+dr0N3bDvHGMc8MOf3OIcYHscta/v07?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1707478e-63d9-4b2d-d037-08ddbf0eb23c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 17:33:19.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t32kBUu/LoHe9UpddjsmPQSLg+8a0mIHTxb/VabrjDWZErClwxni6rD7qmJ3Zxs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

On Fri, Jul 04, 2025 at 06:13:16PM -0700, Nicolin Chen wrote:
> Nicolin Chen (29):
>   iommufd: Report unmapped bytes in the error path of
>     iopt_unmap_iova_range
>   iommufd: Correct virt_id kdoc at struct iommu_vdevice_alloc
>   iommufd/viommu: Explicitly define vdev->virt_id
>   iommu: Use enum iommu_hw_info_type for type in hw_info op
>   iommu: Add iommu_copy_struct_to_user helper
>   iommu: Pass in a driver-level user data structure to viommu_init op
>   iommufd/viommu: Allow driver-specific user data for a vIOMMU object
>   iommufd/selftest: Support user_data in mock_viommu_alloc
>   iommufd/selftest: Add coverage for viommu data
>   iommufd/access: Add internal APIs for HW queue to use
>   iommufd/access: Bypass access->ops->unmap for internal use
>   iommufd/viommu: Add driver-defined vDEVICE support
>   iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE and its related struct
>   iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
>   iommufd/driver: Add iommufd_hw_queue_depend/undepend() helpers
>   iommufd/selftest: Add coverage for IOMMUFD_CMD_HW_QUEUE_ALLOC
>   iommufd: Add mmap interface
>   iommufd/selftest: Add coverage for the new mmap interface
>   Documentation: userspace-api: iommufd: Update HW QUEUE
>   iommu: Allow an input type in hw_info op
>   iommufd: Allow an input data_type via iommu_hw_info
>   iommufd/selftest: Update hw_info coverage for an input data_type
>   iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type and vsmmu_init impl ops
>   iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
>   iommu/tegra241-cmdqv: Use request_threaded_irq
>   iommu/tegra241-cmdqv: Simplify deinit flow in
>     tegra241_cmdqv_remove_vintf()
>   iommu/tegra241-cmdqv: Do not statically map LVCMDQs
>   iommu/tegra241-cmdqv: Add user-space use support
>   iommu/tegra241-cmdqv: Add IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV support

I've dropped this in linux-next with the little fix I mentioned.

If there are further remarks before the merge window please send a v9

Thanks,
Jason

