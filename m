Return-Path: <linux-kselftest+bounces-23734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720029FABDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D032A164516
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889CB191F69;
	Mon, 23 Dec 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bEBlMvzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79317BB35;
	Mon, 23 Dec 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945249; cv=fail; b=ED/vieUPo1th3qCbkxr8zybldS5uD5PK8a30TvxW/c2GoYp5+EeY0M2aklpDwZD0G7KzGLF/CYaiow3ezv+5K5+zVbJpDjNSM0Ud6CWJbbT8hqlZzCqy6gcKq7MG9ngXpSQ25yCD6FbPrPga60YqbegMDnALpStUbV4ZrWh/8jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945249; c=relaxed/simple;
	bh=wRHro5Wlqs6lbo8YDH+7MT4spTvIc4lW2eW1rVXzHeU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlVSyslahev4DaXhPN+/uBNNatLFPV4qJfInInlUVTHpnu5fwzSmduerdDmxXpd4xSOOBrZnLxuM72FcNfBPVOIo415mNJ7linh16SJeKeLK0iX8uB5JetfgXTDhgTT1aY2O3mDyh5DCf/C5uH6RcpovSoRRgDcOr6rKbegZsBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bEBlMvzX; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL1marxcYQoSief8uFQ6OJHwlMFgx9Y9he8J45W6gvye3gidEt8bLPxgUhKNNSS7Xez5Swpg30Jxw6Eh+ksZDlfpllIqAqUOiM159uo4N2FPKO+kGYZWxMNKHTLaZu07NQkaEwu0vgtB5Cp8TAf6IJocr3wFjvjmpl/3QpYryGiUdBbIyDnd2M9qaNr8xXHS5YfT0qqe01YU/eJFWYWv3y6befKUmpSlOq6TM6lvbnSn9grrClyNnTyeMkIRC0J8aEzJ/JiEo3E5xkvo3d7Sv84hELFGx9K6SVwtE9Sq2BThL6x8Q+o/akjBNgdlm5hgGW/w4SWA4tyc1vsHXgC5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O9K0l7s75dTtQ2xsixWM/VOEob3N2c737W4ZWqSxxI=;
 b=OlccK0ABohK5CJcZYjD0IXpW+ywRjCyqA1eeznqq875naUJpKqvUKb3Lb1GMoGTQ3uDHpTVwx2vvRAu4umODSBEqN6IeH0EctQ0Y17v7RLWX8GR828/83T81pJz/YtB7qjAEDiU3uT5fOL+XoRQ80GAo15klkn2S8OPon8sCTGUikEt2q5tz+zxMpGpbbcwQ+aY4128ozIqDZMVXnadtRyVTlEnIwTRkokfaP/kTYb73HZWzAPgtZzAsJp2XrOmhYrpo0qAy+fNOiLlnoYmk7/Kl6b94hPTzrsduwbSrbnaLhlvtC6yYYRSi5Ov7UCtxR8M4Y20vAOiz+4wWTG1FRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O9K0l7s75dTtQ2xsixWM/VOEob3N2c737W4ZWqSxxI=;
 b=bEBlMvzXianUrI2/bbrNzWysMsUVGKntOU8jp3ZFW6SoBtGrYHeIZ0DVCIXhnjxdXUdXSH+m4no28Xpe1bvKViMqSwwkJzkJ89IfMVC1tSxNrdBZqoTf2hGyMAdyf2D8846OJsyWbeg2ogMgoH7HMIcymKcKbh2vrzNmdSC2754=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 09:14:00 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 09:13:58 +0000
Message-ID: <47700dc4-c194-4a3c-a1e7-3d5e5a6ea6dd@amd.com>
Date: Mon, 23 Dec 2024 14:43:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for the Idle HLT intercept feature
From: Manali Shukla <manali.shukla@amd.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <5331cf45-230d-4d27-abc9-e5d92e5a6c11@amd.com>
 <dc3a3dc9-c6d6-449d-a1ec-d6c6879eb8db@amd.com>
Content-Language: en-US
In-Reply-To: <dc3a3dc9-c6d6-449d-a1ec-d6c6879eb8db@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: e640c866-d442-47ae-199c-08dd2332219f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJxZ2V1UWRQSTdzb0R1UGRmeW5sdWYxcHRiTEJxSm5ONEVtUUFQNkljdTNi?=
 =?utf-8?B?bWRGKzB5VytOcWNNTTlkeWdGbE9QL2RzcUZvOEVUQzNlaDZUM0hlK1hZUWZz?=
 =?utf-8?B?b1A5ZzZpSHdZYk04ZEM2amVuSXlEazBIcWRGVnBtTnpKY0NqT010cDE4bXhq?=
 =?utf-8?B?KzV3Uk5uUG1HMG9oY1ZZRDNmOGdyUGNIcFMySGhiSW84VGx6VTdoTTR0a3dD?=
 =?utf-8?B?dG9UbHhsMGxDL280ZXV5Uk5PRm5zY2w4N3pWMmJwSWdpTVNIS0RRK24ySENM?=
 =?utf-8?B?dlhXamlOYzMxeVJRMm1tcS9NVVNKVXpiM2w5V0JDTCt3U1NDamtPeWVXMlFq?=
 =?utf-8?B?MlJ5KzRZWEJDMlE2VmI5RXQxUEVmQk1uN0JxRmNrNGxnZHg0ZGFZeVRlR2d4?=
 =?utf-8?B?aWR3MW4rN0IwQTQwQTFqTzFjZnMvNDdjVFlFNkVESjczdzRiSmdUazhCN2Ey?=
 =?utf-8?B?Y2J5QitXS2N6c244WDhCbGs5ZCtpQktIcUIybFNOWkkrVjg0NC9aVXlsNkdJ?=
 =?utf-8?B?ZnlZVU9tTEs2T2szUkEzNmttMHV5RnZobm9HZTN0RS9lWmY3R0JjQVdOekVR?=
 =?utf-8?B?NEJmUmY3cTVnVURiLzBKY21QSFZHMU1xTHgxQUtFbUlETlVQV1Q0R1Z1NmVm?=
 =?utf-8?B?TDFYaXFRd1dYREJjeDQwQ3AxY3llNUlBNTc0cmJEdnNOejl3bm12VHJ3TzlX?=
 =?utf-8?B?UnROREZDZjcyMHZQNXU3T0lDdTFQNytCYzFLdXBxdUp0S3hIWkNIemlHSFVv?=
 =?utf-8?B?Z0cwZFpVRk9FMFNFbGI5VWd4Z2ZFazhoaWEwU2I4dSt3aWdZMUFZSnEzbmJl?=
 =?utf-8?B?b2hTb2NUM0lwL1oyWkhmRTJnQVNNQ25VZENmQklEQi94S3kwcEhBOEhqaGYr?=
 =?utf-8?B?OG1GRUJMRStnVmFKSkNZdGhsSzZQUCtDQWY0UFg5aEY0U1JaRnlTNXNBSWp6?=
 =?utf-8?B?NnBlVjZCNUg2S21DUUtRNDd4bEhaTkFwTERvODVQM25uK255ZmtMOUV6aXdS?=
 =?utf-8?B?dHJUQWlOUjJQcmVuWVlKTGhhTlNwcFNzd1JTZDY5TE1URHNKemhFNlY1eGth?=
 =?utf-8?B?WjFuWDBPQWVhRVdnWHJPRGc2Um5wa25NbmZKRitHU25DbGNXeUs2bGFmcFlB?=
 =?utf-8?B?VDdkc2hzN0psSjJiK0F3RThDaVZScFU0VFB1YzZyQTB3aDJjUkNIWEtCYVly?=
 =?utf-8?B?NlIrZVVObFphSGVsMFNhbE9ORlNNb0VMU3hkbnlBNnlKWnRFbml4NkhnNHg4?=
 =?utf-8?B?eHNzTEdWQU0rbUYwblU4Z2xXMVpyYUFuSUxnRk9wQ2grYlpoZ29UZmxFYk44?=
 =?utf-8?B?NFNsQWorRWtFanJKNXJ5RVA4dXZCWFRoVzU3d1g2RTVuTHRtS0NHSVRMR1B1?=
 =?utf-8?B?TUZCdDFKVXk5TXpzWlRNa2VpK0g4QkkvejJYOGMxMnFQZ09GUENnc1M2RFRL?=
 =?utf-8?B?cGFyM1RtRlJ5bXZDYWdTNS9xcFB0ZkRicEdSRlJkVWxMUmVHbWpGYzNSWk5i?=
 =?utf-8?B?ZkNHczVwMFV0UnJpYVdyKy9heHdDUlBTeng3QTlVQ2ZTWVpic3JzYzdObUhF?=
 =?utf-8?B?Kzh0ZGkvcWxGN2VBa0RYRlFsZzk3dVAyU1JCOEhSZVlTaHVoMHZHUDR1WHJE?=
 =?utf-8?B?dUtoSWs3NFYvK2hTR2wwaWRVV2dOZ1ZBRWF0ZFNnb2RwSjF3QnpSa0d3QkVj?=
 =?utf-8?B?MlNqMkc4cFpsRytqVEVMK1NyR25iTXUweGNJWjcyS0VDVmF5VU54dkQ3R0xK?=
 =?utf-8?B?RUJlODdvSzBFb1lJQkNVZ1FpQzMyVDBlU1cwa3NVZHg3K05HeG80RXdzcmtT?=
 =?utf-8?B?S0xlMTBSa2UzUlJtbFgxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdkTGZob1JKamM2MWpUcXR0UlRYT1VING45MGRreUxBWnRUUDU4MVBGZTdz?=
 =?utf-8?B?dktsRU84TlJPTk1md2pUVGR0N2lWeklkYmYxelczSDFUZ2Zsa2IxS0FFdHBV?=
 =?utf-8?B?ZmR6REwvbEQ4N09EdTUzYk1Yc0w4VG1XdnRVamVhQ0tCVnNSZWJzVlFSMmFk?=
 =?utf-8?B?NG1yejhPZmZlekJFWWRkcm9Sd2pSZkNKM0syMCtJd3B5UEgyNXZvY1VEbG5Q?=
 =?utf-8?B?eG9xUkVKVGNJR2NaNEdSWkswUlNFQWhjNTlVdTA5UDJjZXU4Z2JKMXZFTW5o?=
 =?utf-8?B?VExtUGtQZmM1Z2RnbXd2N1lOS2hMZXVYKzFQL3p4ZGxBa0tWYUloMVpCMGZ5?=
 =?utf-8?B?VWhjMjV6bmkrTTFIQnBuVXJ3a3RNa25yK2tlR0tITDczK0MyeUlDUk81aGVR?=
 =?utf-8?B?YVU0V1gyUXV3cmhyTmVKQ3JWMFY1WGJaVFZYcGJLSmwzdUJUMDJPTm9HSHRJ?=
 =?utf-8?B?L2NaYkx2VTd3U0ZTTjd2amxzQ3ZiQmx2Tk43d2c4ZlpkeElaeTROL1hRVnFB?=
 =?utf-8?B?Z0dlQ09lZ2Noc0tISkR4eDA2RlF2dCtqbEdvSGgrNi96S1dVeUwxWmtHSTdO?=
 =?utf-8?B?MlRXb1ZEV0tra05zTFNGUWZFcXdvVW5EM2plSlpuY25reVN5M0VzTjNpREhS?=
 =?utf-8?B?RDVYc0l0cURoV0NZMENRa21GU0JOMnIrclZyM29XQmhGd0VXSHZ6NVFFOEN6?=
 =?utf-8?B?NDRxcnRkbU5vWlFqVEFFSDRqL1BVWlAyREIwZ084aVRzSlI1QVJLT1VtY0x0?=
 =?utf-8?B?Z3BGck1FeDUrbHZUNFVHU1dGNk9iNzZGT2x3UDZNd0ROdm1walVNRVduYnV4?=
 =?utf-8?B?Mld4NW95cXZmUmExMVZkZ0g1Rzd1ZWZqNnp6RmRZZ1JSa3NKWWN2NjBUWHd2?=
 =?utf-8?B?ZDhZSmhiT1pZWHdIcWdsTkZDODFwVWhhc0NFWWJPRS9ZU3JsOGtEdnY5SW90?=
 =?utf-8?B?eld3VzJNamNKTFAvK1lVbEtXWDZXZmJ3eThhWW1ZblV0Q0NYdFFoMTN4eldY?=
 =?utf-8?B?dDR3V2RYRU1UMUhsalU0V3owZlZmdGt1OG9hZnpJTVNRWjZEUVNnOGovUXRN?=
 =?utf-8?B?NHFSb1ErUUVoM1BQdytDRk1sOXhlZjNpanJra0xhd3pCUTVHd2lBRHVSLzdG?=
 =?utf-8?B?algvd29OS1ZhSkZaWDNsYi9XdGZsalRDVlRmc2xaY0N6WGZLeWJKWVFJL2JT?=
 =?utf-8?B?bXJhbldod2RXWUNRQTlJUEc1bGtnczM3WThjbHRnZitMenJZcXZ6bVZCMExN?=
 =?utf-8?B?VllDOXNjeFBFb2JaWU9qQWZYbnQvYWRWU2dUWTZDQm9PNzJVZXpITkd3ZXNp?=
 =?utf-8?B?TjlCQkJyM0FmRjhxQUErL2NtR3RtYU1henJDcEJmUTJjZVhvSjBQU3NxTG50?=
 =?utf-8?B?K1YxcmUrcUNqTU1YaG1MTjZWbnkrbjBBa0x0b1NKUnBxMW9KT1Q0WStPcDk3?=
 =?utf-8?B?eGhVcmhVcEJsbk1nYXVSYkdnc0g2MmNzTGlzbVVHbVpNaTAxRkpWVlNwcURx?=
 =?utf-8?B?OTJZS3BtbjAwVENxUGN2b09rSS9hNDNEaktLbmFwMjZDcXhocnRjNFFsQk1w?=
 =?utf-8?B?eE1kYmtpMFFWZm5xTTRDSzlMOGQxcUlwTVdHcC9TNzlRVlpvcG9KQm5xZ1lv?=
 =?utf-8?B?V3NqcHhuNHFETWhsNkhHZEF6UVhtMWFsYWo0emhIODhpNWhGL2pITUdkYWFF?=
 =?utf-8?B?cFREai9WZ1Y4Rm1KSnp6bEpMaEgrMTBiRDMza2dYUks4M0M2dmJvL01NRTh1?=
 =?utf-8?B?VVg1Z09ucXI0NDI2NlI0aFhOWG5rZXUyemZFc0QxdnUwT3ZDZ0NtUUw4Rmxv?=
 =?utf-8?B?cFkzNWlwS3BRa2duUFJjOU13dU9VZzJzVlZ4RDI1ZitUUWFLbUZjM0VkeUtk?=
 =?utf-8?B?T2szSlhhVEN0T1loS2kwcm15bk1lTG5DWDRxdkZ3dkNtUjFTbklDTmtBajhl?=
 =?utf-8?B?TlpTZlAwblZ6SFdTTjk5N1I3cmt2T1hHRlVLOGJ0TkhRNEhWRDd1UG8xWWVx?=
 =?utf-8?B?Vk5GUnlQN2tYTW9lTVhHK3crSkFidlBVdEx5TmZIODRxYXBFeGFYUGM3UUJF?=
 =?utf-8?B?RU9EZlFKT2d3U2NIMHVSUWI2NU00VGFvaVJCYVl0TmJGS0tScUhoRHQ0dW5m?=
 =?utf-8?Q?9xCUHeFyFbFgJaL+7/SZ+FGup?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e640c866-d442-47ae-199c-08dd2332219f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 09:13:57.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xis0CGUa+AJaOrgz2dd8A1O26tK4I71PxVm80blcxTvGOwXoo6p7sVyeobudzLiRFb0b1HHprIRhiYIddcxuBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221

On 12/12/2024 10:07 PM, Manali Shukla wrote:
> On 11/28/2024 8:39 PM, Manali Shukla wrote:
>> On 10/22/2024 11:18 AM, Manali Shukla wrote:
>>> The upcoming new Idle HLT Intercept feature allows for the HLT
>>> instruction execution by a vCPU to be intercepted by the hypervisor
>>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>>> When the vCPU is expected to service the pending V_INTR and V_NMI
>>> events, the Idle HLT intercept won’t trigger. The feature allows the
>>> hypervisor to determine if the vCPU is actually idle and reduces
>>> wasteful VMEXITs.
>>>
>>> The idle HLT intercept feature is used for enlightened guests who wish
>>> to securely handle the events. When an enlightened guest does a HLT
>>> while an interrupt is pending, hypervisor will not have a way to
>>> figure out whether the guest needs to be re-entered or not. The Idle
>>> HLT intercept feature allows the HLT execution only if there are no
>>> pending V_INTR and V_NMI events.
>>>
>>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>>> function Fn8000_000A_EDX[30].
>>>
>>> Document for the Idle HLT intercept feature is available at [1].
>>>
>>> This series is based on kvm-next/next (64dbb3a771a1) + [2].
>>>
>>> Experiments done:
>>> ----------------
>>>
>>> kvm_amd.avic is set to '0' for this experiment.
>>>
>>> The below numbers represent the average of 10 runs.
>>>
>>> Normal guest (L1)
>>> The below netperf command was run on the guest with smp = 1 (pinned).
>>>
>>> netperf -H <host ip> -t TCP_RR -l 60
>>> ----------------------------------------------------------------
>>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>>> ----------------------------------------------------------------
>>> |         25645.7136            |        25773.2796            |
>>> ----------------------------------------------------------------
>>>
>>> Number of transactions/sec with and without idle HLT intercept feature
>>> are almost same.
>>>
>>> Nested guest (L2)
>>> The below netperf command was run on L2 guest with smp = 1 (pinned).
>>>
>>> netperf -H <host ip> -t TCP_RR -l 60
>>> ----------------------------------------------------------------
>>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>>> ----------------------------------------------------------------
>>> |          5655.4468            |          5755.2189           |
>>> ----------------------------------------------------------------
>>>
>>> Number of transactions/sec with and without idle HLT intercept feature
>>> are almost same.
>>>
>>> Testing Done:
>>> - Tested the functionality for the Idle HLT intercept feature
>>>   using selftest svm_idle_hlt_test.
>>> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
>>> - Tested the Idle HLT intercept functionality on nested guest.
>>>
>>> v3 -> v4
>>> - Drop the patches to add vcpu_get_stat() into a new series [2].
>>> - Added nested Idle HLT intercept support.
>>>
>>> v2 -> v3
>>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>>   a way that each architecture can share the generic types and also
>>>   provide its own.
>>>
>>> v1 -> v2
>>> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
>>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>>   doesn't use string to get stat data based on the comments from Sean.
>>> - Added self_halt() and cli() helpers based on the comments from Sean.
>>>
>>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>>
>>> [2]: https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t
>>>
>>> Manali Shukla (4):
>>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>>   KVM: SVM: Add Idle HLT intercept support
>>>   KVM: nSVM: implement the nested idle halt intercept
>>>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
>>>
>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>  arch/x86/include/asm/svm.h                    |  1 +
>>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>>  arch/x86/kvm/governed_features.h              |  1 +
>>>  arch/x86/kvm/svm/nested.c                     |  7 ++
>>>  arch/x86/kvm/svm/svm.c                        | 15 +++-
>>>  tools/testing/selftests/kvm/Makefile          |  1 +
>>>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>>>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>>>  9 files changed, 115 insertions(+), 3 deletions(-)
>>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>>>
>>>
>>> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
>>> prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
>>> prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
>>> prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
>>> prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda
>>
>> A gentle reminder.
>>
>> -Manali
> 
> A Gentle reminder.
> 
> -Manali
> 

A Gentle reminder.

-Manali

