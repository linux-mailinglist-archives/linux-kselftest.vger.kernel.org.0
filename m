Return-Path: <linux-kselftest+bounces-22820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6889E37D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101E7286FC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463521B0F00;
	Wed,  4 Dec 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpIK/Ymi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFD187FFA;
	Wed,  4 Dec 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309156; cv=fail; b=EQ65sFJeikmK0KHj6lkPJK9LZWd3POwEowMWGPIomKkojj2kl09cP+F7WcWKo09iwqMQhsZP/6nKoyUAnCw5aKTwrzSDWSNUTwK3deI05MhJNBPKKN1CQrkg+XhQogfCLV7+0rB07kmV5tozim89xtbgzMuMMuFzt+f6at+TqVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309156; c=relaxed/simple;
	bh=1Y57I3sVgBXISzWvKmscPcLJRlk4OhrC0JQFbol+RP0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y0zmm5tVB07cP74zMZvQcNNHyoZhfStQjpcbfDQBrpKo5h11uxLGATKkeXhqFCie4bUHFkMd0YVARdpzPkU6pKSJeUGXh5TvQZZUAEMfVZE6YNEgyM39HGXfr1BJ86TXDzDE/b8MvZozsvVkhE6NR5yaC0adXs86mwuDgMFctg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpIK/Ymi; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoSWsA/5d4MRYuHzXP9eIhcv4ujRo3pJHF5GO/QGcW+rdsws5Ouhh9GDVc3bKyz2I4h+dx5nXJYuTT2KFH5cilsdWbJwTtPiLBk+DdKUSqL+eoNLGRcpWwUAe/0aOP+5sedCxBhPNbhsP4tqQfZWFzE7b4fhY8Cku58xev/4bJdBvwMmh3A51lVXBVNHwUPhWkoumBB5/3X1b8+W3T9xNMDyt3zeAAvbKuwsT8evTLgzKw+K4ObzS96N/cflC+jXe0wNdklcYFWjiUtqgfRmf85z0oy8vjS0SLnEACVvAW4qNLWQ+GfuqPT/Khd8PkMLakXcS7xktT/Qs5zisaWHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l52B4lY5dBoxjCah0hDkKQ4Z96PShFbDdG+0NhDRCVk=;
 b=fGWx0/j6/x77Q61X6G7tKa04AZVWYl6uWnYkbXtq0b4Vnftw0B1eZg+ey4JgW9l4jk37YfvYPnrBqOCQ7m5TR/woKq8MQousi4WXe8z6mWl+kQRqnJcn0fv8lItrzsImlfGJDFkyqXANVFDBtn9i7JCLhVVKJKmhzAOWzxUksKk7LIhV42DZ7XUWjypQWj8BXkamRq9rZqfH+UuN41AQPL2juJE3YVWTjKU6xe5H6sBfFQCUFO+xphUB6+TSfGIwO1ARdByzcWk8shNQJ8hNFUklgkD57bS3q1bApJxX+5hariXQCKMFgEPTMNTIXSzX/zQknZpT0GMs4ilHGpua+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l52B4lY5dBoxjCah0hDkKQ4Z96PShFbDdG+0NhDRCVk=;
 b=ZpIK/YminRiz0v7Xmk+YKtSXAhMIRGQlry9pdIZ+2Gg1BNosWBwsq54Pg8TeYFk02qfvZEvOGcrxThnDiogeZbfJqnZ8FT8Y1yht8LP+h2ZknoOKfcJQrO+5PtKYMYFX0Di+llHopgv1AmfCwbDDt8cAZXeXGR0OxWnC0iQIQgVS5EnukUgiQhsUPMGE+IbCDPHzdwwH98a5myT0KbR6a4TxOKy0BzAYg4W4svugewovLMaH6lSQ8x57TuUPNKgTfNEWtgL/gT1lpB8OynoHY6/23z8M8SXmCVAqtKy3NnFVi165vokWDnCN9hukbveXxl/iKteErxYe+V2Z5V3gig==
Received: from SA1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:2d3::23)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Wed, 4 Dec
 2024 10:45:47 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::ff) by SA1PR03CA0011.outlook.office365.com
 (2603:10b6:806:2d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 10:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 10:45:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 02:45:32 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 02:45:26 -0800
References: <cover.1733235367.git.petrm@nvidia.com>
 <e4591fe820d539e45a08eae96a69ac7353a2cc7c.1733235367.git.petrm@nvidia.com>
 <20241203190807.330fa9b6@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v1 11/11] selftests: forwarding: Add a selftest
 for the new reserved_bits UAPI
Date: Wed, 4 Dec 2024 11:44:29 +0100
In-Reply-To: <20241203190807.330fa9b6@kernel.org>
Message-ID: <87a5dbohfh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 320c5be0-351d-4ffa-62c0-08dd1450d000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KwMTrtmbgPWqlJYNN8U9SapGWmou2FJJpl/KrnQTcO9ohr8YEiuciHZMKbS?=
 =?us-ascii?Q?QNdFEs31TmbVqutbpLZMZahsr4fSAijLvOm99tknyfU84aNcmiTlLmj3u2MJ?=
 =?us-ascii?Q?vfdALYL/fwZvjuq0zZ7+qMCflkOAHgdzSzOLuVz7vk580drs9cERBmU12ghg?=
 =?us-ascii?Q?SXPs8cD237294TvHpIyWKVdhnn+OV11jIEMVaUlu68WrFaW3FyIOGTXdBHQR?=
 =?us-ascii?Q?sIK6of2Q5vT2j16jwreyAMfkrlO4TLTNeR4eStIRHHC8PImhpPxaIYtvsZv/?=
 =?us-ascii?Q?7LCLhQpNGO90irF5oUgrEVA7xvQqQZ6n1LprbRTDdwwBo534ZhJSJ5Lw8zOj?=
 =?us-ascii?Q?V3L+xgo0ksPYs6rNypsBLNKaLQSL3bRxz74HDzGMWMxqRcNHSY88fKYuist0?=
 =?us-ascii?Q?pVjhn13bcyc/Hk4UiBIlK54rT83T5zoxZnXgwGYwy6dXJwHbBOJfVaZu4+CG?=
 =?us-ascii?Q?dQBakSsBetzalYHuyAPeZ43i074ZogjRzoA0Xcl4yKkGGCYVpzA+1ZZqK8zl?=
 =?us-ascii?Q?V+BIvWVKr0mZrGU/M19qZjUkpfutxzQ0G0sedXRs66QbH/L8Sp1wPp0qDroZ?=
 =?us-ascii?Q?74pIOWx+FSfSf4xsPZRDRM86bg95zZZl8067SniSCxuAueqrc/xUqW84rZAs?=
 =?us-ascii?Q?Zj7hDw4nhZKcmwK8t5bv+y/elabpq2oxeKF2DqwNqSg2eJNZjPMwxbtgAX4n?=
 =?us-ascii?Q?awVYrFbrfCFzoZixHYpUjchx7RHW3Qf1dXF4CkGqlFLljCgtkm5Vx8vNGUCA?=
 =?us-ascii?Q?A/M88o2Q80+OFBjTqupfP/i+ICH3gYddEZ6LoSMX31gov9vtrG9wV1pYWD7s?=
 =?us-ascii?Q?SLXszNipPHGgACnLX2YIRQ+42lwmcRa08mQjTfajLVMuG2S6vWZUQc7TWjqE?=
 =?us-ascii?Q?LQSCkS/U4/R/ysq7pmnAQY+1bo8x0bXMxfJrPAVr/FVBwcoYp5KxwnEvgaXk?=
 =?us-ascii?Q?vWIvqJNAwIgh61uWK1gvGC2x/Dc4nvX84lGVQShuGt1fanPB2amU1m7/hbz6?=
 =?us-ascii?Q?AMez+xvF6bzgurimBfgUDcpEJafrntSgFhoLQdHIqibgkKJBvczp7VWg8G+a?=
 =?us-ascii?Q?KLSJ69p96LuT0A0m5FGKUPlPMZbYXY+mahkMJ+kVI3Y/ubxUTtrjTsE+oJOh?=
 =?us-ascii?Q?seh7KJKOm8WU8a/IleWqB9vyZqT7auMrllSkPiAY4iVVBb8N/U3emwMLNlkX?=
 =?us-ascii?Q?jVpmRXFu7vBtVzqpcJagoUp3PzjhM5+3B/Knxz0fH7pKfs5+WrzDmotiGbl9?=
 =?us-ascii?Q?3Y0ohZbiKy7HIftHKGut7tNSGIJL6ut7QK48lSDYUxJt0tVW20Dbwb5bXqB5?=
 =?us-ascii?Q?6CmUfuTrlHcK0ObcuJPAD1TKLiT/b/U2hXxQqkdOHWU2zRQGk1cg+OV3GtI1?=
 =?us-ascii?Q?DCOsBOwSpJtiT8rXwatzCtrrHCx4d7lBlIaf5/GNPxkkgoywJY4KZOKvjsFZ?=
 =?us-ascii?Q?g7fHU6+cQC10qfRL6AVEmkBCmOCskDyA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 10:45:47.4697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 320c5be0-351d-4ffa-62c0-08dd1450d000
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 3 Dec 2024 15:30:37 +0100 Petr Machata wrote:
>>  .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
>>  1 file changed, 352 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh
>
> Needs to be added to the Makefile, AFAICT

Yeah :-|

