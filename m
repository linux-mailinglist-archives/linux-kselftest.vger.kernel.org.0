Return-Path: <linux-kselftest+bounces-6619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B288C1B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 13:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851B4B237DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB6762F7;
	Tue, 26 Mar 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUtc+Jyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A973522
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455115; cv=fail; b=I4xUDSZyvcqses8BiKX63CMkFK3hut42WweM71ItT0oP6iNcI39BK9IauDfgoM/R5RfMfusd42LIQGWilJ4wRiCpoPZwvhrPdvaK4HU1SwB0Om/Cxm1zDGIymz2aX3J1aCbL6qDvcQRP/Zry9U/ozqhBYUp8bNA4miIk0VM5a0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455115; c=relaxed/simple;
	bh=vQGN8B74J4RaHjK4epsd7wkmAXePKNLjJ0XI5tZgIhA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EB+nFa/ceY45RMe+wKD7tkS1fW2Wq+UzsOJADAw9nHrCcCSYy0+OyoT2Fl5EW39+vq7o0pYJtY1sCxWoCS9Ea4aWZ4DoDmo19KJ0MnUNXxjMD9UW0bx9ll/IqtscJWIxPr370/+/zPmsjBt5uI9aRzQsUfy18dKOGhVqBkKSRLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUtc+Jyd; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5t6LZ2V2L7zoAHJWfmsp12a53wCmFitntXrvC9QICwdUGVLcawWlddXrNcjnzaajOje6ty+XoXHCTXNs6BZBL8KrAICf5H/gK4hzzeBf4nLIvU3CMFVEOZ2DJayor1fY3CvoaQbpP0TvH3K4KbGWg/kTAxlcxF1A4I2ER+IXR7RLt2HCF4S/wrRqc0W9/F0eVh/99LiE+1+VMhm+a1XttnEZ3L7wbfZ0t9UCqpt8VyE2ONP8zSMsqgiA9+BAC64+Q88OORq5Wa8PpLjsMc9eFZEEwamMZqtfrKZXDR0o50CcaPJfDW7RrpKJSSjuEydi+Bu0hioHCJXHeH4S/pqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na/F52zvd+AX8AqzWNXxAklFDBwCefF36zizrbWFe0I=;
 b=V0LP3L9mcK1yR2JA7C2Gkv9FOoRmApPz6g3aHRE8cuIQfwMjhvd3h4txlHAu6lOlD3cT5Z4lARpu1Us9nxu2OOSLiL4Um/+4Dis595rghn6yr5UkzyT0jxQq2nIbz5pBBMCGhiK669U8jenyi4chn8j6wVt/Wt43Jz+pVS/Z3YM4YKRyhDuPkOvrdS328Y1Ej9OsDJyxoXJd0A1PLwilfXY/JVVOSDwEcFLO4Hxa0ZXyu7a9eXiRkA+NZQAfD+213VUD4hWHistQYki4wOppD9rpvdQLl2THQMIiQmjJwiPrO2qFYpuR1RB7U8pjDZ/IhJrlqPx8jXUzLolg0geimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na/F52zvd+AX8AqzWNXxAklFDBwCefF36zizrbWFe0I=;
 b=eUtc+JydjC/QcfiSRPnUoYcn8AFUZ4CFw/ayse1AoeKWFPTiOCzkXfbDOuhapZ8HqKd3sFucyfakOunYoQOvxcc0w86LVU5xsTQThpN4QtEBRTsLn+zd9FlTtyN6aQGolNlZ9HYK1LO1hEMG+dyOE5Q/xCgSqXljrhk+fCIqRcgwNnIfyf0FRC+vdv2bNb2SDwZcr1nxHp37FQwXkqVb942hD3fwtiuIOryYERCqdC6yda9tPrsiYxKf/imS6f+ilDPha30MTCc9yPNi1FJ6foQq3dEXsfULPnsjK4n9YSGaH9qZsA0+AtDFZqJaT+sld6jhZMW1Zv6zL9fK2P7vAw==
Received: from BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 12:11:49 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::14) by BLAPR03CA0001.outlook.office365.com
 (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 12:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 12:11:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 05:11:31 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 05:11:24 -0700
References: <cover.1711385795.git.petrm@nvidia.com>
 <fb7c72469b1d51556914b8a4ba3b7dd6e16815ec.1711385796.git.petrm@nvidia.com>
 <20240325174346.2aca1bc3@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 09/14] selftests: forwarding: Have
 RET track kselftest framework constants
Date: Tue, 26 Mar 2024 12:12:09 +0100
In-Reply-To: <20240325174346.2aca1bc3@kernel.org>
Message-ID: <87h6gtjiqe.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1864f7-905a-43c0-4252-08dc4d8dea5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nMgo+XzCbDMqvFB6VGQoG+qPR8ZP1KxkpMyv/0j6lzXkavv3LIRnDAXrtZoDI0fpMX8pqFTd9Bzd9zvr9Ol08JcTHIiEouviJE21PoK+J2ZLQ5Rv8dZPJK+9X77o46A5Q/gnyDrXB96FRcww6lmXus16rzKZ9OieZfwamkL+paV5GOLu5U5XNKmhPMQBUV8xU1fM+iMWsMhlcTmhsqmHW2ui9NwyByS0f4hxjDFfFFTB07KLTMJ0kgweJuj1pZOuciTEvJDDVtF7Xq1virYjBtyjlZs64I+KiYDk4qqUuYetzuxA1u374QaQ85A21moSX4rEOtHIVL6W5Oe0jNhylTZQFjVTe4bgQVC25F25M15nEpM1/KzD13eoSfiobS1+69tAt2lcxxC3qGVV95iWzy+FpKpb1oq/0KNYbwKV9KXUKdyyenZuGxPWNOt10OiOqyWUb+5Lrq4hfMlA0q0BgwEwUP8ujjJoLq+j569c4YywWCTodcznd59tWdxBUNnjBK0K/cN3nRKw90lOTBM3dAwqePmQnQbNFJ0DN/rNwM3E0GUhlfcULZzHQPN3pxF7QRtJsQ0LpOUDn5V2wzPZBj9x0TtxVlBag5VkIT2vZAdj2CvtyaMZkaaRMxnwqC85c0pHtPbfptuKB/7IiEw2lbP+rqMa4glDqG2mD+MYKbUJRM412m5/nE1qixZR/HOz1aFTnUErMCpD3SVHG8a1655Y6bk5UawZWFNJA8cr+NS7de5jLhnWzVSJYkG9JdvG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 12:11:49.5353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1864f7-905a-43c0-4252-08dc4d8dea5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 25 Mar 2024 18:29:16 +0100 Petr Machata wrote:
>> +set_ret()
>> +{
>> +	local nret=$1; shift
>
> May be worth throwing in a comment that $1 must be a legal ksft ret
> code, not any exit code from random commands.

Hmm, yeah. I'll rename to ret_set_ksft_status() and the variable to
ksft_status, I think that will be harder to miss than a comment. The
verbosity of the new name doesn't matter, it's an internal helper.

