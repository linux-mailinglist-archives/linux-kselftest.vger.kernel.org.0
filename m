Return-Path: <linux-kselftest+bounces-40935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A6CB48A52
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A08C7AC5E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E342F8BD1;
	Mon,  8 Sep 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5H90PfI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3032F3C28;
	Mon,  8 Sep 2025 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327867; cv=fail; b=FruDQ0F3ry+ioKzA2xT2s/Yl2ysWYRw6+1ih8mAppG3uiiPyeORxG7c6lq/ki/1qpJBiBiIJUOVwI19ee2wtmBL47TghJPytjnz3bl2H6/9YQjPRUIdYfbUXkQ5rsL/5pO0NM5AVsWhOooxFi2kNOzMS+oTDGakFL7kU81BBSDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327867; c=relaxed/simple;
	bh=f/NjHyQ0Dt4TSLOysLUubxJac3LEgjGPZYgOR0jqCBY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=e2W3kGJ+OQ3oJgUW7qP05M490YOXMaMgibgPdTriGq+xbIYbUAoYA4T//RuYwa+i/eopYvbh1yDkTSNuAUFpDRyBfQ0ceuDI7kHS9g/hsGomgUzH6rNjOZ7MVHqds4KHHyErsrZq6QU5+S84YYzS3vsOh3/szkM122xgeabWjCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5H90PfI; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfPqm0fkSFJgESxmQ6BXDVywGWJeBhu1n9fVTubVUg8lbnh2bOOZ/GuwvslPW7xC9GcKBTC51DgZLAeEPii08JCU2PHyv7tV73X5/C5TL0dtHMmhiyIpjSlMFiz1BFTFI8jXLwlZe184o9Fx1ot6U6RmSWLD8E2lu+qR4c0hqVODYjUitmZQAKwMGfKjVDBiEpNTCQOOVrBlAjREdUyKmAQwS8XSgwYqzjxefc5T06AtUV0cwPpOntVr+RodgZOSARcMc6IGNgXWKXsDT6UUEzyeCirnX6UYM0qKxzH8j2IIrtdhT8jTOvUQGRRGoTiBh+YjlQxjlGYncyqOl2EgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM6t9e8TNKgRA8qTWslAodoY6JjKW1ep3aqeGcgmUWY=;
 b=TDNuNiZ6mRsvw82PZ1rLYojnjKlNhrhhTt8i4vWymRQFZaM80+grD6eTW66fY5Js3QHwKuEKstozbUQbREczzyrpCyrBP4BY0lbjVgeZ8mH3HrPM817pvDMdjaDUPLh7znOt3AeDd324cr2ZxY/PzG/oFMdp+N1aRH0VB4BbZYZrj0ARfnUEz59ZNtew182LuESGBkgTWyppfECoSQn6KpKek6HfYzYqqPCICFMYGco5JZQKV62Uh9LFwGp3TqZRxHLhgGkS7Odbqz3ds/UCtj5aMY77vqbwSjiX9/h287GEihMMWLhv/FSrKTh5ooEOTyhnmbGuuTT/vxgiEghDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM6t9e8TNKgRA8qTWslAodoY6JjKW1ep3aqeGcgmUWY=;
 b=I5H90PfIp/Ii3cMI4F6N33ERNzRKynMTDVL31R5U0y+b5+mvO45t7N1Jym4fqkRRtfGiSRDHR98RVgfCz1pEAJGN/GsbTY6aVhmOWENXOtjeN6Mtoa3e0JBUZpKZK/yQaC1wACfoY266DAXOfOdiTxStGE6FjWjQcKCQkz2UeDt9BIniA3QCbKtFLsiybjzQRkerpZ0TIdHc0e0+cJzxBppav4Wn5sfMF7+S1hptbbHRjodWM6RTqY8o24dtWa2BF4uYL0lUZENyK4BPEBvJ3CDpcdHequ4NdalFNoi3w/dy5aH2FPmOc3js7go1k/pMSRX9JtntK6BlAlMpxLf53g==
Received: from SJ0PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:33f::23)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 8 Sep
 2025 10:37:40 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::8a) by SJ0PR05CA0048.outlook.office365.com
 (2603:10b6:a03:33f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.8 via Frontend Transport; Mon, 8
 Sep 2025 10:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 10:37:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:37:17 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:36:44 -0700
References: <20250906170440.3513399-1-mmyangfl@gmail.com>
 <aL59Jl5p6bEtCAxo@shredder>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: David Yang <mmyangfl@gmail.com>, <netdev@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang
	<yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Amit Cohen <amcohen@nvidia.com>, Li Shuang
	<shuali@redhat.com>, Alessandro Zanni <alessandro.zanni87@gmail.com>, "Xin
 Long" <lucien.xin@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] selftests: forwarding: Reorder arguments to
 obey POSIX getopt
Date: Mon, 8 Sep 2025 12:25:56 +0200
In-Reply-To: <aL59Jl5p6bEtCAxo@shredder>
Message-ID: <87y0qpw7t4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 86637f32-7c58-4c2a-6b85-08ddeec3bc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZ2qo8nAuABsaB7iwd/Y4e7tf4Y8yQe3J44aMW6BLmP4Um1vuxBh7UVp7D4o?=
 =?us-ascii?Q?V7VwRm3pBG5KFDGIUKM11glwDRBVU+WfofaXzlndnZ9Dgd7/PhJ+w+XBN+cH?=
 =?us-ascii?Q?XyqB4mkfsDj9O/TsL17fU3mTYTe35Et9uOrjBxJF7q1bZdJiFaZ1fsYWFSfh?=
 =?us-ascii?Q?VH2NLNYh5p1Jh4wQV4LtcqjLc3+XCFzoHPUzFTanx3HmlJbq7ERzMo/bvfAS?=
 =?us-ascii?Q?MDYE2z70yNiQWiYNIZhZe0GHHhJAZ1cFKEuXRXJT2SfJJXpciWNIDt1jz0p+?=
 =?us-ascii?Q?CTuH0Bde0T67B5Qo5EEVfL6bn2bcFpGrrL18BA4gp2k36f2cNGBlWDLz75Ay?=
 =?us-ascii?Q?zaj6mmDtQC7gLnOhx9lBrDVL8aosUOBNMTJ2dToTtiSK9OYGBiZT6fHID7B6?=
 =?us-ascii?Q?l1Xt7yO5NWlFIS7RnSOeqO0LbRX5RAM6kulAYIG8O+p5xgvQAZHFUz5/21Gx?=
 =?us-ascii?Q?1YRr4dUVTKKT260DHJ0WYtmjskCWJ+SYnHahADv1043HlGggnDlwecuWxvZH?=
 =?us-ascii?Q?38UV8CZqSv4+GoTF4h87DbdcWABcZk2FOV+trsMkATpqoYC6EXw0qX2VS9o8?=
 =?us-ascii?Q?EMG8hwg67xMDTz6jvXa+rmTDqGq5xF949Z9H1zWMIQi9DXyWjGH9ARvdp220?=
 =?us-ascii?Q?9zoYHU7ioWhN/PGewalDasxcpajd81P+A6vnvmjcYEdt/VfYy7G6pjZIP9C1?=
 =?us-ascii?Q?5wfJJFzYxMrvMRrmYXYXVoxnZ5+bo5w+x9z8QID08jQQsjf7ZtfE0EZWWeNE?=
 =?us-ascii?Q?Ctdc5BdZesuXiciLi9SWOZGtKwT0bOblFDaLzlC7oTBorlClzaOyCmOPXyP2?=
 =?us-ascii?Q?NdJffxKFFOMG2BjyujdLSJ1ti6yCDNmz2mRCbTF6nOegtzw21NSt8SIn30Q0?=
 =?us-ascii?Q?mJE0+Nzw+5fCdqGbeLeDCfIMC8nNpakQAivtH60mGPufHIcsodYD0j9g6+ly?=
 =?us-ascii?Q?f7ji2ie89oDndUd7el6z+vTOn/Oy9dEtcNLRx6Rwxpea46VsOv69x+yDlo+o?=
 =?us-ascii?Q?Evt5t1aLaYUhKp6c7oW66C5fHl6hEo61Capy5Fr+PH9wiMebpdSZUfiM0CZ6?=
 =?us-ascii?Q?cRVfb9Q7Ay0HxsI/coTgh/4aVKQNZMBunsCOA79skXxJno6ArbvKrnk67Gf6?=
 =?us-ascii?Q?fr0wvmbCN4hTLPBybADYun8jkhKJEnepY895r73GLA91C83lpo3VKwBY8pPa?=
 =?us-ascii?Q?873ISQUj/qBOtqRgIfA7fnOFO1MWvbEDSocSUBK86n5SzzptMK+gBYJDc8sy?=
 =?us-ascii?Q?p+zWVFWYR7W5Su38oiX/pzxDahU6qYi3qQHxeAq804UWGm9GDxapT6MFHdU/?=
 =?us-ascii?Q?2WKgyFBbERg/8syyx0cW8+sEUB/A1fa2FZO1G61z+nRaCoylGRPFURdx9708?=
 =?us-ascii?Q?DtzzCwyT1PmsAKeXOHq2EmKC5TwoWMHAkRMq0oFoBJAF/A69ztR4wvN8tq/O?=
 =?us-ascii?Q?A4mj8V1RBaRptK0ABJpwPQmQqlntXtjyYi2hYVqOXIe821SYDkw/IS7IsvuW?=
 =?us-ascii?Q?BcriqeGhEsyOWYjwIZc5HPweTgH+8gkm3Gcbd3SzuzjGzPSd/yyBrMvkZw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:37:39.7815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86637f32-7c58-4c2a-6b85-08ddeec3bc29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949


Ido Schimmel <idosch@nvidia.com> writes:

> On Sun, Sep 07, 2025 at 01:04:35AM +0800, David Yang wrote:
>> Quoted from musl wiki:
>> 
>>   GNU getopt permutes argv to pull options to the front, ahead of
>>   non-option arguments. musl and the POSIX standard getopt stop
>>   processing options at the first non-option argument with no
>>   permutation.
>> 
>> Thus these scripts stop working on musl since non-option arguments do
>> not always come last. Fix it by reordering arguments.
>> 
>> Signed-off-by: David Yang <mmyangfl@gmail.com>
>
> 2. Did you try a newer version of mausezahn? Seems the issue was fixed
> 2.5 years ago:
> https://github.com/netsniff-ng/netsniff-ng/pull/237/commits/f5dce56e74b005daec72c771d27d55964aa8efd7
>
> I feel like this change is fragile since current usage is in accordance
> with mausezahn man page.

I was OK with the change, but the fact that MZ has been fixed, and yes,
it's a fix, because per man page the current usage should work... it
stopped making sense to me.

I'm still fine with the ping changes for the same reason. However.

People will introduce more ping commands in the future, and we are going
to rely on their cut'n'pasting to keep the codebase working. I don't
think we should require the selftests to be musl-clean. We have enough
trouble getting people write selftests, I don't think contributors
should spread themselves thin with stuff like posix compliance and musl
support in selftests. IMHO if it works under bash / glibc, it's golden.

All of which is to say: ack, but you may have to send more patches like
this in the future :)

