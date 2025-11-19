Return-Path: <linux-kselftest+bounces-45987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D0C6F3CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB135EBBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C4364E9F;
	Wed, 19 Nov 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlTJNig3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688234CFBD;
	Wed, 19 Nov 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561572; cv=fail; b=Ybu9RbmoRfQ/NxJs+qux1cz1ClNdnYedwvutiHwhGDbgSDDOk4/BGoKKHMnTp4vsXnTmHjZEhDDmoe3SqisTvhttqU9tbVdZAPA3azqUMXv/sjDoDUsB5IiCGvUup/K4H+w3siBK3cPNxj38bgfTBQ0SBHFJCKrlB6hrE0U8Au8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561572; c=relaxed/simple;
	bh=LIUibiaNfRzfpk3JR/WrupEkUzCNPJMNAnCLJxvZP0Y=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gAM3xDTglaEVdbgs3FQTj35VdRh5T3VDVKsq4vgr/UJWYh6Qm/IU8LcgaLoWp5dj6pY7yM1IcwRAetGkfXUy62IiLKEl8fqxnhXZ7Q9flV27Eiw6WASK0gd0DzKglwfedaRKAaXkog4A034cgCVLLGQznDVP53MkO/+DZyE5QGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlTJNig3; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqZkI0nnkFHHwdFC2aK+oLa4spPFUh/xPT5s2OF5rSIonstq3vIS31p8y5pbRNzMof+LFaV7ZYpKyIr3gazMhI4EmJhf87GXfeODYDtEciaR5NzcWmz44+4bP33iYFQA2sSQkUiVcW1vi7kCnJD8Fcx1OWqvS9k7UDNl3+VAnDkNxk2kn5GAuQkIOo/8JynLF2ko2R73/Ohe21Ks0g+fdM9qEvHmeAUFFOyZYlldF3Lm5Yq+sVciEOMb87pFGKGITuuOZq1ZjJJX/L4jraIZYmA9dhXYAqwPmKbdMwJpp7E4LyDDDV57O/ZItf8o5fxWsG7UVm3217DNazz7khkXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2mLK9TnMuv2/fVs0QYfbUzo6Z2eMlsQvpqMeA8gd7c=;
 b=ATHz+HGrjpcRC/0/Aj5W9hsgIkXWUZ/5CufaASgF9A/9DijJZ0Ahtv/haGvI+CTby5OVeY68INI+2ZAXRlOtM0iitr/fRvwfFdYLrJARJVzl8mIj0deSX1p8Xl5jyeIn5yE34bFCMeqlKEBEcdVwBp7fGMopSIqRMkjXJ9TwPdsDHWSC7mO9Fo0dBeZ4lrWdWWb65LHDpun/VBdLj81haSeqLPZX+jb6rFVxB5wwlosPouwoJDbMncM0mwo6GqIsnTuoid0Eclpp7w7Eyonh1xoBkdxO8YkBqz3Uqwgj4lnXFCCD8jNRF4DeMJm41/UPDifSc0V5LGVZjnrFBICxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2mLK9TnMuv2/fVs0QYfbUzo6Z2eMlsQvpqMeA8gd7c=;
 b=NlTJNig3/8wSLrR27MC1PZDzoox5QW8fYxT5mucLDvSRxuoUnDUbI1BChEG8FseeAFwoUx0J3M1vKSXljV+XEk7DDJNabSK+G7pi24qgzuZwgB8oQsIz7ozPs7c1Ynu22HtHFIfNMv+STm6S3l4XgE+hIfTKgueKg4KUdkcpI3OssFsVfjzU3/Kh9plltbg8UYV5spPRfYPHZcDy2NzcvQUguXmi/yvbJBbrtvkj8QH3CkB/aUBYWG0ztL5dADjY7w/XuItYPP+3M4ZeBywUUmXx0s4fA9YrwL7n76zG77NSS1hq///Z8+Kf2TYeQA2cP+8rJ3sn5iADdFg+y7wpog==
Received: from MN0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::25)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:12:42 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::34) by MN0P220CA0007.outlook.office365.com
 (2603:10b6:208:52e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 14:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 14:12:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:12:21 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:12:15 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-3-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 02/12] selftests: net: py: extract the case
 generation logic
Date: Wed, 19 Nov 2025 15:11:55 +0100
In-Reply-To: <20251118215126.2225826-3-kuba@kernel.org>
Message-ID: <87ikf6cds4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f1e2b7-dfae-4cf6-5d3f-08de2775b3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8o+BHsH3sOXbl6rbVircLxTF+tugHrBlGNoIIZ7OBwuSfjn8jAhW8L189zwk?=
 =?us-ascii?Q?KqYVC27li+7UFLLbArJbOFD36+oUA3xqONMYNpVCmKHufl5RJf4vnQLnzZEe?=
 =?us-ascii?Q?+I3Z4LuZlWv0PDZs/geOv7CQfY/UqLV1TTgktGFRV+Rg1USppTnOCkZvI1T0?=
 =?us-ascii?Q?rPc0R8rFbw03u9aBWc/vxFVpqPYa0JRnj5PS4t3uh8GKjdLYAURkDlQqggIJ?=
 =?us-ascii?Q?EAzcKyO/hOWo91Q+l/Gv57oL1VNuMloFGW0geySlB57UPysz+c1Z7TTw8qOV?=
 =?us-ascii?Q?+4T8XhQSl4yKaxKfMIuYPNZJtzu9Gy0EFS0TsoIsi/awsaLb4vlJNStIrEIa?=
 =?us-ascii?Q?aSZzBdl8arBbCuI0PPwAAnKIUtcTtMl9xaSb6j37crSYNSNpmoLIioKR1KQ+?=
 =?us-ascii?Q?GN/U8SUAFrAAxcrQEIt0Vru5bXm1mIXXCKEzXp82/rJk03m8ifOTzIXGRF64?=
 =?us-ascii?Q?GAVYb4s2PLJRR1eVhgF6SiPvTsT3gQnYQm41BlEv7Mslpt3qmVqGV8TD/iQc?=
 =?us-ascii?Q?ixJHmEDqk5rfQTg+LPTR9gfUfKkxyZeEAr0H+JOICloFTf4eeZyICtVfsy8e?=
 =?us-ascii?Q?dCfAysIUJdwacEailEGoTNdLrCgl/0nnnH2zZGJPH1IBlLTpe1vjdJueViYu?=
 =?us-ascii?Q?GUdrlguJ5iNvyTAKVJH9dcIIv70jiC74No+T+/6AV1yReDKrAgQ7WGhArgCP?=
 =?us-ascii?Q?rt4Dkv8G6WaxiLkm8q8fLPUEvv2H+Vdo/cu5QqlKqxTlGNg9Brg0memKGfsj?=
 =?us-ascii?Q?ie0rjmEyTgRtbXd7lFkvPdflIsCsjX79djB5lMCioiz7r/ISBFW/PWn56/4U?=
 =?us-ascii?Q?/LmsRhsahcsEhj77cBwHn2yaXZt/B9QYNNg8kVkPCWCgZ7EVOXtaKZS6ILqT?=
 =?us-ascii?Q?oYYup0aLYzl4vWh85vpBphPHjRNeu9kwdjI1RyW0L1JgeATcqrzUZO1ZS4PT?=
 =?us-ascii?Q?OwGmXbSif89WmvGOFvwod4o/1pv/FDX3SelQ/9rEwQFXPSTTj6ZaFxdsHGf4?=
 =?us-ascii?Q?i8+W+S5Gx4QgRzGwt4Jw7Q1oDuT877aMl/qotkLyOc7fb/f7iUwc0FLXKNdU?=
 =?us-ascii?Q?0nHGv299IaP9JNe7y0OEFM5CiaU+6zmn3vQSueNw+u00byp+UssVS5NNDnAY?=
 =?us-ascii?Q?MZrEcJHFD3pTMw/K3U2W6gUKGh09tGAW7l+P/52D9gnf9kIyMbkQetVCw5HS?=
 =?us-ascii?Q?bRInKPeQsc58kY8oqJlgb12EMJOX3FQ+mPVR6xte/JskUjMj/K5DlIwlG+i8?=
 =?us-ascii?Q?4qwSsMkkQ2mlydJPge3/G2PQgKkZSkU4CzPlIpHg2jgR8ijdyN6ofZf6ouVR?=
 =?us-ascii?Q?RH+4U4f7HNq30mt7ijr0ZmM/5sJmSCVSjaeNBJ8xZUID23VLvf0wl/PhHBu0?=
 =?us-ascii?Q?CIYqKezqyAjoKAxg+yN2thHO/NEAkVGMRnE2ctHqi+AKNh9btAYCq9Gpq8YU?=
 =?us-ascii?Q?gt+wdTLBGHjmgjZTYBeOeiy+MeKn9VHcOu5gthnJPfo+CmOMbHCsi/BGKKKL?=
 =?us-ascii?Q?dbVpRpGiOCjeRoT2/JWih0M2AsH5emaE6VzC67aTdNLmSF3Ylt8CJO5bEnFE?=
 =?us-ascii?Q?ttv89Uop6uU6hcY0tjI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:12:41.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f1e2b7-dfae-4cf6-5d3f-08de2775b3fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335


Jakub Kicinski <kuba@kernel.org> writes:

> In preparation for adding test variants move the test case
> collection logic to a dedicated function. New helper returns
>
>  (function, args, name, )
>
> tuples. The main test loop can simply run them, not much
> logic or discernment needed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

