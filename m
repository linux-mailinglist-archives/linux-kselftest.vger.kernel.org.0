Return-Path: <linux-kselftest+bounces-7779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104B8A28EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169932823B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F34DA1B;
	Fri, 12 Apr 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENw8HPZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119264BAA6;
	Fri, 12 Apr 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909388; cv=fail; b=cdc2W3t+LT9bYgPusffxuQ8UhQvWqmgHvPzQijQv4RCtQlpl5iYqeIGGJ3G1+vunR8WsqQJJREXn0FRzCVxEd4mblIEdvoAA9d1GHI0d66bz7H372OhR6JAW7Msx66eV3/p6/BlhRpY3R9yWrYoRmn736gZ/NyjbeKkIyUY9Awc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909388; c=relaxed/simple;
	bh=B1Qg1YSl+kiM/gkCdaaM0YQ0mQ6DsI81pp7FMgzqtPU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LLHw7UIdyIbCdt5UDGKezt0IA+KEYhpJOQ3+8Yca8kcmzDRcJh5ljBZyVMTg0SgcLfCTCeRUC5AQEJAcQgXRGPSuYh/Szr2kE2AAvE6kdq0IFbOc19I/LEWoK26frZxx7IbavFXJH10k0GqCOk590m/DIXOGutIbmoSiBSNOulg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENw8HPZh; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYbP+QD+OzDkNEcGquSr1LrHAAm6Zn6LOZIamiCtYtksLlMBAARnHV6WJF8Nmq6TsFAXc9iEzhaq2Y+QCnFsXPeJUWvSt4WdPbPS3HquewMVAPQif+e8Fx5srIDhrXWSAjsm58R2lwDDM3Z/tAGvx+EI5hyoF89VePnykJjpFmwVcWpihUZjHgp+xD4CuShiluIQF/3XiiH0veyMtFowOACqdKGiDd7FrC9zNv8GYz83Zk0wmX96yXrLWvorRFYuELKj5rYSYrGBuusJ/mvIzo8M+R5k/E7RhSMT29CKTJAO+Jt8jcykicO+XzcB7FpVR3gKEk9TIEc4A+GOxR5f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Qg1YSl+kiM/gkCdaaM0YQ0mQ6DsI81pp7FMgzqtPU=;
 b=gtLzYlauTRavozXw2lF/A4YBh/MisORPopX1SyTePOJTykBLA/Y8pOHFEUth0GJDeLeBs/l4He8MQIKZGrJ2+7iMhPNDRF4OpRE0zxmK77g8oHoom2Vml0y1eAk4YXGIy9YaHNO+VtrCFESZviBwVmNipT7fKyF8Ov1N/0b+Nu0Mqu8GzBmWogmvcZDyvl5khyyT9rJou4WmVaVhExObwzb7JAGm4+bFElSsbBq4AJaJ50BSshqay1d2qq29hjXJ4WaiTI4q9Cfu2owjG0zMtZy9eYohZfPEbiBBeDCFLq//LuU50niNSvNlz7ZQTi9BCr7twrD9vdJr5LQCAqx8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Qg1YSl+kiM/gkCdaaM0YQ0mQ6DsI81pp7FMgzqtPU=;
 b=ENw8HPZh1ZWrkdGdtIw1SS4z6RY6ah8LdcfxuDfMr/RLf0E3+OtUViNXLWvGqjWBIshwBaH+UoUCIhSGDGpkV5pvF+zUNgPrua/YeO2A56KrUmFtAJA9liB4vTJFHpJRFMrJDDOb92nyQ6FegDApmEfkXVecnxXcn6Xa4bCVHpWTkMYQl7vMd9t+ETCvl3JkX+qnK/LSVhYZuMGtVGnXRehY9kMvcV2uNcBIov5WQs8YwvmIdpzQMWVYJtr6XcbYv66tdV7M30tpCh72hEhoKgiBGnRBf1U6oUlLozQvPpZ9Ubct0rIyWLa1GY8OH4644qggrEOH49ImkMmbuRoBBg==
Received: from PH7PR17CA0008.namprd17.prod.outlook.com (2603:10b6:510:324::8)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:09:40 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::1d) by PH7PR17CA0008.outlook.office365.com
 (2603:10b6:510:324::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 08:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:09:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:09:27 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:09:23 -0700
References: <20240411012815.174400-1-kuba@kernel.org>
 <20240411012815.174400-6-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/6] selftests: net: support use of
 NetdevSimDev under "with" in python
Date: Fri, 12 Apr 2024 10:07:06 +0200
In-Reply-To: <20240411012815.174400-6-kuba@kernel.org>
Message-ID: <878r1jf1e7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9a2766-9896-4e9a-2bbb-08dc5ac7e753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rb3W3BIuAQyAyj28zQvNQ7TesQ1UZVzIhaDFeyW+TXhx1i84KGngn8Ou3g4Ihld6NUGGxTIFrsew3Fgpz8Tx1ODCkRhNTq27Z6/urkBVOSYwAzX6oIzw9NaIBxJLWeVdjASz+5/UKe5jsZciTa5yOWC6B1Km2p9HEp60nsCnYC+JiRGpgG0YLzWS02e++PckBncsPEDYozAhQSDmz3FOd5tcGNV1HP7h8LhEB/MTELRjkh1fpVT7XYSsTq813VpIp6SHQUC2eht1wK3P0mixOGKCAufOvHtdW7HtMhEty+WRAVz+ARtJvXFkaky2wXgBq2OXkGt+uipiblH8gISdTChyYtMy5MQ7muOfbNI6pqTwbHAS7srDpGpVLIJ8om+XbMQAyb9MfMF9BKr43rBSyZWW+InmOeKL63U+wF7PSKb66Dq6/vlXM+MbyERuKEzm9VZ4PMHPaJVcEqX6770GDh4aRQ4BbpvH0pa/rMaw5Aj7/oxqOq8wJ5uRPcp1eYmcQ8nQ8ZwQKipcuf33hKkfg1CbIjGz8+JVaQPpJ8sEElF9cgJd5OHXYSvhYRq7Nb/ZlVQkdRuOIZPmeUf892zn8uiogPuo9/tBZhI7pxGnrhkT/Xa8SEPtTJbdHzBc5YQ9q5lAaiBf2bX9TheIhN/3YnKay+Ppfk/ctHFEn8h1N8NLau1NlOJ0vM8IvzF+rdCDY4XmXe+hP0vYOWAyv4s0Qj9z/5gAvr5QkvoP4sH6mPDzvUv660eNPHPJNHZMhb8c
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:09:40.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9a2766-9896-4e9a-2bbb-08dc5ac7e753
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348


Jakub Kicinski <kuba@kernel.org> writes:

> Using "with" on an entire driver test env is supported already,
> but it's also useful to use "with" on an individual nsim.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

