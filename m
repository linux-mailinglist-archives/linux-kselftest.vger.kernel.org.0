Return-Path: <linux-kselftest+bounces-7010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205B895FB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 00:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FD51C23896
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30304DA13;
	Tue,  2 Apr 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mU95MNhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FE47A53;
	Tue,  2 Apr 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097765; cv=fail; b=O/KAZpRaBgIeynU1CAbhRuaAcZ6hSB6PxYT3Li5QLHYGlWUrs/BVf18gfNaV7Nfj63FvgnE83BjXgCjMMKVD6qnamiky2PEx9XuyC2sdjyjInTzbdLYo5W5XUYGNIbqMIDbp1bVDpO0zBNDXXxy02W8spYsfd8TWD4Jz1iPzK2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097765; c=relaxed/simple;
	bh=qV3dGnWNL22Lztjn8ZYBsWqq6b3m+tYzRhuAHldrc1w=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XudAC29v0nNc85WqHbfQEmhLiE+4Tzf34HBuvnbZPMZeVJJdu+6emjiXlX1rb0zAbIrcmn+HTEv1zGPn+rUSbFN3b9QxjjGsWSkuPHHjqu1M6bxh1P96f6zapJ+hhuI/JEwAADWoPqhA36xkkuBB/gSuAwwGd6AaJNBorKPsXuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mU95MNhd; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AixGs62xDSvqcj5Lt5IxIfzDmqmHyzJR5UWp2BkOSzAJgFsf2OGpGWVlISUPfvMZ1QkFOVVnQsLo5CJXlM2BlOgz2GJkCZLEFVIYETMauZb4Aw4TgIqublrz4TiE7bPVEX+uTJ8mDpT8k0H81yvTLPmBVpKhMd9Dsl0y6C6FzMpYqrgIrMd784HfoavmxK6z8CCClJxwVx7Z1hjtLKHHUeyZqZshISzFzzPJG+CyO0kMZLIyFHdKTttE9vSdT1B5y0UWxDJxPvcadffySiHzUYt7SYJD5XZE0TRyFdZbEXcK6rJoCJ+hEDP2/YkrmW+CCIyiPC5Q2kNl7YusA9PmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le8ykD15yQBVEeQNY/z0N7Wn1YmoMhjDViiTJSw3gic=;
 b=MYE3DR40SW5xfkv4L0nkbCXNZkrL33gPzwqXloJjCiV7vXU6S4x7cVG5E+wuRS6qg2f2OislvOH8ZHp11tJNNswGxplWugORbt1XIoR0fdYmscQyu8Jth9aguMCnOJmMJ9JaIfuB7q4GN/z/NfE79t4vL2IPM7VxXdO/o9YSgjjPsQczXykpk0yX2WUy7iH+O25ijs07LXXnDTiZfvw2u49rGnJW9vKksHGJQr911p3g7NHm4UQ8VwoDgkpCsx3o4gMHl8EV905fk0nJrecSZVzMX0JTIQapP8yQrDKyNdwHMPMjgYf01XqId1+Iqm878+U/RkzQ+E6t/dgksKqJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le8ykD15yQBVEeQNY/z0N7Wn1YmoMhjDViiTJSw3gic=;
 b=mU95MNhdjXJRSzKWYK0fLDCjU9El0Vzm7LPHvqYBO7qmFvYOMQLZX9sOLbUI+Rus8ZgICJ1eXEICCQVos80REVnCSpAJL+nz+5877f/G1xMkkzA/gFMR3wb8mmdUEvn+HaKTpCcJj9o9IYRssAVcWF4hrYr6s5DEI39blNjretTRoyQYkR629ZOYjJ0ioGyo1I5bElgvKXBGWy9HyDYzS1+MNKJk+2dNJBPp8oHf3Jt7nhVtZcj8gtfVv2hS4bMnXsPJc8EEUPRbeBixJoPRQbnpvL0vHEVtaXbZPKeE8rndXLNvUdtzhkloHgBc6mMPQuX6wNmp4czFLxs6W4FIpg==
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:42:40 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::5e) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 22:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 22:42:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 15:42:26 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 15:42:22 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org> <87bk6rit8f.fsf@nvidia.com>
 <20240402103111.7d190fb1@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <sdf@google.com>, <donald.hunter@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Date: Wed, 3 Apr 2024 00:04:14 +0200
In-Reply-To: <20240402103111.7d190fb1@kernel.org>
Message-ID: <8734s3idys.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f86d6e-f33f-4fcd-420b-08dc53663421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Apc127HyTqcCELcD8U8ARIEC5rto6RyT0M2IPLdUodbElqpZYJddU6sTXaPSSRQaeaBsjGUP38plFOzDn9RlYv8My7yZjP3rLkwZFM/UP3oN/KFYxs7KOP1e5t6AwpNGZaEOn5a+xgisagOPaekxrmpn/s+oLF2Hy2vvCkuYEdVXZckph7Ix+hpFS73oaHeCLSGaJx41rtQDL3C7Yy9BjFVc0Q9QFC79XzLa9pT8tr8VVJxTSyevinV+M2nDel34dDevgVjXiFqPyXQEji7x7gG6HZKWTjG50+KXckJq18fk4BD1oNLevpvx4gNELQkAZnNkkQ27Ku59OpOrcEhlRC64qUCqQVVxxIs1ZgQWDVE3sB5f/7rZRk8lnx2EPyrVQHFw63ccS+o5v5zBasiFjUVPhOWqpXcSKw4qNQ4l9hQ/fPqflrcoyEqDYVcOfF/zE0tUtVdR7Pl1OBGkddv9hS2O44xtF90hD7+NPIBKjwIxMx9LhvcZ7BK7o1Ibq8K4lU5BDGkfK9sr1e7ZI3F0huv+JzsXkW/crW4vpDQIia9D9B+gC70wuiKa8Tcgq4CWuvgmuHDVUV0hYynk/DBeDpxYVLy2J7IISaLKYAz0o4w5Ho19Sxd+4cQTJBiaF+c0jZsgMkOoYQw1de+5m1MIT8b5nXgcc5uMMd91MMx6/oUMhH1yBxYTKmKaPf4YNeljQXvXTbvcYPopCsYheQPnX5MDl5rEL271J4s4Nj/ilGoNFr4Es8YMTR5zMOzSKSSf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:42:40.4569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f86d6e-f33f-4fcd-420b-08dc53663421
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225


Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 2 Apr 2024 18:37:44 +0200 Petr Machata wrote:
>> Yeah, this would be usually done through context managers, as I mention
>> in the other e-mail. But then cfg would be lexically scoped, which IMHO
>> is a good thing, but then it needs to be passed around as an argument,
>> and that makes the ksft_run() invocation a bit messy:
>> 
>>     with NetDrvEnv(__file__) as cfg:
>>         ksft_run([lambda: check_pause(cfg),
>>                   lambda: check_fec(cfg),
>>                   lambda: pkt_byte_sum(cfg)])
>> 
>> Dunno, maybe it could forward *args **kwargs to the cases? But then it
>> loses some of the readability again.
>
> Yes, I was wondering about that. It must be doable, IIRC 
> the multi-threading API "injects" args from a tuple.
> I was thinking something along the lines of:
>
>     with NetDrvEnv(__file__) as cfg:
>         ksft_run([check_pause, check_fec, pkt_byte_sum],
>                  args=(cfg, ))
>
> I got lazy, let me take a closer look. Another benefit
> will be that once we pass in "env" / cfg - we can "register" 
> objects in there for auto-cleanup (in the future, current
> tests don't need cleanup)

Yeah, though some of those should probably just be their own context
managers IMHO, not necessarily hooked to cfg. I'm thinking something
fairly general, so that the support boilerplate doesn't end up costing
an arm and leg:

    with build("ip route add 192.0.2.1/28 nexthop via 192.0.2.17",
               "ip route del 192.0.2.1/28"),
         build("ip link set dev %s master %s" % (swp1, h1),
               "ip link set dev %s nomaster" % swp1):
        le_test()

Dunno. I guess it makes sense to have some of the common stuff
predefined, e.g. "with vrf() as h1". And then the stuff that's typically
in lib.sh's setup() and cleanup(), can be losslessly hooked up to cfg.

This is what I ended up gravitating towards after writing a handful of
LNST tests anyway. The scoping makes it clear where the object exists,
lifetime is taken care of, it's all ponies rainbows basically. At least
as long as your object lifetimes can be cleanly nested, which admittedly
is not always.

