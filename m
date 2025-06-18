Return-Path: <linux-kselftest+bounces-35269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F6ADE922
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807C23A3DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF43A8F7;
	Wed, 18 Jun 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gxrx5AYJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gxrx5AYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E1BA27;
	Wed, 18 Jun 2025 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242968; cv=fail; b=aKPaTJUzdH2PObo6l4b6H4vxHkctZBe/DJZFgRnmvUomML2dEcuKj3RnRp2sIxKecrTj+F1UKdCIjSemct3gII4mg6G/s49JHODvob+R3c3pFPdG9X/XYU8IyubkWgineJnhzGQ205tznXy1eHcg8gT72DU55mKZ6YN4SdEXJTs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242968; c=relaxed/simple;
	bh=MgG5zhfaDdBroFH6ELkzjfuAfTtPN3GD9aYi5gHUjXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TuztFVRMtiiulAfexlP9xJjP7I4saLStI+nGmEkuHQ/GDq7M1SwwHnSvcvalq3sNpLu+fXCk9BuyDYKgCd7eFgsF/nGvBKIsCyk9T01+ZQA9QbR/0VRYjjVzbvGNXx+vrQSJv/VtVBOp2FW4IdAIO5PD7o9bHvNuJqX+PwZxmss=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gxrx5AYJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gxrx5AYJ; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DXmKif2dnOJ5xyYq+joieuTvjoq/jFO/9RkIM4wZWMjg+vGI71lZnaSrYobMrrxY5VRURyfq4yqCmPZoQC2f2+JWpXe7wHf1PxrPzDb5PsvbKXBYj27zwnqMyZCEEDSXubbwwPGDAwWvNF0InZOP2RXK8FZXM7CzNrxNiHeF2KkJKcPgrbxBD+Ocm8y0guGujmHSU86902yHvme1k5mVYIKs8HkyGgp8gs5xebi24tcGuc3SGZq1awoM0yHRWMiwRvb99NkYnG7otvI7hrNkdd4i397P4RCFoO24u8y4CjU6I8teWr+nnmaAez+Z02L6EGgzYxMK1dy9APhMVOvQfA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBaykVDve70FP9lvR32iK/1G+uELYimfwMmHsTWvI1Q=;
 b=GX7XK2Kzo4W1PXo/PLLCNDDMig0pZTgzR4dyPcQ2jGptwLWWl6ZowSLRP0+BL+AVoQwCUJg+KM1VTbCz6FbeemqKBOo0QKr7V9f6sh/PXzdE2qnKMjAB5mJn44FeCE0XrVi8IdP53Y0xKUqEbKgKoA/yC3JyQQbB7lqh9HTTdqKBuNPNdmBw7yMa9ckcc9uVHctuXgEnV1ElnAHQYcN9jfGLQR9yxzQUEPePYRh4H0vPkcYH7fAmp/IZd5mKZbkKzLe42y67FtkXVSe1QeLpGev9X4+ftM/syw+1OgnxS6YyXHQVDFe8/1pZYutdyE5msoJVmvt3JrMd0SVzeOL9+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBaykVDve70FP9lvR32iK/1G+uELYimfwMmHsTWvI1Q=;
 b=Gxrx5AYJBAyxd4qRcA19yDUarFrZkPxwUdCbfZf2DjYizvMP3zoq9kMfoQ/JC8MjmlJK7VrHOzqi2Q64sFVVK1vKRh4qYXgTFQmIwO4AqkELwq85aC7fau3J5xyqFl7P77ijhwJRAKfhEZN/9THHxk3yczCa8la/8qpNGZu42B8=
Received: from AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::26)
 by AM8PR08MB6499.eurprd08.prod.outlook.com (2603:10a6:20b:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 10:36:02 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::a8) by AM0PR10CA0016.outlook.office365.com
 (2603:10a6:208:17c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Wed,
 18 Jun 2025 10:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 10:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXMdmwD+BBrH3V71b7GeO8aPzfHa9uluFBXdFL6O5d9idqapjtonQqdSJeJarmsjm7ZxfGNQQBybhcTDfbLaDnin/K25CDvcxtWTSDMsJXwFUTdTs6m2eaYDSUBnsZGYudfk/5irXWjGP+0oltXQfXqySdj8dA0uPkrr6XzoBajyDD1IARN87wfV0Lo5cXxtg4URC7kz+Zk17V4qrC8Zuc/DcRhhD02IcI+Jk+GQqPecEDKLMT4xfd1ANy7rprDIneoFFMDhLUU3PZ1Mr6Dc/R64+Y2lSXQtiVq/hYAVKmDwiMjPxIWMjvRTuodKqDlhx0ZbI5zTzPmIIrQwMvTzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBaykVDve70FP9lvR32iK/1G+uELYimfwMmHsTWvI1Q=;
 b=WImvR+nIftfeEGV+FmuRVesG1pvcqwmIQCB7C5ENX5LiPg0at12k4tBZsP1mrl2ajBTa0N1lggYgEDZuuimAt+ZOuROm/1xG857Cqca/lWOrjEjBSOHP3aj1ZGldSTnm94nM+rEoU2sLLaovSVJp5HtEqNExmXClUyplrjs+FwvtWjlcjW60KHFas/Dfi88lAXtWWVoRWLJcF/rtqrWMwlknquNhg7hPwPvV+2HZ0LpPqWYxCuKmcfJHeqX7tmOgxSLav6jo0tbeA3Qh/A82Qt7x2ytn1Bzsfvr2oLmF75vIdWkQwIAzNoMQcSQFx8hl1rC+4nctQGKxvP5NxvzDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBaykVDve70FP9lvR32iK/1G+uELYimfwMmHsTWvI1Q=;
 b=Gxrx5AYJBAyxd4qRcA19yDUarFrZkPxwUdCbfZf2DjYizvMP3zoq9kMfoQ/JC8MjmlJK7VrHOzqi2Q64sFVVK1vKRh4qYXgTFQmIwO4AqkELwq85aC7fau3J5xyqFl7P77ijhwJRAKfhEZN/9THHxk3yczCa8la/8qpNGZu42B8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU4PR08MB11101.eurprd08.prod.outlook.com (2603:10a6:10:576::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Wed, 18 Jun
 2025 10:35:29 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 10:35:29 +0000
Message-ID: <e40f8959-6f89-46e3-b2cb-bfe6de615c54@arm.com>
Date: Wed, 18 Jun 2025 16:05:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Donet Tom <donettom@linux.ibm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <aFKPrN4w_ynPA038@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFKPrN4w_ynPA038@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU4PR08MB11101:EE_|AMS0EPF000001AF:EE_|AM8PR08MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 79327b77-3724-4e61-3d01-08ddae53ebb3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cXcwenR3bi9XZ24xUEJ3cjZtY0N5RkMxWVZEODFldFBDT0ROTmNOUXhQNFFj?=
 =?utf-8?B?STdkSUtvWGpTSTlqNlFzZ0YzWFFoMHJDWG9vN043eEoxSHlSTlpzaUJVWm5p?=
 =?utf-8?B?aU52SXBMNllVM0doQU0zQktXVG15VjNnbThGclVZUnhhRXk5QmFwUmM3emtC?=
 =?utf-8?B?TjdwZGdoL1UvV3NzUmVaSUp1a0NlOVluc3oxSlA1VWpzeTBTWnBpcURjV3I5?=
 =?utf-8?B?YWhHYjcxb0RrWTBYWnFlQnZyOFVNYkdYOFdYcEQ0QVhBc2JwcCtwSG1jMk1F?=
 =?utf-8?B?N1o5NDVqTUREeVdTUDM1WklPQkRFamc4WFlqVU4xMTVTWXlYT3Y2ZXpWZHZo?=
 =?utf-8?B?aGtsc096ZXBZR2dBWGlVdUxacXRlNWR6eTZyTW5EQnk1VkNzZHRRaTVRamkv?=
 =?utf-8?B?NjNRcnNhY2YvalBKd1FYQlg2a2pCMU9DMjBkaUp6bW9YZUZwMlVSZC9LUXcx?=
 =?utf-8?B?dGFQMFU0MUw0OTFvQnZENm93VHdZTVIranJoR1QrbjVEMmQ5aW9WQk5KZEJC?=
 =?utf-8?B?aGphb3k4Z1NCNFY1QWxjSXlpR3NZM09NbUc2T1piaytNSlNYNnNRS3dqMExr?=
 =?utf-8?B?NnhuUk1JTnJLVG1XUWcvOUxkU3NRaldnRjNQVGlWRllQbTFQUUdteitoYWJo?=
 =?utf-8?B?YmV3SWg2bUEvcWJ6VEdmM3lPa0JBQkFqNVdFZUc4NVZ5dWExR1ovZzhLN0ZR?=
 =?utf-8?B?VVJmaE50dDk2YkNpRk13STg4VHFZdHdoSWlEeTZmMDdBTkRHVXpWZ05UTUJT?=
 =?utf-8?B?Zm85YUJzMXd6bDRobExYYkEycXByNXZLNHdWcDdlY2N3aG56WHl0R3BEM0VB?=
 =?utf-8?B?VE85SjZ5SFNpQWhRb1praE4zTkE5REVLSllIUEUzNmFGaWJIc1l5NzNldXNP?=
 =?utf-8?B?Q21vWk5QaDNhSjdQZnF1dGVld003N0ttVDlmREF6c2t0WnVkcEZoVVJZMzNw?=
 =?utf-8?B?NURRTVlnNkJFYjUwcEhSRm9kUld2cEx5M0hXN05wYmZVc3AzUjRvUWVpQlIz?=
 =?utf-8?B?S2FlcC81VXRJMnNYeVJvQVZNUjR4TiszZ2EySDVvR095MFdJY1EzZHA1UmhK?=
 =?utf-8?B?a1BGRU9WcnRUdjNPelRYb2RubFJ6MlhCU3gzNmw3WXR0QTdkMmw5elk5b1JN?=
 =?utf-8?B?bDBxaThhaTFCbnJQUnlsMlBnT1U1UUZCd3NFSDRxNmpaemtLNGRzaFNhcjF1?=
 =?utf-8?B?c0dwd3dXSHpYK09sa0YzdUV2ZnZrNWhlOHdTcElFQnhmOFM2bDlZMG1reUF0?=
 =?utf-8?B?SnNITUlxcnBzVVRmNkRsYlJpdW8rTDNJM0xBN1o0SXRMK1E1cjNTN3habERM?=
 =?utf-8?B?K2xob2JnM25RUUNIczI4S1hiQTlCdW1QL0RFeWxxY3pSamhXcGxIb0hWb0tl?=
 =?utf-8?B?STZCUzJHcm9CTUdETFM2TEVmclB2T2RXTy9Sa2NnL05Ha1FtREF1UE9xOHE0?=
 =?utf-8?B?RmtwWDkrd3hYVkRWaUlPOFV2L2ZRcFlqV3NqakROQkJwMzdZc2FRNTFMalhr?=
 =?utf-8?B?TzFtVHZta3ZxdjRSdWhhZnJtZUU2TDlBUUhWTi84K29wVmI1allsT2RpNUlu?=
 =?utf-8?B?eTZHaVhYWm5SU2gvNmVyWURlRlBXK1VrQlUvU2o4QklZMjdOZjdCNFJwaVZi?=
 =?utf-8?B?aEVNSGRZTThBL0xHMXo4TXY0Q0NDaDJYRkhrTVJhbmQ2bWNZLzBZN2dGWWxY?=
 =?utf-8?B?cnVpTjFiRGRRRUs1cEIvZmV6aExYM3JyYmYxeXp6cGJMSkJPRDlRSU9CSXdY?=
 =?utf-8?B?U3hXTU5GekNmOS9XaEVOa3d5UzBFdTRpdkx5YkZmeUF6M3d3bnBIeTg2Vmtz?=
 =?utf-8?B?dnI0K3Q5OXBETHhxcDFzQ080VmxkNjNpeml6Rm5JRm95SW5iamdxYnVkYnpj?=
 =?utf-8?B?UkZOREdDM3c5VmdSaklFamdCRk5ycXE3eGJNVGtnVHdXYW4rOEQ5QTZRUGVW?=
 =?utf-8?Q?m7kTjTmC+Zw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11101
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1e6c4fd1-6466-4020-98a1-08ddae53d839
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|1800799024|376014|7416014|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENOMndnK2x1clpjS08zRXhMd3AreGxxMUpTemZsY01nOXNqMWFCTG11WWFE?=
 =?utf-8?B?MDlkb1VxWXA5WWlhdGpZYmp0eUs5MWNjekwrc1dVbkRSNEIxQ25Kd0luVk4y?=
 =?utf-8?B?V08rditkc0FDWGFtdnJBVCt0TW9qRC9RQnAxSStsUXZZeVB6UXBOL1NPVlV2?=
 =?utf-8?B?bWxuWXdNK0Z0dTVycC9yL1FkM2JSOXFlMkVlMkZ0QmV2SXNwaFM0NHgwUStC?=
 =?utf-8?B?cVRvS0RWdDh2NFM2NzlDMkhrbUd3R1ZNWmJWbG45NDE3K1ZYaVgxYmM1amJ0?=
 =?utf-8?B?ZWZQQlB3b1E1MU9Oc2VaYUk0K2JYVnhVVjU2b2VNV2dIRWF4R0ZvajlnMS9L?=
 =?utf-8?B?VytvRy9ZdE81aVFjT0NUYklJL1hGQ3I2d0lIRDRFV0Rzam14MmJJU01nWUs0?=
 =?utf-8?B?YTJiUno2MU5CSjFYUFBDN3pyVlJCTkwySVFmRlV1VTVXSTRTL3J4dkpyM3Ro?=
 =?utf-8?B?QVFlZ1dpc0pXUnhQYzJ1cFMxU1ZQb3A3ekxDcC9VN2t6S1pJcGl2ZEhyRmRQ?=
 =?utf-8?B?QVk1K0RTcmN3anZDUGxmZWNjcDU2QkFkQ0RaWHM4dVdTK1JoS2E1SEpZRmpR?=
 =?utf-8?B?WFNETHFNRXNwbGpld0dQVWhqWUFPQ2poeWpITExybkhtdHZSTmNXY25RVFhz?=
 =?utf-8?B?S28xZkovMGxaR09CUHU1dzhBUTl0dkN3bjZ5TElNejBtc0NUdzIrVjZuKzZI?=
 =?utf-8?B?NjZEUEgxZndObXVkcUtEU3RyL2o1d0F5K1lFc01MWmFIVWlPaEpFWXpaQkx6?=
 =?utf-8?B?UnpRNTc3VzNLNGpWeU5TVXEwbGQ0Y3lTRDN1cWs5b2grUTVDZVA5eXJ5QzU0?=
 =?utf-8?B?cFlNYkQ4YmxmTWRtTGRqZDJxQ1lEOEtmL0lmY2xpaW8vaDVML1NmeE9obURj?=
 =?utf-8?B?dDdOR0xyR2lsZTRJY0puKzBiVFBNUkd4MUhhL0V5VlhubFdhWWVJUGhpd1hl?=
 =?utf-8?B?QWxUYlZJZytJS2lxcWc1djZSblJoajcyMG04N2VTaTBCa29zZHNUcDloMmRs?=
 =?utf-8?B?WXVXbk1vQ29HSTZaTHNnVkZnYkdKS05CMHJSaklIdXczdkY2VW52eG5kRjZ1?=
 =?utf-8?B?VzQrL1A5UGd6b0QwVkpza0ZFTGhhMUllY25GNEduZGRZSlo0ZXpwanZuNlZF?=
 =?utf-8?B?ZjQwQ2VZckhiY05iKzVhWjY0emFlU29rMTA5VjNtUlNBK1czblkyZzV1a2NV?=
 =?utf-8?B?TW1iNVpUektaYU1qcUpnbUlkbUErbGlGRGN4aTRQcm1NR2k1cEdObWM4a0Uv?=
 =?utf-8?B?aDd3cmJ5bTBLd2JNaEp5ZlBQTXg1RkhHWGFrZGp5bkFqcERSVWFWQysveXFs?=
 =?utf-8?B?dGt0QzkwSjVMSThGdjJWYnRHeHZVVFRnT2dCd1BPWkZkMzMreWEzVVNqMEds?=
 =?utf-8?B?bk96OWdYb3FYOUtSOUw4SlNkK2Jxc0M0SGtuQ2Ewc2E4d01ndzlpZGxVQTgw?=
 =?utf-8?B?M3N1NGVwZ0VvQlUzeEQyd2pyWVpnM0FwNEhoQytmRkNWdXhnY01MTXBPenJy?=
 =?utf-8?B?YzBZM1I1RFltVStTQldZY2xuTEF1eElQRjhMOEVOR1ZNejBRdHBIRjF0bU5I?=
 =?utf-8?B?ZXRyNVh2V29uU3VENFlzSzh6UEJ1OGJPaUwrT2hycHRDaEpMOU4ySHhGZGhC?=
 =?utf-8?B?STNLL0djZ05sa3VDd1R0YW1paGk5RVpST2NyZGh2aFZhaExHZE9sYWVIcTVB?=
 =?utf-8?B?QnVKR3hPRU1yUkhhek14VVNvQ1BLdmRDbWFaM2FMQXNRMjkrQjc3N0U5c0t2?=
 =?utf-8?B?KzQ4b2h3Qm9EL25kelp3WW9KMDJqTE5QQ1pUQjJMcmtFYzZLZWlLMHUzeU43?=
 =?utf-8?B?R29BZVZLSjh3THlqZ2xxTFNvaVFMdFg5RUNsSFdNVVMzRWpPL21kSGUvWSt4?=
 =?utf-8?B?T1NFMnpaN3F0SkFGNFN4S2ZBWWZzRG5LZHFrSllsUFFUVWpRTnMzbXpXSzNV?=
 =?utf-8?B?bVZoQTFwUWRIbGQ0MXhYWnBSenZBcGF5OXAzNG9KR2U2SStzT040ZStOQkhJ?=
 =?utf-8?B?Tm8rS2dCYURLeDhpZlByeHQrSjZYMXVmZXE2UzUzOGpQN2plMUJ3SHpIWUJD?=
 =?utf-8?Q?amgCh3?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(1800799024)(376014)(7416014)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 10:36:01.5441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79327b77-3724-4e61-3d01-08ddae53ebb3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6499


On 18/06/25 3:36 pm, Donet Tom wrote:
> On Mon, Jun 16, 2025 at 09:57:10PM +0530, Dev Jain wrote:
> Hi Dev
>
>> On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
>>> From: Donet Tom <donettom@linux.ibm.com>
>>>
>>> In this patch, we are fixing three issues in the virtual_address_range
>>> test.
>>>
>>> 1. validate_addr() checks if the allocated address is within the range.
>>> In the current implementation, if addr is greater than HIGH_ADDR_MARK,
>>> the test fails. However, addr will be greater than HIGH_ADDR_MARK if
>>> high_addr is set. Therefore, if high_addr is set, we should not check
>>> the (addr > HIGH_ADDR_MARK) condition.
>>>
>>> 2.In main(), the high address is stored in hptr, but for mark_range(),
>>> the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
>>> hptr[i] in mark_range() function call.
>>>
>>> 3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
>>> The gap between the first high address mapping and the previous mapping
>>> is not smaller than MAP_CHUNK_SIZE.
>> For this, can't we just elide the check when we cross the high boundary?
>> As I see it you are essentially nullifying the purpose of validate_complete_va_space;
>> I had written that function so as to have an alternate way of checking VA exhaustion
>> without relying on mmap correctness in a circular way.
>>
> In this test, we first allocate 128TB of low memory and verify that
> the allocated area falls within the expected range.
>
> Next, we allocate memory at high addresses and check whether the
> returned addresses are within the specified limits. To allocate
> memory at a high address, we pass a hint address. This hint address
> is derived using HIGH_ADDR_SHIFT, which is set to 48 — corresponding
> to 256TB. So, we are requesting allocation at the 256TB address, and
> the memory is successfully allocated there. Since the low address
> region is allocated up to 128TB, there is a gap between the low address
> VMA and the high address VMA .
>
> Additionally, we use a random number to generate the hint address, so
> the actual allocated address will vary but will always be above 256TB.
>
>
> 10000000-10010000 r-xp 00000000 fd:05 134255559
> 10010000-10020000 r--p 00000000 fd:05 134255559
> 10020000-10030000 rw-p 00010000 fd:05 134255559
> 10022b80000-10022bb0000 rw-p 00000000 00:00 0
> 7fff5c000000-7fff9c000000 r--p 00000000 00:00 0
> 7fff9cb30000-7fff9ce40000 rw-p 00000000 00:00 0
> 7fff9ce40000-7fff9d070000 r-xp 00000000 fd:00 792355
> 7fff9d070000-7fff9d080000 r--p 00230000 fd:00 792355
> 7fff9d080000-7fff9d090000 rw-p 00240000 fd:00 792355
> 7fff9d090000-7fff9d170000 r-xp 00000000 fd:00 792358
> 7fff9d170000-7fff9d180000 r--p 000d0000 fd:00 792358
> 7fff9d180000-7fff9d190000 rw-p 000e0000 fd:00 792358
> 7fff9d1a0000-7fff9d1e0000 r--p 00000000 00:00 0
> 7fff9d1e0000-7fff9d1f0000 r-xp 00000000 00:00 0
> 7fff9d1f0000-7fff9d240000 r-xp 00000000 fd:00 792351
> 7fff9d240000-7fff9d250000 r--p 00040000 fd:00 792351
> 7fff9d250000-7fff9d260000 rw-p 00050000 fd:00 792351
> 7fffecfa0000-7fffecfd0000 rw-p 00000000 00:00 0
> 1000000000000-1000040000000 r--p 00000000 00:00 0           -> High address
> 2000000000000-2000040000000 r--p 00000000 00:00 0
> 4000000000000-4000040000000 r--p 00000000 00:00 0
> 8000000000000-8000040000000 r--p 00000000 00:00 0
> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>                      
>
> The high address we are getting is at 256TB because we are explicitly
> requesting it. The gap between the high address VMA and the previous VMA
> is large because the low memory allocation goes up to 128TB.
>
> If I understand correctly, this test is verifying whether the allocated
> address falls within the expected range, and validate_complete_va_space()
> is validating the allocated virtual address space.
>
> Why do we need to check whether the gap between two VMAs is within
> MAP_CHUNK_SIZE? Should it validate only the allocated VMAs?

If you were trying to say here "Shouldn't it validate only the allocated VMAs",
that is exactly what we are doing. By "allocated" we mean mmapped. And those
VMAs will be shown in /proc/self/maps. This test is verifying whether mmap
can exhaust a process' VA space or not, therefore (assume no high address)
the gap between any two consecutive VMAs must not be greater than MAP_CHUNK_SIZE,
for if it was, then mmap should have been able to find it and allocate it there,
reducing that gap.

Now, taking into consideration the high address thingy, since the test completely
exhaust the low and high VA space, the gap condition should separately hold on
the low and high VA space. But it may not hold at the low-high boundary. So
you can simply avoid the check when you detect for the first time that the VMA
you are reading from /proc/self/maps comes from the high VA space.

>
> Thanks
> Donet
>   
>> Btw @Lorenzo, validate_complete_va_space was written by me as my first patch ever for
>> the Linux kernel : ) from the limited knowledge I have of VMA stuff, I guess the
>> only requirement for VMA alignment is PAGE_SIZE in this test, therefore, the only
>> check required is that the gap between two VMAs should be at least MAP_CHUNK_SIZE?
>> Or can such a gap still exist even when the VA has been exhausted?
>>
>>> $cat /proc/3713/maps
>>> 10000000-10010000 r-xp 00000000 fd:00 36140094
>>> 10010000-10020000 r--p 00000000 fd:00 36140094
>>> 10020000-10030000 rw-p 00010000 fd:00 36140094
>>> 4ee80000-4eeb0000 rw-p 00000000 00:00 0
>>> 578f0000-57c00000 rw-p 00000000 00:00 0
>>> 57c00000-7fff97c00000 r--p 00000000 00:00 0
>>> 7fff97c00000-7fff97e20000 r-xp 00000000 fd:00 33558923
>>> 7fff97e20000-7fff97e30000 r--p 00220000 fd:00 33558923
>>> 7fff97e30000-7fff97e40000 rw-p 00230000 fd:00 33558923
>>> 7fff97f40000-7fff98020000 r-xp 00000000 fd:00 33558924
>>> 7fff98020000-7fff98030000 r--p 000d0000 fd:00 33558924
>>> 7fff98030000-7fff98040000 rw-p 000e0000 fd:00 33558924
>>> 7fff98050000-7fff98090000 r--p 00000000 00:00 0
>>> 7fff98090000-7fff980a0000 r-xp 00000000 00:00 0
>>> 7fff980a0000-7fff980f0000 r-xp 00000000 fd:00 2634
>>> 7fff980f0000-7fff98100000 r--p 00040000 fd:00 2634
>>> 7fff98100000-7fff98110000 rw-p 00050000 fd:00 2634
>>> 7fffcf8a0000-7fffcf9b0000 rw-p 00000000 00:00 0
>>> 1000000000000-1000040000000 r--p 00000000 00:00 0   --> High Addr
>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>> e800098110000-fffff98110000 r--p 00000000 00:00 0
>>> $
>>>
>>> In this patch, the condition that checks for gaps smaller than MAP_CHUNK_SIZE has been removed.
>>>
>>> Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
>>> Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
>>> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>> ---
>>>    tools/testing/selftests/mm/virtual_address_range.c | 14 +++-----------
>>>    1 file changed, 3 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index b380e102b22f..606e601a8984 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -80,7 +80,7 @@ static void validate_addr(char *ptr, int high_addr)
>>>    	if (high_addr && addr < HIGH_ADDR_MARK)
>>>    		ksft_exit_fail_msg("Bad address %lx\n", addr);
>>> -	if (addr > HIGH_ADDR_MARK)
>>> +	if (!high_addr && addr > HIGH_ADDR_MARK)
>>>    		ksft_exit_fail_msg("Bad address %lx\n", addr);
>>>    }
>>> @@ -117,7 +117,7 @@ static int validate_lower_address_hint(void)
>>>    static int validate_complete_va_space(void)
>>>    {
>>> -	unsigned long start_addr, end_addr, prev_end_addr;
>>> +	unsigned long start_addr, end_addr;
>>>    	char line[400];
>>>    	char prot[6];
>>>    	FILE *file;
>>> @@ -134,7 +134,6 @@ static int validate_complete_va_space(void)
>>>    	if (file == NULL)
>>>    		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
>>> -	prev_end_addr = 0;
>>>    	while (fgets(line, sizeof(line), file)) {
>>>    		const char *vma_name = NULL;
>>>    		int vma_name_start = 0;
>>> @@ -151,12 +150,6 @@ static int validate_complete_va_space(void)
>>>    		if (start_addr & (1UL << 63))
>>>    			return 0;
>>> -		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
>>> -		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
>>> -			return 1;
>>> -
>>> -		prev_end_addr = end_addr;
>>> -
>>>    		if (prot[0] != 'r')
>>>    			continue;
>>> @@ -223,8 +216,7 @@ int main(int argc, char *argv[])
>>>    		if (hptr[i] == MAP_FAILED)
>>>    			break;
>>> -
>>> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
>>> +		mark_range(hptr[i], MAP_CHUNK_SIZE);
>>>    		validate_addr(hptr[i], 1);
>>>    	}
>>>    	hchunks = i;

