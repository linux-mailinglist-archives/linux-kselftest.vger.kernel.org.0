Return-Path: <linux-kselftest+bounces-7170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8689852F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C431F24F48
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80ED7EEFE;
	Thu,  4 Apr 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gkrj6hR9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AE1C6B8;
	Thu,  4 Apr 2024 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227171; cv=fail; b=cmnj4i+vC9+PZEAAo3ZUg0Yg+/JyDhqWyBtdJD28AYfL7ksaeXpEriStaB/p4JN+Qu06ebb6BZO0bEzvZAJjX8vL2ED7fCNxB8FFTHEflLLl9hIFK3kQEAscO8NKQkTb51PwZTmPJVWeD1yiaGos/eyt2a3tleaLow9eHWO0U7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227171; c=relaxed/simple;
	bh=Qs4WSsP7H3VX/2QxMsF2XRYK7Y51bRHusgUQ/Rlop30=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cz7rX9N1r5Sfg25yxbxPV9lS+rvVKfkWztKTHWuW6/z+fDgsK+LlbXA0fdbgk1ujMBGOkL8Bdr9grRSJAYkAYBlA7Ijy2Hs+Bn8lmjxQ5nw9EEOiBDtOFaPwzXsmRacDFpLETJhm5bvlj8HkUa0Dnal3WfmXg++0WpZfdpQvOdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gkrj6hR9; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts4qb5k6KxAYV7v+hNk8cnA7BZ3RBaoxwCR9SEqmvCSEcd1E4Kd4xLVSouHd0aPvH9t/O4iz1V17Fn+o9lVyKe5X/OoOlmv7J79O0Fy/BaaG6+wb0e3S4j25eHq6Mo1I4x6QNXGOh+wBciGSaaojpoWO+gO/14mXfBGKwsDbnzgR7UxglEHe6ZvJujB78IW9Mq1rqJlTUViju3fH6iieSVmh4PUFvunljrclArlGoJwWGA8u4GJzTeYSIeAfavWtR1M59n2TJ9ujtLsUuUniQNXKO4VljJealRasgi6ns2Inkx2JJKXIU7+428WVgxjnb1bdvFD96Bj4SO8nsSOteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs4WSsP7H3VX/2QxMsF2XRYK7Y51bRHusgUQ/Rlop30=;
 b=IWnSj23AFhoBnTgcmH0TIfrMQOlzV53+xHkyGP+ZnJ2VhfM2PoCAK1QZn/9CBX9GO8+V1he2FiWmE6cY74/dWmrbcqHuEHmCkShDSOjScM8AvGJjOldJaak4Znt6/YFgEYAFLbyfedVWMaxcJcVqHws+ERtSIQOGy2trQcfX8ZqMR+qkJE4QV11kLG4rWjMqvMESVILi5QO092Ui7k3bEFQ+UYXN8b94l8CIKHG0xuvz/bwl9Qc9908Dzkmzrkej6ZJjKh0ka44Sxz0DwPRWXb0vs6gA1xd0RZG+RsivLv02y8+UgarKgsC8VvrhoxQq/ZhHbYHM0MOR/DV6riBtpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs4WSsP7H3VX/2QxMsF2XRYK7Y51bRHusgUQ/Rlop30=;
 b=Gkrj6hR9SkW3Ae9tyNz8Dmtm+qFlVOxi4EIvcNNoxJXV25XJvZVmtSy5GfsC7YxD2s9WqmIorhNTNSL7Pu0Y8q/7KGs/8WnCWUnblT3VDsAkiCCf/TsOJNFpLPbEgJEbd8C/rP3Hq4MgrC8RNrt3i36tFaINefolZnBCfRKjYRPokCS9xpAJfRnwAXfejdTBzn1fUWs4pzawVr4cWQiFZ5qgWXuRRyQax5pPo17QTBFzSMpCx3kPaWYMu0eCehzKnOroIDRkHRo3pNQYKcOVURRWH5VQqJ2uL6fXa3MJt+py/8SBWO1GiDZF7pGMoqwheFlTG1kmdRPl1hJjTYihXg==
Received: from MN2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:c0::29)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:39:26 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::d4) by MN2PR05CA0016.outlook.office365.com
 (2603:10b6:208:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 10:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:39:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 03:39:19 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 03:39:14 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-3-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>, <jiri@resnulli.us>
Subject: Re: [PATCH net-next v2 2/7] tools: ynl: copy netlink error to NlError
Date: Thu, 4 Apr 2024 12:39:06 +0200
In-Reply-To: <20240403023426.1762996-3-kuba@kernel.org>
Message-ID: <87h6ghh0og.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c5bb5b-271c-43c6-da52-08dc54937fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6e0yKvpvhgw4fSdHZ4EkrkOssacrdTXwhx3DlAB7S180xdXihvCGB1OUjsF4ePFO6XcqUvbBJwQn8ekh5/e1uziaMQsnkcpRJNPmxWeaiiTSx4RFWAXedvIGzZg17okxio1NwAVgcuCxd4jOF68JCDaWPHk6g5g6EOjrmG7yL80eTkfwL3BODxI+Mk/x/rolN2BQvWQljyNXKMMD4UCT7wYEkjgxrKe9/DiEfAQhAWOBOGlLp9KK0hJ2t4eS7RhbDgCxot3amqCPPO59tECQnZY/n57lAxH20UHdbwTxAv1c0N9BB5iK8hT3QVGKAx4jv9jKtSr04qjZsf8ubykdq6LKG19uiX5nUFxBVe9ZjtpE5BvW1h2Qyih2lILb3t7jUvr89cQua81gIY068cQPe5tlwSYWebJ+FpQBLKBpw5zT+sWjXeNa+esNaORFNn2Yb5/hSxVisobyLZAEOodp7+GeQ7tOjKQ2SAp+CMiuZvIGNcGfoQJJ6MXTxCLwdk94O/hAUlvIyTcmWunLUtS7KNDw0HhNM7cfVldwG3a5zSP2bO4zquQuHDJqHPvYxbQkR2+DqmvJNSTCMODzO/Znvc+K1USC2t3hQhgb8BoQCiog4LDt6JTabBaWLXFOa+KcYqAnOzmC0/Bg1xa7qd35BhNUel54iQWvDemBEMgrrmtBrC0NowlnI9nxi9VHCef5Z3iZSs4AbCN7xKzX9bwT7dQe4QPrUeq9O9nniQHERQ2mAJ4pTimRsWhJgKhyIhzm
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:39:25.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c5bb5b-271c-43c6-da52-08dc54937fb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664


Jakub Kicinski <kuba@kernel.org> writes:

> Typing e.nl_msg.error when processing exception is a bit tedious
> and counter-intuitive. Set a local .error member to the positive
> value of the netlink level error.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

