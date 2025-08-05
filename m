Return-Path: <linux-kselftest+bounces-38310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E12B1BA73
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 20:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE679181F06
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04C2989B4;
	Tue,  5 Aug 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbC/akw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7915ECCC;
	Tue,  5 Aug 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419720; cv=fail; b=OjBuA+9SjLVMGugJmuKp6Js2RM2O+mEAOEbm+v4h8PrvX7SicFz+Ojf3liuPPrsLxnSsKb0XmY2w34wiwe5XpkUktx8qszmEqNNkfT7mmktJ4SBmhye0jC0t1LNd/9oslJVEpN5aP9BbqoygCjV3aH/sKXWpIkQJxxaUSCivaak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419720; c=relaxed/simple;
	bh=E2LRjg5nTwk6XSthptB4tpMUvsNP6L8wiCCdOlG55H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvuq9DmMCIuUeUhMo89ogymeFwt9ZB+f3JT+xfqpY+OmHmVvm+Kf1YwvGQ16eIhdyZ7nj0QnldseqvfoWzfiR23B3jK1jmKo9ISNQNSmnK+3s+DJS5hrKzDvPHll0KyCBV6MmAecyRWVyVwjy3NB9g43J4rGONeS77nX5oen7rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbC/akw6; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJwY8p6uo/KAX7AH1K6J/2qLhgFuFcdPtLaPqtNZ4cMW9eA60OwptpbDX9uzu+Wkqy2Qb8ssf3dKXxFhkN27ftRZNBcJ67D8BuQA/TPyMHTUfGbeuKQR2gaBkdOyGpYGdtoUVh3ax0cVaRx54r09akNOiPLQe0e0qXHs2zqaknvcpZ+XgJolGYIF0Tp87YPMGmqUWiO8vT8flm6ThYR3RKKk8dSOc1j21kejvwx2aeuuHgsIwQin0+IH8mexTfevfxbiywQY6Yy+dRQGyZ/GRzb8jdDQOFqFtfgnKcqSxhbC2S7NgAmcXJFmZ/7YR+ynEyETmi2wHjVjuvMtBdDAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBUd1kPw/ZBFdVEz0v4rwbgbKzHr6VULsukf0eGMmDI=;
 b=kgFzJG9AdP3dRBt/f9M0EY1jI01nhV3619+yAQ9wtbtKt4vE/f2UjZUjZNLZaiMlIbsU8J9BIunEgNA7FWAm5R0jIegmg27hfV65+YzxcObp5lLvsUVT81nvFAnhBLdDfjlb9H9kVl76w6yxo0/vCEDMTDNpOnT6QGyizm7fdUT/4we6rhDE3Kc7rWaoMT2usqeJSwG1jQ+PvxEDFwb1IIx9vSvZURu7KOG6UgiGZA3avaV8mM3E+1O2Q5rMIU4MyI7OvrQdqxovbloyGsQMvbSsDVpi9m4uqqxLQKbZUh5ZPCFMfDXoe9qi06y1qab84BCDKJ5c/99SjX1yscI7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBUd1kPw/ZBFdVEz0v4rwbgbKzHr6VULsukf0eGMmDI=;
 b=kbC/akw68nO4MpB12E63HUohA7+7cg8Nli/4L7MlBQ6P7DOc8qG3E5eeGOT3bE03BeuJTDtg5UlbI+95gBYBIrtBEwRIlSvq/9F3tyoU/rj0y0+ixC4AqtAnO7eSoVgRDpUxTfAmlV3fHDgq/4COQ2XskXsNy0CpILViRPr2aY6kR07obqQXKSuioehjaKsu3XCMn1iZyetRXiTp8K0zGH28JAqkGUAV+p7zpTqmgW6o11TY7DviJlFHnHmUj2pof13erTHglUS8XZxSRwE4tg+aSlU8s/aVSbLnOJbULkGmldAte7tib4E2+tJqbdmONqe2vy//d9qMbz88m/e7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:48:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:48:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jann Horn <jannh@google.com>
Cc: wang lian <lianux.mm@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <ryncsn@gmail.com>,
 Liam Howlett <liam.howlett@oracle.com>, Mark Brown <broonie@kernel.org>,
 SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
Date: Tue, 05 Aug 2025 14:48:25 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <76EE266A-7E9B-484F-AF97-85A99D109005@nvidia.com>
In-Reply-To: <CAG48ez1wKqyCKZX7J2eJekTuzRshVE2btPEWQEm2hW9Ri46Uuw@mail.gmail.com>
References: <20250805175140.241656-1-ziy@nvidia.com>
 <CAG48ez1wKqyCKZX7J2eJekTuzRshVE2btPEWQEm2hW9Ri46Uuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:e8::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 2047e532-fc50-4c46-7a65-08ddd450ac88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWtEcWV6VkhkM1U5UHYwRW5CeUZ3M1NzbWk0VDdTR3ZrajZZWjdnWldIOGVa?=
 =?utf-8?B?bExkZmJoUDh1ZUNISjlwRkszbVRMUVNkTUpPaFhtOXBBMlFpSU5DV1A3VTNM?=
 =?utf-8?B?emJLbkx4ZWtvdk0zS3F6UHVxV1ViZVB0Sm5QTEFabUR2b0Y2V29HNVZmMEdl?=
 =?utf-8?B?VDJMbmw4eVZhb1RhZVE1djE0MzA4cEEzKzJCRkhKSDA3eVBlb1BrN2ZJMGVp?=
 =?utf-8?B?L1hEbmhHRE44cTdXcjZ1VjVoMWE0NTVRWTNyMTRrcG55bDlrZ2xwOVc5Nkxp?=
 =?utf-8?B?T0dmSUQxdkhSb2cvdVI3WTJhREhheko0WEhpclJ6THhCN0d4aDhtOW9QSEZr?=
 =?utf-8?B?MFBEWHZIaEkwazFhWTA4eGlLYnphcFpha20yZDBLZXl6VXVFbFUzanlWYWJK?=
 =?utf-8?B?MHFTK3hDZ0xrTmRBZUZtU3lQTzBHUjY5emI3eUY2d0ZpRWZkMDhXOXRBMnJ4?=
 =?utf-8?B?cGhYaFdTdXQxYkdvQmFtL3ozOFMzMFdjM3hDZHZ4eDlRUXlMNHcwQVM0bWV2?=
 =?utf-8?B?UTRub3ZKYkF5VjJGVzlpL3hlR1VPWWltWDkrSTNNM0RLV0VoVzFzSGdJV1FY?=
 =?utf-8?B?ODBJNENEdFo5RlZiZlE2NkJrVWdqTXpKNDJJRGNSQlRHbTVzUkRsNU5QbWxX?=
 =?utf-8?B?YmQ5YTF1YVZGa3YyeXQ2NG9sT05TWCthM1RPZGxBWnB4Tm9heXVpTHJSeVZZ?=
 =?utf-8?B?bTE4T2xoYkFaMlBlZGdXdTEranZuREpnbEJ1Ykp1S0UvSkdKcnR3RlhaVGxL?=
 =?utf-8?B?Zm5kYTUzWnVyUWNtbTBuWkZHaVI1MGFXS3MweU42aEtTdUJINHJFbDVDMTJ4?=
 =?utf-8?B?cVRsUGtIOStkdkxkN1ArTkVTOEoyM1pIQUFIY2NIekk4VW9OQStwUWNBQkhJ?=
 =?utf-8?B?ZW9abUpTbDRHRFkwNVhSYVlhMGFVSklpQVhaOEw4dkpiQXhHTHdrVWVIWkM2?=
 =?utf-8?B?WXcvaFBTcDhSZlJTenp6MXFjR09lazFubWoxZTdydWp1VmJuTkVqTTZBYVBY?=
 =?utf-8?B?Z0NPeERxcFNlSlF5Z1Z4OVBEejk1dmhvQnBCL0NNZkp5OEZjQy9EcjNVeE15?=
 =?utf-8?B?d0h2WENMbTZJeHorRjhnOGxTeU5PeUZqVmpUZWZzMGZucTE4S0d3NkovRFFP?=
 =?utf-8?B?R0xDRW1mbVUwQXF3S0gvWDRXV0cvanJpTHV5NEU5TWFKb081ZnNQQ2U4KzBJ?=
 =?utf-8?B?RVgxbmV3WUFwUzF3RWFWWGNOTnRCa2wwV2svRHlqbUpDcnVmVFFyOU5FdG0x?=
 =?utf-8?B?Um1WSkNranF4bndSN2dLbjd1Yjc2VzVqQlA0YmRua2w4WTlSS2EyaFpJQ1hI?=
 =?utf-8?B?alB0VVh3S1ZHT0luWVFacFVFQUJoUldUMExYNUhMeEh4UjVueTV4SHVrSHp2?=
 =?utf-8?B?emVQTzN6d1M0QzRSQVJHSXQ5cmM0Qno0cGtndk05YlhySEI0aXNpNTg3VnRI?=
 =?utf-8?B?N1hlRjZiU2RqZWxIeFFYV2t2azZGSUQwSys2ZWhtbk1UVjZYYXh4SFBEZWVm?=
 =?utf-8?B?VFREUHRSZGFVNWhDOExEZjJUZkFGQkh3K2d4dm1SNEZYQWp2L1VLSkRFWjRR?=
 =?utf-8?B?Qm1JVThCTVpPNG1ubWUyUjl5akIrdmZZdkI5b1U5Smw1R1ppbndESUZjNXlC?=
 =?utf-8?B?R0RNOHlhRG5hYzVTdWRKRmk4VGJ1cmxpMWhacFVLbEMzakFWQkIzTEtJczZo?=
 =?utf-8?B?cXg5STRJZEdPRlpRdzFaRnVCdGswT0I3Z0NQcnNJWDhFVUhlMFByN0lnRmYz?=
 =?utf-8?B?T2Y4L1F3RG1ZUTY1cEFhcWl0NUFjdW12TGxubEpBcXVRdVBCdXhjQlNRSFBY?=
 =?utf-8?B?SW4rKzhDOHNIeHdCdGlwOFdnQTIxOVo1VlZIQ1p6VFMvdkZJcVZkaVRzSTY0?=
 =?utf-8?B?b0IzbWtLc3VyZUp4ZmdGc0QzbkgzR3RZRTdFSHJsWnBLbnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2tLSVFCMXBaM0R4eXRWbG9Eb1RVV0VBTnVSa1ViaDdmMTVGdEcxSGtqbVFw?=
 =?utf-8?B?TEk0SE5HdEpXdDdPYTJJVHJzRTUvN0NLaTR5QXZFNXRWSlozZ3dzVmRmeUVB?=
 =?utf-8?B?RHY1eEVWV3MrUXZIczM3UDgyMCtZSm9BRFBxUkhPWlNKK3NxS1pXSGRQakR1?=
 =?utf-8?B?Z2FlOVZKK0Vsci92c0VrTjQ4OWdBQStpT1VGcmJaYUlmemVYV0JtcCs5MUVh?=
 =?utf-8?B?dUJhQktCNTU4bDVsREhkNWVIaWdNcjN4VloxdWtRMkJ6ekpIN2N1c216aFBy?=
 =?utf-8?B?YlBPT2ZKVnh4di9zanp6R3YwcW1maHlNZWRRQ2ZRRXF3Y1hqSEJxY1BqRVBs?=
 =?utf-8?B?ZGEzQ1hLeUlzOXZCaFdSSXVRTS8vamFnS0lNSjM5OHE5K2prUmpOM0lBcnd3?=
 =?utf-8?B?cWFsRUJGN3NQSXUySHR2YWRzWUJJOW1PcmlXeUQ4eXdwdGRBRTdzVElZRHVI?=
 =?utf-8?B?a0lteTMwcVExTDN2QUJvWmNTOVlBYk9WNlBGVjNKVFRFM2VOVlRGRFBIMjNp?=
 =?utf-8?B?cldITXo3RUt0ZndJUkYraDhaK2JFWmEvVlNuM1gvRGJiRFRwMDJYNkRQdjM2?=
 =?utf-8?B?UUdoSkJZTUZ5eGUwSHNRTWUyOGdaUzZKWkJBQmE4eVFBTTYyNEdYc1Jxcnpv?=
 =?utf-8?B?T1Ard3AvbnhNQTBZTTd5NDFsTjIzTjJZd2VOQVZRc2NRaE12ME01VitYVUlh?=
 =?utf-8?B?bkU2bmphTFo0S2tTanVTYVlQNkNub3hWeUVidHhuQldMVXorMlN1NVM0SENv?=
 =?utf-8?B?MTUxdldIRGZJKzgwb3ZyZmtQWWdaMDRNVHBEVTJpWElneW5pb3R0cUVTZVN2?=
 =?utf-8?B?bGU5Ri9IdVExUUN5OGxXd21Dd25oZEsyNFlGNUQxRXd4YXlTWDdkSVdzaEdu?=
 =?utf-8?B?ZVpNemxrenM5eDJLRGkxd1luaEtmb0pydmZ3S1dMSEJEV0dnVjRocGd4aWFn?=
 =?utf-8?B?b0JXVDNsVU1XeDRvKzJnZ1dDTkkxM3FwelBZaVBlOE9ZMmJRUmtvUkhUajZN?=
 =?utf-8?B?L0F1bXpMTVNMbkJSRnpPMnJHNzVEbnI2aXJnSXo1L0xVU3BWYnZGNm5kTGtp?=
 =?utf-8?B?cFBKVlZYSlFFb2NsU0FIUkpJSDdYdm5WVmZ2d2lZV0NwKytmZWxxellwY0tW?=
 =?utf-8?B?dkZCWGZyOHFWZkhuUDBpaXpyZHhydlZ2WHo1eGRDaHR0d1Y0a0lpays3d3pB?=
 =?utf-8?B?cWhybUtkQVBUZlJEck92MDZZM0lsdkFZNTZWVFUxMFpGT0c0RzNpaklEYTZY?=
 =?utf-8?B?VkdVS1VvU05wWnZaK3NTbmVIMVhZcGlkVzNzanEvUU9FTC9MK2lkZkhFTnpk?=
 =?utf-8?B?VklnRkFnU2pKTDdXSmYveXJKT0I0Y1o3Z3BtMjBOM1lPZkR6Z1dndjg5Ynow?=
 =?utf-8?B?REVMNm0rTVdyZHFkVGF2dG1uc0hzOGhXR1htU2V6TzZCa1NsRUZzYmwzQklm?=
 =?utf-8?B?WVVPNXpzZ0tQK3pJQysvcXpPaTkzWHBscmdRUG5LZnNCQ2N0a1p4SGllZXlm?=
 =?utf-8?B?Rmo4SVptODRtV0FMczB4NWU1MHpyUHptZzV3TWZQNDY4aTJ6QVhzMHRiZTJH?=
 =?utf-8?B?MHpwSnk2b0ZvaXBnOHBJMDZVSXJzZmEvckZhZWUvTGd0SVA1Wml0Z3Jwc1NL?=
 =?utf-8?B?RWxYSG5FMDFRZmJnSUE1aGRlVXUvTExZOTdnZUJTNldSNWJLSnFBR0RVZ1pO?=
 =?utf-8?B?eUxKNXlySTFrbXY0Qzk0cUVOT2FBSWFXTG10SE54M2JpMlZlOW15WWd4UUxu?=
 =?utf-8?B?YW1NdVVTMy9CSm9TeDM3clBVaXBYbVZ1N01WNFoyVExHUnJuL0xIQWVCeG1p?=
 =?utf-8?B?SVlORUJOUDhWQ0xaTnRjT2ZKWlJjSVB6WnJ0a3lKTDJ6Y0ZLSStGdlI0MFFq?=
 =?utf-8?B?dnF0UnFsZ29Jc1E3d2c1T3RwL3VjZVZoT1l6V2hveFNwbGF1QXRuQXczZHVa?=
 =?utf-8?B?WmN0ZStkWGNNd3l0OFBCcER0YzhVbnlXWGovc2pkZDcxdk90MkhwdFhlOVI5?=
 =?utf-8?B?elppQ2drUnU1WjNhQ2M1VFBsYXpEL2NnOVpyM1NaSUNIN3h0cUZUN3YrVW1K?=
 =?utf-8?B?b1dDTit4bjN3cDFUZDk1NWFFK1NrVGQ1bXh4dWZ4RmE0eFZHTml2SUs1WkJi?=
 =?utf-8?Q?GWWMiWUK7RbLVaPQIl1WuZ/cz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2047e532-fc50-4c46-7a65-08ddd450ac88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:48:31.4992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB3FUCWDeAUXj1nYqRJdYBB2xVdWWlZz576zsbWKtZryKxihDicXD3kP6UWWtiRx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

On 5 Aug 2025, at 14:38, Jann Horn wrote:

> On Tue, Aug 5, 2025 at 7:51=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>> FORCE_READ() converts input value x to its pointer type then reads from
>> address x. This is wrong. If x is a non-pointer, it would be caught it
>> easily. But all FORCE_READ() callers are trying to read from a pointer a=
nd
>> FORCE_READ() basically reads a pointer to a pointer instead of the origi=
nal
>> typed pointer. Almost no access violation was found, except the one from
>> split_huge_page_test.
> [...]
>> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selfte=
sts/mm/vm_util.h
>> index c20298ae98ea..b55d1809debc 100644
>> --- a/tools/testing/selftests/mm/vm_util.h
>> +++ b/tools/testing/selftests/mm/vm_util.h
>> @@ -23,7 +23,7 @@
>>   * anything with it in order to trigger a read page fault. We therefore=
 must use
>>   * volatile to stop the compiler from optimising this away.
>>   */
>> -#define FORCE_READ(x) (*(volatile typeof(x) *)x)
>> +#define FORCE_READ(x) (*(const volatile typeof(x) *)&(x))
>
> So is the problem with the old code basically that it should have been
> something like
>
> #define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))
>
> to actually cast the normal pointer to a volatile pointer?

Yeah. That works too. I would rename it to FORCE_READ_PTR to avoid
misuse. :)

Best Regards,
Yan, Zi

