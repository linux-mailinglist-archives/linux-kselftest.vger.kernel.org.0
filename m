Return-Path: <linux-kselftest+bounces-30239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C311A7DA25
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C916917717C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BF22FF37;
	Mon,  7 Apr 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="frjxlCWr";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ht3ZUIsi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484C22FDF3
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018927; cv=fail; b=rApOU8PVFjO7fQJhopjVaRi/6psWfnc4NOj9xrw4TLWrh2gR2go3FgElxCKf5SxhIBi7JTGmEj9SP3HH623bhHNFuB5tNAiLstxJgm0Nhvd/CwJRpVqH+Bt7JBc/NYfo+hfdAu1OJ+HAg8korZZW7a3p0DLIZ3ODJC2nH2gTrKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018927; c=relaxed/simple;
	bh=gIT4SCuHD6DvLGXJ5DV6Qxqst9APz3lgeQWOS4FR0Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNq0IwZpKELSTixaGJsqYgpjXC3guF1IsadRbeXEEqU3qwGi9XQjp3j57sAJtF0+j1RzCSYGXHkH0zCYoB3VSEgDOpKupONtr97uCFHDQUtO5lNNdtRBwh3dnSN3WdsyUECwzoajkjee8Wpcvb3IELvF+VGoIWMsKkd+YcEf9NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=frjxlCWr; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ht3ZUIsi; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5374i0AL031389;
	Mon, 7 Apr 2025 04:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=qr9yeIhUqHOJUwQzfIZv0slaIb2Uw6JbsgP6h/0dTTk=; b=
	frjxlCWrSGnYn8N900n+eDLtHYfTLIfPmxj8bH8JksA5FSpq8PgE9eni/SlMO7PQ
	cQR9B98OGoUbDimgPQEdmkEgCCYer05nH5/79nFe5wIZ5Oq5odDoXFmU6WOg7Tmh
	WOYewLA+QwTv6UdzS+FXQ9s07TmAHJepSRaS4dLT4E1aDFl8nHPOx9eskIHrrLZ+
	eBd/+FU4EexSptpa0nrYL5+rzyze3yeI6+/XMOBoG0pQDMw/tyYJAP9R/zOn7WmY
	Fe8hl7da0TfZQeH44zCvibI4iOLhsiT/AiWu6ZMocNbd9vfZXcBBTU08RiZuvL5+
	3OMdEnKWqTE3ksvPebvrrA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45u0xgj0hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 04:41:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIKHvY9nWm2Zd7bWGNa1aUUmG4+NvNpl6oBPIBV4VGcwm6KtkMt0h5MNnnsPh7XuYIBJ3r9EmW/95oHX6xQTGv4f5i8V620P6DxXYxuJtg7Hp0DJS1QruC7QF4KB5BdaEPbfovPtyqMMMc0rV9JTLdch/a+H7BSGeormu//IsV2BIGRqyBDAWPHPu4bO1kcxgsospgvSUk3mb+ooefqbq/AhSBI9n33m9uIMpCVSNbVOySt6wF1tj4muj2gzEZ2yQEI425rtfSook/MeDFzlXb364x8H7LUauWl8T4kvcB0Lr6VTTzEEYirIi1BGx6M0wSais8vWgWK9O608JDGJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr9yeIhUqHOJUwQzfIZv0slaIb2Uw6JbsgP6h/0dTTk=;
 b=a958xmWHNldA1lrHVhpnFOqXemw0DAlXUoWHw3QMnQqjxhuL0Wx0tcpP8oSTGTp4G+cKpbh4uyKGnO3IZIXnbvKQpC9UHZnVOI7QzTM9xQ7PAwgYxKeuY+kgu0orS4cARF6FktpRJhCrwgzTNHiQIuKt/7FzI7nlJYWh4jAfKe5GeT6N887FbkkTgMI0w9hRu//vhbn2eO4+6Pf2qWtBTrD58PCOiCZc+WDq1z4eA/XRy9DCi3WwMBP0Z5ZiF+dFyqJQcc6H4l5NKljESwUeX35tNh3WujrxnQU1R95Yn2avccv53i6HxnHR2/wwsUxbEvtjXu35QYF5bknId94JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr9yeIhUqHOJUwQzfIZv0slaIb2Uw6JbsgP6h/0dTTk=;
 b=Ht3ZUIsi+l/PtG2TJ1dxAREN8lXNmr9RiyRcA9dDuxxkkSA5JW0mHBmdBSGWLTypkj9zFBrAU/9twESweP6USgFQXuo5kNKNlCc3sHtcyyLZ1cTEUPEUoJhSy48nFy3XDRNkeLzu4AF74RcWno554sLFueRSMCmdNlrRrv6N338=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by CH2PR19MB4056.namprd19.prod.outlook.com (2603:10b6:610:a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:41:41 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:82:cafe::fd) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 09:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Mon, 7 Apr 2025 09:41:39 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4BB9E406544;
	Mon,  7 Apr 2025 09:41:38 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3B271820244;
	Mon,  7 Apr 2025 09:41:38 +0000 (UTC)
Message-ID: <1f05e6c8-c257-4fb6-ac94-e4cf40bc1c72@opensource.cirrus.com>
Date: Mon, 7 Apr 2025 10:41:38 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
References: <20250402103655.3e0c62d7@kernel.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250402103655.3e0c62d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH2PR19MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: c96413a9-b6ae-496d-77c9-08dd75b8660d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3VjRHhVeDYvSm50NlB4S1F6M0xhQjF6MFY2c3lwdWV0OXljYlh0Yk9oRS9v?=
 =?utf-8?B?YmluZDdPeEpXL1dZT05MNVpRQ2FTZENUVEx1bFBhdFhVdi9zalluVWtXYW1Q?=
 =?utf-8?B?MEp0VEQzTFB0NUlPRk1sVmxlc0FOcE43V0RvSm51ZWZBRFZzcFRwaFdZSzhX?=
 =?utf-8?B?aVcvWmxGTGg5M2p2ZWR0am15OGVBS2ZZd2ZLUDRIa2ZLeXVBZElad2l3Mktw?=
 =?utf-8?B?Q0tRSm1oMkdlTEk5QXJnais0NitWL0RKVVY5NktiK1FGanA5bHlxNXYrTnBl?=
 =?utf-8?B?am02eGV3TmlnN3dkN0Q2SEZYK056RGcvWUJobjYyQU05blRBNkpTNzl3TEN6?=
 =?utf-8?B?NWw5MW90MFgxbERvc2psZHhsaGxkc1I5RTl3RzlPeUpFZVlkYUpjaTlleE4r?=
 =?utf-8?B?MFJSdTFGUXI0N2tWVFZXejlGZzI1c1VKQnV2eG1XelVXTlJmRjNOVktHbE1m?=
 =?utf-8?B?dkdJaHVrR1pNNEx1RG1CNzEzNmo1SSt2SFEvTFdFZjFJVkdwWmgrSkd1cFZH?=
 =?utf-8?B?TTBYQnVJSkZqNEJHRDNXY2JzN3o4UUI5ekNETTIwZjRUS1ZXSDcyU2E5VVZB?=
 =?utf-8?B?NklKTThydFJVdWZHR2FDRTlVY1o5UnZmSHgyNEowdG1GUk8ybHBzZmJiK08x?=
 =?utf-8?B?Q3ZCZndqbnYzMUZ3R3o3N1d5dEZwS1VWcFNmdjNGZkxWZHVoenB2OU5CeGNz?=
 =?utf-8?B?VnJpUGgzcnlNTVYvM2NwVE1OR09jU0V4SzdqcmJha3VrazNkekJzbEpWc01u?=
 =?utf-8?B?SWdkVnpHanVNdFdEdy8zOWpid2FqNkZXN3diL1laSFczOE02L2xZaW5vVTh0?=
 =?utf-8?B?d3F3Ly9POTExSWFTZDJqdFhqK2ZCV0F4dVg2Umw1YW1XVStoSGN3SDhpZzlN?=
 =?utf-8?B?ZzQzUEhPMVpMbmEwUTZ5VnlOSStnZ0E2Qk4wUDhnaFZ1cTJrVW93djUrVkxi?=
 =?utf-8?B?WEdkeFZRKytWZjNuREk4cHBQd3lpVFdEY3hWN1haRi9ianlSb0xrUW9TcXFV?=
 =?utf-8?B?WlVoRzVza25mM2JEbUlWZHF0YlB1dUljNXhtV2NsMG9pS21FYnNhZVNwMTRM?=
 =?utf-8?B?bzVYbHB0T1UyQjdBS04xcEZRdjN6UU1tMktEL3A0dEd3Njh3azdvOE5hVVVS?=
 =?utf-8?B?NDdWZ2kzOHlpbDBZTll0Y1B0TWF0cXY2SE00U2NENFpyYndRMHMzbTBJeDFw?=
 =?utf-8?B?NEZLZFFwMjFpOWJtMDZXTnJKdG5pa1h5UWI0UnBYTHhFUzBBc09WdEhMUm84?=
 =?utf-8?B?ZE1oY05tbmRiRGNpVUJ5MURXdDhQYWF3Rzl2Nm1kbzhIaFduZjE2UjF0OE1S?=
 =?utf-8?B?Z21XK2RvMk5EZjdpV2luU2xlTWMvTnlzQ01LRnB2WG84bVUrTnhtK2JkL3Z2?=
 =?utf-8?B?UXBKTForYnlsRlkzQUNJNmkvc0V5ZkswZzFManRaeUE3Qi9HazRJQ2ZKQzZy?=
 =?utf-8?B?dDZ0TFdpSGVGVXVNaElQU3VxWGlJTXU1eHovTzJWZnRSUDMvdnNUOVR6OGlo?=
 =?utf-8?B?eGZNQVRLQmkyWVFPYW90dm9BdGUvSEJOa0FTdHE4a0VBL3JxaXlMU2xqREcx?=
 =?utf-8?B?bkR1eUJHRVFBSzFuZGZDZnI2RDYrVzJUdmxhTHYwMVh5V0h4UFVEU1R0Qll4?=
 =?utf-8?B?UUEzYXpwUkVVQ0Y0T3VKMTVmUmllbzRtT0h3MjFKcURLTVh0dytOM0FpTVdj?=
 =?utf-8?B?ZVJ5ZXZMUm52U3pDbUZpOXMrRXZ4dDgzNElDSjFwMEFOWk83UjlRT2JiRTBZ?=
 =?utf-8?B?aXFDbC9FMHNPVGdMMUR6RWx2S3pWWW5vSFZ6amJ2cjlVOUJSbXpDS1UzTFk2?=
 =?utf-8?B?VG9PWHFyVGVLSUtnWE5MVC9XWmZxcldQLzhPUTNuZkp2YVBDMkliZWdqTUdZ?=
 =?utf-8?B?UUZsNnRBM3pneGxxSXlwTUhpR05ndmNvR3JCMDFLREV4ZS9uZEFDVzRObWkv?=
 =?utf-8?Q?+FjRCD+LzwA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:41:39.9786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96413a9-b6ae-496d-77c9-08dd75b8660d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4056
X-Proofpoint-GUID: 3zNMVG_rby4bCANr3dHq0-8-ESbLP0Ji
X-Authority-Analysis: v=2.4 cv=bOIWIO+Z c=1 sm=1 tr=0 ts=67f39ddc cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=3aR74Ren4Y9-3qi38sMA:9 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: 3zNMVG_rby4bCANr3dHq0-8-ESbLP0Ji
X-Proofpoint-Spam-Reason: safe

On 02/04/2025 6:36 pm, Jakub Kicinski wrote:
> Hi!
> 
> The Cirrus tests keep failing for me when run on x86
> 
>   ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64
> 
> https://netdev-3.bots.linux.dev/kunit/results/60103/stdout
> 
> It seems like new cases continue to appear and we have to keep adding
> them to the local ignored list. Is it possible to get these fixed or
> can we exclude the cirrus tests from KUNIT_ALL_TESTS?

This looks like the problem that was fixed by:
https://lore.kernel.org/linux-sound/174291786934.56229.8841259212687977896.b4-ty@kernel.org/T/#t



