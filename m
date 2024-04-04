Return-Path: <linux-kselftest+bounces-7173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09476898536
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12BF288BAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC47F7C8;
	Thu,  4 Apr 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqzA9m7i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379B78B63;
	Thu,  4 Apr 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227218; cv=fail; b=X9voPSZkRU5hFMfIHlG768YS73FJY8anK16+8KqgZeB20VJfW8t0n+j3Xk72M9rMVNkoXCmu+l86SBd46hz7U1k6G42E3b3QSky1gZcCnxNO9AcJeVp8dLwVFAhX9ewA8f8dJ/Lc8vVkkPjBrEgGR5uvG5CGLgN8wEOKQqioLiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227218; c=relaxed/simple;
	bh=2XC1jtA8aSgdnyYrXPqcMkGUcC3HFLbF+38Sw/XBOsE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=chzh+XMseOi3UJDwrxvA8LjbzKfexYc755H6i9iWGaTdEnf9uvfdpZ/YsArRksLpl6tf2AIdnSIm0MHo3XuOSV9OimxFew8YczAZJAr65pBDaeKXjLhjHpkhnTqEMak8FoDbwgG4v73SkUjERnhgOSa1sK9GIOz04KXodI/5No4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqzA9m7i; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxbxBm8qMlbyv3f9Mjm06mtSM6fEPsW7iuKKPjQKylZ92hIA8AVAioEw+O3WU6Mg+2iXgXSZfP8+r6ondTXoe8m83OyMjyhS4WQHKiM2zTAuGWfwJreGHXTLM92v5R75hlP3Jd/o5LxhziPLR5jLoYqzWKXmhrQEZwvGxNvjQEn1nJ9vRLj2SpWI1vaFM63PnqOgOWyNsaE2Xt5my8sSrO7UwOpWEmUwdLkW536CiMqnnfvlJVmcu0M4EQEBhlm64H3GKA85UpjuUoNrJ0+INVJ3JgnOXmpgobWMhnNakeiFLSD/D3cx0HoO7QzpYgI3cMYuEqGIWcxeXJsGyjW2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BTUg/UnphtYJku9daX+Sbq5GjPUsFebGdZr9Q1+QaU=;
 b=jfecRrzN1K3SFoFRUops6k/pwFdH4zZM05a7alBhrv7SDAcMeLH6LMW2atQuywvW/ypJ/lNyjKZjW+Oz0AKULYd/4Y30SI+PMkdCX2lo7ZbfbqVPpvJRV6L6bOK528/uHMnSdyzGBwJDpmVFcNBx3RT6bwb5ld4nS+iOWQGilGB/p4J0ZBP/WDzcCToKFxHrvkaG1PrExs1+rofllT+1h64EWn6r5uyrP8SSwt/YxoHeZOsRz5pwPpqruFkWLeJMg/PcpEryKrYh+pClxtATvUdiJsI6lfyGNCJZCg9ezH2RqIiHnW18g1R8DD3NMU3mkiT9wBcsU67eDlLRyZI0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BTUg/UnphtYJku9daX+Sbq5GjPUsFebGdZr9Q1+QaU=;
 b=ZqzA9m7iCVF1PzM0S4Yyg8ZkZRP+1YDivS+4ddy8Q0/Pi6RXOYiIjEQRDld/FjkBSOsizvUGE52X6YRkEFjuDQpzs1zjGacHEIKQ91JqnLuIPyxYv6DoyXlJu4te3fo7+Xwd/MIQZ7hFJBGObSF5/dRG1UadibYF3IjRz5E99a3ypuMUkLSIjN6VZSTXea1xET/QOx7IFn4DJhQfMsCiSpRP7mhMeZ3CC30iwtRUz37Go1mTuKXiBzbJRlMjswdWNQLL886p/nWOEfll+gxwIqP4d4K/RFgvxx2bNNdlq5Z2yfgfmsItJ+GPz+FrSTTbSj+ffwKIKwbOFk1RhF1D1g==
Received: from SJ0PR13CA0067.namprd13.prod.outlook.com (2603:10b6:a03:2c4::12)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:40:13 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a) by SJ0PR13CA0067.outlook.office365.com
 (2603:10b6:a03:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 10:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:40:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 03:40:00 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 03:39:55 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-5-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 4/7] selftests: nl_netdev: add a trivial
 Netlink netdev test
Date: Thu, 4 Apr 2024 12:39:34 +0200
In-Reply-To: <20240403023426.1762996-5-kuba@kernel.org>
Message-ID: <878r1th0nc.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e4b5a5-04c3-499b-18c4-08dc54939b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8gctYXPyfMOcIsKGCtTYRAWtGzGgxuEmb9DqeETyZc2GFLT4HZXj2BIWYc96nKwb4oXpeMoJBY/OsFB5SBjWufj1MSm3Jq8K4yau6nA5DmwyUed4ezXyZQzhQdU2Bx3ZqGN5CvIhPjdGJmiyDR4Cvz3hgjXponOyBbC3gQRpF13oyUEldL7zN7ID757eo6r11kXxdXTKBh/gMkLd0ajOn0zvCMs5DLTZlr9U+EOc0IsyPnanbk0LOQQV+GjMnFe+Hv9LV7BA09ZVlKEOkP9Mq16RoXJaUVD6Hpru5Ml9JXFLPxhyENR8s1PvK6r27zHvkNax0H4QVwg9OEeeYuQBuaSgaXtrPSVgVMznxLLi9RLaYyyMxmNWsEMMbMQzoFhND3TWSimf8MmmMYei/CbeiRl+pmgyloNakf6CiIj0IBfn3+7xFaEMG4aMizoXbKTnsg+hu63RdaC25O1wNSbG3r5tjOYbYFCiSgXAWcCSxQCHIgnf4JpIywJ60Lb6/HV9+XrG5DTfLSRf2x1HkpUgg/RvSTDaooosB046OPXSqu4tYY8Q3y0L781lzIHu2bOt2nzIzzkp5NGSWx+JS2nmHCDCwxbPsK5SUZvE9s41e8FN8Srvf3hVBnBhL3RwWq96ND7S0aS4XZc88j+T8KAwngsYKfBavE0ABx2fU7u2Ls7SlO0KMVTbrSVL/36CAXW6QTnE3aqR3ly4Ev6vKdJWF5K3Bc2GpCi+NRghfx/Z74JORoeFb0srvoe+oxIkKlXK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:40:12.3374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e4b5a5-04c3-499b-18c4-08dc54939b6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965


Jakub Kicinski <kuba@kernel.org> writes:

> Add a trivial test using YNL.
>
>   $ ./tools/testing/selftests/net/nl_netdev.py
>   KTAP version 1
>   1..2
>   ok 1 nl_netdev.empty_check
>   ok 2 nl_netdev.lo_check
>
> Instantiate the family once, it takes longer than the test itself.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

