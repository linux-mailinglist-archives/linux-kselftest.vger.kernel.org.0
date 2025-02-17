Return-Path: <linux-kselftest+bounces-26797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDFA38ADA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0983B4414
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477522B8CB;
	Mon, 17 Feb 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFyxWAkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2321C18D;
	Mon, 17 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814362; cv=fail; b=k0cDb/ZWuhlvmrOsj3bMn60//jqTWDkYqAgqnj5mHOMScxmy0SeLIkVKGsyDbhS/gbOz9w7JuroMvoHxbwIU1h9j2/WOh+ykBjpKAukdBgELnlAB+AD/hkw9N9B0kFSzPCphGwib7y7aHkjDH0u2W0jiIicjU/RNQaCDsqDHwD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814362; c=relaxed/simple;
	bh=2aqsczYPP1HjTjFHOP2yrqw9f8K9VSSddHioTSxokd4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Pf+FChXJyvIQZu0rRl6fYr+xZOq9dg0uV1epMgvPF6TYPNb5W8pFQnVxC1uwNeAczpfdwzYk9BX95z2nUpZSvFSeVSEqP8YVGeIAwOGcqDy00QFPpp+yaHTLqxACcwJ7zrJsK4H5fLe9Em8HqemCSrX0Mc01K5HdGkX5xVzrYVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFyxWAkM; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/4kjrWJd252h+8Umt9VILruzSa8woDR05qCmhV9k6js6X5B4afBOa9ytAwlMyANbt+nJf+MAjOaE7WRIgaBA1PErt5wu6rg5BIDhUOtaJuFqUrH6QHpZyOdE6JOv1NXwQox+2GJrTSm5i6EIuMy3mHFSFJSavfYGTmF4Juc9zPh2BOn0XKpJY6ow06o6WTN1vMWlCVERvBGOjDkWGbipP1dnNwbabRALZ+pPFtqlMHTpQT+Gv/Hm9PXiN1tHoDJB6m+TRlaFHtX0De790XCZvOufSIC/uIPg4MVAVuILcdEPNSe9IOludMAx+x9TMMtSX7lfXG10mhdmPjGBZ2Ymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aqsczYPP1HjTjFHOP2yrqw9f8K9VSSddHioTSxokd4=;
 b=RC35duS/IVLxxZxGDH8ASN6EYtJ6cXM96GKM5Ut3OW20vr27kQkzQ9wXT+OvOcVvyi2bJ+zfNvbNeQY4r/m5Bxs449pjVQSSPkYZ11JxOZlSjo/Moym4i03oOo4K1mLBohUcgtgX6F2KXs1QCSprCSZinIfz8/PyB9IYJUy71ZXmEtmli0204zOJr/egdK7wIhf/O7++k/dtRN9KvINvMdqoo3Bl/NzWXg5qRm75YMcH+2T0sIu1T6zZjb7OmjACTpGlxUh5SJ2QRdc9Br2XiTEiPmHb8v+0CK5qvdFfzfqPtcbG+skZ3Tqs/2qIHm9fu2UzOWWNGGiyhulc4E1quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aqsczYPP1HjTjFHOP2yrqw9f8K9VSSddHioTSxokd4=;
 b=XFyxWAkMshOs+rUZBgfUxnSUnmbHPNtyUz+G8psx3NL+Jtnjux2gDoX8bg/lG1gfElVQ52g8choElxD4n2z3bBrOUplH46+/D2gt4TByYLJkxRHRGphqt0SEttPcukNFHAyTM1zOHkKX+5QR8Mct2q36gwBlW5fpBssCR6zLfjZ2TxqVfeXJxAzJgDXt09Asu8uhFGdulHV4voyhpT2su2zAS9kalKowsOirKGpXdgenFQO3vc4VTgMCYD7yPny5wxLURKWtYzaYTXwZcqnIeuKJoUb06eUuLMWG51aVeyfGPtVb3fCAL/jRupaOauSTC1MXXidNO4rvwTYSpRz+1g==
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:45:54 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::62) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 17:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 17:45:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 09:45:43 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 09:45:40 -0800
References: <20250217141520.81033-1-chandru.dav@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Chandra Mohan Sundar <chandru.dav@gmail.com>
CC: <skhan@linuxfoundation.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] selftests: net : Fix few spelling mistakes
Date: Mon, 17 Feb 2025 18:45:18 +0100
In-Reply-To: <20250217141520.81033-1-chandru.dav@gmail.com>
Message-ID: <87y0y4fosf.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c13ee1-8a4a-4fd3-4cd8-08dd4f7aed48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RISmkuMKOGNsDzlXGGZPf/goT82i22ImR8IYiP22k652oafOz3cEVMjAoXOM?=
 =?us-ascii?Q?4AL7e1CPk+1BrdTG0F36IXAFSgXvPkfEVK6W91l1Z8eAZ+N871FR8nizmDke?=
 =?us-ascii?Q?n0ceV+Bfl4i/YB+R0mrgngIp1pCwG5937BXA5wEvG3E/TCTHZk8B53Ib/1lO?=
 =?us-ascii?Q?frkDMJEYGedKuxuP+mRnpHvMyT1FISm0W3dpzdcSav0OHaiD4w8bo6nrJqsi?=
 =?us-ascii?Q?Noop2sY0KUFV6VKQRSFQkIOSXQz5ZT7hLKRfAlL/px7yMWjtu9hEt1VwBTgt?=
 =?us-ascii?Q?U1Xw8VJNotGUeFMQkwzDP0RlHiU34aJ9GBKb9FnusfSbBHcPhO+oVvyFvXNt?=
 =?us-ascii?Q?amOI0ta8u42yxEHQD/HcXD+CNY/llED3C/rmjgXMZSm6OF2ROiphDZpIfJOv?=
 =?us-ascii?Q?GMfmUQqYG0FJdH65Rgn9SWIHfKtsv0Ksg2WgtHJUI/mUHHq53d0v6her8xrn?=
 =?us-ascii?Q?yr/5J+Ci1IaDxzZOSsKvwbcDidgA8olAigHiDUHRLf/ffEQBtlaCSjEbwX6X?=
 =?us-ascii?Q?x15HIiWysBBOawcuXJYuHpgdVnfQ8eNx3CiuQI8YpO8mDiwdhSC9DP/vDWv9?=
 =?us-ascii?Q?aa+pK1+FTxOqE9sM9RtXZE6fllgTc/SeYgAdD7pzv8XibKLIPecmrf5jQCPa?=
 =?us-ascii?Q?3Zb4wU8xz5OpkLrDdjz+A+BGo2JXbWqp7zz33sipF1VYq61yeL/wAn8/Kv4H?=
 =?us-ascii?Q?Lkz7y9MedHRKVN0+LSzzzUCsaUasL66oVOkX+oKdZM7OiyO9Hqa+QoX2AyhT?=
 =?us-ascii?Q?DpuvAxx7AwPNC9NVH8bSnb+OZp4qF5xFPVzA/1HZdQ2bls5ySg3Fsa1I3rbv?=
 =?us-ascii?Q?bQyx3K7O1tFTtE9JLAABI40XUyUSompztznJ4VxfE3SFxyqtoJ26ORTe7E9A?=
 =?us-ascii?Q?L9tKIBcLesdLPs7WNrelrj2gvUFEFu0PmAYzhvdwDdnD7lVx5/KImPm+MagY?=
 =?us-ascii?Q?NRrSmhBNgHTV3QRxUKt3qw/6wdbRxMzM65N/BsNTHfSzl2+67hilwLcyhmjz?=
 =?us-ascii?Q?BWvWp+1krnAuIKGshWmWDTyeOktxKOTfZ6VbqbQZkdXYf2pB2qWrnGeWQMVU?=
 =?us-ascii?Q?nmJWYiMCFRTFTippM5CgigIKKjLTAZa9P+xvvUw5uhZhYl3L1gRF4MSeoJe/?=
 =?us-ascii?Q?2NiFeRTt4cOvnFplOlSAj91OTfPEK3lYrZKAV01bosz1NGXk6bd7l8bz/LQm?=
 =?us-ascii?Q?FC/z9U2PjWAhhMGyPSfrLhVzCK+/AJT1cDEI00TUVyexAdXqk9noIszeuo4b?=
 =?us-ascii?Q?Pn4hlVyOx2LxkJWVbM+umBHFfs7WoSG7okqr6RqTvwmuy1nz1DrEguzoYfVG?=
 =?us-ascii?Q?6Sc1jSHj++1Svc7r+C6HSQU12DkJuLiKd/AmjQ5D9yP6zMb/lkPCuQhAUqDg?=
 =?us-ascii?Q?sQltsvNgWkGr2NREotCGRwzM5NXgF/V18PAh8BexJAXvf1WZ2uGeRCZpdRw2?=
 =?us-ascii?Q?jN/y4VYM7SGHr731OvR/y/VMMxsiJ2HEDYiwAOHzNItcQIU4begxzlbaSB0V?=
 =?us-ascii?Q?2+QqBtgy8OGdgLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:45:54.0146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c13ee1-8a4a-4fd3-4cd8-08dd4f7aed48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258


Chandra Mohan Sundar <chandru.dav@gmail.com> writes:

> Fix few spelling mistakes in net selftests
>
> Signed-off-by: Chandra Mohan Sundar <chandru.dav@gmail.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

