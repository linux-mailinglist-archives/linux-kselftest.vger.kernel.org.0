Return-Path: <linux-kselftest+bounces-27054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66781A3D435
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826A8177F00
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018B1EDA35;
	Thu, 20 Feb 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZpP3Sc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167B1EE01B;
	Thu, 20 Feb 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042606; cv=fail; b=RHxxQGf29a5CuBCF3X2GXAkQ5Gq2wKrUW0wk9GPJmMdGChhKG7yLSKy3RjtsQZkM6VeRN2gmOBJpZiq+Kz1sEXkMF7MK/GuJRs9uAyYSBKWjDWPkDaiP1S4NAdwuzXc1oAvD3/+8QLLrNUO+E6ujb2IMfg54OPlkumNsH39mNDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042606; c=relaxed/simple;
	bh=iKr1QiCJn2M4b5KXxUEP47dE5v40W9eWuoTP5rQkHEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlWKBSd0s34v4hCOQ8XtEvOuTv+cyPaDwzV/1VHqnj6wUxgKgUnER+be0erkh4FIc7lDTkh2iVKqw+xRzQGHV6IvDvZKpCbDpctjuDPJJZPTestCu68BBN3fTezfsyH/fyAs4+6UVSSyHU2CqcgP3lHo4/AheXjNjDUExnYQ+jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZpP3Sc7; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug9I+Cf9XgmYvEvCiTfoW1yeYFxn081VoBaQwMcvVl9ZIi7rjfFhoisg69ESegeesj43oCMlfh5wj4d3NU7wcMO+lAteerV4iQi1A7CsFNrfns0b986GFFhLCe5nOQFfuM/+Pr5aeb89pfBAcjbgzb7AMUhpakg0dN7FV8yyjHTrGyiauvlw/QCz1UyIVVhAxQqDGfHur7WcbwIe+Uq29uwieVQSofNOJGR5fmEF8Qi/OsARgaPsP4r2DAzK48cJNu06BHKBarTxL6zE3pEYNrdK6TVyWDx/IA/AR5LkLAbMJkKP/yQYU1RvppOP7R8fJkMNVX6mBoSdYT11fsiW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB4j2kiWPCZPvw7QqCRGZlMmeb+hsgzcLa/hXzGnXxk=;
 b=FrkuN6cdAa0nw9cPuAB28wrHfJT1OlUJ63rEllN0Zql2RrF91uMNjc4wQKl/9DkoQ/Wz9vIMCgx8wr1UosQ3ahcQqHL7i7OrdgVt+6gLSAaWeqZeCgz+ZOKcWKoit8uCL5VuIGqNV7IDWdzX4GGP7rD8pkMMZ7oxGJ9WgYzS6UZ09oT9zs/LuwNqQLcaFZ/xhvsovdeNhHRgJ9OnL1vOK0uGgr01hsNj+gHlk1RcMCdB56FIgs9kHObVUnjCkwQPf7xnTsxio6JsidrZMQ67WHrMSXUjfbF3H1TPN6GN0fm8xae7enu0VTI8ROTgSmoKsTKdwwC/7/znD7riLlFBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB4j2kiWPCZPvw7QqCRGZlMmeb+hsgzcLa/hXzGnXxk=;
 b=kZpP3Sc7XNIbgagW2wLh5rgthVUqVJdb070iDu37UXk+QZf+krwy0n7lo665HnjLRCJ6A6su7PyjXCy+oxljfjn3iiKR4vm+lb9RIFAHmDlYG3QRjgEZD7urwRSfzR8HibRbKsyXnJEr8ICVXsVVhMk0IKGgyPGdGb5MOtAc/7Qt9DJgkIOVWR4treDKeDGSRovu4B1FLvCz+CfQLYI1+E7iBosJzVvBbzSJq+XPiV5WplcEpGlKGBCffMJJZ/KWOu6qhTu4twlWhwLQ6gDHZ9nq2tj72AQGvNs8Xh103uEw+lfBKnEjBz0heOujoKMFFfcaQ0alJs1Kma77Ga5/dQ==
Received: from CY8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::17)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:10:00 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:47:cafe::5a) by CY8P220CA0031.outlook.office365.com
 (2603:10b6:930:47::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:09:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 01:09:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 01:09:42 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 01:09:41 -0800
Date: Thu, 20 Feb 2025 01:09:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7bxU3a0bc1i49Ip@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <436ac2021bb3d75114ca0e45f25a6a8257489d3b.1737754129.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: f2563b60-df2e-4e19-fe07-08dd518e5a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXpKN0JgNyvvH1ADrMqnCaR4QGJnw27ywdfKh/8JxNJhMfYpm9zIH6I69sUY?=
 =?us-ascii?Q?AozBNeS03g47yZMrygmCn6IEULJzuqYfkW8rYc2c92cmQolrPzDhd495rWmQ?=
 =?us-ascii?Q?YaH0iB8eyz+/svCVXOHk0Cdu9rPXAwmdrK5lradDtG86s64K13M4QQm1abza?=
 =?us-ascii?Q?XJ68mlgBk+kqqClbRVGd8KooNeUcdNrX8tfltzk3Y/8sz7b+Licakqh6Q2H4?=
 =?us-ascii?Q?Rd39MhqoK0yvbd6vocQlj3OdbHHmjpNvMCmvv4Je2k1nZ7Pw6mZeagRp0ZTl?=
 =?us-ascii?Q?l8pk1SdVQBPunp+8UOpUw1yAKo8HxUJzBAnoz9tmvWsrFmKVjTMhxDnywuyx?=
 =?us-ascii?Q?J0oyCnpb+mGh0PfRaS2AX3G7HnLdk5pDJgRBaUpfI4yiAqzrOxCbhqZeTzaN?=
 =?us-ascii?Q?NflZSV+SmghsLRyyaB/kJ+TTRdCAtTPLfeKGgKUUcRjdAN/bvBY5zuZcJSyj?=
 =?us-ascii?Q?Zw2o/O/WbM4imjiTzlzbuDs4V8NfffOiX0OYmZ6Rii5fSdRSdHy37Bupa5Bh?=
 =?us-ascii?Q?J69qnbaZ0LjlUL92KXliA2u88785jYZVS6waMYjQNBOWa2bmSNmk2A9U6Ikp?=
 =?us-ascii?Q?JZVBJKxRWTMXzQWoW1cQgSUHIuGq1+RU435Fs1CYR8d/yQU9AhXPYV6ANU3B?=
 =?us-ascii?Q?6nReP93NhgPIqj8RSfEIKTMLH+Er3beUrwhRZAKLP+hPAV+WR2/aVFQMnq8N?=
 =?us-ascii?Q?+U/Q7b5B9rGs5Rb81JabQAwYddwbXxTIBXl9i3UuFshBgUW+4X5YqeCfMQDc?=
 =?us-ascii?Q?lUHtWkRjJbUL8+8bJEeEbxUCCd9mGk3MNUbLJn/frUwS3iDVewMmIFKQ1imO?=
 =?us-ascii?Q?cDU9uRovHZtpgRTfySJFjaUNjzrnqsWkoTByA5id9XxxYMJl+dyaKjl0hhah?=
 =?us-ascii?Q?jcB8nn3FgUKXIB9BjXK9WTpPAFy0A5b1mb4w2Gp29QECvwTge0kc+nSIKf6r?=
 =?us-ascii?Q?iI1d/hnqK5ZYm5NesSJVGJuFTfizUFPu1RCBxahVtZHUMQ+MKNf7YIyKErjI?=
 =?us-ascii?Q?fkdVtMss2TmycgZsKFnlsNjNFTann9VLM5R5FI4i+Mm47MmW0ojExgVjwTRW?=
 =?us-ascii?Q?mzz4DxygrvG6d1oIglIPan+QgDv5fw6ohbTBODvSJxHRUR8+cDzvVvSMnZsp?=
 =?us-ascii?Q?xGw9qUXC5xpLNMqfPTpiMcjAj39DJdMcfkp1jsWJzECzNY3b5lQLadmqFtt1?=
 =?us-ascii?Q?IlHT+FaQ4NBYzxP6nZAjtXIXjlGVj4j16j1585HzQE4a84xK9NQPFMldKNPA?=
 =?us-ascii?Q?UKSmSCxZHLMiNhPaXfCXGSSOrqQMjZN/sb1ljFkv/UMgRJ3jvuB5MuOF19o1?=
 =?us-ascii?Q?dPuwvzAv5kE7OErfNXz+ayMKIvtGJPlpUYMcgcqHkCR3nmxVA6X4XxRK7mcQ?=
 =?us-ascii?Q?2vECmqTpbok7xNK8fhzqanpY2vDKI2YDJhjZBXgAoY9V0WBUHQ0YQ4C/9+Li?=
 =?us-ascii?Q?AcGMYzxJgEzUYO0Aw2xDHj2EmlG3xkiw2OtDZ1sqA1TsJd+Gv1KdDU0YV3wz?=
 =?us-ascii?Q?b36mUEk74ncEAHI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:09:59.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2563b60-df2e-4e19-fe07-08dd518e5a2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

On Fri, Jan 24, 2025 at 04:30:43PM -0800, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index ceeed907a714..20a0e39d7caa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -43,6 +43,8 @@ static void arm_smmu_make_nested_cd_table_ste(
>  	target->data[0] |= nested_domain->ste[0] &
>  			   ~cpu_to_le64(STRTAB_STE_0_CFG);
>  	target->data[1] |= nested_domain->ste[1];
> +	/* Merge events for DoS mitigations on eventq */
> +	target->data[1] |= STRTAB_STE_1_MEV;

This should have cpu_to_le64(). Fixed accordingly.

Thanks
Nicolin

