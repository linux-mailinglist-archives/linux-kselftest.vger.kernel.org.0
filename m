Return-Path: <linux-kselftest+bounces-10343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFF8C86FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85F12837D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD344F208;
	Fri, 17 May 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QO9ia5di"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512C4F608;
	Fri, 17 May 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951422; cv=fail; b=BYxGIuTXDBTN0uIXiGa099TXtAXZQkSliplIGf4i2edd2bqmsmk1fkfJUC3dq35pKJBmO3MPFM+Gg/0LR3M9FYmKW6uKqK5U/RrR3n15HNYuSVO448P+XmbRsgDzeztXqEUPY3FFxydu31qp3P08iWBJhjS78UHXMt5tMMBt3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951422; c=relaxed/simple;
	bh=SrWMKd8c16Eex2XTkianVcVUIiP7+D4E/gndG0RRM5w=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=B9Tehryvagj+MZNAY4fnmEOuMC71rYl/yDroK6h+5JSV/OkZMpQ0u2qu3CvfYf3uXujzDZ4XX5P8T8TJNBZWp3CNgUsimpYpsTTotZFIUcPpyvoCHv4EebehOQPOUQ7T+0Jnh8E8V0zt9tY8Unx9yvlFdTYWduh4fZ45NZNK0yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QO9ia5di; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZC2GJdrNlNufqmT29leCq56K1VgsYNUdzDMRTEP8Hqqv4EoYlsDaH+9paV8E0lAvomtlhJl87REWALiiYoGG4Oss61xfm7NPS1oIlRIqAB/A6Kf8eGsP1T1YSHz1PSW+4k4LfOU8aM4ZD3Y0gMDPIsg3uZC3wihh8Ksuph7k/RJ0m3wHh7gUodwoW5FHj4bT69oCWGXzx+InfIokxCWBX42W5zUoQPoEFRJHjo5sB82f4EYeA+b/5MfLQbzH1ZkmfKwsNJucuD4n4bqFQ/KqqCLYc3p8Rn7eY7FW/Y2CP/vU4mB6I+sxX6E82zHMQ5LYzcTw38cBdYhZLq+ZvAAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEiQiVdB/4UbA05xEKfy1cG16GWCFK4OyuNJjIPhUE0=;
 b=LMtld3BORhW0lDI7RoiL7jYsvDLS199jInBiyr9nJkCe3fgNWV6XSE4rp+7QvPYF63aHQx3FHqJU8zkORNo2GWKEJBgrk5j3Ug+iRQHaWRU0vtZWHj8aq2gLrEyK9LjPaZnchAqNjJGK1YxsKzJVUCTTycr6Ktj3zcyJ/os4qk/ZHsmawM1wX/8sXeOxgVi7w1EbGjQY4j4DGZt1gGLOdT5qO1gOYZz98dN1fi84hQYBjnUys+rkhR+kParloAsdjlHisSNmLT/LNRa9FGILgcrdviw+7yRrBzImXfrbk/19TgGOYNV+6phuOozFPsCPcjUl+7R5gLXCsAzZ0zVavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEiQiVdB/4UbA05xEKfy1cG16GWCFK4OyuNJjIPhUE0=;
 b=QO9ia5di6dH6TY6D75LCYnrMxDmJJ2d6XXrFbJbVHWX1T53Po4paZtmNXWfgZflOEW1mpZxYvZiRwxWs+uGn7j9yWYdILyrev5P+hJnxvBhiOb5RmZO864aYswApuRcP4/xcUFzeROkmcOpp3ipjUAIoUKyz6+1AiTv88kqZOezYeg6G5/AxJPW/03fvC1M/ScEyHmNSbMM3w1ApIE04b7p+bzAEwWIadxm1kliEKuI0OcGGxS9vh6FnEQQwrlCRmDfb6N0VnnRZeyCfPisGH7yjAar7C48oR7m4Rnt0n5j77PErSn94Spq5vKtx4SO5yy8kmu50UrPCsJwMsrqXRw==
Received: from DS7PR07CA0007.namprd07.prod.outlook.com (2603:10b6:5:3af::25)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 13:10:17 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::8e) by DS7PR07CA0007.outlook.office365.com
 (2603:10b6:5:3af::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31 via Frontend
 Transport; Fri, 17 May 2024 13:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 13:10:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 May
 2024 06:09:59 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 May
 2024 06:09:55 -0700
References: <20240516152513.1115270-1-kuba@kernel.org>
 <ZkcbXKfLHHg1h15w@Laptop-X1>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>, <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v3] selftests: net: local_termination: annotate the
 expected failures
Date: Fri, 17 May 2024 15:04:51 +0200
In-Reply-To: <ZkcbXKfLHHg1h15w@Laptop-X1>
Message-ID: <8734qgwpnk.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 545eb33f-dabd-41dd-8178-08dc7672b245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hZe9npMXkGI/s6DOxu5VtxB8K9gaHRlx+MbK3OAfCIYp8gy28Zc7QZRt6Uxj?=
 =?us-ascii?Q?CQQW3Jsm2+KBocRrkRXp/SGiuM4YrxoQWrYaj+pwRR2GMXw1IMLWHqiGgFIK?=
 =?us-ascii?Q?iyit61Gd8QUimRUqsy9g1RlhF2mFOyIbBb/+QNmVtLjITSJugCAOmkJZ5FfZ?=
 =?us-ascii?Q?4w7crrF7Dxlkg2qgrFWYuW9wXjn05V+6h2Jli/79sPRdj1V75R6uwz3YQ80c?=
 =?us-ascii?Q?930Ay5Udi6atT7dKg0iWXQxFc3a+ynIdZfG2Dzr7aP7bunSuEGf4smcsX0vK?=
 =?us-ascii?Q?0OuIQVLaPIMDhUj3N6D2gtiZZGnLwPTWYSZFn/vHO7v4dyXJ2JyCsinAl8Ez?=
 =?us-ascii?Q?5coJq+Bg70zrbZ/ax13H+mvIHj3yhOe+0oo3iP8yt6TCKdKhqgWlSzEK9wvH?=
 =?us-ascii?Q?TqjeU5qpx1+ZHroMWOu1a7w2DNx2cY5U+gF6w5hKFEAXZ+AvzkbrOp7RGIgd?=
 =?us-ascii?Q?8+0GkkQKnhGt0Cz1AeQCpSR6Dpx0Njcub7ot9R5yIt5OSo9tDrKO034BYevV?=
 =?us-ascii?Q?mBP0+QIYHueZkjBucaTQAdkirW877iMhF3eIfJEGJHxA9+PdeIPRQmFeoVR5?=
 =?us-ascii?Q?tNFw5nOv6YKsCJvxFEUG+8PaYLR1dObOE5oSrorp5f9lrEzklw4HKsXyA81f?=
 =?us-ascii?Q?SwI1q3hvUG/KKjSuqpArAz6gMQ4AiQIi0+s5UvJWQjis7l1iJrTofNkVlCIZ?=
 =?us-ascii?Q?rqTDy0z6SQuBl0pKXGq1Yuvcx9s8WHTsODEMaeD2hzlIuKvfppaaIirS7FS8?=
 =?us-ascii?Q?v5be5XMt+lUgnvKzwclCkYVfhS+HC3G0YkpBPBkW+fPxBbcMmhEhvi/InfO3?=
 =?us-ascii?Q?zjTDJUjTO7IgrJureEI1ZkiuITFyWDI/RUsCvBasDSPPVAX2BSBfTrRMJ6lh?=
 =?us-ascii?Q?H3GAOR6gG8TlqeRRUaIj6qDdBUGevAKhoET7++pAwSJOcWsPRA09b9S8xsgZ?=
 =?us-ascii?Q?olog+lOGUD7cQ92CsuqQzk45KQ0kl5TpdvOfQYq9Dke48UA0wWD+ttv5uc3I?=
 =?us-ascii?Q?NlfEDYP+Aj4guzHFzRwsgTbzOazPDy5XhuyDVm9UDf1hVLYSQzUmcPFS8smQ?=
 =?us-ascii?Q?FYrB7a8aCZhCur1q09oCgU425j0QVXMGMUP62uwWw39U3utb5CZ2eY/t1jP8?=
 =?us-ascii?Q?ol5zdgg5MKdGyC/X2U3dK5EiE7dsvb2wSLfXasa9NX4QomuyGx1w8Y88MK3a?=
 =?us-ascii?Q?1+GN6wr+kajoxzJcJQsKGSxy26ihlr07RDxuIX3tElkCsoYsmuuTViU0ath3?=
 =?us-ascii?Q?c84z2CmTxLNpOr0l11WJrz4K3U7uRkbTxEMYnRkZ8No4IeW03yyD/MFGKN6o?=
 =?us-ascii?Q?dThDo1VIA30B80yBDYiOJmq8UiT/nuIZxaxKx9UxHrnXiuAurS8nNm83vWrz?=
 =?us-ascii?Q?mk8kEok=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 13:10:16.7454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545eb33f-dabd-41dd-8178-08dc7672b245
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139


Hangbin Liu <liuhangbin@gmail.com> writes:

> On Thu, May 16, 2024 at 08:25:13AM -0700, Jakub Kicinski wrote:
>> Vladimir said when adding this test:
>> 
>>   The bridge driver fares particularly badly [...] mainly because
>>   it does not implement IFF_UNICAST_FLT.
>> 
>> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
>> local_termination.sh").
>> 
>> We don't want to hide the known gaps, but having a test which
>> always fails prevents us from catching regressions. Report
>> the cases we know may fail as XFAIL.
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I'm still confused that the failure was shown for $rcv_if_name==bridge,
yet we are testing $h1==veth. But mechanically the code is correct.

Reviewed-by: Petr Machata <petrm@nvidia.com>

