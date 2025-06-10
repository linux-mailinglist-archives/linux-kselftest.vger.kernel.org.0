Return-Path: <linux-kselftest+bounces-34543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB83AD2E14
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05C13A70BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA7279337;
	Tue, 10 Jun 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KsZt0x1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD922206BE;
	Tue, 10 Jun 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538180; cv=fail; b=KQHKmtK1A+oZl7HGImzwM03n1+QoEQ1u/GfdeZLpqfJqvfqUkmD5427Y7k2uhDNvAYo1Dy0dwVAt6rMxtFXH89i7F6M86vL+Ur+N+MitS64L29bDlLbFa3AfmJyx8HdpNoY7ww+dyOR/PWsh0uYQS4sgXCFDjn2V7Tfgj7pIQwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538180; c=relaxed/simple;
	bh=PM9j0wuVNyBE1y5ZWRWd8Nm5JzU7IieyZk+HCmpjBT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB4vTkS74QO6qlDTQnDCAYAUnPKAzroJ75LDMF1LcFbUyGWW3FAforiiV4AHvTKYh1k7W+/rTdvta7g2WUKm0gXYqQNU8LenzSS3PsdMvz7XhDjDFcBYCvnLhBJfcBXmd4B+9earArocfL7ZHF8UWog7VoNTn7BDFNj1X02hNgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KsZt0x1q reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9vrelK5zgIqPDOJRk884k7B9p3+s5xRjlQne4RiEaVDriVYpoAOryxbM6bxOvJl7BuQpHJYP9E2xjaIX9eJl3YpWlqngB1/83DI6mDyR7qQ6PZpAiEebTYleD1Z77UPYTvumD35fpG4ug8j7pw4Gqt3Bf6iAG6pTG4TPl4zZ9LRJPKHPZrrt0FeNXe3gHHZrEoPqNmQdUyBvHShsrAr0ifbi1HItHqcA/uLXhIXok/jajbdTBM1uyKDKQ6nPGwby+PSML1nUcB4rqIzb/8qg7HVVA2ZMBZDdCmmAu6tGvk8uDrRJd4SIMOb1SpCvC+vNiY8IufdD5O9XBwrQ/BLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I1YBe3SDvagA9UXT6/sBtIkYv4HrlP+wqMQdQhVGdM=;
 b=LSWO9c7vZn6OekVQF0DU9Ug+4RQvm/iFFflqOhPgxesIagLS9VEbXNXrF93EtVBlL/Rm4fvBUk5ABD3aNGMwffmuj8g8QnxhPq8W8+Vz4R4KNKkCNoWtLXlD6wrfKL+M6Nct33IRXvUFvZLRViue3naiTplv9NIxWlbb7NYRvOagqjoP/cCASf8Io8DLaIw9CKRlCsmou2l7Z/31WzVWXUo7eDUk7TfInP6tsVmRuISNmloqeu+ThNelWaFnlJiLuMo+pabMuq6luUIN/D5NLIYh8dOwvP3nSSqb1vJw3Wopd6ihhi6rJy7MzHKyn9Q1ZjVwtrkmliiEMKbEo7mmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I1YBe3SDvagA9UXT6/sBtIkYv4HrlP+wqMQdQhVGdM=;
 b=KsZt0x1qi2q0SnFgWDoZQEhzO0hAH7CzE+/f0D6/LJ9ZzepxeixXF9wWFVkk4CaYhAHY9bNBppfIjvMTNY+eqD684HJ4+y4m0i82Re47a3sSeWmiFRPVi6gRcbM8/F7Yof1U3hwdumVZ/waEhYFjltzvvNwXjQjlrEKx5ZkN7VMGb3tJQ3fcdJZRIqzclrslQ/efiOVGSVAFQ8DbhaPF3nDvXjnMBNo7rzM8p6Uqjj0xeUK21a83o0gOV+2Qrah50qSx9cKPK0w5mLYgin5tAULF34q0Zs6l7Vmq6Bsfaa8a1iJZoJw3DEtV1nhsOZYF+SsyO3SA56muHh/mBM3OiQ==
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 06:49:32 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::ce) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Tue,
 10 Jun 2025 06:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:49:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:49:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 23:49:11 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:49:07 -0700
Date: Mon, 9 Jun 2025 23:49:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEfVYQaid5uOHB+Y@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e026c24-e101-404e-1750-08dda7eaf45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1uq1+BkTvlOzNNHimChtMmz4vzJ4+eTAcNKX4oJo7ipyLnA4MMFdob8/Qx?=
 =?iso-8859-1?Q?f31vjr2sCOBWGZsJkqG0zYk8nWHiwDAUUNuP1q2UAILVA+K2gfNOhhpygc?=
 =?iso-8859-1?Q?lJ99rCt1rsFtBsFbJgqYNtXEKDYgLQ9TFe9GjUs43GKESlwG3vL6Xr4aWl?=
 =?iso-8859-1?Q?zFKZ0/P7DKRkkiGYv5Ocz7Bwu7tXiRfIbu7wzK44zmU/MM+pdrTR+SeLG9?=
 =?iso-8859-1?Q?stf/bzgzvCFex3zt5tNAK12kZuLPnkfXlQ7iviYqun4kDeKNf9+S1cCiG/?=
 =?iso-8859-1?Q?2mM9mYKlx/6hvHHIGHmzNnhoY7XBcf70tr9T0fWWZlR6rXwCU5/9fY7Sbe?=
 =?iso-8859-1?Q?/3+jtveoPwq1JglcooGn5p4RuTtH3p7KQgVPDlzwCV+z/p8Eq/29zV1m3C?=
 =?iso-8859-1?Q?uixlpNiQOTgqZB+9wPu7DfKd5sh6ezDVfp3h2WNz7jgQTGwZVJ/oGdUumc?=
 =?iso-8859-1?Q?1pVu7kX3wCCn7h2H27nXmSyyF/7hTgFWwtmEXnQPESFYmPprQY86uW1A/M?=
 =?iso-8859-1?Q?1m2V6x6FBvWOtzwSJf1R3mtUFrYc6Noc7QgEROBtDmuLn4ucIuo4HThdRp?=
 =?iso-8859-1?Q?EOJGkoL+nHKohFiYmipy3pY/gR7FU1R6GX11porPrlhg3pnNa66bHVkJ4G?=
 =?iso-8859-1?Q?Fr4Kgiw6Ux3JZYoHXzwCo++r+Q7uRPKph/MEB7iIIgNUQ5S/qUHm4m4KpS?=
 =?iso-8859-1?Q?VlxLLT0JjW2ZhrwoyUS32OmDglAnkZspgRgfCmh+cx3uRtyFbUoF0qc3Iv?=
 =?iso-8859-1?Q?g7Tb3TW9dc8CZVf2x0B7okFVsc1XJqcsu9/lC43CxYG3UOFZDGcsxKTNe8?=
 =?iso-8859-1?Q?N6pwvaYxvQQhWQcwO2nReVuAxkm3VpMiLUAO425cI/d/VdbVP9XIDN3Ukq?=
 =?iso-8859-1?Q?GIRsZzdwkpZq/zWGMEohZRpafb4jvwpoRnWEuDDtNsV4SV8J61xJwBMC6q?=
 =?iso-8859-1?Q?P0mlnidK3JnhyBQJsgBJPW46TPjcWe1CKkTgheVMWiwVco00CUE51H1Dto?=
 =?iso-8859-1?Q?MX1hHeSbfzrAkgpAtOS0xzKpfvyoAUoyuKIZZ6DkERkwFa8uDIOgJWPoOP?=
 =?iso-8859-1?Q?plh+ZUdCWrcq9aWK129nrABgC8P08hkQZqyqIEdVhWjz7RQaDXDE/SYBGK?=
 =?iso-8859-1?Q?YN+2NSXgdb7nowRCpra0CTXXYViOGP6PCnVEuN+RJ9Hze5qZB2lnhmQBGQ?=
 =?iso-8859-1?Q?H4ZKN5u4cZRaBF2ZLyJwYxqmoZmcCxcssmYAjGlU/7c+BOX48I5783Is/H?=
 =?iso-8859-1?Q?aB9YtQ+WtCOxOa9ERQjFz13fxSUTxiuXbd9OqFfYQEw8lvfsYLlXqAhWz2?=
 =?iso-8859-1?Q?eYBMsgznGmy23o0+zVlF/jv+4llB/qA2dwSiwM0uIMCr3Z/nG4MYRVafHK?=
 =?iso-8859-1?Q?n+rkWWWma7fz44eVk5rukIUQNVtm1BX67YDZg6RcOXzJ0H7RqlXGkGGn9T?=
 =?iso-8859-1?Q?dV1vg9YjTaVg/WR8NWbf4+OhA3brNAHirZX7+YPD4p51x5SQ6UKWdhBEGe?=
 =?iso-8859-1?Q?B3HSbr9CYhmDeRg4FwQ1iTql0Vmxn5REBCZf5CLnkcEfMlvPEHq8S+rLAi?=
 =?iso-8859-1?Q?VHRnRzFYV4LXUDCXYOGDbhZlPse7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:49:31.8230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e026c24-e101-404e-1750-08dda7eaf45d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094

Hi Thomas,

CC += Jason

On Mon, May 05, 2025 at 05:15:27PM +0200, Thomas Weiﬂschuh wrote:
> To get rid of setjmp()/longjmp(), the teardown logic needs to be usable
> from __bail(). To access the atomic teardown conditional from there,
> move it into the test metadata.
> This also allows the removal of "setup_completed".
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Certain hugepage tests in iommufd selftest (CONFIG_IOMMUFD_TEST)
start to fail since v6.16-rc1, though the test functions weren't
changed during last cycle:

------------------------------------------------------------------
#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
# enforce_dirty: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
not ok 193 iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty
#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking ...
# set_dirty_tracking: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
not ok 194 iommufd_dirty_tracking.domain_dirty128M_huge.set_dirty_tracking
#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability ...
# device_dirty_capability: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
not ok 195 iommufd_dirty_tracking.domain_dirty128M_huge.device_dirty_capability
#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap ...
# get_dirty_bitmap: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
not ok 196 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap
#  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear ...
# get_dirty_bitmap_no_clear: Test terminated unexpectedly by signal 11
#          FAIL  iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
not ok 197 iommufd_dirty_tracking.domain_dirty128M_huge.get_dirty_bitmap_no_clear
------------------------------------------------------------------

Git bisect points to this patch, and reverting it and its following
patches fixes these.

I haven't debugged it, hoping you might have a quick thought. Lemme
know if you need some details to figure out what's going on.

Thanks
Nicolin

