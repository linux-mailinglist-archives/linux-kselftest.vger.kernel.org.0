Return-Path: <linux-kselftest+bounces-34621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41BAD4237
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 20:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E775417D44D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33B248F76;
	Tue, 10 Jun 2025 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B72BlcuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2A24679E;
	Tue, 10 Jun 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581353; cv=fail; b=LqXqyxbTTaBTf22OfUlk8luTdGikXwDIdcdZ0SJzn4k4MCCPguhDz0LFhSEm1ZTBpx4mJMhwATM/IWT77LGyh8yv0vijD/+J7teDEZWea4TdE4Yn7qFKfr+oKN46aCV1UDWUilauOiM/4bh0RfGq+TMB+0fF06ZLU/bM/4YfNkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581353; c=relaxed/simple;
	bh=j6Z6n8044IiuaHU0oplYnAc7pkHVRqGjgE6/T+u3hz4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnQ4RoK6bLOZdrbMj5mPTVJ2TjRdTXQwNu4AMNTHK6CouWvcKY1I03G3rbhceCvF1kb4uw9ASU5HMNeEvdWFcb70Fjwy67L5kjFdfv4SwUQ/HNK6xeaDosVBGqlMDmto9P92qHvuZSUsENa2RtgLf/r+1dEHQMudYYls2VNw1us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B72BlcuC reason="signature verification failed"; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyhqVlw5tAfUSaDbm2wH2fhFli+CzPJFLAjDiwrlBoLPunsMTAdfbkh+hfr/J4tmYTVyTOBCUj/Xvlza06pZwtLjIgY9UELbPygGhRaxrq3LpPJreVusnsZaqq2i9bh8r0rjg0BUzKI2gaFNKqIike9rPWthP5GMMWiga1cTun/v5vku8wVlu/MqLbFZDpgtdGMm5U2td6TwEXpsjkxSMQFxmt6AejXDQM+sHdX7lFb5SvDO8MMlKx+yGW4vvtwxXtYMppPe985UzMZc1EnbVMMbb0n/1V2uEoOADO8LlL0GVb63eI9skm9h+9zqNK+YSe1ILxpGSWftFijkVjdEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqcHxFG7B5sSZm4aHWn6kYdKM//gd8AiG/oDuBUuBa8=;
 b=raLACctl1C1cb1tEfV1fn3Hy+Es+mLzdwllDj3KLZ7391zlKjTqIE7xFctpjFcUjqkSubRFNGv8Itkmrb0JK1hKm08sW1SS3u9Sbp0pi6Z5bRgmxzC693Vo+qyzbl1Oov0EICixI9duHH1fWNfxrgjr7g9qAPZ4lnYq9x5tB/yjw7MxCPQVXgjuHrcZwKWNam+fVW10Gkycsnb/ExoJMbtdcMWaAKsKQeRnRtPNM7fZE/bp+ziFuY1xg+zlr/YsadACEvUA9980MlcJD0HoKmK8NqPDUIwufYNa/sJkVFg+ACy77uobT+btviITeS15C0zGOfYh9xl5tAlznvsW20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqcHxFG7B5sSZm4aHWn6kYdKM//gd8AiG/oDuBUuBa8=;
 b=B72BlcuCdf4Ah6JfqXe6sUaRAvvK+mlXsWGUwG7LsEAN1ARWczrp5BKiqJYcBv4DbUFp0f0Nw7no2g08sae68eIoujFYrQMBC2bUlNZuUCXwwxieYZdGjXSWuXb6TPfuoSbud8JnXCKtIB7Zmuq9YhYIreB3xoEg3oSQLD8Sny/GnS25Vj6qqicIqMugigIuYp9v5A3RcxMgdT8YW4GBEeB4SyMxUK/uTrr/J3jk58Fvq8WBUYUt+4uE8WDvjThuXbRln8CVsPLttIXLRtU4VsMHkp6AhfBeLiNTldrKTW1zAuQFMVm3Oslv2sDZqP636a+hEbblz9+ZP010al3FJg==
Received: from BYAPR07CA0080.namprd07.prod.outlook.com (2603:10b6:a03:12b::21)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 18:49:07 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::92) by BYAPR07CA0080.outlook.office365.com
 (2603:10b6:a03:12b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 10 Jun 2025 18:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 18:49:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 11:48:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 11:48:49 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 11:48:46 -0700
Date: Tue, 10 Jun 2025 11:48:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Willy
 Tarreau" <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <aEh+DNmbZrqg6rHR@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-9-ee4dd5257135@linutronix.de>
 <aEfVYQaid5uOHB+Y@nvidia.com>
 <20250610130817-253d2b2d-030a-4eda-91fc-3edb58a4f549@linutronix.de>
 <20250610120902.GB543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610120902.GB543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ded4774-4b65-42d1-a110-08dda84f7a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?nIgtpXWrj0wIa/IMhnGQYfueJamQgrV5AHH6zPQkfYF9VgswSyUdZCg+th?=
 =?iso-8859-1?Q?KvCs+tFuLWoTRMylH72UBQwRGVsCKPRZXrteHM5sIh0NdtIUB1vKx1C27s?=
 =?iso-8859-1?Q?jMAAL8CbLM4wTnR54J+8vKPEI0ONiY01VmmrHMAeaGes6msVRBfgbWv/GD?=
 =?iso-8859-1?Q?//EwcxL76cdIhchnQgQTTOIWJhXb1FciUTlPqiuRGyJMP1ITVTYtWDElok?=
 =?iso-8859-1?Q?6w+Wj+ow7s+9s8OQ6/gc5L4tCiMLCOTXtQ1eiVcaqo/P3+U+q/AJqYathf?=
 =?iso-8859-1?Q?Iry9MLUntPJ825iAfBK6C/362PX9PrtiPwFEmESugbtlbLrziOxFgeTFpX?=
 =?iso-8859-1?Q?TfwA8m4PehD/hqLVQB43ft3uJEvG/R4TAKSHw5abO5AUcBdFbHm+PzQfZs?=
 =?iso-8859-1?Q?Aks8uc/JPF1mEYxU2nGcGSAfwQ1PncQ/JrLM7YQ7k1pTk9ZoaOCCZqRZRe?=
 =?iso-8859-1?Q?s/QtzQ6ynZIuzNsPX6E89uNb1zwU+f8Bj+cK5Vphi/VjTHrOTggV+aKoWl?=
 =?iso-8859-1?Q?EymLTfOGe+lgLTiiRhGAC5+X2Tna04dB0SJERIiF11eswvn6DaWYt6GIiJ?=
 =?iso-8859-1?Q?VUDBsW4kK5mR8j1dO5U0nB6pUOZIXrzN4uU6psnEghqJTVGiqOTya5TozY?=
 =?iso-8859-1?Q?fQ+QkUnpHiQJKBewvln3Qfra8j9YUQ9JgaE1mCSY6wIBoONhKmmAK6lcGd?=
 =?iso-8859-1?Q?j6MrU+vCBUVgy5rXq9I2DEiqIeHPuAPalRmtAGRn199mDgFuApUrmoKdZu?=
 =?iso-8859-1?Q?LuDvvbyCcHW9GdSa+e7xMP8VSa0IxqAegDnUMnCQUD7mJfYqMW4f2lbHgy?=
 =?iso-8859-1?Q?X2fhS7mJp3nylbcgsHWgw7XFir9LBOGifN+Dwewpc/5q23DSmtzmYMbLPt?=
 =?iso-8859-1?Q?5MeEopVpftcKljUFxBu3w6KKfj62U30duSTJ7PbasjOR0YH2a1NMJp9Bbr?=
 =?iso-8859-1?Q?YjoGI4jXFlfWYIySWNUcXEuCr893OXs0QH6WLGRT1VRVBxC6X0K5iaGS+W?=
 =?iso-8859-1?Q?ppuDnOcuXNgy+D010CVskPKzP9i6dj1/gjPog5igv0i3xedUp9VsCgSoCk?=
 =?iso-8859-1?Q?VJo6H5uJZHt4tclasDjBnZaJhu7r7HyjkbBbzLlK33qDOM+hlov0KsasSt?=
 =?iso-8859-1?Q?qxynSywLN62ACZjotfviMEd1Sv7PPgkdhBeb4uUxeHJ9Z3IRrsK3pxsVy7?=
 =?iso-8859-1?Q?wTt2vOzcpqN3Rd/slNO+FUfbQllRhYXzUSokrcfNANK3IYG1C6sdj8ofSB?=
 =?iso-8859-1?Q?kn8BQ7Z/GCCCPjr4UnLo1DkMnLpysnGmHJ+Fgi2EatagcnSwDoOnbsYTSh?=
 =?iso-8859-1?Q?NgPvfJW5Z3m7LrmJ7J5bZUTIYElF7EQZwQFB5zox9BuL4Qefs7zKcK2oeX?=
 =?iso-8859-1?Q?20LY1UCQY1VHH7gUGjUak0SScby4Asd1/1tlH4tV2pkYjNcoSpen71p2jb?=
 =?iso-8859-1?Q?SNTFhVfU5tGGZNXpSomWYBePtV2/fm5nbQeEjr2gBdK1/6pSxvuJg/c31g?=
 =?iso-8859-1?Q?Dg6160TMK57nLdI3JHKFwkyANTtjzntuAndc/AoucJ/1zXu1pjhmLYVHX0?=
 =?iso-8859-1?Q?NYH010Fkpbk8vr4J42nsewf7KRHc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:49:06.6986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ded4774-4b65-42d1-a110-08dda84f7a8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

On Tue, Jun 10, 2025 at 09:09:02AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 01:38:22PM +0200, Thomas Weißschuh wrote:
> > > ------------------------------------------------------------------
> > > #  RUN           iommufd_dirty_tracking.domain_dirty128M_huge.enforce_dirty ...
> > > # enforce_dirty: Test terminated unexpectedly by signal 11
> 
> Sig 11 is weird..

> > On another note, the selftest should use the kselftest_harness' ASSERT_*()
> > macros instead of plain assert().
> 
> IIRC the kselftest stuff explodes if you try to use it's assert
> functions within a fixture setup/teardown context.
> 
> I also wasn't able to reproduce this (x86 ubuntu 24 LTS OS) Maybe
> it is ARM specific, I think Nicolin is running on ARM..

Yes. And I was running with 64KB page size. I just quickly retried
with 4KB page size (matching x86), and all failed tests pass now.

Thanks
Nicolin

