Return-Path: <linux-kselftest+bounces-11430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD5900BC8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88831C21EC7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBF4D9F6;
	Fri,  7 Jun 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QkENxxOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763720328;
	Fri,  7 Jun 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784191; cv=fail; b=DYaaGuCL1AmodJk+QAPdwoEW85yyJAcPh+yWKqN85XZzB5kgQFDyF/N7PLWr3vvvydN9kK+ENCtV6DNOnVNgwayLKoawcYf/sVnhWtAYmqZMzu0i8k+LtGhX4Bd96C9r+f1fMO/6dq5+W9n1B2kwwxPjleiJGN6Z2wnPt1lHnGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784191; c=relaxed/simple;
	bh=T5lhnNvOrFPfmAMsXy80BC2J5vC9JxMVmB9SEbrczmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPGfPVGND+xT2tDXyFNjx67uLfp871SYzdU20rohMU3MpNKHsxw8C4jLXKNKwmU7jgbyJHpdi5dSPWABYxdezOq+WtMGEyWXpFqcBD6/6DEyUWQMEVYwRa2mt1zkM4Ex/R1leCUrdk6LhX3biYOWG2Mcoz9xnkAs3kQ7QNMp2oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QkENxxOC; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8WfoI0EKQmX8oWPxMkzkVXq7IaZEUsr5MFugQ9/8oyvp8JeHu6kTLNKkYUUMKbcVsXRgV69oJR/rl9ncz773oivXfpEmarZ43/yyp8+A5MS9W1qZKGE9FQNd2p2gAs3rKm7rygjSirbnasT3CF+tEpEE1FE/n8gU6Ci7UX532Tx0bkwNXi2Yke9qGv06BZvIdEwq2EuwEXvOh3jZNfWkSJ5tC2kItWe8l6di2bBeWZcnRFeQrEEGXrEA1cZCp3ag7G2FE64E29cgxCoHpXFptbTBtnA4u01E/0T4pRYjyV3MZ6vyddOWODbU7nrVnk+edcsO/zCadVz5oawEEqqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOOE6HdnQBLhTZpa3Vk7TnC/Gp3iJOqiPVpEylBg724=;
 b=PV4kyJPFiEMG2QUrJftVzjBMFp3BMotm6trZDPM1k7G8lzzln15Ubp6jTYqY0NMzK698+O/l4GtTHx/SfFCRfxh+YVTXJRDUJzDFYqMjepsxeJEulytrKWdgg/beS813Bbci0Ik2ksrXZzadsWVbRrHMlORi1BNxpBzj5NoFBvBLxSAkqCBH7FPvftGTuO8eBiOBZaGyxAdGs2Kimbem44qu4kS9QIuu7OV+agYQSA3llHSfeaD55BKzrTFt4s6YpoWfJ9VpmMnWGCqWloZBYEcosluwdd36EbhKrWu7WfPrlahwTW5vBl06CNSE5CdngtmN2Czoy9B7ShItGaKXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOOE6HdnQBLhTZpa3Vk7TnC/Gp3iJOqiPVpEylBg724=;
 b=QkENxxOCN+ALSQNhAJcQxsxPTM3OsAMuDvPlR/HlxNrPIXfIy/X1KrjE6X2PYquRaSThQ9eRhHIuEexpr6DFuBq2mwMC6YNBp6yU3luFyN4kxzz+EoxkR8qco2lL9SVqSFRGUjrtJ+VCnkGh62/FPPeNC+qqSqMxbTQPoCxf0LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.34; Fri, 7 Jun
 2024 18:16:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 18:16:25 +0000
Message-ID: <edc31538-3aa1-a35a-ea67-b13f626a84ec@amd.com>
Date: Fri, 7 Jun 2024 13:16:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
 <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
 <8553ddc2-ee0f-447d-8fe4-5a7dd84375f2@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <8553ddc2-ee0f-447d-8fe4-5a7dd84375f2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4098a2e6-ced5-4bc9-c9e7-08dc871df11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VldvTGQ3cmdrMEdvZlV4b21QYnFHbEtkNkNtM3pLK2xuMlA1ZGc1RDVubk1t?=
 =?utf-8?B?RytVMXJtQlh5M3dpTzU4K0VzSGNBOC9odWdVUUZnbFpIaVViaDVuZDRSOFlI?=
 =?utf-8?B?ck52OEVDOWJMckt0QmMzZnROUzhESHpWODAvR2hSMjFDZk5zZjJiYW5yNVB6?=
 =?utf-8?B?elBVRG9PMjNWeDBVWVhSTUpzcE83cWU2YjJscjR6OVY5cCs5a3dqaXhVNWF0?=
 =?utf-8?B?bllZM09CVGx5OElIVlRUMWFCcnJ3cnBNWEFXcHd1ckxZKzF3Y0FuZ1RqUm9t?=
 =?utf-8?B?MVhqVkU5NHRDVFpJdkZjSmJoN1dSQlpjT2E1WHpvZXZhMU91VlM3SHA1R3Bo?=
 =?utf-8?B?d0RKM0RkOEN0bkFnbFRlcUVBVEY5WG1HOFJIajB2RWRtOS9pOHB0aUxJOEdQ?=
 =?utf-8?B?akNDYjVqTUE3QUxsNFFVQ0VSbHpiNWZOYnBaNS8vZHVZc1dSVm93SGFaenpZ?=
 =?utf-8?B?bG9hVmNrUG12MDdOakVyMG00NUJmZFB0dStVTnA4SGJ0c0xaZ0RmNDloT0c5?=
 =?utf-8?B?OFByT1p0bnlnODdlS3YrNngvelFocU92dC9YQklobTZneGltRWVBdEdRTmxV?=
 =?utf-8?B?V25LdHZXWGd5dnY3N1BHT3V5bEVYVEQyQ1RTeUVqYW5KaVFtbE5NN202TTZF?=
 =?utf-8?B?OEEzN0ozNFUrZEdIZ2JPUkUyTVlyNm5hQ3c2OHdYcHVrQkZ1aUxINmkzTjBs?=
 =?utf-8?B?N0k5WkoraXJJblB2MS8vUnlqMWd3bjhzRE1JNmtsMTZQWDRnWThWK0dRY092?=
 =?utf-8?B?Z25CTndUVHNvSlFINGN1MXVRWlVCeG5IeHBKbmRwRXV3R2oxRnMvekRSaHpC?=
 =?utf-8?B?UVhOQlREeGpleDVjRnUvTS9Eem5Uc1ZuSkY1M2Q1RjM2bmp6cXliMDFxMnpj?=
 =?utf-8?B?bE9LVUdqbEJtdG5EZTc2YXBWcktGTVNic0M4eGk2ZUZzdk1kd0xoRVBJZWJH?=
 =?utf-8?B?UzY1cWJCNXBXZkFjbTR5U0NERGxkOGhpRFFQM1ZKL2lZbkp1alFES0pMcTB0?=
 =?utf-8?B?S2hXMGFkL1Job0NqUis0QmlJV0xxWjVrU0F6ZktXaFJ5NmNNVUh3cnlycDd6?=
 =?utf-8?B?Y0czUWh2NXAzRXRRQ3JweEtSdDFnY1hYWlJSbXZKZHZPRWZXZDBXTnpSTENO?=
 =?utf-8?B?UlVHa1g0b2VXRGYxTzRrTEV2a3hQcCs0cndlZXFkNE0rZ1dxM2FzME4rRGM1?=
 =?utf-8?B?NGJCbEJNVDNjQU9NNDNHd3hGaGdnMTVjWFU2UXQ5MnhwMnBwVXVBL2Q3eER6?=
 =?utf-8?B?aE9MYUFaaHZHSkNpcmNMUG04WUdDRExUV1EwWnoyZ0JSMkY3M1ZlTUlCeVZR?=
 =?utf-8?B?RTUrMkxwQnBweXROaFVyRUtRQU1ZRHpvYTkyTER3QUFJOVRDRFhvbDV6VGpI?=
 =?utf-8?B?WEdBYmxKc2pveFV2V2ZDdFhVSnRoS29BSnlPc3hZa2tNeXhjdHRqY2xCWVM3?=
 =?utf-8?B?U3VZUUwxZDZPOFUxdFdjSk41YndOWU5OTTBsZzk0bWxLQ01SbVdOZlgxdytr?=
 =?utf-8?B?d2tYT20zN0FaZ3FHUXJhcno2dlV5cmZNQklvTG5FRW9jUlgzYWpjSlN3NG5T?=
 =?utf-8?B?a0JYbnk1aFVKUUxSa1NZSlJtOStBWmNzQUxMNVkrTUx6K3BDQjNHbk1ubVZL?=
 =?utf-8?B?VFB2V3JrS2kzdDg4aXdCK25xTUdwQjdnNHNRUEk0RTZRSnVlSHkxSnc5OSsr?=
 =?utf-8?B?TWZwQ2F4TDdLL0xUaGlYRkZiVjhJSWYzMDJ4SkJlaDZDUmJmOWF3ckNid0do?=
 =?utf-8?Q?+oKBDhgPynd8I9oPzB8gi7tEj1ngf+xiDV2l0d/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3lqdElwM0pYSlJMTFJPRit5WlhqNzNHVlltUUs5ckJ6NDZJcHpvTklmWUQ1?=
 =?utf-8?B?cStzN1Z1UTdiRDBiZmdVN3l3emt3WnJuSnpXOStUS2Jya1lxTitrOTVzaE5V?=
 =?utf-8?B?eEtRbFNGSG9FcVNoRmlCMDlQSm1YeFUrelBkMUlFR0MyOTNVcGplczJFenNo?=
 =?utf-8?B?NzBJUk5QVGM1UjdrcjVVM0VKM05RTVZEcEJXUGJ5Tis3VW9tRUU2cWg5dlRq?=
 =?utf-8?B?WHg0dHZLRm80eG1kNGt6ZURydlVZRDdXNGV6Skh3LzBKYnh0a3l5QVVDbk5W?=
 =?utf-8?B?L25MOXNTejdhb2pqeE05VW9CeTg5MTE5NGg1K09TOFM4TE0xUHprWlZST3cz?=
 =?utf-8?B?S1ZKNXRKcE5lR2FyWjJFUG1NSjMzOFJwblpWQWZ5OXBHMWFWR3RaYU5UejY4?=
 =?utf-8?B?eHlXWGZjRW1SaXUxbVo1VXZDb2dKQnJpemhzTWs5ZXd5alJuMElGOE1sTXVD?=
 =?utf-8?B?cUR6MFZnUG1HcTNaQzhQelh2cEUwWVM2aWJSYnZ6QzkwdXB6VmxJYTdkSjgr?=
 =?utf-8?B?L05hS0dqRHFpUTFsMUNQK05Jd2Vac3dicGROV3I3NElNRXpMSjNqTHRkcHpN?=
 =?utf-8?B?WDluM1NMYy9HZTdsTHVmV3Z3NGQ2eUZiMXRwckpvUTJmclNWeTh2dSs4Wm9j?=
 =?utf-8?B?R3JPckM2UUhQWTNEYmNkWUFUTUVQTy8yZ1F0blhCL2JiT1BrU0hlTTh0eHR0?=
 =?utf-8?B?RmlpbWZXVTlmSjZpYUlXdXpOQ1NXd0xpZ1NwRlhuUVdKWXBCQkZGbTR5SXdR?=
 =?utf-8?B?a1NuT0lxZFhiZEhtVUQxOHNYM2IxL2ljbTNZNDZzMHhqVUJSMmhDdkxwdFVC?=
 =?utf-8?B?elpnQXMzN3ZkSmZTbzREbXdCT28vQUxsMk9HdllZcFo3M3k4VzZ6ODJGdnRp?=
 =?utf-8?B?K1R6SGoxS3V3NnBub09Dd2FmUzJiL0FLWTBtNHMwNkFJV0NoV2NscnFwem9V?=
 =?utf-8?B?K2RlVmNxRWJrSEZpYkhKV3VxZ1dqMFlpK3JlZnUrRXhtV1J3bjA4UktXbkdQ?=
 =?utf-8?B?N0plSzBJbllRQmlJazJhcWN6U0FjY2IxOCtwQWgzZTNpOG95cjRKWGtiamJx?=
 =?utf-8?B?U3gvOFpOdmJZWnVwekpuWGRyMmd0b3RDUVEvSHJXNWdPVExXdzNqSTNoUW8w?=
 =?utf-8?B?TnBjUmY2NzVMSzhLcDBlV1lRZXpXWGN1Sk05SGdFWlN2Z25BUE9mZU5ibVd5?=
 =?utf-8?B?OFZYQ1F0d29qanVDL0txdDIzcDl5MFcvRDdkaVFTbmJPaWhFSjdsd1pISVZy?=
 =?utf-8?B?RHJ6eXNyOFdjSjUrM3FBdEVJT1dDK3d5WWVVVWRGYTd3ckhFRFQzSHZpTVVj?=
 =?utf-8?B?aWxvRHVqYS9Ham1NZDIrVThFYklabWxnK2pJc0kxOXZiRDZyaGNHcGFTUnRr?=
 =?utf-8?B?REFGOVQxeW82Q1FPYkZzWU4vUnZraEZ6NHNaK29jdkJtdU1JbmkwTkRwK0tR?=
 =?utf-8?B?ZmNzcCs0VUJoNiszdmg5bXA3K3M0NkdqL2RTaUdqRkk5Z3dMNW1JdTFVNWVR?=
 =?utf-8?B?VGxQd0FQUGpRL05JMHZGYzBtSTdrUWphS0QxaTczeVBwYXRWTVYyRzBaRTEv?=
 =?utf-8?B?NVIxcWo1TmhuU1hzNk1MK05lR2JENlFQRGxmemNwT0QrZzhBNU1oZkhjOGpC?=
 =?utf-8?B?cmF1NXl6b2h4ZEwvalYrS2t0Ymo4c2ZobG55VksxMDczVUxMNDlDTUJUVHhR?=
 =?utf-8?B?cFl2UEcvL1lzTXA1RGw0ZlFRbVBJNklrOGlTTmNGdnl4a0FTRHUwTlZKckF4?=
 =?utf-8?B?ODhTV3NJaXZzeGUxZTVIWUxMcFRpK0NYUXhDR2pDWVlGWGt1RllJdURpbWNk?=
 =?utf-8?B?bkE5OTkwOFQxcnpXaXdUcFQ5TmFSanB4YmhkWlNXd2hJc0d5Ny8yZkQyemtu?=
 =?utf-8?B?N3FrZW0xNUpXRVpQakI5bUFjb09JbytVeHlsbGhUS2FSbHNlRnYrOHE1anpt?=
 =?utf-8?B?L0pUN3pzbFhPZkp2WHU3UEsxc2VKaGFuMUhPN1BrdW4ydUl4bDZpSENnWElV?=
 =?utf-8?B?TW1tMXU3WkV1S3RXVlRoRDJldENSOUxqakVlUDNjT0VWUHBTaC9paStIc2FO?=
 =?utf-8?B?VDdPWXVqQ0lRS0dJWUFOQkRGOEtpREU5aHlqZjVOVGI1c2RnejZqVGhwSzlI?=
 =?utf-8?Q?Ljqw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098a2e6-ced5-4bc9-c9e7-08dc871df11f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:16:25.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF9WYZdSCXvHDalecCfJskXa3MpyG841W3YiRg/nCgOKl/XZzkYQpcXd4F7RJvjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

Hi Reinette,

On 6/6/2024 6:58 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/6/24 4:09 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>>
>> On 6/6/2024 3:33 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 6/5/24 2:36 PM, Babu Moger wrote:
>>>> The selftest noncont_cat_run_test fails on AMD with the warnings. 
>>>> Reason
>>>> is, AMD supports non contiguous CBM masks but does not report it via 
>>>> CPUID.
>>>>
>>>> Update noncont_cat_run_test to check for the vendor when verifying 
>>>> CPUID.
>>>>
>>>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT 
>>>> test")
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> This was part of the series
>>>> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>>>> Sending this as a separate fix per review comments.
>>>> ---
>>>>   tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c 
>>>> b/tools/testing/selftests/resctrl/cat_test.c
>>>> index d4dffc934bc3..b2988888786e 100644
>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>> @@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct 
>>>> resctrl_test *test,
>>>>       else
>>>>           return -EINVAL;
>>>> -    if (sparse_masks != ((ecx >> 3) & 1)) {
>>>> +    if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) 
>>>> & 1)) {
>>>>           ksft_print_msg("CPUID output doesn't match 'sparse_masks' 
>>>> file content!\n");
>>>>           return 1;
>>>>       }
>>>
>>> Since AMD does not report this support via CPUID it does not seem
>>> appropriate to use CPUID at all on AMD when doing the hardware check.
>>> I think the above check makes it difficult to understand what is 
>>> different
>>> on AMD.
>>>
>>> What if instead there is a new function, for example,
>>> "static bool arch_supports_noncont_cat(const struct resctrl_test *test)"
>>> that returns true if the hardware supports non-contiguous CBM?
>>
>> Sure.
>>
>>>
>>> The vendor check can be in there to make it obvious what is going on:
>>>
>>>      /* AMD always supports non-contiguous CBM. */
>>>      if (get_vendor() == AMD)
>>>          return true;
>>>
>>>      /* CPUID check for Intel here. */
>>>
>>> The "sparse_masks" from kernel can then be checked against
>>> hardware support with an appropriate (no mention of CPUID)
>>> error message if this fails.
>>>
>>
>> Something like this?
>>
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c 
>> b/tools/testing/selftests/resctrl/cat_test.c
>> index d4dffc934bc3..b75d220f29f6 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -288,11 +288,30 @@ static int cat_run_test(const struct 
>> resctrl_test *test, const struct user_param
>>          return ret;
>>   }
>>
>> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>> +{
>> +       unsigned int eax, ebx, ecx, edx;
>> +
>> +       /* AMD always supports non-contiguous CBM. */
>> +       if (get_vendor() == ARCH_AMD) {
>> +               return true;
>> +       } else {
> 
> The else can be dropped since it follows a return.
Sure

> The rest of the code can be prefixed with a matching
> comment like:
>      /* Intel support for non-contiguous CBM needs to be discovered. */

Sure
> 
> (please feel free to improve)
> 
>> +               if (!strcmp(test->resource, "L3"))
>> +                       __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +               else if (!strcmp(test->resource, "L2"))
>> +                       __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +               else
>> +                       return false;
>> +
>> +               return ((ecx >> 3) & 1);
>> +       }
>> +}
>> +
>>   static int noncont_cat_run_test(const struct resctrl_test *test,
>>                                  const struct user_params *uparams)
>>   {
>>          unsigned long full_cache_mask, cont_mask, noncont_mask;
>> -       unsigned int eax, ebx, ecx, edx, sparse_masks;
>> +       unsigned int sparse_masks;
>>          int bit_center, ret;
>>          char schemata[64];
>>
>> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct 
>> resctrl_test *test,
>>          if (ret)
>>                  return ret;
>>
>> -       if (!strcmp(test->resource, "L3"))
>> -               __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> -       else if (!strcmp(test->resource, "L2"))
>> -               __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> -       else
>> -               return -EINVAL;
>> -
>> -       if (sparse_masks != ((ecx >> 3) & 1)) {
>> -               ksft_print_msg("CPUID output doesn't match 
>> 'sparse_masks' file content!\n");
>> +       if (!(arch_supports_noncont_cat(test) && sparse_masks)) {
>> +               ksft_print_msg("Hardware does not support 
>> non-contiguous CBM!\n");
> 
> Please fix the test as well as the message. It is not an error if 
> hardware does
> not support non-contiguous CBM. It is an error if the hardware and 
> kernel disagrees whether
> non-contiguous CBM is supported.

Not sure about this comment.

Did you mean?

  if (!arch_supports_noncont_cat(test)) {
                 ksft_print_msg("Hardware does not support 
non-contiguous CBM!\n");
                 return 0;
          } else if (arch_supports_noncont_cat(test) && !sparse_masks)) {
                 ksft_print_msg("Hardware and kernel support for 
non-contiguous CBM does not match!\n");
                 return 1;
         }


-- 
- Babu Moger

