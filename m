Return-Path: <linux-kselftest+bounces-6617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CD488C083
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD43021CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C98535AB;
	Tue, 26 Mar 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZYSxsPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABABDDBC
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452047; cv=fail; b=eBLOltfQkdgTasOLmHHeOKLa42j8a1v6la7virM6x1ylyEaZUNKmi3D6J3A7qstKBLOanseBFEjduj8QhRm/eRrGSOm6NtZBBHJ/y6o/+wlywpGDKLS5XK4u94ULaWlL1rHQPGFGDno6gqUGCAr64SjMYmOnXDg0zrW/nkWwLbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452047; c=relaxed/simple;
	bh=s4FPwlEC6TgxoKzctLClLiBA/SWoxsGG3zMXoeq3dD8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=i2JxxU3rNxggcm8CRZ2Be0rhFqsJCXfGiuHnjVH2CX0p7igFUz3gj8UrV/5Parw6Rk8w2/9sABWGRBgJsFmGOQIvdB7SeJ3PTbTmr1qlbeKeUjfGZ2SfRPnyO9ClN5L7JJgxsH3+nK9QLvm8NaZZlc2HHImMf4qtYI/RPRse/Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZYSxsPN; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT1IpcoHP1AN76ygjdQHnSUlKRHBx6R4p3inmMZrDLZ8E2h/cenQZfnMp31CYixB3uTTnxZ+IeN0DYwv2pMgp6BffSdleoUepFZVeCL9jEeTPbwy4KPulCpUtZyIo1zEzLUFCL1ZxR8k6kcrC0SclolrYZsDyxoy44Rn9wkRCNvUSCTYew+ZuJOMnNK6i30yQJFByXygg6rBL6JiNl5Z5PHD+6zuCWi7rCIrivNqSeP2avCqL/ISEUsOhdvT25UsSH1m4bHvlpfE2eHlRJwfgeAjL5xWmqIbVChktskefREHHpmEvzxkGOpRy1TD36pzoV1cE44FJHT0Hbp2teQTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph76mwTCd8AdMUQyXHTi+0kXwjkN8hTBU8rf9GxOvGY=;
 b=VLuvUfvQzN7kkzku55ZpletLB6X+gk7FzYbQERnTKO8oNkAx1UeG8EvTcptwkYpG/eNKpKzeMmm9gtdA1aFCH1p62awQwnNBX0n74IvMsb2j6BLBFXgLPy5yCDSi/bC/vCip8t7Y2CaFR4vgK2m7VuZFdvEZQoDAkksPrHkwYMiz8m7dkR1gb/aqDAE0gmokgz1uA470xdymrtazOQnrbpVY8q31Ch/kQl/oMkbJd2HqVDOX61PTdGq7zopVcO+4avOqG9vASNavi+nKBD8pU66NLpo1+X6L+My+zcCtXJQV0i9Bq96OVkkKV6MRqf8w+Lcx8pf94PEJn09MbOJ+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph76mwTCd8AdMUQyXHTi+0kXwjkN8hTBU8rf9GxOvGY=;
 b=FZYSxsPN7OjhsNYUb3mgvIRMIUxm2PpWTF1A0XxenPjHBmp7N8oOm8oNPX6D8RDV9zgIiSx+YvbW0/j1SHALrPzaJIEZBh3ZrDqKC2kau3N2Pg7je25aIs3yhyoWtMytkWi6KeaJdThP4tUSS2LmP/fe0Ua8MbTTvjCbel4/DXNdXHQNVUGhG7GlOE37yX7ZnvUge9pWQHckjqf7mnQ4Ejxi68hg+7Rak78EyFhqmRQNEfq3Baig513Rdk+2src6zIpm6gKIsvUFt94pjkaElKAuj+aNQR9dX/Lb0lCOYbIioNw+tDtWnEwnFB5MlH6lGqNfd/aDIUhyw2hPUO2WDw==
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 11:20:42 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::91) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Tue, 26 Mar 2024 11:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 11:20:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 04:20:21 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 04:20:15 -0700
References: <cover.1711385795.git.petrm@nvidia.com>
 <20240325174813.3111a5c7@kernel.org>
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
Subject: Re: [RFC PATCH net-next mlxsw 00/14] selftests: Fixes for kernel CI
Date: Tue, 26 Mar 2024 12:13:59 +0100
In-Reply-To: <20240325174813.3111a5c7@kernel.org>
Message-ID: <87le65jl3n.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 880bd537-a7be-44b2-b7cc-08dc4d86c579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0b6kqyl+Ee46htmt6Us30LZLSAx2OG7BQUIp/ZQ0J4gwIn1J39S8B3xJu3kEL4Gu9Ldr3dzeR9laOqw7Yo7lGMBCsgNtXgysSrlSQaIiYjsIsaUa0q0crkl8zy9lT83dvzkOI3H/XCqKUi1u1l2UcbivxQUgpfg1fMCFdkHLRvbrOdyVNgfbEtXoQ+nkoI2rgccyTNas8UYQ9cOJcKGtAj0ZAdsFn9zp/xr6Vw5H/V4jBpF9YaLIwByvsrsWBae3eDPCKuCD9oo0FGiWbZU0JfoLFDQDLKmBjXk16kXu02DiED+hjqZTLP9CKg2vhytdqyO7nbncopeXyQqDLfkbbIxckHu2b83G6cvQqeD4i3sH6rdH1luOSTtcJnPDQx6+K8VNP5MBGDgSBC0mstKGUPl2PrnT7uGGrw2aFXaMJza4d0pQwzwY05eeD9Pl5IfzFtjB+Vik0nhPnulqPgeRlZxmRU2EspICInd++jRsUAqNmDSXiL1BdEM8AbLJjp3UcQeIJxtRIOruWr7Ox2UOEz6EUxMTMhRX9c6IltTRQb24RGLgVyw5vseaFv2PYuUdYyGNP2U22Mum2dG10dTb0V8Fj/zgFXDFuWSNW6W0K1x/44P6xq5XX5QC0EMn1q9j9o/UjWEfatF8uOb8tKcW348nx/JNbWsD2Cb2t1/ScsPE19L+PJ136CfhGLW1LJiGtap6laOSoigpZpKkEdtkqB/brFO1FY2h+IVxbYLLwMKW4L+dIS2Q1b2nvez6W4jv
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:20:41.2250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880bd537-a7be-44b2-b7cc-08dc4d86c579
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 25 Mar 2024 18:29:07 +0100 Petr Machata wrote:
>> As discussed on the bi-weekly call on Jan 30, and in mailing around
>> kernel CI effort, some changes are desirable in the suite of forwarding
>> selftests the better to work with the CI tooling. 
>
> Excellent.
>
> Did you skip CCing netdev@ on purpose or by accident?
> Feel free to send it to the list without the RFC tag
> (pw-bot will auto-discard it if it sees RFC).

D'oh, I forgot to toggle my dev tree from internal to external, so it
went to nbu-linux-internal instead. I'll resend.

