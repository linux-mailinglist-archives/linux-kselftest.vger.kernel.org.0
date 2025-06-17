Return-Path: <linux-kselftest+bounces-35240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9395ADDFCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA7216C9B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD082147E6;
	Tue, 17 Jun 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnmLJqkN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB132F5316;
	Tue, 17 Jun 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750204048; cv=fail; b=Zwi6Dr+CY9HzF8Rh1SGSekdAznwGdfFDsbvAmM87eIrY0I/ZNHQoAmItjjQ4EE8z1zk7aBn9cEHpTPIABfr3jVgcZMsFwlz2gUyx5TDDJ7xgbSDmjvzTaBobYHlAETATZKcecK2HtwRvCJN3+A/sTHmngXVf6P/aqpzrIKCo6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750204048; c=relaxed/simple;
	bh=/w4uMGZ46sTeeWMIDBl5uubskwZdKq9fAWBIYTgPi0k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBclZFuw9A4y2wY6QWLddpgxIujyV0PWxbyD28gv0Rjo09nuDQopjXx5qD3Nb/ZVF7fdSXmrIW6qkPWUzjiXVfEKAcviWYjrDJaFO24wpLYw1qZgk4wyu0foBG/lJMKnfDpgI3ogPscB2/3MIhltU23nPwLKu2e+jf8hqn64JZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GnmLJqkN; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVP5avv3utbnO5NHt75dWiE48XLg9m33fjzw/zPoEdTfk3Joa8Qe0Tw2/GFa0i0Xw/moAv8CEzf3rWHwjLDZHmNKC/YV6n+s9H8IpUOSrgGGnkcNn41I74bQTh1Ea8llFYgJWPLlpCCEjoF4wiaIdcLzEHSqX1ql3Vafni8M/MZFEtA9bmDghHlZOHgKnV2VFeZfWd6+/18E/L1XFS1AV1i54UjKQn1b6VbOJH96GrnsmJa21KdiwhyTi3MUi/+/gt8AzUD/u5eEEGagUQMk0Y5lG6nW31HjErKvq8/1jugK4vKyqmYEt9ho32EQckg8pQWjYX1AGGNNcZGi6ay27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pKk72KMZTbXgSjubR6VdMpalVKtJJPdBfjnywSZ7ts=;
 b=G9S8Gqogc0AWz0Kd0B3JTGTCsoUUi11cvLujgtZcSxx0DbzYDffUCz7V0moeYXxTuSEi71i+VuPDEZuqFdXHMB+kNCoD6+YUd0pM2WR7AE3p9cIZ3kCvu8Dbzp90NE9nYqRrcqmXSJAMIy6NdWEp37MyVJyIqBWKkrO1pQdvGFxgah8CVRnIS79KtRW+05SKaSeG9lytoH0YDp4mOFE1SVjzINCYQYXtkaLXyIl5aQ4Mstt5MZZ798JjT/umqY0yF/QvtqQgLe6bvFaXmpakZ+xzLjzsAPojc+sWo0O54YfofzayEasVJ+9mpTfT7F62t/MeLm+mmiDeX+j/zYnPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pKk72KMZTbXgSjubR6VdMpalVKtJJPdBfjnywSZ7ts=;
 b=GnmLJqkNnnjhR6XiCoVAab5I6V6CZAQ+XVX0Q4Ad2wEGTTsPzNc2h/Rqy4Mv3d0HhGof/cXUI4/UdVbcb4hKMUaM1cs3iKeiSSulu23AebEZXt7PiONdgsVua9GOuCaJTuu56iyZd59xfXCnXYS4v7GMugLtGoAFRaE6p4w5JJSUzNUOqaBj7R5j6fLQOlNM+COjptGrfgmJtzbaPQQdUEzGV7iU3YiG/SW6pYmTZqr3H8SXTSHVFWSpVa1iayKycFIEt7/vZ7EPnM+z+8fm11HNfhkgqW25DcJ/LBKk+REUgLC4q85873b2OghN1ZWj9ZWhgV5qVrZqTOpZbEN0zA==
Received: from BN9PR03CA0210.namprd03.prod.outlook.com (2603:10b6:408:f9::35)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.19; Tue, 17 Jun 2025 23:47:23 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::6) by BN9PR03CA0210.outlook.office365.com
 (2603:10b6:408:f9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 23:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Tue, 17 Jun 2025 23:47:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Jun
 2025 16:47:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 17 Jun
 2025 16:47:04 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 17 Jun 2025 16:47:01 -0700
Date: Tue, 17 Jun 2025 16:46:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <shuah@kernel.org>, <joao.m.martins@oracle.com>,
	<steven.sistare@oracle.com>, <iommu@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <aFH+cUSi1GITvF3F@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
 <aFDMoMX8eL7azoUL@nvidia.com>
 <20250617115948.GV1174925@nvidia.com>
 <aFHc3UujzDIfmKeT@nvidia.com>
 <20250617230136.GC1575786@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617230136.GC1575786@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c61b38-f61d-416c-afce-08ddadf94eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjVVbG0xSUlOTnNKenJDa09UK0xWWHlNZlZYU1paZGNwOXlyQWlJZkR6WWlv?=
 =?utf-8?B?ZmNDMEU2ZmZtSlhIbzViQXllZ0gvTEFLck9VbFJkNXM4a2twNEVWWEVRSnlD?=
 =?utf-8?B?N1EvczZISmlnVytwMGlVY3ROQUNtZU9aaks1QkN2QVZ2UTNVK09JZklnQ1I1?=
 =?utf-8?B?VXI0QWFKZHREMFF4NjRPQjVPVkdseUhvZlNLbUlFQUpLMXJXck12Ym9lNHpH?=
 =?utf-8?B?cEhSbnEvd0FkSnJnUWdneWxlbUdEcGFBSVVVYmNtTUhHVEFLemxVUTNWRkNZ?=
 =?utf-8?B?aFlSK1NMY1ZoZDVDVmlzdEpWMERQbnUxN1loUFVGVTcwSVl3YmJEWHFqY1pL?=
 =?utf-8?B?eFEwOThxY05MQUUzM3ZMTTlXK1YvV1VobVBDRGRhbElLc3NKRit5aDRqeHNX?=
 =?utf-8?B?c1pQRmZIUmFUVVVjaGFFTGo5R2dpVm1yaytDNEEyV1hyaTcvV212b2VQOU54?=
 =?utf-8?B?blFsQ3B3dlR3U29iL3RDVmZmZDBhYUZuVFFodjBaTGQwK2dBdk5qcGs2N2lR?=
 =?utf-8?B?YWlrUTBUaXpZeDlBOGJSUzNpUVFvNnFYc3lTYnZ4djlON3FIaEs1dmVETmtK?=
 =?utf-8?B?UE5FVWIraStmbTdyZitnNmlnaW1YZ3lYcDV1RGdaTWs1L2VQZW95L0Q2SXhn?=
 =?utf-8?B?VWlsRDRob0dSNDdtOWNoQ3BadXNXaVJYNFovd3NOUzdTd3dvdEdyQW9aWS9Y?=
 =?utf-8?B?ckFDVmJhd084eUNvSE5QUXpsNUVHU1REQ3MrWHlHdThPdnNwclpLNFJtV1RM?=
 =?utf-8?B?QmIvRVpER2NhKzdYODVUSWJ5cjNCUnY0MkJjZXp2VnV4SlpLempFZDBCLytl?=
 =?utf-8?B?aWZZM0JJNXVvNFhVZUdiUGRxaEdLWFlDV1liMDhHUG9ZODJmUmtDREQwV3JD?=
 =?utf-8?B?RzNrNWhIS21tUGVaK0hqdjNhMlRTWkYydmVFN0ZZN3dnK2s1bUhtY0daMjFm?=
 =?utf-8?B?UG51NHc2a21OTzZkTldqMG5WZk9tWXplTkhEVVVXOUgxQi9SVTkrYTQzZlV5?=
 =?utf-8?B?c2JBVm8zNFhiSUthYS9iK1EvUlNvLzVLb1A0SWpPSTQ0bjNSdFdrVTJxUWR3?=
 =?utf-8?B?bG1VWTRWcmQxZTZFZ2xKRUtZNEUzbDhOaU1VWmlQSlJCMTdQUjBYQVQvOWg5?=
 =?utf-8?B?SWhPVytwTldpV3lXeENWdnNseXNENzZ0S2Yyd2Q0d1RUbGJ6MXIrTGhKUE0x?=
 =?utf-8?B?MjYwZWNtZEh3eTRFYVNtcnVuQzE0encxallzNDJ5ZHd0b2g0cnBvTjZ6NHpS?=
 =?utf-8?B?bUVLWi9ieG42VHR6UGdPT3RhSTdSUG4xRm9RYjJETitlRkhFL0xlTGlPS3RQ?=
 =?utf-8?B?Y1NGVjVXbXFvcnU0Qnd1OGszcG9LejJUZXZCZDdkU1QxMVk5amgvMHJiZlpK?=
 =?utf-8?B?UUhMMDJIb2ZySks4TE5obkx6UXpxOXhXUWhIdHVHNEkrVi9VcnRJTjdZcGty?=
 =?utf-8?B?MWQ3WGN6WDFyNFMrNTk0VGVLTkpZS25yQ2VKY2tnQmFnMW5Pek5hTmsrUkNB?=
 =?utf-8?B?ZFBmbk5ka2JuZTZWQThvV0lHZS9TcG1RNzhHVHBDQlVVNWtCaWRYU0tiUjQr?=
 =?utf-8?B?WE4vQktzanFLTnRCSExHT3NVWWVoZkpmenZsNnJiYThRZnpFQURub1FDVkZp?=
 =?utf-8?B?VURPdzI0RU4rU1JKMEh4b2lmcGRCZkN4RE5STHBCSTB0YXNmWDdXTURhVFZm?=
 =?utf-8?B?K2RZVHprUnJTZlZyN1NlTXAyTkZBSVBJRGNlSmZUQzFGK1kyRExWNHA5Lytw?=
 =?utf-8?B?YmZqZVBUQjg5bVZwaXBKZzhjRGlncHNUTlFnakNadHZSd2pPUjV6OGRTMTF5?=
 =?utf-8?B?bFBTVjYxc0ZuRmpGUU1UeVJXOWVDVEgxNWF3akJGcm11czlWRDNXekUxYmdJ?=
 =?utf-8?B?ZkppTWFpaTFkdmF4Y3VYUGp3MWlvNkg5YzQvU0FQWlNaenphQ1NYaCtIbkkw?=
 =?utf-8?B?Mzc5U3o3RXp3TFMzS0lySzFWd0dFdytXbDNDUnJzc3owS1Z5SExwRXhWeVF2?=
 =?utf-8?B?Y3JGOFk4Y2xta3BtVkFGMlowaExwL1EzRmpKM2dkZUpMQ0RpRzVHTUR4MWpo?=
 =?utf-8?Q?47SuaC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 23:47:23.3404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c61b38-f61d-416c-afce-08ddadf94eb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

On Tue, Jun 17, 2025 at 08:01:36PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 17, 2025 at 02:23:41PM -0700, Nicolin Chen wrote:
> > On Tue, Jun 17, 2025 at 08:59:48AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 16, 2025 at 07:02:08PM -0700, Nicolin Chen wrote:
> > > > ---breakdown---
> > > > After `posix_memalign()`:
> > > >   [ posix_memalign() memory ]  ← malloc thinks it owns this
> > > > 
> > > > Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
> > > >   [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
> > > >   ↑ mapped
> > > > ---end---
> > > 
> > > Yes, this is correct and what we are doing here. The allocator always
> > > owns it and we are just replacing the memory with a different mmap.
> > 
> > Hmm, if allocator always owns it. Does that mean the munmap() [3]
> > will release what [1] and [2] do (allocating and replacing)?
> 
> No, munmap doesn't destroy the allocator meta data.

Should we do something to that meta data?

