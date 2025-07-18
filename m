Return-Path: <linux-kselftest+bounces-37541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55656B099EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 04:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD543B793A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 02:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BCF1C3BEB;
	Fri, 18 Jul 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSYBk9ri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF2189906;
	Fri, 18 Jul 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806779; cv=fail; b=lzziF4MELX1BuC8ZWyssoxp/JoiuuJ2f2xqnDZMpq+d231mIKe46al0flhWuXiJMUn4RRPhOs8Y+b7OxExBGmmExaVasKJQ/fk0ES7vdCdIKAoqOwRcf3wQpNvxMBTkAe9TOcgIEhKwSBWMk+feE2a1U33oOB3p1m0ypd/e+YNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806779; c=relaxed/simple;
	bh=s3zhjWVK89Vq3ztI/frYrZD4vVt+W36lNeVd82u8yXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaaOMkDFByCW0qRnzefITVAhMxFghukX3N+RqtFX0MhbSSt/HWiylfDor1vbI8vVbpBlIKXhVnLTkbIiaEQ4Dijy81lwhXFByMBilDi3C0VteVdUUNmrjPA1zvBV1eX9yrtykfU7/9QRtMcoF0To5Ma4z6mEoefkrjbkLSY89wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSYBk9ri; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN0+RfsF2uhlPm99t0B5kVCfULgZbl9TBiMS8PNXc30yOp68YpnEv3OFwpWw5MmJcMATBzc/Pi2zYnfap9aDtD9PLYaJ/zP1IxGMFd+J9GTwSgq866BpbKV4HwCHeXZN0GUnhQsrsIILLP60Cjt91Mo+/7vqaRyKjTuaRtfEr+QmbLQc73/Q6pA4jWpkkQZ225zz1yMjdw8Agwuue/40pQQkODnA7zU0ph3z51NaB35TPIIz/oIVLomL6KdfOpTAteOYr2hSxjuXI37qt0QQ2D8BOPyVjGC6o8DSnKsZGxURRoqfzHCmjL7LD79cJhMfc0peB6jYx2Lw/mzxDJThOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXVyvQsBCmUjIjt8itUCvxkt2b1xHkmM/8/7q6iBnPA=;
 b=pMm1A5AjRVfN7kLq0gyfQw7KPlwBdLE+jztQeDghjJnBaHz3cGxjSo1uoH6itODsnkKC0trCUj/7BzI3XCAEQd58uyFRtof1p/0WuHmCj+M0Pb11xeZYWkEG3Pzq4f59Rq5UksBM1FzZ6iFTpIA9TlxEXKW3EBms3UTZOidab2vzz0yyY0jx2uYfGCreaItPb21NT1wQaHL2933/N7tz0ct7NwYs21jbhY9i1Icr8yEejET0E8e36YgLxwrx/oYQU+tWVF1eezzlpi5pwf0L6tlVlizWh3gSrMahvO9wxOXylvitniF+CqPZYxIwIGPmmJGAAv8oShhGzTQzt4YTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXVyvQsBCmUjIjt8itUCvxkt2b1xHkmM/8/7q6iBnPA=;
 b=qSYBk9ri0qOrqe/GfEw8tCxW4maJw4wu9nP1vlV6MdNOHMEt87GgWBLgJXDLU9IUInRqherj0zg14iCj6UUu2qbCCoQTpOm/jZ9kL88r6dY/tfRB61o/H3QKZwfNGnD7WyPIFewNRwdSutQ8qMFaGh+TnFNSCIJvoY2wz6gd4FkIbsqSsZOgnAO98D0CdbBUv1Fku3N4Cwp3ieFctqIzbqlzXN6Hjl9N9VICbU2w4gUrTjpSx4jUIIoLBmBPagqHfenxD/1zIjWpkJDP4L9w6SiuFxrXx61Cbn/lr/RhI2ZoW131s6bKZNPmoJqsqICMdMNqb+HT+3JRviPEtNDSaw==
Received: from MW4PR04CA0375.namprd04.prod.outlook.com (2603:10b6:303:81::20)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 02:46:13 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::d8) by MW4PR04CA0375.outlook.office365.com
 (2603:10b6:303:81::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 02:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 02:46:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 19:45:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 19:45:47 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 17 Jul 2025 19:45:46 -0700
Date: Thu, 17 Jul 2025 19:45:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, <patches@lists.linux.dev>,
	<stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b503fc-ca8c-4a03-0790-08ddc5a54283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HUT/Ezk2VjVRzuRvKHF2LR6gg5fnyVnQCvYyh/v6CFzOQHaLKpfzNrXa9QO?=
 =?us-ascii?Q?wLZzQk53PnchUINJAylbLQ7rd7HnINvLyZFweewjQ9b1vLpmwUSbA0UUHWIA?=
 =?us-ascii?Q?UEdBwg3oW494CcBsT6SPDeNTqigV3mIv003aanyXR7UxTbC1xuBPJIczpHpB?=
 =?us-ascii?Q?46Sk4GbomGsHExHJAyIGu4fbzxA3ev15d1X0xOb/cYx06UFNTa38her9ai5P?=
 =?us-ascii?Q?KzTQX6agDU2nVSycVjqPZ2TI5NQ+h5d6Z5PLBjF9eFbUR6RYeoC31vQvaM5n?=
 =?us-ascii?Q?AgQgF7LUn4KCX7JcV/cV8y7IuofnGjEcFK2Krg3RMl8uBvMAbo/8b1aqs0M4?=
 =?us-ascii?Q?8eYMN56FZVwRaSvkQ9o9RZ0/4Wt6ECDoWmLO39NQaxpyDlgoQfFjASYgn42P?=
 =?us-ascii?Q?+mW2agG15YDgEC+CX/AbEJdTkIl+D1BmAxuFVQjJ0850RPhtqxxfjwzS/38T?=
 =?us-ascii?Q?77Oyo+QQMTfwWSxDPMF3755OqL7IobIKdkW4By2mZnsdKykIEOLzkzYaxmwE?=
 =?us-ascii?Q?imRHUYTKTv6CRCaJQNHaWLmzHLSNufktwEJHpBFBq5dPUcR17PsdMxnO4m2a?=
 =?us-ascii?Q?dcp6VgGVvqkvnB/VFfvaWQZnh36qiAKapzN0MmJxliozLv7KtYLkPHWDVuXn?=
 =?us-ascii?Q?P/EQJ6bIVCqmTb3ZObg3ITmI7pTT4ryuD7/5QJxyoib0fE4sapycZlcCPYtl?=
 =?us-ascii?Q?xJUXps9HdzlF1SIP8rEr/SQVPOCZaE+t2b+ANv+EHcvlDP8eMTncRIrArswV?=
 =?us-ascii?Q?rBJGh0w+zzkW9yNsOiuYbcSlAvMxSlogpWakOzpRooraedswxU4SxXIcANX0?=
 =?us-ascii?Q?bCvFVm4CtLgv6w1SFMLz0/kTI3KeWU8bvX+qJ5X2X07dvvGTMFSzS5R4hLOA?=
 =?us-ascii?Q?SUWGoEH/iDSkTeF8BnK0LEy53ImZwdMk0jygtZIWHD2kJf1nEEq0hlsk6m5V?=
 =?us-ascii?Q?bkTSrymml/DnggsKnjwibR+j0v/TMlvE1AqwwHprlSw88JjMAlT20nveTIy/?=
 =?us-ascii?Q?PFafv6eoDFYTsD59Oe0xMS7KvpnuBcnNPKhYqIfullEdq719tRSY2cdU3jmB?=
 =?us-ascii?Q?P4kmo7iIi2Tl09sVa0hVahyEalxSAvBgc7YJTavk+95HEBaqADAPVclijGRL?=
 =?us-ascii?Q?kkwKbAccXwrpogqLpZaEwBLd/43ZWMgK/13roevO9U2BuqQ9GZtOpf3KUSz/?=
 =?us-ascii?Q?CE32+H7gnneF7//MnKTRn7P9RaaLds1cjulunO3LdNlVLIPbK/MTT0e/jtsu?=
 =?us-ascii?Q?WezLi1GET/2A31GHsrfxSXlo15VcrJHAkCbs4CKS95WvcP6wUX8ZMOUw/tLs?=
 =?us-ascii?Q?qNCYGDDikbC4mTLZDEKbDSpN2p/QBZFrGKZbzSIW7ecQsulDBxvuYnDdzgbt?=
 =?us-ascii?Q?XyRTNz03zh80HIOllQk7HPmcRih6beJvsz8nmEEjZR00Peo8klGRj7HrTh+5?=
 =?us-ascii?Q?jI6lnlQ8kviqvcy2ju691MMHfIZB6bqGI8SDNhzaMDl+evOBscZsXBpZBOK/?=
 =?us-ascii?Q?2Yr+6l9zmjdEBukXJKRJptIG2v2QL3QXRG9P?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 02:46:13.2001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b503fc-ca8c-4a03-0790-08ddc5a54283
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

On Thu, Jul 17, 2025 at 04:15:09PM -0300, Jason Gunthorpe wrote:

> +TEST_F(iommufd_ioas, reserved_overflow)
> +{
> +	struct iommu_test_cmd test_cmd = {
> +		.size = sizeof(test_cmd),
> +		.op = IOMMU_TEST_OP_ADD_RESERVED,
> +		.id = self->ioas_id,
> +		.add_reserved = { .start = 6,
> +				  .length = 0xffffffffffff8001 },
> +	};
> +	__u64 iova;
> +
> +	ASSERT_EQ(0,
> +		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
> +			&test_cmd));
> +	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);

When:
PAGE_SIZE=SZ_64K = 0x10000
MOCK_PAGE_SIZE = PAGE_SIZE / 2 = 0x8000

This likely fails the alignment test, returning -EINVAL instead:

# iommufd.c:988:reserved_overflow:Expected 28 (28) == errno (22)
# reserved_overflow: Test failed
#          FAIL  iommufd_ioas.mock_domain_limit.reserved_overflow

So, I think we'd have to pick a number aligned to MOCK_PAGE_SIZE?
e.g. changing to 0x18000 for example can pass.

Thanks
Nicolin

