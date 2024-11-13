Return-Path: <linux-kselftest+bounces-21916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA89C6ED4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD975282A12
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE8200B86;
	Wed, 13 Nov 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZuoH8xS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE983200B82;
	Wed, 13 Nov 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500105; cv=fail; b=cCe3kw17LCb+mlLGCnAuNOUwXIq0c5MfKiD6ATPoFC9d6eE7M3MOGFWiN8TKzPOh3hA2t3MD/ukM5aJ9p5f1WEDsW4KlXULw043Y2Xo7JBe9z7bydnocM/q2yq1urrXo/N+tRhVq6Q1FnP6r7zrLXG6ZmaeNGW90uI9jmm0/WN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500105; c=relaxed/simple;
	bh=sl++vUSWpNMCaUhoVF4QKW4BiqnGurQOY+xxmOhWBgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ub6Nz+2S0MPaNBgR5hZtC0yQKNBhYr+kP/yRtS73rC/v6w4qfxjLKwVCuHDpRcxpITcAMpPBtzy6nnjAAcMqL3tQoF8mcq/JXHvcwkNIFbk+1Cr+MED3Cw0k+eo1cDk4zrNyfSclmDfuUIVFF9Fj3I+XTCD34wDEEFeJLHu9SVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eZuoH8xS; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQc4/gfZcn6gJwaicF4ZsFOuMypi/Fq/A2mR4SVN6K7rK57W+IpyJExh6EY4tp7QBBgQNhiAXBQS2pM26wMm4fynxuMHY8cm69XGtpLiBW8Vgt55wxONlNUO/Yl8gs3nuCUWvQboHKykKLtImhomnNtdKmRDL4DNL6cAJPtR3ysX87REwhP8tvh8Hs6j1NTWpmKpRlp7B9Zs+RxxKhHBOPFqskztW0MhYMTmhMbrlatERcoLhHj4EnMvqpVibFNkqbB53URqFnDP5HBpL9AMlreNt95MT+vjVl5/ayrqicgLVFAOvB2/iKfbJnE2z07LwJJuE6Yj/ZdCGg/+lyHNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCevIvUZT+/6BJ4/BeRgEYAsSQqrEJe/KRnFh8ybNZ8=;
 b=lxkcr6ZneSjAoW31WoRjBkFcMrc4I4VDkLKYav+kQJPyUiRqkUZTA8JqiftD2zGkvvMY9KEv9+Ih5K8WVg3E/+cUApGnhW89IgaNVZ0Oz5sxQfFkRuQmQhRz9JpdwdDQCwrtCT7SDSA7i1KIcq3DHgDhLt5iuNHm7APksAxM/iKPk5y7jAsx7GoC+N6wdSGCf0z+RJ3RnKuhatIC1zN4f1/4/4/ELocjIbo52pjYq8sZMK+PnLeh1h07L+DOFJoMCcwxGDVJUEC9+w+JuPZFPFFbW3/WOPVDiWDdgxWoum4qFBl1t3F0CSIJquCXjzBGP0+APMrFB1QETu/yItC+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCevIvUZT+/6BJ4/BeRgEYAsSQqrEJe/KRnFh8ybNZ8=;
 b=eZuoH8xSMl9sULqGJj4kd6Pccdg1r+sVef1fKkfgFIMx3SfxsMSwrsAy9VMg3ZVzFwnm0jIW85HPVjPoJezFRFVzPJD7YCFwrxK91dWB2oyhjk9MC2NMTuLV4scn2GP7VmLtZ9arLw24u3aIUB8Bx8gw9ykQMlNS5UzUYbMOZOg=
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 12:15:01 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::11) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 12:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 12:15:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 06:14:59 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 06:14:58 -0600
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 0/5] net: make RSS+RXNFC semantics more explicit
Date: Wed, 13 Nov 2024 12:13:08 +0000
Message-ID: <cover.1731499021.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: a740b823-7aac-4c65-df6c-08dd03dccc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FOgxady7Qb7iMtOOXQCLjmm9801CaMFp3y4Wrf5Dsm6tzp8ciH9UQFlKBlRQ?=
 =?us-ascii?Q?aL/b5EVeoaF0Aokff8NOF35PaaUtfwUyA4NN8GJMrk5qWeY64amTxDIuNvma?=
 =?us-ascii?Q?nl98BDmNQdl7GZ2OVx0VhB587PgN+V0ACa8iJ5UuHpKpl73ZZeX/mIka9jlL?=
 =?us-ascii?Q?jEVto6VlTWg2U1+n3FRL7VVf2acJS2thCGt4jXxDr7ip6aFiybp0NDxmCTZH?=
 =?us-ascii?Q?xprreh4NKJs9WVSBtKlTTd+0fJeXITAslpCD8uCMgDWSew3SwA0fM6kyGO7d?=
 =?us-ascii?Q?QjngIE5u07uJRn+1fuZ8m3tN6lUvmuEKI31GkAJYac6Xvpf00Gokl1yqee+n?=
 =?us-ascii?Q?LxoRc3MgUWEFqie+znoZsBhc/cFKFxtn/8rjYj8cyhwDbyGJws1ABjD4VAZq?=
 =?us-ascii?Q?/h9mfzjHoNfGLJIeyprioqfABbA25hXOb5evRcHxBDAHwmxO1T4a05VgBe3p?=
 =?us-ascii?Q?1jGS8f79VKDCtvKTg2jpXJw+zj/Zfm+w3K+hDi6wgFaaamf/CSsST4O/zOIX?=
 =?us-ascii?Q?WmHVqs38OvaO9FTRofChdaw89R+NDS0xMVXJV77NjWOPfSl1gRFwQgxVv2kj?=
 =?us-ascii?Q?fIQF2xMBknvFwg/IJrSIXAuQcwALGJazKVBx4U28Om1WqWNrSOm5vNewgA1i?=
 =?us-ascii?Q?6BQ+/xa7ELn2licioYItb+vD+GBJx5D2gmRAiY3SSQKimvbjBK8fmdSrbZL8?=
 =?us-ascii?Q?Z+kyXH3HdcN/moH0fD8fL0oRm8JJitmHue7fcN5AXYoMQ/YODqox401G8/qP?=
 =?us-ascii?Q?oaXNjp9VzUsIzsxgNjt2vLiOq2wv4yrl4lZtllvM0IsVQBFMaO7qscsW6SHg?=
 =?us-ascii?Q?WRlyhhmk2dt289hThU49DSx6omp+ReoYyTHEmVQmlWCTi3T3fBV3ezwtP2yW?=
 =?us-ascii?Q?rR8TI8DLllcjl01MGdo7vX/aO5DqQ7wZociewANZ0H9LxGs+AWJsabspb27n?=
 =?us-ascii?Q?vAQGfQcyVWkXT5qFZGv0asjkE/7m5NOd3ryrc5RwL65zVsdgoMj0uEC9Ka0C?=
 =?us-ascii?Q?jPJKIxPtHPuYQudrDsjErlFQ5jC1TDjo/E9eF9mjhRpVX4PQlCmEPdXh2wRZ?=
 =?us-ascii?Q?AFLJFpfaITm3Qh+FbkDIzqeMu/Et9VfT4TDjpVIs9lrVKEAwDHM5J7/rAblZ?=
 =?us-ascii?Q?n7RQ06Mimwy5jmhvwV8+SZOqis3XSG10m/tXIsrLt4vhJp7Ur27W60SLubJ3?=
 =?us-ascii?Q?QP8FXHkRT27FLDC/k19vJUO80Iy15HSI8g0Q/2f8PkrcYM+k+wv6tqguysAZ?=
 =?us-ascii?Q?d84MUPLet1JJcOZnTLiLu5nzpmLFMsW3xdBY+dFUP4LVsWsBGZD+dn/D5rom?=
 =?us-ascii?Q?bVcZjg5nCsgf+33j4JgMnf0JEraDeA0pq/0nTnva5JnJCi2EFzvnUny1fuuJ?=
 =?us-ascii?Q?P1u6+Ajsprgsim+Lz683s18Noop9H62mR9ZmzwGxwsG+cvrm0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 12:15:01.0436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a740b823-7aac-4c65-df6c-08dd03dccc5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

From: Edward Cree <ecree.xilinx@gmail.com>

The original semantics of ntuple filters with FLOW_RSS were not
 fully understood by all drivers, some ignoring the ring_cookie from
 the flow rule.  Require this support to be explicitly declared by
 the driver for filters relying on it to be inserted, and add self-
 test coverage for this functionality.
Also teach ethtool_check_max_channel() about this.

Edward Cree (5):
  net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver
    opts in
  net: ethtool: account for RSS+RXNFC add semantics when checking
    channel count
  selftest: include dst-ip in ethtool ntuple rules
  selftest: validate RSS+ntuple filters with nonzero ring_cookie
  selftest: extend test_rss_context_queue_reconfigure for action
    addition

 drivers/net/ethernet/sfc/ef100_ethtool.c      |  1 +
 drivers/net/ethernet/sfc/ethtool.c            |  1 +
 include/linux/ethtool.h                       |  4 +
 net/ethtool/common.c                          | 42 +++++++---
 net/ethtool/ioctl.c                           |  5 ++
 .../selftests/drivers/net/hw/rss_ctx.py       | 79 +++++++++++++++++--
 6 files changed, 113 insertions(+), 19 deletions(-)


