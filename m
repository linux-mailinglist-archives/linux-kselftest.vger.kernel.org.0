Return-Path: <linux-kselftest+bounces-34542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C68AD2E0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD4D16F6F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 06:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878F279354;
	Tue, 10 Jun 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B045l5DY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527051A0BFA;
	Tue, 10 Jun 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749537662; cv=fail; b=GnqEua3lCiQlkQeTv6kcUdSM9P2/lVhvwzD1Ir9gfbkq+8s1tVfYbN1AfGPkAfOnmOzls8YCH3RD5KU/forxvDzheALkEEFRh48R2yAUEgDk+Hnv1m6b99goHVSZloQhKrxaGsfyWYjmsxNJ9JvM3XWEwe5ppNntVqhtNvEiY7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749537662; c=relaxed/simple;
	bh=Y812angP5d4yTavTnwGAb1UXELQGeShFcPJk7z5G/8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEWYsQFSKD5Pe4MuYWQfhx+yWAVd9qTDtNre524g0N4SCsE+YgfqdCZBMrTz9VAcVyO+MjhVFJPgypzmlBMoCOIdGx1ujjNeoEvlab2i6nrfk1SB+TbgmAnY1QNgQsEa81Yrbu/8oJU41F7wnnn+PFIBtNJ3qdWAMaN4iMM/27M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B045l5DY; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u25OXQzIrrRWvkJ04SgPTG4cVzQUf7HKYX9byAzj0cVZi+Puim+D2vstVtNl2HkizXGJGMsHzeI4SJXF62bEMq3A6xvSQyBcO4Fw3Pio53iutbutwS0YAxFGWTpnZElxLaRDzeKSw5EEAPpvrCanj3ZwiUOCZgGbDyd3WjU28Y2qKe8ft+pQpbUroM5qr+4sOt4f1xBkZ647xFijDfmnsFQDsfxvZIEzgpuKnE1aa+ZUIoc79suuDJEzHeyBIFLL2+T5E5oJpzBNQpz4SM6w1KUosaum0aBRphqx4gAC/R4IEeZVpPfmUu9q6URESzE/vKSIuRsPZCB7OybxBd8UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DudnokSQkNzh7iyKAu2X205I1TtoOOFAkunlCJdDBM=;
 b=E1PK+/I9qZiPnfQAyY+iUxgrP2WP/c+X3QsHpcsTP8hdQhVUMLxiYtVrfsgkmfqva9LYcdw4wPeFSm5ouTRJkR85FjkQ27AIIzkrjxLhQ2rTvSeEDkr5IwNsQ4TWwK2Dnk7gSgKoN6Vjvdvh29h9M9GwbqZfhvNFPAAIFp8cuzdzapgyHOhzwuQHMFxB35+swZ1tDs005F3s0AG59sV7FEWAgjevZqIP2YbGO5404kciSM4+G9cTa2fRTss3Z6vm6ZaEShAxpLvh++b+k3KM5rBe8oxR4LYtlL5AuV/AlrfegFyTwPKlSCVlMtxkcDPDJtA0UKdZkIUNHX7J4dq/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DudnokSQkNzh7iyKAu2X205I1TtoOOFAkunlCJdDBM=;
 b=B045l5DY1gzBc14gle6eWIQjGIQcFOw50InISCi9R3eBG4vuzzpxU2yYprbrPypuNHA6rxI6+PFTB+BiZthh7XRH7HU02T3mMYSP2ITkhP8behVuYCj6Rxr2/cV7Q9eps7VDt1/Ioj4br4jKZX7I6cxIZ/LxvewLP7ijmmesFwafLfiuS7vxkPQaWgnDV/LeBEA11qXl5axmMdNmQUmqog212FW1y/v+UUp5/vwWq3uzCRfRCUj3WiW05qw3wOqej5Ex5FWbdkvX9vXcRAymsFJg/pme6RSyc2GJ/3BnFLUP5GKKQtaUMxBShT3cU5LMJs5zNrTztQM6/MzPWKu7qA==
Received: from CY5PR18CA0046.namprd18.prod.outlook.com (2603:10b6:930:13::8)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Tue, 10 Jun
 2025 06:40:57 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::be) by CY5PR18CA0046.outlook.office365.com
 (2603:10b6:930:13::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 06:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:40:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:40:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 23:40:41 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:40:37 -0700
Date: Mon, 9 Jun 2025 23:40:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v4 12/14] selftests: harness: Stop using
 setjmp()/longjmp()
Message-ID: <aEfTYkVdphiOhqPg@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-12-ee4dd5257135@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-12-ee4dd5257135@linutronix.de>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: f632a080-84ea-4cff-ef8b-08dda7e9c126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXJaZm5MMWpEaXMzcENaSkJRWGJNQ0dHTkprTDBDNVhtUU9uT2UwazBOemN0?=
 =?utf-8?B?cnRuL3dhckhVcDlVbGVPaE0vSW1kczF6Q21hMW5tOGZsK1dwQmgvSUlzK1dR?=
 =?utf-8?B?SUV1VWdLR0k3dGFnZEV0T2pRR1VPN2ZlVnFzNldlR3IzbkhScCtaYmgxQyt3?=
 =?utf-8?B?ZERBL0Vzb0JsanJ0bHl2V05ncHBSU0hyOE5hSFZNQ01qRVJETmlyakU3SkYy?=
 =?utf-8?B?TUhIUVJ6c0VFcS9MM3VkdHBHVkJja2Q1NlA0ZkRuMjRLRHI3RXhxdzY5SUVM?=
 =?utf-8?B?SDFyK2dRMkowZEtOK1h6Ym5SeUFDUm1ib1Z3WUpvbXRlT3BIMWQ5RG1GdUds?=
 =?utf-8?B?c05WTUNtZTNjL09nRUdyT3MybWhoRXc0WWRNcUZxcFJZR2cwUjBQSVJlYTI2?=
 =?utf-8?B?S1YzZFpxQ1M4UlRaK2NydmNoK3NsY2FxN2d6QmhLRWkrWVR5UWRIeVNjSjZh?=
 =?utf-8?B?UVRFVkJyR0JvclhNclcyVE9vMnVIak5Pb2FOSG9OVGUraStuclRkT2ErTlZl?=
 =?utf-8?B?b3dDT2prSHFsaFc1c1ljNFFUZ0VJRVF4T3ZQSVBsQklFUGt5elNDSFNWeGE3?=
 =?utf-8?B?WFByRHdnSWZnMVpROVlnaEVZKzhqaGFpYkt1MjlHUXdrMlNjS3g0S1BmYjhY?=
 =?utf-8?B?ZG5SdUVPZ3p6cVFmWkU2VXVZQnZzTjJZMm0xaVR1KzNnN3Z3anpUQjFHWkdW?=
 =?utf-8?B?ekRoRm9ZdlhNWlIvRmdDa3pUSW5lZFBTMjcwWUhkeTRMSjd0M3VhSG1Hb3Bi?=
 =?utf-8?B?Q3B0OFJjaHBuQTlXa1hzMzNUeUpYTkJxdzFocTZDK3dveW9vSytLbnVuZEZI?=
 =?utf-8?B?K3AzUnp2MHhxTzkvaVhGZjh3bGZLclRXbG4xLzZpWVpCcnZBcEpQVFZWck5q?=
 =?utf-8?B?a1ZtU0tvd2JYMm1Md3RtWU4wNmQ2VkQ2cjdHQXpSVW1mam1SdklVb2lBcnE2?=
 =?utf-8?B?TGRla1ZOWndoeHlXK2E2cXExZXA0MTQvZlZuTlJqRTh5Z2laMVM2N01NUXdW?=
 =?utf-8?B?VG01MkJ4Vlorb3BobXJNTlpQaDVGT2E3WTZobzJXcmNtaklwcXRBeC9UUjJS?=
 =?utf-8?B?VGtXL2tHWnI2WHExTnZXQWhERzh5M2lOSnkwTjh6OW1tQktoYm5iYk9TL2lT?=
 =?utf-8?B?bWxSYmlHazRLa1ROOHJFZHZvSU5COW9VbDdSNldCZW5ZbTNWYkdMbWQvZG5v?=
 =?utf-8?B?Z0xBMzdQKzJwOFdUVG4rUERTUkxmTzk3V1dhdDZzdUYxY3ZTWG5wNnBtVzhz?=
 =?utf-8?B?anBlZzl3OTJFaTVHaEU5UTJsOWJHZHZZK01iSHhzcFlaMncvZVFGWkRwL1FP?=
 =?utf-8?B?Vm5pL2doZC9VeHBKMnhiZ0xuVVltZHZTNmk0aVBIMzRBOUdNdGR0anZ3M2ZV?=
 =?utf-8?B?MGM5Y3pLdEN3Y3RuTm9OSWFxQlg4QWdndGRPOGI5d1BSYU14TWdWWk1CTzBG?=
 =?utf-8?B?QmIxTG56TFJLTEMwc2JmNGVNOU5yY05FazdQRTBaWHVid1dUVmt4WkV4eWFq?=
 =?utf-8?B?QU9YZzZteFUxNVd5T0cyVVphaFN0SkpJVkJ5bHlBd29SVjZNVmhPaVEzVXRv?=
 =?utf-8?B?NjByWWlWY0JnRnNYZVp3dG9NUFduRFRlcFU0enhIdmdhR2p6ZDhGM1JwaUtP?=
 =?utf-8?B?bTRwK1A0clA3MEl5VkJZYmY3ZEUxNHF1YThBU1BYZkZJMnRiRDR1QW54Yktq?=
 =?utf-8?B?ZkxLMC9Qbm9ndUlQelhORzJ2SVVxSThGUHA1ck9CR3htOEk5RmI2eEEyZzRl?=
 =?utf-8?B?b0dUNnRJbXdFL2g5OWlsMitFRE0rcnRpQW5sb3RHRXB4aGpqYWZoVlZ6SzlW?=
 =?utf-8?B?NFU1YWJBQTJwTDRMZERMR29iakd5WkU3NHJjSk4rM09FcStWN3d3MDhlaTJS?=
 =?utf-8?B?VDdtMXlXajk4RWJJaEtrRlJsUHNUR2FJbmxraEdoa3pldm04Sk5BZXI0VkJ3?=
 =?utf-8?B?TCtnK1htVmE2aVhMcDNCVk1QOEhuZC9JN015bXI5eFErZEJiMkk2b3dJL0Uv?=
 =?utf-8?B?Znl5ZEZpMllyOGkxUGpHOXZnZUV5Ni9MUW01ZVZrR0dhdWVaTU1xWnBMbitM?=
 =?utf-8?Q?i+dKxm?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:40:56.5026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f632a080-84ea-4cff-ef8b-08dda7e9c126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

Hi Thomas,

CC += Jason

On Mon, May 05, 2025 at 05:15:30PM +0200, Thomas Weißschuh wrote:
> Usage of longjmp() was added to ensure that teardown is always run in
> commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN for ASSERT failures")
> However instead of calling longjmp() to the teardown handler it is easier to
> just call the teardown handler directly from __bail().
> Any potential duplicate teardown invocations are harmless as the actual
> handler will only ever be executed once since
> commit fff37bd32c76 ("selftests/harness: Fix fixture teardown").
> 
> Additionally this removes a incompatibility with nolibc,
> which does not support setjmp()/longjmp().
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

The iommufd selftest (CONFIG_IOMMUFD_TEST) starts to give warnings
when building with v6.16-rc1, though the test code wasn't changed
at these two functions:
------------------------------------------------------------------
make: Entering directory '/nicolinc/linux-stable/tools/testing/selftests/iommu'
  CC       iommufd
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
iommufd.c:1806:17: warning: ‘mfd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 1806 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1766:13: note: ‘mfd’ was declared here
 1766 |         int mfd;
      |             ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
iommufd.c:1869:17: warning: ‘mfd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 1869 |                 close(mfd);
      |                 ^~~~~~~~~~
iommufd.c:1818:13: note: ‘mfd’ was declared here
 1818 |         int mfd;
      |             ^~~
  CC       iommufd_fail_nth
make: Leaving directory '/nicolinc/linux-stable/tools/testing/selftests/iommu'
------------------------------------------------------------------

Git bisect points to this patch, and reverting it fixes these.

Both mfds are under the same "if (variant->driver)" check, so the
warnings don't seem legit to me.

Do you have any idea why this happens?

Thanks
Nicolin

