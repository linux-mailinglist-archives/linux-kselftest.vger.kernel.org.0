Return-Path: <linux-kselftest+bounces-21385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582E19BB707
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B17B1C22090
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1441304B0;
	Mon,  4 Nov 2024 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDMlNsvR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B879FD;
	Mon,  4 Nov 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729027; cv=fail; b=M+5svo0tuD6JeXEjwWEf1Rm9kZdgBOVzno7KiL9dxf5VEMP1IrLJoaeGiSrd5KIFY/0B1gWNyfWO+g5kwo+H1jmrVYrcpcJRtOeraZ2wf5cm/D28ZfCeEiAqMQXsnHGl0qnNvT59XzT2KjTchO89KfHDtHzhIbCERzg/Nep8F0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729027; c=relaxed/simple;
	bh=fjov0DoALudy4DauWEZZ1O56U6akARpNIXdHAf4ohw4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HXdMbhGgra2BwWUpvvFdoiEpuQhQnEavtWTVFVm+0R3RIjYO7D3Z1BxOoyJ5yiQpQ2UY40rICneT0KdLwgf+jgBbIpeL8wYDx29TMDj6JlNf04Q80xBTYXzAMXdE4PIQoAS+MoXhpdhBhxdBxHJLkg2EigrMjbG3U7KN98sc+rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDMlNsvR; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC39uGXkwq9A+lHUNm6ZvDJ6F9FefmTxT6T8WKsKEDKB2KXpFzLsVp3JzHSgyesqiz5q4hypEs1YX37EddoRB/zxNX4zMI1GkUgLGzjwq2f62VZzYaO8pbWLUFHsidEN/OVml2hGBobavFhU+eV7o4jyNceGQubgMSYD9904of5V0Lg9sc3Tbf5JZbz8z5kqXS6O+rTzIAqYQGgT+fJVuGDFdU9qHWFBOfho4jeIHzMY6JtU01D95vDXnosKm+/bZKw31U9UgT4kgf7kDJ/bjP20DyfHn1PGf1pYNvbgGWob8bg0Kkbky8KTwkP6DVxXFdWjgG7mwZGsgbpzfq3bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbkTKEe+Nh0mH4f0gUv+mMPPA89EyQE//ySB7a7XUME=;
 b=dhCxwS8EZHNNZSnIH2Vlx6xpdgtWH+++qi/T12rFDs+UVvD22+YmzT2XeYvCQHFwTe9Z0MQlJu5E78jzz3gXKASpbL9Fp7yDFhe+JkIOq+0Qs6KkWOYSA1ZmZs6vxl7So7PFMatMYDlNa+u8TN3fdw/Wy+2rwbcRG/R9a5mqPNYeFqs30uNgj4yTkJynVOhOIvr0KPCTcnMnbG5d86vbEYSDB0frIqipMObmKoLcoOLa0Un+547HNHL2jhrWb6RGPTH/SA4jq4UUjfD0VL5vzVp1IL06HpMgrfTz/kXe1sY73IGp0aNBTuONOOJfGHZgC/oLmamOZDIiXeWq4alO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=netfilter.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbkTKEe+Nh0mH4f0gUv+mMPPA89EyQE//ySB7a7XUME=;
 b=fDMlNsvRUIKDhccohM8bj5A6dLtqQnQ5Gsw4Wd//unR0oBN5naiRWws4ILcVEaXUPH8Kz5/53cuKyia7mQtBZy0elQOYiqdOMu4HiFxjAb66yVWOZXF1O7wP1JADKNM4/hl3sBWBU9Di0aQYqX5AwUULLvAhIb4uSt/+nxxf5bIG5APEJoYXVUV4hbtEg9QblIgxASXVLhOCEAPYYVQkMGS8zQUVJDFXwvRwK0mYCMt+dFbr9G4zW27auxopS9uwaGYmIt6nt2TaW98I3ecnGdTa5HfEGHBnETHNN0U4DNJA0s20pG+MunecXmuJryvVHIWC5nC+VxJilT5DdEfGgw==
Received: from DS7PR03CA0141.namprd03.prod.outlook.com (2603:10b6:5:3b4::26)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 14:03:23 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::79) by DS7PR03CA0141.outlook.office365.com
 (2603:10b6:5:3b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 14:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 14:03:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 06:02:56 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Nov 2024
 06:02:48 -0800
References: <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
CC: <mptcp@lists.linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
	<geliang@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, "Jozsef
 Kadlecsik" <kadlec@netfilter.org>, Petr Machata <petrm@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>
Subject: Re: [PATCH net-next] selftests: net: include lib/sh/*.sh with lib.sh
Date: Mon, 4 Nov 2024 15:00:03 +0100
In-Reply-To: <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
Message-ID: <87h68nksfw.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 496264ff-7e62-40d5-134c-08dcfcd97224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AA77q/L8siZ9oFK/LRaTvO+Q3bAIovgF/KnjiXYSBLLDg9YWS63Mb8vt6CvG?=
 =?us-ascii?Q?eBmw8PXKqhy5Drg4LioWq1uEFQyfgnnmeIVAI5LeAEVDxvDbh7+uJQto5O8A?=
 =?us-ascii?Q?WvBgxUyBRX0IyZ18p23YKyR/hXdKSrLTKLKCUhN22LJVQDgu0EcwqA/6U+sO?=
 =?us-ascii?Q?kJQ9ePW3khCdyN5oRZd3zGfxjxLUJFRzg9nzuJD9ewVa88YtAiDdExIVlSjy?=
 =?us-ascii?Q?3tnazLpIRH5ZqlMfZIceTbRKOvalwkJaT/TRtg76odChxNuricV6JVZW/V+X?=
 =?us-ascii?Q?nW3h+tLLgyaO6O+mPARMwBLk3xmXcujGOrvVHS7v8SLmBUiC/k85j1s9iU12?=
 =?us-ascii?Q?9LRvut0Y8HKFt7S8LmK0G246Wa/uHbdNKh+qKGQE5flsvXKbZLHVGBqBPtzO?=
 =?us-ascii?Q?330dYD7TpJiDt8HBpQJtthKvktjOP+Bf5RbzSCVudHxozVh7Lk0mqRDCdjni?=
 =?us-ascii?Q?KssJy8sDfMtFGw1BHxKEpn7bKNsDxOKxF2o38BF1pnmMVYR/NN5cVqlBZth0?=
 =?us-ascii?Q?3VtRZd8gG+CrtoGtPZjdXd5pKZfJxpfJK2iuFtHstyxZKNtjRERLFWlSMm3b?=
 =?us-ascii?Q?VjJ6VJpcI5dOcXWBqNwBEssHbckgxeqYnsNLsrhmtK8QvFlZ53RXKwb7ofr3?=
 =?us-ascii?Q?/xJnBEbjKQP2WNaejkZk0uiQw1LQxXxYTa3KPBsg6v2rDvhhUnKckkxo3uN3?=
 =?us-ascii?Q?q/T4Z33udkFJEWWco/ACeADn90qH2jXITkz8H79MR5aY+pcMTS/fsEmU+l3l?=
 =?us-ascii?Q?PYPUSnNw547x8823W6Ysikm8zNmKs5kKQTcaNCah+CA2pcZhpW33R1MmsGYs?=
 =?us-ascii?Q?Wf/Y6dYHxlzXxNEmGnr5lpAYWOP1pyd+/HM8DoEGlDOF3C3TlFwV4m3qGgJg?=
 =?us-ascii?Q?3pppOZIEraWexjxH6MZbMctz7DBjNSd+geCV+6kHwo9RjqLnQiFk+ZTLY3wh?=
 =?us-ascii?Q?5Xs6TqS0vV9aff4e0mJTmkUxRuCwBQvrY16Xx4iLkMIZa4jUNKN27FqrKeg0?=
 =?us-ascii?Q?vh3eWmP+vMsSnsx59xss7mwl+GnBDPHTQ0sTl6p7BGrYCiFWNIDAgJk2MjJx?=
 =?us-ascii?Q?CQ7waO1H3pDXr9XR1AvWXfGwrChXnptOhHDqF54/TG9Y2cqeALfhj0Z12vlO?=
 =?us-ascii?Q?N17HOnIedUEobFLydak4xPmxzGHa3h1jcAUQb5L+oGNPlZ5UpIaBYkLwgVCC?=
 =?us-ascii?Q?ezQouNHhb9prm1RpgasRgy1DrZObteyjAerFGF+XSGRBQ6F3dsbk2QYKtUIn?=
 =?us-ascii?Q?e3M7Fq13HynqyIKyzrdQhWPhpou83MgVz5QVYM8Sm9P4lhdskE83IdQUlBq2?=
 =?us-ascii?Q?60Nonm7546UCCNR2audpZxPiPV+TABDlm1hmT6C48QdtUquvjs8lxolB6daz?=
 =?us-ascii?Q?GbouH2oAKxCbGZJt5n2z8h9uiEkjenfx6cM48TNB3oxWwKIUlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:03:23.1274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496264ff-7e62-40d5-134c-08dcfcd97224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354


"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> Recently, the net/lib.sh file has been modified to include defer.sh from
> net/lib/sh/ directory. The Makefile from net/lib has been modified
> accordingly, but not the ones from the sub-targets using net/lib.sh.
>
> Because of that, the new file is not installed as expected when
> installing the Forwarding, MPTCP, and Netfilter targets, e.g.
>
>   # make -C tools/testing/selftests TARGETS=net/mptcp install \
>         INSTALL_PATH=/tmp/kself
>   # cd /tmp/kself/
>   # ./run_kselftest.sh -c net/mptcp
>     TAP version 13
>     1..7
>     # timeout set to 1800
>     # selftests: net/mptcp: mptcp_connect.sh
>     # ./../lib.sh: line 5: /tmp/kself/net/lib/sh/defer.sh: No such file
>       or directory
>     # (...)
>
> This can be fixed simply by adding all the .sh files from net/lib/sh
> directory to the TEST_INCLUDES variable in the different Makefile's.
>
> Fixes: a6e263f125cd ("selftests: net: lib: Introduce deferred commands")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Gah, I knew moving this to a separate module would end up biting us.
Well, hopefully the wildcard takes care of this once and for all.
Thanks for the fix!

Reviewed-by: Petr Machata <petrm@nvidia.com>

