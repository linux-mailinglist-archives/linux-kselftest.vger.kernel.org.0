Return-Path: <linux-kselftest+bounces-7829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ECA8A3441
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0372B21BA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938A14B08C;
	Fri, 12 Apr 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tva0J7jM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED38149E0C;
	Fri, 12 Apr 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941335; cv=fail; b=DQR+S+Q8yS1xQILa1jtwpaEndXcFt97gJTtDQhGmKjI+I/wjKekWrII8x7XHXn6Hsl4kXCQ8XOtnDaMg2AhhTdn9HU26hRYrODs0o6cghFoM7vDADWpQqFchUW6uOyk5QQvm+QhuxYKL8hGqAmJYGcSQqpH7X/iJRS6zfc7Cf+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941335; c=relaxed/simple;
	bh=X63MV7kKQIUV/q6IF1ILoi4gB2my/EO8XIaoWfQoOzM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pa59zI65Hf16yycm/yS/I2aaHpVG3owI/fJidYe4lXAEWg2xwx70UwjFhGryHX9DH9Q0NiRm0rKPRMOlU5HMdW0UQKAQbVDl21GFyUbQkd/mGatk6GktVQVPRwzMG6ERl8VdglmKhEsssnNykAiLXB6m2s8PnM+MLUetogenTbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tva0J7jM; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM5dv6Ibd7VjzmEItbocDbSk3QVX8HCKNcqrACZaJMNUe/6OeqktY5qace6FVsiCWgNbqsiZDAUNqckwJJM8zO+Vwiy0ZDxWJmblzTSaY4C4ulEAFwCliuBmvObejStF2xoeIwGvhgcEsWusNphUWQVyquqofEC9YcDXnbNyIA0iZSRASO3eB7fVpzFh9u6o9XEF8Z259MNkQydjBelm4+5oSHk9GP1bgBvVa6Oo9HYwIkjv24PtQCcioX4JDSY5tf/MDgbr2U3Whthp5fRtv/Sbj0k1c4wIIyycT/4LohvxcmDZCdc1v61JR48cge6icCxXX/7hkxz+1b9A5bMovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqHs0Y9Im8tlN38O6Xz2Vd1wHyvypaBEzFnJZiB8Q6Q=;
 b=HY+tNVBzPE3kHxfWAzYy3dC/GfatxmQVIMwF13H9X/Jr85B0udKRVlPLsLKGFM+R8hujXWBQlhIQpLAAmbKRSEZkc8AN8obbKrfZ3LfGyCpITDeWjR9oDFfgmzUm1ti0buRkcxYG3K/sd+AGW3njSLKVSGc3roV5FmdkDhySGfm57kcoW/xGKUcfJdsoA7DiXaNkI3+Iw5YjJe9lreSVZtK1/WLcmsiaYoDpbkRjrZZv5Ynkk0L0Zm9kzaipe0iPuQEZ9dGBG51XRbL/VU2hyWSNWSNKd7euG37OhqcK/Hc+ce4G96iJ2duHawIFEHB9WbFt4pviT2Z0+M+Yfgf3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqHs0Y9Im8tlN38O6Xz2Vd1wHyvypaBEzFnJZiB8Q6Q=;
 b=tva0J7jMjtx544wIUur/0nHrRypVYZkq8WA3/gPPv+bOQwerAOWBMMQ2iSL9k89XtaJ3i2fJfHvbVj4PgLztaX5ke1szIaGEVePapR9+WlxJZ2nPUC+Y+KFDExnn04Bc6vMjaWr1pKMHx4RSWDUtmbb+2OiItmTLgXfGP+YUBKPjpeMy2V3XRsj7w7DG2ZuLX30NCEP+oS0WGXDPRoY/MnJdMiHbmC8ukNPvUYDeZeqhLgF/jLUCsI/E2eIgUylv7wzE9q8xZG5oBaIYBJmwffUi0VmP1ZaCjIW9JowAXsa0AfF1tlsRwFL9KE6de6y7NhnPDsB3YHFyKK2uNOfGgw==
Received: from PR1P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::18)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:02:11 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10a6:102:2cd:cafe::af) by PR1P264CA0124.outlook.office365.com
 (2603:10a6:102:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Fri, 12 Apr 2024 17:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:02:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:01:21 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:01:17 -0700
References: <20240412141436.828666-1-kuba@kernel.org>
 <20240412141436.828666-7-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/6] selftests: net: exercise page pool
 reporting via netlink
Date: Fri, 12 Apr 2024 19:00:38 +0200
In-Reply-To: <20240412141436.828666-7-kuba@kernel.org>
Message-ID: <87zftyecrp.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: f37913fb-5cb1-4408-7011-08dc5b124aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qdxv6wY2dDUlh55VQQ3JKRXwpu23Q+u6aw4XHMqm7Jk5xRyBiQXqlAr84klyYNNvHu6cBmllxkzo9DnWU2Q2jLtqW6FZS24cNdR+sY5yeixJg+wZ0V3m1NMsa7CUujwhKghyIe67h9ElnQakWXi+Rg+cFIKwLreRWH/9OQlXrihDKK8+SrC9NuG0wHy0yqlOE1Y9x774dDfZPzGleeEC0qa11NR1L2QwU0wONAJ3R5T900WcKjXhxoiZo8y7IHTzG1oLDkInZqqEmVOrewWWzTrDTvwCeNZxgQ6XjClmSlnHwvEuo+I8t+5weYwyfSI1K3oiTD/OVIAWY44C1CSqBnyEYc/4Dt8vxo6pZq0/GBcf1WOtalVWOjsvLTMwDKN2tWkBwh+zfPsDxI7mjjNGS8UWBOkHpVWFKdvcGwP7C6dgHLzM1VZ0vCTB9+dC07zeO5hTI7qkLkkTe+6pGJPtn/KMoqUEKBPDk7lb1mgH2aspQaw/grTufnJ896rVrM1w86HTLQ5r4wa2RbfsWID8djYQu2eWeeUF22b2wEDKgx9UGTQ7itcsKOl7bESHoN+QHiQ7iQgkhzZMdn3x0Bs6cITCGnGGUbOZaKbk1umvptk7+s5urGUSgGWS0IsAOFUlUEuNeE8+AvG/qwDehTb3a5Z9IpO2nXvMbuu6FLqMJJC9eP9Ub7AeRJxfely/2zccm/BJnWm04lRO16oM1nRHLrOHL+DVOomi7jkb2zsFVCRBUOEqdpYpWdAdqBFuMtq4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:02:09.7293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37913fb-5cb1-4408-7011-08dc5b124aa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630


Jakub Kicinski <kuba@kernel.org> writes:

> Add a Python test for the basic ops.
>
>   # ./net/nl_netdev.py
>   KTAP version 1
>   1..3
>   ok 1 nl_netdev.empty_check
>   ok 2 nl_netdev.lo_check
>   ok 3 nl_netdev.page_pool_check
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LGTM

Reviewed-by: Petr Machata <petrm@nvidia.com>

