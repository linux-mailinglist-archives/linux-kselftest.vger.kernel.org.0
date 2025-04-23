Return-Path: <linux-kselftest+bounces-31402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27629A98AB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4E83A6564
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4A13BC0C;
	Wed, 23 Apr 2025 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6Rusnp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03157C93;
	Wed, 23 Apr 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414311; cv=fail; b=TwwRMrwSuucHrlXZmaV/s2KhMVjjPBQiV4AMtGkxs92oItX4PBwqhIS/6jSBUWCwGDHIdmcAlWc/ffeRPQdo+AsXVjtpobjylqA4vPWYR0jggVhkYqMnE8Wa+UpHDDGmakoKPG+P7gYbgM5SfjxsrJ7z+/it/Rf7H5xwILR0M+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414311; c=relaxed/simple;
	bh=QrJlKBA9aHRFbQfeP48O4+YMrwuMEVjnCgrX8VN6o5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JejvxDSFxYRVbbxmjlRJqUkWDpPCmOpcZooLBh8CRlvKuZQ7DHlvWMUzdKFf9eC9PFK52uWK8UucN7hWWn80ycThOnvQZoRM3WunNNCw38mkJz3V/zRN2kJY4ipznaoZKmqhegidLAthUfgemlCTuDsyDHv60b4/nDk8eej+5dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P6Rusnp6; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B79cYZYVCSQz7P1dMdr3fnkmOUGkL2qmE9iCcGiyWlMwiLcgFCQR8hcDBJ2XXzeEWpl2TWF42VtaA9SzNi7EEGjAC8164BL/HVA11BDXE9QMCHG2U4+wEQFA+P7i1yQA9wdA4UIWw6Ijs6sNvB6Wn9dA7uLypC0po8dO3a5HhgdWTPkY3YiYRMe/buy75nqkEmYBcgfaOflJn1BDxeV54rFwCqKMzOk7tK2ipTMUSs5b6URqQZqP4OZ7GNvox2WdAp2qBXeRcdbAc9shMfp7WrrfsGikx6Rn7kU6LpzhIVBSXWirFj6eL7aWJ7jHIikdatOg5Q7O+zJ6kDbs+8wLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oas5oOEBrsnfuaihOItva4QCYq0d4RMbId11bpgoJs=;
 b=U7Icr7G0buz6MSRA1wa0HD2NPCy8ruonFtATmGJx1HAFJSrFHvgctN7pHu9XekXrLt0uHfT9YGF6tUzNt4s3HNCA1NNIlmj/SJrCD8SLBIgzl4XJA6Qo0aYLSLqJIN5qOeU+rOTcE2oxINB44gXoHLFap8+fP2HvVKl1NgT3rzHeCy4bPcqMTt2aAN9IR6YMqhSGStnZUuAWg+haVY/7llekQp5HL/zNpwo11kuo1n4tZlvclZ+hjO/UiN7mOFcfu3tCoP87eZyATdefpvhPKQCOOlXlX6ieY2QeBJyg3i2RdRSRQPhZtJvc+QP1JwAXqJeiwviapKOEVV0nLy9CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oas5oOEBrsnfuaihOItva4QCYq0d4RMbId11bpgoJs=;
 b=P6Rusnp644NsjSMXKggl3u6tHJ0ezpo1A2FVp2dhaAel1DZGzRJv979P2p0Tdrs/iB0vNACHeNtFZcHVtd0X0Q4huPdK9cxTIxnrq8VNlYbhnVFOAHlNXgfzfeXApG2Xf9UJZyRqIXsOkB/ShZZCikRg6jkmO2CmI8k7NPD+oLsanQGTjD7ZxmP5HuES4c2hgmUYBj78tr/eihNxXkh9HEWGdRiHeYoLMNXs4GHcfv3H4vh1a+o+rhHfk7+qnJdgXoDI6oSRcEsqzoX9K/VYjYkBY9QJ83b4WpD1jNn0CVAeA1t/2j/6pIdfAR5jFgkHDKbsyjftEp0s/Q9d0SV0mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.39; Wed, 23 Apr
 2025 13:18:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 13:18:27 +0000
Date: Wed, 23 Apr 2025 10:18:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	praan@google.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, jsnitsel@redhat.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 04/16] iommufd: Add iommufd_struct_destroy to revert
 iommufd_viommu_alloc
Message-ID: <20250423131825.GI1648741@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <c8fec9d1107c99e8c1db6c38ed520bf4a8a1b51d.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fec9d1107c99e8c1db6c38ed520bf4a8a1b51d.1744353300.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a72019-72fe-46e9-ef06-08dd8269552c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJ6eOSfuEr7C5tQfdV8Bynf2Z68i45ay5nLDNiNab03+bgVaFKpuS22q3o6U?=
 =?us-ascii?Q?5LP6Z2dMGb1AjQgm4rSM9iVE2BBCN/Tilr/UsE/MmdqWJE7Q6hSN96wWOMfv?=
 =?us-ascii?Q?6a1VaPjnOLCnG+IzUYJ/jXAhOaPi8C+HoUn8ocQfZuYr6+IDbM0OMqxdJuxS?=
 =?us-ascii?Q?abwhniDnoEovMfUCwcbfoXSgQk/es2qobhoAoslw50LtYf1Yt1iduu0J7qC+?=
 =?us-ascii?Q?4GymUDU/PXXtt7ngxOMBDWU678uyoFgGmei1cQGXeNMygRzYBgmq/7EojhxM?=
 =?us-ascii?Q?OzblqjM2sdEA/vdOjILgenABeZX7ZknQQFlHKGM/zcb+zXrUM38mYJXitYVM?=
 =?us-ascii?Q?K+TK9jNfX7Nxg2TQKfxvXBUMeQzoavKKIF8A+nw0ZSJDKI+xdHAZIL2n+IPh?=
 =?us-ascii?Q?4v83t79Cpp527qgFmmdWNFG7jtwEhQZ+Jf2JqvoYay896QA0UQLkyLu9KBRi?=
 =?us-ascii?Q?aAp1uRFT5y3rtU7t8iKFncb34Dtsfup770kMlWcySB6nkyfg/CKf1zWH1vZS?=
 =?us-ascii?Q?9tTViZ/233gnQZ7HDzccjubtDQXuTs2HlFiWEZWGMs6YlGyRocsVr4KGRjBp?=
 =?us-ascii?Q?fFg38hyqpr/PpdVLcXD4NpH9jtc4eS2teboE2r0OMC+zOMK4hwnV9K8x8Kcx?=
 =?us-ascii?Q?2VP+lg97/Ukg/uS32ijCXbjc+jotRMCYsIznpdTlTDT5ivSh4h6nlk72Msbg?=
 =?us-ascii?Q?KVdWzrPJccwjURPxvecwDH3BjiRcalBO0ekUeANGJI56y+g8rKkT9fgAbdG2?=
 =?us-ascii?Q?b6UaI4232orJVI17ZFIO8SFiKfEwEvIkf5vRZo9a/GC8fOrvBXM1Z13JSPiq?=
 =?us-ascii?Q?Rt01UfB2VBtNjFupP92wW8N+fZ4rCIVbe2hmfUAxE/jBEgy00iioKEjCxhtg?=
 =?us-ascii?Q?cly+JBriXp6y8I2uSi85TgJPAqRhdAbNfMlklHtb76QrF0f5nfzdX3fdwpqr?=
 =?us-ascii?Q?iNxfpNkm6MbsRP23P43CRuJDIh/q4z2KJ3dGCX7fefotnYL6D4Klu3TGzX/R?=
 =?us-ascii?Q?ONRE3xtrp7hkrLh7BqQ4ANTZfOoZUWoVWcoVcPa/RfE/pi/7uPcROR2cRahQ?=
 =?us-ascii?Q?CR/7sUXY2dba2TcVK9Uo4rQxaU4QL+I1/hS43AMVCEGxN4L9K5sAy9uecP1T?=
 =?us-ascii?Q?0RItc7IKQk+CcjCqVBEXFLqQe6Axz1LYL+YKwEBUzIWZOM/cDZVXktdKfZKW?=
 =?us-ascii?Q?ec+SGyHMmsweizwG34Cbk8lmZGI7pEB3AQY6Ur6wFgOMwlmMGliLApgQhNsL?=
 =?us-ascii?Q?r/uPKpKBIrgL2mVMjur3OTcBWplk3qVqEw+LwcGtYUlmx+PIWmNUOPMrRVhl?=
 =?us-ascii?Q?srz6rAcSoXFIIR//GmjKlTaoM2p9QfzSfxMNeWTc5BVzVlsZDs+dCb0dAICg?=
 =?us-ascii?Q?lyzNBPu3p5ogw04zS4Ueht1dGnWlAIgcp195rM5jqydqimC6JmBXFLBhYl61?=
 =?us-ascii?Q?w7/WN9ozgQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Ky1bUGpwosejCxM138331xWSTT9BOq0t2C9dFGP8SsYlqP7K8eVCEijCMok?=
 =?us-ascii?Q?4t4LZqh5vk8OAWLLeAHr3axxYBuwahG+FBjx8zFs5wpeU/Xa66NqWzTRN38b?=
 =?us-ascii?Q?VLhAXQybZlf2nXFCahJtt5Rmc4iXQUBV0pFdPVElGfYbbWA2PjG9UelfjJaX?=
 =?us-ascii?Q?lmiUxeRixNlCeNarSFCHQb3+YI4ewN/lPr5ZqrDeL4uKSz65hAqOgj80NNiB?=
 =?us-ascii?Q?2uofUjOf/SSJfx6p5HxT0g2bb57wE6SLD8rFCZ7h/N87lDFFhQjoN5cVKhGj?=
 =?us-ascii?Q?AZjwg13H5xY1PDaooQGbuvpXCsbYzkixymhxZf9kYwwXwTwgZhHmhDWhlsZZ?=
 =?us-ascii?Q?hOHGgwLI9SbWzFMQRBFWHOxtEjC+5eawts8XdvxYjbD9qCSPRA7oJ2+cmTBK?=
 =?us-ascii?Q?2vjeNzMEanQr4sFvtNt3MkAc0cp0l5xQETPvlEKmARRhSuoVlgQq67T10hQ9?=
 =?us-ascii?Q?VxYRPS1VlFBUOcw0a/LhPxWj0YcUAcB5V0f32EtbtmrHJ/l6HxUmDdQOzF1q?=
 =?us-ascii?Q?rECBT5IYJreH4lV7+Vm0XmU4rVcR9bM+nuwkFPVQO6xiK6fSuIeU5W2vNBHh?=
 =?us-ascii?Q?0tH8KSaJGvKSJT66tK2tgeTZ6SndlL5umLot4nVKU0mGpoUnB0aFlRddlZrY?=
 =?us-ascii?Q?i+bdBU8JpW3fKGIiC5jTmTEYIWWfRZyNNL/YabJWSDf/J5bS4iZQsIGVZT4B?=
 =?us-ascii?Q?ANohQxEH2Jh1YwzzGhHTTRoYffpV165yo5VLKZNEbKtSiT+Ik8mdwd8ONtMI?=
 =?us-ascii?Q?mtFrTK1z3uIN8gTuoEObUA3Q+sALD1r4hpYMD8mMQtEQD+Cuu/2lkpce6rxt?=
 =?us-ascii?Q?zpgINqMAHcF3kXUlzL3pjCgNtUdKjKI1koMvQ2wN6L1wfG336sdPqUr+VOH5?=
 =?us-ascii?Q?eneqf4ZYT9qZWoHguhB7An0Vmoqt4MZ3hBAxVFXx5I8pp3yoYLtI/IIJpUL3?=
 =?us-ascii?Q?9RHXJ0YmfxAOHdEwjDNXfE3crU6+Mf1NMN+g38jOJXQbH/pFBvY5eHe0DV4w?=
 =?us-ascii?Q?2ON/A+P0G1V8dN8MJwpSrDw+g1IoSQIwJlYyJhQlK1MaWtFVKx7UM5fh1f+f?=
 =?us-ascii?Q?ITrJ+q7Fv9g3nH4w/Mflq7r312b2ouva6cwoc7IXvJWJ762nNl859n3ebyTN?=
 =?us-ascii?Q?FQfDLYcEGoJ20xxp8lGzKc9kn8WgzpChxTIIBlhQnvDwwm1+ZNWMa3HPLVuU?=
 =?us-ascii?Q?xvlPBqURBZTv8F+8oRaqekuW43VK+zyIUbhbZ90DBbrmidtqiFZSeTcoiy31?=
 =?us-ascii?Q?G3QRApBuXnvkGO1Alk5cF++4+RIbRyIcRqvZIj/B4YVs5pnNiUCFV/si0pb+?=
 =?us-ascii?Q?Tun4BpWSQX7pXxaKyv/wrYd46VEo8RHxZwvI3kJwzx1ik8kvLEk6ZNyG20g5?=
 =?us-ascii?Q?CNPzSqDhH0aj9zaNHcByStuVwGRG15EalCgI8NXizYvkL/1T2hP1JJCxvtP5?=
 =?us-ascii?Q?YyJi7cRgRCim86icEDKfHwmTQcdIjAB98FDA/jKgkqmpWVE22FM4klyA+GGm?=
 =?us-ascii?Q?JAcgFP/ydn29unGIyIYdc8ZWCVtiTsqXLPuPwAsQi8ZIgyEvH3M5+TGDzTdH?=
 =?us-ascii?Q?56S6alpdUIw43zdhYXhRTA+CJkCC0JbrMylX2RpZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a72019-72fe-46e9-ef06-08dd8269552c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:18:27.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2MTcSqX/dBwRZ+irZA/uzxsiA6MSb6prHiIk93YGh4vOf7E/aa7C5opJrCS0HrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008

On Thu, Apr 10, 2025 at 11:37:43PM -0700, Nicolin Chen wrote:
> An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
> if it encounters an internal error after the allocation. So, there needs a
> destroy helper for drivers to use.
> 
> Move iommufd_object_abort() to the driver.c file and the public header, to
> introduce common iommufd_struct_destroy() helper that will abort all kinds
> of driver structures, not confined to iommufd_viommu but also the new ones
> being added by the following patches.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  1 -
>  include/linux/iommufd.h                 | 15 +++++++++++++++
>  drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
>  drivers/iommu/iommufd/main.c            | 13 -------------
>  4 files changed, 29 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

