Return-Path: <linux-kselftest+bounces-46001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D8C6FFEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335AD4F8AB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277B2E8DE6;
	Wed, 19 Nov 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQJ7X/pC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2017288C08;
	Wed, 19 Nov 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568094; cv=fail; b=JMepRPhjgCIcZ9OXl4ioSKYVQaMX0bKxI6Hgzz9YUDT3dI6bRR9T5rjyWOBlD7dNCuYLcivLFRGRZRdl7W+f14TljdQ9wGvRbCQ/SD+07TAKL2gs+d8e1j+8JOQ1Tm8LE+dd6KWIp52QVbZFRmUgf0OK2dZJEQAhzERC4dv2wqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568094; c=relaxed/simple;
	bh=j107q189kTGNl/WPgtiVEXszO1j87aPKg38HrYcaThk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TKXgrj3rdTRkPi1gNIJQ9K/RTb2fh1yuV6/Mbcqe+occ0nnUuIYIZML9mGaM6y/GMTrZdfZikvuNORmAFgNZHiJmRnVP/SmzsI7odJQD6+EemKNa5DCh602XyFPWnSjlsc6tTDD4sLSN+EzD2i+SRUlG6dONeOKcOWrM5PFk78A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bQJ7X/pC; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnA4E4RhmPuLa8zkXz75ja48g1akyaj+/ToyoMXd5NBUfou5zEDfo26i+PYkakPFR+hKvHyRILeREqU3RRE37SNfmi/CAcfeNmviqnxcCTA/ENScg6+t8WBNKz8P0qX8Or71cDiR0DVZqQJL+mT9DjxuiLbcH9ooFb8xs6EumfL2pMxtAGd7R3fZeRCBxzS5biMm+TTatd48q+HFL1qXT84d0RcbaI9S5GoHI2p/pJVQ8p4kLAhcdTGFKOrrQ6vBar2PmK9FTnQ/OBQs8JJGNe+8qzj1b9qXFNfMQ68Ny3JyGqQaVm3+vyOP351zUJvEAbSfAqwi7QmysGj6CJT+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j107q189kTGNl/WPgtiVEXszO1j87aPKg38HrYcaThk=;
 b=U6/7sUpDrIL39bA3NJ2r0CfAfAX2/t0uT7sr/wzLcjazMxwFjqNaPDOs7HxOiRPOg004LN5iz0krVP15LQgHHx5pKujpUDmMljHvvWEO6+2W62oj6xuX07r1sbXlaJSQLh2MTFwrdpGhAHBOTAYZpLk6n7RzGndQ23QFv6xdpF4EI+RV+PL0XbonzVOamD51k8XeSqL5+pG0Dmwdr9Lxwbt/1pHfrPWBhuRlqOHGptHH4v3HpqasBX6I5NPWwInOwXcMonEboOfZqUnP19+tgaAxCVF9Us5WqRle+i87GenfbEXqugxan2Zbkop9K+oIVl2Npzv9AQ86OUpIa464XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j107q189kTGNl/WPgtiVEXszO1j87aPKg38HrYcaThk=;
 b=bQJ7X/pCnwywz67L4kTsLBxTLbgjE7UhUxlTv+vAOEXQBzaWRj6guIXBYw2nrT6J6W4xKIGF7VakD/pUDxxEBBRIirDziTrIqTieEYx72lrR+01O9/CM8GThl/yUz/A1+k6MW7qQCILSfOBiOB+ZUIC3ge7f32hVJsTMBQSd9vQYwvzlfX+KiJjwI6xhEFk52Q2KyNOIq31MZgmkN36gjtyU8h15FyfxCIUFkbwZfU+SYxA+gXuds+wnccTPEZXpW9/ggCfO6vIr30b+RVnDf/N+2koqPmLz04Mb0UOZ6sUwf2InClUnjENzuhtDuou6XC1imI4vX+Pj9wWUX5siMQ==
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:01:29 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::fd) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 16:01:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:00:52 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 08:00:47 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-9-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 08/12] netdevsim: pass packets thru GRO on Rx
Date: Wed, 19 Nov 2025 16:43:01 +0100
In-Reply-To: <20251118215126.2225826-9-kuba@kernel.org>
Message-ID: <87wm3mau6r.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a60cc1-3578-4d8c-2be3-08de2784e599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4AnHUOhfO+W3qN20SRlReVUFDkPxhlsCSsqSpJCF0ytkZaZAqGyTmWGIu3E?=
 =?us-ascii?Q?iiCBcNoU0gldOULNP6uvnfBxM3hxswvI9Wlimp/UBqFjHj0CpaVrnO+pIjrt?=
 =?us-ascii?Q?/A92IAUXaE9FU4OzLCtXKoc7Ds97oliYin0rVGEchIGW6YRX7bFdPGy6OyYT?=
 =?us-ascii?Q?tECV8RIXBgnwqoIhxwOjm7RcT5/pXiiwbTWD7Cm8aSVd1IIYDcEOOtV+x8I+?=
 =?us-ascii?Q?XchPbmSU8N8yRvirAqSbeAK/4DeI244bJUT0Iy2UqWgboA2gheLSvVwNPYBu?=
 =?us-ascii?Q?p4vUkKDnzv04JEe0AG6UBFdoG5RNoH2Yypmaz5VmKOymH4Eu5fd1dLd/3Mra?=
 =?us-ascii?Q?zkBEafzMRAtYR0x+n6OP/GAOqPqfXnahh/17lJiqKHTYhkt4fGQu30Re+U8g?=
 =?us-ascii?Q?vlwzh3Jup5uMStgayuaGsmakFbjqa4AJ9mhz3QKh/20o2ZMjLvHcOGdBJBUI?=
 =?us-ascii?Q?NUEEOGy2G9iMt7bP9U5PNRzbTNFszI5t03AdAIQY3Zl9nQM/0C+MU3CU5ixD?=
 =?us-ascii?Q?xU+m3GQgR54Nhniktfyu09LjaDa52I89q2a3w7wqrVNbX/Fn4im8yzBH4zV/?=
 =?us-ascii?Q?INsLEZFMOQqpBNRCSm7wspEoplSpBWqur+ELtf5hgjoCQS8P0bSeKj3uwT7e?=
 =?us-ascii?Q?nEdfydqV+iz3Zmi8EiChFpfylhLKm+JCJ91QN6c8RzMI4+NvKYogrBM9MtVU?=
 =?us-ascii?Q?I3gzxCAKmn6au7k/RiQrWnkyMAPzM9H+E2pWq6pT8PRCoMQVBywfVWU9nXs4?=
 =?us-ascii?Q?RD/d3A41BzW73MtKpfeln3i+xIGuMMqqL6rMK9A6Tv7L5rxrA6Duv88ZIknA?=
 =?us-ascii?Q?D+YwEdfqPTFH5PYoehyNSiMj7ThBojgtmlqeX2PrceTf8ChtIP2azZphU+g0?=
 =?us-ascii?Q?pcIyD8sUvs0s/FmRxixLFwcFRqR9bTzIh55NwfSo3pp6JA1QWYlDKLcPktO1?=
 =?us-ascii?Q?DTGeDnNQlP0PhEhU79UnuSWYYKjB8P0b+tS7m/e5GZylIzm4zZzwe5YAW5iQ?=
 =?us-ascii?Q?RtJUgE2QPs9c29Vjyli5PZnk6Bfe0oIy8xnRN/jj/48rLpF2BXHEQOIS/5sw?=
 =?us-ascii?Q?L0Lru8KtbKRjXjhgdz/fGOj6+8YWYTjM9/oDCemdAEiDb+R16uqqBYMUUoZV?=
 =?us-ascii?Q?KKOry0BfJPfYblifTHIHG7Hg2BGNvRuhSB4E7KjNPYP/QXy1AHTr1wsS41d7?=
 =?us-ascii?Q?0a/U6XpMoq17jfuwaPv85cRSnfbF/cI8mGGe7losqDObd0LoRboheYzrdwBN?=
 =?us-ascii?Q?u5sZztvNqrN83YsAJ0f1ohA1q5Otr9g7q6rn1u3MSBY6ZOlAN122fiQsNEc6?=
 =?us-ascii?Q?ZSOzV1aBSjjxltgXA5IbyQTQf381sgTtNDF5Jh7xuK8xszvEoRGrBcgzqFIT?=
 =?us-ascii?Q?GFgoVf6q8AM3/icOS9QMIiH8ELS9cKx+a2QLV51t/Dad3VqWltXzQXBCTI07?=
 =?us-ascii?Q?gBq3/wFEVAHo/Y9TZpjveLjMZT9Mjf6y4k6ij2KhfVA9blnmJMu1WhCQci5w?=
 =?us-ascii?Q?X5zZJlM7UZS0+/fgSoKBGOEO3f/RXuI3T+A8RAMWFCJ//bkEyseRKLqgyMZM?=
 =?us-ascii?Q?8gwiITYmXPNV+n1/8cM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:01:27.2499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a60cc1-3578-4d8c-2be3-08de2784e599
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737


Jakub Kicinski <kuba@kernel.org> writes:

> To replace veth in software GRO testing with netdevsim we need
> GRO support in netdevsim. Luckily we already have NAPI support
> so this change is trivial (compared to veth).
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

