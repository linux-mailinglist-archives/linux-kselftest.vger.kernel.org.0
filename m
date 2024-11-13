Return-Path: <linux-kselftest+bounces-21915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB59C6EB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F272812BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3F1FCF73;
	Wed, 13 Nov 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qsqwvvuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB541FF7BD;
	Wed, 13 Nov 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499604; cv=fail; b=HAcq45TPs2IA1IhweSBY7HNxJ7dfcJ7MSJGDjwfP+UBXs8qcc+K4O78IuW0Ze32/hGfjFPX193rJWOpFrBRSh9ah6FO0/W63Pl7DYx32DBR9ORRqwd0bAW9j7rJXebdCLy5LYkhv4zb4phWi5pS/5XTr6iUa2BhK5MNwqJDtzro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499604; c=relaxed/simple;
	bh=py09NA4izy3fdE5gk5cBQd5Q9HQ9AGKig7vMHcK8+dY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dtwf/PJxNsh8movvrKA6WZc/LKUpaghXI0NKyM/FiQDlqwcFmzmuV06Ax9BXz54IKA/wC4KCi3VrI2ISMKmtzDq/Q2pWkn5W+YdtcTv1tZ0xHnSwnr3UVv0FFj7DVzBZrjFBq6K7/PncAMQLuw3Cvp14b2QP7E63Ljtb/lvI5HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qsqwvvuy; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N246MX1YW9eHXNytXimUtuYz9GxjjalubGxSOcrTr2QV5ks5hDmFmcsVJA4wDfNRB6h2Wrn+wiNPlwJsa3GEam/sdwbkmZXIRbs9j+xLN4THaTSDjI2PzjPRKx+cUIbJMdSvHshmDljMRE66hKiBo5xkwUHi9JmIPwZjr4jQk3JCcXQoDbDIu5hhaXMPMxffp+S2pgkl/2oGqm1H6pZqOqdzZPK8w0no/BEnAyuOsyX1UQXsrA2U26SfZgyN3NRckPYfaq+RcGnU+/cSgnPfVkLJjWGB9yt6h325stPaMV7RvTxIuGwyR/ZxgbbZxWsYXVWLYnTjPyFuDxtUxcJoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbeH5y7MuFmP4Yj/piwLvBVYyiXVYL+qb6KJZJDpyrQ=;
 b=neHFMpG+INDnkUtDRM8KSX8cXAMcyc4YgXBzzAkFpaymKGgbRLAJ/pXzRJ/1lDzmRvB6Mv/K8JhBVZnnseTIilSGVDIIk+H4REi2fzg2vLCIT6V7NMA/oNbfm2Rnb7cSjQD8Qr6jeEhuuxOgP+pfX56UExPXqczTcO0Rs25x7dayvQKSjKHbuyTx5tzEnpnR16/8ibxxGtq2PMMH4xf1yRH6lXJiK5nSFbVTZxBfQIWH3Bu9wF7Ul7zi4QChZljZ35dpODsyVHjxnAX5BRapX4Skx2KLhcAmkSWafCBRJ1uUrhrcC0ZitZEkp+xNdelkKXnOfU6p27tQoj10uihUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbeH5y7MuFmP4Yj/piwLvBVYyiXVYL+qb6KJZJDpyrQ=;
 b=QsqwvvuyuAeni9es/2Be29fKxt88hOKeSGH6SkkQ5jvac4Kr/lUY0oV9JeikUeVVTfw9wEh3mVOoy00QVH2IpGKuOfi2PxnT9Phb7JENeayE1QXK+7H8CTDmox1Q3jkdrYa10ZOKvaeS+Gvm/FjBYz48Zz+uBwGCZFiUz6VdjQ6LxfyyV6yYUTSpfMsvMrILuGrcyPnyId14TM756nrgssskECTWeyewLM9H+qHRkecwD+0R6f6cC/eIiZjwUVZQmP983hZvcj8/uUwSypHix96OlaY01TAwIXxX12HEg0Yw3YJZAi/dCpD3pa3Psk4nH2XJ6zL5XGe17NPRWTgTIg==
Received: from BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:06:38 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::75) by BL1PR13CA0021.outlook.office365.com
 (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:06:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 04:06:16 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 04:06:08 -0800
References: <cover.1731342342.git.petrm@nvidia.com>
 <baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
 <20241112142234.7abf2232@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: fdb_notify: Add a test
 for FDB notifications
Date: Wed, 13 Nov 2024 12:46:10 +0100
In-Reply-To: <20241112142234.7abf2232@kernel.org>
Message-ID: <875xorjq37.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d0c538-e02e-498c-601c-08dd03dba022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gknjdJMD4A7RTWWyWprA7quRAVqhjAdyO0q79NMtmE26h+fXf6qtIu1X8tj3?=
 =?us-ascii?Q?HfaHQSqcYpy6hsXEHpFiSG++PW9R/swaQclUmEXm3AiKll65Hx9TeAwyzKU5?=
 =?us-ascii?Q?unnparPRcqDvVN8k4o0GihDePjT+TjicMKH0oFvSw7lU01/FedoxgfGCgXaM?=
 =?us-ascii?Q?uU/TGyB34etzxzyLg/Ko9IddgE1TY66aSXKe+/tHXG5KOIM5fSgVpQcSW2pJ?=
 =?us-ascii?Q?AJRyNTAqtoT85y3J6fWv/4u1EebsqONtQ2sBW8JOuru55Xty0QDN5P+aB8Hc?=
 =?us-ascii?Q?pU14v5Q5NxeP2wHx16BGp0wFlip/5K5ExY0wZjpvs7M0ttORtZc2gxVqNM7+?=
 =?us-ascii?Q?mEUEoaQLN85P/8Ta6zcXcRkr+rbmWeaRTD4iyAklISCXA/rCoyHavyi1eAU+?=
 =?us-ascii?Q?3aEfa78cBmU9p80VLrFFlv0FEqoo2SXlIhkL9eSJUpar8ieHxsCVfYtrYVr/?=
 =?us-ascii?Q?MTylh6N8ycy4AAzTgonG02M+6CSFGSxXBxuNxpKRBcCmiEuflCDqLZzC4c6A?=
 =?us-ascii?Q?DAN6nZosvabFbluUrHLyM9B5phqJrJhZ2JQPy0IUwp9XKzxsaddkiadSBATP?=
 =?us-ascii?Q?GnbIxJrXdJUiC7M7zN8wneXF931ifPZz4wnbWw3GsGNNlvvDGo+yUIFhDHPi?=
 =?us-ascii?Q?5Z0gQwhK45b0j4k+F4dOcsfXSEVQq30aiJDbdndy43/AFWQZlmOyKDhyLWzl?=
 =?us-ascii?Q?hndNjZJ6jlcv8uhgEtJAr3U75x2eIwShJl0g/Jg8bpP7T5mCxwiB1gjQecXx?=
 =?us-ascii?Q?lxO7Rve+dbB5nFCxFAYnlA8prn7sE0zRvopQ1hqDn+2kqMM3tYUNLQfIFOTA?=
 =?us-ascii?Q?grubFC2f5RWUsJ9a+RoUHobFZpe/Jj8txzn/gx9i+BSb1Id68WMJio9TFW5K?=
 =?us-ascii?Q?ZV7tlM8VhQ2KB8L5SiaRDwU6xNUzYawLo99h7UaZjp0xtwySiJTxcmbFuZTO?=
 =?us-ascii?Q?kO0gIjgw4yfXiT4DOSgx/I5zVlOr/pmIsWdl9oG1uP4hl0wQ1MkQfXt2gm4h?=
 =?us-ascii?Q?PFQDNs+Ztx3uNnmF/DTqLkp+sPVkMRMoQYvu9J7JUHcDrtfoFbatoJlKiWfy?=
 =?us-ascii?Q?qmhLeQaJAVVoQ/d2nZ8Vb1vhvp4xgf23RDjyBK8umWZ3NbnKM5TPTvCzHajU?=
 =?us-ascii?Q?WXu/O7vtCsOk7zL8Xk31AgWe7cYNMlSrjS7gezAR/PNIkNA9s0pgLyYQA2ay?=
 =?us-ascii?Q?1DnIN852fH0fSTiZqKOnippdSDD2q382Il8vkHXGjY/hrBim9OT/7NwjZapH?=
 =?us-ascii?Q?ABKAdiM0FBULVSKDYvln1PlKrEn+hWdtcabsz0UVji9m0OGW+tgO+KmOPott?=
 =?us-ascii?Q?Q0Vp2P6FeL1oKLqivp5lKhdnmKiOcYwlG/VdKwWQar14YbmDLHZa16w2pIx5?=
 =?us-ascii?Q?f/6t+UjHLkPKw85+2kr3qnJZeeQ7cxOBESdb/dU1V2A8shvbww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:06:37.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d0c538-e02e-498c-601c-08dd03dba022
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Nov 2024 18:09:01 +0100 Petr Machata wrote:
>> Check that only one notification is produced for various FDB edit
>> operations.
>> 
>> Regarding the ip_link_add() and ip_link_master() helpers. This pattern of
>> action plus corresponding defer is bound to come up often, and a dedicated
>> vocabulary to capture it will be handy. tunnel_create() and vlan_create()
>> from forwarding/lib.sh are somewhat opaque and perhaps too kitchen-sinky,
>> so I tried to go in the opposite direction with these ones, and wrapped
>> only the bare minimum to schedule a corresponding cleanup.
>
> Looks like it fails about half of the time :(
>
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=fdb-notify&br-cnt=200

OK, I can't reproduce this. Trying in VM, on an actual HW, debug, no
debug, no luck. But I see basically two failures:

- A "0 seen, 1 expected", which... I don't know, maybe it could just be
  a misplaced sleep. I don't see how, but it's a deterministing
  scenario, there shouldn't be anything racy here, either it emits or it
  doesn't, so some buffering issue is the only thing I can think of.

- Deadlocks. E.g. this, which looks like it deadlocked and timed out
  ("bad unlock balance detected" followed by "blocked for more than 122
  seconds" et.al.):

    https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/846621/18-fdb-notify-sh/

  Like... how could this patchset even theoretically cause a deadlock?

