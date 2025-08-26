Return-Path: <linux-kselftest+bounces-39901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E11B352C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 06:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87F44E1475
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 04:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C5230BD9;
	Tue, 26 Aug 2025 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="orcN80nH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="orcN80nH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45623596D;
	Tue, 26 Aug 2025 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756182661; cv=fail; b=f86npZ4cKId1aUsd4Y6QRADI1OX9668DAXyGM89az1x9gE1weKOBw8ZJyO2oprNYt19Z09iYtqsDOri/cljlRIr9nzBoTSze7RT4qSlMy4WbWtGrqudBw7YmhrJVPcTVVpqYqq2vdtTNMCIc8imgNA1QSgHyLzEEMXb4la248ds=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756182661; c=relaxed/simple;
	bh=cQS23WptqpN/KcM6n8nPa72D5aTDZQFg4Hfx8CTi5gQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snhnhRWVk7oAMJfp3mXXRq3an0e1Nz2zNqiaf1ErHSmEoB06ZO8VLi2I/d9lEhwlvAUF5iu+Zckp10okC1I7rMQ5Jev8gpSe4a/0uCZKnSPCTWIOqLyLTAOAd6n4YRlA0eGOeP+wQ5kvUkEhqkzcaHDOFUkwwPZLAitkBYSphXg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=orcN80nH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=orcN80nH; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=j3JlpwM/mPVEFYu1KxR79pwqxtZGXjAmCxj2hslKoVRxKckkrf6YK00IAPH5jT9Qdm/OvAhrTHP2dGamFkpwER8gB1iWfV5VAriVMkc1LCzXwmx1+OPC8WYvfxsUWgFNdURJRobDl07WEWlgXH3lh+504/YD1Z4kbDb/t0Hty4p/WRkW4byew4e+7KS+os17mE8RDsWA1lkzaOZ65KoU1j8H701aSzLkfx7t4cfznibqLJBJm/YOL8KXTGYlCaqt5GLVt4P/EXi6bW0tK/ezFYgJ/if7kRJ5sxpycajyL+T7/aF77zFMaS2S9PdoSAH2XLGNoJxpCZ3AmoWHJc12QA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjc98bFFUHOE8EeMPiFcx+9mrlThcxS+eLV/qogmsEs=;
 b=dGOxfGto6oGsDenvDHXKOst0CaV2HEs2rB/HxkFxXCNn32jIKwUFF5Bzt1Fx2U+VA5tuzh+feTTPEQi0DTadh87heHd8lvaUdti0ESS7UfodC0cqTK7YIVzqrzkIexg7WrX1dqn7O4MOviF7kEUgz8Q0jNoH+kyXOy19GHMLkJnuXr7vH0US60P6yKi+9KBlIHnILrPrmJF2lnyE74vq50ij92JEFDGV6aWb0SsoTVqQb7w5LhRA+b58k3OV3bwy3dtnLOxD/enmNyUanj+k0fSQGCf50hsNy8keteYWn2mzZgEGrriecjux0hOywdZSNl0HVdSpALT2umqJjeB+zQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjc98bFFUHOE8EeMPiFcx+9mrlThcxS+eLV/qogmsEs=;
 b=orcN80nH6DsLHru5dSLGKeKm/GWuI68hw5VK6eMu5OZxc6L7JDu7jS0fj0QLEyJqSX5FH4IVC0y0+qnpzNs6o3FJ65WJndjUNL1BRvr0YafGKBrLZCvvS13ZAYu/fC/+HnDDkAhFe2+0oYZNVU6U7NaMNxgUQbbekhqH7PYwGcI=
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by GV1PR08MB10905.eurprd08.prod.outlook.com (2603:10a6:150:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 04:30:55 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b4) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 04:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Tue, 26 Aug 2025 04:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2RAdqFWAZyt86U2lH/OvbajQIB4GcsH2Efp8zocjIpxb8Mh+N4CldcXx7SfXJkutwlKecnag9M0YkZtWh/HsM2XDdaAPRolHaayG0SwXBkvnftroHZy5kqjOow/wvCK0gDyBUAPIXqvyD05ihDZWv62IJRHASjTRCA+AIoM/3gb/NZdjR0dZYSamuvQQrEmnyw329AoBvvBafSDhAG1Qnu9p4XTgoVeO2sjn+JXc7L0ZrhI0BXhxjPVfyqGMA8vQZAyghrFUxiDcPC21xEPXKTIcPXDYppU3Kqwn5uARuPGFQ9vqJCxOVQqfFXNTAzJbQtp5Zf5FojXE24rmuy4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjc98bFFUHOE8EeMPiFcx+9mrlThcxS+eLV/qogmsEs=;
 b=NfSqw8E4y33ypaAPl81Ugsv13ImNZEfqJBYCM8+fVI7mAdB8aMNHm/7RehEVde0hVMZGuwxe3YrLCiRTRu/I4njBK72+DeqJixGd926JKzhKdsjFe0yamqSfgOj/ISkkJ2kRvb1hRQtRFWdwtNv4P9EevGUsx3FMEkryWvIYdbMHAryzsepvDEsMG1/fjrifnFZb74dR7MrqTCw3PgwVdG4jZDcYwYdf0npBVhUGR8IJoH+HfhqiGR0HTX7u2/NrS1lIpNoRxcsyLAwOE5B50JDZD3XQg9bN6/4g2aDKZchN9m3bjO5drO9vpVmW2nOO5l3hhW2UX/DMY1WDbGC/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjc98bFFUHOE8EeMPiFcx+9mrlThcxS+eLV/qogmsEs=;
 b=orcN80nH6DsLHru5dSLGKeKm/GWuI68hw5VK6eMu5OZxc6L7JDu7jS0fj0QLEyJqSX5FH4IVC0y0+qnpzNs6o3FJ65WJndjUNL1BRvr0YafGKBrLZCvvS13ZAYu/fC/+HnDDkAhFe2+0oYZNVU6U7NaMNxgUQbbekhqH7PYwGcI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com (2603:10a6:20b:402::22)
 by AM9PR08MB6227.eurprd08.prod.outlook.com (2603:10a6:20b:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 04:30:20 +0000
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45]) by AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 04:30:20 +0000
Message-ID: <d11aa803-058b-4585-bcee-a6664cf049a9@arm.com>
Date: Tue, 26 Aug 2025 10:00:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: fix typo in ss_flags check message for sas.c
To: Alok Tiwari <alok.a.tiwari@oracle.com>, shuah@kernel.org,
 broonie@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250824191721.631980-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250824191721.631980-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To AS8PR08MB7111.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB7111:EE_|AM9PR08MB6227:EE_|AMS0EPF0000019C:EE_|GV1PR08MB10905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd38be9-33ab-4731-a0ef-08dde45957c0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Nzlyd1lWbXNQazU1SHJFT3d0WDgzeEtDYWlmWDlnckxaRzM2NDdxeGI3SUxq?=
 =?utf-8?B?cGVUL2lwSVVHYkpKb1U3Ry9ISVFVejM2ekpxZ25FUDlqbHIwNTlCeGhjOHlM?=
 =?utf-8?B?NFBJNGNsOWdWWmpDWHB1Z2tOS2h3cUkySmRnZWN1R3FJVWtmbmxWTE95L3FX?=
 =?utf-8?B?NnpmdWtSblJTK21XWTZjZTJqMFVqdXArcG9scGt1aEJWSUF4OHpsVzI1MEtH?=
 =?utf-8?B?YU9oR3dPbHo3REtwa09HSytibUxFVFlUWTZYTE9TbUlNQ0h3RHRUNExCTFY1?=
 =?utf-8?B?RW5zRDM0L2FnN3JWZEgyU01DNUhCUXlxUURvbjk4SVB4TlhMcEhMU0VWUnZu?=
 =?utf-8?B?N0k5ZFhTbHA4OFp4N2pzaTRDb2tER2VjbTJoUmc3Sk1qbzltQVQ1eElxWUxP?=
 =?utf-8?B?MVNuMmRGT1R3d090OEV4L0lJYUNEci9iSURpMjBORXJZck93d3N5NjE2d1Uw?=
 =?utf-8?B?Q0k3QVVGR1ZBRDdsWmdVL2Z6M0ZBdW5aK1hFTXIzNGNCcVZFLzdTVklIdTEx?=
 =?utf-8?B?ZjVWVG5DVXg3eXJnTDF4R2xzVU5kY3NRbTVGWEUzYUIvRS9RYTgwbHZLcFV2?=
 =?utf-8?B?YWlVVWN1cnZzeklOTVVYVnFucURXeWVmanQyd0EwNVo2K2VheForZlpSN0cy?=
 =?utf-8?B?SVlRdVZxa2VaeDhOR2dTellDQ2lLZjd2V2dyWVJrRGNwblNUc1hUOVBseVZj?=
 =?utf-8?B?bG5DUWNMZW5PVWFtaVJxcDhLMHlsZStoOFpya1hUOW9zZ1U4Y1hQb2VjcXA2?=
 =?utf-8?B?NDJnaHhWR3lnMnQvS3N1d09iOEpUNW5rWk1LQkVPZzFmeGwrWlVJS3lIUGNK?=
 =?utf-8?B?UExRajNmTG1PVHI4eDlXWXUrNmo0ZFlJM3YyTkRlL2pYYk1EYXRrdzJhTElW?=
 =?utf-8?B?VndKTjhENUJ1cUI3MkFiVWRYNFp5YTE3Y2JLcVhEcTMrMEhoSHo3cWd4c2Zz?=
 =?utf-8?B?c2xhblQ2WE9TOXhOSjBWOWZQcDYwdHZKdVJtMXZqcUpKVkllQmRLOU1haXZF?=
 =?utf-8?B?S1dPM09wTWc3Qlg2bmlGNFF4dm9pTUJaSjJlSVhnUFdxM2RXWUNpeHFtWEFL?=
 =?utf-8?B?N3BYYjgxRGE4bXFXK09LZk9jRUxIVk1nOVlIaWFGcmZJY2dpaStldnFjSk11?=
 =?utf-8?B?bDZIaVpVakZDcEtqd1JZd1lYVVB2T08rajQvajk5dHNtQVFicmt6bytmdk0x?=
 =?utf-8?B?RUVlVlpzdFhMb2NCZjF1YVhGZjZDUVlSMXpGRzFQbG5JckZDdU9rUnZiSXdL?=
 =?utf-8?B?bGpZcVhpcHg3NVVmZ282SmhpWVVySFdJeWJyNmNlNHUvVFdCTy9VdUl4R3lO?=
 =?utf-8?B?TkZFQUxnRjlhdmpXWXFaYTAzQitvVmVobzlDQms0a3VoR0E4OGxNZ3dCMG8y?=
 =?utf-8?B?NmdJdVVNaG1wclJsNDgvMDdoUCtiVW91YjJ6ang5U1NRU21ac1RtL25od0g5?=
 =?utf-8?B?bDdmV3lFRFNLMnZaVktHQzhOZy9GNjBYOVVYbzZWQWlCV2J5VHZnaDRCeXZa?=
 =?utf-8?B?dzh2bXpWQk5EcUJUK1VSZ0hQMWVYMkE3QVBhb1AwcitOaHlEUnpPMkZVa0oy?=
 =?utf-8?B?eUZ2SEJXOStDQ2hsZmx3dmNkdEZWOCtxLy95RlVGc0I5VkM4cWFnMkpBQzRw?=
 =?utf-8?B?SDhSSVcybXZXMmgxbmVZUGF2OFFFSVpGL0lWcDRqWnlFY29YeVBPNU5tYm1w?=
 =?utf-8?B?WFNSMi83TkpOalowS0FVaXpwMHdCdHYrN0pUemNiT2ltRGJHdk4wdXlYOVZB?=
 =?utf-8?B?NUE3YVBFbWRjbU90RWtWZGZlMGxJT0xOcTBNTWJQREt3YTUrVzZwSmhRTUZ2?=
 =?utf-8?B?ZUFGVEo0TzZ1MVlIYW5ESi91RTFSZjlmNlFFei8xSjB3d2lPTDl5aEgzWUd1?=
 =?utf-8?B?MC9sRGlzVEUyMmVON2w0TEZMUzdQUnpkWlM2UGhueUtHYzJXSkIzNjhIdXF3?=
 =?utf-8?Q?1i2v1XieurI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6227
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cbca64b9-9257-4928-04d3-08dde459440a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|14060799003|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEJFaVUrQVJJaS90Zmw3Y3pFV2lPQkV1OEJFQW4vMHJ3TkJObVdMV2RINXVC?=
 =?utf-8?B?dXpnS2hFK3ZvM3oxZWVVTjJqb2ZNOHJIT3VQSUtnUjlqRTZpMGlCYWZ2b0or?=
 =?utf-8?B?NUlLYk5TRlBVblpaSzBNTFRua2JLeitFaWVWV29OUUtVc2J2V0RlMHBhVTFU?=
 =?utf-8?B?QnRqWk5XQVJTU0xQM2tubVowUXF6VVhYTDYzMHYyb1R5OUhaRmRPUmVTS05B?=
 =?utf-8?B?RHppa0dRU2J2Q0d5cGdtM2FDczI5OS9GT0wzNXRNSkR3aUI1cUx5ZG81RFdm?=
 =?utf-8?B?ZU5sQkVONWhtTDdBd3ozVnpxRXVwRGhsdmkxQXpzdGpDLy9rdmUwUUlseUtY?=
 =?utf-8?B?b2FUZDVqV3p5VlZSMFI4NTJZbDludTByQlQ0cEVabWxrVnN2bC9TamVFbitK?=
 =?utf-8?B?NHJjQ0RIRVRRVDM0WUVqekszRlVDbDMrMTV6T1Vhb2ROTnI3STdFUmdteEx2?=
 =?utf-8?B?Qkl4L2t6aTlTYWZWRWx4MHBZa01HbnRyZERhVEtVczJmNGZVcERiaEtwOEFs?=
 =?utf-8?B?VUpRcnVhVUZuVEtxVVozbUN6cmFOZkRwdW9Yb0xnZFhIaVlwQmQxWm9DRjVh?=
 =?utf-8?B?Q1E5OTFZZXQwQzdjckJnNUhFeVlCa0xaSHNSelNHcVBVTnAvZXhRZmtJYXNs?=
 =?utf-8?B?S1RvZkZ3RFFtOTI4V3NlaGVjbHB2YnV6dkhXS3pmVEYvWXZ6OE5zUk93T29Y?=
 =?utf-8?B?MFY2bzlraHY3UklmZHhwdWJHZ3NaeFprQ1o1WDRiZk1kRnNHbnYvTC9GYm9R?=
 =?utf-8?B?Ti9DeVgxa3RRS0NrZVJPaC9TRWhIYVhQN1VnK0VQSmZTRE1jNEJKVGpZRXN5?=
 =?utf-8?B?WEJsaThvVVc4bkRBZ0FOSEpHS0tIYmgyRzFaTmFYT2g3Nm5RVEQydHgwOS93?=
 =?utf-8?B?akx1MVJEbEV5WDZvYVBYZEplZnN3THhXQytxa3ZxRnpvNVFWQ0UvWmhKUitW?=
 =?utf-8?B?VVNmd0lwaXQ2UTZzZ29iTys4M0JmakpQQkgyTFdzUHBJUXZnTUFNZUhMRzdr?=
 =?utf-8?B?eXNRVXp6NFFVVmFRMFFUeGZ4SmtkcCt6eHI0MERRNm5pVGpBL2t2QzdQNWFM?=
 =?utf-8?B?d3Zic0pRWWNNMEpxNjZZMDV2Qm9GaUVpL1gzTVk4RnZJL2dhZlN2Nm9uSEU0?=
 =?utf-8?B?OUs0OGIvUDFyRVRaaG0xT3RrNHdkNG9nKzNGeEQvZmYySUUrU2pwUFIrOG5R?=
 =?utf-8?B?dmFyY0hXYWNSNVpiTFgwMXQ0OG5RU1F2SkFDWGVkbk5GNWpoZ0tmVHZSdW9j?=
 =?utf-8?B?SXpNVXZqLzlmd3VscmRibEY3b0s0Z3VxeWd0a2t4cXduejlGbmtsc0ZVTU9N?=
 =?utf-8?B?ZjVHK2xyTFgzUm1udTBodXhHbVh4TkRQV205Y2VSZDJzSDNnalRrS3ZvRXEw?=
 =?utf-8?B?UGJlSHJSeEdKMk14OExmNVBGTXdRenFoejY0RStHVHVPbHNoZzNxUGV1d3Jy?=
 =?utf-8?B?MHZNNjJvTWdyUERvT0RtbmtMZVBPZ0JwWjZNQkVGK1dURXBGckFCcUpRMElD?=
 =?utf-8?B?WVVXWkM5dlhmdWkxajZ1bW9pWWxZMDh0VlNQbGF1YWFBRkhZa2pORGJVamU2?=
 =?utf-8?B?d0lRU1VzaXM3dkhCT3JxeWFCOHNiTjNycDlZYXhKN3hkWDkvYi9hVmU4bkpk?=
 =?utf-8?B?aW9rWVlmbjdvbGZKUlRYeWpIa2FnTEhTWTJpL1c3NjBOeVZFREFYbXM0ZlU2?=
 =?utf-8?B?azJlaGxQQlRYbWdCbXoxS0F1SitrZEVQT0tzcEx6ZTVBcDRsdnlQditnN3M0?=
 =?utf-8?B?N0lKLzkrbUxzZnRsWkVCeWJQNS9NNVpuV21Db2lNSEpxMlFwUEprZVJRdERi?=
 =?utf-8?B?VnJtelRnZXNWSFRpa1RVdG5qc25LaWI5Y0ZwVFFLcUJUL3I1UVZ0TUdTWUJU?=
 =?utf-8?B?Z2RYY0NtV2kwU2FUMWpYa2l1c2M4RlMvbElUZGpuRmxadzdSeG8vN3J2YnJa?=
 =?utf-8?B?aUJQcmhPMnpjNHZZZkNCUWxwUUl5dlhRSmVQbzdyUW1vTCtTaDBqSDZBcG5Y?=
 =?utf-8?B?RVZlSnp0dHVGNDNsRTNBOFl1a1ZhYzNPYVFIVjdvZWYyajJNVm04Wmx4dGNa?=
 =?utf-8?Q?3MrwL/?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(14060799003)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 04:30:53.1007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd38be9-33ab-4731-a0ef-08dde45957c0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10905


On 25/08/25 12:47 am, Alok Tiwari wrote:
> Fix a typo in the signal alternate stack test where the error
> message incorrectly used tss_flags instead of the correct field
> name ss_flags.
>
> This change ensures the test output accurately reflects the
> structure member being checked.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


