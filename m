Return-Path: <linux-kselftest+bounces-40926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A32EB486E7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B323B0653
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8832EB857;
	Mon,  8 Sep 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k5BFEBoo";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k5BFEBoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D112EAB88;
	Mon,  8 Sep 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319780; cv=fail; b=dVFkqX4Kv0cBxfUF9qZESrrtey1xRNa3YAX7i3mNFTtdIZbCdvKdlEH9b86LXLGUyNwTInELjNWfgiZJ1MeDMlf6q8sfivNefXI6KTws1W3FLCKOYI/4XwDHY3l1A1iPxZ+adVZo9TXtVpL8j9U8NIfQJIC3as4Ewf+c4DPj7V8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319780; c=relaxed/simple;
	bh=r1Rwvju2Www8bw6kQHGuWt3n0hNXFRt6FQ4gmErMkKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDxGm3oxmLNgOatjlxgMqAcxD7byhBIHH4ub1bTyVBxdyVBrkGxTYVJr8bY0pA6384N2SB0bE5F9h37jWYgZNpBPxLZM88kPZmgeJH/P06eJQbF+H4VDPSHCX3BPVo+tQJ8ZOKEb8Ds9MpdmghlpWyan3GltF891VEOymCvogeQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k5BFEBoo; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k5BFEBoo; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xlodKOcTMqjX9WGD2yAudGub7a3sBF2zwngQNxWQYceSborGxeASJwxqADYgVq6meq4pgKPA1p1SPNTQLgTm6e4Ks6CAGgnkCrPhMllKpbVyl6qIRS4R1n/aOs5QSqJ2o4EpC6JNEkznC1Uaa3t5rV5ivetZpfxiXxbNJlXY0fCyHukE7+/b+Z2RCdmOVaTsTp/rAtPRLpkxjF+tK3TsARwndFFFED5mdbfo6VPHGJYfz72K6taXuRXL9mv1x7s1AH21WIHQQz8+yJQt+qlBvq2Fx+gAGzLb9HXlq9Tpwo8lW/POKr54dMOydyby2Cgy6xQqC3PNgLkv4NgE1MUvtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84LUNvJ0M7EVR6ZLWLkij9gnLFzYoufm1sMJ810yfes=;
 b=H+LXKfYSzxTNxibR06H9WxU3WoJnRM0xDYaS1aeoRiXmQy1nWu8EeFvJnOm0WrkZFBPhAhLmnUFoEvIA1Er3lh6pDBsC6JMU7U/J52vv6qJbrqHFH2qYH1JT1q4TojHA5Jqih6f5YmSq3VDjaLWbeUinfPWnX2MLxRQvlX1bAv0+DBxOh/FpaorSiNcP5PHgZCn6RQ8J+gqgfvxZTRaHiZhUuEc/viEyYmj2W6KZQEEWple7A3Z9oOEcTWkvC7GhYiu8xLDnRWMr0dO10porRuXYIekr5ws+lNh80r0cM77ByRchEqTjTzM47cTuQni1YQMrJHdL6bdSP+vuXVD3QQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84LUNvJ0M7EVR6ZLWLkij9gnLFzYoufm1sMJ810yfes=;
 b=k5BFEBooEp2+0rduwosjG3Pghb6y6efP9c+Ru5vmaLfIt5X1gsMhkfaUsxSqSR7PEPeOYKjdLwQ5rKKomkH2ZlflJhIX6Y+ml1yw0S7iloh/6MdQjyjDRTDTm3gZQb1x7/VFHHHnn+sDk5XbGw0VPvAggr994huai7jT7VRdRP8=
Received: from DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) by VE1PR08MB5568.eurprd08.prod.outlook.com
 (2603:10a6:800:1a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:22:52 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::c4) by DUZPR01CA0165.outlook.office365.com
 (2603:10a6:10:4b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 08:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owYN88xk5HG4jyA91NUBeFxsZMcTc7jZfzu3f51dl4sM5/enYABD9IhGZk97rgQZiTC+6bTRPYbR9EUdbdywpVl1WfSc+MZVeW1hXVSBQbQMWDsOIo9n/KktqhU2qen6vfsuPBKhUouT0ZsSum/vG6jP9IzIhHg/lR8QSRqgetkYrUw6TC0JfrLsgpNGq2oLTCkyqpydDJjpH2kYD65dwIN/wh46hEisjcsgNlmuAXCXqwNhajVeHK+trUncmvjp/CbXvYq+9znpTVJgcBfIEg59i02vJwUZmtiwjVVxlIbRrEASjQVblXv3eJKqTt8oBipeB24+ujbkiTnzvPgNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84LUNvJ0M7EVR6ZLWLkij9gnLFzYoufm1sMJ810yfes=;
 b=EbEvF0XYB5rl5G+ujssI/ZHm0BqKI6YEJ7Rg00f1PP8tQR2GSffRsb0KZTpuSFGTkUA33lquPg/BbHM1hPwnAO/T9C2x3v0pO/PhpfErnBf6MsdgbT98aH3qiVeKuXqWA3Ngv6Sx/hdQZaPjtSPQgUKiYAaAwMMq+pFbDs32uRiplGR0jSgVDDpPk/1WkMZ9P9N8NkVgOiNkz5aJoMYEm34ddmbrf2PJ411AEzEGW/eT5jG4zBc9kumIa9oxJhjEOymWKyOtSWZ+gmBy1ScCHvOsA1VCFlhR/KYERIjv8W1fe/5R2tt6/XeT42rUKZ6EKjOEwv/2a7M50fb/YxHg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84LUNvJ0M7EVR6ZLWLkij9gnLFzYoufm1sMJ810yfes=;
 b=k5BFEBooEp2+0rduwosjG3Pghb6y6efP9c+Ru5vmaLfIt5X1gsMhkfaUsxSqSR7PEPeOYKjdLwQ5rKKomkH2ZlflJhIX6Y+ml1yw0S7iloh/6MdQjyjDRTDTm3gZQb1x7/VFHHHnn+sDk5XbGw0VPvAggr994huai7jT7VRdRP8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com (2603:10a6:20b:402::22)
 by DU0PR08MB9822.eurprd08.prod.outlook.com (2603:10a6:10:445::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:22:19 +0000
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45]) by AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:22:19 +0000
Message-ID: <1634f29f-81a6-46f7-86d4-c9eac953d4f1@arm.com>
Date: Mon, 8 Sep 2025 13:52:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/mm: uffd-stress fixes
To: akpm@linux-foundation.org, david@redhat.com, shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, npache@redhat.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826070705.53841-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250826070705.53841-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR08MB7111.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB7111:EE_|DU0PR08MB9822:EE_|DU2PEPF00028D0F:EE_|VE1PR08MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 17049a39-9f45-43bc-ee40-08ddeeb0e779
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U2E0K1k0RmdWeFZnY0s3MXVHUW1Bd3pDdi9OcEo5V3E0UThXRnBTZys5SnpS?=
 =?utf-8?B?QVQxdDQ5aWhTN0FucElSTlQwQnRnRDFaV3g1Zy9tM3VOVzQwNTM2VHR6WGk4?=
 =?utf-8?B?c2U0SmVQYTV4MlBBRWwwKzl2VDdqWTZiWk96dzFaSUNqY0lJOGVtUDFzblcz?=
 =?utf-8?B?b0Y5RDFlcGo4VnF2TW5ndTdvTWtTbDVKRjNiVEQwY01DeDBPb1Y2dlNqVXVm?=
 =?utf-8?B?NHF5NWNTckxuTW9HbnB1Q25scVBvYld4enBWTW04dk43L2RRc2swdU5TelN0?=
 =?utf-8?B?dkpmbXM4cE9tQVU1OC81NldIdVZub1EzMjJRb0ZUZmU1TmVGYlN2b1VDbU9V?=
 =?utf-8?B?dCttYlFnSXZnd2I5b3UvbTBwMXFZQXI2cnhFOFpBM1NkTGFaMGk1VkcvWDB0?=
 =?utf-8?B?ZXdWcUxDenRsRVZyc05kM2JQaU50MWhUeG9tTUljU3JYU2UyTHhlMkMySlpD?=
 =?utf-8?B?R1MxbWJoOW5kcThjbzNMcExNdENoQXhhdFVsTWxCaElLNm5pTUV2M2ZXdXN0?=
 =?utf-8?B?N2theXFwYUZFa0kycFRWU0hRQngxZG0zMGV0Q09lM2ZFZXJvME1lMVJVR1Rt?=
 =?utf-8?B?UXdEVDBkSFJUL0ZrZjdtM09kWFUvSHU0Mmk0dnN4aUhqbE1uNGV6RlVWY2Jz?=
 =?utf-8?B?ZCtIQXJVMUM3bVBFTlBTbkdXMkZuRjlIMkpEWUp5YXQ3MFZCWjhtd0g2ZnRa?=
 =?utf-8?B?NmNIVGsvV25DeC9QMTJCWEhqMTBzYWJNZXVEWmx5UjlFVWRuV0JoTWJSeWE0?=
 =?utf-8?B?bnlGaU94cjZVa3FRVGVTempET3RWbng5TjJtWnJZME5GenQwTzdZMXRqa0xa?=
 =?utf-8?B?RWZ2S1JxNG5TdWNmSHZkS1NjTHpWaUpTUHVIOGY4RVJCUHhQNmZYK0FZUXk0?=
 =?utf-8?B?M3pXWFdHL0ljZnNPMXloWkFKb3R5aTVtcUkwRVUwdHU0UWNtd08rSXhUZHpi?=
 =?utf-8?B?N3JoNDNia3dqQU05aDY4SGRUS1MzUXAxUG1DWDJUenBXQkZFVmE5YW95b0dm?=
 =?utf-8?B?YmdQbEkzbC9scXdoL0QzMWxYZXFVYnBKN2FHTFdYVkFFYjREd0hYckMxcjJn?=
 =?utf-8?B?UkJZbFVPYXRjdktYWHNjMEFPODRNMXRSSEQ3aHVKQjBWS0FsRmpqVDNjcmV3?=
 =?utf-8?B?Sno1cXFPRUthaWEyR2JBZWMwTHdwblBLMllnVG4wMGs5YllsZHRKcE14cldO?=
 =?utf-8?B?SG4ra2JGait4OXJrc2NtUkNpejhUWG5IOFhrL3pJY0VxZzBnVUNlK3JvbFgz?=
 =?utf-8?B?SFpGL3NjVlhxWFZkRVZ0dlFGSVRCbjlFbVl5SnJXU2xUNXM4dmQ5SnVkSGRi?=
 =?utf-8?B?cmpPZElONU1IN2t0OFRsWE5xbTJyK29tWlhqcmJzTmNlOW9MSWVPL290M05n?=
 =?utf-8?B?SXNDSDF3dUkxLy9ubGpyV1ZQZlhWT3hXZ0xVQjd1QUVhUEM0VktOSm5mVkto?=
 =?utf-8?B?MFRnR1kzSkFyanMrZjBobEozUmJNQmk2aEwyMzFMY1ZJM09jZ3dwMEhtMHlz?=
 =?utf-8?B?MkFlZXQvQUFnZFF2YzZLTjRnYWRySFNhSDVvZ3MrNEUxMWpad0k3cVFsakt3?=
 =?utf-8?B?bHF3bEhXNGpLSXBmRi9naFpTYjBlL0d1clVzUzhTWDArMG5HQkgweFE3WnRw?=
 =?utf-8?B?TjFWSVZaZkpDcW40aU9WT3ViN3luc3ZSWUxocFJ1VVU1NXdyU1Ewb0Rlckdz?=
 =?utf-8?B?N1N3ckJmaU84VHNhVFBEaEhIdktjMVhaRndtbnFvVDdic2ptVVUzUlVYVE5I?=
 =?utf-8?B?NVhUbm15b0FSYlVvY2poUEdMelYyWnJqTDlmMG1RRWtlK0k4US9CMFhETTR6?=
 =?utf-8?Q?Fa6v0S2ec0gej26dclNg3pBxcWJ2AHa4Hgh3U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9822
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1155054-1a25-4808-f689-08ddeeb0d33d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDFmL3RYdExTZnd5LzA3K2RKL29CbTlwclM5YlRqbEJ5UzRpVnhJTE51dUNk?=
 =?utf-8?B?UmlqdnhFTzNQQVB2Slk1RUVuby8wK3dkT3daWTJnLytweDk4VEk2S3lra3Ro?=
 =?utf-8?B?Q0RCVXd3U3dITnVvNkFqNVc2a3FwdW9OSVVpcUhkZHVFUmZ0bU5HQzdUbEhG?=
 =?utf-8?B?dTNQdnl5QktWZ3RyWWlsdnh1MlR3NXNPVGkrcFJKOGNXeFVBWEl6M2QyUzVC?=
 =?utf-8?B?YnN4R1Q3RlZLdW1EeFMwNTZJWStwYzIyaXc1YkZpWkxkejhvZ1A5TFBSalBz?=
 =?utf-8?B?M0U1VWdCY0xiaWNxUjFGOG9ncVkxZzNwSmV3U2oyWlYzNk9CT1k4R1ovc0kx?=
 =?utf-8?B?aDUzMStuOUgyanJaemMydVRXNnlPRGJpNzBpZmtCZHJRc1lURjlzaWNURU91?=
 =?utf-8?B?MjlobFNFekVKN0xUZjFpNUh0QmN5Y2dVcTBZS1ZyOFNwUXBkbXhOVWRvNkpY?=
 =?utf-8?B?MGRCUTYyZURzeTFYTWxjT01TSExwODc3YUlwM1czcUd0OCtHbmc5YWhyZ0t0?=
 =?utf-8?B?TzJRdEdCcktGNGlZelU0aEcyblplMGo4S2hiR2ZFYUpwZFJ1Y2xnTHlteUd1?=
 =?utf-8?B?bmxDNG9OZDY0N0ptUmdNb0VnRVNGbWM0bFBhRi9RZHI4dVRKQytUL3dxcmp1?=
 =?utf-8?B?M09MSVFCbE8rQ1FSbWppbmc0dmJhMUhYdlZsT2R2a3NhWWE1VnE1cmJmSUlk?=
 =?utf-8?B?b0lFSWtZRndPQlo2U3ZhOFpuSCtNNkRFZ0EvOWFVZVg3SC9oQXdUcGxqTFU5?=
 =?utf-8?B?VXU0OGZwMVQ3K0Y3dW1BQ1NRRzdrUG1KVjkwRjNhZDRQNGlmcGt3Mm1JWXJ5?=
 =?utf-8?B?YW5ud1dlSm9sRmV1dFhzTGw1eitlYlRUQU5jZ2NrVXpYbXBLMVNhZTNsdDdq?=
 =?utf-8?B?RnlpaENzTUVOdGlvYlJRWUZtejRUNE1TM1Q1dlB3cklYQWpUYkJRY3ZIb2pT?=
 =?utf-8?B?YkdvWWlSWHcwSVZvZFExeWpTeUU0SnRTRkg5TStoWCs2eGtXZ2pzNlhOaFRN?=
 =?utf-8?B?OVR1V1V4bW9PUDZsQlVqTWRXTXoyVmFEbm44Wlc1YUpmazVCaXd0TE42V1JM?=
 =?utf-8?B?ZFByL0hSNTZydlZVVXZtMWVmWVdsLzBmZzNVbDZWb2JVWGd6eWhIT1N5OXJa?=
 =?utf-8?B?U1d6Qk0xQitndEZvVVBnSG1FeWxmb3ozSVZ2M2lQNFV0SmRSMXQ4NURYQ3p3?=
 =?utf-8?B?cURwa0xWbUpBdkVWWDlwSnZiM0lidVJ2bWhMdXVQeGFYU0lKZ3RsYmN5bUFn?=
 =?utf-8?B?VWNabjBYV0lOZmJaWWhrczA2MmVXUXVoUktEcUhnd2swdkZ0VWJWUkkrenV4?=
 =?utf-8?B?aVVYV252aVhJcHdYOERyaDdncFJBTEVQKzBhSXFrTEpMZHh2bks4V3VhekZO?=
 =?utf-8?B?YTBjdC9LMlI2SDdZa0h2UlByUDVwd3J0OEkyT2lhbFdicEx2M3M0Zjh4SjhV?=
 =?utf-8?B?djQzTnRwS3RwN0J0aWpZMXhQSjY3NEpiK05tejNBaXM2cE9VZmlxUGZkY1N3?=
 =?utf-8?B?UFhLMWJIZ0hIMDg4V1FPTnFIK1lsRHpQRUxNTXB5QmM5M2U3MWp0QkNBclZj?=
 =?utf-8?B?SFdER1NpVDZKbHFLa0hhQ2lqRjNWaGlQR0hoNGY1V2FRVE5kMFBmVlNsNlBk?=
 =?utf-8?B?SzBaSTlaeXN4T3NsaXVjWjcvcWcrak9YMHIvbWxGcGI3VEFtOThzTHZQUml2?=
 =?utf-8?B?enNqUzgzQ3orQml6ekZFVC9lbzhFemhINjNVQW1kN1BMUHN6dnViaFpQMGh3?=
 =?utf-8?B?d25BWHV5VjZYRFp2bEJPckorSVYvY1NackxaeWdrc2c0S0g0SDdLZ0xJM3h4?=
 =?utf-8?B?NE50Snc5NXhEQWQzN1N2L09zT2ZicjNOSXFIejBIdTFFdXFFejQ2MkFrKzRU?=
 =?utf-8?B?ZVQ3UE9uempiZGw0Q1VDQW9VbzRaZHVrVFBPYzRBT3Bod2NzNTdib0pwTUcr?=
 =?utf-8?B?NGdmclByc29Cd3Q3VnY3cjlxRXdOVkJ0QjBVcFhyQ2QzOC9QUzZGODBhc3Vm?=
 =?utf-8?B?SHQwWUtTcGJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:22:52.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17049a39-9f45-43bc-ee40-08ddeeb0e779
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5568


On 26/08/25 12:37 pm, Dev Jain wrote:
> This patchset ensures that the number of hugepages is correctly set in the
> system so that the uffd-stress test does not fail due to the racy nature of
> the test. Patch 1 corrects the hugepage constraint in the run_vmtests.sh
> script, whereas patch 2 corrects the constraint in the test itself.
>
> Dev Jain (2):
>    selftests/mm/uffd-stress: Make test operate on less hugetlb memory
>    selftests/mm/uffd-stress: Stricten constraint on free hugepages before
>      the test
>
>   tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>   tools/testing/selftests/mm/uffd-stress.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Hi Andrew,

I wanted to make a v2 of this series to replace 10 with min(32, nrcpus - 1)
(see computation of nr_parallel in uffd-stress.c) but I see that it has
been pulled into mm-new, and on top of that, the following patch makes
things complicated to just revert my commits in mm-new and make v2 on top of that -
https://lore.kernel.org/all/20250830033424.8C44FC4CEF0@smtp.kernel.org/

So shall I just send a new separate patch based off mm-new?


