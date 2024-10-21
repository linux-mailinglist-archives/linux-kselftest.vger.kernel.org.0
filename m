Return-Path: <linux-kselftest+bounces-20295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917D9A7241
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C79D1F21174
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E81F8936;
	Mon, 21 Oct 2024 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VIE6YMRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0E194AF6;
	Mon, 21 Oct 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535139; cv=fail; b=JTIG8+guQL5mB8Oi7okvcvZSuIAHuVFHld8cOeV2hXfK3FGf+ja7kT9AFOB9hjabriyhFa1X+szhMPJzTt9umcBfcZyACPK/wQ50RaCte6UO86x9zY06ndZN6rJzZMZ2WvBRmLF4zISW47/l1UYBH6UfWOrXT9nfChhlYT0si/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535139; c=relaxed/simple;
	bh=s3SHXtyXcKsrs611MZF66I8I9IE5wIok86iTs6NotTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWOPLYfdWF2dueY61vLqb8LGdnziFFTPWnmVzjP7E9Af8wQCs3iOMGEQSQvzX0llPWe8i5/wlMLAInX78z19fNXBRTjKVFFymSiMnBeVCLZySfHjQ16x1jU0SrEn5k+X1bAKDS4/hfMtkfnY2PpCVlMlilQ3X2wPjlYepT5eMvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VIE6YMRw; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaWYEsNJbPn/VNFTcWdvH9hwoU8s8iEiOUAoNzVzqIMohpKDkmRjkXOvn4KJbBn0LAmYTKg14A/2hV/RVxOfWJFIgIk8IuAB1tUkKqJACAE3z7dyI36d/mKZe5YSXdWJEOBCF0Ihe9h/4CFdJIWsBZOF0ecLid8EVvLfnrSt3V+nk5hqmlEr38Qs7hQoaznVCCI0LK9rkdcp2GMpAYRBq22AZMXJW+F4/UdOyJzy1kcn8Tvsvi5IGt98hyZy5dk8k3qeOQfCse9IsHSko3TX4DJmeAQ4alg0HgAiTeu2nbCzfGP+Lp17nW5z2VhI0Ek6oEolZNUjUbYEy0ajyQfGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/AMYvkrWkvtYGVWRPRo1Bt/DfTS42ENqBwBTRp80W4=;
 b=kuOPRF42N2WZqYuSf/jRaw5mHCiKva6HugqjQRCx5NYCn9iJ0f5oMhNPhB1oStCUVa12pApHac4+FMysvE5uPiTJyHSjfF3Sy9EE3/gfq3OVwAWWK8fLoAOszVC9EPdXhBgX7hQ3+9a4GumdLll/X+ElDWrxNCXYfUGdxtHfjvbHzdZy5WrJxPtJ8hO1xS+LUbpOnOIlJKEB6miWriE7XjWtBdoIDqJLOqVeb04zgWu718o4gzf1Vo2LsO5w9uQE9iFr7JNVqZOmukLFvejrCbegezLwj9Zk1239YbmrKdjjSmmKCBkZe9CorZ/4Vx7CtBNelQueHq0P6GGs0p1k3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/AMYvkrWkvtYGVWRPRo1Bt/DfTS42ENqBwBTRp80W4=;
 b=VIE6YMRwaD7YaJeqTk7/zXwBzH7YjFXV5BsYfewl/KLz8i+1DdJaIFT6yKa7ZQXtMiIazoueCs43PR5KNy1bjAA07RuXtzSremMbqdEIE/+vxAoXE51TuhG55tIxzCepzGQuFWWfQ/Jjcbo1FAxTGmvn/Zo7H5DuR9UN/m8ixtsHIJCHxJrycj/XLIGTwi6Q+f8iSfeYKEub04FIGy5N3E5ekY79I2wTHMfMAa1V4NksdM9TAq+Z+/8FnaOpC8cOkX+pGvrtaUoYHYcaYMVDjUyXgPgWTYyMxTAH5mawKSacGd4BupSCY/RRZaC4FxdGcEbAYBt+zJW6tUctBNQnUg==
Received: from SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::28)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:25:33 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b7) by SA1P222CA0072.outlook.office365.com
 (2603:10b6:806:2c1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 18:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:25:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:25:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:25:10 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 11:25:09 -0700
Date: Mon, 21 Oct 2024 11:25:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 09/11] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Message-ID: <ZxachACC51yHqDme@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <320e7f6a93f50d00d7273ad8a2f06be928a6ed35.1728491453.git.nicolinc@nvidia.com>
 <7f808273-a920-4937-9693-68d4a1557491@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f808273-a920-4937-9693-68d4a1557491@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2e143a-f1c4-45a0-a348-08dcf1fdc04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+itt/0fA7h6/RJtE+ph9Ery0FQwcjj9vEjsoFMtzkstwXL2X4fAF4YRI0f7z?=
 =?us-ascii?Q?oIc87m2F/puSqCtX+s14nfWUrRBfHeGLXGAnyEXWYifjH4E5h5yCFiUgkWF1?=
 =?us-ascii?Q?L7yUHNri9j5oDcoJYMa5JmU3oJZpa0A1gMT9+mHzpdfOo39QoXK03xINx7Zn?=
 =?us-ascii?Q?YYYqHTCrwgOILdtjVKMdmxQZT84TVHlrbDfeZhf28Ne27uE4M6DkpRFTRPQs?=
 =?us-ascii?Q?kXIu8cP8paS/mOhm/jo7Xx4EAMRa6uXV/T2MiKiYwGSCFQvlolLOiZldn6ZO?=
 =?us-ascii?Q?TA/vmizNyuFLrJglgAd7khKCYMNZKnR6Bpf/7hMkjizCDqnZtcSt5ohWaa6j?=
 =?us-ascii?Q?u1sMmVG0BZWP4bES0HdjFGG4N+Q3djmKlHFTt8ZeUOG2UdxXQt7FBtH6M4RT?=
 =?us-ascii?Q?s0x9a+a/ilNDhEyY6c8cf41SIdHjompavgzJsgvGFAaBZnkYig6FYqkA8u4H?=
 =?us-ascii?Q?DsJFtaK+UOQfYtpHz7Klv0P5zreE1JPOfduSGqlZVcY2vtxcOXNpnTncDA6S?=
 =?us-ascii?Q?EFpgQA7tQwuP0k8m6PdPdUc+2kqjwE1ddafkz3R+SpJG4pIsV9JBNrV0FkyH?=
 =?us-ascii?Q?mDA/gaqZi08UEc6bagoFH6xcALlY/FeKoL+/9vpcHWVQQCGN7DYc0vZl2BDA?=
 =?us-ascii?Q?nttUigl+rjYQspDVEZC7/puKQl5uQWF8Jn8SHCLkhQfrxl5lo/NVw4swBDlP?=
 =?us-ascii?Q?Hpkqu8vh2eMM6QmzpWojKiaMOmdx7LNBuLk5vkydvdDR2GhL+6nWGO6zUM9S?=
 =?us-ascii?Q?MeFLohKhIscSXClwncb0vn/EmzyMXrh6w7jRxPBgm5IMuKjQ3YO4/m/N+5qs?=
 =?us-ascii?Q?SbMGVmWSclicF8j/+tm6GM9ix5czgnDHF9edF6KlPxXJpZtW5m3z3EYViHKf?=
 =?us-ascii?Q?esQTT0UrvMgvif35kotht63VgWEEtLjt2kwStK5L1Cbve9b+51LA7TUFZZcg?=
 =?us-ascii?Q?tY1iKn+gBgz3iLDAPi5MAKtzRknA8ukpViS8y7/DsixqDj0xH46TjNB9TYmx?=
 =?us-ascii?Q?tmb24faLfvpTe/QR+Ks+xQz+GCCH5x8GscO0hInwlt/3Vjx56VPY4VahLS0C?=
 =?us-ascii?Q?yiNkQ6P4Ih/MuetFu35exsGtyKFoJ2Po98XrZ3NdD20F8Fgr1yakw9w3opkg?=
 =?us-ascii?Q?yUP17da+U0vFYMHF1J90don54a3FSAQ49YjHw1aHnI6xIzH2YEsys98zMa6f?=
 =?us-ascii?Q?ceiKrhf960tgF5V9V41JgNxbNrqxIfQcZLzmVrkNREOBWG5v45FjPyS+2fkA?=
 =?us-ascii?Q?Y2utQlMHMvNByEdPktjz/Bg1vZu2+nVJA+7lhd9FBT/C+lJfrcDgSoGspEmc?=
 =?us-ascii?Q?p9ZJunYcjByYxW/paOEkxL/zB+KfcW2OGzVpbMFesS4fTwiN3tDUzkictz1P?=
 =?us-ascii?Q?pTCkM+Z2S++kgx1gpK+L8Msm6emSmlXnp2RMecr2BIUYGKLo7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:25:33.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2e143a-f1c4-45a0-a348-08dcf1fdc04b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

On Mon, Oct 21, 2024 at 07:30:57PM +1100, Alexey Kardashevskiy wrote:
> On 10/10/24 03:38, Nicolin Chen wrote:
> > Add a new iommufd_viommu FIXTURE and setup it up with a vIOMMU object.
> > 
> > Any new vIOMMU feature will be added as a TEST_F under that.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >   tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++
> >   tools/testing/selftests/iommu/iommufd.c       | 84 +++++++++++++++++++
> >   2 files changed, 112 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> > index 40f6f14ce136..307d097db9dd 100644
> > --- a/tools/testing/selftests/iommu/iommufd_utils.h
> > +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> > @@ -762,3 +762,31 @@ static int _test_cmd_trigger_iopf(int fd, __u32 device_id, __u32 fault_fd)
> > 
> >   #define test_cmd_trigger_iopf(device_id, fault_fd) \
> >       ASSERT_EQ(0, _test_cmd_trigger_iopf(self->fd, device_id, fault_fd))
> > +
> > +static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
> > +                               __u32 type, __u32 flags, __u32 *viommu_id)
> > +{
> > +     struct iommu_viommu_alloc cmd = {
> > +             .size = sizeof(cmd),
> > +             .flags = flags,
> > +             .type = type,
> > +             .dev_id = device_id,
> > +             .hwpt_id = hwpt_id,
> > +     };
> > +     int ret;
> > +
> > +     ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
> > +     if (ret)
> > +             return ret;
> > +     if (viommu_id)
> 
> "if" can be dropped as viommu_id is always non-null in this test. Thanks,

I will change those negative tests to pass in NULL then..

Thanks
Nicolin

