Return-Path: <linux-kselftest+bounces-34792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A86AD6801
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3115717DA16
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115331F0E2E;
	Thu, 12 Jun 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QovPzMlx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QovPzMlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DC1AC891
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709749; cv=fail; b=j/7B3NSU/4vFLP24fUBzyQXBLwDUW7y/pqJvD9dgD0nqzlOqk+2wF5wirRKNTzywyty+6+/7p7AerEPqwYWmWw8618t0XottpxQIBN7JuOLBugQoX+ixheAnKtgCJpquqWz79VvzVUq4kFUMRlzpir82sUQgSeowbHz9h2pF27E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709749; c=relaxed/simple;
	bh=kKW7yh4If6MG9902EhXTLm9oyqpy9JW1zjnF5nb03Jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=og3F1Ozc+ap6qy1IQeNWW36KCCgKqKZAgvFpb7+LxfuEDaCWlUr8WR1YZbZulTLnyQjB99xmbcH3uw4vkWqAX1SXtXnt+iwQBHuqbatIECurzDIgJ5Qv7SchaNwHMQ5oOe+Sf1Og4HlimxUIALYPsow6S1dvXZGyljOS5tWs7Q4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QovPzMlx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QovPzMlx; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EbSH/Jmm8iJluFMG6ShdgX/qe/uLdSEL31h1pisEgBwfkE6tJ6Du16/CnaIhmFtqw/YZqFNKqoSarE+xEfrJ8nqqYUWCZF9gJd4NEMAwcH/dhHG+ugNNp09jhPOW4xP9LwyBcuDc3I2LeWov1/JZZKBAG115q1ribRi2CLj/qrBa/SQ7RcAbqIllXffvorAKXH1oTI4Izf54pQCXneSdFHHj8zmWFEaOPgtJtgO7bo+5be9yCypbswhzZLOk/izNJVuL5J0XNyAQmZPumE7snBrKxdyOK846Zp/dVBhHjt4DV9izfPyzsRdbFuNkFYW9J936TNInPNnmvOy4sHv3Pg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHK/8n6UrM8ZT3QEUQ567rNtJi/fLun+VnWMwf1tlUU=;
 b=ArBRJ3wVA2t2/GyWkVy30aduIqlqhvYJcgp+3J3EW9ueqbKLCNxF4tcfSEV/2Q3BB1j0S+4o1rM4V4QaSpc9VEj1v3b1c3N1PVobPJ4XKZTfu8Fk0SHsH0er35k348giK7rxZf2InHo4S2JeDKpU0MKtyz0IcJU56yn3YFF+BRlAI9gZZU0qEtYYUQZyFi+QgjspJaElUAs6447i6zozTQEQe1EzyQpKz23/vOZ7Pr76u0UpCvPfNV6puaJL1GO9AwZR9CYr93v5233nuPOE/phQFHFVSM/MdtXwM9Y/M1ZHqezjrXo3gyzEmaYaXGTvs0w1lmOawPRaararBCF05w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHK/8n6UrM8ZT3QEUQ567rNtJi/fLun+VnWMwf1tlUU=;
 b=QovPzMlx8cjhgkaMuxrz+LlugF5CXuU/oLakEi1p6gtMLBBNcHIEayaP4Q4ojhDWeq2yA5W1imVKHUZYSSp5cPgEGJbexYGKhha9zj1gxgkn/SwEZD0pOfxOR+AN0tJ/JWKTuA9u5V/BXlzfQuKgbcsxHB9nDlBEki7fnKPtEeU=
Received: from DU7P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::28)
 by DU4PR08MB11173.eurprd08.prod.outlook.com (2603:10a6:10:576::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 06:29:03 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::ba) by DU7P194CA0024.outlook.office365.com
 (2603:10a6:10:553::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 06:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Thu, 12 Jun 2025 06:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnIU8V+TAO7j4jpwQNA6q5iFo2hjLpFhW9tmvhB7IDOT3C/8y6gbAqx9X+hHOa9vqHfPQNomiP7lXvLE3+QuMwJcikBLWUDHF3FaVrD5nIpx3jcdjyPyrUVQpW8/LnMdb1YzcIfRAy1UFNMDIRGQml9c3usZLB411ptd8J69MYcecP6bb2I6fdNbUJZV5bWGgEOazETUZZz1hV0a8nnkiHz+0120UtiWezQn9Q8I9RuwfpdKfsligYe7SggENvW7xEoCcplxEX7G6z8Dw0j/eh1evYaCAmkDRfNBs5AeTKx9idfFTcPjs2f38akPCjjFiYO2cgni8ovChtGrl63aOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHK/8n6UrM8ZT3QEUQ567rNtJi/fLun+VnWMwf1tlUU=;
 b=ezbUFtW2MBi0kY9HJm4ENxEO8Nfdqw4O/W50SCt+L6YD65RBMcNlo91j7dse2chkvJeC+0AK7GVufYNRXG1rPJXvrOKRHgqJIo/PqvIKZRyCmSEi+at2R8NjFPZWNSAL2JQNatZloVe5KAdUBr4azRKDQjnBHTySZ9AkwyrD8MWriZb2EkmU/pJG4O9LQ8iPvJT4zxK/h9I+2vdO0OtLH5kFQB0aLHwU3fH2pc0bbbiX/CvfFsCFcDylHCynOKMLZH7pULGBBi+D22Nva1WOocJdN2Jzz0eOCWOW627HKDdpmY2b38Wt27IawDJEuOf3+b6o5+ERCFQP9/pE1oVm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHK/8n6UrM8ZT3QEUQ567rNtJi/fLun+VnWMwf1tlUU=;
 b=QovPzMlx8cjhgkaMuxrz+LlugF5CXuU/oLakEi1p6gtMLBBNcHIEayaP4Q4ojhDWeq2yA5W1imVKHUZYSSp5cPgEGJbexYGKhha9zj1gxgkn/SwEZD0pOfxOR+AN0tJ/JWKTuA9u5V/BXlzfQuKgbcsxHB9nDlBEki7fnKPtEeU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB8291.eurprd08.prod.outlook.com (2603:10a6:10:3dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 06:28:28 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 06:28:28 +0000
Message-ID: <7ffffef8-d2ff-42ee-8a1a-da208109ac2b@arm.com>
Date: Thu, 12 Jun 2025 11:58:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Add CONFIG_FTRACE to config
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, vbabka@suse.cz,
 jannh@google.com, pulehui@huawei.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com, broonie@kernel.org,
 ryan.roberts@arm.com
References: <20250611121011.23888-1-dev.jain@arm.com>
 <b46324o3b6rwmda7fu5mc3edv5hy2vow32jeksnjjzotgcbmft@ccxqapirzo7t>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <b46324o3b6rwmda7fu5mc3edv5hy2vow32jeksnjjzotgcbmft@ccxqapirzo7t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MAXPR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::30) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB8291:EE_|DB1PEPF000509F0:EE_|DU4PR08MB11173:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c7e17d-f972-4222-aa57-08dda97a6b91
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TVZQY1FLcFJCUlJaeS9XbE16S0ptTWJqWk9yMWFHV3pEd0h1WWlHYlRBbmFW?=
 =?utf-8?B?TVN0WVRGZC9BMWwvckVMZDZ1R0FOY1U4cnVaUVYxNUp6alV6OUwzeklpUzBN?=
 =?utf-8?B?clpubVdmUzZySXZqSlNlR0wwNXZPVFNkUlJqMzRIdlhUZStwWXZ1emUwZ0tI?=
 =?utf-8?B?UjNpN0R4dWpaczBwRTk4Z0QyMkRVbDhQSTFyNnN0RkdNZkRVZGxlVHpWOGhj?=
 =?utf-8?B?NW9HR2NicXdCZUt6MGRVd3QxMEh3Z1JBY1lvNGI2NFhLYnBNdkp3TlJlZE5B?=
 =?utf-8?B?Rm02bW1sK1Z0NTJDR280VlYxa0tSSENyWWtzaDRtcnpwMm4yeThxa1BQV2pO?=
 =?utf-8?B?aitHTHJQd1NrT3hEa0l5cWlxVmxORis5R0FxZWRER0lmODRZUyt4TGRubjV6?=
 =?utf-8?B?cUkrNFM5djNnTlhPeTRSZGVqOFJ4RXVyaTZPNVdlRnlGWXlCTXBvOFd3Y2ZV?=
 =?utf-8?B?bitObkZPK1BOODkzMlhUMWg3bnJMUm9ObTZQM3hsVUxNVDR0SmE2alJ2WGlL?=
 =?utf-8?B?V1VuNzBEUWxEVlJlWHRZODhINitjMlVqZy9Zb3FHTDdmc0xKNDJBSTZ5Vmhr?=
 =?utf-8?B?V1JmejJOY1pmOTVGTXlUaTVNbXpZL1NBNG9ocmlZQ2FDTnBxb04yRmJwMHR0?=
 =?utf-8?B?L3BHZmFkNk9NSlJoS2dkVzRicXNIS3Q2Nk1wOWRqeVdDQStpK2x5eDgrQXNz?=
 =?utf-8?B?UTFkV2VkR3hrbCt2LzdaUWRMUDdtT0xodjQrc09kbFNZMnJBeHpqN21aNEZF?=
 =?utf-8?B?OTBnUU5hMElWMUlBNGF5M3liSk9XQWJTUGFvc0JuY1FHSzhNcjlUaHZjQVZw?=
 =?utf-8?B?V3ppcThEU0FjUjMyb1dTOFVMU0U2eTRIOUJjYVB5cisrcnZuSzdkaURzMG1P?=
 =?utf-8?B?WFJ1Sm0vM1AzckMrczdqVVRqRU53K3hqZjFmTUVyQk5WZktuWnVoZk8yQlhi?=
 =?utf-8?B?cDR5UXRsVDNqZnhGaXA2K0tnQmcwRjZTeUZ4L3A0eDlhWFJwY293YzlyMjdj?=
 =?utf-8?B?RWRkdXVLTUhSL2dKZmNBb2VmbnRWRlB3NXR5M3dDVVNkeDVPV2FKeGc2clNq?=
 =?utf-8?B?VFIzNUVQUnN3dmxPQTZ1WnFRTHRjTXU4a0dnaE9WeDhhTmJabXBkN0dEeUdy?=
 =?utf-8?B?L1ppMGJORjM4S3BYamZKYk9lcmZrbVBobGR1aGJmMHltd0FxbDczbmYySlFS?=
 =?utf-8?B?Z2RXM3RvK3UxMFR1QmZEZG0zZ3JVUXpHQWQwK3ZTenFTbVZXT1Nhb2NSdGFH?=
 =?utf-8?B?eWF5d0l1b0lBRUtIcXI3SHFFTjJIbVR3dEI5N1NLWjRBdWhxMFAyemdkWWdF?=
 =?utf-8?B?aXhWYmVqenoyckdJLy92Y2xnbUtoNXppSnhDeVNlTlk0SWI1Z0pFUmhXQzBo?=
 =?utf-8?B?eGFoUCs5YjBJVGdXOEVETi80T3hDTGw1VWlQVkgwWVE5QWM3VTR5K0NXbUMx?=
 =?utf-8?B?RStRT1NzZlMyendOaGFna2VIZlJlVGZtdkxnc0R2VTE3eGlURDE0dE0ydnJv?=
 =?utf-8?B?SmJVaUxlMDZMRHE1cGZwYzZjTnRVOWpRWWxsUng0cG5Xdjl1ZnZvVEhuV0ZI?=
 =?utf-8?B?NDNvVG5pRGJQZG5HSlhIcUkvbFRSS29UQy9HaE90bVMyVDQxaStlRDJBTnRM?=
 =?utf-8?B?TS9nNTY5SHZyS1BTVUtrZTA2NmNnOE1ZYUtQTnJrUEtUYW1nOTZSQnVaU2to?=
 =?utf-8?B?RHdoTHFPWVB4bCsrWkt5UWhMa0VLYVN3eEhwS28wZ3NjQkEwd2xCNnNWdWZr?=
 =?utf-8?B?TTQzb2s2UEtZRS9nbE1KUXNmVkJqQ09TeTlFejZsWFFXazFxYjNoWnNzRVY4?=
 =?utf-8?B?ZldIME9GNVVhSTY3d05RWTQ4YmpMaXZocWJ5NzhnQVdvV2svdjJJbldFanFQ?=
 =?utf-8?B?eXpuWEJ6dkQ4VDJ1Yi9EVmlmQTRkTUNuLzFlRVNrV3VlNEE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8291
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	680c5575-97e7-4eeb-558e-08dda97a574c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|82310400026|1800799024|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU1uNzhKVUUxRDhMdG5ycXdXRlcrRHlEZndnajh4K3RISzFUa3BMbTJjNFBh?=
 =?utf-8?B?VnRyVlV2YWdUcWN0WmFkUXc1clNFSG1jZEw4RC9rQ2ZVZjBqTWhkcXFteENB?=
 =?utf-8?B?cUYvem1QVjFPRE9rdnRjTWVTWW42VFRJczExb2dOVEF5cjNrczZ2ZkYwY3d3?=
 =?utf-8?B?RDQxY0lDU0FYdzhmalAybVZVbTNlODZGT3U4amQ3TGQxRGQ4T0pnYlNDQjBP?=
 =?utf-8?B?ZXZ6VE5iaDdaSUdzbDZLV0NBR0h3QytjbzI1NUxEakZBTGRzanR1alp3QWdO?=
 =?utf-8?B?ZlYyc2R4Qll0NmhWQ2ZtRk5WNzBuU2VKK2NVTlcxdlpZZkxFcVBRMW5LL1E3?=
 =?utf-8?B?NHdjb2oySFhQVzViUTVBbGZaYjFKVzBob2I4UXl2TzVjcnN0MGozc3hNK1Y1?=
 =?utf-8?B?RFI3MHZXWm1ic25TWVVQRThVM1U5QUk3WmxUeXFNak1zRzVsY1ByODlzazQ4?=
 =?utf-8?B?RFF5VThrT29veUZiOUJXSjhLZGE5UnNBV0pUbnpyU3RzT2tSdDVIeHM4ejZq?=
 =?utf-8?B?VTRhRi82U3o3WDg3bGNHM3FSbS93SzhRZVY2Y1ZMYmtOTmh2Mkswa1pvQUVV?=
 =?utf-8?B?Ris0REthZkw4K2F2WFVYeHhwOVVubzVWUGwzYkhqaE9UWUJBSGNncTROajVx?=
 =?utf-8?B?WVFCbmhQU0ZoQStZNzBFbnk4VDVwVVd6MEtrbVN3dm5QNzVCSWlKMktXWVY3?=
 =?utf-8?B?RjdtWWhxZHQxQlJZQTB2eDY3S2lxRFFab2Z1K01zVDczN0dyRGNDb2draEZX?=
 =?utf-8?B?VU5vZGp4U1Z5b29kcXlPZG9KVThEdnBoMTZQK2FIWWpRVTJwN3BGOTZtSjli?=
 =?utf-8?B?RTZwRVhtZTRmeDZ1cnMrZWZXVXVOazdSV3VZMVRwRG80bmVvaWZSOENtMEZB?=
 =?utf-8?B?dG5WdEhzcWJ4dkd4ZGRDMk0xMVNVbjBYSUhzZmVqWG8zOUZMdnFXcGZDbXRq?=
 =?utf-8?B?U3dHblAwcW9oMHQwVFVOOGQ4S2FIS2hRQ2dXUkdIN3hqQnpZRGNiSFgrT2lF?=
 =?utf-8?B?UlZxTXQwV0NiVjlOczUyUDJDQmpIa2JnZWpnc0NqaS9ROG1uZTNpb2xDcDVy?=
 =?utf-8?B?bE4zbGx4ZFlCZE1YdUJpK09wRmg0cUN0UUxGR3JGczNKSjAzU0dYM2hqdWE2?=
 =?utf-8?B?eDNDaWNIMkhnTE54em9PcnpzeGg2em83RkZWb2NmdEdzb0hFSTBFWWJVYno5?=
 =?utf-8?B?MEVMc3Vya0hDWlVVNzRHaW9sc2M5NjRNNWI1dFNoZTYyUnRQejZRYnFjTExa?=
 =?utf-8?B?TTBZeGYzSHJhM3Q5eUFtNFJQUHlDNjBZU2dSM0JtNjEzdHpXWnd1bk1kY0hu?=
 =?utf-8?B?VnozTm9zWERjQzlXYUtEenFkSXl1MnpBeTVCelY5UzM2bkptK1FpQ01HR1Ax?=
 =?utf-8?B?QjUyWVNneFJWbWYrSzBaVjRNMkZZSlFmcUw1N0VOcnkxNTlPTHU4RldENVhl?=
 =?utf-8?B?SVNiZlE0UkwxS3FHVW5QbGkvUkFLS2NpakZaYm9QRWVrUHo3d3pSVXJjMldp?=
 =?utf-8?B?bnQwdzdhTktaaUVGWUlLQ0tPR09keXBVV2xmVnNZU1d4RklvNk9iQ3JQWDlq?=
 =?utf-8?B?cWFUK0tpWEtnVjlHTDlwTjhSaDhVMDNLalhHdjBWUDBCL1RBdFZXQ1I5UEpI?=
 =?utf-8?B?MGFzTGFJN2pYbEVheDRRN0xuWC9yYTdYQlVVdU8xSHhlbG56ODVlYlZ3WE5u?=
 =?utf-8?B?QXVLQU0zd1J0SldoZnFuWGluUVVDVkgzQitRSUt0d3A0eHhvVWM3bmpCRDRT?=
 =?utf-8?B?Sy9sUTFBekJmTXRCbnZEZElaWlJWZFhqVTRvVlVZM0duWWt6Qmo0djl1TGRo?=
 =?utf-8?B?WllIcDhDaHdrRXBMRjNKR1VJZGQva1VIZ05XZUpEYXlHSUpaWFhML2dZWnll?=
 =?utf-8?B?UmtmOU5iUjh1MmxCa2pubjB0VmEwd0VwT29GemdWK3FnMnpJcmQzMGo1VXFC?=
 =?utf-8?B?ZmpmdzVadDN0VEx4UG1yMGw0QW5mR3BUMi9VZnRCMlRWQ2dYekhUNXJhdzBq?=
 =?utf-8?B?TTdEbWg3UjJiNys2Tm44ZmorTzZRVDlmWUcrZWVJREJ4STNGcXg1UmlhMUJM?=
 =?utf-8?Q?j4fk2G?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(82310400026)(1800799024)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 06:29:01.1240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c7e17d-f972-4222-aa57-08dda97a6b91
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11173


On 11/06/25 6:00 pm, Pedro Falcato wrote:
> On Wed, Jun 11, 2025 at 05:40:11PM +0530, Dev Jain wrote:
>> If CONFIG_UPROBES is not set, a merge subtest fails:
>>
>> Failure log:
>>
>>    7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_m=
erged_vma ...
>>    7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>>    7153 12:46:54.639306  # # fopen: No such file or directory
>>    7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma=
:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1=
) =3D=3D 0 (0)
>>    7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test termi=
nated by assertion
>>    7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_m=
erged_vma
>>    7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vm=
a
>>
>> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
>> CONFIG_FTRACE. Therefore add this config to selftests/mm/config so that
>> CI systems can include this config in the kernel build.
> While I did consider this before sending my patch, not every architecture
> supports uprobes :/ So this isn't a complete fix.
>
> Also, does every architecture support ftrace? If not (and it does not see=
m so,
> e.g there's an ARM variant that does not), I would guess this config frag=
ment
> blows up.

Sorry forgot to reply.

What do you mean by "config fragment blows up"? I think scripts will just p=
ull
these configs and build the kernel, and if the config is not supported, it =
will
be thrown out of .config, and after applying your patch, the test will be s=
kipped,
so everyone is happy I guess?

>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

