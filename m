Return-Path: <linux-kselftest+bounces-37587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F15CB0AA5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01821C4590F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2342E88B2;
	Fri, 18 Jul 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7h7h8W2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC22E889F;
	Fri, 18 Jul 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864655; cv=fail; b=uauVJ4BctIw4pm7GrF6eKaxa9ftiNlaN8E3t8vydN7pjYIiTBg6oAaYCz7bB3L/+ylfjSf6mTenG3Mte9i+cSbzsnpsshHHkJXNeN12mTqj1FPJhGcm+TDCilxQpaC+Fpcv/pIUsZLCaCT/BlBH/XStUKzvDmdK25SPTVbK55EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864655; c=relaxed/simple;
	bh=v1Suxdf4q3Nxjx0bVnOqV7+5KITm9Di2g1Mr2USR81g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw+Kmrqjf7Ec3vtfWGWN4VRwu80rliDYBituwlQUvt0HU/q4w3qtzp/3SbH4qaPPnpX6qa24Fup9Er9tLJjLE78Oql1nEgcJ5DNBsVAISoLnV4SE5vjBd9RX8Qd8/nmP/quILoT3X1d5j3MiCzGT/0NNwhniH7rg+JdzPmVLN3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7h7h8W2; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZLaaArotzdgd72osATc2hScO25zL3bGDBuBpbRgXx3vWtxPDjF5O/ISrmkHo8J35iJOI6DQOmDWNkLdF9GvQwI7LgUWYSoDxSWyfOz1jF6d4NY6u37wTwGPWrcq1/5opnct4Wb19RZAlFDErJ7zl/qyzuf6hamGEDal3Py/i4bh99pt9k7tdtliDmDQdqGl8cyKN9V4KZshwNZqz25ZPIaOBR4rdrvaF0oCXy23sP3DUl+WlxBfZ7yk2zPnl1xp8VAThMbdiK1CqNjyIQ8UrhiuACx6fQOC+R7YLsuandt+UkqKm+Vt4Plimj2S6T2kxHIty4tLJqpVZdMi+okMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30f6DdiM8avFiXqdZwudkmYm9NPVJ+QRBDHHrnKZlhI=;
 b=mPxA+7giB4BbLhNIMcD/sa8jMEfKlGNOirT1szoLc2yY+bXKLHg0JCD8HxcNxilRp+7pjgIJZGhB4M1OAml9VtmKz2JUexVz2HVr1DQEcWquMiNJvyE9OUVqeSKE6Eyun0nSzJdlswqJHn88Eabkej6NmIP7j8c/6SFppUEVUWX6cMmuPjwZ4QJIP/6c7282382xuYuk22MsoVKJ1Qrq3LDQ9n+ozQajFbbGXx+69tUNGQN+fWH2IMfu6TrgUn+y/uqeCQYtIJFBSSNwD0P5CfXrHn3IV4JAV9xpgGIOcysRG+2wBARe2ALRIwk/iQI5YsxNABWQuTVlRVZopZmJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30f6DdiM8avFiXqdZwudkmYm9NPVJ+QRBDHHrnKZlhI=;
 b=F7h7h8W2OpksWRfCiQQkfcGTLUOF4RFt8bRuo9yxC+7eLTygh9GkwbMhe6FI6+7lUfcWXXD/i4hTJt7+2+tz7HdS8PD8M/1nYhJ8xV4uuQPewkG2efsOW9FO6dAfns4tT3faG3ThwFRizsyr46vT2qg4uckJZtYJBv6ZWvateLVNmowSERxkZ4thwFlIUlUhp7KtiDq+Tn3w8K7AGppQ8Oc9/Gy3f8FCOdYbBRrEJcgN3lb8MB5B652EXHgMtB4WYC2Oh89VvpBq8RT2g4+IdLtbwkafalZo10BxzNjWrucGyCWEwPbRdWyVzIj7phxoDjX5qunoKw5iL5qMkK31Yw==
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 18:50:49 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::1c) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Fri,
 18 Jul 2025 18:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 18:50:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 11:50:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 11:50:33 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 11:50:32 -0700
Date: Fri, 18 Jul 2025 11:50:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, <patches@lists.linux.dev>,
	<stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <aHqXdjJbuO4e7r+X@Asurada-Nvidia>
References: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
 <aHm1WRAGgk/6HZMC@Asurada-Nvidia>
 <aHoCOnOAlwpoiDNe@Asurada-Nvidia>
 <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d18d7013-e82e-456a-87da-8acffc90d8db@arm.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: b42ba17e-3907-4226-98cd-08ddc62c0315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hU50cA0KGakVGY/+PnasQp7aINgV43WPgTdlfSB6L/XjGZbPUoag45LmCan?=
 =?us-ascii?Q?mo2gj1ziM1gebLA7HHvQamqZyteUYi5wdf+e2QC28nrW6LuTi0wafKjnBAyg?=
 =?us-ascii?Q?RW+zhBmo4zJpa8AVR5ixHckBvcVOo+I7NqPaI+vencVgVHNCCO405krp4aBm?=
 =?us-ascii?Q?ecl3plABTl0bFxfJ3Yk3CsPUn7+7c02zXUp7Hqpxy+EOxKd/w6/UZwOIaj/l?=
 =?us-ascii?Q?NPRQqBV7FxMJqR5Lmx6gWOHXwlv8l/OuxJicQyjfBQhV/JbMzxwTSjYKW+Rk?=
 =?us-ascii?Q?pTJBuPpBnmQJzH1s5C7aujBeGYtZ2Sh1AZMlqDLUJY+3vHGx+kV1ohLzW4vQ?=
 =?us-ascii?Q?XOy4MRRFnr6ou54/srtaL2KIfvOOcYyVC2kAiMu2RPGljBT3Mh9N7UBJAlah?=
 =?us-ascii?Q?bZSvocME/3pr6F7ZNasNjrQTsro0pT5bk0VIOeMYh02lp4qIclUdkz/h9aeE?=
 =?us-ascii?Q?65yYzIZpA46SgJbm4TwO5s6gYAjnACTpqWPSGLdyxBMoeK9scrvJn/d98KvO?=
 =?us-ascii?Q?DaOKtxjV6xJE4KSATh+bIKDbjVUzSfSqAGUThIF7IjSiqCzygSgsaDhQVUBh?=
 =?us-ascii?Q?VYVsx5A6n5xke/6EAjxIVjPsUcUT4IRhzos+eKqy58FzKtQ4ssyruFB7iIL5?=
 =?us-ascii?Q?rpB/5ocb2u/ZaTuqFX9Cd687Kq9J2XhN43CX7o5ERUAZQunRe2XGxdgBe0vZ?=
 =?us-ascii?Q?8h/cqzJ1XAckJFCyP5mSSsuKG28t4avZJDaTL9YIXI4799C6RvYyYSeKRmQM?=
 =?us-ascii?Q?ACK9LNOVmpMJDkfSjJxzESGTDclLpVUBqF6HA164O6+Wjssj8pu5gVz9AWvH?=
 =?us-ascii?Q?4Mo6QiMSK14G+OcaC+LlmEQBI+furJ6gvxVnsoK8x5BfWBIX8HvmqGnh7cga?=
 =?us-ascii?Q?Rv+axXvmCpm7XedIOrKDpE5SK3taQ2Vn0ynOe0yfkONXXJWV73xoMSAxnpMT?=
 =?us-ascii?Q?fW5y1DR2MlE2nkohu3EjwaLCegqZBca1kkChyw7fStk/VcU31XCvxnkQfNjS?=
 =?us-ascii?Q?G6oMd4qbptoln7NK6Bf6WmDFzH7Cbi26mDNeuhCSCq8/TqJPkieprTVh+n3K?=
 =?us-ascii?Q?7d1W5P2toVbOeJqfXMeuZualKHZx3tGu9GQmThc1Qk+m4QrvuMNlpTAgkbqM?=
 =?us-ascii?Q?WQddQcSKZPglpH/uhVUfEwDkvLcAE8Ymvm3XO4rb8rDVOas2pdJ+H1D9Odgp?=
 =?us-ascii?Q?MV2+eJlwMd+cllnXoaV/XSqiYeVHD45TGnMuQB4kETSh/8zJi+OjEtgSlBJZ?=
 =?us-ascii?Q?msS4dpdG8axhgU5/lCG4VMjXNwWUSmMQMewoj7hDIV2FnlxSsUo5nfX/I/2Y?=
 =?us-ascii?Q?FC3EidaS9nxID5DRm8hVuNCYTDAqeop+Aw6qK6bKC7MufED94PYidyxjbxEf?=
 =?us-ascii?Q?+JxfIZQ0EkI6LF/TzvSwM2Y83ArPenIV7iwqzh3bRvMWNynZ0EORkLixx5H2?=
 =?us-ascii?Q?VcnXuRTPHbH6KR1ezlgjmNrOt9YrWOW8sFd0OizegXbjFGm1blMEP0cEj1xr?=
 =?us-ascii?Q?RoMi1GoV2J3kedkWcKFt4GgPpL4nXmKAM8ni?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:50:48.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42ba17e-3907-4226-98cd-08ddc62c0315
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610

On Fri, Jul 18, 2025 at 07:23:25PM +0100, Robin Murphy wrote:
> On 2025-07-18 9:13 am, Nicolin Chen wrote:
> > On Thu, Jul 17, 2025 at 07:45:51PM -0700, Nicolin Chen wrote:
> > > On Thu, Jul 17, 2025 at 04:15:09PM -0300, Jason Gunthorpe wrote:
> > > 
> > > > +TEST_F(iommufd_ioas, reserved_overflow)
> > > > +{
> > > > +	struct iommu_test_cmd test_cmd = {
> > > > +		.size = sizeof(test_cmd),
> > > > +		.op = IOMMU_TEST_OP_ADD_RESERVED,
> > > > +		.id = self->ioas_id,
> > > > +		.add_reserved = { .start = 6,
> > > > +				  .length = 0xffffffffffff8001 },
> > > > +	};
> > > > +	__u64 iova;
> > > > +
> > > > +	ASSERT_EQ(0,
> > > > +		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
> > > > +			&test_cmd));
> > > > +	test_err_ioctl_ioas_map(ENOSPC, buffer, 0x5000, &iova);
> > > 
> > > When:
> > > PAGE_SIZE=SZ_64K = 0x10000
> > > MOCK_PAGE_SIZE = PAGE_SIZE / 2 = 0x8000
> > > 
> > > This likely fails the alignment test, returning -EINVAL instead:
> > > 
> > > # iommufd.c:988:reserved_overflow:Expected 28 (28) == errno (22)
> > > # reserved_overflow: Test failed
> > > #          FAIL  iommufd_ioas.mock_domain_limit.reserved_overflow
> > > 
> > > So, I think we'd have to pick a number aligned to MOCK_PAGE_SIZE?
> > > e.g. changing to 0x18000 for example can pass.
> > 
> > I realized that we can't change the number as it won't reproduce
> > on PAGE_SIZE=4K. So, perhaps it should just SKIP other page sizes
> > than 4K.
> 
> Shouldn't it work to parametrise both numbers accordingly, e.g. (if my
> Friday-evening maths holds up) reserve "1UL - MOCK_PAGE_SIZE * 16" then map
> "MOCK_PAGE_SIZE * 10"?

Ah, you are right, I forgot to change the reserved range.

0xfffffffffff80001 and 0x50000 could repro with 64K pages,
exactly what your math works :)

Thanks
Nicolin

