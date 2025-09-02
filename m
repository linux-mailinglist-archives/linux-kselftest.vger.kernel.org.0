Return-Path: <linux-kselftest+bounces-40616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D420B40926
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA16D3B66FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E5321F32;
	Tue,  2 Sep 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qvOiUZhV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566E30E0F1
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827566; cv=fail; b=nRKeWNI5YhxJ1F0m+6V2WjCmUrrjHcE7AQLBbuFHDwfotlDtnN9Id7uWtE/tobiTWIT6V618hUZgZaBBK5VqLCPUUfA7uZXGbVC5Wf4OZpfAT1JO8uFGLnyFnqxpB9Uj3Wf7ueH98IDdZUNCkyomYdfaB9vc9uTKsPouTCsf/zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827566; c=relaxed/simple;
	bh=/HZQOv++ZeRrKfRdHq8TAcvkW7SJr94XAkJYRdAP9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxlXxIdPverL+xJv0BOkuwpVGPY9Yip9F5y+IF88GtnYEzTZHNC3kPvlVutviG3ll5NL+pDHz8pIwV3cDtHhAfs2SOdrhsCqWqTcO0i/sJhXVZJVd7IEQxtr30pcmLMFTX5L0IZ7yvQYkLWfC98TgdqpfhNO/S04BeTtQNNShAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qvOiUZhV; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evisZp6KsWZm5BbIWjjtdUppPKG4L1WbzEViznh7LVruOzht53WhM7ukk/kftqYA7Bq5vWkxHlLi0lLxBJcQyhKsqu+7yIvnRON/ANQxTyCk1CQEQMLp2M0UYp19yCUfIWCFTtKpaDGxh/7LNhQg95zxKDr+IKkgyOZvmGLEGdH9b/QkfgVE0Hiz0B41fRhVH85FEUQM8hn6G55J852yKAPzMdpHrN9l9HGjLLz5nQjLJ+7fFBSEc9/5bGqDHCjjNwXkE85ePYvzE6BrnbBRc8CdtcyY9EeM0IV8igTjSTtUS9101spmXj7t2thjF5T5eFYAkR+PjRy/DM362vzUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkssSDwJdXxM1RCMRlGCgg/BtkAewQQUto582LohBgI=;
 b=KSYFhJQuJSaXpVjqsXMPgYq0iZC77J884RAI7+B44KwWGkdHRTIZahWKF0zUUMEyPtivfYp2SGF9oF5H2ZM5fWOKAe7VihM1rNMzlOjaQhqWe3M8U6CGtZ02+1hSDco7hqXY1DnJoiccZU+YhJocP5kA3j31X3hi+OAJmBTwinFJFcbqXzhECvNmoht0S0j7RIGUg9O2+S2usLAb+LTLqaQpwPpv+Z9lU3NxXXhc9mKHzdFyHhzyzmirm2ch6jGDicSFObN5YGe5ISlAMz3t1+sLeJyGYihyGtafDM9ocG1j8wpOECgsKvDhduNV31sc/ReuRrcl56L5uiz+80fm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkssSDwJdXxM1RCMRlGCgg/BtkAewQQUto582LohBgI=;
 b=qvOiUZhVgiU6p0257S83PZL9Gr06U08o3lLDjbH1LTKiviNmZdzPZf/suaOeq1QlUqz0Y+lx5R1t0FOxaPXvfBopISSvBcB8YX0lowh+IXjP8t8IuFmoHVPejRrCx8jjB1ZYY9PkNu826J01uOrChmy6dcgSFGBnCXUCxKC0hUNLC7uIpJA0Vdbc/dGbOMF3VG6DljLIwVv0OP3yVT3UtFIbXFttlB6PjcUVeJRidyR9/q5sBLIqy+7MjEGyIZQczNKTCTlYxUj86TgGxnqPotCUeXjrR5j3Bs0wmN/GVulDTPGvY6ba7bqSAPLbwFfXZZg2HDmWf4DO5jvbZIbvlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 15:39:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 15:39:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Date: Tue, 02 Sep 2025 11:39:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0E949D81-CE31-430E-8516-0AE921032A3D@nvidia.com>
In-Reply-To: <1d7e9c30-343e-41c4-814d-f6254b042509@redhat.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <27A308FD-C7D8-4C65-90BA-9B1DC117B014@nvidia.com>
 <1d7e9c30-343e-41c4-814d-f6254b042509@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR20CA0052.namprd20.prod.outlook.com
 (2603:10b6:208:235::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: eb880dc0-f670-4523-cfee-08ddea36e22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFRmZGJGcXlMbzZnaThuS1JrY1dEVnAwc1lDUnhtRkVFc0oxbmx6am9pd1Zj?=
 =?utf-8?B?cVB6MWNOMGY0djN2bnVRR2M1TzR2eGpieU9zOVRPTXhLN2dmOU5BZVNnTGI4?=
 =?utf-8?B?RmNRY210L0JvQ0R3czlDYmI5alhNZnNaSURTcGdZRjlzYXE1ZFNtc0x0UXFw?=
 =?utf-8?B?VGJXTzJ1SjEwQitwbWNrNGVOTEJ4cmRnNU80aHg0Y2ZoT25lem5yT1NFclFS?=
 =?utf-8?B?YnB1aVdKUTdXNHdlcytyMlhCZlppZDFGNklhTGU4emNWZVY0MURhNTU0d2dY?=
 =?utf-8?B?Zk9vT1dkWE5BaTh6NVNOZ1B3QTRlZ2trZzA4bnhWYWw2TmVGOWIwNkpMYXBl?=
 =?utf-8?B?dmg2VU0xa052NTRZNGVaSWgwNEUwRlNyeEI1UGFDVkhveVFmdEx3eGNTOVp2?=
 =?utf-8?B?VFhkUjFpK2VraXk1ZWhEY21kdzJLNFBsMTI1WkRJbE8xQ1h0ZEphendVNHRE?=
 =?utf-8?B?TDRMaVd6cm5WNEJPWmdXMjRTSCt1dVcwaEdOY0taT212Y3Mvb2FtbkZIMk5Q?=
 =?utf-8?B?VzhQTURvbXJNM21iTmFGaElzTW9DRDNPNXJZZWxremRLM2JHSUxEWFFVZmNV?=
 =?utf-8?B?NVBuTmpUTFR2blh0dUtDUFlqNXpkZDUzWDZqMjduK3JYMWY5aTZCU21wc0tj?=
 =?utf-8?B?czZkUUM5aTd6bU93S01nSUtxQTEzSEw0OXlQUjFMK3VCK3gvN09aa3BGZ2tN?=
 =?utf-8?B?aDZvMFBtWXBDSzdpRWF6NzhWV2FLMjNVUWE2cHMySGlHN1NCVzgvWG9jU2pI?=
 =?utf-8?B?TVhMRmZTelFCVERLZnd3RGFlUDBGZ1RseHlsWDBNZ01NK21LaXdKN2x5bS9h?=
 =?utf-8?B?ZnJaRHdHRUQ5NE5Hd3J5WGVuWUFZRmN6WVJ2ODlvNjVvcXlWYTVCYlZ6Szha?=
 =?utf-8?B?SzNtYnIrMGowM2xERGVjWXM4cnQyYjJ1NWpxa3RyRVV1bE1nZ2NnOWtFYWxF?=
 =?utf-8?B?YTNhUW9lZUQ1WC9kVDNCc0pIQ3FUMUx0OHExcXQ3OTJWaE5Keitlell2NFdD?=
 =?utf-8?B?dnROQ2JQNDN4VGhWOHZ2K2tTODNhTjVKeXNia25uUnBlM1ZONG5PK0tDd3ds?=
 =?utf-8?B?ZHdnWFNGdURiMkVxRzIzTDVrNGpUbDd2VXFYRHdWaTN2T1Z1TEhqOXBKazN5?=
 =?utf-8?B?Zlg0UlNRdlNBVnhBeG91dlpsbVRteXdBOGRxcWdMOTVzWndIY1FCTDdwOXRZ?=
 =?utf-8?B?OExQYUJqeVVVUVZZMVFvZzFCVkxsL280UUFzUWw4Q2dtZ0hBY0h5c0tveFFY?=
 =?utf-8?B?UHE5R1BWRUtkTW90OUJEOTAvaEJtM1VuaHRYSXl2WTAwNGpoYTVTbnFpay9R?=
 =?utf-8?B?WGY2a096L1VheVh2UXhJbk9iZ1EybUwyb3BzL3NtcXRaUzBJSmFma28xNmdL?=
 =?utf-8?B?SDZPbzZHU1VGL0dFRGNlQXNzWjJ4Tms2VERRZ3BLZE9ZbVl3ODRyYWZrYThT?=
 =?utf-8?B?WERXVHpzYXd2dmVhTlBSNFp5S0R0cVduUEN1ayt5SDcwd2Q4c3lPTzNxQmk4?=
 =?utf-8?B?dlpoQkhYZHl0LzhralRhTG96RmJVY2NJM1ZFNTJocXVva1JXb1EwTi9QTDVM?=
 =?utf-8?B?aVNBSG05WlBrWE16aVFaMDRmR3dLSnJXU0kyV2ZxTlhRMTNJN1FnYUE3U2hp?=
 =?utf-8?B?d1EwYjFuL0ROSkc1dXByRHM2MUs4eHFLRXQxbnlrVmpOSjg1MkM1Z0NrNlBD?=
 =?utf-8?B?L0RjTUp6RUJqenN5QW83bEtIZndhYkNlTi94dndrRFo5eVROYUZtR3dyYytZ?=
 =?utf-8?B?V0ZNd09YNklIUVpkb1o5eVc0MlgrQVdJclpKWDVoUUxXbXBNWFFKcFdkcE9h?=
 =?utf-8?B?bU5mK2tRamEwTUlDcjJwRXJoTkVFUzk5MjhFNkdldmg0d0pyM1ZIV3RyNnRq?=
 =?utf-8?B?RUxGV3FnS1lQM2ZvOVlqTG4rZHdtbTRESE5CYXdUWHVZRklZMmVhNXc1a0Vz?=
 =?utf-8?Q?VcpRshjczSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckkycWZMY1FsQlBoMXRxSHhHMVhjTHpRcnlOU3MyODJzczNyWWgzcE5od1Vq?=
 =?utf-8?B?SEtXd1IyWEc1VzVtaDVteTFaNXZ0TzRIbGc2TzJWMUcxYnpoQnZ2R29CVnYz?=
 =?utf-8?B?NXJ4NGNhbGU1SEtuM3FTWW00bnlya0xncGdsSGRKTnRLMkU0MWsxV0hIOVFs?=
 =?utf-8?B?bTlGTTJiVzZDc2dnTWlxY0RqY1NKR1p6NTI4aXlLYmlvL3dOR2JMdXp1azhR?=
 =?utf-8?B?YzM1dUtLYjB6cDM3VWlZSjBIOXFCdk4rY2w2YVFYTUdyUzdoQVZ6c28yekJG?=
 =?utf-8?B?YXdpbkNicjA1RjdIZFVKdXJ1QW54bGNJYjBvejZlZkhad01DamxuNWtFZGN0?=
 =?utf-8?B?UmhEd05QOGhZUlJ6UzNGZUpWQ0dsaXQ5ZjdkOFh6Vm9hTXRCVjZJRkNLNEZa?=
 =?utf-8?B?cDcwL25Fb01KNXFMcTUySGlBcnpXcDc4YWIxY2lOQVJQd1NycFQ1elRSOWtD?=
 =?utf-8?B?c0hLYU5EY2QyTjJsempGM0VrNW9hYXZVNFE5WFRGbU5GcndvYTZMdHFqbHBC?=
 =?utf-8?B?ZmZEWFA4RW5kbmRsTU9JSitGWE9qSStXMDMrS2tYaGN5NU5xUHozSVI3YTJO?=
 =?utf-8?B?cTRWR3FBSlRLemxLbG85UWgyMzJsMTUvUTVUSWxWbVUxanBLVE5paUY5ZkJv?=
 =?utf-8?B?bEExb2xtSVdkcGtzK1g2VHVBbkhzM2ZuU3RhdVl3b2VzRHJPdS9QQk1ieGNS?=
 =?utf-8?B?NzZUSmFpTGkwT2d3N2pXdjMxd0FPRDAwWk94ODVtZDJmVlRoczJ0SXQ2TTZM?=
 =?utf-8?B?SE43allXVm1udGRGVjNZc2VqMVpxZmJvSW5PZTFxSkxtcS9VNFYzMk0vZkpq?=
 =?utf-8?B?MTJGNGFKeXlPU3lRRzBBb0ZGWTdhZEhPeXJaREN0OEtvNXF0dVJ6NEJRN1RU?=
 =?utf-8?B?aVpWVmthRjdQbXJET2RnUldOMGk1ZDAzT1B2RGsyb1dIcHA5ZFhGTkhCNW1I?=
 =?utf-8?B?Snl0cWJoSkJGU20vSlRsL1hsekNHcTBXcjhSSjRnb0xKN0k1VXhzM0YxS3Jx?=
 =?utf-8?B?emdVQkxhU0FIUXFFQ0FkenV3Y29xdEdKK3oxZWlLY0FKbmsyZnpVakZBRFIy?=
 =?utf-8?B?YkwycUlleUFGSkF3R1h0WTBCTXIyWXJHT2hnVGg4SjkweVBwZzV1SlJ4a1BD?=
 =?utf-8?B?dFdUcExRS3VDY0NMVWU0LzJ2MUlyVzN4Vlp5RWd6bUprWmUzWGRVS0xjR2lZ?=
 =?utf-8?B?UW12d1VBaFlXWjNFQ0d5VFluL21ZWExSMXZiNEpoeTdpT01qZGZwc2NIRzNQ?=
 =?utf-8?B?TWVTTDdtUGZpOGlTZTlncG5rVS91SC9waVo4dmgzY1ZBMCtUWDR6eW9jVExz?=
 =?utf-8?B?R1graXZ4OEd1MWFBS2twQjJxY2MrZ1BGRlEvYWFGb2YvUC8vdUU0UnFxUUtP?=
 =?utf-8?B?ZVhqTTFHZGVjVUh3TlYvT1JmNXZsYnp2TUdFaGJnZk9PMEJ4QUJneHZxQnMz?=
 =?utf-8?B?QTUyRE1lczR3ZHJFbmJZYmlscEhZQm9PWW5VT09TM3FqVVdUUUxrU2MzVjl2?=
 =?utf-8?B?enptTjZCQTVKem8xQTh3ZmZ1bTZsWUxTUzNRejFQQ3ZEN0lVbVoxWHdMc3ZY?=
 =?utf-8?B?WHZiT2dYc0NSWDZjZGFiTmNwekRIYzdLVVB3KzhBTWY1TDJZa1lyQ2xXaGF3?=
 =?utf-8?B?WlE1bDVJb2E1MlRycDhucmJ4RUJVVERFL3F4aHVHRU5SLzY5c09lVXF6TWho?=
 =?utf-8?B?NHVJS21iRU9HcmdGWjJHaW9HSVRkbzVVejF5amUvQW9VUFVOejJIdW53c3cz?=
 =?utf-8?B?bFNKUVVjY0JjQVhmRDRSdFBlcms4MnVFM3Y1NE9yWmRDZzNaODNlTjZhTXJs?=
 =?utf-8?B?WUFZcWIyc1JDWDRFZEdmUjF2M2RhTERITGFKZmZHaitnL2RTdUZLeS9FMnhG?=
 =?utf-8?B?OWttM3hXWHdtZkR3bmtwRmtOekduRTZBWG8rMTkxaUhtWWVTREN3VWRCZnJw?=
 =?utf-8?B?d3dJQmxaamhmR2U2V2M5OCtJbGNteW85OWt5QlAwWHU0SnN2L2RocU82QnhS?=
 =?utf-8?B?YkE5bTcxc1FabXp2WEpxUzNsd2lRMDlPNkpPWFJHbXNPTjBySmd2T0s0U3Bt?=
 =?utf-8?B?bFIzdVQ0S1VRUHVBT2t3OTF1UGtqSmhYVnU4c0FUK2xkT2lTN3R5SWF1elF6?=
 =?utf-8?Q?45yY3YQI/Vn9LmU4VDCNLXZFu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb880dc0-f670-4523-cfee-08ddea36e22a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:39:20.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0epf5Ibvab4A+sod0r/Kycq19iX1bTdVvHsdEO7kUdaR9qcbi0QpnPSYp2Icxtxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On 2 Sep 2025, at 11:28, David Hildenbrand wrote:

> [...]
>
>>> @@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
>>>    static void split_pte_mapped_thp(void)
>>>   {
>>> -	char *one_page, *pte_mapped, *pte_mapped2;
>>> -	size_t len =3D 4 * pmd_pagesize;
>>> -	uint64_t thp_size;
>>> +	const size_t nr_thps =3D 4;
>>> +	const size_t thp_area_size =3D nr_thps * pmd_pagesize;
>>> +	const size_t page_area_size =3D nr_thps * pagesize;
>>> +	char *thp_area, *page_area =3D NULL, *tmp;
>>>   	size_t i;
>>>   -	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>>> +	thp_area =3D mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PRO=
T_WRITE,
>>>   			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> -	if (one_page =3D=3D MAP_FAILED)
>>> -		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno))=
;
>>> +	if (thp_area =3D=3D MAP_FAILED) {
>>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errn=
o));
>>> +		goto out;
>>
>> thp_area mmap failed and out label will try to munmap MAP_FAILED, which =
is
>> (void *) -1. munmap will fail with -EINVAL.
>
> Indeed, should just be a "return;"
>
>>
>>> +	}
>>>   -	madvise(one_page, len, MADV_HUGEPAGE);
>>> +	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>>>   -	for (i =3D 0; i < len; i++)
>>> -		one_page[i] =3D (char)i;
>>> +	for (i =3D 0; i < thp_area_size; i++)
>>> +		thp_area[i] =3D (char)i;
>>>   -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>>> -		ksft_exit_fail_msg("No THP is allocated\n");
>>> +	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
>>> +		ksft_test_result_skip("Not all THPs allocated\n");
>>> +		goto out;
>>> +	}
>>>   -	/* remap the first pagesize of first THP */
>>> -	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>>> -
>>> -	/* remap the Nth pagesize of Nth THP */
>>> -	for (i =3D 1; i < 4; i++) {
>>> -		pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + pagesize * i,
>>> -				     pagesize, pagesize,
>>> -				     MREMAP_MAYMOVE|MREMAP_FIXED,
>>> -				     pte_mapped + pagesize * i);
>>> -		if (pte_mapped2 =3D=3D MAP_FAILED)
>>> -			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
>>> -	}
>>> -
>>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>>> -	thp_size =3D 0;
>>> -	for (i =3D 0; i < pagesize * 4; i++)
>>> -		if (i % pagesize =3D=3D 0 &&
>>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpagef=
lags_fd))
>>> -			thp_size++;
>>> -
>>> -	if (thp_size !=3D 4)
>>> -		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>>> -
>>> -	/* split all remapped THPs */
>>> -	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>>> -		      (uint64_t)pte_mapped + pagesize * 4, 0);
>>> -
>>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>>> -	thp_size =3D 0;
>>> -	for (i =3D 0; i < pagesize * 4; i++) {
>>> -		if (pte_mapped[i] !=3D (char)i)
>>> -			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>> +	/*
>>> +	 * To challenge spitting code, we will mremap page[x] of the
>>> +	 * thp[x] into a smaller area, and trigger the split from that
>>> +	 * smaller area. This will end up replacing the PMD mappings in
>>> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>>> +	 */
>>> +	page_area =3D mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> +	if (page_area =3D=3D MAP_FAILED) {
>>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errn=
o));
>>> +		goto out;
>>> +	}
>>>   -		if (i % pagesize =3D=3D 0 &&
>>> -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd=
))
>>> -			thp_size++;
>>> +	for (i =3D 0; i < nr_thps; i++) {
>>> +		tmp =3D mremap(thp_area + pmd_pagesize * i + pagesize * i,
>>> +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>>> +			     page_area + pagesize * i);
>>> +		if (tmp !=3D MAP_FAILED)
>>> +			continue;
>>> +		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
>>> +		goto out;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Verify that our THPs were not split yet. Note that
>>> +	 * check_huge_anon() cannot be used as it checks for PMD mappings.
>>> +	 */
>>> +	for (i =3D 0; i < nr_thps; i++) {
>>> +		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
>>> +				       pagemap_fd, kpageflags_fd))
>>> +			continue;
>>> +		ksft_test_result_fail("THP %zu missing after mremap\n", i);
>>> +		goto out;
>>>   	}
>>>   -	if (thp_size)
>>> -		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
>>> +	/* Split all THPs through the remapped pages. */
>>> +	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
>>> +		      (uint64_t)page_area + page_area_size, 0);
>>> +
>>> +	/* Corruption during mremap or split? */
>>> +	for (i =3D 0; i < page_area_size; i++) {
>>> +		if (page_area[i] =3D=3D (char)i)
>>> +			continue;
>>> +		ksft_test_result_fail("%zu byte corrupted\n", i);
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Split failed? */
>>> +	for (i =3D 0; i < nr_thps; i++) {
>>> +		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))
>> 		=09
>> page_area + i * pagesize, like Wei pointed out in another email.
>>
>>> +			continue;
>>> +		ksft_test_result_fail("THP %zu not split\n", i);
>>> +	}
>>>    	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>>> -	munmap(one_page, len);
>>> +out:
>>> +	munmap(thp_area, thp_area_size);
>>> +	if (page_area)
>>> +		munmap(page_area, page_area_size);
>>>   }
>>>    static void split_file_backed_thp(int order)
>>> --=20
>>> 2.50.1
>>
>> Otherwise, LGTM. With all the changes in this email and other email,
>> feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com> when you send it
>> out formally.
>
> Thanks!
>
> I'm currently chasing why I keep getting temporary
>
> Bail out! Some THPs are missing during mremap
>
> Already on the old test. Something doesn't work quite right as it seems.

Did you also see =E2=80=9CFailed to get folio info=E2=80=9D?

If pageflags_get() cannot read kpageflags content, is_backed_by_folio()
would not be able to detect a THP.



Best Regards,
Yan, Zi

