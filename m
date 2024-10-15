Return-Path: <linux-kselftest+bounces-19718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01699E23C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA7CB248D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA61D0B91;
	Tue, 15 Oct 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rua2DiwL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C271CFECF;
	Tue, 15 Oct 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983202; cv=fail; b=dG5CKULL226B7wLfylmiQ6o5Onjl7DFsXxfxew5FTno27lb2ow+wztCxScziBYAADxjfJvpLkwTPDp5E5X9ylNSsf3gRS88MSUqdjhkdBdvyZJbet14rwFzvMkvdvEPAnw2l/YcffvSRr81frmvjS9NBPQxcjVnw7/g3xPuZ0FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983202; c=relaxed/simple;
	bh=TQQKFle/6uKt7GQNsTXwhUdaRk6znObadgH2gM09eZA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WoYT7G+ZZSZIcMoMR5+jN0UoWbGxDfQixd59fVdoyoDVb06KYvPbmB43OsX+xjau8he65ChSeg8xVGcYoOsLmoRv9lFguE6NV0rL8JKDRmernXH+r10DVoGp6VRxPlu3ZzboqRbQYOmVSZRVWCk2t25Dsg3r/xtcvu3wtdq+DX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rua2DiwL; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hbl0b24VHrjr+czNu1yaz63NiwycDX2DtK8i/9h8QzDXFf24FdQ8GxJ0IfUjM6lJE+sGricgH8QalGyNrAowsPqQkg4kr2OCRNo0juOs8fxYiom7XK13XCShEgjwS6cTJqEHjQcyj+ycPlUZOpug+waB2sX+R+I+LP1kpzq69CP3wZxlcgEl/daZ46nJ9FRvIAuIj2RukaAnvt/Wk4UVRtjK7nYLKckmlldmg2oWYhv5FxNeZuSuisBazXsfX97N66VUlOT2BC34ApvPtTuT9qv2ZfDZ9FtsJAY67YOuQyIT/nw4vZtSQ+BwK5vusyTtxvzgs3zAucfxDIs/MeVksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEFw+OffaTHrcRDAXIQmyYBhuL1xiK5/jPm1eN6FQtA=;
 b=gOJUNDGhLnPsDKAAUU6jWDKKW99HQte78crcIOIufEwjkhGfDkf9T0VEIyCZo6zmnPFIee0DanEqBZxxUIuNt1b2rEaOCH9RxqZUF+fb/c60v8Yi524iMQdhV7s9kH6c6zcrEzINOSJ2u0t3OJB6dRFAAajGrr/LVTSDzB+6HtTIHeYLXWmQpc6Hs7wLoy0ijWOeZVy1SFx1XF4qWtG3ahXK7CHDaCPXbe/MXkfE5zb0Ocfwq5m3+1C9770qQCb6b/1KCrTWOAH7whKA5JkRzIo0wN2MRkyrU6LlBaJYmhscNiFGDP5gwzB7LUP7pK/15nij0WofAEfJ2W75F4tJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEFw+OffaTHrcRDAXIQmyYBhuL1xiK5/jPm1eN6FQtA=;
 b=Rua2DiwLXO/beOzBUbsFPG4tHO2kMicLhk/ZuqSN9iFVmIM4MuqSags54vcPDL848k9KkbHQ3XQIq0bbXHKr1+cju1fpu9AdDwNIm6H56QiKD43ExM3suHwH+dOUodXP4Z1hrq0n2CxVwApcdSYhbPY3ADYiyRxcXCag+pU9YzPZtTy0OtPFD8VBMR9JlgcZu+ENoVnt8b2x8c2Atx5AcXo04zw+T/PDRqUckX/BCgGMwbx/KcqU+j0/7E11NoVdKVBHNeKToic4EAHTMQcLJBpgPyxzPg7Trh6ctDYuXc81ne23iF7eYGgGnVlAfPvHREjkWlYFREVE1s8n7VWvlg==
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 15 Oct
 2024 09:06:36 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::f6) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 09:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:06:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:06:23 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:06:17 -0700
References: <cover.1728473602.git.petrm@nvidia.com>
 <4a9b24fa7e582bdf457b550bb27bb1e227f05b48.1728473602.git.petrm@nvidia.com>
 <85f5d99b-52cf-449d-93da-57e7504685e1@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 04/10] selftests: RED: Use defer for test cleanup
Date: Tue, 15 Oct 2024 11:03:39 +0200
In-Reply-To: <85f5d99b-52cf-449d-93da-57e7504685e1@redhat.com>
Message-ID: <87y12phh1c.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c885d3-bfd2-4ec0-e0c9-08dcecf8abfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtcTgkxvGl7AnRv07PuXnTPWLqHzk/47nIATVy1a1qM/EgFcLl+Dgtf+hLbP?=
 =?us-ascii?Q?EpyPfMZJGCvbIydj215px+jdOl4xbexAAVn+NtgFgNL1AmaFb1XH7lOCY6ri?=
 =?us-ascii?Q?++gd8A7MNuhnVygMGy60Ycl4HB9epHGsXPEM4wdyFGPVDPSZxaMsXYQJSJ6d?=
 =?us-ascii?Q?gzSRnRt691g7sBfRcRTvIBsgQnqTkIhurNyLsLnWsiynbyUTrlqa6GRC0nIy?=
 =?us-ascii?Q?mRa866DMQtnLst//3Tz83dgcANJkuqFSV9vT9y5ryMV/erY7rqb+D7pttHME?=
 =?us-ascii?Q?CdtZnQkJ1rDkzLU7CfSS5E2jCfGxSjy+CA/vwJ0wGiIJaslQmXEaDZnCPiCC?=
 =?us-ascii?Q?8gQ+KKQm69WrFUr58gvshPV3JeNELZ9mW2P7Vostbfza0zYMZ4ZUoC3YHgDk?=
 =?us-ascii?Q?55391zExQ1X6xxvne3m54S1rMGCY/JTaHphAI6EDlRlOVul5StFYIx+6Ic/e?=
 =?us-ascii?Q?sSudub5C/MC3HZwMvj3CV/QeF9yfPWZMK0DFJsCo9SJUwMsbL5PiZkYrVHwt?=
 =?us-ascii?Q?uo9F0+K/mTi+B903K5BewuA0X9dB6v+jk3upnOa+5o1ebzZv6VdeX+62cssD?=
 =?us-ascii?Q?jNyNgvmcriMc0gvQRneDwQ0S4JHVNt/Ecq9DVQjbKf/tm93n1GkzqWJsWXt5?=
 =?us-ascii?Q?eROg6Mt27l3CPCZGCZ/cXFhxjKy6Syev2nQS0TiDLbqokt1yHd4qBPX6r7q1?=
 =?us-ascii?Q?kjBlMGpTUeOnsJBTWekaXuPBh800Mq0AO9b+2UOPkd5fyL+Pu4khtMwdfJC7?=
 =?us-ascii?Q?qDSA3TvnNZAEWGCsVFikAXMD7CFyIceYV7clMv0zV0EQTKMd2UKYx+racp98?=
 =?us-ascii?Q?rA5nv5zzyCOIu6/wDS9oqQidED3vezwDtcIP6J90NQQW7BKdV7hF0Hub5vzT?=
 =?us-ascii?Q?XjidNXIeB2irTzlhTM0q91PvPNJU6NFdDqkme8SFBowl/Lnl2QZOqDCk04iB?=
 =?us-ascii?Q?FwNHDqclNrUdck5EYztHk1Xnat6jGdCKtTVKdJeiOOiEETHpNll+cyStfqz+?=
 =?us-ascii?Q?9XKUXca3wCVCABHlsB/jtnU+NKJ3US27atVpGE2Ez2erYz8zWC7PtMqtEuVm?=
 =?us-ascii?Q?E6jT30zkXOrX64zh5c6fv5lLb8VjCOv6zy9/cdfahVUfWwrR881MlhEK2EgB?=
 =?us-ascii?Q?k8pvDjBaNrgKP1KIp9/LictsfcbNa+xFTWyYcU5DtL6oLWQijrNoW9+nUGCQ?=
 =?us-ascii?Q?2VSv6nDY5h7nXvgncr1EiJiW7LKoNx3zxdf05Js7aEq/wCsNbtERpZFiU2Os?=
 =?us-ascii?Q?+7LZZX4seCV83FLkEkukg7ZLUHxzc0kAFk0PFZS6vf/fwRz5EHe543dWYF7E?=
 =?us-ascii?Q?3xxYi8fn51TGQ/6msbSFqrhUGj5iSJBJgZ5uZbHhofUUi+Z+zY5Gz1QBsOtb?=
 =?us-ascii?Q?AJICG8djr6D10xPVbxTRETvwxzHp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:06:36.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c885d3-bfd2-4ec0-e0c9-08dcecf8abfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929


Paolo Abeni <pabeni@redhat.com> writes:

> On 10/9/24 14:06, Petr Machata wrote:
>> @@ -450,6 +415,7 @@ __do_ecn_test()
>>     	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
>>   			  $h3_mac tos=0x01
>> +	defer stop_traffic $!
>>   	sleep 1
>>     	ecn_test_common "$name" "$get_nmarked" $vlan $limit
>> @@ -462,7 +428,6 @@ __do_ecn_test()
>>   	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
>>   	log_test "TC $((vlan - 10)): $name backlog > limit: UDP early-dropped"
>>   -	stop_traffic
>>   	sleep 1
>
> I'm wodering what role/goal has the above 'sleep 1'?!? It looks like it could/should be removed
> after moving the stop_traffic call to the deferred cleanup.

Yeah, I'll drop these for v2.

