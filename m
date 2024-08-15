Return-Path: <linux-kselftest+bounces-15462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA161953DF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E0FB2344B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E94156668;
	Thu, 15 Aug 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkOJJPnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07918155C88;
	Thu, 15 Aug 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765002; cv=fail; b=YiYUqwCcDGR12g4ZHA+lclGjA8GHZ9ewZB4impk+tXCN67pFLC2b0z4TzYR4D1/5cgMWq0bhWxD9o0oAEknrVZwbXzMoxfWru2secgS3ADSr9zpiGkOi3qtquXhY0Nv+tKrZzLRbeFdwx5Eqn0M6eJZjlP+ewB/G+LX/xvxxD2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765002; c=relaxed/simple;
	bh=J2ZnhaicgD9Lmboce162qdzrABYbfrnLvkCIvbHg/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYo6Udn+aW4myYeAV1lFBrbiIBtw8Tvk/cviDD6rhrWmfuuVfjaCXsmOY7d/gvazWewRgpzWpO9yHmHyhWvmpE1dQd+ex0oer/Y/hAR/R6IqS6hqUaC24ALVxpU4pOCUBe4/qHEG8KYRRQjtxaj7v3aY6gJwbumvwSJ5eO9dDBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkOJJPnr; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTlXoLNVev9PbDrsrGF38W7fHMQBABmNHVGQCMi88+8MufNGgqFdaopiL+47MZy/Qc7SfCzIRL1iFLF+TyZt6a82Du/vQbaaTsvoQzobVqRxyHo8JDrxOlKlU+GUs07rcOdDV1uDl82zGG6tVC6yU0htRQqNaPhWrvKbNHrNo0YhaMAWQID1KzCvmcTj8Aeo7S+FPqXWf3n0eaH79xsyQqw433PVvJZnlxMb6EEAPRnqzy3ru8cA0AGxaKYtASqlmd1wyp9uaz5kcyZrom4J3VdZz+j/ed44iS5zcTbCrJpP5ZXqlhqPUPIN3Xb53d4CXBhLEXc4CKSeFcPQYae7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3kMfBiULXzkH9ELJtjL/OYtrMQli0vW1YrAxICj/pI=;
 b=F46kIhLpRRIFXbj+3KxWnjV6nCM9o9uGBafRpN2n7C8blM0vCqGplcNQRd6DmskL4NnrDrICBRQS14j/9oWK40AQQaz5TE3JS2gXTuu0y9X5rT4MekQhRGsA/son9ptECHo0DXsOcQaccu+Q1zP6tAXzk3q3HSxJOSLjJbLDK5NvxSYJnd7yOsgfw/R9G8Mdi6YmDvAbW44tmIXhAXRqp85A2TgKP/BEZdpjgS3SfSL6IwZeFNIn1258qX5qNsigd5n26YBHe83DdAuTCYbq8axB23g2JnkRaNdcJwHKytmqNu+wG883TBCIfyc5AuXM8YTJEbgLLUc44em3k3bB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3kMfBiULXzkH9ELJtjL/OYtrMQli0vW1YrAxICj/pI=;
 b=MkOJJPnraqWP7syJOUNBLqdU2mcRpcPpaLUP6u7YIJABXSqPaHF0zdJICn5Dh71eY0UK188Zeb9F7XX9Eqme5NYSi+FsgIP0XAvNzvKAk/andUAG9LgjArg0Zmm3l/1Ne4lIdzmPFvriUPe9S1QghD1bdZMhYjOIpBajltxLBRmpLHrOTCmF3PYt2JGWaBrYA9MKIwLNPrvBNAatTrRmR9xHv644VEGt/ALqrUeO6LhUulg1Jg0vBZTAAlnfMDrqamhjECu+Nb2laKR/5xjffh3VPmNRVpaRpqhDdwEc3rFdjLWT3zh+XyStazeeA+NF/zgpEtzsuO3bbSp8rZepfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 23:36:37 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:36:37 +0000
Date: Thu, 15 Aug 2024 20:36:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/16] iommu/arm-smmu-v3: Add viommu cache
 invalidation support
Message-ID: <20240815233635.GV2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729dfd0808f85d88fd3ef8bcea0168cc1d2c0d59.1723061378.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4db24b-99af-4232-b051-08dcbd831b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wem1k7h/ugDawDMcys+uApoOfSTzC8wTRe+0qArSsDIygTYp7bxPT67NYQqp?=
 =?us-ascii?Q?na5g7//y2NQj50Ud65QcOO4i4965TfjoQBWYVPlMJHYtmX9u6/mWcfmIVj+P?=
 =?us-ascii?Q?RqH+xAh7hkx+zkyXP6MfbRKWKjJOJY9BClFh0b1v09cZ1MUuSI0PB+SJiI9T?=
 =?us-ascii?Q?11xpfGsJ1HREqu83A0A7q5xp9tcWAinTV+sWoSssIlcZOLm2VNYwYeMAUt2s?=
 =?us-ascii?Q?LigJLEUCORkQh8a6JLu/5niCq+YCo1jmUgWJSi7vfwgBbL2JU3/pdHmjWX1a?=
 =?us-ascii?Q?22kbXZyQygoXMh7FvZDZvE1shknzzcSW8FlKMbL+lxIIia2T02vEhhguEiyi?=
 =?us-ascii?Q?8MVuhO2SDkiwwYiUyolxVJPL6YOwhghSEzMb69ztQU3CVtOIAuU6bCk3VJL2?=
 =?us-ascii?Q?DBnS8ecJqtg8TMHNVzVkvGHhThdJC8D5ZATxFKxy8frC46WXvQNYNtmM2Pd6?=
 =?us-ascii?Q?MzeebCWjLRVDYMKgAeO/t9ueQ1aKuHB3H+WO0CmJNYwMOtX0rKVZ+iHwANgn?=
 =?us-ascii?Q?7jiWgXXckMOeTLBRdCDolo+fLe+tLNzOeJZC++oDQUCZQSHzfo7hdy2gtlLu?=
 =?us-ascii?Q?2SsjGgEENUAuzp3SPTjAShGv7NkbQ4eF/UQQREw7Xe1J/kfnXh3L0Nxl8tKq?=
 =?us-ascii?Q?QmF0m8MHAiqZVzzAla7Yt8loWQPtYHVEh0NpQX7cX5+wypq6lyeo8tPjpl6c?=
 =?us-ascii?Q?bRj7zczP4fs5Zn1QcONo4wU5mIbs3VUtAn+faMu63CKbgZeE5oi5rnfQV2Kw?=
 =?us-ascii?Q?6Wt4VOFr27fxyV7Cl3sfmofdmG+dm0E1tDksedDajDFaNWFqrSfSkG3OWtUU?=
 =?us-ascii?Q?WR8XT8t5Vbd76H6+5ZlojcWhKeCYIFhYUk5pduXuZaAbIfIxKnOKuC2vRmib?=
 =?us-ascii?Q?4Ght/T+64b/iOef8HsC4z+BxFbw1F04ESX228z+jBezbdb7oegmGlom08HE/?=
 =?us-ascii?Q?wyKzb9CJgSduKgXmXBJ90YcqTRu31uRm3K2upYg0PIG/P19y1zEIlZXwYrNi?=
 =?us-ascii?Q?QvEKOQ2o67+lUdrbLx3dB/vauB8QSq2UX2MkN6Ls92ZhUIr3EFUkthka6j8M?=
 =?us-ascii?Q?LSriDeRjAMl3tsjBdv6yjJvahbAHmKerT/isRTXJmMTmQo7+eiS3KHxwMZeT?=
 =?us-ascii?Q?uQA7Vj/6yl4Zg3n5rYkT4VdvXwCnMOGTP2BPaQpSIrOeMRRFAsqcrV3D+Ula?=
 =?us-ascii?Q?tSxUSgMDRHtEWOoEvB9vXSZtJldrcCRo9x1AGIldxV+VpGnh9lJzp/WVAIA+?=
 =?us-ascii?Q?8gAP36VnSAVZuMQB+pQhHgVIZ831lu/8WvvMT4kB3zudgYWP3Dygp4lOk20i?=
 =?us-ascii?Q?nD9CrpU9YZIn0VCU1h99XmeXb+KAYn57MJIV1oH7A7VSuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pK/iYm6EXbRDKCE0C/cvlxT7sza+gt7K6zHT88XJbswRgzTx+cvc9/DKXYef?=
 =?us-ascii?Q?YmKBz3lpvVCAdIgYLRh4+xsOjLISogbUc3rYAKjPRAbmctLGItI6WYpBzxWV?=
 =?us-ascii?Q?U99lN8s75wQ4Tx2OtdziwwkL/BRgC5990G65VIEEOkcIip8b0Fzc6Wugmdzl?=
 =?us-ascii?Q?T76O2g+3GZAfqpEi8zdLp/s62p1OLUeWMirm1YpSBkAz7+AH5fm3QfVmTRT3?=
 =?us-ascii?Q?OIEjxbayKs+uxc/BlL9BOcafXssFHXPVbM2UrwauUDCQZQ3EaEFmlQUrWwag?=
 =?us-ascii?Q?Xd/ewIz4K4x3Hc47vxbbElcoDrRcYBRNTVNLp4iQgmQH1FoeHuMU3b7zEY8S?=
 =?us-ascii?Q?x/0nGs5j2BDhUiQfu/u+aQg8v0hT3kw4IQj9K5D7slcNaJ7agcc6U34jIeXi?=
 =?us-ascii?Q?rhVBvf+CgyxkrN2YNviUN+qoMk+pRxYz62gQwihmMbbrS9Ajkh/YH13S6pfP?=
 =?us-ascii?Q?yFOVHpdMyb9j6Q77DwtwWEgBTj9qy8v+SQCTlnN5jsf3YQiv3CNzr8W6MNaV?=
 =?us-ascii?Q?zJ6VnGscvtb7NPdLGez8t2dI2ScpiFynzBg1k10FKdgsR3MIwF+n5BcHL8Lx?=
 =?us-ascii?Q?RovZ646edS+YBYCznoCIZ0C/VNVW8VQjeMrX0FqWNCLEB3dp/MqFlT5LlDdx?=
 =?us-ascii?Q?rlQTyIopoGkvPJq7VN8cTFLggLdG9mPN17BteybuAmYnCg79zFuZLLvsJlH8?=
 =?us-ascii?Q?i8psS0b61DJTvzYWgrpOVcF8Mut23j3DUEyBEKYVQoPgEe3DuqlHjhLEFxkI?=
 =?us-ascii?Q?zktIuvNcXMp2ok6DRlwxt6Pjpg5nls4RU+U26jOxKKjSl1/Jv3DoYhqUe43x?=
 =?us-ascii?Q?igL8bIVO1BuRec6IImhV3hdnooTuZEs6ranr0/WsblMliOQI3p+0FLLw6N/T?=
 =?us-ascii?Q?WlGEFMGjWamdd82/Vn+UbV+cJsciGGU8rnsaAqC8ZsUv+mUtr0L6GR//BdA5?=
 =?us-ascii?Q?2hR1lHpUBwTxveQYc745Z0UTDJCKCCRo/R44ReSIR2ValZyoO1xJR9Rs5WZk?=
 =?us-ascii?Q?LIXeJA7GZ62D2gDBSWftJyZ5tZHD5jO+KZlU7z0MRDjA1ALZ7twBVBsoxrD2?=
 =?us-ascii?Q?dYI6fRQEYQIYh1CpDt8ogkdaZqEfXXBe0cHhD8YfPYwfZBAR9+icLwQCftQ3?=
 =?us-ascii?Q?KTDEB4SDbF44OL3Zxw028XyigQev54/5B8yUTqEHdiwKqIK1Zi2FE+uChJLF?=
 =?us-ascii?Q?wkUCtioVcPklLNNqvUV6eWswh9JmLMWtpbbpRPrKm7CYcZRz/7iJrfw+G1vM?=
 =?us-ascii?Q?KAouhMqy0fVyBf0wj8JoLDK+ekKkmOCaqbiEMSM1SGjerxUQ/tDSkkIwpljU?=
 =?us-ascii?Q?xnyjECQFU4WQThbt4S7o8G+VLxpPQhT/73FxiboX/397Fk0TqdAZH7eaf3cO?=
 =?us-ascii?Q?sLJzvPYJgpuYBjnile8RBvMnn8r7UlH6Vfv4tdUT1B0JNrBBcrTfLf/DC8WY?=
 =?us-ascii?Q?IpdakkYa6BUjzQx4akI9gHIlcg0fvcqHDn4YkA84lJBHq1joHfmFa9jxrkjR?=
 =?us-ascii?Q?9AC1QChMyFmD3XaMs2uNkm98IYm6iC4vcqKDFRp1NIuMSzTXs1Pvj2CQDIqK?=
 =?us-ascii?Q?wxrT2jbk5E+Bqttb9AI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4db24b-99af-4232-b051-08dcbd831b02
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:36:37.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdrQ9TCqfQ64BcDMQfg/8UFk55DIOabJ+laobmnu5BYBKxAXMntcmgi650TleNpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

On Wed, Aug 07, 2024 at 01:10:56PM -0700, Nicolin Chen wrote:
> Add an arm_smmu_viommu_cache_invalidate() function for user space to issue
> cache invalidation commands via viommu.
> 
> The viommu invalidation takes the same native format of a 128-bit command,
> as the hwpt invalidation. Thus, reuse the same driver data structure, but
> make it wider to accept CMDQ_OP_ATC_INV and CMDQ_OP_CFGI_CD{_ALL}.
> 
> Scan the commands against the supported ist and fix the VMIDs and SIDs.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 +++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  include/uapi/linux/iommufd.h                | 20 ++++++++
>  3 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ec76377d505c..be4f849f1a48 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3219,15 +3219,32 @@ static void arm_smmu_domain_nested_free(struct iommu_domain *domain)
>  	kfree(container_of(domain, struct arm_smmu_nested_domain, domain));
>  }
>  
> +static int arm_smmu_convert_viommu_vdev_id(struct iommufd_viommu *viommu,
> +					   u32 vdev_id, u32 *sid)
> +{
> +	struct arm_smmu_master *master;
> +	struct device *dev;
> +
> +	dev = iommufd_viommu_find_device(viommu, vdev_id);
> +	if (!dev)
> +		return -EIO;
> +	master = dev_iommu_priv_get(dev);
> +
> +	if (sid)
> +		*sid = master->streams[0].id;

See this is the thing that needs to be locked right

xa_lock()
dev = xa_load()
master = dev_iommu_priv_get(dev);
*sid =  master->streams[0].id;
xa_unlock()

Then no risk of dev going away under us.

> @@ -3249,6 +3266,19 @@ arm_smmu_convert_user_cmd(struct arm_smmu_domain *s2_parent,
>  		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
>  		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vmid);
>  		break;
> +	case CMDQ_OP_ATC_INV:
> +	case CMDQ_OP_CFGI_CD:
> +	case CMDQ_OP_CFGI_CD_ALL:

Oh, I didn't catch on that CD was needing this too.. :\

That makes the other op much more useless than I expected. I really
wanted to break these two series apart.

Maybe we need to drop the hwpt invalidation from the other series and
aim to merge this all together through the iommufd tree.

Jason

